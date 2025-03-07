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
    <title><fmt:message code="mian.panel" /></title>
    <meta name="renderer" content="webkit">
    <meta http-equiv="X-UA-Compatible" content="IE=10,chrome=1">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=0, minimum-scale=1.0, maximum-scale=1.0">
    <link rel="stylesheet" type="text/css" href="../css/sys/userInfor.css"/>
    <link rel="stylesheet" type="text/css" href="/css/sys/url.css"/>

<%--    <script src="../js/xoajq/xoajq1.js" type="text/javascript" charset="utf-8"></script>--%>
    <script type="text/javascript" src="/js/xoajq/xoajq3.js"></script>
<%--    <script type="text/javascript" src="/js/jquery/jquery-migrate-3.4.0.js"></script>--%>
    <script src="../js/base/base.js" type="text/javascript" charset="utf-8"></script>
    <style>
        .content{
            background-color: #ffffff;
        }
        .colo{
            background: #3791DA;
            color: white;
        }
    </style>
</head>
<body>
<div class="content">
    <div class="right">
        <div class="addPerson" style="display: block;">
            <table class="table" cellspacing="0" cellpadding="0" style="border-collapse:collapse;background-color: #fff">
                <tr class="colo" align="center" style="background: #3791DA" color="white">
                    <td colspan="2">
                        <span style="font-weight: bold"><fmt:message code="url.th.addPerson"/></span>
                    </td>
                </tr>
                <tr>
                    <td class="blue_text" id="urlType"><fmt:message code="notice.th.type" />：</td>
                    <td>
                        <select name="urlType" id="sel">
                            <option value="0"><fmt:message code="url.th.commen" /></option>
                            <option value="1" id="RSS"><fmt:message code="url.th.Subscribe" /></option>
                        </select>
                    </td>
                </tr>
                <tr id="blu" style="display:none">
                    <td class="blue_text"><fmt:message code="url.th.RSS" />：</td>
                    <td>
                        <select name="urlType">
                            <option value="0"><fmt:message code="url.th.first" /></option>
                            <option value="1"><fmt:message code="url.th.mv" /></option>
                            <option value="2"><fmt:message code="url.th.Finance" /></option>
                        </select>
                    </td>
                </tr>
                <tr>
                    <td class="blue_text" id="urlNo"><fmt:message code="file.th.Sort" />：</td>
                    <td>
                      <input type="text" name="urlNo" onkeyup="(this.v=function(){this.value=this.value.replace(/[^0-9-]+/,'');}).call(this)" onblur="this.v();" class="inputTd"/>
                    </td>
                </tr>
                <tr>
                    <td class="blue_text" id="urlDesc"><fmt:message code="roleAuthorization.th.Explain" />：</td>
                    <td>
                        <input type="text" name="urlDesc" class="inputTd"/>
                    </td>
                </tr>
                <tr>
                    <td class="blue_text" id="url"><fmt:message code="url.th.http" />：</td>
                    <td>
                        <input type="text" name="url" class="inputTd"/>
                    </td>
                </tr>
                <tr>
                    <td colspan="2">
                        <div class="btn">
                            <input id="submit" type="button" class="inpuBtn backOkBtn"  value="&nbsp;&nbsp;&nbsp;&nbsp;<fmt:message code="global.lang.add" />">
                        </div>
                    </td>
                </tr>
            </table>
        </div>
    </div>
</div>
<script>
    $(function () {
        $("#sel").on('change',function(){
            if($(this).val()==1){
                $('#blu').show();
            }else {
                $('#blu').hide();
            }
        });
        $('#submit').on('click',function(){
            var data={
                'urlType': $('#sel ').val(),
                "urlNo": $('[name="urlNo"]').val(),
                'urlDesc':$('[name="urlDesc"]').val(),
                'url':$('[name="url"]').val(),
            };

            $.ajax({
                type: "post",
                url: "/controlpanel/addUrl",
                dataType: 'json',
                data: data,
                success: function (obj) {
                    alert("<fmt:message code="url.th.addSuccess" />");
                    /*parent.urlHref('adressList')*/
                    window.location.href = '/controlpanel/adressList';

                },
            });

        });


    })
</script>
</body>
</html>

