<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@taglib prefix="mvc" uri="http://www.springframework.org/tags/form" %>
<%@taglib prefix="fmt" uri="http://www.springframework.org/tags" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>通讯簿</title>
    <meta http-equiv="X-UA-Compatible" content="IE=10,chrome=1">
    <meta http-equiv="Content-Type" content="text/html;">
    <meta name="viewport" content="width=device-width; initial-scale=1.0; maximum-scale=1.0; user-scalable=0;">
    <meta name="apple-mobile-web-app-capable" content="yes">
    <meta name="apple-mobile-web-app-status-bar-style" content="black">
    <!-- CSS Libs -->
    <link rel="stylesheet" type="text/css" href="/css/bootstrap.css">

    <script src="/js/xoajq/xoajq1.js"></script>
    <script type="text/javascript" src="/js/jquery/jquery.charfirst.pinyin.js"></script>
    <style>
        * {
            margin: 0;
            padding: 0;
        }
        body{
            font-size:16px;
        }
        .header{
            position: fixed;
            left: 0;
            top: 0;
            z-index: 99;
            width: 100%;
            height: 45px;
            line-height: 45px;
            background: #3c92e5;
            text-align: center;
        }
        .header p{
            float: left;
            margin-left: 30%;
            font-family: Microsoft yahei,Helvetica Neue,Helvetica,PingFang SC,Tahoma,Arial,sans-serif;
            height: 45px;
            line-height: 45px;
            color: #fff;
            font-size: 18px;
            display:inline-block;
        }
        .header span{
            color:#fff;
            margin-right: 20px;
            float: right;
            line-height: 45px;
        }
        .content{
            margin-top:45px;
        }
        .nav{
            background-color: #fff;
        }

        .header-two{
            position: fixed;
            top: 45px;
            left:0px;
            /*padding-top:45px;*/
            z-index: 99999;
            width: 100%;
            height: 45px;
            background: #fff;
        }
        .header-two p{
            margin-left:20px;
            height: 45px;
            line-height: 45px;
            color: #fff;
            font-size: 18px;
            display:inline-block;
        }
        .header-two span{
            color:#fff;
            margin-left:6px;
            line-height: 45px;
        }
        .header-two i{
            color:#fff;
            margin-left: 20px;
            line-height: 45px;
        }
        .header-two input{
            border:none;

            width:92%;
            background-color:transparent;
        }
        .sort_box-two{
            display:block;
        }
        .input{
            display: inline-block;
            height: 42px;
            width: 100%;
        }
        #search{
            height: 25px;
            margin-top: 6px;
            border:1px solid #3c92e5;
            font-size:11pt;
        }
        ul li{list-style: none;}
        a{text-decoration: none;cursor: pointer;}
        html{height: 100%;}
        a,input,img,textarea,span,div{outline: 0;-webkit-tap-highlight-color:rgba(255,0,0,0);}

        #letter{
            width: 100px;
            height: 100px;
            border-radius: 5px;
            font-size: 75px;
            color: #555;
            text-align: center;
            line-height: 100px;
            background: rgba(145,145,145,0.6);
            position: fixed;
            left: 50%;
            top: 50%;
            margin:-50px 0px 0px -50px;
            z-index: 99;
            display: none;
        }
        #letter img{
            width: 50px;
            height: 50px;
            float: left;
            margin:25px 0px 0px 25px;
        }
        [class^="sort_box"]{
            width: 100%;
            padding-top: 60px;
            overflow: hidden;

        }
        [class^="sort_list"]{
            padding: 0px 60px 0px 69px;
            position: relative;
            line-height: 50px;
            border-bottom:1px solid #ddd;
        }

        [class^="sort_list"] .num_logo{
            width: 30px;
            height: 50px;
            border-radius: 10px;
            overflow: hidden;
            position: absolute;
            left: 20px;
        }
        [class^="sort_list"] .num_logo2{
            width: 30px;
            height: 50px;
            border-radius: 10px;
            overflow: hidden;
            position: absolute;
            right: 10px;
            top: 0px;
        }

        [class^="sort_list"] .num_name{
            color: #000;
        }
        .sort_box-two{
            padding-top: 40px;
        }
        .layLoad {
            display: block;
            position: fixed;
            left: 50%;
            top: 50%;
            background-color: rgba(0,0,0,.6);
            color: #fff;
            border: none;
            width: 274px;
            margin-left: -137px;
            margin-top: -24px;
            z-index: 99999999;
        }
        .layLoad div {
            padding: 12px 25px;
            text-align: center;
            line-height: 24px;
            word-break: break-all;
            overflow: hidden;
            font-size: 14px;
            overflow-x: hidden;
            overflow-y: auto;
        }
        .sort_box{
            display: none;
        }
    </style>

</head>
<body>
    <div class="layLoad"><div>正在加载数据，请稍侯...</div></div>
    <div class="header">
        <a style="display: inline-block;padding: 0 13px;font-style: normal;color: #fff;font-size: 18px; float: left" onclick="returnFn()" >返回</a>
        <p class="title">通讯簿</p>
    </div>
    <div class="header-two">
        <div class="input" id="search2" style="text-align: center;margin: 0 auto;line-height:45px;">
            <input id="search" type="text" placeholder="请输入关键字智能搜索"/>
        </div>
    </div>
    <div class="sort_box-two">

    </div>
    <div class="sort_box">
    </div>
</body>
</html>

<script>
    var type = location.href.indexOf('&type=EWC');
    if(type != -1){
        $('.title').text('选择人员')
    }
    $(function(){
        $.ajax({
            url:'/getChDeptBai',
            data:{deptId: ''},
            dataType:'json',
            type:'get',
            success:function(res){
                $('.sort_box').show();
                if(res.flag&&res.obj.length>0){
                    var data = res.obj;
                    var str = ""
                    for(var i =0;i<data.length;i++){
                        str += '<div class="sort_list" uid="'+data[i].deptId+'"  uname= "'+data[i].deptName+'" onclick="childFn($(this))">\n' +
                            '        <div class="num_logo">\n' +
                            '            <img src="../img/address/organ_deptMent@2x.png"  alt="">\n' +
                            '        </div>\n' +
                            '        <div class="num_name">'+data[i].deptName+'</div>\n' +
                            '        <div class="num_logo2">\n' +
                            '            <img src="../img/attend/icon_behand_18.png"  alt="">\n' +
                            '        </div>\n' +
                            '    </div>'
                    }
                    $('.sort_box').html(str)
                    var Initials=$('.initials');
                    var LetterBox=$('#letter');


                    var windowHeight=$(window).height();
                    var InitHeight=windowHeight-100;
                    Initials.height(InitHeight);
                    var LiHeight=InitHeight/28;
                    Initials.find('li').height(LiHeight);

                }
                $('.layLoad').hide();

            }
        })

        window.onresize=function(){
            if($(window).height()<400){
                $('.nav').hide();
            }else{
                $('.nav').show();
            }
        }

        // $('.header-two').css('display','block')

    })

    function childFn(that) {
        var uid =that.attr("uid")
        var uname =that.attr("uname")
        if(type == '-1'){
            window.location.href = "/ewx/deptPerson?deptId="+uid+"&uname="+uname
        }else{
            window.location.href = "/ewx/deptPerson?deptId="+uid+"&uname="+uname+"&type=EWC"
        }

    }

    function returnFn() {
        if(type == '-1'){
            window.location.href ="/ewx/index"
        }else{
            var index = parent.layer.getFrameIndex(window.name);// 获取当前弹窗的Id
            parent.layer.close(index);
        }
    }
    $('#search2').click(function () {
       if(type == '-1'){
            window.location.href ="/ewx/addressBookSearch"
        }else{
           // 自由流程选人页面效果
            window.location.href ="/ewx/addressBookSearch?type=EWC"
        }
    })

</script>
