<%--
  Created by IntelliJ IDEA.
  User: 张继斌
  Date: 2022/4/13
  Time: 16:11
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>汇报统计</title>
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

    <script type="text/javascript" src="/js/echarts.min.js"></script>
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
        color: black;
        /*background-color: white;*/
    }
    .fore{
        /*background-color: #005825 !important;*/
        color: black;
        border-radius: 20px !important;
    }
    .main_head{
        width:98%;
        margin:0 auto;
        text-align: center;
        height: 40px;
        line-height: 40px;
        /*border-bottom: 1px solid #DCE1E6;*/
        /*border-radius: 4px 4px 0 0;*/
        /*box-shadow: 0 1px 2px 0 rgba(0,0,0,.15);*/
    }
    .main{
        box-sizing: border-box;
        display: flex;
        align-items: center;
        width:1080px;
        margin:0 auto;
        background:#fff;
        box-shadow: 0 1px 2px 0 rgba(0,0,0,.15);
        border-radius: 0 0 4px 4px;
    }
    .left{
        width: 49%;
        border: 1px solid rgb(204,204,204);
        height: 350px;
        display: inline-block;
        float: left;
    }
    .lefttop{
        width: 100%;
        display: inline-block;
        height: 30px;
        background-color: rgb(225,235,241);
        border-bottom: 1px solid rgb(204,204,204);
    }
    .lefttopp{
        width: 20%;
        background-color: rgb(48,136,218);
        height: 100%;
        color: white;
        font-weight: bold;
        line-height: 30px;
        padding-left: 10px;
    }
    .right{
        width: 49%;
        border: 1px solid rgb(204,204,204);
        height: 350px;
        display: inline-block;
        margin-left: 15px;
    }
    .righttop{
        width: 100%;
        display: inline-block;
        height: 30px;
        background-color: rgb(225,235,241);
        border-bottom: 1px solid rgb(204,204,204);
    }
    .righttopp{
        width: 20%;
        background-color: rgb(48,136,218);
        height: 100%;
        color: white;
        font-weight: bold;
        line-height: 30px;
        padding-left: 10px;
    }
    .layui-tab-title{
        border-bottom-style: none;
    }
</style>
<link rel="stylesheet" type="text/css" href="/css/commonTheme/${sessionScope.InterfaceModel}/commonTheme.css"/>
<body>
<div class="head w clearfix" style="background: #fff;width:100%;z-index:1000;height:45px;">
    <ul class="index_head clearfix">
        <li id="index" data_id=""><span class="one headli1_1 titName" style="background-color: white !important;">工作日志</span></li>
        <li id="logQuery" data_id=""><span class="two headli1_1 titName" style="background-color: white !important;">日志查询</span></li>
        <li id="noCommentLog" data_id=""><span class="three headli1_1 titName" style="background-color: white !important;">未点评日志</span></li>
        <li id="reportStatistics" data_id=""><span class="fore headli1_1 titName" style="color: #fff;">汇报统计</span></li>
    </ul>
</div>
<div style="top: 60px">
    <div class="main_head">
        <div class="layui-tab layui-tab-brief" lay-filter="docDemoTabBrief" style="margin: 0px">
            <ul class="layui-tab-title" style="display: inline-block;">
                <li class="layui-this workType" type="1">工作日报</li>
                <li id="li2" class="workType" type="3">工作周报</li>
                <li id="li3" class="workType" type="4">工作月报</li>
            </ul>
            <div class="layui-tab-content" style="background-color: white">
                <div class="layui-tab-item layui-show">
                    <div class="left">
                        <span class="lefttop">
                            <p class="lefttopp" style="float: left;">统计表(下属)</p>
                            <p class="lefttopp" id="diaryExcel" style="float: right; text-align: center; padding-left: 0px; cursor: pointer;">导出Excel</p>
                        </span>
                        <div class="biao" style="padding-right: 10px;padding-left: 10px;height: 300px;overflow-y: auto;">
                            <table class="layui-hide" id="tableStatis" lay-filter="tableStatis"></table>
                        </div>
                    </div>
                    <div class="right">
                        <span class="righttop">
                            <p class="righttopp">统计图(下属)</p>
                        </span>
                        <div id="graphStatis" style="width:100%;height:300px;"></div>
                    </div>
                    <div class="left day">
                        <span class="lefttop">
                            <p class="lefttopp">统计表(我的)</p>
                        </span>
                        <div class="biao" style="padding-right: 10px;padding-left: 10px;height: 300px;overflow-y: auto;">
                            <table class="layui-hide" id="tests" lay-filter="tests"></table>
                        </div>
                    </div>
                    <div class="right day">
                        <span class="righttop">
                            <p class="righttopp">统计图(我的)</p>
                        </span>
                        <div id="containerHetong" style="width:100%;height:100%;"></div>
                    </div>
                </div>
                <div class="layui-tab-item">
                    <div class="left">
                        <span class="lefttop">
                            <p class="lefttopp">统计表(下属)</p>
                        </span>
                        <div class="biao" style="padding-right: 10px;padding-left: 10px;height: 300px;overflow-y: auto;">
                            <table class="layui-hide" id="tableStatis2" lay-filter="tableStatis2"></table>
                        </div>
                    </div>
                    <div class="right">
                        <span class="righttop">
                            <p class="righttopp">统计图(下属)</p>
                        </span>
                        <div id="graphStatis2" style="width:100%;height:300px;"></div>
                    </div>
                    <div class="left week" style="display: none">
                        <span class="lefttop">
                            <p class="lefttopp">统计表(我的)</p>
                        </span>
                        <div class="biao" style="padding-right: 10px;padding-left: 10px;height: 300px;overflow-y: auto;">
                            <table class="layui-hide" id="tests2" lay-filter="tests2"></table>
                        </div>
                    </div>
                    <div class="right week" style="display: none">
                        <span class="righttop">
                            <p class="righttopp">统计图(我的)</p>
                        </span>
                        <div id="containerHetong2" style="width:100%;height:100%;"></div>
                    </div>
                </div>
                <div class="layui-tab-item">
                    <div class="left">
                        <span class="lefttop">
                            <p class="lefttopp">统计表(下属)</p>
                        </span>
                        <div class="biao" style="padding-right: 10px;padding-left: 10px;height: 300px;overflow-y: auto;">
                            <table class="layui-hide" id="tableStatis3" lay-filter="tableStatis3"></table>
                        </div>
                    </div>
                    <div class="right">
                        <span class="righttop">
                            <p class="righttopp">统计图(下属)</p>
                        </span>
                        <div id="graphStatis3" style="width:100%;height:300px;"></div>
                    </div>
                    <div class="left month" style="display: none">
                        <span class="lefttop">
                            <p class="lefttopp">统计表(我的)</p>
                        </span>
                        <div class="biao" style="padding-right: 10px;padding-left: 10px;height: 300px;overflow-y: auto;">
                            <table class="layui-hide" id="tests3" lay-filter="tests3"></table>
                        </div>
                    </div>
                    <div class="right month" style="display: none">
                        <span class="righttop">
                            <p class="righttopp">统计图(我的)</p>
                        </span>
                        <div id="containerHetong3" style="width:100%;height:300px;"></div>
                    </div>
                </div>
            </div>
        </div>
    </div>

</div>

</body>
<script id="barDemos" type="text/html">
    <div class="long">
        <a lay-event="edit" class="layui-btn layui-btn-xs" id="edit">查看</a>
    </div>
</script>
<script>
    layui.use(['form', 'table', 'element', 'layedit','upload','laydate'], function () {
        var laydate = layui.laydate;
        var table = layui.table
        var form = layui.form
        var element = layui.element
        var layedit = layui.layedit
        var eleTree = layui.eleTree;
        var upload = layui.upload;
        $('.workType').on('click',function(){
            var types = $(this).attr('type');
            loading_data(types)
        })
        loading_data(1);
        function loading_data(types){
            var USER_PRIV_OTHER = '0';
            if(USER_PRIV_OTHER == 0) {
                //日报
                $(".day").show();
            }else if(USER_PRIV_OTHER == 1){
                //周报
                $(".week").show();
            }else if(USER_PRIV_OTHER == 2){
                //月报
                $(".month").show();
            }
            $.ajax({
                url:"/diary/reportStatistic?diaType=" + types,
                type:"POST",
                dataType:'json',
                success:function(data){
                    if(data.flag) {
                        if(data.object.lower.subordinate){
                            renderTable(types)
                        }
                        if(types == 1){
                            var object = data.object
                            if(object.lower.chart){
                                var rankingmyChart = echarts.init(document.getElementById('graphStatis'));
                                rankingmyChart.setOption(staSubordinates(object.lower));
                            }
                            if(object.me){
                                var staticsmyChart = echarts.init(document.getElementById('containerHetong'));
                                staticsmyChart.setOption(staMine(object.me));
                                if(object.me.reported){
                                    mineTable(types)
                                }
                            }
                        }else if(types == 3){
                            var object = data.object
                            if(object.lower.chart){
                                var rankingmyChart = echarts.init(document.getElementById('graphStatis2'));
                                rankingmyChart.setOption(staSubordinates(object.lower));
                            }
                        }else if(types == 4){
                            var object = data.object
                            if(object.lower.chart){
                                var rankingmyChart = echarts.init(document.getElementById('graphStatis3'));
                                rankingmyChart.setOption(staSubordinates(object.lower));
                            }
                        }

                    }else{
                        layer.msg("加载失败！",{time:800});
                        return false;
                    }
                }
            });
        }
        //下属统计图
        function staSubordinates(data){
            var yiArr = [];
            var weiArr = [];
            var xzhou = data.chart.slice(0,data.chart.length-1);
            xzhou = xzhou.split(',');
            for(var i=0;i<data.chartsum.length;i++){
                for(var key in data.chartsum[i]){
                    if(xzhou.indexOf(key)>=0){
                        yiArr.push(key);
                        weiArr.push(Number(data.chartsum[i][key]));
                    }
                }
            }
            zheoption = {
                xAxis: {
                    type: 'category',
                    axisLabel: {
                        interval:0,
                        rotate:30,
                    },
                    axisLabel: {
                        interval: 0,
                        rotate:40
                    },
                    data: yiArr
                },
                yAxis: {
                    type: 'value'
                },
                series: [{
                    data: weiArr,
                    type: 'bar'
                }]
            };
            return zheoption;
        }
        //我的统计图
        function staMine(data){
            moption = {
                tooltip: {trigger: 'item',formatter: "{a} <br/>{b} : {c} ({d}%)"},
                series : [
                    {
                        name: '2019',
                        type: 'pie',
                        radius : '55%',
                        center: ['50%', '50%'],
                        data:[
                            {value:Number(data.not), name:'未汇报'},
                            {value:Number(data.already), name:'已汇报'},
                        ],
                        color: ['#c03636', '#759e84'],
                        itemStyle: {
                            emphasis: {
                                shadowBlur: 10,
                                shadowOffsetX: 0,
                                shadowColor: 'rgba(0, 0, 0, 0.5)'
                            },
                            normal:{
                                label:{
                                    textStyle:{
                                        fontSize:16
                                    }
                                }
                            }
                        }
                    }]
            };
            return moption;
        }

        //工作日志统计表（我的）
        table.render({
            elem: '#tests'
            , url: '/diary/reportStatistic?diaType=1'
            , title: '用户数据表'
            , parseData: function (res) { //res 即为原始返回的数据
                return {
                    "code": 0, //解析接口状态
                    "msg": res.msg, //解析提示文本
                    "count": res.totleNum, //解析数据长度
                    "data": res.object.me.reported, //解析数据列表
                };
            }
            , cols: [[
                {field: 'subject',title: '日志标题', align:'center',width:'25%',templet: function (d) {
                        // 判断是否返回内容密级
                        var contentSecrecyName = '';
                        if (d.contentSecrecy && d.contentSecrecy !== "") {
                            contentSecrecyName = '<span style="color: red">【' + d.contentSecrecyName + '】</span>';
                        }
                        return contentSecrecyName + d.subject;
                    }}
                ,{field: 'diaDate',title: '日期', align:'center',width:'40%',}
                ,{field: 'diaTypeName',title: '日志类型', align:'center',width:'20%',}
                , {field: '', title: '操作', toolbar: '#barDemos',align:'center',}
            ]]
            , page: true
        })
        function mineTable(type){
            if(type == 1){
                var elem = '#tests'
            }else if(type == 3){
                var elem = '#tests2'
            }else if(type == 4){
                var elem = '#tests3'
            }
            table.render({
                elem: elem
                , url: '/diary/reportStatistic?diaType=' +type
                , title: '用户数据表'
                , parseData: function (res) { //res 即为原始返回的数据
                    return {
                        "code": 0, //解析接口状态
                        "msg": res.msg, //解析提示文本
                        "count": res.totleNum, //解析数据长度
                        "data": res.object.me.reported, //解析数据列表
                    };
                }
                , cols: [[
                    {field: 'subject',title: '日志标题', align:'center',width:'25%',templet: function (d) {
                            // 判断是否返回内容密级
                            var contentSecrecyName = '';
                            if (d.contentSecrecy && d.contentSecrecy !== "") {
                                contentSecrecyName = '<span style="color: red">【' + d.contentSecrecyName + '】</span>';
                            }
                            return contentSecrecyName + d.subject;
                        }}
                    ,{field: 'diaDate',title: '日期', align:'center',width:'40%',}
                    ,{field: 'diaTypeName',title: '日志类型', align:'center',width:'20%',}
                    , {field: '', title: '操作', toolbar: '#barDemos',align:'center',}
                ]]
            })
        }
        function renderTable(type){
            if(type == 1){
                var elem = '#tableStatis'
            }else if(type == 3){
                var elem = '#tableStatis2'
            }else if(type == 4){
                var elem = '#tableStatis3'
            }
            table.render({
                elem: elem
                , url: '/diary/reportStatistic?diaType='+type
                , defaultToolbar: ['filter', 'exports', 'print', { //自定义头部工具栏右侧图标。如无需自定义，去除该参数即可
                    title: '提示'
                    , layEvent: 'LAYTABLE_TIPS'
                    , icon: 'layui-icon-tips'
                }]
                , title: '用户数据表'
                , parseData: function (res) { //res 即为原始返回的数据
                    if (res.object.lower.diaryId != ""){
                        $("#tableStatis").attr("diaIds", res.object.lower.diaryId);
                    }
                    return {
                        "code": 0, //解析接口状态
                        "msg": res.msg, //解析提示文本
                        "count": res.totleNum, //解析数据长度
                        "data": res.object.lower.subordinate, //解析数据列表
                    };
                }
                , cols: [[
                    {field: 'subject',title: '日志标题', align:'center',width:'25%',templet: function (d) {
                            // 判断是否返回内容密级
                            var contentSecrecyName = '';
                            if (d.contentSecrecy && d.contentSecrecy !== "") {
                                contentSecrecyName = '<span style="color: red">【' + d.contentSecrecyName + '】</span>';
                            }
                            return contentSecrecyName + d.subject;
                        }}
                    ,{field: 'diaDate',title: '日期', align:'center',width:'40%',}
                    ,{field: 'diaTypeName',title: '日志类型', align:'center',width:'20%',}
                    , {field: '', title: '操作', toolbar: '#barDemos',align:'center',}
                ]]
            })
            form.render()
        }
        //导出Excel
        $("#diaryExcel").on('click',function(){
            var diaIds = $("#tableStatis").attr("diaIds");
            if(diaIds != undefined && diaIds != "") {
                location.href = '/diary/reportStatisticExcelDiary?diaIds='+diaIds
            } else {
                layer.msg("暂无数据！",{time:800});
            }
        })
        table.on('tool(tests)',function(obj){
            var diaId = obj.data.diaId
            window.location.href = '/diary/logCheck?type=tongji&diaId='+diaId
        })
        table.on('tool(tableStatis)',function(obj){
            var diaId = obj.data.diaId
            window.location.href = '/diary/logCheck?type=tongji&diaId='+diaId
        })
        table.on('tool(tableStatis2)',function(obj){
            var diaId = obj.data.diaId
            window.location.href = '/diary/logCheck?type=tongji&diaId='+diaId
        })
        table.on('tool(tableStatis3)',function(obj){
            var diaId = obj.data.diaId
            window.location.href = '/diary/logCheck?type=tongji&diaId='+diaId
        })
    })
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
