<%--需把局部样式归并为一个通用或符合公告管理的公共样式，
接口对完需调整--%>

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
	<title>固定资产详情</title>
	<link rel="stylesheet" type="text/css" href="../css/news/center.css"/>
	<link rel="stylesheet" type="text/css" href="../lib/pagination/style/pagination.css"/>
	<link rel="stylesheet" type="text/css" href="../css/base.css" />
	<link rel="stylesheet" href="/lib/layer/skin/default/layer.css">
	<script src="../js/xoajq/xoajq1.js" type="text/javascript" charset="utf-8"></script>
	<script src="../js/base/base.js" type="text/javascript" charset="utf-8"></script>
	<script src="../lib/pagination/js/jquery.pagination.min.js" type="text/javascript" charset="utf-8"></script>
	<link rel="stylesheet" type="text/css" href="../css/news/new_news.css"/>
	<!-- word文本编辑器 -->
	<script src="../lib/ueditor/ueditor.config.js" type="text/javascript" charset="utf-8"></script>
	<script src="../lib/ueditor/ueditor.all.js" type="text/javascript" charset="utf-8"></script>
	<script src="../../lib/laydate/laydate.js"></script>
	<script src="../../lib/layer/layer.js?20201106"></script>
	<script src="/js/jquery/jquery.form.min.js"></script>
	<script type="text/javascript" src="/lib/qrcode.js"></script>
	<style>
		body{
			margin:0px;
		}
		.headImg {
			display: inline-block;
			float: left;
			margin-top:22px;
		}
		.divTitle{
			font-size: 22px;
			color: rgb(73, 77, 89);
			margin-left: 10px;
			margin-right: 20px;
			height:70px;
			line-height:70px;
			width:80%;
		}
		.headTop{
			position: relative;
		}
		.newClass{
			position:absolute;
			top:0;
			right:0;
			width: 90px;
			height: 28px;
			background: url(../../img/file/cabinet01.png) no-repeat;
			color: #fff;
			font-size: 14px;
			line-height: 28px;
			margin: 2% 3% 0 0;
			cursor: pointer;
		}

		.title{
			height:40px;
			line-height: 40px;
			background: #e4f0fa;
			color:#2f5c8f;
			font-size:18px;
			padding-left:3%;
			font-weight: bold;
		}
		.cl{
			clear: both;
		}
		.w50{
			width:50%;
			float: left;
		}
		.minTit{
			display: inline-block;
			/*width:25%;*/
			float: left;
			height:28px;
			line-height: 28px;
		}
		.basicInfo{
			overflow: hidden;
			font-size: 14px;
			position: relative;

		}
		.box{
			position: absolute;
			top:10px;
			left:0;
			width:8px;
			height:20px;
			background: #1387de;
		}
		.con{
			line-height: 28px;
			float: left;
			min-height: 28px;
		}
		.basicMain{
			padding:10px 20px;
			box-sizing: border-box;
			overflow: hidden;

		}
		.showQRCode{
			position:absolute;
			top:85px;
			right:10%;
		}
		#tr_td td{
			text-align: center;
		}
		.th{
			font-size: 15px;
			width:10%;
		}
		.remark{
			width:30%;
		}
		td{
			font-size: 14px;
		}
		#maintain,#atab{
			text-align: center;
		}
		.noneImg,.none{
			margin:10px auto;
		}
		.maintain,.atab{
			position:relative;
		}
	</style>
	<link rel="stylesheet" type="text/css" href="/css/commonTheme/${sessionScope.InterfaceModel}/commonTheme.css"/>
</head>
<body>
<div class="headTop" style="margin-left: 30px">
	<div class="headImg">
		<img src="/img/commonTheme/${sessionScope.InterfaceModel}/fixAssetsManage.png">&nbsp;&nbsp;
	</div>
	<sapn class="divTitle ">
		固定资产详情
	</sapn>
	<%--<div class="newClass" id="turn">--%>

	<%--<span style="margin-left: 30px;">--%>
	<%--<img style="margin-right: 4px;margin-left: -11px;margin-bottom: -2px;" src="../../img/mywork/newbuildworjk.png" alt="">--%>
	<%--返回--%>
	<%--</span>--%>
	<%--</div>--%>
</div>
<div class="cl"></div>
<div class="basicInfo">
	<h2 class="title" >基本信息</h2>
	<div class="box"></div>
	<div class="basicMain">
		<div class="w50"><span class="minTit"><fmt:message code="event.th.FixedAssetNumber" />：</span>
			<div class="con" id="id"></div>
		</div>
		<div class="w50"><span class="minTit"><fmt:message code="event.th.AssetName"/>:</span>
			<div class="con" id="assetsName"></div>
		</div>
		<div class="w50"><span class="minTit"><fmt:message code="event.th.BuyTime" />：</span>
			<div class="con" id="buyTime"></div>
		</div>
		<div class="w50"><span class="minTit">品牌型号：</span>
			<div class="con" id="info"></div>
		</div>
		<div class="w50"><span class="minTit"><fmt:message code="event.th.Number" />：</span>
			<div class="con" id="number"></div>
		</div>
		<div class="w50"><span class="minTit">所在部门：</span>
			<div class="con" id="deptName"></div>
		</div>
		<div class="w50"><span class="minTit">保管人：</span>
			<div class="con" id="keeper"></div>
		</div>
		<div class="w50"><span class="minTit"><fmt:message code="event.th.ArticleStatus" />：</span>
			<div class="con" id="status"></div>
		</div>
		<div class="w50"><span class="minTit">调度人：</span>
			<div class="con" id="keepers"></div>
		</div>
		<div class="w50"><span class="minTit"><fmt:message code="journal.th.Remarks" />：</span>
			<div class="con" id="remark"></div>
		</div>


		<div class="w50"><span class="minTit">资产类型：</span>
			<div class="con" id="typeName"></div>
		</div>
		<div class="w50"><span class="minTit">出厂编号：</span>
			<div class="con" id="factoryNo"></div>
		</div>
		<div class="w50"><span class="minTit">资产性质：</span>
			<div class="con" id="cptlKind"></div>
		</div>
		<div class="w50"><span class="minTit">增加类型：</span>
			<div class="con" id="prcsId"></div>
		</div>
		<%--<div class="w50"><span class="minTit">减少类型：</span>
			<div class="con" id="dcrPrcsId"></div>
		</div>--%>
		<div class="w50"><span class="minTit">启用日期：</span>
			<div class="con" id="fromYymm"></div>
		</div>
		<div class="w50"><span class="minTit">有效日期：</span>
			<div class="con" id="validityTime"></div>
		</div>
		<div class="w50"><span class="minTit">减少日期：</span>
			<div class="con" id="dcrDate"></div>
		</div>
		<div class="w50"><span class="minTit">报废日期：</span>
			<div class="con" id="logoutTime"></div>
		</div>
		<div class="w50"><span class="minTit">是否为固定资产：</span>
			<div class="con" id="isAssets"></div>
		</div>
		<div class="w50"><span class="minTit">目前所在位置：</span>
			<div class="con" id="currutLocation"></div>
		</div>
		<div class="w50"><span class="minTit">是否有证书：</span>
			<div class="con" id="isCertificate"></div>
		</div>
		<div class="w50"><span class="minTit">证书编号：</span>
			<div class="con" id="certificateNo"></div>
		</div>
		<%--<div class="w50"><span class="minTit">证书附件ID：</span>--%>
		<%--<div class="con" id="attachmentId"></div>--%>
		<%--</div>--%>
		<div class="w50"><span class="minTit">证书附件名称：</span>
			<div class="con" id="attachmentName"></div>
		</div>
		<div class="w50"><span class="minTit">资产原值：</span>
			<div class="con" id="cptlVal"></div>
		</div>
		<div class="w50"><span class="minTit">净残值率：</span>
			<div class="con" id="cptlBal"></div>
		</div>
		<div class="w50"><span class="minTit">净残值：</span>
			<div class="con" id="cptlBalVal"></div>
		</div>
		<div class="w50"><span class="minTit">折旧年限：</span>
			<div class="con" id="dpctYy"></div>
		</div>
		<div class="w50"><span class="minTit">使用年限：</span>
			<div class="con" id="useYy"></div>
		</div>
		<div class="w50"><span class="minTit">累计折旧：</span>
			<div class="con" id="sumDpct"></div>
		</div>
		<div class="w50"><span class="minTit">折旧额：</span>
			<div class="con" id="monDpct"></div>
		</div>
		<div class="w50"><span class="minTit">资产净值：</span>
			<div class="con" id="worth"></div>
		</div>
		<div class="w50"><span class="minTit">本年计提折旧：</span>
			<div class="con" id="yyDpct"></div>
		</div>
		<div class="w50"><span class="minTit">已计提月份：</span>
			<div class="con" id="monAccrual"></div>
		</div>
		<div class="w50"><span class="minTit"><fmt:message code="file.th.builder" />：</span>
			<div class="con" id="creater"></div>
		</div>
		<div class="w50"><span class="minTit"><fmt:message code="notice.th.createTime" />：</span>
			<div class="con" id="createrTime"></div>
		</div>
		<div class="w50"><span class="minTit">条形码：</span>
			<div class="con" id="barCode"></div>
		</div>
		<div class="w50"><span class="minTit">资产等级：</span>
			<div class="con" id="capitalLevel"></div>
		</div>
		<div class="w50"><span class="minTit">制造厂商：</span>
			<div class="con" id="manuFacturer"></div>
		</div>
		<div class="w50"><span class="minTit">出厂日期：</span>
			<div class="con" id="manuDate"></div>
		</div>
		<div class="w50"><span class="minTit">计量单位：</span>
			<div class="con" id="unitId"></div>
		</div>
		<div class="w50"><span class="minTit">财务编号：</span>
			<div class="con" id="fnamark"></div>
		</div>
		<div class="w50"><span class="minTit">预警数量：</span>
			<div class="con" id="alertNum"></div>
		</div>
		<div class="w50"><span class="minTit">发票号码：</span>
			<div class="con" id="invoice"></div>
		</div>
		<div class="w50"><span class="minTit">合同号：</span>
			<div class="con" id="contractNo"></div>
		</div>
		<div class="w50"><span class="minTit">设备名称(英文)：</span>
			<div class="con" id="assetsNameEnglish"></div>
		</div>
		<div class="w50"><span class="minTit">设备代码：</span>
			<div class="con" id="deviceCode"></div>
		</div>
		<div class="w50"><span class="minTit">折旧方法：</span>
			<div class="con" id="depreciationMethod"></div>
		</div>
		<%--<div class="cl" style="margin-top:-72px;"><span class="minTit"><fmt:message code="event.th.FixedAssetsPicture" />：</span>--%>
		<%--<div class="con" id="img" style="min-height:100px"></div>--%>
		<%--</div>--%>
	</div>
	<div class="showQRCode">
		<div id="showQRCode" style="height:100px"></div>
		<span style="display:block;width: 100px;height: 28px;line-height: 28px;text-align: center;"><fmt:message code="doc.th.QRCode" /></span>
	</div>

</div>

<div class="atab">
	<h2 class="title">交接明细</h2>
	<div class="box"></div>
	<div id="atab">
		<table id="tr_td" style="margin:10px 1%;width: 98%;" >

		</table>
	</div>
</div>
<div class="maintain">
	<h2 class="title">维修明细</h2>
	<div class="box"></div>
	<div id="maintain">
		<table id="tr_td1" style="margin:10px 1%;width: 98%;" >

		</table>
	</div>

</div>
</body>
</html>

<script>
	$.ajax({
		type:'get',
		url:'/syspara/selectTheSysPara?paraName=IS_SHOW_JMJ',
		dataType:'json',
		success:function (res) {
			if(res.object.length!=0){
				var data=res.object[0]
				if (data.paraValue!=0){
					$('.divTitle ').after('<span style="color: red;font-family: Microsoft YaHei;font-weight: bolder;font-size: 16pt;margin-left: 20px;margin-top: 10px;"> 机密级★ </span>')
				}
			}
		}
	})
	//undefined转换
	function turn(data){
		if(data==undefined){
			return "";
		}else{
			return data;
		}
	}
	//返回上级页面
	$("#turn").click(function () {
		window.location.href = "/eduFixAssets/fixAssetsManager";
	})
	var id =$.GetRequest().id;
	//物品使用状态
	function turnStatus(n){
		switch(n){
			case  "1":
				return "未使用";
			case  "2":
				return "使用";
			case  "3":
				return "损坏";
			case  "4":
				return "丢失";
			case  "5":
				return "废弃";
			default:
				return "正常";
		}
	}
	//请求固定资产详情
	$.ajax({
		url: '/eduFixAssets/selFixAssetsById',
		type: 'get',
		data:{
			id:id,
		},
		dataType: 'json',
		success: function (obj) {
			var data=obj.object;
			if(obj.flag){
				$("#id").html(data.id);
				$("#assetsName").html(data.assetsName);
				$("#buyTime").html(data.buyTime);
				$("#info").html(data.info);
				$("#number").html(data.number);
				$("#keeper").html(data.keeperName);
				$("#keepers").html(data.schedulerName);
				/*$("#deptName").html(data.deptName);*/
                if(data.deptId==0){
                    $("#localAddress").html(data.custodionName);
                }else {
                    $("#localAddress").html(data.deptName);
                }
				$("#creater").html(data.creater);
				$("#typeName").html(data.typeName);
				$("#factoryNo").html(data.factoryNo);
				$("#cptlKind").html(data.cptlKindStr);
				$("#prcsId").html(data.prcsIdStr);
				$("#dcrPrcsId").html(data.dcrPrcsId);
				if(data.fromYymm=='0000-00-00'){
                    $("#fromYymm").html('');
				}else{
                    $("#fromYymm").html(data.fromYymm);
				}
				$("#validityTime").html(data.validityTime);
				$("#dcrDate").html(data.dcrDate);
				$("#logoutTime").html(data.logoutTime);
				if(data.isAssets==0||data.isAssets=='0'){
					$("#isAssets").html('否');
				}else if(data.isAssets==1||data.isAssets=='`'){
					$("#isAssets").html('是');
				}
				// $("#isAssets").html(data.isAssets);
				$("#currutLocation").html(data.custodionName);
				if(data.isCertificate==0||data.isCertificate=='0'){
					$("#isCertificate").html('否');
				}else if(data.isCertificate==1||data.isCertificate=='`'){
					$("#isCertificate").html('是');
				}
				// $("#isCertificate").html(data.isCertificate);
				$("#certificateNo").html(data.certificateNo);
				$("#attachmentId").html(data.attachmentId);
//                $("#attachmentName").html(data.attachmentName);
				$("#cptlVal").html(data.cptlVal);
				$("#cptlBal").html(data.cptlBal);
				$("#cptlBalVal").html(data.cptlBalVal);
				$("#dpctYy").html(data.dpctYy);
				$("#useYy").html(data.useYy);
				$("#sumDpct").html(data.sumDpct);
				$("#monDpct").html(data.monDpct);
				$("#worth").html(data.worth);
				$("#yyDpct").html(data.yyDpct);
				$("#monAccrual").html(data.monAccrual);
				$("#localAddress").html(data.locationAddressName);
				$("#localAddress").attr("deptid",data.locationAddress);
				$("#custodion").html(data.custodionName);
				$("#custodion").attr("user_id",data.custodion);
				$("#status").html(turnStatus(data.status));
				/*$("#imageFile").val(data.imageFile);*/
				$("#remark").html(data.remark);
				/*   $("#QRcodeFile").val(data.QRcodeFile);*/
				//$("#creater").html(data.createrName);
				//$("#creater").attr("user_id",data.creater);
				$("#createrTime").html(data.createrTime);

				$("#otherDept").html(data.otherDept);
				$("#barCode").html(data.barCode);
				$("#capitalLevel").html(data.capitalLevel);
				$("#manuFacturer").html(data.manuFacturer);
				$("#manuDate").html(data.manuDate);
				$("#unitId").html(data.unitId);
				$("#fnamark").html(data.fnamark);
				$("#alertNum").html(data.alertNum);
				$("#invoice").html(data.invoice);
				$("#contractNo").html(data.contractNo);
				$("#assetsNameEnglish").html(data.assetsNameEnglish);
				$("#deviceCode").html(data.deviceCode);
				$("#depreciationMethod").html(data.depreciationMethod);
				var img ="";
				if(data.image!=''){
					if(data.image.indexOf(",")==-1){
						img += '<div style="float:left;position:relative;margin-right:10px;" class="dech" ><image class="smallImg" style="max-width:100px;max_height:100px;" src="' + data.image+ '"></div>';
					}else{
						var data = data.image.split(",");


						for(i=0;i<data.length;i++){
							img += '<div style="float:left;position:relative;margin-right:10px;" class="dech" ><image class="smallImg" style="max-width:100px;max_height:100px;" src="' + data[i]+ '"></div>';

						}
					}

					$("#img").html(img)

				}
				var arr = data.attachmentList;
				var str1="";
				if (arr != ''&&arr!=undefined) {
					for (var i = 0; i < (arr.length); i++) {
						str1+='<div class="dech" deUrl="'+encodeURI(arr[i].attUrl)+'" style="display:block;float:left;margin-right:20px;/fixAssetsManager"><a class="ATTACH_a" NAME="'+arr[i].attachName+'*" href="/download?'+encodeURI(arr[i].attUrl)+'">'+arr[i].attachName+'</a></div>';
					}
					$('#attachmentName').append(str1);
				};
				var createrTime = data.createrTime;
				var id = data.id;
				var companyId = data.companyId;
				var obj ={"mark":"fixAssets","id":id,"createrTime":createrTime,"companyId":companyId};
				var text = JSON.stringify(obj);
				var qrcode = new QRCode(document.getElementById("showQRCode"), {
					width : 100,//设置宽高
					height : 100,
					text:text
				});

//
			}
		}
	})
	//请求交接明细
	$.ajax({
		url:"/Atab/selectByExampleWithBLOBs",
		type:"get",
		data:{
			uid:id
		},
		dataType:"json",
		success:function(obj){
			$("#tr_td").html("");
			var str="";
			var data=obj.obj;
			if(obj.flag){
				if(data.length==0) {
					$("#atab").append('<img  class="noneImg"  src="/img/main_img/shouyekong.png" alt=""><div class="none" >暂无数据</div>');
					return
				}


				str+=	'<thead><tr>'+
						'<th class="th">领用时间</th>'+
						'<th class="th">领用部门</th>'+
						'<th class="th" >领用人</th>'+
						'<th class="th">是否归还</th>'+
						'<th class="th">归还时间</th>'+
						'<th class="th remark">备注</th>'+
						'</tr></thead> <tbody id="j_tb">';
				for(var i=0;i<data.length;i++){
					str+='<tr id="'+data[i].id+'">' +
							'<td>'+turn(data[i].createTime)+'</td>' +
							'<td>'+turn(data[i].depart)+'</td>' +
							'<td>'+turn(data[i].recipient)+'</td>' +
							'<td>'+turn(data[i].conditions)+'</td>' +
							'<td>'+turn(data[i].endtime)+'</td>' +
							'<td>'+turn(data[i].remarks)+'</td></tr>';
					<%--str+= '<td>' +--%>
					<%--'<a class="edit_btn" id="'+data[i].id+'"><fmt:message code="global.lang.edit" /></a>' +--%>
					<%--' &nbsp;' +--%>
					<%--'<span class="del_btn" id="'+data[i].id+'"><fmt:message code="global.lang.delete" /></span></td>' +--%>
					<%--'</tr>';--%>
				}
				str+='</tbody>'
				$("#tr_td").html(str);
			}

		}
	})
	//维修明细
	$.ajax({
		url:"/Maintain/selectByExample",
		type:"get",
		data:{
			uid:id
		},
		dataType:"json",
		success:function(obj){
			$("#tr_td1").html("");

			var str="";
			var data=obj.obj;
			if(obj.flag){
				if(data.length==0) {
					$("#maintain").append('<img  class="noneImg"  src="/img/main_img/shouyekong.png" alt=""><div class="none" >暂无数据</div>');
					return

				}
				str+='<thead><tr>'+
						'<th class="th">时间</th>'+
						'<th class="th">当前使用者</th>'+
						'<th class="th" >问题描述</th>'+
						'<th class="th">维修商家</th>'+
						'<th class="th">商家联系人</th>'+
						'<th class="th">商家电话</th>'+
						'<th class="th">商家地址</th>'+
						'<th class="th">送修人</th>'+
						'</tr></thead><tbody id="j_tb1">';
				for(var i=0;i<data.length;i++){
					str+='<tr id="'+data[i].id+'">' +
							'<td>'+turn(data[i].createTime)+'</td>' +
							'<td>'+turn(data[i].user)+'</td>' +
							'<td>'+turn(data[i].description)+'</td>' +
							'<td>'+turn(data[i].business)+'</td>' +
							'<td>'+turn(data[i].contact)+'</td>' +
							'<td>'+turn(data[i].phone)+'</td>' +
							'<td>'+turn(data[i].address)+'</td>'+
							'<td>'+turn(data[i].send)+'</td>' ;
					<%--str+= '<td>' +--%>
					<%--'<a class="edit_btn" id="'+data[i].id+'"><fmt:message code="global.lang.edit" /></a>' +--%>
					<%--' &nbsp;' +--%>
					<%--'<span class="del_btn" id="'+data[i].id+'"><fmt:message code="global.lang.delete" /></span></td>' +--%>
					<%--'</tr>';--%>
				}
				str+='</tbody>';
				$("#tr_td1").html(str);
			}

		}
	})

</script>