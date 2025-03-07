    <%@ page language="java" contentType="text/html; charset=UTF-8"
             pageEncoding="UTF-8" %>
        <%@taglib prefix="mvc" uri="http://www.springframework.org/tags/form" %>
        <%@taglib prefix="fmt" uri="http://www.springframework.org/tags" %>
            <%
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>


        <!DOCTYPE html>
        <html>
        <head>
        <meta charset="UTF-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
        <title>知识管理</title>
        <meta name="renderer" content="webkit">
        <meta http-equiv="X-UA-Compatible" content="IE=10,chrome=1">
        <meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=0, minimum-scale=1.0,
        maximum-scale=1.0">
        <link rel="stylesheet" type="text/css" href="/lib/layui/layui/css/layui.css?20210319.1"/>
        <script type="text/javascript" src="/lib/layui/layui/layui.js"></script>
        <script type="text/javascript" src="/lib/layui/layui/layui.all.js"></script>
        <script type="text/javascript" src="/js/xoajq/xoajq1.js"></script>
        <script type="text/javascript" src="/js/xoajq/xoajq2.js"></script>
        <script src="/js/base/base.js" type="text/javascript" charset="utf-8"></script>
        <script type="text/javascript" src="/js/echarts.min.js"></script>
        <style>
            html, body{
            font-family: "Microsoft Yahei" !important;
            }
        body{
        background: #F5F7FA;
        }
        .number:hover{
        color: #1195FB !important;
        }
        .fourTop{
        display: flex;
        font-size: 17px;
        /*width: 188px;*/
        height: 66px;
        border-top: 1px solid #ccc;
        border-right: 1px dashed #ccc;
        border-bottom: 1px dashed #ccc;
        padding-top: 12px;
        }
        .fourBottom{
        display: flex;
        font-size: 17px;
        /*width: 188px;*/
        height: 66px;
        border-right: 1px dashed #ccc;
        border-bottom: 1px dashed #ccc;
        padding-top: 12px;
        }
        .block-item-title{
        font-size: 12px;
        color: #5d5d5d;
        width: 100%;
        white-space: nowrap;
        overflow: hidden;
        text-overflow: ellipsis;
        margin-top: 8px;
        }
        .layui-icon{
        font-size: 20px;
        }
        .block-item-content{
        height: 37px;
        line-height: 37px;
        text-align: center;
        }
        .block-item:hover{
        background: #ebebeb;
        opacity: 0.8;
        }
        .left{
        width: 67%;
        }
        .left2 a{
        cursor: pointer;
        }
        .left2 .layui-table td{
        border:none;
        }
        .block-item-bg{
        width: 150px;
        height: 200px;
        }
        .block-item-bg:hover {
        opacity: 0.6;
        }
        .block-item-icon{
        position: absolute;
        top: 70px;
        left: 92px;
        }
        .left3 a:hover{
        color: #018efb !important;
        }
        .catListTitle{
        border: 1px solid #EBEBEB;
        color: #008ff3;
        font-size: 18px;
        font-weight: normal;
        padding: 10px 10px;
        }
        .catListView{
        padding: 0px 15px;
        margin-top: 22px;
        padding-bottom: 30px;
        }
        .catListView ul li {
        padding: 5px 15px;
        font-size: 12px;
        color: #777;
        height: 15px;
        }
        .catListView ul li:hover {
        background-color: #f5f5f5;
        }
        .catListView ul li a{
        color: #777;
        display: inline-block;
        white-space: nowrap;
        overflow: hidden;
        text-overflow: ellipsis;
        vertical-align: middle;
        width: calc(100% - 60px);
        cursor: pointer;
        }
        .numClass{
        color: red;
        width: 45px;
        /*margin-left: 30px;*/
        }
        .catListView ul{
        border: 1px solid #EBEBEB;
        border-top: none;
        }
        .list-content .headimg {
        width: 30px;
        height: 30px;
        line-height: 30px;
        background-size: 30px;
        border-radius: 20px;
        margin-top: 5px;
        cursor: pointer;
        }
        .td-item{
        font-size: 12px;
        }
        .tr-item{
        border-bottom: 1px solid #f3f3f3;
        margin: 10px 0px;
        padding-bottom: 10px;
        }

        /*去掉li标签默认样式*/
        li{
        list-style: none;
        }
        /*最外层盒子样式处理：
        1.设置与轮播图高宽一致
        2.设置纵向距顶部50px，水平居中
        3.设置自己为固定位置
        */
        .outer{
        height: 355px;
        position:relative;
        }
        /*轮播图片集合处理:
        1.将其设置为脱离文档流
        2.设置距顶部和左侧都为0
        */
        .img li{
        width:100% ;
        height: 470px;
        position: absolute;
        top: 0;
        left: 0;
        }
        .img .wid{
        width: 100%;
        height: 355px;
        }
        /*顺序按钮区域处理：
        1.设置脱离文档流
        2.通过设置text-align、width使其整体水平居中
        3.设置距离底部20px
        */
        .num{
        position: absolute;
        text-align: center;
        width: 100%;
        bottom: 20px;
        }
        /*顺序按钮处理:
        1.将其设置为行级及块级兼容显示
        2.设置其宽高
        3.设置背景色及字体颜色
        4.设置字体水平居中
        5.通过设置line-height与height一致，使其字体纵向居中
        6.设置其样式为圆形
        7.增加按钮左右间距
        */
        .num li{
        display: inline-block;
        width: 20px;
        height: 20px;
        background-color: darkgray;
        color: white;
        text-align: center;
        line-height: 20px;
        border-radius: 50%;
        margin: 0 20px;
        }
        /*左、右按钮相同部分处理:
        1.设置其脱离文档流
        2.设置其宽高
        3.设置背景色及字体颜色
        4.设置字体水平居中
        5.通过设置line-height与height一致，使其字体纵向居中
        6.通过设置top、margin-top使其整体纵向居中
        7.默认不显示
        */
        .btn{
        position: absolute;
        width: 20px;
        height: 50px;
        background-color: darkgray;
        color: white;
        text-align: center;
        line-height: 50px;
        top: 50%;
        margin-top: -25px;
        display: none;
        }
        /*左侧按钮处理:
        设置左侧为0
        */
        .left_btn{
        left: 0;
        }
        /*右侧按钮处理:
        设置右侧为0
        */
        .right_btn{
        right: 0;
        }
        /*鼠标悬浮至轮播图区域时左、右按钮处理:
        1.设置左右按钮显示样式为行级块级兼容
        2.设置鼠标放置在左右按钮时样式为小手
        */
        .outer:hover .btn{
        display: inline-block;
        cursor: pointer;
        }
        .current{
        background-color: red!important;
        }
        .daishou li:hover{
        background: #e8f4fc;
        cursor: pointer;
        }
        .noData{
        margin-top: 5%;
        }
            .yangshi :hover{
            background-color:#F0F7FF ;
            }
        </style>
        </head>
        <body>
        <div class="layui-fluid" style="padding: 10px;">
        <div style="display: flex">
        <%--<div  style=" background: url('/img/default/052.jpg') center center/cover no-repeat ; width: 67%;">--%>
        <div  style=" width: 63%;height:355px">
            <div class="outer">
            <ul class="img">
            <li><a href="#"><img src="../img/menu/zhishis.png" class="wid"></a></li>
            <%--<li><a href="#"><img src="../img/menu/zhishi.png" class="wid"></a></li>--%>
            <%--<li><a href="#"><img src="../img/menu/dians.png"  class="wid"></a></li>--%>
            <%--<li><a href="#"><img src="../img/menu/zhishi.png" class="wid"></a></li>--%>
            </ul>

            <%--<div class="left_btn btn"><img src="../img/menu/left.png" style="width: 100%;" alt=""></div>--%>
            <%--<div class="right_btn btn"><img src="../img/menu/right.png" style="width: 100%;" alt=""></div>--%>
            </div>
        </div>
        <div  style="margin-left: 25px;padding-top: 16px;background: #FFFFFF;width: 36%;">
        <div style="display: flex;margin-left: 10px;"><div style="background: #3393FC"><i style="color: white" class="layui-icon layui-icon-note"></i></div><div style="margin-left: 7px;">文件柜统计</div></div>
        <div style="display: flex">
        <div style="margin-top: 6px;width: 50%;">
        <div class="fourTop" >
        <div style="padding-left: 20px;"><i style="color: #79B564" class="layui-icon layui-icon-template-1"></i></div>
        <div style="margin-left: 10px;"><div id="number"></div><div class="block-item-title">公共文件柜创建量</div></div>
        </div>
        </div>
        <div style="margin-top: 6px;width: 50%;">
        <div class="fourTop"  >
        <div style="padding-left: 20px;"><i style="color: #79B564" class="layui-icon layui-icon-template-1"></i></div>
        <div style="margin-left: 10px;"><div id="numberd"></div><div class="block-item-title">个人文件柜创建量</div></div>
        </div>
        </div>
        </div>
        <div style="display: flex">
        <div style="margin-top: 6px;width: 50%;">
        <div class="fourBottom" >
        <div style="padding-left: 20px;"><i style="color: #79B564" class="layui-icon layui-icon-template-1"></i></div>
        <div style="margin-left: 10px;"><div id="numbers"></div><div class="block-item-title">公共文件柜阅读量</div></div>
        </div>
        </div>
        <%--<div style="margin-top: 6px;width: 50%;">--%>
        <%--<div class="fourBottom" >--%>
        <%--<div style="padding-left: 20px;"><i style="color: #79B564" class="layui-icon layui-icon-template-1"></i></div>--%>
        <%--<div style="margin-left: 10px;"><div><a class="number" style="color: #65a94b;font-size: 18px;cursor: pointer;">55</a></div><div class="block-item-title">文件下载量</div></div>--%>
        <%--</div>--%>
        <%--</div>--%>
        </div>
        </div>
        </div>
        <div style="display:flex;margin-top: 10px;">
        <div class="left" style="width: 63%;height: 80%">
        <div class="left2" style=" background: #FFFFFF;margin-top: 10px;min-height: 440px;">
        <div style="display: flex;border-bottom: 1px solid #F3F3F3;padding: 10px;"><div style="background: #3393FC"><i style="color: white" class="layui-icon layui-icon-note"></i></div><div style="margin-left: 7px;">知识库</div></div>
        <div class="layui-tab layui-tab-brief" lay-filter="docDemoTabBrief">
        <ul class="layui-tab-title">
        <li class="layui-this">公共文件柜</li>
        <li class="speak">讨论区</li>
        </ul>
        <div class="layui-tab-content" style="height: 405px;overflow-y: auto">
                <div class="layui-tab-item layui-show cabinets yangshi" >

                </div>
                <div class="layui-tab-item forum yangshi" >

                </div>
        </div>
        </div>
        </div>
        <div class="left4" style=" background: #FFFFFF;margin-top: 10px;">
        <div style="display: flex;border-bottom: 1px solid #F3F3F3;padding: 10px;"><div style="background: #3393FC"><i style="color: white" class="layui-icon layui-icon-note"></i></div><div style="margin-left: 7px;">发帖的数量</div></div>
        <div id="main" style="width: 100%;height:400px;margin-top: 10px;"></div>
        </div>
        </div>
        <div class="right" style="width: 36%;margin-left: 25px;margin-top: 10px;height: 100%">
        <div style=" background: #FFFFFF;">
        <div style="display: flex;border-bottom: 1px solid #F3F3F3;padding: 10px;"><div style="background: #3393FC"><i style="color: white"  class="layui-icon layui-icon-note"></i></div><div style="margin-left: 7px;">公共文件柜阅览排名</div></div>
        <div class="catListView">
        <h3 class="catListTitle" style="text-align:center" id="title">阅览热度前15名</h3>
        <div>
        <ul id="paiming">
            <li style="border-bottom: 1px solid #F3F3F3;padding: 10px;font-size: 13px;color: #000;display: flex;">
<%--            <span></span>--%>
            <div style="width: 60%;">文件名称</div>
            <div style="width: 20%;">阅读量</div>
            <div style="width: 20%;">排名</div>
            </li>
        <%--<li>--%>
            <%--<span>1、</span><a>公司制度</a>--%>
        <%--<span class="numClass">(76)</span>--%>
        <%--</li>--%>
        </ul>
        </div>
        </div>
        </div>
        <div style=" background: #FFFFFF;margin-top: 10px;">
        <div style="display: flex;border-bottom: 1px solid #F3F3F3;padding: 10px;"><div style="background: #3393FC"><i style="color: white" class="layui-icon layui-icon-note"></i></div><div style="margin-left: 7px;">文件贡献排名</div></div>
        <div class="list-content" id="contents">
            <div>
            <ul id="ypaiming">
            <li style="border-bottom: 1px solid #F3F3F3;padding: 10px;font-size: 13px;color: #000;display: flex;">
            <%--            <span></span>--%>
            <div style="width: 35%;">文件贡献人</div>
            <div style="width: 25%;">阅读量</div>
            <div style="width: 25%;">时间</div>
            <div style="width: 15%;">排名</div>
            </li>
            </li>
<%--            <li style="border-bottom: 1px solid #F3F3F3;padding: 10px;">--%>
<%--            <span style="display: inline-block;width: 35%;text-align: center;">名称</span>--%>
<%--            <span style="margin-left: 3%;">阅读量</span>--%>
<%--            <span style="margin-left: 10%;">时间</span>--%>
<%--            <span style="margin-left: 14%;">排名</span>--%>
<%--            </li>--%>
            <%--<li>--%>
            <%--<div>--%>
            <%--<div class="tr-item" style="display: flex;cursor:pointer">--%>
            <%--<div style="margin-left: 5px;"><img class="headimg" src="../img/menu/peoson.png"/></div>--%>
            <%--<div style="margin-left: 8px;" ><a style="color:#be1b1b;">陈峰</a><div class="td-item" style="width: 80px;">研发部</div></div>--%>
            <%--<div class="td-item" style="width: 137.5px;margin-top: 22px;text-align: center">1240361</div>--%>
            <%--<div class="td-item" style="width: 137.5px;margin-top: 22px;text-align: center">2020-04-15</div>--%>
            <%--<div class="td-item" style="width: 137.5px;margin-top: 22px;text-align: center">1</div>--%>
            <%--</div>--%>
            <%--</div>--%>
            <%--</li>--%>
            </ul>
            </div>
        </div>
        </div>
        </div>
        </div>
        </div>

        <script>
        for(var i=0;i<$('.layui-table tr').length;i++){
        $('.layui-table tr').eq(i).find('td').eq(1).css('textAlign','right')
        }

        // 基于准备好的dom，初始化echarts实例
        var myChart = echarts.init(document.getElementById('main'));
        $.ajax({
        url:'/system/bbs/selAll',
        dataType: 'json',//服务器返回json格式数据
        data:{
        page:1,
        limit:10
        },
        type: 'get',
        success:function(res) {
        var datas = res.obj
        var arrName = []
        var arrNum = []
        for(var i=0;i<datas.length;i++){
        arrName.push(datas[i].boardName)
        arrNum.push(datas[i].postNums)
        }
        // 指定图表的配置项和数据
        option = {
        color: ['#3398DB'],
        grid: {
        left: '3%',
        right: '4%',
        bottom: '3%',
        containLabel: true
        },
        tooltip:{
        show:true,
        axisPointer:{
        type:'line',
        crossStyle:{
        color:'#666',
        width:1,
        type:'dashed',
        },
        label:{
        show:true,
        precision : 'auto',
        }
        }
        },
        xAxis: [
        {
        type: 'category',
        data: arrName,
        axisTick: {
        alignWithLabel: true
        }
        }
        ],
        yAxis: [
        {
        type: 'value'
        }
        ],
        series: [
        {
        name: '发帖量',
        type: 'bar',
        barWidth: '60%',
        data: arrNum
        }
        ]
        };

                // 使用刚指定的配置项和数据显示图表。
                myChart.setOption(option);
            window.addEventListener('resize',function(){
                myChart.resize();
            })
        }

        })

        //阅览排名
        $.ajax({
        // url: '/getUserByCondition',
        url: '/newFileContent/selCountClickFile',
        type: 'get',
        dataType: 'json',
        success: function (res) {
            var datasd = res.data
            var str1 = '';
            var str3 = '';
            var num = 1;
        if (datasd.length>0) {
            for (var i = 0; i < datasd.length; i++) {
            str1 +=  '<li style="display: flex;justify-content: space-between;">' +
            '<div style="width: 60%;"><span>'+num+'、<a>' + datasd[i].subject + ' </a> </span></div>'+
            '<div style="width: 20%;"><span class="numClass" >' + datasd[i].fileCount + '</span> </div>'+
            '<div style="width: 20%;"><span class="td-item" style="width: 137.5px;text-align: center">'+num+'</span></div>'+
            '</li>'
            num++;
            }

        }else {
            str1 = '<div class="noData" style="text-align: center;border: none;width: 15%;height: 22%;margin-left: 40%;margin-top: 20%;margin-bottom: 20%">' +
            '<img src="/img/main_img/shouyekong.png" alt="">' +
            '<h6 style="text-align: center;color: #666;width: 95px">'+'暂无数据'+'</h6>' +
            '</div>';
            }
            $('#paiming').append(str1);

            str3 +=  '<a class="number" style="color: #65a94b;font-size: 18px;cursor: pointer;">' + res.totleNum + '</a>'
            $('#numbers').append(str3);
        }
        })
            //贡献排名
            $.ajax({
            url: '/newFileContent/selCountMaxFile',
            type: 'get',
            dataType: 'json',
            success: function (res) {
            var datasd = res.data
            var str1 = '';
            var strs='';
            var num = 1;
            if (datasd.length>0) {
            for (var i = 0; i < datasd.length; i++) {
            str1 +=  '<li style="display: flex;justify-content: space-between;">' +
            // '<div class="tr-item" style="display: flex;cursor:pointer">' +
            '<div style="display: flex;width: 35%;margin-top: 22px;">' +
            '<div style="margin-left: 5px;"><img class="headimg" src="../img/menu/peoson.png"/></div>'+
            '<div style="margin-left: 8px;width: 100px" ><a style="color:#be1b1b;">' + datasd[i].createrName + '</a><div class="td-item" style="width: 80px;">' + datasd[i].deptName + '</div></div>' +
            '</div>'+
            // '<div style="margin-left: 5px;"><img class="headimg" src="../img/menu/peoson.png"/></div>' +

            '<div class="td-item numClass" style="width: 25%;margin-top: 22px;">' + datasd[i].fileCount + '</div>' +
            '<div class="td-item" style="width: 25%;margin-top: 22px;">' + datasd[i].seTime + '</div>' +
            '<div class="td-item" style="width: 15%;margin-top: 22px;">'+num+'</div>' +
            // '</div>' +
            '</li>'
            num++;
            }
            }else{
            str1 = '<div class="noData" style="text-align: center;border: none;width: 15%;height: 22%;margin-left: 40%;margin-top: 20%;padding-bottom: 20%">' +
            '<img src="/img/main_img/shouyekong.png" alt="">' +
            '<h6 style="text-align: center;color: #666;width: 95px">'+'暂无数据'+'</h6>' +
            '</div>';
            }
            $('#ypaiming').append(str1);

            strs +=  '<a class="number" style="color: #65a94b;font-size: 18px;cursor: pointer;">' + res.totleNum + '</a>'
            $('#number').append(strs);
            }
            })

            // 个人文件柜统计
            $.ajax({
            url: '/newFileContent/selSinCountMaxFile',
            type: 'get',
            dataType: 'json',
            success: function (res) {
            var datasd = res.totleNum
            var strd = ''

            strd +=  '<a class="number" style="color: #65a94b;font-size: 18px;cursor: pointer;">' + datasd + '</a>'
            $('#numberd').append(strd);
            }
            })
        </script>
        </body>
        </html>
        <script >
        /*定义位置：由于图片个数与下侧顺序按钮数量一致，可通过位置进行关联*/
        var index=0;
        /*当鼠标放到顺序按钮上时：
        1.将当前这个顺序按钮增加样式为红色背景
        2.移除周围其他同级元素红色背景样式
        3.获取当前顺序按钮的index
        4.通过index获取该位置图片
        5.一秒钟渐入该图片
        6.一秒钟渐出其他相邻图片
        7.防止移动过快导致的效果闪现，使用stop方法
        */
        $(".num li").mousemove(function () {
        $(this).addClass("current").siblings().removeClass("current");
        index=$(this).index();
        $(".img li").eq(index).stop().fadeIn(4000).siblings().stop().fadeOut(4000);
        });
        /*设置每一秒钟自动轮播：
        1.获取当前位置序号：自加操作；当超过图片最大序号时序号设置为0
        2.设置下侧顺序按钮及轮播图显示
        */
        var time=setInterval(move,5000);
        function move() {
        index++;
        if (index==4){
        index=0
        }
        $(".num li").eq(index).addClass("current").siblings().removeClass("current");
        $(".img li").eq(index).stop().fadeIn(1000).siblings().stop().fadeOut(1000);
        };
        /*当鼠标划入、划出轮播图区域时：
        1.划入时停止自动轮播
        2.划出时继续自动轮播
        */
        $(".outer").hover(function () {
        clearInterval(time);
        },
        function () {
        time=setInterval(move,5000);
        });
        /*点击右侧按钮时执行*/
        $(".right_btn").click(function () {
        move();
        });
        /*点击左侧按钮时执行*/
        function moveL() {
        index--;
        if (index==-1){
        index=3
        }
        $(".num li").eq(index).addClass("current").siblings().removeClass("current");
        $(".img li").eq(index).stop().fadeIn(1000).siblings().stop().fadeOut(1000);
        }
        $(".left_btn").click(function () {
        moveL();
        });

        //公共文件柜
        $.ajax({
        url:'/newFileContent/serachAll',
        dataType: 'json',//服务器返回json格式数据
        type: 'get',
        data:{
        // sortId:18,
        // page:1,
        // pageSize:10,
        // useFlag:true,
        // sortType:5
            sortType: 5,
            page: 1,
            pageSize: 10,
            useFlag: true,
            serachType: 2,
            subject:'',
            sort_no:'',
            creater:'',
            keyword1:'',
            keyword2:'',
            keyword3:'',
            attScript:'',
            attName:'',
            attContain:'',
            begainTime:'',
            endTime:'',
            },
        success:function(res) {
        var attach
            var id
            var ids
            var str =  '<li style="display: flex;padding: 8px 6px;cursor:pointer">'+
            '<div style="width: 30%;overflow: hidden;cursor:pointer;font-weight: bold">文件名称</div>'+
            ' <div style="width: 35%;margin-right:6%;font-weight: bold">附件</div>'+
            ' <div style="width: 29%;font-weight: bold">发布时间</div>'+
            ' </li>';
        var contentList = res.obj;
        if(contentList.length>0){
        for(var i=0;i<contentList.length;i++){
        var attachName = contentList[i].attachmentList
            id =contentList[i].contentId
            ids =contentList[i].sortId
        for(var j=0;j<attachName.length;j++){
        attach =attachName[j].attachName
        size = attachName[j].size
        }
        str+='<li style="display: flex;padding: 8px 6px;cursor:pointer" class="daishouDetail" onclick="windowOpens(this)" data-url="/newFilePub/fileDetail?contentId='+id+'&sortId='+ids+'">' +
        '<div style="width: 30%;overflow: hidden;cursor:pointer">'+contentList[i].subject+'</div>'+
        '<div style="width: 35%;margin-right:6%;">'+attach+'</div>'+
        // '<div style="width: 30%;">'+contentList[i].contentNo+'</div>'+
        '<div style="width: 29%;">'+contentList[i].sendTime+'</div>'+
        '</li> '
        }
        }else{
        str = '<div class="noData" style="text-align: center;border: none;">' +
        '<img src="/img/main_img/shouyekong.png" alt="">' +
        '<h6 style="text-align: center;color: #666;">'+'暂无数据'+'</h6>' +
        '</div>';
        }
        $('.cabinets').append(str)
        }
        })
        //讨论区
        $('.speak').click(function() {
                taolun()
        })
        function taolun(){
        $.ajax({
        url:'/system/bbs/selAll',
        dataType: 'json',//服务器返回json格式数据
        data:{
        page:1,
        limit:10
        },
        type: 'get',
        success:function(res){
            var app =  '<li style="display: flex;padding: 8px 6px;cursor:pointer" id="none">'+
            '<div style="width: 41%;overflow: hidden;cursor:pointer;font-weight: bold">讨论区</div>'+
            ' <div style="width: 29%;font-weight: bold">帖数</div>'+
            ' <div style="width: 30%;font-weight: bold">审核</div>'+
            ' <div style="width: 29%;font-weight: bold">版主</div>'+
            ' </li>'
        var data = res.obj;
        if(data.length>0){
        for(var i=0;i<data.length;i++){
        app+='<li style="display: flex;padding: 8px 6px;cursor:pointer" class="daishouDetail" onclick="windowOpens(this)" data-url="/bbs/theme?boardId='+data[i].boardId+'">' +
        '<div style="width: 42%;">'+ function() {
        if(data[i].boardName==undefined){
        return "";
        }else{
        return data[i].boardName;
        }
        }()+'</div>'+
        '<div style="width: 30%;">'+ function() {
        if(data[i].postNums==undefined){
        return "";
        }else{
        return data[i].postNums;
        }
        }()+'</div>'+
        '<div style="width: 30%;">'+function() {
        if(data[i].needCheck==1){
        return "需要审核"
        }else {
        return "不需审核"
        }
        }()+'</div>'+
        '<div style="width: 30%;">'+function() {
        if(data[i].boardHosterName==undefined){
        return "";
        }else{
        return data[i].boardHosterName;
        }
        }()+'</div>'+
        '</li> '
        }
        }
        else{
        app = '<div class="noData" style="text-align: center;border: none;">' +
        '<img src="/img/main_img/shouyekong.png" alt="">' +
        '<h6 style="text-align: center;color: #666;">'+'暂无数据'+'</h6>' +
        '</div>'
        }
        $('.forum').html(app)

        }
        })
        }

            function windowOpens(me) {
            var url=$(me).attr('data-url');
            window.open(url);

            }




        </script>