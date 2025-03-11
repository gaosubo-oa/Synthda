<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@taglib prefix="mvc" uri="http://www.springframework.org/tags/form" %>
<%@taglib prefix="fmt" uri="http://www.springframework.org/tags" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
%>

<!DOCTYPE html>
<html>
<head>
    <title>跟踪分析</title>
    <link rel="stylesheet" type="text/css" href="/lib/pagination/style/pagination.css"/>
    <link rel="stylesheet" type="text/css" href="/css/base.css"/>
    <link rel="stylesheet" type="text/css" href="/css/base/base.css?20201106.1"/>
    <link rel="stylesheet" type="text/css" href="/css/news/center.css"/>
    <link rel="stylesheet" href="/lib/laydate/need/laydate.css">
    <link rel="stylesheet" href="/lib/laydate/skins/default/laydate.css">
    <link rel="stylesheet" href="/lib/layui/layui/css/layui.css?20210319.1">
    <link rel="stylesheet" href="/lib/layui/layui-v2.6.8/layui/css/layui.css">
    <script type="text/javascript" src="/js/xoajq/xoajq3.js"></script>
    <script type="text/javascript" src="/js/jquery/jquery-migrate-3.4.0.js"></script>
    <script type="text/javascript" src="/js/base/tablePage.js"></script>
    <script src="/lib/layui/layui/layui.js?20230306.1"></script>

<%--    <script src="=/js/news/page.js"></script>--%>
<%--    <script src="=/js/base/base.js" type="text/javascript" charset="utf-8"></script>--%>
<%--    <script src="=/lib/pagination/js/jquery.pagination.min.js" type="text/javascript" charset="utf-8"></script>--%>
<%--    <script src="=/lib/layer/layer.js?20201106"></script>--%>
<%--    <script src="=/lib/laydate/laydate.js"></script>--%>
<%--    <script src="=/js/sys/citys.js" type="text/javascript" charset="utf-8"></script>--%>
</head>

<style>
    * {
        font-family: "Microsoft Yahei" !important;
    }

    .header {
        margin-top: 15px;
        height: 78px;
        margin: 20px;
    }

    .header .title {
        margin-left: 22px;
    }

    .header span {
        float: none;
        font-size: 22px;
        color: #333;
        display: inline-block;
        margin-left: 10px;
        vertical-align: middle;
        margin-top: -6px;
    }

    .openFile input[type=file] {
        position: absolute;
        top: 0;
        right: 0;
        bottom: 0;
        left: 0;
        width: 100%;
        height: 18px;
        z-index: 99;
        opacity: 0;
    }

    #ajaxforms .layui-form-item .layui-inline {
        margin-bottom: -5px !important;
    }

    .addExecute {
        display: inline-block;
        margin-top: 10px;
    }

    .adduser {
        display: inline-block;
        margin-top: 37px;
    }

    #ajaxforms .layui-form-label {
        width: 107px;
    }

    .layui-btn + .layui-btn {
        margin-left: 6px;
    }

    .layui-table-cell{
        text-align: center!important;
    }
    .layui-table-page{
        text-align: right;
    }
    .laytable-cell-1-0-1{
        cursor: pointer;
    }
</style>


<body>
<div class="header">
    <div class="title">
        <span style=""><fmt:message code="workflow.th.EstimatedCostTrackingAnalysis" /></span>
        <a class="headerhover" href="javascript:;" layadmin-event="refresh" title="<fmt:message code="global.lang.refresh" />"  onclick="javascript:location.reload();">
            <img src="/img/coesBudget/Refresh01.png" style="width: 20px; margin-left: 10px">
        </a>
<%--        <button type="button" class="layui-btn layui-btn-primary layui-border-green">刷新</button>--%>
        <hr style="background-color: black"/>
    </div>
    <div class="hear" style="margin: auto 20px;">
        <form class="layui-form" action="">
            <div class="layui-inline" style="margin-left: -20px">
                <label class="layui-form-label" style="width: 100px"><fmt:message code="workflow.th.job" /></label>
                <div class="layui-input-inline">
                    <input type="text" lay-verify="required|phone" id="runName" name="runName" autocomplete="off"
                           class="layui-input projectYear">
                </div>
            </div>
            <div class="layui-inline year" style="margin: auto 20px">
                <label class="layui-form-label"><fmt:message code="notice.th.state" /></label>
                <div class="layui-input-inline">
                    <select id="status" name="status">
                        <option value=""><fmt:message code="hr.th.PleaseSelect" /></option>
                        <option value="0"><fmt:message code="workflow.th.uninitiated" /></option>
                        <option value="1"><fmt:message code="workflow.th.initiated" /></option>
                    </select>
                </div>
            </div>
            <button type="button" class="layui-btn search"><fmt:message code="global.lang.query" /></button>
            <a href="#" id="yusuan" class="layui-btn layui-btn-normal" style="font-size:14px;display: block;float:right;" ><fmt:message code="workflow.th.BudgetDeclaration" /></a>
        </form>
    </div>
</div>
<div class="tab" style="margin: auto 36px">
    <table class="layui-hide" id="test" lay-filter="test"></table>
</div>
<script type="text/html" id="barDemo">
    <a class="layui-btn layui-btn-xs" lay-event="details" id="details"><fmt:message code="workflow.th.InitiateCostTrackingAnalysis" /></a>
    <a class="layui-btn layui-btn-normal layui-btn-xs" lay-event="alter" id="alter"><fmt:message code="workflow.th.ViewCostTrackingAnalysis" /></a>
</script>
<script>

    var table,eleTree, laydate,eTree,layer;
    var b=true;
    $(function() {
        layui.use(['table', 'laydate', 'layedit'], function () {
            table = layui.table,
                laydate = layui.laydate,
                layer = layui.layer,
                layedit = layui.layedit;


      var tableInfo = table.render({
                elem: '#test'
                , url: '/coesBudget/queryCoesBudgetFlow?flowId=425'
                , page: true
                // ,limits:[10,20,30,40,50]
                , parseData: function (res) { //res 即为原始返回的数据
                    return {
                        "code": 0, //解析接口状态
                        "data": res.obj, //解析数据列表
                        "msg": res.msg,//解析数据列表
                        "count": res.totleNum,
                    };
                },
                // page:true,
                // limit:10,
                where: {
                    useFlag: true,
                },
                request: {
                    pageName: 'page',
                    limitName: 'pageSize'
                },
                cols: [[
                    {field: 'runId', title: '<fmt:message code="workflow.th.liushui" />', align: 'center'}
                    ,{field: 'runName', title: '<fmt:message code="workflow.th.Documentname-number" />', align: 'center',event:'board'
                     ,templet:function(obj){
                            return '<span style="color: #1687cb;">'+obj.runName+'</span>'
                        }}
                    , {field: 'status', title: '<fmt:message code="workflow.th.CostTrackingStatus" />', align: 'center',
                        templet:function(data){
                            if (data.status == '1'){
                                return "<fmt:message code="workflow.th.initiated" />";
                            }else{
                                return "<fmt:message code="workflow.th.uninitiated" />";
                            }

                        }
                    }
                    , {
                        fixed: '', title: '<fmt:message code="notice.th.operation" />', align: 'center',
                        templet: function (data) {
                            if(data.status == '0') {
                                return '<a class="layui-btn layui-btn-xs" lay-event="details" onclick="newBudget(' + data.runId + ')"><fmt:message code="workflow.th.InitiateCostTrackingAnalysis" /></a>';
                            }else {
                                return '<a class="layui-btn layui-btn-normal layui-btn-xs" lay-event="alter" onclick="view(' + data.runId + ')"><fmt:message code="workflow.th.ViewCostTrackingAnalysis" /></a>';
                            }

                        }
                    }
                ]]
                , page: true
            })
            table.on('tool(test)', function (obj){
                let event = obj.event;
                console.log(obj)
                if(event=='board'){
                    window.open('/workflow/work/workformPreView?flowId=425&flowStep=&prcsId=&runId=' + obj.data.runId);
                }

            })
        })
        // $("#yusuan").on("click",function(){
        //     window.open("/workflow/work/newflowguider?flowId=397&flowStep=1&prcsId=1");
        // })

        //预算申报
        $("#yusuan").on("click",function(){
            var  flowId = 425;
            $.ajax({
                url:'../../workflow/work/workfastAdd',
                type:'get',
                dataType:'json',
                data:{
                    flowId:flowId,
                    prcsId : 1,
                    flowStep : 1,
                    runId:'',
                    preView:0
                },
                async: false,//同步请求,这里使用ajax必须使用同步方式请求，因为浏览器认为这种打开在ajax后新页面是不安全的
                success:function(res){
                    if(res.flag==true){
                        var data = res.object;
                        window.open("/workflow/work/workform?opflag=1&flowId=425&type=new&flowStep=1&prcsId=1&tableName=flowRun&runId="+data.flowRun.runId+"&tabId="+data.flowRun.rid+"");
                    }
                }
            });
        })

        //查询
        $('.search').on('click', function() {
            var runName = $('#runName').val();
            var status = $('#status').val();
            var url = "/coesBudget/queryCoesBudgetFlow?flowId=425";
            if (runName != null && runName.trim() != ''){
                url += "&runName="+runName;
            }
            if (status != null && status.trim() != ''){
                url += "&flowStatus="+status;
            }
            table.render({
                elem: '#test',
                url: url,
                page: true
                // ,limits:[10,20,30,40,50]
                , parseData: function (res) { //res 即为原始返回的数据
                    return {
                        "code": 0, //解析接口状态
                        "data": res.obj, //解析数据列表
                        "msg": res.msg,//解析数据列表
                        "count": res.totleNum,
                    };
                },
                // page:true,
                // limit:10,
                where: {
                    useFlag: true,
                },
                request: {
                    pageName: 'page',
                    limitName: 'pageSize'
                },
                cols: [[
                     {field: 'runId', title: '<fmt:message code="workflow.th.liushui" />', align: 'center'}
                    ,{field: 'runName',id:'runName', title: '<fmt:message code="workflow.th.Documentname-number" />',event:'board',align: 'center',templet:function(obj){
                            return '<span style="color: #1687cb;">'+obj.runName+'</span>'
                        }}
                    , {field: 'status', title: '<fmt:message code="workflow.th.CostTrackingStatus" />', align: 'center',
                        templet:function(data){
                            if (data.status == '1'){
                                return "<fmt:message code="workflow.th.initiated" />";
                            }else{
                                return "<fmt:message code="workflow.th.uninitiated" />";
                            }

                        }
                    }
                    , {
                        fixed: '', title: '<fmt:message code="notice.th.operation" />', align: 'center',
                        templet: function (data) {
                            if(data.status == '0') {
                                return '<a class="layui-btn layui-btn-xs" lay-event="details" onclick="newBudget(' + data.runId + ')"><fmt:message code="workflow.th.InitiateCostTrackingAnalysis" /></a>';
                            }else {
                                return '<a class="layui-btn layui-btn-normal layui-btn-xs" lay-event="alter" onclick="view(' + data.runId + ')"><fmt:message code="workflow.th.ViewCostTrackingAnalysis" /></a>';
                            }

                        }
                    }
                ]]
                , page: true
            })
        })
    });

    //查看成本跟踪分析
    function view(runId){
        $.ajax({
            type: 'get',
            url: '/coesBudget/queryCoesBudgetByRunId?runId='+runId,
            dataType: 'json',
            success: function (res) {
                if (res.flag) {
                    window.open(res.msg);
                }else{
                    layer.msg(res.msg, {icon: 0,time:3000});
                }
            }
        })
    }

    //发起成本跟踪分析
    function newBudget(runId){
        $.ajax({
            type: 'get',
            url: '/coesBudget/initiateAnalysis?runId='+runId,
            dataType: 'json',
            success: function (res) {
                if (res.flag) {
                    window.open(res.msg);
                }else{
                    layer.msg(res.msg, {icon: 0,time:3000});
                }
            }
        })
    }

    //



</script>
</body>
</html>
