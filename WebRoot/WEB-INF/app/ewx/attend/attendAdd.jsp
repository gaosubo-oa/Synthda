<%--
  Created by IntelliJ IDEA.
  User: gaoran
  Date: 2020/3/25
  Time: 11:43
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
<script type="text/javascript" src="../../js/xoajq/xoajq3.js"></script>
<script type="text/javascript" src="../../js/base/base.js"></script>
<script type="text/javascript" src="../../js/ewx/waterMark.js?20190819.2"></script>
<script type="text/javascript" src="../../lib/mui/mui/mui.min.js"></script>
<script type="text/javascript" src="../../js/diary/m/simbaJs.js"></script>
<link rel="stylesheet" href="../../lib/mui/mui/mui.picker.min.css"/>
<script type="text/javascript" src="../../lib/mui/mui/mui.picker.min.js"></script>

<style>

    .all {
        width: 100%;
        height: 100%;
    }

    .content {
        width: 96%;
        height: calc(100% - 245px);
        margin: 0 auto;
        border: #BDBDBD solid 1px;
        border-radius: 6px;
    }

    .content .c_title {
        background: #e6e6e6;
        height: 35px;
        line-height: 35px;
        font-size: 18px;
        text-align: center;
    }

    .content .c_con {
        height: 500px;
    }

    .content .c_con ul li {
        border-bottom: #E6E6E6 solid 1px;
        padding: 5px;
        position: relative;
        min-height: 45px;
    }

    .content .c_con ul li img {
        width: 17px;
    }

    .content .c_con ul li div {
        position: absolute;
        width: 70px;
        color: #FFFFFF;
        height: 30px;
        font-size: 18px;
        line-height: 30px;
        display: inline-block;
        border-radius: 2px;
        padding: 1px 5px;
    }

    .content .c_con ul li .time {
        position: absolute;
        left: 80px;
        line-height: 30px;
    }


    .content .c_con ul li .address {
        display: inline-block;
        font-size: 12px;
        width: calc(100% - 200px);
        margin-left: 145px;
    }

    .content .c_con ul li .type {
        position: absolute;
        right: 10px;
        line-height: 20px;
    }


    .bottom {
        position: relative;
        bottom: 0;
        height: 215px;
        margin-top: 30px;
        text-align: center;
        border-top: #8e8e8e solid 1px;
    }

    .bottom .qiandao {
        background: #fa6165;
        color: #ffffff;
        font-size: 18px;
        width: 80%;
        height: 35px;
        line-height: 35px;
        border: 0;
        margin-top: 20px;
    }
    .bottom .qiandao:disabled {
        background: grey;
    }
    .nowTime{
        font-weight: bold;
        margin-top: 20px;
        font-size: 18px;
    }
    .locationName{
        width: 90%;
        margin: 15px auto 0px auto;
        font-size: 18px;
        font-weight: bold;
    }
    .isLoction{
        margin-top: 10px;
        color: red;
        font-weight: bold;
        font-size: 16px;
    }
</style>
<head>
    <title>打卡</title>
</head>
<body>
<div class="all">
    <div class="map">

    </div>
    <div class="content">
        <div class="c_title">
            打卡记录
        </div>
        <div class="c_con">
            <ul class="c_con_ul">


            </ul>
        </div>
    </div>
    <div class="bottom">
        <div class="nowTime">正在获取当前时间...</div>
        <div class="locationName">正在获取定位信息...</div>
        <div class="isLoction"></div>
        <button class="qiandao">立即打卡</button>
    </div>

</div>
<script charset="utf-8" src="https://map.qq.com/api/js?v=2.exp&key=24YBZ-ZSCWB-672U2-NA7UC-RIOST-PKBXE&libraries=geometry"></script>
<script src="https://3gimg.qq.com/lightmap/components/geolocation/geolocation.min.js"></script>
<script src="/js/base/vconsole.min.js"></script>
<script>
    // var vConsole = new VConsole();
    // 通过腾讯地图获取当前定位展示
    initialize()

    function loadScript() {
        //var script = document.createElement("script");
        // script.src = "//apis.map.qq.com/tools/geolocation/min?key=24YBZ-ZSCWB-672U2-NA7UC-RIOST-PKBXE&referer=suzhuo&callback=initialize"
        // script.src = "//api.map.baidu.com/api?v=2.0&ak=7HSdUGqKaz5U0ph0LIQ2Qd4rFmFZA2kY&callback=initialize";
        //document.body.appendChild(script);
        initialize();
    }
    var uid = "";
    var nowDate = new Date();
    var type = $.GetRequest().type;
    var attendSetType = localStorage.getItem('attendSetType')||'';
    var attendSetObj = localStorage.getItem('attendSetObj')||'';
    var address = "";
    var sid = '';
    var setLocationOn = '';
    var setLocation = '';
    var ranges = '';
    // 从企业微信api获取的定位信息
    // var wxLocation = localStorage.getItem('wxLocation')||'';
    console.log(JSON.parse(attendSetObj))
    if(attendSetType == 'true'&&attendSetObj){

        sid = JSON.parse(attendSetObj).sid;
        setLocationOn = JSON.parse(attendSetObj).locationOn;
        if(setLocationOn == 1){
            $('.qiandao').prop('disabled', true)
        }
        setLocation = JSON.parse(attendSetObj).location;
        ranges = JSON.parse(attendSetObj).ranges;
    }
    // window.onload = loadScript;
    function showPosition(loc){
        // 通过腾讯地图获取定位成功
        console.log(loc);
        address = function(){
            if(loc.province != loc.city){
                return loc.province
            }else{
                return ''
            }
        }() + loc.city + function(){
            if(loc.addr.indexOf(loc.district) == -1){
                return loc.addr
            }else{
                return '';
            }
        }() + loc.addr;
        $('.locationName').text('当前定位：'+ address)
        var start = new qq.maps.LatLng(loc.lat, loc.lng);
        console.log(setLocationOn)
        console.log(setLocation)
        console.log(ranges)
        if(setLocationOn == 1){
            console.log('开启定位范围')
            var coordinate = setLocation;// 设置打卡点经纬度
            var arr = coordinate.split(",");// 切割经纬度
            var lng = arr[0];
            var lat = arr[1];
            // 获取打卡点的百度坐标点
            var pointAttendance = new qq.maps.LatLng(lat, lng);

            // 获取打卡点和定位之前的距离
            var d =  Math.round(qq.maps.geometry.spherical.computeDistanceBetween(start, pointAttendance)*10)/10;
            console.log(d)
            if (parseFloat(d) > parseFloat(ranges)) {
                $('.qiandao').prop('disabled', true)
                $('.isLoction').text('您不在签到范围内')
            }else{
                $('.isLoction').text('');
                $('.qiandao').prop('disabled', false)
            }
        }
    }
    function showErr(){
        // 通过腾讯地图获取定位失败
        console.log('定位失败')
        initialize();
    }
    function initialize() {
        // 使用腾讯地图获取当前定位
        var geolocation = new qq.maps.Geolocation("24YBZ-ZSCWB-672U2-NA7UC-RIOST-PKBXE", "suzhuo");
        geolocation.getLocation(showPosition, showErr);
    }
    // function initialize(){
        // 测试获取的企业微信坐标和百度地图直接获取的坐标没有什么差异，这么作区分经测试作用不大，先注释掉
        // if(wxLocation != ''){
        // console.log('企业微信获取经纬度：' + wxLocation)
        //     // 从企业微信api获取的定位信息不为空时
        //     setTimeout(function(){
        //         var convertor = new BMap.Convertor();
        //         var pointArr = [];
        //         var ggPoint = new BMap.Point(wxLocation.split('|')[0], wxLocation.split('|')[1]);
        //         pointArr.push(ggPoint);
        //         // 获取的WGS84需要转换为BD09坐标
        //         convertor.translate(pointArr, 1, 5, translateCallback)
        //     }, 1000);

        // 通过百度地图获取定位
        // var geolocation = new BMap.Geolocation(); //浏览器定位
        // geolocation.enableSDKLocation();
        // geolocation.getCurrentPosition(function (position) {
        //     if (this.getStatus() == BMAP_STATUS_SUCCESS) {
        //         //通过Geolocation类的getStatus()可以判断是否成功定位。
        //         console.log('当前定位position: ')
        //         console.log(JSON.stringify(position, null, 4));
        //         var lat = position.point.lat;
        //         var lng = position.point.lng;
        //         // 当前定位：北京市丰台区南四环西路
        //         // var lat = 39.837295303982;
        //         // var lng = 116.2982066742;
        //         console.log('BD09坐标系:'+ lng + ', ' + lat)
        //         //将经纬度传递给百度地图API，获取地址信息
        //         var geoc = new BMap.Geocoder();
        //         var thisPoint = new BMap.Point(lng, lat);
        //         // 设置了考勤范围
        //         if(setLocationOn == 1){
        //             var coordinate = setLocation;// 设置打卡点经纬度
        //             var arr = coordinate.split(",");// 切割经纬度
        //             var lon = arr[0];
        //             var lat = arr[1];
        //             // 获取打卡点的百度坐标点
        //             var pointAttendance = new BMap.Point(lon, lat);
        //             var map = new BMap.Map('map');
        //             // 获取打卡点和定位之前的距离
        //             var d = map.getDistance(thisPoint, pointAttendance).toFixed(2);
        //             console.log(d)
        //             if (parseFloat(d) > parseFloat(ranges)) {
        //                 $('.qiandao').prop('disabled', true)
        //                 $('.isLoction').text('您不在签到范围内')
        //             }else{
        //                 $('.isLoction').text('');
        //                 $('.qiandao').prop('disabled', false)
        //             }
        //         }
        //         geoc.getLocation(thisPoint, function (rs) {
        //             // 获取地址信息
        //             var addComp = rs.addressComponents; // 地址信息
        //             var pcd = ''; // 省、市、区
        //             pcd = function(){
        //                 // 处理直辖市，返回的province省和city市是一样的情况
        //                 if(addComp.province == addComp.city){
        //                     return ''
        //                 }else{
        //                     return addComp.province
        //                 }
        //             }() + addComp.city + addComp.district;
        //             address = pcd + addComp.street + addComp.streetNumber;
        //             console.log(address)
        //             // 如果street为空，意味着只返回了省市区，没有返回街道信息
        //             if(addComp.street == ''){
        //                 // 看百度地图返回的对象rs是否存在surroundingPois，代表定位附近的POI点
        //                 if (rs.surroundingPois.length > 0) {
        //                     // 存在surroundingPois的话，看第一个POI点的address
        //                     var inaddress = rs.surroundingPois[0].address||'';
        //                     // 判断POI点的address信息里面是否已经包含省市区信息，
        //                     // 包含省市区信息就不需要再拼接定位的address
        //                     if(inaddress.indexOf(pcd) > -1){
        //                         // 包含直接在后面加上title输出，
        //                         address =  inaddress + ' ' + rs.surroundingPois[0].title;
        //                     }else{
        //                         // 不包含在前面加上address，后面加上title
        //                         address =  address + inaddress + ' ' + rs.surroundingPois[0].title;
        //                     }
        //                 }
        //             }else{ // 返回了街道信息
        //                 // 看百度地图返回的对象rs是否存在surroundingPois，代表定位附近的POI点
        //                 if (rs.surroundingPois.length > 0) {
        //                     // 存在surroundingPois的话，看第一个POI点的address
        //                     address =  address + ' ' + rs.surroundingPois[0].title + '附近';
        //                 }
        //             }
        //             console.log(JSON.stringify(rs, null, 4));
        //             $('.locationName').text('当前定位：'+ address)
        //         }, { maximumAge: 10 });
        //     }
        //
        // }, { enableHighAccuracy: true });
        // 腾讯前端定位组件三模式
        // var geolocation = new qq.maps.Geolocation();
        // geolocation.getLocation(function(postion){
        //     console.log(JSON.stringify(position, null, 4));
        // }, function(e){
        //     console.log('定位失败：'+ JSON.stringify(e))
        // }, {timeout: 9000});
    // }
    // WGS84->D09坐标，转换完之后的回调函数
    translateCallback = function (data){
        if(data.status === 0) {
            var marker = new BMap.Marker(data.points[0]);
            console.log('企业微信获取经纬度转换后: ' + JSON.stringify(data))
            var geoc = new BMap.Geocoder();
            geoc.getLocation(new BMap.Point(data.points[0].lng, data.points[0].lat), function (rs) {
                // 获取地址信息
                // 看百度地图返回的对象rs是否存在surroundingPois，代表定位附近的POI点
                // 存在surroundingPois的话，再看第一个POI点的address是否包含省、市、区等信息
                //     包含就直接在后面加上title输出，
                //     不包含就在前面加上rs.address，后面加上title输出
                // 不存在直接获取rs.address作为定位
                if (rs.surroundingPois.length > 0) {
                    var inaddress = rs.surroundingPois[0].address||'';
                    if(inaddress.indexOf(rs.address) > -1){
                        address =  inaddress + rs.surroundingPois[0].title;
                    }else{
                        address =  rs.address + inaddress + rs.surroundingPois[0].title;
                    }
                } else {
                    address = rs.address;
                }
                console.log('企业微信获取的定位：')
                console.log(JSON.stringify(rs, null, 4));
            }, { maximumAge: 10 });
        }
    }
    setInterval(function (){
        if(new Date().getHours() < 10){
            var hours = '0' + new Date().getHours();
        }else{
            var hours = new Date().getHours();
        }
        if(new Date().getMinutes() < 10){
            var minutes = '0' + new Date().getMinutes();
        }else{
            var minutes = new Date().getMinutes();
        }
        if(new Date().getSeconds() < 10){
            var second = '0' + new Date().getSeconds();
        }else{
            var second = new Date().getSeconds();
        }
        var time = hours + ':' + minutes + ':' + second;
        $('.nowTime').text(time)
    }, 1000)
    $('.locationName').on('click', function(){
        $('.locationName').text('正在获取定位信息...')
        $('.isLoction').text('');
        setTimeout(function(){
            initialize()
        }, 1500)

    })
    $(function () {

        if(attendSetType == 'false'){
            $.ajax('/user/getNowLoginUser', {
                dataType: 'json',//服务器返回json格式数据
                type: 'get',//HTTP请求类型
                success: function (data) {
                    if (data.flag) {
                        uid = data.object.uid;
                        // type=1 2 3 4 5 6 的时候 都是正常的上下班 需要查询考勤时间
                        $.ajax('/attend/seledAttend', {
                            dataType: 'json',//服务器返回json格式数据
                            type: 'get',//HTTP请求类型
                            data: {
                                uid: uid,
                                attendDate: nowDate.getFullYear() + "-" + (nowDate.getMonth() + 1) + "-" + nowDate.getDate()
                            },
                            success: function (res) {
                                if (res.flag) {
                                    attendQuery(res);
                                    if(res.data&&res.data.attendSet){
                                        setLocationOn = res.data.attendSet.locationOn;
                                        if(setLocationOn == 1){
                                            $('.qiandao').prop('disabled', true)
                                        }
                                        setLocation = res.data.attendSet.location;
                                        ranges = res.data.attendSet.ranges;
                                    }
                                }
                            }
                        })

                    }
                }
            });
        }else{
             $.get('/attend/selUserTodayAttendInfo', {
                 sid: sid
             }, function(data){
                if(data.flag){
                    attendQuery(data, 2)
                }
             })

        }
        function attendQuery(res, dataType) {
            var str_li = "";
            // 小于等于6，或者等于107、108，就是 正常的上班下班 进行遍历
            if (type <= 6||type == "107"||type == "108") {
                if(dataType == 2){
                    var attendList = res.data;
                }else{
                    var attendList = res.data.attendList;
                }
                for (let i = 0; i < attendList.length; i++) {
                    let atime = attendList[i].atime;
                    let atimestate = attendList[i].atimestate;
                    var typeStyle = '';
                    var address = attendList[i].address;
                    if (address.indexOf(",") !== -1 && address.split(",")[2]) {
                        address = address.split(",")[2];
                    }
                    if (atime == 0) {
                        atime = "00:00:00"
                    } else {
                        atime = formatDate(atime);
                    }
                    if (atimestate != "正常") {
                        typeStyle = 'style="color:red;"'
                    }
                    if (attendList[i].commute == '1') {
                        str_li += '<li type="1" >\n' +
                            '<div style="background: #fa6165">\n' +
                            '    <img src="/img/ewx/attend/shangban.png">\n' +
                            '    <span class="shangban" >上班</span>\n' +
                            '</div>\n' +
                            '<span class="time">' + atime + '</span>\n' +
                            '<span class="address">' + address + '</span>\n' +
                            '<span class="type" ' + typeStyle + '>' + atimestate + '</span>\n' +
                            '</li>'
                    } else if (attendList[i].commute == '2') {
                        str_li +=
                            '<li type="2" >\n' +
                            '    <div style="background: #2798f5">\n' +
                            '        <img src="/img/ewx/attend/xiaban.png">\n' +
                            '        <span class="shangban" >下班</span>\n' +
                            '    </div>\n' +
                            '    <span class="time">' + atime + '</span>\n' +
                            '    <span class="address">' + address + '</span>\n' +
                            '    <span class="type" ' + typeStyle + '>' + atimestate + '</span>\n' +
                            '</li>'
                    }
                }
            }

            // 7和8是加班
            if (type == 7 || type == 8) {
                var overTimeWork = res.data.overTimeWork1;
                for (let i = 0; i < overTimeWork.length; i++) {
                    let atime = overTimeWork[i].atime;
                    let atimestate = overTimeWork[i].atimestate;
                    var typeStyle = '';
                    var address = overTimeWork[i].address;
                    if (address.indexOf(",") !== -1 && address.split(",")[2]) {
                        address = address.split(",")[2];
                    }
                    if (atime == 0) {
                        atime = "00:00:00"
                    } else {
                        atime = formatDate(atime);
                    }
                    if (atimestate != "正常") {
                        typeStyle = 'style="color:red;"'
                    }
                    if (overTimeWork[i].commute == '1') {
                        str_li += '<li type="1" >\n' +
                            '<div style="background: #fa6165">\n' +
                            '    <img src="/img/ewx/attend/shangban.png">\n' +
                            '    <span class="shangban" >上班</span>\n' +
                            '</div>\n' +
                            '<span class="time">' + atime + '</span>\n' +
                            '<span class="address">' + address + '</span>\n' +
                            '<span class="type" ' + typeStyle + '>' + atimestate + '</span>\n' +
                            '</li>'
                    } else {
                        str_li +=
                            '<li type="2" >\n' +
                            '    <div style="background: #2798f5">\n' +
                            '        <img src="/img/ewx/attend/xiaban.png">\n' +
                            '        <span class="shangban" >下班</span>\n' +
                            '    </div>\n' +
                            '    <span class="time">' + atime + '</span>\n' +
                            '    <span class="address">' + address + '</span>\n' +
                            '    <span class="type" ' + typeStyle + '>' + atimestate + '</span>\n' +
                            '</li>'
                    }
                }
            }


            // 9和10是值班
            if (type == 9 || type == 10) {
                var dutyWork = res.data.dutyWork;
                for (let i = 0; i < dutyWork.length; i++) {
                    let atime = dutyWork[i].atime;
                    let atimestate = dutyWork[i].atimestate;
                    var typeStyle = '';
                    var address = dutyWork[i].address;
                    if (address.indexOf(",") !== -1 && address.split(",")[2]) {
                        address = address.split(",")[2];
                    }
                    if (atime == 0) {
                        atime = "00:00:00"
                    } else {
                        atime = formatDate(atime);
                    }
                    if (atimestate != "正常") {
                        typeStyle = 'style="color:red;"'
                    }
                    if (dutyWork[i].commute == '1') {
                        str_li += '<li type="1" >\n' +
                            '<div style="background: #fa6165">\n' +
                            '    <img src="/img/ewx/attend/shangban.png">\n' +
                            '    <span class="shangban" >上班</span>\n' +
                            '</div>\n' +
                            '<span class="time">' + atime + '</span>\n' +
                            '<span class="address">' + address + '</span>\n' +
                            '<span class="type" ' + typeStyle + '>' + atimestate + '</span>\n' +
                            '</li>'
                    } else {
                        str_li +=
                            '<li type="2" >\n' +
                            '    <div style="background: #2798f5">\n' +
                            '        <img src="/img/ewx/attend/xiaban.png">\n' +
                            '        <span class="shangban" >下班</span>\n' +
                            '    </div>\n' +
                            '    <span class="time">' + atime + '</span>\n' +
                            '    <span class="address">' + address + '</span>\n' +
                            '    <span class="type" ' + typeStyle + '>' + atimestate + '</span>\n' +
                            '</li>'
                    }
                }
            }


            $('.c_con_ul').html(str_li);
        }
        // 点击打卡
        $('.qiandao').click(function () {
            if(address == ""){
                console.log(location.href)
                if (location.href.indexOf('http:') > -1) {
                    address = "企业微信打卡(当前网页为http，仅https支持获取当前地址)";
                }else{
                    address = "企业微信打卡";
                }
            }
            console.log(address)
            var data = {
                uid: uid,
                type: type,
                address: address,
                device: "H5",
                remark: "",
                phoneId: "",
                attendDate: nowDate.getFullYear() + "-" + (nowDate.getMonth() + 1) + "-" + nowDate.getDate()
            }
            if(attendSetType == 'true'){
                data['sid'] = sid;
            }
            $.ajax('/attend/addAttend', {
                dataType: 'json',//服务器返回json格式数据
                type: 'post',//HTTP请求类型
                data: data,
                success: function (res) {
                    if (res.flag) {
                        layer.msg("打卡成功！");
                        location.reload();
                    } else {
                        layer.msg(res.msg +'！');
                    }
                }
            })
        });
        // 格式化返回时间
        function formatDate(time) {
            var now = new Date(time * 1000);
            var year = now.getFullYear();
            var month = now.getMonth() + 1;
            var date = now.getDate();
            var hour = now.getHours();
            var minute = now.getMinutes();
            var second = now.getSeconds();
            if (minute < 10) {
                minute = "0" + minute;
            }
            if (second < 10) {
                second = "0" + second;
            }
            return hour + ":" + minute + ":" + second;
        }
    })
</script>
</body>
</html>
