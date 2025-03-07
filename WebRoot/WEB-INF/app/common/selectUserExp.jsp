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
	<meta name="renderer" content="webkit">
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
</style>
<body>
<!-- //开始 -->
<!-- //头部 -->

<div id="north">
	<div id="navMenu" style="width:auto;">
		<a href="#" title='<fmt:message code="common.th.selPerson" />' class="tab_btn"  block="selected" hidefocus="hidefocus"><span><fmt:message code="common.th.selected" /></span></a><%--已选人员 已选--%>
		<a href="#" title='<fmt:message code="common.th.selByDepart" />' block="dept" hidefocus="hidefocus" class=" tab_btn active"><span><fmt:message code="userManagement.th.department" /></span></a><%--按部门选择 部门--%>
		<%--<a href="#" title="按角色选择" id="privBtn" class="tab_btn" block="priv" hidefocus="hidefocus"><span>角色</span></a>--%>
		<%--<a href="#" title="按分组选择" id="groupBtn" class="tab_btn" block="group" hidefocus="hidefocus"><span>公共分组</span></a>--%>
		<%--<a href="#" title="按自定义组选择" id="customGroup" class="tab_btn" block="custom" hidefocus="hidefocus"><span>个人分组</span></a>--%>
		<%--<a href="#" title="从在线人员选择" id="userOnline" class="tab_btn" block="online" hidefocus="hidefocus"><span>在线</span></a>--%>
		<%--<a href="#" block="query" class="tab_btn" hidefocus="hidefocus" style="display:none;"><span><fmt:message code="workflow.th.sousuo" /></span></a>&lt;%&ndash;搜索&ndash;%&gt;--%>
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
							<input type="checkbox" id="checkedUserAll" value="" style="width: 15px;height: 15px;"disabled="true">
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
    var classDept ;
    if(parent.classDept ){
        classDept = parent.opener.classDept;
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
    var urlType=location.href.split('?');
    var fn;
    if(urlType[1]!=undefined&&urlType[1].toString().indexOf("&")!=-1){
        var n=urlType[1].split("&");
        if(n.length>1){
            if(n[1]!=undefined&&n[1].length>0){
                fn=n[1]
            }
            urlType=n[0]
        }
    } else{
        urlType=urlType[1];
    }
	//lr
    var hrefStr =$.GetRequest();
    var defaultUser=null;
    if(hrefStr!=undefined){
        defaultUser=hrefStr.defaultUser;
	}
	var defultIndex=0;
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
        if(parent.opener.selectUserName!=undefined&&parent.opener.selectUserName.length>0){
            var huixiandata=parent.opener.trdata;
            var huixianuserId=parent.opener.selectUserId;
            try {
                eval("user_id=huixiandata."+huixianuserId)
            } catch (e) {
                user_id=null;
            }
        }else{
            user_id = parent.$("#"+parent.user_id).attr('user_id');
            userPrivName = parent.$("#"+parent.user_id).attr('userPrivName');
            dataid = parent.$("#"+parent.user_id).attr('dataid');
            selectItemsName = parent.$("#"+parent.user_id).val();
            parentObj = parent.$("#"+parent.user_id);
        }
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
                                if(v.sex==0){
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
                                }else if(v.sex==1){
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
                        $('#searchName .userItem').html(arr);
                    }else{
                        $('#search_onlineUser').hide();
                        $('#searchName').find('.noUsers').show()
                    }


//                        if(res.obj.length==0){
//							$('#block-right-header').hide();
//							$('#block-right-add').hide();
//							$('#block-right-remove').hide();
//
//                            arr.push($('<div style="width: 230px;height: 200px;margin: 20px auto;text-align: center">' +
//								'<img src="/img/common/sousuokong.png" style="margin-top: 20px;" alt="">\
//                            	<span style="width: 100%;display: inline-block;margin-top: 10px;\
//                            font-size: 15px;\
//                            font-weight: bold;">暂无搜索人员</span>' +
//								'</div>'))
//						}


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
            if(itemsArr.length!=1){
                layer.msg('请选择一位人员', {icon: 5});
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
            if(itemsArr.length==1){
                selectItemsId+=(obj.attr("user_id"));
                selectItemsName+=(obj.attr("item_name"));
                selectUid+=(obj.attr("uid"));
                userPrivName+=(obj.attr("userPrivName"));
                break;
            }
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
            if(parent.opener && parent.opener.user_id){
                parent.opener.document.getElementById(parent.opener.user_id).value=selectItemsName;
                parent.opener.document.getElementById(parent.opener.user_id).setAttribute('username',selectItemsName);
                parent.opener.document.getElementById(parent.opener.user_id).setAttribute('dataid',selectUid);
                parent.opener.document.getElementById(parent.opener.user_id).setAttribute('user_id',selectItemsId);
                parent.opener.document.getElementById(parent.opener.user_id).setAttribute('userPrivName',userPrivName);
            }else{
                if(parent.opener.selectUserName!=undefined&&parent.opener.selectUserName.length>0){
                    try {
                        var data=parent.opener.trdata;
                        var userName=parent.opener.selectUserName;
                        var userId=parent.opener.selectUserId;
                        data[userName]=selectItemsName;
                        data[userId]=selectItemsId;
                        var obj=parent.opener.trobj
                        obj.update(data);
                    } catch (e) {
                    }
                }else {
                    parentObj.val(selectItemsName);
                    parentObj.attr('username',selectItemsName);
                    parentObj.attr('dataid',selectUid);
                    parentObj.attr('user_id',selectItemsId);
                    parentObj.attr('userPrivName',userPrivName);
                }

            }
            if(parent.opener){
                var deptName=$("#block-right-header").text();
                var param={
                    userIds:selectItemsId,
                    userName:selectItemsName,
                    deptExp:deptName
                 }
                if(parent.opener.loadfile!=undefined){
					parent.opener.loadfile(param)
                }
                //客户管理——新增页面
                if (parent.opener.loads != undefined) {
                    parent.opener.loads(param)
                }
                //客户管理——添加内部联系人
                if (parent.opener.addIncon != undefined && parent.opener.result == 'addIncontact') {
                    var deptName = $("#block-right-header").text();
                    var param = {
                        userId: selectItemsId,
                        deptExp: deptName,
                        result: "2"
                    }
                    parent.opener.addIncon(param)
                }
                //客户管理——分客户经理
                if (parent.opener.fpIncontact != undefined && parent.opener.result == 'gkzj') {
                    var deptName = $("#block-right-header").text();
                    var param = {
                        userId: selectItemsId,
                        deptExp: deptName,
                        result: "3"
                    }
                    parent.opener.fpIncontact(param)
                }
                //客户管理——内部联系人转交
                if (parent.opener.loadfileformal != undefined && parent.opener.result == 'zjIncon') {
                    var deptName = $("#block-right-header").text();
                    var param = {
                        userId: selectItemsId,
                        deptExp: deptName,
                        result: "4"
                    }
                    parent.opener.loadfileformal(param)
                }
                //输入评审提交
				if(parent.opener.commitProj != undefined ){
                    var param = {
                        userId: selectItemsId,
                    }
                    parent.opener.commitProj(param);
				}
				//设备借用-借用部门
                if (parent.opener.Xrborrow != undefined) {
                    var param = {
                        userId: selectItemsId,
                        userName:selectItemsName,
                    }
                    parent.opener.Xrborrow(param)
                }
                //设备转移-原部门
                if (parent.opener.Xrtransfer != undefined) {
                    var param = {
                        userId: selectItemsId,
                        userName:selectItemsName,
                    }
                    parent.opener.Xrtransfer(param)
                }
                //设备转移-批准行内选人
                if (parent.opener.Xrhntransfer != undefined) {
                    parent.opener.Xrhntransfer(param)
                }

                //设备借还——设备归还选人
				if(parent.opener.returnlendlist != undefined){
                    parent.opener.returnlendlist(param)
				}
				//输入评审选择客户经理
				if(parent.opener.AccountManager != undefined){
                    parent.opener.AccountManager(param)
				}
                //物料管理 选择领用人
                if(parent.opener.getUser != undefined){
                    parent.opener.getUser(param);
                }
            }
            window.close();
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
        $('#checkedUserAll').click(function () {
            var state=$(this).prop('checked');
            var deptName=$('#companyName').text()
            showUserAndDept(0,deptName,function () {
                if(state == true){
                    $('#deptBox').find('.block-right-item').addClass('active');
                    var str  = '';
                    $('#deptBox .userItem .active').each(function (i,v) {
                        if($(v).attr('user_id') !='' || $(v).attr('user_id') != undefined){ //判断user_id是否为空
                            if( $('#selectedDox .userItem #'+$(v).attr('user_id')).length < 1){
                                str += $(this).prop("outerHTML");
                            }
                        }
                    });
                    $('#selectedDox .userItem').append(str);
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
            })
        })


// //			点击在线
//         $('#userOnline').click(function () {
//             onlineUser();
//         })
//
//         $.ajax({
//             type:'get',
//             url:'/user/getOnlineMap',
//             dataType:'json',
//             async:false,
//             success:function (res) {
//                 var data=res.object;
//                 if(res.flag){
//                     for(var key in data){
//                         var arrKey=[];
//                         arrKey.push(key);
//                         onLine.push(arrKey)
//                     }
//                 }
//             }
//         })

        buildDefaultItem();
        //queryBenbumen();
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
            var url="/equipment/getDeptExp";
            if(classDept){
                url = '/hierarchical/getClassifyOrgByAdmin';
            }else{
                if(paraValue == ""){
                    url = "/equipment/getDeptExp";
                }else{
                    url = '../getUserOrg '
                }
                // url = "../department/getChDept";
            }
           if(parent.opener.borrow=="borrow"){
                url="/EquipBorrow/getoneDepx?deptId="+parent.opener.deptId
			}
            if(parent.opener.role=="CustomerManager"){  //wss0
               url="/project_input/DeptManager?deptId="+parent.opener.deptId;
            }
            $('#deptOrg').tree({
                url:url,
                animate:true,
                checkbox:true,
                cascadeCheck:true,
                loadFilter: function(node){
					var first=node.obj[0].deptId;
                    //lr 新增。如果defaultUser有值，展现默认的人员就可以了
					debugger
					if(defultIndex==0){
                        if(defaultUser!=undefined&&defaultUser!=null){
                            //先根据这个userId查询人员信息
                            $.get("/user/findUserByuserId",{userId:defaultUser},function (res) {
                                if(res!=undefined&&res.flag){
                                    var obj=res.object;
                                    var str="<div class=\"block-right-item hover\" item_id=\""+obj.uid+"\" userprivname=\""+obj.userPrivName+"\" item_name=\""+obj.userName+"\" id=\""+obj.userId+"\" user_id=\""+obj.userId+"\" uid=\""+obj.uid+"\" title=\""+obj.userName+"\"><span class=\"name\">"+obj.userName+"<span class=\"status\"> </span></span></div>";
                                    $('.curDept').html(str);
                                    $("div[item_id='"+obj.uid+""+"'").click();
                                }
                            });
                        }else{
                            queryBenbumen(first)
                        }
                        defultIndex++;
					}else{
                        queryBenbumen(first)
					}

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
                    debugger
//                        buildUserList(node.id,node.text);
                    buildNewUserList(node.id,node.text);
                    $(this).tree(node.state === 'closed' ? 'expand' : 'collapse', node.target);
                    node.state = node.state === 'closed' ? 'open' : 'closed';
                },
                onDblClick:function (node) {

                },
                onLoadSuccess:function(node,data){

                },
                onBeforeExpand:function(node,param){
                    $('#deptOrg').tree('options').url = "../department/getChDept?deptId=" + node.id;// change the url
                },
                onCheck:function (node,checked) {
                    showUserAndDept(node.id,node.text,function () {
                        if(checked){
                            $('#deptBox').find('.block-right-item').addClass('active');
                            var str  = '';
                            $('#deptBox .userItem .active').each(function (i,v) {
                                if($(v).attr('user_id') !='' || $(v).attr('user_id') != undefined){ //判断user_id是否为空
                                    if( $('#selectedDox .userItem #'+$(v).attr('user_id')).length < 1){
                                        str += $(this).prop("outerHTML");
                                    }
                                }
                            });
                            $('#selectedDox .userItem').append(str);
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
                    });
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

//			$('#deptBox #block-right-add').on('click',function () {
//				$('#deptBox .userItem .block-right-item').addClass('active');
//				var str  = '';
//                $('#deptBox .userItem .active').each(function (i,v) {
//                    if( $('#selectedDox .userItem #'+$(this).attr('user_id')).length < 1){
//                        str += $(this).prop("outerHTML");
//                    }
//                });
//                $('#selectedDox .userItem').append(str);
//            });

//            $('#deptBox #block-right-remove').on('click',function () {
//                $('#deptBox .userItem .active').each(function (i,v) {
//                    if( $('#selectedDox .userItem #'+$(this).attr('user_id')).length > 0){
//                        $('#selectedDox .userItem #'+$(this).attr('user_id')).remove();
//                    }
//                });
//                $('#deptBox .userItem .block-right-item').removeClass('active');
//            });



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
                                }()+'" item_id="'+v.uid+'" item_name="'+v.userName+'" id="'+v.userId+'" user_id="'+v.userId+'" uid="'+v.uid+'" userPrivName="'+function(){if(v.userPrivName==undefined){return ''}else{return v.userPrivName}}()+'" title="'+v.userName+'"><span class="name">'+v.userName+' '+function(){if(v.userPrivName==undefined){return ''}else{return '（'+v.userPrivName+'）'}}()+'<span class="status"> '+function () {
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
        function buildNewUserList(id,text) {
            $('#block-right-header').text(text)
			//wss
			var url="";
            if(parent.opener.role=="CustomerManager"){
                url="/project_input/RolePersonnel?deptId="+id+"&role=CustomerManager";
            }else{
                url='/equipment/getNewChDept?deptId='+id;
            }
            $.ajax({
                type:'get',
                url:url,
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
                            }()+'" item_id="'+v.uid+'" item_name="'+v.userName+'" id="'+v.userId+'" user_id="'+v.userId+'" uid="'+v.uid+'" userPrivName="'+function(){if(v.userPrivName==undefined){return ''}else{return v.userPrivName}}()+'" title="'+v.userName+'"><span class="name">'+v.userName+' '+function(){if(v.userPrivName==undefined){return ''}else{return '（'+v.userPrivName+'）'}}()+'<span class="status"> '+function () {
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
        function showUserAndDept(id,text,fn) {
            $('#block-right-header').text(text);
            $.ajax({
                type:'get',
                url:'/department/getNewChAllDept?deptId='+id,
                dataType:'json',
                success:function (res) {
                    var data=res.object;
                    var str='';
                    var objStr='';
                    if(res.flag){
                        if(data.users.length > 0){
                            for(var i=0;i<data.users.length;i++){
                                objStr+='<div class="block-right-item '+function () {
                                    if(user_id) {  //判断user_id是否存在
                                        var user_idArr;
                                        if(Array.isArray(user_id)){
                                            user_idArr= user_id;
                                        }else {
                                            user_idArr= user_id.split(',');
                                        }
                                        var bool = false;
                                        for (var j = 0; j < user_idArr.length; j++) {
                                            if (data.users[i].userId == user_idArr[j]) {
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
                                }()+'" item_id="'+data.users[i].uid+'" userPrivName="'+function(){if(data.users[i].userPrivName==undefined){return ''}else{return data.users[i].userPrivName}}()+'" item_name="'+data.users[i].userName+'" id="'+data.users[i].userId+'" user_id="'+data.users[i].userId+'" uid="'+data.users[i].uid+'" title="'+data.users[i].userName+'"><span class="name">'+data.users[i].userName+''+function(){if(data.users[i].userPrivName==undefined){return ''}else{return '（'+data.users[i].userPrivName+'）'}}()+'<span class="status">'+function () {
                                    if(onLine.toString().indexOf(data.users[i].userId) > -1){
                                        return '<span style="color:#ff0000;margin-left: 10px;">在线</span>';
                                    }else{
                                        return '';
                                    }
                                }()+' </span></span></div>';
                            }
                        }
                        if(data.child != undefined){
                            str=deptLiData(data.child,0);
                        }
                        $('#deptBox').find('.userItem').html(objStr+str)

                        if(fn){
                            fn();
                        }
                    }
                }
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
                                                if (data[i].users[n].uid == uidArr[i]) {
                                                    bool = true;
                                                    break;
                                                }
                                            }
                                        }else if(user_id){
                                            for (var i = 0; i < user_idArr.length; i++) {
                                                if (data[i].users[n].userId == user_idArr[i]) {
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
                                }()+'" item_id="'+data[i].users[n].uid+'" item_name="'+data[i].users[n].userName+'" id="'+data[i].users[n].userId+'" user_id="'+data[i].users[n].userId+'" uid="'+data[i].users[n].uid+'" userPrivName="'+function(){if(data[i].users[n].userPrivName==undefined){return ''}else{return data[i].users[n].userPrivName}}()+'" title="'+data[i].users[n].userName+'"><span class="name">'+data[i].users[n].userName+' '+function(){if(data[i].users[n].userPrivName==undefined){return ''}else{return '（'+data[i].users[n].userPrivName+'）'}}()+'<span class="status"> '+function () {
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
                        }()+'" item_id="'+v.uid+'" userPrivName="'+function(){if(v.userPrivName==undefined){return ''}else{return v.userPrivName}}()+'" item_name="'+v.userName+'" id="'+v.userId+'" user_id="'+v.userId+'" uid="'+v.uid+'" title="'+v.userName+'"><span class="name">'+v.userName+' '+function(){if(v.userPrivName==undefined){return ''}else{return '（'+v.userPrivName+'）'}}()+'<span class="status">'+function () {
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
        //选人控件默认显示本部门及子部门人员
        function queryBenbumen(first) {
            $("#block-right-header").show();
            $("#block-right-add").show();
            $("#block-right-remove").show();
            var url="";
            debugger
            if(parent.opener.role=="CustomerManager"){  //wss
                url="/project_input/RolePersonnel?deptId="+first+"&role=AccountManager";
            }else{
                url='/equipment/getNewChDept?deptId='+first;
			}
            $.ajax({
                type:'get',
                url:url,
                dataType:'json',
                success:function (res) {
                    if(res.flag){
                        var dataU=res.obj;
                        var strU='';
                        $("#block-right-header").text(dataU[0].deptName);
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
                }()+'" item_id="'+data[i].uid+'" userPrivName="'+function(){if(data[i].userPrivName==undefined){return ''}else{return data[i].userPrivName}}()+'" item_name="'+data[i].userName+'" id="'+data[i].userId+'" user_id="'+data[i].userId+'" uid="'+data[i].uid+'" title="'+data[i].userName+'"><span class="name">'+data[i].userName+'<span class="status">'+function () {
                    if(onLine.toString().indexOf(data[i].userId) > -1){
                        return '<span style="color:#ff0000;margin-left: 10px;">在线</span>';
                    }else{
                        return '';
                    }
                }()+' </span></span></div>';
            }
            return str;
        }
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
 