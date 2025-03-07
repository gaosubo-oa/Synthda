<%--
  Created by IntelliJ IDEA.
  User: Lenovo
  Date: 2023/4/28
  Time: 15:01
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>部门信息</title>
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
    <script src="../js/base/base.js" type="text/javascript" charset="utf-8"></script>

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
<body>
<%--编辑部门--%>
<div class="step2" style="padding: 20px 0;">
    <!-- 中间部分 -->
    <table class="newNews" style="margin: 0 auto;">

        <tbody>
        <tr>
            <td style="border: none;">
                <span class="titleTxt"  style="font-size: 26px;" >部门信息</span>
                <span class="subText" style="font-family: Microsoft yahei; font-weight: bolder; font-size: 12pt; color:red; display: none;">机密级★</span>
            </td>
        </tr>
        <tr>
            <td class="td_w blue_text">
                部门排序号：
            </td>
            <td style="position:relative;">
                <input class="td_title1" type="text" placeholder="" id="deptNo_"/>
                <div class="tit">  <fmt:message code="depatement.th.digit" /></div>

            </td>
        </tr>
        <tr>
            <td class="td_w blue_text">
                部门名称：
            </td>
            <td>
                <input class="td_title1" id="deptName_" type="text" placeholder=""/>

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
                部门编码：
            </td>
            <td>
                <%--<select name="DEPT_PARENT" class="BigSelect" id="deptParent_">

                </select>--%>
                <input class="td_title1"  style="width: 200px;" type="text" id="DeptNum"  />
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
                上级部门：
            </td>
            <td>
                <%--<select name="DEPT_PARENT" class="BigSelect" id="deptParent_">

                </select>--%>
                <input class="td_title1"  style="width: 200px;background-color: #e7e7e7;" type="text" id="deptParent_" readonly />

                <a class="release3 addDept_"><fmt:message code="global.lang.add" /></a>
                <a class="release3 clearDept_"><fmt:message code="global.lang.empty" /></a>
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
                    <input type="radio"  value="1" checked id="editDeptPlay" class="editDeptDisplay" name="deptDisplay">
                    <span>有效</span>
                </label>
                <label for="">
                    <input type="radio" value="0"  id="editDeptNoplay" class="editDeptDisplay" name="deptDisplay">
                    <span>失效</span>
                </label>
            </td>
        </tr>
        <tr>
            <td class="blue_text">部门负责人：</td>
            <td>
                <input class="td_title1  release1" id="query_toId_" dataid="" type="text"/>
                <%-- <img class="td_title2 release2" id="ip2" src="../img/mg2.png" alt=""/>--%>
                <div class="release3" id="adduserAssistant_"><fmt:message code="global.lang.add" /></div>
                <div class="release4 empty" onclick="empty('query_toId_')"><fmt:message code="global.lang.empty" /></div>
                <div class="Image_" display:none>
                    <img src="/img/common/branch.png" title="此部门为分支机构" alt="" id="left" class="imgleft" style="width: 25px;height: 25px;margin-top: 5px;margin-right: 4px;">
                </div>
            </td>
        </tr>

        <tr class="deptexamine">
            <td class="blue_text">部门审核人：</td>
            <td>
                <input class="td_title1  release1" id="deptApprover" dataid="" type="text"/>
                <%-- <img class="td_title2 release2" id="ip2" src="../img/mg2.png" alt=""/>--%>
                <div class="release3" id="addDeptApprover"><fmt:message code="global.lang.add" /></div>
                <div class="release4 empty" onclick="empty('deptApprover')"><fmt:message code="global.lang.empty" /></div>
                <div class="Image_" display:none>
                    <img src="/img/common/branch.png" title="此部门为分支机构" alt="" id="left" class="imgleft" style="width: 25px;height: 25px;margin-top: 5px;margin-right: 4px;">
                </div>
            </td>
        </tr>

        <tr>
            <td class="blue_text">部门助理(选填)：</td>
            <td>
                <input class="td_title1  release1" id="query_Satrap_" dataid="" type="text"/>
                <%-- <img class="td_title2 release2" id="ip2" src="../img/mg2.png" alt=""/>--%>
                <div class="release3" id="adduserSatrap_"><fmt:message code="global.lang.add" /></div>
                <div class="release4 empty" onclick="empty('query_Satrap_')"><fmt:message code="global.lang.empty" /></div>
                <div class="Image_" display:none>
                    <img src="/img/common/branch.png" title="此部门为分支机构" alt="" id="left" class="imgleft" style="width: 25px;height: 25px;margin-top: 5px;margin-right: 4px;">
                </div>
            </td>
        </tr>
        <tr>
            <td class="blue_text">上级主管领导(选填)：</td>
            <td>
                <input class="td_title1  release1" id="query_UpAssistant_" dataid="" type="text"/>
                <%--  <img class="td_title2 release2" id="ip2" src="../img/mg2.png" alt=""/>--%>
                <div class="release3" id="UpAssistant_"><fmt:message code="global.lang.add" /></div>
                <div class="release4 empty" onclick="empty('query_UpAssistant_')"><fmt:message code="global.lang.empty" /></div>
                <div class="Image_" display:none>
                    <img src="/img/common/branch.png" title="此部门为分支机构" alt="" id="left" class="imgleft" style="width: 25px;height: 25px;margin-top: 5px;margin-right: 4px;">
                </div>
            </td>
        </tr>
        <tr>
            <td class="blue_text">上级分管领导(选填)：</td>
            <td>
                <input class="td_title1  release1" id="query_UpSatrap_" dataid="" type="text"/>
                <%--  <img class="td_title2 release2" id="ip2" src="../img/mg2.png" alt=""/>--%>
                <div class="release3" id="UpSatrap_"><fmt:message code="global.lang.add" /></div>
                <div class="release4 empty" onclick="empty('query_UpSatrap_')"><fmt:message code="global.lang.empty" /></div>
                <div class="Image_" display:none>
                    <img src="/img/common/branch.png" title="此部门为分支机构" alt="" id="left" class="imgleft" style="width: 25px;height: 25px;margin-top: 5px;margin-right: 4px;">
                </div>
            </td>
        </tr>
        <tr>
            <td class="blue_text">
                电话：
            </td>
            <td>
                <input class="td_title1 time_coumon" id="telNo_" type="text" placeholder=""/>

            </td>
        </tr>
        <tr>
            <td class="blue_text">
                传真：
            </td>
            <td>
                <input class="td_title1 time_coumon" id="faxNo_" type="text" placeholder=""/>

            </td>
        </tr>
        <tr>
            <td class="blue_text">
                地址：
            </td>
            <td>
                <input class="td_title1 time_coumon" id="deptAddress_" type="text" placeholder=""/>

            </td>
        </tr>
        <tr>
            <td class="blue_text">
                部门职责：
            </td>
            <td>
                <textarea name="" cols="60" rows="5" id="deptFunc_"></textarea>

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
                <button type="button" class="new_but" id="new_" style="padding-left: 0;margin-left: 45%">关闭</button>
                <span id="dapaId_" style="display: none"></span>
            </td>
        </tr>

        </tbody>
    </table>
</div>
<script>
    //判断页面是否需要显示机密级字样
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

    $("#new_").on("click",function() {
        window.close();
    })
    var deptId = location.search.split("=")[1];
    $('input').prop("readonly",true);
    $('textarea').prop("readonly",true);
    $('select').prop("disabled",true);
    $('[type=radio]').prop("disabled",true);
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
    $.ajax({
        url:"/department/getDeptById",
        data: {
            deptId:deptId
        },
        success:function(data) {
            if(data.flag) {
                console.log(data,'res')
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
            }else {
                layer.msg("获取数据失败",{icon:2});
            }
        }
    })
</script>
</body>
</html>
