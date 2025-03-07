<%@ page language="java" contentType="text/html; charset=UTF-8"
		 pageEncoding="UTF-8"%>
<%@taglib prefix="mvc" uri="http://www.springframework.org/tags/form" %>
<%@taglib prefix="fmt" uri="http://www.springframework.org/tags" %>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
	<meta charset="UTF-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
	<title><fmt:message code="dem.th.fileManagement" /></title>
	<link rel="stylesheet" type="text/css" href="../lib/laydate.css"/>
	<link rel="stylesheet" type="text/css" href="../lib/pagination/style/pagination.css"/>
	<link rel="stylesheet" type="text/css" href="../css/base.css"/>
	<script type="text/javascript" src="../js/common/language.js" ></script>
<%--	<script type="text/javascript" src="../js/xoajq/xoajq1.js"></script>--%>
	<script type="text/javascript" src="/js/xoajq/xoajq3.js"></script>
	<script type="text/javascript" src="/js/jquery/jquery-migrate-3.4.0.js"></script>
	<script src="/lib/jQuery-File-Upload-master/jquery-ui.js" type="text/javascript" charset="utf-8"></script>
	<script src="/lib/jQuery-File-Upload-master/jquery.iframe-transport.js" type="text/javascript" charset="utf-8"></script>
	<script src="/lib/jQuery-File-Upload-master/jquery.fileupload.js" type="text/javascript" charset="utf-8"></script>
	<script src="../js/news/page.js"></script>
	<script src="../lib/laydate/laydate.js"></script>
	<script src="../js/base/base.js" type="text/javascript" charset="utf-8"></script>
	<script src="/js/ajaxupload.js" type="text/javascript" charset="utf-8"></script>
	<script src="/js/jquery/jquery.form.min.js"></script>
	<script src="../lib/pagination/js/jquery.pagination.min.js" type="text/javascript" charset="utf-8"></script>
	<script src="../lib/layer/layer.js?20201106"></script>
	<script src="../js/rms/manageRmsFile.js?202130427.2"></script>
	<script src="/js/jquery/jquery.jqprint-0.3.js"></script>
	<script type="text/javascript" src="/js/common/fileupload.js?20220822.1"></script>
	<style>
		a{
			text-decoration: none;
			color: #207bd6;
		}
		.buttonDiv{
			width: 100%;
		}
		.buttonDiv>div{
			float: left;
			margin: 20px 10px;
		}
		.buttonDiv .deleteBtn{
			width: 99px;
			height: 28px;
			/*margin: 20px auto;*/
			background: url("../img/btn_deletecontent_03.png") no-repeat;
			line-height: 28px;
			cursor: pointer;
		}
		.buttonDiv .exportDiv{
			width: 99px;
			height: 28px;
			/*margin: 20px auto;*/
			background: url("../img/icon_daoru.png") no-repeat;
			line-height: 28px;
			cursor: pointer;
		}
		.fileDone select{
			width: 160px;
			height:28px;
		}
		#tr_td tr:nth-child(odd){
			background-color: #fff;
		}

		input{
			float: none;
			margin: -1px;
		}
		.newMange input[type="text"]{
			width: 260px;
			height: 30px;
		}
		select{
			width: 260px;
			height: 30px;
		}
		textarea{
			width: 260px;
			height: 50px;
			vertical-align: middle;
		}
		a{
			text-decoration: none;
			color: #207bd6;
		}
		.newTbale{
			/*width: 80%;*/
			margin: 0px auto;
			margin-top: 70px;
		}
		.newTbale tr td{
			border-right: #ccc 1px solid;
			padding: 5px;
		}
		.buttonDivs{
			width: 100%;
			margin-top: 20px;
		}
		.divBtn{
			width: 170px;
			margin: 0 auto;
			height: 30px;
		}
		.saveBtn{
			display: block;
			float: left;
			background: url(../img/confirm.png) no-repeat;
			border: none;
			width: 70px;
			height: 29px;
			line-height: 29px;
			margin-left: 10px;
			cursor: pointer;
		}
		.resetBtn{
			display: block;
			float: left;
			background: url(../img/news/new_filling.png) no-repeat;
			border: none;
			width: 70px;
			height: 29px;
			line-height: 29px;
			margin-left: 10px;
			cursor:pointer;
		}

		#tr_td .th{
			font-size: 13pt;
		}
		#j_tb tr td {
			font-size: 11pt;
		}
	</style>
</head>

<body>
<div class="bx">
	<div class="navigation  clearfix juMange" id="juMange" style="display: block;">
		<div class="left" style="margin-left: 30px;width: 40%">
			<img src="/img/commonTheme/${sessionScope.InterfaceModel}/icon_manageFile.png" style="margin-top: 18px">
			<div class="news">
				<fmt:message code="dem.th.fileManagement" />
			</div>
		</div>
		<div class="wrap" style="margin-left: 0;padding: 0 20px;margin-top: 70px">
			<table id="tr_td">
				<thead>
				<tr>
					<td>
						<input type="checkbox" id="checkedAll">
					</td>
					<td class="th">
						<fmt:message code="dem.th.FileNum" />
					</td>
					<td class="th" style="width: 30%;">
						<fmt:message code="dem.th.FileTitle" />
					</td>
					<td class="th">
						<fmt:message code="dem.th.Dense" />
					</td>
					<td class="th">
						<fmt:message code="doc.th.DispatchUnit" />
					</td>
					<td class="th">
						<fmt:message code="doc.th.DispatchTime" />
					</td>
					<td class="th">
						<fmt:message code="dem.th.FilesThem" />
					</td>
					<td class="th">
						<fmt:message code="dem.th.FileOperation" />
					</td>
				</tr>
				</thead>
				<tbody id="j_tb">

				</tbody>
			</table>
			<div class="buttonDiv">
				<div class="fileDone">
					<span style="font-size: 15px;font-weight: bold;color: #2f5c8f;"><fmt:message code="dem.th.FileOperation" />：</span>
					<span><fmt:message code="dem.th.Group" />：</span>
					<select name="rollIdSelect" id="rollIdSelect">
						<option value=""><fmt:message code="dem.th.File" /></option>
					</select>
				</div>
				<div class="deleteBtn"><span style="margin-left: 32px;"><fmt:message code="dem.th.BatchDestruction" /></span></div>
				<div class="exportDiv"><span style="margin-left: 36px;"><fmt:message code="dem.th.FileImport" /></span></div>
			</div>
			<div class="right">
				<!-- 分页按钮-->
				<div class="M-box3" id="dbgz_page">
				</div>

			</div>
		</div>
	</div>

	<div class="navigation  clearfix newMange" id="newMange" style="display: none;">
		<div class="left" style="margin-left: 30px;width: 40%">
			<img src="/img/rms/icon_editFile.png" style="margin-top: 17px">
			<div class="news">
				<fmt:message code="dem.th.Edit" />
			</div>
		</div>
		<div class="wrap" style="margin-left: 0;padding: 0 20px;">
			<form id="form1" action="/rmsFile/update">
				<input type="hidden" value="" name="fileId">
				<input type="hidden" value="" name="attachmentId">
				<input type="hidden" value="" name="attachmentName">
				<input type="hidden" value="" name="attachmentId2">
				<input type="hidden" value="" name="attachmentName2">
				<table class="newTbale">
					<tr>
						<td><fmt:message code="dem.th.FileNum" />：</td>
						<td>
							<input type="text" name="fileCode" value="">
							<img class="td_title2" src="../img/mg2.png" style="margin-top: 10px;margin-left: 5px;" alt="必填">
						</td>
						<td><fmt:message code="dem.th.DocumentWords" />：</td>
						<td>
							<input type="text" name="fileSubject" value="">
<%--							<img class="td_title2" src="../img/mg2.png" style="margin-top: 10px;margin-left: 5px;" alt="必填">--%>
						</td>
					</tr>
					<tr>
						<td><fmt:message code="dem.th.FileTitle" />：</td>
						<td>
							<input type="text" name="fileTitle" value="">
							<img class="td_title2" src="../img/mg2.png" style="margin-top: 10px;margin-left: 5px;" alt="必填">
						</td>
						<td><fmt:message code="dem.th.Supplemented" />：</td>
						<td><input type="text" name="fileTitle0" value=""></td>
					</tr>
					<tr>
						<td><fmt:message code="doc.th.DispatchUnit" />：</td>
						<td>
							<input type="text" name="sendUnit" value="">
						</td>
						<td><fmt:message code="dem.th.DateWriting" />：</td>
						<td><input type="text" name="sendDate" value="" onclick="laydate(start)"></td>
					</tr>
					<tr>
						<td><fmt:message code="dem.th.Dense" />：</td>
						<td>
							<select name="secret" id="secret">
								<option value=""><fmt:message code="dem.th.PleaseSecret" /></option>
								<option value="1"><fmt:message code="dem.th.PuDense" /></option>
								<option value="4"><fmt:message code="dem.th.Secret" /></option>
								<option value="3"><fmt:message code="dem.th.Confidential" /></option>
								<option value="2"><fmt:message code="doc.th.Top-secret" /></option>
							</select>
							<img class="td_title2" src="../img/mg2.png" alt="必填">
						</td>
						<td><fmt:message code="dem.th.EmergencyGrade" />：</td>
						<td>
							<select name="urgency" id="urgency">
								<option value=""><fmt:message code="dem.th.Emergency" /></option>
								<option value="1"><fmt:message code="hr.th.EmployeeType" /></option>
								<option value="2"><fmt:message code="dem.th.GeneralLevel" /></option>
							</select>
						</td>
					</tr>
					<tr>
						<td><fmt:message code="dem.th.FileClassification" />：</td>
						<td>
							<select name="fileType" id="fileType">
								<option value=""><fmt:message code="dem.th.SelectClassification" /></option>
								<option value="1"><fmt:message code="email.th.document" /></option>
								<option value="2"><fmt:message code="userDatails.th.data" /></option>
							</select>
						</td>
						<td><fmt:message code="dem.thDocumentCategory" />：</td>
						<td>
							<select name="fileKind" id="fileKind">
								<option value=""><fmt:message code="dem.th.Sategory" /></option>
								<option value="1">A</option>
								<option value="2">B</option>
								<option value="3">C</option>
								<option value="4">D</option>
							</select>
						</td>
					</tr>
					<tr>
						<td><fmt:message code="dem.th.FilePage" />：</td>
						<td><input type="text" name="filePage" value=""></td>
						<td><fmt:message code="dem.th.Print" />：</td>
						<td><input type="text" name="printPage" value=""></td>
					</tr>
					<tr>
						<td><fmt:message code="journal.th.Remarks" />：</td>
						<td><input type="text" name="remark" value=""></td>
						<td><fmt:message code="dem.th.FilesThem" />：</td>
						<td>
							<select name="rollId" id="rollId">
							</select>
						</td>
					</tr>
					<tr>
						<td style="width: 180px;"><fmt:message code="dem.th.SeeApproval" />：</td>
						<td colspan="3">
							<input type="radio" name="isaudit" value="1" checked>
							<span><fmt:message code="global.lang.yes" /></span>
							<input type="radio" name="isaudit" value="0">
							<span><fmt:message code="global.lang.no" /></span>
						</td>
						<%--<td>提醒管理员：</td>--%>
						<%--<td>--%>
						<%--<input type="checkbox">--%>
						<%--<span>发送事务提醒</span>--%>
						<%--</td>--%>
					</tr>
					<tr>
						<td><fmt:message code="dem.th.AppendixPermissions" />：</td>
						<td colspan="3">
							<input type="checkbox" id="downLoadata">
							<input type="hidden" name="download" value="0">
							<input type="hidden" name="print" value="0">
							<span><fmt:message code="notice.th.office" /></span>
							<input type="checkbox" id="daying">
							<span><fmt:message code="notice.th.printoffice" /></span>
							<span style="color: #999;"><fmt:message code="notice.th.noselect" /></span>
						</td>
					</tr>

				</table>
			</form>
			<table class="newTbale" style="margin-top: 0;">
				<tr style="border-top: 0;">
					<td style="width: 180px;">文件正文：</td>
					<td colspan="3">
						<div class="attachNameDiv2"></div>
						<form id="uploadimgform2" target="uploadiframe"  action="/upload?module=roll_manage"  method="post" >
							<input type="file" multiple="multiple" name="file"  id="uploadinputimg2"  class="w-icon5" style="position: absolute;opacity: 0;width: 70px;filter: progid:DXImageTransform.Microsoft.Alpha(opacity=0)">
							<a href="#" id="uploadimg2"><img style="margin-right:5px;" src="../img/icon_uplod.png"/><fmt:message code="global.th.fileup" /></a>
						</form>
					</td>
				</tr>

<%--				<tr style="border-top: 0;">--%>
<%--					<td style="width: 180px;">文件正文：</td>--%>
<%--					<td colspan="3">--%>
<%--						<div class="attachNameDiv3"></div>--%>
<%--						<form id="uploadimgform3" target="uploadiframe"  action="/upload?module=roll_manage"  method="post" >--%>
<%--							<input type="file" multiple="multiple" name="file"  id="uploadinputimg3"  class="w-icon5" style="position: absolute;opacity: 0;width: 70px;filter: progid:DXImageTransform.Microsoft.Alpha(opacity=0)">--%>
<%--							<a href="#" id="uploadimg3"><img style="margin-right:5px;" src="../img/icon_uplod.png"/><fmt:message code="global.th.fileup" /></a>--%>
<%--						</form>--%>
<%--					</td>--%>
<%--				</tr>--%>

				<tr style="border-top: 0;">
					<td style="width: 180px;">其它附件：</td>
					<td colspan="3">
						<div class="attachNameDiv"></div>
						<form id="uploadimgform" target="uploadiframe"  action="/upload?module=rmsFile"  method="post" >
							<input type="file" multiple="multiple" name="file"  id="uploadinputimg"  class="w-icon5" style="position: absolute;opacity: 0;width: 70px;filter: progid:DXImageTransform.Microsoft.Alpha(opacity=0)">
							<a href="#" id="uploadimg"><img style="margin-right:5px;" src="../img/icon_uplod.png"/><fmt:message code="global.th.fileup" /></a>
						</form>
					</td>
				</tr>
			</table>
			<div class="buttonDivs">
				<div class="divBtn">
					<div class="saveBtn"><span style="margin-left: 32px;"><fmt:message code="global.lang.save" /></span></div>
					<div class="resetBtn"><span style="margin-left: 32px;"><fmt:message code="notice.th.return" /></span></div>
				</div>
			</div>
		</div>
	</div>


	<div class="divIframeThr iframeShow" id="iframeShow" style="width: 100%;height: 100%;display: none;">
		<iframe src="/rmsFile/toImport" id="iframeThr" style="width: 100%;height: 100%;" frameborder="0"></iframe>
	</div>

</div>
<iframe style="display:none" id="printIframe" src=""></iframe>
<script type="text/javascript">
	$(function(){

//	    导入文件
		$('.exportDiv').on('click',function(){
		    $('.iframeShow').show().siblings().hide();
		})

        //            点击全选
        $('#checkedAll').on('click',function(){
            var state =$(this).prop("checked");
            if(state==true){
                $(this).prop("checked",true);
                $(".checkedChild").prop("checked",true);
            }else{
                $(this).prop("checked",false);
                $(".checkedChild").prop("checked",false);
            }
        })
        //        查询所有案卷
        $.ajax({
            type:'get',
            url:'/rmsRoll/selectAll',
            dataType:'json',
            success:function(res){
                var datas=res.obj;
                var str='';
                for(var i=0;i<datas.length;i++){
                    str+='<option value="'+datas[i].rollId+'">'+datas[i].rollName+'</option>'
                }
                $('#rollIdSelect').append(str);
            }
        })
        $.ajax({
            type:'get',
            url:'/rmsRoll/selectAll',
            dataType:'json',
            success:function(res){
                var datas=res.obj;
                var str='';
                for(var i=0;i<datas.length;i++){
                    str+='<option value="'+datas[i].rollId+'">'+datas[i].rollName+'</option>'
                }
                $('#rollId').append(str);
            }
        })

		// 文件正文上传
		$('#uploadinputimg2').fileupload({
			dataType:'json',
			done: function (e, data) {
				if(data.result.obj != ''){
					var data = data.result.obj;
					var str = '';
					var str1 = '';
					for (var i = 0; i < data.length; i++) {
						var gs = data[i].attachName.split('.')[1];
						if(gs == 'jsp'||gs == 'css'||gs == 'js'||gs == 'html'||gs == 'java'||gs == 'php' ){
							str += '';
							layer.alert('<fmt:message code="dem.th.uploading" />!',{},function(){
								layer.closeAll();
							});
						}else{
							var fileExtension=data[i].attachName.substring(data[i].attachName.lastIndexOf(".")+1,data[i].attachName.length);//截取附件文件后缀
							var attName = encodeURI(data[i].attachName).replace(/\+/g, "%2b").replace(/\@/g,"%40").replace(/\#/g,"%23").replace(/\&/g,"%26").replace(/\//g,"%2F").replace(/\?/g,"%3F").replace(/\￥/g,"%ef%bf%a5").replace(/\$/g,"%24").replace(/\！/g,"%ef%bc%81").replace(/\（/g,"%ef%bc%88").replace(/\）/g,"%ef%bc%89").replace(/\…/g,"%e2%80%a6%e2%80%a6");
							var fileExtensionName=attName.substring(0,attName.lastIndexOf("."));
							var deUrl = data[i].attUrl.split('&ATTACHMENT_NAME=')[0]+"&ATTACHMENT_NAME="+fileExtensionName+"."+fileExtension+"&FILESIZE="+data[i].size;
							str += '<div class="dech" deUrl="' + deUrl+ '">' +
									'<a  NAME="' + data[i].attachName + '*" style="text-decoration:none;margin-left:5px;">' +
									'<img  src="/img/attachment_icon.png"/>' + data[i].attachName + '</a>' +
									'<img class="deImgs" style="margin-left:5px;cursor: pointer;" src="/img/file/icon_deletecha_03.png"/>' +
									'<a fileExtension="'+fileExtension+'" onclick="pdurls($(this))"   href="javascript:;"  style="padding-left: 5px">' +
									'<img src="/img/attachmentIcon/icon_skim.png" style="padding: 0 5px;">查阅</a>' +
									'<a class="download" style="padding-left: 5px;display: none" href="/download?'+encodeURI(deUrl)+'" >' +
									'<img src="/img/attachmentIcon/icon_down.png"  style="padding: 0 5px;">下载</a>' +
									'<a fileExtension="'+fileExtension+'" href="javascript:;"  style="padding-left: 5px" class="printing "  deUrl="' + deUrl+ '"  onclick="daPrinting($(this),0)">' +
									'<img src="/img/attachmentIcon/icon_down.png" id="print"  style="padding: 0 5px;">打印</a>' +
									'<input type="hidden" class="inHidden" value="' + data[i].aid + '@' + data[i].ym + '_' + data[i].attachId + ',">' +
									'</div>'

							<%--str += '<div class="dech" deUrl="' + encodeURI(data[i].attUrl)+ '"><a href="/download?'+encodeURI(data[i].attUrl)+'" NAME="' + data[i].attachName + '*"><img style="margin-right:10px;" src="../img/attachment_icon.png"/>' + data[i].attachName + '</a><img class="deImgs" style="margin-left:5px;cursor: pointer;" src="../img/file/icon_deletecha_03.png"/><input type="hidden" class="inHidden" value="' + data[i].aid + '@' + data[i].ym + '_' + data[i].attachId + ',"></div>';--%>
						}
					}
					$('.attachNameDiv2').append(str);
					if($('input[name="download"]').val() == 1){
						$('#downLoadata').prop('checked',true);
						$('.download').show()
					}else{
						$('#downLoadata').prop('checked',false);
						$('.download').hide()
					}
					if($('input[name="print"]').val() == 1){
						$('#daying').prop('checked',true);
						$('.printing').show()
					}else{
						$('#daying').prop('checked',false);
						$('.printing').hide()
					}
				}else{
					//alert('添加附件大小不能为空!');
					layer.alert('<fmt:message code="dem.th.AddEmpty" />!',{},function(){
						layer.closeAll();
					});
				}
			}
		});
		// 文件正文删除
		$('.attachNameDiv2').on('click','.deImgs',function(){
			var data=$(this).parents('.dech').attr('deUrl');
			var dome=$(this).parents('.dech');
			$('input[name="attachmentId2"]').val('');
			$('input[name="attachmentName2"]').val('');
			deleteChatment(data,dome);
		});
//公共附件上传
		$('#uploadinputimg3').fileupload({
			dataType:'json',
			done: function (e, data) {
				if(data.result.obj != ''){
					var data = data.result.obj;
					var str = '';
					var str2 = '';
					var str1 = '';
					var str3 = ''
					for (var i = 0; i < data.length; i++) {
						var gs = data[i].attachName.split('.')[1];
						if(gs == 'jsp'||gs == 'css'||gs == 'js'||gs == 'html'||gs == 'java'||gs == 'php' ){
							str += '';
							layer.alert('<fmt:message code="dem.th.uploading" />!',{},function(){
								layer.closeAll();
							});
						}else{

							var fileExtension=data[i].attachName.substring(data[i].attachName.lastIndexOf(".")+1,data[i].attachName.length);//截取附件文件后缀
							var attName = encodeURI(data[i].attachName).replace(/\+/g, "%2b").replace(/\@/g,"%40").replace(/\#/g,"%23").replace(/\&/g,"%26").replace(/\//g,"%2F").replace(/\?/g,"%3F").replace(/\￥/g,"%ef%bf%a5").replace(/\$/g,"%24").replace(/\！/g,"%ef%bc%81").replace(/\（/g,"%ef%bc%88").replace(/\）/g,"%ef%bc%89").replace(/\…/g,"%e2%80%a6%e2%80%a6");
							var fileExtensionName=attName.substring(0,attName.lastIndexOf("."));
							var deUrl = data[i].attUrl.split('&ATTACHMENT_NAME=')[0]+"&ATTACHMENT_NAME="+fileExtensionName+"."+fileExtension+"&FILESIZE="+data[i].size;
							str += '<div class="dech" deUrl="' + deUrl+ '">' +
									'<a  NAME="' + data[i].attachName + '*" style="text-decoration:none;margin-left:5px;">' +
									'<img  src="/img/attachment_icon.png"/>' + data[i].attachName + '</a>' +
									'<img class="deImgs" style="margin-left:5px;cursor: pointer;" src="/img/file/icon_deletecha_03.png"/>' +
									'<a fileExtension="'+fileExtension+'" onclick="pdurls($(this))"   href="javascript:;"  style="padding-left: 5px">' +
									'<img src="/img/attachmentIcon/icon_skim.png" style="padding: 0 5px;">查阅</a>' +
									'<a class="download" style="padding-left: 5px;display: none" href="/download?'+encodeURI(deUrl)+'" >' +
									'<img src="/img/attachmentIcon/icon_down.png"  style="padding: 0 5px;">下载</a>' +
									'<a fileExtension="'+fileExtension+'" href="javascript:;"  style="padding-left: 5px" class="printing "  deUrl="' + deUrl+ '"  onclick="daPrinting($(this),0)">' +
									'<img src="/img/attachmentIcon/icon_down.png" id="print"  style="padding: 0 5px;">打印</a>' +
									'<input   type="hidden" class="inHidden" value="' + data[i].aid + '@' + data[i].ym + '_' + data[i].attachId + ',">' +
									'</div>'
							<%--str += '<div class="dech" deUrl="' + encodeURI(data[i].attUrl)+ '"><a href="/download?'+encodeURI(data[i].attUrl)+'" NAME="' + data[i].attachName + '*"><img style="margin-right:10px;" src="../img/attachment_icon.png"/>' + data[i].attachName + '</a><img class="deImgs" style="margin-left:5px;cursor: pointer;" src="../img/file/icon_deletecha_03.png"/><input type="hidden" class="inHidden" value="' + data[i].aid + '@' + data[i].ym + '_' + data[i].attachId + ',"></div>';--%>
						}
					}
					$('.attachNameDiv3').append(str);
					// $('#printIframe').attr('src',daPrint)
					if($('input[name="download"]').val() == 1){
						$('#downLoadata').prop('checked',true);
						$('.download').show()
					}else{
						$('#downLoadata').prop('',false);
						$('.download').hide()
					}
					if($('input[name="print"]').val() == 1){
						$('#daying').prop('',true);
						$('.printing').show()
					}else{
						$('#daying').prop('',false);
						$('.printing').hide()
					}
				}else{
					//alert('添加附件大小不能为空!');
					layer.alert('<fmt:message code="dem.th.AddEmpty" />!',{},function(){
						layer.closeAll();
					});
				}
			}
		});
		// 公共附件删除
		$('.attachNameDiv3').on('click','.deImgs',function(){
			var data=$(this).parents('.dech').attr('deUrl');
			var dome=$(this).parents('.dech');
			$('input[name="attachmentId3"]').val('');
			$('input[name="attachNameDiv3"]').val('');
			deleteChatment(data,dome);
		});
//		附件上传
        $('#uploadinputimg').fileupload({
            dataType:'json',
            done: function (e, data) {
                if(data.result.obj != ''){
                    var data = data.result.obj;
                    var str = '';
                    var str1 = '';
                    for (var i = 0; i < data.length; i++) {
                        var gs = data[i].attachName.split('.')[1];
                        if(gs == 'jsp'||gs == 'css'||gs == 'js'||gs == 'html'||gs == 'java'||gs == 'php' ){
                            str += '';
                            layer.alert('<fmt:message code="dem.th.uploading" />!',{},function(){
                                layer.closeAll();
                            });
                        }else{

							var fileExtension=data[i].attachName.substring(data[i].attachName.lastIndexOf(".")+1,data[i].attachName.length);//截取附件文件后缀
							var attName = encodeURI(data[i].attachName).replace(/\+/g, "%2b").replace(/\@/g,"%40").replace(/\#/g,"%23").replace(/\&/g,"%26").replace(/\//g,"%2F").replace(/\?/g,"%3F").replace(/\￥/g,"%ef%bf%a5").replace(/\$/g,"%24").replace(/\！/g,"%ef%bc%81").replace(/\（/g,"%ef%bc%88").replace(/\）/g,"%ef%bc%89").replace(/\…/g,"%e2%80%a6%e2%80%a6");
							var fileExtensionName=attName.substring(0,attName.lastIndexOf("."));
							var deUrl = data[i].attUrl.split('&ATTACHMENT_NAME=')[0]+"&ATTACHMENT_NAME="+fileExtensionName+"."+fileExtension+"&FILESIZE="+data[i].size;
							str += '<div class="dech" deUrl="' + deUrl+ '">' +
									'<a  NAME="' + data[i].attachName + '*" style="text-decoration:none;margin-left:5px;">' +
									'<img  src="/img/attachment_icon.png"/>' + data[i].attachName + '</a>' +
									'<img class="deImgs" style="margin-left:5px;cursor: pointer;" src="/img/file/icon_deletecha_03.png"/>' +
									'<a fileExtension="'+fileExtension+'" onclick="pdurls($(this))"   href="javascript:;"  style="padding-left: 5px">' +
									'<img src="/img/attachmentIcon/icon_skim.png" style="padding: 0 5px;">查阅</a>' +
									'<a class="download" style="padding-left: 5px;display: none" href="/download?'+encodeURI(deUrl)+'" >' +
									'<img src="/img/attachmentIcon/icon_down.png"  style="padding: 0 5px;">下载</a>' +
									'<a fileExtension="'+fileExtension+'" href="javascript:;"  style="padding-left: 5px" class="printing "  deUrl="' + deUrl+ '"  onclick="daPrinting($(this),0)">' +
									'<img src="/img/attachmentIcon/icon_down.png" id="print"  style="padding: 0 5px;">打印</a>' +
									'<input type="hidden" class="inHidden" value="' + data[i].aid + '@' + data[i].ym + '_' + data[i].attachId + ',">' +
									'</div>'


							<%--str += '<div class="dech" deUrl="' + encodeURI(data[i].attUrl)+ '"><a href="/download?'+encodeURI(data[i].attUrl)+'" NAME="' + data[i].attachName + '*"><img style="margin-right:10px;" src="../img/attachment_icon.png"/>' + data[i].attachName + '</a><img class="deImgs" style="margin-left:5px;cursor: pointer;" src="../img/file/icon_deletecha_03.png"/><input type="hidden" class="inHidden" value="' + data[i].aid + '@' + data[i].ym + '_' + data[i].attachId + ',"></div>';--%>
                        }
                    }
                    $('.attachNameDiv').append(str);
					if($('input[name="download"]').val() == 1){
						$('#downLoadata').prop('checked',true);
						$('.download').show()
					}else{
						$('#downLoadata').prop('checked',false);
						$('.download').hide()
					}
					if($('input[name="print"]').val() == 1){
						$('#daying').prop('checked',true);
						$('.printing').show()
					}else{
						$('#daying').prop('checked',false);
						$('.printing').hide()
					}
                }else{
                    //alert('添加附件大小不能为空!');
                    layer.alert('<fmt:message code="dem.th.AddEmpty" />!',{},function(){
                        layer.closeAll();
                    });
                }
            }
        });
//        附件删除
        $('.attachNameDiv').on('click','.deImgs',function(){
            var data=$(this).parents('.dech').attr('deUrl');
            var dome=$(this).parents('.dech');
            $('input[name="attachmentId"]').val('');
            $('input[name="attachmentName"]').val('');
            deleteChatment(data,dome);
        })

//		查看详情
        $('#j_tb').on('click','.to_detail',function () {
			var dataId=$(this).parents('tr').attr('data-id');
            $.popWindow('/rmsFile/detail?fileId='+dataId);
        })
//        编辑回写
	    $('#j_tb').on('click','.eaitData',function(){
	        var dataId=$(this).parents('tr').attr('data-id');
	        $('input[name="fileId"]').val(dataId);
	        $('.juMange').hide();
	        $('.newMange').show();
	        $.ajax({
				type:'get',
				url:'/rmsFile/selectById',
				dataType:'json',
				data:{
                    fileId:dataId
				},
				success:function(res){
				    var datas=res.object;
                    $('input[name="attachmentId"]').val(datas.attachmentId);
                    $('input[name="attachmentName"]').val(datas.attachmentName);
					$('input[name="attachmentId2"]').val(datas.attachmentId2);
					$('input[name="attachmentName2"]').val(datas.attachmentName2);
				    $('input[name="fileCode"]').val(datas.fileCode);
				    $('input[name="fileSubject"]').val(datas.fileSubject);
				    $('input[name="fileTitle"]').val(datas.fileTitle);
				    $('input[name="fileTitle0"]').val(datas.fileTitle0);
				    $('input[name="sendUnit"]').val(datas.sendUnit);
				    if(datas.sendDate != undefined){
                        $('input[name="sendDate"]').val(datas.sendDate);
					}
				    $('#secret').val(datas.secret);
				    $('#urgency').val(datas.urgency);
				    $('#fileType').val(datas.fileType);
				    $('#fileKind').val(datas.fileKind);
				    $('input[name="filePage"]').val(datas.filePage);
				    $('input[name="printPage"]').val(datas.printPage);
				    $('input[name="remark"]').val(datas.remark);
				    $('#rollId').val(datas.rollId);
				    if(datas.isaudit == '1'){
				        $('input[name="isaudit"]').eq(0).prop('checked',true);
					}else{
                        $('input[name="isaudit"]').eq(1).prop('checked',true);
					}
                    $('input[name="download"]').val(datas.download);

					$('input[name="print"]').val(datas.print);
					if(datas.print == 1){
					    $('#daying').prop('checked',true);
					}else{
                        $('#daying').prop('checked',false);
					}
					$('#rollId').val(datas.rollId)

					var data=datas.attachmentList;
					var str='';
					for(var i=0;i<data.length;i++){
						var fileExtension=data[i].attachName.substring(data[i].attachName.lastIndexOf(".")+1,data[i].attachName.length);//截取附件文件后缀
						var attName = encodeURI(data[i].attachName).replace(/\+/g, "%2b").replace(/\@/g,"%40").replace(/\#/g,"%23").replace(/\&/g,"%26").replace(/\//g,"%2F").replace(/\?/g,"%3F").replace(/\￥/g,"%ef%bf%a5").replace(/\$/g,"%24").replace(/\！/g,"%ef%bc%81").replace(/\（/g,"%ef%bc%88").replace(/\）/g,"%ef%bc%89").replace(/\…/g,"%e2%80%a6%e2%80%a6");
						var fileExtensionName=attName.substring(0,attName.lastIndexOf("."));
						var deUrl = data[i].attUrl.split('&ATTACHMENT_NAME=')[0]+"&ATTACHMENT_NAME="+fileExtensionName+"."+fileExtension+"&FILESIZE="+data[i].size;
						str += '<div class="dech" deUrl="' + deUrl+ '">' +
								'<a NAME="' + data[i].attachName + '*" style="text-decoration:none;margin-left:5px;">' +
								'<img  src="/img/attachment_icon.png"/>' + data[i].attachName + '</a>' +
								'<img class="deImgs" style="margin-left:5px;cursor: pointer;" src="/img/file/icon_deletecha_03.png"/>' +
								'<a fileExtension="'+fileExtension+'" onclick="pdurls($(this))"   href="javascript:;"  style="padding-left: 5px">' +
								'<img src="/img/attachmentIcon/icon_skim.png" style="padding: 0 5px;">查阅</a>' +
								'<a class="download" style="padding-left: 5px;display: none" href="/download?'+encodeURI(deUrl)+'" >' +
								'<img src="/img/attachmentIcon/icon_down.png"  style="padding: 0 5px;">下载</a>' +
								'<a fileExtension="'+fileExtension+'" href="javascript:;"  style="padding-left: 5px" class="printing "  deUrl="' + deUrl+ '"  onclick="daPrinting($(this),0)">' +
								'<img src="/img/attachmentIcon/icon_down.png" id="print"  style="padding: 0 5px;">打印</a>' +
								'<input type="hidden" class="inHidden" value="' + data[i].aid + '@' + data[i].ym + '_' + data[i].attachId + ',">' +
								'</div>'
                        <%--str += '<div class="dech" deUrl="' + encodeURI(arrAttach[i].attUrl)+ '"><a href="/download?'+encodeURI(arrAttach[i].attUrl)+'" NAME="' + arrAttach[i].attachName + '*"><img style="margin-right:10px;" src="../img/attachment_icon.png"/>' + arrAttach[i].attachName + '</a><img class="deImgs" style="margin-left:5px;cursor: pointer;" src="../img/file/icon_deletecha_03.png"/><input type="hidden" class="inHidden" value="' + arrAttach[i].aid + '@' + arrAttach[i].ym + '_' + arrAttach[i].attachId + ',"></div>';--%>
					}
                    $('.attachNameDiv').html(str);

					var arrAttach2=datas.attachmentList2;
					var str2='';
					for(var i=0;i<arrAttach2.length;i++){
						var fileExtension=arrAttach2[i].attachName.substring(arrAttach2[i].attachName.lastIndexOf(".")+1,arrAttach2[i].attachName.length);//截取附件文件后缀
						var attName = encodeURI(arrAttach2[i].attachName).replace(/\+/g, "%2b").replace(/\@/g,"%40").replace(/\#/g,"%23").replace(/\&/g,"%26").replace(/\//g,"%2F").replace(/\?/g,"%3F").replace(/\￥/g,"%ef%bf%a5").replace(/\$/g,"%24").replace(/\！/g,"%ef%bc%81").replace(/\（/g,"%ef%bc%88").replace(/\）/g,"%ef%bc%89").replace(/\…/g,"%e2%80%a6%e2%80%a6");
						var fileExtensionName=attName.substring(0,attName.lastIndexOf("."));
						var deUrl = arrAttach2[i].attUrl.split('&ATTACHMENT_NAME=')[0]+"&ATTACHMENT_NAME="+fileExtensionName+"."+fileExtension+"&FILESIZE="+arrAttach2[i].size;
						str2 += '<div class="dech" deUrl="' + deUrl+ '">' +
								'<a  NAME="' + arrAttach2[i].attachName + '*" style="text-decoration:none;margin-left:5px;">' +
								'<img  src="/img/attachment_icon.png"/>' + arrAttach2[i].attachName + '</a>' +
								'<img class="deImgs" style="margin-left:5px;cursor: pointer;" src="/img/file/icon_deletecha_03.png"/>' +
								'<a fileExtension="'+fileExtension+'" onclick="pdurls($(this))"   href="javascript:;"  style="padding-left: 5px">' +
								'<img src="/img/attachmentIcon/icon_skim.png" style="padding: 0 5px;">查阅</a>' +
								'<a class="download" style="padding-left: 5px;display: none" href="/download?'+encodeURI(deUrl)+'" >' +
								'<img src="/img/attachmentIcon/icon_down.png"  style="padding: 0 5px;">下载</a>' +
								'<a fileExtension="'+fileExtension+'" href="javascript:;"  style="padding-left: 5px" class="printing "  deUrl="' + deUrl+ '"  onclick="daPrinting($(this),0)">' +
								'<img src="/img/attachmentIcon/icon_down.png" id="print"  style="padding: 0 5px;">打印</a>' +
								'<input type="hidden" class="inHidden" value="' + arrAttach2[i].aid + '@' + arrAttach2[i].ym + '_' + arrAttach2[i].attachId + ',">' +
								'</div>'

						<%--str2 += '<div class="dech" deUrl="' + encodeURI(arrAttach2[i].attUrl)+ '"><a href="/download?'+encodeURI(arrAttach2[i].attUrl)+'" NAME="' + arrAttach2[i].attachName + '*"><img style="margin-right:10px;" src="../img/attachment_icon.png"/>' + arrAttach2[i].attachName + '</a><img class="deImgs" style="margin-left:5px;cursor: pointer;" src="../img/file/icon_deletecha_03.png"/><input type="hidden" class="inHidden" value="' + arrAttach2[i].aid + '@' + arrAttach2[i].ym + '_' + arrAttach2[i].attachId + ',"></div>';--%>
					}
					$('.attachNameDiv2').html(str2);
					if(datas.download == 1){
						$('#downLoadata').prop('checked',true);
						$('.download').show()
					}else{
						$('#downLoadata').prop('checked',false);
						$('.download').hide()
					}
					if(datas.print == 1){
						$('#daying').prop('checked',true);
						$('.printing').show()
					}else{
						$('#daying').prop('checked',false);
						$('.printing').hide()
					}
				}
			})
		})



		$('#downLoadata').on('click',function(){
			var state =$(this).prop("checked");
			if(state == true){
				$(this).prop("checked",true);
				$('input[name="download"]').val('1');
				$('.download').show()
			}else{
				$(this).prop("checked",false);
				$('input[name="download"]').val('0');
				$('.download').hide()
			}
		})
		$('#daying').on('click',function(){
			var state =$(this).prop("checked");
			if(state == true){
				$(this).prop("checked",true);
				$('input[name="print"]').val('1');
				$('.printing').show()
			}else{
				$(this).prop("checked",false);
				$('input[name="print"]').val('0');
				$('.printing').hide()
			}
		})
//		编辑保存
		$('.saveBtn').on('click',function(){
			if($('input[name="fileCode"]').val() == ''){
				layer.msg('请填写文件号！', { icon:5,time:1000});
				return false;
			}
			// if($('input[name="fileSubject"]').val() == ''){
			// 	layer.msg('请填写文件主题词！', { icon:5,time:1000});
			// 	return false;
			// }
			if($('input[name="fileTitle"]').val() == ''){
				layer.msg('请填写文件标题！', { icon:5,time:1000});
				return false;
			}
			if($('#secret option:selected').val() == ''){
				layer.msg('请选择密级！', { icon:5,time:1000});
				return false;
			}
            var aId='';
            var uId='';
            for(var i=0;i<$('.attachNameDiv .inHidden').length;i++){
                aId+=$('.attachNameDiv .inHidden').eq(i).val();
            }
            for(var i=0;i<$('.attachNameDiv .dech').length;i++){
                uId+=$('.attachNameDiv .dech').eq(i).find('a').attr('NAME');
            }
            $('input[name="attachmentId"]').val(aId);
            $('input[name="attachmentName"]').val(uId);

			var aId2='';
			var uId2='';
			for(var i=0;i<$('.attachNameDiv2 .inHidden').length;i++){
				aId2+=$('.attachNameDiv2 .inHidden').eq(i).val();
			}
			for(var i=0;i<$('.attachNameDiv2 .dech').length;i++){
				uId2+=$('.attachNameDiv2 .dech').eq(i).find('a').attr('NAME');
			}
			$('input[name="attachmentId2"]').val(aId2);
			$('input[name="attachmentName2"]').val(uId2);

            $('#form1').ajaxSubmit({
                type: 'post',
                dataType: 'json',
                success: function (res) {
                    if (res.flag) {
                        $.layerMsg({content: '<fmt:message code="diary.th.modify" />！', icon: 1}, function () {
                            location.reload();
                        });
                    } else {
                        $(this).attr('data-type',true)
                        alert('<fmt:message code="dem.th.abnormal" />')
                    }

                }
            })

		})
//		返回
		$('.resetBtn').on('click',function(){
            $('.juMange').show();
            $('.newMange').hide();
		})
	})

    var start = {
        format: 'YYYY-MM-DD hh:mm:ss',
		/* min: laydate.now(), //设定最小日期为当前日期*/
		/* max: '2099-06-16 23:59:59', //最大日期*/
        istime: true,
        istoday: false,
        choose: function(datas){
            end.min = datas; //开始日选好后，重置结束日的最小日期
            end.start = datas //将结束日的初始值设定为开始日
        }
    };

    function deleteChatment(data,element){

        layer.confirm('<fmt:message code="workflow.th.que" />？', {
            btn: ['<fmt:message code="global.lang.ok" />','<fmt:message code="depatement.th.quxiao" />'], //按钮
            title:"<fmt:message code="notice.th.DeleteAttachment" />"
        }, function(){
            //确定删除，调接口
            $.ajax({
                type:'get',
                url:'/rmsFile/destory',
                dataType:'json',
                data:data,
                success:function(res){
                    if(res.flag){
                        layer.msg('<fmt:message code="workflow.th.delsucess" />', { icon:6});
                        element.remove();
                    }else{
                        layer.msg('<fmt:message code="lang.th.deleSucess" />', { icon:6});
                    }
                }
            });

        }, function(){
            layer.closeAll();
        });
    }
</script>
<script>


	function daPrinting(_this,num){ //根据后缀判断选择调取那种打开方式
		console.log(_this)
		var atturl=_this.attr('deUrl')
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
		var gs=_this.attr('fileExtension')
		if(gs == 'png'||gs == 'jpg'||gs == 'bmp' || gs == 'emf' || gs == 'gif'|| gs == 'pcx'|| gs == 'pcd'|| gs == 'ai'|| gs == 'webp'|| gs == 'WMF'|| gs == 'dxf' ||gs == 'PNG'||gs == 'JPG'||gs == 'BMP' || gs == 'EMF' || gs == 'GIF'|| gs == 'PCX'|| gs == 'PCD'|| gs == 'AI'|| gs == 'WEBP'|| gs == 'wmf'|| gs == 'DXF'|| gs == 'txt'|| gs == 'TXT'){
			// $.popWindow("/xs?"+atturl,PreviewPage,'0','0','1200px','600px');
			var url1 = "/xs?"+atturl
			$('#printIframe').attr('src',url1)
			setTimeout(function(){
				if(num == 0){
					$("#printIframe")[0].contentWindow.print();
				}else {
					return url1
				}
			}, 1000)


		}else if(gs == 'mp4'||gs == 'rmvb'||gs == 'avi'||gs == 'ifo'||gs == 'wmv'||gs == 'MP4'||gs == 'RMVB'||gs == 'AVI'||gs == 'IFO'||gs == 'WMV'){
			// layer.open({type: 2, title: false, area: ['630px', '360px'], shade: 0.8, closeBtn: 0, shadeClose: true, content: "/common/video?videoatturlsplit="+atturl});
			var url2 = "/common/video?videoatturlsplit="+atturl
			$('#printIframe').attr('src',url2)
			setTimeout(function(){
				if(num == 0){
					$("#printIframe")[0].contentWindow.print();
				}else {
					return url2
				}
			}, 1000)

			layer.msg('点击任意处关闭');
		}else if(gs == 'pdf'||gs == 'PDF'){
			// $.popWindow("/pdfPreview?"+atturl,PreviewPage,'0','0','1200px','600px');
			var url3 = "/pdfPreview?"+atturl
			$('#printIframe').attr('src',url3)
			setTimeout(function() {
				if (num == 0) {
					$("#printIframe")[0].contentWindow.print();
				} else {
					return url3
				}
			},1000)
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
						}else if(res.object[0].paraValue == 3){
							//默认加载onlyoffice插件 进行跳转
							url = "/common/onlyoffice?"+ atturl +"&edit=false";
						}
					}

				}
			})
			// $.popWindow(url,PreviewPage,'0','0','1200px','600px');

			// GSCloudPlugin.PrintWord({
			// 	Title:'lll',
			// 	Url: url,
			// 	PrinterName: "",
			// 	OnSuccess:function(result){
			// 		// 打印成功
			// 		console.log(result);
			// 	},
			// 	OnError:function(result){
			// 		// 打印失败
			// 		console.log(result);
			// 	}
			// });

			$('#printIframe').attr('src',url)
			setTimeout(function() {
				if(num == 0){
					$("#printIframe")[0].contentWindow.print();
				}else {
					return url
				}
			},1000)




		}
	}

	// var objhead = document.head || document.getElementsByTagName("head")[0] || document.documentElement;
	// var objscript = document.createElement("script");
	// objscript.src ="http://127.0.0.1:8365/GSCloudPlugin.js";
	// objhead.insertBefore(objscript,objhead.firstChild);
	//
	// // 为了防止端口被占用，增加一个备用
	// objscript = document.createElement("script");
	// objscript.src ="http://127.0.0.1:18365/GSCloudPlugin.js";
	// objhead.insertBefore(objscript,objhead.firstChild);
	//
	// export function getGSCloudPlugin(){
	// 	return window.GSCloudPlugin;
	// }
</script>
</body>
</html>
