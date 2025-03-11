<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() +"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE html>
<html><!--<![endif]-->
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
    <title></title>
    <meta name="renderer" content="webkit">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=0, minimum-scale=1.0, maximum-scale=1.0">
    <script src="/js/xoajq/xoajq1.js"></script>
    <script type="text/javascript" src="/js/base/base.js"></script>
    <link rel="stylesheet" href="/css/spirit/groupChat.css">
    <script type="text/javascript" src="../js/spirit/qwebchannel.js"></script>
    <style>
        body, button, select, textarea, input, label, option, fieldset,ul,li,p,ol legend{
            font-family: 微软雅黑;
            margin: 0;
            padding: 0;
        }
        ul li{
            list-style: none;
            padding: 5px 0;
            padding-left: 8px;
            box-sizing: border-box;
            height: 50px;
            line-height: 40px;
            cursor: context-menu;
        }
        ul li:hover{
            background: #e2f4ff;
        }
        li.active{
            background: #ceefff;
        }
        ul{
            margin-top:2px;
        }
        ul li label img{
            width: 24px;
            vertical-align: middle;
            height:24px;
            margin-top:-3px;
            display: inline-block;
        }
        ul li div p.title{
            height: 14px;
            line-height:14px;
            font-size: 12px;
            overflow: hidden;
            padding-left: 5px;
            margin-top:5px;
            overflow: hidden;
            text-overflow:ellipsis;
            white-space: nowrap;
            width: 9em;
        }
        p.name{
            height: 14px;
            line-height:14px;
            font-size: 14px;
            overflow: hidden;
            padding-left: 5px;
            margin-top:4px;
            overflow: hidden;
            text-overflow:ellipsis;
            white-space: nowrap;
            width: 100%;
        }
        .fl{
            float: left;
        }
        .titleText div.fl{
            width: 85%;
        }
        .clearfix{
            display: block;
            clear: both;
            content: '';
        }
        .avatarimg{
            border-radius: 100%;
        }
        .groupOwner{
            font-size: 10px;
            color: #9e9e9e;
        }
    </style>
</head>
<body>
    <ul class="titleText">
    </ul>
<script>
    function throttle(method,id) {
        clearTimeout(method.tId);
        method.tId = setTimeout(function () {
            method.call(window,id);
        }, 500);
    }
    function hoverAjax(id) {
        var jqStr=id;
        new QWebChannel(qt.webChannelTransport, function(channel) {
            var content = channel.objects.interface;
            content.xoa_sms(jqStr,'mv',"SHOW_USER_INFO");
        });
    }
    var geiObj=$.GetRequest();
    $.get('/im/getRoomPerson?roomOf='+geiObj.roomOf,function (json) {
        if(json.flag){
            var arr=json.obj;
            var str='';
            for(var i=0;i<arr.length;i++){
                var groupOwner = '';
                if(arr[i].groupOwner == 1){
                    groupOwner = '<span class="groupOwner">群主</span>';
                }
                var jQobj=$('<li>\
                    <label class="fl"><img class="avatarimg" src="'+function () {
                        var avatar = arr[i].avatar;
                        if(avatar==undefined||avatar==""){
                            avatar = arr[i].sex;
                        }
                        if(avatar==0){
                            return '/img/email/icon_head_man_06.png'
                        }else if(avatar==1){
                            return '/img/email/icon_head_woman_06.png'
                        }else {
                            return '/img/user/'+arr[i].avatar
                        }
                    }()+'" alt=""></label>\
                    <div class="fl">\
                    <p class="name">\
                    <span>'+arr[i].userName+'（'+arr[i].userPrivName+'）</span>'+groupOwner+
                    '</p>\
                    <p class="title">'+arr[i].deptName+''+function () {
                        return ''
                    }()+'</p>\
                    </div>\
                    </li>')

                jQobj.attr('data-obj',JSON.stringify(arr[i]));
                if(arr[i].groupOwner == 1){
                    str = jQobj[0].outerHTML + str;
                }else{
                    str += jQobj[0].outerHTML;
                }
            }
            $('ul').html(str)
        }
    },'json')
    $('.titleText').on('click','li',function () {
        $(this).addClass('active').siblings('').removeClass('active');
        hoverAjax($(this).attr('data-obj'));
    })


    $(".titleText").bind("contextmenu", function(e){
        return false;
    })

    $(".titleText").mousedown(function(e){
        if(e.which==3){
            var $li=null;
            if(e.target.tagName!='LI'){
                $li=$(e.target).parents('li')
            }else {
                $li=$(e.target);
            }
            $li.addClass('active').siblings('').removeClass('active');
            var jqStr=$li.attr('data-obj');
            //console.log(jqStr)
            var groupOwner = $.parseJSON(jqStr).groupOwner;
            new QWebChannel(qt.webChannelTransport, function(channel) {
                var content = channel.objects.interface;
                content.xoa_sms(jqStr,groupOwner,"GET_USER_INFO");
            });
        }
    })


</script>
</body>
</html>