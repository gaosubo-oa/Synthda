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
	<title><fmt:message code="main.assetquery" /></title>
	<link rel="stylesheet" type="text/css" href="../css/news/center.css"/>
	<link rel="stylesheet" type="text/css" href="../lib/pagination/style/pagination.css"/>
	<link rel="stylesheet" type="text/css" href="../css/base.css" />
	<link rel="stylesheet" href="/lib/layer/skin/default/layer.css">
	<script src="../js/xoajq/xoajq3.js" type="text/javascript" charset="utf-8"></script>
	<script src="../js/base/base.js" type="text/javascript" charset="utf-8"></script>
	<script src="../lib/pagination/js/jquery.pagination.min.js" type="text/javascript" charset="utf-8"></script>
	<link rel="stylesheet" type="text/css" href="../css/news/new_news.css"/>
	<!-- word文本编辑器 -->
	<script src="../lib/ueditor/ueditor.config.js" type="text/javascript" charset="utf-8"></script>
	<script src="../lib/ueditor/ueditor.all.js" type="text/javascript" charset="utf-8"></script>
	<script src="../../lib/laydate/laydate.js"></script>
	<script src="../../lib/layer/layer.js?20201106"></script>
	<script src="/js/jquery/jquery.form.min.js"></script>
	<style>
		body{
			margin-top:65px;
		}
		#cont_totals td{
			color: #000;
			font-weight: normal;
		}
		table{
			table-layout:fixed;
		}
		#tr_td tr td.publishtip {
			overflow: hidden;
			text-overflow:ellipsis;
			height: 40px;
			width: 40px;
			white-space:nowrap;
		}
		.news_t h1,.news_two h1{
			line-height: 23px;
			text-align: center;
		}
		.add_print h1,.add_down h1{
			color: #000;
			line-height: 20px;
			text-align: center;
		}
		.title a{
			color: #59b7fb;
		}
		.caozuo a:hover{
			color:#287fe0;
		}
		.center .login .icons{
			padding-left:180px;
		}
		.center .login .icons div{
			margin-left:9px !important;
		}

		.icons div {
			float: left;
			line-height: 30px;
		}
		#daochu{
			background: url(../../img/news/new_export.png) no-repeat;
		}
		#btn_query{
			background: url(../img/file/cabinet03.png) no-repeat;
		}
		.icons h2{
			text-align: center;
			width: 71%;
		}
		table tr td input {
			height: 25px;
			border: #ccc 1px solid;
			padding-left: 5px;
		}
		.notice_top h2,.notice_notop h2,.delete_check h2,.delete_all h2{
			text-align: left;
			margin-left: 12px;
		}
		.navigation{
			/*display: inline-block;*/
			float: left;
			width: 96% !important;
			margin-left: 30px;
		}
		table td{
			overflow: hidden;
			text-overflow: ellipsis;
			white-space: nowrap;
		}
		.le input[type='text']{
			height: 26px;
			width: 174px;
		}
		.le input[type='radio']{
			height: 14px;
			margin-top: -3px;
		}
		#tr_td td{
			text-align: center;
		}
		.del_btn {
			color: #E01919;
			cursor: pointer;
		}
		.edit_btn {
			color: #1772C0;
			cursor: pointer;
		}
		.hanld{
			overflow: visible;
			text-overflow:clip;
			white-space:pre-wrap;
		}
		.notice_do{
			width:16%;
		}
		td.assetName a{
			display: block;
			width:100%;
			max-width: 150px;
			color: #1772C0;
			cursor: pointer;
			overflow: hidden;
			text-overflow:ellipsis;
			white-space: nowrap;
		}
		.edit_btn,.Handover_btn,.Maintain_btn,.detail_btn{
			color: #1772C0;
			cursor: pointer;
		}
		.imgDiv{
			text-align: center;
			display: none;
			margin-top: 60px;
		}
		.cl{
			clear: both;
		}
	</style>
	<link rel="stylesheet" type="text/css" href="/css/commonTheme/${sessionScope.InterfaceModel}/commonTheme.css"/>
</head>
<body>
<div class="bx">
	<div class="center">
		<div class="navigation  clearfix" style="margin-top: -66px;">
			<div>
				<p style="margin:10px 0 0 10px">
					<img src="/img/commonTheme/${sessionScope.InterfaceModel}/fixAssetsQuery.png" style="display: block;float: left">
					<span style="font-size: 18px;margin: 6px 0 10px 5px;color: black;display: block;float: left">资产查询</span>
				</p>
			</div>
		</div>
		<div class="login" style="margin-bottom: 10px">
			<div class="header">
				<fmt:message code="event.th.PleaseCriteria" />
			</div>
			<form id="queryFixAssets">
				<div class="middle">
					<%--固定资产编号--%>
					<div class="le ce1">
						<div class="color" style="width:145px;">
							<fmt:message code="event.th.FixedAssetNumber" /> ：
						</div>
						<div>
							<input id="id" name="id" type="text"  value="${eduFixAssets.id}"/>
						</div>
					</div>
					<%--所在位置--%>
					<div class="le ce1">
						<div class="color" style="width:145px;">
							所在位置：
						</div>
						<div>
							<input id="currutLocation" placeholder="可根据关键字查询" name="currutLocation" value="${eduFixAssets.currutLocation}" type="text"/>
						</div>
					</div>

					<%--资产名称--%>
					<div class="le ce1">
						<div class="color" style="width:145px;"> <fmt:message code="event.th.AssetName" />：</div>
						<div>
							<input id="assetsName" name="assetsName" placeholder="可根据关键字查询" type="text" value="${eduFixAssets.assetsName}">
						</div>
					</div>

					<%--购买时间--%>
					<div class="le ce1">
						<div class="color" style="width:145px;"><fmt:message code="event.th.BuyTime" />：</div>
						<div>
							<input id="buyTime"  value="${eduFixAssets.buyTimeStr}" name="buyTimeStr" type="text" onclick="laydate({istime: true, format: 'YYYY-MM-DD'})">
						</div>
					</div>
					<%--品牌型号--%>
					<div class="le ce1">
						<div class="color" style="width:145px;"><fmt:message code="event.th.Information" />：</div>
						<div>
							<input id="info" name="info" placeholder="可根据关键字查询" type="text" value="${eduFixAssets.info}">
						</div>
					</div>
					<%--数量--%>
					<div class="le ce1">
						<div class="color" style="width:145px;"> <fmt:message code="event.th.Number" />：</div>
						<div>
							<input id="number" name="number" type="text" value="${eduFixAssets.number}">
						</div>
					</div>
					<%--部门--%>
					<div class="le publisher">
						<div class="color" style="width:145px;">部门：</div>
						<textarea name="locationAddressName" id="locationAddressName" class="locationAddressName" deptId="${eduFixAssets.deptId}"  cols="26" disabled readonly>${eduFixAssets.deptName}</textarea>
						<a href="javascript:;" class="addAddress" style="color:#207bd6"><fmt:message code="global.lang.add" /></a>
						<a href="javascript:;" class="clearAddress" style="color:#207bd6" onclick="emptyDept('locationAddressName')"><fmt:message code="global.lang.empty" /></a>
					</div>
					<%--  使用保管人--%>
					<div class="le publisher">
						<div class="color" style="width:145px;"><fmt:message code="event.th.Custodian" />：</div>
						<textarea name="custodionName" id="custodionName" class="custodionName" user_id="" dataid="${eduFixAssets.keeper}" cols="26" disabled readonly>${eduFixAssets.keeperName}</textarea>
						<a href="javascript:;" class="addCustodion" style="color:#207bd6"><fmt:message code="global.lang.add" /></a>
						<a href="javascript:;" class="clearCustodion" style="color:#207bd6" onclick="emptyUser('custodionName')"><fmt:message code="global.lang.empty" /></a>
					</div>
					<%--      物品状态--%>
					<div class="le ce1">
						<div class="color" style="width:145px;"><fmt:message code="event.th.ArticleStatus" />：</div>
						<div>
							<select name="status" id="status">
								<option value=""><fmt:message code="hr.th.PleaseSelect" /></option>
								<option value="1"><fmt:message code="event.th.notUsed" /></option>
								<option value="2"><fmt:message code="evvent.th.Use" /></option>
								<option value="3"><fmt:message code="event.th.damage" /></option>
								<option value="4"><fmt:message code="event.th.Lose" /></option>
								<option value="5"><fmt:message code="event.th.Scrap" /></option>
							</select>
						</div>
					</div>
					<%--  类别--%>
					<div class="le ce1">
						<div class="color" style="width:145px;">类别：</div>
						<div>
							<select name="typeIdStr" id="typeId" style="height: 30px;width: 85px"/>
							<input type="text" style="display: none" >

						</div>
					</div>
					<div class="le publisher">
						<div class="color" style="width:145px;">创建人：</div>
						<textarea name="createrName" id="createrName" class="createrName" user_id="" dataid="${eduFixAssets.creater}" cols="26" disabled readonly>${eduFixAssets.createrName}</textarea>
						<a href="javascript:;" class="addCreater" style="color:#207bd6">添加</a>
						<a href="javascript:;" class="clearCreater" style="color:#207bd6" onclick="emptyUser('createrName')">清空</a>
					</div>
					<%--<div class="le ce1">--%>

					<%--<div class="color" style="width:145px;">创建人：</div>--%>
					<%--<div>--%>
					<%--<input id="createrName" name="createrName" type="text" value="">--%>
					<%--</div>--%>
					<%--</div>--%>
					<div class="le ce1">
						<div class="color" style="width:145px;">创建时间：</div>
						<div>
							<input id="createrTime" value="${eduFixAssets.createrTimeStr}" name="createrTimeStr" type="text" onclick="laydate({istime: true, format: 'YYYY-MM-DD'})">
						</div>
					</div>

					<div class="le ce1">
						<div class="color" style="width:145px;">有效时间：</div>
						<div>
							<input id="validityTime" value="${eduFixAssets.validityTimeStr}" name="validityTimeStr" type="text" onclick="laydate({istime: true, format: 'YYYY-MM-DD'})">
						</div>
					</div>

					<div class="le ce1">
						<div class="color" style="width:145px;">启用日期：</div>
						<div>
							<input id="fromYymm"  name="fromYymmStr" type="text" value="${eduFixAssets.fromYymmStr}" onclick="laydate({istime: true, format: 'YYYY-MM-DD'})">
						</div>
					</div>

					<div class="le ce1">
						<div class="color" style="width:145px;">报废日期：</div>
						<div>
							<input id="logoutTime" value="${eduFixAssets.logoutTimeStr}" name="logoutTimeStr" type="text" onclick="laydate({istime: true, format: 'YYYY-MM-DD'})">
						</div>
					</div>

					<div class="le ce1" style="padding: 2px">
						<div><input type="radio" name="condition" value="3" style="" checked><span style="font-size: 15px"><fmt:message code="event.th.Satisfy" />&nbsp;&nbsp;&nbsp;&nbsp;</span></div>
						<div><input type="radio" name="condition" value="2" style="margin-left: 14px;"><span  style="font-size: 15px"><fmt:message code="event.th.ConcurrentSatisfaction" /></span></div><div><input type="radio" name="apex" value="5" style="margin-left: 14px;"><span  style="font-size: 15px">保存本次查询</span></div>
					</div>
				</div>
			</form>
			<div class="icons" style="padding-left:180px;">
				<div id="btn_query"  style="margin-right:10px; cursor: pointer;" onclick="queryFixAssetsByCond(0) "><h2><fmt:message code="global.lang.query" /></h2></div>
				<div id="daochu"  style="margin-right:10px; cursor: pointer;" onclick="queryFixAssetsByCond(1) "><h2><fmt:message code="global.lang.report" /></h2></div>
			</div>
		</div>
	</div>


	<!--表单选项显示-->
	<div class="step1" style="display: none">
		<div class="navigation  clearfix" style="margin-top: -66px;">
			<div class="left">
				<img src="/img/commonTheme/${sessionScope.InterfaceModel}/fixAssetsQuery.png">
				<span class="news" style="display: inline-block;margin-top: 29px;">
					<fmt:message code="main.assetquery" />
				</span>
			</div>
			<%--分页按钮--%>
			<div id="dbgz_page" class="M-box3 fr" style="margin-top: 2%">
			</div>
		</div>
		<div class="cl"></div>
		<!--table表单  标题栏 -->
		<div>
			<div>
				<div class="imgDiv"><img class="noneImg" src="/img/main_img/shouyekong.png" alt="">
					<div>暂无数据</div>
				</div>
				<table id="tr_td" style="margin-left: 1%;width: 98%;" >
					<thead>
					<tr>
						<td class="th" style=" width: 15%;text-align: center"><fmt:message code="event.th.FixedAssetNumber" /></td>
						<td class="th"><fmt:message code="event.th.AssetName" /></td>
						<td class="th" ><fmt:message code="event.th.BuyTime" /></td>
						<td class="th titleOne">品牌型号</td>
						<td class="th"><fmt:message code="event.th.Number" /></td>
						<td class="th">所在部门</td>
						<td class="th">保管人</td>
						<td class="th"><fmt:message code="event.th.ArticleStatus" /></td>
						<td class="th" style="width: 120px">操作</td>
						<%--<td class="th"><fmt:message code="event.th.FixedAssetsPicture" /></td>--%>
					</tr>
					</thead>
					<tbody id="j_tb"></tbody>
				</table>
			</div>
		</div>
	</div>
</div>


</body>
</html>

<script>

    function checkStr(str){
        if(str==''||typeof (str)=='undefined'){
            return ''
        }else{
            return str
        }
    }
    $(function(){
		$("#status").val(${eduFixAssets.status});

        $.ajax({
            //查出类型对应数据
            url: '/eduFixAssets/getFixAssetstypeName',
            type: 'get',
            dataType: 'json',
            success: function (obj) {
                if(obj.flag){
                    var optionstring="";
                    $.each(obj.object,function(key,value){  //循环遍历后台传过来的json数据
                        optionstring += "<option value=\"" + value.typeId + "\" >" + value.typeName + "</option>";
                    });
                    $("#typeId").html("<option value=''>请选择</option> "+optionstring);
					$("#typeId").val(${eduFixAssets.typeIdStr})
                }
            }
        });

    });
    //点击标题查看详情
    $("#tr_td").on("click",".assetName",function () {
        var id = $(this).attr("id");
        $.popWindow("../../eduFixAssets/fixAssetsDetail?id="+id,"固定资产详情",100,100,1200,500)

    })
    //时间控件
    var start = {
        format: 'YYYY-MM-DD',
    };

    //清空人员控件
    function emptyUser(id){
        $("#"+id).val("");
        $("#"+id).attr("dataid","");
        $("#"+id).attr("user_id","");
    }
    /* 选人控件 */
    $(".addCustodion").on("click",function(){//使用保管人
        user_id = "custodionName";
        $.popWindow("../../common/selectUser?0");
    });

    $(".addCreater").on("click",function(){//使用保管人
        user_id = "createrName";
        $.popWindow("../../common/selectUser?0");
    });
    //清空部门控件
    function emptyDept(id){
        $("#"+id).val("");
        $("#"+id).attr("deptId","");
    }
    /* 选部门控件 */
    $(".addAddress").on("click",function(){//所在位置
        dept_id = "locationAddressName";
        $.popWindow("../../common/selectDept?0");
    });

    //进行条件查询方法，并在列表中显示
    function queryFixAssetsByCond(output) {
        //使用保管人
        var custodionName=$("#custodionName").attr("dataid");
        if(custodionName==''){
            custodionName=''
        }else{
            custodionName=custodionName.split(',')[0];
        }
        //所在位置
        var locationAddressName=$("#locationAddressName").attr("deptId");
        if(locationAddressName){
            locationAddressName=locationAddressName.split(',')[0];
        }else if(locationAddressName==''||typeof (locationAddressName)=='undefined'){
            locationAddressName=0
        }

        var createrName=$("#createrName").attr("dataid");
        if(createrName){
            createrName=createrName.split(',')[0];
        }

        var typeId = $("#typeId").val();
        if(typeId==''||typeof (typeId)=='undefined'){
            typeId=0
        }else{
            typeId = $("#typeId").val();
        }
        if(output!=1){//查询按钮
            ajaxPage.data.page=1;
            ajaxPage.data.output=output;
            ajaxPage.data.condition=$('#condition').attr('condition');
            ajaxPage.data.apex=$('#apex').attr('apex');
            ajaxPage.data.keeper = custodionName;
            // ajaxPage.data.deptId = $('#locationAddressName').attr('deptId')
            ajaxPage.data.deptId = parseInt(locationAddressName);
            ajaxPage.data.creater = createrName;
            // ajaxPage.data.typeId = parseInt(typeId);


            // ajaxPage.data.custodionName=custodionName;
            //  ajaxPage.data.locationAddressName=locationAddressName;
            ajaxPage.page()
            $(".center").hide();
            $(".step1").show();
        }else{//导出按钮
            window.location.href='/eduFixAssets/selFixAssetsByCond?&output='+output+'&condition='+$(':radio[name="condition"]:checked').val()+'&deptId='+parseInt(locationAddressName)+'&keeper='+custodionName+'&id='+$("#id").val()+'&currutLocation='+$("#currutLocation").val()+'&assetsName='+$("#assetsName").val()+'&buyTimeStr='+$("#buyTime").val()+'&info='+$("#info").val()+'&number='+$("#number").val()+'&status='+$("#status").val()+'&typeIdStr='+$("#typeId").val()+'&creater='+createrName+'&createrTimeStr='+$("#createrTime").val()+'&validityTimeStr='+$("#validityTime").val()+'&fromYymmStr='+$("#fromYymm").val()+'&logoutTimeStr='+$("#logoutTime").val()
        }
    }
    //进行条件查询方法，并在列表中显示
    var ajaxPage={
        data:{
            page:1,//当前处于第几页
            pageSize:20,//一页显示几条
            useFlag:true,
            output:0,
            custodionName:null,
            locationAddressName:null,
        },
        init:function () {
        },
        page:function () {
            var me=this;
            $('#queryFixAssets').ajaxSubmit({
                url:"/eduFixAssets/selFixAssetsByCond",
                type:'post',
                dataType:'json',
                data:me.data,
                success:function (json) {
                    $("#tr_td tbody").html("");
                    var str="";
                    var data=json.obj;
                    if(json.flag) {
                        if(data.length==0){
                            $(".imgDiv").css("display","block");
                            $("#tr_td").css("display","none");
                            $("#dbgz_page").css("display","none");
                            return
                        }
                        $(".imgDiv").css("display","none");
                        $("#tr_td").show();
                        $("#dbgz_page").css("display","block");
                        for (var i = 0; i < data.length; i++) {
                            str+='<tr >' +
                                '<td style="min-width:150px">'+checkStr(data[i].id)+'</td>' +
                                '<td class="assetName" id="'+data[i].id+'" title="'+data[i].assetsName+'"><a >'+checkStr(data[i].assetsName)+'</a></td>' +
                                '<td style="min-width:120px">'+checkStr(data[i].buyTime)+'</td>' +
                                '<td >'+checkStr(data[i].info)+'</td>' +
                                '<td>'+checkStr(data[i].number)+'</td>' +
                                '<td>'+checkStr(data[i].locationAddressName)+'</td>' +
                                '<td>'+checkStr(data[i].custodionName)+'</td>';
                            if (data[i].status == 1) {
                                str += '<td><fmt:message code="event.th.notUsed" /></td>';
                            } else if (data[i].status == 2) {
                                str += '<td><fmt:message code="evvent.th.Use" /></td>';
                            } else if (data[i].status == 3) {
                                str += '<td><fmt:message code="event.th.damage" /></td>';
                            } else if (data[i].status == 4) {
                                str += '<td><fmt:message code="event.th.Lose" /></td>';
                            } else if (data[i].status == 5){
                                str += '<td><fmt:message code="event.th.Scrap" /></td>';
                            } else {
								str += '<td></td>';
							}
//                           if(data[i].image!='' && data[i].image!='undefined'){
//                               str += '<td>' + '<img src="/img/edu/eduFixAssets/' + data[i].image + '"  style="height: 70px;width: 110px;"/>' + '</td>';
//						   }else{
//                               str += '<td></td>';
//                           }
                            str+= '<td style="min-width:100px;">' +
                                //                            '<a class="detail_btn"  id="'+data[i].id+'" >查看详情</a>' +
                                '<a class="edit_btn"  href="../../eduFixAssets/fixAssetsEdit?editFlag=1&apex=2&id='+data[i].id+'"><fmt:message code="global.lang.edit" /></a>' +
                                ' &nbsp;' +

                                //
                                '<a class="Handover_btn"  style="padding: 0px 5px"href="../../Atab/fixAssetsAtab?uid='+data[i].id+'&type=1">交接明细</a><pre/>'+
                                '<a class="Maintain_btn" style="padding: 0px 5px" href="../../Maintain/fixAssetsMaintain?uid='+data[i].id+'&type=1">维修明细</a>'+
                                '<span class="del_btn"style="padding: 0px 5px" id="'+data[i].id+'"><fmt:message code="global.lang.delete" /></span></td>' +
                                '</tr>';
                        }
                        $("#tr_td tbody").html(str);
                    }
                    me.pageTwo(json.totleNum,me.data.pageSize,me.data.page)
                }
            })
        },
        pageTwo:function (totalData, pageSize,indexs) {
            var mes=this;
            $('#dbgz_page').pagination({
                totalData: totalData,
                showData: pageSize,
                jump: true,
                coping: true,
                homePage:'',
                endPage: '',
                current:indexs||1,
                callback: function (index) {
                    mes.data.page=index.getCurrent();
                    mes.page();
                }
            });
        }
    }
    $("#tr_td").on("click",".del_btn",function () {
        var id= $(this).attr("id");
        layer.confirm('<fmt:message code="workflow.th.que" />？', {
            btn: ['<fmt:message code="global.lang.ok" />', '<fmt:message code="depatement.th.quxiao" />'], //按钮
            title: "<fmt:message code="event.th.DeleteAssets" />"
        }, function () {
            //确定删除，调接口
            $.ajax({
                url: '/eduFixAssets/deleteFixAssetsById',
                type: 'get',
                data: {
                    id: id,
                },
                dataType: 'json',
                success: function (json) {
                    if (json.flag) {
                        $.layerMsg({content: '<fmt:message code="workflow.th.delsucess" />！', icon: 1}, function () {
                            window.location.href = '/eduFixAssets/fixAssetsQuery';
                        });
                    }
                }
            })
        }, function () {
            layer.closeAll();
        });
    })

</script>
