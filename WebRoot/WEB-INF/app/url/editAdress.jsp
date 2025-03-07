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
    <link rel="stylesheet" href="/lib/layer/skin/default/layer.css">

<%--    <script src="../js/xoajq/xoajq1.js" type="text/javascript" charset="utf-8"></script>--%>
    <script type="text/javascript" src="/js/xoajq/xoajq3.js"></script>
<%--    <script type="text/javascript" src="/js/jquery/jquery-migrate-3.4.0.js"></script>--%>
    <script src="../js/base/base.js" type="text/javascript" charset="utf-8"></script>
    <script src="/lib/layer/layer.js?20201106"></script>

    <style>
        .content{
            background-color: #ffffff;
        }
        .colo {
            background: #e8f4fc;
            color: #313131;
        }
    </style>
</head>
<body>
<div class="content">
    <div class="right" style="width: 100%;">
        <div class="addPerson" style="display: block;">
            <table class="table" cellspacing="0" cellpadding="0" style="border-collapse:collapse;background-color: #fff;width: 95%;margin: 20px auto;">
                <tr class="colo" align="center">
                    <td colspan="2">
                        <span style="font-weight: bold"><fmt:message code="email.th.edit" /></span>
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
                    <td class="blue_text" id="urlNo"><fmt:message code="workflow.th.Serial" />：</td>
                    <td>
                        <input type="text" name="urlNo" class="inputTd"/>
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
                            <input id="submit" type="button" class="inpuBtn backOkBtn" style="border: none;cursor: pointer;" value="&nbsp;&nbsp;&nbsp;&nbsp;<fmt:message code="global.lang.add" />">
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
        $.ajax({
            type:'get',
            url:'/syspara/selectTheSysPara?paraName=IS_SHOW_JMJ',
            dataType:'json',
            success:function (res) {
                if(res.object.length!=0){
                    var data=res.object[0]
                    if (data.paraValue!=0){
                        $('.addPerson').before('<p style="color: red;font-family: Microsoft YaHei;font-weight: bolder;font-size: 16pt;margin-left: 20px;margin-top: 10px;"> 机密级★ </p>')
                    }
                }
            }
        })
        //获取地址栏参数
        var userId=$.getQueryString('userId');
        $.ajax({
            type:'get',
            url:'/controlpanel/getUrlById',
            dataType:'json',
            data:{'urlId':userId},
            success:function(res){
                $('input[name="urlNo"]').val('');
                $('input[name="urlDesc"]').val('');
                $('input[name="url"]').val('');
                $('input[name="urlNo"]').val(res.urlNo);
                $('input[name="urlDesc"]').val(res.urlDesc);
                $('input[name="url"]').val(res.url);
            }
        })
        $('#submit').on('click',function(){
            var data={
                'urlId':userId,
                'urlType': $('#sel option:checked').val(),
                "urlNo": $('[name="urlNo"]').val(),
                'urlDesc':$('[name="urlDesc"]').val(),
                'url':$('[name="url"]').val(),
            };

            $.ajax({
                type: "post",
                url: "/controlpanel/updateUrl",
                dataType: 'json',
                data: data,
                success: function (obj) {
                    $.layerMsg({content:'<fmt:message code="url.th.addSuccess" />',icon:1},function(){
                        window.close();
                        window.opener.location.reload();
                    });
                },
            });

        });


    })






</script>
</body>
</html>
