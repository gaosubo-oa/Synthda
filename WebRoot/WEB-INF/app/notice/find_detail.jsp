<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
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
    <title><fmt:message code="notice.th.Notification" /></title>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <meta name="renderer" content="webkit">
    <meta http-equiv="X-UA-Compatible" content="IE=10,chrome=1" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=0, minimum-scale=1.0, maximum-scale=1.0">
    <link rel="stylesheet" type="text/css" href="../css/notice/style.css" />
    <link rel="stylesheet" type="text/css" href="/lib/layui/layui/css/layui.css?20210319.1"/>
 <%--   <link rel="stylesheet" type="text/css" href="../lib/pagination/style/pagination.css"/>--%>
   <%-- <link rel="stylesheet" type="text/css" href="../css/base.css" />--%>
    <script type="text/javascript" src="../js/xoajq/xoajq1.js"></script>
    <script src="../js/news/page.js"></script>
    <script src="../lib/laydate.js"></script>
    <script type="text/javascript" src="/lib/layui/layui/layui.js"></script>
    <script src="../js/base/base.js" type="text/javascript" charset="utf-8"></script>
    <script type="text/javascript" >
        var MYOA_JS_SERVER = "";
        var MYOA_STATIC_SERVER = "";
    </script>
    <style>
      /*  td{
            text-align: center;
        }*/
        .TableContent {
            padding-left: 15px;
        }
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
<form name="form1" method="post" >
    <table border="0" width="100%" cellspacing="0" cellpadding="3" class="small">
        <tr>
            <td class="Big" style="margin-left: 10px;"><img src="../img/chayue.png" align="absmiddle" style="vertical-align: middle;margin-top: -5px;"><span class="big3"><fmt:message code="news.th.querysituation" /></span>
                <input type="button" value="<fmt:message code="vote.th.ClearingSituation" />" class="SmallButton">
            </td>
        </tr>
    </table>

    <table class="TableTop" width="100%" align="center">
        <tr>
            <td class="left"></td>
            <td class="center tid"><fmt:message code="vote.th.TestQuery" /></td>
            <td class="right"></td>
        </tr>
    </table>
    <table class="TableBlock" width="100%" align="center">

    </table>
    <table class="TableBlocks" width="100%" >
    <tr style="padding: 20px 0; height: 42px;border: 1px solid #ccc;">
        <td style="padding: 10px;"><fmt:message code="vote.th.RemindingLookup" />:</td>
        <td style="width: 54%;border-left: 1px solid #ccc;"><div style="float:left;padding: 10px;"><input id="remind" type="checkbox" checked="checked"> <label><fmt:message code="notice.th.sendTransactionReminderNotificationsToUnreadPersonnel" /></label></div></td>
        <input type="hidden"  name="NOTIFY_ID" value="76">
        <input type="hidden"  name="un_userid_str" value="changbai,chenchangliu,chenqiang,liuyongkang,wangwu,lijia,wangyun,">
        <td align="left">
           <%-- <label class='sms-remind-label'><input type="checkbox" name="SMS_REMIND" id="SMS_REMIND" checked>发送事务提醒消息</label> --%>           </td>
    </tr>
    <tr align="center">
<%--        onClick="window.close();"--%>
        <td colspan="2" nowrap><input class="BigButton" onClick="handleClick()"  type="button" value="<fmt:message code="menuSSetting.th.menusetsure" />"/>&nbsp;&nbsp;
            <input class="BigButton" onClick="window.close();" type="button" value="<fmt:message code="global.lang.close" />"/>
        </td>
    </tr>
    </table>

</form>


</body>
    <script>
        function digui(datas,departId) {
            var data=new Array();
            for(var i=0;i<datas.length;i++){
                if(datas[i].deptParent==departId){
                    datas[i]["childs"]=digui(datas,datas[i].deptId);
                    data.push(datas[i]);
                }
            }
            return data;
        }
        $(function(){
            $.ajax({
                type:'get',
                url:'/syspara/selectTheSysPara?paraName=IS_SHOW_JMJ',
                dataType:'json',
                success:function (res) {
                    if(res.object.length!=0){
                        var data=res.object[0]
                        if (data.paraValue!=0){
                            $('.TableTop').before('<p style="color: red;font-family: Microsoft YaHei;font-weight: bolder;font-size: 16pt;margin-left: 20px;margin-top: 10px;"> 机密级★ </p>')
                        }
                    }
                }
            })
            /*查询某条公告数据的接口*/
            var notifyId=$.getQueryString("notifyId");

            $.ajax({
                url: '/notice/querySituation',
                type: 'get',
                data: {
                    notifyId: notifyId

                },
                dataType: 'json',
                success: function (obj) {
                    var data=obj.object;
                    var res=data.departmentList;
                    var str='';
                  /*  var  departmentData= digui(res,0);
                    callback(departmentData);*/
                    if(obj.flag==true){
                        var arrs=digui(res,0)

                        str= departmentChild(arrs,str,0,-1)
                        var arr=[];
                        for(var i=0;i<res.length;i++){
                         /*   str+='<tr class=TableData><td class="TableContent">'+res[i].deptName+'</td><td style="">'+res[i].read+'</td>'+
                             '<td style="">'+res[i].unread+'</td></tr>'*/
                        }
                        var head='<thead><tr><td class="TableContent" align="right" colspan="3"><u title="<fmt:message code="userManagement.th.department" />：<fmt:message code="hr.th.NorthernResearch" />" style="cursor:hand" class="userName">'+data.name+'</u>&nbsp;&nbsp;'+
                            '<fmt:message code="notice.th.postedto" />：<i class="sendDate">'+data.notifyDateTime+'</i></td></tr><tr class="TableHeader">'+
                            '<td nowrap align="center"><fmt:message code="departement.th.memberUnit" /></td><td nowrap align="center"><fmt:message code="main.th.AlreadyReadPersonnel" /></td>'+
                            '<td nowrap align="center"><fmt:message code="main.th.UnreadPersons" /></td></tr></thead><tbody>';
                       var foot=' </tbody><tfoot class="TableControl"><tr><td nowrap align="center"><b><fmt:message code="global.lang.total" />：</b></td>'+
                                '<td nowrap align="center"><b>'+data.readSize+'</b></td><td nowrap align="center"><b>'+data.unreadSize+'</b></td></tr></tfoot>'
                            var tablemain=head+str+foot;
                       // console.log(tablemain)
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
                    opt_li+='<tr class=TableData><td class="TableContent" style="width:175px">'+String+datas[i].deptName+'</td><td style="width:345px">'+datas[i].read+'</td>'+
                        '<td style="">'+datas[i].unread+'</td></tr>';
                }else{
                    opt_li+='<tr class=TableData><td class="TableContent" style="width:175px">'+String+datas[i].deptName+'</td><td style="width:345px">'+datas[i].read+'</td>'+
                        '<td style="">'+datas[i].unread+'</td></tr>';
                }
                /* 	console.log(datas[i].childs);*/
                if(datas[i].childs!=null){
                    opt_li = departmentChild(datas[i].childs,opt_li,level+1,dept);
                }
            }
            return opt_li;
        }
    //    处理提醒
        function handleClick() {
            const notifyId = location.search.split('=')[1];
            const check = $('#remind').attr('checked');
            if($('#remind').is(":checked")) {
                $.ajax({
                    url:'/notice/notifyUnAll',
                    type:'get',
                    data: {
                        notifyId:notifyId
                    },
                    success(res) {
                        if(res.flag) {
                            layui.use(['layer'],function() {
                                const layer = layui.layer;
                                layer.open({
                                    ttile:'<fmt:message code="common.th.prompt" />',
                                    content:'<fmt:message code="notice.th.unreportedPersonnelHaveBeenNotified" />',
                                    yes() {
                                        window.close();
                                    }
                                })
                            })
                        }else {
                            layui.use(['layer'],function() {
                                const layer = layui.layer;
                                layer.open({
                                    ttile:'<fmt:message code="common.th.prompt" />',
                                    content:'<fmt:message code="notice.th.reminderFailed" />',
                                    yes() {
                                        window.close();
                                    }
                                })
                            })
                        }
                    },
                })
            }else {
                window.close();
            }

        }
    </script>
</html>
