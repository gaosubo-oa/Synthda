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
    <title><fmt:message code="main.userquery" /></title>
    <meta name="renderer" content="webkit">
    <meta http-equiv="X-UA-Compatible" content="IE=10,chrome=1">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=0, minimum-scale=1.0, maximum-scale=1.0">
    <link rel="stylesheet" type="text/css" href="../css/sys/userInfor.css"/>
    <script src="../js/xoajq/xoajq3.js" type="text/javascript" charset="utf-8"></script>
    <script src="../js/base/base.js" type="text/javascript" charset="utf-8"></script>
    <script src="../js/sys/userInfor.js?20230301.1" type="text/javascript" charset="utf-8"></script>
    <style>
        #downChild .dpetWhole0 .childdept{
            padding-left: 60px!important;
        }
        #downChild .dpetWhole0 ul .childdept{
            padding-left: 80px!important;
        }trAllPerson
        #downChild .dpetWhole0 ul ul li .childdept{
            padding-left: 95px!important;
        }
        .content .left {
            width: 21.5%;
            background-color: #fff;
        }
        .content .right{
            width:78%;
        }
        .table .blue_text{
            font-size: 13pt;
        }

        .tab table tr th{
            font-size: 13pt;
        }
        .tab table{
            font-size: 11pt;
        }
        .content .left .collect .divUP{
            overflow-x: auto;
            min-height:400px;
        }
        .content .left .collect .spanUP{
            font-size: 14px;
        }
        .pickCompany a{
            font-size: 14px;
        }
        #downChild li a{
            font-size: 14px;
        }
        #downChild li{
            font-size: 14px;
            /*width: 2000px;*/
            display: block;
            min-width: 100%;
            overflow-y: auto;
            white-space: nowrap;
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
        ::-webkit-scrollbar{
            width: 5px;
            height: 5px;
            background-color: #f5f5f5;
        }
    </style>
</head>
<body>
<div class="content">
    <div class="headDiv">
        <div class="div_Img">
            <img src="/img/commonTheme/${sessionScope.InterfaceModel}/icon_userManagement1.png" style="vertical-align: middle;" alt="用户信息查询">
        </div>
        <div class="divP"><fmt:message code="main.userquery" /></div>
    </div>
    <div class="left">
        <div class="collect">
            <div id="incum" class="divUP">
                <span class="spanUP liUp AUP" style="padding-left:0px"><img src="/img/commonTheme/${sessionScope.InterfaceModel}/icon_inservicsPersonnel.png" style="vertical-align: middle;width: 18px;margin-right: 10px;padding-left: 30px;" alt="在职人员"><fmt:message code="userManagement.th.In-servicePersonnel" /></span>
                <div id="downChild">
                    <div class="pickCompany"><div style="margin-top: 8px;padding-left: 18px;" class="childdept"><img src="/img/commonTheme/${sessionScope.InterfaceModel}/icon_company.png" alt="" style="vertical-align: middle;width: 15px;margin-right: 10px;margin-left: 13px;margin-bottom: 4px;"><a href="javascript:void(0)" class="dynatree-title" title="" style="color: #000;"></a></div></div>
                </div>
            </div>
            <div>
                <span class="spanUP liUp" id="OUTP"><img src="/img/commonTheme/${sessionScope.InterfaceModel}/icon_outgoingPersonnel.png" style="vertical-align: middle;width: 18px;margin-right: 10px;" alt="外出人员"><fmt:message code="userInfor.th.Outgoing" /></span>
            </div>
            <div>
                <span class="spanUP liUp" id="ALLP"><img src="/img/commonTheme/${sessionScope.InterfaceModel}/icon_allPersonnel.png" style="vertical-align: middle;width: 18px;margin-right: 10px;" alt="全部人员"><fmt:message code="userInfor.th.Allpersonnel" /></span>
            </div>
            <div>
                <span class="spanUP liUp on" id="QUERY"><img src="/img/commonTheme/${sessionScope.InterfaceModel}/icon_personnelQuery.png" style="vertical-align: middle;width: 18px;margin-right: 10px;" alt="人员查询"><fmt:message code="userInfor.th.PersonnelInquiries" /></span>
            </div>
        </div>
    </div>
    <div class="right">
        <div class="queryUser" style="display: block;">
            <div class="title">
                <img src="/img/commonTheme/${sessionScope.InterfaceModel}/icon_personnelQuery.png" class="ChildTitleIcon" alt="人员查询" style="    margin-top: 12px;">
                <span><fmt:message code="userInfor.th.PersonnelInquiries" /></span>
            </div>
            <table class="table" cellspacing="0" cellpadding="0" style="border-collapse:collapse;background-color: #fff">
                <tr>
                    <td class="blue_text"><fmt:message code="userName" />：</td>
                    <td>
                        <input type="text" name="userId" class="inputTd"/>
                    </td>
                </tr>
                <tr>
                    <td class="blue_text"><fmt:message code="userManagement.th.Realname" />：</td>
                    <td>
                        <input type="text" name="userName" class="inputTd"/>
                    </td>
                </tr>
                <tr>
                    <td class="blue_text"><fmt:message code="userDetails.th.Gender" />：</td>
                    <td>
                        <select name="sex">
                            <option value=""></option>
                            <option value="0"><fmt:message code="userInfor.th.male" /></option>
                            <option value="1"><fmt:message code="userInfor.th.female" /></option>
                        </select>
                    </td>
                </tr>
                <tr>
                    <td class="blue_text"><fmt:message code="userManagement.th.department" />：</td>
                    <td>
                        <select name="unit" id="department">
                        </select>
                    </td>
                </tr>
                <tr>
                    <td class="blue_text"><fmt:message code="userManagement.th.role" />：</td>
                    <td>
                        <select name="user" id="selectUser">
                        </select>
                    </td>
                </tr>

                <tr>
                    <td colspan="2">
                        <div class="btn">
                            <%--<input id="submit" type="button" class="backQueryBtn" value="&nbsp;&nbsp;&nbsp;&nbsp;<fmt:message code="global.lang.query" />"/>--%>
                            <%--&lt;%&ndash;<input id="submit" type="button" value="<fmt:message code="global.lang.query" />"/>&ndash;%&gt;--%>
                            <%--<input id="export" type="button" class="backExportBtn" value="&nbsp;&nbsp;&nbsp;&nbsp;<fmt:message code="global.lang.report" />"/>--%>
                            <div id="submit" class="backQueryBtn"><span style="margin-left: 33px;"><fmt:message code="global.lang.query" /></span></div>
                            <div id="export" class="backExportBtn"><span style="margin-left: 33px;"><fmt:message code="global.lang.report" /></span></div>
                        </div>
                    </td>
                </tr>
            </table>
        </div>
        <div class="outPerson" style="display: none;">
            <div class="title">
                <img src="/img/commonTheme/${sessionScope.InterfaceModel}/icon_outgoingPersonnel.png" class="ChildTitleIcon" alt="外出人员">
                <span><fmt:message code="userInfor.th.Outgoing" /></span>
            </div>
            <div class="tab" style="display: none;">
                <table cellspacing="0" cellpadding="0" style="border-collapse:collapse;">
                    <tr class='tr_befor'>
                        <th width=""><fmt:message code="userManagement.th.department" /></th>
                        <th width=""><fmt:message code="userManagement.th.role" /></th>
                        <th width=""><fmt:message code="userDetails.th.name" /></th>
<%--                        <th width=""><fmt:message code="userInfor.th.OnlineDuration" /></th>--%>
                        <th width=""><fmt:message code="userDetails.th.Gender" /></th>
                        <th width=""><fmt:message code="userInfor.th.Workphone" /></th>
                        <th width=""><fmt:message code="userDetails.th.MobilePhone" /></th>
                        <th width=""><fmt:message code="main.email" /></th>
                    </tr>
                </table>
            </div>
            <div class="noData" style="display: block;">
                <div class="bgImg">
                    <div class="IMG">
                        <img src="../img/sys/icon64_info.png"/>
                    </div>
                    <div class="TXT"><fmt:message code="userInfor.th.NoOutgoing" /></div>
                </div>
            </div>
        </div>
        <div class="allPerson" style="display: none;">
            <div class="title">
                <img src="/img/commonTheme/${sessionScope.InterfaceModel}/icon_allPersonnel.png" class="ChildTitleIcon" alt="全部人员" style="    margin-top: 13px;">
                <span><fmt:message code="userInfor.th.Allpersonnel" /></span>
            </div>
            <div class="tab">
                <table cellspacing="0" cellpadding="0" style="border-collapse:collapse;">
                    <tr class='trAllPerson'>
                        <th width=""><fmt:message code="userManagement.th.department" /></th>
                        <th width=""><fmt:message code="userManagement.th.role" /></th>
                        <th width=""><fmt:message code="userDetails.th.name" /></th>
<%--                        <th width=""><fmt:message code="userInfor.th.OnlineDuration" /></th>--%>
                        <th width=""><fmt:message code="userDetails.th.Gender" /></th>
                        <th width=""><fmt:message code="userInfor.th.Workphone" /></th>
                        <th width=""><fmt:message code="userDetails.th.MobilePhone" /></th>
                        <th width=""><fmt:message code="main.email" /></th>
                    </tr>
                </table>
            </div>
        </div>
        <div class="userQuery" style="display: none;">
            <div class="title">
                <span><fmt:message code="userInfor.th.UserQuery" /></span>
            </div>
            <div class="tab">
                <table cellspacing="0" cellpadding="0" style="border-collapse:collapse;">
                    <tr class='tr_befor'>
                        <th width=""><fmt:message code="userManagement.th.department" /></th>
                        <th width=""><fmt:message code="userManagement.th.role" /></th>
                        <th width=""><fmt:message code="userDetails.th.name" /></th>
<%--                        <th width=""><fmt:message code="userInfor.th.OnlineDuration" /></th>--%>
                        <th width=""><fmt:message code="userDetails.th.Gender" /></th>
                        <th width=""><fmt:message code="userInfor.th.Workphone" /></th>
                        <th width=""><fmt:message code="userDetails.th.MobilePhone" /></th>
                        <th width=""><fmt:message code="main.email" /></th>
                    </tr>
                </table>
            </div>
        </div>
        <div class="conditionQuery" style="display: none;">
            <div class="title">
                <span><fmt:message code="userInfor.th.UserQuery" /></span>
            </div>
            <div class="tab">
                <table cellspacing="0" cellpadding="0" style="border-collapse:collapse;">
                    <tr class='Condition'>
                        <th width=""><fmt:message code="userManagement.th.department" /></th>
                        <th width=""><fmt:message code="userManagement.th.role" /></th>
                        <th width=""><fmt:message code="userDetails.th.name" /></th>
<%--                        <th width=""><fmt:message code="userInfor.th.OnlineDuration" /></th>--%>
                        <th width=""><fmt:message code="userDetails.th.Gender" /></th>
                        <th width=""><fmt:message code="userInfor.th.Workphone" /></th>
                        <th width=""><fmt:message code="userDetails.th.MobilePhone" /></th>
                        <th width=""><fmt:message code="main.email" /></th>
                    </tr>
                </table>
                <div class="backBtn"><span style="margin-left: 30px;"><fmt:message code="notice.th.return" /></span></div>
            </div>
        </div>
        <div class="childQuery" style="display: none;">
            <div class="title">
                <img src="/img/commonTheme/${sessionScope.InterfaceModel}/icon_inservicsPersonnel.png" class="ChildTitleIcon" alt="用户查询">
                <span><fmt:message code="userInfor.th.UserQuery" /></span>
            </div>
            <div class="tab">
                <table cellspacing="0" cellpadding="0" style="border-collapse:collapse;">
                    <tr class='allCondition'>
                        <th width=""><fmt:message code="userManagement.th.department" /></th>
                        <th width=""><fmt:message code="userDetails.th.name" /></th>
                        <th width=""><fmt:message code="userManagement.th.role" /></th>
                        <th width=""><fmt:message code="userDetails.th.AuxiliaryRole" /></th>
<%--                        <th width=""><fmt:message code="userInfor.th.OnlineDuration" /></th>--%>
                        <th width=""><fmt:message code="userDetails.th.Gender" /></th>
                        <th width=""><fmt:message code="userInfor.th.workTelephone" /></th>
                        <th width=""><fmt:message code="userInfor.th.DepartmentalTelephone" /></th>
                        <th width=""><fmt:message code="userDetails.th.MobilePhone" /></th>
                        <th width=""><fmt:message code="main.email" /></th>
                    </tr>
                </table>
               <%-- <div class="backBtn">返回</div>--%>
            </div>
        </div>
    </div>
</div>
<script>
    function ajaxdata(deptNumId,me) {//部门
        $('.childQuery').show().siblings().hide();
        $('#ULDown li').find('span').removeClass('on');
        $(this).addClass('on');
        $('.loopData').remove();
        var data={
            'choice':1,
            'deptId':deptNumId
        }
        $.ajax({
            type:'get',
            url:'../getUserbyCondition',
            dataType:'json',
            data:data,
            success:function(res){
                var data1=res.obj;
                var str='';
                for(var i=0;i<data1.length;i++){
                    var txt=data1[i].sex==0?'男':'女';
                    if(data1[i].RoleAuxiliaryName){
                        str+='<tr class="loopData" uid="'+data1[i].uid+'"><td>'+data1[i].dep.deptName+'</td><td><a href="javascript:;" class="userDetail">'+data1[i].userName+'</a></td><td>'+data1[i].userPrivName+'</td><td>'+data1[i].RoleAuxiliaryName+'</td><td>'+txt+'</td><td>'+data1[i].telNoDept+'</td><td>'+data1[i].dep.telNo+'</td><td>'+data1[i].mobilNo+'</td><td>'+data1[i].email+'</td></tr>'
                    }else{
                        str+='<tr class="loopData" uid="'+data1[i].uid+'"><td>'+data1[i].dep.deptName+'</td><td><a href="javascript:;" class="userDetail">'+data1[i].userName+'</a></td><td>'+data1[i].userPrivName+'</td><td></td><td>'+txt+'</td><td>'+data1[i].telNoDept+'</td><td>'+data1[i].dep.telNo+'</td><td>'+data1[i].mobilNo+'</td><td>'+data1[i].email+'</td></tr>'
                    }

                }
                $('.allCondition').after(str);
            }
        })
    }
    $(function(){
        $('#department').deptSelect();
        $('#selectUser').privSelect();
//        $.loadSidebar($('#downChild'),0,function (el) {
////            $.loadSidebar(el,30)
//        })
        loadSidebar1($('#downChild'),0)

        function loadSidebar1(target,deptId) {

            $.ajax({
                url: '/department/getChDeptfq',
                type: 'get',
                data: {
                    deptId: deptId
                },
                dataType: 'json',
                success: function (data) {
                    var str = '';
                    data.obj.forEach(function (v, i) {
                        if (v.deptName) {
                            str += '<li><span data-types="1"  data-numtrue="1" ' +
                                'onclick= "imgDown(' +v.deptId + ',this)"  style="height:35px;line-height:35px;padding-left: 30px" deptid="' + v.deptId + '" class="firsttr childdept"><span class=""></span><img src="/img/sys/dapt_right.png" alt="" style="margin-left: 12px;width: 8px;height: 14px;margin-top: -3px;margin-right: 4px;"><a href="javascript:void(0)" class="dynatree-title" title="' + v.deptName + '">' + v.deptName + '</a></span><ul style="display:none;" class="dpetWhole0"></ul></li>';
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
                $('#downChild .pickCompany .dynatree-title').text(data).attr('title',data);

            },
            error:function(e){
                console.log(e);
            }
        })
    })
</script>
</body>
</html>

