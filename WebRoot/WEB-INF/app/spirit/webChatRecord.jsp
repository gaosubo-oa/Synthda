<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@taglib prefix="mvc" uri="http://www.springframework.org/tags/form" %>
<%@taglib prefix="fmt" uri="http://www.springframework.org/tags" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
%>

<!DOCTYPE html>
<html><!--<![endif]-->
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
    <title><fmt:message code="seal.messagehistory" /></title>
    <meta name="renderer" content="webkit">
    <meta http-equiv="X-UA-Compatible" content="IE=10,chrome=1">
    <meta name="viewport" content="width=device-width, initial-scale=0.3, user-scalable=0, minimum-scale=0, maximum-scale=5.0,user-scalable=yes">
    <link rel="stylesheet" type="text/css" href="../lib/pagination/style/pagination.css"/>
    <link rel="stylesheet" type="text/css" href="../css/base.css"/>
    <link rel="stylesheet" href="/css/spirit/chatRecord.css">
    <link rel="stylesheet" type="text/css" href="/css/commonTheme/${sessionScope.InterfaceModel}/commonTheme.css"/>

    <script src="/js/common/language.js"></script>
<%--    <script type="text/javascript" src="/js/xoajq/xoajq1.11.1.js"></script>--%>
    <script type="text/javascript" src="/js/xoajq/xoajq3.js"></script>
<%--    <script type="text/javascript" src="/js/jquery/jquery-migrate-3.4.0.js"></script>--%>
    <script type="text/javascript" src="../js/jquery/jquery.min.js"></script>
    <script type="text/javascript" src="/js/base/base.js"></script>
    <script type="text/javascript" src="../js/spirit/qwebchannel.js"></script>
    <script src="../lib/pagination/js/jquery.pagination.min.js" type="text/javascript" charset="utf-8"></script>
    <script src="../../js/jquery/jquery.cookie.js"></script>

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

        .tabbox li{
            width: 60px;
            float: left;
            margin: 11px 10px;
            height: 24px;
            line-height: 24px;
            cursor: pointer;
            font-size: 15px;
        }
        .search{
            background-color: c0c0c0;
            color: #fff;
            border-radius: 2px;
        }

        /*************qywx修改样式*****************/
        .main-title .name-color {
            margin-right: 6px;
        }
        .wjbox{
            position: relative;
            height: 60px;
            margin-top: 6px;
            cursor: pointer;
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
        .mainTitle{
            float: left;
            height: 45px;
            line-height: 45px;
            font-size: 22px;
            margin-left: 10px;
            color: rgb(73, 77, 89);
        }
        .headbox{
            height: 45px;
            /*border-bottom: 1px solid #999;*/
        }
        .mainCon{
            width: 100%;
        }
        .mainCon table{
            width: 99%;
            margin: 20px auto;
        }
        .mainCon table tr{
            border: #ccc 1px solid;
        }
        .mainCon table tr th{
            padding: 8px;
            color: #2F5C8F;
        }
        .mainCon table tr td{
            padding: 8px;
            text-align: center;
        }
        .mainCon table tr td a{
            text-decoration: none;
            color:#59b7fb;
        }
        .headbox .div img{
            margin-top: 5px;
        }
        table thead tr th{
            font-size: 13pt;
        }
        table tbody tr td{
            font-size: 11pt;
        }
        .subsearch {
            width: 60px;
            height: 29px;
            padding-left: 10px;
            line-height: 29px;
            /* margin-top: 18px; */
            /* margin-left: 10px; */
            text-align: center;
            background-image: url(../../img/center_q.png);
            background-repeat: no-repeat;
            background-size: 100% 100%;
            /* border: 1px solid rgb(204, 204, 204); */
            /* border-radius: 6px; */
            color: #000;
            cursor: pointer;
            font-family: Microsoft yahei,Helvetica Neue,Helvetica,PingFang SC,Tahoma,Arial,sans-serif;
        }
        .inp {
            width: 160px;
            height: 27px;
            border-radius: 6px;
            float: left;
            border: 1px solid #ccc;
            padding: 0px 1px;
            padding-left: 5px;
            padding-right: 69px;
        }
        .toName{
            width: 160px;
            padding-right: 5px;
            margin-right: 20px;
        }
        .main-title{
            font-size:12px;
            line-height: 20px;
        }
        .main-text{
            line-height:21px;
            margin-left: 10px;
            padding: 0 3px;
            display: inline-block;
        }
        .main-title.colorBule{
            color: #0097f3;
            font-weight: 300;
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
            margin-top: 15px;
            float: right;
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
            height: 21px;
            line-height: 24px;
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
            height: 24px;
            line-height: 24px;
            text-align: center;
            font-size: 12px;
            position: absolute;
            top: 0;
            right: -5px;
        }
        .main-content{
            position: relative;
        }
        .specialBox{
            position: fixed;
            top: 0;
            left: 0;
            width: 100px;
            background: #fff;
            color: #000;
            border: 1px solid #ccc;
            box-shadow: 0px 0px 10px 1px #d0d0d0;
            z-index: 999;
        }
        .specialBox li{
            height: 35px;
            line-height: 35px;
            padding-left: 20px;
        }
        .specialBox li:hover{
            background: #ebebeb;
        }
        .specialClass{
            background: #3399ff;
            color: #fff;
        }
        #infoTree li {
            padding-top: 10px;
            height: 50px;
            width: 100%;
            border-bottom: 1px solid #f0f0f0;
            cursor: pointer;
        }
        .d_content {
            width: 90% !important;
            color: #b5b6b7;
            height: 20px;
            line-height: 12px;
            text-align: left;
            overflow: hidden;
            white-space: nowrap;
            text-overflow: ellipsis;
            padding-left: 5px;
            font-size: 12px;
        }
        #infoTree li:hover{
            background-color: #0082f0;
        }
        .nameInfo{
            padding: 0px 5px;
            font-size: 15px;
            overflow: hidden;
            white-space: nowrap;
            text-overflow: ellipsis;
            width: 100%;
            display: inline-block;
        }
    </style>
    <div class="headbox">
        <div>
            <span class="mainTitle" style="position: relative;"><img src="/img/commonTheme/${sessionScope.InterfaceModel}/webChat.png" style="position: absolute;top: 8px;"/><span style="    margin-left: 40px;"><fmt:message code="seal.messagehistory" /></span></span>
        </div>
    </div>
    <div style="float: right;margin: 25px 0; margin-right: 50px;display: none; position: relative">
        <input id="flow_search_value" class="inp toName" type="text" placeholder="&nbsp;输入收件人">
        <input class="inp content" type="text" placeholder="&nbsp;内容">
        <div id="btn_search" style="float: left;position: absolute; right: 0;"><h1 style="cursor:pointer; font-size: 10pt;" class="subsearch" id="dbgz_search">查询</h1></div>
    </div>
</head>
<body>
<div class="content" style="display: flex;margin-top: 25px; width: 100%;border-top: 1px solid #999;">
    <div class="mainLeft" style="width: 300px;border-right: 1px solid #999;height: 100%;overflow-y: auto;overflow-x: hidden;">
        <div id="infoTransfor" style="width:100%;">
            <ul id="infoTree" class="easyui-tree">
            </ul>
        </div>
    </div>

    <div class="mainRight" style="width:calc(100% - 300px);height: 100%;overflow-y: hidden;">
            <div class="mainCon">
<%--                <table border="0" cellspacing="0" cellpadding="0" style="border-collapse: collapse">--%>
<%--                    <thead>--%>
<%--                    <tr>--%>
<%--                        <th><fmt:message code="chat.th.chetType" /></th>--%>
<%--                        <th><fmt:message code="userDetails.th.name" /></th>--%>
<%--                        <th><fmt:message code="email.th.time" /></th>--%>
<%--                        <th style="width: 40%;"><fmt:message code="notice.th.content" /></th>--%>
<%--                        <th><fmt:message code="notice.th.operation" /></th>--%>
<%--                    </tr>--%>
<%--                    </thead>--%>
<%--                    <tbody>--%>

<%--                    </tbody>--%>
<%--                </table>--%>
    <div class="headbox">
        <ul class="tabbox">
            <li class="search" data-id="0"><div class="taboxli"><fmt:message code="notice.th.all" /></div></li>
            <li data-id="1"><div class="taboxli"><fmt:message code="doc.th.file" /></div></li>
            <li data-id="2"><div class="taboxli"><fmt:message code="chat.th.photo" /></div></li>
        </ul>
        <div class="searchDiv" style="display: none">
            <input type="text" class="searchbox" placeholder="<fmt:message code="workflow.th.sousuo" />">
            <span class="active"><fmt:message code="workflow.th.sousuo" /></span>
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
    <div class="mainbox" id="mainbox" style="overflow-x: hidden;overflow-y: auto;position:fixed;top:150px;width: 100%;">
        <div class="main"></div>
    </div>
    <div class="mainbox" id="mainbox1" style="overflow-x: hidden;overflow-y: auto;top:150px;width: 100%;display: none">
        <div class="main" style="padding: 10px 0;margin: 0 auto;width: 100%;">
        </div>
    </div>
    <div class="mainbox" id="mainbox2" style="overflow-x: hidden;overflow-y: auto;top:150px;width: 100%;display: none">
        <div class="main" style="padding: 10px 0;margin: 0 auto;width: 100%;"></div>
    </div>
    <div class="mainbox" id="mainboxsearch" style="overflow-x: hidden;overflow-y: auto;position:fixed;top:150px;width: 100%;display: none">
        <div class="main"></div>
    </div>
            </div>
    </div>
</div>
<%--<div class="right" style="margin-right: 20px;">--%>
<%--    <!-- 分页按钮-->--%>
<%--    <div class="M-box3">--%>
<%--    </div>--%>

<%--</div>--%>

</div>
</body>

<script language="JavaScript">
    /*var cookie = $.cookie('company');
    var uid = $.cookie('uid');*/
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
    function ajaxform(){
        layer.load();
        $.ajax({
            url: '/im/getSqlType',
            type: 'get',
            dataType: 'json',
            success: function (result) {
                var datas = result.object;
                var str = '';
                var of_from = datas.sqlType+'pq'+ datas.str +'@gsubo';
                var toName = $('.toName').val();
                var content = $('.content').val();
                $('#dbgz_search').attr('of_from',of_from);
                $.ajax({
                    url: '/im/getImList?flag=4&of_from='+datas.sqlType+'pq'+ datas.str +'@gsubo',
                    type: 'get',
                    dataType: 'json',
                    // data: {
                    //     toName:toName,
                    //     content:content,
                    // },
                    success: function (result) {
                        var datas = result;
                        var str = '';
                        if (datas.length > 0) {
                            for (var i = 0; i < datas.length-1; i++) {
                                var newDate = new Date();
                                newDate.setTime(datas[i].time * 1000);
                                if(datas[i].of_to.indexOf('gsrooms') == -1){
                                    var dats = '单聊';
                                }else{
                                    var dats = '群聊';
                                }
                                str += '<li uuid='+datas[i].list_id+' from="'+datas[i].of_from+'" msg_type="'+datas[i].msg_type+'" to="'+datas[i].of_to+'" time="'+datas[i].time+'" >' +
                                    '<div style="height: 100%;width: 40px;float: left;">'+
                                    '<img src="'+ function(){
                                        if(datas[i].photo == '1'){
                                            return '/img/user/girl.png'
                                        }else if(datas[i].photo == '0'){
                                            return '/img/user/boy.png'
                                        }else if(datas[i].photo.indexOf("/img/im")>-1){
                                            return datas[i].photo;
                                        }else{
                                            return '/img/user/'+ datas[i].photo;
                                        }
                                    }() +'" style="border-radius: 50%;margin-left: 20%;width: 39px;">' +
                                    '</div>' +
                                    '<div style="height: 100%;margin-left: 17%;position: relative;width: 80%;">' +
                                    '<a href="javascript:void(0)" class="nameInfo" style="height: 23px;line-height: 16px;left: 45px;text-align: left;color: #494d59;">' + datas[i].toUserName+ '</a>' +
                                    '<h3 class="d_content">' + datas[i].content +'</h3>' +
                                    '</div>' +

                                    '</li>';
                            }
                            layer.closeAll();
                            $('#infoTree').append(str);
                        } else {
                            layer.closeAll();
                            $.layerMsg({content: '暂无消息记录！', icon: 5});
                        }
                    }
                });
            }
        })
    }
    function getLocalTime(nS) {
        return new Date(parseInt(nS) * 1000).toLocaleString().substr(0,21)
    }
    function isFloat(n) {
        return n+".0"!=n;
    }
    var res=$.GetRequest();

    $(function(){
        var height=document.documentElement.clientHeight;
        $('.content').css('height',height-72+'px');
        $('#btn_search').on('click',function(){
            ajaxform(1,function (pageCount) {
                initPagination(pageCount, 10);
            });
        })
        ajaxform();
    })
    // $('.mainCon').on('click','.search',function(){
    //     var from=$(this).parents('tr').attr('from');
    //     var msg_type=$(this).parents('tr').attr('msg_type');
    //     var to=$(this).parents('tr').attr('to');
    //     var time=$(this).parents('tr').attr('time');
    //     console.log($(document).width()/2 -150)
    //     var left = $(document).width()/2 -150;
    //     console.log($(document).height()/2 - 300)
    //     var top = $(document).height()/2 - 300;
    //     window.open("/spirit/chatRecord?of_from="+from +"&of_to="+to+"&msg_type="+msg_type+"&last_time="+time,"","top="+ top +",left=" +left+ ",width=300,height=600");
    // })
    var from;
    var msg_type;
    var to;
    var time;
    $('#infoTree').on('click','li',function(){
        from=$(this).attr('from');
        msg_type=$(this).attr('msg_type');
        to=$(this).attr('to');
        time=$(this).attr('time');
        var selectPart = $('.search').attr('data-id')
        if(selectPart == '0'){
            ajaxData(1,0,1);
        }else if(selectPart == '1'){
            $('.page-data1').hide()
            $('.page-data0').hide()
            $('.page-data2').hide()
            $('#mainboxsearch').hide();
            $('#mainbox').hide();
            $('#mainbox1').show();
            $('#mainbox2').hide();
            ajaxwj(1,1,1);
        }else{
            $('.page-data2').hide()
            $('.page-data0').hide()
            $('.page-data1').hide()
            $('#mainboxsearch').hide();
            $('#mainbox').hide();
            $('#mainbox1').hide();
            $('#mainbox2').show();
            ajaxwj(1,2,1);
        }

    })
    function ajaxData(page,ssnum,searchnum) {
        var numid = '';
        $('#mainbox .main').html('')
        $.ajax({
            type: "post",
            url: "/users/getUserTheme",
            dataType: 'json',
            async:false,
            success: function (res) {
                var data = res.object;
                numid = data.uid;
            }
        })
        layer.load();
        // var search = $('.searchbox').val();
        $.post('/im/showMessageListRilegou',{
            of_from:from,
            of_to:to,
            last_time:time*1000,
            msg_type:msg_type,
            pagenum:page,
            // searchMsg:search
        },function (json) {
            if(json.flag){
                var arr=json.obj;
                var str='';
                if(searchnum == 1){
                    var height1 = $('#mainbox .main').height();
                }else{
                    var height1 = $('#mainboxsearch .main').height();
                }
                if(searchnum == 1){
                    for(var i=arr.length-1;i>=0;i--){
                        if(arr[i].content != undefined){
                            var newDate = new Date();
                            newDate.setTime(arr[i].time * 1000);
                            str+=' <div class="main-content onmouseover="normalImg($(this))"'+function () {
                                if(numid != arr[i].from_uid) {
                                    return 'notUser'
                                }else{
                                    return 'User';
                                }
                            }()+'" uuid="'+ arr[i].uuid +'">\
                                    <p class="main-title '+function () {
                                if(numid == arr[i].from_uid) {
                                    return 'colorBule'
                                }else{
                                    return '';
                                }
                            }()+'">\
                                        <span class="name-color ">'+arr[i].formUserName+'</span>\
                                        <span class="time-color">'+newDate.format('yyyy-MM-dd h:m')+'</span>\
                                    </p>'+function(){
                                if(arr[i].content !=''){
                                    if(arr[i].content.indexOf('<!DOCTYPE HTML PUBLIC') == -1){
                                        return '<p class="main-text">'+arr[i].content+'</p>';
                                    }else{
                                        return '<p class="main-text">&nbsp;</p>';
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
                                                '<span style="position: absolute;left:75px;top: 12px;color: #333;font-size: 14px;width: 150px;white-space: nowrap;overflow: hidden;text-overflow: ellipsis;display: inline-block;">' + arr[i].file.file_name.split('.')[0] + '.'+ arr[i].file.file_name.split('.')[1] +'</span>'+
                                                '<div style="position: absolute;left:75px;top: 34px;color: #828080;"><span>'+ arr[i].file.file_size +'</span><span style="margin-left: 10px"></span></div><div class="jsonstring">'+ str_json +'</div>'+
                                                '</div>'
                                        }
                                    }
                                }
                            }()+'</div>'
                        }

                    }
                    if(str ==''){
                        var str = '<li id="img_none" style="width:100%;height:199px;text-align: center;line-height:32px;margin: 0px;border: none;"><img src="/img/workflow/work/add_work/img_nomessage_03.png" alt="" style="margin-top: 16px;"> <span style="display: block;color: #666;"><fmt:message code="dem.th.NoMessageRecord" />!</span> </li>'
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
                        str+=' <div class="main-content onmouseover="normalImg($(this))"'+function () {
                            if(numid!=arr[i].from_uid) {
                                return 'notUser'
                            }else{
                                return 'User'
                            }
                        }()+'" uuid="'+ arr[i].uuid +'">\
                                    <p class="main-title '+function () {
                            if(numid == arr[i].from_uid) {
                                return 'colorBule'
                            }else{
                                return ''
                            }
                        }()+'">\
                                        <span class="name-color ">'+arr[i].formUserName+'</span>\
                                        <span class="time-color">'+newDate.format('yyyy-MM-dd h:m')+'</span>\
                                    </p>'+function(){
                            if(arr[i].content !=''){
                                if(arr[i].content.indexOf('<!DOCTYPE HTML PUBLIC') == -1){
                                    return '<p class="main-text" >'+arr[i].content+'</p>';
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
                                        if(arr[i].file.file_size == undefined||arr[i].file.file_size == ''){
                                            arr[i].file.file_size = '0KB';
                                        }
                                        if(arr[i].file.file_name){
                                            return '<div style="margin-left: 10px;position: relative;width: 240px;height: 65px;background-color: #bfd9f5" ondblclick="doQtPer1($(this))">'+
                                                '<div style="position: absolute;left: 20px;top: 12px;width: 40px;height: 40px;"><img src="/img/spirit/chatfile.png" alt="" style="width:100%;"></div>'+
                                                '<span style="position: absolute;left:75px;top: 12px;color: #333;font-size: 14px;">' + arr[i].file.file_name.split('.')[0] + '.'+ arr[i].file.file_name.split('.')[1] +'</span>'+
                                                '<div style="position: absolute;left:75px;top: 34px;color: #828080;"><span>'+ arr[i].file.file_size +'</span><span style="margin-left: 10px"></span></div><div class="jsonstring">'+ str_json +'</div>'+
                                                '</div>'
                                        }else{
                                            return '';
                                        }
                                    }
                                }
                            }
                        }()+'</div>'
                    }
                    if(str ==''){
                        var str = '<li id="img_none" style="width:100%;height:199px;text-align: center;line-height:32px;margin: 0px;border: none;"><img src="/img/workflow/work/add_work/img_nomessage_03.png" alt="" style="margin-top: 16px;"> <span style="display: block;color: #666;"><fmt:message code="dem.th.NoMessageRecord" />!</span> </li>'
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
    function getLocalTime(nS) {
        return new Date(parseInt(nS) * 1000).toLocaleString().substr(0,21)
    }
    function isFloat(n) {
        return n+".0"!=n;
    }

    function doQtPer(e){
        var url = e.siblings('.jsonstring').text();
        new QWebChannel(qt.webChannelTransport, function(channel) {
            var content = channel.objects.interface;
            content.xoa_sms(url,'',"SEND_IMG_URL");
        });
    }
    function doQtPertp(e){
        var url = e.find('.jsonstring').text();
        console.log(typeof url)
        console.log(url)
        new QWebChannel(qt.webChannelTransport, function(channel) {
            var content = channel.objects.interface;
            content.xoa_sms(url,'',"SEND_IMG_URL");
        });
    }
    function doQtPer1(e){
        var url = e.find('.jsonstring').text();
        console.log(typeof url)
        console.log(url)
        new QWebChannel(qt.webChannelTransport, function(channel) {
            var content = channel.objects.interface;
            content.xoa_sms(url,'',"SEND_MESSAGE_URL");
        });
    }


    function ajaxwj(page,nums,searchnum){
        var page = page;
        var num = nums;
        var searchnum = searchnum;
        // var search = $('.searchbox').val();
        if(num == 1){
            var type = 'file';
        }else{
            var type = 'img';
        }
        layer.load();
        if(time == undefined){
            layer.closeAll();
        }else{
            var data = {
                of_from:from,
                of_to:to,
                last_time:time*1000,
                msg_type:msg_type,
                pagenum:page,
                type:type,
            }
            $.post('/im/showMessageListRilegou',data,function (json) {
                var str = '';
                var data = json.obj;
                var newDate = new Date();
                if(nums == 1){
                    for(var i=0;i<json.obj.length;i++){
                        if(data[i].content !=undefined){
                            newDate.setTime(data[i].time * 1000);
                            var size =data[i].file.file_size;
                            data[i].file['time'] = data[i].time;
                            var str_json = JSON.stringify(data[i].file);
                            if(size == undefined||size == ''){
                                size = '0KB';
                            }
                            if(data[i].file.file_name){
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
                        }

                    }
                    if(searchnum == 1){
                        $('#mainbox1 .main').html('');
                        if(str ==''){
                            var str = '<li id="img_none" style="width:100%;height:199px;text-align: center;line-height:32px;margin: 0px;border: none;"><img src="/img/workflow/work/add_work/img_nomessage_03.png" alt="" style="margin-top: 16px;"> <span style="display: block;color: #666;"><fmt:message code="dem.th.NoMessageRecord" />!</span> </li>'
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
                            var str = '<li id="img_none" style="width:100%;height:199px;text-align: center;line-height:32px;margin: 0px;border: none;"><img src="/img/workflow/work/add_work/img_nomessage_03.png" alt="" style="margin-top: 16px;"> <span style="display: block;color: #666;"><fmt:message code="dem.th.NoMessageRecord" />!</span> </li>'
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
                    $('#mainbox2 .main').html('');
                    for(var i=0;i<json.obj1.length;i++){
                        var zj = json.obj1[i];
                        var ss = json.object[zj];
                        var str1 = '';
                        for(var j=0;j<ss.length;j++){
                            var img = "/xs?"+ ss[j].file.thumbnail_url;
                            ss[j].file['time'] = ss[j].time;
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
                        var str = '<li id="img_none" style="width:100%;height:199px;text-align: center;line-height:32px;margin: 0px;border: none;"><img src="/img/workflow/work/add_work/img_nomessage_03.png" alt="" style="margin-top: 16px;"> <span style="display: block;color: #666;"><fmt:message code="dem.th.NoMessageRecord" />!</span> </li>'
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

    }


    $(function () {
        var pd1 = 0;
        var pd2 = 0;
        $('.tabbox li').on('click',function(){
            var idnum = $(this).attr('data-id');
            $(this).addClass('search').siblings().removeClass('search');
            $('.searchbox').val('');
            if(idnum == 0){
                // $('.searchDiv').show();
                $('.page-data0').hide()
                $('.page-data1').hide()
                $('.page-data2').hide()
                $('#mainboxsearch').hide();
                $('#mainbox').show();
                $('#mainbox1').hide();
                $('#mainbox2').hide();
                ajaxData(1,0,1);
            }else if(idnum == 1){
                // $('.searchDiv').show();
                $('.page-data1').hide()
                $('.page-data0').hide()
                $('.page-data2').hide()
                $('#mainboxsearch').hide();
                $('#mainbox').hide();
                $('#mainbox1').show();
                $('#mainbox2').hide();
                ajaxwj(1,1,1);
                // if(pd1 == 0){
                //     ajaxwj(1,1,1);
                //     pd1 = 1;
                // }
            }else{
                // $('.searchDiv').hide();
                $('.page-data2').hide()
                $('.page-data0').hide()
                $('.page-data1').hide()
                $('#mainboxsearch').hide();
                $('#mainbox').hide();
                $('#mainbox1').hide();
                $('#mainbox2').show();
                ajaxwj(1,2,1);
                // if(pd2 == 0){
                //     ajaxwj(1,2,1);
                //     pd2 = 1;
                // }
            }
        })
        /***************滚动刷新*************************************/
        $('#mainbox').on('scroll',function(){
            $('.specialBox').remove();$('.specialClass').removeClass('specialClass');
            if($('#mainbox').scrollTop() == 0){
                $('.page-data0 .pageClick').eq(0).trigger('click');
            }
        });
        $('.page-data0 .pageClick').on('click',function () {
            var num1 = parseInt($('.page-data0 .onePage').text());
            var num2 = parseInt($('.page-data0 .allPage').text());
            if(num1 >= 1 && num1 <= num2){
                if($(this).attr('data-page')==1){
                    if(num1 != num2){
                        ajaxData(++num1,1,1);
                    }else{
                        layer.msg('无更多内容！')
                        <%--new QWebChannel(qt.webChannelTransport, function(channel) {--%>
                        <%--    var content = channel.objects.interface;--%>
                        <%--    content.xoa_sms('','<fmt:message code="sup.th.NoMoreContent" />',"send_ts");--%>
                        <%--});--%>
                    }
                }else if($(this).attr('data-page')==2){
                    if(num1 > 1){
                        ajaxData(--num1,1,1);
                    }else{
                        new QWebChannel(qt.webChannelTransport, function(channel) {
                            var content = channel.objects.interface;
                            content.xoa_sms('','<fmt:message code="sup.th.NoMoreContent" />',"send_ts");
                        });
                    }
                }
                $('.page-data0 .onePage').html(num1);
            }else{
                new QWebChannel(qt.webChannelTransport, function(channel) {
                    var content = channel.objects.interface;
                    content.xoa_sms('','<fmt:message code="sup.th.NoMoreContent" />',"send_ts");
                });
            }
        })

        $('#mainboxsearch').on('scroll',function(){
            var scroll = $('#mainboxsearch').scrollTop() + 670;
            if(scroll == $('#mainboxsearch .main').height()){
                $('.page-data4 .pageClick').eq(0).trigger('click');
            }
        });
        $('.page-data4 .pageClick').on('click',function () {
            var num1 = parseInt($('.page-data4 .onePage').text());
            var num2 = parseInt($('.page-data4 .allPage').text());
            if(num1 >= 1 && num1 <= num2){
                if($(this).attr('data-page')==1){
                    if(num1 != num2){
                        ajaxData(++num1,1,0);
                    }else{
                        new QWebChannel(qt.webChannelTransport, function(channel) {
                            var content = channel.objects.interface;
                            content.xoa_sms('','<fmt:message code="sup.th.NoMoreContent" />',"send_ts");
                        });
                    }
                }else if($(this).attr('data-page')==2){
                    if(num1 > 1){
                        ajaxData(--num1,1,0);
                    }else{
                        new QWebChannel(qt.webChannelTransport, function(channel) {
                            var content = channel.objects.interface;
                            content.xoa_sms('','<fmt:message code="sup.th.NoMoreContent" />',"send_ts");
                        });
                    }
                }
                $('.page-data4 .onePage').html(num1);
            }else{
                new QWebChannel(qt.webChannelTransport, function(channel) {
                    var content = channel.objects.interface;
                    content.xoa_sms('','<fmt:message code="sup.th.NoMoreContent" />',"send_ts");
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
            document.getElementById("mainbox2").style.height = winHeight - 46  + "px";
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

        /***************阻止右键默认事件，添加右键删除功能********************/
        $("div").bind("contextmenu", function(){
            return false;
        })

    })
    // function dbclick(t,event){
    //
    //     event.stopPropagation();
    //     var top = event.clientY;
    //     var left = event.clientX;
    //     $('.specialBox').remove();$('.specialClass').removeClass('specialClass');
    //     t.after('<ul class="specialBox" style="top: '+ top +'px;left: '+ left +'px;"><li onclick="deleteData($(this),event)">删除</li></ul>');
    //     t.addClass('specialClass');
    // }
    function normalImg(e) {
        $('.specialBox').remove();$('.specialClass').removeClass('specialClass');
    }
    function deleteData(e,event) {
        event.stopPropagation();
        var uuid = e.parents('.main-content').attr('uuid');
        var $this = e.parents('.main-content');
        layer.confirm('是否删除？', {
            btn: ['确定', '取消'] //按钮
        }, function () {
            //确定删除，调接口
            $.post('/im/deleteByUUID',{uuid:uuid},function(res){
                if(res.flag){
                    layer.msg('删除成功', {icon: 6});
                    $this.remove();
                }else{
                    layer.msg('删除失败', {icon: 2});
                }
            })
        }, function () {
            layer.closeAll();

        });

    }
    $(document).on('click',function(){
        $('.specialBox').remove();$('.specialClass').removeClass('specialClass');
    });
</script>
</html>