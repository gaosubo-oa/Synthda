<%--
  Created by IntelliJ IDEA.
  User: gaosubo
  Date: 2017/8/11
  Time: 11:36
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="mvc" uri="http://www.springframework.org/tags/form" %>
<%@taglib prefix="fmt" uri="http://www.springframework.org/tags" %>
<html>
<meta name="viewport" content="width=device-width, initial-scale=0.3, user-scalable=0, minimum-scale=0, maximum-scale=5.0,user-scalable=yes">
<script type="text/javascript" src="../../js/xoajq/xoajq1.js"></script>
<script src="../../js/news/page.js"></script>
<script src="../../lib/laydate/laydate.js"></script>
<script src="/js/base/base.js" type="text/javascript" charset="utf-8"></script>
<script src="../../lib/pagination/js/jquery.pagination.min.js" type="text/javascript" charset="utf-8"></script>
<script src="/lib/ueditor/ueditor.config.js" type="text/javascript" charset="utf-8"></script>
<script src="/lib/ueditor/ueditor.all.js" type="text/javascript" charset="utf-8"></script>
<script src="/lib/laydate/laydate.js"></script>

<title><fmt:message code="three.th.ThreeSettings"/></title>
<link rel="stylesheet" href="/css/dept/roleAuthorization.css?20210311.1">
<script type="text/javascript" src="/js/jquery/jquery.min.js"></script>
<script type="text/javascript" src="/lib/layer/layer.js?20201106"></script>
<script type="text/javascript" src="/js/base/base.js"></script>
<style>
    .headDiv {

        background: #f5f5f5;
        width: 100%;
        height: 45px;
        border-bottom: #999 1px solid;
        overflow: hidden;
    }

    .div_Img {
        float: left;
        width: 23px;
        height: 100%;
        margin-left: 30px;
    }

    .div_Img img {
        width: 23px;
        height: 23px;
        margin-top: 11px;
    }

    .divP {
        float: left;
        height: 45px;
        line-height: 45px;
        font-size: 22px;
        margin-left: 10px;
        color: #494d59;
    }

    .th{
        font-size: 11pt;
    }

</style>
<head>
    <title>Title</title>
</head>
<body>
<div class="headDiv">
    <div class="div_Img">
        <img src="/img/commonTheme/${sessionScope.InterfaceModel}/key_03.png" style="vertical-align: middle;" alt="<fmt:message code="roleAuthoorization.th.EnterSuperPassword"/>">
    </div>
    <div class="divP"><fmt:message code="roleAuthoorization.th.EnterSuperPassword"/></div>
</div>
<div id="loginAdmin" style="    margin-top: 30px;">
    <input name="yc" id="yc" value="${sign}" type="hidden"/>
    <%--<div class="navigation  clearfix" style="margin-top:0;">--%>
    <%--<div class="left">--%>
    <%--<img src="../img/key_03.png" alt="">--%>
    <%--<div class="news"><fmt:message code="roleAuthoorization.th.EnterSuperPassword" /></div>--%>
    <%--</div>--%>
    <%--</div>--%>

    <table class="tr_td" width="50%" align="center">
        <tbody>
        <tr>
            <td class="th" colspan="2">
                <b><fmt:message code="roleAuthorization.th.Explain"/>：</b>
                <%--<fmt:message code="roleAuthorization.th.superPassword"/>--%>
                <fmt:message code="sys.th.superPassword" />
            </td>
        </tr>
        <tr>
            <td class="TableContent" style="width: 25%">
                <fmt:message code="roleAuthorizzation.th.PleaseEnter"/>：
            </td>
            <td class="TableData">
                <input style="margin-left: 10px;" placeholder="<fmt:message code="roleAuthorizzation.th.PleaseEnter" />"
                       type="password" id="super_pass" name="super_pass" class="inp" size="30"><span
                    class="super_pass_msg"></span>
            </td>
        </tr>
        <td nowrap="" style="padding: 7px;" align="center" colspan="2">
            <input class="import" type="button" value="<fmt:message code="global.lang.ok" />">
        </td>
        </tbody>
    </table>
</div>

<div class="bx" style="display: none">
    <!--标题栏-->
    <div class="head w clearfix">
        <ul class="index_head">
            <li url="secureIndex1" class="li_1">
                <span class="one headli1_1"><fmt:message code="three.th.ThreeSettings"/></span>
                <img class="headli1_2" src="../../img/twoth.png" alt=""/>
            </li>
            <li url="getSecureRule" class="li_2">
                <span class="headli2_1">
                <fmt:message code="three.th.RuleSetting"/>
                </span>
            </li>

            <%--  <li url="secureIndex3" class="li_3">
                  <span class="headli2_1">
               批量设置审批人
                  </span>
                  <img src="../../img/twoth.png" alt="" class="headli2_2"/>
              </li>--%>
        </ul>
    </div>

    <div style="width:100%;height:550px;">
        <iframe class="secure_iframe" src="secureIndex1" frameborder="0" width="100%" height="100%"></iframe>
    </div>
</div>

</body>
<script>
    $(function () {
        if ($('#yc').val() == 1) {
            $('.bx').show();
            $('#loginAdmin').hide();
            $('#north').show()
        }

        /*点击标题，获取对应的url，显示对应的src*/
        $('.index_head').on('click', '.li_1', function () {
            var url = $(this).attr('url');
            $('.secure_iframe').attr('src', url);
            // 设置样式
            $('.index_head span').removeClass("one")
            $(this).children("span").addClass("one");
        });
        $('.index_head').on('click', '.li_2', function () {
            var url = $(this).attr('url');
            $('.secure_iframe').attr('src', url);
            // 设置样式
            $('.index_head span').removeClass("one")
            $(this).children("span").addClass("one");
        });
        $('.index_head').on('click', '.li_3', function () {
            var url = $(this).attr('url');
            $('.secure_iframe').attr('src', url);
            // 设置样式
            $('.index_head span').removeClass("one")
            $(this).children("span").addClass("one");
        });
    });

</script>

<script type="text/javascript">

    /*  $(function () {
     if ($('[name="yc"]').val() == 0) {
     $('#hiddenMain').hide();
     $('#loginAdmin').show();
     } else {
     $('#hiddenMain').show();
     $('#loginAdmin').hide();
     }
     }*/
    $('.import').click(function () {
        $.post('checkpwd', {'password': $('[name="super_pass"]').val()}, function (json) {
            if (json.flag) {
                $('.bx').show();
                $('#loginAdmin').hide();
                $('#north').show()
            } else {
                layer.alert('<fmt:message code="main.th.PasswordError" />',{title:' <fmt:message code="information"/>',btn:'<fmt:message code="global.lang.ok"/>'})
            }
        }, 'json')
    })


</script>
</html>
