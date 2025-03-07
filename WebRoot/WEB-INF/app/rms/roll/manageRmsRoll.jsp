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
	<title><fmt:message code="vote.th.supervisionRecord"/></title>
	<link rel="stylesheet" type="text/css" href="../lib/laydate.css"/>
	<link rel="stylesheet" type="text/css" href="../lib/pagination/style/pagination.css"/>
	<link rel="stylesheet" type="text/css" href="../css/base.css"/>
	<script src="/js/common/language.js"></script>
<%--	<script type="text/javascript" src="../js/xoajq/xoajq1.js"></script>--%>
	<script type="text/javascript" src="/js/xoajq/xoajq3.js"></script>
	<script type="text/javascript" src="/js/jquery/jquery-migrate-3.4.0.js"></script>
	<script src="../js/news/page.js"></script>
	<script src="../lib/laydate/laydate.js"></script>
	<script src="../js/base/base.js" type="text/javascript" charset="utf-8"></script>
	<script src="../lib/pagination/js/jquery.pagination.min.js" type="text/javascript" charset="utf-8"></script>
	<script src="../lib/layer/layer.js?20201106"></script>
	<script type="text/javascript" src="/js/jquery/jquery.form.min.js"></script>
	<script src="../js/rms/manageRmsRoll.js?20230427.2"></script>
	<style>
		a {
			text-decoration: none;
			color: #207bd6;
		}
		.buttonDiv{
			width: 100%;
		}
		.buttonDiv .deleteBtn{
			width: 112px;
			height: 28px;
			margin: 20px auto;
			background: url("../img/btn_deletecontent_03.png") no-repeat;
			line-height: 28px;
			cursor: pointer;
		}
		#selectq{
			margin-left: 10px;
			width: 120px;
			outline: none;
			border-radius:4px;
		}
		.editMange input[type="text"]{
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
			background: url(../img/icon_backing.png) no-repeat;
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
		<div class="navigation  clearfix juMange" id="juMange" style="display: block;">
			<div class="left" style="margin-left: 30px;width: 28%;">
				<img src="/img/commonTheme/${sessionScope.InterfaceModel}/icon_manageRoll.png" style="margin-top: 18px;">
				<div class="news">
					<span><fmt:message code="vote.th.supervisionRecord"/></span>
				</div>
				<div style="float: right;margin-top: -22px;">
					<select name="" id="selectq">
						<option value=""><fmt:message code="vote.th.Librarys"/></option>
					</select>
				</div>
			</div>
			<div class="wrap" style="margin-left: 0;padding: 0 20px;margin-top: 70px;">
				<table id="tr_td">
					<thead>
					<tr>
						<td>
							<input type="checkbox" id="checkedAll">
						</td>
						<td class="th">
							<fmt:message code="dem.th.FileNumber"/>
						</td>
						<td class="th">
							<fmt:message code="dem.th.FileName"/>
						</td>
						<td class="th">
							<fmt:message code="dem.th.CoilingLibrary"/>
						</td>
						<td class="th">
							<fmt:message code="dem.th.FondsNumber"/>
						</td>
						<td class="th">
							<fmt:message code="dem.th.CertificateCategory"/>
						</td>
						<td class="th">
							<fmt:message code="dem.th.FileSecurity"/>
						</td>
						<td class="th">
							<fmt:message code="vote.th.FileStatus"/>
						</td>
						<td class="th" style="width: 220px;">
							<fmt:message code="notice.th.operation"/>
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
					<div class="deleteBtn"><span style="margin-left: 34px;"><fmt:message code="meet.th.BatchDelete"/></span></div>
				</div>
			</div>
		</div>


		<div class="navigation  clearfix editMange" style="display: none;">
			<div class="left" style="margin-left: 30px;width: 40%;">
				<img src="/img/rms/icon_editRoll.png" style="margin-top: 18px;">
				<div class="news">
					<fmt:message code="dem.th.EditFile"/>
				</div>
			</div>
			<div class="wrap" style="margin-left: 0;padding: 0 20px;">
				<form id="form1" action="/rmsRoll/update">
					<input type="hidden" name="rollId" value="">
					<table class="newTbale">
						<tr>
							<td><fmt:message code="dem.th.FileNumber"/>：</td>
							<td>
								<input type="text" name="rollCode" required="">
								<img class="td_title2" src="../img/mg2.png" style="margin-top: 10px;margin-left: 5px;" alt="必填">
							</td>
							<td><fmt:message code="dem.th.FileName"/>：</td>
							<td>
								<input type="text" name="rollName">
								<img class="td_title2" src="../img/mg2.png" style="margin-top: 10px;margin-left: 5px;" alt="必填">
							</td>
						</tr>
						<tr>
							<td><fmt:message code="dem.th.CoilingLibrary"/>：</td>
							<td>
								<select name="roomId" id="roomId">
									<option value=""><fmt:message code="vote.th.Librarys"/></option>
								</select>
								<img class="td_title2" src="../img/mg2.png" alt="必填">
							</td>
							<td><fmt:message code="dem.th.Rewinding"/>：</td>
							<td><input type="text" name="years"></td>
						</tr>
						<tr>
							<td><fmt:message code="sms.th.StartDate"/>：</td>
							<td><input type="text" name="beginDate" id="beginDate"></td>
							<td><fmt:message code="notice.th.endDate"/>：</td>
							<td><input type="text" name="endDate" id="endDate"></td>
						</tr>
						<tr>
							<td><fmt:message code="workflow.th.sector"/>：</td>
							<td>
								<textarea name="deptIds" id="deptId" dataid resize="auto"></textarea>
								<input type="hidden" name="deptId" value="">
								<img class="td_title2" src="../img/mg2.png" alt="必填">
								<a href="javascript:;" class="checkOne" id="checkOne" style="margin: 0 10px;"><fmt:message code="global.lang.select"/></a>
								<a href="javascript:;" class="clearOne" id="clearOne"><fmt:message code="global.lang.empty"/></a>
							</td>
							<td><fmt:message code="dem.th.EstablishmentOrganization"/>：</td>
							<td><input type="text" name="editDept"></td>
						</tr>
						<tr>
							<td><fmt:message code="dem.th.TimeLimit"/>：</td>
							<td><input type="text" name="deadline"></td>
							<td><fmt:message code="dem.th.FileSecurity"/>：</td>
							<td>
								<select name="secret" id="secret">
									<option value=""><fmt:message code="dem.th.PleaseSecret"/></option>
									<option value="1"><fmt:message code="dem.th.PuDense"/></option>
									<option value="4"><fmt:message code="dem.th.Secret"/></option>
									<option value="3"><fmt:message code="dem.th.Confidential"/></option>
									<option value="2"><fmt:message code="doc.th.Top-secret"/></option>
								</select>
								<img class="td_title2" src="../img/mg2.png" alt="必填">
							</td>
						</tr>
						<tr>
							<td><fmt:message code="dem.th.FondsNumber"/>：</td>
							<td><input type="text" name="categoryNo"></td>
							<td><fmt:message code="dem.th.Directory"/>：</td>
							<td><input type="text" name="catalogNo"></td>
						</tr>
						<tr>
							<td><fmt:message code="dem.th.ArchivesNumber"/>：</td>
							<td><input type="text" name="archiveNo"></td>
							<td><fmt:message code="dem.th.InsuranceNumber"/>：</td>
							<td><input type="text" name="boxNo"></td>
						</tr>
						<tr>
							<td><fmt:message code="dem.th.Microfilm"/>：</td>
							<td><input type="text" name="microNo"></td>
							<td><fmt:message code="dem.th.CertificateCategory"/>：</td>
							<td>
								<select name="certificateKind" id="certificateKind">
									<option value=""><fmt:message code="dem.th.Category"/></option>
									<option value="1">XXX1</option>
									<option value="2">XXX2</option>
								</select>
							</td>
						</tr>
						<tr>
							<td><fmt:message code="dem.th.Voucher(starting)"/>：</td>
							<td><input type="text" name="certificateStart"></td>
							<td><fmt:message code="dem.th.Voucher(stop)"/>：</td>
							<td><input type="text" name="certificateEnd"></td>
						</tr>
						<tr>
							<td><fmt:message code="dem.th.pages"/>：</td>
							<td><input type="text" name="rollPage"></td>
							<td><fmt:message code="journal.th.Remarks"/>：</td>
							<td><input type="text" name="remark"></td>
						</tr>
						<tr>
							<td><fmt:message code="dem.th.filesStaff"/>：</td>
							<td colspan="3">
								<textarea name="managers" id="textUser" dataid resize="auto"></textarea>
								<input type="hidden" name="manager" value="">
								<a href="javascript:;" id="checkTwo" style="margin: 0 10px"><fmt:message code="global.lang.select"/></a>
								<a href="javascript:;" id="clearBtn"><fmt:message code="global.lang.empty"/></a>
							</td>
						</tr>
					</table>
				</form>
				<div class="buttonDiv">
					<div class="divBtn">
						<div class="saveBtn"><span style="margin-left: 32px;"><fmt:message code="global.lang.save"/></span></div>
						<div class="resetBtn"><span style="margin-left: 32px;"><fmt:message code="notice.th.return"/></span></div>
					</div>
				</div>
			</div>
		</div>

		<div class="divIframeThr iframeShow" id="iframeShow" style="width: 100%;height: 100%;display: none;">
			<iframe src="/rmsRoll/lookFile" id="iframeThr" style="width: 100%;height: 100%;" frameborder="0"></iframe>
		</div>
	</div>
	<script type="text/javascript">
		$(function(){
            queryAllAnjuan($('#selectq'));
            queryAllAnjuan($('#roomId'));

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
//			编辑
			$('#j_tb').on('click','.editData',function(){
			    var dataId=$(this).parents('tr').attr('data-id');
			    $('.juMange').hide();
			    $('.editMange').show();
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
                            $('#textUser').attr('user_id',datas.manager+',');
						}else{
                            $('#textUser').val('');
                            $('#textUser').attr('');
						}

                        $('#deptId').val(datas.deptName+',');
                        $('#deptId').attr('deptid',datas.deptId+',');
                        $('input[name="rollId"]').val(datas.rollId);
					}
				})
			})
//			编辑保存
            $('.saveBtn').on('click',function(){
<%--                var deptOne=0;--%>
<%--                var userOne='';--%>
<%--                if(typeof($("#deptId").attr("deptid"))!="undefined"){--%>
<%--                    deptOne=$('#deptId').attr('deptid').replace(/,/g,'');--%>
<%--                }--%>
<%--                if(typeof($("#textUser").attr("user_id"))!="undefined"){--%>
<%--                    userOne=$('#textUser').attr('user_id').replace(/,/g,'');--%>
<%--                }--%>
<%--                $('input[name="manager"]').val(userOne);--%>
<%--                $('input[name="deptId"]').val(deptOne);--%>
<%--                $('#form1').ajaxSubmit({--%>
<%--                    type: 'post',--%>
<%--                    dataType: 'json',--%>
<%--                    success: function (res) {--%>
<%--                        if (res.flag) {--%>
<%--                            $.layerMsg({content: '<fmt:message code="diary.th.modify"/>！', icon: 1}, function () {--%>
<%--//                            location.reload();--%>
<%--                                $('.juMange').show();--%>
<%--                                $('.editMange').hide();--%>
<%--                                init(dataId,$('#j_tb'));--%>
<%--                            });--%>
<%--                        } else {--%>
<%--                            $(this).attr('data-type',true)--%>
<%--                            alert('<fmt:message code="dem.th.abnormal"/>')--%>
<%--                        }--%>

<%--                    }--%>
<%--                })--%>

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
				if($('#roomId option:selected').val() == ''){
					layer.msg('<fmt:message code="vote.th.Librarys" />！', { icon:5,time:1000});
					return false;
				}
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
            })
//			返回
			$('.resetBtn').on('click',function(){
                $('.juMange').show();
                $('.editMange').hide();
			})
//			查看文件
            $('#j_tb').on('click','.lookFile',function(){
                var dataId=$(this).parents('tr').attr('data-id');
                $('#iframeShow').show().siblings().hide();
//                var test=$("#iframeShow").contents().find("#hiddenId");
//                test.val(dataId);
				$('#iframeThr').attr('src','/rmsRoll/lookFile?rollId='+dataId);
			})
//			拆卷/封卷
			$('#j_tb').on('click','.removeData',function(){
			    var dataid=$(this).parents('tr').attr('data-id');
			    var statusId=$(this).parents('tr').attr('data-status');
			    if(statusId == '0'){
                    statusId='1';
				}else{
                    statusId='0';
				}
				$.ajax({
					type:'post',
					url:'/rmsRoll/update',
					dataType:'json',
					data:{
                        rollId:dataid,
						status:statusId
					},
					success:function(res){
					    if(res.flag){
                            $.layerMsg({content: '<fmt:message code="user.th.SuccessfulOperation"/>！', icon: 1});
                            init(dataId,$('#j_tb'));
						}else{
                            $.layerMsg({content: '<fmt:message code="sms.th.operationFailed"/>！', icon: 2});
						}
					}
				})
			})
		})

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
