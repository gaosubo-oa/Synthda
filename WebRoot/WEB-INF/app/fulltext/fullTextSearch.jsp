<%--
  Created by IntelliJ IDEA.
  User: Lenovo
  Date: 2023/2/7
  Time: 13:46
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>全文检索</title>
    <link rel="stylesheet" type="text/css" href="/lib/layui/layui/css/layui.css"/>
    <link rel="stylesheet" href="/lib/layui/layui/css/layui.css">
    <script type="text/javascript" src="/js/xoajq/xoajq1.js"></script>
    <script type="text/javascript" src="/lib/layui/layui/layui.js"></script>
    <style>
        * {
            margin: 0;
            padding: 0;
        }
        .iconImg {
            width: 16px;
            height: 16px;
            display: inline-block;
        }
        body {
            background-color: #eee;
            overflow: hidden;
            font-family: Arial,sans-serif !important;
        }
        .container {
            position: relative;
            width: 100%;
            height: 100%;
            padding: 0;

            overflow: hidden;
        }
        .container .model {
            position: absolute;
            width: 100%;
            height: 100%;
            background-size: 200% 200%;
            /*background-image: linear-gradient(45deg, rgb(90, 54, 148) 0%, rgb(19, 189, 206) 33%, rgb(0, 148, 217) 66%, rgb(111, 199, 181) 100%);*/
            background-image: linear-gradient(45deg, #fc438c 0%, #18CAE4 50%, #fc438c 100%);
            /*animation: run 2s infinite both linear;*/
        }
         .header {
            width: 100%;
            height: 50px;
            /*background-color: pink;*/
        }
        .container .content {
            overflow: hidden;
        }
        .container .content .search-item {
            width: 70%;
            height: 50px;
            margin: 0 auto;
            overflow: hidden;
            display: flex;
        }
        .container .content .search-item .search-info {
            flex: 1 1 auto;
            display: flex;
        }
        .container .content .search-itm .search-all {
            flex: 0 0 auto;
            width: 10%;
        }
        .container .search-item .search-inp {
            width: 85%;
            height: 40px;
            padding: 0 5px;
            border-radius: 10px 0 0 10px;
            border: 2px solid gray;
            /*border-top-width: 3px;*/
            padding-top:1px;
            outline: none;
        }
        .container .search-item .search-inp:focus {
            transition: .5s;
            border-color: #b6e0ff;
        }
        .container .search-item .search-btn {
            width: 14%;
            height: 40px;
            box-sizing: border-box;
            margin-left: -2px;
            border: none;
            outline: none;
            background-color: #4e6ef2;
            color: #fff;
            cursor: pointer;
            padding: 2px 0;
            border-top-right-radius: 10px;
            border-bottom-right-radius: 10px;
        }
        .container .search-item .search-btn:hover {
            transition: .5s;
            background-color: #0b8aff;
        }
        .container .content .content-title {
            height: 80px;
            text-align: center;
            color: #fff;
            font-size: 28px;
            margin-top: 60px;
            margin-bottom: 20px;
            text-shadow: 1px 1px 1px #000;
            overflow: hidden;
            user-select: none;
        }
        .container .content .search-type {
            width: 70%;
            margin: 10px auto;
            height: 30px;
            line-height: 30px;
        }
        .container .content .search-type ul {
            display: inline-block;
        }
        .container .content .search-type ul li{
            display: inline-block;
            margin: 10px;
            height: 100%;
            cursor: pointer;
            color: #000;
            font-size: 10pt;
        }
        .container .content .search-type ul li:hover {
            transition: .5s;
            color: #4e6ef2;
        }
        .container .content .search-type ul li.active {
            color: #4e6ef2;
        }
        .container .content .search-type ul li.active:after {
            content: '';
            width: auto;
            min-width: 30px;
            height: 2px;
            background: #4e6ef2;
            border-radius: 1px;
            display: block;
            margin-top: 1px;
        }
        .search1 {
            display: inline-block;
            width: 50%;
            height: 100%;
            text-align: center;
            line-height: 40px;
            box-sizing: border-box;
        }
        .search1:first-child{
            border-right: 1px solid #ccc;
        }
        @keyframes run {
          0% {
              background-position: 0 0;
          }
            50% {
                    background-position: 0% 100%;
            }
            /*33% {*/
            /*    background-position: 0 150%;*/
            /*    background-image: linear-gradient( #18CAE4 33%, #FC438c 100%);*/
            /*}*/
            /*66% {*/
            /*    background-position: 150% 0;*/
            /*    background-image: linear-gradient( #18CAE4 33%, #FC438c 100%);*/
            /*}*/
            100% {
                background-position: 100% 100%;

            }
        }
        select {
            text-align: center;
        }
        option {
            width: 100%;
            height: 100px;
            display: block;
            text-align: center;
        }
    </style>
</head>
<body>

<%--    头部导航栏--%>
<%--<div class="header">--%>
<%--    头部导航栏--%>
<%--</div>--%>
<%--外层容器--%>
<div class="layui-fluid container">
    <div class="model"></div>
<%--    中间的内容部分--%>
    <div class="layui-container content" style="height: 100%;">
        <div class="content-title">
            <h1 class="layui-anim layui-anim-up"><span>O</span><span>A</span><span>系</span><span>统</span><span>全</span><span>文</span><span>检</span><span>索</span> </h1>
        </div>

<%--        搜索的输入框和按钮--%>
        <div class="search-item">
            <div class="search-info">
                <input type="text" class="search-inp" placeholder="请输入关键字">
                <button class="search-btn btn1"><span style="font-size: 10pt;">搜索一下</span></button>
                <div class="search-btn btn2" style="padding: 0;margin: 0; display: none;">
                    <select  style="width: 100%;height: 100%;">
                        <option value="">本人</option>
                        <option value="ALL">全部</option>
                    </select>
                </div>
            </div>
<%--            <div class="search-all">--%>
<%--                <select name="city" lay-verify="" class="layui-input" style="padding: 0 5px;">--%>
<%--                    <option value="">搜索范围</option>--%>
<%--                    <option value="">仅自己</option>--%>
<%--                    <option value="ALL">全部</option>--%>
<%--                </select>--%>
<%--            </div>--%>
        </div>
        <%--            根据权限展示分类--%>
        <div class="search-type">
            <%--            <span>分类: </span>--%>
            <ul>

            </ul>
        </div>
    </div>
</div>
<script>
<%--    保存有权限的数组--%>
    var moduleInfo = [];
<%--封装请求ajax的方法--%>
    function fetchData(options) {
        $.ajax({
            url:options.url|| "",
            type:options.type || "get",
            data: options.data || {},
            async:options.async || true,
            success:options.fn
        })
    }
    //根据当前登录的用户id获取权限
    fetchData({
        url:"/getLoginUser",
        async:false,
        fn:function(res) {
            if(res.flag) {
                var userId = res.object.userId;
                //    调取获取权限的接口
                fetchData({
                    url:"/attachPriv/selectAll",
                    async:false,
                    fn:function(res) {
                        if(res.flag) {
                            var data = res.obj;
                            if(data.length > 0) {
                                for(var i = 0; i < data.length; i++) {
                                    var it = data[i];
                                    if(it.userIds && it.userIds.includes(userId)) {
                                        moduleInfo.push({...it,flag:true})
                                    }else {
                                        moduleInfo.push({...it,flag:false})
                                    }
                                }
                            //    渲染可选择模块的数据
                                renderTypeList(moduleInfo,$(".search-type ul"))
                            }
                        }
                    }
                })
            }else {
                layer.msg("加载数据失败",{icon: 2})
            }
        }
    })
//
function renderTypeList(data,dom) {
        var str = "";
    for(var i = 0; i < data.length; i++) {
        var it = data[i];
        if(i === 0) {
            if(it.flag) {
                $('.btn2').show()
                $(".btn1").css({
                    "border-top-right-radius": 0,
                    borderBottomRightRadius: 0
                })
                str += '<li class="active" moduleid='+it.moduleId+' search="all"> <span>'+it.moduleName+'</span> </li>'
            }else {
                $(".btn1").css({
                    "border-top-right-radius": "10px",
                    borderBottomRightRadius: "10px"
                })
                $('.btn2').hide()
                str += '<li class="active" moduleid='+it.moduleId+'> <span>'+it.moduleName+'</span> </li>'
            }
        }else {
            if(it.flag) {
                str += '<li moduleid='+it.moduleId+' search="all"><span>'+it.moduleName+'</span> </li>'
            }else {
                str += '<li moduleid='+it.moduleId+'> <span>'+it.moduleName+'</span> </li>'
            }
        }

    }
    dom.html(str)
}
//给标题绑定点击事件
var timer = null;
    $(".content-title").on("click",'span',function(){
        var _this = $(this);
        if($(this).hasClass("layui-anim layui-anim-up")) {
            $(this).removeClass("layui-anim layui-anim-up")
        }
        timer = setTimeout(function() {
            _this.addClass("layui-anim layui-anim-up")
            clearTimeout(timer)
        },0)
    } )
//搜索按钮点击功能
    $(".btn1").click(function() {
        var searchVal = $(".search-inp").val();
        var moduleId = $(".search-type .active").attr("moduleid");
        var flag = $(".btn2 select").val();
        if(!searchVal) {
            layer.msg("请输入内容",{icon: 2});
            return
        }
        if(flag != "ALL") {
            location.href = '/attachPriv/fullTextList?a=0&s='+searchVal+'&mid='+moduleId
        }else {
            location.href = '/attachPriv/fullTextList?a=0&s='+searchVal+'&mid='+moduleId +'&flag=ALL'
        }


    })
// 按下回车键的操作
$(document).on("keyup",function(e) {
    if(e.key == "Enter") {
        var searchVal = $(".search-inp").val();
        var moduleId = $(".search-type .active").attr("moduleid");
        var flag = $(".btn2 select").val();
        if(!searchVal) {
            layer.msg("请输入内容",{icon: 2});
            return
        }
        if(flag != "ALL") {
            location.href = '/attachPriv/fullTextList?a=0&s='+searchVal+'&mid='+moduleId
        }else {
            location.href = '/attachPriv/fullTextList?a=0&s='+searchVal+'&mid='+moduleId +'&flag=ALL'
        }

        // getData(searchVal)
    }
})
// 可选分类的点击操作
$(".search-type").on("click","li",function() {
    var searchType = $(this).attr("search");
    if(searchType === "all") {
        $('.btn2').show()
        $(".btn1").css({
            "border-top-right-radius": 0,
            borderBottomRightRadius: 0
        })
    }else {
        $('.btn2').hide()
        $(".btn1").css({
            "border-top-right-radius": "10px",
            borderBottomRightRadius: "10px"
        })
    }
    $('.search-type .active').removeClass("active");
    $(this).addClass("active");
})
</script>
</body>
</html>
