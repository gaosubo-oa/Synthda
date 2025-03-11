<%--
  Created by IntelliJ IDEA.
  User: 高速波办公
  Date: 2021/7/15
  Time: 11:16
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=no" >
    <meta name="apple-mobile-web-app-capable" content="yes">
    <meta name="apple-mobile-web-app-status-bar-style" content="black">
    <title>打卡</title>
    <link rel="stylesheet" href="../../css/email/m/styles.css"/>
    <link rel="stylesheet" href="../../css/email/m/style.css">
    <link rel="stylesheet" href="../../css/email/m/mail.css">

    <script type="text/javascript" src="../../js/xoajq/xoajq3.js"></script>
    <script type="text/javascript" src="../../js/base/base.js"></script>
    <style>
        *{
            padding: 0;
            margin: 0;
            font-family: Microsoft yahei,Helvetica Neue,Helvetica,PingFang SC,Tahoma,Arial,sans-serif;
        }
        html{
            font-size: 10px;
        }
        .tabUl{
            height: 7%;
        }
        .tabUl li{
            float: left;
            width: calc(50% - 1px);
            height: 100%;
            line-height: 350%;
            box-sizing: border-box;
            color: #949494;
            font-size: 0.6rem;
            text-align: center;
        }
        .tabUl li:nth-child(1){
            border-right: 1px solid #ddd;
        }
        .tabUl li.active{
            color: #2b7fe0;
            border-bottom: 2px solid #2b7fe0;
        }

        .content{
            display: none;
            width: 100%;
            height: 93%;
            padding: 2.5% 0;
            background: #f5f5f5;
            box-sizing: border-box;
            border-top: 1px solid #ddd;
        }
        .contentBox{
            width: 94%;
            height: 100%;
            margin: auto;
            box-sizing: border-box;
        }
        .mapBox{
            width: 100%;
            height: 40%;
            border: 1px solid #ddd;
            box-sizing: border-box;
            border-radius: 5px;
        }
        .locationBox{
            display: none;
            position: relative;
            width: 100%;
            height: 40%;
            box-sizing: border-box;
            background: #fff;
        }
        .locationBox .location{
            padding-top: calc(40% - 1.65rem);
            color: #417505;
            font-size: 0.6rem;
            text-align: center;
        }
        .locationBox img{
            width: 1.5rem;
            padding-bottom: 0.5rem;
        }
        .locationBox p{
            padding-bottom: 0.35rem;
            font-weight: bold;
            font-size: 0.8rem;
            letter-spacing: 0.05rem;
        }
        .radiusBox{
            position: relative;
            width: 100%;
            height: 60%;
            padding-top: 20%;
            background: #fff;
            box-sizing: border-box;
        }
        .radiusOut{
            position: relative;
            width: 6rem;
            height: 6rem;
            margin: auto;
            border-radius: 100%;
            background: #ffbb13;
        }
        .radiusIn{
            position: absolute;
            width: 5.3rem;
            height: 5.3rem;
            border-radius: 100%;
            background: #fff;
            top: 0.35rem;
            left: 0.35rem;
        }
        .timeBox{
            height: 50%;
            text-align: center;
            font-size: 1.25rem;
            font-weight: bold;
            line-height: 4.25rem;
        }
        .statusBox{
            height: 50%;
            text-align: center;
            font-size: 0.6rem;
            line-height: 2rem;
        }
        .tips{
            position: absolute;
            bottom: 0.75rem;
            width: 100%;
            text-align: center;
            font-size: 0.6rem;
            color: #949494;
            letter-spacing: 0.01rem;
        }

        .hidden{
            display: none;
        }
        .show{
            display: block;
        }

    </style>
</head>
<body>
    <div class="header">
        <ul class="tabUl">
            <li class="active">上下班打卡</li>
            <li class="hidden">外出打卡</li>
        </ul>
    </div>
    <div class="content">
        <div class="contentBox">
            <div class="mapBox" id="map">

            </div>
            <div class="locationBox">
                <div class="location">
                    <img src="/img/attend/m/cityOne.png" alt="">
                    <p>你已在打卡范围内</p>
                    <span>北京银盾保安服务有限公司</span>
                </div>
            </div>
            <div class="radiusBox">
                <div class="radiusOut" onclick="signIn()">
                    <div class="radiusIn">
                        <div class="timeBox"><span></span></div>
                        <div class="statusBox"><span>上班打卡</span></div>
                    </div>
                </div>
                <div class="tips">
                    请在08:30之前打卡
                </div>
            </div>
        </div>
    </div>
    <script>
        var uid, avatar, KQjson, point, pointAttendance, map;
        var distance = 500
        setInterval(function () {
            $('.timeBox span').html(new Date().Format('hh:mm'))
        }, 1000);
    </script>
    <script>
        // 加载百度地图
        function loadScript() {
            var script = document.createElement("script");
            script.src = "//api.map.baidu.com/api?v=2.0&ak=7HSdUGqKaz5U0ph0LIQ2Qd4rFmFZA2kY&callback=initialize";
            document.body.appendChild(script);
        }
        // 加载地图点
        function initialize() {
            map = new BMap.Map('map');
            point = new BMap.Point(116.331398, 39.897445);
            map.centerAndZoom(point, 12);
            map.enableScrollWheelZoom(true);

            var geolocation = new BMap.Geolocation(); //浏览器定位
            geolocation.getCurrentPosition(function(r){
                if(this.getStatus() == BMAP_STATUS_SUCCESS){
                    var myIcon = new BMap.Icon("/img/user/"+avatar, new BMap.Size(25, 25), {
                        imageSize: new BMap.Size(25, 25)
                    });
                    var mk = new BMap.Marker(r.point, {
                        icon: myIcon
                    });
                    map.addOverlay(mk);
                    map.panTo(r.point);
                    point = new BMap.Point(r.point.lng, r.point.lat); // 获取自己当前位置经纬度

                    if(true){
                        var coordinate = KQjson.attendSet.location||"116.433015,39.910508";// 设置打卡点经纬度
                        var arr = coordinate.split(",");// 切割经纬度
                        var lon = arr[0];
                        var lat = arr[1];
                        pointAttendance = new BMap.Point(lon, lat);
                        map.addOverlay(new BMap.Marker(pointAttendance));
                        // var circle = new BMap.Circle(pointAttendance, distance, { // 打卡地点范围
                        //     fillColor: "blue", // 圆形颜色
                        //     strokeWeight: 1,
                        //     fillOpacity: 0.2,
                        //     strokeOpacity: 0.2
                        // });
                        // map.addOverlay(circle);

                        var d = map.getDistance(point, pointAttendance).toFixed(2);
                        if (parseFloat(d) <= parseFloat(distance)) {
                            GetLocation()
                        }else{
                            var opts = {
                                position: point, // 指定文本标注所在的地理位置
                                offset: new BMap.Size(-57, 15) // 设置文本偏移量
                            };
                            // 创建文本标注对象
                            var label = new BMap.Label('不在打卡范围内', opts);
                            // 自定义文本标注样式
                            label.setStyle({
                                color: 'red',
                                border: 'none',
                                borderRadius: '30px',
                                fontSize: '0.3rem',
                                fontWeight: 'bold',
                                padding: '10px 17px 17px'
                            });

                            map.addOverlay(label); // 标出打卡点的位置
                            $('.content').show()
                        }
                    }
                }
                else {
                    alert('failed'+this.getStatus());
                }
            });
        }
        // 打卡
        function signIn() {
            if(KQjson.attendSet.locationOn == 1){
                // 设置开启位置打卡
                var d = map.getDistance(point, pointAttendance).toFixed(2);
                if (parseFloat(d) <= parseFloat(distance)) {
                    var thisEle = $('.statusBox')
                    var iTO = ifTimeOut(thisEle.attr('time'), thisEle.attr('Ftime'), thisEle.attr('Btime'));
                    if(iTO == true){
                        var nowDate = new Date();
                        $.ajax('/attend/addAttend', {
                            dataType: 'json',//服务器返回json格式数据
                            type: 'post',//HTTP请求类型
                            data: {
                                uid: uid,
                                type: thisEle.attr('num'),
                                address:"企业微信打卡",
                                device: "H5",
                                remark: "",
                                phoneId: "",
                                attendDate: nowDate.getFullYear() + "-" + (nowDate.getMonth() + 1) + "-" + nowDate.getDate()
                            },
                            success: function (res) {
                                if(res.flag){
                                    layer.msg('打卡成功!', {time: 3000}, function(){
                                        history.back()
                                    })
                                }else {
                                    var msg = res.msg;
                                    layer.msg(msg, {time: 3000})
                                }
                            }
                        })
                    }else{
                        layer.msg(iTO, {time: 3000})
                    }
                } else {
                    layer.msg('超出打卡范围，打卡失败！', {time: 3000})
                }
            }else{

            }
        }
        // 地址逆解析
        function GetLocation() {
            var geoc = new BMap.Geocoder();
            geoc.getLocation(point, function (rs) {// 获取当前定位所在详细地址
                var addComp = rs.addressComponents;
                if(addComp.province == addComp.city){
                    var address = addComp.city + addComp.district + addComp.street + addComp.streetNumber;
                }else{
                    var address = addComp.province + addComp.city + addComp.district + addComp.street + addComp.streetNumber;
                }
                $('.mapBox').hide();
                $('.locationBox').show().find('span').html(address);
                $('.content').show()
                //alert("您已在" + address + "打卡成功")
            });
        }
        // 获取打卡数据
        function attendQuery() {
            var nowDate = new Date();
            $.ajax('/attend/seledAttend', {
                dataType: 'json',//服务器返回json格式数据
                type: 'get',//HTTP请求类型
                data: {
                    uid: uid,
                    attendDate: nowDate.getFullYear() + "-" + (nowDate.getMonth() + 1) + "-" + nowDate.getDate()
                },
                async: false,
                success: function (data) {
                    if (data.flag) {
                        KQjson = data.data;
                        distance = KQjson.attendSet.ranges;
                        for(var i=0;i<KQjson.attendList.length;i++){
                            if(KQjson.attendList[i].atimestate == '未签到'){
                                if(KQjson.attendList[i].commute == 1){
                                    var text = '上班打卡'
                                    var Ftime = KQjson.attendSet.worktimeF;
                                    var Btime = KQjson.attendSet.worktimeB;
                                }else{
                                    var text = '下班打卡'
                                    var Ftime = KQjson.attendSet.workafterF;
                                    var Btime = KQjson.attendSet.workafterB;
                                }
                                var iTO = ifTimeOut(KQjson.attendList[i].time, Ftime, Btime);
                                if(iTO == '已过打卡时间'){
                                    continue
                                }else{
                                    $('.statusBox').html(text).attr({
                                        'num': KQjson.attendList[i].num,
                                        'commute': KQjson.attendList[i].commute,
                                        'time': KQjson.attendList[i].time,
                                        'Ftime': Ftime,
                                        'Btime': Btime
                                    });
                                    $('.tips').html('请在'+ KQjson.attendList[i].time +'之前打卡')
                                    break;
                                }
                            }
                        }
                        if(!$('.statusBox').attr('num')){
                            $('.statusBox').html('您已完成打卡');
                            $('.radiusOut').removeAttr('onclick').css('background', '#417505')
                            $('.tips').hide()
                        }
                    }
                }
            })
        }

        // 判断是否超时
        // time是 时分秒 如 09:00:00
        function ifTimeOut(time,worktimeF,worktimeB) {
            var nowDate = new Date();
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
            if(nowTimeStemp < a){
                return '未到打卡时间';
            }
            if(nowTimeStemp>b){
                return '已过打卡时间'
            }
            return true;
        }

    </script>
    <script>
        $.ajax('/user/getNowLoginUser',{
            dataType:'json',
            type:'get',
            async: false,
            success:function(data){
                if(data.flag){
                    uid = data.object.uid;
                    avatar = data.object.avatar;
                    if(avatar == 0){
                        avatar = 'boy.png'
                    }else if(avatar == 1){
                        avatar = 'girl.png'
                    }
                    // type=1 2 3 4 5 6 的时候 都是正常的上下班 需要查询打卡时间
                    attendQuery();
                }
            }
        });
        window.onload = loadScript;
        // rem适配
        (function () {
            var  styleN = document.createElement("style");
            var width = document.documentElement.clientWidth/16;
            styleN.innerHTML = 'html{font-size:'+width+'px!important}';
            document.head.appendChild(styleN);
            $('.timeBox span').html(new Date().Format('hh:mm'))
        })();

    </script>
</body>
</html>
