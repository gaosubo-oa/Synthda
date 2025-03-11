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
		<meta name="renderer" content="webkit">
		<meta http-equiv="X-UA-Compatible" content="IE=10,chrome=1">
		<meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=0, minimum-scale=1.0, maximum-scale=1.0">
		<title><fmt:message code="netdisk.th.PermissionSetting" /></title>
		<link rel="stylesheet" type="text/css" href="../css/file/temp.css"/>
		<link rel="stylesheet" type="text/css" href="../css/easyui/easyui.css">
		<%--<link rel="stylesheet" type="text/css" href="../lib/easyui/themes/easyui.css"/>--%>
		<link rel="stylesheet" type="text/css" href="../lib/easyui/themes/icon.css"/>
		<script src="/js/common/language.js"></script>
		<script src="../js/xoajq/xoajq3.js" type="text/javascript" charset="utf-8"></script>
		<script type="text/javascript" src="../lib/layer/layer.js?20201106" ></script>
		<script src="../js/base/base.js" type="text/javascript" charset="utf-8"></script>
		<script type="text/javascript" src="../lib/easyui/jquery.easyui.min.js" ></script>
		<script type="text/javascript" src="../lib/easyui/tree.js" ></script>
		<script src="../js/file/tempHome.js?20230323" type="text/javascript" charset="utf-8"></script>
		<style>
			.cabinet_left{
				background-color: #fff;
			}
			.nav{
				height: 45px;
				background-color: #fff;
			}
			.nav li{
				height: 26px;
				line-height: 26px;
				display: inline-block;
				float: left;
				font-family: Microsoft yahei,Helvetica Neue,Helvetica,PingFang SC,Tahoma,Arial,sans-serif;
				font-size: 14px;
				margin-top: 7px;
				cursor: pointer;
			}
			.content{
				background-color: #f9f9f9;
			}
			.index_head li img{
				height: 40px;
			}
			textarea{
				text-indent:5px;
				padding-top: 5px;
			}
		</style>
		<link rel="stylesheet" type="text/css" href="/css/commonTheme/${sessionScope.InterfaceModel}/commonTheme.css"/>
	</head>
	<body>
	<div class="content">
		<div  class="cabinet_left">
			<div class="ul_all" id="li_parent">

			</div>
		</div>
		<div  class="cabinet_right">
			<div class="nav">
				<ul class="index_head">
					<li id="visitJurisd" data-num="0" style="margin-left: 10px;">
						<span id="visit" class="headli one"><fmt:message code="netdisk.th.AccessAuthority" /></span>
						<img src="../img/twoth.png" alt=""/>
					</li>
					<li id="addJurisd" data-num="1">
						<span id="add" class="headli"><fmt:message code="netdisk.th.NewPermissions" /></span>
						<img src="../img/twoth.png" alt=""/>
					</li>
					<li id="editJurisd" data-num="2">
						<span id="edit" class="headli"><fmt:message code="main.th.EditPermissions" /></span>
						<img src="../img/twoth.png" alt=""/>
					</li>
					<li id="deleteJurisd" data-num="3">
						<span id="delete" class="headli"><fmt:message code="main.th.DeletePermissions" /></span>
						<img src="../img/twoth.png" alt=""/>
					</li>
					<li id="commentJurisd" data-num="4">
						<span id="comment" class="headli"><fmt:message code="main.th.CommenAuthority" /></span>
						<img src="../img/twoth.png" alt=""/>
					</li>
					<li id="downloadJurisd" data-num="5">
						<span id="download" class="headli"><fmt:message code="netdisk.th.Download-print" /></span>
						<img src="../img/twoth.png" alt=""/>
					</li>
					<li id="signJurisd" data-num="6">
						<span id="sign" class="headli"><fmt:message code="main.th.ReadPermission" /></span>
						<img src="../img/twoth.png" alt=""/>
					</li>
					<li id="owner" data-num="7">
						<span id="all" class="headli"><fmt:message code="main.th.owner" /></span>
						<img src="../img/twoth.png" alt=""/>
					</li>
					<li id="batchSettings" data-num="8" style="margin-top: 13px">
						<span class="headli" style="margin-top: 1px;"><fmt:message code="netdisk.th.BatchSettings" /></span>
					</li>
					<li id="Confidential"style="margin-top:14px;display: none;">
						<span style="color: red;font-family: Microsoft YaHei;font-weight: bolder;font-size: 14pt;margin-left: 20px;"> 机密级★ </span>
					</li>
				</ul>
			</div>
			<div class="title">
				<div class="img" style="display: none;"></div>

			</div>
			<div class="tabTypeOne" style="display: block;">
				<div class="specPermiss">
					<img src="/img/fangwenxian.png" style="margin-right: -15px;margin-left: 30px;vertical-align: middle;width: 20px;margin-bottom: 3px;" alt="">
					<div style="font-size: 18px;margin-left: 20px;color: #124164;font-weight: bold;display: inline-block;"><fmt:message code="netdisk.th.SpecifiedPermissions" />-<span class="divTitle"></span></div>
					<span class="explain" style="font-size: 14px;margin-left: 10px;color:#999;"><fmt:message code="netdisk.th.file1" /></span>
				</div>
				<div class="table">
					<table cellspacing="0" cellpadding="0" style="border-collapse:collapse;background-color: #fff;width: 90%;">
						<tr>
							<td width="20%" style="text-align: center;">
								<p><fmt:message code="doc.th.ScopeAuthorization" />：</p>
								<p>（<fmt:message code="userManagement.th.department" />）</p>
							</td>
							<td>
								<div class="inPole">
									<textarea name="txt" id="SendCompany" user_id='' value="" disabled style="min-width: 329px;min-height:76px;width: 85%;"></textarea>
									<span class="add_img" style="margin-left: 10px">
		                                    <a href="javascript:;" id="SelectCompany" class="Add "><fmt:message code="global.lang.add" /></a>
		                                </span>
									<span class="add_img">
		                                    <a href="javascript:;" class="deClearD"><fmt:message code="notice.th.delete1" /></a>
		                                </span>
								</div>
							</td>
						</tr>
						<tr>
							<td width="20%" style="text-align: center;">
								<p><fmt:message code="doc.th.ScopeAuthorization" />：</p>
								<p>（<fmt:message code="userManagement.th.role" />）</p>
							</td>
							<td>
								<div class="inPole">
									<textarea name="txt" id="SendPriv" user_id='' value="" disabled style="min-width: 329px;min-height:76px;width: 85%;"></textarea>
									<span class="add_img" style="margin-left: 10px">
		                                    <a href="javascript:;" id="SelectPriv" class="Add "><fmt:message code="global.lang.add" /></a>
		                                </span>
									<span class="add_img">
		                                    <a href="javascript:;" class="deClearP"><fmt:message code="notice.th.delete1" /></a>
		                                </span>
								</div>
							</td>
						</tr>
						<tr>
							<td width="20%" style="text-align: center;">
								<p><fmt:message code="doc.th.ScopeAuthorization" />：</p>
								<p>（<fmt:message code="diary.th.body" />）</p>
							</td>
							<td>
								<div class="inPole">
									<textarea name="txt" id="Senduser" user_id='' value="" disabled style="min-width: 329px;min-height:76px;width: 85%;"></textarea>
									<span class="add_img" style="margin-left: 10px">
		                                    <a href="javascript:;" id="SelectUser" class="Add "><fmt:message code="global.lang.add" /></a>
		                                </span>
									<span class="add_img">
		                                    <a href="javascript:;" class="deClearU"><fmt:message code="notice.th.delete1" /></a>
		                                </span>
								</div>
							</td>
						</tr>
						<tr>
							<td width="20%" style="text-align: center;">
								<fmt:message code="main.th.option" />：
							</td>
							<td>
								<input type="checkbox" name="isExtends" id="isExtends" value="" />
								<span><fmt:message code="main.th.ResetSubfolders" /></span>
							</td>
						</tr>
						<tr>
							<td colspan="2">
								<div class="div_btn">
									<%--<input type="button" class="inpuBtn" id="btnSure" value="确定" />
									<input type="button" class="inpuBtn" id="btnBack" value="返回" />--%>
									<div class="Btn_sure" id="btnSure"><span style="margin-left: 32px;"><fmt:message code="global.lang.ok" /></span></div>
									<div class="Btn_back" id="btnBack"><span style="margin-left: 32px;"><fmt:message code="notice.th.return" /></span></div>
								</div>
							</td>
						</tr>
					</table>
				</div>
			</div>
			<div class="tabTypeTwo" style="display: none;">
				<div class="specPermiss">
					<img src="/img/piliangshes.png" style="margin-right: -15px;margin-left: 30px;vertical-align: middle;width: 20px;margin-bottom: 3px;" alt="">
					<div style="font-size: 18px;margin-left: 20px;color: #124164;font-weight: bold;display: inline-block;"><fmt:message code="netdisk.th.BatchSettings" />-<span class="divTitle"><fmt:message code="doc.th.CompanySystem" /></span></div>
					<span class="explain" style="font-size: 14px;margin-left: 10px;color: #999;"><fmt:message code="netdisk.th.WorksOn" /></span>
				</div>
				<div class="table">
					<table cellspacing="0" cellpadding="0" style="border-collapse:collapse;background-color: #fff;width: 90%;">
						<tr>
							<td width="20%" style="text-align: center;">
								<p><fmt:message code="doc.th.ScopeAuthorization" />：</p>
								<p>（<fmt:message code="userManagement.th.department" />）</p>
							</td>
							<td>
								<div class="inPole">
									<textarea name="txt" id="batchSendCompany" user_id='' value="" disabled style="min-width: 329px;min-height:76px;width: 85%;"></textarea>
									<span class="add_img" style="margin-left: 10px">
		                                    <a href="javascript:;" id="batchSelectCompany" class="Add "><fmt:message code="global.lang.add" /></a>
		                                </span>
									<span class="add_img">
		                                    <a href="javascript:;" class="deClearDept"><fmt:message code="notice.th.delete1" /></a>
		                                </span>
								</div>
							</td>
						</tr>
						<tr>
							<td width="20%" style="text-align: center;">
								<p><fmt:message code="doc.th.ScopeAuthorization" />：</p>
								<p>（<fmt:message code="userManagement.th.role" />）</p>
							</td>
							<td>
								<div class="inPole">
									<textarea name="txt" id="batchSendPriv" user_id='' value="" disabled style="min-width: 329px;min-height:76px;width: 85%;"></textarea>
									<span class="add_img" style="margin-left: 10px">
		                                    <a href="javascript:;" id="batchSelectPriv" class="Add "><fmt:message code="global.lang.add" /></a>
		                                </span>
									<span class="add_img">
		                                    <a href="javascript:;" class="deClearPriv"><fmt:message code="notice.th.delete1" /></a>
		                                </span>
								</div>
							</td>
						</tr>
						<tr>
							<td width="20%" style="text-align: center;">
								<p><fmt:message code="doc.th.ScopeAuthorization" />：</p>
								<p>（<fmt:message code="diary.th.body" />）</p>
							</td>
							<td>
								<div class="inPole">
									<textarea name="txt" id="batchSenduser" user_id='' value="" disabled style="min-width: 329px;min-height:76px;width: 85%;"></textarea>
									<span class="add_img" style="margin-left: 10px">
		                                    <a href="javascript:;" id="batchSelectUser" class="Add "><fmt:message code="global.lang.add" /></a>
		                                </span>
									<span class="add_img">
		                                    <a href="javascript:;" class="deClearUser"><fmt:message code="notice.th.delete1" /></a>
		                                </span>
								</div>
							</td>
						</tr>
						<tr class="settingOption">
							<td width="20%" style="text-align: center;">
								<fmt:message code="main.th.setOption" />：
							</td>
							<td>
								<div>
									<input type="checkbox" name="userId" value="1" />
									<span><fmt:message code="netdisk.th.AccessAuthority" /></span>
								</div>
								<div>
									<input type="checkbox" name="newUser" value="2" />
									<span><fmt:message code="netdisk.th.NewPermissions" /></span>
								</div>
								<div>
									<input type="checkbox" name="manageUser" value="3" />
									<span><fmt:message code="main.th.EditPermissions" /></span>
								</div>
								<div>
									<input type="checkbox" name="delUser" value="4" />
									<span><fmt:message code="main.th.DeletePermissions" /></span>
								</div>
								<div>
									<input type="checkbox" name="review" value="5" />
									<span><fmt:message code="main.th.CommenAuthority" /></span>
								</div>
								<div>
									<input type="checkbox" name="downUser" value="6" />
									<span><fmt:message code="netdisk.th.Download-print" /></span>
								</div>
								<div>
									<input type="checkbox" name="signUser" value="7" />
									<span><fmt:message code="main.th.ReadPermission" /></span>
								</div>
								<div>
									<input type="checkbox" name="owner" value="8" />
									<span><fmt:message code="main.th.owner" /></span>
								</div>
							</td>
						</tr>
						<%--<tr>--%>
							<%--<td width="20%" style="text-align: center;">--%>
								<%--操作：--%>
							<%--</td>--%>
							<%--<td>--%>
								<%--<input type="radio" name="radios" id="addRadios" value="" />--%>
								<%--<span style="margin-right: 10px;">添加权限</span>--%>
								<%--<input type="radio" name="radios" id="deleteRadios" value="" />--%>
								<%--<span>删除权限</span>--%>
							<%--</td>--%>
						<%--</tr>--%>
						<tr>
							<td colspan="2">
								<div class="div_btn">
									<div class="Btn_sure" id="Btn_sure"><span style="margin-left: 32px;"><fmt:message code="global.lang.ok" /></span></div>
									<div class="Btn_back" id="Btn_back"><span style="margin-left: 32px;"><fmt:message code="notice.th.return" /></span></div>
								</div>
							</td>
						</tr>
					</table>
				</div>
			</div>
		</div>
	</div>
	<script>
		var dept_id='SendCompany';
		var priv_id='SendPriv';
		var user_id='Senduser';
		$(function(){

		    var fileWidth=$('.content').width()-$('.cabinet_left').width()-3;
		    $('.cabinet_right').width(fileWidth+'px');

            $("#SelectCompany").on("click",function(){//选部门控件
                dept_id='SendCompany';
                $.popWindow("../common/selectDept?allDept=1");
            });
            $("#SelectPriv").on("click",function(){//选角色控件
                priv_id='SendPriv';
                $.popWindow("../common/selectPriv?1");
            });
            $("#SelectUser").on("click",function(){//选人员控件
                user_id='Senduser';
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

            $("#batchSelectCompany").on("click",function(){//选部门控件
                dept_id='batchSendCompany';
                $.popWindow("../common/selectDept?allDept=1");
            });
            $("#batchSelectPriv").on("click",function(){//选角色控件
                priv_id='batchSendPriv';
                $.popWindow("../common/selectPriv?1");
            });
            $("#batchSelectUser").on("click",function(){//选人员控件
                user_id='batchSenduser';
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
			$.ajax({
				type:'get',
				url:'/syspara/selectTheSysPara?paraName=IS_SHOW_JMJ',
				dataType:'json',
				success:function (res) {
					if(res.object.length!=0){
						var data=res.object[0]
						if (data.paraValue==0){
							$('#Confidential').hide()
						}else {
							$('#Confidential').show()
						}
					}
				}
			})
		})
	</script>
	</body>
</html>
