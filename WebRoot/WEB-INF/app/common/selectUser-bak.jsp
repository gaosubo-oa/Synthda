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
	<script type="text/javascript" src="/js/xoajq/xoajq1.js"></script>
	<script src="/js/base/base.js"></script>
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
</style>
<body>
	<!-- //开始 -->
		<!-- //头部 -->

		<div id="north">
   <div id="navMenu" style="width:auto;">
      <a href="#" title='<fmt:message code="common.th.selPerson" />' class="tab_btn"  block="selected" hidefocus="hidefocus"><span><fmt:message code="common.th.selected" /></span></a><%--已选人员 已选--%>
      <a href="#" title='<fmt:message code="common.th.selByDepart" />' block="dept" hidefocus="hidefocus" class=" tab_btn active"><span><fmt:message code="userManagement.th.department" /></span></a><%--按部门选择 部门--%>
      <%--<a href="#" title="按角色选择" class="tab_btn" block="priv" hidefocus="hidefocus"><span>角色</span></a>--%>
      <%--<a href="#" title="按分组选择" class="tab_btn" block="group" hidefocus="hidefocus"><span>分组</span></a>--%>
      <%--<a href="#" title="从在线人员选择" class="tab_btn" block="online" hidefocus="hidefocus"><span>在线</span></a>--%>
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
		<div class="main-block" id="deptBox" style="display:block;">
			   <div class="left moduleContainer" id="dept_menu">

				   <div class="tree">
					   <div class="pickCompany">
						<span  class="childdept" style="display: none;">
							<img src="/img/commonTheme/${sessionScope.InterfaceModel}/icon_company.png" alt="" style="vertical-align: middle;width: 15px;margin-right: 5px;margin-left: 5px;margin-bottom: 4px;">
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

						<div id="block-right-add" class="block-right-add"><fmt:message code="meet.th.addAll" /></div><%--全部添加--%>
						<div id="block-right-remove" class="block-right-remove"><fmt:message code="meet.th.DeleteAll" /></div><%--全部删除--%>
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
			   <div class="left moduleContainer" id="dept_menu">
				   <div class="tree">
					   	<ul class="dynatree-container dynatree-no-connector" id="deptOrg">
					   	</ul>
				   </div>

			   </div>
			   <div class="right" id="dept_item">
					<div class="block-right" id="dept_item_2">
						<!-- 部门名 -->

						<div class="block-right-remove"><fmt:message code="meet.th.DeleteAll" /></div><%--全部删除--%>

						<div class="userItem">

						</div>
					</div>
				</div>
		</div>
		<!-- 分组 -->
		<div class="main-block" id="groupDox" >
			   <div class="left moduleContainer" id="dept_menu">
				   <div class="tree">
					   	<ul class="dynatree-container dynatree-no-connector" id="deptOrg">
					   	</ul>
				   </div>

			   </div>
			   <div class="right" id="dept_item">
					<div class="block-right" id="dept_item_2">
						<!-- 部门名 -->

						<div class="block-right-remove"><fmt:message code="meet.th.DeleteAll" /></div><%--全部删除--%>

						<div class="userItem">

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
	<script type="text/javascript">
        var urlType=location.href.split('?')[1];
        var onLine=[];
        function throttle(method,text) {
            clearTimeout(method.tId);
            method.tId=setTimeout(function(){
                method.call(method,text);
            },500);
        }
        var initTree;
        var user_id='';
        var userPrivName='';
        var dataid = '';
        var selectItemsName ='';
        var parentObj='';
        if(parent.opener && parent.opener.user_id){
            user_id = parent.opener.document.getElementById(parent.opener.user_id).getAttribute('user_id');
            userPrivName = parent.opener.document.getElementById(parent.opener.user_id).getAttribute('userPrivName');
            dataid = parent.opener.document.getElementById(parent.opener.user_id).getAttribute('dataid');
            selectItemsName = parent.opener.document.getElementById(parent.opener.user_id).value;
		}else{
            user_id = parent.$("#"+parent.user_id).attr('user_id');
            userPrivName = parent.$("#"+parent.user_id).attr('userPrivName');
            dataid = parent.$("#"+parent.user_id).attr('dataid');
            selectItemsName = parent.$("#"+parent.user_id).val();
            parentObj = parent.$("#"+parent.user_id);
		}


        function autodivheights(text) {
            $.ajax({
                type: "get",
                url: "../user/getBySearch?search=" + text,
                dataType: 'JSON',
                success: function (res) {
                    if(res.flag){
                        var arr = [];
                        $('#block-right-header').show();
                        $('#block-right-add').show();
                        $('#block-right-remove').show();
                        res.obj.forEach(function(v,i){
                            if(v.userId) {  //如果userId存在
                                var divObj = {};
                                if(v.sex==0){   //如果为男性
                                    divObj = $('<div class="block-right-item '+function () {
                                            if(user_id) {  //如果user_id存在
                                                var user_idArr;
                                                if(Array.isArray(user_id)){
                                                    user_idArr= user_id;
                                                }else {
                                                    user_idArr= user_id.split(',');
                                                }

                                                var bool = false;
                                                for (var i = 0; i < user_idArr.length; i++) {
                                                    if (v.userId == user_idArr[i]) {  //判断如果userId和user_idArr中某一个值相等时，将bool赋值true
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
                                        }()+'" item_id="'+v.uid+'" item_name="'+v.userName+'" id="'+v.userId+'" user_id="'+v.userId+'" uid="'+v.uid+'" userPrivName="'+function(){if(v.userPrivName==undefined){return ''}else{return v.userPrivName}}()+'" title="'+v.userName+'"><span class="name">'+v.userName+' '+function(){
                                                if(v.userPrivName==undefined){
                                                    return ''
												}else{
                                                    return '('+v.userPrivName+')'
												}
									}()+'<span class="status"> '+function () {
                                            if(onLine.toString().indexOf(v.userId) > -1){
                                                return '<span style="color:#ff0000;">在线</span>';
                                            }else{
                                                return '';
                                            }
                                        }()+'</span></span></div>');
                                }else if(v.sex==1){  //如果为女性
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
                                        }()+'" item_id="'+v.uid+'" item_name="'+v.userName+'"  id="'+v.userId+'"  user_id="'+v.userId+'" uid="'+v.uid+'" userPrivName="'+function(){if(v.userPrivName==undefined){return ''}else{return v.userPrivName}}()+'" title="'+v.userName+'"><span class="name">'+v.userName+' '+function(){if(v.userPrivName==undefined){return ''}else{return '('+v.userPrivName+')'}}()+'<span class="status">'+function () {
                                            if(onLine.toString().indexOf(v.userId) > -1){
                                                return '<span style="color:#ff0000;">在线</span>';
                                            }else{
                                                return '';
                                            }
                                        }()+'</span></span></div>');
                                }
                                if( $('#selectedDox .userItem #'+v.userId).length > 0 ){
                                    divObj.addClass('active')
                                }
                                arr.push(divObj)
                            }
                        });
                        if(res.obj.length==0){
							$('#block-right-header').hide();
							$('#block-right-add').hide();
							$('#block-right-remove').hide();

                            arr.push($('<div style="width: 230px;height: 200px;margin: 20px auto;text-align: center">' +
								'<img src="/img/common/sousuokong.png" style="margin-top: 20px;" alt="">\
                            	<span style="width: 100%;display: inline-block;margin-top: 10px;\
                            font-size: 15px;\
                            font-weight: bold;">暂无搜索人员</span>' +
								'</div>'))
						}

                        $('#deptBox .userItem').html(arr);
                    }
                }
            });

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
            if(parent.opener && parent.opener.user_id){  //判断是否存在父级页面并且有该元素
                parent.opener.document.getElementById(parent.opener.user_id).value=selectItemsName;
                parent.opener.document.getElementById(parent.opener.user_id).setAttribute('username',selectItemsName);
                parent.opener.document.getElementById(parent.opener.user_id).setAttribute('dataid',selectUid);
                parent.opener.document.getElementById(parent.opener.user_id).setAttribute('user_id',selectItemsId);
                parent.opener.document.getElementById(parent.opener.user_id).setAttribute('userPrivName',userPrivName);
			}else{
                parentObj.val(selectItemsName);
                parentObj.attr('username',selectItemsName);
                parentObj.attr('dataid',selectUid);
                parentObj.attr('user_id',selectItemsId);
                parentObj.attr('userPrivName',userPrivName);
			}
            if(parent.opener){
                if(parent.opener.loadfile!=undefined){
                    parent.opener.loadfile(parent.opener.user_id)
                }
			}

			window.close();
            parent.layer.closeAll();
		}

        $(function(){

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
				if(user_id){  //如果user_id存在
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
				}else if(dataid){  //否则如果dataid存在
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
			};
            initTree = function(){  //加载树方法
                $('#deptOrg').tree({
                    url: '../department/getChDept',
                    animate:true,
                    loadFilter: function(node){
                        numIndex++;
                        return convert(node.obj);
                    },
                    onClick:function(node){
                        buildUserList(node.id,node.text);
                        $(this).tree(node.state === 'closed' ? 'expand' : 'collapse', node.target);
                        node.state = node.state === 'closed' ? 'open' : 'closed';
                    },
                    onDblClick:function (node) {

                    },
                    onLoadSuccess:function(node,data){

                    },
                    onBeforeExpand:function(node,param){
                        $('#deptOrg').tree('options').url = "../department/getChDept?deptId=" + node.id;// change the url
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
			    if(text!= ''){
                    throttle(autodivheights,text);
				}else{
                    $('#deptBox .userItem').html('');
				}
			});
			$('#selectedDox #block-right-remove').on('click',function () {
                $('#selectedDox .userItem .block-right-item').each(function() {
                    if( $('#deptBox .userItem #'+$(this).attr('user_id')).length > 0){
                        $('#deptBox .userItem #'+$(this).attr('user_id')).removeClass('active');
                    }
                });
                $('#selectedDox .userItem .block-right-item').remove();
            });

            $('#selectedDox .userItem ').on('click','.block-right-item',function () {
                $('#deptBox .userItem #'+$(this).attr('user_id')).removeClass('active');
                $(this).remove();
            });

			$('#deptBox #block-right-add').on('click',function () {
				$('#deptBox .userItem .block-right-item').addClass('active');
				var str  = '';
                $('#deptBox .userItem .active').each(function (i,v) {
                    if( $('#selectedDox .userItem #'+$(this).attr('user_id')).length < 1){
                        str += $(this).prop("outerHTML");
                    }
                });
                $('#selectedDox .userItem').append(str);
            });

            $('#deptBox #block-right-remove').on('click',function () {
                $('#deptBox .userItem .active').each(function (i,v) {
                    if( $('#selectedDox .userItem #'+$(this).attr('userId')).length > 0){
                        $('#selectedDox .userItem #'+$(this).attr('userId')).remove();
                    }
                });
                $('#deptBox .userItem .block-right-item').removeClass('active');
            });



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
						   if(v.userId){  //如果userId存在
                               $('#block-right-header').show();
                               $('#block-right-add').show();
                               $('#block-right-remove').show();
                               num++;
                               if(v.sex==0){ //判断性别
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
										   if(dataid != null){  //如果dataid不等于空
                                               for (var i = 0; i < uidArr.length; i++) {
                                                   if (v.uid == uidArr[i]) {
                                                       bool = true;
                                                       break;
                                                   }
                                               }
										   }else if(user_id){//如果user_id不等于空
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
                                       }()+'" item_id="'+v.uid+'" item_name="'+v.userName+'" id="'+v.userId+'" user_id="'+v.userId+'" uid="'+v.uid+'" userPrivName="'+function(){if(v.userPrivName==undefined){return ''}else{return v.userPrivName}}()+'" title="'+v.userName+'"><span class="name">'+v.userName+' '+function(){if(v.userPrivName==undefined){return ''}else{return '（'+v.userPrivName+'）'}}()+'<span class="status"> '+function () {
                                           if(onLine.toString().indexOf(v.userId) > -1){
                                               return '<span style="color:#ff0000;">在线</span>';
                                           }else{
                                               return '';
                                           }
                                       }()+'</span></span></div>');
                               }else if(v.sex==1){  //如果性别为女
                                   divObj = $('<div class="block-right-item '+function () {
                                       if(user_id || dataid) {

                                           var user_idArr;
                                           var uidArr;
                                           if(Array.isArray(user_id)){  //如果数组中包含user_id
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
                                       }()+'" item_id="'+v.uid+'" item_name="'+v.userName+'"  id="'+v.userId +'"  user_id="'+v.userId+'" uid="'+v.uid+'" userPrivName="'+function(){if(v.userPrivName==undefined){return ''}else{return v.userPrivName}}()+'" title="'+v.userName+'"><span class="name">'+v.userName+' '+function(){if(v.userPrivName==undefined){return ''}else{return '（'+v.userPrivName+'）'}}()+'<span class="status">'+function () {
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
                        if(num==0){  //判断如果数据的length为0
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
					if(v.deptId){  //如果deptId存在
                        var node = {};
					    if(numIndex == '1'){
                            node = new TreeNode(v.deptId,v.deptName,"closed")
						}else{
                            node = new TreeNode(v.deptId,v.deptName,"closed")
                        }
						arr.push(node);
					}else if(v.userId){ //如果userId存在
                        if(v.sex==0){ //如果为男性
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
                                }()+'" item_id="'+v.uid+'" userPrivName="'+function(){if(v.userPrivName==undefined){return ''}else{return v.userPrivName}}()+'" item_name="'+v.userName+'" id="'+v.userId+'" user_id="'+v.userId+'" uid="'+v.uid+'" title="'+v.userName+'"><span class="name">'+v.userName+' '+function(){if(v.userPrivName==undefined){return ''}else{return '（'+v.userPrivName+'）'}}()+'<span class="status">'+function () {
									if(onLine.toString().indexOf(v.userId) > -1){
									    return '<span style="color:#ff0000;">在线</span>';
									}else{
									    return '';
									}
                                }()+' </span></span></div>';
						}else if(v.sex==1){ //如果为女性
							tr+='<div class="block-right-item '+function () {
                                    if(user_id) {

                                        var user_idArr;
                                        if(Array.isArray(user_id)){ //如果数组中存在user_id
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
                                }()+'" item_id="'+v.uid+'" userPrivName="'+function(){if(v.userPrivName==undefined){return ''}else{return v.userPrivName}}()+'" item_name="'+v.userName+'"  id="'+v.uid+'"  user_id="'+v.userId+'" uid="'+v.userId+'" title="'+v.userName+'"><span class="name">'+v.userName+' '+function(){if(v.userPrivName==undefined){return ''}else{return '（'+v.userPrivName+'）'}}()+'<span class="status">'+function () {
                                    if(onLine.toString().indexOf(v.userId) > -1){
                                        return '<span style="color:#ff0000;">在线</span>';
                                    }else{
                                        return '';
                                    }
                                }()+'</span></span></div>';
						}
					}
				});
//				$('#deptBox .userItem').html(tr);
				return arr;
			}
            //选人控件默认显示本部门人员
            function queryBenbumen() {
			    $("#block-right-header").show();
			    $("#block-right-add").show();
			    $("#block-right-remove").show();
                $.ajax({
                    type:'get',
                    url:'/user/selNowUsers',
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
                                    }()+'" item_id="'+dataU[i].uid+'" userPrivName="'+function(){if(dataU[i].userPrivName==undefined){return ''}else{return dataU[i].userPrivName}}()+'" item_name="'+dataU[i].userName+'" id="'+dataU[i].userId+'" user_id="'+dataU[i].userId+'" uid="'+dataU[i].uid+'" title="'+dataU[i].userName+'"><span class="name">'+dataU[i].userName+' '+function(){if(dataU[i].userPrivName==undefined){return ''}else{return '（'+dataU[i].userPrivName+'）'}}()+'<span class="status">'+function () {
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

							break;
						case "group":

							break;
						case "query":

							break;
					}
				});

				$('#dept_item').on("click",".block-right-item",function(){
					var that = $(this);
					if(that.attr('class').indexOf('active') > 0){  //判断该元素class中存在active
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
		});
	</script>
</html>
 