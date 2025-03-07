<%--
  Created by IntelliJ IDEA.
  User: Lenovo
  Date: 2023/2/8
  Time: 13:45
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>数据显示</title>
    <link rel="stylesheet" type="text/css" href="/lib/layui/layui/css/layui.css?20210319.1"/>
    <link rel="stylesheet" href="/lib/layui/layui/css/layui.css">
    <script type="text/javascript" src="/js/xoajq/xoajq1.js"></script>
    <script type="text/javascript" src="/lib/layui/layui/layui.js"></script>
    <script type="text/javascript" src="/lib/layui/layui/layui.all_v2.5.js"></script>
    <script src="../js/base/base.js?2023.3.16" type="text/javascript" charset="utf-8"></script>
    <style>
        .container {
            display: flex;
            padding: 20px 0;
            min-height: 100%;
            /*background-color: rgb(247,248,250);*/
            background-image: linear-gradient(45deg, #fc438c 0%, #18CAE4 50%, #fc438c 100%);
        }
        .item h2:hover {
            color: #315efb;
        }
        .content {
            background-color: #fff;
            min-height: 100%;
            border-radius: 20px;
            box-shadow: 3px 3px 10px #000;
            box-sizing: border-box;
            padding: 20px 0;
        }
        .content .header {
            width: 70%;
            margin: 20px auto;
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
            display: block;
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
            margin: 0 10px;
            height: 100%;
            cursor: pointer;
            color: #000;
            font-size: 10pt;
        }
        .container .content .search-type ul li:hover {
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
        .container .search-item .search-inp {
            width: 85%;
            height: 40px;
            padding: 0 5px;
            border-radius: 10px 0 0 10px;
            border: 1px solid gray;
            outline: none;
            box-sizing: border-box;
        }
        .container .search-item .search-inp:focus {
            transition: .5s;
            border-color: #b6e0ff;
            border-width: 2px;
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
            border-top-right-radius: 10px;
            border-bottom-right-radius: 10px;
        }
        .container .search-item .search-btn:hover {
            transition: .5s;
            background-color: #0b8aff;
        }
        .container .content .dataList {
            width: 70%;
            margin: 0 auto;
        }
        .dataList .item .item-title{
            font-size: 20px;
            text-decoration: underline;
            margin-bottom: 5px;

        }
        .dataList .item {
            min-height: 100px;
            margin: 10px 0;
            padding: 10px 20px;
            overflow: hidden;
        }
        .dataList .item .msgInfo {
            display: flex;
        }
        .dataList .item .msgInfo .bgImg {
            width: 100px;
            height: 100px;
            margin-right: 20px;
            flex: 0 0 auto;
        }
        .dataList .item .msgInfo .bgImg img {
            width: 50px;
            height: 50px;
            margin: 5px auto;
            display: block;
        }
        .dataList .item .msgInfo .main {
            flex: 1 1 auto;
            margin: 0 20px;
            overflow: hidden;
            color: #000;
        }
        .dataList .item .msgInfo .main .aside {
            font-size: 14px;
            color: rgb(80,80,80);
        }
        .dataList .item .msgInfo .main h2 {
            margin-bottom: 5px;
            padding: 0;
            overflow: hidden;
            white-space: nowrap;
            text-overflow: ellipsis;
        }
        .dataList .item .msgInfo .main .inner {
            width: 100%;
            height: 40px;
            margin-top: 10px;
            overflow:hidden;
            text-overflow: ellipsis;
            overflow: hidden;
        }
        .dataList .item:hover {
            transition: .5s;
            border-radius: 10px;
            box-shadow: 1px 1px 5px rgb(18,86,199),-1px -1px 5px rgb(18,86,199);
            border-bottom: none;
        }
        .dataList .item .item-title a {
            color: orange;
        }
        .dataList .item .item-content {
            font-size: 14px;
            line-height: 1.5;
            letter-spacing: 1px;
            text-indent: 2em;
        }
        #pageContainer {
            width: 70%;
            height: 50px;
            margin: 0 auto;
        }
        .errorTxt {
            display: none;
            height: 100px;
            margin-top: 100px;
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
        .errorTxt p{
            text-align: center;
            font-size: 20px;
        }
        .item-title:hover {
            color: #51B1F7 !important;
        }
        select {
            width: 100%;
            text-align: center;
        }
        option {
            height: 100px;
            display: block;
            text-align: center;
        }
        #backBtn {
            font-size: 20px;
            cursor: pointer;
        }
        #backBtn:hover {
            color: #f40;
        }
        .yulan {
            cursor: pointer;
            color: rgb(18,86,199);
        }
        .yulan:hover {
            color: rgb(0, 0, 0);
        }
        .fileName {
            color: #000;
            font-weight: bold;
        }
    </style>
</head>
<body>
<div class="layui-fluid container">
    <div class="layui-container content">
        <div class="backBtn" style="margin-left: 15px;">
           <i class=" layui-icon layui-icon-return" id="backBtn" title="返回搜索页"></i>
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

            </div>
        <%--            根据权限展示分类--%>
        <div class="search-type">
            <%--            <span>分类: </span>--%>
            <ul>

            </ul>
        </div>
<%--        数据列表展示--%>
        <div class="dataList">
            <ul>

            </ul>
            <div class="errorTxt">
                <p>暂无数据</p>
            </div>
        </div>
<%--        分页--%>
        <div id="pageContainer">

        </div>
    </div>
</div>
<script>
<%--    从地址栏获取搜索的信息--%>
var searchText = new URL(location.href).searchParams.get("s");
var moduleId = new URL(location.href).searchParams.get("mid");
var flag = new URL(location.href).searchParams.get("flag");
//用来控制是否重新渲染分页组件
var firstRenderPage = true;
<%--    保存有权限的数组--%>
var moduleInfo = [];
$("#backBtn").on("click",function() {
    location.href = "/attachPriv/fullTextSearch"
})
layui.use(["laypage","layer"],function() {
    var laypage = layui.laypage;
    var layer = layui.layer;
    //回显搜索框的内容
    $(".search-inp").val(searchText)
    getData(searchText,moduleId,1,15,flag)
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

//    获取搜索的数据
    function getData(val,moduleId,page,pageSize,flag) {
        var deletelayer = layer.load(2);
        fetchData({
            url:"/attachPriv/selectBySubject",
            data: {
                subject:val,
                page: page,
                flag:flag,
                moduleId: moduleId,
                pageSize: pageSize,
                useFlag: true
            },
            fn:function(res) {
                layer.close(deletelayer)
                if(res.flag && res.obj.length > 0) {
                    const dataArr = renderKeys(res.obj,res.object);
                    renderList(dataArr,$(".dataList ul"))
                    $(".errorTxt").hide();
                    $("#pageContainer").show();

                    //计算总页数，如果总页数小于1那么不渲染分页
                    var totalPage = Math.ceil(res.totleNum / pageSize)
                    if( totalPage <= 1) {
                        $("#pageContainer").hide();
                    }
                    if(firstRenderPage) {
                        renderPage(res,$("#pageContainer"))
                        firstRenderPage = false;
                    }
                }else {
                    $(".dataList ul").empty();
                    $(".errorTxt").show();
                    $("#pageContainer").hide();
                }
            }
        })
    }
//获取一个数组
    function renderKeys(obj,keys) {
        let arr = [];
        for(let i = 0; i < obj.length; i++) {
            const info = renderKey(obj[i].subject,obj[i].profile,obj[i].url,obj[i].content,obj[i].attach?obj[i].attach : "",keys,obj[i].img,obj[i].createTime);
            arr.push(info)
        }
        return arr
    }
//    获取关键字内容
    function getBigText(key,text) {
       const index = text.indexOf(key);
        const reg = new RegExp("("+key+")","g");
       if(index != -1) {
           const indexInfo = (index - 20 > 0)?index-20:index;
           let content =  text.substr(indexInfo);
           content = content.replaceAll(reg,'<span style="color:red;">'+key+'</span>');
           return content
       }
       return text
    }
    function getFileKey(key,text) {
        const reg = new RegExp("("+key+")","g");
        const fileName = text.replaceAll(reg,'<span style="color:red;">'+key+'</span>');
        return fileName
    }
//    比较标题和内容和关键字
    function renderKey(title,profile,url,content,attach,arr,img,createTime) {
        let newTitle = title;
        let newContent = profile;
        let newattachName = "";
        let newTime = createTime;
        for(let i = 0; i < arr.length; i++) {
            let s = arr[i];
            const reg = new RegExp("("+s+")","g");
                newContent =  getBigText(s,content)
             newTitle = title.replace(reg,'<span style="color:red;">'+s+'</span>')
            newTime = createTime.replace(reg,'<span style="color:red;">'+s+'</span>')
        }
        if(attach.length > 0) {
            newattachName = handleFile(attach)
        }
        return {
            title: newTitle,
            profile:newContent,
            url: url,
            content:newContent,
            attach:newattachName,
            img:img,
            createTime:newTime
        }
    }
//    处理附件
    function handleFile(files) {
        return files.map(function(it) {
            return '<div><span class="fileName">'+getFileKey($(".search-inp").val(),it.attachName)+'</span><span class="yulan" style="margin-left: 10px;" attrurl='+it.attUrl+'>预览</span></div>'
        }).join("")
    }
    $(document).on("click",".yulan",function(e) {
        e.preventDefault();
        console.log($(this))
        preview($(this))
    })
//渲染页面
    let isFile = ""
    function renderList(data,dom) {
        let str =   data.map(function(it) {
            if(it.attach) {
                isFile = "附件:"
            }else {
                isFile = "";
            }
               return '  <li class="item">' +
                   '                    <a class="msgInfo" href="'+(it.url?it.url:"javascript:void(0)")+'" target="'+(it.url?"__blank":"")+'">' +
                   '                        <div class="bgImg">' +
                   '                            <img src="'+it.img+'" alt="">' +
                   '                        </div>' +
                   '                        <div class="main">' +
                   '                            <h2>'+(it.title||"无标题")+'</h2>' +
                   '                            <div class="aside">' +
                   '                                <span>'+(it.createTime || "")+'</span>' +
                   '                            </div>' +
                   '                            <div class="inner">'+(it.content || "无内容")+'</div>' +
                   '<div><span style="font-weight: bold;">'+isFile+'</span>'+it.attach+'</div>'+
                   '                        </div>' +
                   '                    </a>' +
                   '                </li>'
           }).join("")


        dom.html(str);
    }
//    渲染分页
    function renderPage(res,dom) {
        laypage.render({
            elem:dom,
            count: res.totleNum,
            limit: 15,
            groups:10,
            jump:function(obj,first) {
                if(!first) {
                    window.scrollTo(0,0);
                    $('.errorTxt').hide();
                    var sText = $(".search-inp").val();
                    var mId = $(".search-type .active").attr("moduleid");
                    var flag = $(".btn2 select").val();
                    getData(sText,mId,obj.curr,obj.limit,flag?"ALL":"")
                }
            }
        })
    }
    //搜索按钮点击功能
    $(".btn1").click(function() {
        $('.errorTxt').hide();
        var sText = $(".search-inp").val();
        var mId = $(".search-type .active").attr("moduleid");
        var flag = $(".btn2 select").val();
        if(!sText) {
            layer.msg("请输入内容",{icon: 2});
            returncommon/userManagement
        }

        firstRenderPage = true;
        replaceParamVal("s",sText,0)
        replaceParamVal("mid",mId,0)
        if(flag != "ALL") {
            getData(sText,mId,1,15,"")
        }else {
            getData(sText,mId,1,15,"ALL")
        }
    })
// 按下回车键的操作
    $(document).on("keyup",function(e) {
        $('.errorTxt').hide();
        if(e.key == "Enter") {
            var sText = $(".search-inp").val();
            var mId = $(".search-type .active").attr("moduleid");
            var flag = $(".btn2 select").val();
            if(!sText) {
                layer.msg("请输入内容",{icon: 2});
                return
            }
            firstRenderPage = true;
            replaceParamVal("s",sText,0)
            replaceParamVal("mid",mId,0)
            if(flag != "ALL") {
                getData(sText,mId,1,15,"")
            }else {
                getData(sText,mId,1,15,"ALL")
            }

        }
    })
    //改变地址栏参数
    function replaceParamVal(paramName, replaceWith, isRefresh) {
        var oUrl = this.location.href.toString();
        if (paramName && replaceWith) {
            if (oUrl.indexOf(paramName + "=" + replaceWith) > 1) {
                return;
            }
        }
        if (oUrl.indexOf('&' + paramName + '=') > 0) {
            var re = eval('/(&' + paramName + '=)([^&]*)/gi');
            var nUrl = oUrl.replace(re, '&' + paramName + '=' + replaceWith);
        } else {
            if (oUrl.indexOf("?") > 0) {
                var nUrl = oUrl + "&" + paramName + "=" + replaceWith;
            } else {
                var nUrl = oUrl + "?" + paramName + "=" + replaceWith;
            }
        }
        // this.location = nUrl;
        if (isRefresh) {
            window.location.href = nUrl
        }
        var stateObject = { id: "" };
        var title = "";
        history.replaceState(stateObject, title, nUrl);
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
            if(it.moduleId == moduleId) {
                if(it.flag) {
                    $('.btn2').show();
                    $(".btn1").css({
                        "border-top-right-radius": 0,
                        borderBottomRightRadius: 0
                    })
                    str += '<li class="active" moduleid='+it.moduleId+' search="all"> <span>'+it.moduleName+'</span> </li>'
                    $(".search-all").show()
                }else {
                    $('.btn2').hide();
                    $(".btn1").css({
                        "border-top-right-radius": "10px",
                        borderBottomRightRadius: "10px"
                    })
                    str += '<li class="active" moduleid='+it.moduleId+'> <span>'+it.moduleName+'</span> </li>'
                    $(".search-all").hide()
                }
            }else {
                if(it.flag) {
                    str += '<li moduleid='+it.moduleId+' search="all"> <span>'+it.moduleName+'</span> </li>'
                }else {
                    str += '<li moduleid='+it.moduleId+'> <span>'+it.moduleName+'</span> </li>'
                }
            }

        }
        dom.html(str)
    }
// 可选分类的点击操作
    $(".search-type").on("click","li",function() {
        $('.errorTxt').hide();
        $('.search-type .active').removeClass("active");
        $(this).addClass("active");
        var searchType = $(this).attr("search");
        if(searchType === "all") {
            $('.btn2').show();
            $(".btn1").css({
                "border-top-right-radius": 0,
                borderBottomRightRadius: 0
            })
        }else {
            $('.btn2').hide();
            $(".btn1").css({
                "border-top-right-radius": "10px",
                borderBottomRightRadius: "10px"
            })
        }
        var sText = $(".search-inp").val();
        if(!sText) {
            layer.msg("请输入搜索内容",{icon:2});
            return
        }
        var mid = $(this).attr("moduleid");
        replaceParamVal("s",sText,0)
        replaceParamVal("mid",mid,0)
        firstRenderPage = true;
        getData(sText,mid,1,15,"")
    })
})

</script>
</body>
</html>
