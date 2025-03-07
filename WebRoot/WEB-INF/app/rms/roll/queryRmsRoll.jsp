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
	<title><fmt:message code="vote.th.FileQuery" /></title>
	<link rel="stylesheet" type="text/css" href="../lib/laydate.css"/>
	<link rel="stylesheet" type="text/css" href="../lib/pagination/style/pagination.css"/>
	<link rel="stylesheet" type="text/css" href="../css/base.css"/>
<%--	<script type="text/javascript" src="../js/xoajq/xoajq1.js"></script>--%>
	<script type="text/javascript" src="/js/xoajq/xoajq3.js"></script>
	<script type="text/javascript" src="/js/jquery/jquery-migrate-3.4.0.js"></script>
	<script src="../js/news/page.js"></script>
	<script src="../lib/laydate/laydate.js"></script>
	<script src="../js/base/base.js" type="text/javascript" charset="utf-8"></script>
	<script src="../lib/pagination/js/jquery.pagination.min.js" type="text/javascript" charset="utf-8"></script>
	<script src="../lib/layer/layer.js?20201106"></script>
	<script type="text/javascript" src="/js/jquery/jquery.form.min.js"></script>
	<script src="../js/rms/queryRms.js?20230427.1"></script>
	<style>
		a {
			text-decoration: none;
			color: #207bd6;
		}
		.buttonDiv{
			width: 100%;
		}
		.buttonDiv .deleteBtn{
			width: 99px;
			height: 28px;
			margin: 20px auto;
			background: url("../img/icon_backing.png") no-repeat;
			line-height: 28px;
			cursor: pointer;
		}
		#selectq{
			margin-left: 10px;
			width: 120px;
			outline: none;
			border-radius:4px;
		}
		.juMange input[type="text"],.editMange input[type="text"]{
			width: 260px;
			height: 30px;
			float: none;
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
			width: 85%;
			margin: 0px auto;
			margin-top: 70px;
		}
		.newTbale tr td{
			border-right: #ccc 1px solid;
			padding: 5px;
		}
		.buttonDiv{
			width: 100%;
			margin-top: 20px;
		}
		.divBtn{
			width: 170px;
			margin: 0 auto;
			height: 30px;
		}
		.saveBtn_s,.saveBtn{
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
		.resetBtn_s,.resetBtn{
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
	<div class="navigation  clearfix juMange" style="display: block;">
		<div class="left" style="margin-left: 30px;width: 40%;">
			<img src="/img/commonTheme/${sessionScope.InterfaceModel}/icon_queryRoll.png" style="margin-top: 17px;">
			<div class="news">
				<fmt:message code="vote.th.FileQuery" />
			</div>
		</div>
		<div class="wrap" style="margin-left: 0;padding: 0 20px;">
				<table class="newTbale">
					<tr>
						<td><fmt:message code="dem.th.FileNumber" />：</td>
						<td>
							<input type="text" name="rollCode_s">
						</td>
						<td><fmt:message code="dem.th.FileName" />：</td>
						<td>
							<input type="text" name="rollName_s">
						</td>
					</tr>
					<tr>
						<td><fmt:message code="dem.th.CoilingLibrary" />：</td>
						<td>
							<select name="roomId_s" id="roomId_s">
								<option value=""><fmt:message code="vote.th.Librarys" /></option>
							</select>
						</td>
						<td><fmt:message code="dem.th.Rewinding" />：</td>
						<td><input type="text" name="years_s"></td>
					</tr>
					<tr>
						<td><fmt:message code="sms.th.StartDate" />：</td>
						<td><input type="text" name="beginDate_s" style="width: 130px;" onclick="laydate(starts)"><span style="margin: 0 5px;">-</span><input type="text" name="beginDate2" style="width: 130px;" onclick="laydate(starts)"></td>
						<td><fmt:message code="notice.th.endDate" />：</td>
						<td><input type="text" name="endDate_s" style="width: 130px;" onclick="laydate(starts)"><span style="margin: 0 5px;">-</span><input type="text" name="endDate2" style="width: 130px;" onclick="laydate(starts)"></td>
					</tr>
					<tr>
						<td><fmt:message code="dem.th.TimeLimit" />：</td>
						<td><input type="text" name="deadline_s" style="width: 120px;"><span style="margin: 0 5px;">-</span><input type="text" name="deadline2" style="width: 120px;"></td>
						<td><fmt:message code="dem.th.FileSecurity" />：</td>
						<td>
							<select name="secret_s" id="secret_s">
								<option value=""><fmt:message code="dem.th.PleaseSecret" /></option>
								<option value="1"><fmt:message code="dem.th.PuDense" /></option>
								<option value="4"><fmt:message code="dem.th.Secret" /></option>
								<option value="3"><fmt:message code="dem.th.Confidential" /></option>
								<option value="2"><fmt:message code="doc.th.Top-secret" /></option>
							</select>
						</td>
					</tr>
					<tr>
						<td><fmt:message code="dem.th.FondsNumber" />：</td>
						<td><input type="text" name="categoryNo_s"></td>
						<td><fmt:message code="dem.th.Directory" />：</td>
						<td><input type="text" name="catalogNo_s"></td>
					</tr>
					<tr>
						<td><fmt:message code="dem.th.ArchivesNumber" />：</td>
						<td><input type="text" name="archiveNo_s"></td>
						<td><fmt:message code="dem.th.InsuranceNumber" />：</td>
						<td><input type="text" name="boxNo_s"></td>
					</tr>
					<tr>
						<td><fmt:message code="dem.th.Microfilm" />：</td>
						<td><input type="text" name="microNo_s"></td>
						<td><fmt:message code="dem.th.CertificateCategory" />：</td>
						<td>
							<select name="certificateKind_s" id="certificateKind_s">
								<option value=""><fmt:message code="dem.th.Category" /></option>
								<option value="1">XXX1</option>
								<option value="2">XXX2</option>
							</select>
						</td>
					</tr>
					<tr>
						<td><fmt:message code="dem.th.Voucher(starting)" />：</td>
						<td><input type="text" name="certificateStart_s" style="width: 120px;"><span style="margin: 0 5px;">-</span><input type="text" name="certificateStart2" style="width: 120px;"></td>
						<td><fmt:message code="dem.th.Voucher(stop)" />：</td>
						<td><input type="text" name="certificateEnd_s" style="width: 120px;"><span style="margin: 0 5px;">-</span><input type="text" name="certificateEnd2" style="width: 120px;"></td>
					</tr>
					<tr>
						<td><fmt:message code="dem.th.pages" />：</td>
						<td><input type="text" name="rollPage_s" style="width: 120px;"><span style="margin: 0 5px;">-</span><input type="text" name="rollPage2" style="width: 120px;"></td>
						<td><fmt:message code="workflow.th.sector" />：</td>
						<td>
							<textarea name="deptId_s" id="deptId_s" dataid resize="auto"></textarea>
							<a href="javascript:;" class="checkOne_s" id="checkOne_s" style="margin: 0 10px;"><fmt:message code="global.lang.select" /></a>
							<a href="javascript:;" class="clearOne_s" id="clearOne_s"><fmt:message code="global.lang.empty" /></a>
						</td>
					</tr>
					<tr>
						<td><fmt:message code="journal.th.Remarks" />：</td>
						<td colspan="3"><input type="text" style="width: 400px;" name="remark_s"></td>
					</tr>
				</table>
			<div class="buttonDiv">
				<div class="divBtn">
					<div class="saveBtn_s"><span style="margin-left: 32px;"><fmt:message code="global.lang.query" /></span></div>
					<div class="resetBtn_s"><span style="margin-left: 32px;"><fmt:message code="workflow.th.Reset" /></span></div>
				</div>
			</div>
		</div>
	</div>

	<div class="navigation  clearfix dataMange" style="display: none;">
		<div class="left" style="margin-left: 30px">
			<img style="margin-top: 17px" src="/img/commonTheme/${sessionScope.InterfaceModel}/icon_queryRoll.png">
			<div class="news" style="margin-left: 33px;margin-top: 22px">
				<span><fmt:message code="vote.th.FileQuery" /></span>
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
						<fmt:message code="dem.th.FileNumber" />
					</td>
					<td class="th">
						<fmt:message code="dem.th.FileName" />
					</td>
					<td class="th">
						<fmt:message code="dem.th.CoilingLibrary" />
					</td>
					<td class="th">
						<fmt:message code="dem.th.FondsNumber" />
					</td>
					<td class="th">
						<fmt:message code="dem.th.CertificateCategory" />
					</td>
					<td class="th">
						<fmt:message code="dem.th.FileSecurity" />
					</td>
					<td class="th">
						<fmt:message code="vote.th.FileStatus" />
					</td>
					<td class="th" style="width: 220px;">
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
				<div class="deleteBtn"><span style="margin-left: 32px;"><fmt:message code="notice.th.return" /></span></div>
			</div>
		</div>
	</div>


	<div class="navigation  clearfix editMange" style="display: none;">
		<div class="left" style="margin-left: 30px">
			<img style="margin-top: 17px" src="/img/rms/icon_editRoll.png">
			<div class="news" style="margin-left: 33px;margin-top: 22px">
				<fmt:message code="dem.th.EditFile" />
			</div>
		</div>
		<div class="wrap" style="margin-left: 0;padding: 0 20px;margin-top: 70px">
			<form id="form1" action="/rmsRoll/update">
				<input type="hidden" name="rollId" value="">
				<table class="newTbale">
					<tr>
						<td><fmt:message code="dem.th.FileNumber" />：</td>
						<td>
							<input type="text" name="rollCode">
							<img class="td_title2" src="../img/mg2.png" style="margin-top: 10px;margin-left: 5px;" alt="必填">
						</td>
						<td><fmt:message code="dem.th.FileName" />：</td>
						<td>
							<input type="text" name="rollName">
							<img class="td_title2" src="../img/mg2.png" style="margin-top: 10px;margin-left: 5px;" alt="必填">
						</td>
					</tr>
					<tr>
						<td><fmt:message code="dem.th.CoilingLibrary" />：</td>
						<td>
							<select name="roomId" id="roomId">
								<option value=""><fmt:message code="vote.th.Librarys" /></option>
							</select>
							<%--<img class="td_title2" src="../img/mg2.png" alt="必填">--%>
						</td>
						<td><fmt:message code="dem.th.Rewinding" />：</td>
						<td><input type="text" name="years"></td>
					</tr>
					<tr>
						<td><fmt:message code="sms.th.StartDate" />：</td>
						<td><input type="text" name="beginDate" id="beginDate"></td>
						<td><fmt:message code="notice.th.endDate" />：</td>
						<td><input type="text" name="endDate" id="endDate"></td>
					</tr>
					<tr>
						<td><fmt:message code="workflow.th.sector" />：</td>
						<td>
							<textarea name="deptIds" id="deptId" dataid resize="auto"></textarea>
							<input type="hidden" name="deptId" value="">
							<img class="td_title2" src="../img/mg2.png" alt="必填">
							<a href="javascript:;" class="checkOne" id="checkOne" style="margin: 0 10px;"><fmt:message code="global.lang.select" /></a>
							<a href="javascript:;" class="clearOne" id="clearOne"><fmt:message code="global.lang.empty" /></a>
						</td>
						<td><fmt:message code="dem.th.EstablishmentOrganization" />：</td>
						<td><input type="text" name="editDept"></td>
					</tr>
					<tr>
						<td><fmt:message code="dem.th.TimeLimit" />：</td>
						<td><input type="text" name="deadline"></td>
						<td><fmt:message code="dem.th.FileSecurity" />：</td>
						<td>
							<select name="secret" id="secret">
								<option value=""><fmt:message code="dem.th.PleaseSecret" /></option>
								<option value="1"><fmt:message code="dem.th.PuDense" /></option>
								<option value="4"><fmt:message code="doc.th.Secret" /></option>
								<option value="3"><fmt:message code="dem.th.Confidential" /></option>
								<option value="2"><fmt:message code="doc.th.Top-secret" /></option>
							</select>
							<img class="td_title2" src="../img/mg2.png" alt="必填">
						</td>
					</tr>
					<tr>
						<td><fmt:message code="dem.th.FondsNumber" />：</td>
						<td><input type="text" name="categoryNo"></td>
						<td><fmt:message code="dem.th.Directory" />：</td>
						<td><input type="text" name="catalogNo"></td>
					</tr>
					<tr>
						<td><fmt:message code="dem.th.ArchivesNumber" />：</td>
						<td><input type="text" name="archiveNo"></td>
						<td><fmt:message code="dem.th.InsuranceNumber" />：</td>
						<td><input type="text" name="boxNo"></td>
					</tr>
					<tr>
						<td><fmt:message code="dem.th.Microfilm" />：</td>
						<td><input type="text" name="microNo"></td>
						<td><fmt:message code="dem.th.CertificateCategory" />：</td>
						<td>
							<select name="certificateKind" id="certificateKind">
								<option value=""><fmt:message code="dem.th.Category" /></option>
								<option value="1">XXX1</option>
								<option value="2">XXX2</option>
							</select>
						</td>
					</tr>
					<tr>
						<td><fmt:message code="dem.th.Voucher(starting)" />：</td>
						<td><input type="text" name="certificateStart"></td>
						<td><fmt:message code="dem.th.Voucher(stop)" />：</td>
						<td><input type="text" name="certificateEnd"></td>
					</tr>
					<tr>
						<td><fmt:message code="dem.th.pages" />：</td>
						<td><input type="text" name="rollPage"></td>
						<td><fmt:message code="journal.th.Remarks" />：</td>
						<td><input type="text" name="remark"></td>
					</tr>
					<tr>
						<td><fmt:message code="dem.th.filesStaff" />：</td>
						<td colspan="3">
							<textarea name="managers" id="textUser" dataid resize="auto"></textarea>
							<input type="hidden" name="manager" value="">
							<a href="javascript:;" id="checkTwo" style="margin: 0 10px"><fmt:message code="global.lang.select" /></a>
							<a href="javascript:;" id="clearBtn"><fmt:message code="global.lang.empty" /></a>
						</td>
					</tr>
				</table>
			</form>
			<div class="buttonDiv">
				<div class="divBtn">
					<div class="saveBtn"><span style="margin-left: 32px;"><fmt:message code="global.lang.save" /></span></div>
					<div class="resetBtn"><span style="margin-left: 32px;"><fmt:message code="notice.th.return" /></span></div>
				</div>
			</div>
		</div>
	</div>


</div>
<script type="text/javascript">
	$(function(){
        queryAllAnjuan($('#roomId_s'));
        $('#checkOne_s').on('click',function(){
            dept_id='deptId_s';
            $.popWindow("../common/selectDept?0");
        });
        $('#clearOne_s').on('click',function(){
            $('#deptId_s').attr('deptid','');
            $('#deptId_s').attr('deptname','');
            $('#deptId_s').attr('deptno','');
            $('#deptId_s').val('');
        });
        $('#checkTwo').on('click',function(){
            user_id='textUser';
            $.popWindow("../common/selectUser?0");
        });
        $('#checkOne').on('click',function(){
            dept_id='deptId';
            $.popWindow("../common/selectDept?0");
        });
        $('#clearBtn').on('click',function(){
            $('#textUser').attr('dataid','');
            $('#textUser').attr('username','');
            $('#textUser').attr('user_id','');
            $('#textUser').attr('userprivname','');
            $('#textUser').val('');
        });
        $('#clearOne').on('click',function(){
            $('#deptId').attr('deptid','');
            $('#deptId').attr('deptname','');
            $('#deptId').attr('deptno','');
            $('#deptId').val('');
        });
//	    重置
		$('.resetBtn_s').on('click',function(){
		    $('input[name="rollCode_s"]').val(''); //案卷号
		    $('input[name="rollName_s"]').val(''); //案卷名称
		    $('input[name="years_s"]').val(''); //归卷年代
		    $('input[name="beginDate_s"]').val(''); //起始日期
		    $('input[name="beginDate2"]').val(''); //起始日期
		    $('input[name="endDate_s"]').val(''); //终止日期
		    $('input[name="endDate2"]').val(''); //终止日期
		    $('input[name="deadline_s"]').val(''); //保管期限
		    $('input[name="deadline2"]').val(''); //保管期限
		    $('input[name="categoryNo_s"]').val(''); //全宗号
		    $('input[name="catalogNo_s"]').val(''); //目录号
		    $('input[name="archiveNo_s"]').val(''); //档案馆号
		    $('input[name="boxNo_s"]').val(''); //保险箱号
		    $('input[name="microNo_s"]').val(''); //缩微号
		    $('input[name="certificateStart_s"]').val(''); //凭证编号（起）
		    $('input[name="certificateStart2"]').val(''); //凭证编号（起）
		    $('input[name="certificateEnd_s"]').val(''); //凭证编号（止）
		    $('input[name="certificateEnd2"]').val(''); //凭证编号（止）
		    $('input[name="rollPage_s"]').val(''); //页数
		    $('input[name="rollPage2"]').val(''); //页数
		    $('input[name="remark_s"]').val(''); //备注
			$('#roomId_s').val(''); //所属卷库
			$('#secret_s').val(''); //案卷密级
			$('#certificateKind_s').val(''); //凭证类别
			$('#deptId_s').val(''); //所属部门
		})
//		返回
		$('.deleteBtn').on('click',function(){
		    $('.juMange').show().siblings().hide();
		})

        //			编辑
        $('#j_tb').on('click','.editData',function(){
            var dataId=$(this).parents('tr').attr('data-id');
            $('.editMange').show().siblings().hide();
            $.ajax({
                type:'get',
                url:'/rmsRoll/selectById',
                dataType:'json',
                data:{
                    rollId:dataId
                },
                success:function(res){
                    var datas=res.object;
                    $('input[name="rollCode"]').val(datas.rollCode);
                    $('input[name="rollName"]').val(datas.rollName);
                    $('input[name="years"]').val(datas.years);
                    $('input[name="beginDate"]').val(datas.beginDate);
                    $('input[name="endDate"]').val(datas.endDate);
                    $('input[name="editDept"]').val(datas.editDept);
                    $('input[name="deadline"]').val(datas.deadline);
                    $('input[name="categoryNo"]').val(datas.categoryNo);
                    $('input[name="catalogNo"]').val(datas.catalogNo);
                    $('input[name="archiveNo"]').val(datas.archiveNo);
                    $('input[name="boxNo"]').val(datas.boxNo);
                    $('input[name="microNo"]').val(datas.microNo);
                    $('input[name="certificateStart"]').val(datas.certificateStart);
                    $('input[name="certificateEnd"]').val(datas.certificateEnd);
                    $('input[name="rollPage"]').val(datas.rollPage);
                    $('input[name="remark"]').val(datas.remark);
                    $('input[name="manager"]').val(datas.manager+',');
                    $('input[name="deptId"]').val(datas.deptId+',');
                    $('#roomId').val(datas.roomId);
                    $('#secret').val(datas.secret);
                    $('#certificateKind').val(datas.certificateKind);
					if(datas.managerName != undefined){
						$('#textUser').val(datas.managerName+',');
					}else {
						$('#textUser').val('');
					}
                    $('#textUser').attr('user_id',datas.manager+',');
                    $('#deptId').val(datas.deptName+',');
                    $('#deptId').attr('deptid',datas.deptId+',');
                    $('input[name="rollId"]').val(datas.rollId);
                }
            })
        })

        //			编辑保存
        $('.saveBtn').on('click',function(){
			// 判断终止日期比开始日期早
			// function compareDate(){
			var startdate = new Date(($("#beginDate").val()).replace(/-/g,"/"));
			var enddate = new Date(($("#endDate").val()).replace(/-/g,"/"));
			if(enddate<startdate){
				alert("结束日期小于开始日期！");
				return false;
			}
			// }
			var deptOne=0;
			var userOne='';
			if(typeof($("#deptId").attr("deptid"))!="undefined"){
				deptOne=$('#deptId').attr('deptid').replace(/,/g,'');
			}
			if(typeof($("#textUser").attr("user_id"))!="undefined"){
				userOne=$('#textUser').attr('user_id').replace(/,/g,'');
			}
			$('input[name="manager"]').val(userOne);
			$('input[name="deptId"]').val(deptOne);

			if($('input[name="rollCode"]').val() == ''){
				layer.msg('<fmt:message code="dem.th.fillNumber" />！', { icon:5,time:1000});
				return false;
			}
			if($('input[name="rollName"]').val() == ''){
				layer.msg('<fmt:message code="dem.th.Fill" />！', { icon:5,time:1000});
				return false;
			}
			<%--if($('#roomId option:selected').val() == ''){--%>
			<%--        layer.msg('<fmt:message code="vote.th.Librarys" />！', { icon:5,time:1000});--%>
			<%--        return false;--%>
			<%--}--%>
			if($('input[name="deptId"]').val() == '0' || $('input[name="deptId"]').val() == ''){
				layer.msg('<fmt:message code="vote.th.ChooseDepartment" />！', { icon:5,time:1000});
				return false;
			}
			if($('#secret option:selected').val() == ''){
				layer.msg('<fmt:message code="dem.th.PleaseSecurity" />！', { icon:5,time:1000});
				return false;
			}

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
            var deptOne=0;
            var userOne='';
            if(typeof($("#deptId").attr("deptid"))!="undefined"){
                deptOne=$('#deptId').attr('deptid').replace(/,/g,'');
            }
            if(typeof($("#textUser").attr("user_id"))!="undefined"){
                userOne=$('#textUser').attr('user_id').replace(/,/g,'');
            }
            $('input[name="manager"]').val(userOne);
            $('input[name="deptId"]').val(deptOne);
            $('#form1').ajaxSubmit({
                type: 'post',
                dataType: 'json',
                success: function (res) {
                    if (res.flag) {
                        $.layerMsg({content: '<fmt:message code="diary.th.modify" />！', icon: 1}, function () {
//                            location.reload();
                            $('.dataMange').show().siblings().hide();
                            init(data,$('#j_tb'));
                        });
                    } else {
                        $(this).attr('data-type',true)
                        alert('<fmt:message code="dem.th.abnormal" />')
                    }

                }
            })
        })
//			返回
        $('.resetBtn').on('click',function(){
            $('.dataMange').show().siblings().hide();
        })

	})

    var starts = {
        format: 'YYYY-MM-DD hh:mm:ss',
        istime: true,
        istoday: false,
    };
    //查询所有卷库
    function queryAllAnjuan(element){
        $.ajax({
            type:'get',
            url:'/rmsRollRoom/selectAll',
            dataType:'json',
            success:function(res){
                var data=res.obj;
                var str='';
                for(var i=0;i<data.length;i++){
                    str+='<option value="'+data[i].roomId+'">'+data[i].roomName+'</option>';
                }
                element.append(str);
            }
        })
    }

    var start = {
        elem: '#beginDate',
        format: 'YYYY-MM-DD hh:mm:ss',
//        min: laydate.now(), //设定最小日期为当前日期
//        max: '2099-06-16 23:59:59', //最大日期
        istime: true,
        istoday: false,
        choose: function(datas){
            end.min = datas; //开始日选好后，重置结束日的最小日期
            end.start = datas //将结束日的初始值设定为开始日
        }
    };
    var end = {
        elem: '#endDate',
        format: 'YYYY-MM-DD hh:mm:ss',
//        min: laydate.now(),
//        max: '2099-06-16 23:59:59',
        istime: true,
        istoday: false,
        choose: function(datas){
            start.max = datas; //结束日选好后，重置开始日的最大日期
        }
    };
    laydate(start);
    laydate(end);
</script>
</body>
</html>
