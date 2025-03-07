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
		<title><fmt:message code="email.title.waitmail" /></title><!-- 写邮件 -->
		<meta name="renderer" content="webkit">
	    <meta http-equiv="X-UA-Compatible" content="IE=10,chrome=1">
		<meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=0, minimum-scale=1.0, maximum-scale=1.0">
		<link rel="stylesheet" type="text/css" href="/css/email/writeMail.css"/>
		<link rel="stylesheet" type="text/css" href="/lib/ueditor/formdesign/bootstrap/css/bootstrap.css"/>
		<script src="/js/common/language.js"></script>
<%--		<script src="/js/xoajq/xoajq1.js" type="text/javascript" charset="utf-8"></script>--%>
		<script type="text/javascript" src="/js/xoajq/xoajq3.js"></script>
		<script type="text/javascript" src="/js/jquery/jquery-migrate-3.4.0.js"></script>
		<script src="/lib/jQuery-File-Upload-master/jquery-ui.js?20230421.1" type="text/javascript" charset="utf-8"></script>
		<script src="/lib/jQuery-File-Upload-master/jquery.iframe-transport.js" type="text/javascript" charset="utf-8"></script>
		<script src="/lib/ueditor/formdesign/bootstrap/js/bootstrap.js?20200826" type="text/javascript" charset="utf-8"></script>
		<script src="/lib/layer/layer.js?20201106" type="text/javascript" charset="utf-8"></script>
		<script src="/lib/ueditor/ueditor.config.js" type="text/javascript" charset="utf-8"></script>
		<script src="/lib/ueditor/ueditor.all.js?20200924.1" type="text/javascript" charset="utf-8"></script>
		<script src="/lib/ueditor/UEcontroller.js" type="text/javascript" charset="utf-8"></script>
		<script src="/js/base/base.js?20220317" type="text/javascript" charset="utf-8"></script>
		<script src="/js/email/writeMail.js?20200429.1" type="text/javascript" charset="utf-8"></script>
		<script src="/js/ajaxupload.js" type="text/javascript" charset="utf-8"></script>
		<script src="/js/jquery/jquery.form.min.js"></script>
		<script type="text/javascript" src="../js/spirit/qwebchannel.js"></script>
<%--		<script type="text/javascript" src="/js/email/fileupload.js"></script>--%>
<%--		<script type="text/javascript" src="/js/email/fileuploadPlus.js?20230529.3"></script>--%>
		<script src="/lib/jQuery-File-Upload-master/jquery.fileupload.js" type="text/javascript" charset="utf-8"></script>
		<script type="text/javascript" src="/js/common/fileupload.js?20230529.3"></script>

		<style>
			.files a{text-decoration: none;}
			a{
				text-decoration: none;
				color: #207BD6;
				cursor: pointer;
			}
			#attention{
				margin: 0;
				padding:0;
				list-style: none;
				width:100px;
				position: absolute;
				left: 10px;
				text-align: center;
				display: none;
				z-index: 9999;
				border:#ccc 1px solid;
				top:20px;
			}
			#attention li{
				background: #ffffff;
				cursor:pointer;
				line-height: 22px;
			}
			#attention li:hover{
				background-color: #6ea1d5;
				color: #fff;
			}
			.choose{
				width: 180px;
				position: absolute;
				left: 255px;
				top: 0px;
			}
			.bar {
				height: 18px;
				background: green;
			}
			.box{width:200px; height:20px; }
			.tbox{width:200px; height:20px; background:url(/img/email/bak.png) no-repeat;background-size: 100% 100%;}
			.tbox div{width:0px; height:20px; background:url(/img/email/pro.png) no-repeat;background-size: 100% 100%;text-align:center;font-size:14px; line-height:20px;}
			a#uploadfile:hover{
				color:#207BD6;
			}
		</style>
	</head>
	<body>
		<table class="TABLE" border="1" cellspacing="0" cellpadding="0" style="border-collapse: collapse;margin-bottom: 20px;margin-top: 30px">
			<tr class="append_tr">
				<td width="15%" style="padding-left: 10px;"><fmt:message code="email.th.recipients" />：</td>
				<td width="85%">
					<div class="inPole">
						<textarea name="txt" id="senduser" user_id='' style="min-width: 70%;vertical-align: middle;" value="" disabled></textarea>
						<span class="add_img" style="margin-left: 10px">
							<a href="javascript:;" id="selectUser" class="Add "><fmt:message code="global.lang.add" /></a>
						</span>
						<span class="add_img">
							<a href="javascript:;" class="clear"><fmt:message code="notice.th.delete1" /></a>
						</span>
					</div>
					<div class="addPepl">
						<a href="javascript:;" class="a3" a3Type="0"><fmt:message code="email.th.addingExternalRecipients" /></a>
						<a href="javascript:;" class="a1" id="addIndex"><fmt:message code="email.th.addwait" /></a>
						<a href="javascript:;" class="a2" id="addmisong"><fmt:message code="email.th.addbcc" /></a>
						<div class="choose">
								<a href="javascript:;" class="show"><fmt:message code="email.th.add" /></a>
								<ul id="attention" >

								</ul>
							</div>
					</div>
				</td>
			</tr>
			<%--抄送--%>
			<tr class="tian" style="display: none;">
				<td><fmt:message code="main.th.CC" />：</td>
				<td><textarea id="copeNameText" name="txt" disabled></textarea>
					<span class="add_img">
						<a href="javascript:;" id="selectUserO" class="Add" style="margin-left: 16px;font-size: 14px;"><fmt:message code="global.lang.add" /></a>
					</span>
					<span class="add_img">
						<a href="javascript:;" class="clearCC" style="margin-left: 16px;font-size: 14px;"><fmt:message code="notice.th.delete1" /></a>
					</span>
					</td>
			</tr>
			<%--添加密送--%>
			<tr class="mis" style="display: none;"><td><fmt:message code="email.th.bcc" />：</td>
			<td><textarea id="secritText" name="txt" disabled></textarea>
				<span class="add_img">
			<a href="javascript:;" id="selectUserT" class="Add" style="margin-left: 16px;font-size: 14px;"><fmt:message code="global.lang.add" /></a>
			</span>
				<span class="add_img"><a href="javascript:;" class="clearBCC" style="margin-left: 16px;font-size: 14px;"><fmt:message code="notice.th.delete1" /></a></span>
				</td>
			</tr>

			<tr class="InText" style="display: none;">
				<td style="padding: 5px;"><fmt:message code="email.th.ExternalRecipient" />：</td>
				<td><input type="text" id="outEmail" style="width: 70%;padding: 5px;" class="input_txt"></td>
			</tr>
			<tr class="InText" style="display: none;">
				<td style="padding: 5px;">Internet <fmt:message code="email.th.mail" />：</td>
				<td style="padding: 5px;">
					<select id="outSelect" style="width: 300px;height: 28px;">
					</select>
					<span style="margin-left: 5px;font-size: 10pt;"><fmt:message code="email.th.SendMessage" /></span>
				</td>
			</tr>
			<tr>
				<td width="15%" style="padding-left: 10px;"><fmt:message code="email.th.major" />：</td>
				<td width="85%">
					<input type="text" id="txt" value="" style="width: 70%;" class="input_txt" />
					<!-- <span class="import">一般邮件</span> -->
				</td>
			</tr>
			<tr>
				<td width="15%" style="padding-left: 10px;">
					<p><fmt:message code="email.th.content" />：</p>
					<!-- <p class="Color"><fmt:message code="email.th.countnumber" />：<span>0</span></p> -->
					<p class="Color"><a href="javascript:;" onclick="empty()"><fmt:message code="global.lang.empty" /></a></p>
				</td>
				<td width="85%">
					<scrtpt id="container" style="width: 99.9%;min-height: 300px;" name="content" type="text/plain"></scrtpt>
				</td>
			</tr>
			<tr class="Attachment" style="width:100%; padding-left: 10px;">
				<td width="15%"><fmt:message code="email.th.filechose" />：</td>
				<td width="85%"   class="files" id="files_txt">
					<div id="fileContent"></div>
				</td>
			</tr>
			<tr>
				<td width="15%" style="padding-left: 10px;"><fmt:message code="email.th.file" />：</td>
				<td width="85%" class="files" style="position: relative">
					<!-- <fmt:message code="email.th.addfile" /> -->
					<form id="uploadimgform" style="float: left;margin: 0 20px 0 0;" target="uploadiframe"  action="/upload?module=email"  method="post" >
						<input type="file" multiple="multiple" name="file"  id="uploadinputimg"  class="w-icon5" style="cursor:pointer;position: absolute;opacity: 0;width: 70px;filter: progid:DXImageTransform.Microsoft.Alpha(opacity=0)">
						<a href="#" id="uploadimg" style="display: inline-block;height: 20px;line-height: 20px"><img style="margin:3px 5px 0 0;float: left;" src="../img/icon_uplod.png"/><fmt:message code="global.th.fileup" /></a>
					</form>
					<form id="uploadimgform2" style="float: left;margin: 0 20px 0 0;"   action=""  method="post" >
						<input webkitdirectory type="file" multiple="multiple" name="file"  id="Folder"  class="w-icon5" style="cursor:pointer;position: absolute;opacity: 0;width: 70px;filter: progid:DXImageTransform.Microsoft.Alpha(opacity=0)">
						<a href="#" id=" upload" style="display: inline-block;height: 20px;line-height: 20px"><img style="margin:3px 5px 0 0;float: left;" src="../img/icon_uplod.png"/><fmt:message code="file.th.folderUpload" /></a>
					</form>
					<form id="fileform" style="float: left;margin: 0 20px 0 0;" target=""  action=""  method="post" >
						<a href="#" id="uploadfile" style="display: inline-block;height: 20px;line-height: 20px" onclick="fileBox()"><img style="margin:3px 5px 0 0;float: left;" src="../img/mg12.png"/><fmt:message code="email.th.selectUpload" /></a>
					</form>
					<span id="fileTips" style="color: #b6b1b1"><fmt:message code="file.th.fileUploadDesc" /></span>
					<%--<a href="javascript:;" onclick="formFile()" style="float: left;margin: 0 15px;"><img style="margin-right:5px;" src="../img/icon_uplod.png"/>从文件柜选择附件</a>--%>
					<div id="progress" style="width: 200px;float: left;margin-left: 10px;margin-top: 2px;">
						<div class="bar" style="width: 0%;"></div>
					</div>
					<div class="barText" style="float: left;margin-left: 10px;"></div>
				</td>
			</tr>
			<tr>
				<td width="15%" style="padding-left: 10px;"><fmt:message code="sms.th.remind" />：</td>
				<td width="85%" class="remind">
					<div class="news_t">
						<input type="checkbox" name="remind" style="margin-top: -2px" class="remindCheck" value="0" checked>
						<span class="remind_msg"><fmt:message code="notice.th.remindermessage" /></span>&nbsp;
						<input type="checkbox" name="smsDefault" style="margin-top: -2px" class="smsDefault" value="1" >
						<span class="hideSpan"><fmt:message code="vote.th.UseRemind" /></span>
					</div>
				</td>
			</tr>
			<tr>
				<td colspan="2">
					<div class="div_btn">
						<div class="sureBtn"><span style="margin-left: 30px;"><fmt:message code="email.th.transmitimmediate" /></span></div>
                    	<div class="saveBtn" style="width: 135px !important;"><span style="margin-left: 33px;"><fmt:message code="email.th.savedraftbox" /></span></div>
					</div>
				</td>
			</tr>
		</table>
		<div style="display: none;">
			<form id="wordimportform" enctype="multipart/form-data">
				<input type="file" name="file" id="wordimportfile" onchange="javascript:asyncUploadFile()" />
				<%--<div id="query_uploadArr" name="query_uploadArr" style="display: none;width:240px;height:80px;float:left">--%>
				<%--</div>--%>
			</form>
		</div>
		<div class="modal fade" id="loadingModal" aria-hidden="false">
			<div style="width: 200px;height:20px; z-index: 20000; position: absolute; text-align: center; left: 50%; top: 50%;margin-left:-100px;margin-top:-10px">
				<div class="progress progress-striped active" style="margin-bottom: 0;">
					<div class="progress-bar" style="width: 100%;"></div>
				</div>
				<h5 style="color: #5BC0DE;"><fmt:message code="workflow.th.doing" /></h5>
			</div>
		</div>
		<script type="text/javascript">
			var fileSizes;
			var attachmentSize;
            var uid = $.GetRequest().uid|| '';
            var uname = $.GetRequest().uname|| '';
            var attach_id='';
            var acc;
            window.console = window.console || (function(){
                    var c = {}; c.log = c.warn = c.debug = c.info = c.error = c.time = c.dir = c.profile = c.clear = c.exception = c.trace = c.assert = function(){};
                    return c;
                })();

			function getQueryString(name){
				var reg = new RegExp("(^|&)"+ name +"=([^&]*)(&|$)");
				var r = window.location.search.substr(1).match(reg);
				if (r != null)
						//return unescape(r[2]);  // 会中文乱码
					return decodeURI((r[2])); // 解决了中文乱码
				return null;
			}
			var type = getQueryString('type')
            $(function(){
            	if(type == "1"){
					$('table').width($(document).width()-600);
					$('.TABLE').css('height','500px');
				}else{
					$('table').width($(document).width()-100);
				}

                var userId = getQueryString('userId');
                var userName = getQueryString('userName');
				if(userId != null || userName!= null){  //判断userId或者userName是否为空
					$('#senduser').attr('user_id',userId+',');
					$('#senduser').attr('username',decodeURI(userName)+',');
					$('#senduser').val(decodeURI(userName)+',');
				}else{
                    $('#senduser').attr('user_id','');
                    $('#senduser').attr('username','');
                    $('#senduser').val('');
				}
//				查是否有权限使用提醒
				$.ajax({
					type:'get',
					url:'/smsRemind/getRemindFlag',
					dataType:'json',
					data:{
						type:2
					},
					success:function (res) {
						if(res.flag){
							if(res.obj.length>0){
								var data = res.obj[0];
								// 是否默认发送
								if(data.isRemind=='0'){
									$('.remindCheck').prop("checked", false);
								}else if(data.isRemind=='1'){
									$('.remindCheck').prop("checked", true);
								}
								// 是否手机短信默认提醒
								if(data.isIphone=='0'){
									$('.smsDefault').prop("checked", false);
								} else if (data.isIphone=='1'){
									$('.smsDefault').prop("checked", true);
								}
								// 是否允许发送事务提醒
								if(data.isCan=='0'){
									$('.remindCheck').prop("checked", false);
									$('.smsDefault').prop("checked", false);
									$('.remind').parent('tr').hide();
								}

							}
						}
					}
				})
//				查Internet邮箱
				$.ajax({
					type:'get',
					url:'/email/selectUserWebMail',
					dataType:'json',
					success:function (res) {
						var data=res.obj;
						var str='';
						if(res.flag){
						    if(data.length > 0){
						        for(var i=0;i<data.length;i++){
                                    str+='<option value="'+data[i].email+'">'+data[i].email+'</option>'
								}
							}else{
								str='<option value=""><fmt:message code="hr.th.PleaseSelect" /></option>'
							}
							$('#outSelect').html(str);
						}
                    }
				})

				$.ajax({
					type:'get',
					url:'/syspara/selectByParaName',
					dataType:'json',
					data:{paraName:'ONE_ATTACHMENT_SIZE'},
					success:function (res) {
						 attachmentSize=res.object*1024*1024
					}
				})
				$('#uploadinputimg').on('change',function(){
					fileSizes = Array.from(this.files).map(function(it) {
						return {
							name:it.name,
							size:it.size
						}
					})
				})
				$('#Folder').on('change',function(){
					fileSizes = Array.from(this.files).map(function(it) {
						return {
							name:it.name,
							size:it.size
						}
					})
				})
                if(uid != ''){
                    $.ajax({
                        type:'get',
                        url:'/user/findUserByuid',
                        dataType:'json',
                        data:{
                            uid:uid
						},
                        success:function(res){
							if(res.flag){
                                $('#senduser').attr('user_id',res.object.userId+',').val(res.object.userName+',').attr('username',res.object.userName+',');
                                $('.add_img').hide();
							}
                        }
                    });
                }
            })
			//当浏览器窗口改变时，根据浏览器窗口大小重新定义表格宽高
			$(window).on('resize',function() {
				$('.TABLE').width($(document).width()-100);
				$('.TABLE').height($(document).height()-100);
			});


			//附件上传方法

			fileuploadFn('#uploadinputimg',$('.Attachment td').eq(1));
			fileuploadFn('#Folder',$('.Attachment td').eq(1));

			//解决拖拽上传执行多次接口，文件夹上传方法如果被点击后执行
			$("#uploadimgform2").on('click',function (){
				$("#uploadimgform2").attr("action","/upload?module=email")
			})

			//			从文件柜上传文件
			// function formFile() {
             //    attach_id='fileContent';
             //    $.popWindow("/email/formFileCabinet");
            // }
            function fileBox() {
               file_id='files_txt';
               model = 'email'
               $.popWindow("../common/selectNewFile?1");
            }



			var user_id='senduser';
			var ue = UE.getEditor('container',{elementPathEnabled : false});
            UEimgfuc();

            var res;
       		 $(function(){
				 ue.ready(function() {
					 var flow_view_str =  $.getQueryString("flow_view_str")||'';
					 if(flow_view_str != ''){
					 	 var runId = window.top.opener.globalData.flowRun.runId;
						 var dataAttach = [];
						 $.ajax({
							 type:'post',
							 url:'/flowUtil/flowAttach2Other',
							 data:{
								 runId:runId,
								 module:'email'
							 },
							 dataType:'json',
							 async:false,
							 success:function(res){
								 dataAttach = res.obj;
							 }
						 })
						 var flowname = window.top.opener.globalData.flowRun.runName;
						 $('#txt').val(flowname);

						 var str = '';
						 for (var i = 0; i < dataAttach.length; i++) {
							 var gs = dataAttach[i].attachName.split('.')[1];
							 if(gs == 'jsp'||gs == 'css'||gs == 'js'||gs == 'html'||gs == 'java'||gs == 'php' ){ //后缀为这些的禁止上传
								 str += '';
								 layer.alert('<fmt:message code="dem.th.uploading" />!',{},function(){
									 layer.closeAll();
								 });
							 }else if(dataAttach[i].attachName.indexOf('+')!=-1){
								 alert("<fmt:message code="email.th.theFileNameIsIncorrect1" />"+dataAttach[i].attachName+"<fmt:message code="email.th.theFileNameIsIncorrect2" />");

							 }else{
								 var fileExtension=dataAttach[i].attachName.substring(dataAttach[i].attachName.lastIndexOf(".")+1,dataAttach[i].attachName.length);//截取附件文件后缀
								 var attName = encodeURI(dataAttach[i].attachName).replace(/\+/g, "%2b").replace(/\@/g,"%40").replace(/\#/g,"%23").replace(/\&/g,"%26").replace(/\//g,"%2F").replace(/\?/g,"%3F").replace(/\￥/g,"%ef%bf%a5").replace(/\$/g,"%24").replace(/\！/g,"%ef%bc%81").replace(/\（/g,"%ef%bc%88").replace(/\）/g,"%ef%bc%89").replace(/\…/g,"%e2%80%a6%e2%80%a6");
								 var fileExtensionName=attName.substring(0,attName.lastIndexOf("."));
								 var deUrl = dataAttach[i].attUrl.split('&ATTACHMENT_NAME=')[0]+"&ATTACHMENT_NAME="+fileExtensionName+"."+fileExtension+"&FILESIZE="+dataAttach[i].size;
								 str += '<div class="dech" deUrl="' + deUrl+ '"><a href="/download?'+encodeURI(deUrl)+'" NAME="' + dataAttach[i].attachName + '*" style="text-decoration:none;margin-left:5px;"><img  src="/img/attachment_icon.png"/>' + dataAttach[i].attachName + '</a><img class="deImgs" style="margin-left:5px;cursor: pointer;" src="/img/file/icon_deletecha_03.png"/><a fileExtension="'+fileExtension+'" onclick="pdurls($(this))"   href="javascript:;"  style="padding-left: 5px"><img src="/img/attachmentIcon/icon_skim.png" style="padding: 0 5px;"><fmt:message code="document.th.ReferTo" /></a><a style="padding-left: 5px" href="/download?'+encodeURI(deUrl)+'" ><img src="/img/attachmentIcon/icon_down.png"  style="padding: 0 5px;"><fmt:message code="file.th.download" /></a><input type="hidden" class="inHidden" value="' + dataAttach[i].aid + '@' + dataAttach[i].ym + '_' + dataAttach[i].attachId + ',"></div>';
							 }
						 }
						 $('.Attachment td').eq(1).append(str);

						 var str1 = '<link rel="stylesheet" type="text/css" href="/css/workflow/m_reset.css">' +
								 '<link rel="stylesheet" type="text/css" href="../../css/workflow/work/new_work.css">' +
								 '<link rel="stylesheet" type="text/css" href="../../css/workflow/work/bootstrap.css">' +
								 '<link rel="stylesheet" type="text/css" href="../../lib/laydate.css"/>' +
								 '<link rel="stylesheet" type="text/css" href="../../css/workflow/work/handle.css"/>' +
								 '<link rel="stylesheet" type="text/css" href="/css/dept/roleAuthorization.css?20210311.1"/>' +
								 '<link rel="stylesheet" href="/css/workflow/work/workFormPreView.css?20191210.1"><style>.cont_form{height: auto;}</style><br><br>';
						 var str = '';
						 if(flow_view_str.indexOf('1') > -1){
							 $(".cont_form script",window.opener.document).remove();
							 str += window.top.opener.document.getElementById("a2").outerHTML;
						 }
						 if(flow_view_str.indexOf('2') > -1){
							 str += window.top.opener.document.getElementById("files").outerHTML;
						 }
						 if(flow_view_str.indexOf('3') > -1){
							 str += window.top.opener.document.getElementById("Opinion").outerHTML;
						 }
						 if(flow_view_str.indexOf('4') > -1){
							 str += window.top.opener.document.getElementById("process").outerHTML;
						 }
						 ue.setContent(str1+'<div class="content" style="margin-top:0px;"><div class="cont" style="background: #fff" id="client">'+str+'</div></div>', true);
					 }
				 })

                 $(document).on('delegate','.clearBCC','click',function(){
                     $('#secritText').attr('username','');
                     $('#secritText').attr('dataid','');
                     $('#secritText').attr('user_id','');
                     $('#secritText').attr('userprivname','');
                     $('#secritText').val('');
                 })
                 $(document).on('delegate','.clearCC','click',function(){
                     $('#copeNameText').attr('username','');
                     $('#copeNameText').attr('dataid','');
                     $('#copeNameText').attr('user_id','');
                     $('#copeNameText').attr('userprivname','');
                     $('#copeNameText').val('');
                 })
                 //选人控件
       		 	$("#selectUser").on("click",function(){
       		 		user_id='senduser';
                    $.ajax({
                        url:'/imfriends/getIsFriends',
                        type:'get',
                        dataType:'json',
                        data:{},
                        success:function(obj){
                            if(obj.object == 1){
                                $.popWindow("../common/selectUserIMAddGroup");
                            }else{
                                $.popWindow("../common/selectUser");
                            }
                        },
                        error:function(res){
                            $.popWindow("../common/selectUser");
                        }
                    })
       		 	});
				 $('.TABLE').on('click','#selectUserO',function(){
					 user_id='copeNameText';
                     $.ajax({
                         url:'/imfriends/getIsFriends',
                         type:'get',
                         dataType:'json',
                         data:{},
                         success:function(obj){
                             if(obj.object == 1){
                                 $.popWindow("../common/selectUserIMAddGroup");
                             }else{
                                 $.popWindow("../common/selectUser");
                             }
                         },
                         error:function(res){
                             $.popWindow("../common/selectUser");
                         }
                     })
				 })
                 $('.TABLE').on('click','#selectUserT',function(){
					 user_id='secritText';
                     $.ajax({
                         url:'/imfriends/getIsFriends',
                         type:'get',
                         dataType:'json',
                         data:{},
                         success:function(obj){
                             if(obj.object == 1){
                                 $.popWindow("../common/selectUserIMAddGroup");
                             }else{
                                 $.popWindow("../common/selectUser");
                             }
                         },
                         error:function(res){
                             $.popWindow("../common/selectUser");
                         }
                     })
                 })

                 //附件删除
                 $('#files_txt').on('click','.deImgs',function(){
                     var data=$(this).parents('.dech').attr('deUrl');
                     var dome=$(this).parents('.dech');
                     deleteChatment(data,dome);
                 })

       		 	//点击立即发送按钮
       		 	$(".sureBtn").on("click",function(){
					if (fileSizes != undefined) {
						var fileSizes1 = fileSizes.filter(function (item) {
							return item.size > attachmentSize
						})
						if (attachmentSize != 0) {
							if (fileSizes1.length > 0) {
								layer.msg("<fmt:message code="email.th.fileSize" />" + attachmentSize / 1024 / 1024 + "M", {icon: 2})
								return
							}
						}
					}

					var remindVal = 0;
					if ($('.remindCheck').is(":checked")) {
						remindVal = 1;
					}
					var smsDefault = 1;
					if ($('.smsDefault').is(":checked")) {
						smsDefault = 0;
					}
					var dataId1 = $('.inPole').find('#senduser').attr('user_id');
					var dataId2 = $('.tian').find('#copeNameText').attr('user_id');
					var dataId3 = $('.mis').find('#secritText').attr('user_id');

					var userId = $('textarea[name="txt"]').attr('user_id');
					var txt = ue.getContentTxt();
					var html = ue.getContent();
					// alert(html)
//					var val=$('#txt').val();
					var attach = $('.Attachment td').eq(1).find('a');
					var aId = '';
					var uId = '';
					for (var i = 0; i < $('.Attachment td .inHidden').length; i++) {
						aId += $('.Attachment td .inHidden').eq(i).val();
					}
					for (var i = 0; i < $('.Attachment td .inHidden').length; i++) {
						uId += $('.Attachment td .inHidden').eq(i).parent().find('a').eq(0).attr('NAME');
					}
					<%--if(val == ''){--%>
					<%--val='【<fmt:message code="email.th.noSubject" />】';/*无主题*/--%>
					<%--}--%>
					<%--if($.trim(val).length == 0){--%>
					<%--val='【<fmt:message code="email.th.noSubject" />】';/*无主题*/--%>
					<%--}--%>
					var data = {
						toId2: dataId1,
						copyToId: dataId2,
						secretToId: dataId3,
						toWebmail: '',
						fromWebmail: '',
						subject: $('#txt').val(),
						content: html,
						attachmentId: aId,
						attachmentName: uId,
						remind: remindVal,//事务提醒
						smsDefault: smsDefault //手机提醒
					};
					if ($('.a3').attr('a3type') == '1') {
						data.toWebmail = $('#outEmail').val();
						data.fromWebmail = $('#outSelect option:selected').val();
					} else {
						if (data.toId2 == '') {
							layer.msg('<fmt:message code="email.th.pleaseFillInTheRecipient" />！', {icon: 6});/*请输入收件人*/
							return;
						}
						data.toWebmail = '';
						data.fromWebmail = '';
					}
					if ($('.barText').html() != '' && $('.barText').html() != "100%") {
						layer.msg('<fmt:message code="email.th.attachmentUploaded" />！', {icon: 2});
						return false;
					}

					layer.load(0, {shade: [0.2, '#ffffff']});
					$.ajax({
						type: 'post',
						url: 'sendEmail',
						dataType: 'json',
						data: data,
						success: function (rsp) {
							if (rsp.flag == true) {
								if (rsp.msg == 'needAdmin') {
									$.layerMsg({content: '<fmt:message code="email.th.pleaseSetUpTheApprovers" />！', icon: 1}, function () {
										layer.closeAll();
									});

								} else {
									$.layerMsg({
										content: '<fmt:message code="global.lang.send" />！',
										icon: 1
									}, function () {
										if (uid != '') {
											layer.closeAll();
											location.reload();
										} else {
											if (userId != null || userName != null) {
												window.close();
											}
											parent.location.reload();
										}
									});
								}
							} else {
								$.layerMsg({content: '<fmt:message code="global.lang.err" />！', icon: 2}, function () {

								});
							}
//							 layer.closeAll();
						}
					});
				});

				//点击保存到草稿箱按钮
				$(".saveBtn").on("click",function(){
					if (fileSizes != undefined) {
						var fileSizes1 = fileSizes.filter(function (item) {
							return item.size > attachmentSize
						})
						if (attachmentSize != 0) {
							if (fileSizes1.length > 0) {
								layer.msg("<fmt:message code="email.th.fileSize" />" + attachmentSize / 1024 / 1024 + "M", {icon: 2})
								return
							}
						}
					}
                    var dataId1=$('.inPole').find('#senduser').attr('user_id');
                    var dataId2=$('.tian').find('#copeNameText').attr('user_id');
                    var dataId3=$('.mis').find('#secritText').attr('user_id');
					var userId=$('textarea[name="txt"]').attr('user_id');
					var txt = ue.getContentTxt();
					var html = ue.getContent();
//					var val=$('#txt').val();
// 					var attach=$('.Attachment td').eq(1).find('.dech a');
					var aId='';
					var uId='';
					for(var i=0;i<$('.Attachment td .inHidden').length;i++){
						aId += $('.Attachment td .inHidden').eq(i).val();
					}
					for(var i=0;i<$('.Attachment td .inHidden').length;i++){
						uId += $('.Attachment td .inHidden').eq(i).parent(".dech").find("a").eq(0).attr('name');
					}
                    if($('.barText').html() != '' && $('.barText').html()!="100%"){
                        layer.msg('<fmt:message code="email.th.attachmentUploaded" />！',{icon:2});
                        return false;
                    }
					<%--if(dataId1 == '' && html == '' && val == '' && aId == '' && uId == ''){--%>
                        <%--val='<fmt:message code="email.th.noSubject" />';/*无主题*/--%>
					<%--}--%>

					var data={
						toWebmail:'',
						fromWebmail:'',
                        'toId2': dataId1,
                        'copyToId':dataId2,
                        'secretToId':dataId3,
						'subject':$('#txt').val(),
						'content':html,
						'attachmentId':aId,
						'attachmentName':uId
					};
					if($('.a3').attr('a3type') == '1'){
						data.toWebmail=$('#outEmail').val();
						data.fromWebmail=$('#outSelect option:selected').val();
					}else{
						if(data.toId2==''){
							layer.msg('<fmt:message code="email.th.pleaseFillInTheRecipient" />！',{ icon:6});/*请输入收件人*/
							return;
						}
						data.toWebmail='';
						data.fromWebmail='';
					}
					$.ajax({
						 type:'post',
						 url:'saveEmail',
						 dataType:'json',
						 data:data,
						 success:function(){
                             $.layerMsg({content:'<fmt:message code="diary.th.modify" />！',icon:1},function(){
                                 parent.location.reload();
							 });
						}
					});
				});

                 //删除附件
				 function deleteChatment(data,element){

					 layer.confirm('<fmt:message code="workflow.th.que" />？', {
						 btn: ['<fmt:message code="global.lang.ok" />','<fmt:message code="depatement.th.quxiao" />'], //按钮
						 title:"<fmt:message code="notice.th.DeleteAttachment" />"
					 }, function(){
						 //确定删除，调接口
						 $.ajax({
							 type:'post',
							 url:'../delete',
							 dataType:'json',
							 data:data,
							 success:function(res){

								 if(res.flag == true){
									 layer.msg('<fmt:message code="workflow.th.delsucess" />', { icon:6});
//                                     var file = $('[name="file"]')
//                                     file.after(file.clone().val(""));
//                                     file.remove();
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

       		 });

       		//清空UE内容
       		function empty(){
       			ue.setContent('');
       		}
       		$(function(){
                //添加常联系人员
                $('.choose ').on('click',function (e){
//                    $("#attention").show();
                    e.stopPropagation();
                    $("#attention").toggle();
                    $.ajax({
                        type:'post',
                        url:'/contactPerson/serchContactPerson',
                        dataType:'json',
                        success:function(json){
                            var arr=json.obj;
                            var str='';
                            for(var i=0;i<arr.length;i++){
								if(arr[i]!=null)
                                	str+='<li dataid="'+arr[i].uid+'" user_id="'+arr[i].userId+'">'+arr[i].userName+'</li>';
                            }
                            $('#attention').html(str);
                        }
                    });
                });
                var userName=[];
                var userIds=[];
                $('#attention').on('click','li',function(){
                    var uName=$(this).text();
                    var uId=$(this).attr('user_id');
                    userName.push(uName);
                    userIds.push(uId);
                    function unique(arr){
                        var res =[];
                        var json = {};
                        for(var i=0;i<arr.length;i++){
                            if(!json[arr[i]]){
                                res.push(arr[i]);
                                json[arr[i]] = 1;
                            }
                        }
                        return res;
                    }
                    var d = unique(userName);
                    var f = unique(userIds);
                    $('#senduser').val(d);
                    $('#senduser').attr('user_id',f);
                });

//                $('#attention'). mouseleave(function (){
//                    $("#attention").hide();
//                });
                $(document).on('click',function(){
                    if ($('#attention').css('display')=='block'){
                        $('#attention').css('display','none');
                    }
                })
			})
            function wordimport(key){
                var me=this;
				$("#wordimportfile").trigger('click');
            }

            $('#wordimportfile').fileupload({
                dataType:'json',
                done: function (e, data) {
					console.log(data)
                    if(data.result.obj != ''){
                        var data = data.result.obj;
                        var str = '';
                        var str1 = '';

                        for (var i = 0; i < data.length; i++) {
                            var gs = data[i].attachName.split('.')[1];
                            if(gs == 'jsp'||gs == 'css'||gs == 'js'||gs == 'html'||gs == 'java'||gs == 'php'||gs == 'xls'||gs == 'xlsx' ){
                                str += '';
                                layer.alert('<fmt:message code="dem.th.uploading" />!',{},function(){
                                    layer.closeAll();
                                });
                            }else{
                                str+='<div class="dech" deUrl="'+encodeURI(data[i].attUrl)+'" style="display:block;"><a class="ATTACH_a" NAME="'+data[i].attachName+'*" href="/download?'+encodeURI(data[i].attUrl)+'">'+data[i].attachName+'</a><img class="deImgs" style="margin-left:5px;cursor: pointer;" src="../img/file/icon_deletecha_03.png"/><input type="hidden" NAME="'+data[i].attachName+'*"  class="inHidden" value="'+data[i].aid+'@'+data[i].ym+'_'+data[i].attachId+',"></div>';
                            }
                            <%--if(gs != 'doc' ){--%>
                                <%--str += '';--%>
                                <%--layer.alert('jsp、css、js、html、java文件禁止上传!',{},function(){--%>
                                    <%--layer.closeAll();--%>
                                <%--});--%>
                            <%--}else{--%>
                                <%--str+='<div class="dech" deUrl="'+encodeURI(data[i].attUrl)+'" style="display:block;"><a class="ATTACH_a" NAME="'+data[i].attachName+'*" href="/download?'+encodeURI(data[i].attUrl)+'">'+data[i].attachName+'</a><img class="deImgs" style="margin-left:5px;cursor: pointer;" src="../img/file/icon_deletecha_03.png"/><input type="hidden" NAME="'+data[i].attachName+'*"  class="inHidden" value="'+data[i].aid+'@'+data[i].ym+'_'+data[i].attachId+',"></div>';--%>
                            <%--}--%>
                        }
                        // $('#query_uploadArr').append(str);
                        // $('#query_uploadArr').val();
                    } else{
                        //alert('添加附件大小不能为空!');
                        layer.alert('<fmt:message code="dem.th.AddEmpty" />!',{},function(){
                            layer.closeAll();
                        });
                    }
                }
            });
            function asyncUploadFile() {
                // $("#loadingModal").modal('show');
                $("#loadingModal").modal({backdrop: 'static', keyboard: false});
                var formData = new FormData($('#wordimportform')[0]);
                $("#wordimportfile").val('');
                $.ajax({
                    url:'/ueditor/wordToHtml?module=ueditor',
                    type:'POST',
                    data:formData,
                    dataType:'text',
                    cache: false,
                    processData: false,
                    contentType: false,
                    success:function (result) {
                        var obj=  JSON.parse(result);
						var valuecontent=obj.htmlContent;
                        ue.execCommand('insertHtml', valuecontent);
                        $("#loadingModal").modal('hide');
                    },
                    error:function (error) {
                        console.log(error);
                        $("#loadingModal").modal('hide');
                    }

                });
            }
    	</script>
	</body>
</html>

