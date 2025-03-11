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
    <link rel="stylesheet" type="text/css" href="../lib/laydate/skins/default/laydate.css"/>
    <link rel="stylesheet" type="text/css" href="../../css/dept/deptManagement.css"/>
    <link rel="stylesheet" type="text/css" href="../../lib/easyui/themes/easyui.css"/>
    <link rel="stylesheet" type="text/css" href="../../lib/easyui/themes/icon.css"/>
    <link rel="stylesheet" type="text/css" href="../../css/base.css"/>
    <link rel="stylesheet" type="text/css" href="../../css/news/center.css"/>
    <link rel="stylesheet" type="text/css" href="../../lib/laydate.css"/>
    <link rel="stylesheet" type="text/css" href="../../css/dept/new_news.css"/>
    <script type="text/javascript" src="../../js/xoajq/xoajq1.js"></script>
    <script src="../../lib/laydate/laydate.js"></script>
    <script src="../../js/base/base.js" type="text/javascript" charset="utf-8"></script>
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
            padding-bottom: 0;
            height: 45px;
        }
        .head h1{
            line-height: 45px;
            margin-left: 12px;
            color: #333;
        }
        .head_left img{
            margin-top: 12px;
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
        .tit{
            position: absolute;
            float: none;
            color: #999;
            margin-left: 5px;
        }
        .nav_box .nav_t2{
            color: #333;
        }
        table{
            margin-left: 30px;
        }
        .tab table tr:nth-child(odd) {
            background-color: #fff;
        }
    </style>
</head>
<body style="overflow:scroll;overflow-y: auto;overflow-x:hidden;">

<div class="tishi" style="height: 100%;text-align: center;border: none;">
    <div style="width:100%;padding-top:20%;"><img style="margin-top: 2%;text-align: center;" src="/img/noData.png" alt=""></div>
    <h2 style="margin: auto;text-align: center;font-size: 20px;font-weight: normal;">请选择学校</h2>
</div>

<%--编辑部门--%>
<div class="step2" style="display: none;margin-left: 0px;">
    <!-- 中间部分 -->
    <div class="nav_box clearfix">
        <div class="nav_t1" style="margin-left: 30px"><img src="/img/commonTheme/${sessionScope.InterfaceModel}/new_dept.png"></div>
        <div class="nav_t2" class="news" style="font-size: 20px;">编辑学校</div>
    </div>
    <table class="newNews">

        <tbody>
        <div class="DEPT_ID" style="display: none"></div>
        <tr>
            <td class="td_w blue_text">
                学校排序号：
            </td>
            <td style="position:relative;">
                <%--<input class="td_title1" type="text" placeholder="" id="deptNo_"/>--%>
                <input class="td_title1" type="text" placeholder="" name="DEPT_NO"/>
                <img class="td_title2" src="../img/mg2.png" alt="">
                <div class="tit">  3位数字，用于同一级次学校排序，不能重复</div>

            </td>
        </tr>
        <tr>
            <td class="td_w blue_text">
                学校全称：
            </td>
            <td>
                <%--<input class="td_title1" id="deptName_" type="text" placeholder=""/>--%>
                <input class="td_title1" name="ORGAN_FULLNAME" type="text" placeholder=""/>
                <img class="td_title2" src="../img/mg2.png" alt="">

            </td>
        </tr>
        <tr>
            <td class="td_w blue_text">
                学校简称：
            </td>
            <td>
                <%--<input class="td_title1" id="deptName_1" type="text" placeholder=""/>--%>
                <input class="td_title1" name="DEPT_NAME" type="text" placeholder=""/>
                <img class="td_title2" src="../img/mg2.png" alt="">

            </td>
        </tr>
        <tr>
            <td class="td_w blue_text">
                学校编码：
            </td>
            <td>
                <%--<input class="td_title1"  style="width: 200px;" type="text" id="DeptNum"  />--%>
                <input class="td_title1"  style="width: 200px;" type="text" name="ORGAN_NUM"  />
                <img class="td_title2" src="../img/mg2.png" alt="">
            </td>
        </tr>
        <tr>
            <td class="td_w blue_text">
                分校码：
            </td>
            <td>
                <%--<input class="td_title1"  style="width: 200px;" type="text" id="DeptNum"  />--%>
                <input class="td_title1"  style="width: 200px;" type="text" name="CHILD_SCHOOL_CODE"  />
            </td>
        </tr>
        <tr>
            <td class="td_w blue_text">
                统一信用代码：
            </td>
            <td>
                <input class="td_title1"  style="width: 200px;" type="text"  name="UNIFIED_CREDIT_CODE"/>
                <%--<img class="td_title2" src="../img/mg2.png" alt="">--%>
            </td>
        </tr>
        <tr>
            <td class="td_w blue_text">
                学校办别：
            </td>
            <td>
                <select name="STATE_PRIVATE_ID" class="BigSelect">
                    <option value="0">请选择</option>
                    <option value="1">公办</option>
                    <option value="2">民办</option>
                    <%--<option value="3">中外合作</option>--%>
                    <%--<option value="9">其他</option>--%>
                </select>
            </td>
        </tr>
        <tr>
            <td class="td_w blue_text">
                办学类型：
            </td>
            <td>
                <select name="SCHOOL_TYPE" class="BigSelect">
                    <option value="0">请选择</option>
                    <option value="1">机关</option>
                    <option value="2">直属单位</option>
                    <option value="3">托育机构</option>
                    <option value="4">幼儿园</option>
                    <option value="5">小学</option>
                    <option value="6">初级中学</option>
                    <option value="7">九年一贯制</option>
                    <option value="8">高级中学</option>
                    <option value="9">完全中学</option>
                    <option value="10">十二年一贯制</option>
                    <option value="11">听力障碍学校</option>
                    <option value="12">智力障碍学校</option>
                    <option value="13">工读学校</option>
                    <option value="14">孤残学校</option>
                    <option value="15">外籍学校</option>
                    <option value="16">中等职业学校</option>
                    <option value="17">职业高中学校</option>
                    <option value="18">开放大学</option>
                    <option value="19">农村成人文化技术培训学校(机构)</option>
                    <option value="20">职工技术培训学校(机构)</option>
                    <option value="21">民办非学历教育机构</option>
                    <option value="22">专科层次普通高等职业技术学校</option>
                </select>
            </td>
        </tr>
        <tr>
            <td class="td_w blue_text">
                管理类型：
            </td>
            <td>
                <select name="SCHOOL_MANAGE_TYPE" class="BigSelect">
                    <option value="0">请选择</option>
                    <option value="1">机关与直属单位</option>
                    <option value="2">托育机构</option>
                    <option value="3">公办幼儿园</option>
                    <option value="4">民办幼儿园</option>
                    <option value="5">民办三级幼儿园</option>
                    <option value="6">外籍幼儿园</option>
                    <option value="7">公办小学</option>
                    <option value="8">公办中学</option>
                    <option value="9">随迁学校</option>
                    <option value="10">民办中小学</option>
                    <option value="11">外籍中小学</option>
                    <option value="12">局管中高职</option>
                    <option value="13">行业中职校</option>
                    <option value="14">市属中职校</option>
                    <option value="15">成教中心社区学校老年大学</option>
                    <option value="16">全日制培训机构</option>
                </select>
            </td>
        </tr>
        <tr>
            <td class="td_w blue_text">
                街镇：
            </td>
            <td>
                <select name="DEPT_AVENUE" class="BigSelect">
                    <option value="0">请选择</option>
                    <option value="1">江川路街道</option>
                    <option value="2">新虹街道</option>
                    <option value="3">古美路街道</option>
                    <option value="4">浦锦街道</option>
                    <option value="5">莘庄镇</option>
                    <option value="6">七宝镇</option>
                    <option value="7">浦江镇</option>
                    <option value="8">梅陇镇</option>
                    <option value="9">虹桥镇</option>
                    <option value="10">马桥镇</option>
                    <option value="11">吴泾镇</option>
                    <option value="12">华漕镇</option>
                    <option value="13">颛桥镇</option>
                    <option value="14">莘庄工业区</option>
                    <option value="15">外区街镇</option>
                </select>
            </td>
        </tr>
        <tr>
            <td class="td_w blue_text">
                地址：
            </td>
            <td>
                <input class="td_title1"  style="width: 200px;" type="text"  name="DEPT_ADDRESS"/>
            </td>
        </tr>
        <tr>
            <td class="td_w blue_text">
                邮编：
            </td>
            <td>
                <input class="td_title1"  style="width: 200px;" type="text"  name="DEPT_CODE"/>
            </td>
        </tr>
        <tr>
            <td class="td_w blue_text">
                电话：
            </td>
            <td>
                <input class="td_title1"  style="width: 200px;" type="text"  name="TEL_NO"/>
            </td>
        </tr>
        <tr>
            <td class="td_w blue_text">
                传真：
            </td>
            <td>
                <input class="td_title1"  style="width: 200px;" type="text"  name="FAX_NO"/>
            </td>
        </tr>

        <tr style="display: none;">
            <td class="td_w blue_text">
                学生总数：
            </td>
            <td>
                <input class="td_title1"  style="width: 200px;" type="text"  name="STUDENT_NUM"/>
            </td>
        </tr>
        <tr style="display: none;">
            <td class="td_w blue_text">
                教职工总数：
            </td>
            <td>
                <input class="td_title1"  style="width: 200px;" type="text"  name="TEACHER_NUM"/>
            </td>
        </tr>
        <tr style="display: none;">
            <td class="td_w blue_text">
                学生失联人数：
            </td>
            <td>
                <input class="td_title1"  style="width: 200px;" type="text"  name="STUDENT_LOST_NUM"/>
            </td>
        </tr>
        <tr style="display: none;">
            <td class="td_w blue_text">
                教师失联人数：
            </td>
            <td>
                <input class="td_title1"  style="width: 200px;" type="text"  name="TEACHER_LOST_NUM"/>
            </td>
        </tr>

        <tr>
            <td colspan="2">
                <button type="button" class="new_but" id="new_" style="padding-left: 0;margin-left: 45%"><fmt:message code="depatement.th.savemodify" /></button>
                <span id="dapaId_" style="display: none"></span>
            </td>
        </tr>

        </tbody>
    </table>
</div>


<%-- 部门查询  --%>
<div class="step3" style="display: none;margin-left: 0px;">
    <!-- 中间部分 -->
    <div class="nav_box clearfix">
        <div class="nav_t1" style="margin-left: 30px"><img src="/img/commonTheme/${sessionScope.InterfaceModel}/new_dept.png"></div>
        <div class="nav_t2" class="news" style="font-size: 20px;">学校查询</div>
    </div>
    <table class="newNews">
        <tbody>

        <tr>
            <td class="td_w blue_text">
                学校名称：
            </td>
            <td>
                <input class="td_title1" name="ORGAN_FULLNAME" type="text" placeholder=""/>
            </td>
        </tr>

        <tr>
            <td class="td_w blue_text">
                学校编码：
            </td>
            <td>
                <input class="td_title1"  style="width: 200px;" type="text" name="ORGAN_NUM"  />
            </td>
        </tr>

        <tr>
            <td class="td_w blue_text">
                统一信用代码：
            </td>
            <td>
                <input class="td_title1"  style="width: 200px;" type="text"  name="UNIFIED_CREDIT_CODE"/>
            </td>
        </tr>

        <tr>
            <td colspan="2">
                <button type="button" class="new_but" id="getSut_" style="padding-left: 0;margin-left: 45%;     width: 122px; background: url(../../img/sys/newhold.png) no-repeat;">
                    学校查询
                </button>
            </td>
        </tr>

        </tbody>
    </table>
</div>

<%-- 查询表格  --%>
<div class="step4" style="display: none;margin-left: 0px;">
    <!-- 中间部分 -->
    <div class="nav_box clearfix">
        <div class="nav_t1" style="margin-left: 30px"><img src="/img/commonTheme/${sessionScope.InterfaceModel}/new_dept.png"></div>
        <div class="nav_t2" class="news" style="font-size: 20px;">学校查询</div>
    </div>
    <table cellspacing="0" cellpadding="0" style="border-collapse:collapse;font-size: 20px;width: 96%;">
        <thead>
            <tr class='tr_befor' style="    line-height: 30px;    height: 30px;">
                <th width="4%"> </th>
                <th width="8%">学校排序号</th>
                <th width="8%">学校全称</th>
                <th width="8%">学校简称</th>
                <th width="8%">学校编码</th>
                <th width="14%">分校码</th>
                <th width="8%">统一信用代码</th>
                <th width="18%">学校办别</th>
                <th width="8%">办学类型</th>
                <th width="16%">操作</th>
            </tr>
        </thead>
        <tbody>

        </tbody>
    </table>
</div>
</body>

<script type="text/javascript">
    /* 人员控件清空 */
    var user_id;
    var dept_id;
    function empty(id){
        $("#"+id).val("");
        $("#"+id).attr('username','');
        $("#"+id).attr('dataid','');
        $("#"+id).attr('user_id','');
        $("#"+id).attr('userprivname','');
    };
    $(function(){

        var table_width = $('.tishi').width()-85;
        $('.newNews').width(table_width);

        // 获取部门信息控件
        $(".addDept").on("click",function(){
            dept_id="deptParent";
            $.popWindow("../common/selectDept?0");
        });
        // 清空部门信息
        $('.clearDept').click(function () {
            $('#deptParent').attr("deptid","");
            $('#deptParent').attr("deptno","");
            $('#deptParent').attr("deptname","");
            $('#deptParent').val("");
        });
        // 添加部门信息
        $(".addDept_").on("click",function(){
            dept_id="deptParent_";
            $.popWindow("../common/selectDept?0");
        });
        // 清空部门信息
        $('.clearDept_').click(function () {
            $('#deptParent_').attr("deptid","");
            $('#deptParent_').attr("deptno","");
            $('#deptParent_').attr("deptname","");
            $('#deptParent_').val("");
        });


        /* 选人控件 */
        $("#adduserAssistant").on("click",function(){
            user_id = "query_toId";
            $.popWindow("../common/selectUser");
        });
        $("#adduserSatrap").on("click",function(){
            user_id = "query_Satrap";
            $.popWindow("../common/selectUser");
        });
        $("#UpAssistant").on("click",function(){
            user_id = "query_UpAssistant";
            $.popWindow("../common/selectUser");
        });
        $("#UpSatrap").on("click",function(){
            user_id = "query_UpSatrap";
            $.popWindow("../common/selectUser");
        });
        $("#adduserAssistant_").on("click",function(){
            user_id = "query_toId_";
            $.popWindow("../common/selectUser");
        });
        $("#adduserSatrap_").on("click",function(){
            user_id = "query_Satrap_";
            $.popWindow("../common/selectUser");
        });
        $("#UpAssistant_").on("click",function(){
            user_id = "query_UpAssistant_";
            $.popWindow("../common/selectUser");
        });
        $("#UpSatrap_").on("click",function(){
            user_id = "query_UpSatrap_";
            $.popWindow("../common/selectUser");
        });

        // 新建部门的
        $("#new").on("click",function(){
            var deptParentValue = $('#deptParent').attr('deptid')|| 0;
            if(deptParentValue != 0){
                var deptParentValue = deptParentValue.split(',')[0];
            }


            var data = {
                "deptCode":$('#schoolNum').val(),
                "deptName": $("#deptName").val().split(',')[0],    // 部门名称
                "telNo": $("#telNo").val(),      //电话
                "faxNo":$("#faxNo").val(),  //传真
                "deptAddress": $("#deptAddress").val(),// 部门地址
                "deptNo":   $("#deptNo").val().split(',')[0],//  部门排序号
                "deptParent":  deptParentValue,//上级部门ID
                "isOrg": "", //是否是分支机构(0-否,1-是)
                "orgAdmin":"",//机构管理员
                "deptEmailAuditsIds":"", //保密邮件审核人
                "weixinDeptId":"",  // null
                "dingdingDeptId":"",//叮叮对应部门id
                "gDept":'',// 是否全局部门(0-否,1-是)
                "manager": $("#query_toId").attr("user_id"),//部门主管
                "assistantId": $("#query_Satrap").attr("user_id"),//部门助理
                "leader1": $("#query_UpAssistant").attr("user_id"),//上级主管领导
                "leader2": $("#query_UpSatrap").attr("user_id"),//上级分管领导
                "deptFunc":$("#deptFunc").val(),//部门职能
                "avatar": "",    // 头像
                " userName": "",      // 用户名字
                "uid":"",  // 用户uid
                "userPrivName": "",// 用户角色名字
                "type":  "" ,//   返回类型
            };



            if($('#deptNo').val()=='' ){
                layer.msg('<fmt:message code="doc.th.fillDept" />！', { icon:6});
                return false;
            }else if($('#deptNo').val().length!=3){
                layer.msg('<fmt:message code="doc.th.fillNo" />', { icon:6});
                return false;
            }else if($('#deptName').val()==''){
                layer.msg('<fmt:message code="hr.th.fnd" />！', { icon:6});
                return false;
            }else{
                //判断排序号是否重复
                var deptParentStr=$("#deptParent").attr("deptid");
                if($("#deptParent").attr("deptid")==''){
                    deptParentStr=0;
                }
                $.ajax({
                    url: "/department/selDeptNoByDeptParent",
                    type: 'post',
                    dataType: "JSON",
                    data: {
                        deptParent:deptParentStr,
                        deptNo:$("#deptNo").val(),
                        editFlag:0,
                        proDeptNo:''
                    },
                    success: function (json) {
                        if(!json.flag){
                            if(json.msg == 'repeat'){
                                $.layerMsg({content:'<fmt:message code="adding.th.dept" />！',icon:1},function(){
                                })
                            }
                        }else{
                            $.ajax({
                                url:"/department/addDept",
                                type:'post',
                                dataType:"JSON",
                                data : data,
                                success:function(data){

                                    if(data.flag){
                                        $.layerMsg({content:'<fmt:message code="depatement.th.Newsuccessfully" />！',icon:1},function(){
                                            parent.loadSidebar1(parent.$('#deptOrg'), 0)
                                            location.reload();
                                        });
                                    }else{
                                        if(data.msg == '<fmt:message code="doc.th.deptCun" />！'){
                                            $.layerMsg({content:'<fmt:message code="doc.th.deptCun" />！',icon:1},function(){

                                            })
                                        }else{
                                            $.layerMsg({content:'<fmt:message code="depatement.th.Newfailed" />！',icon:1},function(){

                                            })
                                        }
                                    }

                                },
                                error:function(e){
                                    console.log(e);
                                }
                            });
                        }
                    }
                })
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
        })


        var deptNoShow='';
        //新建下级部门
        $("#newdeptDown").on("click",function(){
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
        })

    })

</script>

</html>
