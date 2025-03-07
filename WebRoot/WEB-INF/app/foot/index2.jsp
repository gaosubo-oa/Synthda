<%--
  Created by IntelliJ IDEA.
  User: mr.circle
  Date: 2017/7/27
  Time: 11:03
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@taglib prefix="mvc" uri="http://www.springframework.org/tags/form" %>
<%@taglib prefix="fmt" uri="http://www.springframework.org/tags" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
%>
<html>
<head>
    <title><fmt:message code="foot.th.mapShow" /></title>
    <link rel="stylesheet" href="/css/foot/index.css">
    <link rel="stylesheet" href="/lib/layer/skin/default/layer.css">
    <link rel="stylesheet" href="/lib/pagination/style/pagination.css">
    <link rel="stylesheet" href="/lib/laydate/need/laydate.css">
    <link rel="stylesheet" href="/css/base.css">
    <script type="text/javascript" src="../js/xoajq/xoajq1.js"></script>
    <script src="/lib/layer/layer.js?20201106"></script>
    <script src="/js/base/base.js"></script>
    <script src="/lib/laydate/laydate.js"></script>
    <script src="/lib/pagination/js/jquery.pagination.min.js" type="text/javascript" charset="utf-8"></script>
    <script type="text/javascript" src="http://api.map.baidu.com/api?v=2.0&ak=7HSdUGqKaz5U0ph0LIQ2Qd4rFmFZA2kY"></script>
    <script src="../js/jquery/jquery.cookie.js"></script>
</head>
<style>
    .Query{
        margin-top: 16px;
        background: #00a0e9;
        margin-left: 10px;
        padding:5px 10px;
        border-radius: 4px;
        color: #fff;
        cursor: pointer;
    }

</style>
<body>
<div class="headTop">
    <div class="headImg">
        <img src="/img/commonTheme/${sessionScope.InterfaceModel}/yibanfawen.png" alt="">
    </div>
    <h1 class="divTitle">
        <fmt:message code="foot.th.mapShow" />
    </h1>
</div>
<div class="mainRight" id="allmap" style="height: 600px;width: 100%;margin-top: 61px">

</div>

</div>
<script>
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
    function getCookie (key) {
        var arr=document.cookie.split('; '); //多个cookie之间是用;+空格连接的
        for (var i = 0; i < arr.length; i++) {
            var arr2=arr[i].split('=');
            if(arr2[0]==key){
                return arr2[1];
            }
        }
        return false;//如果函数没有返回值，得到的结果是undefined
    }
    var res=$.GetRequest();
    //detail:1,app:1.uid:,time:
    //    $(function(){
    //        var time = res.time;
    //        var uid = res.uid;
    //        var data={
    //            time:time,
    //            uid:uid,
    //            detail:1,
    //            app:1
    //        }
    //        $.get('/footprint/getWebFootPrint',data,function (json) {
    //            var str='';
    //            var arr=json.obj
    //            for(var i=0;i<arr.length;i++){
    //
    //            }
    //
    //
    //        },'json')
    //    })
</script>
<script type="text/javascript">


    function getLocalTime(nS) {
        return new Date(parseInt(nS) * 1000).toLocaleString().substr(0,17)
    }
    var user_id='';
    $('.mainRight').height($(document).height()-50)
    var maps={
        map:null,
        point:null,
        init:function (fn) {   //BMAP_HYBRID_MAP
            this.map = new BMap.Map("allmap",{mapType:BMAP_NORMAL_MAP});    // 创建Map实例
            this.point = new BMap.Point(res.lng,res.lat);//设置坐标
            this.map.centerAndZoom(this.point, 16);//创建比例
            this.map.addControl(new BMap.MapTypeControl());   //添加地图类型控件
            this.map.setCurrentCity("北京");          // 设置地图显示的城市 此项是必须设置的
            this.map.enableScrollWheelZoom(true);     //开启鼠标滚轮缩放
            gridMembermap(undefined,$.cookie('uid'))
            if(fn!=undefined){
                fn()
            }
        }
    }




    var theRockGardenMap={//网格员位置方法展示地图方法
        data:[],
        init:function (latitudeAndLongitude,fn) {
            this.data=latitudeAndLongitude;
            var dataArr=this.data;
            for(var i=0;i<dataArr.length;i++){
                var points=new BMap.Point(parseFloat(dataArr[i].lantitude),parseFloat(dataArr[i].longitude))//对象实例化
                var marker;
                if(i==0){
                    var myIcon = new BMap.Icon("/img/grid/qiandaohongqi.png",
                        new BMap.Size(34,34));
                    marker = new BMap.Marker(points,{icon:myIcon});

                }else if(i==(dataArr.length-1)){
                    var myIcon = new BMap.Icon("/img/grid/zhongzhi.png",
                        new BMap.Size(34,34));
                    marker = new BMap.Marker(points,{icon:myIcon});
                }else {
                    marker = new BMap.Marker(points);//创建标注
                }
                var label;
                maps.map.addOverlay(marker);// 将标注添加到地图中
                marker.addEventListener("onmouseover", function(i,markers,labels){
                    return function () {
                        labels = new BMap.Label(dataArr[i].users.userName+'&nbsp;&nbsp;&nbsp;&nbsp;' +
                            ''+getLocalTime(dataArr[i].updateTime)+'<br/>'+dataArr[i].location
                            ,{offset:new BMap.Size(-20,-30)});
                        labels.setStyle({
                            backgroundColor :"0.7",
                            border :"1px solid red",
                            borderRadius:'6px',
                            fontWeight :"bold",
                            background:'#fff',
                            padding:'3px 6px'
                        })
                        markers.setLabel(labels);
                    }
                }(i,marker,label),false);
                marker.addEventListener("onmouseout", function(marker){
                    return function () {
                        $(marker.Yc.nextElementSibling).remove()
                        console.log(marker)
                    }

                }(marker),false);
            }
            if(typeof fn=='function'){
                fn();
            }

        }
    }


    var scopeOfTheCommunity= {
        polygon: null,
        polyline: null,
        init: function (dataArr, num, ids, type, strData) {//范围显示
            var colors = 'blue';
            if (num == 1) {
                colors = '#3A4F0B';
            }
            this.polygon = new BMap.Polygon(dataArr, {
                strokeColor: colors,
                strokeWeight: 2,
                strokeOpacity: 1,
                fillOpacity: 0.05
            });  //创建多边形
//                var strIng=strData;
            maps.map.addOverlay(this.polygon);   //增加多边形
        },
        lineinits: function (dataArr) {//人员连线
            this.polyline = new BMap.Polyline(dataArr, {strokeColor: "red", strokeWeight: 2, strokeOpacity: 1, fillOpacity: 0.05});   //创建折线
            maps.map.addOverlay(this.polyline);   //增加折线
        }
    }
    function gridMembermap(time,numid) {

        maps.map.clearOverlays();
        var time = res.time;
        var uid = res.uid;
        $.get('/footprint/getWebFootPrint',{
            time:time,
            uid:uid,
            detail:1,
            app:1
        },function (json) {
            if(json.flag){
                //stoneGarden();
                var objarr=json.obj.reverse();
                theRockGardenMap.init(json.obj,function () {
                    var arr=[];
                    for(var i=0;i<objarr.length;i++){
                        arr.push(new BMap.Point(parseFloat(objarr[i].lantitude),parseFloat(objarr[i].longitude)))
                    }
                    scopeOfTheCommunity.lineinits(arr)
                })
            }
        },'json')
    }

    function stoneGarden() {
        scopeOfTheCommunity.init([//初始化石园街道
            new BMap.Point(118.001231,34.391279),
            new BMap.Point(118.034576,34.379303),
            new BMap.Point(118.038097,34.375371),
            new BMap.Point(118.032348,34.376145),
            new BMap.Point(118.032492,34.372034),
            new BMap.Point(118.038097,34.371914),
            new BMap.Point(118.032061,34.364942),
            new BMap.Point(118.046218,34.365836),
            new BMap.Point(118.050314,34.355704),
            new BMap.Point(118.024084,34.346644),
            new BMap.Point(118.023509,34.340563),
            new BMap.Point(118.02164,34.340176),
            new BMap.Point(118.027893,34.322767),
            new BMap.Point(117.986427,34.320858),
            new BMap.Point(117.98578,34.326523),
            new BMap.Point(117.965011,34.323721),
            new BMap.Point(117.980678,34.352038),
            new BMap.Point(117.986858,34.350369)
        ])
    }

    $('[name="printDate"]').val(new Date().Format("yyyy-MM-dd"))
    maps.init(function () {

    })//地图初始化

    $('.Querysl').click(function () {
        gridMembermap($('[name="printDate"]').val(),$.cookie('uid'))
    })


    $('.Querytwo').click(function () {
        var  dataids=null;
        if($('#roleName').attr('dataid')!=undefined){
            dataids=$('#roleName').attr('dataid').replace(',','')
        }

        gridMembermap($('[name="printDateshijian"]').val(),dataids)
    })

    $('.headTop ul li').click(function () {
        $(this).siblings('li').removeClass('active');
        $(this).addClass('active');
        if($(this).attr('data-type')==0){
            $('.mainLeft>label').show()
            $('.mainLeft>div').hide()
            gridMembermap($('[name="printDate"]').val(),$.cookie('uid'))
        }else if($(this).attr('data-type')==1){
            $('.mainLeft>label').hide()
            $('.mainLeft>div').show()
            var  dataids=null;
            if($('#roleName').attr('dataid')!=undefined){
                dataids=$('#roleName').attr('dataid').replace(',','')
            }
            gridMembermap($('[name="printDateshijian"]').val(),dataids)

        }

    })


    $('.roleName').click(function () {
        user_id='roleName';
        $.popWindow('/common/selectUser?0')
    })
    $.ajax({
        type:'get',
        url:'/syspara/selectTheSysPara?paraName=IS_SHOW_JMJ',
        dataType:'json',
        success:function (res) {
            if(res.object.length!=0){
                var data=res.object[0]
                if (data.paraValue!=0){
                    $('.divTitle').after('<span style="color: red;font-family: Microsoft YaHei;font-weight: bolder;font-size: 16pt;line-height: 45px;margin-left: 10px"> 机密级★ </span>')
                }
            }
        }
    })



</script>
</body>
</html>
