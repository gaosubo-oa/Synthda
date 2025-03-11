<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="mvc" uri="http://www.springframework.org/tags/form" %>
<%@taglib prefix="fmt" uri="http://www.springframework.org/tags" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
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
	<script type="text/javascript" src="../js/xoajq/xoajq1.js"></script>
	<script src="../js/base/base.js" type="text/javascript" charset="utf-8"></script>
	<script src="../lib/layer/layer.js?20201106"></script>
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
	width: 50%;
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
	.ss a{font-size: 14px;display: block;font-family: 微软雅黑;letter-spacing: 1px;position: absolute;left: 25px;top: 1px;color: #fff;}
	.one{width:124px;height: 30px;background: url("../img/file/cabinet01.jpg") no-repeat;}
	.one a{height: 30px;  line-height: 30px;margin-left: 13px;}
input:hover {
	color: #0867c5;
}
	.divForm{margin-top: 20px}

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
/* 
 function submitDelete(data){
   <%--document.form2.action="${pageContext.request.contextPath}/fileDelete?sort_id="+"'"+data+"'";--%>
   document.form2.submit();
 } */
 
	</script>
</head>
<body>
	<div class="header">
		<div class="div_Img">
			<img src="/img/commonTheme/${sessionScope.InterfaceModel}/icon_fileSetting.png" style="vertical-align: middle;" alt="<fmt:message code="journal.th.MenuMain"/>">
		</div>
		<div class="divP"><fmt:message code="file.th.fileset"/></div>
		<div class="ss one"> <a id="newFile" href="javascript:;"><img style="margin-right: 4px;margin-left: -22px;margin-bottom: -1px;" src="../../img/mywork/newbuildworjk.png" alt=""><fmt:message code="adding.th.newF"/></a></div>
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
                         url: '../file/deleteAll',
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
             /*$(".deletBtn").click(function () {

                 //alert("确认删除？");
                 //window.location.href="${pageContext.request.contextPath}/file/deleteAll?sortId="+sortId;
                 var msg='确认是否删除？';
                 if (confirm(msg)==true){
                     window.location.href="${pageContext.request.contextPath}/file/deleteAll?sortId="+sortId;
                     return true;
                 }else{
                     return false;
                 }
             })*/

			 $('#newFile').click(function(){
                 layer.open({
                     title: ['<fmt:message code="adding.th.newF"/>', 'background-color:#2b7fe0;color:#fff;'],
                     shade: 0,
                     content: '<div style="margin-left: 30px;margin-top: 30px;"><span style="display: inline-block;width: 100px;height: 26px;text-align: left;line-height: 26px;"><fmt:message code="file.th.Sort"/>：</span><input type="number" name="number" value="" style="width: 220px;height: 26px;border:#ccc 1px solid;border-radius: 5px;color:#000;padding-left: 5px;"></div>'+
					          '<div style="margin-left: 30px;margin-top: 30px;"><span style="display: inline-block;width: 100px;height: 26px;text-align: left;line-height: 26px;"><fmt:message code="file.th.filename"/>：</span><input type="text" name="fileName" value="" style="width: 220px;height: 26px;border:#ccc 1px solid;border-radius: 5px;color:#000;padding-left: 5px;"></div>'+
					          '<div style="margin-left: 30px;margin-top: 30px;"><span style="display: inline-block;width: 100px;height: 26px;text-align: left;line-height: 26px;"><fmt:message code="netdisk.th.Maximumcapacity"/>：</span><input type="number" name="spaceLimit" value="" style="width: 220px;height: 26px;border:#ccc 1px solid;border-radius: 5px;color:#000;padding-left: 5px;"></div>',
                     area: ['500px', '350px'],
                     btn: ['<fmt:message code="global.lang.save"/>', '<fmt:message code="global.lang.close"/>'],
                     yes:function () {
                         var data={
                             "sortNo":$('input[name="number"]').val(),
							 "sortName":$('input[name="fileName"]').val(),
							 "spaceLimit":$('input[name="spaceLimit"]').val(),
							 "sortType":'5'
						 }
						 $.ajax({
							 type:'post',
							 url:'/file/add',
							 dataType:'json',
							 data:data,
							 success:function(res){
							     if(res.code==1001){
                                     $.layerMsg({content:res.msg,icon:1})
								 }else{
                                     $.layerMsg({content:'<fmt:message code="depatement.th.Newsuccessfully"/>！',icon:1},function(){
                                         dataInit();
                                     });
								 }
							 }
						 })
                     }
                 })
			 })

			 $('#table').on('click','#BTAdd',function(){
                 var sortId=$(this).parents('tr').attr("sortId");
                 layer.open({
                     title: ['<fmt:message code="sys.th.edit"/>', 'background-color:#2b7fe0;color:#fff;'],
                     shade: 0,
                     content: '<div style="margin-left: 30px;margin-top: 30px;"><span style="display: inline-block;width: 100px;height: 26px;text-align: left;line-height: 26px;"><fmt:message code="file.th.Sort"/>：</span><input type="number" name="number" value="" style="width: 220px;height: 26px;border:#ccc 1px solid;border-radius: 5px;color:#000;padding-left: 5px;"></div>'+
                              '<div style="margin-left: 30px;margin-top: 30px;"><span style="display: inline-block;width: 100px;height: 26px;text-align: left;line-height: 26px;"><fmt:message code="file.th.filename"/>：</span><input type="text" name="fileName" value="" style="width: 220px;height: 26px;border:#ccc 1px solid;border-radius: 5px;color:#000;padding-left: 5px;"></div>'+
                             '<div style="margin-left: 30px;margin-top: 30px;"><span style="display: inline-block;width: 100px;height: 26px;text-align: left;line-height: 26px;"><fmt:message code="netdisk.th.Maximumcapacity"/>：</span><input type="text" name="spaceLimit" value="" style="width: 220px;height: 26px;border:#ccc 1px solid;border-radius: 5px;color:#000;padding-left: 5px;"></div>',
                     area: ['500px', '350px'],
                     btn: ['<fmt:message code="depatement.th.modify"/>', '<fmt:message code="global.lang.close"/>'],
                     success:function(){
                         $.ajax({
							 type:'get',
							 url:'../file/fileGetOne',
							 dataType:'json',
							 data:{'sortId':sortId},
							 success:function(res){
							     var data1=res.object;
                                 $('input[name="number"]').val('');
                                 $('input[name="fileName"]').val('');
                                 $('input[name="spaceLimit"]').val('');

                                 $('input[name="number"]').val(data1.sortNo);
                                 $('input[name="fileName"]').val(data1.sortName);
                                 $('input[name="spaceLimit"]').val(data1.spaceLimit);
							 }
						 })
                     },
                     yes:function () {
                         var data={
                             "sortNo":$('input[name="number"]').val(),
                             "sortName":$('input[name="fileName"]').val(),
                             "spaceLimit":$('input[name="spaceLimit"]').val(),
                             "sortId":sortId
                         }
                         $.ajax({
                             type:'post',
                             url:'../file/update',
                             dataType:'json',
                             data:data,
                             success:function(res){
                                 if(res ==1 ){
                                     $.layerMsg({content:'<fmt:message code="depatement.th.Modifysuccessfully"/>！',icon:1},function(){
                                         dataInit();
                                     });
                                 }
                             }
                         })
                     }
                 })
			 })
             //权限设置点击事件
             $('#table').on('click','#BT_Add',function(){
                 var sortId=$(this).parents('tr').attr("sortId");
                 $.popWindow('../file/temp?sortId='+sortId+'','<fmt:message code="netdisk.th.PermissionSetting"/>','0','0','1300px','725px');
			 })
			 function dataInit(){
                 $('#table').find('.fileAdd').remove();
				$.ajax({
					type:'get',
					url:'../file/toFileSet',
					dataType:'json',
					success:function(res){
					    var str='';
					    for(var i=0;i<res.length;i++){
					        str+='<tr class="fileAdd" sortId="'+res[i].sortId+'"><td>'+res[i].sortNo+'</td><td>'+res[i].sortName+'</td><td><a href="javascript:;" id="BTAdd" style="color:1772c0;margin-right: 10px;"><fmt:message code="global.lang.edit"/></a><a href="javascript:;" id="BAdd" class="deletBtn" style="color:E01919;margin-right: 10px;"><fmt:message code="global.lang.delete"/></a><a href="javascript:;" id="BT_Add" style="color:1772c0;"><fmt:message code="netdisk.th.PermissionSetting"/></a></td></tr>'
						}
						$('#table').append(str);
					}
				})
			 }
         })
	</script>
</body>
</html>
