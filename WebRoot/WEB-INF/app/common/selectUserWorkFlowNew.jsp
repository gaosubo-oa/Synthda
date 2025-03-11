<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@taglib prefix="mvc" uri="http://www.springframework.org/tags/form" %>
<%@taglib prefix="fmt" uri="http://www.springframework.org/tags" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
%>
<!DOCTYPE html>
<html>
<head>
    <title><fmt:message code="common.th.selPeople"/></title><%--选择人员--%>
    <meta http-equiv="Content-Type" content="text/html; charset=gbk"/>
    <%--    <meta name="renderer" content="webkit">--%>
    <meta http-equiv="X-UA-Compatible" content="IE=10,chrome=1"/>
    <meta name="viewport"
          content="width=device-width, initial-scale=1.0, user-scalable=0, minimum-scale=1.0, maximum-scale=1.0">
    <link rel="stylesheet" type="text/css" href="../css/common/style.css"/>
    <link rel="stylesheet" type="text/css" href="../css/common/select.css"/>
    <link rel="stylesheet" href="/lib/layui/layui/dest/css/layui.css?20210319.1" media="all">
    <!-- 	<link rel="stylesheet" type="text/css" href="../css/common/ui.dynatree.css"> -->
    <link rel="stylesheet" type="text/css" href="../css/common/org_select.css">
    <link rel="stylesheet" type="text/css" href="../lib/easyui/themes/easyui.css"/>
    <link rel="stylesheet" type="text/css" href="../lib/easyui/themes/icon.css"/>
    <script type="text/javascript" src="../js/xoajq/xoajq1.js"></script>
    <script src="../../lib/layer/layer.js?20201106"></script>
    <script src="../../lib/laydate/laydate.js"></script>
    <script src="/js/base/base.js"></script>
    <script type="text/javascript" src="../js/spirit/qwebchannel.js"></script>
    <script type="text/javascript" src="/js/spirit/qwebchannel.js"></script>
    <script src="/js/base/base.js"></script>
    <script type="text/javascript" src="../lib/easyui/jquery.easyui.min.js"></script>
    <script type="text/javascript" src="../lib/easyui/tree.js"></script>
    <script type="text/javascript" src="/js/common/selectUserWorkflow.js"></script>
    <script>
        console.log(parent);
        if (!Array.prototype.forEach) {

            Array.prototype.forEach = function (callback/*, thisArg*/) {

                var T, k;

                if (this == null) {
                    throw new TypeError('this is null or not defined');
                }

                // 1. Let O be the result of calling toObject() passing the
                // |this| value as the argument.
                var O = Object(this);

                // 2. Let lenValue be the result of calling the Get() internal
                // method of O with the argument "length".
                // 3. Let len be toUint32(lenValue).
                var len = O.length >>> 0;

                // 4. If isCallable(callback) is false, throw a TypeError exception.
                // See:/#x9.11
                if (typeof callback !== 'function') {
                    throw new TypeError(callback + ' is not a function');
                }

                // 5. If thisArg was supplied, let T be thisArg; else let
                // T be undefined.
                if (arguments.length > 1) {
                    T = arguments[1];
                }

                // 6. Let k be 0.
                k = 0;

                // 7. Repeat while k < len.
                while (k < len) {

                    var kValue;

                    // a. Let Pk be ToString(k).
                    //    This is implicit for LHS operands of the in operator.
                    // b. Let kPresent be the result of calling the HasProperty
                    //    internal method of O with argument Pk.
                    //    This step can be combined with c.
                    // c. If kPresent is true, then
                    if (k in O) {

                        // i. Let kValue be the result of calling the Get internal
                        // method of O with argument Pk.
                        kValue = O[k];

                        // ii. Call the Call internal method of callback with T as
                        // the this value and argument list containing kValue, k, and O.
                        callback.call(T, kValue, k, O);
                    }
                    // d. Increase k by 1.
                    k++;
                }
                // 8. return undefined.
            };
        }

        if (!Array.prototype.indexOf) {
            Array.prototype.indexOf = function (elt /*, from*/) {
                var len = this.length >>> 0;
                var from = Number(arguments[1]) || 0;
                from = (from < 0)
                    ? Math.ceil(from)
                    : Math.floor(from);
                if (from < 0)
                    from += len;
                for (; from < len; from++) {
                    if (from in this &&
                        this[from] === elt)
                        return from;
                }
                return -1;
            };
        }
    </script>
    <style>
        #dept_menu {
            overflow-x: auto;
        }

        .left_choose ul li div, .left_choose ul li h1, .left_choose ul img {
            float: left;
        }

        .left_choose ul img {
        <!-- margin-top: 8 px;
        -->
        }

        .left_choose ul li {
            width: 80%;
            height: 20px;
        <!-- background: red;
        --> margin-top: 10px;
        }

        .mar {
            margin-left: 10%;
        }

        .name li {
            list-style-type: none;
        }

        .choose {
            background: #D6E4EF !important;
        }

        .layui-form-checkbox {
            height: 25px;
            line-height: 23px;
        }

        .layui-form-item .layui-form-checkbox {
            float: left;
            /*left: 50px;*/
            left: 26px;
            margin-top: 2px;
        }

        .byPrivOrgStrsli {
            background: #fff;
        }

        .byPrivOrgStrsli.actives {
            background: #5FB878;
            color: #fff;
        }

        .byPrivOrgStrsli:hover {
            cursor: pointer;
        }
        .searchinput{
            margin: 6px 70px;
            width: 150px;
            height: 17px;
            border-radius: 30px;
            border: 1px solid #ccc;
            text-indent: 10px;
            padding-right: 10px;
        }
        .searchboxdiv{
            position: relative;
        }
        .searchboxdiv .searchspan{
            position: absolute;
            top: 7px;
            right: 18px;
            color:#2e7fde;
            font-weight: bold;
            cursor: pointer;
        }
        #byPrivOrg .byPrivOrgStrsli{
            cursor: pointer;
        }
        .privActive {
            background: #c7e1f6 !important;
            font-weight: bold;
        }
        .username{
            font-weight: bold;;
        }
    </style>
</head>

<body>
<div id="north" style="display: none">
    <div id="navMenu" style="width:auto;">
        <a href="#" title="已选人员" class="tab_btn"  block="selected" hidefocus="hidefocus"><span>已选</span></a>
        <a href="#" title='<fmt:message code="doc.th.AllHandlers" />' block="allSelect" hidefocus="hidefocus"
           class=" tab_btn active"><span><fmt:message code="doc.th.AllHandlers"/></span></a><%--全部经办人 全部经办人--%>
        <%--<a href="#" title='<fmt:message code="common.th.chooseByProcess" />' class="tab_btn" block="byFlow" hidefocus="hidefocus"><span><fmt:message code="common.th.chooseByProcess" /></span></a>&lt;%&ndash;按流程选择 按流程选择&ndash;%&gt;--%>
        <a href="#" title='<fmt:message code="common.th.selByDepart" />' class="tab_btn" block="byDept"
           hidefocus="hidefocus"><span><fmt:message code="common.th.selByDepart"/></span></a><%--按部门选择 按部门选择--%>
        <a href="#" title='<fmt:message code="common.th.selByRole" />' class="tab_btn" block="byPriv"
           hidefocus="hidefocus"><span><fmt:message code="common.th.selByRole"/></span></a><%--按角色选择 按角色选择--%>
        <a href="#" block="group" class="tab_btn" hidefocus="hidefocus"><span>公共分组</span></a><%--公共分组--%>
        <a href="#" block="custom" class="tab_btn" hidefocus="hidefocus"><span>个人分组</span></a><%--个人分组--%>
    </div>
    <div id="navRight" style="float:right;position: absolute;right:0;">
        <div class="searchboxdiv">
            <div class="searchspan">
                <img src="/img/workflow/work/worksearch.png" alt="" style="margin-bottom: 1px">
                <span>搜索</span>
            </div>
            <input type="text" class="searchinput" id="keyword" >
            <%--<div class="search-body">--%>
            <%--<div class="search-input"><input notlogin_flag="" id="keyword" type="text" value=""></div>--%>
            <%--<div id="search_clear" class="search-clear" style="display:none;"></div>--%>
            <%--</div>--%>
        </div>
    </div>
</div>

<!-- //内容 -->
<div class="layui-form-item" style="display: none">
    <!-- 已选 -->
    <div class="main-block aitem" id="selectedDox">
        <div class="left moduleContainer" id="choose_menu">
            <div class="tree">
                <ul class="dynatree-container dynatree-no-connector" id="chooseOrg">
                </ul>
            </div>

        </div>
        <div class="right" id="dept_item">
            <div class="block-right" id="dept_item_2">
                <div class="block-right-add" onclick="addAllUser($(this))">全部添加</div>
                <div class="block-right-remove" onclick="deleteAllUser($(this))">全部删除</div>
                <div class="userItem">

                </div>
            </div>
        </div>
    </div>
    <div class="main-block aitem" id="allSelect" style="display:block;">
        <div class="left moduleContainer" id="dept_menu" style="">
            <div class="tree">
                <ul class="dynatree-container dynatree-no-connector" id="deptOrg">
                </ul>
            </div>

        </div>
        <div class="right" id="all_item" style="">
            <div class="block-right" id="all_item_2">
                <!-- 全部经办人 -->
                <div class="block-right-header" title=""></div>

                <div id="block-right-add" class="block-right-add"><fmt:message code="meet.th.addAll"/></div>
                <%--全部添加--%>
                <div id="block-right-remove" class="block-right-remove"><fmt:message code="meet.th.DeleteAll"/></div>
                <%--全部删除--%>
                <div class="allItem">

                </div>
            </div>
            <div class="block-right" id="all_item_search" style="display: none">
                <!-- 全部经办人 -->
                <div class="block-right-header" title=""></div>

                <div id="block-right-add" class="block-right-add"><fmt:message code="meet.th.addAll"/></div>
                <%--全部添加--%>
                <div id="block-right-remove" class="block-right-remove"><fmt:message code="meet.th.DeleteAll"/></div>
                <%--全部删除--%>
                <div class="searchItem">

                </div>
            </div>
            <div class="userItem curDept" id="nonesearch" style="display: none">
                <div style="width: 230px;height: 200px;margin: 20px auto;text-align: center" class=""><img
                        src="/img/common/sousuokong.png" style="margin-top: 20px;" alt=""> <span
                        style="width: 100%;display: inline-block;margin-top: 10px;                            font-size: 15px;                            font-weight: bold;">暂无搜索人员</span>
                </div>
            </div>
        </div>
    </div>


    <!-- 按流程选人 -->
    <div class="main-block aitem" id="byFlow">
        <div class="left moduleContainer" id="byFlow_menu">
            <div class="tree">
                <ul class="dynatree-container dynatree-no-connector" id="byFloworg">
                </ul>
            </div>

        </div>
        <div class="right" id="byFlow_item">
            <div class="block-right" id="byFlow_item_2">
                <!-- 部门名 -->
                <div id="block-right-add" class="block-right-add"><fmt:message code="meet.th.addAll"/></div>
                <%--全部添加--%>
                <div class="block-right-remove"><fmt:message code="meet.th.DeleteAll"/></div>
                <%--全部删除--%>

                <div class="byFlowItem">

                </div>
            </div>
        </div>
    </div>
    <!-- 按部门选择 -->
    <div class="main-block aitem" id="byDept">
        <div class="left moduleContainer" id="byDept_menu">
            <div class="tree">
                <ul class="dynatree-container dynatree-no-connector" id="byDeptOrg">
                </ul>
            </div>

        </div>
        <div class="right" id="byDeptitem">
            <div class="block-right" id="byDept_item_2">
                <!-- 部门名 -->
                <div id="block-right-add" class="block-right-add" style="display: none"><fmt:message code="meet.th.addAll"/></div>
                <%--全部添加--%>
                <div class="block-right-remove" style="display: none"><fmt:message code="meet.th.DeleteAll"/></div>
                <%--全部删除--%>
                <div class="byDeptItem">

                </div>
            </div>
            <div class="userItem curDept" id="nonesdeptearch" style="display: none">
                <div style="width: 230px;height: 200px;margin: 20px auto;text-align: center" class=""><img
                        src="/img/common/sousuokong.png" style="margin-top: 20px;" alt=""> <span
                        style="width: 100%;display: inline-block;margin-top: 10px;                            font-size: 15px;                            font-weight: bold;">暂无搜索人员</span>
                </div>
            </div>
        </div>

    </div>

    <!-- 按角色选择 -->
    <div class="main-block aitem" id="byPriv">
        <div class="left moduleContainer" id="byPriv_menu">
            <div class="tree">
                <ul class="dynatree-container dynatree-no-connector" id="byPrivOrg">
                </ul>
            </div>

        </div>
        <div class="right" id="byPrivitem">
            <div class="block-right" id="byPriv_item_2">
                <!-- 部门名 -->
                <div class="block-right-remove" style="display: none"><fmt:message code="meet.th.DeleteAll"/></div>
                <%--全部删除--%>
                <div class="byPrivItem">

                </div>
            </div>
            <div class="userItem curDept" id="noneprivsearch" style="display: none">
                <div style="width: 230px;height: 200px;margin: 20px auto;text-align: center" class=""><img
                        src="/img/common/sousuokong.png" style="margin-top: 20px;" alt=""> <span
                        style="width: 100%;display: inline-block;margin-top: 10px;                            font-size: 15px;                            font-weight: bold;">暂无搜索人员</span>
                </div>
            </div>
        </div>

    </div>

    <!-- 分组 -->
    <div class="main-block aitem" id="groupDox" >
        <div class="left moduleContainer" id="allGroup">
            <div class="leftGroup">
                <div class="block-left-header">公共自定义组</div>
            </div>
        </div>
        <div class="right" id="group_item">
            <div class="block-right" id="group_item_2" style="">
                <div class="block-right-header" title="" style="background: #b6e0ff;" id="group-right-header">公共自定义组1</div>
                <div class="block-right-add" onclick="addAllUser($(this))">全部添加</div>
                <div class="block-right-remove" onclick="deleteAllUser($(this))">全部删除</div>
                <div class="userItem">
                </div>
            </div>

        </div>
    </div>
    <!-- 在线 -->
    <div class="main-block aitem" id="onlineName">
        <div class="right onlineRight" id="dept_online">
            <div class="block-right" id="dept_onlineUser">
                <div class="block-right-header" title="" style="background: #b6e0ff;" id="onlineUser">在线人员</div>
                <div id="onlineAdd" onclick="addAllUser($('#onlineName'))" class="block-right-add">全部添加</div>
                <div class="block-right-remove" onclick="deleteAllUser($('#onlineName'))">全部删除</div>

                <div class="userItem">

                </div>
            </div>
        </div>
    </div>
    <!-- 自定义组 -->
    <div class="main-block aitem" id="customDox">
        <div class="left moduleContainer" id="allcustom">
            <div class="leftGroup">
                <div class="block-left-header">个人自定义组</div>
            </div>
        </div>
        <div class="right" id="custom_item">
            <div class="block-right" id="custom_item_2" style="">

                <div class="block-right-header" title="" style="background: #b6e0ff;" id="custom-right-header"></div>

                <div class="block-right-add" onclick="addAllUser($(this))">全部添加</div>

                <div class="block-right-remove" onclick="deleteAllUser($(this))">全部删除</div>

                <div class="userItem">
                </div>
            </div>
            <div class="pleaseChecks" style="display: none; text-align: center; line-height: 100px; font-size: 12pt;">请选择分组<br>（ 请在控制面板添加个人分组 ）</div>
            <div class="noUsers" style="display: none;text-align: center;line-height: 100px;font-size: 12pt;">该分组未设置用户</div>
        </div>
    </div>
</div>
<!-- //结束 -->
<div id="south" style="display: none">
    <input type="button" class="BigButtonA" value='<fmt:message code="global.lang.ok" />' onclick="close_window();">&nbsp;&nbsp;<%--确定--%>
</div>
</body>
<script>

    function getQueryString(name) {
        var reg = new RegExp("(^|&)" + name + "=([^&]*)(&|$)", "i");
        var r = window.location.search.substr(1).match(reg);
        if (r != null) return unescape(r[2]);
        return null;
    }
    var type = getQueryString("type")
    var secretType = getQueryString("secretType");
    var runIds = getQueryString("runIds")
    var parentObject = null;
    //兼容密送选人不显示主办
    var isDisplay;
    if(secretType !== null){
        if(secretType == '1'){
            isDisplay = 'none'
        }else{
            isDisplay = 'block'
        }
    }

    //为了兼容360IE，使用了$.isEmptyObject方法
    if ( !$.isEmptyObject(parent.opener) && parent.opener.UserItem ) {
        parentObject = parent.opener
    } else {
        parentObject = parent
    }

    $('#north').hide().siblings('.layui-form-item').hide().siblings('#south').hide();
    var searchNum = false;//控制搜索的参数 跟滚动加载更多经办人有关
    var loadFirst = layer.load();
    var flowId = $.GetRequest().flowId || '';
    var flowPrcs = $.GetRequest().flowPrcs || '';
    var deptNo = $.GetRequest().deptNo || '';
    /***********处理了deptNo传输值为,或者,,得情况 start*************/
    var deptNoFlag = false;
    for(var i=0;i<deptNo.split(',').length;i++){
        var j = deptNo.split(',')[i];
        if(j != ''){
            deptNoFlag = true;
        }
    }
    if(!deptNoFlag){
        deptNo = '';
    }
    /************************结束*******************************/
    var runId = $.GetRequest().runId || '';
    var currentFlowPrcs = $.GetRequest().currentFlowPrcs || '';
    var topdefault = $.GetRequest().topdefault || '';
    var paraValue=0;
    var searchPara="";
    $.ajax({
        type:'get',
        async: false,
        url:'/syspara/queryOrgScope',
        dataType:'json',
        success:function (reg) {
            var item=reg.object;
            if(item.paraValue == 1){
                paraValue = 1;
            }
        }
    });
    /***********处理了通过角色选择人员的功能 获取左侧选择角色种类数据 start*************/
    allprcsUserlist = parentObject.allprcsUserlist;
    prcsPrivlist = parentObject.prcsPrivlist;
    $.ajax({
        url:'/userPriv/getAllPriv',
        data:{},
        dataType:'json',
        type:'post',
        success:function(json){
            prcsPrivlist = json.obj;
            var byPrivOrgStrs = '';
            for (var i = 0; i < prcsPrivlist.length; i++) {
                byPrivOrgStrs += '<li class="byPrivOrgStrsli" style="' +
                    'padding-left: 20px;border: 1px solid #ddd;height:30px ;line-height:30px;' +
                    'border-radius: 4px;" userPriv="'+ prcsPrivlist[i].userPriv +'">' + prcsPrivlist[i].privName + '</li>'
            }

            $('#byPriv_menu #byPrivOrg').html(byPrivOrgStrs);
        }
    });
    /************************结束*******************************/
    /***********处理了展示全部人员的功能 获取全部人员的数据 start*************/
    prcsUserlist = parentObject.prcsUserlist;
    prcsDeptlist = parentObject.prcsDeptlist;
    var page = 1;
    var pageTotao;
    var UserItem,UserItemMain,pageSize=45;
    //处理了已选择人员的userid串和name串
    if(secretType != 1){
        UserItem = parentObject.document.getElementById(parentObject.UserItem).getAttribute('user_id');
        UserItemMain = parentObject.document.getElementById(parentObject.UserItemMain).getAttribute('user_id');
        var UserItemName = parentObject.document.getElementById(parentObject.UserItem).value;
        var UserItemMainName = parentObject.document.getElementById(parentObject.UserItemMain).value;
        var UserPrivName = parentObject.document.getElementById(parentObject.UserItem).getAttribute('userPrivName')||'';
        var UserMainPrivName = parentObject.document.getElementById(parentObject.UserItemMain).getAttribute('userPrivName')||'';
        var UserdeptName = parentObject.document.getElementById(parentObject.UserItem).getAttribute('deptName')||'';
        var UserMaindeptName = parentObject.document.getElementById(parentObject.UserItemMain).getAttribute('deptName')||'';
    }else{
        var UserItemName = parentObject.document.getElementById("rescueUser").value;
        UserItem = parentObject.document.getElementById("rescueUser").getAttribute('user_id');
        var UserdeptName = parentObject.document.getElementById("rescueUser").getAttribute('deptName')||'';
        var UserPrivName = parentObject.document.getElementById("rescueUser").getAttribute('userPrivName')||'';
    }
    /*****************处理userid带有 的用户*******************************/
    if(UserItem.indexOf(' ') > -1||UserItemMain.indexOf(' ') > -1){
        UserItem = UserItem.replace(new RegExp(" ", "gm"), "空格kg");
        UserItemMain = UserItemMain.replace(new RegExp(" ", "gm"), "空格kg")
    }
    /******************结束***************************/

    var UserItemarr = [];
    if(UserItemName){
        for(var i=0;i<UserItemName.split(',').length;i++){
            if(UserItem.split(',')[i] != ''){
                var UserItemOBJ = {};
                UserItemOBJ['uid'] = UserItem.split(',')[i];
                UserItemOBJ['userId'] = UserItem.split(',')[i];
                UserItemOBJ['userName'] = UserItemName.split(',')[i];
                UserItemOBJ['deptName'] = UserdeptName.split(',')[i];
                UserItemOBJ['userPrivName'] = UserPrivName.split(',')[i];
                UserItemarr.push(UserItemOBJ);
            }
        }
    }
    var datas = {};
    if(secretType == 1){
        datas = {
                flowId:flowId,
                flowPrcs:flowPrcs,
                deptNo:deptNo,
                deptId:'',
                userPriv:'',
                search:'',
                page:page,
                pageSize:pageSize,
                useFlag:true,
                secretType:'1',
                runId:runIds,
        }
    }else{
        datas = {
            flowId:flowId,
            flowPrcs:flowPrcs,
            deptNo:deptNo,
            deptId:'',
            userPriv:'',
            search:'',
            page:page,
            pageSize:pageSize,
            useFlag:true,
        }
    }
    if(parentObject.sanyuanOpen){
        var contentSecrecy = parentObject.getContentSecrecy();
        datas['contentSecrecy'] = contentSecrecy;
    }
    $.ajax({
        url:'/workflow/work/getWorkFlowUser',
        data: datas,
        dataType:'json',
        type:'post',
        async:false,
        success:function(json){
            prcsUserlist = json.obj;
            pageTotao = json.totleNum;
        }
    });
    /************************结束*******************************/

    var selectedList = {
        main: ''
    };
    $(document).keyup(function (e) {//捕获文档对象的按键弹起事件
        if (e.keyCode == 13&&!$('#navRight').is(':hidden')) {//按键信息对象以参数的形式传递进来了
            //此处编写用户敲回车后的代码
            $('.searchspan').click();
        }
    });
    /***********页面关闭 获取主办人和经办人的功能函数 start*************/
    function close_window() {
        var index = layer.load(0, {
            shade: [2,'#fff'] //0.1透明度的白色背景
        });
        var itemsArr = $('#dept_item_2 .userItem .active')
        var selectUserName = [];
        var selectUserId = '',selectDeptname = '',selectUserprivname = '';
        for (var i = 0; i < itemsArr.length; i++) {
            var obj = itemsArr.eq(i);
            if (selectUserName.indexOf(obj.attr('item_name')) == -1) {
                selectUserId += (obj.attr("user_id") + ',');
                selectDeptname += (obj.attr("deptname") + ',');
                selectUserprivname += (obj.attr("userprivname") + ',');
                selectUserName.push(obj.attr("item_name"));
            }
        };
        var zhuban = ($('#dept_item_2 .layui-form-checked span').attr('username') || '');
        var zhubanId = ($('#dept_item_2 .layui-form-checked span').attr('user_id') || '');
        var zhubanUserprivname = ($('#dept_item_2 .layui-form-checked').parent().attr('userprivname') || '');
        var zhubanDeptname = ($('#dept_item_2 .layui-form-checked').parent().attr('deptname') || '');
        var jingban = selectUserName.join(',');
        var jingbanId = selectUserId;
        var jingbanDeptname = selectDeptname;
        var jingUserprivname = selectUserprivname;
        if (selectUserName.length == 0) {
            jingban = zhuban;
            jingbanId = zhubanId;
            jingbanDeptname = zhubanDeptname;
            jingUserprivname = zhubanUserprivname;
        }
        if(jingbanId != ''||zhubanId != ''){
            if(!matchString(jingbanId,zhubanId)){
                if(jingban.slice(jingban.length - 1) === ','){
                    jingban += zhuban;
                }else{
                    jingban += ','+zhuban;
                }
                if(jingbanId.slice(jingbanId.length - 1) === ','){
                    jingbanId += zhubanId;
                }else{
                    jingbanId += ','+zhubanId;
                }
                if(jingbanDeptname.slice(jingbanDeptname.length - 1) === ','){
                    jingbanDeptname += zhubanDeptname;
                }else{
                    jingbanDeptname += ','+zhubanDeptname;
                }
                if(jingUserprivname.slice(jingUserprivname.length - 1) === ','){
                    jingUserprivname += zhubanUserprivname;
                }else{
                    jingUserprivname += ','+zhubanUserprivname;
                }
            }
        }
        /*****************处理userid带有 的用户*******************************/
        if(jingbanId.indexOf('空格kg') > -1||zhubanId.indexOf('空格kg') > -1){
            jingbanId = jingbanId.replace(new RegExp("空格kg", "gm"), " ");
            zhubanId = zhubanId.replace(new RegExp("空格kg", "gm"), " ")
        }
        /******************结束***************************/
        if(secretType == 1){
            parentObject.document.getElementById("rescueUser").value = jingban;
            parentObject.document.getElementById("rescueUser").setAttribute('user_id', jingbanId);
            parentObject.document.getElementById("rescueUser").setAttribute('userprivname', jingUserprivname);
            parentObject.document.getElementById("rescueUser").setAttribute('deptname', jingbanDeptname);
            window.close();
            if (parentObject.selectUsreLayerIndex) {
                parentObject.layer.close(parentObject.selectUsreLayerIndex)
            }
        }else{
            parentObject.document.getElementById(parentObject.UserItem).value = jingban;
            parentObject.document.getElementById(parentObject.UserItem).setAttribute('user_id', jingbanId);
            parentObject.document.getElementById(parentObject.UserItem).setAttribute('userprivname', jingUserprivname);
            parentObject.document.getElementById(parentObject.UserItem).setAttribute('deptname', jingbanDeptname);
            parentObject.document.getElementById(parentObject.UserItemMain).value = zhuban;
            parentObject.document.getElementById(parentObject.UserItemMain).setAttribute('user_id', zhubanId);
            parentObject.document.getElementById(parentObject.UserItemMain).setAttribute('userprivname', zhubanUserprivname);
            parentObject.document.getElementById(parentObject.UserItemMain).setAttribute('deptname', zhubanDeptname);
            window.close();
            if(type == '00'){
                parent.document.getElementsByClassName('layui-layer-btn0')[0].click();
            }
            if (parentObject.selectUsreLayerIndex) {
                parentObject.layer.close(parentObject.selectUsreLayerIndex)
            }
        }



    };
    /************************结束*******************************/

    function autodivheights(text,index) {
        if($('#navMenu a.active').attr('block') == 'allSelect'){
            var length = $('#all_item_2 .allItem .block-right-item').length
            var $chooseThis = $('#all_item_2 .allItem').find('.block-right-item');
            var $showdiv = $('#all_item_2');
            var $nonesearch = $('#nonesearch');
        }else if($('#navMenu a.active').attr('block') == 'byDept'){
            var length = $('#byDept_item_2 .byDeptItem .block-right-item').length;
            var $chooseThis = $('#byDept_item_2 .byDeptItem').find('.block-right-item');
            var $showdiv = $('#byDept_item_2');
            var $nonesearch = $('#nonesdeptearch');
        }else if($('#navMenu a.active').attr('block') == 'byPriv'){
            var length = $('#byPriv_item_2 .byPrivItem .block-right-item').length;
            var $chooseThis = $('#byPriv_item_2 .byPrivItem').find('.block-right-item');
            var $showdiv = $('#byPriv_item_2');
            var $nonesearch = $('#noneprivsearch');
        }

        var j = 0;
        for (var i = 0; i < length; i++) {
            var $this = $chooseThis.eq(i);
            var szm_name = $this.attr('szm_name');
            var item_name = $this.attr('item_name');
            var user_id = $this.attr('user_id');
            if (szm_name.indexOf(text) > -1 || item_name.indexOf(text) > -1 || user_id.indexOf(text) > -1) {
                $this.show();
            } else {
                $this.hide();
                j++;
            }
            if (length == j) {
                $showdiv.hide();
                $nonesearch.show();
            }
        }
        layer.close(index);
    };

    /***********处理了各功能模块下的元素显示、隐藏和是否主办的功能函数 start*************/
    function mapping($array){
        $array.find('.block-right-item').each(function (index,element) {
            var user_id = $(element).attr('user_id');
            if(selectedList[user_id] != undefined&&selectedList[user_id]){
                $(element).addClass('active');
                if(selectedList['main'] == user_id){
                    $(element).find('.layui-unselect').addClass('layui-form-checked');
                }else{
                    $(element).find('.layui-unselect').removeClass('layui-form-checked');
                }
            }else{
                if(!selectedList[user_id]){
                    $(element).removeClass('active');
                }
            }
        })
    };
    /************************结束*******************************/

    //按角色、部门 全部选中
    function addPrivAndDept($this) {
        $this.parent().find('.block-right-item').each(function (i, v) {
            if(!$(v).hasClass('active')){
                $(v).find('.name').click();
            }
        });
    };

    //按角色、部门 全部删除
    function removePrivAndDept($this) {
        $this.parent().find('.block-right-item').each(function (i, v) {
            if($(v).hasClass('active')){
                $(v).find('.name').click();
            }
        });
    };

    //公共分组、个人分组 全部选中
    function addAllUser($this) {
        $this.parent().find('.block-right-item').each(function (i, v) {
            if(!$(v).hasClass('active')){
                $(v).find('.name').click();
            }
        });
    };

    //公共分组、个人分组 全部删除
    function deleteAllUser($this) {
        $this.parent().find('.block-right-item').each(function (i, v) {
            if($(v).hasClass('active')){
                $(v).find('.name').click();
            }
        });
    };

    function buildUserList(id) {
        $.ajax({
            type: "get",
            url: "../department/getChDept?deptId=" + id,
            dataType: 'JSON',
            success: function (res) {
                var tr = [];
                res.obj.forEach(function (v, i) {
                    var divObj;
                    if (v.userId) {
                        if (v.sex == 0) {
                            divObj = $('<div class="block-right-item" item_id="' + v.uid + '" item_name="' + v.userName + '" id="' + v.uid + '"   user_id="' + v.userId + '" uid="' + v.uid + '" title="' + v.userName + '"><span class="name">' + v.userName + ' ' + v.userPrivName + '<span class="status"> </span></span></div>');
                        } else if (v.sex == 1) {
                            divObj = $('<div class="block-right-item" item_id="' + v.uid + '" item_name="' + v.userName + '"  id="' + v.uid + '"  user_id="' + v.userId + '" uid="' + v.uid + '" title="' + v.userName + '"><span class="name">' + v.userName + ' ' + v.userPrivName + '<span class="status"></span></span></div>');
                        }
                        if ($('#selectedDox .userItem #' + v.uid).length > 0) {
                            divObj.addClass('active')
                        }
                    }
                    tr.push(divObj);
                });
                $('#deptBox .userItem').html(tr);
            }
        });
    };

    function TreeNode(id, text, state, children) {
        this.id = id;
        this.text = text;
        this.state = state;
        this.children = children;
    };

    function convert(data) {

        var arr = [];
        var tr = '';
        data.forEach(function (v, i) {
            if (v.deptId) {
                var node = new TreeNode(v.deptId, v.deptName, "closed")
                arr.push(node);
            } else if (v.userId) {
                if (v.sex == 0) {
                    tr += '<div class="block-right-item" item_id="' + v.uid + '" item_name="' + v.userName + '" id="' + v.uid + '" user_id="' + v.userId + '" uid="' + v.uid + '" title="' + v.userName + '"><span class="name">' + v.userName + ' ' + v.userPrivName + '<span class="status"> </span></span></div>';
                } else if (v.sex == 1) {
                    tr += '<div class="block-right-item" item_id="' + v.uid + '" item_name="' + v.userName + '"  id="' + v.uid + '"  user_id="' + v.userId + '" uid="' + v.uid + '" title="' + v.userName + '"><span class="name">' + v.userName + ' ' + v.userPrivName + '<span class="status"></span></span></div>';
                }
            }
        });
        $('#deptBox .userItem').html(tr);
        return arr;
    };
//list[i].userPrivName
    function buildItemList(target, list, defaultdate,type) {
        if (list && list.length > 0) {
            var str = [];
            var display = '';
            if(topdefault == 1||topdefault == 2){
                display = 'display: none;'
            }
            if (defaultdate) {
                for (var i = 0; i < list.length; i++) {
                    var className = 'block-right-item';//active
                    var checked = 'layui-unselect layui-form-checkbox';//layui-form-checked
                    if(list[i].userId.indexOf(' ') > -1){
                        /*****************处理userid带有 的用户*******************************/
                        list[i].userId = list[i].userId.replace(new RegExp(" ", "gm"), "空格kg");
                        /******************结束***************************/
                    }
                    if (selectedList[list[i].userId]) {
                        className += ' active';
                    }
                    if (selectedList['main'] == list[i].userId) {
                        checked += ' layui-form-checked';
                    }
                    if(!list[i].deptName||list[i].deptName == ''){
                        str.push($('<div class="' + className + ' ' + list[i].uid + '" szm_name="' + makePy(list[i].userName) + '" item_id="' + list[i].uid + '" item_name="' + list[i].userName + '" id="" ' +
                            'user_id="' + list[i].userId + '" uid="' + list[i].uid + '" deptName="" userPrivName="" title="' + list[i].userName + '">' +
                            '<div class="' + checked + '" lay-skin="" style="'+ display +';display: '+ isDisplay +'"><span uid="' + list[i].uid + '"  user_id="' + list[i].userId + '" ' +
                            'userName="' + list[i].userName + '">主办</span><i class="layui-icon"></i></div><span class="name">' + list[i].userName + ' ' + list[i].userPrivName +function () {
                                //增加显示辅助角色
                                if(list[i].userPrivOtherName==undefined || list[i].userPrivOtherName==''){
                                    return ''
                                }else{
                                    return '('+list[i].userPrivOtherName +')'
                                }
                            }()+ '<span class="status"> </span></span></div>'));
                    }else{
                        str.push($('<div class="' + className + ' ' + list[i].uid + '" szm_name="' + makePy(list[i].userName) + '" item_id="' + list[i].uid + '" item_name="' + list[i].userName + '" id="" ' +
                            'user_id="' + list[i].userId + '" uid="' + list[i].uid + '" deptName="' + list[i].deptName + '" userPrivName="' + list[i].userPrivName + '" title="' + list[i].userName + '">' +
                            '<div class="' + checked + '" lay-skin="" style="'+ display +';display: '+ isDisplay +'"><span uid="' + list[i].uid + '"  user_id="' + list[i].userId + '" ' +
                            'userName="' + list[i].userName + '">主办</span><i class="layui-icon"></i></div><span class="name" title='+(list[i].userPrivOtherName || "")+'>' +
                            '[' + list[i].deptName + '] ' + '&nbsp;&nbsp;<span class="username">' + list[i].userName + '</span>&nbsp;&nbsp;' + ' ' + list[i].userPrivName +function () {
                                //增加显示辅助角色
                                if(list[i].userPrivOtherName==undefined || list[i].userPrivOtherName==''){
                                    return ''
                                }else{
                                    var userPrivOtherName = list[i].userPrivOtherName.split(',')[0];
                                    return '('+userPrivOtherName +')'
                                }
                            }()+ '<span class="status"> </span></span></div>'));

                    }
                }
            }else {
                for (var i = 0; i < list.length; i++) {
                    if(list[i].userId.indexOf(' ') > -1){
                        /*****************处理userid带有 的用户*******************************/
                        list[i].userId = list[i].userId.replace(new RegExp(" ", "gm"), "空格kg");
                        /******************结束***************************/
                    }
                    str.push($('<div class="block-right-item ' + list[i].uid + '" szm_name="' + makePy(list[i].userName) + '" ' +
                        'item_id="' + list[i].uid + '" item_name="' + list[i].userName + '" id="' + list[i].uid + '" ' +
                        'user_id="' + list[i].userId + '" uid="' + list[i].uid + '" title="' + list[i].userName + '">' +
                        '<div class="layui-unselect layui-form-checkbox" lay-skin="" style="'+ display +';display: '+ isDisplay +'">' +
                        '<span uid="' + list[i].uid + '"  user_id="' + list[i].userId + '" userName="' + list[i].userName + '">主办</span>' +
                        '<i class="layui-icon"></i></div>' +
                        '<span class="name">' + list[i].userName + ' ' + list[i].userPrivName +function () {
                            //增加显示辅助角色
                            if(list[i].userPrivOtherName==undefined || list[i].userPrivOtherName==''){
                                return ''
                            }else{
                                return '('+list[i].userPrivOtherName +')'
                            }
                        }()+ '<span class="status"> ' +
                        '</span></span></div>'));
                }
            }
            if(type == 1){
                target.html(str)
            }else if(type == 2){
                target.append(str)
            }
        }else{
            $("#all_item_2 .allItem").html('<div style="widt' +
                'h: 230px;height: 200px;margin: 20px auto;text-align: center" class="emptyDivBox"><img src="/img/common/dianjikong.png" style="margin-top: 20px;" alt="">                            <span style="width: 100%;display: inline-block;margin-top: 10px;                        font-size: 15px;                        font-weight: bold;">暂无人员</span></div>')

        }
    };
    var customInforObj;
    function customInfor(type,$Element){
        var search = $('#keyword').val();
        $.ajax({
            type: "post",
            url: "/WFSelectUser/getWFUserGroup",
            data:{
                flowId:flowId,
                flowPrcs:flowPrcs,
                type:type,
                deptNo:deptNo,
                search:search,
                useFlag:false
            },
            dataType: 'JSON',
            success: function (res) {
                customInforObj = {};
                if(type == 1){
                    var str = '<div class="block-left-header">个人自定义组</div>';
                }else{
                    var str = '<div class="block-left-header">公共自定义组</div>';
                }
                if(res.flag){
                    for(var i=0;i<res.obj.userGroupList.length;i++){
                        var $this = res.obj.userGroupList[i];
                        customInforObj[$this.groupId] =$this.usersList;
                        str += '<div class="block-left-item" block="custom" groupid="'+ $this.groupId +'" title="'+ $this.groupName +'"><span>'+ $this.groupName +'</span></div>';
                    }
                }
                $Element.find('.leftGroup').html(str);
                $Element.find('.userItem').html('');
                $Element.find('.leftGroup .block-left-item').eq(0).click();
            }
        });
    }



    $(function () {
        $('#keyword').on('keyup', function() {
            var $this = $('#keyword');
            var text = $this.val();
            if(text == ''){
                $('#all_item_2 .allItem .block-right-item').show();
            }
        });
        //搜索
        $('.searchspan').click(function () {
            searchNum = true;
            var $this = $('#keyword');
            var text = $this.val();
            var index = 0;
            if($('#navMenu a.active').attr('block') == 'allSelect'){
                $('#all_item_search').show().siblings().hide();
                index = 1;
            }else if($('#navMenu a.active').attr('block') == 'byDept'){
                $('#byDept_item_2').show().siblings().hide();
                index = 2;
            }else if($('#navMenu a.active').attr('block') == 'byPriv'){
                $('#byPriv_item_2').show().siblings().hide();
                index = 3;
            }
            if (text != '') {
                var indexs = layer.load();
//                autodivheights(text,indexs);
                var datas = {
                    flowId: flowId,
                    flowPrcs: flowPrcs,
                    deptNo: deptNo,
                    deptId:'',
                    search: text,
                    userPriv: '',
                    useFlag: false
                }
                if(parentObject.sanyuanOpen){
                    var contentSecrecy = parentObject.getContentSecrecy();
                    datas['contentSecrecy'] = contentSecrecy;
                }
                $.ajax({
                    url:'/workflow/work/getWorkFlowUser',
                    data: datas,
                    dataType:'json',
                    type:'post',
                    success:function(json){
                        var prcsUserlistNew = json.obj;
                        buildItemList($("#allSelect .searchItem"), prcsUserlistNew, true,1);
                        layer.close(indexs);
                    }
                })
            }else{
                if(index == 1){
                    $('#all_item_2').show().siblings().hide();
                }else if(index == 2){
                    $('#byDept_item_2 .byDeptItem .block-right-item').show();
                }else if(index == 3){
                    $('#byPriv_item_2 .byPrivItem .block-right-item').show();
                }
            }
        });
        //输入内容后就搜索
        $("#keyword").on("keyup",function() {
            $('.searchspan').click();
        })
        if(secretType != 1){
            selectedList['main'] = UserItemMain.split(',')[0];

            UserItem.split(',').forEach(function(v,i){
                if(v != ''){
                    selectedList[UserItem.split(',')[i]] = true;
                }
            })
        }else{
            selectedList['main'] = UserItem.split(',')[0];
            UserItem.split(',').forEach(function(v,i){
                if(v != ''){
                    selectedList[UserItem.split(',')[i]] = true;
                }
            })
        }



        buildItemList($('#dept_item .userItem'), UserItemarr, true,1);
        buildItemList($("#allSelect .allItem"), prcsUserlist, true,1);
        $('#north').show().siblings('.layui-form-item').show().siblings('#south').show();
        layer.close(loadFirst);

        if(paraValue == 1){
            var url = '/getUserOrg'
        }else{
            var url = '/department/getChDeptfq?deptId=0'
        }

        $('#byDept #byDeptOrg').tree({
            url: url,
            animate: true,
            loadFilter: function (node) {
                var arr = convert(node.obj);
                return arr;
            },
            onClick: function (node) {
                var indexload = layer.load();
//                    build(node.id);
                var strs = [];
                strs.push($('<div onclick="addPrivAndDept($(this))" class="block-right-add">全部添加</div><div onclick="removePrivAndDept($(this))" class="block-right-remove">全部删除</div>'))
                var list = '';
                var datas = {
                    flowId: flowId,
                    flowPrcs: flowPrcs,
                    deptNo: deptNo,
                    deptId: node.id,
                    search: '',
                    userPriv: '',
                    useFlag: false
                }
                if(parentObject.sanyuanOpen){
                    var contentSecrecy = parentObject.getContentSecrecy();
                    datas['contentSecrecy'] = contentSecrecy;
                }
                $.ajax({
                    url:'/workflow/work/getWorkFlowUser',
                    data: datas,
                    async:false,
                    dataType:'json',
                    type:'post',
                    success:function(json){
                        list = json.obj;
                    }
                })
                var nums = 0;
                var display = '';
                if(topdefault == 1||topdefault == 2){
                    display = 'display: none;'
                }
                for (var i = 0; i < list.length; i++) {
                    var active = '';
                    var checked = '';
                    strs.push($('<div class="block-right-item ' + list[i].uid + '"  szm_name="' + makePy(list[i].userName) + '"' +
                        'item_id="' + list[i].uid + '" item_name="' + list[i].userName + '"  ' +
                        'user_id="' + list[i].userId + '" uid="' + list[i].uid + '" deptName="' + list[i].deptName + '" userPrivName="' + list[i].userPrivName + '" title="' + list[i].userName + '">' +
                        '<div class="layui-unselect layui-form-checkbox" lay-skin="" style="'+ display +';display: '+ isDisplay +'">' +
                        '<span uid="' + list[i].uid + '"  user_id="' + list[i].userId + '" userName="' + list[i].userName + '">主办</span>' +
                        '<i class="layui-icon"></i></div>' +
                        '<span class="name">'+ '['  + list[i].deptName + '] ' + '&nbsp;&nbsp;<span class="username">' + list[i].userName + '</span>&nbsp;&nbsp;' + ' ' + list[i].userPrivName +function () {
                            //增加显示辅助角色
                            if(list[i].userPrivOtherName==undefined || list[i].userPrivOtherName==''){
                                return ''
                            }else{
                                return '('+list[i].userPrivOtherName +')'
                            }
                        }()+ '<span class="status"> ' +
                        '</span></span></div>'));
                    nums++;
                }
                if (nums == 0) {
                    $("#byDept .byDeptItem").html('<div style="width: 230px;height: 200px;margin: 20px auto;text-align: center" class="emptyDivBox"><img src="/img/common/dianjikong.png" style="margin-top: 20px;" alt="">                            <span style="width: 100%;display: inline-block;margin-top: 10px;                        font-size: 15px;                        font-weight: bold;">本部门暂无人员</span></div>')
                } else {
                    $("#byDept .byDeptItem").html(strs)
                }
                layer.close(indexload);
                mapping($('#byDeptitem .byDeptItem'));
            },
            onBeforeExpand: function (node, param) {
                $('#byDept #byDeptOrg').tree('options').url = "../department/getChDeptfq?deptId=" + node.id;// change the url
            }
        });

        $('#all_item').scroll(function () {
            if($('#keyword').val() != ''&&searchNum){

            }else{
                var wholeHeight=$(this)[0].scrollHeight;
                var scrollTop=$(this)[0].scrollTop;
                var divHeight=$(this)[0].clientHeight;
                var iNows=Math.ceil(pageTotao/pageSize);

                var liLIst=$('.signDiv').find('li');

                if(divHeight+scrollTop>=wholeHeight){
                    if(iNows > page){
                        page++;
                        var datas = {
                            flowId: flowId,
                            flowPrcs: flowPrcs,
                            deptNo: deptNo,
                            deptId: '',
                            userPriv: '',
                            search: '',
                            page: page,
                            pageSize: pageSize,
                            useFlag: true
                        }
                        if(parentObject.sanyuanOpen){
                            var contentSecrecy = parentObject.getContentSecrecy();
                            datas['contentSecrecy'] = contentSecrecy;
                        }
                        $.ajax({
                            url:'/workflow/work/getWorkFlowUser',
                            data: datas,
                            dataType:'json',
                            type:'post',
                            async:false,
                            success:function(json){
                                buildItemList($("#allSelect .allItem"), json.obj, true,2);
                                prcsUserlist = prcsUserlist.concat(json.obj);
                            }
                        });
                    }else{
//                        alert('该流程暂无更多经办人!');
                    }
                }
            }

        });

        $('#byPriv_menu #byPrivOrg').delegate('li', 'click', function () {
            $(this).siblings('li').removeClass('actives');
            $(this).addClass('actives');
            var me = this;
            var userPriv = $(me).attr('userPriv');
            var list = '';
            var datas = {
                flowId: flowId,
                flowPrcs: flowPrcs,
                deptNo: deptNo,
                deptId: '',
                search: '',
                userPriv: userPriv,
                useFlag: false
            }
            if(parentObject.sanyuanOpen){
                var contentSecrecy = parentObject.getContentSecrecy();
                datas['contentSecrecy'] = contentSecrecy;
            }
            $.ajax({
                url:'/workflow/work/getWorkFlowUser',
                data: datas,
                dataType:'json',
                type:'post',
                async:false,
                success:function(json){
                    list = json.obj;
                }
            })
            var strarr = [];
            strarr.push($('<div onclick="addPrivAndDept($(this))" class="block-right-add">全部添加</div><div onclick="removePrivAndDept($(this))" class="block-right-remove">全部删除</div>'))
            var display = '';
            if(topdefault == 1||topdefault == 2){
                display = 'display: none;';
            }
            for (var i = 0; i < list.length; i++) {
                strarr.push($('<div class="block-right-item ' + list[i].uid + '"  szm_name="' + makePy(list[i].userName) + '" ' +
                    'item_id="' + list[i].uid + '" item_name="' + list[i].userName + '"  ' +
                    'user_id="' + list[i].userId + '" uid="' + list[i].uid + '" deptName="' + list[i].deptName + '" userPrivName="' + list[i].userPrivName + '" title="' + list[i].userName + '">' +
                    '<div class="layui-unselect layui-form-checkbox" lay-skin="" style="'+ display +';display: '+ isDisplay +'">' +
                    '<span uid="' + list[i].uid + '"  user_id="' + list[i].userId + '" userName="' + list[i].userName + '">主办</span>' +
                    '<i class="layui-icon"></i></div>' +
                    '<span class="name">' + '['  + list[i].deptName + '] ' + '&nbsp;&nbsp;<span class="username">' + list[i].userName + '</span>&nbsp;&nbsp;' + ' ' + list[i].userPrivName +function(){
                        if(list[i].userPrivName != $(me).text()){
                            return ' (辅助角色) '
                        }else{
                            return ' ';
                        }
                    }()+ '<span class="status"> ' +
                    '</span></span></div>'));
            }
            $("#byPriv .byPrivItem").html(strarr)
            mapping($("#byPriv .byPrivItem"));
        });

        $('#allcustom .leftGroup').delegate('.block-left-item', 'click', function () {
            $(this).addClass('privActive').siblings().removeClass('privActive');
            $('#custom-right-header').html($(this).attr('title'));
            if(customInforObj[$(this).attr('groupid')]){
                buildItemList($('#custom_item_2 .userItem'), customInforObj[$(this).attr('groupid')], true,1);
                mapping($('#custom_item_2 .userItem'));
            }else{
                $('#custom_item_2 .userItem').html('');
            }
        });
        $('#allGroup .leftGroup').delegate('.block-left-item', 'click', function () {
            $(this).addClass('privActive').siblings().removeClass('privActive');
            $('#group_item_2 .block-right-header').html($(this).attr('title'));
            if(customInforObj[$(this).attr('groupid')]){
                buildItemList($('#group_item_2 .userItem'), customInforObj[$(this).attr('groupid')], true,1);
                mapping($('#group_item_2 .userItem'));
            }else{
                $('#group_item_2 .userItem').html('');
            }
        });
        $('.layui-form-item').on('click', '.block-right-item', function (e) {
            var that = $(this);
            var user_id = that.attr('user_id');
            if (!($(e.target).parent().attr('class').indexOf('layui-form-checkbox') > 0)) {
                if (that.attr('class').indexOf('active') > -1) {
                    that.removeClass("active");
                    $('#dept_item_2 .block-right-item[user_id='+ user_id +']').remove();
                    $('#all_item_2 .block-right-item[user_id='+ user_id +']').removeClass("active");
                    selectedList[user_id] = false;
                    if (selectedList['main'] == user_id){
                        $(e.target).siblings().removeClass('layui-form-checked');
                        $('#all_item_2 .block-right-item[user_id='+ user_id +']').find('.layui-form-checkbox').removeClass('layui-form-checked');
                        selectedList['main'] = '';
                    }
                } else {
                    that.addClass("active");
                    $('#all_item_2 .block-right-item[user_id='+ user_id +']').addClass("active");
                    if($('#dept_item_2 .block-right-item[user_id='+ user_id +']').length == 0){
                        var str = that.prop("outerHTML");
                        $('#dept_item_2 .userItem').append(str);
                    }
                    selectedList[user_id] = true;
                    if ($('#dept_item_2 .userItem').find('.layui-form-checked').length == 0) {
                        $(e.target).siblings().addClass('layui-form-checked');
                        $('#all_item_2 .block-right-item[user_id='+ user_id +']').find('.layui-form-checkbox').addClass('layui-form-checked');
                        $('#dept_item_2 .block-right-item[user_id='+ user_id +']').find('.layui-form-checkbox').addClass('layui-form-checked');
                        selectedList['main'] = $(e.target).siblings().find('span').attr('user_id');
                    }
                }

            } else {
                if ($(e.target).parent().attr('class').indexOf('layui-form-checked') == -1) {
                    $('.aitem').find('.layui-form-checkbox').removeClass('layui-form-checked');
                    selectedList.main = user_id;
                    selectedList[user_id] = true;
                    $(e.target).parent().addClass('layui-form-checked');
                    $(e.target).parent().parent().addClass("active");
                    $('#all_item_2 .block-right-item[user_id='+ user_id +']').addClass("active").find('.layui-form-checkbox').addClass('layui-form-checked');
                    if($('#dept_item_2 .block-right-item[user_id='+ user_id +']').find('.layui-form-checkbox').length == 0){
                        var str = $(e.target).parents('.block-right-item').prop("outerHTML");
                        $('#dept_item_2 .userItem').append(str);
                    }else{
                        $('#dept_item_2 .block-right-item[user_id='+ user_id +']').find('.layui-form-checkbox').addClass('layui-form-checked');
                    }
                }
            }
        });
        //组织
        $('.tab_btn').click(function () {
            var type = $(this).attr('block');
            $(this).addClass("active").siblings().removeClass('active');
            switch (type) {
                case "selected":
                    $('#navRight').hide();
                    $('#selectedDox').show().siblings().hide();
                    break;
                case "allSelect":
                    mapping($('#all_item .allItem'));
                    $('#navRight').show();
                    $('#allSelect').show().siblings().hide();
                    break;
                case "byFlow":
                    $('#byFlow').show().siblings().hide();
                    break;
                case "byDept":
                    $('#navRight').hide();
                    if($('#byDeptOrg .tree-node-selected').length != 0){
                        $('#byDeptOrg .tree-node-selected').click();
                    }else{
                        $('#byDeptOrg').find('.tree-node').eq(0).click();
                    }
                    $('#byDept').show().siblings().hide();
                    break;
                case "byPriv":
                    $('#navRight').hide();
                    if($('#byPrivOrg .actives').length != 0){
                        $('#byPrivOrg .actives').click();
                    }else{
                        $('#byPrivOrg').find('.byPrivOrgStrsli').eq(0).click();
                    }
                    $('#byPriv').show().siblings().hide();
                    break;
                case "group":
                    $('#navRight').hide();
                    $('#groupDox').show().siblings().hide();
                    customInfor(2,$('#groupDox'));
                    break;
                case "custom":
                    $('#navRight').hide();
                    $('#customDox').show().siblings().hide();
                    customInfor(1,$('#customDox'));
                    break;
            }
        });
        //全部经办人 全部选中
        $('#allSelect ').on('click', '#block-right-add', function () {
            $(this).parent().find('.block-right-item').each(function (i, v) {
                if(!$(v).hasClass('active')){
                    $(v).find('.name').click();
                }
            });
        });
        //全部经办人 全部删除
        $('#allSelect ').on('click', '#block-right-remove', function () {
            $(this).parent().find('.block-right-item').each(function (i, v) {
                if($(v).hasClass('active')){
                    $(v).find('.name').click();
                }
            });
        });

        $('.tree .dynatree-container').on('click', '.childdept', function () {
            var that = $(this);
            getChDept(that.next(), that.attr('deptid'));
            var title = that.find('a').text();
            $('.block-right-header').html(title);
        });

        $('.block-right').on('mouseover', 'div', function () {
            if(!$(this).hasClass('emptyDivBox')&&!$(this).hasClass('byDeptItem')){
                $(this).addClass('hover');
            }
        });

        $('.block-right').on('mouseout', 'div', function () {
            if(!$(this).hasClass('emptyDivBox')&&!$(this).hasClass('byDeptItem')){
                $(this).removeClass('hover');
            }
        });
    });
</script>
</html>
