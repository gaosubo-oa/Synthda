var doorIndex="";
$.get('/sys/getInterfaceInfo', function (json){
    if (json.flag) {
        if(json.object.weatherCity!=1){
            // 通过百度地图获取地理位置
            // document.write("<script language=javascript src='http://api.map.baidu.com/api?v=2.0&ak=7HSdUGqKaz5U0ph0LIQ2Qd4rFmFZA2kY'></script>");
            // window.onload = loadScript;
            // 修改为手动调用获取城市、天气新的接口
            getWeather();
        }
    }
}, 'json')
function loadScript() {
    var script = document.createElement("script");
    // script.src = "//apis.map.qq.com/tools/geolocation/min?key=24YBZ-ZSCWB-672U2-NA7UC-RIOST-PKBXE&referer=suzhuo"
    // script.src = "http://api.map.baidu.com/api?v=2.0&ak=7HSdUGqKaz5U0ph0LIQ2Qd4rFmFZA2kY&callback=getweatherBefore";//此为v2.0版本的引用方式,加载完成后执行getweatherBefore事件
    // document.body.appendChild(script);
}
function getweatherBefore(){
    var area="";
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
function getMenu(fn) {
    $.get('/getMenu', function (json) {
        if (json.flag) {
            $.ajax({
                url:'/portals/selPortalsById?portalsId=2',
                dataType:'json',
                type:'get',
                success:function(res){
                    var portals= res.object.portalsMenu.split(',');

                    var stringGetMenus = '';
                    for(var j = 0;j<portals.length;j++){
                        for (var i = 0; i < json.obj.length; i++) {
                            if(portals[j] == json.obj[i].id){
                                stringGetMenus += '<a href="javascript:void(0)" onclick="getMenuOpen(this)"  menu_tid="' + json.obj[i].id + '" data-url="' + json.obj[i].url + '"><div class="apply_every_logo">' +
                                    '<img src="img/main_img/app/' + json.obj[i].id + '.png">' +
                                    '<h2 style="color: #666">' + json.obj[i].name + '</h2>' +
                                    '</div></a>'
                            }

                        }
                    }
                    $('.apply_all').html(stringGetMenus)
                    if(fn!=undefined){
                        fn()
                    }
                }
            })

        }
    }, 'json')
}
//获取天气
function getWeather(){

    $.ajax({
        type:'get',
        url:'/widget/getWeatherNews',
        dataType:'json',
        success:function(res){
            if(res.flag && res.object){
                var weekday = ["星期日","星期一","星期二","星期三","星期四","星期五","星期六"];
                var myddy = new Date().getDay();
                $('.weatherImg img').attr('src', res.object.picture)
                $('.weatherText').html(res.object.weather)
                $('.week').html(weekday[myddy])
                $('.du').html(res.object.tempertureOfDay)
                var city = '';
                if( res.object.location != ''){
                    city =  res.object.location;
                }else{
                    city = res.object.cityName;
                }
                $('.area').html(city)

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
}
$(function () {
    // getMenu();
    //首页门户菜单处理
    $.get('/portals/selIndexPortals',function (json) {
        if(json.flag){
            var datas=json.obj;
            var str='';
            var dataObj = [];
            for(var i=0;i<datas.length;i++){
                if(datas[i].useFlag == '1') {
                    dataObj.push(datas[i])

                }
            }
            for(var j = 0;j<dataObj.length;j++){
                var newWindow = 0
                var iframeSrc = dataObj[j].moduleId;
                if (dataObj[j].portalType == 1){
                    if(dataObj[j].newWindow==1){
                        var newWindow = 1
                    }else{
                        var newWindow = 0
                    }
                }else if(dataObj[j].portalType == 2){
                    iframeSrc = '/cmsPub/portal?siteId='+dataObj[j].moduleId;
                    if(dataObj[j].newWindow==1){
                        var newWindow = 1
                    }else{
                        var newWindow = 0
                    }
                }else{
                    if(dataObj[j].moduleId == "/common/myOA2"){
                        iframeSrc = '/common/myOA';
                    }else{
                        if(dataObj[j].newWindow==1){
                            var newWindow = 1
                        }else{
                            var newWindow = 0
                        }
                    }
                }


                if(j== 0){
                    doorIndex = dataObj[j].portalsId
                    str += ' <li data-id="' + dataObj[j].portalsId + '" newWindow="'+newWindow+'" iframeSrc="'+ iframeSrc +'">\
                                     <span class="head_title active">' + dataObj[j].portalName + '</span>\
                                 </li>';
                    if (iframeSrc == '/document/personal_ZDJ' || iframeSrc == '/document/energyEfficiency_ZDJ') {
                        $('#setPersonal_ZDJ').show();
                    }
                    
                    if (iframeSrc.indexOf('operationsCockpit_ZDJ') > -1) {
                        $('#setFullScreen_ZDJ').show();
                    }
                    $('.main_2 ').find('iframe').attr('src',iframeSrc)

                }else {

                    str += ' <li data-id="' + dataObj[j].portalsId + '" newWindow="'+newWindow+'" iframeSrc="'+ iframeSrc +'">\
                                    <span class="head_title">' + dataObj[j].portalName + '</span>\
                                 </li>';

                }
            }
            $('.header ul').html(str);
        }
    },'json')
    var flag=true;
    $('#xianyin').on('click',function(){
        var kuan = document.documentElement.clientWidth||document.body.clientWidth;
        if(flag){
            $('#bottom_show_left').addClass('show_off_tag_bg');
            $('#bottom_hide_left').removeClass('show_off_tag_bg');
            $('#xianyin').removeClass('show_on2');
            $('#xianyin').addClass('show_on');
            $('.cont_left').hide();
            $('.cont_rig').css('width',kuan+'px');
            flag=false;
        }else{
            $('#xianyin').removeClass('show_on');
            $('#xianyin').addClass('show_on2');
            $('#bottom_hide_left').addClass('show_off_tag_bg');
            $('#bottom_show_left').removeClass('show_off_tag_bg');
            $('.cont_left').show();
            $('.cont_rig').css('width',kuan-212+'px');
            flag=true;
        }
        if ( $('#xianyin').attr('url') ){
            $.ajax({
                type: "post",
                url: "/userExt/userExtMenuPanel",
                dataType: 'json',
                data: {
                    menuPanel:function () {
                        if (flag){
                            return '0';
                        }
                        else {
                            return '1';
                        }
                    }()
                },
                success: function (obj) {

                }
            });
        }


    });
})

















