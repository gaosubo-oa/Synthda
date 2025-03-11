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
    <script src="/js/xoajq/xoajq1.js" type="text/javascript" charset="utf-8"></script>
    <script type="text/javascript" src="../js/diary/m/simbaJs.js" ></script>
    <script type="text/javascript">
        mui.init()
    </script>
</head>

<body>
<header class="mui-bar mui-bar-nav">
    <a class="mui-action-back mui-icon mui-icon-arrowleft mui-pull-left" style="color:#333;"></a>
    <h1 class="mui-title">内容详情</h1>
</header>
<div class="main">
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
            var head_str = "<p class='filename' id='filename'>文件名："+data.subject+"</p><p class='writename' id='writename'>发布人："+data.creater+"</p><p class='createtime' id='createtime'>"+data.sendTime+"</p>";
            mui('#head_show')[0].insertAdjacentHTML('beforeend', head_str);
            var content_str = "<p class='content' id='content'>"+data.content+"</p><p class='fujian'>附件：</p>";
            for(var i = 0;i<filemess.length;i++){
                content_str += "<a data-url='"+filemess[i].attUrl+"' onclick='get_file(this)'>@ "+filemess[i].attachName+"</a><br/><br/>";
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