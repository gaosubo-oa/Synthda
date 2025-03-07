<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2018/4/9/009
  Time: 11:22
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String openId = (String)request.getAttribute("openId");
%>
<html>
<head>
    <meta charset="utf-8">
    <title>OA系统登录</title>
    <link rel="stylesheet" type="text/css" href="../css/base.css">
    <link rel="stylesheet" href="../../lib/mui/mui/mui.min.css"/>
    <script type="text/javascript" src="../../lib/mui/mui/mui.min.js" ></script>
    <script type="text/javascript" src="../../js/jquery/jquery.min.js"></script>
    <script type="text/javascript" src="../../js/jquery/jquery.cookie.js"></script>

    <style>
        body{
            background:url('/img/logOn/background_img.png');
            background-size:100% 100%;
            background-repeat:no-repeat ;
        }
        .logo{
            width: 100%;
            height: 1.8rem;
            margin: 30% auto;
            text-align: center;
        }
        .login div,input{
            width:80%;
            height:0.8rem;
            border-radius: 50px;
            font-size: 0.3rem;
        }
        .login,.password,.accountNumber{
            margin: 0 auto;
            text-align: center;
            margin-bottom:0.4rem;
        }
        .login div{
            background: #fff;
            font-size: 0.3rem;
            color:#3c92e5;
            margin:0 auto;
            line-height: 0.8rem;
            width:80%;
        }

        .password,.accountNumber{
            position: relative;

        }
        span{
           display: inline-block;
        }
        .icon{
            position: absolute;
            margin-left:0.2rem;
            top:0.1rem
        }
        .mui-popup-title{
            font-size: 0.3rem;
            height:0.4rem;
        }
        .mui-popup-title+.mui-popup-text{
            font-size: 0.23rem;
            height:0.3rem;
        }
        .mui-popup-buttons{
            height:70px;
        }
        .mui-popup-button{
            height:70px;
            font-size: 0.24rem;
            line-height: 70px;
        }
        .mui-popup{
            width:3rem;
        }
        .form{
            position: relative;
        }
        .title{
            position: absolute;
            left: 1.3rem;
            top: -1rem;
        }
        .title p{
            font-size:0.5rem;
            color:#fff;
            text-align: center;
        }
        .icon img{
            width: .4rem;
            height: .4rem;
            position: relative;
            left: .1rem;
            top: .08rem;
        }
        input{
            caret-color:#000;
        }
        input::-ms-input-placeholder{color: #fff;height: 0.42em;line-height: .37rem;}
        input::-webkit-input-placeholder{color: #fff;height: 0.42rem;line-height: .37rem}
    </style>
</head>
<script>
    var fs = document.documentElement.clientWidth / 750  * 100;
    document.querySelector("html").style.fontSize = fs + "px";
</script>
<body>
<form action="" class="form">
    <div class="title">
        <p>厦门市海沧区芸美小学</p>
    </div>
    <div class="logo">
        <img src="/img/logOn/logo_icon.png" alt="">
    </div>
    <div class="accountNumber">
        <span class="icon">
            <img src="/img/logOn/accountNumber.png" alt="">
        </span>
        <input type="text" placeholder="请输入OA账号" class="username" style="padding-left:0.9rem;
            background-color: #43a9fe;
            border:1px solid #fff;
            border-radius: 50px;
            height:0.8rem;color: #fff;
            width:80%;">
    </div>
    <div class="password">
        <span class="icon">
            <img src="/img/logOn/password.png" alt="">
        </span>
        <input type="password" placeholder="请输入密码" class="mima" style="padding-left:0.9rem;
            background-color: #43a9fe;
            border:1px solid #fff;
            border-radius: 50px;color: #fff;
            height:0.8rem;
            width:80%;">
    </div>
    <div class="login">
        <div style="font-weight: bold">登录</div>
    </div>
    <div class="info"></div>
</form>
<script>
    jQuery(function(){
        var username = $.cookie('username');
        var password = $.cookie('password');
        $('.username').val(username);
        $('.mima').val(password);
    });

    var openId = <%=openId%>;
    $(function(){
        $('.login div').click(function(){
            //console.log('123')
            $.ajax({
                url:'/login',
                type:'get',
                data:{
                    username:$('.username').val(),
                    password:$('.password input').val(),
                    loginId:'1001',
                    userAgent:'mobile'
                },
                dataType:'json',
                success:function(res){
                    if(res.flag==true){
                        location.href='/m/getMainddh5?openId='+openId
                    }else{
                        mui.alert(res.msg,'提示','确认')
                    }
                }
            })
            var uName =$('.username').val();
            var psw = $('.mima').val();
                $.cookie('username',uName, {expires:7,path:'/'});
                $.cookie('password',psw, {expires:7,path:'/'});
        });
    })
</script>
</body>
</html>
