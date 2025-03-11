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
    <title><fmt:message code="common.th.selPeople" /></title><%--选择人员--%>
	 <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<%--    <meta name="renderer" content="webkit">--%>
    <meta http-equiv="X-UA-Compatible" content="IE=10,chrome=1" />
	<meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=0, minimum-scale=1.0, maximum-scale=1.0">
    <link rel="stylesheet" type="text/css" href="../css/common/style.css" />
	<link rel="stylesheet" type="text/css" href="../css/common/select.css" />
	<link rel="stylesheet" type="text/css" href="../css/common/org_select.css">
	<link rel="stylesheet" type="text/css" href="../lib/easyui/themes/easyui.css"/>
    <link rel="stylesheet" type="text/css" href="../lib/easyui/themes/icon.css"/>
<%--	<script type="text/javascript" src="/js/xoajq/xoajq1.js"></script>--%>
	 <script type="text/javascript" src="/js/xoajq/xoajq3.js"></script>
	 <script type="text/javascript" src="/js/jquery/jquery-migrate-3.4.0.js"></script>
	<script src="/js/base/base.js?20210928"></script>
	<script type="text/javascript" src="../lib/easyui/jquery.easyui.min.js" ></script>
    <script type="text/javascript" src="../lib/easyui/tree.js" ></script>
</head>
<style type="text/css">
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
	#block-right-header,#block-right-add,#block-right-remove{
		display: none;
	}
	.onlineRight{
		width: 98%;
		left: 0 !important;
		border-left: none !important;
		padding: 8px !important;
		margin: 0 auto;
	}
	#allPriv .block-left-item:hover{
		background: #e7f2fa;
	}
	.privActive{
		background: #c7e1f6 !important;
		font-weight: bold;
	}
	.textLeft{
		text-align: left !important;

	}
	#allGroup .block-left-item:hover{
		background: #e7f2fa;
	}
	#query_userId{
		border: 1px solid #d9d9d9;
		width: 91%;
		height: 100px;
		border-radius: 4px;
		margin-top: 15px;
		margin-left: 20px;
		color: #666;
		padding: 5px;
	}

.addcustom{
	position: fixed;
	bottom: 5px;
	/* display: block; */
	color: #fff;
	left: 32px;
	background-color: #5bc0de;
	border-color: #46b8da;
	padding: 6px 12px;
	width: 106px;
	text-align: center;
	border-radius: 2px;
	z-index: 99999;
	cursor: pointer;
}
	.status{
		padding-left:10px;
	}
.gwpost,.zwposition{
	height: 20px;
	margin-top: 4px;
	margin-left: 4px;
}
#navMenu span {
	float: left;
	overflow: hidden;
	color: #000000;
	text-decoration: none;
	padding-left: 5px;
	font-size: 14px;
	background: url(../../img/common/menu_top_line.png) no-repeat top right;
	height: 30px;
}
#navMenu .tab_btn,#navMenu .tab_btnBox{
	display: none;
}
.checkboxs{
	transform: scale(1.5,1.5);
	margin-left: 20px;
	vertical-align: -webkit-baseline-middle;
}
#bgm {
	width: 60px;
	height: 60px;
	background: url(/lib/layer/skin/default/loading-0.gif) no-repeat;
	z-index: 999;
	position: fixed;
	left: 50%;
	top: 50%;
	margin-left: -30px;
	margin-top: -30px;
	display: none;
}
</style>
<body>
	<!-- //开始 -->
		<!-- //头部 -->

		<div id="north">
   <div id="navMenu" style="width:auto;">
      <a href="#" title='<fmt:message code="common.th.selPerson" />' class="tab_btn"  block="selected" hidefocus="hidefocus"><span><fmt:message code="common.th.selected" /></span></a><%--已选人员 已选--%>
      <a href="#" title='<fmt:message code="common.th.selByDepart" />'  id="department" block="dept" hidefocus="hidefocus" class=" tab_btn active"><span><fmt:message code="userManagement.th.department" /></span></a><%--按部门选择 部门--%>
      <a href="#" title="按角色选择" id="privBtn" class="tab_btn" block="priv" hidefocus="hidefocus"><span>角色</span></a>
      <a href="#" title="按分组选择" id="groupBtn" class="tab_btn" block="group" hidefocus="hidefocus"><span>公共分组</span></a>
	   <a href="#" title="按自定义组选择" id="customGroup" class="tab_btn" block="custom" hidefocus="hidefocus"><span>个人分组</span></a>
	   <a href="#" title="从在线人员选择" id="userOnline" class="tab_btn" block="online" hidefocus="hidefocus"><span>在线</span></a>
	   <a href="#" block="query" class="tab_btn" hidefocus="hidefocus" style="display:none;"><span><fmt:message code="workflow.th.sousuo" /></span></a><%--搜索--%>
	   <div class="tab_btnBox" style="float: left">
		   <span href="javascript:;" style="width: 100px;">
            <select name="jobId" class="gwpost">
                <option value="">请选择岗位</option>
            </select>
        </span>
		   <span href="javascript:;">
            <select name="postId" class="zwposition" style="width: 100px;">
                <option value="">请选择职务</option>
            </select>
        </span>
		   <input type="checkbox" class="checkboxs">
		   <div id="bgm" class="layui-layer-content layui-layer-loading0"></div>
	   </div>

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
		<!-- 部门 -->
		<div class="main-block" id="deptBox" style="display:block;">
			   <div class="left moduleContainer" id="dept_menu">

				   <div class="tree">
					   <div class="pickCompany">
						<span  class="childdept" style="display: none;">
							<img src="/img/commonTheme/${sessionScope.InterfaceModel}/icon_company.png" alt="" style="vertical-align: middle;width: 15px;margin-right: 5px;margin-left: 5px;margin-bottom: 4px;">
							<input type="checkbox" id="checkedUserAll" value="" style="width: 15px;height: 15px;">
							<a href="javascript:void(0)" class="dynatree-title" onclick="initTree();"  id="companyName" title=""></a>
						</span>
					   </div>
					   	<ul class="dynatree-container dynatree-no-connector" style="margin-left: 10px;" id="deptOrg">
					   	</ul>
				   </div>

			   </div>
			   <div class="right" id="dept_item">
					<div class="block-right" id="dept_item_2">
						<!-- 部门名 -->
						<div class="block-right-header" title="" style="background: #b6e0ff;" id="block-right-header"></div>

						<div id="block-right-add" onclick="addAllUser($('#deptBox'))" class="block-right-add"><fmt:message code="meet.th.addAll" /></div><%--全部添加--%>
						<div id="block-right-remove" onclick="deleteAllUser($('#deptBox'))" class="block-right-remove"><fmt:message code="meet.th.DeleteAll" /></div><%--全部删除--%>
						<div class="userItem curDept">

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

						<div class="userItem">
						</div>
					</div>
				</div>
		</div>
		<!-- 角色 -->
		<div class="main-block" id="priDox" >
			   <div class="left moduleContainer" id="allPriv">

			   </div>
			   <div class="right" id="priv_item">
					<div class="block-right" id="priv_item_2" style="display: none;">
						<div class="block-right-header" title="" style="background: #b6e0ff;" id="priv-right-header"></div>

						<div class="block-right-add" onclick="addAllUser($('#priDox'))"><fmt:message code="meet.th.addAll" /></div><%--全部添加--%>

						<div class="block-right-remove" onclick="deleteAllUser($('#priDox'))"><fmt:message code="meet.th.DeleteAll" /></div><%--全部删除--%>

						<div class="userItem">

						</div>

					</div>
				   <div class="block-right" id="priv_item_3" style="display: none;margin-top: 10px;">
					   <div class="block-right-header" title="" style="background: #b6e0ff;" id="priv-right-header_s">辅助角色</div>
					   <div class="userItem">

					   </div>
				   </div>
				   <div class="pleaseCheck" style="display: block;text-align: center;line-height: 100px;font-size: 12pt;">请选择角色</div>
				   <div class="noUser" style="display: none;text-align: center;line-height: 100px;font-size: 12pt;">无符合条件的用户</div>
				</div>
		</div>
		<!-- 分组 -->
		<div class="main-block" id="groupDox" >
			   <div class="left moduleContainer" id="allGroup">

			   </div>
			   <div class="right" id="group_item">
					<div class="block-right" id="group_item_2" style="display: none;">

						<div class="block-right-header" title="" style="background: #b6e0ff;" id="group-right-header"></div>

						<div class="block-right-add" onclick="addAllUser($('#groupDox'))"><fmt:message code="meet.th.addAll" /></div><%--全部添加--%>

						<div class="block-right-remove" onclick="deleteAllUser($('#groupDox'))"><fmt:message code="meet.th.DeleteAll" /></div><%--全部删除--%>

						<div class="userItem">

						</div>
					</div>
				   <div class="pleaseChecks" style="display: block;text-align: center;line-height: 100px;font-size: 12pt;">请选择分组</div>
				   <div class="noUsers" style="display: none;text-align: center;line-height: 100px;font-size: 12pt;">该分组未设置用户</div>
				</div>
		</div>
		<!-- 在线 -->
		<div class="main-block" id="onlineName">
			<div class="right onlineRight" id="dept_online">
				<div class="block-right" id="dept_onlineUser">
					<div class="block-right-header" title="" style="background: #b6e0ff;" id="onlineUser">在线人员</div>
					<div id="onlineAdd" onclick="addAllUser($('#onlineName'))" class="block-right-add"><fmt:message code="meet.th.addAll" /></div><%--全部添加--%>
					<div class="block-right-remove" onclick="deleteAllUser($('#onlineName'))"><fmt:message code="meet.th.DeleteAll" /></div><%--全部删除--%>

					<div class="userItem">

					</div>
				</div>
			</div>
		</div>
		<!-- 自定义组 -->
		<div class="main-block" id="customDox" >
			<div class="left moduleContainer" id="allcustom">

			</div>
			<div class="right" id="custom_item">
				<div class="block-right" id="custom_item_2" style="display: none;">

					<div class="block-right-header" title="" style="background: #b6e0ff;" id="custom-right-header"></div>

					<div class="block-right-add" onclick="addAllUser($('#customDox'))"><fmt:message code="meet.th.addAll" /></div><%--全部添加--%>

					<div class="block-right-remove" onclick="deleteAllUser($('#customDox'))"><fmt:message code="meet.th.DeleteAll" /></div><%--全部删除--%>

					<div class="userItem">

					</div>
				</div>
				<div class="pleaseChecks" style="display: block;text-align: center;line-height: 100px;font-size: 12pt;">请选择分组<br>（ 请在控制面板添加个人分组 ）</div>
				<div class="noUsers" style="display: none;text-align: center;line-height: 100px;font-size: 12pt;">该分组未设置用户</div>
			</div>
		</div>
		<!-- 搜索 -->
		<div class="main-block" id="searchName" style="display: none;">
			<div class="right onlineRight" id="search_online">
				<div class="block-right" id="search_onlineUser" style="display: block;">
					<div class="block-right-header" title="" style="background: #b6e0ff;" id="onlineUser">查询人员</div>
					<div id="onlineAdd" class="block-right-add" onclick="addAllUser($('#searchName'))"><fmt:message code="meet.th.addAll" /></div><%--全部添加--%>
					<div class="block-right-remove" onclick="deleteAllUser($('#searchName'))"><fmt:message code="meet.th.DeleteAll" /></div><%--全部删除--%>

					<div class="userItem">

					</div>
				</div>
				<div class="noUsers" style="display: none;text-align: center;line-height: 100px;font-size: 12pt;">无符合条件的用户</div>
			</div>
		</div>
	</div>
	<!-- //结束 -->
	<div id="south">
		<span class="chooseBox">已选人员：</span><span class="chooseBox" style="color: red;margin-right: 10px;" data-num="0">0人</span>
	   <input type="button" class="BigButtonA" value='<fmt:message code="global.lang.ok" />' onclick="close_window();">&nbsp;&nbsp;<%--确定--%>
	</div>
</body>
	<script type="text/javascript">
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
		if (/(iPhone|iPad|iPod|iOS|Android)/i.test(navigator.userAgent)) {
			$('div.left').css('width', '150px');
			$('div.right').css('left', '158px');
			$('#navMenu .tab_btn').hide();
			$('#navMenu .tab_btnBox').hide();
			$('#navMenu .tab_btn').eq(0).show();
			$('#navMenu .tab_btn').eq(1).show()
		}else{
			$('#navMenu .tab_btn').show();
			$('#navMenu .tab_btnBox').show();
		}

        function getQueryString(){
            var url = location.search; //包括问号;
            if (url.indexOf("?") !=-1) {
                url.substr(1);
            }
            return url;
        }
		var node1
		var nodeName
		var groupIds
		var userPr1
		var nodedept = ''
		var nodedeptName
		var groupId1
		var cides =''
		//岗位
		$.ajax({
			url:'/position/selectUserJob',
			type:'get',
			dataType:'json',
			success:function(res){
				var strs = ''
				for(var i=0;i<res.obj.length;i++){
					strs += '<option  value="' + res.obj[i].jobId + '">' +  res.obj[i].jobName + '</option>'
				}
				$('.gwpost').append(strs)
			}
		})

		//职务
		$.ajax({
			url:'/duties/selectUserPostList',
			type:'get',
			dataType:'json',
			success:function(res){
				var strs = ''
				for(var i=0;i<res.obj.length;i++){
					strs += '<option  value="' + res.obj[i].postId + '">' +  res.obj[i].postName + '</option>'
				}
				$('.zwposition').append(strs)
			}
		})

		var classDept ;
		if(parent.opener && parent.opener.moduleId){
			var moduleId = parent.opener.moduleId;
		}else{
			var moduleId = '';
		}
		if(parent.opener !=null && parent.opener.classDept ){
			classDept = parent.opener.classDept;
			$('#navMenu a').hide();$('#navMenu a').eq(0).show();$('#navMenu a').eq(1).show();
			$('#navRight').hide();
		}else{
			$.ajax({
				url:'/imfriends/getIsFriends',
				type:'get',
				dataType:'json',
				data:{},
				success:function(obj){
					if(obj.object == 1){
						location.href = "/common/selectUserIMAddGroup"+getQueryString();
					}
				}
			})
		}
        paraValue=""
        searchPara=""
        $.ajax({
            type:'get',
            url:'/syspara/queryOrgScope',
            dataType:'json',
            success:function (reg) {
                var item=reg.object;
                if(item.paraValue == 1){
                    paraValue = 1;
                }
            }
        })

        var urlType=location.href.split('?')[1];
        var onLine=[];
        function throttle(method,text) {
            clearTimeout(method.tId);
            method.tId=setTimeout(function(){
                method.call(method,text);
            },500);
        }
        function check(name){
            if(name == undefined){
                return '无'
			}else{
                return name
			}
		}
        var initTree;
        var user_id='';
        var userPrivName='';
        var dataid = '';
        var selectItemsName ='';
        var parentObj='';

        try {
            if (parent.opener && parent.opener.user_id) {
                user_id = parent.opener.document.getElementById(parent.opener.user_id).getAttribute('user_id');
                userPrivName = parent.opener.document.getElementById(parent.opener.user_id).getAttribute('userPrivName');
                dataid = parent.opener.document.getElementById(parent.opener.user_id).getAttribute('dataid');
                selectItemsName = parent.opener.document.getElementById(parent.opener.user_id).value;
            } else {
                user_id = parent.$("#" + parent.user_id).attr('user_id');
                userPrivName = parent.$("#" + parent.user_id).attr('userPrivName');
                dataid = parent.$("#" + parent.user_id).attr('dataid');
                selectItemsName = parent.$("#" + parent.user_id).val();
                parentObj = parent.$("#" + parent.user_id);
            }
        } catch (e) {
            user_id = parent.$("#" + parent.user_id).attr('user_id');
            userPrivName = parent.$("#" + parent.user_id).attr('userPrivName');
            dataid = parent.$("#" + parent.user_id).attr('dataid');
            selectItemsName = parent.$("#" + parent.user_id).val();
            parentObj = parent.$("#" + parent.user_id);
        }


        function autodivheights(text) {
            if(classDept){
                var url = "../user/getBySearch?search=" + text
			}else{
                if(paraValue == ""){
                    var url = "../user/getBySearch?search=" + text
                }else{
                    var url = '../user/getBySearchBaiOrg?deptNo='+searchPara+'&search='+text
                }
			}

            $.ajax({
                type: "get",
                url: url,
                dataType: 'JSON',
                success: function (res) {
                    if(res.flag){
                        if(res.obj.length > 0){  //判断是否返回数据集合
                            var arr = [];
//                            $('#block-right-header').show();
//                            $('#block-right-add').show();
//                            $('#block-right-remove').show();
							$('#search_onlineUser').show();
                            $('#searchName').find('.noUsers').hide()
                            res.obj.forEach(function(v,i){
                                if(v.userId) {
                                    var divObj = {};
									divObj = $('<div class="block-right-item '+function () {
										if(user_id) {
											var user_idArr;
											if(Array.isArray(user_id)){
												user_idArr= user_id;
											}else {
												user_idArr= user_id.split(',');
											}

											var bool = false;
											for (var i = 0; i < user_idArr.length; i++) {
												if (v.userId == user_idArr[i]) {
													bool = true;
													break;
												}
											}
											if (bool) {
												return 'active';
											}else {
												return ''
											}
										}else {
											return ''
										}
									}()+'" item_id="'+v.uid+'" item_name="'+v.userName+'" id="'+v.userId+'" user_id="'+v.userId+'" uid="'+v.uid+'" userPrivName="'+function(){if(v.userPrivName==undefined){return ''}else{return v.userPrivName}}()+'" title="'+v.userName+'"><span class="name">'+'['+check(v.deptName)+']&nbsp;'+check(v.userName)+' '+function(){
										if(v.userPrivName==undefined){
											return ''
										}else{
											return v.userPrivName
										}
									}()+'<span class="status"> '+function () {
										if(onLine.toString().indexOf(v.userId) > -1){
											return '<span style="color:#ff0000;">在线</span>';
										}else{
											return '';
										}
									}()+'</span></span></div>');

                                    if( $('#selectedDox .userItem #'+v.userId).length > 0 ){
                                        divObj.addClass('active')
                                    }
                                    arr.push(divObj)
                                }
                            });
                            $('#searchName .userItem').html(arr);
						}else{
                            $('#search_onlineUser').hide();
                            $('#searchName').find('.noUsers').show()
						}
                    }
                }
            });

        }

        function TextareaBlurFun(e){
            if(e.val() == '我是...'){
                e.val('我是');
			}
		}

		function close_window(){
			var itemsArr = $('#selectedDox .userItem .active');
			var itemnum=location.href.split('?')[1]
			if(itemnum==0){
				if(itemsArr.length>1){
					layer.msg('<fmt:message code="common.th.onlyChooseOne" />', {icon: 5});
					//alert('<fmt:message code="common.th.onlyChooseOne" />')/*只能选择一个*/
					return
				}

			}
			var selectItemsId = '';
			var selectItemsName = '';
			var selectUid = '';
			var userPrivName = ''
			for(var i=0;i<itemsArr.length;i++){
				var obj = itemsArr.eq(i);
				selectItemsId+=(obj.attr("user_id")+',');
				selectItemsName+=(obj.attr("item_name")+',');
				selectUid+=(obj.attr("uid")+',');
				userPrivName+=(obj.attr("userPrivName")+',');
			};
            if($("#PC_addfriendBOX" , parent.document).length != 0){
                $('style').append('.layui-layer-title {padding: 0 80px 0 20px;height: 42px;line-height: 42px;border-bottom: 1px solid #eee;font-size: 16px;color: #fff;overflow: hidden;background-color: #2b7fe0;border-radius: 2px 2px 0 0;}')
                layer.open({
                    type: 1,
                    offset: '80px',
                    area: ['500px', '300px'],
                    closeBtn: 2,
                    title: '添加好友',
                    content: '<input id="fuids" type="hidden" value="'+ selectItemsId +'"><div style="color: #000;margin-left: 20px;margin-top: 10px;">请输入验证消息:</div><textarea class=" td_title1  release1" id="query_userId" rows="4" onfocus="TextareaBlurFun($(this))"></textarea>',
                    btn: ['<fmt:message code="main.th.confirm" />', '<fmt:message code="depatement.th.quxiao" />'],
                    success: function (layero, index) {
                        var thisUserName = $('#south').attr('username');
						$('#query_userId').val('我是'+ thisUserName +',请通过我的好友申请');
                    },
                    yes: function(index, layero){
                        if(selectItemsId != ''){
                            $.ajax({
                                type:'post',
                                url:'/imfriends/addFriend',
                                data:{
                                    fuids:$('#fuids').val(),
                                    message:$('#query_userId').val()
                                },
                                dataType:'json',
                                success:function (data) {
                                    layer.closeAll();
                                    top.opener=null;
                                    top.close();  //注意, 不可跨域
                                }
                            })
						}else{
                            alert('请选择至少一个人为好友！')
						}
                    }
                });
            }else{
                if (parent.opener && parent.opener.user_id) {
                    try {
                        parent.opener.document.getElementById(parent.opener.user_id).value = selectItemsName;
                        parent.opener.document.getElementById(parent.opener.user_id).setAttribute('username', selectItemsName);
                        parent.opener.document.getElementById(parent.opener.user_id).setAttribute('dataid', selectUid);
                        parent.opener.document.getElementById(parent.opener.user_id).setAttribute('user_id', selectItemsId);
                        parent.opener.document.getElementById(parent.opener.user_id).setAttribute('userPrivName', userPrivName);
                    } catch (e) {
                        parentObj.val(selectItemsName);
                        parentObj.attr('username', selectItemsName);
                        parentObj.attr('dataid', selectUid);
                        parentObj.attr('user_id', selectItemsId);
                        parentObj.attr('userPrivName', userPrivName);
                    }
                } else {
                    parentObj.val(selectItemsName);
                    parentObj.attr('username', selectItemsName);
                    parentObj.attr('dataid', selectUid);
                    parentObj.attr('user_id', selectItemsId);
                    parentObj.attr('userPrivName', userPrivName);
                }
                if(parent.opener){
					if (parent.opener.archives) {
						parent.opener.archives(selectItemsId)
					}
                    if (parent.opener.responsible) {
                        parent.opener.responsible()
                    }
                    if(parent.opener.loadfile!=undefined){
                        parent.opener.loadfile(parent.opener.user_id)
                    }
                    //针对人事调动页面，选完调动人员后回显调动前职务和调动前部门
                    if (itemnum == 0 && parent.opener.checkOver) {
                        parent.opener.checkOver(selectItemsId,parent.opener.user_id)
                    }

                }

                window.close();
				//判断如果存在layer层，则关闭layer层
				if(parent.selectUsreLayerIndex){
					parent.layer.close(parent.selectUsreLayerIndex);
					return false;
				}
                parent.layer.closeAll();
			}
		}

        $(function(){
//            点击选择全部人员复选框
			var thisUserName = '';
			var privBtnflag = false;//角色box
			var groupflag = false;//组织box
            var customflag = false;//自定义组织box

            $.ajax({
                type:'post',
                url:'/imfriends/getUserName',
                dataType:'json',
                success:function (data) {
                    thisUserName = data.object;
                    $('#south').attr('username',data.object)
                }
            })
			$('#checkedUserAll').on('click',function () {
			    var state=$(this).prop('checked');
			    var deptName=$('#companyName').text()
                showUserAndDept(0,deptName,function () {
					if(state == true){

					}else {
						$('#deptBox').find('.block-right-item').removeClass('active');
						$('#selectedDox .userItem .block-right-item').each(function() {
							if( $('#deptBox .userItem #'+$(this).attr('user_id')).length > 0){
								$('#deptBox .userItem #'+$(this).attr('user_id')).removeClass('active');
							}
						});
						$('#selectedDox .userItem .block-right-item').remove();
					}
                    var num = $('#selectedDox .userItem .block-right-item').length;
                    $('.chooseBox').eq(1).html(num+'人').attr('data-num',num);
                },$('.gwpost').val(),$('.zwposition').val())
            })
//            点击角色
			$('#privBtn').on('click',function () {
			    if(!privBtnflag){
                    privBtnflag = true;
                    $.ajax({
                        type:'get',
                        url:'/userPriv/getAllPriv',
                        dataType:'json',
                        success:function (res) {
                            var data=res.obj;
                            var str='';
                            if(res.flag){
                                if(data.length>0){
                                    for(var i=0;i<data.length;i++){
                                        str+='<div class="block-left-item" block="priv" userPriv="'+data[i].userPriv+'" title="'+data[i].privName+'"><span>'+data[i].privName+'</span></div>'
                                    }
                                }
                                var strHtml='<div class="leftPriv"><div class="block-left-header">系统全局角色</div>'+str+'</div>'
                                $('#allPriv').html(strHtml);
                            }
                        }
                    })
				}else{
			        if($('#allPriv .privActive').length != 0){
                        $('#allPriv .privActive').trigger('click');
					}
				}

            })
//			点击分组
			$('#groupBtn').on('click',function () {
                if(!groupflag){
                    groupflag = true;
                    $.ajax({
                        type:'get',
                        url:'/usergroup/getAllUserGroup',
                        dataType:'json',
                        success:function (res) {
                            var data=res.obj;
                            var str='';
                            if(res.flag){
                                if(data.length > 0){
                                    for(var i=0;i<data.length;i++){
                                        str+='<div class="block-left-item" block="group" groupId="'+data[i].groupId+'" title="'+data[i].groupName+'"><span>'+data[i].groupName+'</span></div>'
                                    }
                                }
                                var strHtml='<div class="leftGroup"><div class="block-left-header">公共自定义组</div>'+str+'</div>';
                                $('#allGroup').html(strHtml);
                            }
                        }
                    })
				}else{

                    if($('#allGroup .privActive').length != 0){
                        $('#allGroup .privActive').trigger('click');
                    }
				}

            })

            //			点击自定义组
            $('#customGroup').on('click',function () {
                if(!customflag){
                    customflag = true;
                    $.ajax({
                        type:'get',
                        url:'/usergroup/getAllUserGroup1',
                        dataType:'json',
                        success:function (res) {
                            var data=res.obj;
                            var str='';
                            if(res.flag){
                                if(data.length > 0){
                                    for(var i=0;i<data.length;i++){
                                        str+='<div class="block-left-item" block="custom" groupId="'+data[i].groupId+'" title="'+data[i].groupName+'"><span>'+data[i].groupName+'</span></div>'
                                    }
                                }
                                var strHtml='<div class="leftGroup"><div class="block-left-header">个人自定义组</div>'+str+'</div>';
                                $('#allcustom').html(strHtml);
                            }
                        }
                    })
                }else{

                    if($('#allcustom .privActive').length != 0){
                        $('#allcustom .privActive').trigger('click');
                    }
                }

                $('.addcustom').on('click',function () {
                    $.popWindow("../../common/customEdit");
                })

            })
//			点击在线
			$('#userOnline').on('click',function () {
                // onlineUser();
				onlineUser($('.gwpost').val(),$('.zwposition').val());
            })

            $.ajax({
                type:'get',
                url:'/user/getOnlineMap',
                dataType:'json',
                async:false,
                success:function (res) {
                    var data=res.object;
                    if(res.flag){
                        for(var key in data){
                            var arrKey=[];
                            arrKey.push(key);
                            onLine.push(arrKey)
                        }
                    }
                }
            })

			buildDefaultItem();
            queryBenbumen();
			var numIndex = 0;
            function buildDefaultItem(){
				var arr = ''
				if(user_id){
                    user_id = user_id.split(',');
                    if(dataid!=undefined){
                        var userdataid =dataid.split(',');
					}else{
                        var userdataid ='';
					}
                    if(userPrivName!=undefined){
                        var thisuserPrivName =userPrivName.split(',');
                    }else{
                        var thisuserPrivName ='';
                    }
                    selectItemsName = selectItemsName.split(',');
                    for(var i=0;i<user_id.length;i++){
                        if(selectItemsName[i] && user_id[i]) {
//                            arr += '<div class="block-right-item active"  userprivname="'+function(){if(userPrivName[i] == undefined){return ''}else{return userPrivName[i]}}()+'"  item_id="' + dataid[i] + '" item_name="' + selectItemsName[i] + '"  id="' + dataid[i] + '"  user_id="' + user_id[i] + '" uid="' + dataid[i] + '" title="' + selectItemsName[i] + '"><span class="name">' + selectItemsName[i] + ' ' + function(){if(userPrivName[i] == undefined){return ''}else{return userPrivName[i]}}() + '<span class="status"></span></span></div>';
                            arr += '<div class="block-right-item active" item_name="' +selectItemsName[i]+ '" userprivname="' + thisuserPrivName[i] + '" uid="' + userdataid[i] + '" id="' + user_id[i] + '"  user_id="' + user_id[i] + '"><span class="name">' + selectItemsName[i] + '<span class="status"></span></span></div>';
                        }
					}
                    $('#selectedDox .userItem').append(arr);
				}else if(dataid){
                    dataid =dataid.split(',');
                    selectItemsName = selectItemsName.split(',');
                    for(var i=0;i<dataid.length;i++){
                        if(selectItemsName[i] && dataid[i]) {
//                            arr += '<div class="block-right-item active"  userprivname="'+function(){if(userPrivName[i] == undefined){return ''}else{return userPrivName[i]}}()+'"  item_id="' + dataid[i] + '" item_name="' + selectItemsName[i] + '"  id="' + dataid[i] + '"  user_id="' + user_id[i] + '" uid="' + dataid[i] + '" title="' + selectItemsName[i] + '"><span class="name">' + selectItemsName[i] + ' ' + function(){if(userPrivName[i] == undefined){return ''}else{return userPrivName[i]}}() + '<span class="status"></span></span></div>';
                            arr += '<div class="block-right-item active" item_name="' +selectItemsName[i]+ '"  uid="' + dataid[i] + '" id="' + dataid[i] + '"><span class="name">' + selectItemsName[i] + '<span class="status"></span></span></div>';
                        }
                    }
                    $('#selectedDox .userItem').append(arr);
				}
                var num = $('#selectedDox .userItem .block-right-item').length;
                $('.chooseBox').eq(1).html(num+'人').attr('data-num',num);
			};
            initTree = function(){
                var url="../department/getChDept";
                if(classDept){
                    url = '/hierarchical/getClassifyOrgByAdmin';
				}else{
                    if(paraValue == ""){
                        url = "../department/getChDept";
                    }else{
                        url = '../getUserOrg '
                    }
				}

                $('#deptOrg').tree({
                    url: url,
                    animate:true,
                    checkbox:true,
                    cascadeCheck:true,
                    loadFilter: function(node){
                        numIndex++;

                        if(node.msg == 'success'){
                            if(node.obj.length>0){
                                for(var i=0;i<node.obj.length;i++){
                                    searchPara += node.obj[i].deptNo +','
                                }
                            }

                        }
                        return convert(node.obj);
                    },
                    onClick:function(node){
//                        buildUserList(node.id,node.text);
						node1 = node.id
						nodeName = node.text
                        // buildNewUserList(node.id,node.text);
						buildNewUserList(node.id,node.text,$('.gwpost').val(),$('.zwposition').val());
                        $(this).tree(node.state === 'closed' ? 'expand' : 'collapse', node.target);
                        node.state = node.state === 'closed' ? 'open' : 'closed';
                    },
                    onDblClick:function (node) {

                    },
                    onLoadSuccess:function(node,data){
						if(classDept != ''){
							if($('#deptOrg li .tree-node-selected').length == 0){
								$('#deptOrg li .tree-node').eq(0).trigger('click')
							}
						}

					},
                    onBeforeExpand:function(node,param){
                        $('#deptOrg').tree('options').url = "../department/getChDept?deptId=" + node.id;// change the url
                    },
					onCheck:function (node,checked) {
						if(checked){
							nodedept += node.id +','
							nodedeptArr=nodedept.split(',')
							$('.tree-checkbox').addClass('sele')
							nodedeptName = node.text
						}else{
							nodedeptArr.forEach(function (value,index) {
								if(value==node.id){
									nodedeptArr.splice(index,1);
									nodedept=nodedeptArr.join(',')
								}
							})
							$('#deptBox').find('.block-right-item').removeClass('active');
							$('#selectedDox .userItem .block-right-item').each(function() {
								if( $('#deptBox .userItem #'+$(this).attr('user_id')).length > 0){
									$('#deptBox .userItem #'+$(this).attr('user_id')).removeClass('active');
								}
							});
							$('#selectedDox .userItem .block-right-item').remove();
							var num = $('#selectedDox .userItem .block-right-item').length;
							$('.chooseBox').eq(1).html(num+'人').attr('data-num',num);
						}
						if($(".checkboxs").attr("checked") == "checked"){
							if($('.gwpost').val() == '' && $('.zwposition').val()==''){
								checks(nodedept.substr(0,nodedept.length-1))
							}
							if($('.gwpost') != '' || $('.zwposition').val() !=''){
								fuxuan(nodedept.substr(0,nodedept.length-1),$('.gwpost').val(),$('.zwposition').val())
							}
						}else{
							showUserAndDept(nodedept.substr(0,nodedept.length-1),nodedeptName,function () {
							},$('.gwpost').val(),$('.zwposition').val());
						}
                    }


                });
			}
            $.ajax({
                url:'../sys/showUnitManage',
                type:'get',
                dataType:'json',
                success:function(obj){
                    $('#companyName').html(obj.object.unitName);
                    $('.childdept').show();
                    initTree();
                }
            });
			//搜索
			$('#keyword').bind('input propertychange', function() {
			    var text = encodeURI($(this).val());
			    $('#searchName').show();
			    if(text!= ''){
                    throttle(autodivheights,text);
				}else{
                    $('#searchName .userItem').html('');
				}
			});
			$('#selectedDox #block-right-remove').on('click',function () {
                $('#selectedDox .userItem .block-right-item').each(function() {
                    if( $('#deptBox .userItem #'+$(this).attr('user_id')).length > 0){
                        $('#deptBox .userItem #'+$(this).attr('user_id')).removeClass('active');
                    }
                });
                $('#selectedDox .userItem .block-right-item').remove();
                var num = $('#selectedDox .userItem .block-right-item').length;
                $('.chooseBox').eq(1).html(num+'人').attr('data-num',num);
            });

            $('#selectedDox .userItem ').on('click','.block-right-item',function () {
                $('#deptBox .userItem #'+$(this).attr('user_id')).removeClass('active');
                $(this).remove();
                var num = $('#selectedDox .userItem .block-right-item').length;
                $('.chooseBox').eq(1).html(num+'人').attr('data-num',num);
            });

			// //判断复选框选中的操作
			$(".checkboxs").on('click',function() {
				$('#bgm').show()
				setTimeout(function () {
					checks(nodedept.substr(0,nodedept.length-1))
				},100);
			})
			function checks(deptids){
				if($(".checkboxs").attr("checked") == "checked"){
					if($('.gwpost').val()=='' &&$('.zwposition').val()==''){
						deleteAllUser($('#deptBox'))//清除部门全部选中的方法
						ajaaxs(deptids)
					}else{
						$('#bgm').hide()
						fuxuan(nodedept.substr(0,nodedept.length-1),$('.gwpost').val(),$('.zwposition').val())
					}
				}else{
					$('#bgm').hide()
					showUserAndDept(nodedept.substr(0,nodedept.length-1),nodedeptName,'',$('.gwpost').val(),$('.zwposition').val())
				}
			}
			function fuxuan(deptids,jobId,postId) {
				$.ajax({
					type:'get',
					url:'/department/getNewChAllDept',
					data:{
						deptId:deptids,
						jobId:jobId,
						postId:postId
					},
					dataType:'json',
					success:function (res) {
						$('#bgm').hide()
						var data=res.object;
						var str='';
						var objStr='';
						var objStr1='';
						if(res.flag){
							for(var k=0;k<data.length;k++){
								if(deptids.indexOf(',')>-1){
									if(Array.isArray(data[k].child)&&data[k].child.length>0){
										for(var a =0;a<data[k].child.length;a++){
											var useres =data[k].child[a].users
											if(useres.length>0){
												var user_idArr = [];
												if(user_id){
													if(Array.isArray(user_id)){
														user_idArr= user_id;
													}else {
														user_idArr= user_id.split(',');
													}
												}
												for(var b=0;b<useres.length;b++){
													objStr+='<div class="block-right-item '+function () {
														if(user_id) {  //判断user_id是否存在

															var bool = false;
															for (var j = 0; j < user_idArr.length; j++) {
																if (useres[b] != undefined&&useres[b].userId == user_idArr[j]) {
																	bool = true;
																	break;
																}
															}
															if (bool) {
																return 'active';
															}else {
																return ''
															}
														}else {
															return ''
														}
													}()+'" item_id="'+useres[b].uid+'" userPrivName="'+function(){if(useres[b].userPrivName==undefined){return ''}else{return useres[b].userPrivName}}()+'" item_name="'+useres[b].userName+'" id="'+useres[b].userId+'" user_id="'+useres[b].userId+'" uid="'+useres[b].uid+'" title="'+useres[b].userName+'"><span class="name">'+'['+check(useres[b].deptName)+']&nbsp;'+check(useres[b].userName)+''+function(){if(useres[b].userPrivName==undefined){return ''}else{return useres[b].userPrivName}}()+'<span class="status">'+function () {
														if(onLine.toString().indexOf(useres[b].userId) > -1){
															return '<span style="color:#ff0000;margin-left: 10px;">在线</span>';
														}else{
															return '';
														}
													}()+' </span></span></div>';
												}
											}
										}
									} else{
										if(data[k].users.length>0){
											var user_idArr = [];
											if(user_id){
												if(Array.isArray(user_id)){
													user_idArr= user_id;
												}else {
													user_idArr= user_id.split(',');
												}
											}
											for(var b=0;b<data[k].users.length;b++){
												objStr+='<div class="block-right-item '+function () {
													if(user_id) {  //判断user_id是否存在

														var bool = false;
														for (var j = 0; j < user_idArr.length; j++) {
															if (data[k].users[b] != undefined&&data[k].users[b].userId == user_idArr[j]) {
																bool = true;
																break;
															}
														}
														if (bool) {
															return 'active';
														}else {
															return ''
														}
													}else {
														return ''
													}
												}()+'" item_id="'+data[k].users[b].uid+'" userPrivName="'+function(){if(data[k].users[b].userPrivName==undefined){return ''}else{return data[k].users[b].userPrivName}}()+'" item_name="'+data[k].users[b].userName+'" id="'+data[k].users[b].userId+'" user_id="'+data[k].users[b].userId+'" uid="'+data[k].users[b].uid+'" title="'+data[k].users[b].userName+'"><span class="name">'+'['+check(data[k].users[b].deptName)+']&nbsp;'+check(data[k].users[b].userName)+''+function(){if(data[k].users[b].userPrivName==undefined){return ''}else{return data[k].users[b].userPrivName}}()+'<span class="status">'+function () {
													if(onLine.toString().indexOf(data[k].users[b].userId) > -1){
														return '<span style="color:#ff0000;margin-left: 10px;">在线</span>';
													}else{
														return '';
													}
												}()+' </span></span></div>';
											}
										}
									}
								}else{
									if(data[k].users.length>0){
										var user_idArr = [];
										if(user_id){
											if(Array.isArray(user_id)){
												user_idArr= user_id;
											}else {
												user_idArr= user_id.split(',');
											}
										}
										for(var b=0;b<data[k].users.length;b++){
											objStr+='<div class="block-right-item '+function () {
												if(user_id) {  //判断user_id是否存在

													var bool = false;
													for (var j = 0; j < user_idArr.length; j++) {
														if (data[k].users[b] != undefined&&data[k].users[b].userId == user_idArr[j]) {
															bool = true;
															break;
														}
													}
													if (bool) {
														return 'active';
													}else {
														return ''
													}
												}else {
													return ''
												}
											}()+'" item_id="'+data[k].users[b].uid+'" userPrivName="'+function(){if(data[k].users[b].userPrivName==undefined){return ''}else{return data[k].users[b].userPrivName}}()+'" item_name="'+data[k].users[b].userName+'" id="'+data[k].users[b].userId+'" user_id="'+data[k].users[b].userId+'" uid="'+data[k].users[b].uid+'" title="'+data[k].users[b].userName+'"><span class="name">'+'['+check(data[k].users[b].deptName)+']&nbsp;'+check(data[k].users[b].userName)+''+function(){if(data[k].users[b].userPrivName==undefined){return ''}else{return data[k].users[b].userPrivName}}()+'<span class="status">'+function () {
												if(onLine.toString().indexOf(data[k].users[b].userId) > -1){
													return '<span style="color:#ff0000;margin-left: 10px;">在线</span>';
												}else{
													return '';
												}
											}()+' </span></span></div>';
										}
									}
									if(data[k].child != undefined){
										str=deptLiData(data[k].child,0);
									}
								}
							}

							if($(".checkboxs").attr("checked") == "checked"){
								if($('.gwpost').val()!='' || $('.zwposition').val() !=''){
									$.ajax({
										url:'/department/getUserByDeptName',
										type:'get',
										dataType:'json',
										data:{
											deptIds:deptids
										},
										success:function(res){
											var objects = res.obj
											if(objects !=''){
												for(var i=0;i<objects.length;i++){
													if(objects.length>0){
														var user_idArr = [];
														if(user_id){
															if(Array.isArray(user_id)){
																user_idArr= user_id;
															}else {
																user_idArr= user_id.split(',');
															}
														}
														objStr1+='<div class="block-right-item '+function () {
															if(user_id) {  //判断user_id是否存在
																var bool = false;
																for (var j = 0; j < user_idArr.length; j++) {
																	if (objects[i] != undefined&&objects[i].userId == user_idArr[j]) {
																		bool = true;
																		break;
																	}
																}
																if (bool) {
																	return 'active';
																}else {
																	return ''
																}
															}else {
																return ''
															}
														}()+'" item_id="'+objects[i].uid+'" userPrivName="'+function(){if(objects[i].userPrivName==undefined){return ''}else{return objects[i].userPrivName}}()+'" item_name="'+objects[i].userName+'" id="'+objects[i].userId+'" user_id="'+objects[i].userId+'" uid="'+objects[i].uid+'" title="'+objects[i].userName+'"><span class="name">'+'['+check(objects[i].deptName)+']&nbsp;'+check(objects[i].userName)+''+function(){if(objects[i].userPrivName==undefined){return ''}else{return objects[i].userPrivName}}()+'<span class="status">'+function () {
															if(onLine.toString().indexOf(objects[i].userId) > -1){
																return '<span style="color:#ff0000;margin-left: 10px;">在线</span>';
															}else{
																return '';
															}
														}()+' </span></span></div>';
													}
												}
												$('#deptBox').find('.userItem').html(objStr+str+objStr1)
												addAllUser($('#deptBox')) //选中条件筛选选中的值
											}else{
												var boxs = "<div style='font-size: 16px;text-align: center;font-weight: 600;margin-top: 10px;'>暂无人员</div>"
												$('#deptBox').find('.userItem').html(boxs)
											}

										}
									})
								}
							}else{
								objStr1 = "";
								$('#deptBox').find('.userItem').html(objStr+str+objStr1)
								addAllUser($('#deptBox')) //选中条件筛选选中的值
							}
						}
					},
					error:function(XMLHttpRequest, textStatus, errorThrown){
						// 状态码
						console.log(XMLHttpRequest.status);
						// 状态
						console.log(XMLHttpRequest.readyState);
						// 错误信息
						console.log(textStatus);
						layer.close(index);
					}
				})
			}
			function ajaaxs(deptids){
				$.ajax({
					url:'/department/getUserByDeptName',
					type:'get',
					dataType:'json',
					data:{
						deptIds: deptids
					},
					success:function(res){
						$('#bgm').hide()
						var objStr1 = "";
						var objects = res.obj
						if(objects !=''){
							for(var i=0;i<objects.length;i++){
								if(objects.length>0){
									var user_idArr = [];
									if(user_id){
										if(Array.isArray(user_id)){
											user_idArr= user_id;
										}else {
											user_idArr= user_id.split(',');
										}
									}
									objStr1+='<div class="block-right-item '+function () {
										if(user_id) {  //判断user_id是否存在
											var bool = false;
											for (var j = 0; j < user_idArr.length; j++) {
												if (objects[i] != undefined&&objects[i].userId == user_idArr[j]) {
													bool = true;
													break;
												}
											}
											if (bool) {
												return 'active';
											}else {
												return ''
											}
										}else {
											return ''
										}
									}()+'" item_id="'+objects[i].uid+'" userPrivName="'+function(){if(objects[i].userPrivName==undefined){return ''}else{return objects[i].userPrivName}}()+'" item_name="'+objects[i].userName+'" id="'+objects[i].userId+'" user_id="'+objects[i].userId+'" uid="'+objects[i].uid+'" title="'+objects[i].userName+'"><span class="name">'+'['+check(objects[i].deptName)+']&nbsp;'+check(objects[i].userName)+''+function(){if(objects[i].userPrivName==undefined){return ''}else{return objects[i].userPrivName}}()+'<span class="status">'+function () {
										if(onLine.toString().indexOf(objects[i].userId) > -1){
											return '<span style="color:#ff0000;margin-left: 10px;">在线</span>';
										}else{
											return '';
										}
									}()+' </span></span></div>';
								}
							}
							$('#deptBox').find('.userItem').html(objStr1)
							addAllUser($('#deptBox')) //选中条件筛选选中的值
						}else{
							var boxs = "<div style='font-size: 16px;text-align: center;font-weight: 600;margin-top: 10px;'>暂无人员</div>"
							$('#deptBox').find('.userItem').html(boxs)
						}
					},
					error:function(XMLHttpRequest, textStatus, errorThrown){
						// 状态码
						console.log(XMLHttpRequest.status);
						// 状态
						console.log(XMLHttpRequest.readyState);
						// 错误信息
						console.log(textStatus);
						layer.close(index);
					}
				})
			}

            function buildUserList(id,text){
                $('#block-right-header').text(text)
                $.ajax({
                    type: "get",
                    url: "../department/getChDept?deptId=" + id,
                    dataType: 'JSON',
                    success: function (res) {
                        var tr = [];
						var num=0;
                       res.obj.forEach(function (v,i) {
							var divObj ;
						   if(v.userId){
                               $('#block-right-header').show();
                               $('#block-right-add').show();
                               $('#block-right-remove').show();
                               num++;
                               if(v.sex==0){
                                   divObj = $('<div class="block-right-item '+function () {
                                       if(user_id ||dataid) {
                                           var user_idArr;
                                           var uidArr;
                                           if(Array.isArray(user_id)){
                                               user_idArr= user_id;
										   }else {
                                               user_idArr= user_id.split(',');
										   }
										   if(dataid != null){
                                               if(Array.isArray(dataid)){
                                                   uidArr= dataid;
                                               }else {
                                                   uidArr= dataid.split(',');
                                               }
										   }
                                           var bool = false;
										   if(dataid != null){
                                               for (var i = 0; i < uidArr.length; i++) {
                                                   if (v.uid == uidArr[i]) {
                                                       bool = true;
                                                       break;
                                                   }
                                               }
										   }else if(user_id){
                                               for (var i = 0; i < user_idArr.length; i++) {
                                                   if (v.userId == user_idArr[i]) {
                                                       bool = true;
                                                       break;
                                                   }
                                               }
										   }
                                           if (bool) {
                                               return 'active';
                                           }else {
                                               return ''
										   }
                                       }else {
                                           return ''
									   }
                                       }()+'" item_id="'+v.uid+'" item_name="'+v.userName+'" id="'+v.userId+'" user_id="'+v.userId+'" uid="'+v.uid+'" userPrivName="'+function(){if(v.userPrivName==undefined){return ''}else{return v.userPrivName}}()+'" title="'+v.userName+'"><span class="name">'+'['+check(v.deptName)+']&nbsp;'+check(v.userName)+' '+function(){if(v.userPrivName==undefined){return ''}else{return v.userPrivName}}()+'<span class="status"> '+function () {
                                           if(onLine.toString().indexOf(v.userId) > -1){
                                               return '<span style="color:#ff0000;">在线</span>';
                                           }else{
                                               return '';
                                           }
                                       }()+'</span></span></div>');
                               }else if(v.sex==1){
                                   divObj = $('<div class="block-right-item '+function () {
                                       if(user_id || dataid) {
                                           var user_idArr;
                                           var uidArr;
                                           if(Array.isArray(user_id)){
                                               user_idArr= user_id;
                                           }else {
                                               user_idArr= user_id.split(',');
                                           }
                                           if(Array.isArray(dataid)){
                                               uidArr= dataid;
                                           }else {
                                               uidArr= dataid.split(',');
                                           }
                                           var bool = false;
                                           for (var i = 0; i < user_idArr.length; i++) {
                                               if (v.userId == user_idArr[i] || v.uid == uidArr[i]) {
                                                   bool = true;
                                                   break;
                                               }
                                           }
                                           if (bool) {
                                               return 'active';
                                           }else {
                                               return ''
										   }
                                       }else {
                                           return ''
									   }
                                       }()+'" item_id="'+v.uid+'" item_name="'+v.userName+'"  id="'+v.userId +'"  user_id="'+v.userId+'" uid="'+v.uid+'" userPrivName="'+function(){if(v.userPrivName==undefined){return ''}else{return v.userPrivName}}()+'" title="'+v.userName+'"><span class="name">'+'['+check(v.deptName)+']&nbsp;'+check(v.userName)+' '+function(){if(v.userPrivName==undefined){return ''}else{return v.userPrivName}}()+'<span class="status">'+function () {
                                           if(onLine.toString().indexOf(v.userId) > -1){
                                               return '<span style="color:#ff0000;">在线</span>';
                                           }else{
                                               return '';
                                           }
                                       }()+'</span></span></div>');
                               }

                               tr.push(divObj);
                           }

                       });
                        if(num==0){
                            $('#block-right-header').hide();
                            $('#block-right-add').hide();
                            $('#block-right-remove').hide();
                            tr.push($('<div style="width: 230px;height: 200px;margin: 20px auto;text-align: center">' +
                                '<img src="/img/common/dianjikong.png" style="margin-top: 20px;" alt="">\
                                <span style="width: 100%;display: inline-block;margin-top: 10px;\
                            font-size: 15px;\
                            font-weight: bold;">本部门暂无人员</span>' +
                                '</div>'))
                        }else {
                            $('#block-right-header').show();
                            $('#block-right-add').show();
                            $('#block-right-remove').show();
						}
                        $('#deptBox .userItem').html(tr);

                    }
                });
			}
//			点击部门显示本部门及子部门人员
// 			function buildNewUserList(id,text) {
			function buildNewUserList(id,text,jobId,postId) {
                $('#block-right-header').text(text)
				$.ajax({
					type:'get',
					// url:'/department/getNewChDept?deptId=' + id,
					url:'/department/getNewChDeptBai?deptId=' + id +'&jobId='+ jobId +'&postId='+ postId + '&moduleId=' + moduleId,
					dataType:'json',
                    success: function (res) {
                        var tr = [];
                        var num=0;
                        var length = $('#selectedDox #dept_item .block-right-item').length;
                        var chooseuidarr = [];
                        var choosearr = [];
                        for(var i=0;i<length;i++){
                            var uid = $('#selectedDox #dept_item .block-right-item').eq(i).attr('uid');
                            var userid = $('#selectedDox #dept_item .block-right-item').eq(i).attr('user_id');
                            chooseuidarr.push(uid);
                            choosearr.push(userid);
                        }
                        res.obj.forEach(function (v,i) {
                            var divObj ;
                            if(v.userId){
                                $('#block-right-header').show();
                                $('#block-right-add').show();
                                $('#block-right-remove').show();
                                num++;
								divObj = $('<div class="block-right-item '+function () {
										if(choosearr ||chooseuidarr) {
											var user_idArr;
											var uidArr;
											if(Array.isArray(choosearr)){
												user_idArr= choosearr;
											}else {
												user_idArr= choosearr.split(',');
											}
											if(chooseuidarr != null){
												if(Array.isArray(chooseuidarr)){
													uidArr= chooseuidarr;
												}else {
													uidArr= chooseuidarr.split(',');
												}
											}
											var bool = false;
											if(chooseuidarr != null){
												for (var i = 0; i < uidArr.length; i++) {
													if (v.uid == uidArr[i]) {
														bool = true;
														break;
													}
												}
											}else if(choosearr){
												for (var i = 0; i < user_idArr.length; i++) {
													if (v.userId == user_idArr[i]) {
														bool = true;
														break;
													}
												}
											}
											if (bool) {
												return 'active';
											}else {
												return ''
											}
										}else {
											return ''
										}
									}()+'" item_id="'+v.uid+'" item_name="'+v.userName+'" id="'+v.userId+'" user_id="'+v.userId+'" uid="'+v.uid+'" userPrivName="'+function(){if(v.userPrivName==undefined){return ''}else{return v.userPrivName}}()+'" title="'+v.userName+'"><span class="name">'+'['+check(v.deptName)+']&nbsp;'+check(v.userName)+' '+function(){if(v.userPrivName==undefined){return ''}else{return v.userPrivName}}()+'<span class="status"> '+function () {
										if(onLine.toString().indexOf(v.userId) > -1){
											return '<span style="color:#ff0000;">在线</span>';
										}else{
											return '';
										}
									}()+'</span></span></div>');
                                tr.push(divObj);
                            }

                        });
                        if(num==0){
                            $('#block-right-header').hide();
                            $('#block-right-add').hide();
                            $('#block-right-remove').hide();
                            tr.push($('<div style="width: 230px;height: 200px;margin: 20px auto;text-align: center">' +
                                '<img src="/img/common/dianjikong.png" style="margin-top: 20px;" alt="">\
                                <span style="width: 100%;display: inline-block;margin-top: 10px;\
                            font-size: 15px;\
                            font-weight: bold;">本部门暂无人员</span>' +
                                '</div>'))
                        }else {
                            $('#block-right-add').show();
                            $('#block-right-remove').show();
                        }
                        $('#deptBox .userItem').html(tr);

                    }
				})
            }
//            点击左侧树中部门前的复选框，显示该部门人员及该部门下的子部门和人员
			function showUserAndDept(id,text,fn,jobId,postId) {
				var ides = ''
				ides += id +',' //筛选多个部门的职务和岗位
				cides = ides
				// deleteAllUser($('#deptBox'))//清除部门全部选中的方法
				var index = layer.load();
                $('#block-right-header').text(text);
                $.ajax({
					type:'get',
					url:'/department/getNewChAllDept?',
					data:{
						deptId:ides.substr(0,ides.length-1),
						jobId:jobId,
						postId:postId
					},
					dataType:'json',
					success:function (res) {
						$('#bgm').hide()
						var data=res.object;
						var str='';
						var objStr='';
						var objStr1='';
						if(res.flag){
							for(var k=0;k<data.length;k++){
								if(ides.substr(0,ides.length-1).indexOf(',')>-1){
									if(Array.isArray(data[k].child)&&data[k].child.length>0){
										for(var a =0;a<data[k].child.length;a++){
											var useres =data[k].child[a].users
											if(useres.length>0){
												var user_idArr = [];
												if(user_id){
													if(Array.isArray(user_id)){
														user_idArr= user_id;
													}else {
														user_idArr= user_id.split(',');
													}
												}
												for(var b=0;b<useres.length;b++){
													objStr+='<div class="block-right-item '+function () {
														if(user_id) {  //判断user_id是否存在

															var bool = false;
															for (var j = 0; j < user_idArr.length; j++) {
																if (useres[b] != undefined&&useres[b].userId == user_idArr[j]) {
																	bool = true;
																	break;
																}
															}
															if (bool) {
																return 'active';
															}else {
																return ''
															}
														}else {
															return ''
														}
													}()+'" item_id="'+useres[b].uid+'" userPrivName="'+function(){if(useres[b].userPrivName==undefined){return ''}else{return useres[b].userPrivName}}()+'" item_name="'+useres[b].userName+'" id="'+useres[b].userId+'" user_id="'+useres[b].userId+'" uid="'+useres[b].uid+'" title="'+useres[b].userName+'"><span class="name">'+'['+check(useres[b].deptName)+']&nbsp;'+check(useres[b].userName)+''+function(){if(useres[b].userPrivName==undefined){return ''}else{return useres[b].userPrivName}}()+'<span class="status">'+function () {
														if(onLine.toString().indexOf(useres[b].userId) > -1){
															return '<span style="color:#ff0000;margin-left: 10px;">在线</span>';
														}else{
															return '';
														}
													}()+' </span></span></div>';
												}
											}
										}
									} else{
										if(data[k].users.length>0){
											var user_idArr = [];
											if(user_id){
												if(Array.isArray(user_id)){
													user_idArr= user_id;
												}else {
													user_idArr= user_id.split(',');
												}
											}
											for(var b=0;b<data[k].users.length;b++){
												objStr+='<div class="block-right-item '+function () {
													if(user_id) {  //判断user_id是否存在

														var bool = false;
														for (var j = 0; j < user_idArr.length; j++) {
															if (data[k].users[b] != undefined&&data[k].users[b].userId == user_idArr[j]) {
																bool = true;
																break;
															}
														}
														if (bool) {
															return 'active';
														}else {
															return ''
														}
													}else {
														return ''
													}
												}()+'" item_id="'+data[k].users[b].uid+'" userPrivName="'+function(){if(data[k].users[b].userPrivName==undefined){return ''}else{return data[k].users[b].userPrivName}}()+'" item_name="'+data[k].users[b].userName+'" id="'+data[k].users[b].userId+'" user_id="'+data[k].users[b].userId+'" uid="'+data[k].users[b].uid+'" title="'+data[k].users[b].userName+'"><span class="name">'+'['+check(data[k].users[b].deptName)+']&nbsp;'+check(data[k].users[b].userName)+''+function(){if(data[k].users[b].userPrivName==undefined){return ''}else{return data[k].users[b].userPrivName}}()+'<span class="status">'+function () {
													if(onLine.toString().indexOf(data[k].users[b].userId) > -1){
														return '<span style="color:#ff0000;margin-left: 10px;">在线</span>';
													}else{
														return '';
													}
												}()+' </span></span></div>';
											}
										}
									}
								}else{
									if(data[k].users.length>0){
										var user_idArr = [];
										if(user_id){
											if(Array.isArray(user_id)){
												user_idArr= user_id;
											}else {
												user_idArr= user_id.split(',');
											}
										}
										for(var b=0;b<data[k].users.length;b++){
											objStr+='<div class="block-right-item '+function () {
												if(user_id) {  //判断user_id是否存在

													var bool = false;
													for (var j = 0; j < user_idArr.length; j++) {
														if (data[k].users[b] != undefined&&data[k].users[b].userId == user_idArr[j]) {
															bool = true;
															break;
														}
													}
													if (bool) {
														return 'active';
													}else {
														return ''
													}
												}else {
													return ''
												}
											}()+'" item_id="'+data[k].users[b].uid+'" userPrivName="'+function(){if(data[k].users[b].userPrivName==undefined){return ''}else{return data[k].users[b].userPrivName}}()+'" item_name="'+data[k].users[b].userName+'" id="'+data[k].users[b].userId+'" user_id="'+data[k].users[b].userId+'" uid="'+data[k].users[b].uid+'" title="'+data[k].users[b].userName+'"><span class="name">'+'['+check(data[k].users[b].deptName)+']&nbsp;'+check(data[k].users[b].userName)+''+function(){if(data[k].users[b].userPrivName==undefined){return ''}else{return data[k].users[b].userPrivName}}()+'<span class="status">'+function () {
												if(onLine.toString().indexOf(data[k].users[b].userId) > -1){
													return '<span style="color:#ff0000;margin-left: 10px;">在线</span>';
												}else{
													return '';
												}
											}()+' </span></span></div>';
										}
									}
									if(data[k].child != undefined){
										str=deptLiData(data[k].child,0);
									}
								}
							}

							if($(".checkboxs").attr("checked") == "checked"){
								if($('.gwpost').val()!='' || $('.zwposition').val() !=''){
									$.ajax({
										url:'/department/getUserByDeptName',
										type:'get',
										dataType:'json',
										data:{
											deptIds:cides.substr(0,cides.length-1)
										},
										success:function(res){
											var objects = res.obj
											if(objects !=''){
												for(var i=0;i<objects.length;i++){
													if(objects.length>0){
														var user_idArr = [];
														if(user_id){
															if(Array.isArray(user_id)){
																user_idArr= user_id;
															}else {
																user_idArr= user_id.split(',');
															}
														}
														objStr1+='<div class="block-right-item '+function () {
															if(user_id) {  //判断user_id是否存在
																var bool = false;
																for (var j = 0; j < user_idArr.length; j++) {
																	if (objects[i] != undefined&&objects[i].userId == user_idArr[j]) {
																		bool = true;
																		break;
																	}
																}
																if (bool) {
																	return 'active';
																}else {
																	return ''
																}
															}else {
																return ''
															}
														}()+'" item_id="'+objects[i].uid+'" userPrivName="'+function(){if(objects[i].userPrivName==undefined){return ''}else{return objects[i].userPrivName}}()+'" item_name="'+objects[i].userName+'" id="'+objects[i].userId+'" user_id="'+objects[i].userId+'" uid="'+objects[i].uid+'" title="'+objects[i].userName+'"><span class="name">'+'['+check(objects[i].deptName)+']&nbsp;'+check(objects[i].userName)+''+function(){if(objects[i].userPrivName==undefined){return ''}else{return objects[i].userPrivName}}()+'<span class="status">'+function () {
															if(onLine.toString().indexOf(objects[i].userId) > -1){
																return '<span style="color:#ff0000;margin-left: 10px;">在线</span>';
															}else{
																return '';
															}
														}()+' </span></span></div>';
													}
												}
												$('#deptBox').find('.userItem').html(objStr+str+objStr1)
												addAllUser($('#deptBox')) //选中条件筛选选中的值
											}else{
												var boxs = "<div style='font-size: 16px;text-align: center;font-weight: 600;margin-top: 10px;'>暂无人员</div>"
												$('#deptBox').find('.userItem').html(boxs)
											}
										}
									})
								}
							}else{
								objStr1 = "";
								deleteAllUser($('#deptBox'))//清除部门全部选中的方法
								$('#deptBox').find('.userItem').html(objStr+str)
								addAllUser($('#deptBox')) //选中条件筛选选中的值
							}
							if(fn){
								fn();
							}
						}
						layer.close(index);
					},
				})
            }
//            显示下级部门
			function deptLiData(data,level) {
                var divObj_s='';
                for(var i=0;i<data.length;i++){
                    var String="";
                    var space=""
                    for(var j=0;j<level;j++){
                        space+="&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;";
                    }
                    if(i==0){
                        String=space+"┌";
                    }else
                    if(i!=0){
                        String=space+"├";
                    }else
                    if(i==data.length-1){
                        String=space+"└";
                    }
                    divObj_s+='<div class="block-right-header textLeft" style="padding-left: 20px;" deptName="'+data[i].deptName+'" deptId="'+data[i].deptId+'">' +
                        '<span>'+String+'</span><span class="name" style="margin-left: 5px;">'+data[i].deptName+'</span>' +
                        '</div>'+function () {
                            var userChild='';
							if(data[i].users.length>0){
							    for(var n=0;n<data[i].users.length;n++){
                                    userChild+='<div class="block-right-item '+function () {
                                            if(user_id ||dataid) {
                                                var user_idArr;
                                                var uidArr;
                                                if(Array.isArray(user_id)){
                                                    user_idArr= user_id;
                                                }else {
                                                    user_idArr= user_id.split(',');
                                                }
                                                if(dataid != null){
                                                    if(Array.isArray(dataid)){
                                                        uidArr= dataid;
                                                    }else {
                                                        uidArr= dataid.split(',');
                                                    }
                                                }
                                                var bool = false;
                                                if(dataid != null){
                                                    for (var i = 0; i < uidArr.length; i++) {
                                                        if(data[i].users[n]&&data[i].users[n].uid == uidArr[i]) {
                                                            bool = true;
                                                            break;
                                                        }
                                                    }
                                                }else if(user_id){
                                                    for (var i = 0; i < user_idArr.length; i++) {
                                                        if(data[i].users[n]&&data[i].users[n].userId == user_idArr[i]) {
                                                            bool = true;
                                                            break;
                                                        }
                                                    }
                                                }
                                                if (bool) {
                                                    return 'active';
                                                }else {
                                                    return ''
                                                }
                                            }else {
                                                return ''
                                            }
                                        }()+'" item_id="'+data[i].users[n].uid+'" item_name="'+data[i].users[n].userName+'" id="'+data[i].users[n].userId+'" user_id="'+data[i].users[n].userId+'" uid="'+data[i].users[n].uid+'" userPrivName="'+function(){if(data[i].users[n].userPrivName==undefined){return ''}else{return data[i].users[n].userPrivName}}()+'" title="'+data[i].users[n].userName+'"><span class="name">'+'['+check(data[i].users[n].deptName)+']&nbsp;'+check(data[i].users[n].userName)+' '+function(){if(data[i].users[n].userPrivName==undefined){return ''}else{return data[i].users[n].userPrivName}}()+'<span class="status"> '+function () {
                                            if(onLine.toString().indexOf(data[i].users[n].userId) > -1){
                                                return '<span style="color:#ff0000;">在线</span>';
                                            }else{
                                                return '';
                                            }
                                        }()+'</span></span></div>';
								}
							}
                            return userChild;
                        }()
					if(data[i].child != undefined){
						divObj_s += deptLiData(data[i].child,level+1);
					}
                }
                return divObj_s
            }
			function TreeNode(id,text,state,children){
				this.id = id;
				this.text = text;
				this.state = state;
				this.children = children;
			}
			function convert(data){
				var arr = [];
				var tr = '';
				var defTr = ''
				data.forEach(function(v,i){
					if(v.deptId){
                        var node = {};
					    if(numIndex == '1'){
                            node = new TreeNode(v.deptId,v.deptName,"closed")
						}else{
                            node = new TreeNode(v.deptId,v.deptName,"closed")
                        }
						arr.push(node);
					}else if(v.userId){
                        if(v.sex==0){
							tr+='<div class="block-right-item '+function () {
                                    if(user_id) {

                                        var user_idArr;
                                        if(Array.isArray(user_id)){
                                            user_idArr= user_id;
                                        }else {
                                            user_idArr= user_id.split(',');
                                        }
                                        var bool = false;
                                        for (var i = 0; i < user_idArr.length; i++) {
                                            if (v.userId == user_idArr[i]) {
                                                bool = true;
                                                break;
                                            }
                                        }
                                        if (bool) {
                                            return 'active';
                                        }else {
                                            return ''
                                        }
                                    }else {
                                        return ''
                                    }
                                }()+'" item_id="'+v.uid+'" userPrivName="'+function(){if(v.userPrivName==undefined){return ''}else{return v.userPrivName}}()+'" item_name="'+v.userName+'" id="'+v.userId+'" user_id="'+v.userId+'" uid="'+v.uid+'" title="'+v.userName+'"><span class="name">'+'['+check(v.deptName)+']&nbsp;'+check(v.userName)+' '+function(){if(v.userPrivName==undefined){return ''}else{return v.userPrivName}}()+'<span class="status">'+function () {
									if(onLine.toString().indexOf(v.userId) > -1){
									    return '<span style="color:#ff0000;">在线</span>';
									}else{
									    return '';
									}
                                }()+' </span></span></div>';
						}else if(v.sex==1){
							tr+='<div class="block-right-item '+function () {
                                    if(user_id) {

                                        var user_idArr;
                                        if(Array.isArray(user_id)){
                                            user_idArr= user_id;
                                        }else {
                                            user_idArr= user_id.split(',');
                                        }
                                        var bool = false;
                                        for (var i = 0; i < user_idArr.length; i++) {
                                            if (v.userId == user_idArr[i]) {
                                                bool = true;
                                                break;
                                            }
                                        }
                                        if (bool) {
                                            return 'active';
                                        }else {
                                            return ''
                                        }
                                    }else {
                                        return ''
                                    }
                                }()+'" item_id="'+v.uid+'" userPrivName="'+function(){if(v.userPrivName==undefined){return ''}else{return v.userPrivName}}()+'" item_name="'+v.userName+'"  id="'+v.uid+'"  user_id="'+v.userId+'" uid="'+v.userId+'" title="'+v.userName+'"><span class="name">'+'['+check(v.deptName)+']&nbsp;'+check(v.userName)+' '+function(){if(v.userPrivName==undefined){return ''}else{return v.userPrivName}}()+'<span class="status">'+function () {
                                    if(onLine.toString().indexOf(v.userId) > -1){
                                        return '<span style="color:#ff0000;">在线</span>';
                                    }else{
                                        return '';
                                    }
                                }()+'</span></span></div>';
						}
					}
				});
				return arr;
			}
            //选人控件默认显示本部门及子部门人员
            function queryBenbumen() {
				$('.gwpost').val('')
				$('.zwposition').val('')
            	if(classDept != ''){

				}else{
					$("#block-right-header").show();
					$("#block-right-add").show();
					$("#block-right-remove").show();
					$.ajax({
						type:'get',
						url:'/user/selNewNowUsers' + '?moduleId=' + moduleId,
						dataType:'json',
						success:function (res) {
							if(res.flag){
								var dataU=res.obj;
								var strU='';
								if(dataU.length != 0){
									$("#block-right-header").text(dataU[0].deptName);
								}
								for(var i=0;i<dataU.length;i++){

									strU+='<div class="block-right-item '+function () {
										if(user_id) {
											var user_idArr;
											if(Array.isArray(user_id)){
												user_idArr= user_id;
											}else {
												user_idArr= user_id.split(',');
											}
											var bool = false;
											for (var j = 0; j < user_idArr.length; j++) {
												if (dataU[i].userId == user_idArr[j]) {
													bool = true;
													break;
												}
											}
											if (bool) {
												return 'active';
											}else {
												return ''
											}
										}else {
											return ''
										}
									}()+'" item_id="'+dataU[i].uid+'" userPrivName="'+function(){if(dataU[i].userPrivName==undefined){return ''}else{return dataU[i].userPrivName}}()+'" item_name="'+dataU[i].userName+'" id="'+dataU[i].userId+'" user_id="'+dataU[i].userId+'" uid="'+dataU[i].uid+'" title="'+dataU[i].userName+'"><span class="name">'+'['+check(dataU[i].deptName)+']&nbsp;'+check(dataU[i].userName)+' '+function(){if(dataU[i].userPrivName==undefined){return ''}else{return dataU[i].userPrivName}}()+'<span class="status">'+function () {
										if(onLine.toString().indexOf(dataU[i].userId) > -1){
											return '<span style="color:#ff0000;">在线</span>';
										}else{
											return '';
										}
									}()+' </span></span></div>';


//                                strU+='<div class="block-right-item" item_name="' +dataU[i].userName+ '" userName="'+dataU[i].userName+'"  user_id="' + dataU[i].userId + '"><span class="name">' + dataU[i].userName + '<span class="status"></span></span></div>'
								}
								$('.curDept').html(strU);
							}
						}
					})
				}

            }

//            显示在线人员
			function onlineUser(jobId,postId) {
				$.ajax({
					type:'get',
					url:'/user/getOnlinePeople',
					data:{
						jobId:jobId,
						postId:postId
					},
					dataType:'json',
					success:function (res) {
						var data=res.obj;
						var str='';
                        var choosearr = [];
                        var length = $('#selectedDox #dept_item .block-right-item').length;
                        for(var i=0;i<length;i++){
                            var user_id = $('#selectedDox #dept_item .block-right-item').eq(i).attr('user_id');
                            choosearr.push(user_id);
                        }
						// if(res.flag){
							if(res.obj != undefined){
						    for(var i=0;i<data.length;i++){
                                str+='<div class="block-right-item '+function () {
                                        if(choosearr) {
                                            var user_idArr;
                                            if(Array.isArray(choosearr)){
                                                user_idArr= choosearr;
                                            }else {
                                                user_idArr= choosearr.split(',');
                                            }
                                            var bool = false;
                                            for (var j = 0; j < user_idArr.length; j++) {
                                                if (data[i].userId == user_idArr[j]) {
                                                    bool = true;
                                                    break;
                                                }
                                            }
                                            if (bool) {
                                                return 'active';
                                            }else {
                                                return ''
                                            }
                                        }else {
                                            return ''
                                        }
                                    }()+'" item_id="'+data[i].uid+'" userPrivName="'+function(){if(data[i].userPrivName==undefined){return ''}else{return data[i].userPrivName}}()+'" item_name="'+data[i].userName+'" id="'+data[i].userId+'" user_id="'+data[i].userId+'" uid="'+data[i].uid+'" title="'+data[i].userName+'"><span class="name">'+'['+check(data[i].deptName)+']&nbsp;'+check(data[i].userName)+' '+function(){if(data[i].userPrivName==undefined){return ''}else{return data[i].userPrivName}}()+'<span class="status">'+function () {
                                        if(onLine.toString().indexOf(data[i].userId) > -1){
                                            return '<span style="color:#ff0000;">在线</span>';
                                        }else{
                                            return '';
                                        }
                                    }()+' </span></span></div>';
							}
							$('#onlineName').find('.userItem').html(str);
						}else{
								var strs = '<div style="font-size: 16px;text-align: center;font-weight: 600;margin-top: 10px;">暂无在线人员</div>'
								$('#onlineName').find('.userItem').html(strs);
							}
                    }
				})
            }
				//组织
				$('.tab_btn').on('click',function(){
					var type = $(this).attr('block');
					$(this).addClass("active").siblings().removeClass('active');
					switch(type){
						case "selected":
							$('#selectedDox').show().siblings().hide();
							break;
						case "dept":
							$('#deptBox').show().siblings().hide();
                            if($('.tree-node-selected').length != 0){
                                $('.tree-node-selected').trigger('click');
                            }else{
                                var itemsArr = $('#selectedDox .userItem .active');
                                var selectItemsId = '';
                                for(var i=0;i<itemsArr.length;i++){
                                    if(i != (itemsArr.length - 1)){
                                        var obj = itemsArr.eq(i);
                                        selectItemsId+=(obj.attr("user_id")+',');
                                    }else{
                                        var obj = itemsArr.eq(i);
                                        selectItemsId+=obj.attr("user_id");
                                    }
                                };
                                user_id = selectItemsId;
                                queryBenbumen()
                            }
                            break;
						case "priv":
						    $('#priDox').show().siblings().hide();
							break;
						case "group":
						    $('#groupDox').show().siblings().hide();
							break;
                        case "custom":
                            $('#customDox').show().siblings().hide();
                            break;
						case "online":
						    $('#onlineName').show().siblings().hide();

						    break
						case "query":

							break;
					}
				});

				$('.right').on("click",".block-right-item",function(){
					var that = $(this);
					if(that.attr('class').indexOf('active') > 0){
						that.removeClass("active");
                        if( $('#selectedDox .userItem #'+that.attr('user_id')).length > 0){

                            $('#selectedDox .userItem #'+that.attr('user_id')).remove();
                        }
					}else{
						var divObj = $(that.prop("outerHTML"));
						divObj.addClass("active");
						that.addClass("active");
                        if( $('#selectedDox .userItem #'+that.attr('user_id')).length < 1){
                            $('#selectedDox .userItem').append(divObj);
                        }
                        if(urlType==0){
                            that.siblings('div').removeClass('active')
                            $('#selectedDox .userItem').empty()
                            $('#selectedDox .userItem').append(divObj);
                        }
					}
                    var num = $('#selectedDox .userItem .block-right-item').length;
                    $('.chooseBox').eq(1).html(num+'人').attr('data-num',num);
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
//				点击各角色
            $('#allPriv').on('click','.block-left-item',function () {
				userPr1=$(this).attr('userPriv');
                // if(paraValue == ""){
                //     var url = '/user/getUserByUserPrivBai?userPriv='+userPr1
                // }else{
                //     var url = '/user/getUserByUserPrivBaiOrg?userPriv='+userPr1+'&deptNo='+searchPara
                // }
				if(paraValue == ""){
					var url = '/user/getUserByUserPrivBai'
					var data = {
						userPriv:userPr1,
						jobId:$('.gwpost').val(),
						postId:$('.zwposition').val()
					}
				}else{
					var url = '/user/getUserByUserPrivBaiOrg?'
					var data={
						userPriv:userPr1,
						deptNo:searchPara
					}
				}
				allPriv(url,data)
            })
			function allPriv(url,data){
				$(this).addClass('privActive').siblings().removeClass('privActive');
				var that=$(this)
				$.ajax({
					type:'get',
					url:url,
					data:data,
					dataType:'json',
					success:function (res) {
						var data=res.object;
						if(res.flag){
							if(data.users.length > 0 || data.otherUsers.length > 0){ //判断是否有符合条件的用户
								$('.pleaseCheck').hide();
								$('#priv_item_2').show();
								$('.noUser').hide();
								$('#priv-right-header').html(that.text());
								if(data.users.length > 0){  //判断集合中是否有数据
									$('#priv_item_2').find('.userItem').html(dataList(data.users));
								}
								if(data.otherUsers.length > 0){ //判断是否存在辅助角色
									$('#priv_item_3').show();
									$('#priv_item_3').find('.userItem').html(dataList(data.otherUsers));
								}else{
									$('#priv_item_3').hide();
								}
							}else{
								$('.pleaseCheck').hide();
								$('#priv_item_2').hide();
								$('.noUser').show();
							}
						}
					}
				})
			}

//			公共点击各分组
			$('#allGroup').on('click','.block-left-item',function () {
				groupIds=$(this).attr('groupid');
				allGroup(groupIds,$('.gwpost').val(),$('.zwposition').val())
            })
			//公共分组的方法
			function allGroup(groupId,jobId,postId){
				$(this).addClass('privActive').siblings().removeClass('privActive');
				var that=$(this)
				$.ajax({
					type:'get',
					url:'/usergroup/getUsersByGroupId',
					dataType:'json',
					data:{
						groupId:groupId,
						jobId:jobId,
						postId:postId
					},
					success:function (res) {
						var datas=res.object;
						if(res.flag){
							if(datas.length > 0){
								$('#group_item_2').show();
								$('.pleaseChecks').hide();
								$('.noUsers').hide();
								$('#group-right-header').html(that.text());
								$('#group_item_2').find('.userItem').html(dataList(datas));
							}else{
								$('#group_item_2').hide();
								$('.pleaseChecks').hide();
								$('.noUsers').show();
							}
						}
					}
				})
			}

            //		个人点击各自定义分组
            $('#allcustom').on('click','.block-left-item',function () {
				groupId1=$(this).attr('groupid');
				allcustom(groupId1,$('.gwpost').val(),$('.zwposition').val())

            })
			//个人分组的方法
			function allcustom(groupId1,jobId,postId){
				$(this).addClass('privActive').siblings().removeClass('privActive');
				var that=$(this)
				$.ajax({
					type:'get',
					url:'/getUsersByGroupIdBai',
					dataType:'json',
					data:{
						groupId:groupId1,
						jobId:jobId,
						postId:postId
					},
					success:function (res) {
						var datas=res.object;
						if(JSON.stringify(res.obj) === '[]'){
							var app = '<div style="font-size: 22px">暂无数据</div>'
							$('.pleaseChecks').html(app)
						}else{
							if(res.flag){
								if(datas.length > 0){
									$('#custom_item_2').show();
									$('.pleaseChecks').hide();
									$('.noUsers').hide();
									$('#custom-right-header').html(that.text());
									$('#custom_item_2').find('.userItem').html(dataList(datas));
								}else{
									$('#custom_item_2').hide();
									$('.pleaseChecks').hide();
									$('.noUsers').show();
								}
							}
						}
					}
				})
			}

            function dataList(data) {
                var str='';
                var length = $('#selectedDox #dept_item .block-right-item').length;
                var choosearr = [];
                for(var i=0;i<length;i++){
                    var user_id = $('#selectedDox #dept_item .block-right-item').eq(i).attr('user_id');
                    choosearr.push(user_id);
				}
                for(var i=0;i<data.length;i++){
                    str+='<div class="block-right-item '+function () {
                            if(choosearr) {  //判断user_id是否存在
                                var user_idArr;
                                if(Array.isArray(choosearr)){
                                    user_idArr= choosearr;
                                }else {
                                    user_idArr= choosearr.split(',');
                                }
                                var bool = false;
                                for (var j = 0; j < user_idArr.length; j++) {
                                    if (data[i].userId == user_idArr[j]) {
                                        bool = true;
                                        break;
                                    }
                                }
                                if (bool) {
                                    return 'active';
                                }else {
                                    return ''
                                }
                            }else {
                                return ''
                            }
                        }()+'" item_id="'+data[i].uid+'" userPrivName="'+function(){if(data[i].userPrivName==undefined){return ''}else{return data[i].userPrivName}}()+'" item_name="'+data[i].userName+'" id="'+data[i].userId+'" user_id="'+data[i].userId+'" uid="'+data[i].uid+'" title="'+data[i].userName+'"><span class="name">'+'['+check(data[i].deptName)+']&nbsp;'+check(data[i].userName)+' '+function(){if(data[i].userPrivName==undefined){return ''}else{return data[i].userPrivName}}()+'<span class="status">'+function () {
                            if(onLine.toString().indexOf(data[i].userId) > -1){
                                return '<span style="color:#ff0000;margin-left: 10px;">在线</span>';
                            }else{
                                return '';
                            }
                        }()+' </span></span></div>';
                }
                return str;
            }

			//监听岗位select
			$(".gwpost").bind("change", function() {
				if($('#department').attr('class').indexOf('active')>-1){//部门
					if($('.tree-checkbox').attr('class').indexOf('sele')>-1){
						deleteAllUser($('#deptBox'))//清除部门全部选中的方法
						showUserAndDept(nodedept.substr(0,nodedept.length-1),nodedeptName,'',$('.gwpost').val(),$('.zwposition').val())
					}else{
						deleteAllUser($('#deptBox'))//清除部门全部选中的方法
						buildNewUserList(node1,nodeName,$('.gwpost').val(),$('.zwposition').val())
					}
				}else if($('#privBtn').attr('class').indexOf('active')>-1){      //角色
					if(paraValue == ""){
						var url = '/user/getUserByUserPrivBai'
						var data = {
							userPriv:userPr1,
							jobId:$('.gwpost').val(),
							postId:$('.zwposition').val()
						}
					}else{
						var url = '/user/getUserByUserPrivBaiOrg'
						var data = {
							userPriv:userPr1,
							deptNo:searchPara
						}
					}
					allPriv(url,data)
				}else if($('#groupBtn').attr('class').indexOf('active')>-1){    //公共分组
					allGroup(groupIds,$('.gwpost').val(),$('.zwposition').val())
				}else if($('#customGroup').attr('class').indexOf('active')>-1){     //个人分组

					allcustom(groupIds,$('.gwpost').val(),$('.zwposition').val())
				}else if($('#userOnline').attr('class').indexOf('active')>-1){   //在线
					onlineUser($('.gwpost').val(),$('.zwposition').val());
				}
			})

			//监听岗位职务
			$(".zwposition").bind("change", function() {
				if($('#department').attr('class').indexOf('active')>-1){//部门
					if($('.tree-checkbox').attr('class').indexOf('sele')>-1){
						deleteAllUser($('#deptBox'))//清除部门全部选中的方法
						showUserAndDept(nodedept.substr(0,nodedept.length-1),nodedeptName,'',$('.gwpost').val(),$('.zwposition').val())
					}else{
						deleteAllUser($('#deptBox'))//清除部门全部选中的方法
						buildNewUserList(node1,nodeName,$('.gwpost').val(),$('.zwposition').val())
					}
				}else if($('#privBtn').attr('class').indexOf('active')>-1){      //角色
					if(paraValue == ""){
						var url = '/user/getUserByUserPrivBai'
						var data = {
							userPriv:userPr1,
							jobId:$('.gwpost').val(),
							postId:$('.zwposition').val()
						}
					}else{
						var url = '/user/getUserByUserPrivBaiOrg'
						var data = {
							userPriv:userPr1,
							deptNo:searchPara
						}
					}
					allPriv(url,data)
				}else if($('#groupBtn').attr('class').indexOf('active')>-1){    //公共分组
					allGroup(groupIds,$('.gwpost').val(),$('.zwposition').val())
				}else if($('#customGroup').attr('class').indexOf('active')>-1){     //个人分组
					allcustom(groupIds,$('.gwpost').val(),$('.zwposition').val())
				}else if($('#userOnline').attr('class').indexOf('active')>-1){   //在线
					onlineUser($('.gwpost').val(),$('.zwposition').val());
				}
			})
		});

        //			点击全部添加方法
        function addAllUser(element) {
            element.find('.userItem .block-right-item').addClass('active');
            var str  = '';
            element.find('.userItem .active').each(function (i,v) {
                if( $('#selectedDox .userItem #'+$(this).attr('user_id')).length < 1){
                    str += $(this).prop("outerHTML");
                }
            });
            $('#selectedDox .userItem').append(str);
            var num = $('#selectedDox .userItem .block-right-item').length;
            $('.chooseBox').eq(1).html(num+'人').attr('data-num',num);
        }
//        点击全部删除方法
		function deleteAllUser(element) {
            element.find('.userItem .active').each(function (i,v) {
                if( $('#selectedDox .userItem #'+$(this).attr('user_id')).length > 0){
                    $('#selectedDox .userItem #'+$(this).attr('user_id')).remove();
                }
            });
            element.find('.userItem .block-right-item').removeClass('active');
            var num = $('#selectedDox .userItem .block-right-item').length;
            $('.chooseBox').eq(1).html(num+'人').attr('data-num',num);
        }

	</script>
</html>
