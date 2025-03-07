<%--
  Created by IntelliJ IDEA.
  User: 骆鹏
  Date: 2017/7/27
  Time: 11:05
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@taglib prefix="mvc" uri="http://www.springframework.org/tags/form" %>
<%@taglib prefix="fmt" uri="http://www.springframework.org/tags" %>

<html>
<head>
    <title><fmt:message code="doc.th.DocumentStatistics"/></title>
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <link rel="stylesheet" href="/css/officialDocument/officialDocument.css">

    <link rel="stylesheet" href="/lib/layer/skin/default/layer.css">
    <link rel="stylesheet" href="/lib/laydate/need/laydate.css">
    <link rel="stylesheet" href="/lib/pagination/style/pagination.css">
    <link rel="stylesheet" href="/css/base.css">
    <script type="text/javascript" src="/js/xoajq/xoajq3.js"></script>
    <script type="text/javascript" src="/js/jquery/jquery-migrate-3.4.0.js"></script>
    <script src="/js/jquery/jquery.cookie.js"></script>
    <script src="/lib/layer/layer.js?20201106"></script>
    <script src="/js/base/base.js"></script>
    <script src="/lib/laydate/laydate.js"></script>
    <script src="/lib/pagination/js/jquery.pagination.min.js" type="text/javascript" charset="utf-8"></script>
    <link rel="stylesheet" type="text/css" href="/css/commonTheme/${sessionScope.InterfaceModel}/commonTheme.css"/>
</head>
<body>
<div class="headTop">
    <ul class="clearfix">
        <li class="fl headTopLi active" data-id="0"><fmt:message code="doc.th.recordType"/></li>
        <li class="fl" style="margin-top: 3px;"><img src="/img/twoth.png" alt=""></li>
        <li class="fl headTopLi" data-id="2"><fmt:message code="notice.th.state"/></li>
        <%--<li class="fl" style="margin-top: 3px;"><img src="/img/twoth.png" alt=""></li>--%>
        <%--<li class="fl headTopLi">部门</li>--%>
    </ul>


</div>
<div style="margin: 0 auto;margin-top: 46px;width: 97%;" class="clearfix">
    <div><img src="/img/commonTheme/${sessionScope.InterfaceModel}/contractinfoend.png" alt=""><span style="
    height: 45px;
    line-height: 45px;
    font-size: 22px;
    margin-left: 10px;
    color: #494d59;"><fmt:message code="doc.th.DocumentStatistics"/></span></div>
    <label class="fl" style="margin-top: 16px;">
        <span class="fl" style="margin-top: 5px;"><fmt:message code="doc.th.enterTime"/>：</span>
        <label class="fl"><input type="text" class="startTime" name="startTime" placeholder="<fmt:message code="doc.th.startDate"/>" onclick="laydate({istime: true, format: 'YYYY-MM-DD'})"></label>

    </label>
    <label class="fl clearfix" style="margin-top: 16px;margin-left: 10px;">
        <span class="fl" style="margin-top: 5px;"><fmt:message code="global.lang.to"/></span>
    </label>
    <label class="fl clearfix" style="margin-top: 16px;margin-left: 10px;">
        <label class="fl"><input type="text" class="endTime" name="endTime" placeholder="<fmt:message code="doc.th.endDate"/>" onclick="laydate({istime: true, format: 'YYYY-MM-DD'})"></label>

    </label>
    <button  type="button" class="Query fl" style="margin-left: 100px;margin-top: 16px;"><fmt:message code="global.lang.query"/></button>
    <div id="dbgz_page" class="M-box3 fr">

    </div>
</div>


<div class="pagediv tableMain" id="table0" style="margin: 20px auto 10px auto;width: 97%;">
    <table>
        <thead>
        <tr>
            <th><fmt:message code="doc.th.DocumentType"/></th>
            <th><fmt:message code="doc.th.PostingNotReceived"/></th>
            <th><fmt:message code="doc.th.ForDispatch"/></th>
            <th><fmt:message code="doc.th.HaveIssuedDocument"/></th>
            <th><fmt:message code="doc.th.DispatchAll"/></th>
            <th><fmt:message code="doc.th.DidReceipt"/></th>
            <th><fmt:message code="doc.th.ForReceipt"/></th>
            <th><fmt:message code="doc.th.HaveCompleted"/></th>
            <th><fmt:message code="doc.th.Allin"/></th>
        </tr>
        </thead>
        <tbody>
        </tbody>
    </table>
</div>
<div class="pagediv clearfix tableMain" id="table2" style="margin: 20px auto;width: 97%;">



</div>

<script>
    var ajaxPage={
        data:{
            staType:null,
            startTime:null,
            endTime:null
        },
        page:function (num) {
            var me=this;
            this.data.staType=num;
            this.data.startTime=$('[name="startTime"]').val();
            this.data.endTime=$('[name="endTime"]').val();
            $('.tableMain').hide()
            $('#table'+num).show()
            $.get('/document/getStatistics',me.data,function (json) {
                var str='';
                var arr=json.datas;
                if(num==0) {
                    for (var i = 0; i < arr.length; i++) {
                        str += '<tr>' +
                            '<td>' + arr[i].dispatchType + '</td>' +
                            '<td>' + arr[i].sendNoSevCounts + '</td>' +
                            '<td>' + arr[i].sendIngCounts + '</td>' +
                            '<td>' + arr[i].sendEndCounts + '</td>' +
                            '<td>' + arr[i].sendTotal + '</td>' +
                            '<td>' + arr[i].recNoSevCounts + '</td>' +
                            '<td>' + arr[i].recIngCounts + '</td>' +
                            '<td>' + arr[i].recEndCounts + '</td>' +
                            '<td>' + arr[i].recTotal + '</td>' +
                            '</tr>'
                    }
                    $('#table' + num + ' table tbody').html(str)
                }
                if(num==2){
                    str='<ul class="active ">\
                            <li class="activeTow"><fmt:message code="notice.th.state"/></li>\
                            <li><fmt:message code="sup.th.NotReceived"/></li>\
                            <li><fmt:message code="lang.th.Process"/></li>\
                            <li><fmt:message code="doc.th.ToReceive"/></li>\
                            <li><fmt:message code="lang.th.HaveThrough"/></li>\
                            </ul>';
                    for (var i = 0; i < arr.length; i++) {
                        str+='<ul>' +
                            '<li class="active activeTow">'+arr[i].documenName+'</li>' +
                            '<li>'+arr[i].notSend+'</li>' +
                            '<li>'+arr[i].working+'</li>' +
                            '<li>'+arr[i].notRec+'</li>' +
                            '<li>'+arr[i].workOver+'</li>' +
                            '</ul>'

                    }
                    if(arr.length==1){
                        str+='<ul>' +
                            '<li class="active activeTow"><fmt:message code="doc.th.Dispatch"/></li>' +
                            '<li></li>' +
                            '<li></li>' +
                            '<li></li>' +
                            '<li></li>' +
                            '</ul>'
                    }
                    if(arr.length==0){
                        str+='<ul>' +
                            '<li class="active activeTow"><fmt:message code="doc.th.Dispatch"/></li>' +
                            '<li></li>' +
                            '<li></li>' +
                            '<li></li>' +
                            '<li></li>' +
                            '</ul>'+
                            '<ul>' +
                            '<li class="active activeTow"><fmt:message code="doc.th.In"/></li>' +
                            '<li></li>' +
                            '<li></li>' +
                            '<li></li>' +
                            '<li></li>' +
                            '</ul>'
                    }


                    $('#table'+num).html(str)
                }

            },'json')
        }
    }
    ajaxPage.page(0)
    $('.Query').on('click', function () {
        if($('.startTime').val()==''&& $('.endTime').val()==''){
            layer.msg('请选择开始时间和结束时间！');
        }else
        if($('.startTime').val()==''&& $('.endTime').val()!=''){
            layer.msg('请选择开始时间！');
        }else
        if($('.endTime').val()==''&& $('.startTime').val()!=''){
            layer.msg('请选择结束时间！');
        }else
        if($('.startTime').val()>$('.endTime').val()){
            layer.msg('开始时间不能大结束时间！');
            return false;

        }
        ajaxPage.page($('.headTop .active').attr('data-id'))

    })
    $('.headTop .headTopLi').on('click', function () {
        $(this).parent().find('li').removeClass('active')
        $(this).addClass('active')
        ajaxPage.page($(this).attr('data-id'))
    })
</script>

</body>
</html>
