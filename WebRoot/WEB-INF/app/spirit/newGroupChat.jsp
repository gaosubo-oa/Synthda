<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html>
<!-- saved from url=(0082)file:///C:/Users/gaosubo/Desktop/OA%E7%B2%BE%E7%81%B5_files/saved_resource(1).html -->
<html><!--<![endif]-->
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
    <title>群聊选人</title>

    <meta name="renderer" content="webkit">
    <meta http-equiv="X-UA-Compatible" content="IE=10,chrome=1">
    <meta name="viewport"
          content="width=device-width, initial-scale=1.0, user-scalable=0, minimum-scale=1.0, maximum-scale=1.0">
    <script type="text/javascript">
        var MYOA_JS_SERVER = "";
        var MYOA_STATIC_SERVER = "";
    </script>
    <link rel="stylesheet" type="text/css" href="../css/spirit/style.css">
    <link rel="stylesheet" type="text/css" href="../css/spirit/ipanel.css">
    <link rel="stylesheet" type="text/css" href="../css/main/theme1/bootstrap.min.css"/>
    <%--<link rel="stylesheet" type="text/css" href="../css/main/theme1/index.css?20201106.1"/>--%>
    <link rel="stylesheet" type="text/css" href="../css/spirit/user_online.css">
    <link rel="stylesheet" type="text/css" href="../css/spirit/ui.dynatree.css">
    <style>
        #deptOrg li .childdept a{
            font-size: 14px;
            vertical-align: middle;
        }

        span.dynatree-checkbox{
            vertical-align: middle;
        }
        /*#modules{*/
        /*margin-left: 0px;*/
        /*}*/
        #deptOrg .childdept{
            display: block;
            line-height: 26px;
        }
        #deptOrg .childdept:hover{
            background: #abd9fe;
        }
        ul.dynatree-container a:hover{
            background: none;
        }
        #modules{
            margin-left: 0px;
            padding:0px;
        }
        ul.dynatree-no-connector > li span.childdept{
            padding-left: 20px;
        }
        .dynatree-checkbox>img{
            width: 20px!important;
            height: 20px!important;
        }
        span.dynatree-checkbox{
            vertical-align: middle;
            width: 20px;
            height: 20px;
        }
        span.dynatree-checkbox.actives{
            vertical-align: middle;
            width: 16px;
            height: 16px;
        }
        span.dynatree-checkbox.actives>img{

            width: 8px!important;
            height: 8px!important;
            margin-top:4px;
        }
        span.dynatree-has-children a{
            font-weight: normal;
        }
    </style>
    <script src="/js/xoajq/xoajq1.js"></script>
    <script src="/js/base/base.js"></script>
    <script type="text/javascript" src="../js/spirit/qwebchannel.js"></script>
    <script src="/js/spirit/newGroupChat.js?20191107.1"></script>

    <script type="text/javascript">
        function init() {
            jQuery("#body").height(jQuery(window).height() - jQuery("#sub_tabs").outerHeight());
        }

        window.onresize = init;
    </script>
    <style type="text/css">
        .dynatree-checkbox{
            margin-right:5px;!important;
        }
        #dyna_li:hover{background:#EFEFEF;}
        #dept_li:focus{background:#EFEFEF;}
        .dynatree-title{
            font-weight: normal;
        }
        .ul.dynatree-container ul{
            padding:0!important;
        }
        .tab_ctwo{
            background: #fff;
        }
        .main{
            padding:0px 20px;
            margin-top:10px;
            width: 100%;
            box-sizing: border-box;
            border-top:1px solid #c0c0c0;
        }
        .mainleft{
            width: 50%;
            float: left;
            box-sizing: border-box;
            padding-right: 5px;
            border-right: 1px solid #c0c0c0;
        }
        .clearfix:after{
            content:'';
            display: block;
            clear: both;
        }
        .mainright{
            width: 50%;
            float: left;
            box-sizing: border-box;
            padding:13px 5px 10px 0px;
        }
        .mainlefttop{
            box-sizing: border-box;
            padding-left: 15px;
            height: 30px;
            line-height: 30px;
            width: 100%;
            margin-top:10px;
            position: relative;
        }
        .mainlefttop input[type=text]{
            width: 80%;
            height: 30px;
            line-height: 30px;padding-left:10px;
            box-sizing: border-box;
            border: 1px solid #c0c0c0;
            outline: none;
        }
        .titles{
            margin-left: 20px;
            color: #c0c0c0;
            font-size: 14px;
        }
        .dataul{
            margin-left: 20px;
        }
        .dataul li{
            height: 27px;
            line-height: 27px;
            position: relative;
            padding-left:10px;
            box-sizing: border-box;
            cursor: pointer;
            background: #abd9fe;
        }
        .dataul li.none{
            background: #fff;
        }
        .dataul .none:hover{
            background: #abd9fe;
        }
        .dataul li img{
            width: 20px;
            vertical-align: middle;
            margin-top:-2px;
            display: inline-block;
        }
        .dataul li span{
            vertical-align: middle;
            margin-left: 8px;
            margin-top:-2px;
            display: inline-block;
        }
        .dataul li span label{
            display: inline-block;
        }
        .dataul li b{
            border-radius: 50%;
            width: 16px;
            height: 16px;
            line-height:16px;
            background: #c0c0c0;
            color: #fff;
            font-size: 12px;
            right: 5px;
            top:50%;
            margin-top:-10px;
            text-align: center;
            position: absolute;
            margin-right: 5px;
            cursor: pointer;
        }
        .mainlefttoptext{
            width: 78%;
            border:1px solid #c0c0c0;
            background: #fff;
            border-radius: 4px;
            position: absolute;
            top: 36px;
            left: 15px;
            display: none;
            padding:10px;
            box-sizing: border-box;
            padding-bottom: 0px;
        }
        .mainlefttoptext ul li img{
            display: inline-block;
        }
        .dataul li b:hover{
            background: #3c92e5;
        }
        .mainlefttoptext ul li:hover b{
            background: #3c92e5;
        }
        .btnArr{
            position: fixed;
            width: 140px;
            height: 30px;
            right: 80px;
            bottom: 22px;
        }
        .btnArr a{
            padding:3px 15px;
            border:1px solid #ccc;
            border-radius: 3px;
            color: #000;
        }
        .btnArr a.active{
            background: #3c92e5;
            color: #fff;
        }
    </style>
</head>


<body  marginwidth="0" marginheight="0">
<div class="btnArr">
    <a href="javascript:;" class="active" style="margin-right: 10px;">确定</a>
    <a href="javascript:;" class="closeA" >取消</a>
</div>
<div class="main clearfix">
    <div class="mainleft">
        <div class="mainlefttop">
            <input type="text" name="sousuo" onclick="event.stopPropagation()"  placeholder="请输入搜索条件">
            <div class="mainlefttoptext">
                <ul class="dataul" style="margin-left: 0px">

                </ul>
            </div>
        </div>
        <div id="body" style="height: calc(100% - 40px);">
            <div id="modules">
                <div id="module_org" class="container moduleContainer" style="display: block;">
                    <div class="pickCompany">
                        <span style="height:32px;line-height:32px;" class="childdept">
                            <img src="/img/commonTheme/${sessionScope.InterfaceModel}/icon_company.png" alt="" style="vertical-align: middle;width: 15px;
                            margin-right: 10px;margin-left: 13px;margin-bottom: 4px;">
                            <a href="javascript:void(0)" class="dynatree-title"
                               title="" style="display: inherit;margin-left: 0;color: #111;font-size: 14px">

                            </a>
                        </span>
                    </div>
                    <div id="sub_module_org_0" class="module-block" style="">
                        <ul class="dynatree-container dynatree-no-connector tab_ctwo" id="deptOrg">
                        </ul>
                    </div>
                    <div id="sub_module_org_1" class="module-block" style="display:none;"></div>
                </div>

            </div>
        </div>
    </div>


    <div class="mainright">
        <p class="titles">
            请选择需要添加的联系人
        </p>
        <ul class="dataul" id="dataul">

        </ul>
    </div>

</div>
</body>
</html>