<%--
  Created by IntelliJ IDEA.
  User: 张继斌
  Date: 2022/4/13
  Time: 15:15
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>未点评日志</title>
    <link rel="stylesheet" type="text/css" href="../lib/laydate.css"/>
    <link rel="stylesheet" type="text/css" href="../lib/pagination/style/pagination.css"/>
    <link rel="stylesheet" type="text/css" href="../css/base.css"/>
    <link rel="stylesheet" type="text/css" href="../css/diary/workLog.css?2019101712.55"/>
    <link rel="stylesheet" type="text/css" href="../css/diary/calendar1.css"/>
    <link rel="stylesheet" type="text/css" href="/lib/layui/layui/css/layui.css?20210319.1"/>
    <script type="text/javascript" src="/lib/layui/layui/layui.js"></script>
    <script type="text/javascript" src="/lib/layui/layui/layui.all.js"></script>
    <script src="/js/common/language.js"></script>
<%--    <script src="/js/xoajq/xoajq1.js" type="text/javascript" charset="utf-8"></script>--%>
    <script type="text/javascript" src="/js/xoajq/xoajq3.js"></script>
<%--    <script type="text/javascript" src="/js/jquery/jquery-migrate-3.4.0.js"></script>--%>
    <script src="/lib/jQuery-File-Upload-master/jquery-ui.js" type="text/javascript" charset="utf-8"></script>
    <script src="/lib/jQuery-File-Upload-master/jquery.iframe-transport.js" type="text/javascript" charset="utf-8"></script>
    <script src="/lib/jQuery-File-Upload-master/jquery.fileupload.js" type="text/javascript" charset="utf-8"></script>
    <script type="text/javascript" src="../js/diary/calendar1.js/"></script>
    <script type="text/javascript" src="../js/diary/date.js/"></script>
    <script src="/js/jquery/jquery.cookie.js"></script>
    <script src="../lib/laydate/laydate.js"></script>
    <script src="../js/news/page.js"></script>
    <script src="../lib/pagination/js/jquery.pagination.min.js" type="text/javascript" charset="utf-8"></script>
    <script src="../js/base/base.js" type="text/javascript" charset="utf-8"></script>
    <script src="../lib/ueditor/ueditor.config.js" type="text/javascript" charset="utf-8"></script>
    <script src="../lib/ueditor/ueditor.all.js" type="text/javascript" charset="utf-8"></script>
    <%-- <script type="text/javascript" src="../js/diary/index.js/"></script>--%>
    <script src="../lib/layer/layer.js?20201106"></script>
    <script src="../../js/jquery/jquery.form.min.js" type="text/javascript" charset="utf-8"></script>
    <script src="/lib/jQuery-File-Upload-master/jquery.fileupload.js" type="text/javascript" charset="utf-8"></script>
    <script src="../js/attachment/attachView.js?20210406.1" type="text/javascript" charset="utf-8"></script>
    <script type="text/javascript" src="/js/common/fileupload.js"></script>
    <!-- kindeditor文本编辑器 -->
    <script charset="utf-8" src="/lib/kindeditor/kindeditor-all.js"></script>
    <script charset="utf-8" src="/lib/kindeditor/lang/zh-CN.js"></script>
</head>
<style>
    .one{
        background-color: white !important;
        color: black !important;
    }
    .two{
        color: black;
        border-radius: 20px !important;

    }
    .three{
        border-radius: 20px !important;
        color: white;
        background-color: #005825;
    }
    .fore{
        background-color: white !important;
        border-radius: 20px !important;
    }
    body{
        /*background-color: rgb(233,234,235);*/
    }
    .main_head{
        width:97%;
        text-align: left;
        padding-left: 20px;
        height: 40px;
        line-height: 40px;
        border-radius: 4px 4px 0 0;
        /*box-shadow: 0 1px 2px 0 rgba(0,0,0,.15);*/
        box-sizing: border-box;
        font-size: 22px;
        color: rgb(73, 77, 89);
    }
    .main{
        box-sizing: border-box;
        /*padding:10px 60px;*/
        display: flex;
        align-items: center;
        width:97%;
        margin:0 auto;
        background:#fff;
        /*box-shadow: 0 1px 2px 0 rgba(0,0,0,.15);*/
        border-radius: 0 0 4px 4px;
    }
    .layui-form-label{
        text-align: left !important;
        padding: 9px 0;
    }
    .layui-hide{
        display: inline-block !important;
    }
    .layui-form {
        display: flex;
        flex-wrap: wrap;
        align-items: center;
        justify-content: space-around;
    }
    .layui-form .layui-inline {
        flex: 1 1 auto;
        margin-top: 20px;
    }
    .main_head img {
        margin-top: 0.36%;
        width: 30px;
        height: 30px;
        display: inline-block;
        float: left;
    }
</style>
<link rel="stylesheet" type="text/css" href="/css/commonTheme/${sessionScope.InterfaceModel}/commonTheme.css"/>
<body>
<div class="head w clearfix" style="position: fixed;background: #fff;width:100%;z-index:1000;height:45px;">
    <ul class="index_head clearfix">
        <li id="index" data_id=""><span class="one headli1_1 titName" style="background-color: white !important;">工作日志</span></li>
        <li id="logQuery" data_id=""><span class="two headli1_1 titName" style="background-color: white !important;">日志查询</span></li>
        <li id="noCommentLog" data_id=""><span class="three headli1_1 titName">未点评日志</span></li>
        <li id="reportStatistics" data_id=""><span class="fore headli1_1 titName">汇报统计</span></li>
        <%--<li data_id="0" onclick="develop()"><span class="headli2_1"><fmt:message code="diary.th.LogRetrieval"/></span><img class="headli1_2" src="../img/twoth.png" alt=""/></span>--%>
        <%--</li>--%>
    </ul>
</div>
<div style="position: relative;top: 60px; width: 97%; margin: 0 auto;">
    <div class="main_head"><img src="/img/main_img/app/0128.png"><div>未点评日志</div></div>
    <div class="main">
        <form class="layui-form" action="">

            <%--            style="margin-left: 60px;--%>
            <div class="layui-inline">
                <label class="layui-form-label">发起人</label>
                <div class="layui-input-inline">
                    <input type="text" name="userId" readonly id="faqiren" lay-verify="date" placeholder="请选择发起人" autocomplete="off" class="layui-input">
                </div>
            </div>

            <div class="layui-inline">
                <label class="layui-form-label">日志日期</label>
                <div class="layui-input-inline">
                    <input type="text" name="date" id="startTime" lay-verify="date" placeholder="请选择开始日期" autocomplete="off" class="layui-input">
                </div>
                <span style="margin-left: 10px;margin-right: 10px;">至</span>
                <div class="layui-input-inline">
                    <input type="text" name="date" id="endTime" lay-verify="date" placeholder="请选择结束日期" autocomplete="off" class="layui-input">
                </div>
            </div>

            <div class="layui-inline" style="margin-top: 20px;">
                <label class="layui-form-label">日志类型</label>
                <div class="layui-input-inline">
                    <select id="diaType" name="schoolTypes" class="schoolType noEdit" lay-verify="required" lay-search="" title="">
                        <option value="1">工作日志</option>
                        <option value="3">工作周报</option>
                        <option value="4">工作月报</option>
                    </select>
                </div>
            </div>

            <div class="layui-inline" style="margin-top: 20px;">
                <button type="button" id="search" class="layui-btn layui-btn-sm">查询</button>
            </div>
            <%--            //表格--%>
            <div class="biao" style="width: 100%;">
                <table class="layui-hide" id="tests" lay-skin="nob"  lay-filter="tests"></table>
            </div>
        </form>
    </div>
</div>
</body>
<script id="barDemos" type="text/html">
    <div class="long">
        <a lay-event="edit" class="layui-btn layui-btn-xs" id="edit">查看</a>
    </div>
</script>
<script>
    function getQueryString(name){
        var reg = new RegExp("(^|&)"+ name +"=([^&]*)(&|$)");
        var r = window.location.search.substr(1).match(reg);
        if(r!=null)return  decodeURI(r[2]); return null;
    }
    var returnTpe = getQueryString('returnTpe');
    var startTime = getQueryString('startTime') || '';
    var endTime = getQueryString('endTime') || '';
    var userId = getQueryString('userId') || '';
    var userName = getQueryString('userName') || '';
    var diaType = getQueryString('diaType') || '';
    if (startTime == "" && endTime == ""){
        startTime = DateFormat(getLastMonday(new Date()), "yyyy-MM-dd");
        endTime = DateFormat(getLastSunday(new Date()), "yyyy-MM-dd");
    }
    $("#startTime").val(startTime)
    $("#endTime").val(endTime)
    $("input[name='userId']").attr("user_id", userId)
    $("input[name='userId']").attr("username", userName)
    $("input[name='userId']").val(userName)
    if (diaType != ""){
        $("#diaType").val(diaType)
    } else {
        $("#diaType").val(3)
    }
    layui.use(['form', 'table', 'element', 'layedit','upload','laydate'], function () {
        var laydate = layui.laydate;
        var table = layui.table
        var form = layui.form
        var element = layui.element
        var layedit = layui.layedit
        var eleTree = layui.eleTree;
        var upload = layui.upload;
        laydate.render({
            elem: '#startTime'
        });
        laydate.render({
            elem: '#endTime'
        });
        if(returnTpe == '1'){
            var urlList = '/diary/notCommentDiary?useFlag=true&startTime='+startTime+'&endTime='+endTime+'&userId='+userId+'&diaType='+diaType
        }else{
            var urlList = '/diary/notCommentDiary?useFlag=true&startTime='+startTime+'&endTime='+endTime+'&diaType='+$("#diaType").val()
        }
        table.render({
            elem: '#tests',
            skin:'nob'
            , url: urlList
            , defaultToolbar: ['filter', 'exports', 'print', { //自定义头部工具栏右侧图标。如无需自定义，去除该参数即可
                title: '提示'
                , layEvent: 'LAYTABLE_TIPS'
                , icon: 'layui-icon-tips'
            }]
            , title: '用户数据表'
            , cols: [[
                {field: 'diaDate',title: '日志日期', align:'center', width: 150}
                ,{field: 'userId',title: '发起人', align:'center', width: 250, templet: function (d) {
                        if(d.userName==undefined){
                            return ''
                        }else{
                            return d.userName
                        }
                    }}
                ,{field: 'subject',title: '日志标题', align:'center',width: 350, templet: function (d) {
                        // 判断是否返回内容密级
                        var contentSecrecyName = '';
                        if (d.contentSecrecy && d.contentSecrecy !== "") {
                            contentSecrecyName = '<span style="color: red">【' + d.contentSecrecyName + '】</span>';
                        }
                        return contentSecrecyName + d.subject;
                    }}
                ,{field: 'diaType',title: '类型', align:'center',templet: function (d) {
                        if(d.diaType=='0'){
                            return '工作日报'
                        }else if(d.diaType=='1'){
                            return '工作日志'
                        }else if(d.diaType=='2'){
                            return '个人日志'
                        }else if(d.diaType=='3'){
                            return '工作周报'
                        }else if(d.diaType=='4'){
                            return '工作月报'
                        }else {
                            return ''
                        }
                    }}
                ,{field: 'deptName',title: '发起人部门', align:'center', width: 100}
                ,{field: 'readingStatus',title: '阅读状态', align:'center',}
                ,{field: 'commentStatus',title: '点评状态', align:'center',}
                , {field: '', title: '操作', toolbar: '#barDemos',align:'center'}
            ]]
            ,done: function (res, curr, count) {

            }
            , parseData: function (res) { //res 即为原始返回的数据
                return {
                    "code": 0, //解析接口状态
                    "msg": res.msg, //解析提示文本
                    "count": res.totleNum, //解析数据长度
                    "data": res.obj, //解析数据列表
                };
            }
            , page: true
        })
        form.render()
        $(document).on('click','#search',function(){
            var startTime = $("#startTime").val()
            var endTime = $("#endTime").val()
            var userId = $("input[name='userId']").attr('user_id')
            var diaType = $("#diaType").val()
            if(userId != undefined){
                var a = userId.split(',')
                userId = a[0]
            } else {
                userId = ""
            }
            table.render({
                elem: '#tests',
                skin:'nob'
                , url: '/diary/notCommentDiary?useFlag=true&startTime='+startTime+'&endTime='+endTime+'&userId='+userId+'&diaType='+diaType
                , defaultToolbar: ['filter', 'exports', 'print', { //自定义头部工具栏右侧图标。如无需自定义，去除该参数即可
                    title: '提示'
                    , layEvent: 'LAYTABLE_TIPS'
                    , icon: 'layui-icon-tips'
                }]
                , title: '用户数据表'
                , cols: [[
                    {field: 'diaDate',title: '日志日期', align:'center', width: 150}
                    ,{field: 'userId',title: '发起人', align:'center', width: 250, templet: function (d) {
                            if(d.userName==undefined){
                                return ''
                            }else{
                                return d.userName
                            }
                        }}
                    ,{field: 'subject',title: '日志标题', align:'center',width: 350, templet: function (d) {
                            // 判断是否返回内容密级
                            var contentSecrecyName = '';
                            if (d.contentSecrecy && d.contentSecrecy !== "") {
                                contentSecrecyName = '<span style="color: red">【' + d.contentSecrecyName + '】</span>';
                            }
                            return contentSecrecyName + d.subject;
                        }}
                    ,{field: 'diaType',title: '类型', align:'center',templet: function (d) {
                            if(d.diaType=='0'){
                                return '工作日报'
                            }else if(d.diaType=='1'){
                                return '工作日志'
                            }else if(d.diaType=='2'){
                                return '个人日志'
                            }else if(d.diaType=='3'){
                                return '工作周报'
                            }else if(d.diaType=='4'){
                                return '工作月报'
                            }else {
                                return ''
                            }
                        }}
                    ,{field: 'deptName',title: '发起人部门', align:'center', width: 100}
                    ,{field: 'readingStatus',title: '阅读状态', align:'center',}
                    ,{field: 'commentStatus',title: '点评状态', align:'center',}
                    , {field: '', title: '操作', toolbar: '#barDemos',align:'center'}
                ]]
                ,done: function (res, curr, count) {

                }
                , parseData: function (res) { //res 即为原始返回的数据
                    return {
                        "code": 0, //解析接口状态
                        "msg": res.msg, //解析提示文本
                        "count": res.totleNum, //解析数据长度
                        "data": res.obj, //解析数据列表
                    };
                }
                , page: true
            })
        })
        table.on('tool(tests)', function (obj) {
            var diaId = obj.data.diaId
            var startTime = $("#startTime").val()
            var endTime = $("#endTime").val()
            var userId = $("#faqiren").attr('user_id')
            var userName = $("#faqiren").val()
            var diaType = $("#diaType").val()
            if(userId != undefined){
                var a = userId.split(',')
                userId = a[0]
            } else {
                userId = ""
            }
            if(userName != undefined){
                var a = userName.split(',')
                userName = a[0]
            } else {
                userName = ""
            }
            window.location.href = '/diary/logCheck?diaId='+diaId+'&type=noCommentLog'+'&startTime='+startTime+'&endTime='+endTime+'&userId='+userId+'&userName='+ userName+'&diaType='+diaType;
        })
    })

    //获取周一
    function getMonday(date) {
        var day = date.getDay() || 7;
        return new Date(date.getFullYear(), date.getMonth(), date.getDate() + 1 - day);
    };
    //获取周日
    function getSunday(date) {
        var day = date.getDay() || 7;
        return new Date(date.getFullYear(), date.getMonth(), date.getDate() + 7 - day);
    };
    //获取上周一
    function getLastMonday(date) {
        var mondayTime = getMonday(date).getTime();//本周一时间戳
        var oneDayTime = 24 * 60 * 60 * 1000;//一天的时间戳
        var lastMonday = new Date(mondayTime - oneDayTime * 7);//上周一
        return lastMonday;
    };
    //获取上周日
    function getLastSunday(date) {
        var sundayTime = getSunday(date).getTime();//本周日时间戳
        var oneDayTime = 24 * 60 * 60 * 1000;//一天的时间戳
        var lastSunday = new Date(sundayTime - oneDayTime * 7);//上周日
        return lastSunday;
    };
    //日期格式化
    function DateFormat(date, fmt) {
        var o = {
            "M+": date.getMonth() + 1,
            "d+": date.getDate(),
            "h+": date.getHours(),
            "m+": date.getMinutes(),
            "s+": date.getSeconds(),
            "q+": Math.floor((date.getMonth() + 3) / 3),
            "S": date.getMilliseconds()
        };
        if (/(y+)/.test(fmt))
            fmt = fmt.replace(RegExp.$1, (date.getFullYear() + "").substr(4 - RegExp.$1.length));
        for (var k in o)
            if (new RegExp("(" + k + ")").test(fmt))
                fmt = fmt.replace(RegExp.$1, (RegExp.$1.length == 1) ? (o[k]) : (("00" + o[k]).substr(("" + o[k]).length)));
        return fmt;
    };

    //选人员
    $('#faqiren').on('click',function(){
        user_id='faqiren';
        $.popWindow("../common/selectUser?0");
    });
    $(document).on('click','#index',function () {
        window.location.href = '/diary/index';
    })
    $(document).on('click','#logQuery',function () {
        window.location.href = '/diary/logQuery';
    })
    $(document).on('click','#noCommentLog',function () {
        window.location.href = '/diary/noCommentLog';
    })
    $(document).on('click','#reportStatistics',function () {
        window.location.href = '/diary/reportStatistics';
    })
</script>
</html>
