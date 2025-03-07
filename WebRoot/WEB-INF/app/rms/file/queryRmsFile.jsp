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
	<title><fmt:message code="dem.th.FileQuery" /></title>
	<link rel="stylesheet" type="text/css" href="../lib/laydate.css"/>
	<link rel="stylesheet" type="text/css" href="../lib/pagination/style/pagination.css"/>
	<link rel="stylesheet" type="text/css" href="../css/base.css"/>
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
	<script src="../js/rms/queryRmsFile.js?20230427.2"></script>
	<style>
		input{
			float: none;
		}
		.queryMange input[type="text"],.newMange input[type="text"]{
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
			width: 100%;
			/*margin: 0px auto;*/
			float: right;
			margin-bottom: 20px;
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
		.saveBtn_s{
			 display: block;
			 float: left;
			 background: url(../img/icon_query_2.png) no-repeat;
			 border: none;
			 width: 70px;
			 height: 29px;
			 line-height: 29px;
			 margin-left: 10px;
			 cursor: pointer;
		 }
		.resetBtn_s{
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
		.saveBtn{
			display: block;
			float: left;
			background: url(../img/icon_query_2.png) no-repeat;
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
		.buttonDiv{
			width: 100%;
			margin-top: 50px;
		}
		.buttonDiv>div{
			float: left;
			margin: 20px 10px;
		}
		.buttonDiv .deleteBtn{
			float: left;
			width: 99px;
			height: 28px;
			/*margin: 20px auto;*/
			background: url("../img/btn_deletecontent_03.png") no-repeat;
			line-height: 28px;
			cursor: pointer;
		}
		.buttonDiv .exportDiv{
			float: left;
			width: 99px;
			height: 28px;
			/*margin: 20px auto;*/
			background: url("../img/icon_daoru.png") no-repeat;
			line-height: 28px;
			cursor: pointer;
		}
		.backDiv{
			width: 100%;
		}
		 .backBtn{
			width: 70px;
			height: 28px;
			margin: 20px auto;
			background: url("../img/icon_backing.png") no-repeat;
			line-height: 28px;
			cursor: pointer;
		}
		#tr_td tr:nth-child(odd){
			background-color: #fff;
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
	<div class="navigation  clearfix queryMange" id="queryMange" style="display: block;">
		<div class="left" style="margin-left: 30px;width: 40%;">
			<img src="/img/commonTheme/${sessionScope.InterfaceModel}/icon_queryFile.png" style="margin-top: 17px">
			<div class="news">
				<fmt:message code="dem.th.FileQuery" />
			</div>
		</div>
		<div class="wrap" style="margin-left: 0;padding: 0 20px;margin-top: 60px">
			<table class="newTbale">
				<tr>
					<td><fmt:message code="dem.th.FileNum" />：</td>
					<td>
						<input type="text" name="fileCode_s" value="">
					</td>
					<td><fmt:message code="dem.th.DocumentWords" />：</td>
					<td>
						<input type="text" name="fileSubject_s" value="">
					</td>
				</tr>
				<tr>
					<td><fmt:message code="dem.th.FileTitle" />：</td>
					<td>
						<input type="text" name="fileTitle_s" value="">
					</td>
					<td><fmt:message code="dem.th.Supplemented" />：</td>
					<td><input type="text" name="fileTitle0_s" value=""></td>
				</tr>
				<tr>
					<td><fmt:message code="doc.th.DispatchUnit" />：</td>
					<td>
						<input type="text" name="sendUnit_s" value="">
					</td>
					<td><fmt:message code="dem.th.DateWriting" />：</td>
					<td><input type="text" name="sendDate_s" value="" style="width: 120px;"><span style="margin: 0 5px;">-</span><input type="text" name="sendDate2" value="" style="width: 120px;"></td>
				</tr>
				<tr>
					<td><fmt:message code="dem.th.CoilingLibrary" />：</td>
					<td>
						<select name="roomId_s" id="roomId_s">
							<option value=""><fmt:message code="vote.th.Librarys" /></option>
						</select>
					</td>
					<td><fmt:message code="dem.th.FilesThem" />：</td>
					<td>
						<select name="rollId_s" id="rollId_s">
							<option value=""><fmt:message code="vote.th.Librarys" /></option>
						</select>
					</td>
				</tr>
				<tr>
					<td><fmt:message code="dem.th.Dense" />：</td>
					<td>
						<select name="secret_s" id="secret_s">
							<option value=""><fmt:message code="dem.th.PleaseSecret" /></option>
							<option value="1"><fmt:message code="dem.th.PuDense" /></option>
							<option value="4"><fmt:message code="dem.th.Secret" /></option>
							<option value="3"><fmt:message code="dem.th.Confidential" /></option>
							<option value="2"><fmt:message code="doc.th.Top-secret" /></option>
						</select>
					</td>
					<td><fmt:message code="dem.th.EmergencyGrade" />：</td>
					<td>
						<select name="urgency_s" id="urgency_s">
							<option value=""><fmt:message code="dem.th.Emergency" /></option>
							<option value="1"><fmt:message code="hr.th.EmployeeType" /></option>
							<option value="2"><fmt:message code="dem.th.GeneralLevel" /></option>
						</select>
					</td>
				</tr>
				<tr>
					<td><fmt:message code="dem.th.FileClassification" />：</td>
					<td>
						<select name="fileType_s" id="fileType_s">
							<option value=""><fmt:message code="dem.th.SelectClassification" /></option>
							<option value="1"><fmt:message code="email.th.document" /></option>
							<option value="2"><fmt:message code="userDatails.th.data" /></option>
						</select>
					</td>
					<td><fmt:message code="dem.thDocumentCategory" />：</td>
					<td>
						<select name="fileKind_s" id="fileKind_s">
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
					<td><input type="text" name="filePage_s" value="" style="width: 120px;"><span style="margin: 0 5px;">-</span><input type="text" name="filePage2" value="" style="width: 120px;"></td>
					<td><fmt:message code="dem.th.Print" />：</td>
					<td><input type="text" name="printPage_s" value="" style="width: 120px;"><span style="margin: 0 5px;">-</span><input type="text" name="printPage2" value="" style="width: 120px;"></td>
				</tr>
				<tr>
					<td><fmt:message code="journal.th.Remarks" />：</td>
					<td colspan="3"><input type="text" name="remark_s" value="" style="width: 500px;"></td>
				</tr>
			</table>
			<div class="buttonDivs">
				<div class="divBtn">
					<div class="saveBtn_s"><span style="margin-left: 32px;"><fmt:message code="global.lang.query" /></span></div>
					<div class="resetBtn_s"><span style="margin-left: 32px;"><fmt:message code="workflow.th.Reset" /></span></div>
				</div>
			</div>
		</div>
	</div>

	<div class="navigation  clearfix juMange" id="juMange" style="display: none;">
		<div class="left" style="margin-left: 30px;width: 40%;">
			<img src="/img/commonTheme/${sessionScope.InterfaceModel}/icon_queryFile.png" style="margin-top: 17px">
			<div class="news">
				<fmt:message code="dem.th.FileQuery" />
			</div>
		</div>
		<div class="wrap" style="margin-left: 0;padding: 0 20px;margin-top: 60px">
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
						<fmt:message code="notice.th.operation" />
					</td>
				</tr>
				</thead>
				<tbody id="j_tb">

				</tbody>
			</table>
			<div class="right">
				<!-- 分页按钮-->
				<div class="M-box3" id="dbgz_page">
				</div>

			</div>
			<div class="buttonDiv">
				<div class="fileDone">
					<span style="font-size: 15px;font-weight: bold;color: #2f5c8f;"><fmt:message code="dem.th.FileOperation" />：</span>
					<span><fmt:message code="dem.th.Group" />：</span>
					<select name="rollIdSelect" id="rollIdSelect">
						<option value=""><fmt:message code="dem.th.File" /></option>
					</select>
				</div>
				<div class="deleteBtn"><span style="margin-left: 36px;"><fmt:message code="dem.th.BatchDestruction" /></span></div>
				<div class="exportDiv"><span style="margin-left: 36px;"><fmt:message code="dem.th.FileImport" /></span></div>
				<%--<div class="backDiv" >--%>
					<div class="backBtn"><span style="margin-left: 36px;"><fmt:message code="notice.th.return" /></span></div>
				<%--</div>--%>
				</div>
		</div>
		<div style="clear: both;"></div>
		<%--<div class="backDiv">--%>
			<%--<div class="backBtn"><span style="margin-left: 36px;"><fmt:message code="notice.th.return" /></span></div>--%>
		<%--</div>--%>
	</div>


	<div class="navigation  clearfix newMange" id="newMange" style="display: none;">
		<div class="left" style="margin-left: 30px;width: 40%;">
			<img src="/img/rms/icon_editFile.png" style="margin-top: 17px">
			<div class="news">
				<fmt:message code="dem.th.Edit" />
			</div>
		</div>
		<div class="wrap" style="margin-left: 0;padding: 0 20px;margin-top: 60px">
			<form id="form1" action="/rmsFile/update">
				<input type="hidden" value="" name="fileId">
				<input type="hidden" value="" name="attachmentId">
				<input type="hidden" value="" name="attachmentName">
				<table class="newTbale" style="width: 80%;">
					<tr>
						<td><fmt:message code="dem.th.FileNum" />：</td>
						<td>
							<input type="text" name="fileCode" value="">
							<img class="td_title2" src="../img/mg2.png" style="margin-top: 10px;margin-left: 5px;" alt="必填">
						</td>
						<td><fmt:message code="dem.th.DocumentWords" />：</td>
						<td>
							<input type="text" name="fileSubject" value="">
							<img class="td_title2" src="../img/mg2.png" style="margin-top: 10px;margin-left: 5px;" alt="必填">
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
			<table class="newTbale" style="margin-top: 0;width: 80%;">
				<tr style="border-top: 0;">
					<td style="width: 180px;"><fmt:message code="email.th.filechose" />：</td>
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
<script type="text/javascript">
	$(function(){
//	    导入文件
        $('.exportDiv').on('click',function(){
            $('.iframeShow').show().siblings().hide();
        })
        queryAllAnjuan($('#roomId_s'));
//        查询所有案卷
        queryRollid($('#rollId_s'));
        queryRollid($('#rollIdSelect'));


		$('.backBtn').on('click',function(){
            $('.queryMange').show().siblings().hide();
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
                            str += '<div class="dech" deUrl="' + encodeURI(data[i].attUrl)+ '"><a href="/download?'+encodeURI(data[i].attUrl)+'" NAME="' + data[i].attachName + '*"><img style="margin-right:10px;" src="../img/attachment_icon.png"/>' + data[i].attachName + '</a><img class="deImgs" style="margin-left:5px;cursor: pointer;" src="../img/file/icon_deletecha_03.png"/><input type="hidden" class="inHidden" value="' + data[i].aid + '@' + data[i].ym + '_' + data[i].attachId + ',"></div>';
                        }
                    }
                    $('.attachNameDiv').append(str);
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
        $('#j_tb').on('click','.to_detail',function(){
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
                    if(datas.download == 1){
                        $('#downLoadata').prop('checked',true);
                    }else{
                        $('#downLoadata').prop('checked',false);
                    }
                    $('input[name="print"]').val(datas.print);
                    if(datas.print == 1){
                        $('#daying').prop('checked',true);
                    }else{
                        $('#daying').prop('checked',false);
                    }

                    var arrAttach=datas.attachmentList;
                    var str='';
                    for(var i=0;i<arrAttach.length;i++){
                        str += '<div class="dech" deUrl="' + encodeURI(arrAttach[i].attUrl)+ '"><a href="/download?'+encodeURI(arrAttach[i].attUrl)+'" NAME="' + arrAttach[i].attachName + '*"><img style="margin-right:10px;" src="../img/attachment_icon.png"/>' + arrAttach[i].attachName + '</a><img class="deImgs" style="margin-left:5px;cursor: pointer;" src="../img/file/icon_deletecha_03.png"/><input type="hidden" class="inHidden" value="' + arrAttach[i].aid + '@' + arrAttach[i].ym + '_' + arrAttach[i].attachId + ',"></div>';
                    }
                    $('.attachNameDiv').html(str);
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
    };

    function deleteChatment(data,element){

        layer.confirm('<fmt:message code="workflow.th.que" />？', {
            btn: ['<fmt:message code="global.lang.ok" />','<fmt:message code="depatement.th.quxiao" />'], //按钮
            title:"<fmt:message code="notice.th.DeleteAttachment" />"
        }, function(){
            //确定删除，调接口
            $.ajax({
                type:'get',
                url:'../delete',
                dataType:'json',
                data:data,
                success:function(res){

                    if(res.flag == true){
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
//    查询所有案卷
	function queryRollid(element){
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
                element.append(str);
            }
        })
	}
</script>
</body>
</html>
