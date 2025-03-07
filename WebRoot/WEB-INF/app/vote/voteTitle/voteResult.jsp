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
    <script src="../../js/news/page.js"></script>
    <script src="/lib/laydate/laydate.js"></script>
    <script src="/lib/layer/layer.js?20201106"></script>
    <script src="../../js/base/base.js" type="text/javascript" charset="utf-8"></script>
    <script src="../../lib/pagination/js/jquery.pagination.min.js" type="text/javascript" charset="utf-8"></script>
    <title><fmt:message code="vote.th.VotingResults" /></title>
    <style>
        .title span{
            font-size:22px;
            color:#494d59;
            padding-left:20px;
        }
        .title{
            margin-bottom:20px;
        }
        .tit{
            background-color: #D6E4EF;
            font-size: 15px;
            color: #2F5C8F;
            font-weight: bold;
            border: 0px;
            line-height:40px;
            text-align:center;
            border:1px solid #c0c0c0;
            margin-top:-1px;
        }
        .piao{
            text-align:right;
        }
        meter{
            width:150px;
        }
        .zhu{
            width:80%;
            height:10px;
            background:skyblue;
        }
        .closeWindow{
            width: 100%;
            margin: 20px 0;
            text-align: center;
        }
        .closeWindow .btnReturn{
            width: 70px;
            height:28px;
            line-height: 28px;
            margin: 0 auto;
            background: url("../../img/vote/return.png") no-repeat;
            cursor: pointer;
            display: inline-block;
        }
        .closeWindow .btnReturn span{
            margin-left: 26px;
            font-size: 14px;
        }
        .dao{
            width: 70px;
            height: 28px;
            line-height: 28px;
            margin: 0 auto;
            cursor: pointer;
            text-align: center;
            background-color: #1772c0;
            color: #fff;
            border-radius: 4px;
            display: inline-block;
        }
    </style>
</head>
<body style="overflow:scroll;overflow-y: auto;overflow-x:hidden;">

<%--学生信息列表--%>
<div style="margin-top:20px">
    <div class="title">
        <span><fmt:message code="vote.th.VotingResults" />-<span class="titleName"></span></span>
    </div>
    <div class="con">
        <p class="content"></p>
    </div>
</div>
<div>
    <div class="table">
        <ul class="list">

        </ul>
    </div>
</div>
<div class="closeWindow">
    <span class="btnReturn" id="btnReturn">
        <span><fmt:message code="notice.th.return" /></span>
    </span>
    <span class="dao" style="display: inline-block;">
        <span>export</span>
    </span>
</div>
</body>

<script type="text/javascript">
    $(function(){
        $.ajax({
            type:'get',
            url:'/syspara/selectTheSysPara?paraName=IS_SHOW_JMJ',
            dataType:'json',
            success:function (res) {
                if(res.object.length!=0){
                    var data=res.object[0]
                    if (data.paraValue!=0){
                        $('.title').before('<p style="color: red;font-family: Microsoft YaHei;font-weight: bolder;font-size: 16pt;margin-bottom: 20px;margin-left: 20px;"> 机密级★ </p>')
                    }
                }
            }
        })
//        获取id和标题
        var sId=$.GetRequest().resultId;
        var title=decodeURI($.GetRequest().title);
        var id="";
        var obj=""
        var anonymity=$.GetRequest().anonymity;//0不允许匿名1允许匿名

        function checkNum(name){
            var name1=''

            if(name.indexOf(',')>=0&&name.split(',').length==2){
                name1 = name.split(',')[0]
            }else{
                name1 = name
            }
            return name1
        }

        function checkNull(name){
            var res='';
            if (name){
                return name;
            }else {
                return res;
            }
        }

//        显示数据
        function init(){
            $.ajax({
                url:'/vote/manage/getVoteDataByVoteId',
                type:'get',
                data:{voteId:sId},
                dataType:'json',
                success:function(res){
                    var data=res.object;
                    var niming = data.anonymity;
                    var parent=data.voteItemList;
                    var child=data.voteTitleList;
                    var count=data.sum;
                    $('.titleName').html(data.subject);
                    $('.user').html(data.toId);
                    $('.time').html(data.sendTime);
                    if(anonymity==0) {
                        str = '  <li id="' + data.voteId + '" data-type="' + data.type + '"> ' +
                            '<div class="tit">' + data.subject + '</div> ' +
                            '<ul class="conn"><table>' + function () {
                                var str1 = "";

                                for (var i = 0; i < parent.length; i++) {
                                    if(data.type!=2){
                                        str1 += '<tr>' +
                                            '<td style="width:25%">' +
                                            function(){
                                            if (parent[i].itemName.indexOf("{textarea}")!= -1) {
                                                return parent[i].itemName.split("+")[0];
                                            }else {
                                                return parent[i].itemName;
                                            }
                                            }()
                                             + '</td>' +
                                            '<td style="width:30%">' +
                                            '<div class="zhu" style="' + function () {
                                                if (parent[i].voteCount == 0) {
                                                    return "width:0%"
                                                } else if (parent[i].voteCount / count == 1) {
                                                    return "width:86%"
                                                } else {
                                                    return "width:" + Math.round((parent[i].voteCount / count) * 100) + "%";
                                                }
                                            }() + ';display:inline-block"></div>' +
                                            '<span>' + function () {
                                                if (parent[i].voteCount == 0) {
                                                    return "0%"
                                                } else {
                                                    return Math.round((parent[i].voteCount / count) * 100) + "%"
                                                }
                                            }() + '</span>' +
                                            '</td>' +
                                            '<td style="width:15%">' + parent[i].voteCount + '<fmt:message code="vote.th.ticket" /></td>' +
                                            '<td style="width:30%">' + checkNum(parent[i].voteUserName) +
                                                function () {
                                                    if (parent[i].itemName.indexOf("{textarea}")!= -1){
                                                        return   '<td style="width:30%"><textarea  readonly="readonly">' + checkNull(parent[i].voteReason)+ '</textarea ></td>'
                                                    }else {
                                                        return   '<td style="width:30%"></td>'
                                                    }
                                                }() +'</td>' +
                                            '</tr>'
                                    }else{
                                        str1 += '<tr>' +
                                            '<td style="width:25%">' +
                                            function(){
                                                if (parent[i].itemName.indexOf("{textarea}")!= -1) {
                                                    return parent[i].itemName.split("+")[0];
                                                }else {
                                                    return parent[i].itemName;
                                                }
                                            }()
                                            + '</td>' +
                                            '<td style="width:30%"></td>' +
                                            '<td style="width:15%"></td>' +
                                            '<td style="width:30%">' + checkNum(parent[i].voteUserName) + '</td>' +
                                            '</tr>'
                                    }

                                }
                                return str1;
                            }() + '</table></ul> ' +
                            '</li>' + function () {
                                var str2 = "";
                                for (var i = 0; i < child.length; i++) {
                                    var item = child[i].voteItemList;
                                    var countNum = child[i].sum;
                                    console.log(child[i].type)
                                    if(child[i].type!=2){
                                        str2 += '  <li id="' + child[i].voteId + '" data-type="' + data.type + '"> ' +
                                            '<div class="tit">' + child[i].subject + '</div> ' +
                                            '<ul class="conn"><table>' + function () {
                                                var str3 = "";
                                                for (var i = 0; i < item.length; i++) {
                                                    str3 += '<tr>' +
                                                        '<td style="width:25%">' +
                                                        function(){
                                                            if (item[i].itemName.indexOf("{textarea}")!= -1) {
                                                                return item[i].itemName.split("+")[0];
                                                            }else {
                                                                return item[i].itemName;
                                                            }
                                                        }()
                                                        + '</td>' +
                                                        '<td style="width:30%">' +
                                                        '<div class="zhu" style="' + function () {
                                                            if (item[i].voteCount == 0) {
                                                                return "width:0%"
                                                            } else if (item[i].voteCount / countNum == 1) {
                                                                return "width:86%"
                                                            } else {
                                                                return "width:" + Math.round((item[i].voteCount / countNum) * 100) + "%";
                                                            }
                                                        }() + ';display:inline-block"></div>' +
                                                        '<span>' + function () {
                                                            if (item[i].voteCount == 0) {
                                                                return "0%"
                                                            } else {
                                                                return Math.round((item[i].voteCount / countNum) * 100) + "%"
                                                            }
                                                        }() + '</span>' +
                                                        '</td>' +
                                                        '<td style="width:15%">' + item[i].voteCount + '<fmt:message code="vote.th.ticket" /></td>' +
                                                        '<td style="width:30%">' + checkNum(item[i].voteUserName) +
                                                        function () {
                                                            if (item[i].itemName.indexOf("{textarea}")!= -1){
                                                                return   '<td style="width:30%"><textarea  readonly="readonly">' + checkNull(item[i].voteReason)+ '</textarea ></td>'
                                                            }else {
                                                                return   '<td style="width:30%"></td>'
                                                            }
                                                        }()+ '</td>' +
                                                        '</tr>'
                                                }
                                                return str3;
                                            }() + '</table></ul> ' +
                                            '</li>'
                                    }else{
                                        str2 += '  <li id="' + child[i].voteId + '" data-type="' + data.type + '"> ' +
                                            '<div class="tit">' + child[i].subject + '</div> ' +
                                            '<ul class="conn"><table>' + function () {
                                                var str3 = "";
                                                for (var i = 0; i < item.length; i++) {
                                                    str3 += '<tr>' +
                                                        '<td style="width:25%">' +
                                                        function(){
                                                            if (item[i].itemName.indexOf("{textarea}")!= -1) {
                                                                return item[i].itemName.split("+")[0];
                                                            }else {
                                                                return item[i].itemName;
                                                            }
                                                        }()
                                                        + '</td>' +
                                                        '<td style="width:30%"></td>' +
                                                        '<td style="width:15%"></td>' +
                                                        '<td style="width:30%">' + checkNum(item[i].voteUserName) + '</td>' +
                                                        '</tr>'
                                                }
                                                return str3;
                                            }() + '</table></ul> ' +
                                            '</li>'
                                    }

                                }
                                return str2;
                            }();
                    }else{
                        str = '  <li id="' + data.voteId + '" data-type="' + data.type + '"> ' +
                            '<div class="tit">' + data.subject + '</div> ' +
                            '<ul class="conn"><table>' + function () {
                                var str1 = "";

                                for (var i = 0; i < parent.length; i++) {
                                    if(data.type!=2){
                                        str1 += '<tr>' +
                                            '<td style="width:25%">' +
                                            function(){
                                                if (parent[i].itemName.indexOf("{textarea}")!= -1) {
                                                    return parent[i].itemName.split("+")[0];
                                                }else {
                                                    return parent[i].itemName;
                                                }
                                            }()
                                            + '</td>' +
                                            '<td style="width:30%">' +
                                            '<div class="zhu" style="' + function () {
                                                if (parent[i].voteCount == 0) {
                                                    return "width:0%"
                                                } else if (parent[i].voteCount / count == 1) {
                                                    return "width:86%"
                                                } else {
                                                    return "width:" + Math.round((parent[i].voteCount / count) * 100) + "%";
                                                }
                                            }() + ';display:inline-block"></div>' +
                                            '<span>' + function () {
                                                if (parent[i].voteCount == 0) {
                                                    return "0%"
                                                } else {
                                                    return Math.round((parent[i].voteCount / count) * 100) + "%"
                                                }
                                            }() + '</span>' +
                                            '</td>' +
                                            '<td style="width:15%">' + parent[i].voteCount + '<fmt:message code="vote.th.ticket" /></td>' +
                                            '<td style="width:30%">' +checkNum(parent[i].voteUserName)  +
                                            function () {
                                                if (parent[i].itemName.indexOf("{textarea}")!= -1){
                                                    return   '<td style="width:30%"><textarea  readonly="readonly">' + checkNull(parent[i].voteReason)+ '</textarea ></td>'
                                                }else {
                                                    return   '<td style="width:30%"></td>'
                                                }
                                            }()+ '</td>' +
                                            '</tr>'
                                    }else{
                                        str1 += '<tr>' +
                                            '<td style="width:25%">' +
                                            function(){
                                                if (parent[i].itemName.indexOf("{textarea}")!= -1) {
                                                    return parent[i].itemName.split("+")[0];
                                                }else {
                                                    return parent[i].itemName;
                                                }
                                            }()
                                            + '</td>' +
                                            '<td style="width:30%"></td>' +
                                            '<td style="width:15%"></td>' +
                                            '<td style="width:30%">' + checkNum(parent[i].voteUserName) + '</td>' +
                                            //                                        '<td style="width:30%">' + parent[i].voteUserName + '</td>' +
                                            '</tr>'
                                    }

                                }
                                return str1;
                            }() + '</table></ul> ' +
                            '</li>' + function () {
                                var str2 = "";
                                for (var i = 0; i < child.length; i++) {
                                    var type = child[i].type;

                                    var item = child[i].voteItemList;
                                    var countNum = child[i].sum;
                                    str2 += '  <li id="' + child[i].voteId + '" data-type="' + data.type + '"> ' +
                                        '<div class="tit">' + child[i].subject + '</div> ' +
                                        '<ul class="conn"><table>' + function () {
                                            var str3 = "";
                                            for (var i = 0; i < item.length; i++) {

                                                if(type!=2){
                                                    str3 += '<tr>' +
                                                        '<td style="width:25%">' +
                                                        function(){
                                                            if (item[i].itemName.indexOf("{textarea}")!= -1) {
                                                                return item[i].itemName.split("+")[0];
                                                            }else {
                                                                return item[i].itemName;
                                                            }
                                                        }()
                                                        + '</td>' +
                                                        '<td style="width:30%">' +
                                                        '<div class="zhu" style="' + function () {
                                                            if (item[i].voteCount == 0) {
                                                                return "width:0%"
                                                            } else if (item[i].voteCount / countNum == 1) {
                                                                return "width:86%"
                                                            } else {
                                                                return "width:" + Math.round((item[i].voteCount / countNum) * 100) + "%";
                                                            }
                                                        }() + ';display:inline-block"></div>' +
                                                        '<span>' + function () {
                                                            if (item[i].voteCount == 0) {
                                                                return "0%"
                                                            } else {
                                                                return Math.round((item[i].voteCount / countNum) * 100) + "%"
                                                            }
                                                        }() + '</span>' +
                                                        '</td>' +
                                                        '<td style="width:15%">' + item[i].voteCount + '<fmt:message code="vote.th.ticket" /></td>' +
                                                        '<td style="width:30%">' + checkNum(item[i].voteUserName) +
                                                        function () {
                                                            if (item[i].itemName.indexOf("{textarea}")!= -1){
                                                                return   '<td style="width:30%"><textarea  readonly="readonly">' + checkNull(item[i].voteReason)+ '</textarea ></td>'
                                                            }else {
                                                                return   '<td style="width:30%"></td>'
                                                            }
                                                        }()+ '</td>' +
                                                        '</tr>'
                                                }else{
                                                    str3 += '<tr>' +
                                                        '<td style="width:25%">' +
                                                        function(){
                                                            if (item[i].itemName.indexOf("{textarea}")!= -1) {
                                                                return item[i].itemName.split("+")[0];
                                                            }else {
                                                                return item[i].itemName;
                                                            }
                                                        }()
                                                        + '</td>' +
                                                        '<td style="width:30%"></td>' +
                                                        '<td style="width:15%"></td>' +
                                                        '<td style="width:30%">' + checkNum(item[i].voteUserName) + '</td>' +
                                                        //                                                    '<td style="width:30%">' + item[i].voteUserName + '</td>' +
                                                        '</tr>'
                                                }

                                            }
                                            return str3;
                                        }() + '</table></ul> ' +
                                        '</li>'
                                }
                                return str2;
                            }();
                    }
                    $('.list').html(str);
                }

            })
        }
        init()


        $('#btnReturn').on('click',function(){
            window.close();
        })

        $('.dao').on('click',function () {
            window.location.href="/vote/manage/getVoteDataByVoteId?export=1&voteId="+sId
        })


    })
</script>
</html>
