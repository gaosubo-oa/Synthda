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
    <link rel="stylesheet" href="/lib/layer/skin/default/layer.css">
    <link rel="stylesheet" href="/lib/pagination/style/pagination.css">
    <link rel="stylesheet" href="/lib/laydate/need/laydate.css">
    <link rel="stylesheet" href="/css/base.css">

<%--    <script type="text/javascript" src="../../js/xoajq/xoajq1.js"></script>--%>
    <script type="text/javascript" src="/js/xoajq/xoajq3.js"></script>
<%--    <script type="text/javascript" src="/js/jquery/jquery-migrate-3.4.0.js"></script>--%>
    <script src="../../js/news/page.js"></script>
    <script src="/lib/laydate/laydate.js"></script>
    <script src="/lib/layer/layer.js?20201106"></script>
    <script src="../../js/base/base.js" type="text/javascript" charset="utf-8"></script>
    <script src="../../lib/pagination/js/jquery.pagination.min.js" type="text/javascript" charset="utf-8"></script>
    <title><fmt:message code="main.votemanage" /></title>
    <style>
        .title span{
            font-size:22px;
            color:#494d59;
        }
        .title img{
            vertical-align: middle;
            padding-left:20px;
        }
        .title{
            margin-bottom:20px;
        }
        .btn{
            text-align:center;
        }
        button{
            width:50px;
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
        #newBtn{
            height: 30px;
            background: url(../../img/vote/save.png) no-repeat;
            color: #fff;
            width: 150px;
            margin-right:20px;
            cursor:pointer;
        }
        #back{
            display: inline-block;
            width: 78px;
            height: 30px;
            line-height: 30px;
            cursor: pointer;
            border-radius: 3px;
            background: url(../../img/vote/icon_back.png) no-repeat;
            padding-left: 7px;
            font-size: 14px;
        }
        td a{
            text-decoration:none;
        }

    </style>
</head>
<body style="overflow:scroll;overflow-y: auto;overflow-x:hidden;">

<%--学生信息列表--%>
<div>
    <div class="title" style="margin-top:20px">
       <%-- <img src="../../img/vote/child.png" alt="">--%>
        <span style="padding-left: 20px;"><fmt:message code="vote.th.Management" /></span>
    </div>
    <div style="float:right;margin:-50px 20px 0px 50px">
        <button id="back"><fmt:message code="notice.th.return" /></button>
    </div>
    <div class="btn" style="float:right;margin:-50px 80px 0px 0px;">
        <button id="newBtn"><fmt:message code="vote.th.NewCast" /></button>
    </div>

    <div class="table">
        <table>
            <thead>
                <tr>
                    <th style="width:70%"><fmt:message code="notice.th.title" /></th>
                    <th><fmt:message code="notice.th.type" /></th>
                    <th><fmt:message code="notice.th.operation" /></th>
                </tr>
            </thead>
            <tbody class="list">

            </tbody>
        </table>
    </div>
</div>
</body>

<script type="text/javascript">

    $(function(){
//        获取id
        function getCookie (key) {
            var arr=document.cookie.split('; ');
            for (var i = 0; i < arr.length; i++) {
                var arr2=arr[i].split('=');
                if(arr2[0]==key){
                    return arr2[1];
                }
            }
            return false;
        }
        var childId=getCookie('childId');

//        子投票列表
        function init(){
            $.ajax({
                url:'/vote/manage/getChildVoteList',
                type:'get',
                data:{voteId:childId},
                dataType:'json',
                success:function(reg){
                    var datas=reg.object;
                    var data=datas.voteTitleList;
                    console.log(data);
                    var str=""
                    for(var i=0;i<data.length;i++){
                        str+=' <tr> ' +
                            '<td><a href="javascript:;" style="color:#1772c0">'+data[i].subject+'</a></td> ' +
                            '<td>'+function () {
                                if(data[i].type==0){
                                    return "<fmt:message code="vote.th.Radio" />";
                                }else if(data[i].type==1){
                                    return "<fmt:message code="vote.th.Multiselect" />";
                                }else{
                                    return "<fmt:message code="vote.th.TextEntry" />";
                                }
                            }()+'</td> ' +
                            '<td id="'+data[i].voteId+'"> ' +
                            function(){
                            if(data[i].type == 2){
                                return ''
                            }else{
                                return '<a href="javascript:;" class="item"  style="color:#1772c0"><fmt:message code="vote.th.VotingItems" /></a> ';
                            }
                            }() +
                            '<a href="javascript:;" class="update"  style="color:#1772c0"><fmt:message code="menuSSetting.th.editMenu" /></a> ' +
                            '<a href="javascript:;" class="del"  style="color:#e01919"><fmt:message code="menuSSetting.th.deleteMenu" /></a> ' +
                            '</td> ' +
                            '</tr>';
                    }
                    $('.list').html(str);
                }
            })
        }
        init();
//        点击返回
        $('#back').on('click',function(){
            self.parent.document.getElementById("iframe").src='/vote/manage/voteList';
        })

//   点击新建子投票
        $('#newBtn').on('click',function () {
            self.parent.document.getElementById("iframe").src='/vote/manage/newChildVote?voteId='+childId;
        })

        //        点击投票项目
        $('.table').on('click','.item',function(){
            var sId=$(this).parent().attr('id');
            self.parent.document.getElementById("iframe").src='/vote/manage/updateVote?ItemId='+sId;
        })

//        点击修改
        $('.table').on('click','.update',function(){
            var sId=$(this).parent().attr('id');
            self.parent.document.getElementById("iframe").src='/vote/manage/editChildVote?childId='+sId;
        })

//        点击删除
        $('.table').on('click','.del',function(){
            var sId=$(this).parent().attr('id');
            layer.confirm(' <fmt:message  code="workflow.th.que"/>', {
                btn: [' <fmt:message  code="global.lang.ok"/>', ' <fmt:message  code="depatement.th.quxiao"/>'], //按钮
                title: " <fmt:message code="common.th.prompt" />"
            },function(){
                $.ajax({
                    url:'/vote/manage/deleteByVoteId',
                    type:'post',
                    data:{voteIds:sId},
                    dataType:'json',
                    success:function(reg){
                        layer.msg(' <fmt:message  code="workflow.th.delsucess"/>', {icon: 6});
                        init();
                    }
                })
            },function(){
                layer.closeAll();
            })

        })

    })

</script>
</html>
