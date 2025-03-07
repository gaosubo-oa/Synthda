<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@taglib prefix="mvc" uri="http://www.springframework.org/tags/form" %>
<%@taglib prefix="fmt" uri="http://www.springframework.org/tags" %>
<!DOCTYPE html>
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width,initial-scale=1,minimum-scale=1,maximum-scale=1,user-scalable=no" />
    <title></title>
    <script type="text/javascript" src="/js/xoajq/xoajq3.js"></script>
    <script type="text/javascript" src="/js/jquery/jquery-migrate-3.4.0.js"></script>
<%--    <script type="text/javascript" src="../../js/jquery/jquery.min.js"></script>--%>
    <script type="text/javascript" src="../../js/base/base.js"></script>
    <%--<script type="text/javascript" src="../../js/ewx/waterMark.js?20190819.1"></script>--%>
    <link href="../../css/H5/default.css" rel="stylesheet"/>

    <style>
        html,body{
            /*width:100%;*/
            /*height:100%;*/
        }

        *{
            margin: 0;
            padding: 0;
        }

        .bot{
            position: fixed;
            bottom: 0;
            height: 70px;
            width: 100%;
            background: #fff;
            display: flex;
            box-shadow: 0px 1px 4px grey;
        }
        .bot div{
            width: calc(100% / 3);
            display: flex;
            flex-direction: column;
            justify-content: center;
            align-items: center;
        }
        .bot span{
            font-size: 12px;
        }
        .bot img{
            width: 22px;
            height: 22px;
            margin:5px auto;
        }
        .main{
            width: 100%;
            height: 100%;
        }

        .fontcolor{
            color: #1296db;
        }
        .wraper{
            width:100%;
            height:100%;
            position: fixed;
            overflow: scroll;
        }
    </style>
    <script type="text/javascript">
        var fs = document.documentElement.clientWidth / 750  * 100;
        document.querySelector("html").style.fontSize = fs + "px";
    </script>
</head>
<body style="background: #f7f7f7;position: relative">
<%--<div class="mui-content" style="padding-bottom: 1rem;">--%>
    <%--&lt;%&ndash;顶部轮播图&ndash;%&gt;--%>
    <%--<div class="swplb" style="width: 100%;">--%>
        <%--<img src="/img/ewx/LOGO.png" alt="">--%>
    <%--</div>--%>

    <%--&lt;%&ndash;滚动公告&ndash;%&gt;--%>

        <%--<div id="scroll_div" class="fl">--%>
            <%--<div id="scroll_begin">--%>
                <%--<span class="pad_right">您有工作需要办理，流水号：2129，工作名称/文号：</span>--%>
            <%--</div>--%>
            <%--<div id="scroll_end"></div>--%>
        <%--</div>--%>

    <%--&lt;%&ndash;智慧城建&ndash;%&gt;--%>
    <%--<div>--%>
        <%--<div class="square">--%>
            <%--<ul class="square-inner flex">--%>
                <%--<li>--%>
                    <%--<a href="/ewx/emailList">--%>
                        <%--<img src="../../img/H5/1.1.png"/>--%>
                        <%--<div>电子邮件</div>--%>
                    <%--</a>--%>
                <%--</li>--%>
                <%--<li  class="lborder rborder">--%>
                    <%--<a href="/ewx/noticeList">--%>
                        <%--<img src="../../img/H5/1.2.png"/>--%>
                        <%--<div>公告通知</div>--%>
                    <%--</a>--%>
                <%--</li>--%>
                <%--<li>--%>
                    <%--<a href="/calender/calendarh51">--%>
                        <%--<img src="../../img/H5/1.4.png"/>--%>
                        <%--<div>日程</div>--%>
                    <%--</a>--%>
                <%--</li>--%>
                <%--<li  class="bborder tborder">--%>
                    <%--<a href="/workflow/work/workflowIndexh5">--%>
                        <%--<img src="../../img/H5/2.1.png"/>--%>
                        <%--<div>工作流</div>--%>
                    <%--</a>--%>
                <%--</li>--%>
                <%--<li class="border">--%>
                    <%--<a href="/document/getSuperiorh51">--%>
                        <%--<img src="../../img/H5/4.2.png"/>--%>
                        <%--<div>待办工作</div>--%>
                    <%--</a>--%>
                <%--</li>--%>
                <%--<li class="tborder bborder">--%>
                    <%--<a href="/document/getDocumentInquiries1">--%>
                        <%--<img src="../../img/H5/5.4.png"/>--%>
                        <%--<div>工作查询</div>--%>
                    <%--</a>--%>
                <%--</li>--%>
                <%--<li>--%>
                    <%--<a href="/diary/diaryIndexh51">--%>
                        <%--<img src="../../img/H5/1.7.png"/>--%>
                        <%--<div>日志</div>--%>
                    <%--</a>--%>
                <%--</li>--%>
                <%--<li class="lborder rborder">--%>
                    <%--<a href="/file/fileIndexh51">--%>
                        <%--<img src="../../img/H5/1.10.png"/>--%>
                        <%--<div>文件柜</div>--%>
                    <%--</a>--%>
                <%--</li>--%>
                <%--<li>--%>
                    <%--<a href="/news/newsh51">--%>
                        <%--<img src="../../img/H5/1.3.png"/>--%>
                        <%--<div>人事</div>--%>
                    <%--</a>--%>
                <%--</li>--%>
            <%--</ul>--%>
        <%--</div>--%>
    <%--</div>--%>

<%--</div>--%>
<div class="wraper">
    <div class="main" style="height: calc(100% - 90px);">
        <iframe name="notices" src="/ewx/oneIndex" frameborder="0" style="height: 100%;width: 100%"></iframe>
    </div>
    <div class="bot">
        <div class="heali0ne">
            <img class="oneimg" src="/img/ewx/apply2.png"/>
            <span class="fontcolor">应用</span>
        </div>
        <div class="healiTwo">
            <img class="twoimg" src="/img/ewx/tixing2.png"/>
            <span>事务提醒</span>
        </div>
        <div class="healiThree">
            <img class="threeimg" src="/img/ewx/wo.png"/>
            <span>我的</span>
        </div>
    </div>
</div>

</body>
<script src="/js/base/vconsole.min.js"></script>
<%--<script src="/js/ewx/onHistoryBack.js?20230525.1"></script>--%>
<script>
    // var vConsole = new VConsole();
   /* $(function(){
        autodivheight();
        debugger
        let openType=$.GetRequest().openType
        if(openType!=undefined && openType!=''){
            console.log(unescape(openType));
           // $('.healiTwo').click();
            location.href = unescape(openType);
        }
    });*/

    window.onresize=function(){
        autodivheight();
    };

    function autodivheight(){
        var winHeight=0;
        if (window.innerHeight)
            winHeight = window.innerHeight;
        else if ((document.body) && (document.body.clientHeight))
            winHeight = document.body.clientHeight;
        if (document.documentElement && document.documentElement.clientHeight)
            winHeight = document.documentElement.clientHeight;
        winWidth = document.documentElement.clientWidth;

        $('.main').css({'width':winWidth +"px"})
        $('.wraper').css({'width':winWidth +"px"})
        $('.wraper').css({'height':winHeight+5 +"px"})
    }

    $('.heali0ne').find('img').attr('src','/img/ewx/apply2.png');
    $('.heali0ne').find('span').addClass('fontcolor');
    $('.main').find('iframe').prop('src','/ewx/oneIndex?dataType='+$.GetRequest().dataType);


    $('.heali0ne').on('click', function () {
        $(this).children('span').addClass('fontcolor')
        $(this).siblings('div').children('span').removeClass('fontcolor');
        $('.oneimg').attr('src','/img/ewx/apply2.png');
        $('.twoimg').attr('src','/img/ewx/tixing2.png');
        $('.threeimg').attr('src','/img/ewx/wo.png');
        $('.main').find('iframe').prop('src','/ewx/oneIndex?dataType='+$.GetRequest().dataType);
    })
    $('.healiTwo').on('click', function () {
        $(this).children('span').addClass('fontcolor')
        $(this).siblings('div').children('span').removeClass('fontcolor');
        $('.oneimg').attr('src','/img/ewx/apply1.png');
        $('.twoimg').attr('src','/img/ewx/tixing.png');
        $('.threeimg').attr('src','/img/ewx/wo.png');
        $('.main').find('iframe').prop('src','/ewx/repository?dataType='+$.GetRequest().dataType);
    })
    $('.healiThree').on('click', function () {
        $(this).children('span').addClass('fontcolor')
        $(this).siblings('div').children('span').removeClass('fontcolor');
        $('.oneimg').attr('src','/img/ewx/apply1.png');
        $('.twoimg').attr('src','/img/ewx/tixing2.png');
        $('.threeimg').attr('src','/img/ewx/wo2.png');
        $('.main').find('iframe').prop('src','/ewx/mine?dataType='+$.GetRequest().dataType);

    })

    function swaciom() {
        $('.healiTwo').children('span').addClass('fontcolor')
        $('.healiTwo').siblings('div').children('span').removeClass('fontcolor');
        $('.oneimg').attr('src','/img/ewx/apply1.png');
        $('.twoimg').attr('src','/img/ewx/tixing.png');
        $('.threeimg').attr('src','/img/ewx/wo.png');
        $('.main').find('iframe').prop('src','/ewx/repository');
    }
    $(function () {
        //企业微信端的办理首页页面的title通过设置项进行赋值
        $.ajax({
            url: '/sys/getIndexInfo',
            type: 'get',
            dataType: 'json',
            success: function (obj) {
                if (obj.flag == true) {
                    $('title').html(obj.object.ieTitle)
                }
            }
        });
    })
</script>
</html>