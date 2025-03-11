
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
<head lang="en">
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <title>学习经历管理</title>
    <link rel="stylesheet" href="/lib/pagination/style/pagination.css">
    <link rel="stylesheet" href="/css/base/base.css?20201106.1">
    <link rel="stylesheet" href="/css/notice/noticeManagement.css">
    <script src="/js/common/language.js"></script>

    <script type="text/javascript" src="/js/xoajq/xoajq1.js"></script>
    <script src="/js/jquery/jquery.cookie.js"></script>
    <script src="../lib/layer/layer.js?20201106" type="text/javascript" charset="utf-8"></script>
    <script type="text/javascript" src="/js/base/tablePage.js"></script>
    <script src="/js/base/base.js"></script>
    <script src="/lib/pagination/js/jquery.pagination.min.js" type="text/javascript" charset="utf-8"></script>
    <link rel="stylesheet" type="text/css" href="/css/commonTheme/${sessionScope.InterfaceModel}/commonTheme.css"/>
    <style>
        table tbody td{
            text-align: left!important;
        }
        input{
            float: none;
        }
        .editAndDelete3{
            color: red;
        }
        .newClass{
            float: right;
            width: 90px;
            height: 28px;
            background: url(../../img/file/cabinet01.png) no-repeat;
            color: #fff;
            font-size: 14px;
            line-height: 28px;
            margin: 2%  3% 0 0;
            cursor: pointer;
        }
        .delete_check {
            display: inline-block;
            width: 70px;
            height: 28px;
            position: relative;
            color: #ffffff;
            border-radius: 3px;
            background: #2b7fe0;
            text-align: center;
            line-height: 28px;
            margin-left: 20px;
        }
        .editAndDelete2{
            color: red;
        }
        .pagediv .page-bottom-outer-layer table td:last-child{
            border-right: 1px #c0c0c0 solid;
        }
        .page-top-inner-layer{
            padding: 0!important;
        }
        table tr td,table tr th{
            text-align: center !important;
        }
        /*table tr td:last-child{*/
            /*width:150px !important;*/
        /*}*/
        /*table tfoot tr td:last-child{*/
            /*text-align: left !important;*/
        /*}*/
        /*table tr th:last-child{*/
            /*width:150px !important;*/
        /*}*/
        .pagediv{
            width: 70%!important;
        }
    </style>
    <script src="/js/newUeTemplate.js"></script>
</head>
<body>
<div class="navigation">
    <img src="/img/commonTheme/${sessionScope.InterfaceModel}/gonggaoguanli.png" alt="">
    <h2>模板管理</h2>
    <div class="newClass" id="newClass">
            <span style="margin-left: 30px;">
                <img style="margin-right: 4px;margin-left: -11px;margin-bottom: 2px;" src="../../img/mywork/newbuildworjk.png" alt="">
                新建
            </span>
    </div>
</div>
<div id="pagediv">

</div>
</body>
<script>
    //        新建
    $(document).on('click','.newClass',function () {
//        $(window.parent.document).find('.main').find('iframe').prop('src','/learningExperience/newLearningExperience')
        window.location.href='/ueTemplate/ueTemplateManagement'
    })
</script>
</html>
