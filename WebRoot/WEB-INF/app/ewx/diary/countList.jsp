<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@taglib prefix="mvc" uri="http://www.springframework.org/tags/form" %>
<%@taglib prefix="fmt" uri="http://www.springframework.org/tags" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width,initial-scale=1,minimum-scale=1,maximum-scale=1,user-scalable=no" />
    <title>日志统计列表</title>
    <script src="/js/xoajq/xoajq1.js" type="text/javascript" charset="utf-8"></script>
    <script type="text/javascript" src="../lib/mui/mui/mui.min.js"></script>
    <script type="text/javascript" src="../js/diary/m/vue.min.js"></script>
    <link href="../lib/mui/mui/mui.css" rel="stylesheet"/>
    <link rel="stylesheet" type="text/css" href="../css/diary/m/iStarted.css">
    <link rel="stylesheet" type="text/css" href="../css/diary/m/consult.css">
    <link rel="stylesheet" href="../css/diary/m/diary_base.css" />
    <style>
        .clearfix:after {
            content: " ";
            display: block;
            clear: both;
            height: 0;
        }
        .clearfix {
            zoom: 1;
        }
        .mui-table-view{
            width: 100%;
            float: left;
        }
        .mui-table-view.mui-grid-view .mui-table-view-cell>a:not(.mui-btn){
            color: #00c749;
        }
        .al_smt_day,.al_smt_month{
            border-right: 1px solid #F2F2F2;
        }
        .al_smt_day_count,.al_smt_month_count{
            color: #3b8fd4;
        }
        .next_smt_day_count,.next_smt_month_count{
            color: #ff6360;
        }
        .Submit_count {
            border-bottom: 6px solid #f5f5f5;
        }
        .Submit_count.mui-table-view:after {
            height: 0px;
        }
        .comment_no {
            color: #ff6360;
            font-size: 17px;
            margin-top: 8px;
        }
        .comment_have {
            color: #3b8fd4;
            font-size: 17px;
            margin-top: 8px;
        }
        .comment_have_no {
            color: #ff806f;
            font-size: 17px;
            margin-top: 8px;
        }
        .mui-btn-block {
            width: calc(100% - 20px);
            margin: auto;
            padding: 10px 0;
        }
        /*统计*/
        .pull_left {
            float:left;
        }
        .pull_right {
            float:right;
        }
        .people {
            margin-right:5px;
        }
        .initiator_list {
            margin-left:0px !important;
        }
        li.mui-table-view-cell {
            padding: 11px 15px 11px 16px;
        }
        #list0,#list1{
            padding-bottom: 50px !important;
        }
        ul.mui-table-view {
            border-bottom:2px solid #f3f3f3;
        }
        #tab_nav {
            border-bottom:1px solid #f3f3f3;
        }

    </style>
    <script type="text/javascript" charset="utf-8">
        mui.init();
    </script>
</head>
<body id="count_list">
<!--<header class="mui-bar mui-bar-nav">
    <a class="mui-action-back mui-icon mui-icon-left-nav mui-pull-left mui-nav-btn"></a>
    <h1 class="mui-title">统计列表</h1>
    <a id="info" class="mui-icon mui-icon-more-filled mui-pull-right mui-nav-btn"></a>
</header>-->
<div class="mui-content">
    <!--<div class="stat_sear">
        <div class="started_me">统计</div>
    </div>-->
    <div class="mui-popup-text">
        <div class=" mui-badge-blue"><i class="date-icon"></i><span class="mui-pull-left mui-date"></span><span class="mui-pull-right mui-type">日报</span></div>
        <div class="mui-table">
            <ul class="mui-table-view mui-grid-view" id="count_con">
                <li class="mui-table-view-cell mui-media mui-col-xs-6 al_smt_day">
                    <a class="mui-table-view-cell" href="javascript:;" @click="jump_istarted">
                        <h3 class="mui-text-center al_smt_day_count">0</h3>
                        <p>已提交</p>
                    </a>
                </li>
                <li class="mui-table-view-cell mui-media mui-col-xs-6">
                    <a class="mui-table-view-cell" href="javascript:;" @click="jump_istarted">
                        <h3 class="mui-text-center next_smt_day_count">0</h3>

                        <p>未提交</p>
                    </a>
                </li>
            </ul>
        </div>
        <div class="tab clearfix" id="tab_nav">
            <a class=" pull_left line_tab" id="0">
                <span class="">已提交</span>
            </a>
            <a class="pull_right" id="1" style="color:#8f8f94">
                <span class="">未提交</span>
            </a>

        </div>
        <ul class="mui-table-view list" id="list0" ></ul>
        <ul class="mui-table-view list" id="list1" style="display: none;"></ul>
    </div>
</div>

<footer class="mui-bar-footer" id="footer" style="display: none;">
    <nav class="mui-bar mui-bar-tab mui-btn-nav" data-role="footer">
        <button class="mui-btn mui-btn-block mui-btn-mini mui-btn-negative" id="remind">一键提醒</button>
    </nav>
</footer>
</body>
<script type="text/javascript">
    var wait=null;var closewin=null;

    var url = location.search; //获取url中"?"符后的字串
    theRequest = new Object();//改为全局变量
    if (url.indexOf("?") != -1) {
        var str = url.substr(1);
        strs = str.split("&");
        for(var i = 0; i < strs.length; i ++) {
            theRequest[strs[i].split("=")[0]]=unescape(strs[i].split("=")[1]);
        }
    }
    // H5 plus事件处理
    function plusReady(){}
    if(window.plus){
        plusReady();
    }else{
        document.addEventListener("plusready",plusReady,false);
    }
    function p(s) {
        return s < 10 ? '0' + s: s;
    }
    var date=new Date();
    var d=date.getDate();
    var y=date.getFullYear();
    var m=date.getMonth()+1;
    var str_date=y+'年'+p(m)+'月'+p(d)+'日';
    var str_month=y+'年'+p(m)+'月';

    function GetQueryString(name) {
        var reg = new RegExp("(^|&)" + name + "=([^&]*)(&|$)");
        var r = window.location.search.substr(1).match(reg);
        if (r != null) return unescape(r[2]); return null;
    }
    var day = GetQueryString("day"); //括号里放地址栏传参变量
    var week = GetQueryString("week"); //括号里放地址栏传参变量
    var month = GetQueryString("month"); //括号里放地址栏传参变量
    if(day!=null){
        var arr = day.split('-');
        str_date=arr[0]+"年"+arr[1]+"月"+arr[2]+"日";
    }
    if(week!=null){
        var arr = week.split('-');
        str_month=arr[0]+"年"+arr[1]+"月";
    }
    if(month!=null){
        var arr = month.split('-');
        str_month=arr[0]+"年"+arr[1]+"月";
    }

    if(theRequest.dia_type == '0'){
        jQuery(".mui-date").html(str_date);
        jQuery(".mui-type").html('日报');
    }else if(theRequest.dia_type == '2'){
        jQuery(".mui-date").html(str_month);
        jQuery(".mui-type").html('月报');
    }else if(theRequest.dia_type == '1'){
        jQuery(".mui-date").html(str_month);
        jQuery(".mui-type").html('周报');
    }
    //    (function($, doc) {
    //        mui.init();
    //        for(var v=0;v<2;v++){
    //            if(v==0){
    //                var s='A';
    //            }else if(v==1){
    //                var s='B';
    //            }
    //            theRequest.flag=7;
    //            //theRequest.SFLAG=v;
    //            theRequest.stype=s;
    //            var li_str='';
    //            var length='';
    //            mui.ajax({
    //                url: '/pda/diary/data/data.php',
    //                type: 'POST',
    //                data:theRequest,
    //                dataType:'json',
    //                async: false,
    //                beforeSend: function() {
    //                    wait;
    //                },
    //                complete: function() {
    //                    closewin;
    //                },
    //                success:function(data){
    //                    length=data.length;
    //                    theRequest.uncommit='';
    //                    if(data !='' && data !=null){
    //                        for(i=0;i<data.length;i++){
    //                            theRequest.uncommit+=data[i].UID+',';//拼接未提交日志的UID
    //                            if(data[i].HAS == '0'){
    //                                var yue='未点评';
    //                                var color_yue = 'comment_have_no';
    //                            }else if(data[i].HAS == '1'){
    //                                var yue='已点评';
    //                                var color_yue = 'comment_have';
    //                            }else{
    //                                var yue='';
    //                            }
    //                            li_str+=' <li class="mui-table-view-cell"><a data-did="'+data[i].DIA_ID+'"><div class="consult_list"><div class="pull_left"><span class="subject">'+data[i].NAME+'</span><div class="initiator_list">'+data[i].PAME+'</div></div><div class="pull_right '+color_yue+'">'+yue+'</div></div></a></li>';
    //                        }
    //                    }else{
    //                        li_str+='<li class="mui-table-view-cell">暂无数据</li>';
    //                    }
    //
    //                }
    //            })
    //            jQuery("#list"+v).html(li_str);
    //            jQuery("#count_con").find("h3")[v].innerHTML=length;
    //        }
    //    })(mui, document);
    jQuery(function(){
        /*已提交/未提交*/
        mui("#tab_nav").on('tap','a',function(){
            var type_id=$(this).attr("id");
            var uncount=jQuery(".next_smt_day_count").html();
            $(this).addClass("line_tab").siblings().removeClass("line_tab");
            jQuery("ul[id=list"+type_id+"]").show();
            jQuery("ul[id=list"+type_id+"]").siblings("ul").hide();
            jQuery("a[id="+type_id+"]").css("color","#007aff");
            jQuery("a[id="+type_id+"]").siblings("a").css("color","#8f8f94");
            if(uncount != '0'){
                if(jQuery("#list1").css("display")==='block'){
                    jQuery("#footer").css("display","block");
                }else{
                    jQuery("#footer").css("display","none");
                }
            }
        });
        mui("#footer").on('tap','#remind',function(){
            mui.ajax({
                url: '/pda/diary/data/data.php',
                type: 'POST',
                data:{
                    flag:17,
                    uncommit:theRequest.uncommit,
                    // DIA_TYPE:theRequest.dia_type,    //0日报
                    // SFLAG:v      //未发送
                },
                dataType:'json',
                async: true,
                beforeSend: function() {
                    wait;
                },
                complete: function() {
                    closewin;
                },
                success:function(data){
                    mui.toast('消息已发送',{ duration:'200', type:'div' });
                }
            });
        });
    });
    var vm=new Vue({
        el:'#count_list',
        data:{
            name:'Vue.js'
        },
        methods:{
            jump_create:function(event){
                mui.openWindow({
                    url:'Create.php',
                    id:'Create'
                });
            }
        }
    });
</script>
</html>
