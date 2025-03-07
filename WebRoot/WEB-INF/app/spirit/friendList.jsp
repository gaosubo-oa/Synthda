<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html>
<!-- saved from url=(0082)file:///C:/Users/gaosubo/Desktop/OA%E7%B2%BE%E7%81%B5_files/saved_resource(1).html -->
<html><!--<![endif]-->
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
    <title></title>

    <meta name="renderer" content="webkit">
    <meta http-equiv="X-UA-Compatible" content="IE=10,chrome=1">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=0, minimum-scale=1.0, maximum-scale=1.0">
    <link rel="stylesheet" type="text/css" href="../css/spirit/style.css">
    <link rel="stylesheet" type="text/css" href="../css/spirit/ipanel.css">
    <link rel="stylesheet" type="text/css" href="../css/main/theme1/bootstrap.min.css"/>
    <link rel="stylesheet" type="text/css" href="../css/main/theme1/index.css?20201106.1"/>
    <link rel="stylesheet" type="text/css" href="../css/spirit/user_online.css">
<%--    <script type="text/javascript" src="/js/xoajq/xoajq1.js"></script>--%>
    <script type="text/javascript" src="/js/xoajq/xoajq3.js"></script>
<%--    <script type="text/javascript" src="/js/jquery/jquery-migrate-3.4.0.js"></script>--%>
    <script src="/lib/layer/layer.js?20201106"></script>
    <script src="/js/base/base.js"></script>
    <script type="text/javascript" src="../js/spirit/qwebchannel.js"></script>
    <style>
        .signBOX{
            padding-left: 20px;
            display: block;
            line-height: 26px;
        }
        .dynatree-checkbox{
            background: none;
            vertical-align: middle;
            width: 16px;
            height: 16px;
        }
        span.dynatree-checkbox img {
            cursor: pointer;
            vertical-align: top;
            border-style: none;
            width: 8px!important;
            height: 8px!important;
            margin-top: 4px;
        }

        a.dynatree-title {
            color: black;
            font-size: 14px;
            vertical-align: middle;
            display: inline;
            margin-left: 0px;
            font-weight: 300;
        }
        .rightBOX{
            width: 100px;
            float: left;
            margin-left: 150px;
            height: 28px;
        }
        .rightBOX li{
            cursor: pointer;
            float: left;
            height: 28px;
            line-height: 28px;
            margin-right: 15px;
        }
        .rightBOX img{
            width:14px;
        }
        .friendsBOX .dyna_li,.friendsBOX2 .dyna_li{
            list-style-image: none;
            list-style-position: outside;
            list-style-type: none;
            -moz-background-clip: border;
            -moz-background-inline-policy: continuous;
            -moz-background-origin: padding;
            background-attachment: scroll;
            background-color: transparent;
            background-position: 0 0;
            background-repeat: repeat-y;
            background-image: none;
            margin: 0;
            padding: 1px 0 0 0;
            overflow: visible;
            white-space: nowrap;
            cursor: pointer;
        }
        .friendsBOX .childdept,.friendsBOX2 .childdept{
            display: block;
            line-height: 26px;
        }
        .friendsBOX span.dynatree-checkbox,.friendsBOX2 span.dynatree-checkbox {
            vertical-align: middle;
            width: 20px;
            height: 20px;
            margin-right: 5px;

        }
        .friendsBOX .dynatree-checkbox>img,.friendsBOX2 .dynatree-checkbox>img {
            width: 20px!important;
            height: 20px!important;
            border-radius: 100%;
            margin-top: 0;
        }
        .friendsBOX .childdept:hover {
            background: #abd9fe;
        }
    </style>
</head>
    <div class="box">
        <div class="signBOX">
            <div class="specialBOX" style="float: left;">
                <span class="dynatree-checkbox">
                    <img src="/img/sys/dapt_down.png" alt="" data-type="1">
                </span>
                <a href="#" class="dynatree-title" title="" style="font-weight: 900">我的好友</a>
            </div>
            <ul class="rightBOX">

                <li class="Refresh"><img src="/img/spirit/menu/Refresh.png" title="刷新" ></li>
                <li class="addFriend"><img src="/img/spirit/menu/addFriend.png" title="添加好友"></li>
            </ul>
        </div>
        <ul class="friendsBOX">
        </ul>
    </div>

    <div class="box2">
        <div class="signBOX" style="margin-top: 50px">
            <div class="specialBOX2" style="float: left;">
                    <span class="dynatree-checkbox actives">
                        <img src="/img/sys/dapt_right.png" alt="" data-type="1">
                    </span>
                <a href="#" class="dynatree-title" title="" style="font-weight: 900">待验证</a>
            </div>
        </div>
        <ul class="friendsBOX2" style="display: none">
        </ul>
    </div>

<body>

<script>
    function openwin(e){
        var uid=$(e).find("a.dynatree-title").attr("uid");
        var uname=$(e).find("a.dynatree-title").attr("title");
        var userPrivName=$(e).find("a.dynatree-title").attr("userPrivName");
        var sex=$(e).find("a.dynatree-title").attr("sex");
        var birthday=$(e).find("a.dynatree-title").attr("birthday");
        var mobilNo=$(e).find("a.dynatree-title").attr("id");
        var myStatus = $(e).find("a.dynatree-title").attr("myStatus");
        var avatar = $(e).find("span.dynatree-checkbox img").attr("src");
        var datas={"uname":uname,"userPrivName":userPrivName,"sex":sex,"birthday":birthday,"mobilNo":mobilNo,"myStatus":myStatus,"avatar":avatar};
        var datass=JSON.stringify(datas);
        doQtDep(uid,datass);
    }

    function doQtDep(uid,datas) {
        new QWebChannel(qt.webChannelTransport, function(channel) {
            var content = channel.objects.interface;
            content.xoa_sms(uid,datas,"SEND_MSG");
        });
    }

    $('.specialBOX').on('click',function(){
        if($(this).find('.dynatree-checkbox').hasClass('actives')){
            $(this).find('.dynatree-checkbox').removeClass('actives').find('img').attr('src','/img/sys/dapt_down.png');
            $('.friendsBOX').show();
        }else{
            $(this).find('.dynatree-checkbox').addClass('actives').find('img').attr('src','/img/sys/dapt_right.png');
            $('.friendsBOX').hide();
        }
    });
    $('.specialBOX2').on('click',function(){
        if($(this).find('.dynatree-checkbox').hasClass('actives')){
            $(this).find('.dynatree-checkbox').removeClass('actives').find('img').attr('src','/img/sys/dapt_down.png');
            $('.friendsBOX2').show();
        }else{
            $(this).find('.dynatree-checkbox').addClass('actives').find('img').attr('src','/img/sys/dapt_right.png');
            $('.friendsBOX2').hide();
        }
    });
    $('.addFriend').on('click',function(){
        doQtDep('addFrineds','/spirit/getAddfriend');
    })

    $('.Refresh').on('click',function(){
        location.reload();
    })
    $(function(){
        setTimeout(function(){
            $('.Refresh').trigger('click');
        },300000)
        $.ajax({
            type:'post',
            url:'/imfriends/getfriendsList?userName=',
            dataType:'json',
            success:function (data) {
//                if(data.flag){
                    if(data.obj !=''){
                        var str = '';
                        for(var i=0;i<data.obj.length;i++){
                           str += '<li class="dyna_li" onclick="openwin(this)"><span style="padding-left: 40px; " class="childdept dynatree-node dynatree-folder dynatree-expanded dynatree-has-children dynatree-lastsib dynatree-exp-el dynatree-ico-ef"><span class="dynatree-checkbox"><img onerror="imgerror(this,1)" class="avatarimg" src="'+function () {
                                        if(data.obj[i].avatar=='0'){
                                            return '/img/email/icon_head_man_06.png'
                                        }else if(data.obj[i].avatar=='1'){
                                            return '/img/email/icon_head_woman_06.png'
                                        }else if(data.obj[i].avatar==''){
                                            return '/img/email/icon_head_man_06.png'
                                        }else{
                                            return '/img/user/'+data.obj[i].avatar
                                        }
                                    }()+'" ></span><a href="#" class="dynatree-title" userid="'+ data.obj[i].userId +'" uid="'+ data.obj[i].uid +'" userprivname="'+ data.obj[i].userPrivName +'" sex="'+ data.obj[i].sex +'" id="'+ data.obj[i].mobilNo +'" title="'+ data.obj[i].userName +'" mystatus="'+ data.obj[i].myStatus +'" birthday="'+ data.obj[i].birthday +'">'+ data.obj[i].userName +'</a></span></li>'

                        }
                        $('.friendsBOX').html(str);
                    }else{
                        $('.friendsBOX').html('<li><span style="padding-left: 40px;color: red;">暂无好友!</span></li>')
                    }
//                }else{
//                    $('.friendsBOX').html('<li><span style="padding-left: 40px;color: red;">暂无好友!</span></li>')
//                }
            }
        })
        $.ajax({
            type:'post',
            url:'/imfriends/getWyzFriends',
            dataType:'json',
            success:function (data) {
                if(data.obj !=''){
                    var str = '';
                    for(var i=0;i<data.obj.length;i++){
                        str += '<li class="dyna_li"><span style="padding-left: 40px; " class="childdept dynatree-node dynatree-folder dynatree-expanded dynatree-has-children dynatree-lastsib dynatree-exp-el dynatree-ico-ef"><span class="dynatree-checkbox"><img onerror="imgerror(this,1)" class="avatarimg" src="'+function () {
                                if(data.obj[i].avatar=='0'){
                                    return '/img/email/icon_head_man_06.png'
                                }else if(data.obj[i].avatar=='1'){
                                    return '/img/email/icon_head_woman_06.png'
                                }else if(data.obj[i].avatar==''){
                                    return '/img/email/icon_head_man_06.png'
                                }else{
                                    return '/img/user/'+data.obj[i].avatar
                                }
                            }()+'" ></span><a href="#" class="dynatree-title" userid="'+ data.obj[i].userId +'" uid="'+ data.obj[i].uid +'" userprivname="'+ data.obj[i].userPrivName +'" sex="'+ data.obj[i].sex +'" id="'+ data.obj[i].mobilNo +'" title="'+ data.obj[i].userName +'" mystatus="'+ data.obj[i].myStatus +'" birthday="'+ data.obj[i].birthday +'">'+ data.obj[i].userName +'</a></span></li>'

                    }
                    $('.friendsBOX2').html(str);
                }else{
                    $('.friendsBOX2').html('<li><span style="padding-left: 40px;color: red;">暂无好友!</span></li>')
                }
            }
        })
    })
</script>
</body>
</html>