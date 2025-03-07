
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
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <title><fmt:message code="email.th.emailReviewSetting" /></title>
    <meta name="renderer" content="webkit">
    <meta http-equiv="X-UA-Compatible" content="IE=10,chrome=1">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=0, minimum-scale=1.0, maximum-scale=1.0">
    <link rel="stylesheet" type="text/css" href="../css/email/manageMail.css"/>
    <script src="/js/common/language.js"></script>
<%--    <script src="../js/xoajq/xoajq1.js" type="text/javascript" charset="utf-8"></script>--%>
    <script type="text/javascript" charset="utf-8" src="/js/xoajq/xoajq3.js"></script>
    <script type="text/javascript" charset="utf-8" src="/js/jquery/jquery-migrate-3.4.0.js"></script>
    <script src="../lib/layer/layer.js?20201106" type="text/javascript" charset="utf-8"></script>
    <script src="../js/jquery/jquery.cookie.js"></script>
    <script src="../js/base/base.js" type="text/javascript" charset="utf-8"></script>
    <script src="../js/email/emailSet.js?20230509.1" type="text/javascript" charset="utf-8"></script>
    <style type="text/css">
       .title{
           box-sizing: border-box;
            margin-left: 0px;
            margin-top: 20px;
           padding-left: 20px;
        }
       table tr th,.TABLE_A table tr th{
           font-size: 13pt;
       }
       .TABLE tr td,.TABLE_A table tr td{
           font-size: 11pt;
       }
        input[type="radio"]{
            width: 16px !important;
            height: 16px !important;
            vertical-align: middle;
            margin-right: 5px;
            margin-left: 20px;
        }
        #TABLE_A tr th,#TABLE_A tr td{
            text-align: center;
            border-right: #ccc 1px solid;
        }
       input[type="checkbox"],input[type="radio"]{
           background: transparent;
           border: 0;
       }
       table tr td:first-of-type{
           width: 17%;
       }
       .DIV_Txt{
           width: 102px;
       }
    </style>
</head>
<body>
<div class="content">
    <div class="DIV_LIST" id="DIV_LIST" style="display: block;">
        <div class="title">
            <div class="div_im">
                <img src="../img/icon_addEmail_03.png">
            </div>
            <div class="div_title" ><fmt:message code="email.th.addEmailRule" /></div>
        </div>
        <div class="TABLE" style="width: 100%;">
            <form action="" method="get">
                <table cellspacing="0" cellpadding="0" width="60%" height="60%" style="border-collapse:collapse;background-color: #fff;margin: 0 auto;">
                    <tr>
                        <th colspan="2" style="height:40px; text-align: center;background-color: #3691DA;color: #fff;font-weight: normal;padding: 6px;"><fmt:message code="email.th.addEmailRule" /></th>
                    </tr>
                    <tr  >
                        <td><fmt:message code="email.th.massDeliveryQuantity" />：</td>
                        <td>
                          <%--  <textarea name="txt" id="sendAmount" style="min-width: 70%;min-height: 40px;" value="" readonly></textarea>
                            <a href="javascript:;" class="choseDept">选择</a>
                            <a href="javascript:;" class="clearDept">清空</a>--%>
                              <span style="font-size: 14px;color: #1772c0"><fmt:message code="workflow.th.moreThanThe" /></span>
                              <input style="width: 30.5%;height: 30px" id="sendAmount" name="sendAmount" type="text" name="title" required  value="1" />
                        <span style="font-size: 14px;color: #1772c0">人</span>
                        </td>
                    </tr>
                    <tr  >
                        <td><fmt:message code="workflow.th.sector" />：</td>
                        <td>
                            <textarea name="deptName" id="deptName" style="min-width: 75%;min-height: 70px;" value="" readonly></textarea>
                            <a href="javascript:;" class="choseDept"><fmt:message code="notice.th.chose" /></a>
                            <a href="javascript:;" class="clearDept"><fmt:message code="global.lang.empty" /></a>
                        </td>
                    </tr>
                    <tr id="hide3" >
                        <td><fmt:message code="email.th.eliminatePeople" />：</td>
                        <td>
                                <textarea name="excludeUserName" id="excludeUserName"  style="min-width: 75%;min-height: 50px;" value="" readonly></textarea>
                            <a href="javascript:;" class="choseUserPerson"><fmt:message code="notice.th.chose" /></a>
                            <a href="javascript:;" class="clearUserPerson"><fmt:message code="global.lang.empty" /></a>
                        </td>
                    </tr>
                    <tr id="hide4" >
                        <td><fmt:message code="censor_th_reviewers" />：</td>
                        <td>
                            <textarea name="userName" id="userName" userName='' style="min-width: 75%;min-height: 35px;" value="" readonly></textarea>
                            <a href="javascript:;" class="choseUser"><fmt:message code="notice.th.chose" /></a>
                            <a href="javascript:;" class="clearUser"><fmt:message code="global.lang.empty" /></a>
                        </td>
                    </tr>

                    <tr id="hide5" style="">
                        <td colspan="2">
                            <div name="btn" id="btn" style="margin: 10px auto">
                               <%-- <div class="DIV_Txt" id="AddFolder"><span style="margin-left: 31px;"><fmt:message code="global.lang.add" /></span></div>--%>
                                   <div class="DIV_Txt" id="AddFolder"><span style="margin-left: 31px;"><fmt:message code="email.th.addingRules" /></span></div>
                            </div>
                        </td>
                    </tr>
                </table>
            </form>
        </div>
        <hr />
        <div class="div_list">
            <div class="title">
                <div class="div_im">
                    <img src="../img/icon_manageEmail_03.png">
                </div>
                <div class="div_title"><fmt:message code="email.th.managementEmailRule" /></div>
            </div>
            <div class="TABLE_A" id="TABLE_A">
                <table cellspacing="0" cellpadding="0" style="border-collapse:collapse;width:60%;margin: 0 auto;">
                    <thead>
                    <tr class='befor'>
                        <th><fmt:message code="file.th.Sort" /></th>
                        <th><fmt:message code="workflow.th.sector" /></th>
                        <th style="width: 100px;"><fmt:message code="email.th.eliminatePeople" /></th>
                        <th  style="width: 100px;"><fmt:message code="censor_th_reviewers" /></th>
                        <th width="100px"><fmt:message code="notice.th.operation" /></th>
                    </tr>
                    </thead>
                    <tbody id="eList">

                    </tbody>

                </table>
            </div>
        </div>
    </div>
</div>
</div>
<script>
    var user_id;
    var dept_id;
    $(function () {
        $('.choseDept').on('click',function () {
            dept_id='deptName';
            $.popWindow("../common/selectDept");
        })
        $('.choseUserPerson').on('click',function () {
            user_id='excludeUserName';
            $.popWindow("../common/selectUser");
        })
        $('.choseUser').on('click',function () {
            user_id='userName';
            $.popWindow("../common/selectUser");
        })
        $('.clearDept').on('click',function () {
            $('#deptName').attr('deptname','');
            $('#deptName').attr('deptid','');
            $('#deptName').attr('deptno','');
            $('#deptName').val('');
        });
        $('.clearUserPerson').on('click',function () {
            $('#excludeUserName').attr('user_id','');
            $('#excludeUserName').attr('username','');
            $('#excludeUserName').attr('dataid','');
            $('#excludeUserName').attr('userprivname','');
            $('#excludeUserName').val('');
        })
        $('.clearUser').on('click',function () {
            $('#userName').attr('user_id','');
            $('#userName').attr('username','');
            $('#userName').attr('dataid','');
            $('#userName').attr('userprivname','');
            $('#userName').val('');
        })

//        if($("input[name='examFlag']").val() == '2' || $("input[name='examFlag']").val() == '3'){
//            $('#hide1').show();
//            $('#hide2').show();
//        }else {
//            $('#hide1').hide();
//            $('#hide2').hide();
//        }


      /*  $("input[name='examFlag']").change(function () {
            if($(this).val() == '1'){
                $('#hide1').hide();
                $('#hide2').hide();
//                $('#hide3').hide();
            }else{
                $('#hide1').show();
                $('#hide2').show();
//                $('#hide3').show();
            }
        })*/

    })
</script>
</body>
</html>

