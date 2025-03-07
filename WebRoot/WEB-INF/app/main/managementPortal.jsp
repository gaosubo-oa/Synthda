<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@taglib prefix="mvc" uri="http://www.springframework.org/tags/form" %>
<%@taglib prefix="fmt" uri="http://www.springframework.org/tags" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title><fmt:message code="sys.th.fede" /></title>
    <%--<fmt:message code="global.page.first" />--%>
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta http-equiv="Content-Type" content="text/html;">
    <meta name="viewport"
          content="width=device-width, initial-scale=0.3, user-scalable=0, minimum-scale=0, maximum-scale=5.0,user-scalable=yes">
    <meta name="apple-mobile-web-app-capable" content="yes">
    <meta name="apple-mobile-web-app-status-bar-style" content="black">

    <%--<link rel="stylesheet" type="text/css" href="css/main/${sessionScope.InterfaceModel}/bootstrap-responsive.min.css"/>--%>
    <link rel="stylesheet" type="text/css" href="/css/main/theme1/managementPortal.css" />
    <link rel="stylesheet" type="text/css" href="/css/main/${sessionScope.InterfaceModel}/cont.css"/>
    <%--${sessionScope.InterfaceModel}--%>
    <script src="/js/xoajq/xoajq3.js" type="text/javascript" charset="utf-8"></script>
    <script src="/js/jquery/jquery-migrate-3.4.0.js" type="text/javascript" charset="utf-8"></script>
    <script src="/js/jquery/jquery.cookie.js"></script>
    <script type="text/javascript" src="/lib/highcharts.js"></script>
    <script type="text/javascript" src="/js/jqmeter.min.js"></script>

    <script src="/lib/layer/layer.js?20201106"></script>
    <script src="/js/base/base.js"></script>
    <style type="text/css">
        body{
            overflow-y: auto;
            font-size: 9pt;
        }
        .outer-therm {
            margin: 10px 0 !important;
        }
        text [x="5"]{
            font-size: 9pt;
        }
        text [x="21"]{
            font-size: 9pt;
        }
        svg.highcharts-root{
            font-size: 9pt;
        }
        .outLi{
            display: none;
        }
    </style>
    <script>

    </script>
</head>
<body>
<div class="content">
    <div class="mainCon">
        <ul class="outUl">
            <%--公司考勤--%>
            <li class="outLi" id="01">
                <span class="lineTop"></span>
                <div class="titleLi">
                    <img src="/img/main_img/${sessionScope.InterfaceModel}/managementPortal/manageportal_icon_wa.png" alt="">
                    <span class="textLi"><fmt:message code="attend.th.Attendance" /></span>
                </div>

                <div class="title_s_can">
                    <div class="div_canvas">
                        <canvas id="yuan"></canvas>
                    </div>
                    <div class="div_prog">
                        <ul id="shou">
                            <li>
                                <span><fmt:message code="attendance.th.normal" /></span><span class="normal"></span>
                                <div id="prog1"></div>
                            </li>
                            <li>
                                <span><fmt:message code="doc.th.NoSignIn" /></span><span class="weiqiandao"></span>
                                <div id="prog2"></div>
                            </li>
                            <li>
                                <span><fmt:message code="doc.th.Late" /></span><span class="chidao"></span>
                                <div id="prog3"></div>
                            </li>
                            <li>
                                <span><fmt:message code="attend.th.leave" /></span><span class="qingjia"></span>
                                <div id="prog4"></div>
                            </li>
                        </ul>
                    </div>
                </div>

            </li>
                <%--新入职员工--%>
            <li class="outLi" id="09">
                <span class="lineTop"></span>
                <div class="titleLi">
                    <img src="/img/main_img/${sessionScope.InterfaceModel}/managementPortal/manageportal_icon_newemployee.png" alt="">
                    <span class="textLi"><fmt:message code="sys.th.comer" /></span>
                    <span class="moreData moreXinruzhi" style="display: block;"><fmt:message code="email.th.more" /></span>
                </div>
                <div class="insideDiv">
                    <ul id="xinruzhi">

                    </ul>
                </div>
            </li>
                <%--员工统计--%>
            <li class="outLi" id="06">
                <span class="lineTop"></span>
                <div class="titleLi">
                    <img src="/img/main_img/${sessionScope.InterfaceModel}/managementPortal/manageportal_icon_es.png" alt="">
                    <span class="textLi"><fmt:message code="sys.th.comertj" /></span>
                    <ul class="insideUl">
                        <li class="age liActive"><fmt:message code="hr.th.Age" /></li>
                        <li class="sex"><fmt:message code="userDetails.th.Gender" /></li>
                        <li class="education"><fmt:message code="hr.th.Education" /></li>
                        <li class="workingLife"><fmt:message code="sys.th.years" /></li>
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
            </li>
                <%--合同到期员工--%>
            <li class="outLi" id="08">
                <span class="lineTop"></span>
                <div class="titleLi">
                    <img src="/img/main_img/${sessionScope.InterfaceModel}/managementPortal/manageportal_icon_eocs.png" alt="">
                    <span class="textLi"><fmt:message code="sys.th.yuna" /></span>
                    <span class="moreData moreDaoqi" style="display: none;"><fmt:message code="email.th.more" /></span>
                </div>
                <div class="insideDiv">
                    <ul id="hetongUl">

                    </ul>
                </div>
            </li>
                <%--员工合同统计--%>
            <li class="outLi" id="07">
                <span class="lineTop"></span>
                <div class="titleLi">
                    <img src="/img/main_img/${sessionScope.InterfaceModel}/managementPortal/manageportal_icon_ecs.png" alt="">
                    <span class="textLi"><fmt:message code="sys.th.heto" /></span>
                </div>
                <div id="containerHetong" style="min-width: 350px;height:260px;"></div>
            </li>
                <%--公告发布数统计--%>
            <li class="outLi" id="03">
                <span class="lineTop"></span>
                <div class="titleLi">
                    <img src="/img/main_img/${sessionScope.InterfaceModel}/managementPortal/manageportal_icon_ods.png" alt="">
                    <span class="textLi"><fmt:message code="sys.th.pub" /></span>
                </div>
                <div id="container" style="min-width: 350px;height:260px;"></div>
            </li>
                <%--工作流统计--%>
            <li class="outLi" id="05">
                <span class="lineTop"></span>
                <div class="titleLi">
                    <img src="/img/main_img/${sessionScope.InterfaceModel}/managementPortal/manageportal_icon_wfs.png" alt="">
                    <span class="textLi"><fmt:message code="sys.th.work" /></span>
                </div>
                <div id="containerFlow" style="min-width: 350px;height:260px;"></div>
            </li>
                <%--新闻发布数统计--%>
            <li class="outLi" id="04">
                <span class="lineTop"></span>
                <div class="titleLi">
                    <img src="/img/main_img/${sessionScope.InterfaceModel}/managementPortal/manageportal_icon_ns.png" alt="">
                    <span class="textLi"><fmt:message code="sys.th.new" /></span>
                </div>
                <div id="containerNews" style="min-width: 350px;height:260px;"></div>
            </li>
                <%--员工请假统计--%>
            <li class="outLi" id="02">
                <span class="lineTop"></span>
                <div class="titleLi">
                    <img src="/img/main_img/${sessionScope.InterfaceModel}/managementPortal/manageportal_icon_vs.png" alt="">
                    <span class="textLi"><fmt:message code="sys.th.job" /></span>
                </div>
                <div id="containerQingjia" style="min-width: 350px;height:260px;"></div>
            </li>
        </ul>
    </div>
</div>
<script src="/js/main_js/managementPortal.js"></script>
<script>
    $.ajax({
        url:'/portals/selPortalsById?portalsId=3',
        dataType:'json',
        type:'get',
        success:function(res){
            var data = res.object.portalsManage.split(',');
            for(var i=0;i<data.length;i++){
                if(data[i]!=""){
                //     console.log($('#'+data[i]))
                    $('.outUl').find('#'+data[i]).show().appendTo('.outUl')
                }

                // $('.outLi[id="'+data[i]+'"]').css('display','block')
            }
        }
    })
</script>
</body>
</html>
