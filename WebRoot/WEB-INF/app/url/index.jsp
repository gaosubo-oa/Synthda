<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@taglib prefix="mvc" uri="http://www.springframework.org/tags/form" %>
<%@taglib prefix="fmt" uri="http://www.springframework.org/tags" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>


<!DOCTYPE html>
<html >
<head>
    <meta charset="UTF-8">
    <title><fmt:message code="mian.panel" /></title>
    <meta name="renderer" content="webkit">
    <meta http-equiv="X-UA-Compatible" content="IE=10,chrome=1">
    <meta name="viewport" content="width=device-width, initial-scale=0.3, user-scalable=0, minimum-scale=0, maximum-scale=5.0,user-scalable=yes">

    <link rel="stylesheet" type="text/css" href="../css/sys/userInfor.css"/>
    <link rel="stylesheet" type="text/css" href="/css/sys/url.css"/>
<%--    <script src="../js/xoajq/xoajq1.js" type="text/javascript" charset="utf-8"></script>--%>
    <script type="text/javascript" src="/js/xoajq/xoajq3.js"></script>
<%--    <script type="text/javascript" src="/js/jquery/jquery-migrate-3.4.0.js"></script>--%>
    <script src="../js/base/base.js" type="text/javascript" charset="utf-8"></script>
    <style>
        html,body{
            height:100%;
        }
        #pa{
            margin-left: 7px;
            margin-top: 12px;
            margin-bottom: 12px;
            line-height: 45px;
            font-size: 22px;
        }
        .headf{
            border-bottom: #999999 1px solid;
        }
        .add_back{
            background-color: #add2f8;
        }
        .one_all{
            height:34px !important;
            line-height:34px;
        }
    </style>
</head>
<body>
<div class="headf" style="position: fixed;top: 0;
    background: #fff;
    width: 100%;">
    <img src="/img/commonTheme/${sessionScope.InterfaceModel}/contropan.png" style="float: left;margin-top: 10px;margin-left: 2%;">
    <span id="pa">
        <fmt:message code="mian.panel" />
    </span>
</div>

<div class="content" style="padding-top: 46px;box-sizing: border-box;">
    <div class="left" style="font-size: 12pt;width:230px">
        <div class="collect">
            <div id="incum" class="divUP">
                <div class="tablediv" id="them">
                    <span class="one_all"><img src="/img/commonTheme/${sessionScope.InterfaceModel}/faceSetting.png" style="vertical-align: middle;width: 18px;margin-right: 10px;" alt="界面设置"><fmt:message code="main.interfaceset" /></span>
                </div>
                <div id="ulist" style="display: block;">
                    <span class="tablespan" id="theme"><img src="/img/commonTheme/${sessionScope.InterfaceModel}/theme.png"  alt="界面主题"><fmt:message code="interfaceSetting.th.InterfaceTopics" /></span>
                    <span class="tablespan" id="address"><img src="/img/commonTheme/${sessionScope.InterfaceModel}/person.png" alt="个人网址"><fmt:message code="url.th.address" /></span>
                    <span class="tablespan" id="commonSetting"><img src="/img/commonTheme/${sessionScope.InterfaceModel}/person.png" alt="<fmt:message code="url.th.commonApplicationSettings" />"><fmt:message code="url.th.commonApplicationSettings" /></span>
                    <span class="tablespan" id="desktop" style="display: none;"><img src="/img/commonTheme/${sessionScope.InterfaceModel}/desktop.png" alt="桌面设置"><fmt:message code="vote.th.DesktopSettings" /></span>
                </div>
            </div>
            <div id="incum2"  class="divUP">
                <div class="tablediv" id="per">
                    <span class="one_all" id="persion"><img src="/img/commonTheme/${sessionScope.InterfaceModel}/personnalInfo.png"  alt="个人信息"><fmt:message code="userDetails.th.PersonalInformation" /></span>
                </div>
                <div id="personbox" style="display: none;">
                    <span class="tablespan" id="personalinfo"><img src="/img/commonTheme/${sessionScope.InterfaceModel}/information.png" alt="个人资料"><fmt:message code="url.th.personinfor" /></span>
                    <span class="tablespan" id="editUserExt"><img src="/img/commonTheme/${sessionScope.InterfaceModel}/information-2.png" alt="昵称与头像"><fmt:message code="urlth.Nicknames" /></span>
                    <span class="tablespan" id="personalCustom"><img src="/img/commonTheme/${sessionScope.InterfaceModel}/information.png" alt="<fmt:message code="url.th.personalGrouping" />"><fmt:message code="url.th.personalGrouping" /></span>
                    <span class="tablespan" id="SealPass"><img src="/img/commonTheme/${sessionScope.InterfaceModel}/information.png" alt="<fmt:message code="url.th.sealPasswordModification" />"><fmt:message code="url.th.sealPasswordModification" /></span>
                    <%--  <span class="tablespan" id="editUserExt"><img src="/img/commonTheme/${sessionScope.InterfaceModel}/information-2.png" alt="昵称与头像"><fmt:message code="urlth.Nicknames" /></span>--%>
                </div>
            </div>

            <div  class="divUP">
                <div class="tablediv" id="cou">
                    <span class="one_all" id="securit"><img src="/img/commonTheme/${sessionScope.InterfaceModel}/countSafe.png" alt="账号与安全"><fmt:message code="url.th.security" /></span>
                </div>
                <div id="securitbox" style="display: none;">
                    <span class="tablespan" id="myoa"><img src="/img/commonTheme/${sessionScope.InterfaceModel}/mycount.png" alt="<fmt:message code="url.th.myAccount" />"><fmt:message code="url.th.myAccount" /></span>
                    <span class="tablespan" id="updatapwd" style="display: none;"><img src="/img/commonTheme/${sessionScope.InterfaceModel}/modifypassword.png" alt="<fmt:message code="url.th.modi" />"><fmt:message code="url.th.modi" /></span>
                    <span class="tablespan" id="safelog"><img src="/img/commonTheme/${sessionScope.InterfaceModel}/log.png" alt="安全日志"><fmt:message code="url.th.safelog" /></span>
                </div>
            </div>
        </div>
    </div>
    <div class="right">
    </div>
</div>
<script>
    var str1=''
    //判断页面是否显示机密级字样
    $.ajax({
        type:'get',
        url:'/syspara/selectTheSysPara?paraName=IS_SHOW_JMJ',
        dataType:'json',
        success:function (res) {
            if(res.object.length!=0){
                var data=res.object[0]
                if (data.paraValue!=0){
                    $('#pa').after('<span style="color: red;font-family: Microsoft YaHei;font-weight: bolder;font-size: 16pt;line-height: 45px;"> 机密级★ </span>')
                }
            }
        }
    })
    //如果开启三员管理隐藏 印章密码修改 我的账户 我的账户
    $.ajax({
        url:"/syspara/selectTheSysPara?paraName=IS_OPEN_SANYUAN",
        success:function(res) {
            var data = res.object[0];
            if(data.paraValue == 0) {
                $("#SealPass").hide();
                $("#myoa").css("display","none")
                $("#safelog").css("display","none")
                $("#pa").text("个人设置")
            }
        }
    })
    $.ajax({
        url: '/users/getUserTheme',
        dataType: 'json',
        type: 'post',
        success: function (data) {
            if (data.object.simpleInterface == 1) {
                $('#incum').hide()
                $('#incum2').hide()
                $('#myoa').hide()
                $('#updatapwd').addClass('add_back')
                str1+='<iframe  style="display: block" id="every_module" src="modifyInfo" frameborder="0" scrolling="yes" height="100%" width="100%" noresize="noresize"></iframe>'
                $(".right").html(str1);
            } else if (data.object.simpleInterface == 0) {
                $('#incum').show()
                $('#incum2').show()
                $('#myoa').show()
                $('#theme').addClass('add_back')
                str1+='<iframe  style="display: block" id="every_module" src="theme" frameborder="0" scrolling="yes" height="100%" width="100%" noresize="noresize"></iframe>'
                $(".right").html(str1);
            }

        }
    })


    function addEventHandler(target,type,fn){
        if(target.addEventListener){
            target.addEventListener(type,fn,false);
        }else{
            target.attachEvent("on"+type,fn,false);
        }
    }
    var  locationReloads=parent.locationReload;

    $('.right').width(document.documentElement.clientWidth-$('.left').width()-4)
    addEventHandler(window,'resize',function () {
        $('.right').width(document.documentElement.clientWidth-$('.left').width()-4)

    })


    function urlHref(url) {
        $('.right').find('iframe').attr('src', url)
    }

    var isHide = false;
    //判断是否中电建项目，中电建项目无需修改密码
    $.ajax({
        url: '/ShowDownLoadQrCode',
        type: 'GET',
        dataType: 'JSON',
        async: false,
        success: function (res) {
            if (res.flag && res.object == 1) {
                isHide = true;
            }
        }
    });
    $(function () {
        $.ajax({
            type: 'get',
            url: '/syspara/checkDemo',
            dataType: 'json',
            success: function (res) {
                if (res.flag && !isHide) {
                    $('#updatapwd').show();
                } else {
                    $('#updatapwd').hide();
                }
            }
        })

        $('#them').on('click',function () {
            $("#ulist").toggle();

        });
        $('#per').on('click',function () {
            $("#personbox").toggle();

        });
        $('#cou').on('click',function(){
            $("#securitbox").toggle();
        });
        $('#theme').on('click',function(){
            $("#every_module").attr('src','theme');

        });
        $('#address').on('click',function(){
            $("#every_module").attr('src','adressList');
        });
        $('#commonSetting').on('click',function(){
            $("#every_module").attr('src','commonSettings');
        })
        $('#desktop').on('click',function(){
            $("#every_module").attr('src','desktop');
        });

        $('#myoa').on('click',function(){
            $("#every_module").attr('src','count');
        });
        $('#updatapwd').on('click',function(){
            $("#every_module").attr('src','modifyInfo');
        });
        $('#SealPass').on('click',function(){
            $("#every_module").attr('src','/controlpanel/updateSealPass');
        });

        $('#personalinfo').on('click',function(){
            $("#every_module").attr('src','personInfor?type=0');
        });
        $('#personalCustom').on('click',function(){
            $("#every_module").attr('src','/controlpanel/customEdit');
        });
        $('#safelog').on('click',function(){
            $("#every_module").attr('src','safelog');
        });

        $("#editUserExt").on('click',function(){
            $("#every_module").attr('src','editUserExtPage');
        })

        $("#per").trigger("click")
        $("#cou").trigger("click")

    })



</script>
</body>
</html>

