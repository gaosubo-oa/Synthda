<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@taglib prefix="mvc" uri="http://www.springframework.org/tags/form" %>
<%@taglib prefix="fmt" uri="http://www.springframework.org/tags" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html >
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <title>工资查询</title>
    <meta name="renderer" content="webkit">
    <meta http-equiv="X-UA-Compatible" content="IE=10,chrome=1">
    <meta name="viewport" content="width=320,maximum-scale=1.3,user-scalable=no">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=0, minimum-scale=1.0, maximum-scale=1.0">
    <link rel="stylesheet" type="text/css" href="/lib/layui/layui/css/layui.css?20210319.1"/>
    <link rel="stylesheet" type="text/css" href="../../css/news/center.css"/>
    <link rel="stylesheet" type="text/css" href="../../lib/laydate.css"/>
    <link rel="stylesheet" type="text/css" href="../../lib/pagination/style/pagination.css"/>
    <link rel="stylesheet" type="text/css" href="../../css/base.css" />
    <link rel="stylesheet" type="text/css" href="../../css/news/new_news.css"/>
    <link rel="stylesheet" type="text/css" href="../../css/news/management_query.css" />
    <script type="text/javascript" src="/js/xoajq/xoajq1.js"></script>
    <%--    <script type="text/javascript" src="/js/xoajq/xoajq2.js"></script>--%>
    <script src="/js/base/base.js" type="text/javascript" charset="utf-8"></script>
    <script src="../../js/jquery/jquery.cookie.js"></script>
    <script src="/lib/jQuery-File-Upload-master/jquery-ui.js" type="text/javascript" charset="utf-8"></script>
    <script src="/lib/jQuery-File-Upload-master/jquery.iframe-transport.js" type="text/javascript" charset="utf-8"></script>
    <script src="/lib/jQuery-File-Upload-master/jquery.fileupload.js" type="text/javascript" charset="utf-8"></script>
    <script type="text/javascript" src="/js/common/fileupload.js"></script>
    <script type="text/javascript" src="/lib/layui/layui/layui.js"></script>
    <script type="text/javascript" src="/lib/layui/layui/layui.all.js"></script>
    <script type="text/javascript" src="/lib/layui/layui/layui-v1.0.9_rls/layui/lay/modules/layedit.js"></script>
    <script src="../../js/news/page.js"></script>
    <script src="../../lib/laydate/laydate.js"></script>
    <script src="../../lib/pagination/js/jquery.pagination.min.js" type="text/javascript" charset="utf-8"></script>
    <script src="../../js/jquery/jquery.cookie.js"></script>
    <style type="text/css">
        html,body{
            height: 100%;
            width: 100%;
            /*overflow-x: hidden;*/
        }
        .index_head{
            width: 100%;
            height: 98px;
        }
        li{
            width: 49%;
            height: 30px;
            float: left;
        }
    </style>
</head>
<body id="body">
<div id="header" class="head w clearfix" style="width: 100%">
    <ul class="index_head">
        <li data_id="0" url="/bonusmsg/h5wages" data-num="0"><span class="one headli1_1" style="width: 120px;text-align: center">我的工资数据查询</span>
        </li><img style="margin:  0; float: left;" class="headli1_2" src="../img/twoth.png" alt=""/>

        <li data_id="" url="/bonusmsg/h5bonus" data-num="1"><span class="headli2_1" style="width: 120px;text-align: center">我的奖金数据查询</span>
            <%--            <img src="../img/twoth.png" alt="" class="headli2_2"/>--%>
        </li>

        <li data_id="" url="/bonusmsg/h5subWages" data-num="2" class="headli3_1" style="visibility: hidden"><span class="headli3_1" style="width: 120px;text-align: center">下属工资数据查询</span>
        </li><img style="margin:  0; float: left;" src="../img/twoth.png" alt="" class="headli2_2"/>

        <li data_id="" url="/bonusmsg/h5affBonus" data-num="3" class="headli4_1" style="visibility: hidden"><span class="headli4_1" style="width: 120px;text-align: center">下属奖金数据查询</span>
        </li>
    </ul>
</div>

<div id="iframebox" style="margin-top: 30px;">
    <iframe src="/bonusmsg/h5wages" frameborder="0" scrolling="yes"  noresize="noresize"  id="iframes"></iframe>

</div>
<script>
    $('.index_head').on('click','li',function() {
        var dataNum=$(this).attr('data-num');
        $('.index_head span').removeClass('one');
        $(this).children('span').addClass('one');
        if(dataNum == '1'){
            $('.head').width($(window.body).width());
            $('#index_head').width($(window.body).width())
            $('#iframes').width($(window.body).width());
            $('#iframes').attr('src','/bonusmsg/h5bonus');
        }else if (dataNum == '0'){
            $('.head').width($(window.body).width());
            $('#index_head').width($(window.body).width())
            $('#iframes').width($(window.body).width());
            $('#iframes').attr('src','/bonusmsg/h5wages');
        }else if (dataNum == '2'){
            $('.head').width('100%');
            $('#iframes').width('100%');
            $('#iframes').attr('src','/bonusmsg/h5subWages');
        }else if (dataNum == '3') {
            $('.head').width('100%');
            $('#iframes').width('100%');
            $('#iframes').attr('src','/bonusmsg/h5affBonus');
        }
//        var url=$(this).attr('url');
//        $('#iframes').attr('src',url);

    });
    $(function () {
        $('#iframes').width('100%')
        var ifm= document.getElementById("iframes");
        var ifHeight=$('#body').height()-$('.head').height();
        ifm.height=ifHeight-35;
    })

    //当前用户登录权限是否显示下属工资与奖金
    $.ajax({
        url:'/bonusPriv/bonusPrivType',
        type:'get',
        dataType:'json',
        success: function (data) {
            if(data.flag){
                if(data.object.type==1){
                    $('.headli3_1').css('visibility','visible');
                    $('.headli4_1').css('visibility','visible');
                    $('.headli2_2').css('display','block');

                    parent();
                }else{
                    $('.headli3_1').css('visibility','hidden');
                    $('.headli4_1').css('visibility','hidden');
                    $('.headli2_2').css('display','none');
                    parent();
                }
            }
        }
    });
    $('#0130', parent.document).click(function () {
        location.reload();
    })

</script>

</body>
</html>
