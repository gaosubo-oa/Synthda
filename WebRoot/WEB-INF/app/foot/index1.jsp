<%--
  Created by IntelliJ IDEA.
  User: mr.circle
  Date: 2017/7/27
  Time: 11:03
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@taglib prefix="mvc" uri="http://www.springframework.org/tags/form" %>
<%@taglib prefix="fmt" uri="http://www.springframework.org/tags" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
%>
<html>
<head>
    <title><fmt:message code="foot.th.foot" /></title>
    <link rel="stylesheet" href="/css/foot/index.css">
    <link rel="stylesheet" href="/lib/layer/skin/default/layer.css">
    <link rel="stylesheet" href="/lib/pagination/style/pagination.css">
    <link rel="stylesheet" href="/lib/laydate/need/laydate.css">
    <link rel="stylesheet" href="/css/base.css">
    <script type="text/javascript" src="../js/xoajq/xoajq1.js"></script>
    <script src="/lib/layer/layer.js?20201106"></script>
    <script src="/js/base/base.js"></script>
    <script src="/lib/laydate/laydate.js"></script>
    <script src="/lib/pagination/js/jquery.pagination.min.js" type="text/javascript" charset="utf-8"></script>

</head>
<style>
    .Query{
        margin-top: 16px;
        background: #00a0e9;
        margin-left: 10px;
        padding:5px 10px;
        border-radius: 4px;
        color: #fff;
        cursor: pointer;
    }

</style>
<body>
<div class="headTop">
    <div class="headImg">
        <img src="/img/commonTheme/${sessionScope.InterfaceModel}/yibanfawen.png" alt="">
    </div>
    <h1 class="divTitle">
        <fmt:message code="foot.th.foot" />
    </h1>
</div>
<div class="pagediv" style="margin: 0 auto;width: 97%;margin-top: 61px;">
    <table>
        <thead>
        <tr>
            <th><fmt:message code="workflow.th.Serial" /></th>
            <th><fmt:message code="userDetails.th.name" /></th>
            <th><fmt:message code="email.th.time" /></th>
            <th><fmt:message code="depatement.th.address" /></th>
            <th><fmt:message code="userManagement.th.department" /></th>

        </tr>
        </thead>
        <tbody>
        </tbody>
    </table>
</div>

</div>
<script>
    Date.prototype.format = function(format) {
        var date = {
            "M+": this.getMonth() + 1,
            "d+": this.getDate(),
            "h+": this.getHours(),
            "m+": this.getMinutes(),
            "s+": this.getSeconds(),
            "q+": Math.floor((this.getMonth() + 3) / 3),
            "S+": this.getMilliseconds()
        };
        if (/(y+)/i.test(format)) {
            format = format.replace(RegExp.$1, (this.getFullYear() + '').substr(4 - RegExp.$1.length));
        }
        for (var k in date) {
            if (new RegExp("(" + k + ")").test(format)) {
                format = format.replace(RegExp.$1, RegExp.$1.length == 1
                    ? date[k] : ("00" + date[k]).substr(("" + date[k]).length));
            }
        }
        return format;
    }
    function getCookie (key) {
        var arr=document.cookie.split('; '); //多个cookie之间是用;+空格连接的
        for (var i = 0; i < arr.length; i++) {
            var arr2=arr[i].split('=');
            if(arr2[0]==key){
                return arr2[1];
            }
        }
        return false;//如果函数没有返回值，得到的结果是undefined
    }
    var res=$.GetRequest();
    //detail:1,app:1.uid:,time:
    $(function(){
        $.ajax({
            type:'get',
            url:'/syspara/selectTheSysPara?paraName=IS_SHOW_JMJ',
            dataType:'json',
            success:function (res) {
                if(res.object.length!=0){
                    var data=res.object[0]
                    if (data.paraValue!=0){
                        $('.divTitle').after('<span style="color: red;font-family: Microsoft YaHei;font-weight: bolder;font-size: 16pt;line-height: 45px;margin-left: 10px"> 机密级★ </span>')
                    }
                }
            }
        })
        var time = res.time;
        var uid = res.uid;
        var data={
            time:time,
            uid:uid,
            detail:1,
            app:1
        }
        $.get('/footprint/getWebFootPrint',data,function (json) {
            var str='';
            var arr=json.obj
            for(var i=0;i<arr.length;i++){
                var newDate = new Date();
                newDate.setTime(arr[i].createTime * 1000);
                str+='<tr>'+
                    '<td>'+(i+1)+'</td>' +
                    '<td>'+arr[i].users.userName+'</td>' +
                    '<td>'+newDate.format('yyyy-MM-dd h:m')+'</td>' +
                    '<td>'+arr[i].location+'</td>' +
                    '<td>'+arr[i].department.deptName+'</td>'
            }
            $('.pagediv table tbody').html(str)

        },'json')
    })
</script>
</body>
</html>
