<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!doctype html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport"
          content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <script type="text/javascript" src="../js/xoajq/xoajq1.11.1.js"></script>
    <script type="text/javascript" src="../js/jquery/jquery.min.js"></script>
    <script type="text/javascript" src="../js/spirit/qwebchannel.js"></script>
    <title>群组面板</title>
    <style>
        *{
            padding: 0;
            margin: 0;
            font-family: Microsoft yahei,Helvetica Neue,Helvetica,PingFang SC,Tahoma,Arial,sans-serif;
        }
        span{
            font-size:14px;
            color: #666666;
        }
        ul, ol ,li{
            list-style: none;
        }
        /*******************headBOX*******************************/
        #head{

            height:30px;
            background-color: #ececec;
            padding: 0 10px;
            border-bottom: 1px solid #fefeff;
        }
        .head_title{
            display: inline-block;
            height: 30px;
            line-height: 30px;
        }
        .headImgBox{
            float: right;
            height:30px;
        }
        .headImg{
            height:12px;
            margin-top: 9px;
        }
        .newBtn{
            margin-right: 15px;
        }
        /*******************bodyBOX*******************************/
        #body{
            width: 100%;
        }
        .dialogBox{
            width:100%;
        }
        .dialoglist{
            width:100%;
            height: 60px;
            border-bottom: 1px solid #e6e6e6;
        }
        .dialogPic{
            width: 60px;
            height:60px;
            float: left;
        }
        .dialogspanBox{
            width: calc(100% - 75px);
            height: 44px;
            float: left;
            padding: 8px 10px 8px 5px;
        }
        .dialogspan{
            height:22px;
        }
        .dialogspan span{
            display: inline-block;
            height: 22px;
            line-height: 22px;
        }
        .dialogName{
            font-size:15px;
            color: #000000;
            font-weight:600;
        }
        .dialogTime{
            float: right;
            font-size:13px;
            color: #a3a3a3;
        }
        .dialogContent{
            color: #666666;
            font-size:14px;
        }
        .jsonstring{
            display: none;
        }
    </style>
</head>
<body>
    <div id="head" >
       <span class="head_title">讨论组群</span>
        <div class="headImgBox">
            <img src="../img/spirit/newbtn.png" alt="" class="headImg newBtn">
            <img src="../img/spirit/managerbtn.png" alt="" class="headImg managerbtnBtn">
        </div>

    </div>
    <div id="body">
        <ul class="dialogBox">
        </ul>

    </div>

    <script>
        function doQtPer(uid){
            //console.log(uid);
            new QWebChannel(qt.webChannelTransport, function(channel) {
                var content = channel.objects.interface;
                content.xoa_sms(uid,'',"SEND_GROUP_MSG");
            });
        }
        function dialogclick(e){
            var uid = e.find('.jsonstring').text();
            doQtPer(uid);
        }
        $(function(){
            $('.newBtn').hover(function(){
                $(this).attr('src','../img/spirit/newbtnhover.png');
            },function(){
                $(this).attr('src','../img/spirit/newbtn.png');
            });
            $('.managerbtnBtn').hover(function(){
                $(this).attr('src','../img/spirit/managerbtnhover.png');
            },function(){
                $(this).attr('src','../img/spirit/managerbtn.png');
            });

            $.ajax({
                url:'/user/userCookie',
                type:'get',
                dataType:'json',
                data:{},
                success:function(data){
                    console.log(data);
                    var uid = data.object.uid;
                    $.ajax({
                        url:'/im/getAllRoom',
                        type:'get',
                        dataType:'json',
                        data:{
                            uid:uid
                        },
                        success:function(data){
                            console.log(data);
                            var str ='';
                            for(var i= 0;i<data.length;i++){
                                console.log(typeof(data[i]));
                                var str_json = JSON.stringify(data[i]);
                                console.log(str_json);
                                str += '<li class="dialoglist" onclick="dialogclick($(this))">'+
                                            '<div class="dialogPic">'+
                                                '<img src="../img/spirit/IM_img.png" alt="" style="height:43px;margin: 9px 0 0 9px;border-radius: 50%;">'+
                                            '</div>'+
                                            '<ul class="dialogspanBox">'+
                                                '<li class="dialogspan" style="margin-top: 12px">'+
                                                    '<span class="dialogName">'+data[i].rname+'</span>'+
                                                    '<span class="dialogTime"></span>'+
                                                '</li>'+
                                                '<li class="dialogspan">'+
                                                    '<span class="dialogContent"></span>'+
                                                '</li>'+
                                            '</ul>'+
                                            '<div class="jsonstring">'+ str_json +'</div>'+
                                        '</li>'
                            }
                            $('.dialogBox').html(str);
                        }

                    })
                }

            })
        })

    </script>
</body>
</html>