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
    <title>通讯簿-个人资料</title>
    <meta http-equiv="X-UA-Compatible" content="IE=10,chrome=1">
    <meta http-equiv="Content-Type" content="text/html;">
    <meta name="viewport" content="width=device-width; initial-scale=1.0; maximum-scale=1.0; user-scalable=0;">
    <meta name="apple-mobile-web-app-capable" content="yes">
    <meta name="apple-mobile-web-app-status-bar-style" content="black">
    <link href='http://fonts.googleapis.com/css?family=Roboto+Condensed:300,400' rel='stylesheet' type='text/css'>
    <link href='http://fonts.googleapis.com/css?family=Lato:300,400,700,900' rel='stylesheet' type='text/css'>
    <!-- CSS Libs -->
    <link rel="stylesheet" type="text/css" href="/css/bootstrap.css">
    <link rel="stylesheet" type="text/css" href="https://cdn.bootcss.com/bootstrap-switch/4.0.0-alpha.1/css/bootstrap-switch.css">

    <script src="/js/xoajq/xoajq1.js"></script>
    <script type="text/javascript" src="/js/jquery/jquery.charfirst.pinyin.js"></script>
    <%--    <script type="text/javascript" src="/js/address/circle.js"></script>--%>
    <style>
        * {
            margin: 0;
            padding: 0;
        }
        body{
            font-size:16px;
            background-color: #F5F5F5;
        }
        .header{
            position: fixed;
            left: 0;
            top: 0;
            z-index: 99;
            width: 100%;
            height: 100px;
            height: 45px;
            line-height: 45px;
            background: #3c92e5;
            text-align: center;
        }
        .header p{
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
            padding-top: 4px;
            overflow: hidden;

        }
        [class^="sort_list"]{
            padding: 0px 60px 0px 69px;
            position: relative;
            line-height: 50px;
            border-bottom:1px solid #ddd;
        }

        [class^="sort_list"] .num_logo{
            width: 54px;
            height: 54px;
            border-radius: 38px;
            overflow: hidden;
            position: absolute;
            left: 25px;
            top: 20px;
        }

        [class^="sort_list"] .num_name{
            color: #000;
        }

        .sort_letter{
            height: 30px;
            line-height: 30px;
            padding-left: 20px;
            color:#787878;
            font-size: 14px;
            border-bottom:1px solid #ddd;
        }
        .initials{
            position: fixed;
            top: 119px;
            right: 6px;
            height: 100%;
            width: 15px;
            padding-right: 10px;
            text-align: center;
            font-size: 12px;
            z-index: 99;
            background: rgba(145,145,145,0);
        }
        .initials li{
            margin-left:-25px;

        }
        .initials li img{
            width: 14px;
        }
        .sort_letter{
            background: #eee;
        }
        .sort_box-two{
            padding-top: 86px;
        }


        .ibox{
            width: 95%;
            height: 90px;
            background-color:#ffffff;
            position: relative;
            margin: auto;
            top: 50px;
            z-index: 99999999999999;
        }

        [class^="sort_list"] .person{
            width: 300px;
            height: 50px;
            position: absolute;
            top: 20px;
            left: 107px;
        }
        .onebox {
            width: 95%;
            height: 46px;
            margin: 70px 0px 20px 0px;
            background-color:#ffffff;
            position: relative;
            margin-left: 2.5%;
        }
        .twobox{
            width: 95%;
            height: 172px;
            margin: 20px 0px 20px 0px;
            background-color:#ffffff;
            position: relative;
            margin-left: 2.5%;
        }
        .threebox{
            width: 95%;
            height: 88px;
            margin: 20px 0px 20px 0px;
            background-color:#ffffff;
            position: relative;
            margin-left: 2.5%;
        }
        [class^="onebox"] .sign{
            width: 100%;
            height: 35px;
            position: absolute;
            top: 10px;
            left: 20px;
        }


        [class^="twobox"] .sign{
            width: 100%;
            height: 30px;
            position: absolute;
            top: 10px;
            left: 20px;
        }

        [class^="threebox"] .sign{
            width: 100%;
            height: 30px;
            position: absolute;
            top: 10px;
            left: 20px;
        }


    </style>


</head>
<body>


<div class="header">
    <div>
        <p style="float: left;font-weight: bold" onclick="returnFn()" ><img  style="width: 35px;height: 35px;" src="../img/address/ic_title_back.png"  alt="" /></p>
        <p class="title">个人资料</p>
    </div>
</div>


<div class="ibox" >
<%--姓名和职位信息--%>
</div>

<div class="onebox">
<%--    工作签名--%>
</div>

<div class="twobox">

</div>

<div class="threebox">

</div>


</body>
</html>

<script>
    // 获取地址栏参数值
    function getQueryString(name){
        var reg = new RegExp("(^|&)"+ name +"=([^&]*)(&|$)");
        var r = window.location.search.substr(1).match(reg);
        if (r != null)
            //return unescape(r[2]);  // 会中文乱码
            return decodeURI(r[2]); // 解决了中文乱码
        return null;
    }

    var uid = getQueryString('uid');
    var newcolor = getQueryString('newcolor');
    var url = window.location.href;
    var locations = url.split('/ewx')[0]
    // var locations = window.location.protocol+"//"+window.location.port;//获取当前登录地址
    var tsex = getQueryString('tsex');
    var tname = getQueryString('tname');
    var tuserPrivName = getQueryString('tuserPrivName');
    var tavatar = getQueryString('tavatar');
    var starname =  tname.substr(0,1);//名字第一个字符;//获取名字的第一个字


    $(function(){
        $.ajax({
            url: '/user/findUserByuid',
            data: { uid: uid },
            dataType: 'json',
            type: 'get',
            success: function(res){
                var str = ""
                var str0 = ""
                var str1 = ""
                var str2 = ""
                if(tavatar != '' && tavatar != null  && tavatar != 0 && tavatar != 1 && tavatar != undefined && tavatar != "undefined"){
                    //有头像的时候
                    var newlocations = locations+'/img/user/'+tavatar
                    str += '<div class="sort_list" >\n' +
                            '        <div class="num_logo" >\n' +
                            '            <img src="'+newlocations+'"   alt="">\n' +
                            '        </div>\n' +
                            '        <div class="person" style="font-size: 10px;line-height: 50px;">\n'+
                            '           <div style="font-size: 10px;height: 25px;line-height: 25px; font-weight: bold">'+filterFn(tname)+' <img style="width: 20px;height: 20px;" src="'+function(){
                                if(tsex == 1){
                                    return '../img/address/womennew.png'
                                }else if(tsex == 0){
                                    return "../img/address/mannew.png";
                                }
                            }()+'" alt=""></div>\n'+
                            '           <div style="font-size: 10px;height: 25px;line-height: 25px;">'+filterFn(tuserPrivName)+'</div>\n'+
                            '        </div>\n' +
                            '    </div>'

                }else{
                    str += '<div class="sort_list" >\n' +
                            '        <div class="num_logo" style="line-height: 54px;height: 54px;">\n'+
                            '        <div  style="line-height: 54px;height: 54px;font-size: 20px;color: #fff; text-align: center;background-color: '+newcolor+'">' +starname+ '</div>\n' +
                            '</div>\n' +
                            '        <div class="person" style="font-size: 10px;line-height: 50px;">\n'+
                            '           <div style="font-size: 10px;height: 25px;line-height: 25px; font-weight: bold">'+filterFn(tname)+' <img style="width: 20px;height: 20px;" src="'+function(){
                                if(tsex == 1){
                                    return '../img/address/womennew.png'
                                }else if(tsex == 0){
                                    return "../img/address/mannew.png";
                                }
                            }()+'" alt=""></div>\n'+
                            '           <div style="font-size: 10px;height: 25px;line-height: 25px;">'+filterFn(tuserPrivName)+'</div>\n'+
                            '        </div>\n' +
                            '    </div>'

                }

                if(res.flag && res.object != undefined && res.object != "undefined" ){
                    var data = res.object;

                    str0 += '<div class="sign">\n' +
                        '           <div style="font-size: 10px;height: 35px;line-height: 35px;margin-bottom: 6px; font-weight: bold; border-bottom:1px solid #F5F5F5;">工作签名 &nbsp;&nbsp;'+' '+filterFn(data.myStatus)+'</div>\n'+
                        '    </div>'

                    str1 += '<div class="sign">\n' +
                        '           <div style="font-size: 10px;height: 35px;line-height: 35px;margin-bottom: 6px; font-weight: bold; border-bottom:1px solid #F5F5F5;">办公电话 &nbsp;&nbsp;'+' '+filterFn(data.telNoDept)+'</div>\n'+
                        '           <div style="font-size: 10px;height: 35px;line-height: 35px;margin-bottom: 6px; font-weight: bold; border-bottom:1px solid #F5F5F5;">移动电话 &nbsp;&nbsp;'+' '+filterFn(data.mobilNo)+'</div>\n'+
                        '           <div style="font-size: 10px;height: 35px;line-height: 35px;margin-bottom: 6px; font-weight: bold; border-bottom:1px solid #F5F5F5;">邮箱 &nbsp;&nbsp;&nbsp;&nbsp;'+' '+filterFn(data.email)+'</div>\n'+
                        '           <div style="font-size: 10px;height: 35px;line-height: 35px;margin-bottom: 6px; font-weight: bold; border-bottom:1px solid #F5F5F5;">QQ &nbsp;&nbsp;&nbsp;&nbsp;'+' '+filterFn(data.oicqNo)+'</div>\n'+
                        '    </div>'

                    str2 += '<div class="sign">\n' +
                        '           <div style="font-size: 10px;height: 35px;line-height: 35px;margin-bottom: 6px; font-weight: bold; border-bottom:1px solid #F5F5F5;">部门 &nbsp;&nbsp;&nbsp;&nbsp;'+' '+filterFn(data.deptName)+'</div>\n'+
                        '           <div style="font-size: 10px;height: 35px;line-height: 35px;margin-bottom: 6px; font-weight: bold; border-bottom:1px solid #F5F5F5;">生日 &nbsp;&nbsp;&nbsp;&nbsp;'+' '+filterFn(data.birthday)+'</div>\n'+
                        '    </div>'
                }else if( res.object == undefined || res.object == "undefined" ||  res.object == '' ){

                    str0 += '<div class="sign">\n' +
                        '           <div style="font-size: 10px;height: 35px;line-height: 35px;margin-bottom: 6px; font-weight: bold; border-bottom:1px solid #F5F5F5;">工作签名 &nbsp;&nbsp;</div>\n'+
                        '    </div>'

                    str1 += '<div class="sign">\n' +
                        '           <div style="font-size: 10px;height: 35px;line-height: 35px;margin-bottom: 6px; font-weight: bold; border-bottom:1px solid #F5F5F5;">办公电话 &nbsp;&nbsp; </div>\n'+
                        '           <div style="font-size: 10px;height: 35px;line-height: 35px;margin-bottom: 6px; font-weight: bold; border-bottom:1px solid #F5F5F5;">移动电话 &nbsp;&nbsp;</div>\n'+
                        '           <div style="font-size: 10px;height: 35px;line-height: 35px;margin-bottom: 6px; font-weight: bold; border-bottom:1px solid #F5F5F5;">邮箱 &nbsp;&nbsp;&nbsp;&nbsp;</div>\n'+
                        '           <div style="font-size: 10px;height: 35px;line-height: 35px;margin-bottom: 6px; font-weight: bold; border-bottom:1px solid #F5F5F5;">QQ &nbsp;&nbsp;&nbsp;&nbsp;</div>\n'+
                        '    </div>'

                    str2 += '<div class="sign">\n' +
                        '           <div style="font-size: 10px;height: 35px;line-height: 35px;margin-bottom: 6px; font-weight: bold; border-bottom:1px solid #F5F5F5;">部门 &nbsp;&nbsp;&nbsp;&nbsp;</div>\n'+
                        '           <div style="font-size: 10px;height: 35px;line-height: 35px;margin-bottom: 6px; font-weight: bold; border-bottom:1px solid #F5F5F5;">生日 &nbsp;&nbsp;&nbsp;&nbsp;</div>\n'+
                        '    </div>'
                }

                    $('.ibox').html(str)
                    $('.onebox').html(str0)
                    $('.twobox').html(str1)
                    $('.threebox').html(str2)
                    var Initials=$('.initials');
                    var LetterBox=$('#letter');


                    var windowHeight=$(window).height();
                    var InitHeight=windowHeight-100;
                    Initials.height(InitHeight);
                    var LiHeight=InitHeight/28;
                    Initials.find('li').height(LiHeight);

                }
            })


        window.onresize=function(){
            if($(window).height()<400){
                $('.nav').hide();
            }else{
                $('.nav').show();
            }

        }
    })

    function filterFn(a){
        if(a != '' && a != 'undefined'  && a != undefined ){
            return  a;
        }else{
            return '';
        }
    }

    function returnFn() {
        window.history.back(-1);
    }

</script>
