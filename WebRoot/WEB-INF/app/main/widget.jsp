<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@taglib prefix="mvc" uri="http://www.springframework.org/tags/form" %>
<%@taglib prefix="fmt" uri="http://www.springframework.org/tags" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE html>
<html>

<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
    <%--<meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=0, minimum-scale=1.0, maximum-scale=1.0">--%>
    <meta name="apple-mobile-web-app-capable" content="yes">
    <meta name="apple-mobile-web-app-status-bar-style" content="black">
    <title></title>
    <script type="text/javascript" src="/js/xoajq/xoajq1.11.1.js"></script>
    <script src="/js/base/base.js"></script>
    <link rel="stylesheet" type="text/css" href="/css/bootstrap.css"/>

    <meta name="viewport" content="width=device-width, initial-scale=0.3, user-scalable=0, minimum-scale=0, maximum-scale=5.0,user-scalable=yes">
    <link rel="stylesheet" href="/css/officialDocument/officialDocument.css">
    <link rel="stylesheet" href="/lib/pagination/style/pagination.css">
    <link rel="stylesheet" href="/lib/laydate/need/laydate.css">
    <link rel="stylesheet" type="text/css" href="/css/street/street.css"/>
    <link rel="stylesheet" type="text/css" href="/css/base.css"/>
    <script type="text/javascript" src="../../js/xoajq/xoajq1.js"></script>
    <script src="../../lib/laydate/laydate.js"></script>
    <script src="/js/base/base.js"></script>
    <script src="/lib/Highcharts-5.0.14/code/highcharts.js"></script>
    <script src="/lib/Highcharts-5.0.14/code/modules/data.js"></script>
    <script src="/lib/pagination/js/jquery.pagination.min.js" type="text/javascript" charset="utf-8"></script>
    <script src="/lib/Highcharts-5.0.14/code/modules/drilldown.js"></script>
    <link rel="stylesheet" href="../../lib/kinggrid/core/kinggrid.plus.mobile.css">
    <script type="text/javascript" src="../../lib/kinggrid/signature.mobile.min.js"></script>
    <script type="text/javascript" src="../../lib/kinggrid/signature_pad.min.js"></script>
    <script type="text/javascript" src="../../lib/kinggrid/jquery.timer.dev.js"></script>
    <link rel="stylesheet" href="/css/officialDocument/officialDocument.css">
    <link rel="stylesheet" href="/lib/layer/skin/default/layer.css">
    <link rel="stylesheet" href="/lib/laydate/need/laydate.css">
    <link rel="stylesheet" href="/lib/pagination/style/pagination.css">
    <link rel="stylesheet" href="/css/base.css">
    <script type="text/javascript" src="/js/xoajq/xoajq1.js"></script>
    <script src="/lib/layer/layer.js?20201106"></script>
    <script src="/js/base/base.js"></script>
    <script src="/js/jquery/jquery-validate.js"></script>
    <%--<script src="/lib/validate-mothods.js"></script>--%>
    <script src="/lib/pagination/js/jquery.pagination.min.js" type="text/javascript" charset="utf-8"></script>
    <script src="/lib/Highcharts-5.0.14/code/highcharts.js"></script>
    <script src="/lib/Highcharts-5.0.14/code/modules/data.js"></script>
    <script src="/lib/Highcharts-5.0.14/code/modules/drilldown.js"></script>
    <script src="/js/jquery/jquery.cookie.js"></script>
    <%--<link rel="stylesheet" href="/css/main/fullscreen.css">--%>
    <script src="/js/xoajq/xoajq1.js" type="text/javascript" charset="utf-8"></script>
    <script src="/js/base/base.js"></script>
    <script type="text/javascript" src="/js/xoajq/xoajq1.js"></script>
    <style>
        body{
            margin: 0;
            padding: 0;
            background: #fff;
        }
        p{
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }
        iframe{
            width:100%;
            height:100%;
        }
        .title{
            padding-left: 0.08333333333333333rem;
            font-size: 0.35rem;
            height: 0.5rem;
            line-height: 0.5rem;
            color: #fff;
            background: #72aafd;
        }
        .section{
            margin: 0.041666666666666664rem 0.08333333333333333rem;
            border-radius: 0.05rem;
            overflow: hidden;
        }
        body,html{
            width: 100%;
            height: 100%;
        }

        .pic{
            float: left;
        }
        table {
            border-collapse: collapse;
            width: 100%;
            /*height: 100%;
             */
        }
        td,th{
            border: 1px solid #c2ccd1;
        }
        div{
            font-size: 0.31rem;
        }
        td{
            padding: 0.6666666666666666rem 0;
            width: 50%;
            padding-left: 9%;
        }


        body,html{
            width: 100%;
            height: 100%;
        }
        .pic{
            float: left;
        }
        table {
            border-collapse: collapse;
            width: 100%;
            /*height: 100%;
             */
        }
        td,th{
            border: 1px solid #c2ccd1;
        }
        div{
            font-size: 0.31rem;
            -webkit-font-smoothing:antialiased;
        }
        td{
            padding: 0.6666666666666666rem 0;
            width: 50%;
            padding-left: 6%;
        }
        .conts{
            font-size: 0.5333333333333333rem;
        }
        .rit{
            float: left;
            margin-top: -0.041666666666666664rem;
            margin-left: 0.375rem;
        }
        .nav {
            width: 100%;
            padding: 0.16666666666666666rem 0;
            padding-top: 0.6666666666666666rem;
        }
        .nav ul{
            width: 5.6rem;
            margin: 0 auto;
            border-radius: 0.008333333333333333rem;
        }
        .navs li{
            float: left;
            /*background-color: dodgerblue;
             */
            padding: 0.21rem 0.5rem;
            font-size: 0.4166666666666667rem;
            /*color: #fff;
             */
            border: 2px solid dodgerblue;
        }
        .active{
            background-color: dodgerblue;
            color: #fff;
        }
        .content{
            padding: 0.375rem;
            padding: 0.16666666666666666rem;
            /*width: 9.583333333333334rem;
             */
            margin: 0 auto;
            padding-right: 0;
        }
        .left{
            float: left;
            width: 3.1666666666666665rem;
            text-align: right;
        }
        .right{
            float: right;
            width: calc(100% - 5rem);
            height: 100%;
            position: relative;
            top: -0.25rem;
            left: -1.3333333333333333rem;
        }
        .shequ{
            font-size: 0.32rem;
        }
        .out {
            width: 91%;
            height: 0.25rem;
            /*border-radius: 0.16666666666666666rem;
             */
            background: #d0edfa;
            margin-top: 0.25rem;
            overflow: hidden;
        }
        .in {
            display: inline-block;
            height: 100%;
            background: #17aee6;
            /*border-radius: 0.16666666666666666rem;
             */
            width: 50%;
        }
        .content li{
            padding: 0.4166666666666667rem 0;
        }
        .content span{
            text-align: right;
        }
        .box{
            position: absolute;
            /*right: -28%;
             */
            top: 0.25833333333333336rem;
            left: 100%;
        }
        .font{
            font-size: 0.5416666666666666rem;
            color: #e38453
        }
        .conter li:hover{
            cursor:pointer;
        }
        .tab{
            width:100%;
        }
        .main ul{
            width:60%;
            height:0.5416666666666666rem;
            margin:0.4166666666666667rem auto 0rem;
            border-radius: 0.041666666666666664rem;
            border:1px solid #3d91e4;
        }
        .tab li{
            width:33.2%;
            float:left;
            border-right:0.008333333333333333rem solid #3d91e4;
            color: #3d91e4;
            height:100%;
            line-height: 0.5416666666666666rem;
            text-align: center;
            font-size: 0.35rem;
        }
        .tab .select{
            color: #ffffff;
            background: #3d91e4;
        }
        #containerOne{
            width:100%;
        }
        *{
            margin: 0;
            padding: 0;
        }
        body,html{
            width: 100%;
            /*height: 100%;
             */
            background-color: #fff;
            /*font-size: 0.26666666666666666rem;
             */
        }

        .top{
            position: relative;
            border-top: #d5d6d8 solid 0.008333333333333333rem;
            width: 100%;
            height: 3.75rem;
            background: url('/img/street/paihang.png') no-repeat;
            background-size: 100% 100%;
        }
        .bot{
            font-size: 0.26666666666666666rem;
            position: absolute;
            bottom: 0;
            width: 100%;
            height: 1.25rem;
            /*border: 1px solid blue;
             */
        }
        .p1,.p2,.p3{
            width: 32.333%;
            text-align: center;
            height: 0.8333333333333334rem;
            float: left;
        }
        .p3{
            padding-left: 0.15rem;
        }
        .p2{
            margin-top: -0.19166666666666668rem;
        }
        .sorce{
            color: #999999;
            text-align: center;
            font-weight: 700;
        }
        .name{
            color: #2e78bf;
            font-size: 0.24rem;
            font-weight: 700;
            padding: 0.008333333333333333rem;
            padding-top: 0.08333333333333333rem;
        }
        .bottom{
            /*height: 1.6666666666666667rem;
             */
            width: 100%;
            text-align: center;
            background-color: #fff;
        }
        .cont{
            width: 100%;
            border-bottom: #d5d6d8 solid 0.008333333333333333rem;
            height: 1rem;
        }
        .con1{
            width: 66%;
            float: left;
            line-height: 1rem;
            text-align: left;
        }
        .con2{
            width: 20%;
            float: left;
            padding-top: 0.3333333333333333rem;
            text-align: left;
        }
        .con3{
            width: 14%;
            color: #fb862f;
            float: left;
            font-size: 0.3333333333333333rem;
            line-height: 1rem;
            font-weight: 700;
        }
        .in {
            display: inline-block;
            height: 0.16666666666666666rem;
            background: #17aee6;
            /*border-radius: 0.16666666666666666rem;
             */
            width: 100%;
        }
        .nums{
            float: left;
            width:5%;
            padding:0 0.19166666666666668rem;
            font-size: 0.375rem;
            font-weight: 700
        }
        .rits{
            float: left;
            width:82%;
            line-height: 1rem;
            font-size: 0.26666666666666666rem;
        }
        *{
            margin: 0;
            padding: 0;
        }
        body,html{
            width: 100%;
            height: 100%;
            font-size: 0.26666666666666666rem;
        }
        img{
            width: 100%;
            height: 100%;
        }
        .pic img{
            width: 1rem;
            height: 1rem;

        }
        .top{
            position: relative;
            border-top: #d5d6d8 solid 0.008333333333333333rem;
            width: 100%;
            height: 3.75rem;
            background: url('/img/street/paihang.png') no-repeat;
            background-size: 100% 100%;
        }
        .bot{
            font-size: 0.26666666666666666rem;
            position: absolute;
            bottom: 0;
            width: 100%;
            height: 1.25rem;
            /*border: 1px solid blue;
             */
        }
        .p1,.p2,.p3{
            width: 32.333%;
            text-align: center;
            height: 0.8333333333333334rem;
            float: left;
        }
        .p3{
            padding-left: 0.15rem;
        }
        .p2{
            margin-top: -0.19166666666666668rem;
        }
        .sorce{
            color: #999999;
            text-align: center;
            font-weight: 700;
        }

        .bottom{
            /*height: 1.6666666666666667rem;
             */
            width: 100%;
            text-align: center;
            background-color: #fff;
        }
        .in {
            display: inline-block;
            height: 0.16666666666666666rem;
            background: #17aee6;
            /*border-radius: 0.16666666666666666rem;
             */
            width: 100%;
        }
        .nums{
            float: left;
            width:8%;
            padding:0 0.19166666666666668rem;
            font-size: 0.375rem;
            font-weight: 700;
            text-align: center;
        }
        rits1{
            float: left;
        }
        .usernav {
            font-size: 0.24rem;
            display: flex;
            /*align-items: center;*/
            background-color: #fff;
            text-align: center;
            flex-wrap: wrap;
        }
        .nav{
            font-size: 0.28rem;
            color: #666;
            /*//margin: 0 0.2rem;*/
            line-height: 0.8rem;
            /*//padding-left: 0.18rem;*/
            position: relative;
        }
        .usernav img{
            width: 0.9rem;
            height: 0.9rem;
            margin:0 auto;
        }
        .usernav div{
            /*padding-top: 0.15rem;*/
            color: #666;
        }


        .nav1{
            font-size: 0.28rem;
            color: #1e90ff;
            line-height: 0.62rem;
            padding-left: 0.5rem;
            position: relative;
            background-color: #f0f1f3;
            bottom: 5px;
            border-radius: 18px 18px 0px 0px;
            box-shadow: 0px 1px 3px #aeaeae;
        }



        /*#navsn .nav1{*/
            /*font-size: 0.28rem;*/
            /*color: #666;*/
            /*margin: 0 0.2rem;*/
            /*line-height: 0.8rem;*/
            /*padding-left: 0.18rem;*/
            /*position: relative;*/
        /*}*/
        /*#navsn{*/
        /*box-shadow: 0 1px 28px rgba(206, 194, 194, 0.85);*/
        /*border-radius: .1rem;*/
        /*background-color: #fff;*/
        /*margin: .25rem .13rem;*/
        /*}*/
        /*.nav{*/
        /*font-size: 0.28rem;*/
        /*color: #1e90ff;*/
        /*line-height: 0.62rem;*/
        /*padding-left: 0.5rem;*/
        /*position: relative;*/
        /*background-color: #f0f1f3;*/
        /*bottom: 5px;*/
            /*border-radius: 18px 18px 0px 0px;*/
        /*box-shadow: 0px 1px 3px #aeaeae;*/
        /*}*/

        /*#navsn .chunk{*/
            /*width: 10px;*/
            /*height: 36px;*/
            /*background: #7caeff;*/
            /*display: inline-block;*/
            /*position: relative;*/
            /*top: 2px;*/
            /*right: 22px;*/
        /*}*/
        #navsn .usernav {
            font-size: 0.24rem;
            display: flex;
            /*align-items: center;*/
            background-color: #fff;
            text-align: center;
            flex-wrap: wrap;
            /*border-radius: 0 0 18px 18px;*/
            border: 1px solid #c2ccd1;
        }
        #navsn .usernav img{
            width: 0.9rem;
            height: 0.9rem;
            margin:0 auto;
        }
        #navsn .usernav div{
            padding-top: 0.15rem;
            color: #666;
        }
        #navsn input{
            width: 88%;
            border:1px solid #ccc;
            padding-left: .05rem;
            height: .5rem;
            margin: .1rem 0;
            border-radius: 3px;

        }
        #navsn .usernav a{
            width: 25%;
            position: relative;
            margin: .2rem 0;
        }
        #navsn div{
            font-size: .24rem;
        }

    </style>

</head>

<body>

<%--<div id="navsn">--%>
    <%--<p class="nav1"><span class="chunk"></span>网格中心</p>--%>
    <%--<div>--%>
        <%--<section class="usernav">--%>
            <%--<a href="javascript:;" class="alerts">--%>
                <%--<img src="../../img/menu/zhihuizhongxing.png"/>--%>
                <%--<div>网格中心</div>--%>
            <%--</a>--%>
            <%--<a href="javascript:;" class="alerts">--%>
                <%--<img src="../../img/menu/Gridmap.png"/>--%>
            <%--<div>网格地图</div>--%>
            <%--</a>--%>
            <%--<a href="javascript:;" class="alerts">--%>
                <%--<img src="../../img/menu/huanbaoseshi.png"/>--%>
                <%--<div>环保设施</div>--%>
            <%--</a>--%>
            <%--<a href="javascript:;" class="alerts">--%>
                <%--<img src="../../img/menu/videoSurveillanceQiye.png"/>--%>
                <%--<div>动态监管台账</div>--%>
            <%--</a>--%>
        <%--</section>--%>
    <%--</div>--%>
<%--</div>--%>

<div class="section" id="navsn">
    <p class="title" >应用中心</p>
    <div>
        <%--<iframe src="/street/populationH5" frameborder="0"></iframe>--%>
            <section class="usernav">
            <a href="javascript:;" class="alerts">
            <img src="../../img/menu/zhihuizhongxing.png"/>
            <div>网格中心</div>
            </a>
            <a href="javascript:;" class="alerts">
            <img src="../../img/menu/Gridmap.png"/>
            <div>网格地图</div>
            </a>
            <a href="javascript:;" class="alerts">
            <img src="../../img/menu/huanbaoseshi.png"/>
            <div>环保设施</div>
            </a>
            <a href="javascript:;" class="alerts">
            <img src="../../img/menu/videoSurveillanceQiye.png"/>
            <div>动态监管台账</div>
            </a>
            </section>

    </div>
</div>

<div class="section">
    <p class="title" >人口信息</p>
    <div>
        <%--<iframe src="/street/populationH5" frameborder="0"></iframe>--%>

            <table >
                <tr>
                    <td style="border-left: none;border-top: none">
                        <div class="pic">
                            <img src="/img/street/people1.png" alt="">
                        </div>
                        <div class="rit"><span class="conts">6.63</span>万
                            <div>常住人口</div>
                        </div>

                    </td>
                    <td style="border-right: none;border-top: none">
                        <div class="pic">
                            <img src="/img/street/people6.png" alt="">
                        </div>
                        <div class="rit"><span class="conts">2.5</span>万
                            <div>总户数</div>
                        </div>

                    </td>
                </tr>
                <tr>
                    <td style="border-left: none;border-top: none">
                        <div class="pic">
                            <img src="/img/street/people3.png" alt="">
                        </div>
                        <div class="rit"><span class="conts">9034</span>人
                            <div>流动人口</div>
                        </div>

                    </td>
                    <td style="border-right: none;border-top: none">
                        <div class="pic">
                            <img src="/img/street/people2.png" alt="">
                        </div>
                        <div class="rit"><span class="conts">20</span>人
                            <div>出生人口</div>
                        </div>

                    </td>
                </tr>
                <tr>
                    <td style="border-left: none;border-bottom: none">
                        <div class="pic">
                            <img src="/img/street/people4.png" alt="">
                        </div>
                        <div class="rit"><span class="conts">16</span>人
                            <div>失业人口</div>
                        </div>

                    </td>
                    <td style="border-right: none;border-bottom: none">
                        <div class="pic">
                            <img src="/img/street/people5.png" alt="">
                        </div>
                        <div class="rit"><span class="conts">5</span>人
                            <div>退休人口</div>
                        </div>

                    </td>
                </tr>
            </table>
    </div>
</div>

<div class="section">
    <p class="title" >安全监管</p>
    <div style="    height: 873px;">
        <%--<iframe src="/street/safetyH5" frameborder="0"></iframe>--%>

            <table >
                <tr>
                    <td>
                        <div class="pic">
                            <div style="margin-top: 11px;width: 50px;height:50px;border-radius: 4px;background-color:#ef563d"></div>
                        </div>
                        <div class="rits1"><span class="">重大隐患 <span id="zdyh" class="number">0</span> 起</span>
                        </div>

                    </td>
                    <td>
                        <div class="pic">
                            <div style="margin-top: 11px;width: 50px;height:50px;border-radius: 4px;background-color:#f2ce2f"></div>
                        </div>
                        <div class="rits1"><span class="">突出隐患 <span id="tcyh" class="number">0</span> 起</span>
                        </div>

                    </td>
                </tr>
                <tr>
                    <td>
                        <div class="pic">
                            <div style="margin-top: 11px;width: 50px;height:50px;border-radius: 4px;background-color:#1e9de0"></div>
                        </div>
                        <div class="rits1"><span class="">一般隐患 <span id="ybyh" class="number">0</span> 起</span>
                        </div>

                    </td>
                    <td>
                        <div class="pic">
                            <div style="margin-top: 11px;width: 50px;height:50px;border-radius: 4px;background-color:rgb(80, 180, 50)"></div>
                        </div>
                        <div class="rits1"><span class="">合格达标 <span id="hgdb" class="number">0</span> 起</span>
                        </div>

                    </td>
                </tr>

            </table>
            <div id="container" style="min-width: 100%; margin: 0 auto"></div>
            <div style="width: 100%;text-align: center;padding: 10px 0;    padding-bottom: 100px;">
                <div style="float: left;width: 25%">合格达标</div>
                <div style="float: left;width: 25%">一般隐患</div>
                <div style="float: left;width: 25%">突出隐患</div>
                <div style="float: left;width: 25%">重大隐患</div>
            </div>

    </div>
</div>
<div class="section">
    <p class="title">优秀党支部积分</p>
    <div style="    height: 700px;">
        <%--<iframe src="/street/excellentH5" frameborder="0"></iframe> --%>
        <div class="top">
            <div class="bot">
                <div class="p1">
                    <div class="name" id="nam1"></div>
                    <div class="sorce" id="num1">0</div>
                </div>
                <div class="p2">
                    <div class="name" id="nam2"></div>
                    <div class="sorce" id="num2">0</div>
                </div>
                <div class="p3">
                    <div class="name" id="nam3"></div>
                    <div class="sorce" id="num3">0</div>
                </div>
            </div>
        </div>
        <%--<div class="bottom1">--%>
        <%--<div class="cont">--%>
        <%--<div class="con1" style="width: 18%;"><div class="nums">4</div><div class="rits" style=""></div></div>--%>
        <%--<div class="con2" style="margin-top: 10px;width: 60%;"><span style="background: #e2e3e3;width:100%" class="in" ></span></div>--%>
        <%--<div class="con3">0</div>--%>
        <%--</div>--%>
        <%--<div class="cont">--%>
        <%--<div class="con1" style="width: 18%;"><div class="nums">5</div><div class="rits" style=""></div></div>--%>
        <%--<div class="con2" style="margin-top: 10px;width: 60%;"><span style="background: #e2e3e3;width:100%" class="in" ></span></div>--%>
        <%--<div class="con3">0</div>--%>
        <%--</div>--%>
        <%--</div>--%>
    </div>
</div>


<div class="section">
    <p class="title">巡检统计</p>
    <div style="    height: 1915px;">
        <%--<iframe src="/street/polling" frameborder="0"></iframe>--%>
            <div class="nav clearfix">
                <ul class="navs">
                    <li data-id="1" class="active" style=" border-bottom-left-radius: 12px;border-top-left-radius: 12px;">今日</li>
                    <li data-id="2">本周</li>
                    <li data-id="3" style=" border-bottom-right-radius: 12px;border-top-right-radius: 12px;">本月</li>
                </ul>
            </div>
            <div class="content clearfix">
                <ul class="conter" dataId="1">
                    <%--<li>--%>
                    <%--<div class="left"><span class="shequ">石园北一社区</span></div>--%>
                    <%--<div class="right">--%>
                    <%--<div class="out">--%>
                    <%--<span class="in" style="width: 100%"></span>--%>
                    <%--</div>--%>
                    <%--<div class="box"><span class="font">142</span></div>--%>
                    <%--</div>--%>
                    <%--</li>--%>
                </ul>
            </div>
    </div>
</div>
<div class="section">
    <p class="title">统计</p>
    <div style="">
        <%--<iframe src="/street/excellentlistH5" frameborder="0"></iframe>--%>

        <div class="bottom" style="height: 5rem;overflow: hidden;font-size: 0.26666666666666666rem;">

        </div>
        <div class="display" style="display: none;width: 100%;height: 100%;">
            <div style="text-align: center;height: 100%;line-height: 100%"><img style="margin-top: 30%;width: 200px;height: 227px;" src="/img/noData.png" alt=""><p style="text-align: center;margin-top: 30px;font-size: 40px;">暂无数据</p></div>
        </div>
    </div>
</div>
<div class="section">
    <p class="title">环保事件统计</p>
    <div style="    height: 1250px;">
        <%--<iframe src="/street/eventH5" frameborder="0"></iframe>--%>

            <div class="main" style="width:100%;">
                <div class="tab">
                    <ul>
                        <li  data-type="1">今日</li>
                        <li data-type="2">本周</li>
                        <li class="select" style="border-right: none;" data-type="3">本月</li>
                    </ul>
                    <div id="containerOne" style=" width:80%;margin:80px auto 0px;padding-bottom:80px;border-bottom:2pt solid #ababab">

                    </div>
                    <div id="containerTwo" style="margin:80px auto 80px;">

                    </div>
                </div>
            </div>
    </div>
</div>




</body>
<script>

    var fs = document.documentElement.clientWidth / 750  * 100;
    document.querySelector("html").style.fontSize = fs + "px";

    $(function () {

        $.ajax({
            url: '/fixForm/selectTypeCount',
            type:'get',
            dataType:'json',
            success:function(res){
                var datas= res.data
                $('#zdyh').html(datas.typeCount4)
                $('#ybyh').html(datas.typeCount2)
                $('#tcyh').html(datas.typeCount3)
                $('#hgdb').html(datas.typeCount1)
                Highcharts.chart('container', {
                    chart: {
                        type: 'column'
                    },
                    xAxis: {
                        categories: [ '合格达标','一般隐患', '突出隐患','重大隐患'],
                        labels:{
                            enabled:false
                        }
                    },
                    yAxis: {
                        gridLineWidth: 0,
                        labels:{
                            enabled:false
                        },
                        title: {
                            text: ''                // y 轴标题
                        }
                    },

                    plotOptions: {
                        series: {
                            pointPadding: 0.35,
                            groupPadding: 0,
                            borderWidth: 0,
                            shadow: false,
                            events:{
                                click:function(e){
                                    var u = navigator.userAgent;
                                    var safe=""

                                    if (u.indexOf('Android') > -1 || u.indexOf('Linux') > -1) {//安卓手机
                                        window.Android.Safe(e.point.id)
                                    } else if (u.indexOf('iPhone') > -1) {//苹果手机
                                        safe=e.point.id
                                        window.Safe(safe)
                                    } else if (u.indexOf('Windows Phone') > -1) {//winphone手机
                                        safe=e.point.id
                                        window.Safe(safe)
                                    }

                                }
                            }
                        },
                        column: {
                            colorByPoint:true
                        },

                    },
                    tooltip: {
                        valueSuffix: ''
                    },
                    credits: {
                        enabled: false
                    },
                    legend: {
                        enabled: false
                    },
                    exporting: {
                        enabled: false
                    },
                    title: {
                        text:null,
                    },

                    series: [{
                        data: [{id:2,y:Number(datas.typeCount1),name:'合格达标'},{id:1,y:Number(datas.typeCount2),name:'一般隐患'},{id:4,y:Number(datas.typeCount3),name:'突出隐患'}, {id:3,y:Number(datas.typeCount4),name:'重大隐患'} ],
                        colors: [ '#50B432','#058DC7', '#DDDF00' ,'#ED561B']
                    }]
                });
            }
        })
    });

    $(function(){
        $('.conter').on('click','li',function(e){
            var time=$('.conter').attr('dataId');
            var id=$(this).attr('id');
            var u = navigator.userAgent;
            if (u.indexOf('Android') > -1 || u.indexOf('Linux') > -1) {//安卓手机
                window.Android.Xunjian(id,time)
            } else if (u.indexOf('iPhone') > -1) {//苹果手机
                window.Xunjian(time,id)
            } else if (u.indexOf('Windows Phone') > -1) {//winphone手机
                window.Xunjian(time,id)
            }


        })
    })


    popula(1);
    $('.nav li').click(function () {
        var timeType=$(this).attr('data-id');
        $('.nav li').removeClass('active');
        $(this).addClass('active');
        $('.conter').attr('dataId',timeType);
        popula($(this).attr('data-id'))
    })

    function popula(id) {
        $.ajax({
            url: '/gridCheck/getStatisticsArrt',
            type:'get',
            data:{
                timeType:id,
                paixu:1
            },
            dataType:'json',
            success:function(res){
                var ars=[];
                var str='';
                var arr=res.object.baseWrapper.datas;
                for(var i=0;i<arr.length;i++){
                    ars.push(arr[i].y)
                }
                var  max=Math.max.apply(null, ars) +20;

                for(var i=0;i<arr.length;i++){
                    str+='<li id="'+arr[i].id+'">' +
                        '<div class="left"><span class="shequ">'+arr[i].name+'</span></div>' +
                        '<div class="right">' +
                        '<div class="out">' +
                        '<span class="in" style="width:'+(arr[i].y/max)*100+'%"></span>' +
                        '</div>' +
                        '<div class="box"><span class="font">'+arr[i].y+'</span></div>' +
                        '</div>' +
                        '</li>'
                }
                $('.conter').html(str);




            }
        })
    }



    var area="";
    var successful="";

    function check(){

    }
    $('.tab li').click(function(){
        $(this).addClass('select').siblings().removeClass('select');
        var type=$(this).attr('data-type')
        four(type)
        four2(type)
    })
    function charLeft(data,time){
        Highcharts.chart('containerOne', {

            chart: {
                type: 'pie',
                backgroundColor: 'rgba(0,0,0,0)',
                fontSize:'30px',
                fontWeight:'normal'
            },
            title: {
                text: ''
            },
            exporting:{
                enabled:false
            },
            credits: {
                enabled:false
            },
            legend:{
                itemStyle:{ fontSize:'30px' ,fontWeight: 'normal'}
            },
            plotOptions: {
                pie:{
//                    size:80,
                    innerSize:'80',
                    allowPointSelect:true,
                    cursor:'pointer',
                    depth:35,
                    fontSize:'30px',
                    dataLabels:{
                        enabled:true,
                        format: '<span style="font-size:30px;font-weight: normal">{point.name}</span>: <span style="font-size:30px;font-weight: normal">{point.percentage:.1f} %</span>',
                        connectorWidth:1,
                        distance:5
                    },
                    showInLegend: true,
                    events:{
                        click: function(e) {
                            var u = navigator.userAgent;
                            if (u.indexOf('Android') > -1 || u.indexOf('Linux') > -1) {//安卓手机
                                if(e.point.options.name == '已完成'){
                                    window.Android.Shijian('ok',time,'top',1)
                                }else{
                                    window.Android.Shijian('ok',time,'top',2)
                                }
                            } else if (u.indexOf('iPhone') > -1) {//苹果手机
                                if(e.point.options.name == '已完成'){
                                    successful='1';
                                    area='top'
                                    window.Shijian('ok',time,area,successful)
                                }else{
                                    successful='2';
                                    area='top'
                                    window.Shijian('ok',time,area,successful)
                                }
                            } else if (u.indexOf('Windows Phone') > -1) {//winphone手机
                                if(e.point.options.name == '已完成'){
                                    window.Shijian('ok',time,'top',1)
                                }else{
                                    window.Shijian('ok',time,'top',2)
                                }
                            }


                        }
                    }
                }


            },
            tooltip: {
                headerFormat:
                    '<span style="font-size:30px;font-weight: normal">{point.name}</span><br>',
                pointFormat: '<span style="color:{point.color};font-size:20px;font-weight: normal">{point.name}</span>: <b style="font-size: 20px;font-weight: normal">{point.percentage:.1f}%</b><br/>'
            },
            series: [{
                name: '统计',
                type:'pie',
                colorByPoint: true,
                data:data,
                colors: ['#94d364', '#ffe2b5', '#00b3f1']
            }]
        });
    }
    function four(typeDate){
        $.ajax({
            url:'/gridEvent/tinCount',
            data:{timeType:typeDate},
            type:'get',
            dataType:'json',
            success:function(res){
                var obj=[['已完成',res.object.cston],['未完成',res.object.mnt]];

                if(res.object.cston==0 && res.object.mnt==0){
                    noDate('containerOne',typeDate)
                }else{
                    charLeft(obj,typeDate)
                }


            }
        })
    }
    four(3)

    function four2(typeDate){
        $.ajax({
            url:'/gridEvent/getStatisticsByGridEventType',
            data:{typeDate:typeDate,queryType:2},
            type:'get',
            dataType:'json',
            success:function(res){
                var data=res.datas;
                if(data[0].y==0 && data[1].y==0 && data[2].y==0 && data[3].y==0 && data[4].y==0){
                    noDate('containerTwo',typeDate)
                }else{
                    charRight(res.datas,typeDate)
                }

            }
        })
    }
    four2(3)

    function charRight(data,time){
        Highcharts.chart('containerTwo', {
            chart: {
                type: 'pie',
                backgroundColor: 'rgba(0,0,0,0)',
                fontWeight:'normal'
            },
            title: {
                text: ''
            },
            legend: {
                enabled:true
            },
            options3d:{
                enabled:true,
                alpha:45,
                beta:0
            },
            legend:{
                itemStyle:{ fontSize:'30px',fontWeight:'normal' }
            },
            exporting:{
                enabled:false
            },
            credits: {
                enabled:false
            },
            plotOptions: {
                pie:{
                    allowPointSelect:true,
                    cursor:'pointer',
                    depth:35,
                    fontSize:'30px',
                    dataLabels:{
                        enabled:true,
                        format: '<span style="font-size: 30px;font-weight: normal">{point.name}</span>: <span style="font-size:30px;font-weight: normal">{point.percentage:.1f} %</span>',
                        connectorWidth:1,
                        distance:5
                    },
                    showInLegend: true,
                    events:{
                        click: function(e) {
                            var type=e.point.options.id;
                            var u = navigator.userAgent;
                            area='bottom';
                            if (u.indexOf('Android') > -1 || u.indexOf('Linux') > -1) {//安卓手机

                                window.Android.Shijian('ok',time,area,type);
                            } else if (u.indexOf('iPhone') > -1) {//苹果手机
                                window.Shijian('ok',time,area,type);
                            } else if (u.indexOf('Windows Phone') > -1) {//winphone手机
                                window.Shijian('ok',time,area,type);
                            }

                        }
                    }
                }

            },
            tooltip: {
                headerFormat:
                    '<span style="font-size:30px;font-weight: normal">{point.name}</span><br>',
                pointFormat: '<span style="color:{point.color};font-size:20px;font-weight: normal">{point.name}</span>: <b style="font-size:20px">{point.percentage:.1f}%</b><br/>'
            },
            series: [{
                name: '统计',
                type:'pie',
                colorByPoint: true,
                data:data,
                colors: ['#0cc2ff', '#85dfdf', '#93d364','#f6b177','#ff88c4']
            }]
        });
    }
    function noDate(id,time){
        Highcharts.chart(id, {
            chart: {
                type: 'pie',
                backgroundColor: null,
                plotBackgroundColor: null,
                plotBorderWidth: null,
                plotShadow: false,
                borderWidth:null,
//                                spacing : [30, 0 , 0, 0],
            },
            title: {
                text: ''
            },
            legend: {
                enabled:true,
                align: "center", //程度标的目标地位
                verticalAlign: "bottom", //垂直标的目标地位
                itemStyle:{fontSize:'30px',fontWeight:'normal',width:'300px'}

            },
            exporting:{
                enabled:false
            },
            tooltip: {
                enabled:false
            },
            credits: {
                enabled:false
            },
            colors:[
                '#e1e1e1'//第一个颜色，欢迎加入Highcharts学习交流群294191384
            ],
//                tooltip: {
//                    headerFormat:
//                        '<span style="font-size:30px;font-weight: normal">{point.name}</span><br>',
//                    pointFormat: '<span style="color:{point.color};font-size:20px;font-weight: normal">{point.name}</span>: <b style="font-size:20px">{point.percentage:.1f}%</b><br/>'
//                },
            plotOptions: {
                pie:{
                    innerSize:'80',
                    depth:35,
                    name:'',
                    fontSize:'30px',
                    dataLabels:{
                        enabled:false,
//                        format: '<span style="font-size: 30px;font-weight: normal;margin-left: 30px;"></span><span style="font-size:30px;font-weight: normal">{point.percentage:.1f} %</span>',
                        connectorWidth:1,
                        distance:5
                    },
                    showInLegend:true,
                    events:{
                        click: function(e,time) {
                            var u = navigator.userAgent;
                            if (u.indexOf('Android') > -1 || u.indexOf('Linux') > -1) {//安卓手机
                                window.Android.Shijian('null',time,'','')
                            } else if (u.indexOf('iPhone') > -1) {//苹果手机
                                window.Shijian('null',time,'','')
                            } else if (u.indexOf('Windows Phone') > -1) {//winphone手机
                                window.Shijian('null',time,'','')
                            }

                        }
                    }
                }



            },
            series: [{
                type:'pie',
                data:[ {name:'暂无数据',y:1}]
            }]
        });
    }

    $('.top').click(function(){
        var u = navigator.userAgent;
        if (u.indexOf('Android') > -1 || u.indexOf('Linux') > -1) {//安卓手机
            window.Android.Jifen('ok')
        } else if (u.indexOf('iPhone') > -1) {//苹果手机
            window.Jifen('ok')
        } else if (u.indexOf('Windows Phone') > -1) {//winphone手机
            window.Jifen('ok')
        }

    })
    $(document).on('click','.bottom',function(){
        var u = navigator.userAgent;
        if (u.indexOf('Android') > -1 || u.indexOf('Linux') > -1) {//安卓手机
            window.Android.Jifen('ok')
        } else if (u.indexOf('iPhone') > -1) {//苹果手机
            window.Jifen('ok')
        } else if (u.indexOf('Windows Phone') > -1) {//winphone手机
            window.Jifen('ok')
        }
    })

    var d=new Date();
    nowYear=d.getFullYear();
    $.ajax({
        url: '/integralManger/getDataByType',
        type: 'get',
        data: {
            paixu:1,
            type:'year',
            timeType:nowYear
        },
        dataType: 'json',
        success: function (res) {
            var reg = res.data;
            var str = '';
            var num = reg[0].scoreTotal + 30
            for (var i = 0; i < reg.length; i++) {
                if(i==0){
                    $('#nam2').html(reg[i].partyBranchName);
                    $('#num2').html(reg[i].scoreTotal+'分');
                }else if(i==1){
                    $('#nam1').html(reg[i].partyBranchName);
                    $('#num1').html(reg[i].scoreTotal+'分');
                }
                else if(i==2){
                    $('#nam3').html(reg[i].partyBranchName);
                    $('#num3').html(reg[i].scoreTotal+'分');
                } else if(i==3){
                    str+='<div class="cont">' +
                        '<div class="con1"><div class="nums">'+(i+1)+'</div><div class="rits" style="'+function () {
                            if(reg[i].partyBranchName.length>10){
                                return 'line-height: 1px;padding-top: 1px;'
                            }else {
                                return ''
                            }
                        }()+'">'+reg[i].partyBranchName+'</div></div>' +
                        '<div class="con2"><span class="in" style="width: '+(reg[i].scoreTotal/num)*100+'%"></span></div>' +
                        '<div class="con3">'+reg[i].scoreTotal+'</div>' +
                        '</div>'
                }else if(i==4){
                    str+='<div class="cont">' +
                        '<div class="con1"><div class="nums">'+(i+1)+'</div><div class="rits" style="'+function () {
                            if(reg[i].partyBranchName.length>10){
                                return 'line-height: 1px;padding-top: 1px;'
                            }else {
                                return ''
                            }
                        }()+'">'+reg[i].partyBranchName+'</div></div>' +
                        '<div class="con2"><span class="in" style="width: '+(reg[i].scoreTotal/num)*100+'%"></span></div>' +
                        '<div class="con3">'+reg[i].scoreTotal+'</div>' +
                        '</div>'
                }
            }
            $('.bottom').html(str);
        }
    })

    var d=new Date();
    nowYear=d.getFullYear()
    $.ajax({
        url: '/integralManger/getDataByType',
        type: 'get',
        data: {
            paixu:1,
            type:'year',
            timeType:nowYear
        },
        dataType: 'json',
        success: function (res) {
            var reg=res.data;
            if(reg==""||reg==null){
                $('.display').show()
            }else{
                $('.display').hide()
                var str='';
                var num=reg[0].scoreTotal+30
//                alert(reg[0].partyBranchName.length)
                for(var i=0;i<reg.length;i++){
                    str+='<div class="cont">' +
                        '<div class="con1"><div class="nums" style="'+function () {
                            if(i==0){
                                return 'color:#d83250;'
                            } else if(i==1){
                                return 'color:#2d79bf;'
                            }else if(i==2){
                                return 'color:#23a490;'
                            } else {
                                return ''
                            }
                        }()+'">'+(i+1)+'</div><div class="rits" style="'+function () {
                            if(reg[i].partyBranchName.length>10){
                                return 'line-height: 170px;padding-top: 0px;'
                            }else {
                                return ''
                            }
                        }()+'">'+reg[i].partyBranchName+'</div></div>' +
                        '<div class="con2"><span class="in" style="width: '+(reg[i].scoreTotal/num)*100+'%"></span></div>' +
                        '<div class="con3">'+reg[i].scoreTotal+'</div>' +
                        '</div>'
                }
                $('.bottom').html(str);
            }

        }
    })
</script>
</html>

