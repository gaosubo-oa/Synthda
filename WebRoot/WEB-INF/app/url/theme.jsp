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
    <title><fmt:message code="mian.panel"/></title>
    <meta name="renderer" content="webkit">
    <meta http-equiv="X-UA-Compatible" content="IE=10,chrome=1">
    <meta name="viewport"
          content="width=device-width, initial-scale=1.0, user-scalable=0, minimum-scale=1.0, maximum-scale=1.0">
    <link rel="stylesheet" type="text/css" href="../css/sys/userInfor.css"/>
    <link rel="stylesheet" type="text/css" href="/css/sys/url.css"/>

<%--    <script src="../../js/xoajq/xoajq1.js" type="text/javascript" charset="utf-8"></script>--%>
    <script type="text/javascript" charset="utf-8" src="/js/xoajq/xoajq3.js"></script>
    <script type="text/javascript" charset="utf-8" src="/js/jquery/jquery-migrate-3.4.0.js"></script>
    <script src="../../js/base/base.js" type="text/javascript" charset="utf-8"></script>
    <%--<script src="../js/sys/userInfor.js" type="text/javascript" charset="utf-8"></script>--%>
    <style>
        .content {
            background-color: #ffffff;
        }
        .content .right {
            width: 100%;
        }
        .colo {
            background: #e8f4fc;
            color: #313131;
            text-align: left;
        }
        #btn1 {
            margin: 0 auto;
            width: 110px;
            margin-bottom: 80px;
        }
        #btn1 {
            background: url("/img/confirm.png") no-repeat;
            border: none;
            width: 146px;
            padding-left: 6px;
            height: 29px;
            line-height: 29px;
            cursor: pointer;
        }
        table.table tr {
            border: none;
        }
        table.table tr.padstyle td {
            padding-top: 40px;
        }
        table.table tr th {
            border-right: none;
            padding: 0px 0px 0px 43px;
            height:36px;
        }
        table.table tr td {
            border-right: none;
            padding: 10px ;
        }
        table.table tr td span {
            color:#999;
            font-size:12px;
        }
        table.table tr td:first-of-type {
            text-align: right;
            width: 30%;
            font-weight:normal;
            font-size: 11pt;
        }
        table.table tr td:last-of-type {
            padding-left: 5px;
        }
        table.table {
            width: 100%;
            margin: 0px auto;
            /*font-size: 14px;*/
            font-size: 13pt;
            margin-bottom: 40px;
        }
        table.table tr td input[type="checkbox"]{
            margin-left: 10px;
            margin-right: 5px;
        }
        .title{
            height:35px;
            line-height:35px;
        }
        .title span{
            margin-left:0px;
            font-size:22px;
            line-height:35px;
        }
        .title img{
            margin-left:15px;
            vertical-align: middle;
            width:24px;
            height:26px;
            padding-bottom:8px;
        }
        select{
            height:28px;
            font-size: 11pt;
        }
        table.table tr .red_text{
            text-align: right;
            width: 30%;
            font-weight: bold;
        }

    </style>
</head>
<script>
    $(function () {
        function getMenu(){
            $.ajax({
                url:'/showMenu',
                type:'get',
                success:function(res){
                    var data=res.obj;
                    var str='<option value=""><fmt:message code="url.th.doNotExpand" /></option>'
                    for(var i=0;i<data.length;i++){
                        str+='<option value="'+data[i].id+'">'+data[i].name+'</option>'
                    }
                    $('#menuExpand').html(str);
                    initData();
                }
            })
        }
        getMenu();

    });

    $.ajax({
        url:"../../sys/getInterfaceInfo",
        type:"post",
        datatType:"json",
        //data:datas,
        success:function(data){
            if(data.object.themeSelect =='1'){

            }else{
                $("#theme").attr('disabled', 'disabled');
            }
        }
    })

    function initData() {
        $.ajax({
            type: "post",
            url: "/users/getUserTheme",
            dataType: 'json',
            data: "",
            success: function (obj) {
                $("#theme option").each(function (){
                    var value = $(this).val();
                    if(value == obj.object.theme){
                        $(this).attr("selected", "selected");

                    }
                });


                //默认展开菜单
                $("#menuExpand option").each(function (){
                    var value = $(this).val();
                    if(value == obj.object.menuExpand){
                        $(this).attr("selected", "selected");
                    }
                });

                //登录模式
                $("#menuType option").each(function (){
                    var value = $(this).val();

                    if(value == obj.object.menuType){
                        $(this).attr("selected", "selected");
                    }
                });

                //登录后左侧面板
                $("#panel option").each(function (){
                    var value = $(this).val();

                    if(value == obj.object.panel){
                        $(this).attr("selected", "selected");

                    }
                });
                $("#callSound option").each(function (){
                    var value = $(this).val();

                    if(value == obj.object.callSound){
                        $(this).attr("selected", "selected");

                    }
                });


            }
        });


    }


</script>

<body>
<div class="content">
    <div class="right">
        <div class="title">
            <img src="/img/commonTheme/${sessionScope.InterfaceModel}/theme.png" alt="界面主题">
            <span><fmt:message code="interfaceSetting.th.InterfaceTopics"/></span>
        </div>
        <div class="main" style="...">
            <table class="table" cellspacing="0" cellpadding="0"
                   style="border-collapse:collapse;background-color: #fff">
                <tr class="colo" align="center" style="">
                    <th colspan="2">
                        <span style="font-weight: bold"><fmt:message code="url.th.ThemesAndMenus"/></span>
                    </th>
                </tr>
                <tr class="padstyle">
                    <td class="red_text"><fmt:message code="interfaceSetting.th.InterfaceTopics"/>:</td>
                    <td>
                        <select name="uType" id="theme">
                            <option value="20"><fmt:message code="home.page.fashion.title" /></option>
                            <option value="6"><fmt:message code="controller.th.er" /></option>
                            <option value="7"><fmt:message code="controller.th.san" /></option>
                            <option value="3"><fmt:message code="controller.th.si" /></option>
                            <option value="4"><fmt:message code="controller.th.gm" /></option>
                            <option value="5"><fmt:message code="controller.th.dge" /></option>
                           <%-- <option value="0"><fmt:message code="url.th.Universe"/></option>
                            <option value="1"><fmt:message code="url.th.Fresh"/></option>
                            <option value="2"><fmt:message code="url.th.DeepElegance"/></option>
                            <option value="3"><fmt:message code="url.th.BeautyLife"/></option>--%>
                        </select>
                        <%--<span><fmt:message code="url.th.ThemeIE9"/></span>--%>
                    </td>
                </tr>
                <tr>
                    <td class="red_text"><fmt:message code="url.th.Default"/>:</td>
                    <td>
                        <select name="uType" id="menuExpand">
                            <%--<option value="0"><fmt:message code="main.affairs"/></option>--%>
                            <%--<option value="1"><fmt:message code="email.th.workflow"/></option>--%>
                            <%--<option value="2"><fmt:message code="main.office"/></option>--%>
                            <%--<option value="3"><fmt:message code="main.management"/></option>--%>
                            <%--&lt;%&ndash;<option value="3"><fmt:message code="main.portal"/></option>--%>
                            <%--<option value="4"><fmt:message code="main.center"/></option>&ndash;%&gt;--%>
                            <%--<option value="4"><fmt:message code="sup.th.SupervisionAndSupervision"/></option>--%>
                            <%--<option value="5"><fmt:message code="main.resources"/></option>--%>
                            <%--<option value="6"><fmt:message code="main.document"/></option>--%>
                            <%--<option value="7"><fmt:message code="main.systemmanage"/></option>--%>
                        </select>
                        <%--<span><fmt:message code="url.th.SupportTheme"/></span>--%>
                    </td>
                </tr>
            </table>
        </div>
        <%--<div class="main" style="...">--%>
            <%--<table class="table" cellspacing="0" cellpadding="0"--%>
                   <%--style="border-collapse:collapse;background-color: #fff">--%>
                <%--<tr class="colo" align="center" style="" color="white">--%>
                    <%--<th colspan="2">--%>
                        <%--<span style="font-weight: bold"><fmt:message code="url.th.LoginOptions"/></span>--%>
                    <%--</th>--%>
                <%--</tr>--%>
                <%--<tr class="padstyle">--%>
                    <%--<td class="red_text"><fmt:message code="url.th.loginType"/>:</td>--%>
                    <%--<td>--%>
                        <%--<select name="uType" id="menuType">--%>
                            <%--<option value="0"><fmt:message code="url.th.OpenWindow"/></option>--%>
                            <%--<option value="1"><fmt:message code="url.th.OpenNew"/></option>--%>
                            <%--<option value="2"><fmt:message code="url.th.OpenOA"/></option>--%>
                        <%--</select>--%>
                        <%--<span><fmt:message code="url.th.Relogin"/></span>--%>
                    <%--</td>--%>
                <%--</tr>--%>
               <%--&lt;%&ndash; <tr>--%>
                    <%--<td class="red_text"><fmt:message code="url.th.ShowLeftPanel"/>:</td>--%>
                    <%--<td>--%>
                        <%--<select name="uType" id="panel">--%>
                            <%--<option value=""><fmt:message code="url.th.Navigation"/></option>--%>
                            <%--<option value="0"><fmt:message code="global.lang.tissue"/></option>--%>
                            <%--<option value="1"><fmt:message code="url.th.MicroNews"/></option>--%>
                            <%--<option value="2"><fmt:message code="url.th.Note"/></option>--%>
                        <%--</select>--%>
                        <%--<span><fmt:message code="url.th.OASprite"/></span>--%>
                    <%--</td>--%>
                <%--</tr>&ndash;%&gt;--%>
                <%--&lt;%&ndash;<tr>--%>
                    <%--<td class="red_text"><fmt:message code="url.th.Display"/>:</td>--%>
                    <%--<td>--%>
                        <%--<select name="uType">--%>
                            <%--<option value=""><fmt:message code="global.lang.yes"/></option>--%>
                            <%--<option value="0"><fmt:message code="global.lang.no"/></option>--%>
                        <%--</select>--%>
                        <%--<span><fmt:message code="url.th.Wizard"/></span>--%>
                    <%--</td>--%>
                <%--</tr>&ndash;%&gt;--%>
            <%--</table>--%>
        <%--</div>--%>
        <div class="main" style="...">
            <table class="table" cellspacing="0" cellpadding="0"
                   style="border-collapse:collapse;background-color: #fff">
                <tr class="colo" align="center" style="" color="white">
                    <th colspan="2">
                        <span style="font-weight: bold"><fmt:message code="url.th.MessageSettings"/></span>
                    </th>
                </tr>
                <tr class="padstyle">
                    <td class="red_text"><fmt:message code="url.th.Message"/>:</td>
                    <td>
                        <select name="uType" id="callSound">
                            <option value="1"><fmt:message code="url.th.systemThemeSoundEffect" /></option>
                            <option value="0"><fmt:message code="event.th.nothing" /></option>
                            <%--<option value=""><fmt:message code="url.th.OAtheme"/></option>--%>
                           <%-- <option value="0"><fmt:message code="url.th.laser"/></option>
                            <option value="1"><fmt:message code="url.th.Drops"/></option>
                            <option value="2"><fmt:message code="url.th.auto"/></option>--%>
                        </select>
                    </td>
                </tr>
            </table>
        </div>
        <div class="main" style="...">
            <%--<table class="table" cellspacing="0" cellpadding="0"
                   style="border-collapse:collapse;background-color: #fff">
                <tr class="colo" align="center" style="" color="white">
                    <th colspan="2">
                        <span style="font-weight: bold"><fmt:message code="url.th.weather"/></span>
                    </th>
                </tr>
                <tr class="padstyle">
                    <td class="red_text"><fmt:message code="url.th.Whether"/>:</td>
                    <td>
                        <input name="showWhether" id="showWhetherId" type="checkbox"><fmt:message code="url.th.show"/>
                    </td>
                </tr>
            </table>--%>
            <div style="margin:0 auto;width: 130px">
                <div class="Btn" id="btn1"><span style="margin-left: 22px;"><fmt:message code="global.lang.save" /></span></div>
            </div>
        </div>

    </div>
</div>
<script>
    $(function () {


            $('#btn1').on('click',function () {
/*
            //是否显示天气预报
                       var showWhether = $("input[name='showWhether']:checked").val();
             if (showWhether != null) {
             showWhether = "yes";
             } else {
             showWhether = "no";
             }*/

            var data = {
                'theme': $('#theme option:checked').attr('value'),
                "menuType": $('#menuType option:checked').attr('value'),
                'bkground': $('#bkground option:checked').attr('value'),
                'menuExpand': $('#menuExpand option:checked').attr('value'),
                'panel': $('#panel  option:checked').attr('value'),
                'callSound': $('#callSound option:checked').attr('value'),
                          'weatherCity': "no"

            };
            $.ajax({
                type: "post",
                url: "/users/addAndApplicationUsers",
                dataType: 'json',
                data: data,
                success: function (obj) {
                    if (obj.msg = "ok") {
                        $.layerMsg({content:'<fmt:message code="depatement.th.Modifysuccessfully" />',icon:1},function(){
//                            console.log('新建失败');

                               parent.locationReloads();

                        });
                        <%--alert("<fmt:message code="depatement.th.Modifysuccessfully" />");--%>
                    } else {
                        <%--alert("<fmt:message code="depatement.th.modifyfailed" />");--%>
                        $.layerMsg({content:'<fmt:message code="depatement.th.modifyfailed" />',icon:2},function(){
                            console.log('新建失败');
                        });
                    }
                }
            });


        });
    })


</script>

</body>
</html>

