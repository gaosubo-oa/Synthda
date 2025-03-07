<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@taglib prefix="mvc" uri="http://www.springframework.org/tags/form" %>
<%@taglib prefix="fmt" uri="http://www.springframework.org/tags" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<html><head>
    <meta charset="UTF-8">
    <title>请求添加你为好友</title>
    <link rel="stylesheet" type="text/css" href="../lib/laydate.css"/>
    <script src="../js/xoajq/xoajq1.js" type="text/javascript" charset="utf-8"></script>
    <script src="../js/base/base.js" type="text/javascript" charset="utf-8"></script>
    <script src="/lib/layer/layer.js?20201106" type="text/javascript" charset="utf-8"></script>
    <script src="../lib/laydate.js" type="text/javascript" charset="utf-8"></script>
    <script src="../js/attachment/attachView.js?20210406.1" type="text/javascript" charset="utf-8"></script>
    <script type="text/javascript" src="/lib/starRating/js/star.js" charset="utf-8"></script>
    <style type="text/css">
        body {
            padding: 0;
            margin: 0;
            font-family: Microsoft yahei,Helvetica Neue,Helvetica,PingFang SC,Tahoma,Arial,sans-serif;
            width: 100%;
        }
        a{
            text-decoration: none;
        }
        .detailsContent {
            width: 90%;
            overflow: hidden;
            margin: 0 auto;
        }

        .detailsContent .title {
            display: none;
            width: 100%;
            text-align: left;
            line-height: 60px;
            color: #2a588c;
            font-size: 20px;
            font-weight: bold;
        }
        .divContent {
            margin-top: 60px;
            width: 100%;
        }
        .divTxt p {
            font-size: 14px;
            color: #444;
            line-height: 25px;
            margin-left: 20px;
        }
        .divContent .keyWord {
            margin: 0 0 10px 50px;
        }
        .divContent .keyWord span {
            margin-right: 10px;
            color: #2b7fe0;
        }
        .Table{
            width: 100%;
            table-layout: fixed;
        }
        .Table tr td{
            font-size: 14px;
            padding: 20px 10px 10px 20px;
        }
        .button_query {
            color: #FFF;
            font-size: 14px;
            width: 50px;
            height: 28px;
            line-height: 28px;
            background-color: rgb(0, 162, 212);
            display: inline-block;
            text-align: center;
            border-radius: 3px;
            margin-left: 10px;
            float: left;
        }
        #closeBtn{
            background-color: #f8f8f8;
            color:#666;
            border:#ccc 1px solid;
        }
        #deleteBtn {
            background-color: #dd6161;
            color: #fff;
            border: #c73d3d;
        }
        #chandReadBtn{
            color: #fff;
            border: #c73d3d;
        }
        #editBtn{
            border:#0093c1;
        }
        .btn{
            width: 252px;
            position: fixed;
            bottom: 5%;
            right: 5%;
        }
        .commentArea{
            width: 100%;
        }
        ul,li{
            list-style: none;
            margin: 0;
            padding: 0;
        }
        .stararea{
            display: inline;
            float: left;
            width: 260px;
            margin-left: 80px;
        }
        .stararea .pltitle {
            font-size: 11pt;
            float: left;
            line-height: 25px;
            display: inline-block;
            color: #686868;
            font-weight: bold;
        }
        .txtComment{
            width: 100%;
            margin: 10px 0;
        }
        .txtComment textarea{
            width: 100%;
            border-radius: 5px;
        }
        .tijiaoBtn{
            width: 50px;
            height: 28px;
            border-radius: 4px;
            background: #4b8cf7;
            color: #ffffff;
            float: right;
            line-height: 28px;
            text-align: center;
            font-size: 11pt;
            cursor: pointer;
        }
        .pingjiaBox{
            padding: 10px;
            border: #ccc 1px solid;
        }
        .rating{
            float: left;
            position:relative;
            width:100px !important;
            height: 24px;
            background:url(/lib/starRating/images/star.png) repeat-x;
        }
        .rating-disply{
            width:24px;
            height:45px;
            background-position:0 -22px;
            background:url(/lib/starRating/images/star.png) repeat-x 0 -26px;

        }
        .rating-mask{
            position:absolute;
            left:0;
            top:0;
            width:100%;
        }
        .rating-item{
            list-style: none;
            float: left;
            width:24px;
            height:45px;
            cursor:pointer;
        }
        .pingjun{
            display: inline-block;
            position: relative;
            width:100px;
            height: 24px;
            background:url(/lib/starRating/images/star.png) repeat-x;
        }
        .pjdefen{
            width: 0px;
            height: 45px;
            background-position:0 -22px;
            background:url(/lib/starRating/images/star.png) repeat-x 0 -26px;
        }
        /*该条数据已被删除*/
        .noData .bgImg {
            width: 360px;
            height: 150px;
            margin: 100px auto;
            background-color: #357ece;
            border-radius: 10px;
            box-shadow: 3px 3px 3px #2F5C8F;
            overflow: hidden;
            text-align: center;
        }
        .noData .bgImg .IMG {
            float: left;
            width: 75px;
            height: 75px;
            margin-top: 37px;
            margin-left: 30px;
        }
        .noData .bgImg .TXT {
            float: left;
            color: #fff;
            font-size: 16pt;
            margin-top: 60px;
            margin-left: 20px;
        }
    </style>
</head>
<body style="overflow: hidden;">
<div class="outMain" style="height: 100%;overflow-y: auto;">
    <div class="detailsContent">
        <div class="title">2018年8月21日</div>
        <div class="divContent">
            <div id="userAvatar" style="width: 70px;float:  left;height: 65px;">

            </div>
            <div class="divTxt" style="width:  80%;float:  left;font-size: 13px;">
                <span id="username" style="display:  block;margin-bottom: 15px;font-size: 16px;font-weight: 900;color: #333;"></span>
                <span style="color: #666;">附加消息:</span>
                <span id="message" style="color: #000;margin-left: 10px;"></span>
            </div>
        </div>
        <div class="btn">
            <a href="javascript:;" id="sure" class="button_query" style="display: block;">同意</a>
            <a href="javascript:;" id="deleteBtn" class="button_query" style="display: block;">不同意</a>
        </div>

    </div>
</div>

<script>

    function imgerror(e,opt){
        if(opt){
            var url = '';
            switch (opt){
                case 1://头像
                    url=domain+'/img/email/icon_head_man_06.png';
                    break;
                case 2://logo
                    url='';
                    break;
                default:

            }
        }
        $(e).attr('src',url);
    }
    $(function(){

        $.ajax({
            type: "get",
            url: "/imfriends/geImfriendsById?frdId="+$.getQueryString("frdId"),
            dataType: 'JSON',
            success: function (res) {
                var data = res.object;
                if(data.avatar == '0'){
                    var src =  '/img/email/icon_head_man_06.png'
                }else if(data.avatar == '1'){
                    var src =  '/img/email/icon_head_woman_06.png'
                }else if(data.avatar == ''){
                    var src =  '/img/email/icon_head_man_06.png'
                }else{
                    var src =  '/img/user/'+data.avatar
                }
                var src = '';
                $('#userAvatar').html('<img src="'+ src +'" style="width: 87%;" onerror="imgerror(this,1)">');
                $('#username').html(data.userName);
                $('#message').html(data.message);
            }
        });

        $('#sure').click(function(){
            $.ajax({
                type: "get",
                url: "/imfriends/updatePass?frdId="+$.getQueryString("frdId"),
                data:{
                    pass:1
                },
                dataType: 'JSON',
                success: function (res) {
                    window.close();
                    if(parent.opener.openRold!=undefined){
                        parent.opener.openRold()
                    }
                }
            });
        })
        $('#deleteBtn').click(function(){
            $.ajax({
                type: "get",
                url: "/imfriends/updatePass?frdId="+$.getQueryString("frdId"),
                data:{
                    pass:2
                },
                dataType: 'JSON',
                success: function (res) {
                    window.close();
                    if(parent.opener.openRold!=undefined){
                        parent.opener.openRold()
                    }
                }
            });
        })
    })
</script>
</body></html>

