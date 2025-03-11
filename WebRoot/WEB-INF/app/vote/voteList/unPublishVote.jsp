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
    <%--<link rel="stylesheet" type="text/css" href="../../css/dept/deptManagement.css"/>--%>
    <link rel="stylesheet" type="text/css" href="../../lib/easyui/themes/easyui.css"/>
    <link rel="stylesheet" type="text/css" href="../../lib/easyui/themes/icon.css"/>
    <link rel="stylesheet" type="text/css" href="../../css/base.css"/>
    <link rel="stylesheet" type="text/css" href="../../lib/pagination/style/pagination.css"/>
    <link rel="stylesheet" type="text/css" href="../../css/news/center.css"/>
    <%--<link rel="stylesheet" type="text/css" href="../../css/dept/new_news.css"/>--%>
    <script src="../../js/common/language.js"></script>
<%--    <script type="text/javascript" src="../../js/xoajq/xoajq1.js"></script>--%>
    <script type="text/javascript" src="/js/xoajq/xoajq3.js"></script>
<%--    <script type="text/javascript" src="/js/jquery/jquery-migrate-3.4.0.js"></script>--%>
    <script type="text/javascript" src="../../js/base/base.js"></script>
    <script src="/lib/layer/layer.js?20201106"></script>
    <script src="../../js/base/base.js" type="text/javascript" charset="utf-8"></script>
    <script src="/lib/pagination/js/jquery.pagination.min.js" type="text/javascript" charset="utf-8"></script>
    <title><fmt:message code="vote.th.vote" /></title>
    <style>
        .title span{
            font-size:22px;
            color:#494d59;
            padding-left:20px;
        }
        .title{
            margin-bottom:20px;
        }
        document,body{
            width:100%;
            height:100%;
        }

        .content{
            margin:20px auto 0px;
            margin-top: 71px;
            width:100%;
            height:100%;
        }
        .table table{
            width: 97%;
            margin:0 auto;
        }
        th{
            background-color: #fff;
            font-size: 15px;
            color: #2F5C8F;
            font-weight: bold;
            border: 0px;
            line-height:45px;
            text-align:left;
            padding-left:10px;
        }
        .titleName{
            cursor:pointer;
        }
        .M-box3 .active{
            margin: 0px 3px;
            width: 29px;
            height: 29px;
            line-height: 29px;
            background: #2b7fe0;
            font-size: 12px;
            border: 1px solid #2b7fe0;
            color:#fff;
            text-align:center;
            display: inline-block;
        }
        .M-box3 a{
            margin: 0 3px;
            width: 29px;
            height: 29px;
            line-height: 29px;
            font-size: 12px;
            display: inline-block;
            text-align:center;
            background: #fff;
            border: 1px solid #ebebeb;
            color: #bdbdbd;
            text-decoration: none;
        }
        table thead tr th{
            font-size: 13pt;
        }
        table tbody tr td{
            font-size: 11pt;
        }
    </style>
    <link rel="stylesheet" type="text/css" href="/css/commonTheme/${sessionScope.InterfaceModel}/commonTheme.css"/>
</head>
<body style="overflow:scroll;overflow-y: auto;overflow-x:hidden;">

<%--管理已发布的投票--%>

<div class="content">
    <div class="title">
        <img src="/img/commonTheme/${sessionScope.InterfaceModel}/end.png" alt="" style="padding-left:30px;margin-bottom: 7px">
        <span style="padding-left:10px;"><fmt:message code="vote.th.Discontinued" /></span>
    </div>
<%--    <div style="margin: -60px auto 0px;height:50px;width: 97%;" class="clearfix">--%>
<%--        <div id="dbgz_page" class="M-box3">--%>

<%--        </div>--%>
<%--    </div>--%>
    <div class="table">
        <table>
            <thead>
            <tr>
                <th><fmt:message code="notice.th.publisher" /></th>
                <th><fmt:message code="notice.th.title" /></th>
                <th><fmt:message code="vote.th.anonymous" /></th>
                <th><fmt:message code="vote.th.HaveVoted" /></th>
                <th><fmt:message code="notice.th.effectivedate" /></th>
                <th><fmt:message code="notice.th.endDate" /></th>
                <th><fmt:message code="notice.th.operation" /></th>
            </tr>
            </thead>
            <tbody class="list">

            </tbody>
        </table>
    </div>
    <div style="margin: 0px auto 0px;height:50px;width: 97%;" class="clearfix">
        <div id="dbgz_page" class="M-box3">

        </div>
    </div>
</div>
<script type="text/javascript">

    //点击查询后，查询列表展示
    $(function () {
        //        列表带分页
        var ajaxPageLe={
            data:{
                page:1,//当前处于第几页
                pageSize:10,//一页显示几条
                useFlag:true
            },
            page:function () {
                var me=this;
                $.ajax({
                    url:'/vote/manage/getVoteTitleCount',
                    type:'get',
                    dateType:'json',
                    data:me.data,
                    success:function(reg){
                        var data=reg.obj;
                        var str=""
                        for(var i=0;i<data.length;i++){
                            str+='<tr class="pagediv" id='+data[i].voteId+'> ' +
                                '<td>'+data[i].userName+'</td> ' +
                                '<td class="titleName" data-priv="'+data[i].viewPriv+'"><a href="javascript:;" style="color:#1772c0">'+data[i].subject+'</a></td> ' +
                                '<td>'+function(){
                                    if(data[i].anonymity==0){
                                        return "<fmt:message code="workflow.th.NotAllowed" />";
                                    }else{
                                        return '<fmt:message code="workflow.th.Allowed" />';
                                    }
                                }()+'</td> ' +
                                '<td>'+data[i].count +'  /  '+data[i].sum+'</td> ' +
                                '<td>'+data[i].sendTime+'</td> ' +
                                '<td>'+data[i].endDate+'</td> ' +
                                '<td> ' +
                                '<a href="javascript:;" class="result" data-priv="'+data[i].viewPriv+'" style="color:#1772c0"><fmt:message code="vote.th.ViewResults" /></a> ' +
                                '</td> ' +
                                '</tr>'
                        }
                        $('.list').html(str);
                        me.pageTwo(reg.totleNum,me.data.pageSize,me.data.page);
                    }
                })

            },
            pageTwo:function (totalData, pageSize,indexs) {
                var mes=this;
                $('#dbgz_page').pagination({
                    totalData: totalData,
                    showData: pageSize,
                    current:indexs,
                    jump: true,
                    coping: true,
                    homePage: '<fmt:message code="global.page.first" />',
                    endPage: '<fmt:message code="global.page.last" />',
                    prevContent: '<fmt:message code="global.page.pre" />',
                    nextContent: '<fmt:message code="global.page.next" />',
                    jumpBtn: '<fmt:message code="global.page.jump" />',
                    callback: function (index) {
                        mes.data.page=index.getCurrent();
                        mes.page();
                    }
                });
            }
        }
        ajaxPageLe.page();


        function init(){
            $.ajax({
                url:'/vote/manage/getVoteTitleCount',
                type:'get',
                dateType:'json',
                success:function(reg){
                    var data=reg.obj;
                    var str=""
                    for(var i=0;i<data.length;i++){
                        str+='<tr class="pagediv" id='+data[i].voteId+'> ' +
                            '<td>'+data[i].userName+'</td> ' +
                            '<td class="titleName" data-priv="'+data[i].viewPriv+'"><a href="javascript:;"  style="color:#1772c0">'+data[i].subject+'</a></td> ' +
                            '<td>'+data[i].anonymity+'</td> ' +
                            '<td>'+data[i].sendTime+'</td> ' +
                            '<td>'+data[i].endDate+'</td> ' +
                            '<td> ' +
                            '<a href="javascript:;" class="result" data-priv="'+data[i].viewPriv+'" style="color:#1772c0"><fmt:message code="vote.th.ViewResults" /></a> ' +
                            '</td> ' +
                            '</tr>'
                    }
                    $('.list').html(str);
                }
            })
        }

        //        点击标题
        $('.list').on('click','.titleName',function(){
            var sId=$(this).parent().attr('id');
            var piv = $(this).attr('data-priv');//0投票后查看结果，1投票前查看结果，2不允许查看结果
            if (piv == 2) {
                $.layerMsg({content: '<fmt:message code="vote.th.noSee" />', icon: 2})
                return ;
            }
            window.open ("/vote/manage/voteResult?resultId="+sId+"&type=0", "newwindow", "height=500, width=800, top=100, left=300, toolbar =no, menubar=no, scrollbars=no, resizable=no, location=no, status=no")
        })

        //        点击查看结果
        $('.list').on('click','.result',function(){
            var sId=$(this).parent().parent().attr('id');
            var piv = $(this).attr('data-priv');//0投票后查看结果，1投票前查看结果，2不允许查看结果

            if (piv == 2) {
                $.layerMsg({content: '<fmt:message code="vote.th.noSee" />', icon: 2})
                return ;
            }
            window.open ("/vote/manage/voteResult?resultId="+sId+"&type=0", "newwindow", "height=500, width=800, top=100, left=300, toolbar =no, menubar=no, scrollbars=no, resizable=no, location=no, status=no")
        })

    })



</script>
</body>


</html>
