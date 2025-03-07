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
    <title>通讯簿-搜索</title>
    <meta http-equiv="X-UA-Compatible" content="IE=10,chrome=1">
    <meta http-equiv="Content-Type" content="text/html;">
    <meta name="viewport" content="width=device-width; initial-scale=1.0; maximum-scale=1.0; user-scalable=0;">
    <meta name="apple-mobile-web-app-capable" content="yes">
    <meta name="apple-mobile-web-app-status-bar-style" content="black">
   <!-- CSS Libs -->
    <link rel="stylesheet" type="text/css" href="/css/bootstrap.css">

    <link rel="stylesheet" href="/lib/layui/layui/css/layui.css">
    <script src="/js/xoajq/xoajq1.js"></script>
    <script type="text/javascript" src="/lib/layui/layui/layui.js"></script>
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
        [class^="sort_list2"]{
              padding: 0px 60px 0px 69px;
              position: relative;
              line-height: 50px;
          }

        [class^="sort_list"] .num_logo{
            /*width: 30px;*/
            /*height: 50px;*/
            /*border-radius: 10px;*/
            /*overflow: hidden;*/
            /*position: absolute;*/
            /*left: 20px;*/

            width: 45px;
            height: 45px;
            border-radius: 45px;
            overflow: hidden;
            position: absolute;
            left: 10px;
            top: 2px;
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

        [class^="header"] .search{
            background-color: #fff;
            width: 86%;
            margin-top: 7px;
            outline: none;
            border: 1px solid #fff;
        }

        .checkBox{
            display: inline-block;
            position: absolute;
            right: 24px;
        }
        .checkBox i{
            font-size: 22px;
            color: #ababab;
        }
        .checkBox i.layui-icon-ok-circle{
            color: #5FB878;
        }
        .layLoad {
            display: none;
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

    </style>

</head>
<body>
<div class="layLoad"><div>正在加载数据，请稍侯...</div></div>

<div class="header">
    <p style="float: left;font-weight: bold;cursor: pointer" onclick="returnFn()" ><img  style="width: 35px;height: 35px;" src="../img/address/ic_title_back.png"  alt="" /></p>
    <input id="search" class="search"   type="text" />
</div>
<div class="sort_box-two">

</div>
<div class="sort_box">
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
    var timer;
    var count = 0;
    var url = window.location.href;
    var locations = url.split('/ewx')[0]
    // var locations = window.location.protocol+"//"+window.location.port
    var starname = "";//获取名字的第一个字

    // 自由流程
    var workflow = getQueryString('type')||'';
    if($.isEmptyObject(parent.iframeJson)){
        var thisJson = parent.json[parent.choosePrcsid].user;
        var thisUserId = parent.userId;
    }else{
        var thisJson = parent.iframeJson;
        var thisUserId = parent.iframeJson.map(n => n.userId);
    }


    function childFn(that) {
        var tavatar = that.attr("tavatar")
        var uid = that.attr("uid")
        var userId = that.attr("userId")
        var newcolor = that.find(".newcolor").css("background-color")
        var tsex =that.attr("tsex")
        var tname =that.attr("tname")
        var tuserPrivName =that.attr("tuserPrivName")
        if(workflow != ''){
            if(that.find('.layui-icon-ok-circle').length > 0){
                thisUserId = thisJson.map(n => n.userId);
                var Jsonindex = thisUserId.indexOf(userId);
                thisJson.splice(Jsonindex, 1)
                that.find('.layui-icon-ok-circle').removeClass('layui-icon-ok-circle').addClass('layui-icon-circle');
            }else{
                if(tavatar != 0&&tavatar != 1&&tavatar != ''&&tavatar != undefined){
                    thisJson.push({
                        name: tname,
                        userId: userId,
                        avatar: '/img/user/' + tavatar
                    })
                }else{
                    thisJson.push({
                        name: tname,
                        userId: userId,
                    })
                }
                that.find('.layui-icon-circle').removeClass('layui-icon-circle').addClass('layui-icon-ok-circle');
            }
            parent.iframeJson = thisJson;
        }else{
            //人员详情页
            window.location.href = "/ewx/Persondata?uid=" +uid+"&newcolor="+newcolor+"&tsex="+tsex+"&tname="+tname+"&tuserPrivName="+tuserPrivName+"&tavatar="+tavatar

        }
    }

    function returnFn() {
        window.history.back(-1);
    }

    var bind_name ='input';
    if(navigator.userAgent.indexOf("MSIE") != -1){
        bind_name ='propertychange';
    }
    if(navigator.userAgent.match(/andriod/i)=="andriod"){
        bind_name ="keyup";
    }
    $("#search").bind(bind_name,function(){
        clearTimeout(timer);
        timer = setTimeout(function(){
            $('.layLoad').show();
            var searchnew = $("#search").val();
            $.ajax({
                url:'/user/getBySearchBai',
                data:{search: searchnew},
                dataType:'json',
                type:'get',
                success:function(res){
                    if(res.flag&&res.obj.length>0){
                        var data = res.obj;
                        var str = ""
                        for(var i = 0; i < data.length; i++){
                            starname = data[i].userName.substr(0,1);//名字第一个字符
                            var newlocations = locations+'/img/user/'+data[i].avatar;
                            if(workflow != ''){
                                var checkStr = '<div class="checkBox"><i class="layui-icon '+ function(){
                                    if(thisUserId.indexOf(data[i].userId.toString()) > -1){
                                        return 'layui-icon-ok-circle'
                                    }else{
                                        return 'layui-icon-circle'
                                    }

                                }() +'"></i></div>'
                            }else{
                                var checkStr = '';
                            }
                            if(data[i].avatar != 0 && data[i].avatar != 1 && data[i].avatar != undefined && data[i].avatar != "undefined"  && data[i].avatar != "" ){
                                str += '<div class="sort_list" uid="'+data[i].uid+'" userId="'+data[i].userId+'" type="'+data[i].type+'" tavatar ="'+data[i].avatar+'"     tsex="'+data[i].sex+'"   tname ="'+data[i].name+'"  tuserPrivName="'+data[i].userPrivName+'" onclick="childFn($(this))" ">\n' +
                                    checkStr + '        <div class="num_logo">\n' +
                                    '            <img src="'+newlocations+'"  alt="">\n' +
                                    '        </div>\n' +
                                    '        <div class="num_name" style="font-size: 10px;line-height: 50px;">\n'+
                                    '           <div style="font-size: 10px;height: 25px;line-height: 25px;">'+data[i].userName+'</div>\n'+
                                    '           <div style="font-size: 10px;height: 25px;line-height: 25px;">'+data[i].userPrivName+'</div>\n'+
                                    '        </div>\n' +
                                    '    </div>'
                            }else if(data[i].avatar =='' || data[i].avatar == 0 || data[i].avatar == 1){
                                str += '<div class="sort_list" uid="'+data[i].uid+'" userId="'+data[i].userId+'" type="'+data[i].type+'" tavatar ="'+data[i].avatar+'"  tsex="'+data[i].sex+'"   tname ="'+data[i].name+'"  tuserPrivName="'+data[i].userPrivName+'" onclick="childFn($(this))" ">\n' +
                                    checkStr + '        <div class="num_logo newcolor"  style="line-height: 45px;height: 45px; background-color: '+bg1()+'">\n'+
                                    '        <div  style="line-height: 45px;height: 45px;font-size: 20px;color: #fff; text-align: center;">' +starname+ '</div>\n' +
                                    '</div>\n' +
                                    '        <div class="num_name" style="font-size: 10px;line-height: 50px;">\n'+
                                    '           <div style="font-size: 10px;height: 25px;line-height: 25px;">'+data[i].userName+'</div>\n'+
                                    '           <div style="font-size: 10px;height: 25px;line-height: 25px;">'+data[i].userPrivName+'</div>\n'+
                                    '        </div>\n' +
                                    '    </div>'
                            }


                        }
                    }else if(res.flag&&res.obj.length==0){
                        var str = '';
                        str += '<div class="sort_list2" style="text-align: center;margin: 0 auto;line-height:45px;">'+
                            '暂无信息\n'+
                            '</div>'
                    }
                    $('.layLoad').hide();
                    $('.sort_box').html(str)
                    var Initials=$('.initials');

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
        }, 1500);
    })
    // window.onload = function () {
    //     var searchnew = $("#search").val();
    //     if( searchnew != "" && searchnew != undefined && searchnew!="undefined"){
    //         var searchnew = $("#search").val();
    //     }
    // }
    function bg1(){
        var colorstr = "#";
        var Str ="ABCDEF123456789"
        for(var i=0;i<6;i++){
            colorstr += Str[Math.floor(Math.random() * Str.length)]
        }
        return colorstr;
    }
</script>
