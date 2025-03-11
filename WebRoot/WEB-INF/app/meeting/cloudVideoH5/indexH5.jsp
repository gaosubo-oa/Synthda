<%--
  Created by IntelliJ IDEA.
  User: gaosubo3000
  Date: 2020/9/24
  Time: 16:51
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>云广通视频会议</title>
    <meta name="renderer" content="webkit">
    <meta http-equiv="X-UA-Compatible" content="IE=10,chrome=1">
    <meta name="viewport"
          content="width=device-width, initial-scale=1.0, user-scalable=0, minimum-scale=1.0, maximum-scale=1.0">
    <%--    <link rel="stylesheet" href="../../css/email/m/jquery.mobile.css"/>--%>
    <%--    <link rel="stylesheet" href="../../css/email/m/styles.css"/>--%>
    <%--    <link rel="stylesheet" href="../../css/email/m/style.css">--%>
    <%--    <link rel="stylesheet" href="../../css/email/m/mail.css">--%>
    <script type="text/javascript" src="../../js/notes/jquery-2.1.2.min.js"></script>
    <%--    <script type="text/javascript" src="../../lib/mui/mui/mui.min.js"></script>--%>
    <script type="text/javascript" src="../../js/diary/m/simbaJs.js"></script>

    <link rel="stylesheet" href="../../lib/mui/mui/mui.min.css"/>
    <link rel="stylesheet" href="../../lib/mui/mui/mui.picker.min.css"/>
    <%--    <script type="text/javascript" src="../../lib/mui/mui/mui.picker.min.js"></script>--%>
    <script type="text/javascript" src="../../js/jquery/jquery.min.js"></script>
    <script type="text/javascript" src="../../js/base/base.js"></script>
    <script type="text/javascript" src="../../js/ewx/waterMark.js?20190819.2"></script>
    <link href="../../css/H5/default.css" rel="stylesheet"/>
    <script type="text/javascript" src="../../lib/dropload/dropload.js"></script>
    <link href="../../lib/dropload/dropload.css" rel="stylesheet"/>
</head>
<style>
    .header1 {
        height: 48px;
        display: flex;
        align-items: center;
        justify-content: space-between;
        font-size: 18px;
        color: #fff;
        position: fixed;
        width: 100%;
        z-index: 1;
        background-color: #0089e8;
        box-shadow: 1px 1px 7px rgba(0, 0, 0, .85);
    }

    .header1 i a {
        color: #fff;
        text-decoration: none
    }

    .header1 i {
        display: inline-block;
        padding: 0 13px;
        font-style: normal;
    }

    .header1 i {
        display: inline-block;
        padding: 0 13px;
        font-style: normal;
    }

    .header i a {
        color: #fff;
        text-decoration: none
    }

    .header i {
        display: inline-block;
        padding: 0 13px;
        font-style: normal;
    }

    .herderc {
        background-color: #ececec;
        height: 30px;
        color: #00a0e9;
        margin-top: 10px;
        position: relative;
        z-index: 0;
    }

    body {
        margin: 0;
    }

    /*头部左侧*/
    .process-top .left a {
        position: absolute;
        left: 10px;
        top: 0;
        color: #333;
        width: 10%;
    }

    .mobile {
        position: absolute;
        top: 118px;
        left: 0;
        width: 100%;
        right: 0;
        z-index: 5;
    }

    .nav {
        width: 60%;
        height: 42px;
        margin: 18px 0;
    }

    /*.navc{*/
    /*background-color: #00a0e9;*/
    /*color: #fff;*/
    /*border-radius: 10px;*/
    /*}*/
    .fl {
        float: left;
    }

    .fr {
        float: right;
    }

    p {
        margin: 6px 0;
    }

    .spanc {
        background-color: #00a0e9;
        width: 40px;
        display: inline-block;
        text-align: center;
        height: 22px;
        line-height: 21px;
        border-radius: 6px;
        color: #fff;
    }

    li {
        list-style: none;
    }

    a {
        text-decoration: none;
        color: #000;
    }

    .ove {
        overflow: hidden;
        text-overflow: ellipsis;
        white-space: nowrap;
        font-weight: bold;
    }

    .nav ul {
        width: 60%;
        height: 28px;
        margin: 8px 20%;
        border-radius: 0.8333333333333333px;
        border: 1px solid #3d91e4;
        border-left: none;
        border-right: none;
        position: fixed;
        z-index: 2;
        padding-left: 0;
        border-radius: 4px;
    }

    .navs li {
        width: 50%;
        float: left;
        border-right: 1px solid #3d91e4;
        border-left: 1px solid #3d91e4;
        color: #3d91e4;
        height: 101%;
        line-height: 28px;
        text-align: center;
        font-size: 15px;
        border-radius: 4px 0px 0px 4px;
    }

    .nav .navs .navc {
        color: #ffffff;
        background: #3d91e4;
    }
</style>
<body>
<div class="box">
    <%--        //head--%>
    <div class="header1">
        <i><a href="javascript:;" class="mui-action-back mui-icon mui-icon-left-nav mui-pull-left" onclick="back()"></a></i>
        <span>云广通视频会议</span>
        <i><a href="/JHTMeeting/newAdd">申请会议</a></i>
    </div>
    <%--        //tab--%>
    <div style="height: 40px"></div>
    <div class="nav">
        <ul class="navs">
            <li class="navc fl">我申请的</li>
            <li class="fr" style="border-radius: 0px 4px 4px 0px;">我参与的</li>
        </ul>
    </div>
    <div class="mobile animated fadeInRight">
        <ul class="mui-table-view listTavle">
        </ul>
    </div>
    <div class="nav1 " style="display: none">
        <ul class="listTavle2">
        </ul>
    </div>
</div>
<iframe id="attendMeetingIfr" width="0" height="0" src=""></iframe>
</body>
</html>
<script>
    function back(){
        window.Android.onback();
    }
    $('.navs').on('click', 'li', function () {
        $('.listTavle2').html('')
        $('li').removeClass('navc')
        $(this).addClass('navc')
        if ($('.fl').hasClass('navc')) {
            $('.nav1').css('display','none')
            $('.mobile').css('display','block')
            listShe(1)
            window.location.reload()
        }
        if ($('.fr').hasClass('navc')) {
            $('.listTavle').html('')
            $('.nav1').css('display','block')
            $('.mobile').css('display','none')
            $('.mobile').css('background-color','#fff')
            // window.location.reload()
            listCan(2)
        }
    })
    listShe(1)
    function listShe(num) {
        var page = 0;
        // 每页展示5个
        var size = 5;
        var str='&userId=1'
        if(num==2){
            str='&hostUserId=1&summaryUserId=1&userIds=1'
        }else{
            str='&userId=1'
        }
        $('.listTavle li').remove();
        // dropload
        $('.listTavle').dropload({
            scrollArea: window,
            domDown: {
                domClass: 'dropload-down',
                domRefresh: '<div class="dropload-refresh">上拉加载更多</div>',
                domLoad: '<div class="dropload-load"><span class="loading"></span>加载中...</div>',
                domNoData: '<div class="dropload-noData">暂无更多数据</div>'
            },
            loadDownFn: function (me) {
                page++;
                // 拼接HTML
                var app = '';
                var  nstr = "";
                var now = new Date();
                var nyear = now.getFullYear();
                var nmonth = now.getMonth()+1;
                if(nmonth<10){
                    nmonth = "0"+nmonth;
                }
                nstr = nyear+"-"+nmonth;
                $.ajax({
                    type: 'get',
                    url: '/JHTMeeting/findJHTMeeting?' + str,
                    dataType: 'json',
                    data: {
                        // data:nstr,
                        page: page,
                        pageSize: size
                    },
                    success: function (res) {
                        var data = res.obj;


                        if(data.length>0) {
                            for (var i = 0; i < data.length; i++) {
                                var join = ''
                                if(data[i].meetStatus == 2||data[i].meetStatus == 3){
                                    // return '<a class="join" href="javascript:join(' + data[i].roomId + ',' + data[i].roomPwd + ');">参加会议</a>&emsp;'
                                    join =  '<a class="join" style="cursor:pointer;position: absolute;right: 5px;color: dodgerblue"  onclick="attendMeeting(' + data[i].roomId + ',' + data[i].roomPwd + ')">参加会议</a>&emsp;'
                                }else{
                                    join =  ''
                                }
                                app+= " <a class='add'  href='/JHTMeeting/details?usid=1&meetingId="+data[i].meetingId+"&roomId="+data[i].roomId+"'  style='position:relative;' meetingId = '"+data[i].meetingId+"' calId='" + data[i].roomId + "' meetName = '" + data[i].meetName + "'>" +
                                    // "<img style='width: 40px;height: 40px;position: absolute;top: 13px;left: -5px;' src='../../img/H5/1.10.png' alt=''>" +
                                    "<ul class='mui-table-view'>" +
                                    '<li class="mui-table-view-cell">'+
                                    "<p class='ove1' style='font-size: 16px;color:#333;font-weight:900;'>" + data[i].meetName + "" +
                                    "<span>"+join+"</span>" +
                                    "</p>" +
                                    "<p class='ove2'>开始时间:" + data[i].startTime + "</p>" +
                                    "<p class='ove3'>结束时间:" + data[i].endTime + "</p>" +
                                    // "<p class='ove3'>/p>" +
                                    '</li>'+
                                    "</ul>" +
                                    "</a>"
                            }
                            // 如果没有数据
                            if(data.length==0){
                                // 锁定
                                me.lock();
                                // 无数据
                                me.noData();
                            }
                        } else {
                            // 锁定
                            me.lock();
                            // 无数据
                            me.noData();
                        }
                        // 为了测试，延迟1秒加载
                        setTimeout(function () {
                            // 插入数据到页面，放到最后面
                            $('.dropload-down').before(app);
                            // 每次数据插入，必须重置
                            me.resetload();
                        }, 1000);
                    },
                    error: function (xhr, type) {
                        alert('Ajax error!');
                        // 即使加载出错，也得重置
                        me.resetload();
                    }
                });
            },
            threshold: 50
        });
    }


    function listCan(num) {
        var page = 0;
        // 每页展示5个
        var size = 5;
        var str='&userId=1'
        if(num==2){
            str='&hostUserId=1&summaryUserId=1&userIds=1'
        }else{
            str='&userId=1'
        }
        $('.listTavle2 li').remove();
        // dropload
        $('.listTavle2').dropload({
            scrollArea: window,
            domDown: {
                domClass: 'dropload-down2',
                domRefresh: '<div class="dropload-refresh">上拉加载更多</div>',
                domLoad: '<div class="dropload-load"><span class="loading"></span>加载中...</div>',
                domNoData: '<div class="dropload-noData">暂无更多数据</div>'
            },
            loadDownFn: function (me) {
                page++;
                // 拼接HTML
                var app = '';
                var  nstr = "";
                var now = new Date();
                var nyear = now.getFullYear();
                var nmonth = now.getMonth()+1;
                if(nmonth<10){
                    nmonth = "0"+nmonth;
                }
                nstr = nyear+"-"+nmonth;
                $.ajax({
                    type: 'get',
                    url: '/JHTMeeting/findJHTMeeting?' + str,
                    dataType: 'json',
                    data: {
                        // data:nstr,
                        page: page,
                        pageSize: size
                    },
                    success: function (res) {
                        var data = res.obj;
                        if(data.length>0) {
                            for (var i = 0; i < data.length; i++) {
                                app+= " <a class='add' href='/JHTMeeting/details?usid=1&meetingId="+data[i].meetingId+"'style='position:relative;' meetingId = '"+data[i].meetingId+"' calId='" + data[i].roomId + "' meetName = '" + data[i].meetName + "'>" +
                                    // "<img style='width: 40px;height: 40px;position: absolute;top: 13px;left: -5px;' src='../../img/H5/1.10.png' alt=''>" +
                                    "<ul class='mui-table-view'>" +
                                    '<li class="mui-table-view-cell">'+
                                    "<p class='ove1' style='font-size: 16px;color:#333;font-weight:900;'>" + data[i].meetName + "</p>" +
                                    "<p class='ove2'>开始时间:" + data[i].startTime + "</p>" +
                                    "<p class='ove3'>结束时间111:" + data[i].meetAddress + "</p>" +
                                    "<p class='ove4'><a class='join' style='cursor:pointer;'  onclick='attendMeeting(" + data[i].roomId + "," + data[i].roomPwd + ")'>参加会议</a></p>" +
                                    '</li>\n'+
                                    "</ul>" +
                                    "</a>"
                            }
                            // 如果没有数据
                            if(data.length==0){
                                // 锁定
                                me.lock();
                                // 无数据
                                me.noData();
                            }
                        } else {
                            // 锁定
                            me.lock();
                            // 无数据
                            me.noData();
                        }
                        // 为了测试，延迟1秒加载
                        setTimeout(function () {
                            // 插入数据到页面，放到最后面
                            $('.dropload-down2').before(app);
                            // 每次数据插入，必须重置
                            me.resetload();
                        }, 1000);
                    },
                    error: function (xhr, type) {
                        alert('Ajax error!');
                        // 即使加载出错，也得重置
                        me.resetload();
                    }
                });
            },
            threshold: 50
        });
    }

    function attendMeeting(roomid,classpwd) {
        var attendMeetingIfr = $('#attendMeetingIfr')

        $('#attendMeetingIfr').attr('src','/JHTMeeting/staVideoH5')

        var pwd=classpwd;
        if(classpwd=='0'){
            pwd='0000'
        }

        $.ajax({
            url: '/syspara/selectTheSysPara',
            type: 'get',
            dataType: 'json',
            data: {paraName:'WD_MEETING'},
            success: function (res) {
                var type=eval("(" + res.object[0].paraValue + ")")
                if(type.jhtType=='iactive'){
                    if (( /(iPhone|iPad|iPod|iOS)/i.test(navigator.userAgent) )) {

                    } else if (/(Android)/i.test(navigator.userAgent)) {
                        Android.Instant('111.47.113.243',$('#already').attr('name'),'',roomid,pwd);
                    } else {
                        //私有云
                        // window.open('http://cloud.iactive.com.cn/startmeeting?SrvIP=111.47.113.243&app=1&auto=1&AnonymousUser=1&UserName='+$('#already').attr('name')+'&RoomID='+roomid+'&ClassPwd='+pwd+'');
                        var urlVideo = 'http://cloud.iactive.com.cn/startmeeting?SrvIP=111.47.113.243&app=1&auto=1&AnonymousUser=1&UserName='+$('#already').attr('name')+'&RoomID='+roomid+'&ClassPwd='+pwd+''
                        var urlVideoSi = replaceInfo(urlVideo)
                        attendMeetingIfr.attr('urlVid',urlVideoSi)
                    }

                }else if(type.jhtType=='liveuc'){
                    //公有云
                    // window.open('http://mware.liveuc.net/ameeting?app=imm&isanyuser=1&nickname='+$('#already').attr('name')+'&roomid='+roomid+'&classpwd='+pwd+'');
                    var siVideo = 'http://mware.liveuc.net/ameeting?app=imm&isanyuser=1&nickname='+$('#already').attr('name')+'&roomid='+roomid+'&classpwd='+pwd+''
                    var gongsiVideo = replaceInfo (siVideo)
                    attendMeetingIfr.attr('urlVid',gongsiVideo)
                }
            }
        })

    }
    function replaceAll (str, oldSubStr, newSubStr)
    {
        var ret = "";
        if (str != null && oldSubStr!= null && newSubStr!= null)
        {
            ret = str.replace(new RegExp(oldSubStr, 'gm'), newSubStr);
        }
        return ret;
    }

    function replaceInfo(url)
    {
        var roomid = $('.roomId').attr('title'); //会议id
        var nickname = $('.roomPwd').attr('title'); //主持人信息
        var classpwd = $('.hostUserName').attr('title');  //会议密码

        var ret = url;
        ret = replaceAll(ret, "IACTIVEROOMID", roomid);
        ret = replaceAll(ret, "IACTIVENICKNAME", encodeURIComponent(nickname));
        ret = replaceAll(ret, "IACTIVECLASSPWD", encodeURIComponent(classpwd));

        return ret;
        // $('#attendMeetingIfr').attr('urlVid',ret)
    }
</script>
