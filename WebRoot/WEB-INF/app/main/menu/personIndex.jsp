<%--
  Created by IntelliJ IDEA.
  User: gaosubo
  Date: 2021/3/24
  Time: 16:18
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <title>个人门户</title>
<%--    <script type="text/javascript" src="/js/calendar.js"></script>--%>
    <meta name="renderer" content="webkit">
    <meta http-equiv="X-UA-Compatible" content="IE=10,chrome=1">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=0, minimum-scale=1.0, maximum-scale=1.0">
    <link rel="stylesheet" type="text/css" href="/lib/layui/layui/css/layui.css?20210319.1"/>
    <link rel="stylesheet" type="text/css" href="/css/diary/calendar1.css"/>
    <link rel="stylesheet" type="text/css" href="/css/main/theme6/cont.css?20210322.4"/>
    <link rel="stylesheet" type="text/css" href="/css/main/theme1/m_reset.css"/>
    <link rel="stylesheet" type="text/css" href="/css/main/${sessionScope.InterfaceModel}/index.css?20210322"/>
    <script type="text/javascript" src="/lib/layui/layui/layui.js"></script>
    <script type="text/javascript" src="/lib/layui/layui/layui.all.js"></script>
    <script type="text/javascript" src="/js/xoajq/xoajq1.js"></script>
    <script type="text/javascript" src="/js/xoajq/xoajq2.js"></script>
    <script src="/js/base/base.js" type="text/javascript" charset="utf-8"></script>
    <script type="text/javascript" src="/js/echarts.min.js"></script>
    <script src="../../js/jquery/jquery.cookie.js"></script>
    <script type="text/javascript" src="/js/diary/calendar1.js/"></script>
    <script src="/js/main_js/myOA.js?20220121.1"></script>
    <style>
        html, body{
            font-family: "Microsoft Yahei" !important;
        }
        body{
            background: #F8F8F8;
        }
        .threeLeft{
            width: 42%;
            background: white;
            margin-left: 1.3%;
            height: 400px;
        }
        .threeRight{
            width: 32%;
            background: white;
            margin-left: 1%;
            height: 400px;
            margin-right: 1%;
        }
        li{
            margin: 6px auto;
        }
        .layui-tab-content li:hover{
            cursor: pointer;
            /*background-color: #e8f4fc;*/
        }
        .works:hover{
            color: #8a8e98fa;
            cursor: pointer;
        }
        .layui-tab-content li{
            /*list-style: disc;*/
            padding: 5px 0px;
            margin: 0;
            font-size: 13px;
        }
        .r-top h3{
            font-size: 25px;
            line-height: 49px;
            padding-top: 10px;
        }
        .r-top h4{
            font-size: 18px;
            line-height: 8px;
        }

        .contain {
            border: none;
            height: 365px;
            width: 31.7%;
            float: left;
        }
        .cont_main ul.total > li {
            background: #fff;
            box-shadow: 0 2px 6px rgba(0, 0, 0, 0.2);
        }
        .main .middle {
            width: 32%;
        }
        .main {
            width: 100%;
            margin: auto;
             height: auto;
            overflow-y: scroll;
            /* height: calc(100% - 50px); */
        }
        ul.total {
            width: 100%;
             height: auto;
        }
        .total .bg_head {
            cursor: all-scroll;
        }
        .hide {
            display: none;
        }
        .s_head img {
            position: absolute;
            left: 6px;
            top: 8px;
        }
        .more_emil li, .more_news {
            font-weight: 300;
            margin: 4px 0 4px 4px;
        }
        .selectTy {
            width: 18%;
            height: 85.5%;
            font-size: 7.5pt;
            margin: 1px 5px;
        }
        .chedule_li div {
            float: left;
            margin-top: 7px;
            font-size: 13px;
        }
        .richeng_title {
            width: 65%;
            line-height: 28px;
            margin-left: 4px;
            overflow: hidden;
            text-overflow: ellipsis;
            white-space: nowrap;
        }

        .calendar-arrow span, .calendar-views .days li[data-calendar-day], .calendar-views .view-month li[data-calendar-month]{
            height: 27px !important;
            line-height: 27px !important;
            width: 35.428571px;
        }
        .new_title {
            color: black;
        }
        .new_title:hover {
            color: #8a8e98fa;
        }
        .e_word, .n_word {
            width: 83%;
            height: 22%;
            margin-left: 2%;
            position: relative;
        }
        .fileWord{
            height: 20%;
            margin-left: 2%;
            position: relative;
        }
        .e_img, .d_img, .n_img {
            height: 20%;
            width: 36px;
        }
        .calendar-arrow {
            width: 82px;
            margin-right: 0px;
        }

        .imgTitle{
            cursor:pointer;
        }

        .layui-carousel-ind {
            position: relative;
            top: -22px;
            width: 100%;
            line-height: 0!important;
            text-align: center;
            font-size: 0;
        }
        .gongwen li{
            width: 100%;
            height: 50px;
            border-bottom: 1px solid #f0f0f0;
        }
    </style>
</head>
<body style="overflow-y: auto;">
<div>
    <%--    第一部分--%>
    <div id="myTableGets" <%--style="display:none"--%>>
    <li id="01" class="contain middle lis con_notice" news="1">
        <%--左侧图片新闻--%>
        <div class="threeMiddle">
            <div style="margin-top: 8px;font-weight: bold;font-size: 15px;margin-left: 2%;position: relative;">
                <img src="/img/main_img/theme6/icon_newsgrid.png" style="margin-top: -2px;">
                <span style="margin-left: 5px">图片新闻</span>
                <span name="news" class="more more_news" tid="0117" more_type="1" url="news/index" onclick="parent.getMenuOpen(this)" style="position: absolute;">
                    <h2 class="hide" style="display: none">新闻</h2><a style="float: right;margin-right: 10px;cursor:pointer;color: #2b7fe0!important; font-size: 13px;font-weight: bold;">更多</a>
                </span>
            </div>
            <div class="swiper-wrapper">
                <div class="layui-carousel" id="pictures" lay-filter="pictures" style="margin-left: 2%">
                    <div carousel-item="">
<%--                        <div><img src="/img/main_img/theme6/icon_newsgrid.png" alt="" style="height:100%;width: 100%"></div>--%>
<%--                        <div><img src="/img/main_img/theme6/icon_newsgrid.png" alt="" style="height:100%;"></div>--%>
<%--                        <div><img src="/img/main_img/theme6/icon_newsgrid.png" alt="" style="height:100%;width: 100%"></div>--%>
                    </div>
                </div>
            </div>
        </div>

    </li>

    <li id="02" class="contain side lis con_new" news="2">
        <div style="margin-top: 8px;font-weight: bold;font-size: 16px;margin-left: 2%;">
            <img src="/img/main_img/theme6/icon_newsgrid.png"><span style="margin-left: 5px">新闻</span>
        </div>
        <div class="layui-tab layui-tab-brief" lay-filter="xinwen">
            <ul class="layui-tab-title">
                <li class="xw layui-this" type="1">未读</li>
                <li class="xw" type="2">已读</li>
                <li class="xw" type="3">全部</li>
            </ul>
            <div class="layui-tab-content" style="height: 250px;">
                <div class="layui-tab-item layui-show xwweidu" ></div>
                <div class="layui-tab-item xwyidu"></div>
                <div class="layui-tab-item xwquanbu"></div>
            </div>
        </div>
    </li>
    <li id="03" class="contain middle lis con_notice">
        <div style="margin-top: 8px;font-weight: bold;font-size: 16px;margin-left: 2%;">
        <img src="/img/main_img/theme6/announce.png"><span style="margin-left: 5px">公告</span></div>
        <div class="layui-tab layui-tab-brief" lay-filter="gonggao">
        <ul class="layui-tab-title">
        <li class="layui-this">未读</li>
        <li>已读</li>
        <li>全部</li>
        </ul>
        <div class="layui-tab-content" style="height: 250px;">
        <div class="layui-tab-item layui-show ggweidu"></div>
        <div class="layui-tab-item ggyidu"></div>
        <div class="layui-tab-item ggquanbu"></div>
        <%--            <div class="layui-tab-item weiWork"></div>--%>
        </div>
        </div>
    </li>
    </div>
    <div class="main cont_main" id="contmain_1" data-tabid="1" style="z-index: 0;overflow-x: hidden;">
    <ul class="total" style="min-width: 1200px;">

    </ul>
    </div>

    <%--    第二部分--%>
    <div style="display: flex;margin-top: 10px;">
        <%--左侧--%>
        <div class="threeLeft">
            <div style="margin-top: 8px;font-weight: bold;font-size: 15px;margin-left: 2%;">
                <img src="/img/main_img/theme6/changyong.png" style="margin-top: -2px;"><span style="margin-left: 5px">流程中心</span>
            </div>
            <div class="layui-tab layui-tab-brief" lay-filter="docDemoTabBrief" style="margin-left: 1%">
                <ul class="layui-tab-title">
                    <li class="layui-this">待办工作</li>
                    <li>办结工作</li>
                    <li>全部工作</li>
                    <li>委托工作</li>
                </ul>
                <div class="layui-tab-content liucheng" style="height: 287px; overflow-y: scroll;">
                    <div class="layui-tab-item layui-show daiWork"></div>
                    <div class="layui-tab-item overWork"></div>
                    <div class="layui-tab-item allWorkShow"></div>
                    <div class="layui-tab-item weiWork"></div>
                </div>
            </div>
        </div>
        <%--中间--%>
        <div class="contain middle lis con_email" style="height: 400px; margin-top: 0%;">
            <div style="margin-top: 8px;font-weight: bold;font-size: 16px;margin-left: 2%;">
                <img src="/img/main_img/theme6/emailbox.png"><span style="margin-left: 5px">邮件</span>
            </div>
            <div class="layui-tab layui-tab-brief" lay-filter="youjian">
                <ul class="layui-tab-title">
                    <li class="layui-this">未读</li>
                    <li>已读</li>
                    <li>全部</li>
                </ul>
                <div class="layui-tab-content" style="height: 287px;overflow-y: scroll">
                    <div class="layui-tab-item layui-show yjweidu" ></div>
                    <div class="layui-tab-item yjyidu"></div>
                    <div class="layui-tab-item yjquanbu"></div>
                </div>
            </div>
        </div>
        <%--右侧--%>
        <div class="threeRight">
            <div style="margin-top: 8px;font-weight: bold;font-size: 15px;margin-left: 2%;">
                <img src="/img/commonTheme/theme6/doctment.png" style="margin-top: -2px;width: 18px;"><span style="margin-left: 5px">公文</span>
            </div>
            <div class="layui-tab layui-tab-brief" lay-filter="publicFile" style="margin-left: 1%">
                <ul class="layui-tab-title">
                    <li class="layui-this">待办收文</li>
                    <li>待办发文</li>
                    <li>已办收文</li>
                    <li>已办发文</li>

                </ul>
                <div class="layui-tab-content" style="height: 287px; overflow-y: hidden;">
                    <div class="layui-tab-item layui-show daiAccept"></div>
                    <div class="layui-tab-item daiSendFile"></div>
                    <div class="layui-tab-item overAccept"></div>
                    <div class="layui-tab-item overSendFile"></div>

                </div>
            </div>
        </div>

    </div>

</div>
    <script>
        layui.use('carousel', function(){
            var carousel = layui.carousel;
            //建造实例
            var carouselIndex = carousel.render({
                elem: '#pictures'
                ,width: '96%' //设置容器宽度
                ,height:'325px'
                ,arrow: 'always' //始终显示箭头
                //,anim: 'updown' //切换动画方式
            });

            $.ajax({
                url: '/news/newsManage',
                type: 'get',
                data:{
                    page:'1',
                    read:'',
                    pageSize:'6',
                    useFlag:'true',
                    typeId:'',
                },
                dataType: 'json',
                success: function (obj) {
                    var types = $('.contain').attr('news');
                    if(types == '1'){
                        var li = '';
                        var data = obj.obj;
                        var str = ''
                        var domain = document.location.origin;
                        for (var i = 0; i < data.length; i++) {
                            if(data[i].attachment.length != 0){
                                var img=data[i].attachment[0].attachName.split('.')[1]
                                if(img == 'png'||img == 'jpg' || img == 'PNG'||img == 'JPG'){
                                    // $('#min').html('')
                                    str +='<div><img style="width: 98%;height: 310px;margin-top: 24px;margin-left: 2%;" src="'+domain+'/xs?' + data[i].attachment[0].attUrl + '"/>' +
                                    '<span class="imgTitle" style="position: absolute;color: white; bottom: 30px; left: 10%;font-size: 18px;text-align: center;width: 80%;" onclick="tiaozhuan(this)" data-url="/news/detail?newsId=' + data[i].newsId + '"> '+ data[i].subject +'</span></div>'
                                    $('#pictures').children('div').html(str);
                                    carouselIndex.reload({elem: '#pictures'});//重置轮播图
                                     // return
                                }else{
                                    var lis = '<div class="no_notice" style="text-align: center;border: none;">' +
                                    '<img style="margin-top: 62px;"  src="/img/main_img/shouyekong.png" alt="">' +
                                    '<h2 style="text-align: center;color: #666;">暂无图片新闻</h2>' +
                                    '</div>';
                                    $('#pictures').children('div').html(lis);

                                }
                                // if(data[i].attachment.length == 1){
                                //
                                // } else{
                                //     for(var j=0;j<data[i].attachment.length;j++){
                                //         if(data[i].attachment[j].attachName != undefined){
                                //             var img=data[i].attachment[j].attachName.split('.')[1]
                                //             if(img == 'png'||img == 'jpg'){
                                //                 // $('#min').html('')
                                //                 str +='<div><img style="width: 98%;height: 310px;margin-top: 24px;margin-left: 2%;" src="'+domain+'/xs?' + data[i].attachment[j].attUrl + '"/>' +
                                //                 '<span class="imgTitle" style="position: absolute;color: white; bottom: 30px; left: 10%;font-size: 18px;text-align: center;width: 80%;" onclick="tiaozhuan(this)" data-url="/news/detail?newsId=' + data[i].newsId + '"> '+ data[i].subject +'</span></div>'
                                //                 $('#pictures').children('div').html(str);
                                //                 carouselIndex.reload({elem: '#pictures'});//重置轮播图
                                //                 // return
                                //             }else{
                                //                 var lis = '<div class="no_notice" style="text-align: center;border: none;">' +
                                //                 '<img style="margin-top: 62px;"  src="/img/main_img/shouyekong.png" alt="">' +
                                //                 '<h2 style="text-align: center;color: #666;">暂无图片新闻</h2>' +
                                //                 '</div>';
                                //                 $('#pictures').children('div').html(str);
                                //             }
                                //         }
                                //
                                //     }
                                // }

                            }
                        }
                     }
                }

            });
    });
    </script>
    <script type="text/javascript">
        //待办工作
        $.ajax({
            type: 'get',
            url: '/workflow/work/selectWork',
            dataType: 'json',
            data:{
                page: 1,
                pageSize: 11,
                useFlag: true
            },
            success:function(res) {
                var data=res.obj
                var str=''
                var $str
                if(data.length>0){
                    for(var i=0;i<data.length;i++){
                        $str=$('<li style="display: flex" onclick ="js_methodDai(this)">'+
                            '<div class="works" style="width: 55%;">'+data[i].flowRun.runName +'</div>'+
                            '<div style="width: 17%;">'+data[i].flowRun.userName+'</div>'+
                            '<div>'+data[i].receiptTime+'</div>'+'</li>')
                        $str.data('data',data[i])
                        $('.daiWork').append($str)
                    }
                }else{
                    str += '<div class="noData" style="text-align: center;border: none;">' +
                    '<img  src="/img/main_img/shouyekong.png" alt="">' +
                    '<h6 style="text-align: center;color: #666;">'+'暂无数据'+'</h6>' +
                    '</div>';
                    $('.daiWork').append(str)
                }

            }
        })
        //办结工作
        $.ajax({
            type: 'post',
            url: '/workflow/work/selectEndWord',
            dataType: 'json',
            data:{
                page: 1,
                pageSize: 11,
                useFlag: true
            },
            success:function(res) {
                var data=res.obj
                var str=''
                var $str
                if(data.length>0){
                    for(var i=0;i<data.length;i++){
                        $str=$('<li style="display: flex" onclick ="js_method(this)">'+
                            '<div class="works" style="width: 55%;">'+data[i].runName+'</div>'+
                            '<div style="width: 17%;">'+data[i].flowRun.userName+'</div>'+
                            '<div>'+data[i].deliverTime+'</div>'+'</li>')
                        $str.data('data',data[i])
                        $('.overWork').append($str)
                    }
                }else{
                    str += '<div class="noData" style="text-align: center;border: none;">' +
                    '<img  src="/img/main_img/shouyekong.png" alt="">' +
                    '<h6 style="text-align: center;color: #666;">'+'暂无数据'+'</h6>' +
                    '</div>';
                    $('.overWork').append(str)
                }

            }
        })
        //全部工作
        $.ajax({
            type: 'post',
            url: '/workflow/work/selectAll',
            dataType: 'json',
            data:{
                page: 1,
                pageSize: 11,
                useFlag: true
            },
            success:function(res) {
                var data=res.obj
                var str=''
                var $str
                if(data.length>0){
                    for(var i=0;i<data.length;i++){
                        $str=$('<li style="display: flex" onclick ="js_method(this)">'+
                            '<div class="works" style="width: 55%;">'+data[i].flowRun.runName+'</div>'+
                            '<div style="width: 17%;">'+data[i].flowRun.userName+'</div>'+'</li>')
                        $str.data('data',data[i])
                        $('.threeLeft .allWorkShow').append($str)
                    }
                }else{
                    str += '<div class="noData" style="text-align: center;border: none;">' +
                    '<img  src="/img/main_img/shouyekong.png" alt="">' +
                    '<h6 style="text-align: center;color: #666;">'+'暂无数据'+'</h6>' +
                    '</div>';
                    $('.threeLeft .allWorkShow').append(str)
                }

            }
        })
        //委托工作
        $.ajax({
            type: 'post',
            url: '/workflow/work/entrustWorkList',
            dataType: 'json',
            data:{
                page: 1,
                pageSize: 11,
                useFlag: true,
                userId:$.cookie('userId')
            },
            success:function(res) {
                var data=res.obj
                var str=''
                var $str
                if(data.length>0){
                    for(var i=0;i<data.length;i++){
                        // $str=$('<li class="liucheng" style="display: flex" onclick ="js_method(this)">'+
                        // '<div class="works" style="width: 65%;height: 40px">'+
                        // '<h1 class="" style="font-size: 12px;">'+data[i].flowRun.userName+'</h1>'+
                        // '<h3 class="" style="color: #1b5e8d;font-size: 14px;"><p>'+data[i].flowRun.runName.split(' ')[0]+'</p></h3>' +
                        // '</div>'+
                        // // '<div style="width: 17%;">'+data[i].flowRun.userName+'</div>'+
                        // '</li>')
                        $str=$('<li style="display: flex" onclick ="js_method(this)">'+
                            '<div class="works" style="width: 55%;">'+data[i].flowRun.runName.split(' ')[0]+'</div>'+
                            '<div style="width: 17%;">'+data[i].flowRun.userName+'</div>'+'</li>')
                        $str.data('data',data[i])
                        $('.weiWork').append($str)
                    }
                }else{
                    str += '<div class="noData" style="text-align: center;border: none;">' +
                    '<img  src="/img/main_img/shouyekong.png" alt="">' +
                    '<h6 style="text-align: center;color: #666;">'+'暂无数据'+'</h6>' +
                    '</div>';
                    $('.weiWork').append(str)
                }

            }
        })
        //待办工作跳转
        function js_methodDai(data){
            var obj=$(data).data('data')
            // console.log($(data).data('data'))
            if (obj.opFlag == 1) {
                huiqian = 'zhuban';
            } else {
                huiqian = 'huiqian';
            }
            if(obj.sortMainType=='BUDGETTYPE'){
                window.open('/workflow/work/workform?opflag=' + obj.opFlag + '&flowId=' + obj.flowRun.flowId + '&prcsId=' + obj.flowProcess.prcsId + '&tableName=budget&flowStep=' + obj.prcsId
                + '&runId=' + obj.runId);
            }else{
                window.open('/workflow/work/workform?opflag=' + obj.opFlag + '&flowId=' + obj.flowRun.flowId + '&prcsId=' + obj.flowProcess.prcsId + '&flowStep=' + obj.prcsId
                + '&runId=' + obj.runId);
            }

            // if(obj.sortMainType=='BUDGETTYPE'){
            //     window.open('/workflow/work/workformPreView?flowId='+obj.flowRun.flowId+'&prcsId='+obj.flowPrcs+'&flowStep='+obj.prcsId+'&tableName=budget&runId='+obj.runId);
            // }else{
            //     window.open('/workflow/work/workformPreView?flowId='+obj.flowRun.flowId+'&prcsId='+obj.flowPrcs+'&flowStep='+obj.prcsId+'&runId='+obj.runId);
            // }
        }
        //办结工作跳转
        function js_method(data){
            var obj=$(data).data('data')
            // console.log($(data).data('data'))
            if(obj.sortMainType=='BUDGETTYPE'){
                window.open('/workflow/work/workformPreView?flowId='+obj.flowRun.flowId+'&prcsId='+obj.flowPrcs+'&flowStep='+obj.prcsId+'&tableName=budget&runId='+obj.runId);
            }else{
                window.open('/workflow/work/workformPreView?flowId='+obj.flowRun.flowId+'&prcsId='+obj.flowPrcs+'&flowStep='+obj.prcsId+'&runId='+obj.runId);
            }
        }

        //公告未读
        $.ajax({
            url:"/notice/notifyManage",
            type:'get',
            data:{
                read:0,
                page:1,
                pageSize:6,
                useFlag:'true',
                typeId:''
            },
            dataType:'json',
            success:function(obj) {

            var data = obj.obj;
            /*console.log(data);*/
            var str_li = '';
            var notice_li = '';
            for (var i = 0; i < data.length; i++) {
            var strnbsp = function(){
            if(data[i].notifyDateTime!=undefined){
                return data[i].notifyDateTime.split(/\s/g)[0]
            }else {
                return ''
            }
            }()

            str_li += '<li style="padding: 0 5px; box-sizing: border-box;white-space: nowrap;" class="chedule_li" onclick="tiaozhuan(this)" data-url="/notice/detail?notifyId=' + data[i].notifyId + '">' +
            '<a><div class="new_title richeng_title" title="' + data[i].subject + '">' + data[i].subject + '</div></a>' +
            '<div class="every_times" style="float: right;padding-right: 10px;">' +strnbsp+ '</div>' +
            '</li>'

            notice_li += '<a href="/notice/detail?notifyId=' + data[i].notifyId + '" style="color:#000;" class="public_title" target="_blank">' +
            '	<li class="tixing_one_all">' +
            '<div class="tixing_every">' +
            '<div class="company">' +
            '<img onerror="imgerror(this,1)"  src="'+function () {
            if(data[i].users.avatar != 0&&data[i].users.avatar != 1&&data[i].users.avatar != ''){
                return '/img/user/'+data[i].users.avatar;
            }
            if(data[i].users.sex == 0){
                return '/img/user/boy.png';
            }
            else if(data[i].users.sex == 1){
                return '/img/user/girl.png';
            }
            }()+'" alt="">' +
            '<h1>' + data[i].name + '</h1>' +
            '<h2 class="company_time" style="margin-left: 57px;">' + strnbsp + '</h2>' +
            '</div>' +
            '<h1 class="thing">请查看我的公告</h1>' +
            '<div class="liushuihao">' +
            '<h1>主题：</h1><' +
            'span>' + data[i].subject + '</span>' +
            '</div>' +
            '</div>' +
            '</li></a>';
            }

            $('.ggweidu').html(str_li);
                if(obj.obj.length==0) {
                var lis = '<div class="no_notice" style="text-align: center;border: none;">' +
                '<img style="margin-top: 62px;"  src="/img/main_img/shouyekong.png" alt="">' +
                '<h2 style="text-align: center;color: #666;">'+no_Data+'</h2>' +
                '</div>';
            $('.ggweidu').html(lis);
            }

            }
            })
        //公告已读
        $.ajax({
            url:"/notice/notifyManage",
            type:'get',
            data:{
                read:1,
                page:1,
                pageSize:6,
                useFlag:'true',
                typeId:''
            },
            dataType:'json',
            success:function(obj) {

            var data = obj.obj;
            var str_li = '';
            var notice_li = '';
            for (var i = 0; i < data.length; i++) {
            var strnbsp = function(){
            if(data[i].notifyDateTime!=undefined){
            return data[i].notifyDateTime.split(/\s/g)[0]
            }else {
                return ''
            }
            }()

            str_li += '<li style="padding: 0 5px; box-sizing: border-box;" class="chedule_li" onclick="tiaozhuan(this)" data-url="/notice/detail?notifyId=' + data[i].notifyId + '">' +
            '<a><div class="new_title richeng_title" title="' + data[i].subject + '">' + data[i].subject + '</div></a>' +
            '<div class="every_times" style="float: right;padding-right: 10px;">' +strnbsp+ '</div>' +
            '</li>'

            notice_li += '<a href="/notice/detail?notifyId=' + data[i].notifyId + '" style="color:#000;" class="public_title" target="_blank">' +
            '	<li class="tixing_one_all">' +
            '<div class="tixing_every">' +
            '<div class="company">' +
            '<img onerror="imgerror(this,1)"  src="'+function () {
            if(data[i].users.avatar != 0&&data[i].users.avatar != 1&&data[i].users.avatar != ''){
                return '/img/user/'+data[i].users.avatar;
            }
            if(data[i].users.sex == 0){
                return '/img/user/boy.png';
            }
            else if(data[i].users.sex == 1){
                return '/img/user/girl.png';
            }
            }()+'" alt="">' +
            '<h1>' + data[i].name + '</h1>' +
            '<h2 class="company_time" style="margin-left: 57px;">' + strnbsp + '</h2>' +
            '</div>' +
            '<h1 class="thing">请查看我的公告</h1>' +
            '<div class="liushuihao">' +
            '<h1>主题：</h1><' +
            'span>' + data[i].subject + '</span>' +
            '</div>' +
            '</div>' +
            '</li></a>';
            }

            $('.ggyidu').html(str_li);
            if(obj.obj.length==0) {
            var lis = '<div class="no_notice" style="text-align: center;border: none;">' +
            '<img style="margin-top: 62px;"  src="/img/main_img/shouyekong.png" alt="">' +
            '<h2 style="text-align: center;color: #666;">'+no_Data+'</h2>' +
            '</div>';
            $('.ggyidu').html(lis);
            }

            }
        })
        //公告全部
        $.ajax({
            url:"/notice/notifyManage",
            type:'get',
            data:{
                read:'',
                page:1,
                pageSize:6,
                useFlag:'true',
                typeId:''
            },
            dataType:'json',
            success:function(obj) {
                var data = obj.obj;
                var str_li = '';
                var notice_li = '';
                for (var i = 0; i < data.length; i++) {
                var strnbsp = function(){
                if(data[i].notifyDateTime!=undefined){
                return data[i].notifyDateTime.split(/\s/g)[0]
                }else {
                return ''
                }
                }()

                str_li += '<li style="padding: 0 5px; box-sizing: border-box;" class="chedule_li" onclick="tiaozhuan(this)" data-url="/notice/detail?notifyId=' + data[i].notifyId + '">' +
                '<a><div class="new_title richeng_title" title="' + data[i].subject + '">' + data[i].subject + '</div></a>' +
                '<div class="every_times" style="float: right;padding-right: 10px;">' +strnbsp+ '</div>' +
                '</li>'

                notice_li += '<a href="/notice/detail?notifyId=' + data[i].notifyId + '" style="color:#000;" class="public_title" target="_blank">' +
                '	<li class="tixing_one_all">' +
                '<div class="tixing_every">' +
                '<div class="company">' +
                '<img onerror="imgerror(this,1)"  src="'+function () {
                if(data[i].users.avatar != 0&&data[i].users.avatar != 1&&data[i].users.avatar != ''){
                    return '/img/user/'+data[i].users.avatar;
                }
                if(data[i].users.sex == 0){
                    return '/img/user/boy.png';
                }
                else if(data[i].users.sex == 1){
                    return '/img/user/girl.png';
                }
                }()+'" alt="">' +
                '<h1>' + data[i].name + '</h1>' +
                '<h2 class="company_time" style="margin-left: 57px;">' + strnbsp + '</h2>' +
                '</div>' +
                '<h1 class="thing">请查看我的公告</h1>' +
                '<div class="liushuihao">' +
                '<h1>主题：</h1><' +
                'span>' + data[i].subject + '</span>' +
                '</div>' +
                '</div>' +
                '</li></a>';
                }
                $('.ggquanbu').html(str_li);

                if(obj.obj.length==0) {
                var lis = '<div class="no_notice" style="text-align: center;border: none;">' +
                '<img style="margin-top: 62px;"  src="/img/main_img/shouyekong.png" alt="">' +
                '<h2 style="text-align: center;color: #666;">'+no_Data+'</h2>' +
                '</div>';
                $('.ggquanbu').html(lis);
                }
            }
        })

    //待办发文
    $.ajax({
        url: '/document/selWillDocSendOrReceive?documentType=0 ',
        type: 'get',
        data:{
            page:1,
            pageSize:5,
            useFlag:true,
            printDate:'',
            dispatchType:'',
            title:'',
            docStatus:'',
            flowId:''
        },
        dataType: 'json',
        success: function (obj) {
            var str='';
            var data=obj.datas;
            if(data.length>0){
                for(var i=0;i<data.length;i++){
                    var url = '/workflow/work/workform?&flowId='+data[i].flowId+'&prcsId='+data[i].realPrcsId+'&flowStep='+data[i].step
                    +'&runId='+data[i].runId+'&tabId='+data[i].id+'&tableName='+data[i].tableName+'&isNomalType=false&hidden=true&opFlag='+data[i].opFlag;
                    str += '<li data-s="1" style="padding: 0 5px; box-sizing: border-box;" class="no_readss clearfix" onclick="tiaozhuan(this)" data-url="'+url+'">' +
                    '<div class="" style="margin: 0;width: 100%;">' +
                    '<div class="e_img" style="margin-right: 5px;">' +
                        '<img style="margin-left: 5px;" onerror="imgerror(this,1)" src="'+ function () {
                        if(data[i].avatar != 0&&data[i].avatar != 1&&data[i].avatar != ''){
                            return '/img/user/'+data[i].avatar;
                        }
                        if(data[i].sex == 0){
                            return '/img/user/boy.png';
                        }
                        else if(data[i].sex == 1){
                            return '/img/user/girl.png';
                        }
                        }()+'">' +
                    '</div>' +
                    '<div class="fileWord">' +
                        '<h1 class="n_name">'+data[i].createrName+'</h1>' +
                        '<h3 class="n_time" style="float: right;width: auto;font-size: 11pt;padding: 15px 3px 15px 10px;"><p>'+function(){
                        if(data[i].createTime.indexOf('.') > -1){
                            if(data[i].createTime.indexOf(' ') > -1){
                                return data[i].createTime.split(' ')[0];
                            }else{
                                return data[i].createTime;
                            }
                        }else{
                            return '';
                        }
                        }()+'</p></h3>' +
                        '<a data-url="" class="windowopen"  style="color:#1b5e8d;display: inline-block;width: 55%" class="public_title" target="_blank">' +
                        '<h2 style="font-size: 8px; color: #1b5e8d;width: 300px" emil-tid="'+data[i].title+'" class="e_title" title="'+data[i].title+'">'+data[i].title+'</h2>' +
                        '</a>' +
                    '</div>' +
                    '</div>' +
                    '</li>'
                }
            }
            $('.daiSendFile').html(str);
            if(data.length==0) {
                var lis = '<div class="no_notice" style="text-align: center;border: none;">' +
                '<img style="margin-top: 62px;"  src="/img/main_img/shouyekong.png" alt="">' +
                '<h2 style="text-align: center;color: #666;">'+no_Data+'</h2>' +
                '</div>';
                $('.daiSendFile').html(lis);
            }
        }
    });

    //待办收文
    $.ajax({
    url: '/document/selWillDocSendOrReceive?documentType=1',
    type: 'get',
    data:{
    page:1,
    pageSize:5,
    useFlag:true,
    printDate:'',
    dispatchType:'',
    title:'',
    docStatus:'',
    flowId:''
    },
    dataType: 'json',
    success: function (obj) {
    var str='';
    var data=obj.datas;
    if(data.length>0){
    for(var i=0;i<data.length;i++){
    var url = '/workflow/work/workform?&flowId='+data[i].flowId+'&prcsId='+data[i].realPrcsId+'&flowStep='+data[i].step
    +'&runId='+data[i].runId+'&tabId='+data[i].id+'&tableName='+data[i].tableName+'&isNomalType=false&hidden=true&opFlag='+data[i].opFlag;
    str += '<li data-s="1" style="padding: 0 5px; box-sizing: border-box;" class="no_readss clearfix" onclick="tiaozhuan(this)" data-url="'+url+'">' +
    '<div class="" style="margin: 0;width: 100%;">' +
    '<div class="e_img" style="margin-right: 5px;">' +
    '<img style="margin-left: 5px;" onerror="imgerror(this,1)" src="'+ function () {
    if(data[i].avatar != 0&&data[i].avatar != 1&&data[i].avatar != ''){
    return '/img/user/'+data[i].avatar;
    }
    if(data[i].sex == 0){
    return '/img/user/boy.png';
    }
    else if(data[i].sex == 1){
    return '/img/user/girl.png';
    }
    }()+'">' +
    '</div>' +
    '<div class="fileWord">' +
    '<h1 class="n_name">'+data[i].createrName+'</h1>' +
    '<h3 class="n_time" style="float: right;width: auto;font-size: 11pt;padding: 15px 3px 15px 10px;"><p>'+function(){
    if(data[i].createTime.indexOf('.') > -1){
    if(data[i].createTime.indexOf(' ') > -1){
    return data[i].createTime.split(' ')[0];
    }else{
    return data[i].createTime;
    }
    }else{
    return '';
    }
    }()+'</p></h3>' +
    '<a data-url="" class="windowopen"  style="color:#1b5e8d;display: inline-block;width: 55%" class="public_title" target="_blank">' +
    '<h2 style="font-size: 8px; color: #1b5e8d;width: 300px" emil-tid="'+data[i].title+'" class="e_title" title="'+data[i].title+'">'+data[i].title+'</h2>' +
    '</a>' +
    '</div>' +
    '</div>' +
    '</li>'
    }
    }


    $('.daiAccept').html(str);
    if(data.length==0) {
    var lis = '<div class="no_notice" style="text-align: center;border: none;">' +
    '<img style="margin-top: 62px;"  src="/img/main_img/shouyekong.png" alt="">' +
    '<h2 style="text-align: center;color: #666;">'+no_Data+'</h2>' +
    '</div>';
    $('.daiAccept').html(lis);
    }
    }
    });


    //已办发文
    $.ajax({
    url: '/document/selOverDocSendOrReceive?documentType=0 ',
    type: 'get',
    data:{
    page:1,
    pageSize:5,
    useFlag:true,
    printDate:'',
    dispatchType:'',
    title:'',
    docStatus:'',
    flowId:''
    },
    dataType: 'json',
    success: function (obj) {
    var str='';
    var data=obj.datas;
    if(data.length>0){
    for(var i=0;i<data.length;i++){
    var url = '/workflow/work/workformPreView?&flowId='+data[i].flowId+'&prcsId='+data[i].realPrcsId+'&flowStep='+data[i].step
    +'&runId='+data[i].runId+'&tabId='+data[i].id+'&tableName='+data[i].tableName+'&isNomalType=false&hidden=true&opFlag='+data[i].opFlag;
    str += '<li data-s="1" style="padding: 0 5px; box-sizing: border-box;" class="no_readss clearfix" onclick="tiaozhuan(this)" data-url="'+url+'">' +
    '<div class="" style="margin: 0;width: 100%;">' +
    '<div class="e_img" style="margin-right: 5px;">' +
    '<img style="margin-left: 5px;" onerror="imgerror(this,1)" src="'+ function () {
    if(data[i].avatar != 0&&data[i].avatar != 1&&data[i].avatar != ''){
    return '/img/user/'+data[i].avatar;
    }
    if(data[i].sex == 0){
    return '/img/user/boy.png';
    }
    else if(data[i].sex == 1){
    return '/img/user/girl.png';
    }
    }()+'">' +
    '</div>' +
    '<div class="fileWord">' +
    '<h1 class="n_name">'+data[i].createrName+'</h1>' +
    '<h3 class="n_time" style="float: right;width: auto;font-size: 11pt;padding: 15px 3px 15px 10px;"><p>'+function(){
    if(data[i].createTime.indexOf('.') > -1){
    if(data[i].createTime.indexOf(' ') > -1){
    return data[i].createTime.split(' ')[0];
    }else{
    return data[i].createTime;
    }
    }else{
    return '';
    }
    }()+'</p></h3>' +
    '<a data-url="" class="windowopen"  style="color:#1b5e8d;display: inline-block;width: 55%;" class="public_title" target="_blank">' +
    '<h2 style="font-size: 8px; color: #1b5e8d;width: 300px" emil-tid="'+data[i].title+'" class="e_title" title="'+data[i].title+'">'+data[i].title+'</h2>' +
    '</a>' +
    '</div>' +
    '</div>' +
    '</li>'
    }
    }


    $('.overSendFile').html(str);
    if(data.length==0) {
    var lis = '<div class="no_notice" style="text-align: center;border: none;">' +
    '<img style="margin-top: 62px;"  src="/img/main_img/shouyekong.png" alt="">' +
    '<h2 style="text-align: center;color: #666;">'+no_Data+'</h2>' +
    '</div>';
    $('.overSendFile').html(lis);
    }
    }
    });

    //已办收文
    $.ajax({
    url: '/document/selOverDocSendOrReceive?documentType=1 ',
    type: 'get',
    data:{
    page:1,
    pageSize:5,
    useFlag:true,
    printDate:'',
    dispatchType:'',
    title:'',
    docStatus:'',
    flowId:''
    },
    dataType: 'json',
    success: function (obj) {
    var str='';
    var data=obj.datas;
    if(data.length>0){
    for(var i=0;i<data.length;i++){
    var url = '/workflow/work/workformPreView?&flowId='+data[i].flowId+'&prcsId='+data[i].realPrcsId+'&flowStep='+data[i].step
    +'&runId='+data[i].runId+'&tabId='+data[i].id+'&tableName='+data[i].tableName+'&isNomalType=false&hidden=true&opFlag='+data[i].opFlag;
    str += '<li data-s="1" style="padding: 0 5px; box-sizing: border-box;" class="no_readss clearfix" onclick="tiaozhuan(this)" data-url="'+url+'">' +
    '<div class="" style="margin: 0;width: 100%;">' +
    '<div class="e_img" id="e_img" style="margin-right: 5px;">' +
    '<img style="margin-left: 5px;" onerror="imgerror(this,1)" src="'+ function () {
    if(data[i].avatar != 0&&data[i].avatar != 1&&data[i].avatar != ''){
    return '/img/user/'+data[i].avatar;
    }
    if(data[i].sex == 0){
    return '/img/user/boy.png';
    }
    else if(data[i].sex == 1){
    return '/img/user/girl.png';
    }
    }()+'">' +
    '</div>' +
    '<div class="fileWord">' +
    '<h1 class="n_name">'+data[i].createrName+'</h1>' +
    '<h3 class="n_time" style="float: right;width: auto;font-size: 11pt;padding: 15px 3px 15px 10px;"><p>'+function(){
    if(data[i].createTime.indexOf('.') > -1){
    if(data[i].createTime.indexOf(' ') > -1){
    return data[i].createTime.split(' ')[0];
    }else{
    return data[i].createTime;
    }
    }else{
    return '';
    }
    }()+'</p></h3>' +
    '<a data-url="" class="windowopen"  style="color:#1b5e8d;display: inline-block;width: 55%" class="public_title" target="_blank">' +
    '<h2 style="font-size: 8px; color: #1b5e8d;width: 300px" emil-tid="'+data[i].title+'" class="e_title" title="'+data[i].title+'">'+data[i].title+'</h2>' +
    '</a>' +
    '</div>' +
    '</div>' +
    '</li>'
    }
    }


    $('.overAccept').html(str);
    if(data.length==0) {
    var lis = '<div class="no_notice" style="text-align: center;border: none;">' +
    '<img style="margin-top: 62px;"  src="/img/main_img/shouyekong.png" alt="">' +
    '<h2 style="text-align: center;color: #666;">'+no_Data+'</h2>' +
    '</div>';
    $('.overAccept').html(lis);
    }
    }
    });

        //新闻
        var no_Data='暂无数据';
        $.ajax({
            url: '/news/newsManage',
            type: 'get',
            data:{
                page:'1',
                read:0,
                pageSize:'6',
                useFlag:'true',
                typeId:'',
            },
            dataType: 'json',
            success: function (obj) {
            var li = '';
            var data = obj.obj;
            for (var i = 0; i < data.length; i++) {
            li += '<li class="chedule_li" onclick="tiaozhuan(this)" data-url="/news/detail?newsId='+data[i].newsId+'">' +
            '<a><div class="new_title richeng_title" title="' + data[i].subject + '">' + data[i].subject + '</div></a>' +
            '<div class="every_times" style="float: right;padding-right: 10px;">' +function () {

            if(data[i].newsDateTime!=undefined){
            return data[i].newsDateTime.split(/\s/g)[0];
            }else {
            return ''
            }


            }()  + '</div>' +
            '</li>'
            }
             $('.xwweidu').html(li);
            if(obj.obj.length==0) {
            var lis = '<div class="no_notice" style="text-align: center;border: none;">' +
            '<img style="margin-top: 62px;"  src="/img/main_img/shouyekong.png" alt="">' +
            '<h2 style="text-align: center;color: #666;">暂无数据</h2>' +
            '</div>';
            $('.xwweidu').html(lis);
            }
            }
        });
        $.ajax({
            url: '/news/newsManage',
            type: 'get',
            data:{
                page:'1',
                read:1,
                pageSize:'6',
                useFlag:'true',
                typeId:'',
            },
            dataType: 'json',
            success: function (obj) {

            var li = '';
            var data = obj.obj;
            for (var i = 0; i < data.length; i++) {
            li += '<li class="chedule_li" onclick="tiaozhuan(this)" data-url="/news/detail?newsId='+data[i].newsId+'">' +
            '<a><div class="new_title richeng_title" title="' + data[i].subject + '">' + data[i].subject + '</div></a>' +
            '<div class="every_times" style="float: right;padding-right: 10px;">' +function () {

            if(data[i].newsDateTime!=undefined){
            return data[i].newsDateTime.split(/\s/g)[0];
            }else {
            return ''
            }


            }()  + '</div>' +
            '</li>'
            }
            $('.xwyidu').html(li);
            if(obj.obj.length==0) {
            var lis = '<div class="no_notice" style="text-align: center;border: none;">' +
            '<img style="margin-top: 62px;"  src="/img/main_img/shouyekong.png" alt="">' +
            '<h2 style="text-align: center;color: #666;">'+no_Data+'</h2>' +
            '</div>';
            $('.xwyidu').html(lis);
            }


            }
        });
        $.ajax({
            url: '/news/newsManage',
            type: 'get',
            data:{
            page:'1',
            read:'',
            pageSize:'6',
            useFlag:'true',
            typeId:'',
            },
            dataType: 'json',
            success: function (obj) {
                var types = $('.contain').attr('news');

                var li = '';
                var data = obj.obj;
                for (var i = 0; i < data.length; i++) {
                li += '<li class="chedule_li" onclick="tiaozhuan(this)" data-url="/news/detail?newsId='+data[i].newsId+'">' +
                '<a><div class="new_title richeng_title" title="' + data[i].subject + '">' + data[i].subject + '</div></a>' +
                '<div class="every_times" style="float: right;padding-right: 10px;">' +function () {

                if(data[i].newsDateTime!=undefined){
                return data[i].newsDateTime.split(/\s/g)[0];
                }else {
                return ''
                }


                }()  + '</div>' +
                '</li>'
                }
                $('.xwquanbu').html(li);
                if(obj.obj.length==0) {
                var lis = '<div class="no_notice" style="text-align: center;border: none;">' +
                '<img style="margin-top: 62px;"  src="/img/main_img/shouyekong.png" alt="">' +
                '<h2 style="text-align: center;color: #666;">'+no_Data+'</h2>' +
                '</div>';
                $('.xwquanbu').html(lis);
                }
            }

        });


        //邮件
        $.ajax({
            url:'/email/newShowEmail',
            type:'get',
            data:{
                flag:'inbox',
                page:1,
                pageSize:5,
                useFlag:'true',
                // userID:'admin'
            },
            dataType:'json',
            success:function(obj){
            if(obj.flag) {
            var data = obj.obj;
            var li = '';
            var read_li = '';
            var all_li = '';
            var email_li = '';
            for (var i = 0; i < data.length; i++) {
            for (var j = 0; j < data[i].emailList.length; j++) {
            if(data[i].users != undefined){
            var sendTime = new Date((data[i].sendTime) * 1000).Format('yyyy-MM-dd hh:mm:ss');
            if (data[i].emailList[j].readFlag == 0) {
            var sendTime = new Date((data[i].sendTime) * 1000).Format('yyyy-MM-dd  hh:mm:ss');
            li += '<li class="no_read" onclick="tiaozhuan(this)" data-url="/email/emailDetail?id=' + data[i].emailList[j].emailId + '"><div class="e_img"><img onerror="imgerror(this,1)" src="'+function () {
            if(data[i].users.avatar != 0&&data[i].users.avatar != 1&&data[i].users.avatar != ''){
            return '/img/user/'+data[i].users.avatar;
            }
            if(data[i].users.sex == 0){
            return '/img/user/boy.png';
            }
            else if(data[i].users.sex == 1){
            return '/img/user/girl.png';
            }
            }()+'"></div><div class="e_word"><h1 class="e_name" data-userId="'+data[i].users.userId+'">' + data[i].users.userName + '</h1>' +
            '<h3 class="e_time">' + sendTime.replace(/\s/g, '<i style="margin-right:10px;"></i>') + '</h3>' +
            '<a style="color:#1b5e8d;" class="public_title" target="_blank">' +
            '<h2 style="font-size: 8px; color: #1b5e8d;" emil-tid="' + data[i].emailList[j].emailId + '" ' +
            'class="e_title" title="' + data[i].subject + '">' + data[i].subject + '</h2></a>' +
            ''+function () {
            if(data[i].attachmentId==''){
            return ''
            }else {
            return '<img  class="accessory" src="/img/main_img/accessory.png" alt="">'
            }
            }()+'</div></li>'
            } else if (data[i].emailList[j].readFlag == 1) {
            var sendTime = new Date((data[i].sendTime) * 1000).Format('yyyy-MM-dd hh:mm:ss');
            read_li += '<li onclick="tiaozhuan(this)" data-url="/email/emailDetail?id=' + data[i].emailList[j].emailId + '"><div class="e_img"><img onerror="imgerror(this,1)" src="'+function () {
            if(data[i].users.avatar != 0&&data[i].users.avatar != 1&&data[i].users.avatar != ''){
            return '/img/user/'+data[i].users.avatar;
            }
            if(data[i].users.sex == 0){
            return '/img/user/boy.png';
            }
            else if(data[i].users.sex == 1){
            return '/img/user/girl.png';
            }
            }()+'"></div>' +
            '<div class="e_word">' +
            '<h1 class="e_name" data-userName="'+data[i].users.userName+'" data-userId="'+data[i].users.userId+'">' + data[i].users.userName + '</h1>' +
            '<h3 class="e_time">' + sendTime.replace(/\s/g, '<i style="margin-right:10px;"></i>') + '</h3>' +
            '<a style="color:#1b5e8d;" class="public_title" target="_blank"><h2 style="font-size: 8px; color: #1b5e8d;" emil-tid="' + data[i].emailList[j].emailId + '" class="e_title" title="' + data[i].subject + '">' + data[i].subject + '</h2></a>' +
            ''+function () {
            if(data[i].attachmentId==''){
            return ''
            }else {
            return '<img  class="accessory" src="/img/main_img/accessory.png" alt="">'
            }
            }()+'</div></li>'
            }
            var sendTimews = new Date((data[i].sendTime) * 1000).Format('yyyy-MM-dd hh:mm:ss');
            all_li += '<li onclick="tiaozhuan(this)" data-url="/email/emailDetail?id=' + data[i].emailList[j].emailId + '"><div class="e_img">' +
            '<img onerror="imgerror(this,1)" src="'+function () {
            if(data[i].users.avatar != 0&&data[i].users.avatar != 1&&data[i].users.avatar != ''){
            return '/img/user/'+data[i].users.avatar;
            }
            if(data[i].users.sex == 0){
                return '/img/user/boy.png';
            }
            else if(data[i].users.sex == 1){
                return '/img/user/girl.png';
            }
            }()+'">' +
            '</div><div class="e_word"><h1 class="e_name" data-userName="'+data[i].users.userName+'" data-userId="'+data[i].users.userId+'">' +data[i].users.userName + '</h1><h3 class="e_time">' + sendTimews.replace(/\s/g, '<i style="margin-right:10px;"></i>') + '</h3><a style="color:#1b5e8d;" class="public_title" target="_blank"><h2 style="font-size: 8px; color: #1b5e8d;" emil-tid="' + data[i].emailList[j].emailId + '" class="e_title" title="' + data[i].subject + '">' + data[i].subject + '</h2></a>' +
            ''+function () {
                if(data[i].attachmentId==''){
                    return ''
                }else {
                    return '<img  class="accessory" src="/img/main_img/accessory.png" alt="">'
                }
             }()+'</div></li>'

            email_li += '	<li class="tixing_one_all" onclick="tiaozhuan(this)" data-url="/email/emailDetail?id=' + data[i].emailList[j].emailId + '"><div class="tixing_every"><div class="company">' +
            '<img onerror="imgerror(this,1)" src="'+function () {
            if(data[i].users.avater != 0&&data[i].users.avater != 1&&data[i].users.avater != ''){
                return '/img/user/'+data[i].users.avater;
            }
            if(data[i].users.sex == 0){
                return '/img/user/boy.png';
            }
            else if(data[i].users.sex == 1){
                return '/img/user/girl.png';
            }
                }()+'" alt=""><h1>' + data[i].emailList[j].toName + '</h1><h2 class="company_time" style="margin-left: 88px;">' + sendTime + '</h2>' +
                '</div><a style="color:#1b5e8d;" class="public_title" target="_blank"><h1 class="thing">请查看我的邮件</h1><div class="liushuihao"><h1>主题：</h1><span>' + data[i].subject + '</span></div></a>' +
                '</div></li>';
                }
                }
                }
                $('.yjquanbu').html(all_li);
                $('.yjyidu').html(read_li);
                $('.yjweidu').html(li);
            if(li==''){
                var lis = '<div class="no_notice" style="text-align: center;border: none;">' +
                '<img style="margin-top: 62px;"  src="/img/main_img/shouyekong.png" alt="">' +
                '<h2 style="text-align: center;color: #666;">'+no_Data+'</h2>' +
                '</div>';
                $('.yjweidu').html(lis);
            }
            if(all_li=='') {
                var lis = '<div class="no_notice" style="text-align: center;border: none;">' +
                '<img style="margin-top: 62px;"  src="/img/main_img/shouyekong.png" alt="">' +
                '<h2 style="text-align: center;color: #666;">'+no_Data+'</h2>' +
                '</div>';
                $('.yjquanbu').html(lis);
            }
            }else {
                var lis = '<div class="no_notice" style="text-align: center;border: none;">' +
                '<img style="margin-top: 62px;"  src="/img/main_img/shouyekong.png" alt="">' +
                '<h2 style="text-align: center;color: #666;">'+no_Data+'</h2>' +
                '</div>';
                $('.yjquanbu').html(lis);
                $('.yjyidu').html(lis);
                $('.yjweidu').html(lis);
            }
            }
        })
        //图片新闻



    </script>
</body>
</html>
