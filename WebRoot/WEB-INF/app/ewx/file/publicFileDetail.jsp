<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@taglib prefix="mvc" uri="http://www.springframework.org/tags/form" %>
<%@taglib prefix="fmt" uri="http://www.springframework.org/tags" %>
<!doctype html>
<html>
<head>
    <meta charset="UTF-8">
    <title>详情页</title>
    <meta name="viewport" content="width=device-width,initial-scale=1,minimum-scale=1,maximum-scale=1,user-scalable=no" />
    <link href="../lib/mui/mui/mui.css" rel="stylesheet" />
    <link rel="stylesheet" href="../css/file/m/file_content.css" />
    <script src="../lib/mui/mui/mui.min.js"></script>
    <script type="text/javascript" src="/js/xoajq/xoajq3.js"></script>
    <script type="text/javascript" src="/js/jquery/jquery-migrate-3.4.0.js"></script>
    <script type="text/javascript" src="../../js/base/base.js"></script>
    <script type="text/javascript" src="../../js/ewx/waterMark.js?20190819.1"></script>
    <script type="text/javascript" src="../js/diary/m/simbaJs.js" ></script>
    <script type="text/javascript">
        mui.init()
    </script>
</head>

<body>
<%--<header class="mui-bar mui-bar-nav">--%>
<%--    <a class="mui-action-back mui-icon mui-icon-arrowleft mui-pull-left" style="color:#333;"></a>--%>
<%--    <h1 class="mui-title">内容详情</h1>--%>
<%--</header>--%>
<div class="main" style="margin-top: 10px">
    <div class="head_show" id="head_show">
    </div>
    <hr>
    <div class="content_show" id="content_show">
    </div>
    <div id="picture" class="mui-popover mui-popover-action mui-popover-bottom">
        <ul class="mui-table-view">
            <li class="mui-table-view-cell">
                <a href="#" onclick="up_load()">查看</a>
            </li>
        </ul>
        <ul class="mui-table-view">
            <li class="mui-table-view-cell">
                <a href="#picture"><b>取消</b></a>
            </li>
        </ul>
    </div>
</div>
<script>
    var file_url = "";
    var file_name = "";
    function get_file(self){
        self.setAttribute("href","#picture");
        file_url = self.getAttribute("data-url");
    }
    function up_load(){
        var url = file_url;
        plus.runtime.openURL(url);
    }
</script>
<script>
    function GetQueryString(name) {
        var reg = new RegExp("(^|&)" + name + "=([^&]*)(&|$)");
        var r = window.location.search.substr(1).match(reg);
        if (r != null) return unescape(r[2]); return null;
    }
    id = GetQueryString("id"); //括号里放地址栏传参变量
    mui.ajax('/file/getContentById',{
        data:{
            contentId : id
        },
        dataType:'json',//服务器返回json格式数据
        type:'get',//HTTP请求类型
        success:function(data){
            var filemess = data.attachmentList;
            var head_str = "<p class='filename' id='filename' style='text-align: center;font-weight: bold;font-size: 20px;height: 30px'>"+data.subject+"</p><p><span  class='writename' id='writename'>创建人："+data.creater+"</span><span class='createtime' id='createtime' style='float: right'>"+data.sendTime+"</span></p>";
            mui('#head_show')[0].insertAdjacentHTML('beforeend', head_str);
            var content_str = "<div class='content' id='content' style='"+(data.content ? '' : 'text-align:center')+"'>"+(data.content ? data.content : '<span>无...</span>')+"</div><p class='fujian'>附件：</p>";
            for(var i = 0;i<filemess.length;i++){
                content_str += "<a data-url='"+filemess[i].attUrl+"' href='/download?"+filemess[i].attUrl+"'>"+filemess[i].attachName+"</a><br/><br/>";
            }
            mui('#content_show')[0].insertAdjacentHTML('beforeend', content_str);
        },
        error:function(xhr,type,errorThrown){
            //异常处理；
            console.log(type);
        }
    });
</script>
</body>
</html>