<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib prefix="mvc" uri="http://www.springframework.org/tags/form" %>
<%@taglib prefix="fmt" uri="http://www.springframework.org/tags" %>

<%
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";

%>

<!DOCTYPE html>
<!--[if IE 6 ]> <html class="ie6 lte_ie6 lte_ie7 lte_ie8 lte_ie9"> <![endif]-->
<!--[if lte IE 6 ]> <html class="lte_ie6 lte_ie7 lte_ie8 lte_ie9"> <![endif]-->
<!--[if lte IE 7 ]> <html class="lte_ie7 lte_ie8 lte_ie9"> <![endif]-->
<!--[if lte IE 8 ]> <html class="lte_ie8 lte_ie9"> <![endif]-->
<!--[if lte IE 9 ]> <html class="lte_ie9"> <![endif]-->
<!--[if (gte IE 10)|!(IE)]><!--><html><!--<![endif]-->
<head>
    <title><fmt:message code="main.roledetail" /></title>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <meta name="renderer" content="webkit">
    <meta http-equiv="X-UA-Compatible" content="IE=10,chrome=1" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=0, minimum-scale=1.0, maximum-scale=1.0">
    <link rel="stylesheet" type="text/css" href="../css/notice/style.css" />
 <%--   <link rel="stylesheet" type="text/css" href="../lib/pagination/style/pagination.css"/>--%>
   <%-- <link rel="stylesheet" type="text/css" href="../css/base.css" />--%>
    <script type="text/javascript" src="../js/xoajq/xoajq1.js"></script>
    <script src="../js/news/page.js"></script>
    <script src="../lib/laydate.js"></script>
    <script src="../js/base/base.js" type="text/javascript" charset="utf-8"></script>
    <script type="text/javascript" >
        var MYOA_JS_SERVER = "";
        var MYOA_STATIC_SERVER = "";
    </script>
    <style>
      /*  td{
            text-align: center;
        }*/
    </style>
</head>

<script>

   /* function delete_reader(NOTIFY_ID)
    {
        msg='确认要清空查阅情况吗？';
        if(window.confirm(msg))
        {
            URL="delete_reader.php?NOTIFY_ID=" + NOTIFY_ID;
            window.location=URL;
        }
    }

    function SetNums()
    {
        document.form1.action="noread_remind.php";
        document.form1.submit();
    }*/
</script>

<body class="bodycolor">
  &nbsp;&nbsp;&nbsp;&nbsp;<fmt:message code="main.roledetail" />--[<span id="jiaose"></span> ]
<%--角色id--[${userPriv}]--%>
<form name="form1" method="post" >
    <table border="0" width="100%" cellspacing="0" cellpadding="3" class="small">
        <tr>
         <%--   <td class="Big" style="margin-left: 10px;"><img src="../img/chayue.png" align="absmiddle" style="vertical-align: middle;margin-top: -5px;"><span class="big3"><fmt:message code="news.th.querysituation" /></span>
                <input type="button" value="<fmt:message code="vote.th.ClearingSituation" />" class="SmallButton">
            </td>--%>
        </tr>
    </table>

    <table class="TableTop" width="100%" align="center">
        <tr>
            <td class="left"></td>
            <td class="center tid"><%--<fmt:message code="vote.th.TestQuery" /></td>--%>
            <td class="right"></td>
        </tr>
    </table>
    <table class="TableBlock" width="100%" align="center">

    </table>
    <table class="TableBlocks" width="100%" >
    <tr>
        <%--<td><fmt:message code="vote.th.RemindingLookup" />:</td>--%>
        <input type="hidden"  name="NOTIFY_ID" value="76">
        <input type="hidden"  name="un_userid_str" value="changbai,chenchangliu,chenqiang,liuyongkang,wangwu,lijia,wangyun,">
        <td align="left">
           <%-- <label class='sms-remind-label'><input type="checkbox" name="SMS_REMIND" id="SMS_REMIND" checked>发送事务提醒消息</label> --%>           </td>
    </tr>
<%--    <tr align="center">
        <td colspan="2" nowrap><input class="BigButton" onClick="window.close();" type="button" value="<fmt:message code="menuSSetting.th.menusetsure" />"/>&nbsp;&nbsp;
            <input class="BigButton" onClick="window.close();" type="button" value="<fmt:message code="global.lang.close" />"/>
        </td>
    </tr>--%>
    </table>
</form>


</body>
    <script>
        jiaose();
        var sp;
        function jiaose() {
            $.ajax({
                url:'/userPriv/getUserPrivName?userPriv='+$.GetRequest().userPriv,
                type:'get',
                dataType:'json',
                async:false,
                success:function (res) {
                    sp =res.object.privName;
                    $('#jiaose').append(sp);
                }
            });
        }
        function digui(datas,departId) {
            var data=new Array();
            var outDept;
            var leaveDept;
            for(var i=0;i<datas.length;i++){
                if(datas[i].deptParent==departId){
                    datas[i]["childs"]=digui(datas,datas[i].deptId);
                    data.push(datas[i]);
                }else if(datas[i].deptName.indexOf("人员") > -1) {
                    leaveDept = datas[i];
                }
                // 把离职部门放到最后一个
                if(departId==0&&i==datas.length-1){
                    data.push(leaveDept);

                }
            }
            return data;
        }
        $(function(){
            /*查询某条公告数据的接口*/
            var notifyId=$.getQueryString("notifyId");
            var userPriv=${userPriv};

            $.ajax({
                url: '/userPriv/query_usersbyuserPriv',
                type: 'get',
                data: {
                    userPriv: userPriv

                },
                dataType: 'json',
                success: function (obj) {
                    var data=obj.object;
                    var obj1=obj.obj1;
                    var res=data;
                    var str='';
                  /*  var  departmentData= digui(res,0);
                    callback(departmentData);*/
                    if(obj.flag==true){
                        var arrs=digui(res,0)
                        console.log(arrs)
                        str= departmentChild(arrs,str,0,-1)

                        var head='<thead><tr>'+
                            '<td nowrap align="center"><fmt:message code="departement.th.memberUnit" /></td><td nowrap align="center"><fmt:message code="main.peopleCount" /></td>'+
                            '<td nowrap align="center"><fmt:message code="main.mainroleallusers" /></td><td nowrap align="center">(<fmt:message code="main.nologin" />)</td><td nowrap align="center"><fmt:message code="main.auxiliaryroleuser" /></td></tr></thead><tbody>';
                        var foot=' </tbody><tfoot class="TableControl"><tr><td nowrap align="center"><b><fmt:message code="global.lang.total" />：</b></td><td nowrap align="center"><b></b></td>'+
                                '<td nowrap align="center"><b>'+obj1.alltheMainRoleallUsersCount+'</b></td><td nowrap align="center"><b>'+obj1.allnoLoginUsersCount+'</b></td><td nowrap align="center"><b>'+obj1.allauxiliaryRoleUserCount+'</b></td></tr></tfoot>'
                            var tablemain=head+str+foot;

                        $('.TableBlock').html(tablemain);
                        $('.tid').html(data.subject);
                    }
                }
            })
            $('.SmallButton').on('click',function() {
                layer.confirm('<fmt:message code="vote.th.DetermineSituation" />？', {
                    btn: ['<fmt:message code="global.lang.ok" />','<fmt:message code="depatement.th.quxiao" />'], //按钮
                    title:"<fmt:message code="vote.th.ClearingSituation" />"
                }, function(){
                    //确定删除，调接口
                    $.ajax({
                        url: '/notice/updateNotify',
                        type: 'post',
                        data: {
                            notifyId: notifyId,
                            readers:''
                        },
                        dataType: 'json',
                        success: function (obj) {
                            window.location.reload();
                        }
                    })

                }, function(){
                    layer.closeAll();
                });
            })
            })

        //部门遍历方法
        function departmentChild(datas,opt_li,level,dept){
            for(var i=0;i<datas.length;i++){
                if(datas[i]==undefined){
                    continue;
                }
                var String="";
                var space=""
                for(var j=0;j<level;j++){
                    space+="&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;├&nbsp;&nbsp;&nbsp;";
                }
                /* console.log("kongge"+space+"kongge")*/
                if(i==0){
                    String=space+"┌";
                }else
                if(i!=0){
                    String=space+"├";
                }else
                if(i==datas.length-1){
                    String=space+"└";
                }
                if(dept==datas[i].deptId){
                    opt_li+='<tr class=TableData><td class="TableContent" width="20%">'+String+datas[i].deptName+'</td><td style="" width="10%">'+datas[i].theMainRoleallUsersCount+'('+datas[i].noLoginUsersCount+')/'+datas[i].auxiliaryRoleUserCount+'</td>'+'<td style="" width="25%">'+datas[i].theMainRoleallUsers+'</td>'+
                        '<td style="" width="25%">'+datas[i].noLoginUsers+'</td>'+'<td style="" >'+datas[i].auxiliaryRoleUser+'</td></tr>';
                }else{
                    opt_li+='<tr class=TableData><td class="TableContent"  width="20%">'+String+datas[i].deptName+'</td><td style="" width="10%">'+datas[i].theMainRoleallUsersCount+'('+datas[i].noLoginUsersCount+')/'+datas[i].auxiliaryRoleUserCount+'</td>'+'<td style="" width="25%">'+datas[i].theMainRoleallUsers+'</td>'+
                        '<td style="" width="25%">'+datas[i].noLoginUsers+'</td>'+'<td style="" >'+datas[i].auxiliaryRoleUser+'</td></tr>';
                }
                /* 	console.log(datas[i].childs);*/
                if(datas[i].childs!=null){
                    opt_li = departmentChild(datas[i].childs,opt_li,level+1,dept);
                }
            }
            return opt_li;
        }
    </script>
</html>
