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
	<title><fmt:message code="common.th.SelRole" /></title><%--选择角色--%>
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
	<script type="text/javascript" src="../js/jquery-1.9.1.js"></script>
	 <script type="text/javascript" src="../js/spirit/qwebchannel.js"></script>     <script type="text/javascript" src="/js/spirit/qwebchannel.js"></script>    <script src="/js/base/base.js"></script>
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
		<div class="left moduleContainer" id="dept_menu">

			<div class="tree">
				<ul class="dynatree-container dynatree-no-connector" id="priOrg">
				</ul>
			</div>

		</div>
		<div class="right" id="pri_item">
			<div class="block-right" id="dept_item_2">
				<!-- 角色名 -->
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
    function close_window(){
        var itemsArr = $('#pri_item .priItem .active');
        var itemnum=location.href.split('?')[1]
        if(itemnum==0){
            if(itemsArr.length>1){
                alert('<fmt:message code="common.th.onlyChooseOne" />')/*只能选择一个*/
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
        //alert(selectItemsId);
        parent.opener.document.getElementById(parent.opener.priv_id).value=selectItemsName;
        parent.opener.document.getElementById(parent.opener.priv_id).setAttribute('privId',selectItemsId);
        parent.opener.document.getElementById(parent.opener.priv_id).setAttribute('userPriv',userPriv);
        window.close();
    }
    $(function(){

        $('#priOrg').tree({
            url: '../eduDepartment/queryListByDeptId?deptId=0',
            animate:true,
            loadFilter: function(node){
                return convert(node.obj);

            },
            onDblClick:function (node) {

            },
            onClick:function(node){
                //buildPrivList(node.id);
                $(this).tree(node.state === 'closed' ? 'expand' : 'collapse', node.target);
                node.state = node.state === 'closed' ? 'open' : 'closed';
            },
            onBeforeExpand:function(node,param){
                $('#priOrg').tree('options').url = "../department/getChDept?deptId=" + node.id;// change the url
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

        });
        $('#selectedDox .priItem ').on('click','.block-right-item',function () {
            $('#priDox .priItem #'+$(this).attr('privid')).removeClass('active');
            $(this).remove();
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
        });
        $('#priDox #block-right-remove').on('click',function () {

            $('#priDox .priItem .active').each(function (i,v) {
                console.log($(this).attr('uid'));
                if( $('#selectedDox .priItem #'+$(this).attr('privid')).length > 0){
                    console.log($(this).attr('privid'));
                    $('#selectedDox .priItem #'+$(this).attr('privid')).remove();
                }
            });
            $('#priDox .priItem .block-right-item').removeClass('active');
        })
        function TreeNode(id,text,state,children){
            this.id = id;
            this.text = text;
            this.state = state;
            this.children = children;
        }
        buildPriitems();
        function buildPriitems(){
            $.ajax({
                url:'../userPriv/getAllPriv',
                type:'get',
                dataType:'json',
                success:function(obj){
                    if(obj.flag){
                        var data = obj.obj;
                        var tr = '';
                        data.forEach(function(v,i){

                            tr+='<div class="block-right-item" id="'+v.privNo+'" privId="'+v.privNo+'" privName="'+v.privName+'" userPriv="'+v.userPriv+'"title="'+v.privName+'"><span class="name">'+v.privName+'<span class="status"> </span></span></div>';
                        });

                        $('#priDox .priItem').html(tr);

                    }
                }
            });
        }
        function convert(data){
            console.log(data);
            var arr = [];
            var tr = '';
            data.forEach(function(v,i){
                if(v.deptId){
                    var node = new TreeNode(v.deptId,v.deptName,"closed")
                    arr.push(node);
                }else if(v.userId){
                    if(v.sex==0){
                        tr+='<div class="block-right-item" item_id="'+v.uid+'" item_name="'+v.userName+'" user_id="'+v.userId+'" uid="'+v.uid+'" title="'+v.userName+'"><span class="name">'+v.userName+' '+v.userPrivName+'<span class="status"> </span></span></div>';
                    }else if(v.sex==1){
                        tr+='<div class="block-right-item" item_id="'+v.uid+'" item_name="'+v.userName+'" user_id="'+v.userId+'" uid="'+v.uid+'" title="'+v.userName+'"><span class="name">'+v.userName+' '+v.userPrivName+'<span class="status"></span></span></div>';
                    }
                }
            });
            //$('#priDox .priItem').html(tr);
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
                $('#selectedDox .priItem #'+that.attr('privid')).remove();
            }else{
                var divObj = $(that.prop("outerHTML"));
                divObj.addClass("active");
                that.addClass("active");
                $('#selectedDox .priItem').append(divObj);
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
