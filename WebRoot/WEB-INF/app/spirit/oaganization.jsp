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
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width,initial-scale=1,minimum-scale=1,maximum-scale=1,user-scalable=no" />
    <title>组织</title>
    <link rel="stylesheet" type="text/css" href="../css/spirit/oaStyle.css"/>
    <link rel="stylesheet" type="text/css" href="../css/spirit/oaganization.css"/>
    <script src="../js/xoajq/xoajq1.js" type="text/javascript" charset="utf-8"></script>
</head>
<script type="text/javascript">
    $(function () {
        if(window.external && typeof window.external.OA_SMS != 'undefined') //如果从OA精灵打开，则最大化窗口
        {
            var h = Math.min(800, screen.availHeight - 180),
                w = Math.min(1280, screen.availWidth - 180);
            window.external.OA_SMS(w, h, "SET_SIZE");
        }
        $('.ulTwo>li').click(function () {
            //$(this).find('.ulThree').slideToggle();
            if ($(this).find('.ulThree').css('display')=='block') {
                $(this).removeClass('slideDown').addClass('slideUp');
                $(this).find('.ulThree').slideUp();
            }else{
                $(this).removeClass('slideUp').addClass('slideDown');
                $(this).find('.ulThree').slideDown();
            }
        })
    })
</script>
<body>
<div class="content">
    <div class="nav">
        <ul>
            <li><span class="spanTxt">全部</span></li>
            <li>分组</li>
            <li>最近</li>
            <li>群组</li>
            <li><img src="../img/spirit/refesh.png"/></li>
        </ul>
    </div>
    <div class="mainCont">
        <ul class="ulOne">
            <li>
                <span><img src="/img/commonTheme/${sessionScope.InterfaceModel}/icon_company.png"/></span>
                <span class="spanFirst"><fmt:message code="label.replace.name" /></span>
            </li>
            <li>
                <ul class="ulTwo">
                    <li class="slideUp"><img src="../img/spirit/icon_department.png"/><span>管理部</span>
                        <ul class="ulThree" style="display: none;">
                            <li><img src="../img/spirit/icon_man.png"/><span>云云</span></li>
                            <li><img src="../img/spirit/icon_woman.png"/><span>李云</span></li>
                        </ul>
                    </li>
                </ul>
            </li>
            <li>
                <ul class="ulTwo">
                    <li class="slideUp"><img src="../img/spirit/icon_department.png"/><span>技术研究院</span>
                        <ul class="ulThree" style="display: none;">
                            <li><img src="../img/spirit/icon_man.png"/><span>王云</span></li>
                            <li><img src="../img/spirit/icon_woman.png"/><span>马云</span></li>
                            <li><img src="../img/spirit/icon_man.png"/><span>云云</span></li>
                        </ul>
                    </li>
                </ul>
            </li>
            <li>
                <ul class="ulTwo">
                    <li class="slideUp"><img src="../img/spirit/icon_department.png"/><span>研发部</span></li>
                </ul>
            </li>
            <li>
                <ul class="ulTwo">
                    <li class="slideUp"><img src="../img/spirit/icon_department.png"/><span>市场部</span></li>
                </ul>
            </li>
        </ul>
    </div>
</div>
</body>
<script>
    if(window.external && typeof window.external.OA_SMS != 'undefined') //如果从OA精灵打开，则最大化窗口
    {
        var h = Math.min(800, screen.availHeight - 180),
            w = Math.min(1280, screen.availWidth - 180);
        window.external.OA_SMS(w, h, "SET_SIZE");
    }
</script>
</html>


