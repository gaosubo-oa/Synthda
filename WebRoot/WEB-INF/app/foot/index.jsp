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
    <script type="text/javascript" src="/ui/js/xoajq/xoajq3.js"></script>
    <script src="/lib/layer/layer.js?20201106"></script>
    <script src="/js/base/base.js"></script>
    <script src="/lib/laydate/laydate.js"></script>
    <script src="/lib/pagination/js/jquery.pagination.min.js" type="text/javascript" charset="utf-8"></script>
    <link rel="stylesheet" type="text/css" href="/css/commonTheme/${sessionScope.InterfaceModel}/commonTheme.css"/>

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
    .deleteSc{
        white-space:nowrap;
    }

</style>
<body>
<div class="headTop">
    <div class="headImg">
        <img src="/img/commonTheme/${sessionScope.InterfaceModel}/icon_footer.png" alt="">
    </div>
    <div class="divTitle">
        <fmt:message code="foot.th.foot" />
    </div>
</div>
<div style="margin: 0 auto;margin-top: 46px;height: 60px;width: 97%;" class="navigation clearfix">

    <label class="fl clearfix" style="margin-top: 16px;margin-left: 10px;">
        <span class="f1" style="margin-top: 5px;" ><fmt:message code="foot.th.chooseType" />：</span>
        <select class="app">
            <option value="3"><fmt:message code="foot.th.queryAll" /></option>
            <option value="2"><fmt:message code="foot.th.queryDept" /></option>
            <option value="1"><fmt:message code="foot.th.querySelf" /></option>
        </select>
    </label>
    <%--<label class="fl clearfix" style="margin-top: 16px;margin-left: 10px;" >
        <span class="fl" style="margin-top: 5px;">获奖项目：</span>
        <label class="fl"><input name="prizeProject" id="prizeProject_2" placeholder="请输入获奖项目"  type="text"></label>
        <button  type="button" class="Query fl"><fmt:message code="global.lang.query"/></button>
        <button  type="button" class="Export" onclick="export_1();">导出Excel</button>
        <button  type="button" class="NEW">新建获奖信息</button>
    </label>--%>
    <button  type="button" class="Query" onclick="query();"><fmt:message code="global.lang.query" /></button>
    <div class="left" style="float:  left;width: 265px;">
        <label class="nav_date">
            <fmt:message code="global.lang.date" />
            :
        </label>
        <input class="button1" id="sendTime" onclick="laydate(start)">
    </div>
</div>


<div class="pagediv" style="margin: 0 auto;width: 97%;">
    <table>
        <thead>
        <tr>
            <th> <fmt:message code="workflow.th.Serial" /></th>
            <th><fmt:message code="userDetails.th.name" /></th>
            <th><fmt:message code="email.th.time" /></th>
            <th><fmt:message code="depatement.th.address" /></th>
            <th><fmt:message code="foot.th.longitude" /></th>
            <th><fmt:message code="foot.th.latitude" /></th>
            <th><fmt:message code="menuSSetting.th.menuSetting"/></th>
        </tr>
        </thead>
        <tbody>
        </tbody>
    </table>
</div>
<div id="dbgz_page" class="M-box3 fr" style="margin-right: 24px;">

</div>
<script>
    //格式化时间
    function   formatDate(now)   {
        if(now!=''&& now!=undefined){
            var   year=now.getFullYear();
            var   month=now.getMonth()+1;
            var   date=now.getDate();
            var   hour=now.getHours();
            var   minute=now.getMinutes();
            var   second=now.getSeconds();
            return  year+"<fmt:message code="chat.th.year"/>"+month+"<fmt:message code="global.lang.month"/>";
        }else{
            return "";
        }
    }

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
    //detail:1,app:1.uid:,time:
    var ajaxPage={
        data:{
            detail:0,
            page:1,//当前处于第几页
            pageSize:5,//一页显示几条
            useFlag:true,
            app:null,
            time:''
        },
        page:function () {
            var me=this;
            this.data.app=$('.app').val();
            this.data.time = $('#sendTime').val();
            $.get('/footprint/getWebFootPrint',me.data,function (json) {
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
                        '<td>'+arr[i].lat+'</td>' +
                        '<td>'+arr[i].lng+'</td>' +
                        '<td>' +
                        '<a href="/footprint/index1?time='+newDate.format('yyyy-MM-dd')+'&uid='+arr[i].uid+'" target= _blank  data-id="'+json.obj[i].id+'" class="deleteSc" style="margin-right: 10px"><fmt:message code="roleAuthorization.th.ViewDetails" /></a><a href="/footprint/index2?time='+newDate.format('yyyy-MM-dd')+'&uid='+arr[i].uid+'&lat=' + json.obj[i].lat + '&lng=' + json.obj[i].lng + '" target= _blank  data-id="'+json.obj[i].id+'" class="deleteSc"><fmt:message code="foot.th.mapShow" /></a>' +
                        '</td>' +
                        '</tr>'
                }
                $('.pagediv table tbody').html(str)
                me.pageTwo(json.totleNum,me.data.pageSize,me.data.page)

            },'json')
        },
        pageTwo:function (totalData, pageSize,indexs) {
            var mes=this;
            $('#dbgz_page').pagination({
                totalData: totalData,
                showData: pageSize,
                jump: true,
                coping: true,
                homePage:'',
                endPage: '',
                current:indexs||1,
                callback: function (index) {

                    mes.data.page=index.getCurrent();
                    mes.page();
                }
            });
        }
    }
    function query(){
        ajaxPage.data.page=1;
        ajaxPage.page()
    }
    var start = {
        elem: '#sendTime',
        format: 'YYYY-MM-DD',
        istime: true,
        istoday: false,

        //回调函数
    };
    $(function(){
        //新建分类接口
        ajaxPage.data.page=1;
        ajaxPage.page()
    })
</script>
</body>
</html>
