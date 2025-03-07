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
    <title><fmt:message code="new.th.theAccessStatusOfNewsAnnouncements" /></title>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <meta name="renderer" content="webkit">
    <meta http-equiv="X-UA-Compatible" content="IE=10,chrome=1" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=0, minimum-scale=1.0, maximum-scale=1.0">
    <link rel="stylesheet" type="text/css" href="../css/news/find_detail.css" />
 <%--   <link rel="stylesheet" type="text/css" href="../lib/pagination/style/pagination.css"/>--%>
   <%-- <link rel="stylesheet" type="text/css" href="../css/base.css" />--%>
    <script src="/js/common/language.js"></script>
<%--    <script type="text/javascript" src="../js/xoajq/xoajq1.js"></script>--%>
    <script type="text/javascript" src="/js/xoajq/xoajq3.js"></script>
<%--    <script type="text/javascript" src="/js/jquery/jquery-migrate-3.4.0.js"></script>--%>
    <script src="../js/news/page.js"></script>
    <script src="../lib/laydate/laydate.js"></script>
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
<form name="form1" method="post" >
    <table border="0" width="100%" cellspacing="0" cellpadding="3" class="small">
        <tr>
            <td class="Big"><img src="../img/news/consultimg.png" align="absmiddle" class="consultimg"><span class="big3"> <fmt:message code="news.th.querysituation" /></span>
                <input type="button" value="<fmt:message code="vote.th.ClearingSituation" />" class="SmallButton">
                <%--<input type="button" value="完整显示查阅情况" class="clearButton">--%>
            </td>
        </tr>
    </table>

    <table class="TableTop" width="100%" align="center">
        <tr>
            <td class="left"></td>
            <td class="center"></td>
            <td class="right"></td>
        </tr>
    </table>
    <table class="TableBlock" width="100%" align="center">


    </table>
    <%--<table class="TableBlocks" width="100%" >--%>
        <%--<tr>--%>
            <%--<td>提醒未查阅人员:</td>--%>
            <%--<input type="hidden"  name="NOTIFY_ID" value="76">--%>
            <%--<input type="hidden"  name="un_userid_str" value="changbai,chenchangliu,chenqiang,liuyongkang,wangwu,lijia,wangyun,">--%>
            <%--<td align="left">--%>
               <%--&lt;%&ndash; <label class='sms-remind-label'><input type="checkbox" name="SMS_REMIND" id="SMS_REMIND" checked>发送事务提醒消息</label> &ndash;%&gt;           </td>--%>
        <%--</tr>--%>
        <%--<tr align="center">--%>
            <%--<td colspan="2" nowrap><input class="BigButton" onClick="SetNums()" type="button" value="确定"/>&nbsp;&nbsp;--%>
                <%--<input class="BigButton" onClick="window.close();" type="button" value="关闭"/>--%>
            <%--</td>--%>
        <%--</tr>--%>
    <%--</table>--%>
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
            /*查询某条新闻数据的接口*/
            var newsId=$.getQueryString("newsId");
            $.ajax({
                url: '/news/querySituation',
                type: 'get',
                data: {
                    newsId: newsId
                },
                dataType: 'json',
                success: function (obj) {
                    var data=obj.object;
                    var res=data.departmentList;
                    var str='';
                  /*  var  departmentData= digui(res,0);
                    callback(departmentData);*/
                    if(obj.flag==true){
                        $('.center').html(data.subject)
                        var arrs=digui(res,0)
                        str= departmentChild(arrs,str,0,-1)
                        var arr=[];
                        var head='<thead><tr><td class="TableContent" align="right" colspan="3"><u title="<fmt:message code="new.th.tableTitle" />" style="cursor:hand" class="userName">'+data.providerName+'</u>&nbsp;&nbsp;'+
                            '<fmt:message code="notice.th.postedto" />：<i class="sendDate">'+data.newsDateTime+'</i></td></tr><tr class="TableHeader">'+
                            '<td nowrap align="center"><fmt:message code="departement.th.memberUnit" /></td><td nowrap align="center"><fmt:message code="main.th.AlreadyReadPersonnel" /></td>'+
                            '<td nowrap align="center"><fmt:message code="main.th.UnreadPersons" /></td></tr></thead><tbody>';
                        var foot=' </tbody><tfoot class="TableControl"><tr><td nowrap align="center"><b><fmt:message code="global.lang.total" />：</b></td>'+
                                '<td nowrap align="center"><b>'+data.readSize+'</b></td><td nowrap align="center"><b>'+data.unreadSize+'</b></td></tr></tfoot>'
                        var tablemain=head+str+foot;
                        $('.TableBlock').html(tablemain);
                    }
                }
            })
            $('.SmallButton').on('click',function() {
                layer.confirm('<fmt:message code="vote.th.DetermineSituation" />？', {
                    btn: ['<fmt:message code="global.lang.ok" />','<fmt:message code="license.cancel" />'], //按钮
                    title:"<fmt:message code="vote.th.ClearingSituation" />"
                }, function(){
                    //确定删除，调接口
                    $.ajax({
                        url: '/news/updateNews',
                        type: 'post',
                        data: {
                            newsId: newsId,
                            readers:'',
                            editPublish:'3'
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
                    opt_li+='<tr class=TableData><td class="TableContent">'+String+datas[i].deptName+'</td><td style="">'+datas[i].read+'</td>'+
                        '<td style="">'+datas[i].unread+'</td></tr>';
                }else{
                    opt_li+='<tr class=TableData><td class="TableContent">'+String+datas[i].deptName+'</td><td style="">'+datas[i].read+'</td>'+
                        '<td style="">'+datas[i].unread+'</td></tr>';
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
