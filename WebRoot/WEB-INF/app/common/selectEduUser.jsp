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
    <meta http-equiv="Content-Type" content="text/html; charset=gbk" />
    <meta name="renderer" content="webkit">
    <meta http-equiv="X-UA-Compatible" content="IE=10,chrome=1" />
	<meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=0, minimum-scale=1.0, maximum-scale=1.0">
    <link rel="stylesheet" type="text/css" href="../css/common/style.css" />
	<link rel="stylesheet" type="text/css" href="../css/common/select.css" />
<!-- 	<link rel="stylesheet" type="text/css" href="../css/common/ui.dynatree.css"> -->
	<link rel="stylesheet" type="text/css" href="../css/common/org_select.css">
	<link rel="stylesheet" type="text/css" href="../lib/easyui/themes/easyui.css"/>
    <link rel="stylesheet" type="text/css" href="../lib/easyui/themes/icon.css"/>
	 <script src="/js/xoajq/xoajq1.js" type="text/javascript" charset="utf-8"></script>
	<%--<script type="text/javascript" src="/js/xoajq/xoajq1.js"></script>--%>
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
					   	<ul class="dynatree-container dynatree-no-connector" id="deptOrg">
					   	</ul>
				   </div>

			   </div>
			   <div class="right" id="dept_item">
					<div class="block-right" id="dept_item_2">
						<!-- 部门名 -->
						<div class="block-right-header" title=""></div>

						<div id="block-right-add" class="block-right-add"><fmt:message code="meet.th.addAll" /></div><%--全部添加--%>
						<div id="block-right-remove" class="block-right-remove"><fmt:message code="meet.th.DeleteAll" /></div><%--全部删除--%>
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
	<script>
				function close_window(){
					var itemsArr = $('#selectedDox .userItem .block-right-item');
//					console.log(itemsArr.length);
                    var itemnum=location.href.split('?')[1]
                    if(itemnum==0){
                        if(itemsArr.length>1){
                            alert('<fmt:message code="common.th.onlyChooseOne" />')/*只能选择一个*/
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
					//alert(selectItemsId);
					parent.opener.document.getElementById(parent.opener.user_id).value=selectItemsName;
					parent.opener.document.getElementById(parent.opener.user_id).setAttribute('dataid',selectUid);
					parent.opener.document.getElementById(parent.opener.user_id).setAttribute('user_id',selectItemsId);
					parent.opener.document.getElementById(parent.opener.user_id).setAttribute('userPrivName',userPrivName);
					if(parent.opener.loadfile!=undefined){
                       parent.opener.loadfile()
					}
					window.close();
				}
		$(function(){
            var numIndex = 0;
		  /*  var user_id = parent.opener.document.getElementById(parent.opener.user_id).getAttribute('user_id');
		    var userPrivName = parent.opener.document.getElementById(parent.opener.user_id).getAttribute('userPrivName');
            var dataid = parent.opener.document.getElementById(parent.opener.user_id).getAttribute('dataid');
            var selectItemsName = parent.opener.document.getElementById(parent.opener.user_id).value;
			buildDefaultItem();
			var numIndex = 0;
            function buildDefaultItem(){
				var arr = ''
				if(user_id && dataid && selectItemsName && userPrivName){
                    user_id = user_id.split(',');
                    dataid =dataid.split(',');
                    userPrivName =userPrivName.split(',');
                    selectItemsName = selectItemsName.split(',');
                    for(var i=0;i<user_id.length;i++){
                        if(user_id[i]) {
                            arr += '<div class="block-right-item active" item_id="' + dataid[i] + '" item_name="' + selectItemsName[i] + '"  id="' + dataid[i] + '"  user_id="' + user_id[i] + '" uid="' + dataid[i] + '" title="' + selectItemsName[i] + '"><span class="name">' + selectItemsName[i] + ' ' + userPrivName[i] + '<span class="status"></span></span></div>';
                        }
					}
                    $('#selectedDox .userItem').append(arr);
				}
			};*/
			$('#deptOrg').tree({
				url: '../eduDepartment/queryListByDeptId?deptId=0',
				animate:true,
				loadFilter: function(node){
                   numIndex++;
					return convert(node.obj);
				},
				onClick:function(node){
		           buildUserList(node.id);
                    $(this).tree(node.state === 'closed' ? 'expand' : 'collapse', node.target);
                    node.state = node.state === 'closed' ? 'open' : 'closed';
		        },
             /*   onDblClick:function (node) {

                },
                onLoadSuccess:function(node,data){

				},*/
				onBeforeExpand:function(node,param){
		        	  $('#deptOrg').tree('options').url = "../eduDepartment/queryListByDeptId?deptId=" + node.id;// change the url
		        }

			});
			//搜索
			$('#keyword').bind('input propertychange', function() {
			    var text = $(this).val();
//			    console.log(text);
			    if(text!= ''){
                    $.ajax({
                        type: "get",
                        url: "../user/getBySearch?search=" + text,
                        dataType: 'JSON',
                        success: function (res) {
                            if(res.flag){
                                var arr = [];
                                res.obj.forEach(function(v,i){
                                    if(v.userId) {
                                        var divObj = {};
                                        if(v.sex==0){
                                            divObj = $('<div class="block-right-item" item_id="'+v.uid+'" item_name="'+v.userName+'" id="'+v.uid+'" user_id="'+v.userId+'" uid="'+v.uid+'" userPrivName="'+v.userPrivName+'" title="'+v.userName+'"><span class="name">'+v.userName+' '+v.userPrivName+'<span class="status"> </span></span></div>');
                                        }else if(v.sex==1){
                                            divObj = $('<div class="block-right-item" item_id="'+v.uid+'" item_name="'+v.userName+'"  id="'+v.uid+'"  user_id="'+v.userId+'" uid="'+v.uid+'" userPrivName="'+v.userPrivName+'" title="'+v.userName+'"><span class="name">'+v.userName+' '+v.userPrivName+'<span class="status"></span></span></div>');
                                        }
                                        if( $('#selectedDox .userItem #'+v.uid).length > 0 ){
                                            divObj.addClass('active')
                                        }

                                        arr.push(divObj)
                                    }
                                });

                                $('#deptBox .userItem').html(arr);
                            }
                        }
                    });
				}else{
                    $('#deptBox .userItem').html('');
				}
			});
			$('#selectedDox #block-right-remove').on('click',function () {
                $('#selectedDox .userItem .block-right-item').each(function() {
                    if( $('#deptBox .userItem #'+$(this).attr('uid')).length > 0){
                        $('#deptBox .userItem #'+$(this).attr('uid')).removeClass('active');
                    }
                });
                $('#selectedDox .userItem .block-right-item').remove();
            });

            $('#selectedDox .userItem ').on('click','.block-right-item',function () {
                $('#deptBox .userItem #'+$(this).attr('uid')).removeClass('active');
                $(this).remove();
            });

			$('#deptBox #block-right-add').on('click',function () {
				$('#deptBox .userItem .block-right-item').addClass('active');
				var str  = '';
                $('#deptBox .userItem .active').each(function (i,v) {
                    if( $('#selectedDox .userItem #'+$(this).attr('uid')).length < 1){
                        str += $(this).prop("outerHTML");
                    }
                });
                $('#selectedDox .userItem').append(str);
            });

            $('#deptBox #block-right-remove').on('click',function () {
                $('#deptBox .userItem .active').each(function (i,v) {
                    if( $('#selectedDox .userItem #'+$(this).attr('uid')).length > 0){
//                        console.log($(this).attr('uid'));
                        $('#selectedDox .userItem #'+$(this).attr('uid')).remove();
                    }
                });
                $('#deptBox .userItem .block-right-item').removeClass('active');
            });

            function buildUserList(id){
                $.ajax({
                    type: "get",
                    url: "../edu/student/getUserByDeptId?deptId=" + id,
                    dataType: 'JSON',
                    success: function (res) {
                        var tr = [];
                       res.obj.forEach(function (v,i) {
							var divObj ;
						   if(v.userId){
                               if(v.sex==0){
                                   divObj = $('<div class="block-right-item" item_id="'+v.uid+'" item_name="'+v.userName+'" id="'+v.uid+'" user_id="'+v.userId+'" uid="'+v.uid+'" userPrivName="'+v.userPrivName+'" title="'+v.userName+'"><span class="name">'+v.userName+'<span class="status"> </span></span></div>');
                               }else if(v.sex==1){
                                   divObj = $('<div class="block-right-item" item_id="'+v.uid+'" item_name="'+v.userName+'"  id="'+v.uid+'"  user_id="'+v.userId+'" uid="'+v.uid+'" userPrivName="'+v.userPrivName+'" title="'+v.userName+'"><span class="name">'+v.userName+'<span class="status"></span></span></div>');
                               }
                               if( $('#selectedDox .userItem #'+v.uid).length > 0 ){
                                   divObj.addClass('active')
							   }
                           }
                           tr.push(divObj);
                       });
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
							tr+='<div class="block-right-item" item_id="'+v.uid+'" userPrivName="'+v.userPrivName+'" item_name="'+v.userName+'" id="'+v.uid+'" user_id="'+v.userId+'" uid="'+v.uid+'" title="'+v.userName+'"><span class="name">'+v.userName+' '+v.userPrivName+'<span class="status"> </span></span></div>';
						}else if(v.sex==1){
							tr+='<div class="block-right-item" item_id="'+v.uid+'" userPrivName="'+v.userPrivName+'" item_name="'+v.userName+'"  id="'+v.uid+'"  user_id="'+v.userId+'" uid="'+v.uid+'" title="'+v.userName+'"><span class="name">'+v.userName+' '+v.userPrivName+'<span class="status"></span></span></div>';
						}
					}
				});
				$('#deptBox .userItem').html(tr);
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

							break;
						case "group":

							break;
						case "query":

							break;
					}
				});

				$('#dept_item').on("click",".block-right-item",function(){
					var that = $(this);
					if(that.attr('class').indexOf('active') > 0){
						that.removeClass("active");
                        if( $('#selectedDox .userItem #'+that.attr('uid')).length > 0){

                            $('#selectedDox .userItem #'+that.attr('uid')).remove();
                        }
					}else{
						var divObj = $(that.prop("outerHTML"));
						divObj.addClass("active");
						that.addClass("active");
                        if( $('#selectedDox .userItem #'+that.attr('uid')).length < 1){
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
 