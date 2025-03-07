<%--
  Created by IntelliJ IDEA.
  User: liruixu
  Date: 2017/6/13
  Time: 11:14
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="mvc" uri="http://www.springframework.org/tags/form" %>
<%@taglib prefix="fmt" uri="http://www.springframework.org/tags" %>
<html>
<head>
    <title><fmt:message code="main.roleandpriv" /></title>
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <link rel="stylesheet" href="/css/dept/roleAuthorization.css?20210311.1">
    <link rel="stylesheet" href="/lib/layui/layui/css/layui.css?20210319.1">
    <link rel="stylesheet" href="/lib/layui/layui/css/eleTree.css">
    <script src="/js/common/language.js"></script>
    <script type="text/javascript" src="/js/xoajq/xoajq3.js"></script>
    <script src="/js/jquery/jquery-migrate-3.4.0.js"></script>
    <script src="/js/jquery/jquery.cookie.js"></script>
    <script type="text/javascript" src="/lib/layer/layer.js?20201106"></script>
    <script type="text/javascript" src="/js/base/base.js"></script>
    <script src="/js/jquery/jquery.form.min.js"></script>
    <script src="/js/UserPriv/roleAuthorization.js?20230424.1"></script>
    <script type="text/javascript" src="/lib/layui/layui/layui.all_v2.5.js"></script>
    <script type="text/javascript" src="/js/base/base.js"></script>
    <script type="text/javascript" src="/lib/layui/layui/global.js?20201229.1"></script>
    <script type="text/javascript" src="/lib/layui/layui/lay/mymodules/tableFilter.js"></script>
    <script type="text/javascript" src="/lib/layui/layui/lay/mymodules/tableChild.js"></script>
    <script type="text/javascript" src="/lib/layui/layui/lay/mymodules/tableMerge.js"></script>
    <script src="/lib/layui/layui/js/common.js?v=20190726" type="text/javascript" charset="utf-8"></script>
    <style>
        .headDiv {

            background: #f5f5f5;
            width: 100%;
            height: 45px;
            border-bottom: #999 1px solid;
            overflow: hidden;
        }
        .div_Img {
            float: left;
            width: 23px;
            height: 100%;
            margin-left: 30px;
        }
        .div_Img img {
            width: 23px;
            height: 23px;
            margin-top: 11px;
        }
        .divP {
            float: left;
            height: 45px;
            line-height: 45px;
            font-size: 22px;
            margin-left: 10px;
            color: #494d59;
        }
        .big3{
              margin-left: 5px;
              font-family: Microsoft yahei,Helvetica Neue,Helvetica,PingFang SC,Tahoma,Arial,sans-serif;
              font-size: 20px;
              color: #494d59;
              FONT-WEIGHT: normal;
        }
        .Big img{
            float: left;
            margin-top: 3px;
            margin-right: 5px;
            padding-left: 20px;
        }
        .head li{
            margin-left: 10px;
        }
        .head .headli1_2{
            /*margin-left: 15px;*/
            margin-top: -5px;
        }
        .layui-layer{
            top:200px;
        }
        .th{
            font-size: 11pt;
        }
        .newJuese{
            display: inline-block;
            width: 100px;
            height: 28px;
            line-height: 28px;
            border-radius: 3px;
            background: #2b7fe0;
            color: #ffffff;
            text-align: center;
            cursor: pointer;
        }
        .layui-layer{
            top:200px!important;
        }
        .lefts{
            width: 15%;
            display: inline-block;
            float: left;
            border-right: 1px solid black;
        }
        .rights{
            width: 84%;
            display: inline-block;
        }
        .one_name{
            font-size: 12pt;
            font-weight: 400;
        }
        .tab_cone li .one_all:hover{
            background: #b6e0ff !important;
        }
        .one_all li:hover{
            background:#ccebff;
            cursor:pointer;
        }
        .one_all li:hover h1{
            color:#2f8ae3;
        }
        .one_all{
            padding-top: 15px;
            border: none;
            border-bottom: none;
            background: #f5f7f8 ;
            border-top: 2px solid #fff!important;
        }
        .one_all{
            height: 40px !important;
            width: 100% !important;
            border-left: none !important;
            border-right: none !important;
        }
        .one_all{
            background: #f0f4f7 ;
            position: relative;
        }
        .one_alltwo{
            background: #fff!important;
            height: 40px !important;
            width: 100% !important;
            border-left: none !important;
            border-right: none !important;
            border: none;
            border-bottom: none;
            border-top: 2px solid #fff!important;
            margin-top: 0%;
        }
        .one_alltwo h1{
            font-size: 18px;
            color: #2f8ae3;
        }
        .tab_cone li .one_all:hover{
            background: #b6e0ff !important;
        }
        .cont_left{
            overflow-y: auto;
            height: 100%;
            border: 0;
        }
        #top:hover{
            background-color: rgb(246,247,249) !important;
        }
    </style>
</head>
<body>
    <div id="loginAdmin">
        <input name="username" value="${sign}" type="hidden" />
        <%--<div class="navigation  clearfix" style="margin-top:0;">--%>
            <%--<div class="left">--%>
                <%--<img src="../img/key_03.png" alt="">--%>
                <%--<div class="news"><fmt:message code="roleAuthoorization.th.EnterSuperPassword" /></div>--%>
            <%--</div>--%>
        <%--</div>--%>
        <div class="headDiv">
            <div class="div_Img">
                <img src="/img/commonTheme/${sessionScope.InterfaceModel}/key_03.png" style="vertical-align: middle;" alt="输入超级密码">
            </div>
            <div class="divP"><fmt:message code="roleAuthoorization.th.EnterSuperPassword" /></div>
        </div>
        <table class="tr_td" width="50%" align="center" style="margin-top: 20px">
            <tbody>
                <tr>
                    <td class="th" colspan="2">
                        <b><fmt:message code="roleAuthorization.th.Explain" />：</b>

                        <fmt:message code="sys.th.superPassword" />

                    </td>
                </tr>
                <tr>
                    <td class="TableContent" style="width: 25%">
                     <fmt:message code="roleAuthorizzation.th.PleaseEnter" />：
                    </td>
                    <td class="TableData">
                        <input style="margin-left: 10px;width: 251px;" placeholder="<fmt:message code="roleAuthorizzation.th.PleaseEnter" />" type="password" id="super_pass" name="super_pass" class="inp" size="30" ><span class="super_pass_msg"></span>
                    </td>
                </tr>
                <td nowrap="" style="padding: 7px;" align="center" colspan="2">
                    <input class="import"  type="button" value="<fmt:message code="global.lang.ok" />">
                </td>
            </tbody>
        </table>
    </div>
    <div id="north" style="display: none;min-width: 1100px;">
        <div class="head w clearfix">
            <ul class="index_head clearfix">
                <li data_id="0">
                <span class="headli1_1 one">
                <a  href="roleAuthorization" data-Url="" ><fmt:message code="roleAuthorization.th.RoleMmanagement" /></a>
                </span><img class="headli1_2" src="../img/twoth.png" alt="">
                </li>

                <%--<li>--%>
                <%--<span class="headli1_1 ">--%>
                    <%--<a  href="newRole?0" data-Url="" ><fmt:message code="roleAuthorization.th.NewRole" /></a></span>--%>
                    <%--<img src="../img/twoth.png" alt="" class="headli1_2">--%>
                <%--</li>--%>
                <li data_id="1">
                  <span class="headli1_1">
                <a  href="adjustTheRole" data-Url="" ><fmt:message code="roleAuthorization.th.AdjustRoleSorting" /></a>
                </span><img class="headli1_2" src="../img/twoth.png" alt="">
                </li>
                <li data_id="1">
                  <span class="headli1_1">
                <a  href="modifyThePermissions?0" data-Url="" ><fmt:message code="roleAuthorization.th.Add-delete" /></a>
                </span><img class="headli1_2" src="../img/twoth.png" alt="">
                </li>
                <li data_id="1">
                  <span class="headli1_1">
                <a href="theAuxiliaryRole" data-Url="" ><fmt:message code="roleAuthorization.th.Add-remove" /></a>
                </span><img class="headli1_2" src="../img/twoth.png" alt="">
                </li>
                <li data_id="1">
                  <span class="headli1_1">
                <a  href="superPassword" data-Url="" ><fmt:message code="roleAuthorization.th.SuperPasswordSettings" /></a>
                </span><img class="headli1_2" src="../img/twoth.png" alt="">
                </li>
                <li data_id="1">
                  <span class="headli1_1">
                <a  href="theHumanResources" data-Url="" ><fmt:message code="roleAuthorization.th.HR" /></a>
                </span><img class="headli1_2" src="../img/twoth.png" alt="">
                </li>
                <li data_id="1">
                  <span class="headli1_1">
                <a  href="roleAndClassification" data-Url="" ><fmt:message code="roleAuthorization.th.RoleClassificationManagement" /></a>
                </span><img class="headli1_2" src="../img/twoth.png" alt="">
                </li>
            </ul>
        </div>
    </div>
    <div id="hiddenMain" class="clearfix" style="display: none">

        <div class="mainAdmin clearfix" >
            <div class="mainLeft" style="display: none">
                <div class="cont_left" id="cont_left">
                    <ul>
                        <li class="dept_li liUp" id="dept_lis"><img src="/img/commonTheme/${sessionScope.InterfaceModel}/icon_sectorList.png" style="vertical-align: middle;width: 15px;margin-right: 10px;" alt="部门列表"><fmt:message code="depatement.th.depa" /></li>
                        <li class="pick" style="display: none;">
                            <ul class="tab_ctwo a" id="deptOrg"><li><span deptid="30" class="childdept"><span class=""></span><a href="#" class="dynatree-title" title="北京公司"><fmt:message code="roleAuthorization.th.BJ" /></a></span><ul style="margin-left:10%;display:block;" id="dpetWhole"><li><span deptid="1" class="childdept"><span></span><img src="../img/main_img/company_logo.png" alt=""><a href="#" class="dynatree-title" title="董事会"><fmt:message code="roleAuthorization.th.Board" /></a></span><ul style="margin-left:10%;display:none;"></ul></li><li><span deptid="2" class="childdept"><span></span><img src="../img/main_img/company_logo.png" alt=""><a href="#" class="dynatree-title" title="管理部"><fmt:message code="roleAuthorization.th.ManagementDepartment" /></a></span><ul style="margin-left:10%;display:none;"></ul></li><li><span deptid="3" class="childdept"><span></span><img src="../img/main_img/company_logo.png" alt=""><a href="#" class="dynatree-title" title="市场部"><fmt:message code="roleAuthorization.th.MarketingDepartment" /></a></span><ul style="margin-left:10%;display:none;"></ul></li><li><span deptid="4" class="childdept"><span></span><img src="../img/main_img/company_logo.png" alt=""><a href="#" class="dynatree-title" title="销售部"><fmt:message code="roleAuthorization.th.SalesDepartment" /></a></span><ul style="margin-left:10%;display:none;"></ul></li><li><span deptid="15" class="childdept"><span></span><img src="../img/main_img/company_logo.png" alt=""><a href="#" class="dynatree-title" title="技术部"><fmt:message code="roleAuthorization.th.TechnologyDepartment" /></a></span><ul style="margin-left:10%;display:none;"></ul></li></ul></li></ul>
                        </li>
                        <li class="liUp dept_li"><img src="../img/sys/icon_departingStaff.png" style="vertical-align: middle;width: 15px;margin-right: 10px;" alt="离职人员/外部人员"><fmt:message code="userManagement.th.Outgoing" /></li>
                        <li class="liUp dept_li"><img src="../img/sys/icon_publicCustomGroup.png" style="vertical-align: middle;width: 15px;margin-right: 10px;" alt="公共自定义组"><fmt:message code="roleAuthorization.th.PublicCustom" /></li>
                        <li class="liUp dept_li"><img src="../img/sys/icon_fixDepartmentLevel.png" style="vertical-align: middle;width: 15px;margin-right: 10px;" alt="修正部门级别"><fmt:message code="roleAuthorization.th.FixDepartmentLevel" /></li>

                    </ul>
                </div>
            </div>
            <div class="mainRight" style="padding-top: 5px;margin-top: 47px;width: 100%">
                <table border="0" width="100%" cellspacing="0" cellpadding="3" class="tr_td " style="min-width: 756px">
                    <tbody><tr style="border: none" id="top">
                        <td class="Big">
                            <img src="/img/icon_rolemanage_06.png"  align="absmiddle">
                            <span class="big3"> <fmt:message code="roleAuthorization.th.RoleMmanagement" /></span>
                            <input type="text" id="privName" style="width: 150px;height: 32px;margin-right: 1%;margin-left: 3%" placeholder="<fmt:message code="roleAuthorization.th.PleaseEnterName" />">
                            <button type="button" class="layui-btn layui-btn-sm" id="search" style="height: 31px;line-height: 25px;margin-top: -4px;"><fmt:message code="roleAuthorization.th.query" /></button>
                            <button type="button" class="layui-btn layui-btn-sm" id="clear" style="height: 31px;line-height: 25px;margin-top: -4px;margin-right: 40px"><fmt:message code="roleAuthorization.th.clear" /></button>
                        </td>

                        <td align="right" style="position: relative">
                            <input type="button" value="<fmt:message code="workflow.th.Import" />" class="exportsss"  title="导入角色">
                            <input type="button" style="cursor: pointer;" class="fileload" title="<fmt:message code="workflow.th.Import" />" value="<fmt:message code="workflow.th.Import" />">
                            <a href="/outputUserPriv" style="display: inline-block"  class="importTwo"><fmt:message code="global.lang.report" /></a>
                            <a class="newJuese"><img style="margin-right: 4px;margin-bottom: 4px;" src="/img/mywork/newbuildworjk.png" alt=""><fmt:message code="roleAuthorization.th.NewRole" /></a>
                        </td>

                    </tr>
                    </tbody>
                </table>
                <div style="margin-top: 1%">
                    <div class="lefts">

                        <span style="display: inline-block;font-size: 22px;color:#2f8ae3;width: 95%;height: 50px;line-height: 50px;border-bottom: 1px solid #2f8ae3;padding-left: 15px">
                            <img style="width: 20px;height: 20px;vertical-align: text-bottom;margin-right: 10px;margin-left: 0;" src="/img/commonTheme/${sessionScope.InterfaceModel}/icon-01.png"><fmt:message code="roleAuthorization.th.RoleClassification" /></span>
                        <div class="cont_left">
                            <ul class="all_ul">
                                <div class="tab_c list">

                                    <ul class="tab_cone a yiji" style="background: #fff;">

                                    </ul>
                                </div>
                            </ul>
                        </div>
                    </div>
                    <div class="rights">
                        <table id="table_style" width="96%" class="tr_td trtd_d" style="margin-left: 30px;">
                            <thead class="TableHeader">
                            <tr><td nowrap="" class="th" align="center"><fmt:message code="roleAuthorization.th.RoleSortingNumber" /></td>
                                <td nowrap="" class="th" align="center"><fmt:message code="roleAuthorization.th.RoleName" /></td>
                                <td nowrap="" class="th" align="center"><fmt:message code="roleAuthorization.th.RoleClassification" /></td>
                                <%--<td nowrap="" class="th"  align="center"><fmt:message code="workflow.th.sector" /></td>--%>
                                <td nowrap="" class="th" align="center"><fmt:message code="roleAuthorization.th.TotalNumber" /></td>
                                <td nowrap="" class="th" align="center"><fmt:message code="notice.th.operation" /></td>
                            </tr></thead>
                            <tbody>

                            </tbody>
                        </table>
                    </div>

                </div>
            </div>
        </div>
    </div>
    <script>
        var privTypeId;
        $(function () {

            $("#privName").on("keypress",function(e){
                if(e.keyCode == '13'){
                    $('#search').click();
                }
            });

            $('#clear').on("click",function(){
                if($('#privName').val()!=''){
                    $('#privName').val("");
                    $.ajax({
                        type: 'get',
                        url: '/getAllUserPriv',
                        dataType: 'json',
                        success: function (date) {
                            var str='';
                            var data=date.obj

                            for(var i=0;i<data.length;i++){
                                var color_str = '';
                                if (data[i].userPriv ==1 ){
                                    color_str = 'style="color:red"';
                                }
                                str+='<tr>' +
                                    '<td nowrap="" align="center" width="60">'+data[i].privNo+'</td>' +
                                    '<td nowrap="" align="center" '+color_str+' >'+data[i].privName+'</td>' +
                                    '<td nowrap="" align="center" '+color_str+' >'+function () {
                                        if(data[i].privTypeName == undefined){
                                            return '<fmt:message code="roleAuthorization.th.Unclassified" />';
                                        }else{
                                            return data[i].privTypeName
                                        }
                                    }()+'</td>' +
                                    // '<td nowrap="" align="center">'+data[i].privDeptId+'</td>' +
                                    '<td nowrap="" align="center">'+data[i].showCount+'  &nbsp;&nbsp; <a target="_blank" href="userPriv/show_users?userPriv='+data[i].userPriv+'&privName="  data-url=""> '+'<fmt:message code="roleAuthorization.th.ViewDetails" />'+'</a> </td>' +
                                    '<td nowrap="" align="center"> <a href="modifyThePermissions?'+data[i].userPriv+'"  data-url=""> '+permissions+'</a>&nbsp;&nbsp;'+
                                    // '<a href="newRole?'+data[i].userPriv+'" data-url=""> '+edit1+'</a>&nbsp;&nbsp;'+
                                    '<span data-id="'+data[i].userPriv+'" class="editData" style="color: #1687cb;cursor: pointer" data-url="" onclick="editData($(this))"> '+edit1+'</span>&nbsp;&nbsp;'+
                                    '<a href="cloning?'+data[i].userPriv+'" data-url="">'+clone+'</a>&nbsp;&nbsp;'+
                                    '<span id="delete_priv" onclick="delete_priv(this,'+data[i].userPriv+',\''+data[i].showCount+'\')" style="color: #1687cb;cursor: pointer"> '+function () {
                                        if(data[i].userPriv==undefined || data[i].userPriv==1){return ''}
                                        else {
                                            return ''+del+''
                                        }
                                    }()+'</span>'+
                                    '</td>' +
                                    '</tr>'
                            }/*<a href="javascript:viod(0)">查看详情</a>*/
                            // if(data[i].userPriv==1){
                            //     $('#delete_priv').attr('text','')
                            // }
                            $('#table_style tbody').html(str)
                        }
                    })
                }
            });
            $('#search').on("click",function(){
                var privName = $('#privName').val();
                if(privName == ''){
                    $.ajax({
                        type: 'get',
                        url: '/getAllUserPriv',
                        dataType: 'json',
                        success: function (date) {
                            var str='';
                            var data=date.obj

                            for(var i=0;i<data.length;i++){
                                var color_str = '';
                                if (data[i].userPriv ==1 ){
                                    color_str = 'style="color:red"';
                                }
                                str+='<tr>' +
                                    '<td nowrap="" align="center" width="60">'+data[i].privNo+'</td>' +
                                    '<td nowrap="" align="center" '+color_str+' >'+data[i].privName+'</td>' +
                                    '<td nowrap="" align="center" '+color_str+' >'+function () {
                                        if(data[i].privTypeName == undefined){
                                            return '<fmt:message code="roleAuthorization.th.Unclassified" />';
                                        }else{
                                            return data[i].privTypeName
                                        }

                                    }()+'</td>' +
                                    // '<td nowrap="" align="center">'+data[i].privDeptId+'</td>' +
                                    '<td nowrap="" align="center">'+data[i].showCount+'  &nbsp;&nbsp; <a target="_blank" href="userPriv/show_users?userPriv='+data[i].userPriv+'&privName="  data-url=""> '+'<fmt:message code="roleAuthorization.th.ViewDetails" />'+'</a> </td>' +
                                    '<td nowrap="" align="center"> <a href="modifyThePermissions?'+data[i].userPriv+'"  data-url=""> '+permissions+'</a>&nbsp;&nbsp;'+
                                    // '<a href="newRole?'+data[i].userPriv+'" data-url=""> '+edit1+'</a>&nbsp;&nbsp;'+
                                    '<span data-id="'+data[i].userPriv+'" class="editData" style="color: #1687cb;cursor: pointer" data-url="" onclick="editData($(this))"> '+edit1+'</span>&nbsp;&nbsp;'+
                                    '<a href="cloning?'+data[i].userPriv+'" data-url="">'+clone+'</a>&nbsp;&nbsp;'+
                                    '<span id="delete_priv" onclick="delete_priv(this,'+data[i].userPriv+',\''+data[i].showCount+'\')" style="color: #1687cb;cursor: pointer"> '+function () {
                                        if(data[i].userPriv==undefined || data[i].userPriv==1){return ''}
                                        else {
                                            return ''+del+''
                                        }
                                    }()+'</span>'+
                                    '</td>' +
                                    '</tr>'
                            }/*<a href="javascript:viod(0)">查看详情</a>*/
                            // if(data[i].userPriv==1){
                            //     $('#delete_priv').attr('text','')
                            // }
                            $('#table_style tbody').html(str)

                        }
                    })
                }else {
                    $.ajax({
                        type: 'get',
                        url: '/userPriv/getUserPrivsByPrivName',
                        data:{
                            privName:privName
                        },
                        dataType: 'json',
                        success: function (date) {
                            // if(userPriv)
                            var str='';
                            var data=date.obj

                            for (var i = 0; i < data.length; i++) {
                                $("[name='priv']").append('<option value="' + data[i].userPriv + '">' + data[i].privName + '</option>');
                            }
                            for(var i=0;i<data.length;i++){

                                var color_str = '';
                                if (data[i].userPriv ==1 ){
                                    color_str = 'style="color:red"';
                                }
                                str+='<tr>' +
                                    '<td nowrap="" align="center" width="60">'+data[i].privNo+'</td>' +
                                    '<td nowrap="" align="center" '+color_str+' >'+data[i].privName+'</td>' +
                                    '<td nowrap="" align="center" '+color_str+' >'+function () {
                                        if(data[i].privTypeName == undefined){
                                            return '<fmt:message code="roleAuthorization.th.Unclassified" />';
                                        }else{
                                            return data[i].privTypeName
                                        }

                                    }()+'</td>' +
                                    // '<td nowrap="" align="center">'+data[i].privDeptId+'</td>' +
                                    '<td nowrap="" align="center">'+data[i].showCount+'  &nbsp;&nbsp; <a target="_blank" href="userPriv/show_users?userPriv='+data[i].userPriv+'&privName="  data-url=""> '+'<fmt:message code="roleAuthorization.th.ViewDetails" />'+'</a> </td>' +
                                    '<td nowrap="" align="center"> <a href="modifyThePermissions?'+data[i].userPriv+'"  data-url=""> '+permissions+'</a>&nbsp;&nbsp;'+
                                    // '<a href="newRole?'+data[i].userPriv+'" data-url=""> '+edit1+'</a>&nbsp;&nbsp;'+
                                    '<span data-id="'+data[i].userPriv+'" class="editData" style="color: #1687cb;cursor: pointer" data-url="" onclick="editData($(this))"> '+edit1+'</span>&nbsp;&nbsp;'+
                                    '<a href="cloning?'+data[i].userPriv+'" data-url="">'+clone+'</a>&nbsp;&nbsp;'+
                                    '<span id="delete_priv" onclick="delete_priv(this,'+data[i].userPriv+',\''+data[i].showCount+'\')" style="color: #1687cb;cursor: pointer"> '+function () {
                                        if(data[i].userPriv==undefined || data[i].userPriv==1){return ''}
                                        else {
                                            return ''+del+''
                                        }
                                    }()+'</span>'+
                                    '</td>' +
                                    '</tr>'
                            }/*<a href="javascript:viod(0)">查看详情</a>*/
                            // if(data[i].userPriv==1){
                            //     $('#delete_priv').attr('text','')
                            // }
                            $('#table_style tbody').html(str)
                            if(str==''){
                                str = '<li class="no_notice" style="background:#fff;position:absolute;text-align: center;padding: 27px 0px;' +
                                    'border: 1px solid #c0c0c0;border-top: none;width:'+($('.TableHeader').width()-1)+'px">' +
                                    '<img style="margin-bottom: 20px;"  src="/img/main_img/shouyekong.png" alt="">' +
                                    '<h2 style="text-align: center;color: #666;font-size: 16px">'+no_Data+'</h2>' +
                                    '</li>';
                                $('#table_style tbody').html(str)
                            }
                        }
                    })
                }

            })

//            点击新建
            $('.newJuese').on("click",function () {
                layer.open({
                    type:1,
                    title:['<fmt:message code="roleAuthorization.th.NewRole" />','background-color:#2b7fe0;color:#fff;'],
                    area: ['440px', '260px'],
                    shadeClose: true, //点击遮罩关闭
                    btn: ['确定', '取消'],
                    content:'<table class="tr_td" width="400" align="center" style="margin:30px auto;">'+
                            '<tbody><tr>'+
                            '<td nowrap="" class="TableData" style="width: 88px;"><fmt:message code="roleAuthorization.th.RoleSortingNumber" />：</td>'+
                        '<td nowrap="" class="TableData">'+
                            '<input type="text" name="PRIV_NO" style="margin: 0;" class="inp" size="5" maxlength="10" value="10">&nbsp;<br>'+
                        '</td>'+
                        '</tr>'+
                        '<tr>'+
                        '<td nowrap="" class="TableData"><fmt:message code="roleAuthorization.th.RoleName" />：</td>'+
                        '<td nowrap="" class="TableData">'+
                            '<input type="text" name="PRIV_NAME" style="margin: 0" class="inp" size="25" maxlength="100" value="">&nbsp;'+
                        '</td>'+
                        '</tr>'+
                        '<tr>'+
                        '<td nowrap="" class="TableData">'+'<fmt:message code="roleAuthorization.th.RoleClassificationManagement" />'+'：</td>'+
                            '<td nowrap="" class="TableData">' +
                        // '<input type="text" name="PRIV_NAME" style="margin: 0" class="inp" size="25" maxlength="100" value="">&nbsp;'+
                        '   <select id="zhu" name="privTypeId" class="schoolType noEdit" lay-verify="required" lay-search="" title="考勤类型" style="width:200px">\n' +
                        // '       <option value="">无角色分类</option>\n' +
                        '   </select>\n' +
                        '</td>'+
                        '</tr>'+
                        '</tbody>'+
                        '</table>',
                    success:function () {
                        $('input[name="PRIV_NAME"]').focus();
                        $.ajax({
                            type: 'post',
                            url: '/userPrivType/queryUserPrivType',
                            dataType: 'json',
                            success: function (json) {
                                // var str = '<option selected=selected>无角色分类</option>'
                                var str = ''
                                for(var i=0;i<json.obj.length;i++){
                                    str+='<option value="'+json.obj[i].privTypeId+'">'+json.obj[i].privTypeName+'</option>'
                                }
                                $("select[name='privTypeId']").html(str)
                            }
                        })
                    },
                    yes:function (index) {
                        if($('input[name="PRIV_NO"]').val() == ''){
                            layer.msg('请输入角色排序号！',{icon:5});
                            return false;
                        };
                        if($('input[name="PRIV_NAME"]').val() == ''){
                            layer.msg('请输入角色名称！',{icon:5});
                            return false;
                        }
                        var privTypeId = $('select[name="privTypeId"]').val()
                        $.ajax({
                            type:'post',
                            url:'/userPriv/addUser',
                            dataType:'json',
                            data:{
                                privNo:$('input[name="PRIV_NO"]').val(),
                                privName:$('input[name="PRIV_NAME"]').val(),
                                privTypeId:privTypeId
                            },
                            success:function (res) {
                                if (res.flag) {
                                    layer.msg(res.msg, {icon: 1, time: 3000});
                                    htmlloadDate.init(privTypeId);
                                    layer.close(index);
                                } else {
                                    layer.msg(res.msg, {icon: 2});
                                }
                            }
                        })
                    }
                })
            });
        })
        function jump(me){
            parent.newjump($(me).attr('data-Url'));
        }
        function editData(e){
            //点击编辑
                var dataId=e.attr('data-id');
                layer.open({
                    type:1,
                    title:['编辑角色','background-color:#2b7fe0;color:#fff;'],
                    area: ['440px', '260px'],
                    shadeClose: true, //点击遮罩关闭
                    btn: ['确定', '取消'],
                    content:'<table class="tr_td" width="400" align="center" style="margin:30px auto;">'+
                    '<tbody><tr>'+
                    '<td nowrap="" class="TableData" style="width: 88px;"><fmt:message code="roleAuthorization.th.RoleSortingNumber" />：</td>'+
                    '<td nowrap="" class="TableData">'+
                    '<input type="text" name="PRIV_NO" style="margin: 0;" class="inp" size="5" maxlength="10" value="">&nbsp;<br>'+
                    '</td>'+
                    '</tr>'+
                    '<tr>'+
                    '<td nowrap="" class="TableData"><fmt:message code="roleAuthorization.th.RoleName" />：</td>'+
                    '<td nowrap="" class="TableData">'+
                    '<input type="text" name="PRIV_NAME" style="margin: 0" class="inp" size="25" maxlength="100" value="">&nbsp;'+
                    '</td>'+
                    '</tr>'+
                        '<tr>'+
                        '<td nowrap="" class="TableData">'+'<fmt:message code="roleAuthorization.th.RoleClassificationManagement" />'+'：</td>'+
                        '<td nowrap="" class="TableData">'+
                        // '<input type="text" name="PRIV_NAME" style="margin: 0" class="inp" size="25" maxlength="100" value="">&nbsp;'+
                        '   <select id="zhu" name="privTypeId" class="schoolType noEdit" lay-verify="required" lay-search="" title="考勤类型" style="width:200px">\n' +
                        // '       <option value="">无角色分类</option>\n' +
                        '   </select>\n' +
                        '</td>'+
                        '</tr>'+
                    '<tr class="msg_tr"></tr>'+
                    '</tbody>'+
                    '</table>',
                    success:function () {
                        $.ajax({
                            type: 'post',
                            url: '/userPrivType/queryUserPrivType',
                            dataType: 'json',
                            success: function (json) {
                                // var str = '<option selected=selected>无角色分类</option>'
                                var str = ''
                                for(var i=0;i<json.obj.length;i++){
                                    str+='<option value="'+json.obj[i].privTypeId+'">'+json.obj[i].privTypeName+'</option>'
                                }
                                $("select[name='privTypeId']").html(str)
                            }
                        })
                        $.ajax({
                            type:'get',
                            url:'/userPriv/findByuserPriv',
                            dataType:'json',
                            data:{
                                userPriv:dataId
                            },
                            success:function (res) {
//                               alert('b3');
//                                alert($('.layui-layer').css('top'))
//                                alert($('.layui-layer-shade').css('z-index'))
//                                alert($('.layui-layer').css('z-index'))
                                var datas=res.object;
                                $('input[name="PRIV_NO"]').val(datas.privNo);
                                $('input[name="PRIV_NAME"]').val(datas.privName);
                                if(datas.userPriv==1){
                                    $('.msg_tr').html('<td colspan="2">注意：本角色为内置的‘超级系统管理员’角色，具有特殊的职能，为admin用户的默认角色，可以编辑其名称，但应保留其‘超级系统管理员’内涵</td>');
                                }
                                if(datas.privTypeId != undefined){
                                    $("#zhu option[value="+datas.privTypeId+"]").prop("selected",true)
                                }
                            }
                        })
                    },
                    yes:function (index) {
                        if($('input[name="PRIV_NO"]').val() == ''){
                            layer.msg('请输入角色排序号！',{icon:5});
                            return false;
                        };
                        if($('input[name="PRIV_NAME"]').val() == ''){
                            layer.msg('请输入角色名称！',{icon:5});
                            return false;
                        }
                        var privTypeId = $("#zhu").val()
                        $.ajax({
                            type:'post',
                            url:'/userPriv/updateUser',
                            dataType:'json',
                            data:{
                                userPriv:dataId,
                                privNo:$('input[name="PRIV_NO"]').val(),
                                privName:$('input[name="PRIV_NAME"]').val(),
                                privTypeId:privTypeId
                            },
                            success:function (res) {
                                if(res.flag){
                                    layer.msg('保存成功！',{icon:1,time:3000});
                                    htmlloadDate.init(privTypeId);
                                    layer.close(index);
                                }else{
                                    layer.msg('已存在同名角色，保存失败！',{icon:2});
                                }
                            }
                        })
                    }
                })
        }
        function init(){
            $.ajax({
                dataType:'json',
                type:"get",
                url:'/userPrivType/queryUserPrivType',
                success:function(json) {
                    var data = json.obj
                    var str='';
                    for(var i=0;i<data.length;i++){
                        var er='';
                        if(data[i].childs != undefined){
                            for(var j=0;j<data[i].childs.length;j++){
                                if(data[i].childs[j].childs != undefined){
                                    if(data[i].childs[j].childs.length>0){
                                        var three='';
                                        for(var k=0;k<data[i].childs[j].childs.length;k++){
                                            three +='<li class="three checked" menu_tid='+data[i].childs[j].childs[k].privTypeId+' url='+data[i].childs[j].childs[k].url+' title="'+data[i].childs[j].childs[k].privTypeName+'"><div class="work_sanji"  style="margin-left:18px;"><h1 style="margin-left:50px;"><img style="margin-left: 0;margin-top: 0;vertical-align: middle;margin-right: 10px;float: none;" src="/img/commonTheme/${sessionScope.InterfaceModel}/icon-05.png">'+data[i].childs[j].childs[k].privTypeName+'</h1></div></li>' ;
                                        }
                                        er += '<li class="two"  ><div style="position: relative" menu_tid='+data[i].childs[j].privTypeId+'  class="two_all click_erji  checked"  title="'+data[i].childs[j].privTypeName+'"><h1 style="width: 53%;"><img style="vertical-align: middle;margin-right: 10px;float: none;" src="/img/commonTheme/${sessionScope.InterfaceModel}/icon-05.png">'+data[i].childs[j].privTypeName+'</h1><img class="er_img" src="../../img/workflow/work/add_work/icon-03.png"></div><ul class="sanji" style="display:none;">'+three+'</ul></li>';

                                    }
                                }else{
                                    er += '<li class="two" ><div menu_tid='+data[i].childs[j].privTypeId+' class="two_all  checked" title="'+data[i].childs[j].privTypeName+'"><h1 class="erji_h1"><img style="vertical-align: middle;margin-right: 10px;float: none;" src="/img/commonTheme/${sessionScope.InterfaceModel}/icon-05.png">'+data[i].childs[j].privTypeName+'</h1></div></li>';
                                }

                            }
                        }

                        if(data[i].childs==''){
                            str+='<li class="one person">' +
                                '<div class="one_all checked" title="'+data[i].privTypeName+'" ' +
                                'menu_tid='+data[i].privTypeId+'>' +
                                '<h1 class="one_name" style="width: 88%;">' +
                                '<img style="vertical-align: text-bottom;\
                    margin-right: 30px;" />'+data[i].privTypeName+'</h1>' +
                                '</div>' +
                                '<div class="two_menu">' +
                                '<ul class="erji b"  style="width:100%;display:none;">' +
                                '<li class="two">' +
                                '<div class="two_all">'+er+'</div>' +
                                '</li>' +
                                '</ul>' +
                                '</div>' +
                                '</li>';
                        }else{
                            str+='<li class="one person">' +
                                '<div class="one_all checked" ' +
                                'title="'+data[i].privTypeName+'" ' +
                                'menu_tid='+data[i].privTypeId+'>' +
                                '<h1 class="one_name" ' +
                                'id="administ"><img style="vertical-align: text-bottom;\
                    margin-right: 30px; position: relative;left:15px" src="/img/commonTheme/${sessionScope.InterfaceModel}/gongzuo.png" />'+data[i].privTypeName+'</h1>' +
                                // '<img class="down_jiao" ' +
                                // 'src="../../img/workflow/work/add_work/icon-03.png">' +
                                '</div>' +
                                '<div class="two_menu">' +
                                '<ul class="erji b"  style="width:100%;display:none;">' +
                                '<li class="two">' +
                                '<div class="two_all">'+er+'</div>' +
                                '</li>' +
                                '</ul>' +
                                '</div>' +
                                '</li>';
                        }

                    }
                    var stt='<li class="one person" style="border-bottom: 1px solid #2f8ae3;display:none">\
                        <div class="checked one_alltwo" data-type="1">\
                        <h1 class="one_name" style="width: 88%;"><img style="width: 20px;height: 20px;vertical-align: text-bottom;margin-right: 10px;margin-left: 0;" src="/img/commonTheme/${sessionScope.InterfaceModel}/icon-02.png">\
                       <fmt:message code="workflow.th.QuickNew" /></h1>\
                        </div>\
                        </li>\
                        <li class="one person" style="display:none">' +
                        '<div class="one_all checked commonwork">' +
                        '<h1 class="one_name" style="width: 84%;"><img style="vertical-align: text-bottom;\
                    margin-right: 4px;" src="/img/commonTheme/${sessionScope.InterfaceModel}/ofen_works.png" />\
                        <fmt:message code="workflow.th.Commonwork" /></h1>\
                        </div>\
                        </li>\
                        <li class="one person " style="display:none">\
                        <div class="one_all checked allWorkShow">\
                        <h1 class="one_name" style="width: 84%;"><img style="vertical-align: text-bottom;margin-right: 4px;" \
                        src="/img/commonTheme/${sessionScope.InterfaceModel}/all_works.png" />\
                        <fmt:message code="workflow.th.allwork" /></h1>\
                        </div>\
                        </li>';
                    <%-- <li class="one person ulNone" style="border-bottom: 1px solid #2f8ae3;">\--%>
                    <%-- <div class="checked one_alltwo " data-type="1">\--%>
                    <%-- <h1 class="one_name" style="width: 88%;"><img style="width: 20px;height: 20px;vertical-align: text-bottom;margin-right: 10px;margin-left: 0;" src="/img/commonTheme/${sessionScope.InterfaceModel}/icon-01.png">\--%>
                    <%--<fmt:message code="workflow.th.New" /></h1>\--%>
                    <%-- </div>\--%>
                    <%-- </li>';--%>
                    $(".tab_cone").html(stt+str);
                    //点击一级菜单。显示二级
                    $('.one_all').on('click',function () {
                        privTypeId = $(this).attr('menu_tid')
                        right(privTypeId)
                        if($(this).attr('data-type')==1){
                            return;
                        }
                        var top_one=$(this).parent().next('li').find('.one_all');
                        if ($(this).siblings().find('.erji').css('display')=='none') {
                            $(this).find('.down_jiao').attr('src','../../img/workflow/work/add_work/icon-04.png');
                            $(this).siblings().find('.erji').show();
                            $(this).siblings().find('.erji').css('background','#e8f4fc');

                            /*top_one.css('border-top','1px solid #999');*/
                        }else{
                            $(this).find('.down_jiao').attr('src','../../img/workflow/work/add_work/icon-03.png');
                            $(this).siblings().find('.erji').hide();
                            /* top_one.css('border-top','none');*/
                        }
                        if($(this).siblings('.two_menu')){
//                            $(this).find('h1').css({
//                                'color':'#000'
//                            });
                        }else{
                            $(this).css('background','#ccebff');
                        }

                        if($(this).find('h1').find('img').prop('src').indexOf('gongzuo')!=-1){
                            $('.rig_title').find('img').prop('src','/img/commonTheme/${sessionScope.InterfaceModel}/gongzuos.png')
                        }else  if($(this).find('h1').find('img').prop('src').indexOf('all_works')!=-1){
                            $('.rig_title').find('img').prop('src','/img/commonTheme/${sessionScope.InterfaceModel}/all_wosrkstwo.png')
                        }else  if($(this).find('h1').find('img').prop('src').indexOf('ofen_works')!=-1){
                            $('.rig_title').find('img').prop('src','/img/commonTheme/${sessionScope.InterfaceModel}/ofen_workss.png')
                        }


                    });

                    //点击二级，出现三级
//                     $('.click_erji').on('click',function () {
//                         var san= $(this).siblings().html();
//                         if ($(this).siblings('.sanji').css('display')=='none') {
//                             $(this).find('.er_img').attr('src','../../img/workflow/work/add_work/icon-04.png');
//                             $(this).siblings('.sanji').show();
//
//                         }else{
//                             $(this).find('.er_img').attr('src','../../img/workflow/work/add_work/icon-03.png');
//                             $(this).siblings('.sanji').hide();
//                         }
//                     });
//
//                     //点击二级菜单
//                     $('.two_menu li').on('click','.two_all',function(){
//                         gappType = $(this).attr('menu_tid')
//                         gappTypes = $(this).attr('menu_tid')
//                         $("#ying").attr('gappType',gappType)
//                         // right(gappType)
//                         var url=$(this).attr('url');
//                         var menu_tid=$(this).parent().attr('menu_tid');
//                         //样式的 改变
// //                        $(this).parent().siblings().find('.two_all').removeClass('menu_change');//同层级的二级文字
// //                        $(this).parents('.one').siblings().find('.two_all').removeClass('menu_change');//同层级的二级文字
// //                        $(this).parent('.two').siblings().find('.three').removeClass('menu_change');//同层级的三级文字
// //                        $(this).parents('.one').siblings().find('.three').removeClass('menu_change');//不同层级的三级文字
// //                        $(this).addClass('menu_change');
//
//                         //判断标题id与iframeid是否相同
//                         if($('#f_'+menu_tid).length>0){
//                             //页面一打开，切换显示
//                             $('.all_content .iItem').hide();
//                             $('#f_'+menu_tid).show();
//
//                             $('#t_'+menu_tid).css({
//                                 'color':'#2a588c',
//                                 'position':'relative',
//                                 'z-index':99999
//                             })
//                             $('#t_'+menu_tid).siblings().css({
//                                 'color':'#fff',
//                                 'position':'relative',
//                                 'z-index':999
//                             });
//                         }else{
//                             if($(this).siblings('.sanji').length>0){
//
//                             }else{
//                                 //页面不存在，新增 title和iframe
//                                 var titlestr = '<li class="choose" index="0;" id="t_'+menu_tid+'" title="'+$(this).find('h1').html()+'"><h1>'+$(this).find('h1').html()+'</h1><div class="img" style="display:none;"><img class="close"  src="img/main_img/icon.png"></div></li>';
//                                 var iframestr = '<div id="f_'+menu_tid+'" class="iItem" ><iframe id="every_module" src="'+url+'" frameborder="0" scrolling="yes" height="100%" width="100%" noresize="noresize" tid="2"></iframe></div>';
//                                 $('.main_title ul').append(titlestr);
//                                 $('#t_'+menu_tid).siblings().attr('style','background: url(img/main_img/title_no.png) 0px 4px no-repeat;');
//                                 $('#t_'+menu_tid).siblings().css('color','#fff');
//                                 $('.all_content').append(iframestr);
//                                 $('.all_content .iItem').hide();
//                                 $('#f_'+menu_tid).show();
//                             }
//                         }
//                     });
//                     //点击三级菜单，跳转页面。
//                     $('.sanji').on('click','li',function(){
//                         gappType = $(this).attr('menu_tid')
//                         gappTypes = $(this).attr('menu_tid')
//                         $("#ying").attr('gappType',gappType)
//                         // right(gappType)
//                         var url=$(this).attr('url');
//                         var menu_tid=$(this).attr('menu_tid');
//                         //样式改变
// //                        $(this).parents('.two').siblings().find('.two_all').removeClass('menu_change');//同层级的二级文字
// //                        $(this).parents('.one').siblings().find('.two_all').removeClass('menu_change');//同层级的二级文字
// //                        $(this).siblings().removeClass('menu_change');//同层级的三级文字
// //                        $(this).parents('.one').siblings().find('.three').removeClass('menu_change');//不同层级的三级文字
// //                        $(this).addClass('menu_change');
//                         if($('#f_'+menu_tid).length>0){
//                             //页面一打开，切换显示
//                             $('.all_content .iItem').hide();
//                             $('#f_'+menu_tid).show();
//
//                             $('#t_'+menu_tid).siblings().css({
//                                 'color':'#fff',
//                                 'position':'relative',
//                                 'z-index':999
//                             });
//                             $('#t_'+menu_tid).css({
//                                 /* 'background':'url(img/main_img/title_yes.png) 0px 4px no-repeat',*/
//                                 'color':'#2a588c',
//                                 'position':'relative',
//                                 'z-index':99999
//                             })
//                         }else{
//                             //页面不存在，新增 title和iframe
//                             var titlestrs = '<li class="choose " index="0;" id="t_'+menu_tid+'" title="'+$(this).find('h1').html()+'"><h1>'+$(this).find('h1').html()+'</h1><div class="img" style="display:none;"><img class="close" src="img/main_img/icon.png"></div></li>';
//                             var iframestr = '<div id="f_'+menu_tid+'" class="iItem"><iframe id="every_module" src="'+url+'" frameborder="0" scrolling="yes" height="100%" width="100%" noresize="noresize" tid="2"></iframe></div>';
//                             $('.main_title ul').append(titlestrs);
//                             $('#t_'+menu_tid).siblings().attr('style','background: url(img/main_img/title_no.png) 0px 4px no-repeat;');
//                             $('#t_'+menu_tid).siblings().css('color','#fff');
//                             $('.all_content').append(iframestr);
//                             $('.all_content .iItem').hide();
//                             $('#f_'+menu_tid).show();
//                         }
//
//                     });
//                     $('.one_all')[0].click()
                }
            })

            //首次进入或者刷新页面，默认展示所有角色
            $.ajax({
                type: 'get',
                url: '/getAllUserPriv',
                dataType: 'json',
                success: function (date) {
                    var str='';
                    var data=date.obj

                    for(var i=0;i<data.length;i++){
                        var color_str = '';
                        if (data[i].userPriv ==1 ){
                            color_str = 'style="color:red"';
                        }
                        str+='<tr>' +
                            '<td nowrap="" align="center" width="60">'+data[i].privNo+'</td>' +
                            '<td nowrap="" align="center" '+color_str+' >'+data[i].privName+'</td>' +
                            '<td nowrap="" align="center" '+color_str+' >'+function () {
                                if(data[i].privTypeName == undefined){
                                    return '<fmt:message code="roleAuthorization.th.Unclassified" />';
                                }else{
                                    return data[i].privTypeName
                                }
                            }()+'</td>' +
                            // '<td nowrap="" align="center">'+data[i].privDeptId+'</td>' +
                            '<td nowrap="" align="center">'+data[i].showCount+'  &nbsp;&nbsp; <a target="_blank" href="userPriv/show_users?userPriv='+data[i].userPriv+'&privName="  data-url=""> '+'<fmt:message code="roleAuthorization.th.ViewDetails" />'+'</a> </td>' +
                            '<td nowrap="" align="center"> <a href="modifyThePermissions?'+data[i].userPriv+'"  data-url=""> '+permissions+'</a>&nbsp;&nbsp;'+
                            // '<a href="newRole?'+data[i].userPriv+'" data-url=""> '+edit1+'</a>&nbsp;&nbsp;'+
                            '<span data-id="'+data[i].userPriv+'" class="editData" style="color: #1687cb;cursor: pointer" data-url="" onclick="editData($(this))"> '+edit1+'</span>&nbsp;&nbsp;'+
                            '<a href="cloning?'+data[i].userPriv+'" data-url="">'+clone+'</a>&nbsp;&nbsp;'+
                            '<span id="delete_priv" onclick="delete_priv(this,'+data[i].userPriv+',\''+data[i].showCount+'\')" style="color: #1687cb;cursor: pointer"> '+function () {
                                if(data[i].userPriv==undefined || data[i].userPriv==1){return ''}
                                else {
                                    return ''+del+''
                                }
                            }()+'</span>'+
                            '</td>' +
                            '</tr>'
                    }/*<a href="javascript:viod(0)">查看详情</a>*/
                    // if(data[i].userPriv==1){
                    //     $('#delete_priv').attr('text','')
                    // }
                    $('#table_style tbody').html(str)
                }
            })
        };
        init()
        // $('.one_all')[0].click()
        // right(0)
        function right(privTypeId){
            $.ajax({
                type: 'get',
                url: '/userPrivType/queryUserPrivByPrivTypeId',
                data:{
                    privTypeId:privTypeId
                },
                dataType: 'json',
                success: function (date) {
                    // if(userPriv)
                    var str='';
                    var data=date.obj

                    for (var i = 0; i < data.length; i++) {
                        $("[name='priv']").append('<option value="' + data[i].userPriv + '">' + data[i].privName + '</option>');
                    }
                    for(var i=0;i<data.length;i++){

                        var color_str = '';
                        if (data[i].userPriv ==1 ){
                            color_str = 'style="color:red"';
                        }
                        str+='<tr>' +
                            '<td nowrap="" align="center" width="60">'+data[i].privNo+'</td>' +
                            '<td nowrap="" align="center" '+color_str+' >'+data[i].privName+'</td>' +
                            '<td nowrap="" align="center" '+color_str+' >'+function () {
                                if(data[i].privTypeName == undefined){
                                    return '<fmt:message code="roleAuthorization.th.Unclassified" />';
                                }else{
                                    return data[i].privTypeName
                                }

                            }()+'</td>' +
                            // '<td nowrap="" align="center">'+data[i].privDeptId+'</td>' +
                            '<td nowrap="" align="center">'+data[i].showCount+'  &nbsp;&nbsp; <a target="_blank" href="userPriv/show_users?userPriv='+data[i].userPriv+'&privName="  data-url=""> '+'<fmt:message code="roleAuthorization.th.ViewDetails" />'+'</a> </td>' +
                            '<td nowrap="" align="center"> <a href="modifyThePermissions?'+data[i].userPriv+'"  data-url=""> '+permissions+'</a>&nbsp;&nbsp;'+
                            // '<a href="newRole?'+data[i].userPriv+'" data-url=""> '+edit1+'</a>&nbsp;&nbsp;'+
                            '<span data-id="'+data[i].userPriv+'" class="editData" style="color: #1687cb;cursor: pointer" data-url="" onclick="editData($(this))"> '+edit1+'</span>&nbsp;&nbsp;'+
                            '<a href="cloning?'+data[i].userPriv+'" data-url="">'+clone+'</a>&nbsp;&nbsp;'+
                            '<span id="delete_priv" onclick="delete_priv(this,'+data[i].userPriv+',\''+data[i].showCount+'\')" style="color: #1687cb;cursor: pointer"> '+function () {
                                if(data[i].userPriv==undefined || data[i].userPriv==1){return ''}
                                else {
                                    return ''+del+''
                                }
                            }()+'</span>'+
                            '</td>' +
                            '</tr>'
                    }/*<a href="javascript:viod(0)">查看详情</a>*/
                    // if(data[i].userPriv==1){
                    //     $('#delete_priv').attr('text','')
                    // }
                    $('#table_style tbody').html(str)
                    if(str==''){
                        str = '<li class="no_notice" style="background:#fff;position:absolute;text-align: center;padding: 27px 0px;' +
                            'border: 1px solid #c0c0c0;border-top: none;width:'+($('.TableHeader').width()-1)+'px">' +
                            '<img style="margin-bottom: 20px;"  src="/img/main_img/shouyekong.png" alt="">' +
                            '<h2 style="text-align: center;color: #666;font-size: 16px">'+no_Data+'</h2>' +
                            '</li>';
                        $('#table_style tbody').html(str)
                    }
                }
            })
        }


        $(document).on('click','.one_all',function(res){
            $('.one_all').css({"background-color": "rgb(240,244,247)"});
            var index = $(this)
            $(index).css({"background-color": "rgb(182,224,255)"});
        })
    </script>
</body>
</html>
