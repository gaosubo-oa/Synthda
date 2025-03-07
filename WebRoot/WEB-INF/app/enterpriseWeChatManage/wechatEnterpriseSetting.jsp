<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@taglib prefix="mvc" uri="http://www.springframework.org/tags/form" %>
<%@taglib prefix="fmt" uri="http://www.springframework.org/tags" %>
<!DOCTYPE html>

<html lang="en" class=" js flexbox canvas canvastext webgl no-touch geolocation postmessage websqldatabase indexeddb hashchange history draganddrop websockets rgba hsla multiplebgs backgroundsize borderimage borderradius boxshadow textshadow opacity cssanimations csscolumns cssgradients cssreflections csstransforms csstransforms3d csstransitions fontface generatedcontent video audio localstorage sessionstorage webworkers applicationcache svg inlinesvg smil svgclippaths"><head><meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <head>
        <title>企业微信企业号设置</title>
        <meta http-equiv="Content-Type" content="text/html; charset=gbk" />
        <meta name="renderer" content="webkit">
        <meta http-equiv="X-UA-Compatible" content="IE=10,chrome=1" />
        <meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=0, minimum-scale=1.0, maximum-scale=1.0">
        <script type="text/javascript" >
            var MYOA_JS_SERVER = "";
            var MYOA_STATIC_SERVER = "";
        </script>
    </head>
<body>
<link rel="stylesheet" type="text/css" href="../../css/bootstrap.css">
<link rel="stylesheet" type="text/css" href="../../css/enterpriseManage/weixinqy.css">
<script type="text/javascript" src="../../js/jquery/jquery.min.js"></script>
<script type="text/javascript" src="../../lib/layer/layer.js?20201106"></script>

<style>

    body{
        font: 14px "微软雅黑";
    }
    body a{
        color:#3b474d;
    }
    i{ font-style:normal;font-weight: bold;float: right;}
    li:hover i{
        color: #00a0e9;
    }
</style>
<div id="homepage" class="container">
    <div class="row">

        <div class="span3 bs-docs-sidebar">
            <div class="func_box">
                <div class="hd">设置</div>
                <div class="bd">
                    <ul class="nav nav-list bs-docs-sidenav affix-top">
                        <li class="cur" url="/enterpriseWeChatManage/getWechatArameterSetting"><a href="javascript:;"><i> > </i> 基础参数设置<span class='font-red'>（必填）</span></a></li>
                        <li url="/enterpriseWeChatManage/getWechatChooseDepartment"><a href="javascript:;"><i> > </i> 组织架构初始化</a></li>
                        <li url="/enterpriseWeChatManage/getWechatImportPersonnel"><a href="javascript:;"><i> > </i> 用户管理</a></li>
                        <li class="pd1" url="/enterpriseWeChatManage/getWechatOrganizationManagement"><a href="javascript:;" data-module="basic.dingding_org"><i> > </i> 企业微信组织架构管理</a></li>
                        <li class="pd2"  url="/enterpriseWeChatManage/getWechatOaBinding"><a href="javascript:;"><i> > </i> 企业微信账号绑定到OA用户</a></li>
                        <li  url="/enterpriseWeChatManage/getWechatPublicNotice?appName='WECHATQY_APP_XOA'" class="on" appName="WECHATQY_APP_XOA"><a href="javascript:;"><i> > </i> 心通达云办公</a></li>
                    </ul>
                </div>
            </div>
            <%--<div class="func_box">--%>
                <%--<div class="hd">企业微信应用设置</div>--%>
                <%--<div class="bd">--%>
                    <%--<ul class="nav nav-list bs-docs-sidenav affix-top">--%>
                        <%--<li><a href="javascript:;"><i> > </i> 电子邮件</a></li>--%>
                        <%--<li url="/infoCenter/getPublicNotice"><a href="javascript:;"><i> > </i> 公告通知</a></li>--%>
                        <%--<li><a href="javascript:;"><i> > </i> 新闻</a></li>--%>
                        <%--<li><a href="javascript:;"><i> > </i> 工作流</a></li>--%>
                        <%--<li><a href="javascript:;"><i> > </i> 日程安排</a></li>--%>
                        <%--<li><a href="javascript:;"><i> > </i> 工作日志</a></li>--%>
                        <%--<li><a href="javascript:;"><i> > </i> 公共文件柜</a></li>--%>
                        <%--<li><a href="javascript:;"><i> > </i> 图片浏览</a></li>--%>
                        <%--<li><a href="javascript:;"><i> > </i> 工资条查询</a></li>--%>
                        <%--<li><a href="javascript:;"><i> > </i> 会议申请</a></li>--%>
                        <%--<li><a href="javascript:;"><i> > </i> 投票管理</a></li>--%>
                        <%--<li><a href="javascript:;"><i> > </i> 企业社区</a></li>--%>
                        <%--<li><a href="javascript:;"><i> > </i> 个人文件柜</a></li>--%>

                        <%--<!--<li><a href="javascript:;" data-module="basic.dingding_app_module.personinfo"><i class="icon-chevron-right"></i> 员工信息</a></li>-->--%>
                    <%--</ul>--%>
                <%--</div>--%>
            <%--</div>--%>
            <%--<div class="func_box">--%>
                <%--<div class="hd">基础功能</div>--%>
                <%--<div class="bd">--%>
                    <%--<ul class="nav nav-list bs-docs-sidenav affix-top">--%>
                        <%--<li url="/infoCenter/getOrganizationManagement"><a href="javascript:;" data-module="basic.dingding_org"><i> > </i> 企业微信组织架构管理</a></li>--%>
                    <%--</ul>--%>
                <%--</div>--%>
            <%--</div>--%>
        </div>

        <div id="content-wrap" class="span9" style="height:700px">
            <iframe id="iframe" src="/enterpriseWeChatManage/getWechatArameterSetting" frameborder="0"></iframe>
        </div>

    </div>
</div>
</body>
<script type="text/javascript">
    function pd(id){
        $(id).on("click", function(){
            var pd=$('#iframe').attr('v-s');
            if(pd!=2){
                layer.open({
                    type: 1,
                    title: ['提示','background-color:#2e8ded;color:#fff'],
                    content:'<div style="font-size: 18px;text-align: center;padding-top: 60px;">请填写企业微信开发凭证,保存并测试链接！</div>',
                    area: ['430px', '250px'],

                    btn: ['关闭'],
                    yes:function(index){
                        layer.close(index)
                    },
                    btnAlign:'c',

                })


                return
            }
        });

    }
    $(function(){
        $(".func_box li").on("click", function(){
            $(".func_box li").removeClass("cur")
            $(this).addClass("cur");
            var src=$(this).attr('url')
            $("#iframe").attr("src", src);
            var pd=$('#iframe').attr('v-s');
        });
        pd('.pd1')
        pd('.pd2')
    });
</script>
</html>