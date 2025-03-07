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
    <title>学校设置</title>
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
    <script src="../lib/laydate/laydate.js"></script>
    <%--<script type="text/javascript" src="../lib/easyui/jquery.easyui.min.js"></script>--%>
    <%--<script type="text/javascript" src="../lib/easyui/tree.js"></script>--%>
    <%--<script type="text/javascript" src="../js/index.js"></script>--%>
    <script src="../lib/layer/layer.js?20201106"></script>
    <script src="/js/base/base.js"></script>
    <%--<script src="../lib/laydate.js"></script>--%>
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
        .dpetWhole0{overflow: hidden}
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
            width: 1200px
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
            float:right!important;
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
        .spanUP {
            display: block;
            width: 100%;
            padding-left: 30px;
            font-size: 13pt;
            height: 40px;
            line-height: 40px;
            border-bottom: #ddd 1px solid;
            cursor: pointer;
        }
    </style>
    <link rel="stylesheet" type="text/css" href="/css/commonTheme/${sessionScope.InterfaceModel}/commonTheme.css"/>
</head>
<body style="overflow:scroll;overflow-y: hidden;overflow-x:hidden;">

<div class="wrap" style="margin-left:0px !important;">
    <div class="head">
        <div class="head_left">
            <img src="/img/commonTheme/${sessionScope.InterfaceModel}/dept1.png" alt="">
            <h1>学校设置</h1>
        </div>
    </div>

    <div class="cont" style="overflow-y: auto;">
        <div class="cont_left" id="cont_left">
            <ul>
                <li class="liDown dept_li" id="dept_lis" style="padding-left: 30px;">
                    <img src="/img/commonTheme/${sessionScope.InterfaceModel}/icon_sectorList.png" style="vertical-align: middle;width: 15px;margin-right: 10px;" alt="学校列表">学校列表
                    <a href="javascript:void(0)" onclick="location.reload()" style="color: #207BD6;margin-left: 20px;cursor: pointer;"><img src="/img/commonTheme/theme6/icon_shuaxin_03.png" style="margin-right: 8px;margin-bottom: 1px;">刷新</a>
                </li>
                <li class="pick" id="pick" style="display: block;">
                    <div class="pickCompany">
                        <span style="height:35px;line-height:35px;" class="childdept">
                            <img src="/img/commonTheme/${sessionScope.InterfaceModel}/icon_company.png" alt="" style="vertical-align: middle;width: 15px;margin-right: 10px;margin-left: 13px;margin-bottom: 4px;">
                            <a href="javascript:void(0)" class="dynatree-title" title=""></a>
                        </span>
                    </div>
                </li>

                <li id="queryExport">
                    <span class="spanUP liUp queryExport">
                            <img src="/img/commonTheme/${sessionScope.InterfaceModel}/icon_userQuery.png" style="vertical-align: middle;width: 15px;margin-right: 10px;" alt="用户查询或导出">
                            学校查询
                        </span>
                </li>
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
            <jsp:include page="school_deptManagement.jsp"/>
        </div>

    </div>
</div>
</body>
<script type="text/javascript">
    function autodivheight(){
        var winHeight=0;
        if (window.innerHeight)
            winHeight = window.innerHeight;
        else if ((document.body) && (document.body.clientHeight))
            winHeight = document.body.clientHeight;
        if (document.documentElement && document.documentElement.clientHeight)
            winHeight = document.documentElement.clientHeight;
        winWidth = document.documentElement.clientWidth;
        $('#pick').css({'min-height':winHeight - 255 +"px"})

    }
    $('#pick').height($(window).height()-140)
    boolTwo=false;
    numstring=true;
    //正在开发中
    function develop(me){
        $('.cont_rig').hide()
        $('.mainRight').show()
        $('.mainRight').height($(document).height()-$('.head').height())
        $('.mainRight').find('iframe').prop('src',$(me).attr('data-url'))
    };


    //编辑回显详情
    var deptNoShow='';
    function ajaxdata(id,me){
        $('.mainRight').hide()
        $('.cont_rig').show()
        if($(me).attr('data-numtrue')==1){
            $(me).parent().addClass('select').siblings().removeClass('select').find('li').removeClass('select').end().parent().find('ul').css('background','#fff')
        }else{
            $(me).parents('li').removeClass('select').end().parent().addClass('select').siblings().removeClass('select').find('li').removeClass('select').end().parent().find('ul').css('background','#fff')
        }
        $.ajax({
            url:'/department/getschoolDeptById',
            type:'get',
            dataType:'json',
            data:{'deptId':id},
            success:function(data){
                $(".tishi").hide();
                $(".step2").show();
                $(".step3").hide();
                $(".step4").hide();

                $('.DEPT_ID').html(data.object.DEPT_ID)
                $('input[name="DEPT_NO"]').val(data.object.DEPT_NO),
                    $('input[name="ORGAN_FULLNAME"]').val(data.object.ORGAN_FULLNAME)
                $('input[name="DEPT_NAME"]').val(data.object.DEPT_NAME)
                $('input[name="ORGAN_NUM"]').val(data.object.ORGAN_NUM)
                $('input[name="UNIFIED_CREDIT_CODE"]').val(data.object.UNIFIED_CREDIT_CODE)
                if(data.object.STATE_PRIVATE_ID=='4'|| data.object.STATE_PRIVATE_ID=='5' || data.object.STATE_PRIVATE_ID=='6' || data.object.STATE_PRIVATE_ID=='2'){
                    $('select[name="STATE_PRIVATE_ID"]').val('2')
                }else if(data.object.STATE_PRIVATE_ID=='1' || data.object.STATE_PRIVATE_ID=='7' || data.object.STATE_PRIVATE_ID=='8') {
                    $('select[name="STATE_PRIVATE_ID"]').val('1')
                }else if(data.object.STATE_PRIVATE_ID=='3') {
                    $('select[name="STATE_PRIVATE_ID"]').val('3')
                }else if(data.object.STATE_PRIVATE_ID=='9') {
                    $('select[name="STATE_PRIVATE_ID"]').val('9')
                }else if(data.object.STATE_PRIVATE_ID=='' || data.object.STATE_PRIVATE_ID==undefined){
                    $('select[name="STATE_PRIVATE_ID"]').val('')
                }
                $('select[name="SCHOOL_TYPE"]').val(data.object.SCHOOL_TYPE)
                $('select[name="SCHOOL_MANAGE_TYPE"]').val(data.object.SCHOOL_MANAGE_TYPE)
                $('select[name="DEPT_AVENUE"]').val(data.object.DEPT_AVENUE)

                $('input[name="DEPT_ADDRESS"]').val(data.object.DEPT_ADDRESS)
                $('input[name="DEPT_CODE"]').val(data.object.DEPT_CODE)
                $('input[name="TEL_NO"]').val(data.object.TEL_NO)
                $('input[name="FAX_NO"]').val(data.object.FAX_NO)

                $('input[name="STUDENT_NUM"]').val(data.object.STUDENT_NUM)
                $('input[name="TEACHER_NUM"]').val(data.object.TEACHER_NUM)
                $('input[name="STUDENT_LOST_NUM"]').val(data.object.STUDENT_LOST_NUM)
                $('input[name="TEACHER_LOST_NUM"]').val(data.object.TEACHER_LOST_NUM)
                $('input[name="CHILD_SCHOOL_CODE"]').val(data.object.CHILD_SCHOOL_CODE)
            }
        })
    }
    //新建部门/成员单位按钮
    function newDept(){
        location.reload();
        $(".step1").show();
        $(".step2").hide();
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
        // 编辑保存***********************

        $("#new_").on("click",function(){
            if($('input[name="DEPT_NO"]').val()=='' ){
                layer.msg('学校排序号为必填项！',{icon:0});
                return false
            }
            if( $('input[name="ORGAN_FULLNAME"]').val()==''){
                layer.msg('学校全称为必填项！',{icon:0});
                return false
            }
            if( $('input[name="DEPT_NAME"]').val()=='' ){
                layer.msg('学校简称为必填项！',{icon:0});
                return false
            }
            if( $('input[name="ORGAN_NUM"]').val()=='' ){
                layer.msg('学校编码为必填项！',{icon:0});
                return false
            }
            var DEPT_ADDRESS=$('input[name="DEPT_ADDRESS"]').val()
            var DEPT_CODE=$('input[name="DEPT_CODE"]').val()
            var TEL_NO=$('input[name="TEL_NO"]').val()
            var FAX_NO=$('input[name="FAX_NO"]').val()


            var STUDENT_NUM=$('input[name="STUDENT_NUM"]').val()
            var TEACHER_NUM=$('input[name="TEACHER_NUM"]').val()
            var STUDENT_LOST_NUM=$('input[name="STUDENT_LOST_NUM"]').val()
            var TEACHER_LOST_NUM=$('input[name="TEACHER_LOST_NUM"]').val()
            var CHILD_SCHOOL_CODE=$('input[name="CHILD_SCHOOL_CODE"]').val()
            if($('input[name="STUDENT_NUM"]').val()==''){
                STUDENT_NUM=0
            }
            if($('input[name="TEACHER_NUM"]').val()==''){
                TEACHER_NUM=0
            }
            if($('input[name="STUDENT_LOST_NUM"]').val()==''){
                STUDENT_LOST_NUM=0
            }
            if($('input[name="TEACHER_LOST_NUM"]').val()==''){
                TEACHER_LOST_NUM=0
            }
            var data = {
                DEPT_ID: $('.DEPT_ID').html(),
                DEPT_NO:$('input[name="DEPT_NO"]').val(),
                ORGAN_FULLNAME:$('input[name="ORGAN_FULLNAME"]').val(),
                DEPT_NAME:$('input[name="DEPT_NAME"]').val(),
                ORGAN_NUM:$('input[name="ORGAN_NUM"]').val(),
                UNIFIED_CREDIT_CODE:$('input[name="UNIFIED_CREDIT_CODE"]').val(),
                STATE_PRIVATE_ID:$('select[name="STATE_PRIVATE_ID"]').val(),
                SCHOOL_TYPE:$('select[name="SCHOOL_TYPE"]').val(),
                SCHOOL_MANAGE_TYPE:$('select[name="SCHOOL_MANAGE_TYPE"]').val(),
                DEPT_AVENUE:$('select[name="DEPT_AVENUE"]').val(),

                DEPT_ADDRESS:DEPT_ADDRESS,
                DEPT_CODE:DEPT_CODE,
                TEL_NO:TEL_NO,
                FAX_NO:FAX_NO,

                STUDENT_NUM:STUDENT_NUM,
                TEACHER_NUM:TEACHER_NUM,
                STUDENT_LOST_NUM:STUDENT_LOST_NUM,
                TEACHER_LOST_NUM:TEACHER_LOST_NUM,
                CHILD_SCHOOL_CODE:CHILD_SCHOOL_CODE,
            };
            $.ajax({
                url:'/department/editschoolDept',
                type:'post',
                dataType:'json',
                data:{jsonStr:JSON.stringify(data)},
                success:function(res){
                    if(res.flag){
                        layer.msg('修改成功',{icon:1});
                    }
                }
            })

        });
        <%--// 删除当前部门/成员单位按钮--%>
        $("#delete_").on("click",function(){
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
                    $(".step1").hide();
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

                    $(".step1").show();
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

            $.ajax({
                url: '/department/getChDeptfq',
                type: 'get',
                data: {
                    deptId: deptId
                },
                dataType: 'json',
                success: function (data) {

//                    $(target).empty();
                    var str = '';
                    data.obj.forEach(function (v, i) {
                        if (v.deptName) {
                            str += '<li style="position: relative"><div class="mores" depid="' +v.deptId + '">⋮</div><span  data-numtrue="1" ' +
                                'onclick= "imgDown(' +v.deptId + ',this)"   data-numString="1"  style="height:35px;line-height:35px;padding-left: 14px" deptid="' + v.deptId + '" class="childdept"><span class=""></span>' +
                                '<img src="/img/sys/dapt_right.png" alt="" class="imgleft" style="width: 8px;height: 14px;margin-top: -3px;margin-right: 4px;"><a href="javascript:void(0)" class="dynatree-title" title="' + v.deptName + '">' + v.deptName + '</a></span><ul style="display:none;" class="dpetWhole0"></ul>' +
                                '</li>';
                        }
                    })
                    widthnum++;
                    target.append(str);

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

    //部门查询
    $('#queryExport').on("click",function () {
        $(".tishi").hide();
        $(".step2").hide();
        $(".step3").show();
        $(".step4").hide();

    });
    $('#getSut_').on("click",function () {
        $(".tishi").hide();
        $(".step2").hide();
        $(".step3").hide();
        $(".step4").show();

        $.post('/department/getDeptByManyMap',{
            ORGAN_FULLNAME:$('.step3').find('input[name="ORGAN_FULLNAME"]').val()
            ,ORGAN_NUM:$('.step3').find('input[name="ORGAN_NUM"]').val()
            ,UNIFIED_CREDIT_CODE:$('.step3').find('input[name="UNIFIED_CREDIT_CODE"]').val()
        },function(res){
            var obj = res.obj;
            if(obj && res.flag){
                $('.step4').find('tbody').html('');

                for (let i = 0; i <obj.length ; i++) {
                    var str = '<tr>\n' +
                        '            <td width="4%" align="center" valian="middle"> </td>\n' +
                        '            <td width="8%"  align="center" valian="middle">'+function () {
                            if (obj[i].DEPT_NO){
                                return obj[i].DEPT_NO;
                            }
                            return '';
                        }()+'</td>\n' +
                        '            <td width="8%"  align="center" valian="middle">'+function () {
                            if (obj[i].ORGAN_FULLNAME){
                                return obj[i].ORGAN_FULLNAME;
                            }
                            return '';
                        }()+'</td>\n' +
                        '            <td width="8%"  align="center" valian="middle">'+function () {
                            if (obj[i].DEPT_NAME){
                                return obj[i].DEPT_NAME
                            }
                            return '';
                        }()+'</td>\n' +
                        '            <td width="8%"  align="center" valian="middle">'+function () {
                            if (obj[i].ORGAN_NUM){
                                return obj[i].ORGAN_NUM;
                            }
                            return '';
                        }()+'</td>\n' +
                        '            <td width="14%"  align="center" valian="middle">'+function () {
                            if (obj[i].CHILD_SCHOOL_CODE){
                                return obj[i].CHILD_SCHOOL_CODE
                            }
                            return '';
                        }()+'</td>\n' +
                        '            <td width="8%"  align="center" valian="middle">'+function () {
                            if (obj[i].UNIFIED_CREDIT_CODE){
                                return obj[i].UNIFIED_CREDIT_CODE;
                            }
                            return '';
                        }()+'</td>\n' +
                        '            <td width="18%"  align="center" valian="middle">'+function () {
                            if (obj[i].STATE_PRIVATE_ID){
                                switch (obj[i].STATE_PRIVATE_ID) {
                                    case '1':
                                        return '公办'
                                        break
                                    case '2':
                                        return '民办'
                                        break
                                    default:
                                        return ''
                                        break
                                }
                            }
                            return '';
                        }()+'</td>\n' +
                        '            <td width="8%"  align="center" valian="middle">'+function () {
                            if (obj[i].SCHOOL_TYPE){
                                switch (obj[i].SCHOOL_TYPE) {
                                    case '1':
                                        return '机关'
                                        break
                                    case '2':
                                        return '直属单位'
                                        break
                                    case '3':
                                        return '托育机构'
                                        break
                                    case '4':
                                        return '幼儿园'
                                        break
                                    case '5':
                                        return '小学'
                                        break
                                    case '6':
                                        return '初级中学'
                                        break
                                    case '7':
                                        return '九年一贯制'
                                        break
                                    case '8':
                                        return '高级中学'
                                        break
                                    case '9':
                                        return '完全中学'
                                        break
                                    case '10':
                                        return '十二年一贯制'
                                        break
                                    case '11':
                                        return '听力障碍学校'
                                        break
                                    case '12':
                                        return '智力障碍学校'
                                        break
                                    case '13':
                                        return '工读学校'
                                        break
                                    case '14':
                                        return '孤残学校'
                                        break
                                    case '15':
                                        return '外籍学校'
                                        break
                                    case '16':
                                        return '中等职业学校'
                                        break
                                    case '17':
                                        return '职业高中学校'
                                        break
                                    case '18':
                                        return '开放大学'
                                        break
                                    case '19':
                                        return '农村成人文化技术培训学校'
                                        break
                                    case '20':
                                        return '职工技术培训学校'
                                        break
                                    case '21':
                                        return '民办非学历教育机构'
                                        break
                                    default:
                                        return ''
                                        break
                                }
                            }
                            return '';
                        }()+'</td>\n' +
                        '            <td width="16%"  align="center" valian="middle"><span style="color: #0a6aa1;" onclick="imgDown('+obj[i].DEPT_ID + ',this)">编辑</span></td>\n' +
                        '        </tr>';
                    $('.step4').find('tbody').append(str);
                }

            }
        });

    });


    // 部门点击
    function imgDown(deptNum, me) {

        ajaxdata(deptNum, me);
        if ($(me).attr('data-types') == undefined) {
            $(me).find('img').attr('src', $(me).find('img').attr('src') == '/img/sys/dapt_right.png' ? '/img/sys/dapt_down.png' : '/img/sys/dapt_right.png');
            if ($(me).find('img').attr('src') == '/img/sys/dapt_right.png') {
                $(me).find('img').css({"margin-top": "-3px", "margin-right": "4px", "margin-left": ""});
                $(me).find('img').width(8);
                $(me).find('img').height(14);
                $(me).next().hide();
                // $(me).next().html('')
            } else if ($(me).find('img').attr('src') == '/img/sys/dapt_down.png') {
                $(me).find('img').css({"margin-top": "-3px", "margin-right": "4px", "margin-left": "-5px"});
                $(me).find('img').width(14);
                $(me).find('img').height(9);
                $(me).next().show();
            }
        }
        else {
            $(me).find('img').attr('src', $(me).find('img').attr('src') == '/img/sys/dapt_right.png' ? '/img/sys/dapt_down.png' : '/img/sys/dapt_right.png');
            if ($(me).find('img').attr('src') == '/img/sys/dapt_right.png') {
                $(me).find('img').width(8);
                $(me).find('img').height(14);
            } else if ($(me).find('img').attr('src') == '/img/sys/dapt_down.png') {
                $(me).find('img').width(14);
                $(me).find('img').height(9);
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
                loadSidebar1($(me).next(), deptNum)
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
            // if (numstring) {
            console.log($(me).next())
            console.log(deptNum)
            loadSidebar1($(me).next(), deptNum)
            // }else{
            //
            // }
        }

    }

    function loadSidebar1(target, deptId, fn) {
        $.ajax({
            url: '/department/getChDeptfq',
            type: 'get',
            data: {
                deptId: deptId
            },
            dataType: 'json',
            success: function (data) {

                if (deptId == 0) {
                    var str = '';
                    if ($(target).children('li').length == 0) {
                        data.obj.forEach(function (v, i) {
                            if (v.deptName) {
                                str += '<li><div class="mores" depid="' +v.deptId + '">⋮</div><span data-types="1" data-numstring="1"   data-numtrue="1" ' +
                                    'onclick= "imgDown(' + v.deptId + ',this)"  ' +
                                    'style="height:35px;line-height:35px;padding-left: 14px" ' +
                                    'deptid="' + v.deptId + '" class="childdept"><span class="">' +
                                    '</span><img src="/img/commonTheme/${sessionScope.InterfaceModel}/icon_company.png" alt="" ' +
                                    'style="vertical-align: middle;width: 15px;' +
                                    'margin-right: 10px;margin-left:15px;">' +
                                    '<a href="javascript:void(0)" ' +
                                    'class="dynatree-title" title="' + v.deptName + '">' + v.deptName + '</a>' +
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
                                            'onclick= "imgDown(' + data.obj.deptId + ',this)"  ' +
                                            'style="height:35px;line-height:35px;padding-left: 14px" ' +
                                            'deptid="' + data.obj.deptId + '" class="childdept">' +
                                            '<span class="">' +
                                            '</span><img src="/img/commonTheme/${sessionScope.InterfaceModel}/icon_company.png" alt="" ' +
                                            'style="vertical-align: middle;width: 15px;' +
                                            'margin-right: 10px;margin-left:15px;">' +
                                            '<a href="javascript:void(0)" ' +
                                            'class="dynatree-title" title="' + data.obj.deptName + '">' + data.obj.deptName + '</a>' +
                                            '</span><ul style="display:none;" class="dpetWhole0"></ul></li>';
                                    }
                                    $(target).append(str)
                                }
                            }
                            return false
                        })
                    }
                    widthnum++;
                    if (fn != undefined) {
                        fn($(target).find('.dpetWhole0'))
                    }
                } else {
                    var str = '';
                    if ($(target).children('li').length == 0) {
                        data.obj.forEach(function (v, i) {
                            var targetnum = parseInt($(target).prev().attr('data-numtrue'))

                            if (v.deptName && v.isHaveCh == 1) {
                                str += '<li><div class="mores" depid="' +v.deptId + '">⋮</div><span  onclick= "imgDown(' + v.deptId + ',this)" ' +
                                    'data-numString="2" deptid="' + v.deptId + '" ' +
                                    'data-numtrue="' + (targetnum + 1) + '"  ' +
                                    'style="padding-left:' +
                                    (20 + (20 * parseInt($(target).prev().attr('data-numtrue')))) + 'px;' +
                                    'height:35px;line-height:35px;"  deptid="' + v.deptId + '" class="childdept">' +
                                    '<span></span><img id="img' + v.deptId + '" src="/img/sys/dapt_right.png" ' +
                                    'style="width: 8px;height:14px;margin-top: -3px;margin-right:4px;" alt="">' +
                                    '&nbsp;<a href="javascript:void(0)" class="dynatree-title" ' +
                                    'title="' + v.deptName + '">' + v.deptName + '</a></span>' +
                                    '<ul style="display:none;"></ul></li>';
                            } else {
                                str += '<li><div class="mores" depid="' +v.deptId + '">⋮</div>' +
                                    '<span onclick="imgDown(' + v.deptId + ',this)" ' +
                                    'data-numString="1" deptid="' + v.deptId + '" ' +
                                    'data-numtrue="' + (targetnum + 1) + '" ' +
                                    'style="padding-left:' + (20 + (20 *
                                        parseInt($(target).prev().attr('data-numtrue')))) + 'px;' +
                                    'height:35px;line-height:35px;"  deptid="' + v.deptId + '" ' +
                                    'class="childdept"><span></span><img  src="/img/sys/dapt_right.png" ' +
                                    'style="width: 8px;height:14px;margin-top: -3px;margin-right:4px;" ' +
                                    'alt="">&nbsp;<a href="javascript:void(0)" class="dynatree-title" ' +
                                    'title="' + v.deptName + '">' + v.deptName + '</a></span><ul ' +
                                    'style="display:none;"></ul></li>';
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
                                            'style="padding-left:' +
                                            (20 + (20 * parseInt($(target).prev().attr('data-numtrue')))) + 'px;' +
                                            'height:35px;line-height:35px;"  deptid="' + data.obj[i].deptId + '" class="childdept">' +
                                            '<span></span><img id="img' + data.obj[i].deptId + '" src="/img/sys/dapt_right.png" ' +
                                            'style="width: 8px;height:14px;margin-top: -3px;margin-right:4px;" alt="">' +
                                            '&nbsp;<a href="javascript:void(0)" class="dynatree-title" ' +
                                            'title="' + data.obj[i].deptName + '">' + data.obj[i].deptName + '</a></span>' +
                                            '<ul style="display:none;"></ul></li>';
                                    } else {
                                        str = '<li><div class="mores" depid="' +data.obj[i].deptId + '">⋮</div>' +
                                            '<span onclick="imgDown(' + data.obj[i].deptId + ',this)" ' +
                                            'data-numString="1" deptid="' + data.obj[i].deptId + '" ' +
                                            'data-numtrue="' + (targetnum + 1) + '" ' +
                                            'style="padding-left:' + (20 + (20 *
                                                parseInt($(target).prev().attr('data-numtrue')))) + 'px;' +
                                            'height:35px;line-height:35px;"  deptid="' + data.obj[i].deptId + '" ' +
                                            'class="childdept"><span></span><img  src="/img/sys/dapt_right.png" ' +
                                            'style="width: 8px;height:14px;margin-top: -3px;margin-right:4px;" ' +
                                            'alt="">&nbsp;<a href="javascript:void(0)" class="dynatree-title" ' +
                                            'title="' + data.obj[i].deptName + '">' + data.obj[i].deptName + '</a></span><ul ' +
                                            'style="display:none;"></ul></li>';
                                    }
                                    $(target).append(str)
                                }
                            }
                            return false;
                        })
                    }
                    widthnum++
                    if (fn != undefined) {
                        fn();
                    }
                }
            }
        })
    }
</script>

</html>
