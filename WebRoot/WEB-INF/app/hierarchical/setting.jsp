<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%--// $.popWindow("../../common/selectUser");--%>
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
    <link rel="stylesheet" type="text/css" href="../../css/dept/deptManagement.css"/>
    <link rel="stylesheet" type="text/css" href="../../lib/easyui/themes/easyui.css"/>
    <link rel="stylesheet" type="text/css" href="../../lib/easyui/themes/icon.css"/>
    <link rel="stylesheet" type="text/css" href="../../css/base.css"/>
    <link rel="stylesheet" type="text/css" href="../../css/dept/new_news.css"/>
    <link rel="stylesheet" type="text/css" href="../../css/news/center.css"/>
    <link rel="stylesheet" href="/css/dept/roleAuthorization.css?20210311.1">
    <script type="text/javascript" src="../../js/xoajq/xoajq3.js"></script>
    <script src="/js/jquery/jquery-migrate-3.4.0.js"></script>
    <script src="/js/jquery/jquery.cookie.js"></script>
    <script src="../../lib/laydate/laydate.js"></script>
    <script type="text/javascript" src="../../lib/easyui/jquery.easyui.min.js"></script>
    <script type="text/javascript" src="../../lib/easyui/tree.js"></script>
    <%--<script type="text/javascript" src="../../js/index.js"></script>--%>
    <script src="../../lib/layer/layer.js?20201106"></script>
    <script src="../../js/base/base.js"></script>
    <script type="text/javascript" src="/lib/layui/layui/lay/mymodules/xm-select.js"></script>
    <script type="text/javascript" src="/lib/layui/layui/layui.all_v2.5.js"></script>
    <script type="text/javascript" src="/lib/layui/layui/global.js?20201229.1"></script>
    <script type="text/javascript" src="/lib/layui/layui/lay/mymodules/tableFilter.js"></script>
    <script type="text/javascript" src="/lib/layui/layui/lay/mymodules/tableChild.js"></script>
    <script type="text/javascript" src="/lib/layui/layui/lay/mymodules/tableMerge.js"></script>
    <script src="/lib/layui/layui/js/common.js?v=20190726" type="text/javascript" charset="utf-8"></script>
    <title>分支机构设置</title>
</head>
<style>
    html,
    body,
    .wrap{
        width:100%;
        height:100%;
        /* overflow: hidden;*/
    }		.pick{			overflow-x: auto;		}		.pick::-webkit-scrollbar{            width: 5px;            height: 6px;            background-color: #f5f5f5;        }        /*定义滚动条的轨道，内阴影及圆角*/        #cont_left::-webkit-scrollbar-track{            -webkit-box-shadow: inset 0 0 6px rgba(0,0,0,.3);            border-radius: 10px;            background-color: #f5f5f5;        }        /*定义滑块，内阴影及圆角*/        ::-webkit-scrollbar-thumb{            /*width: 10px;*/            height: 20px;            border-radius: 10px;            -webkit-box-shadow: inset 0 0 6px rgba(0,0,0,.3);            background-color: #555;        }		::-webkit-scrollbar{            width: 5px;            height: 0px;            background-color: #f5f5f5;        }        
    .head_rig  .import {
        width: 56px;
        height: 30px;
        font-size: 13px !important;
        cursor: pointer;
        background-repeat: no-repeat;
        background-image: url(../../img/sys/import.png);
        padding-left: 25px;
    }
    .head_rig  .export {
        width: 56px;
        height: 30px;
        font-size: 13px !important;
        cursor: pointer;
        background-repeat: no-repeat;
        background-image: url(../../img/sys/export.png);
        padding-left: 25px;
    }
    .head_rig .new_dept {
        width: 160px;
        height: 30px;
        font-size: 13px !important;
        background-image:url(../../img/sys/dept_personnel.png);
        cursor: pointer;
        background-repeat: no-repeat;
        color: #fff;
        margin-top: 0px;
        float: right;
    }

    #cont_left::-webkit-scrollbar {
        width: 0px;
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

    .search h1 {
        text-align: center;
        color: #fff;
        font-size: 14px;
        line-height: 28px;
        background-image: url(../../img/workflow/btn_check_nor_03.png);
        background-repeat: no-repeat;
    }

    .cont {
        width: 102%;
        height: 95%;
        overflow-y: scroll;
    }
.pick li{width: 2000px;}
    .head {
        border-bottom: 1px solid #9E9E9E;
        height: 42px;
    }
    .head_rig h1 :hover {
        cursor: pointer;
    }

    .search h1 :hover {
        cursor: pointer;
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

    select {

        height: 32px;
        width: 220px;
        border-radius: 4px;
        border: 1px solid #cccccc;
        background-color: #ffffff;
    }

    .f_field_ctrl input {
        color: #000;
    }

    #delete_{
        padding-left: 2px;
    }

    .layui-layer-page .layui-layer-btn {
        padding-top: 10px;
        text-align: center;
    }
    .dpetWhole0{overflow: auto;margin-left:10px;}
    dpetWhole0 li{white-space: nowrap;}


    .classify{
        display: inline;
        float: left;
        margin-left: 10px;
    }

    .td_title1{
        height:32px;
    }

    .tdText{
        font-size: 15px;
        color: #2a588c;
        font-weight: bold;
    }
    .cont_left {
        border-right: 1px solid #c0c0c0!important;
    }
    .cont_left ul li{
        margin-top:-1px;
    }
    textarea{
        background: #f2f2f2;
        text-indent: 5px;
        border: 1px solid #d9d9d9;
    }
    .setGlobal tr td{
        border: none;
    }
    .mainRight{
        display: none;
    }
    .tit{
        position: absolute;
        color: #999;
        margin-left: 10px;
    }
    .dynatree-title{
        color: #666!important;
    }
    .colo {
        background: #e8f4fc;
        color: #313131;
        text-align: left;
        color: #313131;
    }
    tr.padstyle td{
        padding-top: 40px;
    }
    table.setGlobal td span{
        color: #313131;
        font-weight: bold;
    }
    .scroll-body .selected {
        background: none;
    }
    .head_left img {
        display: inline-block;
        float: left;
        width: 35px;
        margin-top: 8px;
        margin-left: 30px;
    }
</style>
<link rel="stylesheet" type="text/css" href="/css/commonTheme/${sessionScope.InterfaceModel}/commonTheme.css"/>

<style type="text/css">
    .head_rig .new_dept, .nav_box .head_rig .new_dept{
        background-color: #fff !important
    }
</style>

<body style="overflow:scroll;overflow-y: hidden;overflow-x:hidden;">

<div class="wrap" style="margin-left:0px !important;">
    <div class="head">
        <div class="head_left">
            <img src="/img/common/branch.png" alt="">
            <h1>分支机构设置</h1>
        </div>
    </div>

    <div class="cont">
        <div class="cont_left" id="cont_left">
            <ul>
                <li class="liDown dept_li" id="dept_lis"><img src="/img/commonTheme/${sessionScope.InterfaceModel}/icon_sectorList.png" style="vertical-align: middle;width: 15px;margin-right: 10px;" alt="分支机构列表">分支机构列表</li>
                <li id="nextLi" style="display: block;">
                    <ul class="pick">

                    </ul>

                </li>
                <li class="globalSetting dept_li"><img src="/img/commonTheme/${sessionScope.InterfaceModel}/bigClassifyGlobal.png" style="vertical-align: middle;width: 15px;margin-right: 10px;" alt="全局查看权限设置"><fmt:message code="user.th.kd" /></li>

            </ul>
        </div>

        <%--编辑分级机构--%>
        <div class="cont_rig classify classifyRight2" style="display: none;margin-left: 0px;">
            <div class="nav_box1 clearfix1" style="margin-left:0px;margin-top: 20px; ">
                <div class="nav_t11" style="display:inline;margin-left: 30px"><img src="/img/hierarchical/editClassify.png" style="margin-bottom: 5px"></div>
                <div class="nav_t22" style="display:inline;font-size: 20px;font-family: 微软雅黑;margin-left: 8px" class="news">编辑分支机构</div>
                <div class="head_rig" id="head_rig" style="width:400px;">
                    <h1 style="cursor:pointer; width: 160px; display: inline-block" class="new_dept delClassify" id="delete_">删除分支机构</h1>
                    <h1 style='cursor:pointer;display: inline-block' class="new_dept" onclick="newDept()" >新建分支机构</h1>

                </div>
            </div>
            <!-- 中间部分 -->
            <table class="newNews" style="width: 79%;">
                <tbody>
                <tr>
                    <td class="td_w blue_text">
                        <fmt:message code="depatement.th.sortnumber" />：
                    </td>
                    <td style="position:relative;">
                        <input class="td_title1 editTest_null" type="text" placeholder="" id="deptNo_"/>
                        <img class="td_title2" src="../../img/mg2.png" alt="">
                        <div class="tit" style="float: none;">  <fmt:message code="depatement.th.digit" /></div>
                    </td>
                </tr>
                <tr>
                    <td class="td_w blue_text">
                        <fmt:message code="depatement.th.Departmentname" />：
                    </td>
                    <td>
                        <input class="td_title1 editTest_null" id="deptName_" type="text" placeholder=""/>
                        <img class="td_title2" src="../../img/mg2.png" alt="">

                    </td>
                </tr>
                <tr>
                    <td class="td_w blue_text">
                        <fmt:message code="depatement.th.Superiordepartment" />：
                    </td>
                    <td>
                        <input class="td_title1"  style="width: 200px;background-color: #e7e7e7;" readonly type="text" id="deptParent_" />

                        <a class="release3 addDept_"><fmt:message code="global.lang.add" /></a>
                        <a class="release3 clearDept_"><fmt:message code="global.lang.empty" /></a>
                        <%-- <select name="DEPT_PARENT" class="BigSelect editTest_null" id="deptParent_" style="width: 200px;height: 32px;">

                         </select>
                         <img class="td_title2" src="../../img/mg2.png" alt="">--%>

                    </td>
                </tr>
                <tr>
                    <td class="blue_text"><fmt:message code="depatement.th.headpar" />：</td>
                    <td>
                        <input class="td_title1  release1" id="query_toId_" dataid="" type="text"/>
                        <div class="release3" id="adduserAssistant_"><fmt:message code="global.lang.add" /></div>
                        <div class="release4 empty" onclick="empty('query_toId_')"><fmt:message code="global.lang.empty" /></div>

                    </td>
                </tr>
                <tr>
                    <td class="blue_text"><fmt:message code="depatement.th.assistantdep" />：</td>
                    <td>
                        <input class="td_title1  release1" id="query_Satrap_" dataid="" type="text"/>
                        <div class="release3" id="adduserSatrap_"><fmt:message code="global.lang.add" /></div>
                        <div class="release4 empty" onclick="empty('query_Satrap_')"><fmt:message code="global.lang.empty" /></div>
                    </td>
                </tr>
                <tr>
                    <td class="blue_text"><fmt:message code="depatemtent.th.head" />：</td>
                    <td>
                        <input class="td_title1  release1" id="query_UpAssistant_" dataid="" type="text"/>
                        <div class="release3" id="UpAssistant_"><fmt:message code="global.lang.add" /></div>
                        <div class="release4 empty" onclick="empty('query_UpAssistant_')"><fmt:message code="global.lang.empty" /></div>
                    </td>
                </tr>
                <tr>
                    <td class="blue_text"><fmt:message code="depatement.th.superiors" />：</td>
                    <td>
                        <input class="td_title1  release1" id="query_UpSatrap_" dataid="" type="text"/>
                        <div class="release3" id="UpSatrap_"><fmt:message code="global.lang.add" /></div>
                        <div class="release4 empty" onclick="empty('query_UpSatrap_')"><fmt:message code="global.lang.empty" /></div>
                    </td>
                </tr>

<%--                <tr>--%>
<%--                    <td class="blue_text">可管理角色分类：</td>--%>
<%--                    <td>--%>
<%--                        <div id="parentGtypeIds" class=""></div>--%>
<%--                    </td>--%>
<%--                </tr>--%>

                <tr>
                    <td class="blue_text">分支机构管理员：</td>
                    <td>
                        <input class="td_title1  release1" id="query_orgAdmin_" dataid="" type="text"/>
                        <div class="release3" id="orgAdmin_"><fmt:message code="global.lang.add" /></div>
                        <div class="release4 empty" onclick="empty('query_orgAdmin_')"><fmt:message code="global.lang.empty" /></div>
                    </td>
                </tr>
                <tr>
                    <td class="blue_text">是否包含下级分支机构：</td>
                    <td>
                        <div>
                            <select id="isSubOrg">
                                <option value="1">是</option>
                                <option value="0">否</option>
                            </select>
                        </div>
                    </td>
                </tr>

                <tr>
                    <td class="blue_text">可管理角色分类：</td>
                    <td>
                        <div id="parentGtypeId" class=""></div>
                    </td>
                </tr>
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
                    <td colspan="2">
                        <button type="button" class="new_but" id="new_" style="margin-left: 41%;"><fmt:message code="depatement.th.savemodify" /></button>
                        <span id="dapaId_" style="display: none"></span>
                    </td>
                </tr>
                </tbody>
            </table>
        </div>
        <%--新建分级机构--%>
        <div class="cont_rig1">
            <form action="" method="post" name="form1">
                <table class="tr_td1" style="width: 50%;margin-left: 33%;margin-top: 15px;">
                    <div class="nav_box1 clearfix1" style="margin-left:10px;margin-top: 20px; ">
                        <div class="nav_t11" style="display:inline;margin-left: 30px;"><img src="/img/hierarchical/createClassify.png" style="margin-bottom: 5px"></div>
                        <div class="nav_t22" style="display:inline;font-size: 20px;font-family: 微软雅黑;margin-left: 8px" class="news">新建分支机构</div>
                        <%--<div class="head_rig" id="head_rig" style="width:190px;">--%>
                            <%--<h1 style='cursor:pointer;' class="new_dept" onclick="newDept()" ><fmt:message code="user.th.xj" /></h1>--%>
                        <%--</div>--%>
                    </div>
                    <tbody>
                    <tr>
                        <td nowrap="" class="TableData tdText">分支机构：</td>
                        <td class="TableData">
                            <textarea cols="45" name="classifyOrgDept" rows="3" id="classifyOrgDept" class="classifyOrgDept test_null" wrap="yes" readonly="" style="background: #f2f2f2;"></textarea><span style="margin-left: 10px;color: red;font-size: 14px;">*</span>
                            <a href="javascript:;" class="orgDeptAdd" ><fmt:message code="global.lang.add" /></a>
                            <a href="javascript:;" class="orgDeptClear" onclick="clearDept('classifyOrgDept')" ><fmt:message code="global.lang.empty" /></a>
                        </td>
                    </tr>
                    <tr>
                        <td nowrap="" class="TableData tdText"><fmt:message code="user.th.df" />：</td>
                        <td class="TableData">
                            <textarea cols="45" name="classifyOrgAdmin" rows="3" id="classifyOrgAdmin" class="classifyOrgAdmin test_null" wrap="yes" readonly="" style="background: #f2f2f2;"></textarea><span style="margin-left: 10px;color: red;font-size: 14px;">*</span>
                            <a href="javascript:;" class="orgAdminAdd" onclick="selPerson('classifyOrgAdmin')"><fmt:message code="global.lang.add" /></a>
                            <a href="javascript:;" class="orgAdminClear" onclick="clearPerson('classifyOrgAdmin')"><fmt:message code="global.lang.empty" /></a>
                        </td>
                    </tr>
                    <tr>
                        <td nowrap="" class="TableControl" colspan="2" align="center">
                            <input type="button" value="<fmt:message code="global.lang.save" />" class="import settingSave">&nbsp;&nbsp;
                        </td>
                    </tr>
                    </tbody>
                </table>
            </form>
        </div>

        <%--全局设置--%>
        <div class="setAddressBook" style="display: none;" >
            <div class="nav_box1 clearfix1" style="margin-left:10px;height:40px;line-height:40px; ">
                <div class="nav_t11" style="display:inline;margin-left: 15px;"><img src="/img/hierarchical/bigClassifyGlobal.png" style="margin-bottom: 5px"></div>
                <div class="nav_t22" style="display:inline;font-size: 22px;color: #313131;font-family: 微软雅黑;margin-left: 8px;line-height: 40px;" class="news"><fmt:message code="user.th.kd" /></div>
            </div>
            <table class="tr_td1 setGlobal"  style="width: 80%;margin-left: 18%;background: white;border-collapse: initial;font-size: 14px">
                <tr class="colo">
                    <td nowrap="" class="TableData" colspan="2"><span  style="margin-left: 1%;">允许以下人员查看所有分支机构人员，并进行选人操作</span><input type="hidden" value="0132" name="bookModelId" id="bookModelId" class="modelId" ></td>
                </tr>
                <tr class="padstyle">
                    <td nowrap="" class="TableData tdText" style="width: 32%"><span class="spanText" style="float: right"><fmt:message code="diary.th.body" />：</span></td>
                    <td class="TableData">
                        <textarea cols="45"  name="bookPerson" rows="3" id="bookPerson" class="bookPerson globalPerson" wrap="yes" readonly=""></textarea>
                        <a href="javascript:;" class="addBookPerson" onclick="selPerson('bookPerson')"><fmt:message code="global.lang.add" /></a>
                        <a href="javascript:;" class="clearBookPerson" onclick="clearPerson('bookPerson')"><fmt:message code="global.lang.empty" /></a>
                    </td>
                </tr>
                <tr>
                    <td nowrap="" class="TableData tdText"><span class="spanText" style="float: right" ><fmt:message code="userManagement.th.department" />：</span></td>
                    <td class="TableData">
                        <textarea cols="45"  name="bookDept" rows="3" id="bookDept" class="bookDept globalDept" wrap="yes" readonly="" ></textarea>
                        <a href="javascript:;" class="addBookDept" onclick="selDept('bookDept')"><fmt:message code="global.lang.add" /></a>
                        <a href="javascript:;" class="clearBookDept" onclick="clearDept('bookDept')"><fmt:message code="global.lang.empty" /></a>
                    </td>
                </tr>
                <tr>
                    <td nowrap="" class="TableData tdText"><span class="spanText" style="float: right" ><fmt:message code="userManagement.th.role" />：</span></td>
                    <td class="TableData">
                        <textarea cols="45"  name="bookPriv" rows="3" id="bookPriv" class="bookPriv globalPriv" wrap="yes" readonly="" ></textarea>
                        <a href="javascript:;" class="addBookPriv" onclick="selPriv('bookPriv')"><fmt:message code="global.lang.add" /></a>
                        <a href="javascript:;" class="clearBookPriv" onclick="clearPriv('bookPriv')"><fmt:message code="global.lang.empty" /></a>
                    </td>
                </tr>
                <tr>
                    <td colspan="2"> <input type="button" value="<fmt:message code="global.lang.save" />" class="import setAddressBookBtn" style="margin-left: 42%">&nbsp;&nbsp;</td>
                </tr>
            </table>
        </div>

        <div class="mainRight" style="float: left;width: 80%;">
            <iframe style="width: 100%;height:100%" src="" frameborder="0"></iframe>
        </div>
    </div>
</div>
</body>


</html>
<script>
    var paraValues = "";
    // var parentGtypeIds = null;
    var parentGtypeId = null;
    layui.use(['treeTable', 'table', 'layer', 'form', 'element', 'laydate', 'upload','soulTable'], function () {
        var table = layui.table,
            form = layui.form,
            layer = layui.layer,
            laydate = layui.laydate,
            upload = layui.upload,
            treeTable = layui.treeTable,
            element = layui.element;
        soulTable = layui.soulTable;

        var data = [];
        $.ajax({
            type: 'post',
            url: '/userPrivType/queryUserPrivType',
            dataType: 'json',
            async:false,
            success: function (json) {
                var arr = json.obj
                var arrStr;
                for(var i = 0;i<arr.length;i++){
                    arrStr = {name:arr[i].privTypeName,value:arr[i].privTypeId };
                    data.push(arrStr);

                }
                data.shift()
                // console.log(data)
            }
        })
        // parentGtypeIds=xmSelect.render({
        //     el: '#parentGtypeIds',
        //     toolbar:{
        //         show: true,
        //     },
        //     filterable: true,
        //     height: '500px',
        //     data: data
        //
        // });
        parentGtypeId=xmSelect.render({
            el: '#parentGtypeId',
            toolbar:{
                show: true,
            },
            filterable: true,
            height: '500px',
            data: data

        });
    })

    var data = []

    var widthnum=1;
    //选人员控件
    function selPerson(id) {
        user_id=id;
        $.popWindow("../../common/selectUser");
    }

    function clearPerson(id) {
        $("#"+id).val("").attr({
            'username':'',
            'dataid':'',
            'user_id':'',
            'userprivname':''
        });
    }

    //选部门控件
    $(".orgDeptAdd").on("click",function(){//添加部门
        dept_id='classifyOrgDept';
        $.popWindow("../../common/selectDept");
    });
    function selDept(id) {
        dept_id=id;
        $.popWindow("../../common/selectDept");
    }
    function clearDept(id) {
        $('#'+id).attr('dept_id','');
        $('#'+id).attr('deptid','');
        $('#'+id).val('');

    }

    //选角色控件
    function selPriv(id) {
        priv_id=id;
        $.popWindow("../../common/selectPriv");
    }
    function clearPriv(id) {
        $('#'+id).attr('userpriv','');
        $('#'+id).attr('privid','');
        $('#'+id).val('');
    }


    //设置分级机构保存按钮
    $(".settingSave").on("click",function(){
        /*var array=$(".test_null");
         var attendId='';
         var attendName='';
         for(var i=0;i<array.length;i++){
         if(array[i].value==""){
         $.layerMsg({content:"<fmt:message code="sup.th.With*" />",icon:2},function(){
         });
         return;
         }
         }*/
        if($('#classifyOrgDept').val()=='' || $('#classifyOrgDept').val().length<3){
            layer.msg('<fmt:message code="hr.th.fd" />', { icon:6});
            return false;
        }else if($('#classifyOrgAdmin').val()==''){
            layer.msg('<fmt:message code="hr.th.fa" />', { icon:6});
            return false;
        }
        $.ajax({
            url: '/hierarchical/setClassifyOrgByDeptId',
            dataType: 'json',
            data: {
                deptIds:  $('#classifyOrgDept').attr('deptid'),
                classifyOrgAdmin: $('#classifyOrgAdmin').attr('dataid'),
                classifyOrg:1
            },
            success: function(res) {
                if(res.flag){
                    layer.msg('<fmt:message code="diary.th.modify" />！', { icon:6});
                    location.reload();
                }
            }
        })
    })

    //删除分级机构按钮
    $(".delClassify").on("click",function(){
        $.layerConfirm({title:'<fmt:message code="workflow.th.suredel" />',content:'<fmt:message code="adding.th.dh" />？',icon:0},function() {
            $.ajax({
                url: '/hierarchical/setClassifyOrgByDeptId',
                dataType: 'json',
                data: {
                    deptIds: $("#dapaId_").html(),
                    classifyOrgAdmin: "",
                    classifyOrg: 0
                },
                success: function (res) {
                    if (res.flag) {
                        layer.msg('<fmt:message code="workflow.th.delsucess" />！', {icon: 6});
                        location.reload();
                    }
                }
            })
        })
    })

    //编辑分级机构
    /*$("#deptParent_").deptSelect(); //编辑中上级部门中部门控件*/
    // 添加上级部门
    $(".addDept_").on("click",function(){
        dept_id="deptParent_";
        $.popWindow("/common/selectDept?0");
    });
    //    清除上级部门
    $('.clearDept_').on('click',function(){
        $('#deptParent_').val('');
        $('#deptParent_').removeAttr('deptid');
    })

    //部门主管（选人控件）
    $("#adduserAssistant_").on("click",function(){
        user_id = "query_toId_";
        $.popWindow("../../common/selectUser");
    });
    //部门助理（选人控件）
    $("#adduserSatrap_").on("click",function(){
        user_id = "query_Satrap_";
        $.popWindow("../../common/selectUser");
    });
    //上级主管领导（选人控件）
    $("#UpAssistant_").on("click",function(){
        user_id = "query_UpAssistant_";
        $.popWindow("../../common/selectUser");
    });
    //上级分管领导（选人控件）
    $("#UpSatrap_").on("click",function(){
        user_id = "query_UpSatrap_";
        $.popWindow("../../common/selectUser");
    });
    //分级机构管理员（选人控件）
    $("#orgAdmin_ ").on("click",function(){
        user_id = "query_orgAdmin_";
        $.popWindow("../../common/selectUser");
    });
    //清空按钮(部门主管\部门助理\上级主管领导\上级分管领导)
    function empty(id){
        $("#"+id).val("").attr({
            'username':'',
            'dataid':'',
            'user_id':'',
            'userprivname':''
        });

    };

    //编辑部门 详情
    var deptNoShow='';
    function ajaxdata(id,me){
        $(".cont_rig").show();
        $(".cont_rig1").hide();
        $(".setAddressBook").hide();
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
                var manager= data.object.manager.split("&");
                var manager0=manager[0];
                if(manager0=="null"){
                    manager0=""
                };
                var assistantId= data.object.assistantId.split("&");
                var assistantId0=assistantId[0];
                if(assistantId0=="null"){
                    assistantId0=""
                };
                var leader1= data.object.leader1.split("&");
                var leader10=leader1[0];
                if(leader10=="null"){
                    leader10=""
                };
                var leader2= data.object.leader2.split("&");
                var leader20=leader2[0];
                if(leader20=="null"){
                    leader20=""
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

                //分级机构管理员
                $("#query_orgAdmin_").attr("user_id",data.object.classifyOrgAdminUserId);
                $("#query_orgAdmin_").val(data.object.classifyOrgAdminName);

                $("#telNo_").val(data.object.telNo); // 电话
                $("#faxNo_").val(data.object.faxNo); // 传真
                $("#deptAddress_").val(data.object.deptAddress); // 地址
                $("#deptFunc_").val(data.object.deptFunc); // 部门职责
                $("#dapaId_").html(data.object.deptId);
                $("#isSubOrg").val(data.object.isSubOrg);
                var viewUserTypeArr = (data.object.privTypes || '').split(',');
                parentGtypeId.setValue(viewUserTypeArr);
                // $("#parentGtypeId").val(data.object.privTypeNames);
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
    }
    //新建部门/成员单位按钮
    function newDept(){
        $(".cont_rig1").show();
        $(".cont_rig").hide();
        $(".setAddressBook").hide();
        $('#classifyOrgDept').attr('deptid','')
        $('#classifyOrgDept').attr('deptname','')
        $('#classifyOrgDept').attr('deptno','')
        $('#classifyOrgDept').val('')

        $('#classifyOrgAdmin').attr('deptid','')
        $('#classifyOrgAdmin').attr('deptname','')
        $('#classifyOrgAdmin').attr('deptno','')
        $('#classifyOrgAdmin').val('')
    };
    $(function () {
        /*左侧点击事件显示隐藏*/
        boolTwo=false;
        $("#dept_lis").on('click', function () {
            if ($(this).siblings('#nextLi').css('display') == 'none') {
                $(this).siblings('#nextLi').show();
                $(this).addClass("liDown").removeClass("liUp");
            } else {
                $(this).siblings('#nextLi').hide();
                $(this).addClass("liUp").removeClass("liDown");
            }
            $(".cont_rig").hide();
            $(".cont_rig1").show();
            $(".setAddressBook").hide();
        });
        // 编辑保存***********************
        $("#new_").on("click",function(){
            if($('#deptNo_').val()=='' || $('#deptNo_').val().length<3){
                layer.msg('<fmt:message code="hr.th.dsn" />', { icon:6});
                return false;
            }else if($('#deptName_').val()==''){
                layer.msg('<fmt:message code="hr.th.fnd" />', { icon:6});
                return false;
            }
            if($('#deptParent_').attr('deptid') == undefined){
                var deptParent = 0;
            }else{
                var deptParent = $('#deptParent_').attr('deptid').split(',')[0];
            }
            // console.log(deptParent)

            var projectIds = ''
            // 获取
            var projectArr = parentGtypeId.getValue()
            projectArr.forEach(function (item, index) {
                projectIds += item.value + ','
            })

            var data = {
                'deptId':$("#dapaId_").html(),
                "deptNo":$("#deptNo_").val(),//  部门排序号
                "deptName": $("#deptName_").val(),    // 部门名称
                "telNo": $("#telNo_").val(),      //电话
                "faxNo":$("#faxNo_").val(),  //传真
                "deptAddress": $("#deptAddress_").val(),// 部门地址
                "deptParent":  deptParent,//上级部门ID
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
                "classifyOrgAdmin": $("#query_orgAdmin_").attr("dataid"),//分级机构管理员
                "deptFunc":$("#deptFunc_").val(),//部门职能
                "avatar": "",    // 头像
                "userName": "",      // 用户名字
                "uid":"",  // 用户uid
                "userPrivName": "",// 用户角色名字
                "type":  "", //   返回类型
                "isSubOrg":$("#isSubOrg").val(),
                "privTypes":projectIds

            };
            //判断排序号是否重复
            var deptParentStr=$("#deptParent_").attr("deptid");
            if($("#deptParent_").attr("deptid")==''){
                deptParentStr=0;
            }
            if(deptNoShow.length>3){
                deptNoShow=deptNoShow.substring(deptNoShow.length-3,deptNoShow.length); // 部门排序号
            }
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
                        $.layerMsg({content:'<fmt:message code="depatement.th.Modifysuccessfully" />！',icon:1},function(){
                            $.ajax({
                                url:"/../department/editDept",
                                type:'post',
                                dataType:"JSON",
                                data : data,
                                success:function(res){
                                    if (res.flag) {
                                        location.reload();
                                    }
                                },
                                error:function(e){
                                    console.log(e);
                                }
                            });
                        });
                    }
                }
            })
        });
        //判断是否开启分支机构
        $.ajax({
            url:"/syspara/queryOrgScope",
            dataType: 'json',
            success:function(res) {
                paraValues = res.object.paraValue;
            }
        })
        $.extend({
            loadSidebar: function (target, deptId, fn) {
                $.ajax({
                    url: '/department/getChDeptfq',
                    type: 'get',
                    data: {
                        deptId: deptId
                    },
                    dataType: 'json',
                    success: function (data) {
                        if (deptId == 300) {
                            var str = '';
                            data.obj.forEach(function (v, i) {
                                if(paraValues == '1'&&v.classifyOrg == '1' ){
                                    if (v.deptName && v.isHaveCh == 1) {
                                        str += '<li><span  onclick= "imgDown(' + v.deptId + ',this)" data-numString="2" data-numtrue="' + (parseInt($(target).prev().attr('data-numtrue')) + 1) + '" style="padding-left:41px;height:35px;line-height:35px;"  deptid="' + v.deptId + '" class="childdept"><span></span><img id="img' + v.deptId + '" src="/img/sys/dapt_right.png" style="width: 8px;height:14px;margin-top: -3px;margin-right:4px;" alt="">&nbsp;<a href="javascript:void(0)" class="dynatree-title" title="' + v.deptName + '">' + v.deptName + '</a></span><ul style="display:none;"></ul></li>';
                                    } else {
                                        str += '<li><span onclick="imgDown(' + v.deptId + ',this)" data-numString="1" data-numtrue="' + (parseInt($(target).prev().attr('data-numtrue')) + 1) + '"  style="padding-left:41px;height:35px;line-height:35px;"  deptid="' + v.deptId + '" class="childdept"><span></span><img  src="/img/sys/dapt_right.png" style="width: 8px;height:14px;margin-top: -3px;margin-right:4px;" alt="">&nbsp;<a href="javascript:void(0)" class="dynatree-title" title="' + v.deptName + '">' + v.deptName + '</a></span><ul  style="display:none;"></ul></li>';
                                    }
                                }
                            });
                            target.html(str);
                            widthnum++;
                            if (fn != undefined) {
                                fn()
                            }
                        } else if (deptId == 0) {
                            var str = '';
                            data.obj.forEach(function (v, i) {
                                if(paraValues == '1'&&v.classifyOrg == '1' ){
                                    if (v.deptName) {
                                        str += '<li><span data-types="1" data-numstring="1"  data-numtrue="1" ' +
                                            'onclick= "imgDown(' + v.deptId + ',this)"  style="height:35px;line-height:35px;padding-left: 14px" deptid="' + v.deptId + '" class="childdept">' +
                                            '<span class=""></span>' +
                                            '<img src="/img/sys/dapt_down.png" alt="" style="    width: 8px;height: 14px;margin-top: -3px;margin-right: 4px;">' +
                                            '<a href="javascript:void(0)" class="dynatree-title" title="' + v.deptName + '">' + v.deptName + '</a>' +
                                            '</span><ul style="display:none;" class="dpetWhole0"></ul>' +
                                            '</li>';
                                    }
                                }

                            })
                            widthnum++;
                            target.html(str);
                            if (fn != undefined) {
                                fn($(target))
                            }


                        } else {
                            var str = '';

                            data.obj.forEach(function (v, i) {
                                var targetnum = parseInt($(target).prev().attr('data-numtrue'))
                                if(paraValues == '1'&&v.classifyOrg == '1' ){
                                    if (v.deptName && v.isHaveCh == 1) {
                                        str += '<li><span  onclick= "imgDown(' + v.deptId + ',this)" data-numString="2" deptid="' + v.deptId + '" data-numtrue="' + (targetnum + 1) + '"  style="padding-left:' + (20 + (20 * parseInt($(target).prev().attr('data-numtrue')))) + 'px;height:35px;line-height:35px;"  deptid="' + v.deptId + '" class="childdept"><span></span><img id="img' + v.deptId + '" src="/img/sys/dapt_right.png" style="width: 8px;height:14px;margin-top: -3px;margin-right:4px;" alt="">&nbsp;<a href="javascript:void(0)" class="dynatree-title" title="' + v.deptName + '">' + v.deptName + '</a></span><ul style="display:none;"></ul></li>';
                                    } else {
                                        str += '<li><span onclick="imgDown(' + v.deptId + ',this)" data-numString="1" deptid="' + v.deptId + '" data-numtrue="' + (targetnum + 1) + '" style="padding-left:' + (20 + (20 * parseInt($(target).prev().attr('data-numtrue')))) + 'px;height:35px;line-height:35px;"  deptid="' + v.deptId + '" class="childdept"><span></span><img  src="/img/sys/dapt_right.png" style="width: 8px;height:14px;margin-top: -3px;margin-right:4px;" alt="">&nbsp;<a href="javascript:void(0)" class="dynatree-title" title="' + v.deptName + '">' + v.deptName + '</a></span><ul style="display:none;"></ul></li>';
                                    }
                                }

                            });
                            widthnum++
                            target.html(str);
                            if (fn != undefined) {
                                fn()
                            }
                        }
                    }
                })
            }

        })
//        $.loadSidebar($('.pick'),0,function (el) {
//            $(el).css('padding-left','8%')
//        })


    });
    $.ajax({
        url:'/hierarchical/getAllClassifyOrg',
        type:'post',
        datatype:'json',
        success:function(res){
            var mydata= res.obj;
            buildDeptTree(mydata);
            function buildDeptTree(data){
                var treeStr = buildChild(data);
                $('.pick').html(treeStr)
            }

        }
    })


    function buildChild(data){
        var str = '';
        data.forEach(function(v,i){
            if(v.child && v.child.length>0){
                str+= '<li><span data-numtrue="1" onclick="imgDown1('+v.deptId+',this)" data-numstring="1" style="height:35px;line-height:35px;padding-left: 14px" deptid="'+v.deptId+'" class="childdept"><span class=""></span><img src="/img/sys/dapt_right.png" id="imgleft" alt="" class="imgleft" style="width: 8px;height: 14px;margin-top: -3px;margin-right: 4px;"><a href="javascript:void(0)" class="dynatree-title" title="'+v.deptName+'">'+v.deptName+'</a>'+ function () {
                    if (paraValues == '1'&&v.classifyOrg == '1') {
                        return '<img src="/img/common/branch.png" title="此部门为分支机构" alt="" class="imgleft" style="width: 25px;height: 25px;margin-top: -3px;margin-right: 4px;">'
                    } else {
                        return ''
                    }
                }() +'</span><ul style="display:none;" class="dpetWhole0">'+buildChild(v.child)+'</ul></li>';
            }else{
                str+= '<li><span data-numtrue="1" onclick="imgDown1('+v.deptId+',this)" data-numstring="1" style="height:35px;line-height:35px;padding-left: 14px" deptid="'+v.deptId+'" class="childdept"><span class=""></span><img src="/img/sys/dapt_right.png" id="imgleft" alt="" class="imgleft" style="width: 8px;height: 14px;margin-top: -3px;margin-right: 4px;"><a href="javascript:void(0)" class="dynatree-title" title="'+v.deptName+'">'+v.deptName+'</a>'+ function () {
                    if (paraValues == '1'&& v.classifyOrg == '1') {
                        return '<img src="/img/common/branch.png" title="此部门为分支机构" alt="" class="imgleft" style="width: 25px;height: 25px;margin-top: -3px;margin-right: 4px;">'
                    } else {
                        return ''
                    }
                }() +'</span><ul style="display:none;" class="dpetWhole0"></ul></li>';
            }
        });
        return str;

    }


    $(".globalSetting").on("click",function () {
        $.ajax({
            url: '/hierarchicalGlobal/selGlobalPerson',
            type: 'get',
            dataType: 'json',
            success: function (json) {
                if(json.flag){
                    var data=json.attributes.model1;//通讯簿
                    $("#bookPerson").val(data.globalPersonName);
                    $("#bookPerson").attr("user_id",data.globalPerson);
                    $("#bookDept").val(data.globalDeptName);
                    $("#bookDept").attr("deptid",data.globalDept);
                    $("#bookPriv").val(data.globalPrivName);
                    $("#bookPriv").attr("userpriv",data.globalPriv);
                }
            }
        })
        $(".cont_rig").hide();
        $(".cont_rig1").hide();
        $(".setAddressBook").show();
    })

    $(".setAddressBookBtn").on("click",function () {
        var arr=[];
        $(".setAddressBook table").each(function (i,v) {
            var obj=new Object();
            obj.modelId=$(this).find(".modelId").val();
            obj.globalPerson=$(this).find(".globalPerson").attr("user_id");
            obj.globalDept=$(this).find(".globalDept").attr("deptid");
            obj.globalPriv=$(this).find(".globalPriv").attr("userpriv");
            arr.push(obj);
        })
        $.ajax({
            url: '/hierarchicalGlobal/setHierarchicalGlobalPerson',
            type: 'get',
            dataType: 'json',
            data: {
                globalJson:JSON.stringify(arr)
            },
            success: function (data) {
                if(data.flag){
                    $.layerMsg({content:"<fmt:message code="diary.th.modify" />！",icon:6},function(){
                    });
                }
            }
        })
    })
    function imgDown1(id,me){
        // console.log($(me));
        $(me).next().show();
        $(me).attr('data-types', '2')
        $(me).find('#imgleft').attr('src', $(me).find('#imgleft').attr('src') == '/img/sys/dapt_right.png' ? '/img/sys/dapt_down.png' : '/img/sys/dapt_right.png');
        if ($(me).find('#imgleft').attr('src') == '/img/sys/dapt_right.png') {
            $(me).find('#imgleft').css({"margin-top": "-3px", "margin-right": "4px", "margin-left": ""});
            $(me).find('#imgleft').width(8);
            $(me).find('#imgleft').height(14);
            $(me).next().hide();
            // $(me).next().html('')
        } else if ($(me).find('#imgleft').attr('src') == '/img/sys/dapt_down.png') {
            $(me).find('#imgleft').css({"margin-top": "-3px", "margin-right": "4px", "margin-left": "-5px"});
            $(me).find('#imgleft').width(14);
            $(me).find('#imgleft').height(9);
            $(me).next().show();
        }
        this.ajaxdata(id,me);
    }
</script>

