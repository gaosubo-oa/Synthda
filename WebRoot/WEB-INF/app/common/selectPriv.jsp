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
	<%--	<meta name="renderer" content="webkit">--%>
	<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
	<meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=0, minimum-scale=1.0, maximum-scale=1.0">
	<title><fmt:message code="common.th.SelRole" /></title><%--选择角色--%>
	<link rel="stylesheet" type="text/css" href="../css/common/style.css" />
	<link rel="stylesheet" type="text/css" href="../css/common/select.css" />
	<!-- 	<link rel="stylesheet" type="text/css" href="../css/common/ui.dynatree.css"> -->
	<link rel="stylesheet" type="text/css" href="../css/common/org_select.css">
	<link rel="stylesheet" type="text/css" href="../lib/easyui/themes/easyui.css"/>
	<link rel="stylesheet" type="text/css" href="../lib/easyui/themes/icon.css"/>
	<script type="text/javascript" src="../js/xoajq/xoajq1.js"></script>
	<script type="text/javascript" src="../js/spirit/qwebchannel.js"></script>
	<script src="/js/base/base.js"></script>
	<script type="text/javascript" src="../lib/easyui/jquery.easyui.min.js" ></script>
	<script type="text/javascript" src="../lib/easyui/tree.js" ></script>
</head>




<style>
	#dept_menu{
		overflow-x: auto;
	}
	.left_choose ul li div,.left_choose ul li h1,.left_choose ul img{
		float:left;
	}
	.left_choose ul img{
	<!-- margin-top:8px; -->
	}
	.left_choose ul li{
		width:80%;
		height:20px;
	<!-- background:red; -->
		margin-top:10px;
	}
	.mar{
		margin-left:10%;
	}
	.name li{
		list-style-type:none;
	}
	.choose{
		background:#D6E4EF !important;
	}
</style>
<body>
<!-- //开始 -->
<!-- //头部 -->

<div id="north">
	<div id="navMenu" style="width:auto;">
		<a href="#" title='<fmt:message code="common.th.selPerson" />' class="tab_btn"  block="selected" hidefocus="hidefocus"><span><fmt:message code="common.th.selected" /></span></a><%--已选人员 已选--%>

		<a href="#" title='<fmt:message code="common.th.selByRole" />' class="tab_btn active" block="priv" hidefocus="hidefocus"><span><fmt:message code="userManagement.th.role" /></span></a><%--按角色选择 角色--%>
		<a href="#" block="query" class="tab_btn" hidefocus="hidefocus" style="display:none;"><span><fmt:message code="workflow.th.sousuo" /></span></a><%--搜索--%>
	</div>
	<div id="navRight" style="float:right;">
		<div class="search">
			<div class="search-body">
				<div class="search-input"><input notlogin_flag="" id="keyword" type="text" value=""></div>
				<div id="search_clear" class="search-clear" style="display:none;"></div>
			</div>
		</div>
	</div>
</div>

<!-- //内容 -->
<div>
	<div class="main-block" id="deptBox" >
		<div class="left moduleContainer" id="dept_menu">
			<div class="tree">
				<ul class="dynatree-container dynatree-no-connector" id="deptOrg">
				</ul>
			</div>

		</div>
		<div class="right" id="dept_item">
			<div class="block-right" id="dept_item_2">
				<!-- 部门名 -->
				<div class="block-right-header" title=""></div>

				<div class="block-right-add"><fmt:message code="meet.th.addAll" /></div><%--全部添加--%>
				<div class="block-right-remove"><fmt:message code="meet.th.DeleteAll" /></div><%--全部删除--%>
				<div class="block-right-item" uid="1" item_name='<fmt:message code="email.th.systemmanager" />' user_id="admin" title='<fmt:message code="url.th.OAadministrator" />'><%--系统管理员 OA管理员--%>
					<span class="name"><fmt:message code="email.th.systemmanager" /><span class="status"> </span><fmt:message code="common.th.online" /></span><%--系统管理员  (在线)--%>
				</div>
				<div class="userItem">

				</div>
			</div>
		</div>
	</div>
	<!-- 已选 -->
	<div class="main-block" id="selectedDox" >
		<div class="left moduleContainer" id="dept_menu">
			<div class="tree">
				<ul class="dynatree-container dynatree-no-connector" id="deptOrg">
				</ul>
			</div>

		</div>
		<div class="right" id="dept_item">
			<div class="block-right" id="dept_item_2">
				<!-- 部门名 -->

				<div id="block-right-remove" class="block-right-remove"><fmt:message code="meet.th.DeleteAll" /></div><%--全部删除--%>

				<div class="priItem">

				</div>
			</div>
		</div>
	</div>
	<!-- 角色 -->
	<div class="main-block" id="priDox"  style="display:block;">

		<%--选择角色界面，不应该再有组织架构，另外窗口，宽度对应减少--%>
		<div class="left moduleContainer" id="dept_menu">
			<div class="tree">
				<div class="pickCompany">
                    <span  class="childdept">
                        <img src="/img/commonTheme/${sessionScope.InterfaceModel}/icon_company.png" alt="" style="vertical-align: middle;width: 15px;margin-right: 5px;margin-left: 5px;margin-bottom: 4px;">
                        <a href="javascript:void(0)" class="dynatree-title"  onclick="" id="companyName" title="">全部角色</a>
                    </span>
				</div>
				<ul  style="margin-left: 10px;" class="dynatree-container dynatree-no-connector" id="priOrg">
				</ul>
			</div>

		</div>
		<div class="right" id="pri_item">
			<div class="block-right" id="dept_item_2">
				<!-- 角色名 -->
				<%--选择主角色时，就不应该有全部添加这个 按钮--%>
				<div id="block-right-add" class="block-right-add"><fmt:message code="meet.th.addAll" /></div><%--全部添加--%>
				<div id="block-right-remove" class="block-right-remove"><fmt:message code="meet.th.DeleteAll" /></div><%--全部删除--%>

				<div class="priItem">

				</div>
			</div>
		</div>
	</div>

</div>
<!-- //结束 -->
<div id="south">
	<input type="button" class="BigButtonA" value='<fmt:message code="global.lang.ok" />' onclick="close_window();">&nbsp;&nbsp;<%--确定--%>
</div>
</body>
<script>
	$.ajax({
		type:'get',
		url:'/syspara/selectTheSysPara?paraName=IS_SHOW_JMJ',
		dataType:'json',
		success:function (res) {
			if(res.object.length!=0){
				var data=res.object[0]
				if (data.paraValue!=0){
					$('.BigButtonA').before('<span style="color: red;font-family: Microsoft YaHei;font-weight: bolder;font-size: 12pt;position: absolute;left: 20px;"> 机密级★ </span>')
				}
			}
		}
	})
	var moduleId  = $.GetRequest().moduleId||moduleId;
	var classHierarchicalPriv ;
	console.log(parent.opener)
	if(parent.opener.classHierarchicalPriv == 1&&parent.opener!=null){
		//选择分级机构下角色
		classHierarchicalPriv = 1;
		$('#navRight').hide();
	}
	//是否开启分级机构设置
	var orgScope = "";

	var urlType = location.href.split('?')[1];
	if(parent.opener && parent.opener.moduleId){
		var moduleId = parent.opener.moduleId;
	}else{
		var moduleId = '';
	}

	var classifyOrg = "";
	if(parent.opener && parent.opener.classifyOrg){
		var classifyOrg = parent.opener.classifyOrg;
	}

	function close_window(){

		var itemsArr = $('#dept_item .priItem .active');
		var itemnum=location.href.split('?')[1]
		if(itemnum==0){
			if(itemsArr.length>1){
				alert('<fmt:message code="common.th.onlyChooseOne" />')/*只能选择一个*/
				return
			}

		}

		if(itemnum==2){
			if(itemsArr.length>1){
				alert('<fmt:message code="common.th.onlyChooseOne" />')/*只能选择一个*/
				return
			}
			var obj = itemsArr.eq(0);
			if (obj.attr("privName")!="OA管理员"){
				alert('管理员角色权限不能修改！')/*只能选择一个*/
				return
			}


		}
		var selectItemsId = '';
		var selectItemsName = '';
		var userPriv = '';
		for(var i=0;i<itemsArr.length;i++){
			var obj = itemsArr.eq(i);
			selectItemsId+=(obj.attr("privId")+',');
			selectItemsName+=(obj.attr("privName")+',');
			userPriv+=(obj.attr("userPriv")+',');
		};
		if(parent.opener && parent.opener.priv_id){
			if(parent.opener.location.href.indexOf('addUsers?') > -1&&itemnum==0){
				parent.opener.document.getElementById(parent.opener.priv_id).value=selectItemsName.split(',')[0];
			}else{
				parent.opener.document.getElementById(parent.opener.priv_id).value=selectItemsName;
			}

			parent.opener.document.getElementById(parent.opener.priv_id).setAttribute('privId',selectItemsId);
			parent.opener.document.getElementById(parent.opener.priv_id).setAttribute('userPriv',userPriv);
		}else{
			var parentObj = parent.$("#"+parent.priv_id);
			parentObj.val(selectItemsName);
			parentObj.attr('userPriv',userPriv);
			parentObj.attr('privId',selectItemsId);
		}
		window.close();
		parent.layer.closeAll();
	}
	var initTree;
	if(parent.opener && parent.opener.priv_id){
		var priv_id = parent.opener.document.getElementById(parent.opener.priv_id).getAttribute('userpriv');
	}else{
		priv_id = parent.$("#"+parent.priv_id).attr('userpriv');
	}
	$(function(){
		// var url = '../userPrivType/queryUserPrivType?moduleId=' + moduleId;
		var url = '/userPrivType/selectUserPrivTypeByClassifyOrg?moduleId='+moduleId;
		initTree = function(){
			$('#priOrg').tree({
				url: url,
				animate: true,
				loadFilter: function (node) {
					return convert(node.obj);

				},
				onDblClick: function (node) {

				},
				onClick: function (node) {
//                    buildPrivList(node.id);
					$(this).tree(node.state === 'closed' ? 'expand' : 'collapse', node.target);
					node.state = node.state === 'closed' ? 'open' : 'closed';
				},
				onBeforeExpand: function (node, param) {
					$('#priOrg').tree('options').url = "../userPrivType/queryUserPrivByPrivTypeId?privTypeId=" + node.id;// change the url
				}

			});
		};

		$.ajax({
			url:'../sys/showUnitManage?moduleId='+moduleId,
			type:'get',
			dataType:'json',
			success:function(obj) {
				// $('#companyName').html(obj.object.unitName);
				$('.childdept').show();
				initTree();
			}
		});
		function getPriv(){

		}
		$('#selectedDox #block-right-remove').click(function () {
			$('#selectedDox .priItem .block-right-item').each(function() {
				if( $('#priDox .priItem #'+$(this).attr('privid')).length > 0){
					$('#priDox .priItem #'+$(this).attr('privid')).removeClass('active');
				}
			});
			$('#selectedDox .priItem .block-right-item').remove();
			priv_idStr();

		});
		$('#selectedDox .priItem ').on('click','.block-right-item',function () {
			$('#priDox .priItem #'+$(this).attr('privid')).removeClass('active');
			$(this).remove();
			priv_idStr();
		});
		$('#priDox #block-right-add').on('click',function () {
			$('#priDox .priItem .block-right-item').addClass('active');
			var str  = '';
			$('#priDox .priItem .active').each(function (i,v) {
				if( $('#selectedDox .priItem #'+$(this).attr('privid')).length < 1){
					str += $(this).prop("outerHTML");
				}
			});
			$('#selectedDox .priItem').append(str);
			priv_idStr();
		});
		$('#priDox #block-right-remove').on('click',function () {

			$('#priDox .priItem .active').each(function (i,v) {
				if( $('#selectedDox .priItem #'+$(this).attr('privid')).length > 0){
					$('#selectedDox .priItem #'+$(this).attr('privid')).remove();
				}
			});
			$('#priDox .priItem .block-right-item').removeClass('active');
			priv_idStr();
		})
		function priv_idStr(){
			priv_id = '';
			var itemsArr = $('#dept_item .priItem .active');
			for(var i=0;i<itemsArr.length;i++){
				var obj = itemsArr.eq(i);
				priv_id+=(obj.attr("privId")+',');
			};

		}
		function TreeNode(id,text,state,children){
			this.id = id;
			this.text = text;
			this.state = state;
			this.children = children;
		}
		$(document).on('click','#companyName',function(){
			buildPriitems();
		})
		buildPriitems();
		function buildPriitems(){
			if(location.href.split('?')[1] == 0){
				var data = {
					IsPriv:'1',
					check:'1'
				}
			}else if(location.href.split('?')[1] == undefined){
				var data = {
					IsPriv:'1',
					check:'1'
				}
			}else if(location.href.split('?')[1] == 1){
				var data = {
					IsPriv:'0',
				}
			} else{
				var data = {
					IsPriv:'1',
				}
			}
			if(classHierarchicalPriv == 1){
				//选择分级机构下角色
				var url = '/hierarchicalGlobal/getGlobalPersonPriv?allType='+$.GetRequest().allType||'';
			} else {
				// var url = '../userPriv/getAllPriv'+ '?moduleId=' + moduleId
				var url = '/userPriv/getAllPrivByClassifyOrg' + '?moduleId=' + moduleId
			}
			$.ajax({
				url:url,
				type:'get',
				data: data,
				dataType:'json',
				success:function(obj){
					if(obj.flag){
						var data = obj.obj;
						var tr = '';
						var dept_item_2 = '';
						data.forEach(function(v,i){
							var bool = false;
							var div = '<div class="block-right-item'+function(){
								if(priv_id){
									var priv_idArr;
									if(Array.isArray(priv_id)){
										priv_idArr= priv_id;
									}else {
										priv_idArr= priv_id.split(',');
									}
									for (var i = 0; i < priv_idArr.length; i++) {
										if (v.userPriv == priv_idArr[i]) {
											bool = true;
											break;
										}
									}
									if (bool) {
										return ' active';
									}else {
										return ''
									}
								}else {
									return ''
								}
							}()+'" id="'+v.userPriv+'" privId="'+v.userPriv+'" privName="'+v.privName+'" userPriv="'+v.userPriv+'"title="'+v.privName+'"><span class="name">'+v.privName+'<span class="status"> </span></span></div>';
							tr+=div;
							if (bool) {
								dept_item_2 +=div;
							}
						});

						$('#priDox .priItem').html(tr);
						$('#dept_item .priItem').html(dept_item_2);
					}
				}
			});
		}
		function convert(data){
			var arr = [];
			var tr = '';
			if(data == ''){
				var bool = false;
				// var div = '<div class="block-right-item'+function(){
				// 	if(priv_id){
				// 		var priv_idArr;
				// 		if(Array.isArray(priv_id)){
				// 			priv_idArr= priv_id;
				// 		}else {
				// 			priv_idArr= priv_id.split(',');
				// 		}
				// 		for (var i = 0; i < priv_idArr.length; i++) {
				// 			if (v.userPriv == priv_idArr[i]) {
				// 				bool = true;
				// 				break;
				// 			}
				// 		}
				// 		if (bool) {
				// 			return ' active';
				// 		}else {
				// 			return ''
				// 		}
				// 	}else {
				// 		return ''
				// 	}
				// }()+'"></div>';
				tr = '<li class="no_notice" style="list-style:none;background:#fff;position:absolute;text-align: center;padding: 27px 0px;border: 1px solid #c0c0c0;border-top: none;width:100%"><img style="margin-bottom: 20px;"  src="/img/main_img/shouyekong.png" alt=""><h2 style="text-align: center;color: #666;font-size: 16px">暂无数据</h2></li>';
				$('#priDox .priItem').html(tr);
			}else{
				data.forEach(function(v,i){
					if(v.privTypeId != undefined && v.userPriv == undefined){
						var node = new TreeNode(v.privTypeId,v.privTypeName,"closed")
						arr.push(node);
					}else if(v.userPriv){
						// if(v.sex==0){
						//     tr+='<div class="block-right-item" item_id="'+v.uid+'" item_name="'+v.userName+'" user_id="'+v.userId+'" uid="'+v.uid+'" title="'+v.userName+'"><span class="name">'+v.userName+' '+v.userPrivName+'<span class="status"> </span></span></div>';
						// }else if(v.sex==1){
						//     tr+='<div class="block-right-item" item_id="'+v.uid+'" item_name="'+v.userName+'" user_id="'+v.userId+'" uid="'+v.uid+'" title="'+v.userName+'"><span class="name">'+v.userName+' '+v.userPrivName+'<span class="status"></span></span></div>';
						// }
						// tr+='<div class="block-right-item" item_id="'+v.userPriv+'" item_name="'+v.privName+'" user_id="'+v.userPriv+'" uid="'+v.userPriv+'" title="'+v.privName+'"><span class="name">'+v.privName+'<span class="status"> </span></span></div>';
						var bool = false;
						var div = '<div class="block-right-item'+function(){
							if(priv_id){
								var priv_idArr;
								if(Array.isArray(priv_id)){
									priv_idArr= priv_id;
								}else {
									priv_idArr= priv_id.split(',');
								}
								for (var i = 0; i < priv_idArr.length; i++) {
									if (v.userPriv == priv_idArr[i]) {
										bool = true;
										break;
									}
								}
								if (bool) {
									return ' active';
								}else {
									return ''
								}
							}else {
								return ''
							}
						}()+'" id="'+v.userPriv+'" privId="'+v.userPriv+'" privName="'+v.privName+'" userPriv="'+v.userPriv+'"title="'+v.privName+'"><span class="name">'+v.privName+'<span class="status"> </span></span></div>';
						tr+=div;
						$('#priDox .priItem').html(tr);
					}
				});
			}


			return arr;
		}
		//组织
		$('.tab_btn').click(function(){
			var type = $(this).attr('block');
			$(this).addClass("active").siblings().removeClass('active');
			switch(type){
				case "selected":
					$('#selectedDox').show().siblings().hide();
					break;
				case "dept":
					$('#deptBox').show().siblings().hide();
					break;
				case "priv":
					$('#priDox').show().siblings().hide();
					break;
				case "group":

					break;
				case "query":

					break;
			}
		});

		$('#priDox #pri_item').on("click",".block-right-item",function(){
			var that = $(this);
			if(that.attr('class').indexOf('active') > 0){
				that.removeClass("active");
				if($('#selectedDox .priItem #'+that.attr('privid')).length > 0){
					$('#selectedDox .priItem #'+that.attr('privid')).remove();
				}
//                $('#selectedDox .priItem #'+that.attr('privid')).remove();
			}else{
				var divObj = $(that.prop("outerHTML"));
				divObj.addClass("active");
				that.addClass("active");

				if($('#selectedDox .priItem #'+that.attr('privid')).length < 1){
					$('#selectedDox .priItem').append(divObj);
				}
				if(urlType == 0){
					that.siblings('div').removeClass('active');
					$('#selectedDox .priItem').empty();
					$('#selectedDox .priItem').append(divObj);
				}

//                $('#selectedDox .priItem').append(divObj);
			}
			priv_idStr();
		});


		$('.tree .dynatree-container').on('click','.childdept',function(){
			var  that = $(this);
			getChDept(that.next(),that.attr('deptid'));
			var title=that.find('a').text();
			$('.block-right-header').html(title);
		});

		$('.block-right').on('mouseover','div',function(){
			$(this).addClass('hover');
		});
		$('.block-right').on('mouseout','div',function(){
			$(this).removeClass('hover');
		});

		//搜索
		$('#keyword').bind('input propertychange', function() {
			var text = encodeURI($(this).val());
			throttle(autodivheights,text);
		});

	});

	function throttle(method,text) {
		clearTimeout(method.tId);
		method.tId=setTimeout(function(){
			method.call(method,text);
		},500);
	}

	function autodivheights(text) {
		// var url = "../userPriv/getBySearch";
		var url = "/userPriv/getAllPrivByClassifyOrg";
		if(location.href.split('?')[1] == 1){
			var data = {
				IsPriv: '0',
				search: text,
			}
		}else{
			var data = {
				IsPriv: '1',
				check: '1',
				search: text,
			}
		}
		$.ajax({
			type: "get",
			url: url,
			dataType: 'JSON',
			data: data,
			success: function (res) {
				if(res.flag){
					var data = res.obj;
					var tr = '';
					data.forEach(function(v,i){
						tr+='<div class="block-right-item'+function(){
							var bool = false;
							if(priv_id){
								var priv_idArr;
								if(Array.isArray(priv_id)){
									priv_idArr= priv_id;
								}else {
									priv_idArr= priv_id.split(',');
								}
								for (var i = 0; i < priv_idArr.length; i++) {
									if (v.userPriv == priv_idArr[i]) {
										bool = true;
										break;
									}
								}
								if (bool) {
									return ' active';
								}else {
									return ''
								}
							}else {
								return ''
							}
						}()+'" id="'+v.userPriv+'" privId="'+v.userPriv+'" privName="'+v.privName+'" userPriv="'+v.userPriv+'"title="'+v.privName+'"><span class="name">'+v.privName+'<span class="status"> </span></span></div>';
					});

					if(data.length==0){
						tr='<div style="width: 230px;height: 200px;margin: 20px auto;text-align: center">' +
								'<img src="/img/common/sousuokong.png" style="margin-top: 20px;" alt="">\
                                <span style="width: 100%;display: inline-block;margin-top: 10px;\
                            font-size: 15px;\
                            font-weight: bold;">暂无搜索角色</span>' +
								'</div>'
					}
					$('#priDox .priItem').html(tr);
				}
			}
		});
	}
</script>
</html>
