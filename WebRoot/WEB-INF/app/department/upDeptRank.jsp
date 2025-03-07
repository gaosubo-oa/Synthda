<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@taglib prefix="mvc" uri="http://www.springframework.org/tags/form" %>
<%@taglib prefix="fmt" uri="http://www.springframework.org/tags" %>

<%
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html;charset=utf-8">
    <title>Insert title here</title>
    <style>
        html {
            height:100%;
        }
        body {
            height:100%;
        }
        .cabinet_left {
            width: 20%;
            float: left;
            /*overflow: auto ;*/
            overflow-x: hidden;
            overflow-y: auto;
            height: 100%;
            background-color: #F0F4F7;
            border:1px solid #d9d9d9;
        }
        .cabinet_right {
            width:79.8%;
            height:100%;
            border-left-width: 0px;
            border-right-width: 0px;
            border-top-width: 0px;
        }
        .cabinet_info{
            width:100%;

            float: left;
        }
        .noData{
            width: 100%;
        }
        .noData .bgImg{
            position: relative;
            width: 360px;
            height: 190px;
            margin: 55px auto;
            background-color: #357ece;
            border-radius: 10px;
            box-shadow: 3px 3px 3px #2F5C8F;
            overflow: hidden;
        }
        .noData .bgImg .IMG{
            float: left;
            width: 75px;
            height: 75px;
            margin-top: 37px;
            margin-left: 30px;
        }
        .noData .bgImg .IMG img{
            width: 100%;
        }
        .noData .bgImg .TXT{
            float: left;
            color: #fff;
            position: absolute;
            right: 22px;
            top:50%;
            margin-top: -87px;
            font-size: 14px;
            /*margin-top: 22px;*/
            margin-left: 20px;
            width: 59%;
            text-align: left;
            line-height: 18px;
        }
        .noData .bgImg .TXTa{
            color: #fff;
            font-size: 14px;
            margin-top: 60px;
            margin-left: 20px;
            text-align: center;
        }
        /*定义滚动条宽高及背景，宽高分别对应横竖滚动条的尺寸*/
        .cabinet_left ::-webkit-scrollbar{
            width: 4px;
            height: 16px;
            background-color: #f5f5f5;
        }
        /*定义滚动条的轨道，内阴影及圆角*/
        .cabinet_left ::-webkit-scrollbar-track{
            -webkit-box-shadow: inset 0 0 6px rgba(0,0,0,.3);
            border-radius: 10px;
            background-color: #f5f5f5;
        }
        /*定义滑块，内阴影及圆角*/
        .cabinet_left ::-webkit-scrollbar-thumb{
            /*width: 10px;*/
            height: 20px;
            border-radius: 10px;
            -webkit-box-shadow: inset 0 0 6px rgba(0,0,0,.3);
            background-color: #555;
        }
        .div_Img{
            float: left;
            width: 23px;
            height: 100%;
            margin-left: 30px;
        }
        .div_Img img{
            width: 23px;
            height: 23px;
            margin-top: 11px;
        }
        .divP{
            float: left;
            height: 40px;
            line-height: 40px;
            font-size: 22px;
            margin-left: 10px;
            color:#494d59;
        }
        body {
            background-color: #f9f9f9;
        }
    </style>
    <link rel="stylesheet" href="/css/dept/userGroup.css">
    <link rel="stylesheet" href="/css/dept/roleAuthorization.css?20210311.1">
    <link rel="stylesheet" type="text/css" href="../css/easyui/easyui.css">
    <link rel="stylesheet" type="text/css" href="../css/easyui/icon.css">
    <%--<link rel="stylesheet" type="text/css" href="../lib/laydate.css"/>--%>
    <link rel="stylesheet" type="text/css" href="../css/cabinet.css?20201106.1">
    <script type="text/javascript" src="../js/easyui/jquery.min.js"></script>
    <script type="text/javascript" src="../js/xoajq/xoajq3.js"></script>
    <script src="/js/jquery/jquery-migrate-3.4.0.js"></script>
    <script src="../../js/jquery/jquery.cookie.js"></script>
    <script type="text/javascript" src="../js/easyui/jquery.easyui.min.js"></script>
    <script type="text/javascript" src="../js/easyui/easyui-lang-zh_CN.js"></script>
    <script src="../js/base/base.js" type="text/javascript" charset="utf-8"></script>
    <script src="../lib/layer/layer.js?20201106" type="text/javascript" charset="utf-8"></script>
    <%--<script src="../lib/laydate.js" type="text/javascript" charset="utf-8"></script>--%>
    <script src="../js/jquery/jquery.form.min.js" type="text/javascript" charset="utf-8"></script>
    <script type="text/javascript">

    </script>
</head>
<body>
<div style="height: 100%" align="center" id="main">
    <div class="navigation  clearfix">
        <div class="left">
            <img src="../img/department/upDeptRank.png" alt="">
            <div class="news newtwo"><fmt:message code="depart.th.FixDepartLevel" /></div><%--修正部门级次--%>
            <div id="Confidential" style="display: inline-block"></div>
        </div>
    </div>
    <div class="cabinet_info">
        <div class="noData"  style="display: block;">
            <div class="bgImg">
                <div class="IMG">
                    <img src="../img/sys/icon64_info.png"/>
                </div>
                <div class="TXT"><%--该功能可以修正因部门排序号出现错误导致的个别界面部门级次混乱的问题，修正操作会对部门排序号进行重新调整，修正后请您对部门的级次和排序进行确认，必要的话可以手动调整。--%><fmt:message code="depart.th.adjustment" /></div>
            </div>
        </div>
        <input type="button" value='<fmt:message code="depart.th.correction" />' class="upDeptRankBt import"><%--修正--%>
    </div>
</div>

<div align="center" id="minor" style="display: none">
    <div class="cabinet_info">
        <div class="noData"  style="display: block;">
            <div class="bgImg">
                <div class="IMG">
                    <img src="../img/sys/icon64_info.png"/>
                </div>
                <div class="TXT">	<%--修正部门级次成功,请您对部门的级次和排序进行确认，必要的话可以手动调整。--%><fmt:message code="depart.th.adjust" /></div>
            </div>
        </div>
    </div>
</div>
<script>
    $(".upDeptRankBt").on("click",function(){
        $.post("/department/updateDeptNo",function (json) {
            if(json.flag){
                /*$.layerMsg({content:'操作成功',icon:1},function () {*/
                $("#main").hide();
                $("#minor").show();
                /*})*/
            }
        },'json')
    })

    var language=$.cookie('language');
    console.log(language)
    if(language == 'en_US'){
        $('.TXT').attr('style','margin-top:-87px!important');
    }else{
        $('.TXT').attr('style','margin-top:-57px!important');
    }

    $.ajax({
        type:'get',
        url:'/syspara/selectTheSysPara?paraName=IS_SHOW_JMJ',
        dataType:'json',
        success:function (res) {
                var data=res.object[0]
                if (data.paraValue!=0){
                    $('#Confidential').append('<span style="color: red;font-family: Microsoft YaHei;font-weight: bolder;font-size: 16pt;margin-left: 20px;margin-top: 10px;"> 机密级★ </span>')
                }
        }
    })
</script>
</body>
</html>