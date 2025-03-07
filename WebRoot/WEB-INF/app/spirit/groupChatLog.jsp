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
    <meta http-equiv="X-UA-Compatible" content="IE=10,chrome=1">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=0, minimum-scale=1.0, maximum-scale=1.0">
    <script type="text/javascript" src="/js/xoajq/xoajq1.11.1.js"></script>
    <script type="text/javascript" src="../js/jquery/jquery.min.js"></script>
    <script type="text/javascript" src="/js/base/base.js"></script>
    <link rel="stylesheet" href="/css/spirit/chatRecord.css">
    <script type="text/javascript" src="../js/spirit/qwebchannel.js"></script>
    <style>
        body, button, select, textarea, input, label, option, fieldset, legend{
            font-family: 微软雅黑;
        }
        .main-title{
            font-size:12px;
            line-height: 20px;
        }
        .main-text{
            line-height:21px;
            margin-left: 10px;
        }
        .main-title.colorBule{
            color: #0097f3;
            font-weight: 600;
        }
        .jsonstring{
            display: none;
        }
        .page-data{
            width: 110px;
        }
        /*定义滚动条宽高及背景，宽高分别对应横竖滚动条的尺寸*/
        .mainbox::-webkit-scrollbar{
            width: 4px;
            height: 16px;
            background-color: #f5f5f5;
        }
        /*定义滚动条的轨道，内阴影及圆角*/
        .mainbox::-webkit-scrollbar-track{
            -webkit-box-shadow: inset 0 0 6px rgba(0,0,0,.3);
            border-radius: 10px;
            background-color: #f5f5f5;
        }
        /*定义滑块，内阴影及圆角*/
        .mainbox::-webkit-scrollbar-thumb{
            /*width: 10px;*/
            height: 20px;
            border-radius: 10px;
            -webkit-box-shadow: inset 0 0 6px rgba(0,0,0,.3);
            background-color: #ccc;
        }
        .main {
            padding: 10px 20px;
        }
        .tabbox{
            width: 240px;
            height: 46px;
            margin: 0 auto;
        }
        .searchDiv{
            width: 240px;
            height:24px;
            margin: 0 auto;
            position: relative;
        }
        .tabbox li{
            width: 60px;
            float: left;
            margin: 11px 10px;
            height: 24px;
            line-height: 24px;
            cursor: pointer;
        }
        .taboxli{
            text-align: center;
        }
        .search{
            background-color: #0082f0;
            color: #fff;
            border-radius: 2px;
        }
        .searchbox{
            width: 100%;
            border: 1px solid #d0d6d9;
            text-indent: 8px;
        }

        /*************qywx修改样式*****************/
        .main-title .name-color {
            margin-right: 6px;
        }
        .wjbox{
            position: relative;
            height: 60px;
            margin-top: 6px;
            padding: 0 10px;
        }
        .wjbox:hover{
            background-color: #e0e9f2;
        }
        .wjbox:first-child{
            margin-top: 0px;
        }
        .liimg{
            width: calc(33% - 16px);
            height: 71px;
            float: left;
            margin: 5px;
            background-size: cover;
            border: 2px solid #dadde0;
        }
        .active{
            cursor: pointer;
            background: #3c92e5 !important;
            border-radius: 2px;
            color: #fff !important;
            display: inline-block;
            padding: 0 10px;
            height: 21px;
            line-height: 21px;
            text-align: center;
            font-size: 10px;
            position: absolute;
            top: 0;
            right: -2px;
        }
    </style>
</head>
<body style="overflow: hidden;cursor: default;">
<div class="headbox">
    <ul class="tabbox">
        <li class="search" data-id="0"><div class="taboxli">全部</div></li>
        <li data-id="1"><div class="taboxli">文件</div></li>
        <li data-id="2"><div class="taboxli">图片</div></li>
    </ul>
    <div class="searchDiv">
        <input type="text" class="searchbox" placeholder="搜索">
        <span class="active">搜索</span>
    </div>
</div>
<ul class="page-data page-data4" style="z-index: 1111;display: none;">
    <li class="fl pageimgBg pageClick" data-page="1"><img src="/img/spirit/mainTop.png" alt=""></li>
    <li class="fl onePage">1</li>
    <li class="fl">/</li>
    <li class="fl allPage">37</li>
    <li class="fl pageimgBg pageClick" data-page="2"><img src="/img/spirit/mainBottom.png" alt=""></li>
</ul>
<ul class="page-data page-data0" style="z-index: 1111;display: none;">
    <li class="fl pageimgBg pageClick" data-page="1"><img src="/img/spirit/mainTop.png" alt=""></li>
    <li class="fl onePage">1</li>
    <li class="fl">/</li>
    <li class="fl allPage">37</li>
    <li class="fl pageimgBg pageClick" data-page="2"><img src="/img/spirit/mainBottom.png" alt=""></li>
</ul>
<ul class="page-data page-data1" style="z-index: 1111;display: none;">
    <li class="fl pageimgBg pageClick" data-page="1"><img src="/img/spirit/mainTop.png" alt=""></li>
    <li class="fl onePage">1</li>
    <li class="fl">/</li>
    <li class="fl allPage">37</li>
    <li class="fl pageimgBg pageClick" data-page="2"><img src="/img/spirit/mainBottom.png" alt=""></li>
</ul>
<ul class="page-data page-data2" style="z-index: 1111;display: none;">
    <li class="fl pageimgBg pageClick" data-page="1"><img src="/img/spirit/mainTop.png" alt=""></li>
    <li class="fl onePage">1</li>
    <li class="fl">/</li>
    <li class="fl allPage">37</li>
    <li class="fl pageimgBg pageClick" data-page="2"><img src="/img/spirit/mainBottom.png" alt=""></li>
</ul>
<div class="mainbox" id="mainbox" style="overflow-x: hidden;overflow-y: auto;background-color: #f3f6f9;position:fixed;top:80px;width: 100%;">
    <div class="main"></div>
</div>
<div class="mainbox" id="mainbox1" style="overflow-x: hidden;overflow-y: auto;background-color: #f3f6f9;position:fixed;top:80px;width: 100%;display: none">
    <div class="main" style="padding: 10px 0;">
    </div>
</div>
<div class="mainbox" id="mainbox2" style="overflow-x: hidden;overflow-y: auto;background-color: #f3f6f9;position:fixed;top:80px;width: 100%;display: none">
    <div class="main"></div>
</div>
<div class="mainbox" id="mainboxsearch" style="overflow-x: hidden;overflow-y: auto;background-color: #f3f6f9;position:fixed;top:80px;width: 100%;display: none">
    <div class="main"></div>
</div>
</body>

<script language="JavaScript">
    Date.prototype.format = function(format) {
        var date = {
            "M+": this.getMonth() + 1,
            "d+": this.getDate(),
            "h+": this.getHours(),
            "m+": this.getMinutes(),
            "s+": this.getSeconds(),
            "q+": Math.floor((this.getMonth() + 3) / 3),
            "S+": this.getMilliseconds()
        };
        if (/(y+)/i.test(format)) {
            format = format.replace(RegExp.$1, (this.getFullYear() + '').substr(4 - RegExp.$1.length));
        }
        for (var k in date) {
            if (new RegExp("(" + k + ")").test(format)) {
                format = format.replace(RegExp.$1, RegExp.$1.length == 1
                    ? date[k] : ("00" + date[k]).substr(("" + date[k]).length));
            }
        }
        return format;
    }

    function getLocalTime(nS) {
        return new Date(parseInt(nS) * 1000).toLocaleString().substr(0,21)
    }
    function isFloat(n) {
        return n+".0"!=n;
    }
    var res=$.GetRequest();

    function doQtPer(e){
        var url = e.siblings('.jsonstring').text();
        console.log(url);
        new QWebChannel(qt.webChannelTransport, function(channel) {
            var content = channel.objects.interface;
            content.xoa_sms(url,'',"SEND_IMG_URL");
        });
    }
    function doQtPertp(e){
        var url = e.find('.jsonstring').text();
        console.log(url)
        new QWebChannel(qt.webChannelTransport, function(channel) {
            var content = channel.objects.interface;
            content.xoa_sms(url,'',"SEND_IMG_URL");
        });
    }
    function doQtPer1(e){
        var url = e.find('.jsonstring').text();


        console.log(url);
        new QWebChannel(qt.webChannelTransport, function(channel) {
            var content = channel.objects.interface;
            content.xoa_sms(url,'',"SEND_MESSAGE_URL");
        });
    }
    function ajaxData(page,ssnum,searchnum) {
        layer.load();
        var search = $('.searchbox').val();
        $.post('/im/showMessageListRilegou',{
            of_to:res.of_to,
            last_time:res.last_time,
            msg_type:1,
            pagenum:page,
            searchMsg:search

        },function (json) {
            if(json.flag){
                var arr=json.obj;
                if(arr == ""){
                    var numid='';

                }else{
                    var numid=arr[0].from_uid;
                }
                var str='';
                if(searchnum == 1){
                    var height1 = $('#mainbox .main').height();
                }else{
                    var height1 = $('#mainboxsearch .main').height();
                }
                if(searchnum == 1){
                    for(var i=arr.length-1;i>=0;i--){
                        var newDate = new Date();
                        newDate.setTime(arr[i].time * 1000);
                        str+=' <div class="main-content">\
                                    <p class="main-title '+function () {
//                                if(numid!=arr[i].from_uid) {
                                    return 'colorBule'
//                                }
                            }()+'">\
                                        <span class="name-color ">'+arr[i].formUserName+'</span>\
                                        <span class="time-color">'+newDate.format('yyyy-MM-dd h:m')+'</span>\
                                    </p>'+function(){
                                if(arr[i].content !=''){
                                    if(arr[i].content.indexOf('<!DOCTYPE HTML PUBLIC') == -1){
                                        return '<p class="main-text">'+arr[i].content+'</p>';
                                    }else{
                                        return '<p class="main-text"></p>';
                                    }
                                }
                                else{
                                    if(JSON.stringify(arr[i].file) == "{}"){
                                        return '<p class="main-text"></p>';
                                    }else{
                                        arr[i].file['time'] = arr[i].time;
                                        var str_json = JSON.stringify(arr[i].file);
                                        if(arr[i].file.thumbnail_url !=undefined){
                                            var height = arr[i].file.file_height*0.3;
                                            return '<img src="/xs?'+ arr[i].file.file_url+'" style="border: 1px solid #eee;margin-left: 10px;height: 130px;" ondblclick="doQtPer($(this))"><div class="jsonstring">'+ str_json +'</div>';
                                        }else{
                                            if(arr[i].file.file_size == undefined){
                                                arr[i].file.file_size = '0KB';
                                            }
                                            return '<div style="margin-left: 10px;position: relative;width: 240px;height: 65px;background-color: #bfd9f5" ondblclick="doQtPer1($(this))">'+
                                                '<div style="position: absolute;left: 20px;top: 12px;width: 40px;height: 40px;"><img src="/img/spirit/chatfile.png" alt="" style="width:100%;"></div>'+
                                                '<span style="position: absolute;left:75px;top: 12px;color: #333;font-size: 14px;width: 150px;white-space: nowrap;overflow: hidden;text-overflow: ellipsis;display: inline-block;">' + arr[i].file.file_name.split('.')[0] + '.'+ arr[i].file.file_name.split('.')[1] +'</span>'+
                                                '<div style="position: absolute;left:75px;top: 34px;color: #b8bebf;"><span>'+ arr[i].file.file_size +'</span><span style="margin-left: 10px"></span></div><div class="jsonstring">'+ str_json +'</div>'+
                                                '</div>'
                                        }
                                    }
                                }
                            }()+'</div>'
                    }
                    if(str ==''){
                        var str = '<li id="img_none" style="width:100%;height:199px;text-align: center;line-height:32px;margin: 0px;border: none;"><img src="/img/workflow/work/add_work/img_nomessage_03.png" alt="" style="margin-top: 16px;"> <span style="display: block;color: #666;">暂无消息记录!</span> </li>'
                    }
                    $('#mainbox .main').prepend(str);
                    var num;
                    if(isFloat(parseInt(json.totleNum)/30)){
                        if(parseInt(json.totleNum)/30<1){
                            num=1;
                        }else {
                            num=parseInt(parseInt(json.totleNum)/30)+1
                        }
                    }else {
                        num=parseInt(json.totleNum)/30;
                    }
                    $('.page-data0 .allPage').html(num)
                }else{
                    for(var i=0;i<arr.length;i++){
                        var newDate = new Date();
                        newDate.setTime(arr[i].time * 1000);
                        str+=' <div class="main-content">\
                                    <p class="main-title '+function () {
//                                if(numid!=arr[i].from_uid) {
                                    return 'colorBule'
//                                }
                            }()+'">\
                                        <span class="name-color ">'+arr[i].formUserName+'</span>\
                                        <span class="time-color">'+newDate.format('yyyy-MM-dd h:m')+'</span>\
                                    </p>'+function(){
                                if(arr[i].content !=''){
                                    if(arr[i].content.indexOf('<!DOCTYPE HTML PUBLIC') == -1){
                                        return '<p class="main-text">'+arr[i].content+'</p>';
                                    }else{
                                        return '<p class="main-text"></p>';
                                    }
                                }
                                else{
                                    if(JSON.stringify(arr[i].file) == "{}"){
                                        return '<p class="main-text"></p>';
                                    }else{
                                        arr[i].file['time'] = arr[i].time;
                                        var str_json = JSON.stringify(arr[i].file);
                                        if(arr[i].file.thumbnail_url !=undefined){
                                            var height = arr[i].file.file_height*0.3;
                                            return '<img src="/xs?'+ arr[i].file.thumbnail_url+'" style="border: 1px solid #eee;margin-left: 10px;height: 130px;" ondblclick="doQtPer($(this))"><div class="jsonstring">'+ str_json +'</div>';

                                        }else{
                                            if(arr[i].file.file_size == undefined){
                                                arr[i].file.file_size = '0KB';
                                            }
                                            return '<div style="margin-left: 10px;position: relative;width: 240px;height: 65px;background-color: #bfd9f5" ondblclick="doQtPer1($(this))">'+
                                                '<div style="position: absolute;left: 20px;top: 12px;width: 40px;height: 40px;"><img src="/img/spirit/chatfile.png" alt="" style="width:100%;"></div>'+
                                                '<span style="position: absolute;left:75px;top: 12px;color: #333;font-size: 14px;">' + arr[i].file.file_name.split('.')[0] + '.'+ arr[i].file.file_name.split('.')[1] +'</span>'+
                                                '<div style="position: absolute;left:75px;top: 34px;color: #b8bebf;"><span>'+ arr[i].file.file_size +'</span><span style="margin-left: 10px"></span></div><div class="jsonstring">'+ str_json +'</div>'+
                                                '</div>'
                                        }
                                    }
                                }
                            }()+'</div>'
                    }
                    if(str ==''){
                        var str = '<li id="img_none" style="width:100%;height:199px;text-align: center;line-height:32px;margin: 0px;border: none;"><img src="/img/workflow/work/add_work/img_nomessage_03.png" alt="" style="margin-top: 16px;"> <span style="display: block;color: #666;">暂无消息记录!</span> </li>'
                    }
                    $('#mainboxsearch .main').append(str);
                    var num;
                    if(isFloat(parseInt(json.totleNum)/30)){
                        if(parseInt(json.totleNum)/30<1){
                            num=1;
                        }else {
                            num=parseInt(parseInt(json.totleNum)/30)+1
                        }
                    }else {
                        num=parseInt(json.totleNum)/30;
                    }
                    $('.page-data4 .allPage').html(num)
                }
                if(ssnum == 0){
                    var scrolltop = $('.mainbox')[0].scrollHeight+999;
                    $('.mainbox').eq(0).scrollTop(scrolltop);
                }else{
                    if(searchnum == 1){
                        var height2 = $('#mainbox .main').height();
                        var height = height2 - height1;
                        $('.mainbox').eq(0).scrollTop(height);
                    }else{
                        console.log(height1)
                        $('.mainbox').eq(4).scrollTop(height1);
                    }
                }
            }
            layer.closeAll();
        },'json')
    }
    ajaxData(1,0,1);

    function ajaxwj(page,nums,searchnum){
        var page = page;
        var num = nums;
        var searchnum = searchnum;
        var search = $('.searchbox').val();
        if(num == 1){
            var type = 'file';
        }else{
            var type = 'img';
        }
        layer.load();
        $.post('/im/showMessageListRilegou',{
            of_to:res.of_to,
            last_time:res.last_time*1000,
            msg_type:1,

            pagenum:page,
            type:type,
            searchMsg:search
        },function (json) {
            var str = '';
            var data = json.obj;
            var newDate = new Date();
            if(nums == 1){
                for(var i=0;i<json.obj.length;i++){
                    newDate.setTime(data[i].time * 1000);
                    var size =data[i].file.file_size;
                    data[i].file['time'] = data[i].time;
                    var str_json = JSON.stringify(data[i].file);
                    if(size == undefined){
                        size = '0kb';
                    }
                    str += '<div class="wjbox" ondblclick="doQtPer1($(this))">' +
                        '<div style="position: absolute;width: 40px;height: 40px;margin-top: 10px;">' +
                        '<img src="/img/spirit/chatfile.png" alt="" style="width:100%;">' +
                        '</div>' +
                        '<div style="float: left;width: calc(100% - 85px);height: 100%;margin-left: 50px;">' +
                        '<span style="color: #141414;font-size: 14px;width: 100%;white-space:nowrap;overflow:hidden;text-overflow:ellipsis;display: inline-block;margin-top: 10px;">'+data[i].file.file_name.split('.')[0] + '.'+ data[i].file.file_name.split('.')[1]+'</span>' +
                        '</div>' +
                        '<div style="position: absolute;left: 60px;top: 34px;color: #8796a5;">' +
                        '<span style="padding-right: 7px;border-right: 1px solid #8796a5;">'+size+'</span><span style="margin-left: 7px;">'+data[i].formUserName+'</span>' +
                        '</div>' +
                        '<div style="color: #8796a5;position: absolute;right: 10px;top: 10px;">'+newDate.format('MM/dd')+'</div><div class="jsonstring">'+ str_json +'</div>' +
                        '</div>';
                }
                if(searchnum == 1){
                    if(str ==''){
                        var str = '<li id="img_none" style="width:100%;height:199px;text-align: center;line-height:32px;margin: 0px;border: none;"><img src="/img/workflow/work/add_work/img_nomessage_03.png" alt="" style="margin-top: 16px;"> <span style="display: block;color: #666;">暂无消息记录!</span> </li>'
                    }
                    $('#mainbox1 .main').prepend(str);
                    var num1;
                    if(isFloat(parseInt(json.totleNum)/30)){
                        if(parseInt(json.totleNum)/30<1){
                            num1=1;
                        }else {
                            num1=parseInt(parseInt(json.totleNum)/30)+1
                        }
                    }else {
                        num1=parseInt(json.totleNum)/30;
                    }
                    $('.page-data1 .allPage').html(num1);
                }else{
                    if(str ==''){
                        var str = '<li id="img_none" style="width:100%;height:199px;text-align: center;line-height:32px;margin: 0px;border: none;"><img src="/img/workflow/work/add_work/img_nomessage_03.png" alt="" style="margin-top: 16px;"> <span style="display: block;color: #666;">暂无消息记录!</span> </li>'
                    }
                    $('#mainboxsearch .main').html(str);
                    var num;
                    if(isFloat(parseInt(json.totleNum)/30)){
                        if(parseInt(json.totleNum)/30<1){
                            num=1;
                        }else {
                            num=parseInt(parseInt(json.totleNum)/30)+1
                        }
                    }else {
                        num=parseInt(json.totleNum)/30;
                    }
                    $('.page-data4 .allPage').html(num)
                }
            }else{
                for(var i=0;i<json.obj1.length;i++){
                    var zj = json.obj1[i];
                    var ss = json.object[zj];
                    var str1 = '';
                    for(var j=0;j<ss.length;j++){
                        var img = "/xs?"+ ss[j].file.file_url;
                        ss[i].file['time'] = ss[i].time;
                        var str_json = JSON.stringify(ss[j].file);
                        str1 += "<li class=\"liimg\"" +
                            " style=\"background: url('"+img+"') no-repeat;\" ondblclick=\"doQtPertp($(this))\"><div class=\"jsonstring\">"+ str_json +"</div></li>"
                    }

                    str +=   '<div class="main-content"> ' +
                        '<div class="main-title colorBule">' +
                        '<div class="time-color" style="margin: 0 auto;width: 110px;">'+ zj +'</div> ' +
                        '</div>' +
                        '<ul>'+str1+'</ul>' +
                        '</div>'
                }
                if(str ==''){
                    var str = '<li id="img_none" style="width:100%;height:199px;text-align: center;line-height:32px;margin: 0px;border: none;"><img src="/img/workflow/work/add_work/img_nomessage_03.png" alt="" style="margin-top: 16px;"> <span style="display: block;color: #666;">暂无消息记录!</span> </li>'
                }
                $('#mainbox2 .main').prepend(str);
                for(var i=0;i<$('#mainbox2 .main-content').length;i++){
                    var num = $('#mainbox2 .main-content').eq(i).find('.liimg').length;
                    if(num <= 3){
                        $('#mainbox2 .main-content').eq(i).find('ul').height('85');
                    }else{
                        var ys = Math.ceil(num/3);
                        var height = 85 * ys;
                        $('#mainbox2 .main-content').eq(i).find('ul').height(height);
                    }
                }
            }
            layer.closeAll();
        },'json')
    }


    $(function () {
        var pd1 = 0;
        var pd2 = 0;
        $('.tabbox li').click(function(){
            var idnum = $(this).attr('data-id');
            $(this).addClass('search').siblings().removeClass('search');
            $('.searchbox').val('');
            if(idnum == 0){
                $('.searchDiv').show();
                $('.page-data0').hide()
                $('.page-data1').hide()
                $('.page-data2').hide()
                $('#mainboxsearch').hide();
                $('#mainbox').show();
                $('#mainbox1').hide();
                $('#mainbox2').hide();
            }else if(idnum == 1){
                $('.searchDiv').show();
                $('.page-data1').hide()
                $('.page-data0').hide()
                $('.page-data2').hide()
                $('#mainboxsearch').hide();
                $('#mainbox').hide();
                $('#mainbox1').show();
                $('#mainbox2').hide();
                if(pd1 == 0){
                    ajaxwj(1,1,1);
                    pd1 = 1;
                }
            }else{
                $('.searchDiv').hide();
                $('.page-data2').hide()
                $('.page-data0').hide()
                $('.page-data1').hide()
                $('#mainboxsearch').hide();
                $('#mainbox').hide();
                $('#mainbox1').hide();
                $('#mainbox2').show();
                if(pd2 == 0){
                    ajaxwj(1,2,1);
                    pd2 = 1;
                }
            }
        })
        /***************滚动刷新*************************************/
        $('#mainbox').scroll(function(){
            if($('#mainbox').scrollTop() == 0){
                $('.page-data0 .pageClick').eq(0).click();
            }
        });
        $('.page-data0 .pageClick').click(function () {
            var num1 = parseInt($('.page-data0 .onePage').text());
            var num2 = parseInt($('.page-data0 .allPage').text());
            if(num1 >= 1 && num1 <= num2){
                if($(this).attr('data-page')==1){
                    if(num1 != num2){
                        ajaxData(++num1,1,1);
                    }else{
                        new QWebChannel(qt.webChannelTransport, function(channel) {
                            var content = channel.objects.interface;
                            content.xoa_sms('','没有更多记录',"send_ts");
                        });
                    }
                }else if($(this).attr('data-page')==2){
                    if(num1 > 1){
                        ajaxData(--num1,1,1);
                    }else{
                        new QWebChannel(qt.webChannelTransport, function(channel) {
                            var content = channel.objects.interface;
                            content.xoa_sms('','没有更多记录',"send_ts");
                        });
                    }
                }
                $('.page-data0 .onePage').html(num1);
            }else{
                new QWebChannel(qt.webChannelTransport, function(channel) {
                    var content = channel.objects.interface;
                    content.xoa_sms('','没有更多记录',"send_ts");
                });
            }
        })

        $('#mainboxsearch').scroll(function(){
            var scroll = $('#mainboxsearch').scrollTop() + 670;
            console.log($('#mainboxsearch').scrollTop())
            console.log($('#mainboxsearch .main').height())
            if(scroll == $('#mainboxsearch .main').height()){
                $('.page-data4 .pageClick').eq(0).click();
            }
        });
        $('.page-data4 .pageClick').click(function () {
            var num1 = parseInt($('.page-data4 .onePage').text());
            var num2 = parseInt($('.page-data4 .allPage').text());
            if(num1 >= 1 && num1 <= num2){
                if($(this).attr('data-page')==1){
                    if(num1 != num2){
                        ajaxData(++num1,1,0);
                    }else{
                        new QWebChannel(qt.webChannelTransport, function(channel) {
                            var content = channel.objects.interface;
                            content.xoa_sms('','没有更多记录',"send_ts");
                        });
                    }
                }else if($(this).attr('data-page')==2){
                    if(num1 > 1){
                        ajaxData(--num1,1,0);
                    }else{
                        new QWebChannel(qt.webChannelTransport, function(channel) {
                            var content = channel.objects.interface;
                            content.xoa_sms('','没有更多记录',"send_ts");
                        });
                    }
                }
                $('.page-data4 .onePage').html(num1);
            }else{
                new QWebChannel(qt.webChannelTransport, function(channel) {
                    var content = channel.objects.interface;
                    content.xoa_sms('','没有更多记录',"send_ts");
                });
            }
        })
        autodivheight();
        function autodivheight() {
            var winHeight = 0;
            if (window.innerHeight)
                winHeight = window.innerHeight;
            else if ((document.body) && (document.body.clientHeight))
                winHeight = document.body.clientHeight;
            if (document.documentElement && document.documentElement.clientHeight)
                winHeight = document.documentElement.clientHeight;
            winWidth = document.documentElement.clientWidth;
            document.getElementById("mainbox").style.height = winHeight - 78  + "px";
            document.getElementById("mainbox1").style.height = winHeight - 78  + "px";
            document.getElementById("mainbox2").style.height = winHeight - 78  + "px";
            document.getElementById("mainboxsearch").style.height = winHeight - 78  + "px";
        }
        window.onresize = autodivheight;
        /*************搜索 功能********************************/
        $('.active').on('click', function() {
            var searchval = $('.searchbox').val();
            $('#mainboxsearch').show();
            $('#mainboxsearch .main').empty();
            $('#mainbox').hide();
            $('#mainbox1').hide();
            $('#mainbox2').hide();
            var dataid = $('.search').attr('data-id');
            if(dataid == 0){
                ajaxData(1,1,0);
            }else if(dataid == 1){
                ajaxwj(1,1,0)
            }
            //$('.page-data4').show();
        });

        $('.searchbox').bind('input propertychange', function() {
            var dataid = $('.search').attr('data-id');
            if($('.searchbox').val() == ''){
                $('#mainboxsearch').hide();
                if(dataid == 0){
                    $('#mainbox').show();
                }else if(dataid == 1){
                    $('#mainbox1').show();
                }
            }
        })
    })


</script>
</html>