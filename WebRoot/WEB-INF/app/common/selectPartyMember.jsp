<%--
  Created by IntelliJ IDEA.
  User: hasee
  Date: 2021/7/2
  Time: 10:01
  To change this template use File | Settings | File Templates.
--%>
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
    <title>选择党员</title><%--选择部门--%>
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
    <script type="text/javascript" src="../js/xoajq/xoajq1.js"></script>
    <script src="../js/base/base.js"></script>
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
        <a href="#" title='<fmt:message code="common.th.selPerson" />' class="tab_btn"  block="selected" hidefocus="hidefocus"><span><fmt:message code="common.th.selected" /></span></a><%--已选人员  已选--%>
        <a href="#" title='<fmt:message code="common.th.selByDepart" />' block="dept" hidefocus="hidefocus" class=" tab_btn active"><span><fmt:message code="userManagement.th.department" /></span></a><%--按部门选择   部门--%>

        <%--        <a href="#" block="query" class="tab_btn" hidefocus="hidefocus"><span><fmt:message code="workflow.th.sousuo" /></span></a>&lt;%&ndash;搜索&ndash;%&gt;--%>
    </div>
    <div id="navRight" style="float:right;width: 115px;">
        <div class="search">
            <div class="search-body">
                <div class="search-input"><input notlogin_flag="" id="keyword" type="text" value=""></div>
                <div id="search_clear" class="search-clear" style="display:none;"></div>
            </div>
        </div>
    </div>
    <%--    <div id="navRight" style="float:right;">--%>
    <%--        <div class="search">--%>
    <%--            <div class="search-body">--%>
    <%--                <div class="search-input"><input notlogin_flag="" id="keyword" type="text" value=""></div>--%>
    <%--                <div id="search_clear" class="search-clear" style="display:none;"></div>--%>
    <%--            </div>--%>
    <%--        </div>--%>
    <%--    </div>--%>
</div>

<!-- //内容 -->
<div>
    <div class="main-block" id="deptBox" style="display:block;">
        <div class="left moduleContainer" id="dept_menu">
            <div class="tree">
                <div class="pickCompany">
                    <span  class="childdept" style="display: none;">
                        <img src="/img/spirit/icon_company.png" alt="" style="vertical-align: middle;width: 15px;margin-right: 5px;margin-left: 5px;margin-bottom: 4px;">
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
            <div class="block-right" id="dept_item_1">
                <!-- 部门名 -->

                <div id="block-right-remove" class="block-right-remove"><fmt:message code="meet.th.DeleteAll" /></div><%--全部删除--%>

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
    var user_id='';
    var user_idArr;
    var selectedUser;
    if (parent.opener && parent.opener.org_id) {
        user_id = parent.opener.document.getElementById(parent.opener.org_id).getAttribute('orgId');
    } else {
        user_id = parent.$("#" + parent.org_id).attr('orgId');
    }
    if(user_id){
        user_idArr= user_id.split(',');
    }
    function getQueryString(name) {
        var reg = new RegExp("(^|&)" + name + "=([^&]*)(&|$)", "i");
        var r = window.location.search.substr(1).match(reg);
        if (r != null) return unescape(r[2]);
        return null;
    }
    var types = getQueryString("types")
    if(types == 1){
        selectedUser = parent.opener.document.getElementById(parent.opener.org_id).getAttribute('orgId');
        var UserItemName = parent.opener.document.getElementById(parent.opener.org_id).value;
        var UserPrivName = parent.opener.document.getElementById(parent.opener.org_id).getAttribute('orgname')||'';
        var UserdeptName = parent.opener.document.getElementById(parent.opener.org_id).getAttribute('orgno')||'';
        var UserItemarr = [];
        if(UserItemName){
            for(var i=0;i<UserItemName.split(',').length;i++){
                if(selectedUser.split(',')[i] != ''){
                    var UserItemOBJ = {};
                    UserItemOBJ['orgId'] = selectedUser.split(',')[i];
                    UserItemOBJ['userName'] = UserItemName.split(',')[i];
                    UserItemOBJ['deptName'] = UserdeptName.split(',')[i];
                    UserItemOBJ['userPrivName'] = UserPrivName.split(',')[i];
                    UserItemarr.push(UserItemOBJ);
                }
            }
        }
        var selectedList = {
            main: ''
        };
        if(selectedUser != null){
            selectedList['main'] = selectedUser.split(',')[0];
            selectedUser.split(',').forEach(function(v,i){
                if(v != ''){
                    selectedList[selectedUser.split(',')[i]] = true;
                }
            })
        }

        function buildItemList(target, list, defaultdate,type) {
            if (list && list.length > 0) {
                var str = [];
                var display = '';
                if (defaultdate) {
                    for (var i = 0; i < list.length; i++) {
                        var className = 'block-right-item';//active
                        var checked = 'layui-unselect layui-form-checkbox';//layui-form-checked
                        if (selectedList[list[i].orgId]) {
                            // $('#deptBox .userItem .block-right-item').addClass('active');
                            $('.userItem #'+list[i].orgId).addClass('active');
                        }
                        if (selectedList['main'] == list[i].orgId) {
                            checked += ' layui-form-checked';
                        }
                    }
                }else {
                    for (var i = 0; i < list.length; i++) {
                        str.push($('<div class="block-right-item" orgNo="'+list[i].orgId+'" orgName="'+list[i].userName+'" id="'+list[i].orgId+'" orgId="'+list[i].orgId+'" title="'+list[i].userName+'">' +
                            '<span class="name">'+list[i].userName+
                            '<span class="status"></span></span></div>'));
                    }
                }
                // target.html(str)
            }else{
                $("#all_item_2 .allItem").html('<div style="widt' +
                    'h: 230px;height: 200px;margin: 20px auto;text-align: center" class="emptyDivBox"><img src="/img/common/dianjikong.png" style="margin-top: 20px;" alt="">                            <span style="width: 100%;display: inline-block;margin-top: 10px;                        font-size: 15px;                        font-weight: bold;">暂无人员</span></div>')

            }
        }
    }
    function throttle(method,text) {
        clearTimeout(method.tId);
        method.tId=setTimeout(function(){
            method.call(method,text);
        },500);
    }
    // $('#keyword').keydown(function(){
    //     var text = encodeURI($(this).val());
    //     $('#searchName').show();
    //     if(text== ''){
    //         throttle(autodivheights,text);
    //     }else{
    //         $('#searchName .userItem').html('');
    //     }
    // })
    $('#keyword').bind('input propertychange', function() {
        var text = encodeURI($(this).val());
        $('#searchName').show();
        if(text!= ''){
            throttle(autodivheights,text);
        }else{
            throttle(autodivheights,text);
            $('#searchName .userItem').html('');
        }
    });
    function autodivheights(text) {
        var index = layer.load();
        var url = '/OrgPartyMember/selectPartyMemberAll?name='+text
        $.ajax({
            type: "get",
            url: url,
            dataType: 'JSON',
            success: function (res) {
                if(res.flag){
                    //判断是否返回数据集合
                    var arr = [];
                    $('#search_onlineUser').show();
                    $('#searchName').find('.noUsers').hide()
                    res.data.forEach(function(v,i){
                        if(v.deptId){
                            var node = new TreeNode(v.deptId,v.deptName,"closed")
                            arr.push(node);
                            tr+='<div class="block-right-item" deptNo="'+v.deptNo+'" deptName="'+v.deptName+'" id="'+v.deptId+'" deptId="'+v.deptId+'" title="'+v.deptName+'"><span class="name">'+v.deptName+'<span class="status"></span></span></div>';

                        }
                    });
                    // $('#deptBox .userItem').html(tr);
                    if(res.data.length != 0){
                        $.ajax({
                            url:'/OrgPartyMember/selectPartyMemberAll?name='+text,
                            type:'get',
                            dataType:'json',
                            success:function(obj){
                                // if(obj.flag){
                                var data = obj.data;
                                var tr = '';
                                data.forEach(function(v,i){
                                    if(v.userId){
                                        tr+='<div class="block-right-item" orgNo="'+v.userId+'" orgName="'+v.name+'" id="'+v.userId+'" orgId="'+v.userId+'" title="'+v.name+'"><span class="name">'+v.name+'<span class="status"></span></span></div>';
                                    }
                                });
                                $('#deptBox .userItem').html(tr);
                                if(types == 1){
                                    buildItemList($('#dept_item .userItem'), UserItemarr, true,1);
                                }
                                // }
                            }
                        });
                    }
                    $('#searchName .userItem').html(arr);
                }
                layer.close(index);
            },error:function(XMLHttpRequest, textStatus, errorThrown){
                // 状态码
                console.log(XMLHttpRequest.status);
                // 状态
                console.log(XMLHttpRequest.readyState);
                // 错误信息
                console.log(textStatus);
                layer.close(index);
            }
        });

    }

    function close_window(){
        var itemsArr = $('#dept_item_2 .userItem .active');
        var itemnum=location.href.split('?')[1]
        if(itemnum==0){
            if(itemsArr.length>1){
                alert('<fmt:message code="common.th.onlyChooseOne" />')/*只能选择一个*/
                return
            }

        }
        var selectItemsId = '';
        var selectItemsName = '';
        var selectdeptNo = '';
        for(var i=0;i<itemsArr.length;i++){
            var obj = itemsArr.eq(i);
            selectItemsId+=(obj.attr("orgId")+',');
            selectItemsName+=(obj.attr("orgName")+',');
            selectdeptNo+=(obj.attr("orgNo")+',');
        };
        parent.opener.document.getElementById(parent.opener.org_id).value=selectItemsName;
        parent.opener.document.getElementById(parent.opener.org_id).setAttribute('orgName',selectItemsName);
        parent.opener.document.getElementById(parent.opener.org_id).setAttribute('orgId',selectItemsId);
        parent.opener.document.getElementById(parent.opener.org_id).setAttribute('orgNo',selectdeptNo);
        window.close();
    }
    var initTree ;
    $(function(){
        var globalIndex = 0;
        initTree = function(){
            $('#deptOrg').tree({
                url: '/orgDepartment/queryByDepIdList?deptId=0',
                animate:true,
                loadFilter: function(node){
                    var arr = convert(node.obj);
                    return arr;
                },
                onClick:function(node){
                    build(node.id);
                    $(this).tree(node.state === 'closed' ? 'expand' : 'collapse', node.target);
                    node.state = node.state === 'closed' ? 'open' : 'closed';
                },
                onBeforeExpand:function(node,param){
                    $('#deptOrg').tree('options').url = "/OrgPartyMember/selectPartyMemberAll?orgDeptId=" + node.id;// change the url
                }

            });
        };
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
var dept_item_3=''
        function TreeNode(id,text,state,children){
            this.id = id;
            this.text = text;
            this.state = state;
            this.children = children;
        }
        function convert(data){
            var arr = [];
            var tr = '';
            data.forEach(function(v,i){
                if(v.deptId){
                    var node = new TreeNode(v.deptId,v.deptName,"closed")
                    arr.push(node);
                    tr+='<div class="block-right-item" deptNo="'+v.deptNo+'" deptName="'+v.deptName+'" id="'+v.deptId+'" deptId="'+v.deptId+'" title="'+v.deptName+'"><span class="name">'+v.deptName+'<span class="status"></span></span></div>';

                }
            });
            // $('#deptBox .userItem').html(tr);
            if(data.length != 0){
                $.ajax({
                    url:'/OrgPartyMember/selectPartyMemberAll',
                    type:'get',
                    dataType:'json',
                    success:function(obj){
                        // if(obj.flag){
                        var data = obj.data;
                        var tr = '';
                        data.forEach(function(v,i){
                            var bool = false;
                            div = '<div class="block-right-item  '+function(){
                                if(user_id){
                                    var user_idArr;
                                    if(Array.isArray(user_id)){
                                        user_idArr= user_id;
                                    }else {
                                        user_idArr= user_id.split(',');
                                    }
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
                            }()+'"orgNo="'+v.userId+'" orgName="'+v.name+'" id="'+v.userId+'" orgId="'+v.userId+'" title="'+v.name+'"><span class="name">'+v.name+'<span class="status"></span></span></div>';
                            tr+=div;
                            if (bool) {
                                dept_item_3 +=div;
                            }
                        });

                        $('#deptBox .userItem').html(tr);
                        $('#dept_item_1 .userItem').html(dept_item_3);
                        if(types == 1){
                            buildItemList($('#dept_item .userItem'), UserItemarr, true,1);
                        }
                        // }
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

                    break;
                case "group":

                    break;
                case "query":

                    break;
            }
        });
        function build(id){
            $.ajax({
                url:'/OrgPartyMember/selectPartyMemberAll?orgDeptId='+id,
                type:'get',
                dataType:'json',
                success:function(obj){
                    // if(obj.flag){
                    var data = obj.data;
                    var tr = '';
                    data.forEach(function(v,i){
                        if(v.userId){
                            tr+='<div class="block-right-item" orgNo="'+v.userId+'" orgName="'+v.name+'" id="'+v.userId+'" orgId="'+v.userId+'" title="'+v.name+'"><span class="name">'+v.name+'<span class="status"></span></span></div>';
                        }
                    });

                    $('#deptBox .userItem').html(tr);

                    // }
                }
            });
        }
        $('#dept_item').on("click",".block-right-item",function(){
            var that = $(this);
            var user_id = that.attr('id');
            if(types == 1){
                if (that.attr('class').indexOf('active') > -1) {
                    that.removeClass("active");
                    $('#dept_item_2 .block-right-item[id='+user_id +']').remove();
                    $('#all_item_2 .block-right-item[id='+ user_id +']').removeClass("active");
                    selectedList[user_id] = false;
                    if (selectedList['main'] == user_id){
                        $(e.target).siblings().removeClass('layui-form-checked');
                        $('#all_item_2 .block-right-item[id='+ id +']').find('.layui-form-checkbox').removeClass('layui-form-checked');
                        selectedList['main'] = '';
                    }
                } else {
                    that.addClass("active");
                    $('#all_item_2 .block-right-item[id='+ user_id +']').addClass("active");
                    if($('#dept_item_2 .block-right-item[id='+ user_id +']').length == 0){
                        var str = that.prop("outerHTML");
                        $('#dept_item_2 .userItem').append(str);
                    }
                    selectedList[user_id] = true;
                    if ($('#dept_item_2 .userItem').find('.layui-form-checked').length == 0) {
                        $(e.target).siblings().addClass('layui-form-checked');
                        $('#all_item_2 .block-right-item[id='+ user_id +']').find('.layui-form-checkbox').addClass('layui-form-checked');
                        $('#dept_item_2 .block-right-item[id='+ user_id +']').find('.layui-form-checkbox').addClass('layui-form-checked');
                        selectedList['main'] = $(e.target).siblings().find('span').attr('id');
                    }
                }
            }else{
                if(that.attr('class').indexOf('active') > 0){
                    that.removeClass("active");
                    if( $('#selectedDox .userItem #'+that.attr('orgId')).length > 0){

                        $('#selectedDox .userItem #'+that.attr('orgId')).remove();
                    }
                }else{

                    var divObj = $(that.prop("outerHTML"));
                    divObj.addClass("active");
                    that.addClass("active");


                    if( $('#selectedDox .userItem #'+that.attr('orgId')).length < 1){
                        $('#selectedDox .userItem').append(divObj);
                    }

                }
            }

        });

        $('#selectedDox #block-right-remove').on('click',function () {
            $('#selectedDox .userItem .block-right-item').each(function() {
                if( $('#deptBox .userItem #'+$(this).attr('orgId')).length > 0){
                    $('#deptBox .userItem #'+$(this).attr('orgId')).removeClass('active');
                }
            });
            $('#selectedDox .userItem .block-right-item').remove();
        });

        $('#selectedDox .userItem ').on('click','.block-right-item',function () {
            $('#deptBox .userItem #'+$(this).attr('orgId')).removeClass('active');
            $(this).remove();
        });

        $('#deptBox #block-right-add').on('click',function () {
            $('#deptBox .userItem .block-right-item').addClass('active');
            var str  = '';
            $('#deptBox .userItem .active').each(function (i,v) {
                if( $('#selectedDox .userItem #'+$(this).attr('orgId')).length < 1){
                    str += $(this).prop("outerHTML");
                }
            });
            $('#selectedDox .userItem').append(str);
        });

        $('#deptBox #block-right-remove').on('click',function () {
            $('#deptBox .userItem .active').each(function (i,v) {

                if( $('#selectedDox .userItem #'+$(this).attr('orgId')).length > 0){

                    $('#selectedDox .userItem #'+$(this).attr('orgId')).remove();
                }
            });
            $('#deptBox .userItem .block-right-item').removeClass('active');
        });

        $('.tree .dynatree-container').on('click','.childdept',function(){
            var  that = $(this);
            getChDept(that.next(),that.attr('orgId'));
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

