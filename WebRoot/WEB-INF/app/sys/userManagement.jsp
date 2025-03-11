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
    <meta charset="UTF-8">
    <title><fmt:message code="main.usermanage" /></title>
    <meta name="renderer" content="webkit">
    <meta name="renderer" content="ie-comp">
    <meta name="renderer" content="ie-stand">
    <meta http-equiv="X-UA-Compatible" content="IE=EmulateIE7; IE=EmulateIE9">
    <meta name="renderer" content="webkit|ie-comp|ie-stand">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=0, minimum-scale=1.0, maximum-scale=1.0">
    <link rel="stylesheet" type="text/css" href="../css/sys/userManagement.css"/>
    <link rel="stylesheet" type="text/css" href="../css/base.css?20210827"/>

    <link rel="stylesheet" href="/lib/layui/layui/css/layui.css">
    <script type="text/javascript" src="/lib/layui/layui.js"></script>
    <script type="text/javascript" src="/js/xoajq/xoajq3.js"></script>
    <script src="/js/jquery/jquery-migrate-3.4.0.js"></script>
    <%--<script type="text/javascript" src="/lib/layui/layui.all.js"></script>--%>
    <script type="text/javascript" src="/lib/layui/layui/layui.all.js"></script>

    <script type="text/javascript" src="/lib/layer/layer.js?20210631"></script>
    <script src="/js/base/base.js" type="text/javascript" charset="utf-8"></script>
    <script  type="text/javascript" src="/js/wechatQy/wechatBase.js"></script>
    <style>
        .bottom .boto div {
            cursor: pointer;
            color: #2B7FE0;
            font-size: 14px;
            display: block;
            border: #ccc 1px solid;
            padding: 2px 4px;
            border-radius: 3px;
            margin-top: 0;
            margin-left: 0;
        }
        .boto a{

        }
        .colorRed td{
            color: red!important;
        }
        .colorddd td{
            color: #999!important;
        }
        .content .left .collect .liUp:first-of-type{
            border-top:none!important;
        }
        #btn{
            line-height: 28px;
        }
        table  tr td{
            /*text-align: center;*/
        }
        #btn {
            line-height: 28px;
            float: right;
            margin-right: 12px;
            margin-top:4px;
            margin-left:0px;
            border:none;
            top: 46px;
        }
        body{
            background-color: #f5f7f8;
        }
        .content .left{
            width: 350px!important;
        }
        .content .rightMain, .content .right{
            width: calc(100% - 351px)!important;
        }
        #downChild .dpetWhole0 .childdept{
            padding-left: 60px!important;
        }
        #downChild .dpetWhole0 ul .childdept{
            padding-left: 80px!important;
        }
        #downChild .dpetWhole0 ul ul li .childdept{
            padding-left: 95px!important;
        }
        .tab table{
            white-space: nowrap;
            word-break: keep-all;
        }
        .content .headDiv{
            background-color: #f5f7f8;
        }

        /*.pickCompany{*/
            /*margin-bottom: 30px;*/
        /*}*/

        /*td{*/
        /*    font-size: 11pt;*/
        /*}*/
        .liUp{
            color:#000;
        }
        .content .right{
            overflow-y: inherit;
        }
        #downChild li{
            /*width: 1000px;*/
        }
        .content .left .collect .divUP{
            overflow: auto;
        }
        .childdept{
            min-height: 36px;
            height: auto;
            line-height: 36px;
        }
        #downChild li>span{
            font-size: 14px;
            white-space: nowrap
        }
        .content .left .collect .spanUP{
            color: #000;
            font-size: 14px;
        }
        #downChild li>span{
            font-size: 14px;
        }

        .content .left .collect{
            height: 900px!important;
        }
        .pickCompany a{
            font-size: 14px;
        }
        .pickCompany .childdept img{
            margin-left: 0px!important;
        }
        .liUp{
            background: url(../../img/sys/icon_rightarrow_03.png) no-repeat 85% center;
        }
        .liDown{
            background: url(../../img/sys/icon_downarrow_03.png) no-repeat 85% center;
        }
        ::-webkit-scrollbar{
            width: 5px;
        }
        .w{
            height: 40px;
        }
        .layui-btn{
            margin-left: 10px;
            margin-top: -11px;
            height: 20px;
            line-height: 20px;
        }
    </style>
    <link rel="stylesheet" type="text/css" href="/css/commonTheme/${sessionScope.InterfaceModel}/commonTheme.css"/>
    <script src="../js/xoajq/xoajq1.js" type="text/javascript" charset="utf-8"></script>
    <script src="/lib/layer/layer.js?20201106"></script>
    <script src="/lib/laydate/laydate.js"></script>
    <script src="/lib/layer/layer.js?20201106"></script>
    <link rel="stylesheet" href="/lib/layer/skin/default/layer.css">
    <link rel="stylesheet" type="text/css" href="../lib/pagination/style/pagination.css"/>
    <link rel="stylesheet" href="/lib/laydate/need/laydate.css">
    <script src="../js/base/base.js?20200119.1" type="text/javascript" charset="utf-8"></script>

    <style>
        .dept_order_box th{
            padding: 10px;
            font-size: 11pt;
        }
        .dept_order_box td {
            padding: 5px;
        }
        .dept_order_box table input {
            width: 40px;
            height: 20px;
        }
        .dept_order_box table select {
            height: 20px;
            padding: 2px;
            box-sizing: content-box;
        }
        .syn_user{
            width: 90px;
            font-size: 13px;
            background-color: #2f80d1;
            height: 30px;
            line-height: 30px;
            color: white;
            border-radius: 5px;
        }
        #deptOrderTable tr td{
            text-align: center;
        }
    </style>
</head>
<body>
<div class="content clearfix">
    <input type="hidden" name="hiddenDept">
    <div class="headDiv">
        <div class="div_Img">
            <img src="/img/commonTheme/${sessionScope.InterfaceModel}/icon_userManagement1.png" style="vertical-align: middle;" alt="<fmt:message code="userManagement.th.UserManagement" />">
        </div>
        <div class="divP"><fmt:message code="main.usermanage" />-<fmt:message code="userManagement.th.ManagementScope" /><span class="innerText"></span></div>
        <div style="float: right;margin-top: 10px;margin-right: 20px;">
            <button style='cursor:pointer;' class="syn_user" onclick="synUser()" ><fmt:message code="userManagement.th.syncUsers" /></button>
        </div>
    </div>
    <div class="left" style="background: #f5f7f8;">
        <div class="collect">
            <div id="incum" class="divUP">
                <span class="spanUP liDown AUP">
                    <img src="/img/commonTheme/${sessionScope.InterfaceModel}/icon_inservicsPersonnel.png" style="vertical-align: middle;width: 15px;margin-right: 10px;" alt="在职人员"><fmt:message code="userManagement.th.In-servicePersonnel" />
                    <a href="javascript:void(0)" onclick="location.reload()" style="color: #207BD6;margin-left: 20px;cursor: pointer;font-size: 11px;"><img src="/img/commonTheme/theme6/icon_shuaxin_03.png" style="margin-right: 8px;margin-bottom: 1px;"><fmt:message code="global.lang.refresh" /></a>
                </span>
                <div id="downChild">
                    <div class="pickCompany"><div style="padding-left: 16px;" class="childdept"><img src="/img/commonTheme/${sessionScope.InterfaceModel}/icon_company.png" alt="" style="vertical-align: middle;width: 15px;margin-right: 10px;margin-left: 13px;margin-bottom: 4px;"><a href="javascript:void(0)" class="dynatree-title" title=""></a></div></div>
                </div>
            </div>
            <%--未分配部门人员--%>
            <div style="height: 350px">
            <div id="noDept"><span class="spanUP liUp noDept"  deptid="0"><img src="/img/commonTheme/${sessionScope.InterfaceModel}/icon_demission.png" style="vertical-align: middle;width: 15px;margin-right: 10px;" alt="未分配部门人员"><fmt:message code="userManagement.th.Unallocated" /></span></div>
            <div id="employee"><span class="spanUP liUp employee"  deptid="0"><img src="/img/commonTheme/${sessionScope.InterfaceModel}/icon_demission.png" style="vertical-align: middle;width: 15px;margin-right: 10px;" alt="离职人员/外部人员"><fmt:message code="userManagement.th.Outgoing" /></span></div>
            <div id="newUsers"><span class="spanUP liUp newUsers"><img src="/img/commonTheme/${sessionScope.InterfaceModel}/icon_newUser.png" style="vertical-align: middle;width: 15px;margin-right: 10px;" alt="最近新增用户"><fmt:message code="userManagement.th.RecentlyAdded" /></span></div>
            <div id="queryExport"><span class="spanUP liUp queryExport"><img src="/img/commonTheme/${sessionScope.InterfaceModel}/icon_userQuery.png" style="vertical-align: middle;width: 15px;margin-right: 10px;" alt="用户查询或导出"><fmt:message code="userManagement.th.UserQuery" /></span></div>
            <div id="import"><span class="spanUP liUp import"><img src="/img/commonTheme/${sessionScope.InterfaceModel}/icon_userImport.png" style="vertical-align: middle;width: 15px;margin-right: 10px;" alt="用户导入"><fmt:message code="userManagement.th.Userimport" /></span></div>
            <div id="editUserBatch"><span class="spanUP liUp editUserBatch"><img src="/img/commonTheme/${sessionScope.InterfaceModel}/icon_batchUserSettings.png" style="vertical-align: middle;width: 15px;margin-right: 10px;" alt="批量用户个性设置"><fmt:message code="userManagement.th.Batch" /></span></div>
<%--            <div id="passwordCard"><span class="spanUP liUp passwordCard"><img src="/img/commonTheme/${sessionScope.InterfaceModel}/icon_batchUserSettings.png" style="vertical-align: middle;width: 15px;margin-right: 10px;" alt="动态密码卡管理">动态密码卡管理</span></div>--%>
            <%--<div><span class="spanUP liUp proceed"><img src="../img/sys/icon_remindEmptyPassword.png" style="vertical-align: middle;width: 15px;margin-right: 10px;" alt="提醒空密码用户"><fmt:message code="userManagement.th.Reminding" /></span></div>--%>
            <%--<div><span class="spanUP liUp proceed"><img src="../img/sys/icon_exportRtxFormat.png" style="vertical-align: middle;width: 15px;margin-right: 10px;" alt="导出RTX格式"><fmt:message code="userManagement.th.ExportRTXformat" /></span></div>--%>
            <%--<div><span class="spanUP liUp proceed"><img src="../img/sys/icon_signOut.png" style="vertical-align: middle;width: 15px;margin-right: 10px;" alt="退出用户客户端登录"><fmt:message code="userManagement.th.Exitlogin" /></span></div>--%>

            </div></div>
    </div>
    <div class="right">
        <div class="header">
            <img src="/img/commonTheme/theme6/batchSetDept.png" style="margin-left: 11px;"/>
            <span class="USER" style="font-size: 20px;font-weight: 700;"><fmt:message code="userInfor.th.UserQuery" /></span><span class="post newDept"></span>
            <%--<select  name="" id="noDept" style="float: right;margin-top: 7px;margin-right: 24%;display: none">
                <option value=""><fmt:message code="userManagement.th.AllUser" /></option>
                <option value="0"><fmt:message code="userManagement.th.AllowIogonUser" /></option>
                <option value="1"><fmt:message code="userManagement.th.NoIogonUser" /></option>
            </select>--%>
            <input type="button" class="new_liucheng" name="btn" id="reload" style="right: 150px;top: 50px;height: 33px;line-height: 28px;" value="<fmt:message code="global.lang.refresh" />">
            <input type="button" class="new_liucheng" name="btn" id="btn" value="<fmt:message code="userManagement.th.NewUser" />" /><span class="newroletwo"><input type="hidden"></span>
            <%--<span style="margin-left: 10px;">共有<span style="color: #ff0000;margin: 0 5px;" class="totalNum"></span>条记录</span>--%>
        </div>
        <div class="title">
            <span class="USER"><fmt:message code="main.usermanage" /></span><span class="post currentDept"></span>
            <select name="allUser" id="allSelUser">
                <option value=""><fmt:message code="userManagement.th.AllUser" /></option>
                <option value="0"><fmt:message code="userManagement.th.AllowIogonUser" /></option>
                <option value="1"><fmt:message code="userManagement.th.NoIogonUser" /></option>
            </select>
            <span class="explain"><fmt:message code="userManagement.th.Explanation" /></span>
        </div>
        <div class="tab">
            <table cellspacing="0" cellpadding="0" style="border-collapse:collapse;">
                <tr class='tr_befor'>
                    <th width="4%">

                    </th>
                    <th width="7%"><fmt:message code="userManagement.th.userId" /></th>
                    <th width="7%"><fmt:message code="userName" /></th>
                    <th width="7%"><fmt:message code="userManagement.th.Realname" /></th>
                    <th width="7%"><fmt:message code="userManagement.th.department" /></th>
<%--                    <th width="7%">考勤类型</th>--%>
                    <th width="14%"><fmt:message code="userManagement.th.role" /></th>
                    <th width="7%"><fmt:message code="userManagement.th.ManagementScope" /></th>
                    <th width="18%"><fmt:message code="userManagement.th.LastAccess" /></th>
                    <th width="7%"><fmt:message code="userManagement.th.idle" /></th>
                    <th width="15%"><fmt:message code="notice.th.operation" /></th>
                </tr>

            </table>
        </div>
        <div class="bottom w clearfix">
            <div class="checkALL">
                <input id="checkedAll" type="checkbox" name="" value="" onclick="getclass()">
                <label for="checkedAll" style="font-size: 14px;"><fmt:message code="notice.th.allchose" /></label>
            </div>
            <div class="boto">
                <div class="ONE" href="javascript:void(0)"><span><fmt:message code="global.lang.delete" /></span></div>
            </div>
            <div class="boto">
                <div class="TWO" href="javascript:void(0)"><span><fmt:message code="userManagement.th.Emptylong" /></span></div>
            </div>
            <div class="boto">
                <div class="THREE" href="javascript:void(0)"><span><fmt:message code="userManagement.th.BatchPasswordModification" /></span></div>
            </div>
            <div class="boto">
                <div class="FOUR" href="javascript:void(0)"><span><fmt:message code="userManangement.th.Nologin" /></span></div>
            </div>
            <div class="boto">
                <div class="SEVEN" href="javascript:void(0)"><span><fmt:message code="userManagement.th.AllowLogin" /></span></div>
            </div>
            <%--<div class="boto">
                <div class="FIVE" href="javascript:void(0)"><span><fmt:message code="userManagement.th.Remind" /></span></a>
            </div>--%>
            <div class="boto">
                <div class="SIX" href="javascript:void(0)"><span><fmt:message code="userManagement.th.BatchExchangeDepartment" /></span></div>
            </div>
            <div class="boto">
                <div class="Seven"><span><fmt:message code="userManagement.th.ReturnDepartment" /></span></div>
            </div>
        </div>
    </div>
    <div class="rightMain clearfix" style="overflow: hidden">
        <iframe src="../user/goQueryExportUsers?type=0" frameborder="0">

        </iframe>
    </div>
</div>
<script src="../js/xoajq/xoajq1.js" type="text/javascript" charset="utf-8"></script>
<script src="../js/base/base.js" type="text/javascript" charset="utf-8"></script>
<script src="/js/jquery/jquery.cookie.js"></script>
<script type="text/javascript">
<%--    --%>
<%--判断是否开启三员管理 如果开启 隐藏说明--%>
    $.ajax({
        url:"/syspara/selectTheSysPara?paraName=IS_OPEN_SANYUAN",
        success:function(res) {
            var data = res.object[0];
            if(data.paraValue == 0){
                $(".explain").hide();
            }
        }
    })
    //判断是否开启分支机构
    var paraValues = "";
    $.ajax({
        url:"/syspara/queryOrgScope",
        dataType: 'json',
        success:function(res) {
            paraValues = res.object.paraValue;
        }
    })
    var uid = $.cookie("uid");
    $.ajax({
        url:"/modulePriv/getModulePrivSingle",
        data: {
            uid:uid,
            moduleId:11
        },
        success:function(res) {
            if( res.object && (res.object.deptPriv == "0" || res.object.deptPriv == "2" || res.object.deptPriv == "3" || res.object.deptPriv == "4")) {
                $('#noDept').hide();
                $('#employee').hide();
                $('#newUsers').hide();
                $('#import').hide();
                $('#editUserBatch').hide();
                $('#passwordCard').hide();
            }
            if(!res.object || !res.object.deptPriv) {
                $(".innerText").text("（<fmt:message code="url.th.all" />）")
                return
            }
            //deptPriv  人员范围（无-空字符串、本部门-0、全体-1、指定部门-2、指定人员-3、本人-4）
            if(res.object.deptPriv == "0") {
                $(".innerText").text("（<fmt:message code="sys.th.ThisDepartment" />）")
            }else if(res.object.deptPriv == "1") {
                $(".innerText").text("（<fmt:message code="url.th.all" />）")
            }
            else if(res.object.deptPriv == 2){
                $(".innerText").text("（<fmt:message code="sys.th.DesignatedDepartment" />）")
            }else if(res.object.deptPriv == 3) {
                $(".innerText").text("（<fmt:message code="sys.th.DesignatedPersonnel" />）")
            }else if(res.object.deptPriv == 4) {
                $(".innerText").text("（<fmt:message code="sys.th.self" />）")
            }

        }
    })
    var type = $.GetRequest().type;
    var priv_id;
    var dept_id;
    var data;
    var moduleId=11;
    $.get('/syspara/selectProjectId',function (res) {
        if (res.object == 'MINHANG_EDU') {
            $('.syn_user').css('display','inline-block')
        }else{
            $('.syn_user').css('display','none')
        }
    })
    //同步用户
    function synUser(){
        $.ajax({
            type: "post",
            url: "/mhsso/tbyh",
            dataType: 'json',
            success: function (res) {
                if(res.flag){
                    $.layerMsg({content: '同步成功', icon: 1})
                }else{
                    $.layerMsg({content: res.msg, icon: 2})
                }
            }
        })
    };
    layui.use(['form', 'layedit', 'laydate','table'], function() {
        var form = layui.form
            , table = layui.table
            , layer = layui.layer
            , layedit = layui.layedit
            , laydate = layui.laydate;
        form.render()
    })
    var uidArray = new Array();
    var a;
    var b=0;
    var dimission = 0;
    $('#reload').on("click",function(){
        var deptIdRun = $('.newroletwo').children('input').val();
        $('#allSelUser').val('')
        if(deptIdRun != ''){
            deptById({deptId:deptIdRun},$('.tr_befor'),function(){
                $.layerMsg({content: '刷新成功', icon: 1});
            });
            // $('.newroletwo').children('input').val('');
        }else {
            $('.newUsers').click();
        }
    });
    function autodivheight(){
        var winHeight=0;
        if (window.innerHeight)
            winHeight = window.innerHeight;
        else if ((document.body) && (document.body.clientHeight))
            winHeight = document.body.clientHeight;
        if (document.documentElement && document.documentElement.clientHeight)
            winHeight = document.documentElement.clientHeight;
        winWidth = document.documentElement.clientWidth;
        //document.getElementById("downChild").style.height= winHeight - 300 +"px";
        $('#downChild').css({'min-height':winHeight - 400 +"px"});

    }
    autodivheight();
    function turnUndefined(data){
        if(data==undefined){
            return ""
        }else{
            return data;
        }
    }
    $('.left').height($(document).height()-46)
    var userstr;
    var user_id;
    var numdept;
    var searchData ={};
    var USER_DEPT_ORDER = false;
    // 判断是否开启用户部门排序功能
    $.get('/department/order', function(res){
        if (res.flag) {
            USER_DEPT_ORDER = res.code == 1
        }
    });
    function deptById(data,element,fun){
        $('.tab').find('.userData').remove();
        $('.content .right').css("display","block");
        $('.content .rightMain').css("display","none");
        $.ajax({
            url:'../user/queryExportUsers?moduleId='+moduleId,
            type:'get',
            dataType:'json',
            data:data,
            success:function(rsp){
                var data1=rsp.obj;
                $('.totalNum').html(rsp.obj.length);
                var str='<tr class="tr_befor">\n' +
                    '                    <th width="4%">\n' +
                    '\n' +
                    '                    </th>\n' +
                    '                    <th width="7%"><fmt:message code="userManagement.th.userId" /></th>\n' +
                    '                    <th width="7%"><fmt:message code="userName" /></th>\n' +
                    '                    <th width="7%"><fmt:message code="userManagement.th.Realname" /></th>\n' +
                    '                    <th width="7%"><fmt:message code="userManagement.th.department" /></th>\n' +
                    // '                    <th width="7%">考勤类型</th>\n' +
                    '                    <th width="14%"><fmt:message code="userManagement.th.role" /></th>\n' +
                    // '                    <th width="8%"><fmt:message code="userManagement.th.ManagementScope" /></th>\n' +
                    '                    <th width="7%"><fmt:message code="userDetails.th.post" /></th>\n' +
                    '                    <th width="18%"><fmt:message code="userManagement.th.LastAccess" /></th>\n' +
                    '                    <th width="7%"><fmt:message code="userManagement.th.idle" /></th>\n' +
                    '                    <th width="15%"><fmt:message code="notice.th.operation" /></th>\n' +
                    '                </tr>';
                for(var i=0;i<data1.length;i++){
                    var colorNum='';
                    var lastVisitTime='';
                    if(data1[i].password=='') {
                        colorNum = 'colorRed'
                    }
                    if(data1[i].notLogin==1){
                        colorNum='colorddd'
                    }
                    if(data1[i].lastVisitTime!=undefined){
                        lastVisitTime=data1[i].lastVisitTime
                    }

                    str += '<tr class="userData '+colorNum+'" uId="' + data1[i].uid + '">' +
                        '<td>'+function(){if(data1[i].byname=="admin"){
                            return ''
                        }else{
                            return '<input type="checkbox" class="checkChild" name="checkbox" value=""  style="width:13px;height:13px;" />'
                        }}()+'</td>' +
                        '<td userid="'+ data1[i].userId +'">' + data1[i].userId + '</td>' +
                        '<td byname="'+ data1[i].byname +'">' + data1[i].byname + '</td>' +
                        '<td>' + data1[i].userName + '</td>' +
                        '<td data-deptid="'+data1[i].deptId+'">' + data1[i].deptName + '</td>' +
                        '<td>' + data1[i].userPrivName + '</td>' +
                        '<td>' + function () {
                            if(data1[i].postName!=undefined){
                                return data1[i].postName
                            }else{
                                return ''
                            }
                        }() + '</td>' +
                        '<td>' + lastVisitTime + '</td>' +
                        '<td>' + data1[i].idleTime + '</td>' +
                        '<td>'+function(){
                                if(data1[i].uid==''){
                                    return '';
                                }else{
                                    var str = '<a href="javascript:void(0)" onclick="clickrenwu('+data1[i].uid+',this)" style="margin-right: 5px;"><fmt:message code="global.lang.edit" /></a>'

                                    if (USER_DEPT_ORDER) {
                                        str += '<a href="javascript:;" userid="'+data1[i].userId+'" name="'+data1[i].userName+'" onclick="userDeptOrder(this)">部门排序</a>'
                                    }

                                    return str
                                }
                        }()+'</td>' +
                        '</tr>';  //<a href="javascript:;">
                    <%--<fmt:message code="userManagement.th.MenuAauthority" />--%>
                    //</a>:菜单权限查看
                    $("#checkedAll").removeAttr("checked");

                }

                element.parent().html(str);
                $('.userData').on("click",function(){
                    var inCh=$(this).find('.checkChild').prop('checked');
                    if(inCh == true){
                        $(this).find('.checkChild').prop('checked',true);
                        $(this).addClass('bgColor');
                    }else{
                        $('#checkedAll').prop('checked',false);
                        $(this).find('.checkChild').prop('checked',false);
                        $(this).removeClass('bgColor');
                    }
                    var child = $(".checkChild");
                    for(var i=0;i<child.length;i++){
                        var childstate= $(child[i]).prop("checked");
                        if(inCh!=childstate){
                            return
                        }
                    }
                    $('#checkedAll').prop("checked",inCh);
                })
                if(fun){
                    fun();
                }
            }
        })
    }
    function ajaxdata (deptId,me) {
        $('#allSelUser').val(' ')
        $('.header').children('.USER').text($(me).children('a').text());
        $('.newroletwo').children('span').text($(me).children('a').text());
        $('.newroletwo').children('input').val($(me).attr('deptid'));
        searchData = {};
        searchData.deptIds = deptId+",";
        if($('#allSelUser').val()!=undefined &&$('#allSelUser').val()!=''){
            searchData.notLogin = $('#allSelUser').val();
        }
        if(deptId==0||deptId=='0'){
            searchData.deptIds = "";
            searchData.notLogin = $('#allSelUser').val();
            searchData.deptId = 0;
        }
        $('#reload').show();
        deptById(searchData,$('.tr_befor'))
    }
    function clickrenwu(deptId,me) {
        userstr=$(me).text();
        window.open('../addUsers?'+deptId,'<fmt:message code="sys.th.EditUser" />');
    }
    $(function () {
        loadSidebar1($('#downChild'),0);
        $.ajax({
            url:'/sys/showUnitManage',
            type:'get',
            dataType:"JSON",
            data : '',
            success:function(obj){
                var data = obj.object.unitName;
                $('#downChild .pickCompany .dynatree-title').text(data).attr('title',data);
            },
            error:function(e){
            }
        });
        $('.rightMain ').height($(document).height()-46);
        window.onresize=function(){
            $('.rightMain ').height($(document).height()-46);
            $('.left ').height($(document).height()-46);
        }
        $('#btn').on("click",function(){
            /*$.ajax({
                url:"/user/checkUserCount",
                type:"get",
                async:false,
                success:function (res) {
                    if(res.flag){
                        numdept=$('.newroletwo').find('input').val();
                        window.open('../addUsers?0','<fmt:message code="userManagement.th.NewUser" />');
                    }else{
                        layer.msg(res.msg, {icon: 2});
                    }
                },
                dataType:"json"
            });*/
            var deptId=$(this).attr('data_id');
            window.open('../addUsers?isAdd=0&deptId='+deptId,'<fmt:message code="userManagement.th.NewUser" />');
        });
        $('#allSelUser ').on('change',function () {
                 var deptId= 0 ;
                var deptIdDom = $('.collect .add_back').attr('deptid');
                if(deptIdDom!=undefined&&deptIdDom!=''&&deptIdDom!='undefined'){
                    deptId = deptIdDom;
                }
                if(searchData.deptIds==undefined){
                    searchData.deptIds = deptId;
                }
            searchData.notLogin = $(this).val();
            if($(this).val()==''){
                delete searchData.notLogin;
            }
            $('#reload').show();
            if(dimission == 1){
                searchData.deptId = 0;
                searchData.deptIds= '';
            }
            deptById(searchData,$('.tr_befor'),function () {
                dimission = 0;
            })
        });
//        init()
//        getChDept($('#ULDown'),30);
        $('.AUP').on("click",function(){
            //$('#ulList').slideToggle();
            if($('#downChild').css('display')=='block'){
                $(this).addClass('liUp').removeClass('liDown');
                $('#downChild').slideUp();
            }else{
                $(this).addClass('liDown').removeClass('liUp');
                $('#downChild').slideDown();
            }
        });
        $('.proceed').on("click",function () {
            $.layerMsg({content:'<fmt:message code="lang.th.Upcoming" />',icon:6})
        });
        $('.employee').on("click",function () {
            $('#reload').show()
            $('#btn').show()
            dimission = 1;
            <%--$('.newroletwo').children('span').text("<fmt:message code="userManagement.th.Outgoing" />");--%>
            $('.header').children('.USER').text('<fmt:message code="userManagement.th.Outgoing" />');
            $('#reload').show();
            $('.newroletwo').children('input').val(0);
            var datas={
                      'deptId':0,
                       'notLogin':$('#allSelUser').val()
                    };
            if($('#allSelUser').val()==undefined || $('#allSelUser').val()==''){
                searchData.notLogin =null;
            }
            $('#reload').show();
            deptById(datas,$('.tr_befor'));
        });
        // 查询新增用户
        $('.newUsers').on("click",function(){
            $('#reload').show()
            $('#btn').show()
            $('.tab').find('.userData').remove();
            $('.content .right').css("display","block");
            $('.content .rightMain').css("display","none");
            <%--$('.newroletwo').children('span').text("<fmt:message code="userManagement.th.RecentlyAdded" />");--%>
            $('.header').children('.USER').text('<fmt:message code="userManagement.th.RecentlyAdded" />');
            $('#reload').show();
            $('.newroletwo').children('input').val('');
            $.ajax({
                url:'../user/queryExportUsers?moduleId='+moduleId,
                type:'get',
                dataType:'json',
                success:function(rsp){
                    var data1=rsp.obj;
                    var str='';
                    $('.totalNum').html(rsp.obj.length);
                    for(var i=0;i<data1.length;i++){
                        var colorNum='';
                        var lastVisitTime=''
                        if(data1[i].password=='') {
                            colorNum = 'colorRed'
                        }
                        if(data1[i].notLogin==1){
                            colorNum='colorddd'
                        }
                        if(data1[i].lastVisitTime!=undefined){
                            lastVisitTime=data1[i].lastVisitTime
                        }

                        str += '<tr class="userData '+colorNum+'" uId="' + data1[i].uid + '">' +
                            '<td>'+function(){
                                if(data1[i].byname=='admin'){
                                    return ''
                                }else{
                                    return '<input type="checkbox" class="checkChild" name="checkbox" value="" style="width:13px;height:13px;" />'
                                }
                            }()+'</td>' +
                            '<td>' + data1[i].userId + '</td>' +
                            '<td>' + data1[i].byname + '</td>' +
                            '<td>' + data1[i].userName + '</td>' +
                            '<td data-deptid="'+data1[i].deptId+'">' + data1[i].deptName + '</td>' +
                            '<td>' + data1[i].userPrivName + '</td>' +
                            <%--'<td>' +function () {--%>
                            <%--    switch (parseInt(data1[i].postPriv)) {--%>
                            <%--        case 1:--%>
                            <%--            return '<fmt:message code="url.th.all" />';--%>
                            <%--            break--%>
                            <%--        case 2:--%>
                            <%--            return '<fmt:message code="sys.th.DesignatedDepartment" />';--%>
                            <%--            break--%>
                            <%--        case 0:--%>
                            <%--            return '<fmt:message code="sys.th.ThisDepartment" />';--%>
                            <%--            break--%>
                            <%--        default:--%>
                            <%--            return ""--%>
                            <%--    }--%>

                            <%--}()  + '</td>' +--%>
                            '<td></td>' +
                            '<td>' + lastVisitTime + '</td>' +
                            '<td>' + data1[i].idleTime + '</td>' +
                            '<td>'+function(){
                                    if(data1[i].uid==''){
                                        return ''
                                    }else{
                                        return '<a href="javascript:void(0)" onclick="clickrenwu('+data1[i].uid+',this)" style="margin-right: 5px;"><fmt:message code="global.lang.edit" /></a>'
                                    }
                            }()+'</td>' +
                            '</tr>';  //<a href="javascript:;">
                        <%--<fmt:message code="userManagement.th.MenuAauthority" />--%>
                        //</a>:菜单权限查看

                    }

                    $('.tr_befor').after(str);
                    $('.userData').on("click",function(){
                        var inCh=$(this).find('.checkChild').prop('checked');
                        if(inCh == true){
                            $(this).find('.checkChild').prop('checked',true);
                            $(this).addClass('bgColor');
                        }else{
//                            $('#checkedAll').prop('checked',false);
                            $('#checkedAll').removeAttr("checked")
                            $(this).find('.checkChild').prop('checked',false);
                            $(this).removeClass('bgColor');
                        }
                        var child = $(".checkChild");
                        for(var i=0;i<child.length;i++){
                            var childstate= $(child[i]).prop("checked");
                            if(inCh!=childstate){
                                return
                            }
                        }
                        $('#checkedAll').prop("checked",inCh);
                    })
                }
            })
        })
        //未分配部门人员
        $('.noDept').on("click",function () {
            $('.content .right').css("display","none");
            $('.rightMain').css("display","block");
            $('.rightMain iframe').attr("src","/sys/noDeptPeople");
        })
        // 查询和导出
        $('.queryExport').on("click",function () {
            $('.content .right').css("display","none");
            $('.rightMain').css("display","block");
            $('.rightMain iframe').attr("src","../user/goQueryExportUsers?type=0");
        });
        // 导入
        $('.import').on("click",function () {
            $('.content .right').css("display","none");
            $('.rightMain').css("display","block");
            $('.rightMain iframe').attr("src","../user/goImportUsers");
        });
        // 批量设置
        $('.editUserBatch').on("click",function () {
            $('.content .right').css("display","none");
            $('.rightMain').css("display","block");
            $('.rightMain iframe').attr("src","../user/goEditUserBatch?isClassDept=0");
        });
        //动态密码卡管理
        $('.passwordCard').on("click",function () {
            $('.content .right').css("display","none");
            $('.rightMain').css("display","block");
            $('.rightMain iframe').attr("src","../user/passwordCard");
        });
//        //部门人员情况列表
//        $('#ULDown').on('click','.childdept',function(){
//            var  that = $(this);
//            var deptid=that.attr('deptid');
//            var deName=that.attr('Name');
//            var val=$('#allSelUser option:checked').val();
//            $('.childdept').removeClass('on');
//            that.addClass('on')
//            getChDept(that.next(),deptid);
//            that.next().slideToggle();
//            var data={
//                'deptId':deptid,
//                'notLogin':val
//            }
//            $('.newDept').text('（'+deName+'）');
//            $('.currentDept').text('（'+deName+'）');
//            deptById(data,$('.tr_befor'));
//        })
        //全选点击事件
        $('#checkedAll').on("click",function(){
            var state =$(this).prop("checked");
            if(state==true){
                $(this).prop("checked",true);
                $(".checkChild").prop("checked",true);
                $(".userData").addClass('bgcolor');
            }else{
                $(this).prop("checked",false);
                $(".checkChild").prop("checked",false);
                $('.userData').removeClass('bgcolor');
            }
        })
        //删除人员按钮
        $('.ONE').on("click",function(){
            // 判断是否只允许系统管理员删除用户
            $.ajax({
                type:'get',
                url:'/syspara/selectByParaName',
                dataType:'json',
                data:{
                    paraName:'PRIV1_DELETE_USER'
                },
                success:function (res) {
                    if(res.flag){
                        if(res.object==1){
                            if($('.tab table input[type="checkbox"]:checked').length==0){
                                $.layerMsg({content:'<fmt:message code="sys.th.PleaseFirst" />',icon:2})
                                return
                            }
                            $.ajax({
                                type:'get',
                                url:'/user/userCookie',
                                dataType:'json',
                                success:function (res) {
                                    if(res.object.role.userPriv==1){
                                        buttonInterface('../user/deleteUser','<fmt:message code="sys.th.MakeSureDelete" />？');
                                    }else {
                                         $.layerMsg({content:'您不是系统管理员，不能删除用户',icon:2})
                                        return
                                    }
                                }
                            })

                        }else{
                            if($('.tab table input[type="checkbox"]:checked').length==0){
                                $.layerMsg({content:'<fmt:message code="sys.th.PleaseFirst" />',icon:1})
                                return
                            }
                            buttonInterface('../user/deleteUser','<fmt:message code="sys.th.MakeSureDelete" />？');
                        }

                    }
                }
            })
        })
        //清空在线时长按钮
        $('.TWO').on("click",function(){
            if($('.tab table input[type="checkbox"]:checked').length==0){
                $.layerMsg({content:'<fmt:message code="sys.th.PleaseFirst" />',icon:1})
                return
            }
            buttonInterface('../user/clearOnLine','<fmt:message code="sys.th.MakeSureEmpty" />？');
        })
        //批量修改按钮
        $('.THREE').on("click",function(){
            // uidArray = new Array();
            // $.each($('tbody .bgcolor'), function (index, elem) {
            //     uidArray.push($(elem).attr('uid'))
            // });
            if(b==0){
                $('.tab table tbody [type="checkbox"]:checked').each(function(){
                    uidArray+=$(this).parent().parent().attr('uid')+',';
                    a = uidArray.split(',')
                    b++

                })
            }else{
                uidArray = new Array()
                $('.tab table tbody [type="checkbox"]:checked').each(function(){
                    uidArray+=$(this).parent().parent().attr('uid')+',';
                    a = uidArray.split(',')
                    b++
                })
            }
            // console.log(a)

            if($('.tab table input[type="checkbox"]:checked').length==0){
                $.layerMsg({content:'<fmt:message code="sys.th.PleaseFirst" />',icon:1})
            }else{
                layer.open({
                    type: 1,
                    title:['批量修改密码'],
                    area: ['640px', '350px'], //宽高
                    content: '        <div class="title" style="margin-top:10px;margin-left:10px">\n' +
                        '            <img src="../img/modifypassword.png" alt="修改OA账户">\n' +
                        '            <span><fmt:message code="url.th.ModifyOA" /></span>\n' +
                        '        </div>\n' +
                        '        <div class="main" style="margin-top:35px;padding-left:80px">\n' +
                        '            <table class="table" cellspacing="0" cellpadding="0" style="border-collapse:collapse;background-color: #fff">\n' +
                        '                <tr class="w" style="border:0">\n' +
                        '                    <td class="red_text" style="text-align:center"><fmt:message code="url.th.newPW" />:</td>\n' +
                        '                    <td>\n' +
                        '                        <input type="password" style="width:50%" id="password" class="pw"/><%--<fmt:message code="url.th.numbers" />--%>\n' +
                        '                    </td>\n' +
                        '                </tr>\n' +
                        '          <tr style="border:0">\n' +
                        '          <td class="red_text" style="text-align:center"><fmt:message code="url.th.Confirm" />:</td>\n' +
                        '  <td style="display:inline-block;margin-top:20px;width:100%">\n' +
                        '  <input type="password" style="width:50%" id="repassword" class="pw"    onkeyup="validatePwdStrong(this.value);"/>\n' +
                        '      <span class="passWordRuleSpan"></span><span>位，必须同时包含字母和数字</span><%--<fmt:message code="url.th.numbers" />--%>\n' +
                        '  <div class="clearfix" style="    width: 217px;height: 10px;border: 1px solid #ccc;margin-top: 5px; margin-bottom:10px;border-radius: 4px;" id="main">\n' +
                        '      <span class="fl" style="display:inline-block;position: relative;top:-6px;width: 67px;height:10px;border-right: 1px solid #ccc" id="low"></span>\n' +
                        '      <span class="fl" style="display:inline-block;width: 67px;position: relative;top:-6px;height:10px;border-right: 1px solid #ccc" id="medium"></span>\n' +
                        '      <span class="fl" style="display:inline-block;position: relative;top:-6px;width: 68px;height:10px;" id="height"></span>\n' +
                        '      </div>\n' +
                        '      </td>\n' +
                        '      </tr>\n' +
                        '           <tr style="border:0">\n' +
                        '           <td colspan="2">\n' +
                        '       <div class="btn" style="text-align:center;margin-top:30px;margin-right:40px">\n' +
                        '       <input id="submit" style="width:80px;cursor: pointer" type="button" class="inpuBtn backOkBtn"  value="<fmt:message code="global.lang.save" />">\n' +
                        '       </div>\n' +
                        '       </td>\n' +
                        '       </tr>\n' +
                        '            </table>\n' +
                        '        </div>',
                    success:function(){

                    }
                });
            }


            $(function(){
                // 查询密码限制长度
                var passWordMin=6,passWordMax=20;
                $.ajax({
                    url:"/user/getPwRule",
                    type:"get",
                    dataType: 'json',
                    success:function (res) {
                        if(res.flag){
                            var obj = res.object;
                            passWordMin = obj.secPassMin;
                            passWordMax = obj.secPassMax;
                            start = passWordMin
                            end = passWordMax
                            $('.passWordRuleSpan').html(passWordMin+"-"+passWordMax);
                        }
                    }
                });

                $.ajax({
                    url:'/sysTasks/selectAll',
                    dataType:'json',
                    type:'get',
                    success:function (res) {
                        var data = res.obj;
                        for(var i=0;i<data.length;i++){
                            if(data[i].paraName=='SEC_PASS_SAFE'){
                                if(data[i].paraValue == 0){
                                    flag = 0
                                    $('.passWordRuleSpan').next().html('位')
                                }else if(data[i].paraValue == 1){
                                    flag = 1
                                    $('.passWordRuleSpan').next().html('位，必须同时包含字母和数字')
                                }else if(data[i].paraValue == 2){
                                    flag = 2
                                    $('.passWordRuleSpan').next().html('位，必须同时包含字母和数字和字符')
                                }else if(data[i].paraValue == 3){
                                    flag = 3
                                    $('.passWordRuleSpan').next().html('位，必须同时包含大写字母和小写字母和数字')
                                }else if(data[i].paraValue == 4){
                                    flag = 4
                                    $('.passWordRuleSpan').next().html('位，必须同时包含大写字母和小写字母和数字和特殊字符')
                                }
                            }
                        }
                        $('.right').show();
                    }
                })

                $.ajax({
                    type: "get",
                    url: "/getUsersByuserId",
                    dataType: 'json',
                    success: function (obj) {
                        if(obj.flag){

                            $('#username').val(obj.object.byname);
                            $('#username').attr({
                                'userId':obj.object.userId,
                                'uid':obj.object.uid
                            })
                            var timeStamp=obj.object.lastPassTime;
                            if(timeStamp!=undefined) {
                                var time = new Date(timeStamp);
                                var year = time.getFullYear();//年
                                var month = time.getMonth() + 1;//月
                                var date = time.getDate();//日
                                var hour = time.getHours(); //时
                                var minu = time.getMinutes(); //分
                                var conds = time.getSeconds(); //秒
                                var new_months;
                                var new_dates;
                                var new_hours;
                                var new_minus;
                                var new_condss;
                                if (month < 10) {
                                    new_months = "0" + month
                                } else {
                                    new_months = month;
                                }
                                if (date < 10) {
                                    new_dates = "0" + date
                                } else {
                                    new_dates = date;
                                }
                                if (minu < 10) {
                                    new_minus = "0" + minu
                                } else {
                                    new_minus = minu;
                                }
                                if (hour < 10) {
                                    new_hours = "0" + hour;
                                } else {
                                    new_hours = hour;
                                }
                                if (conds < 10) {
                                    new_condss = "0" + conds;
                                } else {
                                    new_condss = conds;
                                }
                                var str_time = year + "-" + new_months + "-" + new_dates + " " + new_hours + ":" + new_minus + ":" + new_condss;

                                $('#lastEditTime').html(str_time);
                            }else {
                                $('#lastEditTime').html("");
                            }
                        }
                    },
                });





                //初始化修改登录日志列表显示
                logListShow();
            })

            function logListShow(){
                $.ajax({
                    type: "post",
                    url: "/sys/getModifyPwdLog",
                    dataType: 'json',
                    success:function(data){
                        var obj=data.obj;
                        if(data.flag&&obj.length>0){
                            var str="";
                            for(var i=0;i<obj.length;i++){
                                str+='<tr><td>'+obj[i].userName+'</td><td>'+obj[i].time+'</td><td>'+obj[i].ip+'</td><td>'+obj[i].typeName+'</td><td>'+obj[i].remark+'</td></tr>';
                            }
                            $('.modifyPwdLogList').html(str.toString());
                            $('#lastEditTime').html(obj[0].time);
                        }
                    }
                })
            }

            /******************************************************验证用户输入******************************************************/


            function ValidateInput(element, value) {
//验证密码

                var i = start;
                var j = end;
                var reg = /^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)[^]{1,}$/

                if(flag == 1 && !reg.test(value)){
                    $.layerMsg({content:'密码必须包含大写字母、小写字母和数字',icon:6})
                    return;
                }else if(flag == 0 && Evaluate(value) != 2){
                    $.layerMsg({content:'密码必须包含字母和数字',icon:6})
                    return;
                }

                if (element == "password") {
                    if (value.toString().length < start) {
                        $.layerMsg({content:'您的密码不到'+start+'位',icon:6})
//                 alert("您的密码不到6位")
                        return;
                    }
                }

            }



            /*================================密码强度 ===========Begin=======================================*/






            <%--if($('.tab table input[type="checkbox"]:checked').length==0){--%>
            <%--    $.layerMsg({content:'<fmt:message code="sys.th.PleaseFirst" />',icon:1})--%>
            <%--    return--%>
            <%--}--%>
            <%--buttonInterface('../user/clearPassword','<fmt:message code="sys.th.VerifyPassword" />？');--%>
        })



        //禁止登录按钮
        $('.FOUR').on("click",function(){
            if($('.tab table input[type="checkbox"]:checked').length==0){
                $.layerMsg({content:'<fmt:message code="sys.th.PleaseFirst" />',icon:1})
                return
            }
            buttonInterface('../user/setNotLogin','<fmt:message code="sys.th.MakeSure" />？');
        })
        //允许登录按钮
        $('.SEVEN').on("click",function(){
            if($('.tab table input[type="checkbox"]:checked').length==0){
                $.layerMsg({content:'是否允许选中的人员登录？',icon:1})
                return
            }
            buttonInterface('../user/setAllowLogin','是否允许选中的人员登录？');
        })
        // 提醒空密码用户按钮
        $('.FIVE').on("click",function(){
            $.layerMsg({content:'<fmt:message code="lang.th.Upcoming" />',icon:1})
                return
        })
        // 批量修改部门按钮
        $('.SIX').on("click",function(){
            if($('.tab table input[type="checkbox"]:checked').length==0){
                $.layerMsg({content:'<fmt:message code="sys.th.PleaseFirst" />',icon:1})
                return
            }
            layer.open({
                title:'<fmt:message code="sys.th.BatchModification" />',
                content:'<div>' +
                        '<table style="height:200px">' +
                        '<tr><td style="border-right: 1px solid #ddd;text-align: center;"><fmt:message code="main.usermanage" />:</td><td><textarea name="" id="textareaopen"></textarea><a href="javascript:void(0)" class="addopens"><button type="button" class="layui-btn layui-btn-normal"><fmt:message code="global.lang.add" /></button></a></td></tr>' +
                '<tr><td style="border-right: 1px solid #ddd;text-align: center;"><fmt:message code="sys.th.NewSector" />:</td><td><select style="width: 150px;” name="" id="newselectrrole"></select></td></tr>' +
                '<tr><td style="border-right: 1px solid #ddd;text-align: center;"><fmt:message code="sys.th.ReminderDepartment" />:</td><td><label style="margin-right: 10px;"><input name="checktit" type="checkbox" value="发送事务提醒消息"><fmt:message code="notice.th.remindermessage" /></label>' +
                '<label><input name="checktit" type="checkbox" value="发送提醒信息"><fmt:message code="sys.th.SendReminderMessage" /></label></td></tr></table></div>',
                area:['500px','400px'],
                btn:['<fmt:message code="global.lang.ok" />','<fmt:message code="depatement.th.quxiao" />'],
                yes:function (index) {
                        var obj=document.getElementsByName('checktit'); //选择所有name="'test'"的对象，返回数组
                        //取到对象数组后，我们来循环检测它是不是被选中
                        var s='';
                        for(var i=0; i<obj.length; i++){
                            if(obj[i].checked) s+=obj[i].value+','; //如果选中，将value添加到变量s中
                        }
                        // alert(s==''?'你还没有选择任何内容！':s);
                        var remindType;
                        if(s == '发送事务提醒消息,'){
                            remindType = 1
                        }else if(s == '发送提醒信息,'){
                            remindType = 2
                        }else if(s == '发送事务提醒消息,发送提醒信息,'){
                            remindType = 3
                        }else{
                            remindType = 0
                        }
                    var obj={
                        'deptId':$('#newselectrrole').val(),
                        'uids':$('#textareaopen').attr('dataid'),
                        'nowDeptId':$('.userData').eq(0).find('td').eq(4).attr('data-deptid'),
                        'remindType':remindType
                    }
                    $.post('/user/editUsersDeptId',obj,function (json) {
                        if(json.flag){
                            $.layerMsg({content:'<fmt:message code="sys.th.SwapComplete" />',icon:1},function () {
                                location.reload()
                            })
                        }
                    },'json')
                },
                success:function () {
                    $('#newselectrrole').deptSelect(function (me) {//me是传过来的this，newselectrrole
                        $.get('/department/selectUnallocated', function(res){
                            $(me).append('<option value="0"><fmt:message code="userManagement.th.Outgoing" /></option>')
                            if (res.flag && res.msg != 'false') {
                                $(me).append('<option value="'+res.object.deptId+'">'+res.object.deptName+'</option>')
                            }
                            $('#newselectrrole').val($('.tab table tbody [type="checkbox"]:checked').parent().parent().find('td').eq(4).attr('data-deptid'))
                        })
                    })
                    var strcheck='',struserId='',struid='';
                    $('.tab table tbody [type="checkbox"]:checked').each(function(){
                        strcheck+=$(this).parent().parent().find('td').eq(2).text()+',';
                        struserId+=$(this).parent().parent().find('td').eq(1).attr('userid')+',';
                        struid+=$(this).parent().parent().attr('uid')+',';
                    })
                    $('#textareaopen').val(strcheck)
                    $('#textareaopen').attr('user_id',struserId)
                    $('#textareaopen').attr('dataid',struid)
                    $('.addopens').on("click",function(){
                        user_id=$(this).prev().prop('id')
                        $.popWindow("../common/selectUser");
                    })
                }
            })

        })
        function init(){
            $.ajax({
                url:'../department/getChDept',
                type:'get',
                data:{'deptId':20 },
                dataType:'json',
                success:function(res){
                    var data1=res.obj;
                    var str='';
                    str='<span deptid="'+data1.deptId+'" class="childdept" style="display: block;width:100%;padding:8px 0 8px 30px;font-size: 14px;"><a href="javascript:void(0)" class="dynatree-title" title="'+data1[0].deptName+'">'+data1[0].deptName+'</a></span>'
                    $('#ULDown').before(str);
                }
            })
        }
        //部门人员树状图方法
        function getChDept(element,deptId){
            $.ajax({
                url:'../department/getChDept',
                type:'get',
                data:{'deptId':deptId },
                dataType:'json',
                success:function(data){

                    if(deptId==30){
                        var str = '';
                        data.obj.forEach(function(v,i){
                            if(v.deptName){
                                str+='<li><span deptid="'+v.deptId+'" Name="'+v.deptName+'" class="childdept"><img style="margin-left: 42px;margin-right: 5px" src="../img/main_img/company_logo.png" alt=""><a href="javascript:void(0)"  class="dynatree-title" title="'+v.deptName+'">'+v.deptName+'</a></span><ul></ul></li>';
                            }else{
                                str+='<li><span deptid="'+v.deptId+'" Name="'+v.deptName+'" class="childdept"><span><img style="margin-left: 65px;margin-right: 5px" src="../img/main_img/man.png" alt=""></span><img style="margin-left: 65px;margin-right: 5px" src="../img/main_img/man.png" alt=""><a href="javascript:void(0)"  class="dynatree-title" title="'+v.userName+'">'+v.userName+'</a></span><ul></ul></li>';
                            }
                        });
                    }else{
                        var str = '';
                        data.obj.forEach(function(v,i){
                            if(v.deptName){
                                str+='<li><span deptid="'+v.deptId+'" Name="'+v.deptName+'" class="childdept"><img style="margin-left: 65px;margin-right: 5px" src="../img/main_img/company_logo.png" alt=""><a href="javascript:void(0)" data-uid="'+v.uid+'" onclick="edituser(this)" class="dynatree-title" title="'+v.deptName+'">'+v.deptName+'</a></span><ul></ul></li>';
                            }else{
                                if(v.sex==0){
                                    str+='<li><span deptid="'+v.deptId+'" Name="'+v.deptName+'" class="childdept"><img style="margin-left: 65px;margin-right: 5px" src="../img/main_img/man.png" alt=""><a href="javascript:void(0)" data-uid="'+v.uid+'" onclick="edituser(this)" class="dynatree-title" title="'+v.userName+'">'+v.userName+'</a></span><ul></ul></li>';
                                }else if(v.sex==1){
                                    str+='<li><span deptid="'+v.deptId+'" Name="'+v.deptName+'" class="childdept"><img style="margin-left: 65px;margin-right: 5px" src="../img/main_img/women.png" alt=""><a href="javascript:void(0)" data-uid="'+v.uid+'" onclick="edituser(this)" class="dynatree-title" title="'+v.userName+'">'+v.userName+'</a></span><ul></ul></li>';
                                }
                            }

                        });
                    }
                    element.html(str);

                }
            })
        }
        //人员列表展示
        //列表功能按钮
        function buttonInterface(URL,txt){
            var deptid=$('.collect .add_back').attr('deptid');
            var val=$('#allSelUser option:checked').val();


            var string='';
            $('.tab table input[type="checkbox"]:checked').each(function(i,n){
                string+=$(this).parent().parent().attr('uId')+',';
            })
//           var str=string.split("").join(",");
            var msg=txt;

            $.layerConfirm({title:msg,content:msg,icon:0,offset:"200px"},function(){
                $.ajax({
                    type:'post',
                    url:URL,
                    dataType:'json',
                    data:{'uids':string},
                    success:function(res){
//                        deptById(data,$('.tr_befor'));
                        if(res.flag){
                            if($('#allSelUser').val()!=undefined &&$('#allSelUser').val()!=''){
                                searchData.notLogin = $('#allSelUser').val();
                            }
                            $("#checkedAll").removeAttr("checked");
                            $('#reload').show();
                            if(msg == '确定删除选中人员？'){
                                layer.msg('删除成功！', {icon: 1, time: 2000});
                                setTimeout(function () {
                                    window.location.reload()
                                }, 1000);
                            }
                            // deptById(searchData,$('.tr_befor'))
                            if(msg == '确认清空选中人员在线时长？'){
                                $.ajax({
                                    url:'../user/queryExportUsers?moduleId='+moduleId,
                                    type:'get',
                                    dataType:'json',
                                    success:function(rsp){
                                        var data1=rsp.obj;
                                        $('.totalNum').html(rsp.obj.length);
                                        var str='<tr class="tr_befor">\n' +
                                            '                    <th width="4%">\n' +
                                            '\n' +
                                            '                    </th>\n' +
                                            '                    <th width="7%"><fmt:message code="userManagement.th.userId" /></th>\n' +
                                            '                    <th width="7%"><fmt:message code="userName" /></th>\n' +
                                            '                    <th width="7%"><fmt:message code="userManagement.th.Realname" /></th>\n' +
                                            '                    <th width="7%"><fmt:message code="userManagement.th.department" /></th>\n' +
                                            // '                    <th width="7%">考勤类型</th>\n' +
                                            '                    <th width="14%"><fmt:message code="userManagement.th.role" /></th>\n' +
                                            // '                    <th width="8%"><fmt:message code="userManagement.th.ManagementScope" /></th>\n' +
                                            '                    <th width="7%"><fmt:message code="userDetails.th.post" /></th>\n' +
                                            '                    <th width="18%"><fmt:message code="userManagement.th.LastAccess" /></th>\n' +
                                            '                    <th width="7%"><fmt:message code="userManagement.th.idle" /></th>\n' +
                                            '                    <th width="15%"><fmt:message code="notice.th.operation" /></th>\n' +
                                            '                </tr>';
                                        for(var i=0;i<data1.length;i++){
                                            var colorNum='';
                                            var lastVisitTime='';
                                            if(data1[i].password=='') {
                                                colorNum = 'colorRed'
                                            }
                                            if(data1[i].notLogin==1){
                                                colorNum='colorddd'
                                            }
                                            if(data1[i].lastVisitTime!=undefined){
                                                lastVisitTime=data1[i].lastVisitTime
                                            }

                                            str += '<tr class="userData '+colorNum+'" uId="' + data1[i].uid + '">' +
                                                '<td>'+function(){if(data1[i].byname=="admin"){
                                                    return ''
                                                }else{
                                                    return '<input type="checkbox" class="checkChild" name="checkbox" value=""  style="width:13px;height:13px;" />'
                                                }}()+'</td>' +
                                                '<td userid="'+ data1[i].userId +'">' + data1[i].userId + '</td>' +
                                                '<td byname="'+ data1[i].byname +'">' + data1[i].byname + '</td>' +
                                                '<td>' + data1[i].userName + '</td>' +
                                                '<td data-deptid="'+data1[i].deptId+'">' + data1[i].deptName + '</td>' +
                                                '<td>' +data1[i].dutyTypeName+ '</td>' +
                                                '<td>' + data1[i].userPrivName + '</td>' +
                                                /* '<td>' +function () {
                                                         if(data1[i].postPriv==undefined){
                                                             return '';
                                                         }
                                                     switch (parseInt(data1[i].postPriv)) {
                                                         case 1:
                                                             return '<fmt:message code="url.th.all" />';
                                    break
                                case 2:
                                    return '<fmt:message code="sys.th.DesignatedDepartment" />';
                                    break
                                case 0:
                                    return '<fmt:message code="sys.th.ThisDepartment" />';
                                    break
                                default:
                                    return ""
                            }

                        }()  + '</td>' +*/
                                                '<td>' + function () {
                                                    if(data1[i].postName!=undefined){
                                                        return data1[i].postName
                                                    }else{
                                                        return ''
                                                    }
                                                }() + '</td>' +
                                                '<td>' + lastVisitTime + '</td>' +
                                                '<td>' + data1[i].idleTime + '</td>' +
                                                '<td>'+function(){
                                                    if(data1[i].uid==''){
                                                        return '';
                                                    }else{
                                                        var str = '<a href="javascript:void(0)" onclick="clickrenwu('+data1[i].uid+',this)" style="margin-right: 5px;"><fmt:message code="global.lang.edit" /></a>'

                                                        if (USER_DEPT_ORDER) {
                                                            str += '<a href="javascript:;" userid="'+data1[i].userId+'" name="'+data1[i].userName+'" onclick="userDeptOrder(this)">部门排序</a>'
                                                        }

                                                        return str
                                                    }
                                                }()+'</td>' +
                                                '</tr>';  //<a href="javascript:;">
                                            <%--<fmt:message code="userManagement.th.MenuAauthority" />--%>
                                            //</a>:菜单权限查看
                                            $("#checkedAll").removeAttr("checked");

                                        }

                                        $('.tr_befor').parent().html(str);
                                        $('.userData').on("click",function(){
                                            var inCh=$(this).find('.checkChild').prop('checked');
                                            if(inCh == true){
                                                $(this).find('.checkChild').prop('checked',true);
                                                $(this).addClass('bgColor');
                                            }else{
                                                $('#checkedAll').prop('checked',false);
                                                $(this).find('.checkChild').prop('checked',false);
                                                $(this).removeClass('bgColor');
                                            }
                                            var child = $(".checkChild");
                                            for(var i=0;i<child.length;i++){
                                                var childstate= $(child[i]).prop("checked");
                                                if(inCh!=childstate){
                                                    return
                                                }
                                            }
                                            $('#checkedAll').prop("checked",inCh);
                                        })
                                    }
                                })
                            }

                            if(msg == '确认禁止选中人员登录？'){
                                $.layerConfirm({title:'信息',content:'是否禁止登录后调整至离职部门?',icon:0,offset:"200px"},function(){
                                    $.ajax({
                                        url:'/user/editUsersDeptId',
                                        type:'get',
                                        data:{deptId:0,uids:string},
                                        success:function(ress){
                                            if(ress.flag){
                                                $.layerMsg({content:'调整成功',icon:0});
                                                window.location.reload()
                                            }else{
                                                $.layerMsg({content:'调整失败',icon:1})
                                            }
                                        }
                                    })
                                })
                            }

                        }

                        /*location.reload()*/
                    }
                })
            })

        }
    })
    function loadSidebar1(target,deptId) {
        $.ajax({
            url: '/department/getChDeptfq',
            type: 'get',
            data: {
                deptId: deptId,
                moduleId:moduleId
            },
            dataType: 'json',
            success: function (data) {
                var str = '';
                data.obj.forEach(function (v, i) {
                    if (v.deptName) {
                        str += '<li><span data-types="1"  data-numtrue="1" ' +
                            'onclick= "imgDown(' +v.deptId + ',this)"  style="height:35px;line-height:35px;padding-left: 30px" deptid="' + v.deptId + '" class="firsttr childdept">' +
                            '<span class=""></span>' +
                            '<img src="/img/sys/dapt_right.png" id="fenzhi" alt="" style="margin-left: 12px;width: 8px;height: 14px;margin-top: -3px;margin-right: 4px;">' +
                            '<a href="javascript:void(0)" class="dynatree-title" title="' + v.deptName + '">' + v.deptName + '</a>'+ function () {
                                if (paraValues == '1'&&v.classifyOrg == '1') {
                                    return '<img src="/img/common/branch.png" title="此部门为分支机构" alt="" class="imgleft" style="width: 25px;height: 25px;margin-top: -3px;margin-right: 4px;">'
                                 } else {
                                    return ''
                                }
                            }() +'</span>' +
                            '<ul style="display:none;" class="dpetWhole0"></ul></li>';
                    }
                })

                widthnum++;
                target.append(str);
            }
        })
    }
    function userDeptOrder(ele){
        var loadIndex = layer.load(2);
        var userId = $(ele).attr('userid');
        var layerIndex = layer.open({
            title: $(ele).attr('name')+'的部门排序',
            type: 1,
            area: ['600px', '500px'],
            btn: ['确认', '取消','重置'+$(ele).attr('name')+'的部门排序',],
            content: '<div class="dept_order_box" style="padding: 8px"><table>' +
                '<thead><tr><th style="width: 30%">部门</th><th style="width: 30%">排序</th><th style="width: 40%"><fmt:message code="userDetails.th.post" /></th></tr></thead>' +
                '<tbody id="deptOrderTable"></tbody></table></div>',
            success: function (){
                $('.layui-layer-btn2').css('float','left')
                $('.layui-layer-btn2').css({
                    'float':'left',
                    'background': '#FF5722',
                    'color': 'white'
                })
                var option = '<option value="0">请选择</option>'
                $.ajax({
                    url: '/duties/selectUserPostList',
                    type: 'GET',
                    async:false,
                    success: function(res){
                        if (res.flag && res.obj.length > 0) {
                            res.obj.forEach(function(post){
                                option += '<option value="'+post.postId+'">'+post.postName+'</option>'
                            })
                        }
                    }
                });

                $.get('/department/deptOrder', {userId: userId}, function(res){
                    if (res.object.length > 0) {
                        res.object.forEach(function(order){
                            $str = $('<tr orderId="'+order.orderId+'" deptId="'+order.deptId+'" userId="'+userId+'"><td>'+order.deptName+'</td>' +
                                '<td><input class="layui-input order_no" type="text" value="'+order.orderNo+'" style="margin-left: 40%;"></td>' +
                                '<td><select>'+option+'<select></td></tr>')
                            $str.find('select').val(order.postId)
                            $('#deptOrderTable').append($str)
                        })
                    }
                });
                layer.close(loadIndex)
            },
            yes: function(){
                var userDeptOrders = []
                var $tr = $('#deptOrderTable tr')
                $tr.each(function(){
                    var orderId = parseInt($(this).attr('orderId'))
                    var deptId = parseInt($(this).attr('deptId'))
                    var userId = $(this).attr('userId')
                    var orderNo = parseInt($(this).find('input').val().trim() || 0)
                    var postId = parseInt($(this).find('select').val() || 0)
                    var item = {orderId: orderId, deptId: deptId, userId: userId, orderNo: orderNo, postId: postId}
                    userDeptOrders.push(item)
                })
                $.ajax({
                    url: '/department/updeptOrder',
                    type: 'post',
                    data: {userDeptOrders: JSON.stringify(userDeptOrders)},
                    success: function(res){
                        if (res.flag) {
                            layer.msg('保存成功')
                            layer.close(layerIndex)
                        } else {
                            layer.msg('保存失败')
                        }
                    }
                })
            },
            btn3:function (index, layero) {
                layer.confirm('确定要重置'+$(ele).attr('name')+'的部门排序吗'+'?', {icon: 3, title:'提示'}, function(index){
                    $.get('/department/resetUserId?userId='+userId,function (res) {
                        if(res.flag){
                            layer.msg(res.msg, {icon: 1},function(){
                                layer.closeAll();
                            });
                        }
                    })
                });
                return false

            }
        })
    }
    //监听键盘事件，部门排序只能输入数字
    $(document).on('keypress', '.order_no', function (e) {
        var key = window.event ? e.keyCode : e.which

        if (!((key > 95 && key < 106) || (key > 47 && key < 58) || key == 8 || key == 9 || key == 13 || key == 37 || key == 39)) {
            return false
        }
    })
    // 监听输入内容
    $(document).on('input propertychange', '.order_no', function (event) {
        var value = parseInt($(this).val())
        if (isNaN(value)) {
            $(this).val('')
        } else {
            $(this).val(value)
        }
    });

    function colorInit() {
        $('#low').css("backgroundColor","#fff")
        $('#medium').css("backgroundColor","#fff")
        $('#height').css("backgroundColor","#fff")

    }

    function Evaluate(word) {
        var low =/^[0-9]*$/;
        var mid=/^[A-Za-z0-9]+$/
        var big=/[0-9a-zA-Z\._\$%&\*\!]/


//        var low = /^(?:\d+|[a-zA-Z]+|[,.:;!@#$%^&*]+)$/  //密码强度为弱 纯数字，纯字母，纯特殊字符
//        var mid = /^(?![^a-zA-Z]+$)(?!\D+$).*$/  //密码强度为中 字母+数字，字母+特殊字符，数字+特殊字符
//        var big = /^.*(?=.*)(?=.*\d)(?=.*[A-Za-z])(?=.*[,.:;!@#$%^&*? ]).*$/  //密码强度为强 字母+数字+特殊字符


        if(low.exec(word)){
            return 1;
        }else if(mid.exec(word)){
            return 2;
        }else if(big.exec(word)){
            return 3;
        }else {
            return 1;
        }
    }

    function validatePwdStrong(value) {
        if (Evaluate(value) == 1) {
            colorInit();
            $('#low').css("backgroundColor","red")
            $('#medium').css("backgroundColor","#fff")
            $('#height').css("backgroundColor","#fff")

        }
        else if (Evaluate(value) == 2) {
            colorInit();
            $('#low').css("backgroundColor","#dfff36")
            $('#medium').css("backgroundColor","#dfff36")
            $('#height').css("backgroundColor","#fff")

        }
        else if (Evaluate(value) == 3) {
            colorInit();
            $('#low').css("backgroundColor","#2dff44")
            $('#medium').css("backgroundColor","#2dff44")
            $('#height').css("backgroundColor","#2dff44")
            $('#height').css("width","70")

        }


    }
    $(function (){
    $('body').on('click','#submit',function(){
        var repassword = $('#repassword').val();
        var password = $('#password').val();
        var oldpassword = $('#password').val()
        var reg =/^[0-9]*$/; //数字
        var reg1=/^(?![^a-zA-Z]+$)(?!\D+$).{1,}$/  //字母和数字
        var reg2 = /^.*(?=.{1,})(?=.*\d)(?=.*[A-Za-z])(?=.*[,.:;!@#$%^&*? ]).*$/; //字母、数字、特殊字符
        var reg3 = /^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)[^]{1,}$/  //大写字母、小写字母、数字
        var reg4 = /^.*(?=.{1,})(?=.*\d)(?=.*[A-Z])(?=.*[a-z])(?=.*[,.:;!@#$%^&*? ]).*$/;  //大写字母、小写字母、数字、特殊字符
//                    var reg = /^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)[^]{1,}$/;
//            var values = $('#repassword').val()
//            console.log(repassword)
//            console.log(password)
//            console.log(flag)
//            console.log(reg4.test(repassword))
        if(password ==''){
            $.layerMsg({content:'<fmt:message code="url.th.PasswordNotEmpty" />！',icon:1},function(){
                return false;
            });
        } else if(repassword == '' ){
            $.layerMsg({content:'<fmt:message code="url.th.VerifynotEmpty" />！',icon:1},function(){
                return false;
            });
        }else if(oldpassword == ''){
            $.layerMsg({content:'<fmt:message code="url.th.TheOldNotEmpty" />！',icon:1},function(){
                return false;
            });
        }else if(repassword == password){
            if(flag == 0){
                if(repassword.toString().length < start){
                    $.layerMsg({content:'您输入的密码格式不正确，要求密码长度为'+start+'-'+end+'位',icon:6,time:3000})
                    return false;
                }else if(repassword.toString().length > end){
                    $.layerMsg({content:'您输入的密码格式不正确，要求密码长度为'+start+'-'+end+'位',icon:6,time:3000})
                    return false;
                }
            }if(flag == 1 ){
                if(!reg1.test(repassword)){
                    $.layerMsg({content:'您输入的密码格式不正确，要求密码长度为'+start+'-'+end+'位，密码强度为密码必须包含：字母 和 数字',icon:6,time:3000})
                    return false;
                }else if(repassword.toString().length < start){
                    $.layerMsg({content:'您输入的密码格式不正确，要求密码长度为'+start+'-'+end+'位，密码强度为密码必须包含：字母 和 数字',icon:6,time:3000})
                    return false;
                }else if(repassword.toString().length > end){
                    $.layerMsg({content:'您输入的密码格式不正确，要求密码长度为'+start+'-'+end+'位，密码强度为密码必须包含：字母 和 数字',icon:6,time:3000})
                    return false;
                }
            }else if(flag == 2 ){
                if(!reg2.test(repassword)){
                    $.layerMsg({content:'您输入的密码格式不正确，要求密码长度为'+start+'-'+end+'位，密码强度为密码必须包含：字母 和 数字 和 特殊字符',icon:6,time:3000})
                    return false;
                }else if(repassword.toString().length < start){
                    $.layerMsg({content:'您输入的密码格式不正确，要求密码长度为'+start+'-'+end+'位，密码强度为密码必须包含：字母 和 数字 和 特殊字符',icon:6,time:3000})
                    return false;
                }else if(repassword.toString().length > end){
                    $.layerMsg({content:'您输入的密码格式不正确，要求密码长度为'+start+'-'+end+'位，密码强度为密码必须包含：字母 和 数字 和 特殊字符',icon:6,time:3000})
                    return false;
                }
            }else if(flag == 3 ){
                if(!reg3.test(repassword)){
                    $.layerMsg({content:'您输入的密码格式不正确，要求密码长度为'+start+'-'+end+'位，密码强度为密码必须包含：大写字母 和 小写字母 和 数字',icon:6,time:3000})
                    return false;
                }else if(repassword.toString().length < start){
                    $.layerMsg({content:'您输入的密码格式不正确，要求密码长度为'+start+'-'+end+'位，密码强度为密码必须包含：大写字母 和 小写字母 和 数字',icon:6,time:3000})
                    return false;
                }else if(repassword.toString().length > end){
                    $.layerMsg({content:'您输入的密码格式不正确，要求密码长度为'+start+'-'+end+'位，密码强度为密码必须包含：大写字母 和 小写字母 和 数字',icon:6,time:3000})
                    return false;
                }
            }else if(flag == 4 ){
                if(!reg4.test(repassword)){
                    $.layerMsg({content:'您输入的密码格式不正确，要求密码长度为'+start+'-'+end+'位，密码强度为密码必须包含：大写字母 和 小写字母 和 数字 和 特殊字符',icon:6,time:3000})
                    return false;
                }else if(repassword.toString().length < start){
                    $.layerMsg({content:'您输入的密码格式不正确，要求密码长度为'+start+'-'+end+'位，密码强度为密码必须包含：大写字母 和 小写字母 和 数字 和 特殊字符',icon:6,time:3000})
                    return false;
                }else if(repassword.toString().length > end){
                    $.layerMsg({content:'您输入的密码格式不正确，要求密码长度为'+start+'-'+end+'位，密码强度为密码必须包含：大写字母 和 小写字母 和 数字 和 特殊字符',icon:6,time:3000})
                    return false;
                }
            }
            $.ajax({
                type: "post",
                url: "/user/batchUpdatePassWordByUidArray",
                dataType: 'json',
                data: {
                    password:$('#repassword').val(),
                    // userId:$('#username').attr('userId'),
                    // uidArray:$('#username').attr('uid'),
                    uidArray:a,
                    // newPwd:$('#password').val()
                },
                success: function (obj) {
                    if(obj.flag){
                        <%--if(/(Android)/i.test(navigator.userAgent)){--%>
                        <%--    Android.logOut();--%>
                        <%--}else if(( /(iPhone|iPad|iPod|iOS)/i.test(navigator.userAgent) )){--%>
                        <%--    try{--%>
                        <%--        window.webkit.messageHandlers.logOut.postMessage("");--%>
                        <%--    }--%>
                        <%--    catch(err) {--%>
                        <%--        logOut();--%>
                        <%--    }--%>
                        <%--}--%>
                        <%--else{--%>
                        <%--    if(seaUrl!=undefined&&seaUrl == 1){--%>
                        <%--        window.location.href = '/'--%>
                        <%--    }else{--%>
                        <%--        $.layerMsg({content:'<fmt:message code="url.th.PasswordChangesSucceeded" />！',icon:1},function(){--%>
                        <%--            location.reload();--%>
                        <%--        });--%>
                        <%--    }--%>
                        <%--}--%>
                        layer.closeAll()
                        layer.msg('修改成功')

                    }else{
                        $.layerMsg({content:'<fmt:message code="url.th.PasswordModificationFailed" />！',icon:2},function(){
//                                 location.reload();
                        });
                    }
                }
            });
        }else{
            $.layerMsg({content:'<fmt:message code="url.th.TwoPassword" />！',icon:0},function(){
                location.reload();
            });
        }

    });
    $('.Seven').on("click",function(){
        var USER_DEPT_ORDER = false
        if($('.tab table input[type="checkbox"]:checked').length==0){
            $.layerMsg({content:'<fmt:message code="sys.th.PleaseFirst" />',icon:2})
            return;
        } else if($('.tab table input[type="checkbox"]:checked').length>1) {
            $.layerMsg({content:'只能选择1条数据',icon:2})
            return;
        } else {
            var deptId = $('.tab table tbody [type="checkbox"]:checked').parent().parent().find('td').eq(4).attr('data-deptid');
                $('.header .USER').html('用户查询');
                $('#reload').hide();
                var queryIndex = layer.load(1, {shade: [0.1,'#fff'] }); //0代表加载的风格，支持0-2
                $('.tab').find('.userData').remove();
                $.ajax({
                    type: 'post',
                    url: '/user/queryExportUsers',
                    dataType: 'json',
                    data: {
                        deptId:deptId,
                        moduleId:moduleId
                    },
                    success:function(rsp){
                        layer.close(queryIndex);
                        if(rsp.flag){
                            searchData = data;
                            var data1=rsp.obj;
                            var str='';
                            for(var i=0;i<data1.length;i++){
                                var colorNum='';
                                var lastVisitTime='';
                                if(data1[i].password=='') {
                                    colorNum = 'colorRed'
                                }
                                if(data1[i].notLogin==1){
                                    colorNum='colorddd'
                                }
                                if(data1[i].lastVisitTime!=undefined){
                                    lastVisitTime=data1[i].lastVisitTime
                                }

                                str += '<tr class="userData '+colorNum+'" uId="' + data1[i].uid + '">' +
                                    '<td>'+function(){
                                        if(data1[i].byname=='admin'){
                                            return ''
                                        }else{
                                            return '<input type="checkbox" class="checkChild" name="checkbox" value="" style="width:13px;height:13px;" />'
                                        }
                                    }()+'</td>' +
                                    '<td>' + data1[i].userId + '</td>' +
                                    '<td>' + data1[i].byname + '</td>' +
                                    '<td>' + data1[i].userName + '</td>' +
                                    '<td data-deptid="'+data1[i].deptId+'">' + data1[i].deptName + '</td>' +
                                    '<td>' +function () {
                                        if(data1[i].dutyTypeName==undefined){
                                            return "";
                                        }else {
                                            return data1[i].dutyTypeName
                                        }
                                    }()  + '</td>' +

                                    '<td>' + data1[i].userPrivName + '</td>' +
                                    '<td>' +function () {
                                        switch (parseInt(data1[i].postPriv)) {
                                            case 1:
                                                return '<fmt:message code="url.th.all" />';
                                                break
                                            case 2:
                                                return '<fmt:message code="sys.th.DesignatedDepartment" />';
                                                break
                                            case 0:
                                                return '<fmt:message code="sys.th.ThisDepartment" />';
                                                break
                                            default:
                                                return '';
                                                break;
                                        }

                                    }()  + '</td>' +
                                    '<td>' + lastVisitTime + '</td>' +
                                    '<td>' + data1[i].idleTime + '</td>' +
                                    '<td>'+function(){
                                        if(data1[i].uid==''){
                                            return ''
                                        }else{
                                            var str='<a href="javascript:void(0)" onclick="clickrenwu('+data1[i].uid+',this)" style="margin-right: 5px;"><fmt:message code="global.lang.edit" /></a>'
                                            if (USER_DEPT_ORDER) {
                                                str += '<a href="javascript:;" userid="'+data1[i].userId+'" name="'+data1[i].userName+'" onclick="userDeptOrder(this)">部门排序</a>'
                                            }
                                            return str
                                        }

                                    }()+'</td>' +
                                    '</tr>';  //<a href="javascript:;">
                                <%--<fmt:message code="userManagement.th.MenuAauthority" />--%>
                                //</a>:菜单权限查看

                            }
                            $('.totalNum').html(rsp.obj.length);
                            $('.tr_befor').after(str);
                            $('.userData').on("click",function(){
                                var inCh=$(this).find('.checkChild').prop('checked');
                                if(inCh == true){
                                    $(this).find('.checkChild').prop('checked',true);
                                    $(this).addClass('bgColor');
                                }else{
                                    $('#checkedAll').prop('checked',false);
                                    $(this).find('.checkChild').prop('checked',false);
                                    $(this).removeClass('bgColor');
                                }
                                var child = $(".checkChild");
                                for(var i=0;i<child.length;i++){
                                    var childstate= $(child[i]).prop("checked");
                                    if(inCh!=childstate){
                                        return
                                    }
                                }
                                $('#checkedAll').prop("checked",inCh);
                            });
                            $('.content .right').css("display","block");
                            $('.rightMain').css("display","none");
                        }else{
                            layer.msg('查询失败');
                        }


                    }
                })
            }
    })
    })
    function imgDown_s(deptNum, me) {
        if ($(me).attr('data-types') == undefined) {
            $(me).find('#fenzhi').attr('src', $(me).find('#fenzhi').attr('src') == '/img/sys/dapt_right.png' ? '/img/sys/dapt_down.png' : '/img/sys/dapt_right.png');
            if ($(me).find('#fenzhi').attr('src') == '/img/sys/dapt_right.png') {
                $(me).find('#fenzhi').css({"margin-top": "-3px", "margin-right": "4px", "margin-left": ""});
                $(me).find('#fenzhi').width(8);
                $(me).find('#fenzhi').height(14);
                $(me).next().hide();
                // $(me).next().html('')
            } else if ($(me).find('#fenzhi').attr('src') == '/img/sys/dapt_down.png') {
                $(me).find('#fenzhi').css({"margin-top": "-3px", "margin-right": "4px", "margin-left": "-5px"});
                $(me).find('#fenzhi').width(14);
                $(me).find('#fenzhi').height(9);
                $(me).next().show();
            }
        } else {
            $(me).find('#fenzhi').attr('src', $(me).find('#fenzhi').attr('src') == '/img/sys/dapt_right.png' ? '/img/sys/dapt_down.png' : '/img/sys/dapt_right.png');
            if ($(me).find('#fenzhi').attr('src') == '/img/sys/dapt_right.png') {
                $(me).find('#fenzhi').width(8);
                $(me).find('#fenzhi').height(14);
            } else if ($(me).find('#fenzhi').attr('src') == '/img/sys/dapt_down.png') {
                $(me).find('#fenzhi').width(14);
                $(me).find('#fenzhi').height(9);
            }
            if ($(me).attr('data-types') == '1') {
                $(me).next().show();
                $(me).attr('data-types', '2')
            } else if ($(me).attr('data-types') == '2') {
                $(me).next().hide();
                $(me).attr('data-types', '1')
            }
        }

        $('#btn').attr('data_id', deptNum);

        if ($(me).attr('data-numstring') == 1) {
            if (boolTwo) {
                if ($(me).next().css('display') == 'none') {
                    return;
                }
                $.loadroleUser($(me).next(), deptNum, $(me).attr('data-numtrue'),null,11);
            } else {
                $.loadSidebar($(me).next(), deptNum,null,11)
            }
        }
        if ($(me).next().html() == '') {
            if (boolTwo) {
                $.loadroleUser($(me).next(), deptNum, $(me).attr('data-numtrue'), function () {
                    if (departments) {
                        $.loadSidebar($(me).next(), deptNum,null,11)
                    }
                },11)
            }

        }
        if ($(me).attr('data-numstring') == 2) {
            if (numstring) {
                $.loadSidebar($(me).next(), deptNum,null,11)
            }
        }

    }
</script>
</body>
</html>
