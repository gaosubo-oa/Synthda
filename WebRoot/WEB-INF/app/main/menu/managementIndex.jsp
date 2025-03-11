        <%--
          Created by IntelliJ IDEA.
          User: xoa
          Date: 2020-04-3
          Time: 17:21
          To change this template use File | Settings | File Templates.
        --%>
                <%@ page contentType="text/html;charset=UTF-8" language="java" %>
                <html>
                <head>
                <meta charset="UTF-8">
                <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
                <title>管理门户</title>
                <meta name="renderer" content="webkit">
                <meta http-equiv="X-UA-Compatible" content="IE=10,chrome=1">
                <meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=0, minimum-scale=1.0, maximum-scale=1.0">
                <link rel="stylesheet" type="text/css" href="/lib/layui/layui/css/layui.css?20210319.1"/>
                <link rel="stylesheet" type="text/css" href="/css/main/theme1/managementPortal.css?20200605" />
                <script type="text/javascript" src="/lib/layui/layui/layui.js"></script>
                <script type="text/javascript" src="/lib/layui/layui/layui.all.js"></script>
                <script type="text/javascript" src="/js/xoajq/xoajq1.js"></script>
                <script type="text/javascript" src="/js/xoajq/xoajq2.js"></script>
                <script src="/js/base/base.js" type="text/javascript" charset="utf-8"></script>
                <script type="text/javascript" src="/js/echarts.min.js"></script>
                <script type="text/javascript" src="/lib/highcharts.js"></script>
                <script type="text/javascript" src="/js/main_js/index.js"></script>
                <script type="text/javascript" src="/js/main_js/index20.js?20201216.1"></script>
                <script src="/js/common/language.js"></script>
                <script src="/js/jquery/jquery.cookie.js"></script>
                <script src="/js/base/base.js"></script>
                <script src="/lib/audiojs/audio.min.js"></script>
                <style>
                html, body{
                font-family: "Microsoft Yahei" !important;
                }
                body{
                background: #F8F8F8;
                overflow: auto;
                }
                .left1{
                width: 36%;
                background: #FFFFFF
                }
                .right1{
                width: 65%;
                background: #ffffff;
                }
                .one ,.two , .three ,.left1List , .left1List , .left1Item , .right1List{
                display: flex;
                }
                .item1{
                margin: 5px 10px;
                }
                .item2{
                margin-left: 50%;
                }
                .item3{
                /*margin: 5px 10px;*/
                margin: 5px 66px;
                }
                .item4{
                margin-top: 5px;
                }
                .left1Item{
                margin: 5px 10px;
                }
                .daishou li:hover{
                background: #e8f4fc;
                cursor: pointer;
                }
                .yishou li:hover{
                background: #e8f4fc;
                cursor: pointer;
                }
                .myshou li:hover{
                background: #e8f4fc;
                cursor: pointer;
                }
                .daifa li:hover{
                background: #e8f4fc;
                cursor: pointer;
                }
                .yifa li:hover{
                background: #e8f4fc;
                cursor: pointer;
                }
                .myfa li:hover{
                background: #e8f4fc;
                cursor: pointer;
                }
                text [x="5"]{
                font-size: 9pt;
                }
                text [x="21"]{
                font-size: 9pt;
                }
                .layui-tab-brief>.layui-tab-more li.layui-this:after, .layui-tab-brief>.layui-tab-title .layui-this:after{
                border-bottom: 2px solid #2A79D5;!important;
                }
                .layui-tab-brief>.layui-tab-title .layui-this{
                color:#2A79D5
                }
                .insideDiv ul li{
                height: 80%; !important;
                }
                .fen{
                width: 100px;
                height: 100px;
                float: left;
                margin-right:10px;
                margin-top: 30px;

                }
                .fen a{
                display: block;
                width: 100px;
                height: 100px;
                }
                .clas{
                margin-top: 30px;
                }
                .clases{
                margin-top: 30px;
                }
                .clas i,p{
                color: #fff;
                }

                </style>
                </head>
                <body>
                <div style="padding: 8px">
                <%--第一块内容--%>
                <div class="one" >
                <%--左侧第一块 图片   url(../../../../ui/img/managementIndex.png)--%>
                <div class="right1" style="width: 63%;background:#f2f2f2">
                <div class="" lay-shrink="all" id="LAY-system-side-menu" lay-filter="layadmin-system-side-menu">
                </div>
                </div>

                <div class="left1" style="margin-left: 1%;height:290px ">
                <div class="titleLi">
                <img src="/img/main_img/theme1/managementPortal/manageportal_icon_es.png" alt="">
                <span class="textLi">员工统计</span>
                <ul class="insideUl">
                <li class="age liActive">年龄</li>
                <li class="sex">性别</li>
                <li class="education">学历</li>
                <li class="workingLife">工作年限</li>
                </ul>
                </div>

                <div id="containerYuangong" style="min-width: 350px;height:260px;display: block;"></div>
                <div id="containerSex" style="min-width: 350px;height:260px;display: none;"></div>
                <div id="containerXueli" style="min-width: 350px;height:260px;display: none;"></div>
                <div id="containerNianxian" style="min-width: 350px;height:260px;display: none;"></div>
                <div id="noData" style="display: none;text-align: center;">
                <img style="margin-top: 62px;" src="/img/main_img/shouyekong.png" alt="">
                <h2 style="text-align: center;color: #666;"><fmt:message code="doc.th.NoData" /></h2>
                </div>

                </div>
                </div>

                <%--第二块内容--%>
                <div class="two" style="margin-top: 20px;">
                <%--左侧--%>
                <div style="width: 63%;background: #FFFFFF;" >
                <%--<h3 style="padding-left: 18px;margin-top:10px;font-weight: bold;">收文管理</h3>--%>
                <div class="titleLi">
                <img src="/img/main_img/theme1/managementPortal/manageportal_icon_ns.png" alt="">
                <span class="textLi">新闻发布数统计</span>
                </div>
                <div id="containerNews" style="min-width: 350px;height:350px;"></div>
                </div>
                <%--右侧--%>
                <div class="left1" style="margin-left: 1%;height:400px; ">
                <div class="titleLi">
                <img src="/img/main_img/theme1/managementPortal/manageportal_icon_ecs.png" alt="">
                <span class="textLi">员工合同统计</span>
                </div>
                <div id="containerHetong" style="min-width: 350px;height:350px;"></div>

                </div>
                </div>
                </div>
                <%--第三块内容--%>
                <div class="three" style="margin-top: 15px;">
                <%--左侧--%>
                <div style="width: 63%;background: #FFFFFF;">
                <div class="titleLi">
                <img src="/img/main_img/theme1/managementPortal/manageportal_icon_ods.png" alt="">
                <span class="textLi">公告发布数统计</span>
                </div>
                <div id="container" style="min-width: 350px;height:350px;"></div>
                </div>
                <%--右侧--%>
                <div class="left1" style="margin-left: 1%;height:400px ">
                <div class="titleLi">
                <img src="/img/main_img/theme1/managementPortal/manageportal_icon_wfs.png" alt="">
                <span class="textLi">工作流统计</span>
                </div>
                <div id="containerFlow" style="min-width: 350px;height:350px;"></div>

                </div>
                </div>
                </div>
                <%--第四块内容--%>
                <div class="three" style="margin-top: 20px;">
                <%--左侧--%>
                <div style="width: 63%;background: #FFFFFF;height: 310px">
                <div class="titleLi">
                <img src="/img/main_img/theme1/managementPortal/manageportal_icon_newemployee.png" alt="">
                <span class="textLi">员工信息</span>
                </div>
                <div class="layui-tab  layui-tab-brief">
                <ul class="layui-tab-title" style="margin-left:15px;margin-top:15px;">
                <li class="layui-this">新入职员工</li>
                <li>合同到期员工（30天内）</li>
                </ul>
                <div class="layui-tab-content" >
                <div class="layui-tab-item layui-show">
                <div class="insideDiv">
                <ul id="xinruzhi">
                </ul>
                </div>
                </div>
                <div class="layui-tab-item ">
                <div class="insideDiv">
                <ul id="hetongUl">
                </ul>
                </div>
                </div>
                </div>
                </div>
                </div>
                <%--右侧--%>
                <div class="left1" style="margin-left: 1%;height:310px ">
                <div class="titleLi">
                <img src="/img/main_img/theme1/managementPortal/manageportal_icon_vs.png" alt="">
                <span class="textLi">员工请假统计</span>
                </div>
                <div id="containerQingjia" style="min-width: 350px;height:290px;"></div>
                </div>
                </div>
                </div>
                <script src="/lib/layui/layuiadmin/layui/layui.js"></script>
                <script src="/js/main_js/index20.js?20201216.5"></script>
                <script>
                var styles;
                layui.config({
                base: '/lib/layui/layuiadmin/' //静态资源所在路径
                }).extend({
                index: 'lib/index' //主入口模块
                }).use('index');
                </script>
                <script type="text/javascript">
                $(function () {
                yuangongTongji('1');//员工统计初始数据

                $('.age').click(function(){
                $(this).addClass('liActive').siblings().removeClass('liActive');
                $('#containerYuangong').show();
                $('#containerSex').hide();
                $('#containerXueli').hide();
                $('#containerNianxian').hide();
                yuangongTongji('1');
                })
                $('.sex').click(function(){
                $(this).addClass('liActive').siblings().removeClass('liActive');
                $('#containerYuangong').hide();
                $('#containerSex').show();
                $('#containerXueli').hide();
                $('#containerNianxian').hide();
                yuangongTongji('2');
                })
                $('.education').click(function(){
                $(this).addClass('liActive').siblings().removeClass('liActive');
                $('#containerYuangong').hide();
                $('#containerSex').hide();
                $('#containerXueli').show();
                $('#containerNianxian').hide();
                yuangongTongji('3');
                })
                $('.workingLife').click(function(){
                $(this).addClass('liActive').siblings().removeClass('liActive');
                $('#containerYuangong').hide();
                $('#containerSex').hide();
                $('#containerXueli').hide();
                $('#containerNianxian').show();
                yuangongTongji('4');
                })

                var nowTime=getNowFormatDate()

                //    公告发布数统计接口
                $.ajax({
                type:'get',
                url:'/notice/selectByType',
                dataType:'json',
                success:function(res){
                var datas=res.data;
                var dataNum=[];
                for(var key in datas){
                var str=[];
                str.push(key);
                str.push(datas[key]);
                dataNum.push(str);
                }
                noteTongji(dataNum);
                }
                })
                //    新闻发布数统计接口
                $.ajax({
                type:'get',
                url:'/news/getNewCountByType',
                dataType:'json',
                success:function(res){
                var datas=res.data;
                var dataNum=[];
                for(var key in datas){
                var str=[];
                str.push(key);
                str.push(datas[key]);
                dataNum.push(str);
                }
                newsTongji(dataNum);
                }
                })
                //    合同到期员工统计
                $.ajax({
                type:'get',
                url:'/hr/contract/getMaturityContract',
                dataType:'json',
                data:{
                status:1
                },
                success:function (res) {
                var datas=res.obj;
                var str='';
                if(res.flag == true){
                if(datas.length>3){
                $('.moreDaoqi').show();
                }else {
                $('.moreDaoqi').hide();
                }
                var h = parent.document.documentElement.clientWidth;
                if(datas.length>0){
                for(var i=0;i<datas.length;i++){
                if(h >= 1673){
                if(i<3){
                str+='<li>' +
                '<div class="userInfo">'+
                '<div class="userImg"><img src="/img/main_img/managementPortal/boy.png" alt=""></div>'+
                '<span class="userSpan">'+
                '<p>'+datas[i].userName+'</p>'+
                '<p>'+datas[i].userPriv+'</p>'+
                '</span>'+
                '</div>' +
                '<div class="userInfo2">'+
                '<span>'+
                '<span>部门：</span><span>'+datas[i].deptName+'</span>'+
                '</span>'+
                '<span>'+
                '<span>到期时间：</span><span>'+datas[i].contractEndTime+'</span>'+
                '</span>'+
                '</div>'+
                '</li>'
                }
                }else{
                if(i<2){
                str+='<li>' +
                '<div class="userInfo">'+
                '<div class="userImg"><img src="/img/main_img/managementPortal/boy.png" alt=""></div>'+
                '<span class="userSpan">'+
                '<p>'+datas[i].userName+'</p>'+
                '<p>'+datas[i].userPriv+'</p>'+
                '</span>'+
                '</div>' +
                '<div class="userInfo2">'+
                '<span>'+
                '<span>部门：</span><span>'+datas[i].deptName+'</span>'+
                '</span>'+
                '<span>'+
                '<span>到期时间：</span><span>'+datas[i].contractEndTime+'</span>'+
                '</span>'+
                '</div>'+
                '</li>'
                }
                }
                }
                }else{
                str='<li class="no_notice" style="text-align: center;border: none;width: 100%;">' +
                '<img style="margin-top: 62px;" src="/img/main_img/shouyekong.png" alt="">' +
                '<h2 style="text-align: center;color: #666;">暂无数据</h2>' +
                '</li>'
                }

                $('#hetongUl').html(str);
                }
                }
                })
                //    工作流统计
                $.ajax({
                type:'get',
                url:'/flowRun/queryFlowRunCount',
                dataType:'json',
                success:function(res){
                var data=res.datas
                if(res.flag == true){
                var arrFlow=[];
                for(var i=0;i<data.length;i++){
                var arrStr=[];
                arrStr.push(data[i].flowRunModelName);
                arrStr.push(data[i].flowRunModelPrcsCount);
                arrFlow.push(arrStr)
                }
                flowTongji(arrFlow)
                }
                }
                })
                //    员工合同统计
                $.ajax({
                type:'get',
                url:'/hr/contract/getHrCountByType',
                dataType:'json',
                success:function (res) {
                var datas=res.data;
                //console.log(datas)
                if(res.flag == true){
                var dataNum=[];
                for(var key in datas){
                var str=[];
                str.push(key);
                str.push(datas[key]);
                dataNum.push(str);
                }
                hetongTongji(dataNum)
                }
                }
                })
                //    员工请假统计
                $.ajax({
                type:'get',
                url:'/attendLeave/getAttendLeaveCount',
                dataType:'json',
                success:function (res) {
                var datas=res.data;
                var monthTime=[];
                var dataNum=[];
                if(res.flag == true){
                for(var i=0;i<datas.length;i++){
                monthTime.push(datas[i].monthname);
                dataNum.push(datas[i].id)
                }
                qingjiaTongji(monthTime,dataNum);
                }
                }
                })
                //    新入职员工
                $.ajax({
                type:'get',
                url:'/hr/api/getHrStaffInfoNews',
                dataType:'json',
                success:function (res) {
                var data=res.datas;
                var str='';
                if(res.flag == true){
                var h = parent.document.documentElement.clientWidth;
                if(data.length>3){
                if(h >= 1673){

                }else{
                $('style').append('.insideDiv ul li{width: 47%;}.userSpan{margin-top: 40px;margin-left: 10%;}')
                }
                $('.moreXinruzhi').hide();
                }else{
                if(h >= 1673){
                $('.moreXinruzhi').hide();
                }else{
                $('style').append('.insideDiv ul li{width: 47%;}.userSpan{margin-top: 40px;margin-left: 10%;}')
                if(data.length == 3){
                $('.moreXinruzhi').hide();
                }else{
                $('.moreXinruzhi').hide();
                }
                }

                }
                if(data.length>0){
                for(var i=0;i<data.length;i++){
                if(h >= 1673){
                if(i<3){
                str+='<li>'+
                '<div class="userInfo">'+
                '<div class="userImg"><img src="/img/main_img/managementPortal/boy.png" alt=""></div>'+
                '<span class="userSpan">'+
                '<p>'+data[i].userName+'</p>'+
                '<p>新入职员工</p>'+
                '</span>'+
                '</div>'+
                '<div class="userInfo2">'+
                '<span>'+
                '<span>性别：</span><span>'+function () {
                if(data[i].sex == '0'){
                return '男';
                }else if(data[i].sex == '1'){
                return '女';
                }
                }()+'</span>'+
                '</span>'+
                '<span>'+
                '<span>部门：</span><span>'+data[i].deptName+'</span>'+
                '</span>'+
                '<span>'+
                '<span>入职时间：</span><span>'+data[i].datesEmployed+'</span>'+
                '</span>'+
                '</div>'+
                '</li>';
                }
                }else{
                if(i<2){
                str+='<li>'+
                '<div class="userInfo">'+
                '<div class="userImg"><img src="/img/main_img/managementPortal/boy.png" alt=""></div>'+
                '<span class="userSpan">'+
                '<p>'+data[i].userName+'</p>'+
                '<p>新入职员工</p>'+
                '</span>'+
                '</div>'+
                '<div class="userInfo2">'+
                '<span>'+
                '<span>性别：</span><span>'+function () {
                if(data[i].sex == '0'){
                return '男';
                }else if(data[i].sex == '1'){
                return '女';
                }
                }()+'</span>'+
                '</span>'+
                '<span>'+
                '<span>部门：</span><span>'+data[i].deptName+'</span>'+
                '</span>'+
                '<span>'+
                '<span>入职时间：</span><span>'+data[i].datesEmployed+'</span>'+
                '</span>'+
                '</div>'+
                '</li>';
                }
                }
                }
                }else{
                str='<li class="no_notice" style="text-align: center;border: none;width: 100%;">' +
                '<img style="margin-top: 62px;" src="/img/main_img/shouyekong.png" alt="">' +
                '<h2 style="text-align: center;color: #666;">暂无数据</h2>' +
                '</li>'
                }
                $('#xinruzhi').html(str);
                }
                }
                })
                });
                //获取当前时间，格式YYYY-MM-DD
                function getNowFormatDate() {
                var date = new Date();
                var seperator1 = "-";
                var year = date.getFullYear();
                var month = date.getMonth() + 1;
                var strDate = date.getDate();
                if (month >= 1 && month <= 9) {
                month = "0" + month;
                }
                if (strDate >= 0 && strDate <= 9) {
                strDate = "0" + strDate;
                }
                var currentdate = year + seperator1 + month + seperator1 + strDate;
                return currentdate;
                }
                function yuangongTongji(typeNum) {
                $.ajax({
                type:'get',
                url:'/hr/api/getHrStaffInfoCount',
                dataType:'json',
                data:{
                type:typeNum
                },
                success:function(res){
                var datas=res.data;
                var dataTotal=[];
                if(res.flag == true){
                for(var key in datas){
                var str=[];
                str.push(key);
                str.push(datas[key]);
                dataTotal.push(str);
                }
                if(typeNum == '1'){
                nianlingTongji(dataTotal);
                }else if(typeNum == '2'){
                xingbieTongji(dataTotal);
                }else if(typeNum == '3'){
                xueliTongji(dataTotal);
                }else if(typeNum == '4'){
                nianxianTongji(dataTotal);
                }
                }
                }
                })
                }
                // 员工年龄统计
                function nianlingTongji(data) {
                var Age = [];var Count = [];
                for (var i = 0; i<data.length; i++){
                Age.push(data[i][0]);
                Count.push(data[i][1]);
                }
                var Yuangong = echarts.init(document.getElementById('containerYuangong'));
                var option = {
                grid:{
                x:30,
                y:20,
                x2:10,
                y2:30
                },
                title:{},
                tooltip:{
                show:true,
                axisPointer:{
                type:'cross',
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
                color:['#5cb3e1'],
                xAxis:{
                type: 'category',
                data:Age,
                left:"center"
                },
                yAxis:{},
                series: [
                {
                type: 'bar', name: '人数',
                data: Count
                }
                ]
                }
                Yuangong.setOption(option);
                }
                //  员工性别统计
                function xingbieTongji(data) {
                var YuangongSex = echarts.init(document.getElementById('containerSex'));
                var option = {
                grid:{
                x:30,
                y:20,
                x2:10,
                y2:30
                },
                title:{},
                color:['#91c7ae'],
                tooltip:{
                show:true,
                axisPointer:{
                type:'cross',
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
                color:['#5cb3e1'],
                xAxis:{
                type: 'category',
                data:['男','女'],
                left:"center",
                axisLabel:{
                fontSize:16
                }
                },
                yAxis:{},
                series: [
                {
                type: 'bar', name: '人数',
                data:[data[0][1],data[1][1]],
                barWidth:60
                }
                ]
                }

                YuangongSex.setOption(option);
                }
                // 员工学历统计
                function xueliTongji(data) {

                var Xue = [];var Count = [];
                for (var i = 0; i<data.length; i++){
                Xue.push(data[i][0]);
                Count.push(data[i][1]);
                }
                var YuangongXueli = echarts.init(document.getElementById('containerXueli'));
                var option = {
                grid:{
                x:30,
                y:20,
                x2:10,
                y2:30
                },
                title:{},
                tooltip:{
                show:true,
                axisPointer:{
                type:'cross',
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
                color:['#5cb3e1'],
                xAxis:{
                type: 'category',
                data:Xue,
                left:"center"
                },
                yAxis:{},
                series: [
                {
                type: 'bar', name: '人数',
                data: Count
                }
                ]
                }

                YuangongXueli.setOption(option);
                }
                // 员工工作年限统计
                function nianxianTongji(data) {

                var Year = [];var Count = [];
                for (var i = 0; i<data.length; i++){
                Year.push(data[i][0]);
                Count.push(data[i][1]);
                }
                var YuangongWorkYear = echarts.init(document.getElementById('containerNianxian'));
                var option = {
                grid:{
                x:30,
                y:20,
                x2:10,
                y2:30
                },
                title:{},
                tooltip:{
                show:true,
                axisPointer:{
                type:'cross',
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
                color:['#5cb3e1'],
                xAxis:{
                type: 'category',
                data:Year,
                left:"center"
                },
                yAxis:{},
                series: [
                {
                type: 'bar', name: '人数',
                data: Count
                }
                ]
                }

                YuangongWorkYear.setOption(option);
                }
                // 发布公告统计
                function noteTongji(data) {

                var Gao = [];var Count = [];
                for (var i = 0; i<data.length; i++){
                Gao.push(data[i][0]);
                Count.push(data[i][1]);
                }
                var YuangongGao = echarts.init(document.getElementById('container'));
                var option = {
                grid:{
                x:40,
                y:20,
                x2:30,
                y2:30
                },
                title:{},
                tooltip:{
                show:true,
                axisPointer:{
                type:'cross',
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
                color:['rgba(92,179,225,1)'],
                xAxis:{
                type: 'category',
                data:Gao,
                left:"center",
                axisLabel:{
                fontSize:16
                }
                },
                yAxis:{},
                series: [
                {
                type: 'bar', name: '公告发布量',
                data: Count,
                barWidth:60,
                }
                ]
                }

                YuangongGao.setOption(option);
                }
                // 新闻发布量统计
                function newsTongji(data) {
                var News = [];var Count = [];
                for (var i = 0; i<data.length; i++){
                News.push(data[i][0]);
                Count.push(data[i][1]);
                }
                var YuangongNews = echarts.init(document.getElementById('containerNews'));
                var option = {
                grid:{
                x:40,
                y:20,
                x2:30,
                y2:30
                },
                title:{},
                tooltip:{
                show:true,
                axisPointer:{
                type:'cross',
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
                color:['#5cb3e1'],
                xAxis:{
                type: 'category',
                data:News,
                left:"center",
                axisLabel:{
                fontSize:16
                }
                },
                yAxis:{},
                series: [
                {
                type: 'bar', name: '新闻发布量',
                data: Count,
                barWidth:60,
                }
                ]
                }

                YuangongNews.setOption(option);
                }
                //工作流统计
                function flowTongji(data) {

                var Type = [];var Count = [];
                for(var i = 0; i<data.length;i++){
                Type.push(data[i][0]);
                Count.push(data[i][1]);
                }
                var containerFlow = echarts.init(document.getElementById("containerFlow"));
                var option = {
                title:{
                text:''
                },
                tooltip: {
                //                trigger: 'item',
                formatter: '{a} <br/>{b} : {c} ({d}%)'
                },
                color:['rgba(90,180,222,1)','rgba(255,219,92,1)','rgba(41,188,187,1)'],
                series:[
                {type:'pie',
                radius:'65%',
                center:['50%','55%'],
                label: {
                normal: {
                textStyle : {
                fontSize :15
                }
                }
                },
                selectedMode:'single',
                data:[
                {value:Count[0],name:Type[0]},
                {value:Count[1],name:Type[1]},
                {value:Count[2],name:Type[2]},
                ],
                fontSize:20
                }
                ]

                }
                containerFlow.setOption(option)
                }
                //员工合同统计
                function hetongTongji(data) {

                var Type = [];var Count = [];
                for(var i = 0; i<data.length;i++){
                Type.push(data[i][0]);
                Count.push(data[i][1]);
                }
                var YuangongHeTong = echarts.init(document.getElementById("containerHetong"));
                var option = {
                title:{
                text:''
                },
                tooltip: {
                //                trigger: 'item',
                formatter: '{a} <br/>{b} : {c} ({d}%)'
                },
                color:['#1a8f80','#91c7ae','#1a86db','rgba(92,179,225,1)','rgba(194,53,49,1)','rgba(202,134,34,1)','rgba(255,219,92,1)'],
                series:[
                {type:'pie',
                radius:'65%',
                center:['50%','50%'],
                label: {
                normal: {
                textStyle : {
                fontSize :15
                }
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
                ]
                }
                ]

                }
                YuangongHeTong.setOption(option)
                }
                //员工请假统计
                function qingjiaTongji(dataMonth,dataNum) {


                var chart = echarts.init(document.getElementById("containerQingjia"));
                var  option ={
                title:{

                },
                tooltip:{
                show:true
                },
                color:['rgba(92,179,225,1)'],
                xAxis: {
                type: 'category',
                data: dataMonth
                },
                yAxis: {
                type: 'value'
                },
                series: [{
                data: dataNum,
                type: 'line'
                }]
                }
                chart.setOption(option)
                }
                //公司考勤
                function circleProgress(value,average){
                var canvas = document.getElementById("yuan");
                var context = canvas.getContext('2d');
                var _this = $(canvas),
                value= Number(value),// 当前数值
                average = Number(average),// 总数值
                color = "#80e5da",// 进度条、文字样式
                maxpercent = 100,//最大百分比,可设置
                c_width = 100,// canvas,宽度
                c_height =100;// canvas,高度
                // 判断设置当前显示颜色



                // 清空画布

                context.clearRect(0, 0, c_width, c_height);

                // 画初始圆

                context.beginPath();

                // 将起始点移到canvas中心

                context.moveTo(c_width/2+15, c_height/2+15);

                // 绘制一个中心点为（c_width/2, c_height/2），半径为c_height/2，起始点0，终止点为Math.PI * 2的 整圆

                context.arc(c_width/2+15, c_height/2+15, c_height/2+15, 0, Math.PI * 2, false);

                context.closePath();

                context.fillStyle = '#68b5fb'; //填充颜色

                context.fill();

                // 绘制内圆

                context.beginPath();

                context.strokeStyle = color;

                context.lineCap = 'square';

                context.closePath();

                context.fill();

                context.lineWidth = 8.0;//绘制内圆的线宽度



                function draw(cur){

                // 画内部空白

                context.beginPath();

                context.moveTo(24, 24);

                context.arc(c_width/2+15, c_height/2+15, c_height/2+7, 0, Math.PI * 2, true);

                context.closePath();

                context.fillStyle = 'rgba(255,255,255,1)';  // 填充内部颜色

                context.fill();

                // 画内圆

                context.beginPath();

                // 绘制一个中心点为（c_width/2, c_height/2），半径为c_height/2-5不与外圆重叠，

                // 起始点-(Math.PI/2)，终止点为((Math.PI*2)*cur)-Math.PI/2的 整圆cur为每一次绘制的距离

                context.arc(c_width/2+15, c_height/2+15, c_height/2-5, -(Math.PI / 2), ((Math.PI * 2) * cur ) - Math.PI / 2, false);

                context.stroke();

                // 在中间写字

                context.font = "10pt Arial";  // 字体大小，样式

                context.fillStyle = color;  // 颜色

                context.textAlign = 'center';  // 位置

                context.textBaseline = 'middle';

                context.moveTo(c_width/2+15, c_height/2+15);  // 文字填充位置

                context.fillText(value+'/'+average, c_width/2+15, c_height/2+5);

                context.stroke();

                context.fillStyle = '#666';

                context.fillText("出勤人员", c_width/2+15, c_height/2+25);

                }

                // 调用定时器实现动态效果

                var timer=null,n=0;

                function loadCanvas(nowT){

                timer = setInterval(function(){

                if(n>nowT){

                clearInterval(timer);

                }else{

                draw(n);

                n += 0.01;

                }

                },15);

                }

                loadCanvas((value/average));

                timer=null;

                };
                function progress_show (id,goal,raised,barColor) {
                $(id).jQMeter({
                goal:goal,
                raised:raised,
                width:'100%',
                height:'10px',
                bgColor:'#eeeeee',
                barColor:barColor,
                displayTotal:false
                });
                }
                function timers() {
                var timer=setTimeout(function () {
                location.reload();
                },100);
                }

                (function () {
                layui.use(['element', 'layer'], function () {
                var layer = layui.layer;
                //左侧门户数据获取
                $.ajax({
                url: '/portals/selIndexPortals',
                type: 'get',
                dataType: 'json',
                success: function (json) {
                var str = '';
                if (json.flag) {
                var data = json.obj;
                for (var i = 0; i < data.length; i++) {
                var href = '';
                var menhuclass = 'layui-icon-template';
                var color = ""
                if (data[i].portalName == "我的门户") {
                // var styles = 1;
                //window.location.href="/common/myOA?20190710";
                href = '/common/myOA?20190710';
                menhuclass = 'layui-icon-username';
                color="#1a86db"
                } else if (data[i].portalName == "应用门户") {
                href = '/common/applyOA';
                menhuclass = 'layui-icon-app';
                color="#265a8f"
                } else if (data[i].portalName == "办公管理门户") {
                href = '/portals/dazueduIndex';
                menhuclass = 'layui-icon-layer';
                color=" #5fb878"
                } else if (data[i].portalName == "政务门户") {
                href = '/governmentPortal';
                menhuclass = 'layui-icon-layer';
                color=" #7556ef"
                } else if (data[i].portalName == "办公综合门户") {
                href = '/portals/officeIndex';
                menhuclass = 'layui-icon-template';
                color='#5fb878'
                } else if (data[i].portalName == "办公门户") {
                    href = '/portals/officePortal';
                    menhuclass = 'layui-icon-template';
                    color='#91bbe5'
                    }
                else if (data[i].portalName == "制度门户") {
                href = '/document/Institutional';
                menhuclass = 'layui-icon-template';
                color='#5fb878'
                }else if (data[i].portalName == "公司门户") {
                href = '/document/companyPortal';
                menhuclass = 'layui-icon-layouts';
                color='#7556ef'
                } else if (data[i].portalName == "辅助平台") {
                href = '/common/acceptOA';

                } else if (data[i].portalName == "流程门户") {
                href = '/portal/flowIndex';
                menhuclass = 'layui-icon-user';
                color="#e2694e"
                } else if (data[i].portalName == "公文门户") {
                href = '/document/documentIndex';
                menhuclass = 'layui-icon-file';
                color="#975292"
                } else if (data[i].portalName == "知识门户") {
                href = '/document/knowledgeIndex';
                menhuclass = 'layui-icon-read';
                color="#1a8f80"
                } else if (data[i].portalName == "人力门户" || data[i].portalName == "人力资源门户") {
                href = '/document/humanResource';
                menhuclass = 'layui-icon-group';
                color="#1a776c"
                } else if (data[i].portalName == "营销门户") {
                href = '/document/marketIndex';
                menhuclass = 'layui-icon-tabs';
                color="#0078d7"
                } else if (data[i].portalName == "财务门户") {
                href = '/document/financialIndex';
                menhuclass = 'layui-icon-rmb';
                color="#01aaed"
                } else if (data[i].portalName == "报表门户") {
                href = '/document/reportFormIndex';
                menhuclass = 'layui-icon-date';
                color="#1a86db"
                } else if (data[i].portalName == "管理门户") {
                href = '/document/managementIndex ';
                color="#0078d7"
                } else {
                if (data[i].portalType == 2 ||data[i].portalType == "政务门户") {
                href = '/cmsPub/portal?siteId=' + data[i].moduleId;
                color="#91bbe5"
                } else {
                href = data[i].moduleId;
                color="#5fb878"
                }
                }
                if (i == 0) {
                var classnew = 'layui-this';
                $('.firstmenu').attr({ 'lay-id': href, 'lay-attr': href }).find('i').html(data[i].portalName);
                $('.layadmin-iframe').attr('src', href);
                } else {
                var classnew = '';
                }
                if(data[i].portalName!="管理门户"){
                str +='<div data-name="home" class="menuLi fen ' + classnew + '"  style="margin-left: 30px;">'+
                ' <a href="javascript:;"   lay-href="' + href + '" style="background-color:'+color+'">\n'+
                '                            <i class="layui-icon ' + menhuclass + '" style="display: block;text-align: center;font-size: 30px;padding-top: 6px;color:#fff"></i>' +
                '<p style="margin-top: 5px;text-align: center;font-size: 16px">' + data[i].portalName + '</p>\n'+
                '                        </a>\n'+
                '                 </div>'
                }
                }
                $("#LAY-system-side-menu").append(str);

                $.ajax({
                url: '/users/getUserTheme',
                dataType: 'json',
                type: 'post',
                async: false,
                success: function (res) {
                var datas = res.object;
                if (datas.theme != 20) {
                $('.menuLi').click(function(){
                var href=$(this).find('a').attr('lay-href');
                window.location.href=href;
                var num = $(".header", window.parent.document).find('ul li');
                for(var i=0;i<num.length;i++){
                // console.log(num.eq(i).attr('iframesrc'))
                if(num.eq(i).attr('iframesrc') == href){
                num.eq(i).find('span').addClass('active');
                num.eq(i).siblings().find('span').removeClass('active')
                return false;
                }

                }
                })
                }
                }
                })
                }
                }
                });
                });
                })();
                </script>
                </body>
                </html>
