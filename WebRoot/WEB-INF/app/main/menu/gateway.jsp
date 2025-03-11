    <%--
   Created by IntelliJ IDEA.
   User: mr.circle
   Date: 2021/3/24
   Time: 16:12 下午
   To change this template use File | Settings | File Templates.
 --%>
        <%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>工作门户</title>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <link rel="stylesheet" href="/lib/layui/layui/css/eleTree.css?2019101815.40">
    <link rel="stylesheet" href="/lib/layui/layui/css/treeTable.css?2019101815.17">
    <link rel="stylesheet" href="/lib/layui/layui/css/layui.css?20210319.1">
    <link rel="stylesheet" href="/lib/layui/layui/css/modules/layer/default/layer.css">
    <link rel="stylesheet" type="text/css" href="/css/main/${sessionScope.InterfaceModel}/cont.css"/>

    <link rel="stylesheet" href="/lib/layui/layui/css/layui.css?20210319.1">
    <link rel="stylesheet" href="/css/main/gateway.css">
    <script type="text/javascript" src="/js/xoajq/xoajq1.js"></script>
    <script type="text/javascript" src="/lib/layui/layui/layui.js"></script>
    <script type="text/javascript" src="/lib/layui/layui/layui.all.js"></script>
    <script type="text/javascript" src="../../js/xoajq/xoajq3.js"></script>
    <script type="text/javascript" src="../../js/base/base.js"></script>
    <script type="text/javascript" src="/js/main_js/index.js?20210430.1"></script>
    <script type="text/javascript" src="/js/base/base.js"></script>
    <script type="text/javascript" src="/lib/layui/layui/global.js"></script>
    <script type="text/javascript" src="/js/jquery/jquery.cookie.js"></script>
    <script type="text/javascript" src="/js/calendar.js"></script>
    <script type="text/javascript" src="/js/main_js/intranetRed.js?20190912.3"></script>
    <script type="text/javascript" src="/js/echarts.min.js"></script>

</head>
        <style>
        #apply ul li{
        width:35%;
        margin:0 7%;
        }
        #containerHetong div{
        width: inherit;
        }
        .e_img, .e_wo{
        float: none;
        }
        .yjquanbu li{
        display: flex;
        height: 40px;
        line-height: 40px;
        margin-bottom: 10px;
        }
        .yjyidu li{
        display: flex;
        height: 40px;
        line-height: 40px;
        margin-bottom: 10px;
        }
        .card{
        margin-top: 8px;
        }
        .yjweidu li{
        display: flex;
        height: 40px;
        line-height: 40px;
        margin-bottom: 10px;
        }
        .e_img img, .d_img img, .n_img img{
        width: 38px;
        height: 38px;
        margin-top: 5px;
        }
        </style>
<body>
<div class="box" style="height: 100%;overflow:auto;margin-left: 10px;">
        <div class="home-row">
<%--        1--%>
            <div class="card" id="apply">
                <div class="title">
                    <div class="title-text-wrap">
                         <div class="text ellipsis">申请</div>
                    </div>
                </div>
                <ul>
                    <li val="apply-1">
                        <div class="apply-img fastItem" opttype="140" url="/workflow/work/newflowguider?flowId=140&flowStep=1&prcsId=1">
                            <img      src="/img/menu/rest.png" alt="请假申请">
                        </div>
                        <div class="apply-text">请假申请</div>
                    </li>
                    <li val="apply-2">
                        <div class="apply-img fastItem" opttype="141" url="/workflow/work/newflowguider?flowId=141&flowStep=1&prcsId=1">
                        <img src="/img/menu/working_on_laptop.png"        alt="加班申请">
                        </div>
                        <div class="apply-text">加班申请</div>
                    </li>
                    <li val="apply-3 fastItem" opttype="142" url="/workflow/work/newflowguider?flowId=143&flowStep=1&prcsId=1">
                        <div class="apply-img">
                        <img src="/img/menu/briefcase.png"        alt="外出申请">
                        </div>
                        <div class="apply-text">外出申请</div>
                    </li>
                    <li val="apply-4">
                        <div class="apply-img fastItem" opttype="143" url="/workflow/work/newflowguider?flowId=142&flowStep=1&prcsId=1">
                        <img src="/img/menu/airplaneFast.png"        alt="出差申请">
                        </div>
                        <div class="apply-text">出差申请</div>
                    </li>
                    <li val="apply-1">
                        <div class="apply-img fastItem" opttype="167" url="/workflow/work/newflowguider?flowId=167&flowStep=1&prcsId=1">
                        <img      src="/img/menu/money.png" alt="费用报销">
                        </div>
                        <div class="apply-text">费用报销</div>
                    </li>
                        <li val="apply-2">
                        <div class="apply-img fastItem" opttype="146" url="/workflow/work/newflowguider?flowId=146&flowStep=1&prcsId=1">
                        <img src="/img/menu/tiaoxin.png"        alt="调薪申请">
                        </div>
                        <div class="apply-text">调薪申请</div>
                    </li>
                </ul>
            </div>
<%--2--%>
            <div class="card" id="weather">
                <div class="weather">
                    <div class="timeDate" style="">
                        <span class="time" id="time"></span>
                        <p>
                            <span class="date" id="date"></span>
                            <span class="week"></span>
                        </p>
                    </div>
                    <div class="weatherC" style="margin-top: 12px;text-align: right">
                        <p style="margin-left: 10px;text-align: left" class=" area"></p>
                        <p class="weatherImg" style="text-align: center">
                            <img src="" alt="" style="width:50%;margin-top: 20px">
                        </p>
                        <p class="du"></p>
                        <p class="center1 weatherText" style="margin-top: 5px;"></p>
                        <p class="center1" style="margin-top: 5px;">  <span class="zl"></span><span class="zlNum"></span></p>
                    </div>
                </div>
            </div>

<%--3--%>
            <div>
                    <div class="layui-tab layui-tab-brief" lay-filter="docDemoTabBrief"  id="email" style="width: 71%;margin-left: 16.3%;">
                        <ul class="layui-tab-title">
                            <li class="layui-this">全部邮件</li>
                            <li>未读邮件</li>
                            <li>已读邮件</li>
                        </ul>
                        <div class="layui-tab-content" style="height: 300px;overflow-y: auto">
                            <div class="layui-tab-item layui-show" >
                                <ul class="yjquanbu " id="email0" style="margin-left: -5px;margin-top: -4px;">
                                </ul>
                            </div>
                            <div class="layui-tab-item">
                                <ul class="buttommai-main no_read yjweidu " id="new" style="">

                                </ul>
                            </div>
                            <div class="layui-tab-item">
                                <ul class="buttommai-main no_read yjyidu" id="new1" style="">

                                </ul>
                            </div>

                        </div>
                    </div>
            </div>
        </div>



        <div class="home-row clearfix" style="height:auto;display: flex">
            <div style="display: flex;width: 87.8%;flex-wrap: wrap;">
<%--        1--%>
                <div id="workflow" class="pull-left" style="width: 43.5%;margin-right: 0;margin-top: 0px!important;">
                    <div class="other-button">
                        <span class="td-iconfont td-icon-pandianzhujiemian" title="我的工作"></span>
                    </div>
                    <div class="card">
                        <div style="display: flex;margin-top: 10px;">
                            <%--左侧--%>
                            <div class="threeLeft" style="width: 100%">
                                <div class="layui-tab layui-tab-brief" lay-filter="docDemoTabBrief">
                                    <ul class="layui-tab-title">
                                        <li class="layui-this">待办工作</li>
                                        <li>办结工作</li>
                                        <li>全部工作</li>
                                        <li>委托工作</li>
                                    </ul>
                                    <div class="layui-tab-content" style="">
                                        <div class="layui-tab-item layui-show daiWork"></div>
                                        <div class="layui-tab-item overWork"></div>
                                        <div class="layui-tab-item allWorkShow"></div>
                                        <div class="layui-tab-item weiWork"></div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
<%--        2--%>
                <div style="padding-top: 15px;background: #FFFFFF;height: 349px;width: 27%;margin-top:5px;margin: 5px 0.5% 0;">
                    <div id="demo" style="height: 336px;">
                        <div id="ca" style="margin: 0 auto;    height: 336px !important;position: relative"></div>
                    </div>
                </div>
<%--        3--%>

                <div style="background: #FFFFFF;height: 349px;    width: 27.5%;  margin-top: 5px;">
                     <div id="containerHetong" style="width:100%;height:100%;"></div>
                </div>
<%--4公共文件柜--%>
                <div id="filefolder" class="pull-left" style="width: 34%">
                    <div class="card">
                        <div class="title"><div class="other-button" title="公共文件柜"><span class="td-iconfont td-icon-pandianzhujiemian"></span></div>
                            <div class="title-text-wrap">
                                 <div class="text ellipsis">公共文件柜</div>
                            </div>
                        </div>
                        <div class="content">
                             <ul class="Management"></ul>
                        </div>
                    </div>
                </div>

<%--5--%>
                <div id="news" class="pull-left" style="width: 30%">
                    <div class="card">
                        <div class="title">
                            <div class="other-button" title="新闻">
                                <span class="td-iconfont td-icon-pandianzhujiemian"></span>
                            </div>
                            <div class="title-text-wrap">
                                <div class="text ellipsis">新闻</div>
                            </div>
                        </div>
                        <ul class="buttommai-main" id="newsZ">

                        </ul>
                    </div>
                </div>


                <%--         公告   --%>
                <div id="news" class="pull-left" style="width: 33.8%;margin-right: 0;">
                    <div class="card">
                        <div class="title">
                            <div class="other-button" title="公告">
                                 <span class="td-iconfont td-icon-pandianzhujiemian"></span>
                            </div>
                            <div class="title-text-wrap">
                                 <div class="text ellipsis">公告</div>
                            </div>
                        </div>
                        <ul class="buttommai-main" id="new2">

                        </ul>
                    </div>
                </div>


            </div>
<%--        常用--%>
            <div style="width: 11.4%;margin-left: 5px;background: white;    border: 1px solid #e5e5e5;">
                <div class="card pull-right" id="common" style="width: 100%;border:none">
                    <div class="title">
                        <div class="title-text-wrap">
                            <div class="text ellipsis">常用</div>
                        </div>
                    </div>
                    <ul class="clearfix" id="clearfixC" style="height: 620px;overflow-y: auto">

                    </ul>
                </div>
            </div>
        </div>


</body>
</html>
<script>
        var area="";
        var BMap
        var script = document.createElement("script");
        script.src = "http://api.map.baidu.com/api?v=2.0&ak=7HSdUGqKaz5U0ph0LIQ2Qd4rFmFZA2kY&callback=getweatherBefore";//此为v2.0版本的引用方式,加载完成后执行getweatherBefore事件
        document.body.appendChild(script);
        function getweatherBefore(){
        var areaText = "";
        //获取地理位置
        if(BMap!=undefined) {
        var map = new BMap.Map("allmap");
        var point = new BMap.Point(108.95, 34.27);
        // map.centerAndZoom(point, 18);
        var geolocation = new BMap.Geolocation();
        geolocation.getCurrentPosition(function (r) {
        if (this.getStatus() == BMAP_STATUS_SUCCESS) {
        // var mk = new BMap.Marker(r.point);
        // map.addOverlay(mk);//标出所在地
        // map.panTo(r.point);//地图中心移动
        //alert('您的位置：'+r.point.lng+','+r.point.lat);
        var point = new BMap.Point(r.point.lng, r.point.lat);//用所定位的经纬度查找所在地省市街道等信息
        var gc = new BMap.Geocoder();
        gc.getLocation(point, function (rs) {
        var addComp = rs.addressComponents; //地址信息
        area = rs.addressComponents.city;
        getWeather(area)
        });
        } else {
        alert('failed' + this.getStatus());
        }

        }, {enableHighAccuracy: true})

        }
        }
        getweatherBefore();

        $.ajax({
        type:'get',
        url:'/widget/getWeatherNew',
        dataType:'json',
        data:{cityName:area},
        success:function(res){
        if(res.flag && res.object){
        var weekday=["星期日","星期一","星期二","星期三","星期四","星期五","星期六"];
        var myddy=new Date().getDay();
        $('.weatherImg img').attr('src',res.object.picture)
        $('.weatherText').html(res.object.weather)
        $('.week').html(weekday[myddy])
        $('.du').html(res.object.tempertureOfDay);
        $('.area').html(area)

        var zlNum=parseInt(res.object.aqi);
        var zl='';

        if(zlNum>0&&zlNum<=50){
        zl='空气 优'
        }else if(100>=zlNum&&zlNum>50){
        zl='空气 良'
        }else if(200>=zlNum&&zlNum>100){
        zl='空气 轻度污染'
        }else if(300>=zlNum&&zlNum>200){
        zl='空气 中度污染'
        }else if(zlNum>300){
        zl='空气 重度污染'
        }
        $('.zl').html(zl)
        $('.zlNum').html(zlNum)
        // console.log($('.weatherImg img'))
        }
        }
        })

        layui.use('element', function(){
                    var $ = layui.jquery
                    ,element = layui.element; //Tab的切换功能，切换事件监听等，需要依赖element模块
        })


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

        var serverTime = ''
        setInterval(function () {
        var nowTime = new Date().getTime();
        serverTime = nowTime;
        serverTime = parseInt(serverTime) + 1000;
        var nowTime = serverTime;
        var date1 = new Date(nowTime).Format('MM月dd日');
        var date2 = new Date(nowTime).Format('hh:mm');
        // $('.date').text(date1);
        $('#time').text(date2);
        },1000);


  function tiaozhuan(that) {
  if($(that).hasClass('news')){
  $.popWindow($(that).attr('data-url'),'新闻详情','0','100','1200px','700px');

  }else{
  $.popWindow($(that).attr('data-url'),'公告详情','20','150','1200px','500px')
  }

  }


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
            for(var i=0;i<7;i++){
            $str=$('<li style="display: flex;height: 40px;line-height: 40px;" onclick ="js_methodDai(this)">'+'<div style="width: 45%;">'+data[i].flowType.flowName +'</div>'+'<div style="width: 20%;">'+data[i].flowRun.userName+'</div>'+'<div>'+data[i].receiptTime.split(' ')[0]+'</div>'+'</li>')
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
            for(var i=0;i<7;i++){
            $str=$('<li style="display: flex;height: 40px;line-height: 40px;" onclick ="js_method(this)">'+'<div style="width: 55%;">'+data[i].runName+'</div>'+'<div style="width: 20%;">'+data[i].flowRun.userName+'</div>'+'<div>'+data[i].deliverTime.split(' ')[0]+'</div>'+'</li>')
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
            for(var i=0;i<7;i++){
            $str=$('<li style="display: flex;height: 40px;line-height: 40px;" onclick ="js_method(this)">'+'<div style="width: 55%;">'+data[i].flowRun.runName+'</div>'+'<div style="width: 20%;">'+data[i].flowRun.userName+'</div>'+'</li>')
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
            for(var i=0;i<7;i++){
            $str=$('<li style="display: flex;height: 40px;line-height: 40px;" onclick ="js_method(this)">'+'<div style="width: 58%;">'+data[i].flowRun.runName.split(' ')[0]+'</div>'+'<div style="width: 17%;">'+data[i].flowRun.userName+'</div>'+'</li>')
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
        // window.open('/workflow/work/workformPreView?flowId='+obj.flowRun.flowId+'&prcsId='+obj.flowPrcs+'&flowStep='+obj.prcsId+'&tableName=budget&runId='+obj.runId);
        // }else{
        // window.open('/workflow/work/workformPreView?flowId='+obj.flowRun.flowId+'&prcsId='+obj.flowPrcs+'&flowStep='+obj.prcsId+'&runId='+obj.runId);
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
            //日历
            $('#ca').calendar({
            width: 320,
            height: 320,
            data: [
            {
            date: '2015/12/24',
            value: 'Christmas Eve'
            },
            {
            date: '2015/12/25',
            value: 'Merry Christmas'
            },
            {
            date: '2016/01/01',
            value: 'Happy New Year'
            }
            ],
            onSelected: function (view, date, data) {

            }
            });

  var userId = $.cookie('userId');
        var userName = $.cookie('userName');
        if (userName == null || userId == null) {
            $.post('/user/getNowLoginUser', {}, function (json) {
                var obj = json.object;
                if (json.flag) {
                    userName = obj.userName;
                    userId = obj.userId
                }
            })
        }
        function getNowFormatDate() {

        return new Date().Format('yyyy-MM-dd hh:mm:ss');
        }
   $('.fastItem').click(function() {
        var url=$(this).attr('url')
        var flowId = $(this).attr('opttype')
        var title1 = $(this).next('.apply-text').text()
        if(title1 == '请假申请' || title1 == '加班申请' || title1 == '外出申请' || title1 == '出差申请'){

            $.ajax({
                type: 'get',
                url: '/flow/checkWFNewPriv',
                dataType: 'json',
                data:{
                    flowId:flowId
                },
                success:function(res){
                    var data = res.success
                    if(data==false){
                        layer.msg('您没有经办权限！', {icon: 3});
                    }else{
                        if(url==undefined || url==''){
                            layer.msg("无此流程！", {
                                icon: 0,
                                offset: '45%'
                            })
                        }else{
                            layer.open({
                                type: 1,
                                title: [title1, 'background-color:#2b7fe0;color:#fff;'],
                                area: ['520px', '280px'],
                                shadeClose: true, //点击遮罩关闭
                                btn: ['创建', '取消'],
                                content: '<div class="newsAdd" style="padding-left: 5px;">' +
                                    '<table cellspacing="0" cellpadding="0" class="tab" style="border-collapse:collapse;background-color: #fff;width: 100%;margin-top: 20px;">' +
                                    '<tr class="applicant" style="margin-bottom: 20px;display: block"><td style="width: 200px;padding-left: 59px;text-align: right">申请人 ：</td><td><input type="text" class="inp" name="userName" style="width: 180px;" value="  ' + userName + '" id="leaveUser" readonly="readonly" userId="' + userId + '" ></td></tr>' +
                                    '<tr style="display: block"><td style="width: 200px;padding-left: 59px;text-align: right"> 登记时间 ：</td><td><input type="text" class="inp"  style="width: 180px;" name="begainTime" id="leaveTime" class="inputTd" readonly="readonly" value="  ' + getNowFormatDate() + '" /></td></tr>' +
                                    '</table></div>',
                                yes: function (index) {
                                    var attendUrl = '';
                                    if(title1 == '请假申请')
                                        attendUrl = '/attendLeave/addAttendLeave';
                                    if(title1 == '加班申请')
                                        attendUrl = '/attendanceOvertime/addAttendanceOvertime';
                                    if(title1 == '外出申请')
                                        attendUrl = '/attendOut/addAttendOut';
                                    if(title1 == '出差申请')
                                        attendUrl = '/attendEvection/addAttendEvection';

                                    $.ajax({
                                        type: 'post',
                                        url: attendUrl,
                                        dataType: 'json',
                                        async: false,
                                        data: {
                                            userId: $('#leaveUser').attr('userId'),
                                            recordTime: $('#leaveTime').val(),
                                            createDate: $('#leaveTime').val()
                                        },
                                        async: false,
                                        success: function (res) {
                                            if(title1 == '请假申请')
                                                $.popWindow("../workflow/work/workform?opflag=1&flowId=" + flowId + '&type=new&flowStep=1&prcsId=1&runId=' + res.data.runId, '快速新建页面', '0', '0', '1150px', '700px');

                                            if(title1 == '加班申请')
                                                $.popWindow('../workflow/work/workform?flowId=' + flowId + '&flowStep=1&prcsId=1&runId=' + res.data.runId + '&tableName=' + res.data.tableName + '&tabId=' + res.data.evectionId + '&isNomalType=true', '快速新建页面', '0', '0', '1500px', '800px');

                                            if(title1 == '外出申请')
                                                $.popWindow('../workflow/work/workform?flowId=' + flowId + '&flowStep=1&prcsId=1&runId=' + res.data.runId + '&tableName=' + res.data.tableName + '&tabId=' + res.data.outId + '&isNomalType=true', '快速新建页面', '0', '0', '1500px', '800px');

                                            if(title1 == '出差申请')
                                                $.popWindow('../workflow/work/workform?flowId=' + flowId + '&flowStep=1&prcsId=1&runId=' + res.data.runId + '&tableName=' + res.data.tableName + '&tabId=' + res.data.evectionId + '&isNomalType=true', '快速新建页面', '0', '0', '1500px', '800px');

                                        }

                                    });

                                    layer.close(index);

                                },
                            });
                        }
                    }
                }
            })

        }else{
        var url=$(this).attr('url')
        var flowId = $(this).attr('opttype')
        $.ajax({
                type: 'get',
                url: '/flow/checkWFNewPriv',
                dataType: 'json',
                data:{
                        flowId:flowId
                },
                success:function(res){
                        var data = res.success
                        if(data==false){
                                layer.msg('您没有经办权限！', {icon: 3});
                        }else{
                                if(url==undefined || url==''){
                                        layer.msg("无此流程！", {
                                                icon: 0,
                                                offset: '45%'
                                        })
                                }else{
                                        window.open(url)
                                }
                        }
                }
        })
        }



        })


            announcement()
            //文件管理 公共文件
            function announcement(){
            $.ajax({
            url: '/file/writeTree',
            type: 'get',
            dataType: 'json',
            success: function (data) {
            $('.Management').empty();
            var str='';
            if(data.length>0){
            // data.forEach(function(val,index){
                    for(var index=0;index<data.length;index++){

            str='<li data-num="1" data-id="'+data[index].id+'" menu_tid="3001" onclick="parent.getMenuOpen(this,2)" data-url="knowledge_management">'+
            '   <h2 style="display: none">公共文件</h2>'+
           '   <div style="display: flex;flex-direction: column;height: 100%;justify-content: center;align-items: center;">'+
            '       <h3 class="" style="height: 50px;">' +
            '<svg t="1616748079323" class="icon" viewBox="0 0 1024 1024" version="1.1" xmlns="http://www.w3.org/2000/svg" p-id="2757" width="45" height="45"><path d="M919.04 416.4608c0-17.8688-5.12-22.9888-22.9888-22.9888H130.304c-17.8688 0-25.6 5.12-25.6 25.6v400.7424c0 53.6064 22.9888 76.8 74.0352 76.8h668.8256c51.2 0 74.0352-22.9888 74.0352-74.0352-2.56-138.0864-2.56-270.848-2.56-406.1184zM125.184 352.6144H875.52c43.4176 0 43.4176 0 43.4176-40.96 0-48.4864-20.48-66.56-66.56-66.56h-323.8912c-40.96 0-40.96 0-40.96-40.96 0-43.4176-20.48-61.44-63.7952-61.44H168.6016c-46.08-2.56-63.7952 15.36-66.56 61.44v125.5424c0.3584 20.4288 5.4784 22.9376 23.1424 22.9376z" p-id="2758" fill="#7dc5eb"></path></svg></h3>'+
            '<span style="overflow: hidden;text-overflow: ellipsis;white-space: nowrap;width: 60px;" title="'+data[index].text+'">'+data[index].text+'</span>'+
            '   </div>'+
            '</li>'
            $('.Management').append(str);
            }

            // })
            }else{
            str += '<div class="noData" style="text-align: center;border: none;">' +
            '       <img  src="/img/main_img/shouyekong.png" alt="">' +
            '       <h5 style="text-align: center;color: #666;">'+'暂无数据'+'</h5>'
            '   </div>';
            $('.Management').html(str)
            }
            }
            });            }

            //时间戳转换
            function format(t) {
            if(t) {
            //处理ie下时间转换问题
            if(new Date(t).Format("yyyy-MM-dd") == 'NaN-aN-aN'){
            return t.split(' ')[0];
            }else{
            return new Date(t).Format("yyyy-MM-dd");
            }

            }else{
            return ''
            }
            }
            administrivia($('[data-bool=""]'))
            //新闻
            function administrivia(me) {//新闻
            $.ajax({
            url: '/news/newsManage',
            type: 'get',
            data:{
            page:'1',
            read:$(me).attr('data-bool'),
            pageSize:'6',
            useFlag:'true'
            },
            dataType: 'json',
            success: function (obj) {
            var li = '';
            var data = obj.obj;
        lengths = 0
            if(data.length>0){
            if(data.length >6){
                lengths= 6
            }else {
            lengths= data.length
            }
            for (var i = 0; i < lengths; i++) {
            li += '<li class="clearfix chedule_li news" style="width: 100%;display: flex;align-items: center;position: relative;cursor:pointer;width: 100%" onclick="tiaozhuan(this)" data-url="/news/detail?newsId='+data[i].newsId+'">' +
            '<div style="margin-left:12px;display: inline-block;">' +
            '<img src="/img/data_point.png">' +
            '</div>' +
            '<a style="width: 60%"><div class="new_title richeng_title" title="' + data[i].subject + '" style="display: inline-block">' + data[i].subject + '</div></a>' +
            '<div class="every_times" style="position:absolute;right: 20px">' +function () {

            if(data[i].newsDateTime!=undefined){
            return data[i].newsDateTime.replace(/\s/g, '<i style="margin-right:10px;"></i>')
            }else {
            return ''
            }
            }()  + '</div>' +
            '</li>'
            }
            }

            $('#newsZ').html(li);
            if(obj.obj.length==0) {
            var lis = '<div class="no_notice" style="text-align: center;border: none;">' +
            '<img style="margin-top: 62px;"  src="/img/main_img/shouyekong.png" alt="">' +
            '<h2 style="text-align: center;color: #666;">'+no_Data+'</h2>' +
            '</div>';
            $('#newsZ').html(lis);
            }


            }
            });
            }

            //公告
        newannouncement2()
            function newannouncement2(me){  //公告查询方法
            var obj={
            read:'',
            page:1,
            pageSize:5,
            useFlag:'true',
            typeId:""
            };
            $.ajax({
            url:"/notice/notifyManage",
            type:'get',
            data:obj,
            dataType:'json',
            success:function(obj) {
            var data = obj.obj;
            var str_li = '';
            if(data.length>0){
            if(data.length >6){
                lengths= 6
                }else {
                lengths= data.length
                }
                for (var i = 0; i < lengths; i++) {
                str_li += '<li class="clearfix chedule_li news" style="    position: relative;display: flex;align-items: center;cursor:pointer;width: 100%" onclick="tiaozhuan(this)" data-url="/notice/detail?notifyId=' + data[i].notifyId + '">' +
                '<div style="margin-left:12px;display: inline-block" >' +
                '<img src="/img/data_point.png">' +
                '</div>' +
                '<a style="width: 60%;display: inline-block"><div class="new_title richeng_title" style="display: inline-block;text-overflow: ellipsis;overflow: hidden;white-space: nowrap;width: 70%" title="' + data[i].subject + '">' + data[i].subject + '</div></a>' +
                '<div class="every_times" style="position:absolute;right: 20px">' +function () {

                if(data[i].notifyDateTime!=undefined){
                return data[i].notifyDateTime.replace(/\s/g, '<i style="margin-right:10px;"></i>')
                }else {
                return ''
                }
                }()  + '</div>' +
                '</li>'

                }
        }

            $('#new2').html(str_li);
            if(obj.obj.length==0) {
            var lis = '<div class="no_notice" style="text-align: center;border: none;">' +
            '<img style="margin-top: 62px;"  src="/img/main_img/shouyekong.png" alt="">' +
            '<h2 style="text-align: center;color: #666;">'+no_Data+'</h2>' +
            '</div>';
            $('#new2').html(lis);
            }
            }
            })
            }

            //常用
            getApplication()

        function getApplication(fn) {
        $.get('/getMenu', function (json) {
        if (json.flag) {
        $.ajax({
        url:'/portals/selPortalsById?portalsId=2',
        dataType:'json',
        type:'get',
        success:function(res){
        var portals= res.object.portalsMenu.split(',');

        var str = '';
        for(var j = 0;j<portals.length;j++){
        for (var i = 0; i < json.obj.length; i++) {
        if(portals[j] == json.obj[i].id){



        str += '<li val="worklog" menu_tid="' + json.obj[i].id + '" onclick="parent.getMenuOpen(this)" data-url="' + json.obj[i].url + '">'+
        ' <div class="img-wrap ie8"><i class="radius"></i> <div class="img ie8-img">\n'+
        '            <img src="/img/main_img/app/' + json.obj[i].fId + '.png" style="width: 60px;"></div></div>\n'+
        '<h2 style="display: none">'+json.obj[i].name+'</h2>'+
        '            <div class="common-text ellipsis">' + json.obj[i].name + '</div></li>'
        }

        }
        }
        $('#clearfixC').html(str);
        if(fn!=undefined){
        fn()
        }
        }
        })

        }
        }, 'json')
        }
            //个人考勤
        // 指定图表的配置项和数据
        // var myChart = echarts.init(document.getElementById('main'));
        //员工合同统计
        //    员工合同统计
        $.ajax({
        type:'get',
        url:'/attend/companyAttendance',
        dataType:'json',
        success:function (res) {
        var data=res.data.list
        var dataNum=[];
        //console.log(datas)

        for(var key in data){
            var str=[];
            str.push(data[key].sname)
            str.push(data[key].state)
            dataNum.push(str)
        }
        hetongTongji(dataNum)
        }
        })
        function hetongTongji(data) {

        var Type = [];var Count = [];
        for(var i = 0; i<data.length;i++){
        Type.push(data[i][0]);
        Count.push(data[i][1]);
        }
        var YuangongHeTong = echarts.init(document.getElementById("containerHetong"));
        var option = {
        title:{
        text: '个人考勤',
        left:'center',
        top:10
        },
        tooltip: {
        //                trigger: 'item',
        formatter: '{a} <br/>{b} : {c} ({d}%)'
        },
        color: ['#e72a17','#53e69d','#2cabe3','#7bcef3','#67B74E','#F48222','#943A92','#5299B7','#FDB428','#079BD2','#a6937c','#DCF2DC'],
        legend: {
        //图例垂直排列
        orient: 'vertical',
        right: 10,
        top:30,
        //data中的名字要与series-data中的列名对应，方可点击操控
        data:['上班正常','下班正常','迟到','早退','未打卡','未打卡','外勤','出差','外出','请假','值班','加班']
        },
        series:[
        {type:'pie',
        radius:'65%',
        center:['40%','50%'],
        label: {
        normal: {
        textStyle : {  fontSize :13   },
        position: 'inner',
        show : false
        }
        },
        selectedMode:'single',
        data:[
        {value:Count[0],name:Type[0]},
        {value:Count[1],name:Type[1]},
        {value:Count[2],name:Type[2]},
        {value:Count[3],name:Type[3]},
        {value:Count[4],name:Type[4]},
        {value:Count[5],name:Type[5]},
        {value:Count[6],name:Type[6]},
        {value:Count[7],name:Type[7]},
        {value:Count[8],name:Type[8]},
        {value:Count[9],name:Type[9]},
        {value:Count[10],name:Type[10]},
        {value:Count[11],name:Type[11]},
        ]
        }
        ]

        }
        YuangongHeTong.setOption(option)
        }





            </script>
