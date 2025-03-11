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
    <title>统计</title>
    <script src="/js/xoajq/xoajq1.js" type="text/javascript" charset="utf-8"></script>
    <script type="text/javascript" src="../lib/mui/mui/mui.min.js"></script>
    <script type="text/javascript" src="../js/diary/m/vue.min.js"></script>
    <link href="../lib/mui/mui/mui.css" rel="stylesheet"/>
    <link rel="stylesheet" type="text/css" href="../css/diary/m/iStarted.css">
    <link rel="stylesheet" href="../css/diary/m/diary_base.css" />
    <style>
        .mui-table-view{
            width: 100%;
            float: left;
        }
        .mui-table-view.mui-grid-view .mui-table-view-cell>a:not(.mui-btn){
            color: #15c33e;
        }
        .al_smt_day,.al_smt_month,.al_smt_week{
            border-right: 1px solid #F2F2F2;
        }
        .al_smt_day_count,.al_smt_month_count,.al_smt_week_count{
            color: #598fd6;
        }
        .next_smt_day_count,.next_smt_month_count,.next_smt_week_count{
            color: #ff6f6f;
        }
        .al_smt_day_count,
        .al_smt_month_count,
        .al_smt_week_count,
        .next_smt_week_count,
        .next_smt_day_count,
        .next_smt_month_count{
            margin-top:10px;
            margin-bottom: 10px;
        }
        .mui-table-view-cell a p{
            margin-bottom: 10px;
        }
        ul.mui-table-view {
            border-bottom:2px solid #f3f3f3;
        }
    </style>
</head>
<body id="Count">
<!--<header class="mui-bar mui-bar-nav">
    <a class="mui-action-back mui-icon mui-icon-left-nav mui-pull-left mui-nav-btn"></a>
    <h1 class="mui-title">统计</h1>
    <a id="info" class="mui-icon mui-icon-more-filled mui-pull-right mui-nav-btn"></a>
</header>-->
<div class="mui-content">
    <div class="mui-popup-text">
        <div class=" mui-badge-blue"><i class="date-icon" @click="jump_calender" data-type="0"></i><span class="mui-pull-left mui-date"></span><span class="mui-pull-right">日报</span></div>
        <div class="mui-table">
            <ul class="mui-table-view mui-grid-view">
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
            <ul class="mui-table-view mui-grid-view">
                <li class="mui-table-view-cell mui-media mui-col-xs-12">
                    <a class="mui-table-view-cell mui-check" href="javascript:;" @click="jump_countlist" data-type="0">查看详情</a>
                </li>
            </ul>
        </div>
    </div>
    <div class="mui-popup-text">
        <div class=" mui-badge-blue"><i class="date-icon" @click="jump_calender" data-type="1"></i><span class="mui-pull-left mui-date"></span><span class="mui-pull-right">周报</span></div>
        <div class="mui-table">
            <ul class="mui-table-view mui-grid-view">
                <li class="mui-table-view-cell mui-media mui-col-xs-6 al_smt_day">
                    <a class="mui-table-view-cell" href="javascript:;" @click="jump_istarted">

                        <h3 class="mui-text-center al_smt_week_count">0</h3>
                        <p>已提交</p>
                    </a>
                </li>
                <li class="mui-table-view-cell mui-media mui-col-xs-6">
                    <a class="mui-table-view-cell" href="javascript:;" @click="jump_istarted">

                        <h3 class="mui-text-center next_smt_week_count">0</h3>
                        <p>未提交</p>
                    </a>
                </li>
            </ul>
            <ul class="mui-table-view mui-grid-view">
                <li class="mui-table-view-cell mui-media mui-col-xs-12">
                    <a class="mui-table-view-cell mui-check" href="javascript:;" @click="jump_countlist" data-type="1">查看详情</a>
                </li>
            </ul>
        </div>
    </div>
    <div class="mui-popup-text">
        <div class=" mui-badge-blue"><i class="date-icon" @click="jump_calender" data-type="2"></i><span class="mui-pull-left mui-month"></span><span class="mui-pull-right">月报</span></div>
        <div class="mui-table">
            <ul class="mui-table-view mui-grid-view">
                <li class="mui-table-view-cell mui-media mui-col-xs-6 al_smt_week">
                    <a class="mui-table-view-cell" href="javascript:;" @click="jump_istarted">

                        <h3 class="mui-text-center al_smt_month_count">0</h3>
                        <p>已提交</p>
                    </a>
                </li>
                <li class="mui-table-view-cell mui-media mui-col-xs-6">
                    <a class="mui-table-view-cell" href="javascript:;" @click="jump_istarted">

                        <h3 class="mui-text-center next_smt_month_count">0</h3>
                        <p>未提交</p>
                    </a>
                </li>
            </ul>
            <ul class="mui-table-view mui-grid-view">
                <li class="mui-table-view-cell mui-media mui-col-xs-12">
                    <a class="mui-table-view-cell mui-check" href="javascript:;" @click="jump_countlist" data-type="2">
                        查看详情
                    </a>
                </li>
            </ul>
        </div>
    </div>
</div>
</body>
<script type="text/javascript">
    var wait=null;var closewin=null;
    // H5 plus事件处理
    function plusReady(){
        wait=plus.nativeUI.showWaiting('正在加载');
        closewin= plus.nativeUI.closeWaiting();
    }
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
    jQuery(".mui-month").html(str_month);
    jQuery(".mui-date").html(str_date);

    (function($, doc) {
        mui.init();
        mui.ajax({
            url: '/pda/diary/data/data.php?flag=7',
            type: 'POST',
            dataType:'json',
            beforeSend: function() {
                wait;
            },
            complete: function() {
                closewin;
            },
            success:function(data){
                jQuery(".al_smt_day_count").html(data[0].t_committed);
                jQuery(".next_smt_day_count").html(data[0].t_uncommitted);
                jQuery(".al_smt_week_count").html(data[0].w_committed);
                jQuery(".next_smt_week_count").html(data[0].w_uncommitted);
                jQuery(".al_smt_month_count").html(data[0].m_committed);
                jQuery(".next_smt_month_count").html(data[0].m_uncommitted);

            }
        });
    })(mui, document);

    var vm=new Vue({
        el:'#Count',
        data:{
            name:'Vue.js'
        },
        methods:{
            jump_countlist:function(event){
                mui.openWindow({
                    url:'/diary/diaryCountListh5?dia_type='+event.target.getAttribute("data-type"),
                    id:'count_list'
                });
            },
            jump_calender:function(event){
                mui.openWindow({
                    url:'/diary/diaryCalenderh5?dia_type='+event.target.getAttribute("data-type"),
                    id:'calender'
                });
            }
        }
    });
</script>
</html>