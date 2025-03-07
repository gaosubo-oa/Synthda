<%@ page language="java" contentType="text/html; charset=UTF-8"
		 pageEncoding="UTF-8"%>
<%@taglib prefix="mvc" uri="http://www.springframework.org/tags/form" %>
<%@taglib prefix="fmt" uri="http://www.springframework.org/tags" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<%--<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">--%>
<!DOCTYPE html>
<head>
	<base href="/">

	<title><fmt:message code="file.th.fileset"/></title>

	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
	<%--<link rel="stylesheet" type="text/css" href="styles.css">--%>
	<link rel="stylesheet" type="text/css" href="/lib/layui/layui-v2.6.8/layui/css/layui.css">
	<script src="/lib/layui/layui-v2.6.8/layui/layui.js"></script>
	<script type="text/javascript" src="/js/xoajq/xoajq3.js"></script>
	<script type="text/javascript" src="/js/jquery/jquery-migrate-3.4.0.js"></script>
	<script src="../js/base/base.js?20190515.1" type="text/javascript" charset="utf-8"></script>
	<script src="../lib/layer/layer.js?20201106"></script>
	<script src="/js/base/base.js"></script>
	<style type="text/css">
		*{
			margin: 0;
			padding: 0;
		}
		body {
			background-color: #fff;
		}
		a{
			text-decoration: none;
		}
		h1 {
			font-size: 20px;
		}
		table {
			margin: 0 auto;
			width: 60%;
		}
		table tr{
			border:#ccc 1px solid;
		}
		table tr:nth-child(even){
			background-color: #F6F7F9 !important;
		}
		table tr:nth-child(odd){
			background-color: #fff !important;
		}

		table tr td {
			padding: 5px 5px;
			font-size: 11pt;
		}

		table tr td:last-of-type {
			text-align: center;
		}

		table tr th {
			padding: 5px 5px;
			font-size: 13pt;
			color: #2F5C8F;
			text-align: left;
		}
		table tr th:last-of-type{
			text-align: center;
		}
		a {
			text-decoration: none;
		}

		input {
			outline: none;
			border: 0;
			background: none;
			color: #2788ea;
		}
		.header{
			width: 100%;
			height: 45px;
			overflow: hidden;
			border-bottom: #ccc 1px solid;
		}
		.divP{
			float: left;
			height: 45px;
			line-height: 45px;
			font-size: 22px;
			margin-left: 10px;
			color:#494d59;
		}
		.div_Img{
			float: left;
			width: 23px;
			height: 100%;
			margin-left: 30px;
		}
		.div_Img img{
			width: 23px;
			height: 28px;
			margin-top: 11px;
		}
		.ss{margin-top:9px;position: relative;float:right;margin-right: 10%;}
		.ss span{font-size: 14px;display: block;font-family: 微软雅黑;letter-spacing: 1px;position: absolute;left: 25px;top: 1px;color: #fff;}
		.one{cursor: pointer;width:124px;height: 30px;background: url("../img/file/cabinet01.jpg") no-repeat;}
		.one span{height: 30px;  line-height: 30px;margin-left: 13px;}
		input:hover {
			color: #0867c5;
		}
		.divForm{margin-top: 20px}
		/*.layui-layer-dialog{*/
		/*top:150px!important;*/
		/*}*/
	</style>
	<link rel="stylesheet" type="text/css" href="/css/commonTheme/${sessionScope.InterfaceModel}/commonTheme.css"/>
	<script type="text/javascript">
		function openWindow(sHref,strWidth,strHeight) {
			var strLeft=(screen.availWidth-strWidth)/2;
			var strTop=(screen.availHeight-strHeight)/2;
			var strRef="";
			strRef=strRef+"width="+strWidth+"px,height="+strHeight+"px,";
			strRef=strRef+"left="+strLeft+"px,top="+strTop+"px,";
			strRef=strRef+"resizable=yes,scrollbars=yes,status=yes,toolbar=no,systemmenu=no,location=no,borderSize=thin";//channelmode,fullscreen
			var openerobj= window.open(sHref,'newwin',strRef,false);
			openerobj.focus();
		}
	</script>
</head>
<body>
<div class="header">
	<div class="div_Img">
		<img src="/img/commonTheme/${sessionScope.InterfaceModel}/icon_fileSetting.png" style="vertical-align: middle;" alt="<fmt:message code="journal.th.MenuMain"/>">
	</div>
	<div class="divP"><fmt:message code="file.th.fileset"/></div>
	<div class="ss one"> <span id="newFile"><img style="margin-right: 4px;margin-left: -22px;margin-bottom: -1px;" src="../../img/mywork/newbuildworjk.png" alt=""><fmt:message code="adding.th.newF"/></span></div>
</div>
<div class="divForm">
	<%--<form id="form2" name="form2" method="get">
        <table id="table" cellspacing="0" cellpadding="0" style="border-collapse:collapse;">
            <tr>
                <th class="css_td"><fmt:message code="file.th.Sort"/></th>
                <th class="css_td"><fmt:message code="file.th.filename"/></th>
                <th class="css_td"><fmt:message code="notice.th.operation"/></th>
            </tr>
            <c:forEach items="${parentList}" var="parent">
                <tr>
                    <td>${parent.sortNo}</td>
                    <td>${parent.sortName}</td>
                    <td>&nbsp;&nbsp;<input style="font-size:12px;height=20;width=80" id="BTAdd" type="button" value="编辑" name="BT_find" onclick="openWindow('${pageContext.request.contextPath }/file/edit?sortId=${parent.sortId}','700','500')" />&nbsp;&nbsp;<input style="font-size:12px;height=20;width=80" id="BAdd" class="deletBtn" type="button" value="删除"  sortId="${parent.sortId}" name="BT_find" /> &nbsp;&nbsp;<input style="font-size:12px;height=20;width=80" id="BT_Add" type="button"  value="权限设置" name="BT_find" onclick="openWindow('${pageContext.request.contextPath }/file/temp?sortId=${parent.sortId}','1200','700')" />&nbsp;&nbsp;
                    </td>
                </tr>
            </c:forEach>
        </table>
    </form>--%>
	<table id="table" cellspacing="0" cellpadding="0" style="border-collapse:collapse;">
		<tr>
			<th class="css_td"><fmt:message code="file.th.Sort"/></th>
			<th class="css_td"><fmt:message code="file.th.filename"/></th>
			<th class="css_td"><fmt:message code="notice.th.operation"/></th>
		</tr>
	</table>
</div>

<script>
	var priv_id = "";

	var isOrgScope = false;// 是否开启分支机构
	var branchDeptId = "";// 当前登陆人 所在分支机构ID
	var branchDeptName = "";// 当前登陆人 所在分支机构名称

	$(function () {

		//数据列表
		dataInit();
		$('#table').on('click','.deletBtn',function(){
			var sortId=$(this).parents('tr').attr("sortId");
			layer.confirm('<fmt:message code="sys.th.commit"/>！', {title:'<fmt:message code="information"/>',
				btn: ['<fmt:message code="global.lang.ok"/>','<fmt:message code="depatement.th.quxiao"/>'] //按钮
			}, function(){
				//确定删除，调接口
				$.ajax({
					type: 'get',
					url: '/newFilePub/delPubSort',
					data:{'sortId':sortId},
					dataType: 'json',
					success: function (res) {
						if(res.flag == true){
							//第三方扩展皮肤
							layer.msg('<fmt:message code="workflow.th.delsucess"/>', { icon:6});
							dataInit();
						}else{
							layer.msg('<fmt:message code="lang.th.deleSucess"/>', { icon:6});

						}
					}
				})

			}, function(){
				layer.closeAll();
			});

		})

		$('#newFile').on("click",function(){
			layer.open({
				title: ['<fmt:message code="adding.th.newF"/>', 'background-color:#2b7fe0;color:#fff;'],
				shade: 0,
				offset:['150px','35%'],
				content: '<div style="margin-left: 30px;margin-top: 30px;"><span style="display: inline-block;width: 100px;height: 26px;text-align: left;line-height: 26px;"><fmt:message code="file.th.Sort"/>：</span><input type="number" name="number" value="10" style="width: 220px;height: 26px;border:#ccc 1px solid;border-radius: 5px;color:#000;padding-left: 5px;"></div>'+
						'<div style="margin-left: 30px;margin-top: 30px;"><span style="display: inline-block;width: 100px;height: 26px;text-align: left;line-height: 26px;"><fmt:message code="file.th.filename"/>：</span><input type="text" name="fileName" value="" style="width: 220px;height: 26px;border:#ccc 1px solid;border-radius: 5px;color:#000;padding-left: 5px;"></div>'+
						'<div style="margin-left: 30px;margin-top: 30px;"><span style="display: inline-block;width: 100px;height: 26px;text-align: left;line-height: 26px;"><fmt:message code="netdisk.th.Maximumcapacity"/>：</span><input type="number" name="spaceLimit" value="" style="width: 220px;height: 26px;border:#ccc 1px solid;border-radius: 5px;color:#000;padding-left: 5px;margin-right:3px;">MB</div>'+
						'<div style="margin-left: 30px;margin-top: 30px;"><span style="display: inline-block;width: 100px;height: 26px;text-align: left;line-height: 26px;"><fmt:message code="user.th.branchDept"/>：</span><select name="branchDeptId" value="" style="width: 227px;height: 26px;border:#ccc 1px solid;border-radius: 5px;color:#000;padding-left: 5px;"></select></div>',
				area: ['500px', '400px'],
				btn: ['<fmt:message code="global.lang.save"/>', '<fmt:message code="global.lang.close"/>'],
				success: function () {
					// 如果当前登陆人是管理员，则不选就行
					// 如果当前登陆人是分支机构人员，则只显示本分支机构（分支机构人员新建时，只能选本分支机构）
					if (isOrgScope && branchDeptId !== "" && branchDeptName !== "") {
						//下拉框加选项
						$('select[name="branchDeptId"]').html('<option value="' + branchDeptId + '">' + branchDeptName + '</option>');
					}

					$('input[name="fileName"]').focus();
				},
				yes:function () {
					var data={
						sortNo:$('input[name="number"]').val(),
						sortName:$('input[name="fileName"]').val(),
						spaceLimit:$('input[name="spaceLimit"]').val(),
						branchDeptId:$('select[name="branchDeptId"]').val() != null ? $('select[name="branchDeptId"]').val() : "",
						sortType:'5',
						sortParent:0
					}

					if($('input[name="number"]').val()==''){
						$.layerMsg({content:'<fmt:message code="workflow.th.SequenceNumberCannotBeEmpty" />！',icon:2});
						return false;
					}
					if($('input[name="fileName"]').val()==''){
						$.layerMsg({content:'<fmt:message code="workflow.th.folderNameCannotBeEmpty" />！',icon:2});
						return false;
					}
					// layer.load();
					$.ajax({
						type:'post',
						url:'/newFilePub/getFileCheck',
						dataType:'json',
						data:data,
						success:function(res) {
							if (res.status == false) {
								$.layerMsg({content:'<fmt:message code="main.th.alreadyExists"/>！',icon:3});
								return false;
								layer.closeAll();
							}else{
								$.ajax({
									type:'post',
									url:'/newFilePub/addPubSort',
									dataType:'json',
									data:data,
									success:function(res){
										layer.closeAll()
										if(res.code==1001){
											$.layerMsg({content:res.msg,icon:1})
										}else{
											$.layerMsg({content:'<fmt:message code="depatement.th.Newsuccessfully"/>！',icon:1},function(){
												dataInit();
											});
										}
										layer.closeAll();
									}
								})
							}

						}
					});
				}
			})
		})
		//编辑按钮点击事件
		$('#table').on('click','#BTAdd',function(){
			var sortId=$(this).parents('tr').attr("sortId");
			layer.open({
				title: ['<fmt:message code="sys.th.edit"/>', 'background-color:#2b7fe0;color:#fff;'],
				shade: 0,
				content: '<div style="margin-left: 30px;margin-top: 30px;"><span style="display: inline-block;width: 100px;height: 26px;text-align: left;line-height: 26px;"><fmt:message code="file.th.Sort"/>：</span><input type="number" name="number" value="" style="width: 220px;height: 26px;border:#ccc 1px solid;border-radius: 5px;color:#000;padding-left: 5px;"></div>'+
						'<div style="margin-left: 30px;margin-top: 30px;"><span style="display: inline-block;width: 100px;height: 26px;text-align: left;line-height: 26px;"><fmt:message code="file.th.filename"/>：</span><input type="text" name="fileName" value="" style="width: 220px;height: 26px;border:#ccc 1px solid;border-radius: 5px;color:#000;padding-left: 5px;"></div>'+
						'<div style="margin-left: 30px;margin-top: 30px;"><span style="display: inline-block;width: 100px;height: 26px;text-align: left;line-height: 26px;"><fmt:message code="netdisk.th.Maximumcapacity"/>：</span><input type="text" name="spaceLimit" value="" style="width: 220px;height: 26px;border:#ccc 1px solid;border-radius: 5px;color:#000;padding-left: 5px;margin-right:3px;">MB</div>'+
						'<div style="margin-left: 30px;margin-top: 30px;"><span style="display: inline-block;width: 100px;height: 26px;text-align: left;line-height: 26px;"><fmt:message code="user.th.branchDept"/>：</span><select name="branchDeptId" value="" style="width: 227px;height: 26px;border:#ccc 1px solid;border-radius: 5px;color:#000;padding-left: 5px;"></select></div>',
				area: ['500px', '400px'],
				btn: ['<fmt:message code="depatement.th.modify"/>', '<fmt:message code="global.lang.close"/>'],
				success: function(){
					// 如果当前登陆人是管理员，则不选就行
					// 如果当前登陆人是分支机构人员，则只显示本分支机构（分支机构人员新建时，只能选本分支机构）
					if (isOrgScope && branchDeptId !== "" && branchDeptName !== "") {
						//下拉框加选项
						$('select[name="branchDeptId"]').html('<option value="' + branchDeptId + '">' + branchDeptName + '</option>');
					}

					$.ajax({
						type:'get',
						url:'/newFilePub/getPubSort',
						dataType:'json',
						data:{'sortId':sortId},
						success:function(res){
							var data1=res.data;
							$('input[name="number"]').val('');
							$('input[name="fileName"]').val('');
							$('input[name="spaceLimit"]').val('');

							$('input[name="number"]').val(data1.sortNo);
							$('input[name="fileName"]').val(data1.sortName);
							$('input[name="spaceLimit"]').val(data1.spaceLimit);
							$('select[name="branchDeptId"]').val(data1.branchDeptId);
						}
					})
				},
				yes:function () {
					var data={
						"sortNo":$('input[name="number"]').val(),
						"sortName":$('input[name="fileName"]').val(),
						"spaceLimit":$('input[name="spaceLimit"]').val(),
						"sortId":sortId,
						"branchDeptId":$('select[name="branchDeptId"]').val() != null ? $('select[name="branchDeptId"]').val() : ""
					}
					if($('input[name="fileName"]').val()==''){
						$.layerMsg({content:'<fmt:message code="workflow.th.folderNameCannotBeEmpty" />！',icon:2});
						return false;
					}
					$.ajax({
						type:'post',
						url:'/newFilePub/updPubSort',
						dataType:'json',
						data:data,
						success:function(res){
							if(res.flag){
								$.layerMsg({content:'<fmt:message code="depatement.th.Modifysuccessfully"/>！',icon:1});
								dataInit();
							}else{
								$.layerMsg({content:'<fmt:message code="depatement.th.modifyfailed" />！',icon:2});
							}
						}
					})
				}
			})
		})
		//权限设置点击事件
		$('#table').on('click','#BT_Add',function(){
			var sortId=$(this).parents('tr').attr("sortId");
			$.popWindow('/newFilePub/tempHome?sortId='+sortId+'','<fmt:message code="netdisk.th.PermissionSetting"/>','0','0','1300px','725px');
		})
		//2021.06.10 修改 起始=======
		//克隆文件夹点击事件
		$('#table').on('click','#BT_Copy',function(){
			var sortId=$(this).parents('tr').attr("sortId");
			layer.open({
				title: ['<fmt:message code="sys.th.copy"/>', 'background-color:#2b7fe0;color:#fff;'],
				shade: 0,
				type:1,
				content: '<div style="margin-left: 30px;margin-top: 30px;"><span style="display: inline-block;width: 100px;height: 26px;text-align: left;line-height: 26px;"><fmt:message code="file.th.Sort"/>：</span><input type="number" name="number" value="" style="width: 220px;height: 26px;border:#ccc 1px solid;border-radius: 5px;color:#000;padding-left: 5px;"></div>'+
						'<div style="margin-left: 30px;margin-top: 30px;"><span style="display: inline-block;width: 100px;height: 26px;text-align: left;line-height: 26px;"><fmt:message code="file.th.rename"/>：</span><input type="text" name="refileName" value="" style="width: 220px;height: 26px;border:#ccc 1px solid;border-radius: 5px;color:#000;padding-left: 5px;"><span style="color: red;font-size: 16px;">*</span></div>'+
						'<div style="margin-left: 30px;margin-top: 30px;"><span style="display: inline-block;width: 100px;height: 26px;text-align: left;line-height: 26px;"><fmt:message code="netdisk.th.Maximumcapacity"/>：</span><input type="text" name="spaceLimit" value="" style="width: 220px;height: 26px;border:#ccc 1px solid;border-radius: 5px;color:#000;padding-left: 5px;margin-right:3px;">MB</div>'+
						'<div style="margin-left: 30px;margin-top: 30px;"><span style="display: inline-block;width: 100px;height: 26px;text-align: left;line-height: 26px;"><fmt:message code="user.th.branchDept"/>：</span><select name="branchDeptId" value="" style="width: 227px;height: 26px;border:#ccc 1px solid;border-radius: 5px;color:#000;padding-left: 5px;"></select></div>',
				area: ['500px', '400px'],
				btn: ['<fmt:message code="depatement.th.copy"/>', '<fmt:message code="global.lang.close"/>'],
				success: function(){
					// 如果当前登陆人是管理员，则不选就行
					// 如果当前登陆人是分支机构人员，则只显示本分支机构（分支机构人员新建时，只能选本分支机构）
					if (isOrgScope && branchDeptId !== "" && branchDeptName !== "") {
						//下拉框加选项
						$('select[name="branchDeptId"]').html('<option value="' + branchDeptId + '">' + branchDeptName + '</option>');
					}

					$.ajax({
						type:'get',
						url:'/newFilePub/getPubSort',
						dataType:'json',
						data:{'sortId':sortId},
						success:function(res){
							var data1=res.data;
							$('input[name="number"]').val('');
							$('input[name="refileName"]').val('');
							$('input[name="spaceLimit"]').val('');

							$('input[name="number"]').val(data1.sortNo);
							// $('input[name="refileName"]').val(data1.sortName);
							$('input[name="spaceLimit"]').val(data1.spaceLimit);
							$('select[name="branchDeptId"]').val(data1.branchDeptId);
						}
					})
				},
				yes:function (index) {
					var data={
						"sortNo":$('input[name="number"]').val(),
						"sortName":$('input[name="refileName"]').val(),
						"spaceLimit":$('input[name="spaceLimit"]').val(),
						"branchDeptId":$('select[name="branchDeptId"]').val() != null ? $('select[name="branchDeptId"]').val() : "",
						"sortId":sortId,
						"sortType":5,
					}
					if($('input[name="refileName"]').val()!=''){
						$.ajax({
							type:'post',
							url:'/newFilePub/copyFileCheck',
							dataType:'json',
							data:data,
							success:function(res) {
								if (res.status == false) {
									$.layerMsg({content: '<fmt:message code="main.th.copyAlreadyExists"/>！', icon: 3});
									return false;
									layer.closeAll();
								} else {
									$.ajax({
										type: 'post',
										url: '/newFilePub/copyPubFileSort',
										dataType: 'json',
										data: data,
										success: function (res) {
											if (res.flag) {
												layer.closeAll();
												$.layerMsg({
													content: '<fmt:message code="depatement.th.copysuccessfully"/>！',
													icon: 1
												});
												dataInit();
											} else {
												$.layerMsg({content: '<fmt:message code="workflow.th.CloningFailure" />！', icon: 2});
											}
										}
									})

								}
							}})
					}else{
						$.layerMsg({content:'<fmt:message code="workflow.th.folderNameCannotBeEmpty" />！',icon:2});
						return false;
					}

				}
			})
		})
		//发布菜单点击事件
		$("table").on("click",'#BT_Re',function() {
			var id = $(this).parents("tr").attr("sortid")
			layer.open({
				title: '<p style="height: 43px;width: 100%;font-size: 16px;padding-left: 10px;color: #000"><fmt:message code="file.th.releaseMenu" /></p>',
				shade: 0.3,
				type: 1,
				content:'<div class="tbox">\n' +
						'        <form class="layui-form" action="" style="margin: auto;">\n' +
						'            <div class="layui-form-item">\n' +
						'                <label class="layui-form-label"><fmt:message code="menuSetting.th.ID" /></label>\n' +
						'                <div class="layui-input-block">\n' +
						'                    <input type="text"  name="addfId" id="addfId"  style="border: 1px solid #c0c0c0;background-color: #e7e7e7;" readonly="readonly" lay-verify="title" autocomplete="off"  class="layui-input">\n' +
						'                </div>\n' +
						'            </div>\n' +
						'\n' +
						'            <div class="layui-form-item">\n' +
						'                <label class="layui-form-label"><span class="red">*</span><fmt:message code="menuSetting.th.menud" /></label>\n' +
						'\n' +
						'                <div class="layui-input-block">\n' +
						'                    <select name="addParentId" id="addParentId" lay-filter="addParentId" lay-verify="required"  class="layui-input-block">\n' +
						'                        <option></option>\n' +
						'                    </select>\n' +
						'                </div>\n' +
						'            </div>\n' +
						'            <div class="layui-form-item">\n' +
						'                <label class="layui-form-label"><span class="red">*</span><fmt:message code="menuSetting.th.itemCode" /></label>\n' +
						'                <div class="layui-input-block">\n' +
						'                    <input type="text" name="addId"  id="addId" lay-verify="title" autocomplete="off" class="layui-input">\n' +
						'            <div><fmt:message code="workflow.th.description2" />\n'+
						'                </div>\n' +
						'                </div>\n' +
						'            </div>\n' +
						'            <div class="layui-form-item">\n' +
						'                <label class="layui-form-label"><span class="red">*</span><fmt:message code="menuSSetting.th.menuName" /></label>\n' +
						'                <div class="layui-input-block">\n' +
						'                    <input type="text" name="addName"  id="addName" style="border: 1px solid #c0c0c0" lay-verify="title" autocomplete="off"  class="layui-input">\n' +
						'                </div>\n' +
						'            </div>\n' +
						'            <div class="layui-form-item">\n' +
						'                <label class="layui-form-label"><fmt:message code="workflow.th.module" /></label>\n' +
						'                <div class="layui-input-block">\n' +
						'                    <input type="text" name="addUrl"  id="addUrl"  style="border: 1px solid #c0c0c0;background-color: #e7e7e7;" readonly="readonly" lay-verify="title" autocomplete="off"  class="layui-input">\n' +
						'                </div>\n' +
						'            </div>\n' +
						'            <div class="layui-form-item" id="userBox" style="position:relative;">\n' +
						'                <label class="layui-form-label"><span class="red">*</span><fmt:message code="doc.th.Autho" /></label>\n' +
						'                <div class="layui-input-block">\n' +
						'                        <textarea id="privDuser"  style="width:580px;float: left;border: 1px solid #c0c0c0;background-color: #e7e7e7;"   readonly="readonly" class="layui-textarea"></textarea>\n' +
						'             <div>\n'+
						'                    <a class="addControls" data-type="priv" style="float: left;color: blue;padding: 0 10px;position: absolute;width:30px;top:80px;cursor: pointer;"><fmt:message code="global.lang.select" /></a>\n' +
						'                    <a style="float: left;color: blue;padding: 0 10px;position: absolute;width:30px;top:80px;margin-left:40px;cursor: pointer;" class="cleardate"><fmt:message code="global.lang.empty" /></a>\n' +
						'                </div>\n' +
						'                </div>\n' +
						'            </div>\n' +
						'        </form>\n' +
						'    </div>\n',
				area: ['800px', '500px'],
				offset: ['60px', '400px'],
				btn: ['<fmt:message code="global.lang.publish" />', '<fmt:message code="license.cancel" />'],
				success: function(layero){
					//选择角色
					$(".addControls").on("click",function() {
						priv_id = $(this).parents("#userBox").find("textarea").prop("id");
						$.popWindow("/common/selectPriv?1");
					})
					//清空角色
					$(".cleardate").on("click",function() {
						$(this).parents("#userBox").find("textarea").attr("privid","");
						$(this).parents("#userBox").find("textarea").attr("userpriv","");
						$(this).parents("#userBox").find("textarea").val("");
					})
					$("#addUrl").val('/newFilePub/DefineMenu?sortId='+id);
					//获取子菜单项ID
					$.ajax({
						url: '/getMenuId',
						dataType: 'json',
						type: 'post',
						success: function (res) {
							$("#addfId").val(res.object)
						}
					})
					selectMenu($('#addParentId'));
				},
				yes: function (index, layero) {
					//发布应用
					var privDuser = $("#privDuser").val();//授权角色
					var privDuserids =$("#privDuser").attr('privid');//授权角色id
					var fId =$("#addfId").val();
					var parentIdn = $("#addParentId").val();
					var idss =$("#addId").val();
					var names = $("#addName").val();
					var urls =$("#addUrl").val()
					if(fId=='' || parentIdn=='' || idss=='' ||names=='' || urls=='' ||privDuser==''){
						layer.msg("<fmt:message code="file.th.requiredTtemsCannotBeLeftBlank" />",{icon:5});
						return false;
					}else{
						console.log(urls);
						$.ajax({
							url: '/addFunction',
							data:{
								fId: fId,
								parentId: parentIdn,
								id: idss,
								name: names,
								url: urls,
								isopenNew: 0,
								isShowFunc: 0
							},
							type: 'get',
							success: function (res) {
								if(res.flag){
									layer.msg(res.msg, {icon: 1});
									$.ajax({
										url: '/updateUserPrivfuncIdStr',
										data:{
											privids: privDuserids,
											funcId: fId
										},
										type: 'post',
										success: function (res) {
											layui.layer.close(index);
											if(res.flag){
												layui.layer.msg("<fmt:message code="user.th.PublishSuccessfully" />", {icon: 1})
											}
										}
									})
								}else{
									layer.msg(res.msg, {icon: 5})
								}
							}
						});
					}

				},
				btn2:function(index,layer){
					//取消
					layui.layer.close(index);
				}
			})
		})
		//渲染下拉选择框的函数
		function selectMenu(element) {
			$.ajax({
				type: 'get',
				url: '/showMenu',
				dataType: 'json',
				success: function (rsp) {
					var data = rsp.obj;
					var str = '';
					str = queryMenuT(data, str);
					element.append(str);
					layui.form.render('select');
				}
			})
		}
		function queryMenuT(data, str) {
			for (var i = 0; i < data.length; i++) {
				if (data[i].id.length==2){
					str += '<option value="' + data[i].id + '">' + data[i].name + '</option>';
				}else{
					str += '<option value="' + data[i].id + '">' +"&nbsp;&nbsp;├"+data[i].name + '</option>';
				}

				if (data[i].child) {
					if (data[i].child.length > 0) {
						str = queryMenuT(data[i].child, str);
					}
				}

			}
			return str;
		}
		//2021.06.10 修改 结束=======
		function dataInit(){
			$('#table').find('.fileAdd').remove();
			$.ajax({
				type:'get',
				url:'/newFilePub/toFileSet',
				dataType:'json',
				success:function(res){
					var data=res.datas;
					var str='';
					for(var i=0;i<data.length;i++){
						str+='<tr class="fileAdd" sortId="'+data[i].sortId+'">' +
								'<td>'+data[i].sortNo+'</td><td>'+data[i].sortName+'</td>' +
								'<td><span id="BTAdd" style="color:#1772c0;margin-right: 10px;cursor: pointer;"><fmt:message code="global.lang.edit"/></span>' +
								'<span id="BAdd" class="deletBtn" style="color:#E01919;margin-right: 10px;cursor: pointer;"><fmt:message code="global.lang.delete"/></span>'+
								'<span id="BT_Add" style="color:#1772c0;margin-right: 10px;cursor: pointer;"><fmt:message code="netdisk.th.PermissionSetting"/></span>'+
								'<span id="BT_Copy" style="color:#1772c0;cursor: pointer;"><fmt:message code="netdisk.th.PermissionCopy"/></span>' +
								'<span id="BT_Re" style="color:#1772c0;cursor: pointer;margin-left:10px;"><fmt:message code="file.th.releaseMenu" /></span></td></tr>'
					}
					$('#table').append(str);
				}
			})
		}

		// 判断是否开启分支机构
		$.ajax({
			type: 'get',
			url: '/syspara/queryOrgScope',
			dataType: 'json',
			success: function (res) {
				if (res.object !== undefined && res.object.paraValue === "1") {
					isOrgScope = true;

					//获取当前登陆人 角色
					$.ajax({
						type:'get',
						url:'/getLoginUser',
						dataType:'json',
						success:function(res){
							if (res.object.branchDeptId !== undefined && res.object.branchDeptId !== "" && res.object.branchDeptName !== undefined && res.object.branchDeptName !== "") {
								branchDeptId = res.object.branchDeptId;
								branchDeptName = res.object.branchDeptName;
							}
						}
					})
				}
			}
		})

	})
</script>
</body>
</html>
