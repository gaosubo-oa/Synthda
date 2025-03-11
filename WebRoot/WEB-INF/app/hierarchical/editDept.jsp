<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
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
    <!-- <meta name="viewport" content="width=device-width, initial-scale=1.0"> -->
    <link rel="stylesheet" type="text/css" href="/lib/laydate/skins/default/laydate.css"/>
    <link rel="stylesheet" type="text/css" href="../../css/dept/deptManagement.css"/>
    <link rel="stylesheet" type="text/css" href="../../lib/easyui/themes/easyui.css"/>
    <link rel="stylesheet" type="text/css" href="../../lib/easyui/themes/icon.css"/>
    <link rel="stylesheet" type="text/css" href="../../css/base.css"/>
    <link rel="stylesheet" type="text/css" href="../../css/news/center.css"/>
    <link rel="stylesheet" type="text/css" href="../../lib/laydate.css"/>
    <link rel="stylesheet" type="text/css" href="../../css/dept/new_news.css"/>
    <script src="/lib/laydate/laydate.js"></script>
    <script src="/js/base/base.js" type="text/javascript" charset="utf-8"></script>
    <script type="text/javascript" src="/lib/layui/layui/lay/mymodules/xm-select.js"></script>
    <script src="../../lib/layer/layer.js?20201106"></script>
    <script src="../../js/base/base.js"></script>
    <script type="text/javascript" src="/lib/layui/layui/lay/mymodules/xm-select.js"></script>
    <script type="text/javascript" src="/lib/layui/layui/layui.all_v2.5.js"></script>
    <script type="text/javascript" src="/lib/layui/layui/global.js?20201229.1"></script>
    <script type="text/javascript" src="/lib/layui/layui/lay/mymodules/tableFilter.js"></script>
    <script type="text/javascript" src="/lib/layui/layui/lay/mymodules/tableChild.js"></script>
    <script type="text/javascript" src="/lib/layui/layui/lay/mymodules/tableMerge.js"></script>
    <script src="/lib/layui/layui/js/common.js?v=20190726" type="text/javascript" charset="utf-8"></script>
    <title><fmt:message code="global.page.first" /></title>
    <style>
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

        .head_rig h1 {
            width: 78px;
            height: 30px;
            font-size: 13px !important;
            background-image: url(../img/workflow/btn_new_nor_03.png), url(../img/workflow/icon_plus_03.png);
            cursor: pointer;
            background-repeat: no-repeat;
        }

        #cont_left::-webkit-scrollbar-corner {
            background: #82AFFF;
        }

        .head_rig {
            width: 480px;
            margin-top: 8px;
            float: right !important;;
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
            overflow-y: scroll;
        }

        .head {
            border-bottom: 1px solid #9E9E9E;
            height: 42px;
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

        user agent stylesheet
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
            width: 207px;
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

        /*	#layui-layer2{
                border-radius:10px;
            }*/
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
        .new_but{
            margin-left: 0px;
            color: #fff;
        }
        #new_{
            width: 109px;
            font-size: 11pt;
            color: #333;
        }
        .selected{
            background-color: white;
        }
    </style>
</head>
<body style="overflow:scroll;overflow-y: auto;overflow-x:hidden;">
<%--新建部门--%>
<div class="step1" style="display: block;margin-left: 0px;">
    <!-- 中间部分 -->
    <div class="nav_box clearfix">
        <div class="nav_t1" style="margin-left: 30px"><img src="/img/commonTheme/${sessionScope.InterfaceModel}/classifyCreateDept.png"></div>
        <div class="nav_t2" class="news" style="font-size: 20px;"><fmt:message code="depatement.th.NewDepartment" /></div>
        <div class="head_rig" id="head_rig" style="width:190px;">
            <%--<h1 style='cursor:pointer;' class="new_dept" onclick="newDept()" ><fmt:message code="depatement.th.NewDepartment" /></h1>--%>
            <%--<h1 style='cursor:pointer;' class="import" onclick="develop()"><fmt:message code="workflow.th.Import" /></h1>--%>
            <%--<h1 style='cursor:pointer;' class="export" onclick="develop()"><fmt:message code="global.lang.report" /></h1>--%>
        </div>
    </div>
    <table class="newNews" style="margin-left: 2.5%">


        <tbody>
        <tr>
            <td class="td_w blue_text">
                <fmt:message code="depatement.th.sortnumber" />：
            </td>
            <td>
                <input class="td_title1" type="text" placeholder="" id="deptNo"/><span style="margin-left:7px;color: red;font-size: 14px;">*</span>
                <%--<img class="td_title2" src="../img/mg2.png" alt="">--%>
                <div class="tit" style="margin-right: 70px"> <fmt:message code="depatement.th.digit" /></div>

            </td>
        </tr>
        <tr>
            <td class="td_w blue_text">
                <fmt:message code="depatement.th.Departmentname" />：
            </td>
            <td>
                <input class="td_title1" id="deptName" type="text" placeholder="" readonly/><span style="margin-left:7px;color: red;font-size: 14px;">*</span>
                <%--<img class="td_title2" src="../img/mg2.png" alt="">--%>

            </td>
        </tr>
        <tr>
            <td class="td_w blue_text">
                部门简称：
            </td>
            <td>
                <input class="td_title1" id="deptAbbrName2" type="text" placeholder=""/>
            </td>
        </tr>
        <tr>
            <td class="td_w blue_text">
                部门分类：
            </td>
            <td>
                <select name="deptType" id="deptType2"></select>
            </td>
        </tr>
        <tr>
            <td class="td_w blue_text">
                <fmt:message code="depatement.th.Superiordepartment" />：
            </td>
            <td>
                <input class="td_title1" type="text" style="width: 200px;background-color: #e7e7e7;"  id="deptParent" readonly/>

<%--                <a class="release3 addDept"><fmt:message code="global.lang.add" /></a>--%>
<%--                <a class="release3 clearDept" onclick="clearDept($(this))"><fmt:message code="global.lang.empty" /></a>--%>
                <%--<select name="DEPT_PARENT" class="BigSelect" id="deptParent">--%>
                <%--</select>--%>
                <%--<span style="margin-left: 7px;color: red;font-size: 14px;">*</span>--%>
                <%--<img class="td_title2" src="../img/mg2.png" alt="">--%>

            </td>
        </tr>
        <tr>
            <td class="blue_text"><fmt:message code="depatement.th.headpar" />：</td>
            <td>
                <input class="td_title1  release1" id="query_toId" type="text"/>
                <%-- <img class="td_title2 release2" id="ip2" src="../img/mg2.png" alt=""/>--%>
                <div class="release3" id="adduserAssistant"><fmt:message code="global.lang.add" /></div>
                <div class="release4 empty" onclick="empty('query_toId')"><fmt:message code="global.lang.empty" /></div>

            </td>
        </tr>
        <tr>
            <td class="blue_text"><fmt:message code="depatement.th.assistantdep" />：</td>
            <td>
                <input class="td_title1  release1" id="query_Satrap" type="text"/>
                <%-- <img class="td_title2 release2" id="ip2" src="../img/mg2.png" alt=""/>--%>
                <div class="release3" id="adduserSatrap"><fmt:message code="global.lang.add" /></div>
                <div class="release4 empty" onclick="empty('query_Satrap')"><fmt:message code="global.lang.empty" /></div>
            </td>
        </tr>
        <tr>
            <td class="blue_text"><fmt:message code="depatemtent.th.head" />：</td>
            <td>
                <input class="td_title1  release1" id="query_UpAssistant" dataid="" type="text"/>
                <%--  <img class="td_title2 release2" id="ip2" src="../img/mg2.png" alt=""/>--%>
                <div class="release3" id="UpAssistant"><fmt:message code="global.lang.add" /></div>
                <div class="release4 empty" onclick="empty('query_UpAssistant')"><fmt:message code="global.lang.empty" /></div>
            </td>
        </tr>
        <tr>
            <td class="blue_text"><fmt:message code="depatement.th.superiors" />：</td>
            <td>
                <input class="td_title1  release1" id="query_UpSatrap" dataid="" type="text"/>
                <%--  <img class="td_title2 release2" id="ip2" src="../img/mg2.png" alt=""/>--%>
                <div class="release3" id="UpSatrap"><fmt:message code="global.lang.add" /></div>
                <div class="release4 empty" onclick="empty('query_UpSatrap')"><fmt:message code="global.lang.empty" /></div>
            </td>
        </tr>
<%--        <tr>--%>
<%--            <td class="blue_text">可管理角色分类：</td>--%>
<%--            <td>--%>
<%--                <div id="parentGtypeIds" class=""></div>--%>
<%--            </td>--%>
<%--        </tr>--%>
        <tr>
            <td class="blue_text">
                 <fmt:message code="depatement.th.Telephone" />：
            </td>
            <td>
                <input class="td_title1 time_coumon" id="telNo" type="text" placeholder=""/>

            </td>
        </tr>
        <tr>
            <td class="blue_text">
                <fmt:message code="depatement.th.fax" />：
            </td>
            <td>
                <input class="td_title1 time_coumon" id="faxNo" type="text" placeholder=""/>

            </td>
        </tr>
        <tr>
            <td class="blue_text">
                <fmt:message code="depatement.th.address" />：
            </td>
            <td>
                <input class="td_title1 time_coumon" id="deptAddress" type="text" placeholder=""/>

            </td>
        </tr>
        <tr>
            <td class="blue_text">
                 <fmt:message code="depatement.th.responsibilities" />：
            </td>
            <td>
                <textarea name="" cols="60" rows="5" id="deptFunc"></textarea>

            </td>
        </tr>
        <tr>
            <td colspan="2" style="text-align: center;">
                <button type="button" class="new_but" id="new"><fmt:message code="global.lang.new" /></button>
            </td>
        </tr>

        </tbody>
    </table>
</div>

<%--编辑部门--%>
<div class="step2" style="display: none;margin-left: 0px;">
    <!-- 中间部分 -->
    <div class="nav_box clearfix">
        <div class="nav_t1"><img src="../../img/hierarchical/classifyEditDept.png" style="margin-left: 30px"></div>
        <%--<div class="nav_t2" class="news">编辑部门/成员单位-当前节点：[北京公司]</div>--%>
        <div class="nav_t2" class="news"><fmt:message code="depatement.th.edit" /></div>
        <div class="head_rig" id="head_rig_">
            <%--<h1 style='cursor:pointer;' class="new_dept" onclick="newDept()" ><fmt:message code="depatement.th.NewDepartment" /></h1>--%>
            <h1 style='cursor:pointer;margin-left: 95px;' class="new_dept" id="newdeptDowns">新建子部门</h1>
            <h1 style='cursor:pointer;' class="new_dept" id="delete_"><fmt:message code="main.th.DeleteCurrentDepartment" /></h1>
            <%--<h1 style='cursor:pointer;' class="import" onclick="develop()"><fmt:message code="workflow.th.Import" /></h1>--%>
            <%--<h1 style='cursor:pointer;' class="export" onclick="develop()"><fmt:message code="global.lang.report" /></h1>--%>
        </div>
    </div>
    <table class="newNews" style="margin-left: 2.5%">

        <tbody>
        <tr>
            <td class="td_w blue_text">
                <fmt:message code="depatement.th.sortnumber" />：
            </td>
            <td>
                <input class="td_title1" type="text" placeholder="" id="deptNo_"/><span style="margin-left:7px;color: red;font-size: 14px;">*</span>
                <img class="td_title2" src="/img/mg2.png" alt="">
                <div class="tit" style="margin-right: 70px">  <fmt:message code="depatement.th.digit" /></div>

            </td>
        </tr>
        <tr>
            <td class="td_w blue_text">
                <fmt:message code="depatement.th.Departmentname" />：
            </td>
            <td>
                <input class="td_title1" id="deptName_" type="text" placeholder=""/><span style="margin-left:7px;color: red;font-size: 14px;">*</span>
                <img class="td_title2" src="/img/mg2.png" alt="">

            </td>
        </tr>
        <tr>
            <td class="td_w blue_text">
                部门简称：
            </td>
            <td>
                <input class="td_title1" id="deptAbbrName" type="text" placeholder=""/>
            </td>
        </tr>
        <tr>
            <td class="td_w blue_text">
                部门分类：
            </td>
            <td>
                <select name="deptType" id="deptType"></select>
            </td>
        </tr>
        <tr>
            <td class="td_w blue_text">
                <fmt:message code="depatement.th.Superiordepartment" />：
            </td>
            <td>
                <input class="td_title1"  style="width: 200px;background-color: #e7e7e7;" type="text" id="deptParent_" readonly/>

                <a class="release3 addDept_">添加</a>
                <a class="release3 clearDept_" onclick="clearDept($(this))">清除</a>

                <%--<span style="color: red;font-size: 14px;">*</span>--%>
                <%--<img class="td_title2" src="../img/mg2.png" alt="">--%>

            </td>
        </tr>
        <tr>
            <td class="blue_text"><fmt:message code="depatement.th.headpar" />：</td>
            <td>
                <input class="td_title1  release1" id="query_toId_" dataid="" type="text"/>
                <%-- <img class="td_title2 release2" id="ip2" src="../img/mg2.png" alt=""/>--%>
                <div class="release3" id="adduserAssistant_"><fmt:message code="global.lang.add" /></div>
                <div class="release4 empty" onclick="empty('query_toId_')"><fmt:message code="global.lang.empty" /></div>

            </td>
        </tr>
        <tr>
            <td class="blue_text"><fmt:message code="depatement.th.assistantdep" />：</td>
            <td>
                <input class="td_title1  release1" id="query_Satrap_" dataid="" type="text" readonly/>
                <%-- <img class="td_title2 release2" id="ip2" src="../img/mg2.png" alt=""/>--%>
                <div class="release3" id="adduserSatrap_"><fmt:message code="global.lang.add" /></div>
                <div class="release4 empty" onclick="empty('query_Satrap_')"><fmt:message code="global.lang.empty" /></div>
            </td>
        </tr>
        <tr>
            <td class="blue_text"><fmt:message code="depatemtent.th.head" />：</td>
            <td>
                <input class="td_title1  release1" id="query_UpAssistant_" dataid="" type="text" readonly/>
                <%--  <img class="td_title2 release2" id="ip2" src="../img/mg2.png" alt=""/>--%>
                <div class="release3" id="UpAssistant_"><fmt:message code="global.lang.add" /></div>
                <div class="release4 empty" onclick="empty('query_UpAssistant_')"><fmt:message code="global.lang.empty" /></div>
            </td>
        </tr>
        <tr>
            <td class="blue_text"><fmt:message code="depatement.th.superiors" />：</td>
            <td>
                <input class="td_title1  release1" id="query_UpSatrap_" dataid="" type="text" readonly/>
                <%--  <img class="td_title2 release2" id="ip2" src="../img/mg2.png" alt=""/>--%>
                <div class="release3" id="UpSatrap_"><fmt:message code="global.lang.add" /></div>
                <div class="release4 empty" onclick="empty('query_UpSatrap_')"><fmt:message code="global.lang.empty" /></div>
            </td>
        </tr>
<%--        <tr>--%>
<%--            <td class="blue_text">可管理角色分类：</td>--%>
<%--            <td>--%>
<%--                <div id="parentGtypeId" class=""></div>--%>
<%--            </td>--%>
<%--        </tr>--%>
        <tr>
            <td class="blue_text">
                 <fmt:message code="depatement.th.Telephone" />：
            </td>
            <td>
                <input class="td_title1 time_coumon" id="telNo_" type="text" placeholder=""/>

            </td>
        </tr>
        <tr>
            <td class="blue_text">
                 <fmt:message code="depatement.th.fax" />：
            </td>
            <td>
                <input class="td_title1 time_coumon" id="faxNo_" type="text" placeholder=""/>

            </td>
        </tr>
        <tr>
            <td class="blue_text">
                 <fmt:message code="depatement.th.address" />：
            </td>
            <td>
                <input class="td_title1 time_coumon" id="deptAddress_" type="text" placeholder=""/>

            </td>
        </tr>
        <tr>
            <td class="blue_text">
                <fmt:message code="depatement.th.responsibilities" />：
            </td>
            <td>
                <textarea name="" cols="60" rows="5" id="deptFunc_"></textarea>

            </td>
        </tr>
        <tr>
            <td colspan="2" style="text-align: center;">
                <button type="button" class="new_but" id="new_"><fmt:message code="depatement.th.savemodify" /></button>
               <span id="dapaId_" style="display: none"></span>
            </td>
        </tr>
        <%--<tr>--%>
            <%--<td colspan="2">--%>
                <%--<button type="button" class="delete_but" id="delete_"><fmt:message code="depatement.th.currentdel" /></button>--%>
            <%--</td>--%>
        <%--</tr>--%>



        </tbody>
    </table>
</div>




</body>

<script>
//     var parentGtypeIds = null;
//     var parentGtypeId = null;
//     layui.use(['treeTable', 'table', 'layer', 'form', 'element', 'laydate', 'upload','soulTable'], function () {
//         var table = layui.table,
//             form = layui.form,
//             layer = layui.layer,
//             laydate = layui.laydate,
//             upload = layui.upload,
//             treeTable = layui.treeTable,
//             element = layui.element;
//         soulTable = layui.soulTable;
//
//         var data = [];
//         $.ajax({
//             type: 'post',
//             url: '/userPrivType/queryUserPrivType',
//             dataType: 'json',
//             async:false,
//             success: function (json) {
//                 var arr = json.obj
//                 var arrStr;
//                 for(var i = 0;i<arr.length;i++){
//                     arrStr = {name:arr[i].privTypeName,value:arr[i].privTypeId };
//                     data.push(arrStr);
//
//                 }
//                 data.shift()
// console.log(data)
//             }
//         })
//         parentGtypeIds=xmSelect.render({
//             el: '#parentGtypeIds',
//             toolbar:{
//                 show: true,
//             },
//             filterable: true,
//             height: '500px',
//             data: data
//
//         });
//         parentGtypeId=xmSelect.render({
//             el: '#parentGtypeId',
//             toolbar:{
//                 show: true,
//             },
//             filterable: true,
//             height: '500px',
//             data: data
//
//         });
//     })
    var dept_id;
//    user_id='query_toId';//选人控件
    /* 人员控件清空 */
    function empty(id){
        $("#"+id).val("").attr({
            'username':'',
            'dataid':'',
            'user_id':'',
            'userprivname':''
        });

    };
    function clearDept(e){
        e.parent().find('input').val("").attr({
            'deptname':'',
            'deptid':'',
        });
    }
    $(function(){
        $(".addDept").on("click",function(){
            dept_id="deptParent";
            $.popWindow("/common/selectDept?0");
        });
        // 添加部门信息
        $(".addDept_").on("click",function(){
            dept_id="deptParent_";
            $.popWindow("/common/selectDept?0");
        });
        /* 选人控件 */
        $("#adduserAssistant").on("click",function(){
            user_id = "query_toId";
            $.popWindow("/common/selectUser");
        });
        $("#adduserSatrap").on("click",function(){
            user_id = "query_Satrap";
            $.popWindow("/common/selectUser");
        });
        $("#UpAssistant").on("click",function(){
            user_id = "query_UpAssistant";
            $.popWindow("/common/selectUser");
        });
        $("#UpSatrap").on("click",function(){
            user_id = "query_UpSatrap";
            $.popWindow("/common/selectUser");
        });
        $("#adduserAssistant_").on("click",function(){
            user_id = "query_toId_";
            $.popWindow("/common/selectUser");
        });
        $("#adduserSatrap_").on("click",function(){
            user_id = "query_Satrap_";
            $.popWindow("/common/selectUser");
        });
        $("#UpAssistant_").on("click",function(){
            user_id = "query_UpAssistant_";
            $.popWindow("/common/selectUser");
        });
        $("#UpSatrap_").on("click",function(){
            user_id = "query_UpSatrap_";
            $.popWindow("/common/selectUser");
        });


        // 新建部门的
        $("#new").on("click",function(){
//           alert($('#deptParent option:checked').attr('value'));
            if($('#deptParent').attr('deptid') == undefined){
                var deptParent = 0;
            }else{
                var deptParent = $('#deptParent').attr('deptid').split(',')[0];
            }
            // var projectIds = ''
            // // 获取
            // var projectArr = parentGtypeIds.getValue()
            // projectArr.forEach(function (item, index) {
            //     projectIds += item.value + ','
            // })
            var data = {
                "deptName": $("#deptName").val(),    // 部门名称
                "telNo": $("#telNo").val(),      //电话
                "faxNo":$("#faxNo").val(),  //传真
                "deptAddress": $("#deptAddress").val(),// 部门地址
                "deptNo":   $("#deptNo").val(),//  部门排序号
                "deptParent": deptParent ,//上级部门ID
                "isOrg": "", //是否是分支机构(0-否,1-是)
                "orgAdmin":"",//机构管理员
                "deptEmailAuditsIds":"", //保密邮件审核人
                "weixinDeptId":"",  // null
                "dingdingDeptId":"",//叮叮对应部门id
                "gDept":'',// 是否全局部门(0-否,1-是)
                "manager": $("#query_toId").attr("dataid"),//部门主管
                "assistantId": $("#query_Satrap").attr("dataid"),//部门助理
                "leader1": $("#query_UpAssistant").attr("dataid"),//上级主管领导
                "leader2": $("#query_UpSatrap").attr("dataid"),//上级分管领导
                "deptFunc":$("#deptFunc").val(),//部门职能
                "avatar": "",    // 头像
                " userName": "",      // 用户名字
                "uid":"",  // 用户uid
                "userPrivName": "",// 用户角色名字
                "type":  "" ,//   返回类型
                "deptAbbrName": $('#deptAbbrName2').val(), // 部门简介
                "deptType": $('#deptType2').val(), // 部门分类
                // "privTypes":projectIds
            };
            console.log(data.deptParent)
            if($('#deptNo').val()=='' || $('#deptNo').val().length>3){
                layer.msg('<fmt:message code="hr.th.dsn" />', { icon:6});
                return false;
            }else if($('#deptName').val()==''){
                layer.msg('<fmt:message code="hr.th.fnd" />', { icon:6});
                return false;
            } else {
                //判断排序号是否重复
                var deptParentStr=$("#deptParent").attr("deptid");
                if($("#deptParent").attr("deptid")==''){
                    deptParentStr=0;
                }
        
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
                        url: "/department/selDeptNoByDeptParent",
                        type: 'post',
                        dataType: "JSON",
                        data: {
                            deptParent: deptParentStr,
                            deptNo: $("#deptNo").val(),
                            editFlag: 0,
                            proDeptNo: ''
                        },
                        success: function (json) {
                            if (!json.flag) {
                                if (json.msg == 'repeat') {
                                    $.layerMsg({content: '<fmt:message code="adding.th.dept" />！', icon: 1}, function () {
                                    })
                                }
                            } else {
                                $.ajax({
                                    url: "/department/addDept",
                                    type: 'post',
                                    dataType: "JSON",
                                    data: data,
                                    success: function (data) {
                                
                                        if (data.flag) {
                                            $.layerMsg({content: '<fmt:message code="depatement.th.Newsuccessfully" />！', icon: 1}, function () {
                                                location.reload();
                                            });
                                        } else {
                                            if (data.msg == '<fmt:message code="doc.th.deptCun" />！') {
                                                $.layerMsg({content: '<fmt:message code="doc.th.deptCun" />！', icon: 1}, function () {
                                                    location.reload();
                                                })
                                            } else {
                                                $.layerMsg({content: '<fmt:message code="depatement.th.Newfailed" />！', icon: 1}, function () {
                                                    location.reload();
                                                })
                                            }
                                        }
                                
                                    },
                                    error: function (e) {
                                        console.log(e);
                                    }
                                });
                            }
                        }
                    })
                } else {
                    layer.msg('公司总部已存在!', {icon: 0, time: 1500});
                    return false;
                }
            }
        });

//         //新建下级部门
        $("#newdeptDowns").on("click",function(){
            $(".step1").show();
            $(".step2").hide();
            var deptNo_ = $("#deptNo_").val() + ',';
            var deptName_ = $("#deptName_").val() + ',';
            var newbumen=$("#dapaId_").text() + ',';
            $('#deptParent').val(deptName_);
            $('#deptParent').attr('deptid',newbumen);
            $('#deptParent').attr('deptno',deptNo_);
            $('#deptName').removeAttr('readonly')
//            console.log($("#deptParent").find('option[value="'+newbumen_+'"]'))
//            $("#deptParent").find('option[value="'+newbumen_+'"]').attr("selected",true);//上级部门ID

        })

        var deptNoShow='';
        //新建下级部门
        $("#newdeptDown").on("click",function(){
            var id = $(this).attr('dpid');
            $('#deptName').removeAttr('readonly');
            $.ajax({
                url:'/department/getDeptById',
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

                }
            })
            //限制排序号只能输入三位有效数字
            var text = document.getElementById("deptNo_");
            text.onkeyup = function(){
                this.value=this.value.replace(/\D/g,'');
                if(text.value.length>3){
                    text.value = deptNoShow;
                }
            }

//            console.log($("#deptParent").find('option[value="'+newbumen_+'"]'))
//            $("#deptParent").find('option[value="'+newbumen_+'"]').attr("selected",true);//上级部门ID

        })
        
        // 获取部门分类数据
        $.get('/code/getCode?parentNo=DEPT_TYPE', function(res){
            var str = '<option value="">请选择</option>';
            if (res.obj.length > 0){
                res.obj.forEach(function(item){
                    str += '<option value="'+item.codeNo+'">'+item.codeName+'</option>';
                });
            }
            $('[name="deptType"]').html(str);
        });


    })





</script>

</html>
