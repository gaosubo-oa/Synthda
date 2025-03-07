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
    <script type="text/javascript" src="/lib/layui/layui/layui.all.js"></script>
    <script type="text/javascript" src="/lib/layui/layui/global.js"></script>
    <script src="/lib/jQuery-File-Upload-master/jquery-ui.js" type="text/javascript" charset="utf-8"></script>
    <script src="/lib/jQuery-File-Upload-master/jquery.iframe-transport.js" type="text/javascript" charset="utf-8"></script>
    <script src="/lib/jQuery-File-Upload-master/jquery.fileupload.js" type="text/javascript" charset="utf-8"></script>
    <script src="../js/base/base.js" type="text/javascript" charset="utf-8"></script>
    <script src="../js/ajaxupload.js" type="text/javascript" charset="utf-8"></script>
    <script type="text/javascript" src="/js/common/fileupload.js"></script>
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
    </style>
</head>
<body style="overflow:scroll;overflow-y: auto;overflow-x:hidden;">
<%--新建部门--%>

<%--编辑部门--%>
<div class="step2" style="display: none;margin-left: 0px;">
    <!-- 中间部分 -->
    <div class="nav_box clearfix">
        <div class="nav_t1" style="margin-left: 30px"><img src="/img/commonTheme/${sessionScope.InterfaceModel}/new_dept.png"></div>
        <%--<div class="nav_t2" class="news">编辑部门/成员单位-当前节点：[北京公司]</div>--%>
        <div class="nav_t2" class="news" style="font-size: 20px;">部门详情</div>
        <div class="head_rig" id="head_rig_" style="margin-right: 10px;">
            <%--<h1 style='cursor:pointer;' class="new_dept" onclick="newDept()" ><fmt:message code="depatement.th.NewDepartment" /></h1>--%>
<%--            <h1 style='cursor:pointer;' class="new_dept" id="newdeptDowns"><fmt:message code="depatement.th.NewChiDepartment" /></h1>--%>
            <h1 style='cursor:pointer;' class="new_dept" id="delete_"><fmt:message code="main.th.DeleteCurrentDepartment" /></h1>
            <%--<h1 style='cursor:pointer;' class="import" onclick="develop()"><fmt:message code="workflow.th.Import" /></h1>--%>
            <%--<h1 style='cursor:pointer;' class="export" onclick="develop()"><fmt:message code="global.lang.report" /></h1>--%>
        </div>
    </div>
    <table class="newNews" style="width: 80%;">

        <tbody>
        <tr>
            <td class="td_w blue_text">
                <fmt:message code="depatement.th.sortnumber" />：
            </td>
            <td style="position:relative;">
                <input class="td_title1" type="text" placeholder="" id="deptNo_" readonly/>
                <img class="td_title2" src="../img/mg2.png" alt="">
                <div class="tit">  <fmt:message code="depatement.th.digit" /></div>

            </td>
        </tr>
        <tr>
            <td class="td_w blue_text">
                <fmt:message code="depatement.th.Departmentname" />：
            </td>
            <td>
                <input class="td_title1" id="deptName_" type="text" placeholder="" readonly/>
                <img class="td_title2" src="../img/mg2.png" alt="">

            </td>
        </tr>
        <tr>
            <td class="td_w blue_text">
                部门简称：
            </td>
            <td>
                <input class="td_title1" id="deptAbbrName2" type="text" placeholder="" readonly/>

            </td>
        </tr>
        <tr>
            <td class="td_w blue_text">
                部门编码：
            </td>
            <td>
                <%--<select name="DEPT_PARENT" class="BigSelect" id="deptParent_">

                </select>--%>
                <input class="td_title1"  style="width: 200px;" type="text" id="DeptNum"  readonly/>
            </td>
        </tr>
        <tr>
            <td class="td_w blue_text">
                部门分类：
            </td>
            <td>
                <select name="deptType" id="deptType2" disabled></select>
            </td>
        </tr>
        <tr>
            <td class="td_w blue_text">
                <fmt:message code="depatement.th.Superiordepartment" />：
            </td>
            <td>
                <%--<select name="DEPT_PARENT" class="BigSelect" id="deptParent_">

                </select>--%>
                <input class="td_title1"  style="width: 200px;background-color: #e7e7e7;" type="text" id="deptParent_" readonly/>

<%--                <a class="release3 addDept_"><fmt:message code="global.lang.add" /></a>--%>
<%--                <a class="release3 clearDept_"><fmt:message code="global.lang.empty" /></a>--%>
                <div class="Image_" display:none>
                    <img src="/img/common/branch.png" title="此部门为分支机构" alt="" id="left" class="imgleft" style="width: 25px;height: 25px;margin-top: 5px;margin-right: 4px;">
                </div>
            </td>
        </tr>
        <tr>
            <td class="td_w blue_text">
                部门是否失效：
            </td>
            <td>
                <label for="">
                    <input type="radio"  value="1" checked id="editDeptPlay" class="editDeptDisplay" name="deptDisplay" disabled>
                    <span>有效</span>
                </label>
                <label for="">
                    <input type="radio" value="0"  id="editDeptNoplay" class="editDeptDisplay" name="deptDisplay" disabled>
                    <span>失效</span>
                </label>
            </td>
        </tr>
        <tr>
            <td class="blue_text">部门负责人：</td>
            <td>
                <input class="td_title1  release1" id="query_toId_" dataid="" type="text" readonly/>
                <%-- <img class="td_title2 release2" id="ip2" src="../img/mg2.png" alt=""/>--%>
<%--                <div class="release3" id="adduserAssistant_"><fmt:message code="global.lang.add" /></div>--%>
<%--                <div class="release4 empty" onclick="empty('query_toId_')"><fmt:message code="global.lang.empty" /></div>--%>
                <div class="Image_" display:none>
                    <img src="/img/common/branch.png" title="此部门为分支机构" alt="" id="left" class="imgleft" style="width: 25px;height: 25px;margin-top: 5px;margin-right: 4px;">
                </div>
            </td>
        </tr>

        <tr class="deptexamine" style="display: none;">
            <td class="blue_text">部门审核人：</td>
            <td>
                <input class="td_title1  release1" id="deptApprover" dataid="" type="text" readonly/>
                <%-- <img class="td_title2 release2" id="ip2" src="../img/mg2.png" alt=""/>--%>
<%--                <div class="release3" id="addDeptApprover"><fmt:message code="global.lang.add" /></div>--%>
<%--                <div class="release4 empty" onclick="empty('deptApprover')"><fmt:message code="global.lang.empty" /></div>--%>
                <div class="Image_" display:none>
                    <img src="/img/common/branch.png" title="此部门为分支机构" alt="" id="left" class="imgleft" style="width: 25px;height: 25px;margin-top: 5px;margin-right: 4px;">
                </div>
            </td>
        </tr>

        <tr>
            <td class="blue_text"><fmt:message code="depatement.th.assistantdep" />：</td>
            <td>
                <input class="td_title1  release1" id="query_Satrap_" dataid="" type="text" readonly/>
                <%-- <img class="td_title2 release2" id="ip2" src="../img/mg2.png" alt=""/>--%>
<%--                <div class="release3" id="adduserSatrap_"><fmt:message code="global.lang.add" /></div>--%>
<%--                <div class="release4 empty" onclick="empty('query_Satrap_')"><fmt:message code="global.lang.empty" /></div>--%>
                <div class="Image_" display:none>
                    <img src="/img/common/branch.png" title="此部门为分支机构" alt="" id="left" class="imgleft" style="width: 25px;height: 25px;margin-top: 5px;margin-right: 4px;">
                </div>
            </td>
        </tr>
        <tr>
            <td class="blue_text"><fmt:message code="depatemtent.th.head" />：</td>
            <td>
                <input class="td_title1  release1" id="query_UpAssistant_" dataid="" type="text" readonly/>
                <%--  <img class="td_title2 release2" id="ip2" src="../img/mg2.png" alt=""/>--%>
<%--                <div class="release3" id="UpAssistant_"><fmt:message code="global.lang.add" /></div>--%>
<%--                <div class="release4 empty" onclick="empty('query_UpAssistant_')"><fmt:message code="global.lang.empty" /></div>--%>
                <div class="Image_" display:none>
                    <img src="/img/common/branch.png" title="此部门为分支机构" alt="" id="left" class="imgleft" style="width: 25px;height: 25px;margin-top: 5px;margin-right: 4px;">
                </div>
            </td>
        </tr>
        <tr>
            <td class="blue_text"><fmt:message code="depatement.th.superiors" />：</td>
            <td>
                <input class="td_title1  release1" id="query_UpSatrap_" dataid="" type="text" readonly/>
                <%--  <img class="td_title2 release2" id="ip2" src="../img/mg2.png" alt=""/>--%>
<%--                <div class="release3" id="UpSatrap_"><fmt:message code="global.lang.add" /></div>--%>
<%--                <div class="release4 empty" onclick="empty('query_UpSatrap_')"><fmt:message code="global.lang.empty" /></div>--%>
                <div class="Image_" display:none>
                    <img src="/img/common/branch.png" title="此部门为分支机构" alt="" id="left" class="imgleft" style="width: 25px;height: 25px;margin-top: 5px;margin-right: 4px;">
                </div>
            </td>
        </tr>
        <tr>
            <td class="blue_text">
                <fmt:message code="depatement.th.Telephone" />：
            </td>
            <td>
                <input class="td_title1 time_coumon" id="telNo_" type="text" placeholder="" readonly/>

            </td>
        </tr>
        <tr>
            <td class="blue_text">
                <fmt:message code="depatement.th.fax" />：
            </td>
            <td>
                <input class="td_title1 time_coumon" id="faxNo_" type="text" placeholder="" readonly/>

            </td>
        </tr>
        <tr>
            <td class="blue_text">
                <fmt:message code="depatement.th.address" />：
            </td>
            <td>
                <input class="td_title1 time_coumon" id="deptAddress_" type="text" placeholder="" readonly/>

            </td>
        </tr>
        <tr>
            <td class="blue_text">
                <fmt:message code="depatement.th.responsibilities" />：
            </td>
            <td>
                <textarea name="" cols="60" rows="5" id="deptFunc_" readonly></textarea>

            </td>
        </tr>
        <tr class="adShow" style="display: none">
            <td class="blue_text">
                域组织单位映射：
            </td>
            <td>
                <select id="editDeptMap" class="xm-select-demo " cols="60" rows="5" multiple style="height: 150px;width: 400px"></select>
            </td>
        </tr>
        <tr>
            <td colspan="2">
<%--                <button type="button" class="new_but" id="new_" style="padding-left: 0;margin-left: 45%"><fmt:message code="depatement.th.savemodify" /></button>--%>
                <span id="dapaId_" style="display: none"></span>
            </td>
        </tr>

        </tbody>
    </table>
</div>
</body>

<script type="text/javascript">
    // 判断是否为中电建环境
    $.get('/ShowDownLoadQrCode', function (res) {
        if (res.flag && res.object == 1) {
            $('#schoolNum').attr('readonly', 'readonly');
            $('#DeptNum').attr('readonly', 'readonly');
        }
    });
    function digui(datas,n,isroot){
        for(var j=0; j<datas.length; j++){
            strAd += '<option style="margin-left: '+n * 8 +'px" value="'+ datas[j].deptGuid +'" dn="'+ datas[j].dn +'">||--' +  datas[j].deptName + '</option>'
            if(datas[j].children != undefined && datas[j].children.length != 0){
                n++;
                digui(datas[j].children,n)
            }
        }
    }
    //域组织单位映射
    var strAd = '<option>无</option>'
    $.ajax({
        url: '/ad/queryDeptMapTree',
        type: 'GET',
        dataType: 'JSON',
        async: false,
        success: function (res) {
            if (res.flag) {
                var datas = res.datas;
                var index = 1;
                if(datas != undefined && datas.length!= 0){
                    $('.adShow').css('display','table-row')
                    for(var i=0; i<datas.length; i++){
                        strAd += '<option value="'+ datas[i].deptGuid +'" dn="'+ datas[i].dn +'">|-'+ datas[i].deptName + '</option>'
                        if(datas[i].children != undefined && datas[i].children.length != 0){
                            digui(datas[i].children,index)
                        }
                    }
                    $('#adDeptMap').append(strAd)
                    $('#editDeptMap').append(strAd)

                }else{
                    $('.adShow').css('display','none')
                }
            }else{
                $('.adShow').css('display','none')
            }
        }
    });

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
        var table_width = $('.step1').width()-85;


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
        // $("#adduserAssistant").on("click",function(){
        //     user_id = "query_toId";
        //     $.popWindow("../common/selectUser");
        // });
        // $("#addDeptApprover").on("click",function() {
        //     user_id = "deptApprover";
        //     $.popWindow("../common/selectUser");
        // })
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
        // $("#adduserAssistant_").on("click",function(){
        //     user_id = "query_toId_";
        //     $.popWindow("../common/selectUser");
        // });
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

        //限制排序号只能输入三位有效数字
        var text2 = document.getElementById("deptNo");
        }
        <%--    判断是否开始了三员管理--%>
        $.ajax({
            url:"/syspara/selectTheSysPara?paraName=IS_OPEN_SANYUAN",
            success:function(res) {
                var data = res.object[0];
                if(data.paraValue == 1) {
                    $(".deptexamine").hide();
                    //如果没有三员管理 部门主管和部门审核人变为多选
                    $("#addDeptApprover").on("click",function() {
                        user_id = "deptApprover";
                        $.popWindow("../common/selectUser");
                    })
                    /* 选人控件 */
                    $("#adduserAssistant").on("click",function(){
                        user_id = "query_toId";
                        $.popWindow("../common/selectUser");
                    });
                    $("#adduserAssistant_").on("click",function(){
                        user_id = "query_toId_";
                        $.popWindow("../common/selectUser");
                    });
                }else if(data.paraValue == 0){
                    $('.deptHead').after(' <tr class="deptexamine" style="display: none;">\n' +
                        '            <td class="blue_text">部门审批人：</td>\n' +
                        '            <td>\n' +
                        '                <input class="td_title1  release1" id="deptApprover" dataid="" type="text"/>\n' +
                        '                <%-- <img class="td_title2 release2" id="ip2" src="../img/mg2.png" alt=""/>--%>\n' +
                        '                <div class="release3" id="addDeptApprover"><fmt:message code="global.lang.add" /></div>\n' +
                        '                <div class="release4 empty" onclick="empty(\'deptApprover\')"><fmt:message code="global.lang.empty" /></div>\n' +
                        '            </td>\n' +
                        '        </tr>')
                    $(".deptexamine").show();
                    //如果开启了三员管理 部门主管和部门审核人变为单选
                    $("#addDeptApprover").on("click",function() {
                        user_id = "deptApprover";
                        $.popWindow("../common/selectUser?0");
                    })
                    $("#adduserAssistant_").on("click",function(){
                        user_id = "query_toId_";
                        $.popWindow("../common/selectUser?0");
                    });
                    $("#adduserAssistant").on("click",function(){
                        user_id = "query_toId";
                        $.popWindow("../common/selectUser?0");
                    });
                }
            }
        })
        // 新建部门的
        $("#new").on("click",function(){
            if(!$("#query_toId").attr("user_id")) {
                layer.msg("请选择部门负责人",{icon:2})
                return
            }
            if($(".step1 .deptexamine")) {
                if(! $("#deptApprover").attr("user_id")) {
                    layer.msg("请选择部门审批人",{icon:2})
                    return
                }
            }

//           alert($('#deptParent option:checked').attr('value'));
            var deptParentValue = $('#deptParent').attr('deptid')|| 0;
            if(deptParentValue != 0){
                var deptParentValue = deptParentValue.split(',')[0];
            }
//            if(deptParentValue!=undefined&&deptParentValue!="undefined"&&$('#deptParent').val()!=""){
//                deptParentValue = deptParentValue.replace(/,/g,'');
//            }
            var deptGuid = '';
            var deptDn = '';
            $("#adDeptMap option:selected").each(function () {
                deptGuid += $(this).val() + ','
                deptDn += $(this).attr('dn') + '*'
            })
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
                "deptApprover": $("#deptApprover").attr("user_id") || "",//部门审批人
                "assistantId": $("#query_Satrap").attr("user_id"),//部门助理
                "leader1": $("#query_UpAssistant").attr("user_id"),//上级主管领导
                "leader2": $("#query_UpSatrap").attr("user_id"),//上级分管领导
                "deptFunc":$("#deptFunc").val(),//部门职能
                "avatar": "",    // 头像
                " userName": "",      // 用户名字
                "uid":"",  // 用户uid
                "userPrivName": "",// 用户角色名字
                "type":  "" ,//   返回类型
                "deptAbbrName": $('#deptAbbrName').val(),
                "deptType": $('#deptType').val(),
                'deptDisplay': $('.addDeptPlay:checked').val(),
                'deptGuid':deptGuid,
                'deptDn':deptDn
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
                        beforeSend: function () {
                            layer.load()
                        },
                        success: function (json) {
                            if (!json.flag) {
                                if (json.msg == 'repeat') {
                                    layer.closeAll('loading');
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
                                                var s1=$(".select").children(".mores").attr("depid")
                                                var c1=[s1]
                                                for(i=0;i<100;i++){
                                                    var c=$('.childdept[deptid='+ s1 +']').parents().prevAll().eq(i).attr('depid')
                                                    c1.push(c)
                                                }
                                                var r=c1.filter(function(s){
                                                    return s&&s.trim();
                                                })
                                                var arr1=r.reverse();
                                                window.location.reload()
                                            });
                                        } else {
                                            if (data.msg == '<fmt:message code="doc.th.deptCun" />！') {
                                                layer.closeAll('loading');
                                                $.layerMsg({content: '<fmt:message code="doc.th.deptCun" />！', icon: 1}, function () {

                                                })
                                            } else {
                                                layer.closeAll('loading');
                                                $.layerMsg({content: '<fmt:message code="depatement.th.Newfailed" />！', icon: 1}, function () {

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
                    });
                } else {
                    layer.msg('公司总部已存在!', {icon: 0, time: 1500});
                    return false;
                }
            }
        });
        //新建下级部门
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
