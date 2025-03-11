<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="mvc" uri="http://www.springframework.org/tags/form" %>
<%@taglib prefix="fmt" uri="http://www.springframework.org/tags" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8"/>
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <link rel="stylesheet" type="text/css" href="../lib/laydate/skins/default/laydate.css"/>
    <link rel="stylesheet" type="text/css" href="../css/base.css"/>
    <link rel="stylesheet" type="text/css" href="../css/dept/deptManagement.css?20190716"/>
    <link rel="stylesheet" type="text/css" href="../lib/easyui/themes/easyui.css"/>
    <link rel="stylesheet" type="text/css" href="../lib/easyui/themes/icon.css"/>
    <link rel="stylesheet" type="text/css" href="../css/base.css"/>
    <link rel="stylesheet" type="text/css" href="../css/news/center.css"/>
    <script type="text/javascript" src="../js/xoajq/xoajq3.js"></script>
    <script src="/js/jquery/jquery-migrate-3.4.0.js"></script>

    <script src="/js/common/language.js"></script>
    <script src="/js/jquery/jquery.cookie.js"></script>
    <script src="../lib/laydate/laydate.js"></script>
    <script src="/lib/layer/layer.js"></script>
    <script src="/lib/jQuery-File-Upload-master/jquery-ui.js" type="text/javascript" charset="utf-8"></script>
    <script src="/lib/jQuery-File-Upload-master/jquery.iframe-transport.js" type="text/javascript" charset="utf-8"></script>
    <script src="/lib/jQuery-File-Upload-master/jquery.fileupload.js" type="text/javascript" charset="utf-8"></script>
    <script src="../js/base/base.js" type="text/javascript" charset="utf-8"></script>
    <script src="../js/ajaxupload.js" type="text/javascript" charset="utf-8"></script>
    <script type="text/javascript" src="/js/common/fileupload.js"></script>
    <%--<script src="../lib/laydate.js"></script>--%>
    <title><fmt:message code="main.deptmanage" /></title>
    <style>
        html,
        body,
        .wrap{
            width:100%;
            height:100%;
            /* overflow: hidden;*/
        }
        .noDatas {
            margin-top: 10px;
        }

        .noDatas_pic {
            margin-top: 20%;
        }

        .noData_out {
            margin: 0 auto;
            text-align: center;
        }

        .foot_span_show {
            float: right;
            color: white;
            line-height: 28px;
            margin-right: 15px;
            cursor: pointer
        }
        .head_rig  .import {
            width: 56px;
            height: 30px;
            font-size: 13px !important;
            cursor: pointer;
            background-repeat: no-repeat;
            background-image: url(../img/sys/import.png);
            padding-left: 25px;
        }
        .head_rig  .export {
            width: 56px;
            height: 30px;
            font-size: 13px !important;
            cursor: pointer;
            background-repeat: no-repeat;
            background-image: url(../img/sys/export.png);
            padding-left: 25px;
        }
        .head_rig .new_dept {
            width: 130px;
            height: 30px;
            font-size: 13px !important;
            background-image:url(../img/sys/dept_personnel.png);
            cursor: pointer;
            background-repeat: no-repeat;
            color: #fff;
        }

        #cont_left::-webkit-scrollbar {
            width: 5px;
        }

        #cont_left::-webkit-scrollbar-corner {
            /*background: #82AFFF;*/
        }

        .head_rig {
            width: 29%;
            margin-top: 0px;
            float: right;
        }
        .head_rig h1 {
            float: left;
            margin-right:20px;
        }

        .inp {
            height: 24px;
        }

        .search {
            width: 72px;
            height: 29px;
            margin-top: 16px;
            background: #fff;
        }

        .search h1 {
            text-align: center;
            color: #fff;
            font-size: 14px;
            line-height: 28px;
            background-image: url(../img/workflow/btn_check_nor_03.png);
            background-repeat: no-repeat;
        }

        .cont {
            width: 102%;
            height: 95%;
            overflow-y: auto;
        }

        .head {
            border-bottom: 1px solid #dedede;

        }
        .new_excell_pic {
            border-radius: 0;
            border: none;
            width: 73px;
            height: 73px;
            margin: 10px 24px 10px 20px;
        }

        .head_rig h1 :hover {
            cursor: pointer;
        }

        .deldel {
            color: #fff;
            font-size: 12px;
            float: right;
            margin-right: 10px;
            margin-left: 5px;
            line-height: 28px;
            cursor: pointer;
        }

        .footer_span_space {
            color: #fff;
            font-size: 12px;
            float: right;
            margin-right: 10px;
            line-height: 28px;
            cursor: pointer;
        }

        .foot_span_show {
            margin-left: 9px;
        }

        .edit {
            color: #fff;
            font-size: 12px;
            float: right;
            margin-right: 10px;
            margin-left: 5px;
            line-height: 28px;
            cursor: pointer;
        }

        .search h1 :hover {
            cursor: pointer;
        }

        .deldel_img {
            float: right;
            height: 15px;
            margin-top: 7px;
        }

        .edit_img {
            float: right;
            height: 15px;
            margin-top: 7px;
        }

        .deldel_yulan {
            float: right;
            height: 15px;
            margin-top: 7px;
            margin-right: 0px;
            cursor: pointer;
            margin-left: -4px;
        }

        .new_excell_footer {
            width: 100%;
            height: 28px;
            position: relative;
            background-color: #59bdf0;
        }

        .new_excell_head {
            position: relative;
            width: 100%;
            height: 30px;
        }

        .new_excell_name {
            border-left: 4px solid #59bdf0;
            color: #59bdf0;
            position: absolute;
            bottom: 0;
            font-size: 16px;
            font-weight: 700;
            height: 24px;
            margin-left: 20px;
        }

        .new_excell_info {
            width: 100%;
            height: 123px;
            position: relative;
        }

        .new_excell_center {
            margin-left: 6%;
            margin-top: 10px;
        }

        .new_excell_info_main {
            width: 100%;
            height: 62px;
            position: absolute;

        }

        .new_excell_info_other {
            position: absolute;
            top: 10px;
            height: 100%;
            margin-left: 45px;
            margin-top: 10px;
            list-style-type: none;
            left: 20%;
        }

        .new_excell_main {
            width: 332px;
            height: 181px;
            border: 1px solid #ddd;
            margin: auto;
            margin-top: 10px;
            border-radius: 5px;
        }

        .new_excell_main:hover {
            border: 2px solid #59bdf0;
        }

        .new_excell_info_mian_pic {
            float: left;
        }

        .new_excell {
            width: 360px;
            height: 191px;
            float: left;
            margin-left: 0px;
            margin-right: 0px;
        }

        .new_excell_info_other span {
            margin-left: 10px;
            color: black;
        }

        .new_excell_info_other li {
            height: 50%;
            line-height: 24px;
            font-size: 20px;
        }


        li {
            display: list-item;
            text-align: -webkit-match-parent;
        }

        .conter {
            width: 461px;
            height: 800px;
            margin: auto;
        }

        .f_field_title {
            display: inline-block;
            font-size: 12px;
            font-weight: bold;
            height: 18px;
            line-height: 41px;
            margin-left: 2px;
            margin-right: 2px;
        }

        .f_field_required {
            color: red;
            font-size: 12px;
            margin-top: 0px;
            margin-left: 2px;
            margin-right: 2px;
        }

        .f_field_ctrl {
            margin-top: 5px;
            margin-left: 2px;
            float: left;
        }

        select {
            height: 32px;
            width: 220px;
            border-radius: 4px;
            border: 1px solid #cccccc;
            background-color: #ffffff;
        }

        .f_field_title {
            font-size: 12px;
            font-weight: bold;
            margin-left: 2px;
            margin-right: 2px;
        }

        .f_field_required {
            color: red;
            font-size: 12px;
            margin-top: 0px;
            margin-left: 2px;
            margin-right: 2px;
        }

        .f_field_ctrl {
            margin-top: 5px;
            margin-left: 2px;
        }

        .f_field_ctrl input {
            color: #000;
        }

        .f_field_block {
            width: 100%;
            height: 68px;
            margin-top: 70px;
            margin-bottom: 4px;
            display: block;
            text-align: left;
        }

        .inp {
            width: 221px;
            height: 32px;
            border-radius: 4px;
        }


        .center {
            height: 400px !important;
        }

        .delete_flow, .edit_liucheng {
            cursor: pointer;
        }

        .layui-layer-title {
            padding: 0 80px 0 20px;
            height: 42px;
            line-height: 42px;
            border-bottom: 1px solid #eee;
            font-size: 16px;
            color: #fff;
            overflow: hidden;
            background-color: #2b7fe0;
            border-radius: 2px 2px 0 0;
        }

        .layui-layer-page .layui-layer-btn {
            padding-top: 10px;
            text-align: center;
        }
        /*.dpetWhole0{overflow: hidden}*/
        dpetWhole0 li{white-space: nowrap;}
        .cont_rig {
            float: left;
            background-color: #f9f9f9;
        }
        .cont_left{
            border-right: 1px solid #c0c0c0!important;
            overflow-x: hidden;
        }
        .imgleft{
            margin-left: 12px!important;
        }
        .head_left img {
            width: 25px;
        }
        .pick{
            overflow: auto;
        }
        .pick li{
            white-space: nowrap;
        }
        ::-webkit-scrollbar{
            width: 8px;
            height: 6px;
            background-color: #f5f5f5;
        }
        /*定义滚动条的轨道，内阴影及圆角*/
        ::-webkit-scrollbar-track{
            -webkit-box-shadow: inset 0 0 6px rgba(0,0,0,.3);
            border-radius: 10px;
            background-color: #f5f5f5;
        }
        /*定义滑块，内阴影及圆角*/
        ::-webkit-scrollbar-thumb{
            /*width: 10px;*/
            height: 20px;
            border-radius: 10px;
            -webkit-box-shadow: inset 0 0 6px rgba(0,0,0,.3);
            background-color: #555;
        }
        .liUp{

        }
        .cont_left .dept_li{
            padding-left: 30px!important;
        }
        .head_left .new_dept{
            width: 124px;
            height: 30px;
            font-size: 13px !important;
            background-image: url(../../img/sys/dept_personnel.png);
            line-height: 30px;
            text-align: center;
            cursor: pointer;
            background-repeat: no-repeat;
            color: #fff;
            padding-left: 15px;
            margin-right: 16px;
            margin-top: 6px;
            /*float:right!important;*/
            color:#fff;
            text-align: center;
        }
        .mores{
            z-index: 66;
            position: absolute;
            right: 5px;
            line-height: 25px;
            width: 18px;
            height: 35px;
            cursor: pointer;
            font-size: 26px;
        }
        .head_left h1{
            float:none!important;
        }
        .select{
            background:#c5e9fb;

        }
        .select>span>a{
            color:#fff!important;
        }
        .ant-dropdown {
            position: absolute;
            left: -9999px;
            top: -9999px;
            z-index: 1050;
            display: block;
            font-size: 12px;
            font-weight: normal;
            line-height: 1.5;
        }
        .ant-dropdown {
            list-style-type: none;
            padding: 0;
            margin: 0;
            text-align: left;
            background-color: #fff;
            border-radius: 6px;
            box-shadow: 0 1px 6px rgba(99,99,99,.2);
            background-clip: padding-box;
            border: 1px solid #d9d9d9;
            padding: 10px 15px;
        }
        .duletit {
            padding-top: 5px;
            padding-bottom: 5px;
            border-bottom: 1px solid #ddd;
            margin-bottom: 5px;
        }
        .ant-menu-inline, .ant-menu-vertical {
            border-right: none;
            border-radius: 6px;
        }
        .ant-menu-root.ant-menu-vertical, .ant-menu-root.ant-menu-inline {
            box-shadow: none;
        }
        .ant-menu-item, .ant-menu-submenu, .ant-menu-submenu-title {
            cursor: pointer;
            -webkit-transition: all 0.3s ease;
            transition: all 0.3s ease;
        }
        .ant-menu-item, .ant-menu-submenu-title {
            margin: 0;
            position: relative;
            display: block;
            white-space: nowrap;
        }
        .ant-menu-inline .ant-menu-item, .ant-menu-vertical .ant-menu-item {
            border-right: 1px solid #e9e9e9;
            margin-left: -1px;
            left: 1px;
            position: relative;
            z-index: 1;
        }
        .ant-menu-vertical > .ant-menu-item, .ant-menu-inline > .ant-menu-item, .ant-menu-item-group-list > .ant-menu-item, .ant-menu-vertical > .ant-menu-submenu > .ant-menu-submenu-title, .ant-menu-inline > .ant-menu-submenu > .ant-menu-submenu-title, .ant-menu-item-group-list > .ant-menu-submenu > .ant-menu-submenu-title {
            padding: 0px 16px 0 28px;
            font-size: 12px;
            line-height: 42px;
            height: 42px;
        }
        .ant-menu-inline .ant-menu-item, .ant-menu-vertical .ant-menu-item {
            border-right: none;
            padding-left: 5px;
            height: 34px;
            line-height: 34px;
        }
        .hedul {
            width: 10px;
            height: 10px;
            border-radius: 50%;
            display: inline-block;
            margin-left: 5px;
            margin-right: 5px;
            background:#dadada;
        }
        .ant-menu-item:hover{
            background-color: #2baee9;
            color: #fff;
        }
        .syn_dept{
            width: 90px;
            font-size: 13px;
            background-color: #2f80d1;
            height: 30px;
            line-height: 30px;
            color: white;
            border-radius: 5px;
        }
        .cont_left{
            width: 350px!important;
        }
        .cont_rig, .mainRight{
            width: calc(100% - 351px)!important;
        }
        .operation {
            display: none;
        }
        .unloading {
            display: none;
        }
    </style>
    <link rel="stylesheet" type="text/css" href="/css/commonTheme/${sessionScope.InterfaceModel}/commonTheme.css"/>
</head>
<body style="overflow:scroll;overflow-y: hidden;overflow-x:hidden;">

<div class="wrap" style="margin-left:0px !important;">

    <div class="cont" style="overflow-y: auto ">
        <div class="cont_left" id="cont_left">
            <ul>
                <li class="liDown dept_li" id="dept_lis" style="padding-left: 30px;">
                    <img src="/img/commonTheme/${sessionScope.InterfaceModel}/icon_sectorList.png" style="vertical-align: middle;width: 15px;margin-right: 10px;" alt="部门列表"><fmt:message code="depatement.th.depa" />
<%--                    <a href="javascript:void(0)" onclick="location.reload()" style="color: #207BD6;margin-left: 20px;cursor: pointer;"><img src="/img/commonTheme/theme6/icon_shuaxin_03.png" style="margin-right: 8px;margin-bottom: 1px;">刷新</a>--%>
                </li>
                <div style="padding-left: 30px;font-size: 14px;padding-top: 10px;">
                    <label class="" style="display: inline-block;">是否显示失效部门</label>
                    <input type="checkbox" name="" id="isPlayDept">
                </div>
                <li class="pick" id="pick" style="display: block;">
                    <div class="pickCompany"><span style="height:35px;line-height:35px;" class="childdept"><img src="/img/commonTheme/${sessionScope.InterfaceModel}/icon_company.png" alt="" style="vertical-align: middle;width: 15px;margin-right: 10px;margin-left: 13px;margin-bottom: 4px;"><a href="javascript:void(0)" class="dynatree-title" title=""></a></span></div>
                    <%--<ul class="tab_ctwo a" id="deptOrg">--%>
                    <%--<!-- <li>--%>

                    <%--</li> -->--%>
                    <%--</ul>--%>
                </li>
                <div style="height: 200px">
<%--                    <li class="liUp dept_li" onclick="develop(this)" data-url="/department/batchSetDept"><img src="/img/commonTheme/${sessionScope.InterfaceModel}/smallBatchSetDept.png" style="vertical-align: middle;width: 15px;margin-right: 10px;" alt="部门批量设置"><fmt:message code="depatement.th.Sectorbatch" /></li>--%>
<%--                    <li class="liUp dept_li" onclick="develop(this)" data-url="/department/AuxiliaryDepartment"><img src="/img/commonTheme/theme1/addAndRemove.png" style="vertical-align: middle;width: 15px;margin-right: 10px;" alt="添加/删除辅助部门">添加/删除辅助部门</li>--%>
<%--                    <li class="liUp dept_li" onclick="develop(this)" data-url="/usergroup/userGroup"><img src="/img/commonTheme/${sessionScope.InterfaceModel}/smallGroup.png" style="vertical-align: middle;width: 15px;margin-right: 10px;" alt="公共自定义组"><fmt:message code="depatement.th.customgroup" /></li>--%>
<%--                    <li class="liUp dept_li" onclick="develop(this)" data-url="/department/upDeptRank"><img src="/img/commonTheme/${sessionScope.InterfaceModel}/smallUpDeptRank.png" style="vertical-align: middle;width: 15px;margin-right: 10px;" alt="修正部门级别"><fmt:message code="depatement.th.departmentlevel" /></li>--%>
<%--                    <li class="liUp dept_li" onclick="develop(this)" data-url="/department/exportOrImport"><img src="/img/commonTheme/${sessionScope.InterfaceModel}/icon_userImport.png" style="vertical-align: middle;width: 15px;margin-right: 10px;" alt="部门导入或导出"><fmt:message code="doc.th.deptImport" /></li>--%>
                </div>
            </ul>
        </div>
        <div style="display:none">
            <div class="ant-dropdown">
                <div>
                    <div class="duletit"><h1 style='cursor:pointer;' class="new_dept" id="newdeptDown"><fmt:message code="depatement.th.NewChiDepartment" /></h1></div>
                    <div><h1 style='cursor:pointer;padding-left: 7px;' class="new_dept" id="del"><fmt:message code="main.th.DeleteCurrentDepartment" /></h1></div>
                </div>
            </div>
        </div>
        <div class="cont_rig">
            <!-- 部门右侧页面 -->

            <jsp:include page="secrectDeptManagement.jsp"/>


        </div>
    </div>
</div>
</body>
<script type="text/javascript">
    var attachmentId = [];
    var attachmentName = [];
    var operationReason = ""
    var isScreen = '1'
    var ids
    var param = $.GetRequest();
    var arr70 = param.arr1
    //判断是否开启分支机构
    var paraValues = "";
    $.ajax({
        url:"/syspara/selectTheSysPara?paraName=IS_SHOW_JMJ",
        success:function(res) {
            var data = res.object[0];
            if(data.paraValue == 1) {
                $(".subText").show()
            }else {
                $(".subText").hide()
            }
        }
    })
    $.ajax({
        url:"/syspara/queryOrgScope",
        dataType: 'json',
        success:function(res) {
            paraValues = res.object.paraValue
        }
    })
    if(arr70!=''&&arr70!=undefined){
        var arr = arr70.split(',')
    }
    var secretInfo = null;
    $.ajax({
        url:"/syspara/selectTheSysPara?paraName=IS_OPEN_SANYUAN",
        success:function(res) {
            secretInfo = res.object[0].paraValue;
        }
    })
    function domClick() {
        if(location.search) {
            let dom = null;
            var deptId = location.search.split('=')[1];
            dom = $('#cont_left span').filter(function(i,el) {
                return $(el).attr("deptid") == deptId;
            })
            if(dom) {
                dom.click()
            }
        }
    }
    function autodivheight(){
        var winHeight=0;
        if (window.innerHeight)
            winHeight = window.innerHeight;
        else if ((document.body) && (document.body.clientHeight))
            winHeight = document.body.clientHeight;
        if (document.documentElement && document.documentElement.clientHeight)
            winHeight = document.documentElement.clientHeight;
        winWidth = document.documentElement.clientWidth;
        //document.getElementById("pick").style.height= winHeight - 250 +"px";
        $('#pick').css({'min-height':winHeight - 255 +"px"})

    }
    autodivheight();
    boolTwo=false;
    numstring=true;
    //正在开发中
    function develop(me){
        $('.cont_rig').hide()
        $('.mainRight').show()
        $('.mainRight').height($(document).height()-$('.head').height())
        $('.mainRight').find('iframe').prop('src',$(me).attr('data-url'))
    };

    //编辑部门 详情
    var queryToId = "";
    var deptApprover = ""
    var deptNoShow='';
    function ajaxdata(id,me,deptDisplay){
        ids=id

        $('.mainRight').hide()
        $('.cont_rig').show()
        if($(me).attr('data-numtrue')==1){
            $(me).parent().addClass('select').siblings().removeClass('select').find('li').removeClass('select').end().parent().find('ul').css('background','#fff')
        }else{
            $(me).parents('li').removeClass('select').end().parent().addClass('select').siblings().removeClass('select').find('li').removeClass('select').end().parent().find('ul').css('background','#fff')
        }
        $.ajax({
            url:'../department/getDeptById',
            type:'get',
            dataType:'json',
            data:{
                'deptId':id,
            },
            success:function(data){
                $(".step2").show();
                $(".kf").hide();
                deptNoShow=data.object.deptNo;
                $('#deptApprover').attr("user_id",data.object.deptApprover).val(data.object.deptApproverName)
                /*   $("#deptNo_").attr("disabled","disabled"); */// 部门排序号,不可修改
                if(data.object.deptNo.length>3){
                    $("#deptNo_").val(data.object.deptNo.substring(data.object.deptNo.length-3,data.object.deptNo.length)); // 部门排序号
                }else{
                    $("#deptNo_").val(data.object.deptNo);
                }
                if(data.object.classifyOrg =='1'){
                    $(".Image_").show()
                }else {
                    $(".Image_").hide()
                }
                deptApprover = data.object.deptApprover;
                $("#deptApprover").attr("user_id",data.object.deptApprover)
                $("#deptName_").val(data.object.deptName); // 部门名称
                $('#deptAbbrName2').val(data.object.deptAbbrName || ''); // 部门简称
                if(data.object.deptParent!=0&&data.object.deptParent!="0"){
                    $("#deptParent_").val(data.object.deptParentName); // 上级部门名称
                }else{
                    $("#deptParent_").val(''); // 上级部门名称
                }
                if(data.object.deptDisplay == '0'){
                    $('#editDeptNoplay').prop('checked',true)
                    $('#editDeptPlay').prop('checked',false)
                }else{
                    $('#editDeptNoplay').prop('checked',false)
                    $('#editDeptPlay').prop('checked',true)
                }
                // if(data.object.deptParent.classifyOrg =='1'){
                //     $(".Image_").show()
                // }else {
                //     $(".Image_").hide()
                // }
                $("#deptParent_").attr("deptid",data.object.deptParent); // 上级部门id

                var manager= data.object.manager.split("&");
                queryToId = manager[1];
                var manager0=manager[0];
                if(!manager0　|| manager0=="null"){
                    manager0="";
                    manager[1] = '';
                };
                var assistantId= data.object.assistantId.split("&");
                var assistantId0=assistantId[0];
                if(!assistantId0 || assistantId0=="null"){
                    assistantId0="";
                    assistantId[1] = '';
                };
                var leader1= data.object.leader1.split("&");
                var leader10=leader1[0];
                if(!leader10 || leader10=="null"){
                    leader10=""
                    leader1[0] = ''
                };
                var leader2= data.object.leader2.split("&");
                var leader20=leader2[0];
                if(!leader20 ||leader20=="null"){
                    leader20="";
                    leader2[0] = '';
                };

                $("#query_toId_").attr("user_id",manager[1]);
                $("#query_toId_").val(manager0); //部门主管

                $("#query_Satrap_").attr("user_id",assistantId[1]);
                $("#query_Satrap_").val(assistantId0); // 部门助理

                $("#query_UpAssistant_").attr("user_id",leader1[1]);
                $("#query_UpAssistant_").val(leader10); // 上级主管领导

                $("#query_UpSatrap_").attr("user_id",leader2[1]);
                $("#query_UpSatrap_").val(leader20); // 上级分管领导

                $('#DeptNum').val(data.object.deptCode)

                $("#telNo_").val(data.object.telNo); // 电话
                $("#faxNo_").val(data.object.faxNo); // 传真
                $("#deptAddress_").val(data.object.deptAddress); // 地址
                $("#deptFunc_").val(data.object.deptFunc); // 部门职责
                $("#dapaId_").html(data.object.deptId);
                $('#deptType2').val(data.object.deptType || '');
                //域组织树回显
                if(data.obj1.length != 0){
                    var selectMore = [];
                    for(var i=0; i<data.obj1.length; i++){
                        $("#editDeptMap option").each(function(){
                            if($(this).val() == data.obj1[i].deptGuid){
                                $(this).attr("selected", true);
                                selectMore.push(data.obj1[i].deptGuid)
                            }
                        });
                        break;
                    }
                    $('#editDeptMap').val(selectMore);
                }
            }

        })
        //限制排序号只能输入三位有效数字
        var text = document.getElementById("deptNo_");
    }
    //新建部门/成员单位按钮
    function newDept(){
        location.reload();
        $(".step2").hide();
    };
    $.get('/syspara/selectProjectId',function (res) {
        if (res.object == 'MINHANG_EDU') {
            $('.syn_dept').css('display','inline-block')
        }else{
            $('.syn_dept').css('display','none')
        }
    })
    //同步部门
    function synDept(){
        $.ajax({
            type: "post",
            url: "/mhsso/tbbm",
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
    $(function () {
        /*左侧点击事件显示隐藏*/
        boolTwo=false;
        $("#dept_lis").on('click', function () {

            if ($(this).siblings('.pick').css('display') == 'none') {
                $(this).siblings('.pick').show();
                $(this).addClass("liDown").removeClass("liUp");
            } else {
                $(this).siblings('.pick').hide();
                $(this).addClass("liUp").removeClass("liDown");
            }
        });
        //是否显示失效部门
        $('#isPlayDept').on('click',function(){
            if(isScreen == '1'){
                loadSidebar1($('.pick'),0,'shixiao')
                isScreen = '2'
            }else if(isScreen == '2'){
                loadSidebar1($('.pick'),0)
                isScreen = '1'
            }

        })
        function saveEXaInfo(fn) {
            layer.open({
                type: 1,
                title: "删除理由",
                area: ['900px', '500px'],
                btn: ['确定', '取消'],
                content: '<div style="width:800px;margin:10px auto;">' +
                    '<table style="margin: 0;border: none;"><tr class="Attachment" style="border:none;">\n' +
                    '<td style="border:none;" width="20%">附件信息：</td>\n' +
                    '<td style="border:none;" width="80%"   class="files" id="files_txt">\n' +
                    '<div id="fileContent"></div>\n' +
                    '</td>\n' +
                    '</tr></table>'+
                    '<form method="post" action="/upload?module=sys">       <div class="layui-form-item" style="margin: 10px 0;"> '+
                    '                                        <label class="layui-form-label" style="display: inline-block;font-size: 14px;">上传附件:</label> '+
                    '                                        <div class="layui-input-block" style="line-height: 36px; display: inline-block"> '+
                    '<input type="file" multiple="multiple" name="file"  id="fileInp" style="border:none; display:inline-block; cursor:pointer;width: 62px;">'+
                    '                                 </div>' +
                    '                                   </div>' +

                    '</form>'+
                    ' <div class="layui-form-item layui-form-text">\n' +
                    '    <label class="layui-form-label" style="display: inline-block;vertical-align: top;font-size: 14px;">变更理由:</label>\n' +
                    '    <div class="layui-input-block" style="display: inline-block;">\n' +
                    '      <textarea name="approvalOpinion" placeholder="请输入理由" class="layui-textarea" style="width: 600px;height: 200px;"></textarea>\n' +
                    '    </div>\n' +
                    '  </div>' +
                    '</div>',
                success:function() {
                    //附件删除
                    $('#files_txt').on('click','.deImgs',function(){
                        var data=$(this).parents('.dech').attr('deUrl');
                        var dome=$(this).parents('.dech');
                        deleteChatment(data,dome);
                    })
                    fileuploadFn('#fileInp',$('.Attachment td').eq(1));
                },
                btn1:function(index) {
                    var doms = $('.inHidden');
                    for(var i = 0; i < doms.length; i++) {
                        attachmentId.push($(doms[i]).val().replaceAll(",",""))
                        attachmentName.push($(doms[i]).parents(".dech").attr("name1"))
                    }
                    operationReason = $('[name=approvalOpinion]').val();
                    fn()
                }
            })
        }
        // 编辑保存***********************
        $("#new_").on("click",function(){
            var queryInfo = $("#query_toId_").attr("user_id");
            var deptApproverInfo = $('#deptApprover').attr("user_id");
            if((queryInfo != queryToId|| deptApproverInfo !=deptApprover) && secretInfo == 0) {
                if(!queryInfo) {
                    layer.msg("请选择部门负责人",{icon:2})
                    return
                }
                if(queryInfo == deptApproverInfo) {
                    layer.msg("部门负责人和部门审核人不能为同一个人",{icon:2})
                    return
                }
                saveEXaInfo(function() {
                    var deptParent_num = $('#deptParent_').attr('deptid').replace(/,/g,'');
                    if(deptParent_num == ''){
                        deptParent_num = 0;
                    }
                    if(ids==deptParent_num){
                        alert('上级部门不可选当前部门，请重新选择！')
                        $('#deptParent_').attr('deptid','')
                        $('#deptParent_').attr('deptname','')
                        $('#deptParent_').val('')

                    }
                    var deptGuid = '';
                    var deptDn = '';
                    $("#editDeptMap option:selected").each(function () {
                        deptGuid += $(this).val() + ','
                        deptDn += $(this).attr('dn') + '*'
                    })
                    var data = {
                        operationReason:operationReason,
                        attachmentId:attachmentId.join(","),
                        attachmentName:attachmentName.join(","),
                        'deptApprover':$('#deptApprover').attr("user_id") || "",//部门审核人
                        'deptCode':$('#DeptNum').val(),
                        'deptId':$("#dapaId_").html(),
                        "deptNo":$("#deptNo_").val(),//  部门排序号
                        "deptName": $("#deptName_").val(),    // 部门名称
                        "telNo": $("#telNo_").val(),      //电话
                        "faxNo":$("#faxNo_").val(),  //传真
                        "deptAddress": $("#deptAddress_").val(),// 部门地址
                        "deptParent":  deptParent_num,/*上级部门ID*/
                        "isOrg": "", //是否是分支机构(0-否,1-是)
                        "orgAdmin":"",//机构管理员
                        "deptEmailAuditsIds":"", //保密邮件审核人
                        "weixinDeptId":"",  // null
                        "dingdingDeptId":"",//叮叮对应部门id
                        "gDept":'',// 是否全局部门(0-否,1-是)
                        "manager": $("#query_toId_").attr("user_id"),//部门主管
                        "assistantId": $("#query_Satrap_").attr("user_id"),//部门助理
                        "leader1": $("#query_UpAssistant_").attr("user_id"),//上级主管领导
                        "leader2": $("#query_UpSatrap_").attr("user_id"),//上级分管领导
                        "deptFunc":$("#deptFunc_").val(),//部门职能
                        "avatar": "",    // 头像
                        " userName": "",      // 用户名字
                        "uid":"",  // 用户uid
                        "userPrivName": "",// 用户角色名字
                        "type":  "", //   返回类型
                        "deptAbbrName": $('#deptAbbrName2').val(),
                        "deptType": $('#deptType2').val(),
                        'deptDisplay': $('.editDeptDisplay:checked').val(),
                        'deptGuid':deptGuid,
                        'deptDn':deptDn

                    };

                    //判断排序号是否重复
                    var deptParentStr=$("#deptParent_").attr("deptid");
                    if($("#deptParent_").attr("deptid")==''){
                        deptParentStr=0;
                    }
                    if(deptNoShow.length>3){
                        deptNoShow=deptNoShow.substring(deptNoShow.length-3,deptNoShow.length); // 部门排序号
                    }
                    if(ids!=deptParent_num){
                        $.ajax({
                            url: "/department/selDeptNoByDeptParent",
                            type: 'post',
                            dataType: "JSON",
                            data: {
                                deptParent: deptParentStr,
                                deptNo: $("#deptNo_").val(),
                                proDeptNo:deptNoShow,
                                editFlag: 1
                            },
                            success: function (json) {
                                if (!json.flag) {
                                    if (json.msg == 'repeat') {
                                        $.layerMsg({content: '<fmt:message code="adding.th.dept" />！', icon: 1}, function () {
                                        })
                                    }
                                } else {
                                    var flag = true;

                                    // 判断是否为总部
                                    if (data.deptType == '01') {
                                        // 判断是否是中电建环境
                                        $.ajax({
                                            url: '/ShowDownLoadQrCode',
                                            type: 'GET',
                                            dataType: 'JSON',
                                            async: false,
                                            success: function (res) {
                                                if (res.flag && res.object == 1) {
                                                    $.ajax({
                                                        type: 'GET',
                                                        url: '/department/getDeptByType?deptType=01',
                                                        dataType: 'JSON',
                                                        async: false,
                                                        success: function (res) {
                                                            if (res.object == 1) {
                                                                flag = false;
                                                            }
                                                        }
                                                    });
                                                }
                                            }
                                        });
                                    }

                                    if (flag) {
                                        $.ajax({
                                            url:"/department/editDept",
                                            type:'post',
                                            dataType:"JSON",
                                            data : data,
                                            success:function(data){
                                                if(data.flag){
                                                    $.layerMsg({content:'修改成功！',icon:1},function(){
//
                                                        parent.loadSidebar1(parent.$('#deptOrg'), 0)
                                                        location.reload();

                                                    });
                                                }else{
                                                    if(data.msg == '该部门名称或排序号已经存在，请重新填写！'){
                                                        $.layerMsg({content:'<fmt:message code="doc.th.deptCun" />！',icon:1},function(){

                                                        })
                                                    }else{
                                                        $.layerMsg({content: data.msg, icon:2},function(){

                                                        })
                                                    }
                                                }

                                            },
                                            error:function(e){
                                                console.log(e);
                                            }
                                        });
                                    } else {
                                        layer.msg('公司总部已存在!', {icon: 0, time: 1500});
                                        return false;
                                    }

                                }
                            }
                        })
                    }
                })
            }
            else {
                var deptParent_num = $('#deptParent_').attr('deptid').replace(/,/g,'');
                if(deptParent_num == ''){
                    deptParent_num = 0;
                }
                if(ids==deptParent_num){
                    alert('上级部门不可选当前部门，请重新选择！')
                    $('#deptParent_').attr('deptid','')
                    $('#deptParent_').attr('deptname','')
                    $('#deptParent_').val('')

                }
                var deptGuid = '';
                var deptDn = '';
                $("#editDeptMap option:selected").each(function () {
                    deptGuid += $(this).val() + ','
                    deptDn += $(this).attr('dn') + '*'
                })
                var data = {
                    'deptApprover':$('#deptApprover').attr("user_id") || "",//部门审核人
                    'deptCode':$('#DeptNum').val(),
                    'deptId':$("#dapaId_").html(),
                    "deptNo":$("#deptNo_").val(),//  部门排序号
                    "deptName": $("#deptName_").val(),    // 部门名称
                    "telNo": $("#telNo_").val(),      //电话
                    "faxNo":$("#faxNo_").val(),  //传真
                    "deptAddress": $("#deptAddress_").val(),// 部门地址
                    "deptParent":  deptParent_num,/*上级部门ID*/
                    "isOrg": "", //是否是分支机构(0-否,1-是)
                    "orgAdmin":"",//机构管理员
                    "deptEmailAuditsIds":"", //保密邮件审核人
                    "weixinDeptId":"",  // null
                    "dingdingDeptId":"",//叮叮对应部门id
                    "gDept":'',// 是否全局部门(0-否,1-是)
                    "manager": $("#query_toId_").attr("user_id"),//部门主管
                    "assistantId": $("#query_Satrap_").attr("user_id"),//部门助理
                    "leader1": $("#query_UpAssistant_").attr("user_id"),//上级主管领导
                    "leader2": $("#query_UpSatrap_").attr("user_id"),//上级分管领导
                    "deptFunc":$("#deptFunc_").val(),//部门职能
                    "avatar": "",    // 头像
                    " userName": "",      // 用户名字
                    "uid":"",  // 用户uid
                    "userPrivName": "",// 用户角色名字
                    "type":  "", //   返回类型
                    "deptAbbrName": $('#deptAbbrName2').val(),
                    "deptType": $('#deptType2').val(),
                    'deptDisplay': $('.editDeptDisplay:checked').val(),
                    'deptGuid':deptGuid,
                    'deptDn':deptDn

                };

                //判断排序号是否重复
                var deptParentStr=$("#deptParent_").attr("deptid");
                if($("#deptParent_").attr("deptid")==''){
                    deptParentStr=0;
                }
                if(deptNoShow.length>3){
                    deptNoShow=deptNoShow.substring(deptNoShow.length-3,deptNoShow.length); // 部门排序号
                }
                if(ids!=deptParent_num){
                    $.ajax({
                        url: "/department/selDeptNoByDeptParent",
                        type: 'post',
                        dataType: "JSON",
                        data: {
                            deptParent: deptParentStr,
                            deptNo: $("#deptNo_").val(),
                            proDeptNo:deptNoShow,
                            editFlag: 1
                        },
                        success: function (json) {
                            if (!json.flag) {
                                if (json.msg == 'repeat') {
                                    $.layerMsg({content: '<fmt:message code="adding.th.dept" />！', icon: 1}, function () {
                                    })
                                }
                            } else {
                                var flag = true;

                                // 判断是否为总部
                                if (data.deptType == '01') {
                                    // 判断是否是中电建环境
                                    $.ajax({
                                        url: '/ShowDownLoadQrCode',
                                        type: 'GET',
                                        dataType: 'JSON',
                                        async: false,
                                        success: function (res) {
                                            if (res.flag && res.object == 1) {
                                                $.ajax({
                                                    type: 'GET',
                                                    url: '/department/getDeptByType?deptType=01',
                                                    dataType: 'JSON',
                                                    async: false,
                                                    success: function (res) {
                                                        if (res.object == 1) {
                                                            flag = false;
                                                        }
                                                    }
                                                });
                                            }
                                        }
                                    });
                                }

                                if (flag) {
                                    $.ajax({
                                        url:"/department/editDept",
                                        type:'post',
                                        dataType:"JSON",
                                        data : data,
                                        success:function(data){
                                            if(data.flag){
                                                $.layerMsg({content:'修改成功！',icon:1},function(){
//
                                                    parent.loadSidebar1(parent.$('#deptOrg'), 0)
                                                    location.reload();

                                                });
                                            }else{
                                                if(data.msg == '该部门名称或排序号已经存在，请重新填写！'){
                                                    $.layerMsg({content:'<fmt:message code="doc.th.deptCun" />！',icon:1},function(){

                                                    })
                                                }else{
                                                    $.layerMsg({content: data.msg, icon:1},function(){

                                                    })
                                                }
                                            }

                                        },
                                        error:function(e){
                                            console.log(e);
                                        }
                                    });
                                } else {
                                    layer.msg('公司总部已存在!', {icon: 0, time: 1500});
                                    return false;
                                }

                            }
                        }
                    })
                }
            }



        });
        <%--// 删除当前部门/成员单位按钮--%>
        $("#delete_").on("click",function(){
            /* 调用插件弹窗 */
            $.layerConfirm({title:'<fmt:message code="menuSSetting.th.suredeleteMenu" />',content:'<fmt:message code="adding.th.jhddelete" />！',icon:0},function(){
                saveEXaInfo(function() {
                    if(!operationReason) {
                        layer.msg("请填写理由",{icon:2})
                        return
                    }
                    if(attachmentId.length == 0 || attachmentName.length == 0) {
                        layer.msg("请选择附件",{icon:2})
                        return
                    }
                    var data = {
                        'deptId':$("#dapaId_").html(),
                        "deptNo": $("#deptNo_").val(),   // 部门排序号
                        "attachmentId":attachmentId.join(","),
                        "attachmentName":attachmentName.join((",")),
                        operationReason:operationReason
                    };
                    $.ajax({
                        url:"/department/deletedept",
                        type:'get',
                        dataType:"JSON",
                        data : data,
                        success:function(data){
                            if(data.flag){
                                var s1=$(".select").children(".mores").attr("depid")
                                var c1=[]
                                for(i=0;i<100;i++){
                                    var c=$('.childdept[deptid='+ s1 +']').parents().prevAll().eq(i).attr('depid')
                                    c1.push(c)
                                }
                                var r=c1.filter(function(s){
                                    return s&&s.trim();
                                })
                                $.layerMsg({content:"删除成功",icon:1},function() {
                                    window.location.reload();
                                })

                            }else{
                                $.layerMsg({content:data.msg,icon:2})
                            }


                        },
                        error:function(e){
                            console.log(e);
                        }
                    });
                })

            },function(){
                return true;
            })
        });

        // 删除当前部门/成员单位按钮
        $("#del").on("click",function(){
            var id = $(this).attr('dpid');
            $.ajax({
                url:'../department/getDeptById',
                type:'get',
                dataType:'json',
                data:{'deptId':id},
                success:function(data){
                    $(".step2").show();
                    $(".kf").hide();
                    deptNoShow=data.object.deptNo;
                    /*   $("#deptNo_").attr("disabled","disabled"); */// 部门排序号,不可修改
                    if(data.object.deptNo.length>3){
                        $("#deptNo_").val(data.object.deptNo.substring(data.object.deptNo.length-3,data.object.deptNo.length)); // 部门排序号
                    }else{
                        $("#deptNo_").val(data.object.deptNo);
                    }
                    $("#deptName_").val(data.object.deptName); // 部门名称
                    if(data.object.deptParent!=0&&data.object.deptParent!="0"){
                        $("#deptParent_").val(data.object.deptParentName); // 上级部门名称
                    }else{
                        $("#deptParent_").val(''); // 上级部门名称
                    }


                    $("#deptParent_").attr("deptid",data.object.deptParent); // 上级部门id
                    $("#dapaId_").html(data.object.deptId);

                    $(".step2").hide();
                    var deptNo_ = $("#deptNo_").val() + ',';
                    var deptName_ = $("#deptName_").val() + ',';
                    var newbumen=$("#dapaId_").text() + ',';
                    $('#deptParent').val(deptName_);
                    $('#deptParent').attr('deptid',newbumen);
                    $('#deptParent').attr('deptno',deptNo_);
                    $("#dapaId_").html(data.object.deptId);

                    var data = {
                        'deptId':$("#dapaId_").html(),
                        "deptNo": $("#deptNo_").val()   // 部门排序号
                    };
                    /* 调用插件弹窗 */
                    $.layerConfirm({title:'<fmt:message code="menuSSetting.th.suredeleteMenu" />',content:'<fmt:message code="adding.th.jhddelete" />！',icon:0},function(){
                        $.ajax({
                            url:"/department/deletedept",
                            type:'get',
                            dataType:"JSON",
                            data : data,
                            success:function(data){
                                if(data.flag){
                                    parent.loadSidebar1(parent.$('#deptOrg'), 0)
                                    location.reload();
                                }else{
                                    $.layerMsg({content:data.msg,icon:2})
                                }


                            },
                            error:function(e){
                                console.log(e);
                            }

                        });
                    },function(){
                        return true;
                    })
                }
            })

        });

        var boolTwo= false;
//        部门左侧数据渲染
//        <img src="/img/spirit/icon_company.png">
        loadSidebar1($('.pick'),0)
        function loadSidebar1(target,deptId,fn) {
            target.html('');
            var datas
            if(fn == 'shixiao'){
                datas = {
                    deptId: deptId,
                    deptDisplay: '0'
                }
            }else{
                datas = {
                    deptId: deptId,
                }
            }
            $.ajax({
                url: '/department/getChDeptfq',
                type: 'get',
                data: datas,
                dataType: 'json',
                success: function (data) {
//                    $(target).empty();
                    if(arr!=undefined&&arr!=''){
                        $.ajax({
                            url:'/department/getChDeptfq',
                            type:'get',
                            dataType:"JSON",
                            async:false,
                            data : datas,
                            success:function(data){
                                var str = '';
                                data.obj.forEach(function (v, i) {
                                    if (v.deptName) {
                                        str += '<li style="position: relative;"><div class="mores" depid="' +v.deptId + '">⋮</div><span  data-numtrue="1" ' +
                                            'onclick= "imgDown(' +v.deptId + ',this,'+ v.deptDisplay +')"   data-numString="1"  style="height:35px;line-height:35px;padding-left: 14px" deptid="' + v.deptId + '" class="childdept"><span class=""></span>' +
                                            '<img src="/img/sys/dapt_right.png" id="imgleft" alt="" class="imgleft img" style="width: 8px;height: 14px;margin-top: -3px;margin-right: 4px;">' +
                                            '<a href="javascript:void(0)" class="dynatree-title" title="' + v.deptName + '" style="color:' + function(){
                                                if(v.deptDisplay == '0'){
                                                    return '#b5aeae!important'
                                                }
                                            }()+ '">' + v.deptName + '</a>' + function () {
                                                if (paraValues == '1'&&v.classifyOrg == '1') {
                                                    return '<img src="/img/common/branch.png" title="此部门为分支机构" alt="" id="left" class="imgleft" style="width: 25px;height: 25px;margin-top: -3px;margin-right: 4px;">'
                                                } else {
                                                    return ''
                                                }
                                            }() +'</span>' +
                                            '<ul style="display:none;" class="dpetWhole0"></ul>' +
                                            '</li>';
                                    }
                                })
                                widthnum++;
                                target.append(str);
                                domClick();
                            },
                            error:function(e){
                                console.log(e);
                            }
                        })
                        $('.childdept[deptid='+ arr[0] +']').click();

                    }else{
                        var str = '';
                        data.obj.forEach(function (v, i) {
                            if (v.deptName) {
                                str += '<li style="position: relative;"><div class="mores" depid="' +v.deptId + '">⋮</div><span  data-numtrue="1" ' +
                                    'onclick= "imgDown(' +v.deptId + ',this,'+ v.deptDisplay +')"   data-numString="1"  style="height:35px;line-height:35px;padding-left: 14px" deptid="' + v.deptId + '" class="childdept"><span class=""></span>' +
                                    '<img src="/img/sys/dapt_right.png" id="imgleft" alt="" class="imgleft img" style="width: 8px;height: 14px;margin-top: -3px;margin-right: 4px;">' +
                                    '<a href="javascript:void(0)" class="dynatree-title" title="' + v.deptName + '" style="color:' + function(){
                                        if(v.deptDisplay == '0'){
                                            return '#b5aeae!important'
                                        }
                                    }()+ '">' + v.deptName + '</a>' + function () {
                                        if (paraValues == '1'&&v.classifyOrg == '1') {
                                            return '<img src="/img/common/branch.png" title="此部门为分支机构" alt="" class="imgleft" style="width: 25px;height: 25px;margin-top: -3px;margin-right: 4px;">'
                                        } else {
                                            return ''
                                        }
                                    }() +'</span>' +
                                    '<ul style="display:none;" class="dpetWhole0"></ul>' +
                                    '</li>';
                            }
                        })
                        widthnum++;
                        target.append(str);
                        domClick()
                    }

                }
            })
        }
        $.ajax({
            url:'/sys/showUnitManage',
            type:'get',
            dataType:"JSON",
            data : '',
            success:function(obj){

                var data = obj.object.unitName;
                $('.pick .pickCompany .dynatree-title').text(data).attr('title',data);

            },
            error:function(e){
                console.log(e);
            }
        })

        $('body').on("click",function () {
            $(".ant-dropdown").hide();
        })

        $(document).on('click','.mores',function (e) {
            var depid = $(this).attr('depid');
            $('#newdeptDown').attr('dpid',depid);
            $('#del').attr('dpid',depid);
            var objW=$(".ant-dropdown").width();
            var objH=$(".ant-dropdown").height();
            $(".ant-dropdown").hide();
            e.stopPropagation();
            elem = $(e.currentTarget)

            var selfX=objW+e.pageX;
            var selfY=objH+e.pageY;
            bodyW=document.documentElement.clientWidth+document.documentElement.scrollLeft;
            var bodyH=document.documentElement.clientHeight+document.documentElement.scrollTop;
            if(selfX>bodyW && selfY>bodyH){
                $(".ant-dropdown").css({top:(e.pageY-objH),left:(bodyW-objW-100)}).fadeIn();
            }else if(selfY>bodyH && selfX>bodyW){
                $(".ant-dropdown").css({top:(e.pageY-objH),left:(bodyW-objW-100)}).fadeIn();
            }else if(selfY>bodyH){
                $(".ant-dropdown").css({top:(e.pageY-objH),left:e.pageX-30}).fadeIn();
            }else if(selfX>bodyW){
                $(".ant-dropdown").css({top:e.pageY+20,left:(bodyW-objW-100)}).fadeIn();
            }else{
                $(".ant-dropdown").css({top:e.pageY,left:e.pageX-30}).fadeIn();
            }
        })



    });

    // 部门点击
    function imgDown(deptNum, me,deptDisplay) {
        $("#editDeptMap").find('option:selected').attr('selected',false)
        ajaxdata(deptNum, me);
        if ($(me).attr('data-types') == undefined) {
            $(me).find('.img').attr('src', $(me).find('.img').attr('src') == '/img/sys/dapt_right.png' ? '/img/sys/dapt_down.png' : '/img/sys/dapt_right.png');
            if ($(me).find('.img').attr('src') == '/img/sys/dapt_right.png') {
                $(me).find('.img').css({"margin-top": "-3px", "margin-right": "4px", "margin-left": ""});
                $(me).find('.img').width(8);
                $(me).find('.img').height(14);
                $(me).next().hide();
                // $(me).next().html('')
            } else if ($(me).find('.img').attr('src') == '/img/sys/dapt_down.png') {
                $(me).find('.img').css({"margin-top": "-3px", "margin-right": "4px", "margin-left": "-5px"});
                $(me).find('.img').width(14);
                $(me).find('.img').height(9);
                $(me).next().show();
            }
        }
        else {
            $(me).find('.img').attr('src', $(me).find('.img').attr('src') == '/img/sys/dapt_right.png' ? '/img/sys/dapt_down.png' : '/img/sys/dapt_right.png');
            if ($(me).find('.img').attr('src') == '/img/sys/dapt_right.png') {
                $(me).find('.img').width(8);
                $(me).find('.img').height(14);
            } else if ($(me).find('.img').attr('src') == '/img/sys/dapt_down.png') {
                $(me).find('.img').width(14);
                $(me).find('.img').height(9);
            }
            if ($(me).attr('data-types') == '1') {
                $(me).next().show();
                $(me).attr('data-types', '2')
            } else if ($(me).attr('data-types') == '2') {
                $(me).next().hide();
                $(me).attr('data-types', '1')
            }
        }

        $('#btn').attr('data_id',deptNum);

        if ($(me).attr('data-numstring') == 1) {
            if (boolTwo) {
                if ($(me).next().css('display') == 'none') {
                    return;
                }
                loadSidebar1($(me).next(), deptNum, $(me).attr('data-numtrue'));
            } else {
                if(isScreen == '1'){
                    loadSidebar1($(me).next(), deptNum)
                }else{
                    loadSidebar1($(me).next(), deptNum,'shixiao')
                }

            }
        }
        if($(me).next().html()=='') {
            if (boolTwo) {
                $.loadrole($(me).next(), deptNum, $(me).attr('data-numtrue'), function () {
                    if (departments) {
                        loadSidebar1($(me).next(), deptNum)
                    }
                })
            }

        }
        if ($(me).attr('data-numstring') == 2) {
            if (boolTwo) {
                if ($(me).next().css('display') == 'none') {
                    return;
                }
                loadSidebar1($(me).next(), deptNum, $(me).attr('data-numtrue'));
            } else {
                if(isScreen == '1'){
                    loadSidebar1($(me).next(), deptNum)
                }else{
                    loadSidebar1($(me).next(), deptNum,'shixiao')
                }

            }
        }

    }
    if(arr!=''&&arr!=undefined){
        var arr2=arr[1];
        var arr5=arr[2];
        var arr6=arr[3];
        var arr7=arr[4];
    }
    function loadSidebar1(target, deptId, fn) {
        if($('.childdept[deptid=' + arr2 + ']').attr('value')=='ok'){
            arr2=''
        }else if($('.childdept[deptid=' + arr5 + ']').attr('value')=='ok'){
            arr5=''
        }else if($('.childdept[deptid=' + arr6 + ']').attr('value')=='ok'){
            arr6=''
        }else if($('.childdept[deptid=' + arr7 + ']').attr('value')=='ok'){
            arr7=''
        }
        if(fn == 'shixiao'){
            var datas = {
                deptId: deptId,
                deptDisplay: '0'
            }
        }else{
            var datas = {
                deptId: deptId,
            }
        }
        $.ajax({
            url: '/department/getChDeptfq',
            type: 'get',
            data: datas,
            dataType: 'json',
            async:false,
            success: function (data) {
                if (deptId == 0) {
                    var str = '';
                    if ($(target).children('li').length == 0) {
                        data.obj.forEach(function (v, i) {
                            if (v.deptName) {
                                str += '<li><div class="mores" depid="' +v.deptId + '">⋮</div><span data-types="1" data-numstring="1"   data-numtrue="1" ' +
                                    'onclick= "imgDown(' + v.deptId + ',this,'+ v.deptDisplay +')"  ' +
                                    'style="height:35px;line-height:35px;padding-left: 14px" ' +
                                    'deptid="' + v.deptId + '" class="childdept"><span class="">' +
                                    '</span><img src="/img/commonTheme/${sessionScope.InterfaceModel}/icon_company.png" alt="" ' +
                                    'style="vertical-align: middle;width: 15px;' +
                                    'margin-right: 10px;margin-left:15px;">' +
                                    '<a href="javascript:void(0)" ' +
                                    'class="dynatree-title" title="' + v.deptName + '" style="color:' + function(){
                                        if(v.deptDisplay == '0'){
                                            return '#b5aeae!important'
                                        }
                                    }()+ '">' + v.deptName + '</a>' + function () {
                                        if (paraValues == '1'&&v.classifyOrg == '1') {
                                            return '<img src="/img/common/branch.png" title="此部门为分支机构" alt="" class="imgleft" style="width: 25px;height: 25px;margin-top: -3px;margin-right: 4px;">'
                                        } else {
                                            return ''
                                        }
                                    }() +
                                    '</span><ul style="display:none;" class="dpetWhole0"></ul></li>';
                            }
                        })
                        target.html(str);
                    } else {
                        $(target).children('li').each(function (v, l) {
                            for (var i = 0; i < data.obj.length; i++) {
                                if ($($(target).children('li')[i]).children('span').attr('deptid') != data.obj[i].deptId) {
                                    if (v.deptName) {
                                        str = '<li><div class="mores" depid="' +data.obj.deptId + '">⋮</div><span data-types="1" data-numstring="1"   data-numtrue="1" ' +
                                            'onclick= "imgDown(' + data.obj.deptId + ',this,'+ data.obj.deptDisplay +')"  ' +
                                            'style="height:35px;line-height:35px;padding-left: 14px" ' +
                                            'deptid="' + data.obj.deptId + '" class="childdept">' +
                                            '<span class="">' +
                                            '</span><img src="/img/commonTheme/${sessionScope.InterfaceModel}/icon_company.png" alt="" ' +
                                            'style="vertical-align: middle;width: 15px;' +
                                            'margin-right: 10px;margin-left:15px;">' +
                                            '<a href="javascript:void(0)" ' +
                                            'class="dynatree-title" title="' + data.obj.deptName + '" style="color:' + function(){
                                                if(v.deptDisplay == '0'){
                                                    return '#b5aeae!important'
                                                }
                                            }()+ '">' + data.obj.deptName + '</a>' + function () {
                                                if (paraValues == '1'&&v.classifyOrg == '1') {
                                                    return '<img src="/img/common/branch.png" title="此部门为分支机构" alt="" class="imgleft" style="width: 25px;height: 25px;margin-top: -3px;margin-right: 4px;">'
                                                } else {
                                                    return ''
                                                }
                                            }() +
                                            '</span><ul style="display:none;" class="dpetWhole0"></ul></li>';
                                    }
                                    $(target).append(str)
                                }
                            }
                            return false
                        })
                    }
                    widthnum++;
                    if (fn != undefined && fn != 'shixiao') {
                        fn($(target).find('.dpetWhole0'))
                    }
                } else {
                    var str = '';
                    if ($(target).children('li').length == 0) {
                        data.obj.forEach(function (v, i) {
                            var targetnum = parseInt($(target).prev().attr('data-numtrue'))

                            if (v.deptName && v.isHaveCh == 1) {
                                str += '<li><div class="mores" depid="' +v.deptId + '">⋮</div><span  onclick= "imgDown(' + v.deptId + ',this,'+ v.deptDisplay +')" ' +
                                    'data-numString="2" deptid="' + v.deptId + '" ' +
                                    'data-numtrue="' + (targetnum + 1) + '"  ' +
                                    'style="padding-left:' +
                                    (20 + (20 * parseInt($(target).prev().attr('data-numtrue')))) + 'px;' +
                                    'height:35px;line-height:35px;"  deptid="' + v.deptId + '" class="childdept">' +
                                    '<span></span><img class="img" id="img' + v.deptId + '" src="/img/sys/dapt_right.png" ' +
                                    'style="width: 8px;height:14px;margin-top: -3px;margin-right:4px;" alt="">' +
                                    '&nbsp;<a href="javascript:void(0)" class="dynatree-title" ' +
                                    'title="' + v.deptName + '" style="color:' + function(){
                                        if(v.deptDisplay == '0'){
                                            return '#b5aeae!important'
                                        }
                                    }()+ '">' + v.deptName + '</a>'+ function () {
                                        if (paraValues == '1'&&v.classifyOrg == '1') {
                                            return '<img src="/img/common/branch.png" title="此部门为分支机构" alt="" class="imgleft" style="width: 25px;height: 25px;margin-top: -3px;margin-right: 4px;">'
                                        } else {
                                            return ''
                                        }
                                    }() +'</span>' +
                                    '<ul style="display:none;"></ul></li>';
                            } else {
                                str += '<li><div class="mores" depid="' +v.deptId + '">⋮</div>' +
                                    '<span onclick="imgDown(' + v.deptId + ',this,'+ v.deptDisplay +')" ' +
                                    'data-numString="1" deptid="' + v.deptId + '" ' +
                                    'data-numtrue="' + (targetnum + 1) + '" ' +
                                    'style="padding-left:' + (20 + (20 * parseInt($(target).prev().attr('data-numtrue')))) + 'px;' +
                                    'height:35px;line-height:35px;"  deptid="' + v.deptId + '" ' +
                                    'class="childdept"><span></span><img class="img" src="/img/sys/dapt_right.png" ' +
                                    'style="width: 8px;height:14px;margin-top: -3px;margin-right:4px;" ' +
                                    'alt="">&nbsp;<a href="javascript:void(0)" class="dynatree-title" ' +
                                    'title="' + v.deptName + '" style="color:' + function(){
                                        if(v.deptDisplay == '0'){
                                            return '#b5aeae!important'
                                        }
                                    }()+ '">' + v.deptName + '</a>'+ function () {
                                        if (paraValues == '1'&&v.classifyOrg == '1') {
                                            return '<img src="/img/common/branch.png" title="此部门为分支机构" alt="" class="imgleft" style="width: 25px;height: 25px;margin-top: -3px;margin-right: 4px;">'
                                        } else {
                                            return ''
                                        }
                                    }() +'</span><ul style="display:none;"></ul></li>';
                            }

                        });
                        target.html(str);
                    } else {
                        $(target).children('li').each(function (v, l) {

                            for (var i = 0; i < data.obj.length; i++) {



                                if ($($(target).children('li')[i]).children('span').attr('deptid') != data.obj[i].deptId) {

                                    var targetnum = parseInt($(target).prev().attr('data-numtrue'))

                                    if (data.obj[i].deptName && data.obj[i].isHaveCh == 1) {
                                        str = '<li><div class="mores" depid="' +data.obj[i].deptId + '">⋮</div><span  onclick= "imgDown(' + data.obj[i].deptId + ',this)" ' +
                                            'data-numString="2" deptid="' + data.obj[i].deptId + '" ' +
                                            'data-numtrue="' + (targetnum + 1) + '"  ' +
                                            'style="padding-left:' + (20 + (20 *
                                                parseInt($(target).prev().attr('data-numtrue')))) + 'px;' +
                                            'height:35px;line-height:35px;"  deptid="' + data.obj[i].deptId + '" class="childdept">' +
                                            '<span></span><img class="img" id="img' + data.obj[i].deptId + '" src="/img/sys/dapt_right.png" ' +
                                            'style="width: 8px;height:14px;margin-top: -3px;margin-right:4px;" alt="">' +
                                            '&nbsp;<a href="javascript:void(0)" class="dynatree-title" ' +
                                            'title="' + data.obj[i].deptName + '" style="color:' + function(){
                                                if(v.deptDisplay == '0'){
                                                    return '#b5aeae!important'
                                                }
                                            }()+ '">' + data.obj[i].deptName + '</a>'+ function () {
                                                if (paraValues == '1'&&v.classifyOrg == '1') {
                                                    return '<img src="/img/common/branch.png" title="此部门为分支机构" alt="" class="imgleft" style="width: 25px;height: 25px;margin-top: -3px;margin-right: 4px;">'
                                                } else {
                                                    return ''
                                                }
                                            }() +'</span>' +
                                            '<ul style="display:none;"></ul></li>';
                                    } else {
                                        str = '<li><div class="mores" depid="' +data.obj[i].deptId + '">⋮</div>' +
                                            '<span onclick="imgDown(' + data.obj[i].deptId + ',this)" ' +
                                            'data-numString="1" deptid="' + data.obj[i].deptId + '" ' +
                                            'data-numtrue="' + (targetnum + 1) + '" ' +
                                            'style="padding-left:' + (20 + (20 * parseInt($(target).prev().attr('data-numtrue')))) + 'px;' +
                                            'height:35px;line-height:35px;"  deptid="' + data.obj[i].deptId + '" ' +
                                            'class="childdept"><span></span>' +
                                            '<img class="img" src="/img/sys/dapt_right.png" style="width: 8px;height:14px;margin-top: -3px;margin-right:4px;" alt="">&nbsp;<a href="javascript:void(0)" class="dynatree-title" ' +
                                            'title="' + data.obj[i].deptName + '" style="color:' + function(){
                                                if(v.deptDisplay == '0'){
                                                    return '#b5aeae!important'
                                                }
                                            }()+ '">' + data.obj[i].deptName + '</a>'+ function () {
                                                if (paraValues == '1'&&v.classifyOrg == '1') {
                                                    return '<img src="/img/common/branch.png" title="此部门为分支机构" alt="" class="imgleft" style="width: 25px;height: 25px;margin-top: -3px;margin-right: 4px;">'
                                                } else {
                                                    return ''
                                                }
                                            }() +'</span><ul style="display:none;"></ul></li>';
                                    }
                                    $(target).append(str)
                                }
                            }
                            return false;
                        })
                    }
                    widthnum++
                    if (fn != undefined && fn != 'shixiao') {
                        fn();
                    }
                }

            }
        })
        if(arr2!=undefined&&arr2!='') {
            $('.childdept[deptid=' + arr2 + ']').attr('value','ok')
            $('.childdept[deptid=' + arr2 + ']').click();

        }
        if(arr2==''&&arr!='') {
            $('.childdept[deptid=' + arr5 + ']').attr('value','ok')
            $('.childdept[deptid=' + arr5 + ']').click();
        }
        if(arr5==''&&arr!='') {
            $('.childdept[deptid=' + arr6 + ']').next().css('background','white')
            $('.childdept[deptid=' + arr6 + ']').attr('value','ok')
            $('.childdept[deptid=' + arr6 + ']').click();
        }
        if(arr6==''&&arr!='') {
            $('.childdept[deptid=' + arr7 + ']').next().css('background','white')
            $('.childdept[deptid=' + arr7 + ']').attr('value','ok')
            $('.childdept[deptid=' + arr7 + ']').click();
        }

    }
</script>

</html>
