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
    <!-- <meta name="viewport" content="width=device-width, initial-scale=1.0"> -->
    <link rel="stylesheet" type="text/css" href="../../lib/ueditor/laydate.css"/>
    <link rel="stylesheet" type="text/css" href="../../css/dept/deptManagement.css"/>
    <link rel="stylesheet" type="text/css" href="../../lib/easyui/themes/easyui.css"/>
    <link rel="stylesheet" type="text/css" href="../../lib/easyui/themes/icon.css"/>
    <link rel="stylesheet" type="text/css" href="../../css/base.css"/>
    <link rel="stylesheet" type="text/css" href="../../css/news/center.css"/>
    <link rel="stylesheet" href="/lib/layer/skin/default/layer.css">
    <link rel="stylesheet" type="text/css" href="../../lib/laydate.css"/>
    <link rel="stylesheet" type="text/css" href="../../css/dept/new_news.css"/>
    <script type="text/javascript" src="../../js/xoajq/xoajq1.js"></script>
    <script type="text/javascript" src="../../js/base/base.js"></script>
    <script src="../../lib/laydate/laydate.js"></script>
    <script src="/lib/layer/layer.js?20201106"></script>
    <script src="../../js/base/base.js" type="text/javascript" charset="utf-8"></script>
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
        }
    </style>
</head>
<body style="overflow:scroll;overflow-y: auto;overflow-x:hidden;">

<%--管理已发布的投票--%>

<div class="content" style="width:100%;height:100%">
    <div class="title">
        <span ><fmt:message code="vote.th.Published" /></span>
    </div>
    <div class="table">
        <table>
            <thead>
            <tr>
                <th><fmt:message code="notice.th.publisher" /></th>
                <th><fmt:message code="notice.th.title" /></th>
                <th><fmt:message code="vote.th.anonymous" /></th>
                <th><fmt:message code="notice.th.effectivedate" /></th>
                <th><fmt:message code="notice.th.endDate" /></th>
                <th><fmt:message code="notice.th.operation" /></th>
            </tr>
            </thead>
            <tbody class="list">

            </tbody>
        </table>
    </div>
</div>
<script type="text/javascript">

    //点击查询后，查询列表展示
    $(function () {

//        管理投票查询列表
        function init(){
            $.ajax({
                url:'/vote/manage/getVoteTitleList',
                type:'get',
                dataType:'json',
                success:function(reg){
                    var datas=reg.obj;
                    var str="";
                    for(var i=0;i<datas.length;i++){
                        str+='<tr class="pagediv" id='+datas[i].voteId+'> ' +
                            '<td>'+datas[i].userName+'</td> ' +
                            '<td>'+datas[i].subject+'</td> ' +
                            '<td>'+datas[i].anonymity+'</td> ' +
                            '<td>'+datas[i].sendTime+'</td> ' +
                            '<td>'+datas[i].endDate+'</td> ' +
                            '<td></td> ' +
                            '<td class="parent" id="'+datas[i].voteId+'"> ' +
                            '<a class="seeResult" href="javascript:;"><fmt:message code="vote.th.ViewResults" /></a> ' +
                            '</td> ' +
                            '</tr>'
                    }
                    $('.list').append(str);
                }
            })
        }
        init();
//   子投票点击
        $('.list').on('click','.children',function(){
            var sId=$(this).parent().attr('id');
            self.parent.document.getElementById("iframe").src='/vote/manage/voteChild';
            document.cookie="childId="+sId;
        })
//   投票项目
        $('.list').on('click','.item',function(){
            self.parent.document.getElementById("iframe").src='/vote/manage/updateVote';
        })
//        点击修改
        $('.list').on('click','.editd',function(){
            self.parent.document.getElementById("iframe").src='/vote/manage/editVote';
        })
//        点击全选
        $('#allChoose').click(function(){
            var state=$(this).prop('checked');
            if(state == true){
                $(this).prop('checked',true);
                $('.childCheck').prop('checked',true);
            }else{
                $(this).prop('checked',false);
                $('.childCheck').prop('checked',false);
            }
        })
//        点击删除
        $('#del').click(function(){
            var checkL=$('.childCheck:checkbox:checked').length;
//            console.log(checkL);
            if(checkL != 0){
                $('.childCheck:checkbox:checked').each(function(){
                    if(this.checked){
                        var sId=$(this).parent().parent().attr('id');
                        $.ajax({
                            url:'/vote/manage/deleteByVoteId',
                            type:'post',
                            dataType:'json',
                            data:{voteId:sId},
                            success:function(){
                                layer.msg(' <fmt:message  code="workflow.th.delsucess"/>', {icon: 6});
                                window.location.reload();
                            }
                        })
                    }
                })
            }
        })

//        点击全部删除
        $('#allDel').click(function(){

        })

    })



</script>
</body>


</html>
