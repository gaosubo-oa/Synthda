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
	<meta name="viewport" content="width=device-width,maximum-scale=1.0,user-scalable=no,initial-scale=1.0">
	<title>固定资产详情</title>
	<script>
     (function (doc, win) {
                 var docEl = doc.documentElement,
                        resizeEvt = 'orientationchange' in window ? 'orientationchange' : 'resize',
                         recalc = function () {
                             var clientWidth = docEl.clientWidth;
                             if (!clientWidth) return;
                             if(clientWidth>=640){
                                     docEl.style.fontSize = '100px';
                                 }else{
                                     docEl.style.fontSize = 100 * (clientWidth / 640) + 'px';
                                 }
                         };

                 if (!doc.addEventListener) return;
                 win.addEventListener(resizeEvt, recalc, false);
                 doc.addEventListener('DOMContentLoaded', recalc, false);
             })(document, window);
     </script>
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
			font-size: 0.22rem;
			color: rgb(73, 77, 89);
			margin-left: 0.1rem;
			margin-right: 0.2rem;
			height:70px;
			line-height:70px;
			width:80%;
            text-align: center;
		}
		.headTop{
			position: relative;
		}
		.newClass{
			position:absolute;
			top:0;
			right:0;
			width: 0.9rem;
			height: 28px;
			background: url(../../img/file/cabinet01.png) no-repeat;
			color: #fff;
			font-size: 0.14rem;
			line-height: 28px;
			margin: 2% 3% 0 0;
			cursor: pointer;
		}

		.title{
			height:0.88rem;
			line-height: 0.88rem;
			background: #e4f0fa;
			font-size:0.28rem;
			color:#333;
			font-weight: bold;
		}
		.title h2{
			float: left;
			padding-left: 3%;
		}
		.box{
			display: block;
			float: left;
			width:0.08rem;
			height:0.28rem;
			background:#2f8ae3;
			margin-top: 0.3rem;
		}
		.cl{
			clear: both;
		}
		.w50{
			overflow: hidden;
		}
		.wid50{
			width:50%;
			float: left;


		}

		.minTit{
			display: inline-block;
			/*width:25%;*/
			float: left;
			height:0.5rem;
			line-height: 0.5rem;
		}
        .wid50 .minTit{

            height:0.42rem;
            line-height: 0.42rem;
            color:#3e3e3f;
        }
        .wid50 .con{
            height:0.42rem;
            line-height: 0.42rem;
            color:#797b7b;
        }
		.basicInfo{

			overflow: hidden;
			font-size: 0.26rem;

		}
		.con{
			height:0.5rem;
			line-height: 0.5rem;
			float: left;
		}
		.basicMain{
			padding:0.32rem 20px;
            color:#333;
			box-sizing: border-box;
			overflow: hidden;
		}
		#tr_td td{
			text-align: center;
		}
		.th{
			font-size: 0.15rem;
			width:10%;
		}
		.remark{
			width:30%;
		}
		td{
			font-size: 0.14rem;
		}
		#maintain,#atab{
			text-align: center;
		}
		.noneImg,.none{
			margin:10px auto;
		}
		.atabCard{
			background: url("/img/H5/atabCard.png") no-repeat;
			background-size: 100% 100%;
			height:150px;
			overflow: hidden;
			padding:0.2rem 0.4rem;
			margin:10px 0;
            font-size: 0.24rem;
		}
		.maintainCard{
			background: url("/img/H5/maintainCard.png") no-repeat;
			background-size: 100% 100%;
			height:190px;
			overflow: hidden;
			padding:0.2rem 0.4rem;
			margin:10px 0;
            font-size: 0.24rem;
		}
		.h3{
			color:#90a7c1;
			font-weight: bold;
			font-size: 0.28rem;
			height:0.6rem;
			line-height:0.6rem;
			text-align: left;

		}

	</style>
	<link rel="stylesheet" type="text/css" href="/css/commonTheme/${sessionScope.InterfaceModel}/commonTheme.css"/>
</head>
<body>
<div class="headTop" >
	<%--<div class="headImg">--%>
		<%--<img src="/img/commonTheme/${sessionScope.InterfaceModel}/fixAssetsManage.png">--%>
	<%--</div>--%>
	<%--<div class="divTitle ">--%>
		<%--固定资产详情--%>
	<%--</div>--%>
	<%--<div class="newClass" id="turn">--%>

            <%--<span style="margin-left: 30px;">--%>
                <%--<img style="margin-right: 4px;margin-left: -11px;margin-bottom: -2px;" src="../../img/mywork/newbuildworjk.png" alt="">--%>
                <%--返回--%>
            <%--</span>--%>
	<%--</div>--%>
<%--</div>--%>
<div class="cl"></div>
<div class="basicInfo">
	<div class="title"><span class="box"></span><h2>基本信息</h2></div>

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
		<div class="w50"><span class="minTit">资产原值：</span>
			<div class="con" id="cptlVal"></div>
		</div>
		<div class="w50"><span class="minTit">所在部门：</span>
			<div class="con" id="localAddress"></div>
		</div>
		<div class="w50"><span class="minTit">所在位置：</span>
			<div class="con" id="locationAddressName"></div>
		</div>
		<div class="w50"><span class="minTit">保管人：</span>
			<div class="con" id="custodion"></div>
		</div>
		<div class="w50"><span class="minTit"><fmt:message code="event.th.ArticleStatus" />：</span>
			<div class="con" id="status"></div>
		</div>
		<div class="w50"><span class="minTit"><fmt:message code="journal.th.Remarks" />：</span>
			<div class="con" id="remake"></div>
		</div>
		<div class="w50"><span class="minTit">录入人：</span>
			<div class="con" id="creater"></div>
		</div>
		<div class="w50"><span class="minTit">录入时间：</span>
			<div class="con" id="createrTime"></div>
		</div>
		<div class="w50"><span class="minTit">启用时间：</span>
			<div class="con" id="showQRCode"></div>
		</div>
		<div class="w50" style="margin-top:10px;"><span class="minTit"><fmt:message code="event.th.FixedAssetsPicture" />：</span>
			<div class="con" id="img" style="min-height:100px"></div>
		</div>
	</div>

</div>

<div class="atab">
	<div class="title"><span class="box"></span><h2>交接明细</h2></div>
	<div id="atab">

	</div>
</div>
<div class="maintain">
	<div class="title"><span class="box"></span><h2>维修明细</h2></div>
	<div id="maintain">

	</div>

</div>
</body>
</html>

<script>
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
                $("#cptlVal").html(data.cptlVal);
                if(data.deptId==0){
                    $("#localAddress").html(data.custodionName);
				}else {
                    $("#localAddress").html(data.deptName);
				}
                $("#locationAddressName").html(data.custodionName);
                $("#localAddress").attr("deptid",data.locationAddress);
                $("#custodion").html(data.custodionName);
                $("#custodion").attr("user_id",data.custodion);
                $("#status").html(turnStatus(data.status));
				/*$("#imageFile").val(data.imageFile);*/
                $("#remake").html(data.remark);
				/*   $("#QRcodeFile").val(data.QRcodeFile);*/
                $("#creater").html(data.creater);
               // $("#creater").attr("user_id",data.creater);
                $("#createrTime").html(data.createrTime);
                $("#showQRCode").html(data.fromYymm);
                var img ="";
                if(data.image!=''){
                    var data = data.image.split(",");
                    for(i=0;i<data.length;i++){
                        img += '<div style="margin-right:10px;" class="dech" ><image class="smallImg" style="max-width:100px;max_height:100px;" src="' + data[i]+ '"></div>';

                    }
                    $("#img").html(img)

                }
                var createrTime = data.createrTime;
                var id = data.id;
                var companyId = data.companyId;
                var obj ={"mark":"fixAssets","id":id,"createrTime":createrTime,"companyId":companyId};
                var text = JSON.stringify(obj);
               /* var qrcode = new QRCode(document.getElementById("showQRCode"), {
                    width : 100,//设置宽高
                    height : 100,
                    text:text
                });*/

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

            var str="";
            var data=obj.obj;
            if(obj.flag){
                if(data.length==0) {
                    $("#atab").append('<img  class="noneImg"  src="/img/main_img/shouyekong.png" alt=""><div class="none" >暂无数据</div>');
                    return
                }
                for(var i=0;i<data.length;i++){
                    str+='<div class="atabCard" id="'+data[i].id+'">'+
						'<h3 class="h3">交接明细卡</h3>'+
						'<div class="wid50"><span class="minTit">领用时间:</span><div class="con">'+turn(data[i].createTime)+'</div></div>'+
                        '<div class="wid50"><span class="minTit">领用部门:</span><div class="con">'+turn(data[i].depart)+'</div></div>'+
                        '<div class="wid50"><span class="minTit">领用人:</span><div class="con">'+turn(data[i].recipient)+'</div></div>'+
                        '<div class="wid50"><span class="minTit">是否归还:</span><div class="con">'+turn(data[i].conditions)+'</div></div>'+
                        '<div class="wid50"><span class="minTit">归还时间:</span><div class="con">'+turn(data[i].endtime)+'</div></div>'+
                        '<div class="cl"><span class="minTit" style="height:0.42rem;line-height: 0.42rem;color:#3e3e3f;">备注:</span><div class="con" style="height:0.42rem;line-height: 0.42rem;color:#797b7b;">'+turn(data[i].remarks)+'</div></div>'+
						'<div class="cl"></div></div>'


                }

                $("#atab").html(str);
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
            var str="";
            var data=obj.obj;
            if(obj.flag){
                if(data.length==0) {
                    $("#maintain").append('<img  class="noneImg"  src="/img/main_img/shouyekong.png" alt=""><div class="none" >暂无数据</div>');
                    return

                }
                for(var i=0;i<data.length;i++){
                    str+='<div class="maintainCard" id="'+data[i].id+'">'+
                        '<h3 class="h3" style="color:#ccae99;height:0.8rem;line-height: 0.8rem;">交接明细卡</h3>'+
                        '<div class="wid50"><span class="minTit">时间:</span><div class="con">'+turn(data[i].createTime)+'</div></div>'+
                        '<div class="wid50"><span class="minTit">商家电话:</span><div class="con">'+turn(data[i].phone)+'</div></div>'+
                        '<div class="wid50"><span class="minTit">当前使用者:</span><div class="con">'+turn(data[i].user)+'</div></div>'+
                        '<div class="wid50"><span class="minTit">商家联系人:</span><div class="con">'+turn(data[i].contact)+'</div></div>'+
                        '<div class="wid50"><span class="minTit">维修商家:</span><div class="con">'+turn(data[i].business)+'</div></div>'+
                        '<div class="wid50"><span class="minTit">送修人:</span><div class="con">'+turn(data[i].send)+'</div></div>'+
                        '<div class="cl"><span class="minTit" style="height:0.42rem;line-height: 0.42rem;color:#3e3e3f;">商家地址:</span><div class="con" style="height:0.42rem;line-height: 0.42rem;color:#797b7b;">'+turn(data[i].address)+'</div></div>'+
                        '<div class="cl"><span class="minTit" style="height:0.42rem;line-height: 0.42rem;color:#3e3e3f;">问题描述:</span><div class="con" style="height:0.42rem;line-height: 0.42rem;color:#797b7b;">'+turn(data[i].description)+'</div></div>'+
						'<div class="cl"></div></div>'
                }

                $("#maintain").html(str);
            }

        }
    })

</script>