<%--
  Created by IntelliJ IDEA.
  User: gaoran
  Date: 2020/3/24
  Time: 17:21
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<meta name="viewport"
      content="width=device-width, initial-scale=1.0, user-scalable=0, minimum-scale=1.0, maximum-scale=1.0">
<meta name="apple-mobile-web-app-capable" content="yes">
<meta name="apple-mobile-web-app-status-bar-style" content="black">
<link rel="stylesheet" href="../../css/email/m/jquery.mobile.css"/>
<link rel="stylesheet" href="../../lib/mui/mui/mui.min.css"/>

<link rel="stylesheet" href="../../css/email/m/styles.css"/>
<link rel="stylesheet" href="../../css/email/m/style.css">
<link rel="stylesheet" href="../../css/email/m/mail.css">
<link rel="stylesheet" href="/lib/layui/layui/css/layui.css?20210319.1">
<script type="text/javascript" src="/lib/layui/layui/layui.js"></script>
<script type="text/javascript" src="/lib/layui/layui/layui.all.js"></script>
<script type="text/javascript" src="../../js/xoajq/xoajq3.js"></script>
<script type="text/javascript" src="../../js/base/base.js"></script>
<script type="text/javascript" src="../../js/ewx/waterMark.js?20190819.2"></script>
<script type="text/javascript" src="../../lib/mui/mui/mui.min.js"></script>
<script type="text/javascript" src="../../js/diary/m/simbaJs.js"></script>


<link rel="stylesheet" href="../../lib/mui/mui/mui.picker.min.css"/>
<script type="text/javascript" src="../../lib/mui/mui/mui.picker.min.js"></script>
<style >
    body{
        overflow: auto;
    }
    .banner {
        margin: 0;
    }
    .banner img {
        width: 100%;
    }
    .msg{
        margin: 2%;
        text-align: center;
    }

    .attend_msg{
        border-top: #BDBDBD solid 1px;
    }
    .attend_ul li{
        float: left;
        width: 46%;
        margin: 2%;
        background: #0479b2;
        color: #ffffff;
        height: 60px;
        border-radius: 5px;
        line-height: 60px;
        position: relative;
    }

    .attend_ul li img {
        width: 25px;
        position: absolute;
        top: 16px;
        left: 4px;
    }

    .attend_ul li span {
        font-size: 16px;
        margin-left: 30px;
    }

    .addAttendCant {
        opacity: 0.5;
    }
    .selectType{
        display: inline-block;
        width: 150px;
        border:1px solid #e4e4e4!important;
    }
</style>
<head>
    <title>考勤打卡</title>
</head>
<body>
    <div class="banner" >
        <img src="/img/ewx/attend/banner.png">
    </div>

    <div class="msg">
        <div style="font-weight: bold;font-size: 30px;">
            <span class="date">2020年3月24日</span><span class="week" style="margin-left: 5px;"></span>
        </div>
        <div style="color: #BDBDBD;margin-top: 2%;">
            考勤类型：<span class="attend_type">默认考勤类型</span>
        </div>
    </div>
    <div class="attend_msg">
        <div style="margin: 2%;">
            <ul class="attend_ul">

            </ul>
        </div>
    </div>

<script>
    var uid = "";
    var nowDate = new Date();
    // 设置星期
    var weekday = ["星期日","星期一","星期二","星期三","星期四","星期五","星期六"];
    var myddy = nowDate.getDay();
    $('.week').html(weekday[myddy]);
    // 设置时间
    $('.date').html(nowDate.getFullYear()+"年"+(nowDate.getMonth()+1)+"月"+nowDate.getDate()+"日");
    var typeFlag = false;
    var selecAttendSetObj = {};
    var morenSid = '';
    localStorage.setItem('attendSetType', typeFlag);
    $.get('/attend/checkAttendFree', {}, function(data){
        if(data.flag){
            typeFlag = data.data.attendFreeFlag;
            morenSid = data.data.sid||'';
        }
        if(typeFlag){
            // 在localStorage处理为true，标志开启自主排班设置
            localStorage.setItem('attendSetType', 'true');
            var selectStr = '';
            $.get('/attendSet/selsectAttendSet', {}, function(data){
                if(data.flag){
                    for(var i = 0; i < data.obj.length; i++){
                        selecAttendSetObj[data.obj[i].sid] = data.obj[i];
                        selectStr += '<option value="'+ data.obj[i].sid +'">'+ data.obj[i].title +'</option>'
                    }
                    $('.attend_type').html('<select class="selectType">'+ selectStr +'</select>')
                    if(morenSid != ''){
                        $('.selectType').val(morenSid)
                    }else{
                        morenSid = $('.selectType').val()
                    }

                    attendQuery(selecAttendSetObj[morenSid])
                    // 在localStorage处理attendSetObj，处理打开详情页面显示上、下班数据
                    localStorage.setItem('attendSetObj', JSON.stringify( selecAttendSetObj[morenSid]));

                    $('.selectType').on('change', function(){
                        console.log($(this).val())
                        var data = selecAttendSetObj[$(this).val()];
                        $('.attend_ul').empty()
                        attendQuery(data)
                        // 在localStorage处理attendSetObj，处理打开详情页面显示上、下班数据
                        localStorage.setItem('attendSetObj', JSON.stringify(data));
                    })
                }else{
                    console.log('"/attendSet/selsectAttendSet"接口返回数据失败')
                }
            })

        }
        if(!typeFlag || morenSid == ''){
            $.ajax('/user/getNowLoginUser',{
                dataType:'json',//服务器返回json格式数据
                type:'get',//HTTP请求类型
                success:function(data){
                    if(data.flag){
                        uid = data.object.uid;
                        // type=1 2 3 4 5 6 的时候 都是正常的上下班 需要查询考勤时间

                        $.ajax('/attend/seledAttend', {
                            dataType: 'json',//服务器返回json格式数据
                            type: 'get',//HTTP请求类型
                            data: {
                                uid: uid,
                                attendDate: nowDate.getFullYear() + "-" + (nowDate.getMonth() + 1) + "-" + nowDate.getDate()
                            },
                            success: function (data) {
                                if (data.flag) {
                                    var as = data.data.attendSet;
                                    attendQuery(as);
                                    if(!typeFlag){
                                        $('.attend_type').html(as.title);
                                    }else{
                                        $('.selectType').val(as.sid)
                                    }
                                }
                            }
                        })
                    }
                }
            });
        }

    })

    function attendQuery(as) {
        var worktimeF = as.worktimeF;
        var worktimeB = as.worktimeB;
        var workafterF = as.workafterF;
        var workafterB = as.workafterB;

        var li_str = '';
        for (let i = 1; i <= 8; i++) {
            var atimeSet = as["atime"+i+"Set"];
            var atime = as["atime" + i];
            if (atimeSet != undefined && atimeSet != '' && atime != undefined) {
                var setArr = atimeSet.split("|");
                if (setArr[0] == '1') {
                    if(i == 7||i == 8){
                        var type = '10'+i;
                    }else{
                        var type = i;
                    }
                    if (setArr[1] == '1') {
                        li_str += '<li class="addAttend1" atime="'+atime+'" type="' + type + '" style="background: #fa6165">' +
                            '<img src="/img/ewx/attend/shangban.png">' +
                            '<span class="shangban" atime="' + atime + '">上班（' + atime + '）</span>' +
                            '</li>';
                    } else if (setArr[1] == '2') {
                        li_str += '<li class="addAttend2" atime="'+atime+'" type="' + type + '"  style="background: #2798f5">' +
                            '<img src="/img/ewx/attend/xiaban.png">' +
                            '<span class="xiaban" atime="' + atime + '">下班（' + atime + '）</span>' +
                            '</li>';
                    }
                }
            }
        }

        if (as.isOvertime == '1') {
            li_str += '<li class="addAttend" type="7" style="background: #61c4c4">' +
                '<img src="/img/ewx/attend/shangban.png">' +
                '<span  >加班上班</span>' +
                '</li>' +
                '<li class="addAttend" type="8" style="background: #61c4c4">' +
                '<img src="/img/ewx/attend/xiaban.png">' +
                '<span>加班下班</span>' +
                '</li>'
        }
        if (as.isDuty == '1') {
            li_str += '<li class="addAttend" type="9"  style="background: #61c4c4">' +
                '<img src="/img/ewx/attend/shangban.png">' +
                '<span >值班上班</span>' +
                '</li>' +
                '<li class="addAttend" type="10"  style="background: #61c4c4">' +
                '<img src="/img/ewx/attend/xiaban.png">' +
                '<span >值班下班</span>' +
                '</li>'
        }
        if (as.isGo == '1') {
            li_str += '<li class="flow_li" style="background: #61c4c4">' +
                '<img src="/img/ewx/attend/waichu.png">' +
                '<span class="waichu" >外出申请</span>' +
                '</li>';
        }
        if (as.isLeave == '1') {
            li_str += '<li class="flow_li" style="background: #61c4c4">' +
                '<img src="/img/ewx/attend/waichu.png">' +
                '<span class="qingjia" >请假申请</span>' +
                '</li>';
        }
        if (as.isTrip == '1') {
            li_str += '<li class="flow_li" style="background: #61c4c4">' +
                '<img src="/img/ewx/attend/waichu.png">' +
                '<span class="chuchai" >出差申请</span>' +
                '</li>';
        }
        if (as.isOut == '1') {
            li_str += '<li style="background: #61c4c4">' +
                '<img src="/img/ewx/attend/waichu.png">' +
                '<span class="waiqin">外勤打卡</span>' +
                '</li>';
        }

        $('.attend_ul').append(li_str);

        // 点击申请跳转
        $('.flow_li').bind('click', function () {
            window.open('/workflow/work/workflowIndexh5')
        })
        $('.addAttend1').bind('click', function () {
            var atime = $(this).attr("atime");
            var ifTimeOut1 = ifTimeOut(atime, worktimeF, worktimeB);
            if (ifTimeOut1 == true) {
                window.open('/ewx/attendAdd?type=' + $(this).attr("type"))
            } else {
                layer.msg(ifTimeOut1);
            }
        })
        $('.addAttend2').bind('click', function () {
            var atime = $(this).attr("atime");
            var ifTimeOut2 = ifTimeOut(atime, workafterF, workafterB)
            if (ifTimeOut2 == true) {
                window.open('/ewx/attendAdd?type=' + $(this).attr("type"))
            } else {
                layer.msg(ifTimeOut2);
            }
        })
        $('.addAttend').bind('click', function () {
            window.open('/ewx/attendAdd?type=' + $(this).attr("type"))
        })
    }
    // 判断是否超时
    // time是 时分秒 如 09:00:00
    function ifTimeOut(time,worktimeF,worktimeB) {
        var times = time.split(":");
        var worktimeFs = worktimeF.split(":");
        var worktimeBs = worktimeB.split(":");
        var atimeDate = new Date();
        atimeDate.setHours(times[0]);
        atimeDate.setMinutes(times[1]);
        atimeDate.setSeconds(times[2]);
        var worktimeFDate = new Date();
        worktimeFDate.setHours(worktimeFs[0]);
        worktimeFDate.setMinutes(worktimeFs[1]);
        worktimeFDate.setSeconds(worktimeFs[2]);
        var worktimeBDate = new Date();
        worktimeBDate.setHours(worktimeBs[0]);
        worktimeBDate.setMinutes(worktimeBs[1]);
        worktimeBDate.setSeconds(worktimeBs[2]);
        var zero = new Date();
        zero.setHours('00');
        zero.setMinutes('00');
        zero.setSeconds('00');
        let atimeDateStemp = atimeDate.getTime()/1000;
        let worktimeFDatetemp = (worktimeFDate.getTime()-zero.getTime())/1000;
        let worktimeBDatetemp = (worktimeBDate.getTime()-zero.getTime())/1000;
        let nowTimeStemp = nowDate.getTime()/1000;
        var a = atimeDateStemp-worktimeFDatetemp
        var b = atimeDateStemp+worktimeBDatetemp
        if(nowTimeStemp<a){
            return '未到打卡时间';
        }
        if(nowTimeStemp>b){
            return '已过打卡时间'
        }
        return true;
    }


</script>
</body>
</html>
