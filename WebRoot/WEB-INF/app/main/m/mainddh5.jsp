<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@taglib prefix="mvc" uri="http://www.springframework.org/tags/form" %>
<%@taglib prefix="fmt" uri="http://www.springframework.org/tags" %>
<!DOCTYPE html>
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width,initial-scale=1,minimum-scale=1,maximum-scale=1,user-scalable=no" />
    <title></title>
    <script type="text/javascript" src="../../js/jquery/jquery.min.js"></script>
    <link href="../../css/H5/default.css" rel="stylesheet"/>
    <style>

        header {
            height: 0.85rem;
            align-items: center;
            font-size: 0.28rem;
            color: #fff;
            padding-left: 0.23rem;
            padding-right: 0.23rem;
            text-align: center;
            line-height: 0.85rem;
            position: fixed;
            width: 100%;
            z-index: 1;
            background-color: #3984ff;
            box-shadow: 1px 1px 7px rgba(0, 0, 0, .85);
        }
        .nav{
            font-size: 0.28rem;
            color: #fff;
            line-height: 0.8rem;
            padding-left: 0.5rem;
            position: relative;
            background-color: #2b7fe0;
            bottom: 5px;
            border-radius: 5px 5px 0px 0px;
            box-shadow: 1px 1px 7px rgba(141, 152, 156, 0.85);
        }
        .chunk{
            width: 4px;
            height: 13px;
            background:#7caeff;
            display: inline-block;
            position: relative;
            top: 2px;
            right: 9px;
        }
        .usernav {
            font-size: 0.24rem;
            height: 2rem;
            display: flex;
            align-items: center;
            background-color: #fff;
            text-align: center;
        }
        .usernav img{
            width: 0.9rem;
            height: 0.9rem;
            margin:0 auto;
        }
        .usernav div{
            padding-top: 0.15rem;
            color: #666;
        }
        input{
            width: 88%;
            border:1px solid #ccc;
            padding-left: .05rem;
            height: .5rem;
            margin: .1rem 0;
            border-radius: 3px;

        }
        .hd{
            height: 0.85rem;
        }
        .usernav a{
            width: 25%;
            position: relative;
        }

        /*.nav:after {*/
            /*position: absolute;*/
            /*top: 37px;*/
            /*right: 0;*/
            /*left: 0;*/
            /*height: 1px;*/
            /*content: '';*/
            /*-webkit-transform: scaleY(.5);*/
            /*transform: scaleY(.5);*/
            /*background-color: #1e64d6;;*/
        /*}*/
        .sub-nav{
            box-shadow: 1px 1px 7px rgba(206, 194, 194, 0.85);
            border-radius: .1rem;
            background-color: #fff;
            margin: .25rem .2rem;
            padding: .1rem 0;
        }
        body{
            background: #bdd0d3;
        }

    </style>
    <script type="text/javascript">
        var fs = document.documentElement.clientWidth / 750  * 100;
        document.querySelector("html").style.fontSize = fs + "px";
    </script>
</head>
<body>
<header>
    <%--<i><a href="" style="color: #fff">返回</a></i>--%>
    <span id="tit"></span>
    <%--<i ></i>--%>
</header>
<div class="hd"></div>
<div class="mui-content">
    <div class="sub-nav">
        <p class="nav"><span class="chunk"></span>个人事务</p>
        <div>
            <section class="usernav">
                <a href="/email/emailh5">
                    <img src="../../img/H5/1.1.png"/>
                    <div>电子邮件</div>
                </a>
                <a href="/notice/noticeh5">
                    <img src="../../img/H5/1.2.png"/>
                    <div>公告通知</div>
                </a>
                <a href="/news/newsh5">
                    <img src="../../img/H5/1.3.png"/>
                    <div>新闻</div>
                </a>
                <a href="/calender/calendarh5">
                    <img src="../../img/H5/1.4.png"/>
                    <div>日程安排</div>
                </a>
            </section>
            <section class="usernav">
                <%--<a href="">--%>
                    <%--<img src="../../img/H5/1.5.png"/>--%>
                    <%--<div>事务提醒</div>--%>
                <%--</a>--%>
                <a href="/attendPage/attendIndexh5">
                    <img src="../../img/H5/1.6.png"/>
                    <div>个人考勤</div>
                </a>
                <a href="/diary/diaryIndexh5">
                    <img src="../../img/H5/1.7.png"/>
                    <div>工作日志</div>
                </a>
                <%--<a href="">--%>
                    <%--<img src="../../img/H5/1.8.png"/>--%>
                    <%--<div>工作计划</div>--%>
                <%--</a>--%>
                <a href="/file/fileIndexh5">
                    <img src="../../img/H5/1.10.png"/>
                    <div>个人文件柜</div>
                </a>
            </section>
            <%--<section class="usernav">--%>
                <%--<a href="">--%>
                    <%--<img src="../../img/H5/1.9.png"/>--%>
                    <%--<div>通讯簿</div>--%>
                <%--</a>--%>
                <%--<a href="/file/fileIndexh5">--%>
                    <%--<img src="../../img/H5/1.10.png"/>--%>
                    <%--<div>个人文件柜</div>--%>
                <%--</a>--%>
            <%--</section>--%>
        </div>
    </div>
    <div class="sub-nav">
        <p class="nav"><span class="chunk"></span>公文管理</p>
        <div>
            <section class="usernav">
                <%--<a href="/document/getDispah5">--%>
                    <%--<img src="../../img/H5/3.1.png"/>--%>
                    <%--<div>发文管理</div>--%>
                <%--</a>--%>
                <a href="/document/getReceiptMenth5">
                    <img src="../../img/H5/3.2.png"/>
                    <div>收文管理</div>
                </a>
                <a href="/document/getSuperiorh5">
                    <img src="../../img/H5/4.2.png"/>
                    <div>上级来文</div>
                </a>
                <a href="/document/getDocumentInquiries">
                    <img src="../../img/H5/5.4.png"/>
                    <div>公文查询</div>
                </a>
            </section>
        </div>
    </div>
    <div class="sub-nav">
        <p class="nav"><span class="chunk"></span>工作流</p>
        <div>
            <section class="usernav">
                <a href="/workflow/work/workflowIndexh5">
                    <img src="../../img/H5/2.1.png"/>
                    <div>工作流</div>
                </a>
            </section>
        </div>
    </div>
    <%--<div class="sub-nav">--%>
        <%--<p class="nav"><span class="chunk"></span>知识管理</p>--%>
        <%--<div>--%>
            <%--<section class="usernav">--%>
                <%--<a href="">--%>
                    <%--<img src="../../img/H5/3.1.png"/>--%>
                    <%--<div>公共文件柜</div>--%>
                <%--</a>--%>
                <%--<a href="">--%>
                    <%--<img src="../../img/H5/3.2.png"/>--%>
                    <%--<div>网络硬盘</div>--%>
                <%--</a>--%>
            <%--</section>--%>
        <%--</div>--%>
    <%--</div>--%>
    <%--<p class="nav"><span class="chunk"></span>资源管理</p>--%>
    <%--<div>--%>
        <%--<section class="usernav">--%>
            <%--<a href="">--%>
                <%--<img src="../../img/H5/4.1.png"/>--%>
                <%--<div>我的会议</div>--%>
            <%--</a>--%>
            <%--<a href="">--%>
                <%--<img src="../../img/H5/4.2.png"/>--%>
                <%--<div>会议申请</div>--%>
            <%--</a>--%>
        <%--</section>--%>
    <%--</div>--%>
    <%--<p class="nav"><span class="chunk"></span>资源管理</p>--%>
    <%--<div>--%>
        <%--<section class="usernav">--%>
            <%--<a href="">--%>
                <%--<img src="../../img/H5/5.1.png"/>--%>
                <%--<div>待办发文</div>--%>
            <%--</a>--%>
            <%--<a href="">--%>
                <%--<img src="../../img/H5/5.2.png"/>--%>
                <%--<div>已办发文</div>--%>
            <%--</a>--%>
            <%--<a href="">--%>
                <%--<img src="../../img/H5/5.3.png"/>--%>
                <%--<div>待办收文</div>--%>
            <%--</a>--%>
            <%--<a href="">--%>
                <%--<img src="../../img/H5/5.4.png"/>--%>
                <%--<div>已办收文</div>--%>
            <%--</a>--%>
        <%--</section>--%>
    <%--</div>--%>
</div>


<script>
$(function(){
    $.ajax({
        url:'/sys/getInterfaceInfo',
        data:'',
        type: "get",
        success:function(res){
            if(res.flag){
                $('#tit').text(res.object.title);

                $('title').text(res.object.ieTitle)
            }
        }
    })
})
</script>
</body>
</html>