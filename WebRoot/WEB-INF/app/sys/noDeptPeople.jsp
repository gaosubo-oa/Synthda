<%--
  Created by IntelliJ IDEA.
  User: zhangyuan
  Date: 2020-04-27
  Time: 13:22
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
    <link rel="stylesheet" type="text/css" href="../css/base.css"/>
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
            text-align: center;
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
            /*overflow-x:auto;*/
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

        td{
            font-size: 11pt;
        }
        .liUp{
            color:#000;
        }
        .content .right{
            overflow-y: inherit;
        }
        #downChild li{
            width: 1000px;
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
        }
        .content .left .collect .spanUP{
            color: #000;
            font-size: 14px;
        }
        #downChild li>span{
            font-size: 14px;
        }

        .content .left .collect{
            height: auto;
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
    </style>
    <link rel="stylesheet" type="text/css" href="/css/commonTheme/${sessionScope.InterfaceModel}/commonTheme.css"/>
    <script type="text/javascript" src="../js/xoajq/xoajq3.js"></script>
    <script src="/js/jquery/jquery-migrate-3.4.0.js"></script>
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
        .content .right{
            width: 100%;
            margin-top: 0;
        }
        #saveNoDept{
            height: 33px;
            line-height: 28px;
            color: #fff;
            background: #2b7fe0;
            border-radius: 6px;
            font-size: 12pt;
            width: 100px;
            cursor: pointer;
        }
    </style>
</head>
<body>
<div class="content clearfix">
    <div class="right">
        <div class="header">
            <img src="/img/commonTheme/theme6/batchSetDept.png" style="margin-left: 11px;"/>
            <span class="USER" style="font-size: 20px;font-weight: 700;"><fmt:message code="userManagement.th.Unallocated" /></span><span class="post newDept"></span>
            <%--<span id="noEditDept" style="color: red;position: absolute;right: 29%">指定部门(指定后无法修改)</span>
            <textarea  type="text" name="noDept" id="noDept" readonly  style="background:#e7e7e7;text-indent:1em;border-radius: 4px;float: right;margin-top: 4px;margin-right: 24%;display: none"></textarea>
            <a href="javascript:;" style="color:#1E9FFF;margin-left:10px;float: right;margin-top: 7px;margin-right: -15%;display: none" class="noDeptAdd">添加</a>
            <a href="javascript:;" style="color:#1E9FFF;margin-left:5px;float: right;margin-top: 7px;margin-right: -18%;display: none" class="noDeptDel">清空</a>
            <input type="button" class="new_liucheng" name="btn" id="saveNoDept" style="right: 80px;top: 50px;height: 33px;line-height: 28px;display: none" value="保存">--%>
<%--            <span style="margin-left: 10px;">共有<span style="color: #ff0000;margin: 0 5px;" class="totalNum"></span>条记录</span>--%>
            <div id="Confidential" style="display: inline-block"></div>
        </div>
        <div class="title">
            <span class="USER"><fmt:message code="main.usermanage" /></span><span class="post currentDept"></span>
            <select name="allUser" id="allSelUser">
                <option value=""><fmt:message code="userManagement.th.AllUser" /></option>
                <option value="0"><fmt:message code="userManagement.th.AllowIogonUser" /></option>
                <option value="1"><fmt:message code="userManagement.th.NoIogonUser" /></option>
            </select>
            <span class="explain"><fmt:message code="userManagement.th.Explanation" /></span>
            <div style="display: flex;float: right;margin-right: 2%">
                <div id="noEditDept" style="color: red;margin-top: 13px;"><fmt:message code="userManagement.th.DesignatedDepartmentTip" /></div>
                <div style="margin: 0px 15px;">
                    <textarea  type="text" name="noDept" id="noDept" readonly  style="background:#e7e7e7;text-indent:1em;border-radius: 4px;margin-top: 4px"></textarea>
                    <a href="javascript:;" style="color:#1E9FFF;margin-left: 10px" class="noDeptAdd"><fmt:message code="global.lang.add" /></a>
                    <a href="javascript:;" style="color:#1E9FFF;margin-left: 10px" class="noDeptDel"><fmt:message code="global.lang.empty" /></a>
                </div>
                <div>
                    <input type="button" name="btn" id="saveNoDept" style="margin-top: 6px;"  value="保存">
                </div>
            </div>
        </div>
        <div class="tab">
            <table cellspacing="0" cellpadding="0" style="border-collapse:collapse;">
                <tr class='tr_befor'>
                    <th width="4%">

                    </th>
                    <th width="8%"><fmt:message code="userName" /></th>
                    <th width="8%"><fmt:message code="userManagement.th.Realname" /></th>
                    <th width="8%"><fmt:message code="userManagement.th.department" /></th>
<%--                    <th width="8%"><fmt:message code="userManagement.th.Scheduling" /></th>--%>
                    <th width="14%"><fmt:message code="userManagement.th.role" /></th>
                    <%--<th width="8%"><fmt:message code="userManagement.th.ManagementScope" /></th>--%>
                    <th width="18%"><fmt:message code="userManagement.th.LastAccess" /></th>
                    <th width="8%"><fmt:message code="userManagement.th.idle" /></th>
                    <th width="16%"><fmt:message code="notice.th.operation" /></th>
                </tr>

            </table>
        </div>
        <div class="bottom w clearfix">
            <div class="checkALL">
                <input id="checkedAll" type="checkbox" name="" value="" >
                <label for="checkedAll" style="font-size: 14px;"><fmt:message code="notice.th.allchose" /></label>
            </div>
            <div class="boto">
                <div class="ONE" href="javascript:void(0)"><span><fmt:message code="global.lang.delete" /></span></div>
            </div>
            <div class="boto">
                <div class="TWO" href="javascript:void(0)"><span><fmt:message code="userManagement.th.Emptylong" /></span></div>
            </div>
            <div class="boto">
                <div class="THREE" href="javascript:void(0)"><span><fmt:message code="userManagement.th.Emptypassword" /></span></div>
            </div>
            <div class="boto">
                <div class="FOUR" href="javascript:void(0)"><span><fmt:message code="userManangement.th.Nologin" /></span></div>
            </div>
            <%--<div class="boto">
                <div class="FIVE" href="javascript:void(0)"><span><fmt:message code="userManagement.th.Remind" /></span></a>
            </div>--%>
            <div class="boto">
                <div class="SIX" href="javascript:void(0)"><span><fmt:message code="userManagement.th.BatchExchangeDepartment" /></span></div>
            </div>

        </div>
    </div>
</div>
<script type="text/javascript">
    var moduleId = 11;
    //未分配部门人员
    var noDeptDeptId
    $.ajax({
        type: 'post',
        url: '/department/selectUnallocated?moduleId='+moduleId,
        dataType: 'json',
        async:false,
        success:function(res) {
            if(res.msg=='false'){
                $('#noEditDept').show()
                $('#noDept').show()
                $('.noDeptAdd').show()
                $('.noDeptDel').show()
                $('#saveNoDept').show()
                $('.tab').find('.userData').remove();
                $('.content .right').css("display","block");
                $('.content .rightMain').css("display","none");
            }else{
                $('#noEditDept').hide()
                $('#noDept').hide()
                $('.noDeptAdd').hide()
                $('.noDeptDel').hide()
                $('#saveNoDept').hide()
                var datas={
                    'deptId':res.object.deptId,
                    'notLogin':$('#allSelUser').val()
                };
               /* if($('#allSelUser').val()==undefined || $('#allSelUser').val()==''){
                    searchData.notLogin =null;
                }*/
                noDeptDeptId=res.object.deptId
                deptById(datas,$('.tr_befor'));
            }
        }
    })
    //未分配部门的添加
    $(".noDeptAdd").on("click",function(){
        dept_id = 'noDept';
        $.popWindow("/common/selectDept?0");
    });
    //未分配部门的删除
    $('.noDeptDel').on("click",function () {
        $('#noDept').attr("deptid","");
        $('#noDept').attr("deptno","");
        $('#noDept').val("");
    });
    var dimission = 0;
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
        data.moduleId = moduleId;
        $.ajax({
            url:'../user/queryExportUsers',
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
                    '                    <th width="8%"><fmt:message code="userName" /></th>\n' +
                    '                    <th width="8%"><fmt:message code="userManagement.th.Realname" /></th>\n' +
                    '                    <th width="8%"><fmt:message code="userManagement.th.department" /></th>\n' +
                    // '                    <th width="8%">排班</th>\n' +
                    '                    <th width="14%"><fmt:message code="userManagement.th.role" /></th>\n' +
                    // '                    <th width="8%">管理范围</th>\n' +
                    '                    <th width="8%"><fmt:message code="userDetails.th.post" /></th>\n' +
                    '                    <th width="18%"><fmt:message code="userManagement.th.LastAccess" /></th>\n' +
                    '                    <th width="8%"><fmt:message code="userManagement.th.idle" /></th>\n' +
                    '                    <th width="16%"><fmt:message code="notice.th.operation" /></th>\n' +
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
                        '<td userid="'+ data1[i].userId +'">' + data1[i].byname + '</td>' +
                        '<td>' + data1[i].userName + '</td>' +
                        '<td data-deptid="'+data1[i].deptId+'">' + data1[i].deptName + '</td>' +
                        <%--'<td>' + function () {--%>
                        <%--    switch (data1[i].dutyType) {--%>
                        <%--        case 1:--%>
                        <%--            return '<fmt:message code="sys.th.RegularClass" />';--%>
                        <%--            break;--%>
                        <%--        case 2:--%>
                        <%--            return '<fmt:message code="sys.th.Whole-day" />';--%>
                        <%--            break;--%>
                        <%--        case 99:--%>
                        <%--            return '<fmt:message code="sys.th.ShiftSystem" />';--%>
                        <%--            break;--%>
                        <%--        default:--%>
                        <%--            return ""--%>
                        <%--    }--%>

                        <%--}() + '</td>' +--%>
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
                            if(data1[i].byname==''){
                                return '';
                            }else{
                                var str = '<a href="javascript:void(0)" onclick="clickrenwu('+data1[i].uid+',this)" style="margin-right: 5px;"><fmt:message code="global.lang.edit" /></a>'

                               /* if (USER_DEPT_ORDER) {
                                    str += '<a href="javascript:;" userid="'+data1[i].userId+'" name="'+data1[i].userName+'" onclick="userDeptOrder(this)">部门排序</a>'
                                }*/

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
    function clickrenwu(deptId,me) {
        userstr=$(me).text();
        window.open('../addUsers?'+deptId,'<fmt:message code="sys.th.EditUser" />');
    }
    $(function () {
        $('.rightMain ').height($(document).height()-46);
        window.onresize=function(){
            $('.rightMain ').height($(document).height()-46);
            $('.left ').height($(document).height()-46);
        }
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
            if($(this).parent().prev().find('.USER').text()=='未分配部门人员'){
                searchData.deptId=noDeptDeptId
            }
            deptById(searchData,$('.tr_befor'),function () {
                dimission = 0;
            })

        });
       /* //未分配部门人员
        $('.noDept').click(function () {
            dimission = 1;
            $.ajax({
                type: 'post',
                url: '/department/selectUnallocated',
                dataType: 'json',
                async:false,
                success:function(res) {
                    if(res.msg=='false'){
                        $('#noEditDept').show()
                        $('#noDept').show()
                        $('.noDeptAdd').show()
                        $('.noDeptDel').show()
                        $('#saveNoDept').show()
                        $('.tab').find('.userData').remove();
                        $('.content .right').css("display","block");
                        $('.content .rightMain').css("display","none");
                    }else{
                        $('#noEditDept').hide()
                        $('#noDept').hide()
                        $('.noDeptAdd').hide()
                        $('.noDeptDel').hide()
                        $('#saveNoDept').hide()
                        var datas={
                            'deptId':res.object.deptId,
                            'notLogin':$('#allSelUser').val()
                        };
                        if($('#allSelUser').val()==undefined || $('#allSelUser').val()==''){
                            searchData.notLogin =null;
                        }
                        noDeptDeptId=res.object.deptId
                        deptById(datas,$('.tr_befor'));
                    }
                }
            })
        })*/
        //未分配部门人员的保存按钮
        $('#saveNoDept').on('click',function () {
            if($('#noDept').attr('deptid')=='' || $('#noDept').attr('deptid')==undefined){
                layer.msg('请选择部门！',{icon:0})
                return false
            }
            $.ajax({
                type: 'post',
                url: '/department/updateDept',
                dataType: 'json',
                data:{deptId:$('#noDept').attr('deptid').substring(0,$('#noDept').attr('deptid').length-1),moduleId:moduleId},
                success:function(res) {
                    if(res.flag){
                        layer.msg(res.msg)
                        var datas={
                            'deptId':$('#noDept').attr('deptid'),
                            'notLogin':$('#allSelUser').val()
                        };
                        deptById(datas,$('.tr_befor'));
                        window.location.reload()
                    }
                }
            })
        })
        // 批量设置
        $('.editUserBatch').on("click",function () {
            $('.content .right').css("display","none");
            $('.rightMain').css("display","block");
            $('.rightMain iframe').attr("src","../user/goEditUserBatch");
        });
        //动态密码卡管理
        $('.passwordCard').on("click",function () {
            $('.content .right').css("display","none");
            $('.rightMain').css("display","block");
            $('.rightMain iframe').attr("src","../user/passwordCard");
        });
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
                                $.layerMsg({content:'<fmt:message code="sys.th.PleaseFirst" />',icon:1})
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
        //清空密码按钮
        $('.THREE').on("click",function(){
            if($('.tab table input[type="checkbox"]:checked').length==0){
                $.layerMsg({content:'<fmt:message code="sys.th.PleaseFirst" />',icon:1})
                return
            }
            buttonInterface('../user/clearPassword','<fmt:message code="sys.th.VerifyPassword" />？');
        })
        //禁止登录按钮
        $('.FOUR').on("click",function(){
            if($('.tab table input[type="checkbox"]:checked').length==0){
                $.layerMsg({content:'<fmt:message code="sys.th.PleaseFirst" />',icon:1})
                return
            }
            buttonInterface('../user/setNotLogin','<fmt:message code="sys.th.MakeSure" />？');
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
                    '<table>' +
                    '<tr><td style="border-right: 1px solid #ddd"><fmt:message code="main.usermanage" />:</td><td><textarea style="margin-right: 10px;" name="" id="textareaopen"></textarea><a href="javascript:void(0)" class="addopens"><fmt:message code="global.lang.add" /></a></td></tr>' +
                    '<tr><td style="border-right: 1px solid #ddd"><fmt:message code="sys.th.NewSector" />:</td><td><select style="width: 139px;margin-left: -28px;" name="" id="newselectrrole"></select></td></tr>' +
                    '<tr><td style="border-right: 1px solid #ddd"><fmt:message code="sys.th.ReminderDepartment" />:</td><td><label style="margin-right: 10px;"><input name="checktit" type="checkbox"><fmt:message code="notice.th.remindermessage" /></label>' +
                    '<label><input name="checktit" type="checkbox"><fmt:message code="sys.th.SendReminderMessage" /></label></td></tr></table></div>',
                area:['500px','300px'],
                btn:['<fmt:message code="global.lang.ok" />','<fmt:message code="depatement.th.quxiao" />'],
                yes:function (index) {
                    var obj={
                        'deptId':$('#newselectrrole').val(),
                        'uids':$('#textareaopen').attr('dataid'),
                        'nowDeptId':$('.userData').eq(0).find('td').eq(3).attr('data-deptid')
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
                            $('#newselectrrole').val($('.tab table tbody [type="checkbox"]:checked').parent().parent().find('td').eq(3).attr('data-deptid'))
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
        //列表功能按钮
        function buttonInterface(URL,txt){
            var deptid=$('.collect .add_back').attr('deptid');
            var val=$('#allSelUser option:checked').val();
            var string='';
            $('.tab table input[type="checkbox"]:checked').each(function(i,n){
                string+=$(this).parent().parent().attr('uId')+',';
            })
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
                            deptById(searchData,$('.tr_befor'))

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
                    }
                })
            })
        }
    })
    function userDeptOrder(ele){
        var loadIndex = layer.load(2);
        var userId = $(ele).attr('userid');
        var layerIndex = layer.open({
            title: $(ele).attr('name')+'的部门排序',
            type: 1,
            area: ['600px', '500px'],
            btn: ['确认', '取消'],
            content: '<div class="dept_order_box" style="padding: 8px"><table><thead><tr><th>部门</th><th>排序</th><th>职务</th></tr></thead><tbody id="deptOrderTable"></tbody></table></div>',
            success: function (){
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
                            $str = $('<tr orderId="'+order.orderId+'" deptId="'+order.deptId+'" userId="'+userId+'"><td>'+order.deptName+'</td><td><input class="layui-input order_no" type="text" value="'+order.orderNo+'"></td><td><select>'+option+'<select></td></tr>')
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
    $.ajax({
        type:'get',
        url:'/syspara/selectTheSysPara?paraName=IS_SHOW_JMJ',
        dataType:'json',
        success:function (res) {
            var data=res.object[0]
            if (data.paraValue!=0){
                $('#Confidential').append('<span style="color: red;font-family: Microsoft YaHei;font-weight: bolder;font-size: 16pt;margin-left: 20px;margin-top: 10px;"> 机密级★ </span>')
            }
        }
    })
</script>
</body>
</html>

