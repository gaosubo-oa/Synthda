<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@taglib prefix="mvc" uri="http://www.springframework.org/tags/form" %>
<%@taglib prefix="fmt" uri="http://www.springframework.org/tags" %>
<!DOCTYPE html>
<head>
    <head>
        <title>数据导入 - 人员和日志</title>
        <meta http-equiv="Content-Type" content="text/html; charset=gbk" />
        <meta name="renderer" content="webkit">
        <meta http-equiv="X-UA-Compatible" content="IE=10,chrome=1" />
        <meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=0, minimum-scale=1.0, maximum-scale=1.0">
    <!--[if lte IE 8]>
    <!--<script type="text/javascript" src="/static/js/ccorrect_btn.js"></script>-->
    <%--<![endif]-->--%>

    <script type="text/javascript" >
        var MYOA_JS_SERVER = "";
        var MYOA_STATIC_SERVER = "";
    </script>
</head>
<link rel="stylesheet" type="text/css" href="../../css/bootstrap.css">
<link rel="stylesheet" type="text/css" href="../../css/enterpriseManage/weixinqy.css">
<script type="text/javascript" src="../../js/jquery/jquery.min.js"></script>
<body>
<script type="text/javascript">
    $(function(){
        $(".func-item button").on("click", function(){
            $(".func-item button").removeClass("btn-primary");
            $(".func-item button i").removeClass("icon-white");
            $(".mod-func").hide();
            var module = $(this).attr("data-module");
            $(this).addClass("btn-primary");
            $(this).find("i").addClass("icon-white");
            $("#mod-" + module).show();
        });

            var pd=$('#iframe', window.parent.document).attr('v-s')
            if(pd==undefined){
                $('#mod-sync').attr('v-s',1)
            }else {
                $('#mod-sync').attr('v-s',2)
            }
    });
</script>
<div>
    <fieldset>
        <legend><h5>数据导入 - 人员</h5></legend>
    </fieldset>

    <div class="func-item">
        <button class="btn btn-small btn-primary"  data-module="sync"><i class="icon-user icon-white"></i>按人员导入</button>
        <button class="btn btn-small"  data-module="logs"><i class="icon-list"></i>导入日志</button>
    </div>

    <div id="mod-sync" class="mod-func well" style="display:block;"  v-s="0">
        <iframe class="iframes" src="/enterpriseWeChatManage/getWechatImportPeople" frameborder="0"></iframe>
    </div>
    <div id="mod-logs" class="mod-func well">
        <iframe class="iframes" src="/enterpriseWeChatManage/getWechatImportLogs" frameborder="0"></iframe>
    </div>
</div>
</body>
</html>