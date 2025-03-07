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
    <title>综合门户</title>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">

    <link rel="stylesheet" type="text/css" href="/lib/layui/layui/css/layui.css?20210319.1"/>

    <script type="text/javascript" src="/js/xoajq/xoajq1.js"></script>
    <script type="text/javascript" src="/js/base/base.js"></script>
    <script type="text/javascript" src="/lib/layui/layui/layui.js"></script>
    <script type="text/javascript" src="/lib/layui/layui/layui.all.js"></script>
    <script type="text/javascript" src="/js/echarts.min.js"></script>
    <script type="text/javascript" src="/js/xoajq/xoajq2.js"></script>
    <script type="text/javascript" src="/js/calendar.js"></script>
    <style>
        * {
            margin: 0;
            padding: 0
        }
        body{
            background-color: #f8f8f8;
            font-family: "Microsoft YaHei","Arial",simsun, sans-serif;
        }
        a {
            text-decoration: none;
        }
        .w{
            width: 1200px;
            margin: 0 auto;
        }
        .top {
            padding: 20px;
            /*height: 130px;*/
            /*line-height: 90px;*/
            box-sizing: border-box;
        }
        .top span {
            font-size: 35px;
            font-weight: bold;
            margin-left: 20px;
        }
        .left{
            float: left;
        }
        .right{
            float: right;
        }
        .nav {
            background-color: rgba(211,11,21, 0.9);
            height: 70px;
        }

        .navbox{
            height: 70px;
        }

        .nav ul li a{
            line-height: 70px;
            float: left;
            font-size: 22px;
            color: #fff;
            width: 140px;
            text-align: center;
            letter-spacing: 3px;
            cursor: pointer;
            list-style: none;
            text-overflow: ellipsis;
            white-space: nowrap;
            overflow: hidden;
        }
        .navbox li a:hover {
            background-color: #e82622;
            display: block;
        }
        .nav .w .navbox .focus{
            background-color: #e82622;
        }
        .cont1{
            margin: 15px 0;
            height: 330px;
        }
        .conlt, .conrt{
            width: 590px;
            height: 330px;
            background-color: #fff;
        }
        .conrt {
            border: 1px solid #cccccc;
            box-sizing: border-box;
            padding: 10px;
        }
        .ct {
            border-bottom: 1px solid #d0d0d0;
        }

        .ct div {
            padding: 10px;
            margin: 0 10px;
        }

        .ct a {
            color: #000;
        }

        .ctactive{
            color: #d30b15;
            border-bottom: 3px solid #d30b15;
        }

        .ct{
            font-size: 19px;
            height: 47px;
        }

        .cb {
            padding: 10px;
            margin-top: 5px;
        }

        .cbs{
            padding: 10px;
        }

        .cbs div {
            width: 400px;
            text-overflow: ellipsis;
            white-space: nowrap;
            overflow: hidden;
            margin-right: 30px;
        }

        .cb li span {
            position: absolute;
        }
        .more {
            float: right;
            font-size: 14px;
            cursor: pointer;
        }
        #test1{
            width: 590px !important;
            height: 330px !important;
        }
        .bottom{
            margin-top: 20px;
            background-color: #333333;
            height: 270px;
            border: 1px solid #333333;
        }
        .botbox{
            box-sizing: border-box;
            padding: 30px;
            margin-top: 30px;
            margin-left: 100px;
        }
        .botf{
            background-image: url('/img/menu/airplaneFast.png');
            background-size: cover;
            width: 154px;
            height: 152px;
        }

        .bort{
            color: #fff;
        }

        .bort div{
            margin: 20px;
            letter-spacing: 2px;
            margin-left: 80px;
        }
    </style>

</head>
<body>
<div class="container">
    <!-- 头部 -->
    <div class="w">
        <div class="top">
            <div class="left" style="height:78px;">
                <img src="/img/attend/wcyy.png">
            </div>
            <span class="head_title">电建生态公司综合管理系统</span>
        </div><!--top-->
    </div><!-- w -->

    <%--导航--%>
    <div class="nav">
        <div class="w">
            <ul class="navbox">
                <li class="focus"><a class="node">首页</a></li>
                <li class="focus"><a class="node">新闻通知</a></li>
                <li class="focus"><a class="node">部门动态</a></li>
                <li class="focus"><a class="node">法制建设</a></li>
                <li class="focus"><a class="node">科学与标准</a></li>
                <li class="focus"><a class="node">相关下载</a></li>
                <li class="focus"><a class="node">子系统</a></li>
            </ul>
        </div>
    </div>
    <%--内容--%>
    <div class="w" style="min-height: 675px;">
        <div class="cont1 contFirst">
            <div class="conlt left" >
                <div class="swiper-wrapper">
                    <div class="layui-carousel" id="test1" lay-filter="test1">
                        <div carousel-item="">
                            <div><img src="/img/menu/dian.png" alt="" style="height:100%;width: 100%"></div>
                            <div><img src="/img/menu/dians.png" alt="" style="height:100%;"></div>
                            <div><img src="/img/menu/company.jpg" alt="" style="height:100%;width: 100%"></div>
                        </div>
                    </div>
                </div>
            </div>
            <%--右边部分--%>
            <div class="conrt right" style="float: right">
                <div class="ct">
                    <div class="ctactive left">
                        <a href="javascript:;">
                            <span class="a">最新新闻</span>
                            <span class="b">111</span>
                        </a>
                    </div>
                    <div class="more">
                        <a href="javascript:;">更多></a>
                    </div>
                </div>
                <div class="cb">
                    <div class="cbs">
                        <div class="left">
                            <a href="javascript:;">全国土壤污染防治部际协调小组会议召开</a>
                        </div>
                        <span>2019-06-20</span>
                    </div>
                    <div class="cbs">
                        <div class="left">
                            <a href="javascript:;">全国土壤污染防治部际协调小组会议召开</a>
                        </div>
                        <span>2019-06-20</span>
                    </div>
                </div>
            </div>
        </div>
        <div class="cont1">
            <div class="conrt left">
                <div class="ct">
                    <div class="ctactive left">
                        <a href="javascript:;">
                            <span class="a">人文滨海</span>
                            <span class="b"></span>
                        </a>
                    </div>
                    <div class="more">
                        <a href="javascript:;">更多></a>
                    </div>
                </div>
                <div class="cb">
                    <div class="cbs">
                        <div class="left">
                            <a href="javascript:;">全国土壤污染防治部际协调小组会议召开</a>
                        </div>
                        <span>2019-06-20</span>
                    </div>
                </div>
            </div>
            <div class="conrt right">
                <div class="ct">
                    <div class="ctactive left">
                        <a href="javascript:;">
                            <span class="a">最新新闻</span>
                            <span class="b">111</span>
                        </a>
                    </div>
                    <div class="more">
                        <a href="javascript:;">更多></a>
                    </div>
                </div>
                <div class="cb">
                    <div class="cbs">
                        <div class="left">
                            <a href="javascript:;">全国土壤污染防治部际协调小组会议召开</a>
                        </div>
                        <span>2019-06-20</span>
                    </div>
                    <div class="cbs">
                        <div class="left">
                            <a href="javascript:;">全国土壤污染防治部际协调小组会议召开</a>
                        </div>
                        <span>2019-06-20</span>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <%--底部--%>
    <div class="bottom">
        <div class="w">
            <div class="botbox">
                <div class="botf left"></div>
                <div class="bort left">
                    <div>滨海省人民政府 主办 滨海市人民政府办公室承办 滨海市政府办公室负责日常管理与维护</div>
                    <div>邮编：888888 联系电话：0310-88888888 邮箱：88888888@888.com</div>
                    <div>版权所有 ICP备案/许可证编号为：京ICP备66666666号</div>
                </div>
            </div>
        </div>
    </div>
</div>

<script>
    layui.use(['carousel', 'form'], function() {
        var carousel = layui.carousel
            , form = layui.form;

        //常规轮播
        carousel.render({
            elem: '#test1'
            , arrow: 'always'
        });

        //改变下时间间隔、动画类型、高度
        carousel.render({
            elem: '#test2'
            , interval: 1800
            , anim: 'fade'
            , height: '120px'
        });

        //设定各种参数
        var ins3 = carousel.render({
            elem: '#test3'
        });
        //图片轮播
        carousel.render({
            elem: '#test10'
            , width: '778px'
            , height: '440px'
            , interval: 5000
        });

        //事件
        carousel.on('change(test4)', function (res) {
            console.log(res)
        });

        var $ = layui.$, active = {
            set: function (othis) {
                var THIS = 'layui-bg-normal'
                    , key = othis.data('key')
                    , options = {};

                othis.css('background-color', '#5FB878').siblings().removeAttr('style');
                options[key] = othis.data('value');
                ins3.reload(options);
            }
        };

        //监听开关
        form.on('switch(autoplay)', function () {
            ins3.reload({
                autoplay: this.checked
            });
        });

        $('.demoSet').on('keyup', function () {
            var value = this.value
                , options = {};
            if (!/^\d+$/.test(value)) return;

            options[this.name] = value;
            ins3.reload(options);
        })
    })
</script>

</body>
</html>
