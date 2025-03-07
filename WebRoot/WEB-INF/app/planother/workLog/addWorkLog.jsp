<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@taglib prefix="mvc" uri="http://www.springframework.org/tags/form" %>
<%@taglib prefix="fmt" uri="http://www.springframework.org/tags" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html>
<html>
<head lang="en">
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <title>填报日志</title>
<%--    <link rel="stylesheet" href="/lib/layui/layui/css/layui.css?20190817.1">--%>
    <link rel="stylesheet" href="/lib/layui/layui/css/common.css">
    <link rel="stylesheet" href="/lib/layui/layui/css/eleTree.css">
    <link rel="stylesheet" stype="text/cs" href="/lib/layui/layui/css/layui.css"/>
    <link rel="stylesheet" href="/lib/layui/layui/css/treeTable.css">
    <script src="/lib/layui/layui/layui.js"></script>
    <script type="text/javascript" src="../../js/xoajq/xoajq1.js"></script>
    <script src="/lib/layui/layui/js/limstree.js?v=2019080601" type="text/javascript" charset="utf-8"></script>
    <script src="/lib/layui/layui/js/common.js?v=20190726" type="text/javascript" charset="utf-8"></script>
    <script type="text/javascript" src="/lib/layui/layui/global.js"></script>
    <script src="/js/base/base.js" type="text/javascript" charset="utf-8"></script>
    <script src="/lib/jQuery-File-Upload-master/jquery-ui.js" type="text/javascript" charset="utf-8"></script>
    <script src="/lib/jQuery-File-Upload-master/jquery.iframe-transport.js" type="text/javascript" charset="utf-8"></script>
    <script src="/lib/jQuery-File-Upload-master/jquery.fileupload.js" type="text/javascript" charset="utf-8"></script>
<%--    <script type="text/javascript" src="../../js/common/fileupload.js"></script>--%>
    <script type="text/javascript" src="/js/planother/planotherUtil.js?222021080915083"></script>
    <style>
        .mbox {
            padding: 8px;
        }

        .inbox {
            padding: 5px;
            padding-right: 30px;
        }

        .deptinput {
            display: inline-block;
            width: 75%;
        }

        .layui-btn {
            margin-left: 10px;
        }

        .layui-btn .layui-icon {
            margin-right: 0px;
        }

        .red {
            color: red;
            font-size: 16px;
        }

        .layui-form-label {
            padding: 8px 15px;
        }

        .layui-card-body {
            display: flex;
        }

        .layui-lf {
            min-width: 10%;
            overflow-x: auto;
        }
        .layui-rt {
            width: 93%;
        }
        .tdstyl {
            width: 70px;
        }
        /*客户信息样式*/
        #customerInfo{
            width:100%;
        }
        #customerInfo tr{
            height: 46px !important;
            line-height: 46px;
        }
        #customerInfo tr td{
            height: 38px;
            padding: 4px 15px;
        }
        #customerInfo tr td .layui-form-label{
            width:130px;
        }
        /*项目信息样式*/
        #projectInfo{
            width:100%;
        }
        #projectInfo tr{
            height: 46px !important;
            line-height: 46px;
        }
        #projectInfo tr td{
            height: 38px;
            padding: 4px 15px;
        }
        #projectInfo tr td .layui-form-label{
            width:130px;
        }
        .layui-radio-disbaled>i{
            color:#5FB878 !important;
        }
        .layui-disabled, .layui-disabled:hover{
            color:#666 !important;
        }
        /*.layui-form-select .layui-input{*/
            /*padding-right: 20px;*/
        /*}*/
        /**去掉数字的上下箭头*/
        input::-webkit-outer-spin-button, input::-webkit-inner-spin-button {
            -webkit-appearance: none;
        }
        input[type="number"] {
            -moz-appearance: textfield;
        }
        #layui-treeSelect-body-1578045742906_1_a{
            display: block;
        }
        #__vconsole .vc-switch{
            margin-top: 200px;
        }
        .tdsty2{
            width:30%;
        }
        /*.layui-input{*/
            /*width: 30%;*/
        /*}*/
        /*.layui-form-label{*/
            /*width:15%;*/
        /*}*/
        .disable{
            pointer-events: none;
            cursor: default;
        }

        .textAreaBox{
            width: 100%;
            max-width: 100%;
            cursor: pointer;
            margin: 0px;
            overflow-y:visible;
            min-height: 37px;
        }


        /*#yesterTable td[data-field="completionStatus"] .layui-table-cell .layui-input .layui-unselect{*/
        /*    height: 100%;*/
        /*}*/
        td[data-field="completionStatus"] .layui-table-cell{
            overflow: visible !important;
        }
        .layui-form-select dl {
            z-index: 9999;
        }
        td .layui-form-select {
            margin-top: -9px;
            margin-left: -15px;
            margin-right: -15px;
            border: none;
        }
        .yester_Table, .yester_Table .layui-table-cell,.yester_Table .layui-table-box,.yester_Table .layui-table-body {
            overflow: visible;
        }
        .table_box, .table_box .layui-table-cell,.table_box .layui-table-box,.table_box .layui-table-body,.table_box .ew-tree-table-box {
            overflow: visible !important;
        }
        .yester_Table [data-field="jobContent"] div{
            overflow:hidden;
        }
        .layui-table-box {
            overflow: visible
        }
        .layui-table-body{
            overflow:visible;
        }
       /* .openFile input[type=file]{
            position: absolute;
            top: 0;
            right: 0;
            bottom: 0;
            left: 0;
            width: 100%;
            height: 18px;
            z-index: 99;
            opacity: 0;
        }*/
        /* region 上传附件样式 */
        .file_upload_box {
            position: relative;
            height: 22px;
            overflow: hidden;
        }
        .open_file {
            float: left;
            position:relative;
        }
        .open_file input[type=file] {
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            z-index: 2;
            opacity: 0;
        }

        .progress {
            float: left;
            width: 200px;
            margin-left: 10px;
            margin-top: 2px;
        }

        .bar {
            width: 0%;
            height: 18px;
            background: green;
        }

        .bar_text {
            float: left;
            margin-left: 10px;
        }
        /* endregion */
        [data-field="scheduleBeginDate"] .ew-tree-table-cell-content,
        [data-field="scheduleEndDate"] .ew-tree-table-cell-content,
        [data-field="isComplete"] .ew-tree-table-cell-content,
        [data-field="createUserName"] .ew-tree-table-cell-content
        {
            min-width: 90px;
            /*width: 90px;*/
            padding: 0 5px !important;
        }
        [data-field="scheduleDuration"] .ew-tree-table-cell-content
        {
            min-width: 60px;
            /*width: 90px;*/
            padding: 0 5px !important;
        }
    </style>
</head>
<body>
<div class="mbox" <%--style="padding-bottom: 100px;"--%>>
    <form class="layui-form" lay-filter="formTest">
        <div class="layui-collapse" lay-filter="test">
            <div class="layui-colla-item">
                <div class="layui-colla-content layui-show" style="padding: 0 15px;">
                    <table class="layui-table" lay-skin="line" lay-filter="customerInfoFilter">
                        <tr>
                            <td class="tdstyl">
                                <label class="layui-form-label" style="">日期</label>
                            </td>
                            <td colspan="2" class="tdsty2">
                                <input type="text"  name="fillingDate" id="fillingDate" disabled  autocomplete="off" class="layui-input">
                            </td>
                            <td class="tdstyl">
                                <label class="layui-form-label">天气</label>
                            </td>
                            <td colspan="2" class="tdsty2">
                                <input type="text"  id="water" disabled autocomplete="off" class="layui-input">
                            </td>
                            <td class="tdstyl">
                                <label class="layui-form-label">编制人</label>
                            </td>
                            <td colspan="2" class="tdsty2">
                                <input type="text"  id="createUserName" disabled autocomplete="off" class="layui-input">
                            </td>
                        </tr>
                    </table>
                </div>
            </div>
            <div class="layui-colla-item">
                <h2 style="font-size: 14px;padding: 10px 10px;">
                    今日总结
                </h2>
                <textarea id="planSummary" style="margin: 10px;padding: 10px 0px;width: 98%;height: 100px;"></textarea>
            </div>

            <div class="mbox">

                <div class="layui-card">
                    <div class="layui-card-body" style="padding-left: 6px;">
                        <div class="layui-tab layui-tab-brief" lay-filter="docDemoTabBrief"  style="width: 100%">
                            <ul class="layui-tab-title"  style="width: 100%">
                                <li class="layui-this">进度填报</li>
                                <li>昨日计划今日完成</li>
                                <li>今日其他工作</li>
                                <li>明日工作安排</li>
                            </ul>
                            <div class="layui-tab-content">
                                <div class="layui-tab-item layui-show table_box">
                                    <table class="layui-table" lay-skin="line" id="speedProgress" style="width:500px" lay-filter="speedProgress"></table>
                                </div>
                                <div class="layui-tab-item yester_Table">
                                    <form class="layui-form"  lay-filter="formTest">
                                        <table class="layui-table" lay-skin="line" id="yesterdayWork" lay-filter="yesterdayFilter"></table>
                                    </form>
                                </div>

                                <div class="layui-tab-item ">
                                    <table class="layui-table" lay-skin="line" id="todayWork" lay-filter="todayFilter"></table>
                                    <table class="layui-table" lay-skin="line" id="resources" lay-filter="resourcesFilter"></table>
                                </div>

                                <div class="layui-tab-item ">
                                    <table class="layui-table" lay-skin="line" id="tomorrowWork" style="width:500px" lay-filter="tomorrowFilter"></table>
                                </div>
                            </div>

                        </div>
                    </div>
                </div>
            </div>

            <%--<div class="layui-colla-item">
                <h2 class="layui-colla-title">昨日计划今日完成
                    <input type="hidden">
                </h2>
                <div class="layui-colla-content layui-show" style="padding: 0 15px;" id="yesterTable">
                    <table class="layui-table" id="yesterdayWork" lay-filter="yesterdayFilter"></table>
                </div>
            </div>
            <div class="layui-colla-item">
                <h2 class="layui-colla-title">
                    今日其他工作
                </h2>
                <div class="layui-colla-content layui-show">
                    <table class="layui-table" id="todayWork" lay-filter="todayFilter"></table>
                </div>
                <div class="layui-colla-content layui-show">
                    <table class="layui-table" id="resources" lay-filter="resourcesFilter"></table>
                </div>
            </div>
            <div class="layui-colla-item">
                <h2 class="layui-colla-title">
                    明日工作安排
                </h2>
                <div class="layui-colla-content layui-show">
                    <table id="tomorrowWork" lay-filter="tomorrowFilter"></table>
                </div>
            </div>--%>
        </div>
        <button type="button" id="btnSubmit" lay-filter="btnSubmit" lay-submit style="display: none"></button>
    </form>
</div>
<script type="text/html" id="toolbar">
    <div class="layui-btn-container" style="height: 30px;">
        <input type="button" class="layui-btn layui-btn-sm" lay-event="addTest" value="新增">
        <input type="button" class="layui-btn layui-btn-sm" lay-event="delTest" value="删除">
    </div>
</script>
<script type="text/html" id="toolbar2">
    <div class="layui-btn-container" style="height: 30px;">
        <input type="button" class="layui-btn layui-btn-sm" lay-event="addTest" value="填报">
        <input type="button" class="layui-btn layui-btn-sm" lay-event="delTest" value="删除">
    </div>
</script>

<script type="text/html" id="todayToolbar">
    <div class="layui-btn-container" style="height: 30px;">
        <input type="button" class="layui-btn layui-btn-sm" lay-event="addTest" value="新增">
        <input type="button" class="layui-btn layui-btn-sm" lay-event="updateTest" value="编辑">
        <input type="button" class="layui-btn layui-btn-sm" lay-event="delTest" value="删除">
    </div>
</script>
<script type="text/javascript">
    //    // 获取地址栏参数值
    function getQueryString(name){
        var reg = new RegExp("(^|&)"+ name +"=([^&]*)(&|$)");
        var r = window.location.search.substr(1).match(reg);
        if(r!=null)return  unescape(r[2]); return null;
    }
    //var getWorkPlanData = parent.getWorkPlanData;//日志详情
    //console.log(getWorkPlanData);
    var dataa;
    var workPlanId = getQueryString("workPlanId");
    var yesterdayWorkTable;
    var todayWorkTable;
    var tomorrowWorkTable;
    var speedProgressTable;
    var type = getQueryString("type");
    //console.log(workPlanId);
    var pdata = parent.parentData;


    // var treeData = []

    // 获取数据字典数据
    var dictionaryObj = {
        PROGRESS_TYPE: {},
        SCHEDULE_INPORTANCE:{}
    }
    var dictionaryStr = 'PROGRESS_TYPE,SCHEDULE_INPORTANCE';
    $.get('/plbDictonary/selectDictionaryByDictNos', {plbDictNos: dictionaryStr}, function (res) {
        if (res.flag) {
            for (var dict in dictionaryObj) {
                dictionaryObj[dict] = {object: {}, str: ''}
                if (res.object[dict]) {
                    res.object[dict].forEach(function (item) {
                        dictionaryObj[dict]['object'][item.plbDictNo] = item.dictName;
                        dictionaryObj[dict]['str'] += '<option value=' + item.plbDictNo + '>' + item.dictName + '</option>';
                    });
                }
            }
        }
    });

    var _disabled1 = null

    layui.use(['laydate','table','layer','form','eleTree','element','treeTable'], function () {
        var form = layui.form
            ,layer = layui.layer
            ,$ = layui.jquery
            ,laydate = layui.laydate
            ,element=layui.element
            ,eleTree = layui.eleTree
            ,table = layui.table
            ,treeTable = layui.treeTable;
        var watherFlag=true;
        var workPlan;
        if(workPlanId!=undefined){
            $.ajax({
                url:'/workflow/workLog/getWorkPlanById?workPlanId='+workPlanId,
                dataType:'json',
                type:'post',
                async:false,
                success:function(res){
                    if(res.code===0||res.code==="0"){
                        dataa = res;
                        workPlan= res.obj;
                        $("#fillingDate").val(workPlan.fillingDate);
                        $("#water").val(workPlan.weather);
                        $("#createUserName").val(workPlan.createUserName);
                        $("#planSummary").text(undefind_nullStr(workPlan.planSummary));
                        _disabled1 = workPlan.submitFlag==1
                    }
                }
            })
        }
        if(type == "detail"){ //查看工作日志
            if(workPlan==undefined){
                window.history.go(-1);
                layer.msg("数据错误，请刷新重试")
            }
            //初始化加载昨日工作表格
            var yestDayData =[];
            if(dataa.object.yestDay!=undefined&&dataa.object.yestDay.length>0){
                yestDayData = dataa.object.yestDay;
            }
            yesterdayWorkTable = layui.table.render({
                elem: '#yesterdayWork'
                //, url: '/workflow/workLog/getYestdayWork?workTypes=2'//数据接口status=1,10&
                ,data:yestDayData
                , page: { //支持传入 laypage 组件的所有参数（某些参数除外，如：jump/elem） - 详见文档
                    layout: ['prev', 'page', 'next', 'skip', 'count', 'limit',]//自定义分页布局
                    , limits: [10, 15, 20, 25, 30, 35, 40, 45, 50, 55, 60, 65, 70, 75, 80, 85, 90, 95, 100]
                    , first: false //不显示首页
                    , last: false //不显示尾页
                } //开启分页
                //, toolbar: '#toolbar2'
                , cols: [[ //表头
                    /*{type: 'checkbox'}
                    ,*/ {type: 'numbers', title: '序号',width:50}
                    , {field: 'jobContent', title: '工作内容'}
                    , {field: 'explain', title: '说明'}
                    , {field: 'memo', title: '备注',templet: function (d) {
                            var _disabled = _disabled1
                            return '<input type="text" name="memo" logId="'+d.logId+'" '+(_disabled?'disabled':'')+' class="layui-input" style="height: 100%;'+(_disabled?"background: #e7e7e7":"")+'" value="' + (d.memo||'') + '">'
                        }}
                    , {field: 'completionStatus', title: '*完成状态',templet:function(d){
                            var _disabled = _disabled1
                            var sele;
                            d.confirmYn =1;
                            if(d.editedFlag=="1"){
                                if(d.completionStatus=="0"){
                                    if(d.confirmYn===0||d.confirmYn==="0"){
                                        sele = '<select lay-filter="statusC" disabled '+(_disabled?'disabled':'')+' name="completionStatus"><option tdId='+d.logId+' value="">请选择</option><option tdId='+d.logId+' selected value="0">全部完成</option><option tdId='+d.logId+' value="1">部分完成</option><option tdId='+d.logId+' value="10">未启动</option></select>';
                                    }else{
                                        sele = '<select lay-filter="statusC" '+(_disabled?'disabled':'')+' name="completionStatus"><option tdId='+d.logId+' value="">请选择</option><option tdId='+d.logId+' selected value="0">全部完成</option><option tdId='+d.logId+' value="1">部分完成</option><option tdId='+d.logId+' value="10">未启动</option></select>';
                                    }
                                }else if(d.completionStatus=="1"){
                                    if(d.confirmYn===0||d.confirmYn==="0"){
                                        sele = '<select disabled lay-filter="statusC '+(_disabled?'disabled':'')+'" name="completionStatus"><option tdId='+d.logId+' value="">请选择</option><option tdId='+d.logId+' value="0">全部完成</option><option selected tdId='+d.logId+' value="1">部分完成</option><option tdId='+d.logId+' value="10">未启动</option></select>';
                                    }else{
                                        sele = '<select lay-filter="statusC" '+(_disabled?'disabled':'')+' name="completionStatus"><option tdId='+d.logId+' value="">请选择</option><option tdId='+d.logId+' value="0">全部完成</option><option selected tdId='+d.logId+' value="1">部分完成</option><option tdId='+d.logId+' value="10">未启动</option></select>';
                                    }
                                }else if(d.completionStatus=="10"){
                                    if(d.confirmYn===0||d.confirmYn==="0"){
                                        sele = '<select disabled lay-filter="statusC" '+(_disabled?'disabled':'')+' name="completionStatus"><option tdId='+d.logId+' value="">请选择</option><option tdId='+d.logId+' value="0">全部完成</option><option tdId='+d.logId+' value="1">部分完成</option><option selected tdId='+d.logId+' value="10">未启动</option></select>';
                                    }else{
                                        sele = '<select lay-filter="statusC" '+(_disabled?'disabled':'')+' name="completionStatus"><option tdId='+d.logId+' value="">请选择</option><option tdId='+d.logId+' value="0">全部完成</option><option tdId='+d.logId+' value="1">部分完成</option><option selected tdId='+d.logId+' value="10">未启动</option></select>';
                                    }
                                }else{
                                    if(d.confirmYn===0||d.confirmYn==="0"){
                                        sele = '<select disabled lay-filter="statusC" '+(_disabled?'disabled':'')+' name="completionStatus"><option tdId='+d.logId+' selected value="">请选择</option><option tdId='+d.logId+' value="0">全部完成</option><option  tdId='+d.logId+' value="1">部分完成</option><option tdId='+d.logId+' value="10">未启动</option></select>';
                                    }else{
                                        sele = '<select lay-filter="statusC" '+(_disabled?'disabled':'')+' name="completionStatus"><option tdId='+d.logId+' selected value="">请选择</option><option tdId='+d.logId+' value="0">全部完成</option><option  tdId='+d.logId+' value="1">部分完成</option><option tdId='+d.logId+' value="10">未启动</option></select>';
                                    }
                                }
                            }else {
                                sele = '<select lay-filter="statusC" '+(_disabled?'disabled':'')+' name="completionStatus"><option tdId='+d.logId+' value="">请选择</option><option tdId='+d.logId+' value="0">全部完成</option><option  tdId='+d.logId+' value="1">部分完成</option><option tdId='+d.logId+' value="10">未启动</option></select>';
                            }

                            return sele;
                        }}                      //,{width:100, title: '操作',align:'center', toolbar: '#barOperation'}
                ]]
                , limit: 10
                , done: function (res, curr, count) {
                    form.render();
                }
            });
            //初始化加载今日工作表格
            var toDay =[];
            if(dataa.object.toDay!=undefined&&dataa.object.toDay.length>0){
                toDay = dataa.object.toDay;
            }
            todayWorkTable = layui.table.render({
                elem: '#todayWork'
                //, url: '/workflow/workLog/getTodyWork?planId='+workPlanId//数据接口
                ,data:toDay
                , page: { //支持传入 laypage 组件的所有参数（某些参数除外，如：jump/elem） - 详见文档
                    layout: ['prev', 'page', 'next', 'skip', 'count', 'limit',]//自定义分页布局
                    , limits: [10, 15, 20, 25, 30, 35, 40, 45, 50, 55, 60, 65, 70, 75, 80, 85, 90, 95, 100]
                    , first: false //不显示首页
                    , last: false //不显示尾页
                } //开启分页
                //, toolbar: '#todayToolbar'
                , cols: [[ //表头
                    /*{type: 'checkbox'}
                    ,*/ {type: 'numbers', title: '序号',width:50}
                    , {field: 'jobContent', title: '工作内容'}
                    , {field: 'completionStatus', title: '*完成状态',templet:function(d){
                            if(d.completionStatus=="0"){
                                return "全部完成";
                            }else if(d.completionStatus=="1"){
                                return "部分完成";
                            }else if(d.completionStatus=="10"){
                                return "未启动";
                            }
                        }}
                    , {field: 'explain', title: '说明'}
                    //,{width:100, title: '操作',align:'center', toolbar: '#barOperation'}
                ]]
                , limit: 10
                , done: function (res, curr, count) {
                    form.render();
                    // var table_data = res.data
                    // var trNum = count;
                    // for(let i = 0;i<res.data.length;i++){
                    //     let state = res.data[i].confirmYn; //根据status状态判断，不为0时，禁止勾选
                    //     if(state===0||state==="0"){
                    //         var index = res.data[i]['LAY_TABLE_INDEX'];
                    //         $(".layui-table tr[data-index="+index+"] input[type='checkbox']").prop('disabled',true);
                    //         $(".layui-table tr[data-index="+index+"] input[type='checkbox']").next().addClass('layui-btn-disabled');
                    //         $('.layui-table tr[data-index=' + index + '] input[type="checkbox"]').prop('name', 'eee');
                    //     }
                    // }
                }
            });
            //初始化加载资源情况表格
            resourcesTable = layui.table.render({
                elem: '#resources'
                //, url: '/workflow/workLog/getResources?planId='+workPlanId//数据接口
                ,data:dataa.object.resources
                , page: { //支持传入 laypage 组件的所有参数（某些参数除外，如：jump/elem） - 详见文档
                    layout: ['prev', 'page', 'next', 'skip', 'count', 'limit',]//自定义分页布局
                    , limits: [10, 15, 20, 25, 30, 35, 40, 45, 50, 55, 60, 65, 70, 75, 80, 85, 90, 95, 100]
                    , first: false //不显示首页
                    , last: false //不显示尾页
                } //开启分页
                //, toolbar: '#todayToolbar'
                , cols: [[ //表头
                    /*{type: 'checkbox'}
                    ,*/ {type: 'numbers', title: '序号',width:50}
                    , {field: 'resourceName', title: '资源名称'}
                    , {field: 'resourceTypeName', title: '资源类型'}
                    , {field: 'resourcesNumber', title: '数量'}
                    , {field: 'explain', title: '说明'}
                    //,{width:100, title: '操作',align:'center', toolbar: '#barOperation'}
                ]]
                , limit: 10
                , done: function (res) {
                }
            });
            //初始化加载明日工作表格
            var tomorrow =[];
            if(dataa.object.tomorrow!=undefined&&dataa.object.tomorrow.length>0){
                tomorrow = dataa.object.tomorrow;
            }
            tomorrowWorkTable = layui.table.render({
                elem: '#tomorrowWork'
                //, url: '/workflow/workLog/getTomorrowWork?planId='+workPlanId//数据接口
                ,data:tomorrow
                , page: { //支持传入 laypage 组件的所有参数（某些参数除外，如：jump/elem） - 详见文档
                    layout: ['prev', 'page', 'next', 'skip', 'count', 'limit',]//自定义分页布局
                    , limits: [10, 15, 20, 25, 30, 35, 40, 45, 50, 55, 60, 65, 70, 75, 80, 85, 90, 95, 100]
                    , first: false //不显示首页
                    , last: false //不显示尾页
                } //开启分页
                //, toolbar: '#todayToolbar'
                , cols: [[ //表头
                    /*{type: 'checkbox'}
                    ,*/ {type: 'numbers', title: '序号',width:50}
                    , {field: 'jobContent', title: '工作内容'}
                    , {field: 'explain', title: '说明'}
                    //,{width:100, title: '操作',align:'center', toolbar: '#barOperation'}
                ]]
                , limit: 10
                , done: function (res, curr, count) {
                    // var table_data = res.data
                    // var trNum = count;
                    // for(let i = 0;i<res.data.length;i++){
                    //     let state = res.data[i].confirmYn; //根据status状态判断，不为0时，禁止勾选
                    //     if(state===0||state==="0"){
                    //         var index = res.data[i]['LAY_TABLE_INDEX'];
                    //         $(".layui-table tr[data-index="+index+"] input[type='checkbox']").prop('disabled',true);
                    //         $(".layui-table tr[data-index="+index+"] input[type='checkbox']").next().addClass('layui-btn-disabled');
                    //         $('.layui-table tr[data-index=' + index + '] input[type="checkbox"]').prop('name', 'eee');
                    //     }
                    // }
                }
            });
            $('#fillingDate').attr("readOnly",true);
            $('#planSummary').attr("readOnly",true);
            //$("[name='completionStatus']").attr("disabled",disabled);

            speedProgressTable = layui.treeTable.render({
                elem: '#speedProgress',
                url: '/procedureSchedule/select',//数据接口
                page:true,
                where: {
                    // projId: $('#leftId').attr('projId')||'',
                    // projectId: $('#leftId').attr('projId')||'',
                    delFlag: '0',
                    dataFormStr: "3",
                    byUser: "byUser",
                    sBeginDate: "sBeginDate",
                    haveParent: "haveParent",
                    workPlanId: workPlanId,
                    isClose:"02"
                },
                tree: {
                    iconIndex: 1,
                    idName: 'scheduleId',
                    childName: "child"
                },
                cols: [[//表头
                    // {type: 'radio'},
                    {type: 'numbers'},
                    {field: 'documentNo', title: '编号', minWidth: 120,align:'center'},
                    // {field:'companySort',title:'排序号',minWidth: 100},
                    {field: 'scheduleName', title: '任务名称', minWidth: 200,align:'center'},
                    {field:'scheduleBeginDate',title:'计划开始时间',minWidth: 90,align:'center'},
                    {field: 'scheduleEndDate', title: '计划完成时间', minWidth: 90,align:'center'},
                    {field: 'scheduleDuration', title: '持续时间',minWidth: 60,align:'center'},
                    {field:'beforeSchedule',title:'紧前工序',minWidth: 110,align:'center',templet: function (d) {
                        return '<span>'+(d.beforeSchedule&&d.beforeSchedule.scheduleName||'')+'</span>'
                    }},
                    // {field: 'scheduleType', title: '类型',minWidth: 100,templet: function (d) {
                    //     if(d.scheduleType) {
                    //         return '<span>'+((dictionaryObj&&dictionaryObj['SCHEDULE_INPORTANCE']&&dictionaryObj['SCHEDULE_INPORTANCE']['object'][d.scheduleType])||'')+'</span>'
                    //     }else {
                    //         return ''
                    //     }
                    // }},
                    {field: 'scheduleUserName', title: '责任人',minWidth: 90,align:'center'},
                    {field: 'recordDate', title: '进度开始时间*',minWidth: 120,align:'center',templet: function (d) {
                            var _disabled = (d.record&&d.record.recordBeginDate)||(d.dataForm&&d.dataForm==2)||(d.record&&d.record.isComplete&&d.record.isComplete==1)
                            return '<input type="text" name="recordBeginDate" onfocus="clickdata(this)" class="layui-input" '+(_disabled?'disabled':'')+' style="height: 100%;'+(_disabled?"background: #e7e7e7":"")+'" value="' + (d.record&&d.record.recordBeginDate||'') + '">'
                        }},
                    {field: 'recordDate', title: '进度日期*',minWidth: 120,align:'center',templet: function (d) {
                        var _disabled = (d.dataForm&&d.dataForm==2)||(d.record&&d.record.isComplete&&d.record.isComplete==1)
                        return '<input type="text" scheduleId="'+(d.scheduleId||'')+'" name="recordDate" onfocus="clickdata(this)" class="layui-input" '+(_disabled?'disabled':'')+' style="height: 100%;'+(_disabled?"background: #e7e7e7":"")+'" value="' + (d.record&&d.record.recordDate||'') + '">'
                    }},
                    {field: 'recordProgress', title: '进展情况',minWidth: 160,align:'center',templet: function (d) {
                        var _disabled = (d.dataForm&&d.dataForm==2)||(d.record&&d.record.isComplete&&d.record.isComplete==1)
                        return '<input type="text" name="recordProgress" '+(_disabled?'disabled':'')+' class="layui-input" style="height: 100%;'+(_disabled?"background: #e7e7e7":"")+'" value="' + (d.record&&d.record.recordProgress||'') + '">'
                    }},
                    {field: 'percentComplete', title: '完成百分比*',minWidth: 90,align:'center',templet: function (d) {
                        var percentComplete = d.record&&d.record.percentComplete&&d.record.percentComplete;
                        var _disabled = (d.record&&d.record.isComplete&&d.record.isComplete==1)
                        if(d.dataForm&&d.dataForm==3){
                            return '<select name="percentComplete" '+(_disabled?'disabled':'')+' class="layui-input" style="height: 100%;" >' +
                                '<option value="">请选择</option>' +
                                '<option value="10" '+(percentComplete=='10'?'selected':'')+'>10</option>' +
                                '<option value="20" '+(percentComplete=='20'?'selected':'')+'>20</option>' +
                                '<option value="30" '+(percentComplete=='30'?'selected':'')+'>30</option>' +
                                '<option value="40" '+(percentComplete=='40'?'selected':'')+'>40</option>' +
                                '<option value="50" '+(percentComplete=='50'?'selected':'')+'>50</option>' +
                                '<option value="60" '+(percentComplete=='60'?'selected':'')+'>60</option>' +
                                '<option value="70" '+(percentComplete=='70'?'selected':'')+'>70</option>' +
                                '<option value="80" '+(percentComplete=='80'?'selected':'')+'>80</option>' +
                                '<option value="90" '+(percentComplete=='90'?'selected':'')+'>90</option>' +
                                '<option value="100" '+(percentComplete=='100'?'selected':'')+'>100</option>' +
                                '</select>'
                        }else {
                            return '<input type="number" name="percentComplete" disabled class="layui-input" style="height: 100%;background: #e7e7e7" value="' + (d.record&&d.record.percentComplete||'') + '">'
                        }

                    }},
                    {field: 'isComplete', title: '实际进度状态',minWidth: 90,align:'center',templet: function (d) {
                        if(d.record&&d.record.isComplete){
                            if(d.record.isComplete==0){
                                return '<span>未完成</span>'
                            }else if(d.record.isComplete==1){
                                return '<span>完成</span>'
                            }
                        }else {
                            return '<span>未完成</span>'
                        }
                    }},
                    {field: 'createUserName', title: '填报人',minWidth: 90,align:'center', sort: false, hide: false}
                ]],
                // request: {
                //     pageName: 'page' //页码的参数名称，默认：page
                //     ,limitName: 'pageSize' //每页数据量的参数名，默认：limit
                // },
                done: function (res, curr, count) {
                    $(".ew-tree-table-box [data-field='percentComplete'] .ew-tree-table-cell-content").css('overflow', 'visible');

                    //遍历表格获取每行数据
                    var $trs = $('.table_box').find('.layui-table tbody tr select[name="percentComplete"]');
                    $trs.each(function (index) {
                        if($(this).attr('disabled')){
                            $(this).next().find('input').css('background', '#e7e7e7')
                        }
                    })
                }
            });


        }else{ //填报工作日志
            // laydate.render({
            //     elem: '#fillingDate',// input里时间的Id
            //     value: $("#fillingDate").val()? false:new Date(),
            //     done: function (value, date) {
            //     }
            // });
            $.get('/sys/getInterfaceInfo', function (json){
                if (json.flag) {
                    if(json.object.weatherCity!=1){
                        // window.onload = loadScript;
                        loadScript()
                    }
                }
            }, 'json')
            function loadScript() {
                var script = document.createElement("script");
                script.src = "http://api.map.baidu.com/api?v=2.0&ak=7HSdUGqKaz5U0ph0LIQ2Qd4rFmFZA2kY&callback=getweatherBefore";//此为v2.0版本的引用方式,加载完成后执行getweatherBefore事件
                document.body.appendChild(script);
            }
            //初始化加载昨日工作表格
            yesterdayWorkTable = layui.table.render({
                elem: '#yesterdayWork'
                , url: '/workflow/workLog/getYestdayWork?workTypes=2&planId='+workPlanId //数据接口status=1,10&
                , page: { //支持传入 laypage 组件的所有参数（某些参数除外，如：jump/elem） - 详见文档
                    layout: ['prev', 'page', 'next', 'skip', 'count', 'limit',]//自定义分页布局
                    , limits: [10, 15, 20, 25, 30, 35, 40, 45, 50, 55, 60, 65, 70, 75, 80, 85, 90, 95, 100]
                    , first: false //不显示首页
                    , last: false //不显示尾页
                } //开启分页
                //, toolbar: '#toolbar2'
                , cols: [[ //表头
                    {type: 'checkbox'}
                    , {type: 'numbers', title: '序号',width:50}
                    , {field: 'jobContent', title: '工作内容'}
                    , {field: 'explain', title: '说明'}
                    , {field: 'memo', title: '备注',templet: function (d) {
                            var _disabled = _disabled1
                            return '<input type="text" name="memo" logId="'+d.logId+'" '+(_disabled?'disabled':'')+' class="layui-input" style="height: 100%;'+(_disabled?"background: #e7e7e7":"")+'" value="' + (d.memo||'') + '">'
                        }}
                    , {field: 'completionStatus', title: '*完成状态',templet:function(d){
                            var _disabled = _disabled1
                            var sele;
                            d.confirmYn =1;
                            if(d.editedFlag=="1"){
                                if(d.completionStatus=="0"){
                                    if(d.confirmYn===0||d.confirmYn==="0"){
                                        sele = '<select lay-filter="statusC" disabled '+(_disabled?'disabled':'')+' name="completionStatus"><option tdId='+d.logId+' value="">请选择</option><option tdId='+d.logId+' selected value="0">全部完成</option><option tdId='+d.logId+' value="1">部分完成</option><option tdId='+d.logId+' value="10">未启动</option></select>';
                                    }else{
                                        sele = '<select lay-filter="statusC" '+(_disabled?'disabled':'')+' name="completionStatus"><option tdId='+d.logId+' value="">请选择</option><option tdId='+d.logId+' selected value="0">全部完成</option><option tdId='+d.logId+' value="1">部分完成</option><option tdId='+d.logId+' value="10">未启动</option></select>';
                                    }
                                }else if(d.completionStatus=="1"){
                                    if(d.confirmYn===0||d.confirmYn==="0"){
                                        sele = '<select disabled lay-filter="statusC '+(_disabled?'disabled':'')+'" name="completionStatus"><option tdId='+d.logId+' value="">请选择</option><option tdId='+d.logId+' value="0">全部完成</option><option selected tdId='+d.logId+' value="1">部分完成</option><option tdId='+d.logId+' value="10">未启动</option></select>';
                                    }else{
                                        sele = '<select lay-filter="statusC" '+(_disabled?'disabled':'')+' name="completionStatus"><option tdId='+d.logId+' value="">请选择</option><option tdId='+d.logId+' value="0">全部完成</option><option selected tdId='+d.logId+' value="1">部分完成</option><option tdId='+d.logId+' value="10">未启动</option></select>';
                                    }
                                }else if(d.completionStatus=="10"){
                                    if(d.confirmYn===0||d.confirmYn==="0"){
                                        sele = '<select disabled lay-filter="statusC" '+(_disabled?'disabled':'')+' name="completionStatus"><option tdId='+d.logId+' value="">请选择</option><option tdId='+d.logId+' value="0">全部完成</option><option tdId='+d.logId+' value="1">部分完成</option><option selected tdId='+d.logId+' value="10">未启动</option></select>';
                                    }else{
                                        sele = '<select lay-filter="statusC" '+(_disabled?'disabled':'')+' name="completionStatus"><option tdId='+d.logId+' value="">请选择</option><option tdId='+d.logId+' value="0">全部完成</option><option tdId='+d.logId+' value="1">部分完成</option><option selected tdId='+d.logId+' value="10">未启动</option></select>';
                                    }
                                }else{
                                    if(d.confirmYn===0||d.confirmYn==="0"){
                                        sele = '<select disabled lay-filter="statusC" '+(_disabled?'disabled':'')+' name="completionStatus"><option tdId='+d.logId+' selected value="">请选择</option><option tdId='+d.logId+' value="0">全部完成</option><option  tdId='+d.logId+' value="1">部分完成</option><option tdId='+d.logId+' value="10">未启动</option></select>';
                                    }else{
                                        sele = '<select lay-filter="statusC" '+(_disabled?'disabled':'')+' name="completionStatus"><option tdId='+d.logId+' selected value="">请选择</option><option tdId='+d.logId+' value="0">全部完成</option><option  tdId='+d.logId+' value="1">部分完成</option><option tdId='+d.logId+' value="10">未启动</option></select>';
                                    }
                                }
                            }else {
                                sele = '<select lay-filter="statusC" '+(_disabled?'disabled':'')+' name="completionStatus"><option tdId='+d.logId+' value="">请选择</option><option tdId='+d.logId+' value="0">全部完成</option><option  tdId='+d.logId+' value="1">部分完成</option><option tdId='+d.logId+' value="10">未启动</option></select>';
                            }

                            return sele;
                        }}                  //,{width:100, title: '操作',align:'center', toolbar: '#barOperation'}
                ]]
                , limit: 10
                , done: function (res, curr, count) {
                    form.render();
                    // var table_data = res.data
                    // var trNum = count;
                    // for(let i = 0;i<res.data.length;i++){
                    //     let state = res.data[i].confirmYn; //根据status状态判断，不为0时，禁止勾选
                    //     if(state===0||state==="0"){
                    //         var index = res.data[i]['LAY_TABLE_INDEX'];
                    //         $(".layui-table tr[data-index="+index+"] input[type='checkbox']").prop('disabled',true);
                    //         $(".layui-table tr[data-index="+index+"] input[type='checkbox']").next().addClass('layui-btn-disabled');
                    //         $('.layui-table tr[data-index=' + index + '] input[type="checkbox"]').prop('name', 'eee');
                    //     }
                    // }
                }
            });
            //初始化加载今日工作表格
            todayWorkTable = layui.table.render({
                elem: '#todayWork'
                , url: '/workflow/workLog/getTodyWork?planId='+workPlanId//数据接口
                , page: { //支持传入 laypage 组件的所有参数（某些参数除外，如：jump/elem） - 详见文档
                    layout: ['prev', 'page', 'next', 'skip', 'count', 'limit',]//自定义分页布局
                    , limits: [10, 15, 20, 25, 30, 35, 40, 45, 50, 55, 60, 65, 70, 75, 80, 85, 90, 95, 100]
                    , first: false //不显示首页
                    , last: false //不显示尾页
                } //开启分页
                , toolbar: '#todayToolbar'
                , cols: [[ //表头
                    {type: 'checkbox'}
                    , {type: 'numbers', title: '序号',width:50}
                    , {field: 'jobContent', title: '工作内容'}
                    , {field: 'completionStatus', title: '*完成状态',templet:function(d){
                            if(d.completionStatus=="0"){
                                return "全部完成";
                            }else if(d.completionStatus=="1"){
                                return "部分完成";
                            }else if(d.completionStatus=="10"){
                                return "未启动";
                            }
                        }}
                    , {field: 'explain', title: '说明'}
                    //,{width:100, title: '操作',align:'center', toolbar: '#barOperation'}
                ]]
                , limit: 10
                , done: function (res, curr, count) {
                    form.render();
                    // var table_data = res.data
                    // var trNum = count;
                    // for(let i = 0;i<res.data.length;i++){
                    //     let state = res.data[i].confirmYn; //根据status状态判断，不为0时，禁止勾选
                    //     if(state===0||state==="0"){
                    //         var index = res.data[i]['LAY_TABLE_INDEX'];
                    //         $(".layui-table tr[data-index="+index+"] input[type='checkbox']").prop('disabled',true);
                    //         $(".layui-table tr[data-index="+index+"] input[type='checkbox']").next().addClass('layui-btn-disabled');
                    //         $('.layui-table tr[data-index=' + index + '] input[type="checkbox"]').prop('name', 'eee');
                    //     }
                    // }
                }
            });
            //初始化加载资源情况表格
            resourcesTable = layui.table.render({
                elem: '#resources'
                , url: '/workflow/workLog/getResources?planId='+workPlanId//数据接口
                , page: { //支持传入 laypage 组件的所有参数（某些参数除外，如：jump/elem） - 详见文档
                    layout: ['prev', 'page', 'next', 'skip', 'count', 'limit',]//自定义分页布局
                    , limits: [10, 15, 20, 25, 30, 35, 40, 45, 50, 55, 60, 65, 70, 75, 80, 85, 90, 95, 100]
                    , first: false //不显示首页
                    , last: false //不显示尾页
                } //开启分页
                , toolbar: '#todayToolbar'
                , cols: [[ //表头
                    {type: 'checkbox'}
                    , {type: 'numbers', title: '序号',width:50}
                    , {field: 'resourceName', title: '资源名称'}
                    , {field: 'resourceTypeName', title: '资源类型'}
                    , {field: 'resourcesNumber', title: '数量'}
                    , {field: 'explain', title: '说明'}
                    //,{width:100, title: '操作',align:'center', toolbar: '#barOperation'}
                ]]
                , limit: 10
                , done: function (res) {
                }
            });
            //初始化加载明日工作表格
            tomorrowWorkTable = layui.table.render({
                elem: '#tomorrowWork'
                , url: '/workflow/workLog/getTomorrowWork?planId='+workPlanId//数据接口
                , page: { //支持传入 laypage 组件的所有参数（某些参数除外，如：jump/elem） - 详见文档
                    layout: ['prev', 'page', 'next', 'skip', 'count', 'limit',]//自定义分页布局
                    , limits: [10, 15, 20, 25, 30, 35, 40, 45, 50, 55, 60, 65, 70, 75, 80, 85, 90, 95, 100]
                    , first: false //不显示首页
                    , last: false //不显示尾页
                } //开启分页
                , toolbar: '#todayToolbar'
                , cols: [[ //表头
                    {type: 'checkbox'}
                    , {type: 'numbers', title: '序号',width:50}
                    , {field: 'jobContent', title: '工作内容'}
                    , {field: 'explain', title: '说明'}
                    //,{width:100, title: '操作',align:'center', toolbar: '#barOperation'}
                ]]
                , limit: 10
                , done: function (res, curr, count) {
                    // var table_data = res.data
                    // var trNum = count;
                    // for(let i = 0;i<res.data.length;i++){
                    //     let state = res.data[i].confirmYn; //根据status状态判断，不为0时，禁止勾选
                    //     if(state===0||state==="0"){
                    //         var index = res.data[i]['LAY_TABLE_INDEX'];
                    //         $(".layui-table tr[data-index="+index+"] input[type='checkbox']").prop('disabled',true);
                    //         $(".layui-table tr[data-index="+index+"] input[type='checkbox']").next().addClass('layui-btn-disabled');
                    //         $('.layui-table tr[data-index=' + index + '] input[type="checkbox"]').prop('name', 'eee');
                    //     }
                    // }
                }
            });

            speedProgressTable = layui.treeTable.render({
                elem: '#speedProgress',
                url: '/procedureSchedule/select',//数据接口
                page:true,
                where: {
                    // projId: $('#leftId').attr('projId')||'',
                    // projectId: $('#leftId').attr('projId')||'',
                    delFlag: '0',
                    dataFormStr: "3",
                    byUser: "byUser",
                    sBeginDate: "sBeginDate",
                    haveParent: "haveParent",
                    workPlanId:workPlanId,
                    isClose:"02"
                },
                tree: {
                    iconIndex: 1,
                    idName: 'scheduleId',
                    childName: "child"
                },
                cols: [[//表头
                    // {type: 'radio'},
                    {type: 'numbers'},
                    {field: 'documentNo', title: '编号', minWidth: 120,align:'center'},
                    // {field:'companySort',title:'排序号',minWidth: 100},
                    {field: 'scheduleName', title: '任务名称', minWidth: 200,align:'center'},
                    {field:'scheduleBeginDate',title:'计划开始时间',minWidth: 90,align:'center'},
                    {field: 'scheduleEndDate', title: '计划完成时间', minWidth: 90,align:'center'},
                    {field: 'scheduleDuration', title: '持续时间',minWidth: 60,align:'center'},
                    {field:'beforeSchedule',title:'紧前工序',minWidth: 110,align:'center',templet: function (d) {
                            return '<span>'+(d.beforeSchedule&&d.beforeSchedule.scheduleName||'')+'</span>'
                        }},
                    // {field: 'scheduleType', title: '类型',minWidth: 100,templet: function (d) {
                    //     if(d.scheduleType) {
                    //         return '<span>'+((dictionaryObj&&dictionaryObj['SCHEDULE_INPORTANCE']&&dictionaryObj['SCHEDULE_INPORTANCE']['object'][d.scheduleType])||'')+'</span>'
                    //     }else {
                    //         return ''
                    //     }
                    // }},
                    {field: 'scheduleUserName', title: '责任人',minWidth: 90,align:'center'},
                    {field: 'recordDate', title: '进度开始时间*',minWidth: 120,align:'center',templet: function (d) {
                            var _disabled = (d.record&&d.record.recordBeginDate)||(d.dataForm&&d.dataForm==2)||(d.record&&d.record.isComplete&&d.record.isComplete==1)
                            return '<input type="text" name="recordBeginDate" onfocus="clickdata(this)" class="layui-input" '+(_disabled?'disabled':'')+' style="height: 100%;'+(_disabled?"background: #e7e7e7":"")+'" value="' + (d.record&&d.record.recordBeginDate||'') + '">'
                        }},
                    {field: 'recordDate', title: '进度日期*',minWidth: 120,align:'center',templet: function (d) {
                            var _disabled = (d.dataForm&&d.dataForm==2)||(d.record&&d.record.isComplete&&d.record.isComplete==1)
                            return '<input type="text" scheduleId="'+(d.scheduleId||'')+'" name="recordDate" onfocus="clickdata(this)" class="layui-input" '+(_disabled?'disabled':'')+' style="height: 100%;'+(_disabled?"background: #e7e7e7":"")+'" value="' + (d.record&&d.record.recordDate||'') + '">'
                        }},
                    {field: 'recordProgress', title: '进展情况',minWidth: 160,align:'center',templet: function (d) {
                            var _disabled = (d.dataForm&&d.dataForm==2)||(d.record&&d.record.isComplete&&d.record.isComplete==1)
                            return '<input type="text" name="recordProgress" '+(_disabled?'disabled':'')+' class="layui-input" style="height: 100%;'+(_disabled?"background: #e7e7e7":"")+'" value="' + (d.record&&d.record.recordProgress||'') + '">'
                        }},
                    {field: 'percentComplete', title: '完成百分比*',minWidth: 90,align:'center',templet: function (d) {
                            var percentComplete = d.record&&d.record.percentComplete&&d.record.percentComplete;
                            var _disabled = (d.record&&d.record.isComplete&&d.record.isComplete==1)
                            if(d.dataForm&&d.dataForm==3){
                                return '<select name="percentComplete" '+(_disabled?'disabled':'')+' class="layui-input" style="height: 100%;" >' +
                                    '<option value="">请选择</option>' +
                                    '<option value="10" '+(percentComplete=='10'?'selected':'')+'>10</option>' +
                                    '<option value="20" '+(percentComplete=='20'?'selected':'')+'>20</option>' +
                                    '<option value="30" '+(percentComplete=='30'?'selected':'')+'>30</option>' +
                                    '<option value="40" '+(percentComplete=='40'?'selected':'')+'>40</option>' +
                                    '<option value="50" '+(percentComplete=='50'?'selected':'')+'>50</option>' +
                                    '<option value="60" '+(percentComplete=='60'?'selected':'')+'>60</option>' +
                                    '<option value="70" '+(percentComplete=='70'?'selected':'')+'>70</option>' +
                                    '<option value="80" '+(percentComplete=='80'?'selected':'')+'>80</option>' +
                                    '<option value="90" '+(percentComplete=='90'?'selected':'')+'>90</option>' +
                                    '<option value="100" '+(percentComplete=='100'?'selected':'')+'>100</option>' +
                                    '</select>'
                            }else {
                                return '<input type="number" name="percentComplete" disabled class="layui-input" style="height: 100%;background: #e7e7e7" value="' + (d.record&&d.record.percentComplete||'') + '">'
                            }

                        }},
                    {field: 'isComplete', title: '实际进度状态',minWidth: 90,align:'center',templet: function (d) {
                            if(d.record&&d.record.isComplete){
                                if(d.record.isComplete==0){
                                    return '<span>未完成</span>'
                                }else if(d.record.isComplete==1){
                                    return '<span>完成</span>'
                                }
                            }else {
                                return '<span>未完成</span>'
                            }
                        }},
                    {field: 'createUserName', title: '填报人',minWidth: 90,align:'center', sort: false, hide: false}
                ]],
                // request: {
                //     pageName: 'page' //页码的参数名称，默认：page
                //     ,limitName: 'pageSize' //每页数据量的参数名，默认：limit
                // },
                done: function (res, curr, count) {
                    $(".ew-tree-table-box [data-field='percentComplete'] .ew-tree-table-cell-content").css('overflow', 'visible');

                    //遍历表格获取每行数据
                    var $trs = $('.table_box').find('.layui-table tbody tr select[name="percentComplete"]');
                    $trs.each(function (index) {
                        if($(this).attr('disabled')){
                            $(this).next().find('input').css('background', '#e7e7e7')
                        }
                    })
                }
            });
        }
        //监听完成状态下拉列表
        form.on('select(statusC)', function(data){
            var workId = $(data.elem[data.elem.selectedIndex]).attr("tdId");
            var workLog = {
                logId:workId,
                completionStatus:data.value
            }
            $.ajax({
                url:"/workflow/workLog/updateManager",
                data:workLog,
                dataType:"json",
                success:function(res){
                    if(data.value=="1"||data.value=="10"){//部分完成或未启动
                        var works = {
                            workType:"2",
                            completionStatus:data.value,
                            logId:workId
                        }
                        //执行新增
                        $.ajax({
                            url:"/workflow/workLog/copyWork?workPlanId="+workPlanId,
                            data:works,
                            dataType:"json",
                            success:function(res){
                                if(res.code==="0"||res.code===0){
                                    layer.msg(res.msg);
                                    tomorrowWorkTable.reload();
                                }else{
                                    layer.msg(res.msg);
                                }
                            }
                        })
                    }else if(data.value=="0"){//全部完成
                        var works = {
                            completionStatus:"0",
                            logOldId:workId,
                            workPlanId:workPlanId,
                        }
                        //执行新增
                        $.ajax({
                            url:"/workflow/workLog/changeWork",
                            data:works,
                            dataType:"json",
                            success:function(res){
                                if(res.code==="0"||res.code===0){
                                    tomorrowWorkTable.reload();
                                }
                            }
                        })
                    }
                }
            })
        });

        //昨日表格头事件
        table.on('toolbar(yesterdayFilter)', function (obj) {
            var events = obj.event;
            var datas = table.checkStatus('formTable1').data;
            // 新增
            if (events == 'addTest') {
                layer.open({
                    type: 1,
                    skin: 'layui-layer-molv', //加上边框
                    area: ['80%', '90%'], //宽高
                    title: '选择昨日工作计划',
                    maxmin: true,
                    btn: ['提交', '取消'],
                    content: '<form class="layui-form" id="form1" lay-filter="formTest1"><div class="layui-form" style="margin-top: 20px;">' +
                        '<div class="layui-form-item">\n' +
                        '    <div class="layui-inline" style="width: 98%;">\n' +
                        '         <label class="layui-form-label" style="width: 11%"><span style="color:red">*</span>工作内容</label>\n' +
                        '         <div class="layui-input-inline" style="width: 84%;">\n' +
                        '         <textarea type="text" id="jobContent" style="min-height: 100px !important;float: left;width:85%" autocomplete="off" class="layui-input"></textarea><input style="width: 12%;float: right" class="layui-btn" type="button" id="close" value="选择">' +
                        '         </div>\n' +
                        '    </div>\n' +
                        '</div>\n' +
                        '<div class="layui-form-item">\n' +
                        '    <div style="width: 98%;">\n' +
                        '         <label class="layui-form-label" style="width: 11%"><span style="color:red">*</span>完成状态</label>\n' +
                        '         <div style="width: 84%;float: left">\n' +
                        '             <select id="completionStatus"><option value="">请选择<option><option value="0">全部完成</option><option value="1">部分完成</option><option value="10">未启动</option></select>\n' +
                        '         </div>\n' +
                        '    </div>\n' +
                        '</div>\n' +
                        '<div class="layui-form-item">\n' +
                        '    <div class="layui-inline" style="width: 98%;">\n' +
                        '         <label class="layui-form-label" style="width: 11%">说明</label>\n' +
                        '         <div class="layui-input-inline" style="width: 84%;">\n' +
                        '             <textarea type="text" id="explain" style="min-height: 100px !important;" autocomplete="off" class="layui-input"></textarea>' +
                        '         </div>\n' +
                        '<input hidden id="attachmentId" name="attachmentId"/>'+
                        '<input hidden id="attachmentName" name="attachmentName"/>'+
                        '    </div>\n' +
                        '</div>\n' +
                        '</div></form>',
                    success: function () {
                        form.render("select");//初始化表单
                    },
                    yes: function (index, layero) {
                        var jobContent = $("#jobContent").val();//工作内容
                        var completionStatus = $("#completionStatus").next('.layui-form-select').find('dl dd.layui-this').attr('lay-value'); //完成状态
                        var explain = $("#explain").text();//说明

                        if(jobContent==undefined||jobContent==""){
                            layer.msg("请填写工作内容");
                            return false;
                        }else if(completionStatus==undefined||completionStatus==""){
                            layer.msg("请选择完成状态");
                            return false;
                        }else {
                            var works = {
                                jobContent:jobContent,
                                completionStatus:completionStatus,
                                workPlanId:workPlanId
                            }
                            //执行新增
                            $.ajax({
                                url:"",
                                data:works,
                                dataType:"json",
                                success:function(res){
                                    if(res.code==="0"||res.code===0){
                                        layer.msg(res.msg);
                                        yesterdayWorkTable.reload();
                                    }else{
                                        layer.msg(res.msg);
                                    }
                                }
                            })
                        }
                    }
                });
            }
        })

        //今日日表格头事件
        table.on('toolbar(todayFilter)', function (obj) {
            var events = obj.event;
            var datas = table.checkStatus('todayWork').data;
            // 新增
            if (events == 'addTest') {
                layer.open({
                    type: 1,
                    skin: 'layui-layer-molv', //加上边框
                    area: ['80%', '90%'], //宽高
                    title: '今日工作填报',
                    maxmin: true,
                    btn: ['提交', '取消'],
                    content: '<form class="layui-form" id="form1" lay-filter="formTest1"><div class="layui-form" style="margin-top: 20px;">' +
                        '<div class="layui-form-item">\n' +
                        '    <div class="layui-inline" style="width: 98%;">\n' +
                        '         <label class="layui-form-label" style="width: 11%"><span style="color:red">*</span>工作内容</label>\n' +
                        '         <div class="layui-input-inline" style="width: 84%;">\n' +
                        '         <textarea type="text" id="jobContent" style="min-height: 75px !important;float: left;" autocomplete="off" class="layui-input"></textarea>' +//<input style="width: 12%;float: right" class="layui-btn" type="button" id="close" value="选择">
                        '         </div>\n' +
                        '    </div>\n' +
                        '</div>\n' +
                        '<div class="layui-form-item">\n' +
                        '    <div style="width: 98%;">\n' +
                        '         <label class="layui-form-label" style="width: 11%"><span style="color:red">*</span>完成状态</label>\n' +
                        '         <div style="width: 84%;float: left">\n' +
                        '             <select id="completionStatus"><option value="">请选择<option><option value="0">全部完成</option><option value="1">部分完成</option><option value="10">未启动</option></select>\n' +
                        '         </div>\n' +
                        '    </div>\n' +
                        '</div>\n' +
                        '<div class="layui-form-item" style="margin-bottom:0;">\n' +
                        '    <div class="layui-inline" style="width: 98%;">\n' +
                        '         <label class="layui-form-label" style="width: 11%">说明</label>\n' +
                        '         <div class="layui-input-inline" style="width: 84%;">\n' +
                        '             <textarea type="text" id="explain" style="min-height: 75px !important;" autocomplete="off" class="layui-input"></textarea>' +
                        '         </div>\n' +
                        '</div>\n' +
                        '</div>\n' +
                        '<div class="layui-input-inline" style="margin-left: 130px;">\n' +
                        '    <div class="layui-inline" style="width: 98%;">\n' +
                        '         <label class="layui-form-label" style="width: 10%">附件</label>\n' +
                        '         <div class="layui-input-inline" style="width: 90%;">\n' +
                        '             <div class="file_module">' +
                        '                  <div id="fileContent" class="file_content"></div>' +
                        '                  <div class="file_upload_box">' +
                        '                       <a href="javascript:;" class="open_file">' +
                        '                            <img src="/img/mg11.png" style="margin: -3px 5px 0 0;"><span>添加附件</span>' +
                        '                            <input type="file" multiple id="fileupload" data-url="/upload?module=workflow" name="file">' +
                        '                       </a>' +
                        '                       <div class="progress" id="progress">' +
                        '                             <div class="bar"></div>\n' +
                        '                       </div>' +
                        '                       <div class="bar_text"></div>' +
                        '                  </div>' +
                        '             </div>' +
                        '         </div>\n' +
                        '    </div>\n' +
                        // '<div id="fujians"></div>' +
                        // ' <div id="fileAll">\n' +
                        // '</div>\n' +
                        // '<a href="javascript:;" class="openFile" style="float: left;margin-top:8px;position:relative">\n' +
                        // '<img src="../img/mg11.png" alt="">\n' +
                        // '<span>添加附件</span>\n' +
                        // '<input type="file" multiple id="fileupload" data-url="/upload?module=workflow" name="file">\n' +
                        // '</a>\n' +
                        '</div>\n' +
                        '</div></form>',
                    success: function () {
                        form.render("select");//初始化表单
                        fileuploadFn('#fileupload', $('#fileContent'));
                        // fileuploadFn('#fileupload', $('#fileAll'));
                    },
                    yes: function (index, layero) {
                        var jobContent = $("#jobContent").val();//工作内容
                        var completionStatus = $("#completionStatus").next('.layui-form-select').find('dl dd.layui-this').attr('lay-value'); //完成状态
                        var explain = $("#explain").val();//说明
                        // 附件
                        var attachmentId = '';
                        var attachmentName = '';
                        for (var i = 0; i < $('#fileContent .dech').length; i++) {
                            attachmentId += $('#fileContent .dech').eq(i).find('input').val();
                            attachmentName += $('#fileContent .dech').eq(i).find('input').attr('filename');

                        }
                        if(jobContent==undefined||jobContent==""){
                            layer.msg("请填写工作内容");
                            return false;
                        }else if(completionStatus==undefined||completionStatus==""){
                            layer.msg("请选择完成状态");
                            return false;
                        }else {
                            var works = {
                                jobContent:jobContent,
                                completionStatus:completionStatus,
                                explain:explain,
                                workPlanId:workPlanId,
                                attachmentId:attachmentId,
                                attachmentName:attachmentName,
                                workType:"1"
                            }
                            //执行新增
                            $.ajax({
                                url:"/workflow/workLog/insertManager",
                                data:works,
                                dataType:"json",
                                success:function(res){
                                    if(res.code==="0"||res.code===0){
                                        layer.msg(res.msg);
                                        todayWorkTable.reload();
                                        tomorrowWorkTable.reload();
                                        layer.close(index)
                                    }else{
                                        layer.msg(res.msg);
                                    }
                                }
                            })
                        }
                    }
                });
            }else if(events == 'updateTest'){
                if(datas.length!=1){
                    layer.msg("请勾选一条进行编辑")
                }else{
                    layer.open({
                        type: 1,
                        skin: 'layui-layer-molv', //加上边框
                        area: ['80%', '90%'], //宽高
                        title: '今日工作编辑',
                        maxmin: true,
                        btn: ['提交', '取消'],
                        content: '<form class="layui-form" id="form1" lay-filter="formTest1"><div class="layui-form" style="margin-top: 20px;">' +
                            '<div class="layui-form-item">\n' +
                            '    <div class="layui-inline" style="width: 98%;">\n' +
                            '         <label class="layui-form-label" style="width: 11%"><span style="color:red">*</span>工作内容</label>\n' +
                            '         <div class="layui-input-inline" style="width: 84%;">\n' +
                            '         <textarea type="text" id="jobContent" style="min-height: 75px !important;float: left;" autocomplete="off" class="layui-input"></textarea>' +
                            '         </div>\n' +
                            '    </div>\n' +
                            '</div>\n' +
                            '<div class="layui-form-item">\n' +
                            '    <div style="width: 98%;">\n' +
                            '         <label class="layui-form-label" style="width: 11%"><span style="color:red">*</span>完成状态</label>\n' +
                            '         <div style="width: 84%;float: left">\n' +
                            '             <select id="completionStatus"><option value="">请选择<option><option value="0">全部完成</option><option value="1">部分完成</option><option value="10">未启动</option></select>\n' +
                            '         </div>\n' +
                            '    </div>\n' +
                            '</div>\n' +
                            '<div class="layui-form-item" style="margin-bottom:0;">\n' +
                            '    <div class="layui-inline" style="width: 98%;">\n' +
                            '         <label class="layui-form-label" style="width: 11%">说明</label>\n' +
                            '         <div class="layui-input-inline" style="width: 84%;">\n' +
                            '             <textarea type="text" id="explain" style="min-height: 75px !important;" autocomplete="off" class="layui-input"></textarea>' +
                            '         </div>\n' +
                            '    </div>\n' +
                            '</div>\n' +
                            '<div class="layui-input-inline" style="margin-left: 130px;">\n' +
                            '    <div class="layui-inline" style="width: 98%;">\n' +
                            '         <label class="layui-form-label" style="width: 10%">附件</label>\n' +
                            '         <div class="layui-input-inline" style="width: 90%;">\n' +
                            '             <div class="file_module">' +
                            '                  <div id="fileContent" class="file_content"></div>' +
                            '                  <div class="file_upload_box">' +
                            '                       <a href="javascript:;" class="open_file">' +
                            '                            <img src="/img/mg11.png" style="margin: -3px 5px 0 0;"><span>添加附件</span>' +
                            '                            <input type="file" multiple id="fileupload" data-url="/upload?module=workflow" name="file">' +
                            '                       </a>' +
                            '                       <div class="progress" id="progress">' +
                            '                             <div class="bar"></div>\n' +
                            '                       </div>' +
                            '                       <div class="bar_text"></div>' +
                            '                  </div>' +
                            '             </div>' +
                            '         </div>\n' +
                            '    </div>\n' +
                            // '<div id="fujians"></div>' +
                            // ' <div id="fileAll">\n' +
                            // '</div>\n' +
                            // '<a href="javascript:;" class="openFile" style="float: left;margin-top:8px;position:relative">\n' +
                            // '<img src="../img/mg11.png" alt="">\n' +
                            // '<span>添加附件</span>\n' +
                            // '<input type="file" multiple id="fileupload" data-url="/upload?module=workflow" name="file">\n' +
                            // '</a>\n' +
                            '</div>\n' +
                            '</div></form>',
                        success: function () {
                            $("#jobContent").text(datas[0].jobContent);
                            $("#completionStatus").val(datas[0].completionStatus);
                            $("#explain").text(datas[0].explain);
                            form.render("select");//初始化表单
                            // fileuploadFn('#fileupload', $('#fileAll'));
                            fileuploadFn('#fileupload', $('#fileContent'));
                            $.ajax({
                                url:'/workflow/workLog/getWorkById?type=work',
                                dataType: 'json',
                                type: 'get',
                                data:{
                                    workId:datas[0].logId
                                },
                                success:function (res) {
                                    // var str = ''
                                    // if(res.object.attachmentList.length>0){
                                    //     for(var i=0;i<res.object.attachmentList.length;i++){
                                    //         str+='<div class="dech" deUrl="' +res.object.attachmentList[i].attUrl + '"><a href="/download?' + res.object.attachmentList[i].attUrl + '" NAME="' + res.object.attachmentList[i].attachName +'*"><img style="margin-right:10px;" src="/img/attachment_icon.png"/>' + res.object.attachmentList[i].attachName + '</a><img class="deImgs" style="margin-left:5px;cursor: pointer;" src="/img/file/icon_deletecha_03.png"/><input type="hidden" class="inHidden" value="' + res.object.attachmentList[i].aid + '@' + res.object.attachmentList[i].ym + '_' + res.object.attachmentList[i].attachId +',"></div>'
                                    //     }
                                    // }else{
                                    //     str='';
                                    // }
                                    // $('#fileAll').append(str)

                                    //附件
                                    if (res&&res.object&&res.object.attachmentList && res.object.attachmentList.length > 0) {
                                        var fileArr = res.object.attachmentList;
                                        $('#fileContent').append(echoAttachment(fileArr));
                                    }
                                }
                            })
                        },
                        yes: function (index, layero) {
                            var jobContent = $("#jobContent").val();//工作内容
                            var completionStatus = $("#completionStatus").next('.layui-form-select').find('dl dd.layui-this').attr('lay-value'); //完成状态
                            var explain = $("#explain").val();//说明
                            // 附件
                            var attachmentId = '';
                            var attachmentName = '';
                            for (var i = 0; i < $('#fileContent .dech').length; i++) {
                                attachmentId += $('#fileContent .dech').eq(i).find('input').val();
                                attachmentName += $('#fileContent .dech').eq(i).find('input').attr('filename');

                            }
                            if(jobContent==undefined||jobContent==""){
                                layer.msg("请填写工作内容");
                                return false;
                            }else if(completionStatus==undefined||completionStatus==""){
                                layer.msg("请选择完成状态");
                                return false;
                            }else {
                                var works = {
                                    logId:datas[0].logId,
                                    jobContent:jobContent,
                                    completionStatus:completionStatus,
                                    explain:explain,
                                    workType:"1",
                                    attachmentId:attachmentId,
                                    attachmentName:attachmentName,
                                    workPlanId:workPlanId
                                }
                                //执行新增
                                $.ajax({
                                    url:"/workflow/workLog/updateManager",
                                    data:works,
                                    dataType:"json",
                                    success:function(res){
                                        if(res.code==="0"||res.code===0){
                                            layer.msg(res.msg);
                                            todayWorkTable.reload();
                                            tomorrowWorkTable.reload();
                                            layer.close(index)
                                        }else{
                                            layer.msg(res.msg);
                                        }
                                    }
                                })
                            }
                        }
                    });
                }
            }else if(events == 'delTest'){
                if(datas.length<1){
                    layer.msg("请至少勾选一条进行删除")
                }else{
                    layui.layer.confirm('确定要删除吗?', {icon: 3, title:'提示'}, function(index){
                        var ids = "";
                        for(var i=0;i<datas.length;i++){
                            ids+=datas[i].logId;
                        }
                        $.ajax({
                            url:"/workflow/workLog/delDanger?ids="+ids,
                            dataType:"json",
                            success:function(res){
                                if(res.code==="0"||res.code===0){
                                    layer.msg(res.msg);
                                    todayWorkTable.reload();
                                    tomorrowWorkTable.reload();
                                    layer.close(index)
                                }else{
                                    layer.msg(res.msg);
                                }
                            }
                        })
                    })
                }
            }
        })

        //资源情况表格头事件
        table.on('toolbar(resourcesFilter)', function (obj) {
            var events = obj.event;
            var datas = table.checkStatus('resources').data;
            if (events == 'addTest') {
                layer.open({
                    type: 1,
                    skin: 'layui-layer-molv', //加上边框
                    area: ['80%', '90%'], //宽高
                    title: '新增资源情况',
                    maxmin: true,
                    btn: ['提交', '取消'],
                    content: '<form class="layui-form" id="form1" lay-filter="formTest1"><div class="layui-form" style="margin-top: 20px;">' +
                        '<div class="layui-form-item">\n' +
                        '    <div class="layui-inline" style="width: 98%;">\n' +
                        '         <label class="layui-form-label" style="width: 11%"><span style="color:red">*</span>资源名称</label>\n' +
                        '         <div class="layui-input-inline" style="width: 84%;">\n' +
                        '         <input type="text" id="resourcesName"  autocomplete="off" class="layui-input">' +
                        '         </div>\n' +
                        '    </div>\n' +
                        '</div>\n' +
                        '<div class="layui-form-item">\n' +
                        '    <div style="width: 98%;">\n' +
                        '         <label class="layui-form-label" style="width: 11%">资源类型</label>\n' +
                        '         <div style="width: 84%;float: left">\n' +
                        '             <select id="resourcesType"></select>\n' +
                        '         </div>\n' +
                        '    </div>\n' +
                        '</div>\n' +
                        '<div class="layui-form-item">\n' +
                        '    <div class="layui-inline" style="width: 98%;">\n' +
                        '         <label class="layui-form-label" style="width: 11%">数量</label>\n' +
                        '         <div class="layui-input-inline" style="width: 84%;">\n' +
                        '         <input type="number" id="resourcesNumber" autocomplete="off" class="layui-input">' +
                        '         </div>\n' +
                        '    </div>\n' +
                        '</div>\n' +
                        '<div class="layui-form-item">\n' +
                        '    <div class="layui-inline" style="width: 98%;">\n' +
                        '         <label class="layui-form-label" style="width: 11%">说明</label>\n' +
                        '         <div class="layui-input-inline" style="width: 84%;">\n' +
                        '             <textarea type="text" id="explain" style="min-height: 100px !important;" autocomplete="off" class="layui-input"></textarea>' +
                        '         </div>\n' +
                        '    </div>\n' +
                        '</div>\n' +
                        '<div class="layui-input-inline" style="margin-left: 130px;">\n' +
                        '    <div class="layui-inline" style="width: 98%;">\n' +
                        '         <label class="layui-form-label" style="width: 10%">附件</label>\n' +
                        '         <div class="layui-input-inline" style="width: 90%;">\n' +
                        '             <div class="file_module">' +
                        '                  <div id="fileContent" class="file_content"></div>' +
                        '                  <div class="file_upload_box">' +
                        '                       <a href="javascript:;" class="open_file">' +
                        '                            <img src="/img/mg11.png" style="margin: -3px 5px 0 0;"><span>添加附件</span>' +
                        '                            <input type="file" multiple id="fileupload" data-url="/upload?module=workflow" name="file">' +
                        '                       </a>' +
                        '                       <div class="progress" id="progress">' +
                        '                             <div class="bar"></div>\n' +
                        '                       </div>' +
                        '                       <div class="bar_text"></div>' +
                        '                  </div>' +
                        '             </div>' +
                        '         </div>\n' +
                        '    </div>\n' +
                        // '<div id="fujians"></div>' +
                        // ' <div id="fileAll">\n' +
                        // '</div>\n' +
                        // '<a href="javascript:;" class="openFile" style="float: left;margin-top:8px;position:relative">\n' +
                        // '<img src="../img/mg11.png" alt="">\n' +
                        // '<span>添加附件</span>\n' +
                        // '<input type="file" multiple id="fileupload" data-url="/upload?module=workflow" name="file">\n' +
                        // '</a>\n' +
                        '</div>\n' +
                        '</div></form>',
                    success: function () {
                        var $select1 = $("#resourcesType");
                        var optionStr = '<option value="">请选择</option>';
                        $.ajax({ //查询文档等级
                            url: '/Dictonary/selectDictionaryByNo?dictNo=RESOURCES_TYPE',
                            type: 'get',
                            dataType: 'json',
                            async:false,
                            success: function (res) {
                                var data=res.data
                                if(data!=undefined&&data.length>0){
                                    for(var i=0;i<data.length;i++){
                                        //if(data[i].dictNo==dataa.testTypeNo){
                                            optionStr += '<option value="' + data[i].dictNo + '">' + data[i].dictName + '</option>'
                                        //}else{
                                        //    optionStr += '<option value="' + data[i].dictNo + '">' + data[i].dictName + '</option>'
                                        //}
                                    }
                                }
                            }
                        })
                        $select1.html(optionStr);
                        form.render("select");//初始化表单
                        // fileuploadFn('#fileupload', $('#fileAll'));
                        fileuploadFn('#fileupload', $('#fileContent'));
                    },
                    yes: function (index, layero) {
                        var resourcesName = $("#resourcesName").val();//资源名称
                        var resourcesNumber = $("#resourcesNumber").val();//数量
                        var resourcesType = $("#resourcesType").next('.layui-form-select').find('dl dd.layui-this').attr('lay-value'); //完成状态
                        var explain = $("#explain").val();//说明
                        // 附件
                        var attachmentId = '';
                        var attachmentName = '';
                        for (var i = 0; i < $('#fileContent .dech').length; i++) {
                            attachmentId += $('#fileContent .dech').eq(i).find('input').val();
                            attachmentName += $('#fileContent .dech').eq(i).find('input').attr('filename');

                        }
                        if(resourcesName==undefined||resourcesName==""){
                            layer.msg("请填写资源名称");
                            return false;
                        }else {
                            var works = {
                                resourceName:resourcesName,
                                resourcesNumber:resourcesNumber,
                                explain:explain,
                                attachmentId:attachmentId,
                                attachmentName:attachmentName,
                                resourceType:resourcesType,
                                workPlanId:workPlanId
                            }
                            //执行新增
                            $.ajax({
                                url:"/workflow/workLog/insertResources",
                                data:works,
                                dataType:"json",
                                success:function(res){
                                    if(res.code==="0"||res.code===0){
                                        layer.msg(res.msg);
                                        resourcesTable.reload();
                                        layer.close(index)
                                    }else{
                                        layer.msg(res.msg);
                                    }
                                }
                            })
                        }
                    }
                });
            }else if(events == 'updateTest'){
                if(datas.length!=1){
                    layer.msg("请勾选一条进行编辑")
                }else{
                    layer.open({
                        type: 1,
                        skin: 'layui-layer-molv', //加上边框
                        area: ['80%', '90%'], //宽高
                        title: '编辑资源情况',
                        maxmin: true,
                        btn: ['提交', '取消'],
                        content: '<form class="layui-form" id="form1" lay-filter="formTest1"><div class="layui-form" style="margin-top: 20px;">' +
                            '<div class="layui-form-item">\n' +
                            '    <div class="layui-inline" style="width: 98%;">\n' +
                            '         <label class="layui-form-label" style="width: 11%"><span style="color:red">*</span>资源名称</label>\n' +
                            '         <div class="layui-input-inline" style="width: 84%;">\n' +
                            '         <input type="text" id="resourcesName"  autocomplete="off" class="layui-input">' +
                            '         </div>\n' +
                            '    </div>\n' +
                            '</div>\n' +
                            '<div class="layui-form-item">\n' +
                            '    <div style="width: 98%;">\n' +
                            '         <label class="layui-form-label" style="width: 11%">资源类型</label>\n' +
                            '         <div style="width: 84%;float: left">\n' +
                            '             <select id="resourcesType"></select>\n' +
                            '         </div>\n' +
                            '    </div>\n' +
                            '</div>\n' +
                            '<div class="layui-form-item">\n' +
                            '    <div class="layui-inline" style="width: 98%;">\n' +
                            '         <label class="layui-form-label" style="width: 11%">数量</label>\n' +
                            '         <div class="layui-input-inline" style="width: 84%;">\n' +
                            '         <input type="number" id="resourcesNumber" autocomplete="off" class="layui-input">' +
                            '         </div>\n' +
                            '    </div>\n' +
                            '</div>\n' +
                            '<div class="layui-form-item">\n' +
                            '    <div class="layui-inline" style="width: 98%;">\n' +
                            '         <label class="layui-form-label" style="width: 11%">说明</label>\n' +
                            '         <div class="layui-input-inline" style="width: 84%;">\n' +
                            '             <textarea type="text" id="explain" style="min-height: 100px !important;" autocomplete="off" class="layui-input"></textarea>' +
                            '         </div>\n' +
                            '<input hidden id="attachmentId" name="attachmentId"/>'+
                            '<input hidden id="attachmentName" name="attachmentName"/>'+
                            '    </div>\n' +
                            '</div>\n' +
                            '<div class="layui-input-inline" style="margin-left: 130px;">\n' +
                            '    <div class="layui-inline" style="width: 98%;">\n' +
                            '         <label class="layui-form-label" style="width: 10%">附件</label>\n' +
                            '         <div class="layui-input-inline" style="width: 90%;">\n' +
                            '             <div class="file_module">' +
                            '                  <div id="fileContent" class="file_content"></div>' +
                            '                  <div class="file_upload_box">' +
                            '                       <a href="javascript:;" class="open_file">' +
                            '                            <img src="/img/mg11.png" style="margin: -3px 5px 0 0;"><span>添加附件</span>' +
                            '                            <input type="file" multiple id="fileupload" data-url="/upload?module=workflow" name="file">' +
                            '                       </a>' +
                            '                       <div class="progress" id="progress">' +
                            '                             <div class="bar"></div>\n' +
                            '                       </div>' +
                            '                       <div class="bar_text"></div>' +
                            '                  </div>' +
                            '             </div>' +
                            '         </div>\n' +
                            '    </div>\n' +
                            // '<div id="fujians"></div>' +
                            // ' <div id="fileAll">\n' +
                            // '</div>\n' +
                            // '<a href="javascript:;" class="openFile" style="float: left;margin-top:8px;position:relative">\n' +
                            // '<img src="../img/mg11.png" alt="">\n' +
                            // '<span>添加附件</span>\n' +
                            // '<input type="file" multiple id="fileupload" data-url="/upload?module=workflow" name="file">\n' +
                            // '</a>\n' +
                            '</div>\n' +
                            '</div></form>',
                        success: function () {
                            var $select1 = $("#resourcesType");
                            var optionStr = '<option value="">请选择</option>';
                            $.ajax({ //查询文档等级
                                url: '/Dictonary/selectDictionaryByNo?dictNo=RESOURCES_TYPE',
                                type: 'get',
                                dataType: 'json',
                                async:false,
                                success: function (res) {
                                    var data=res.data
                                    if(data!=undefined&&data.length>0){
                                        for(var i=0;i<data.length;i++){
                                            if(data[i].dictNo==datas[0].resourceType){
                                                optionStr += '<option selected value="' + data[i].dictNo + '">' + data[i].dictName + '</option>'
                                            }else{
                                                optionStr += '<option value="' + data[i].dictNo + '">' + data[i].dictName + '</option>'
                                            }
                                        }
                                    }
                                }
                            })
                            $select1.html(optionStr);
                            $("#resourcesName").val(datas[0].resourceName);//资源名称
                            $("#resourcesNumber").val(datas[0].resourcesNumber);
                            $("#explain").text(datas[0].explain);
                            // fileuploadFn('#fileupload', $('#fileAll'));
                            fileuploadFn('#fileupload', $('#fileContent'));
                            $.ajax({
                                url:'/workflow/workLog/getWorkById?type=resources',
                                dataType: 'json',
                                type: 'get',
                                data:{
                                    workId:datas[0].logId
                                },
                                success:function (res) {
                                    // var str = ''
                                    // if(res.object.attachmentList.length>0){
                                    //     for(var i=0;i<res.object.attachmentList.length;i++){
                                    //         str+='<div class="dech" deUrl="' +res.object.attachmentList[i].attUrl + '"><a href="/download?' + res.object.attachmentList[i].attUrl + '" NAME="' + res.object.attachmentList[i].attachName +'*"><img style="margin-right:10px;" src="/img/attachment_icon.png"/>' + res.object.attachmentList[i].attachName + '</a><img class="deImgs" style="margin-left:5px;cursor: pointer;" src="/img/file/icon_deletecha_03.png"/><input type="hidden" class="inHidden" value="' + res.object.attachmentList[i].aid + '@' + res.object.attachmentList[i].ym + '_' + res.object.attachmentList[i].attachId +',"></div>'
                                    //     }
                                    // }else{
                                    //     str='';
                                    // }
                                    // $('#fileAll').append(str)
                                    //附件
                                    if (res&&res.object&&res.object.attachmentList && res.object.attachmentList.length > 0) {
                                        var fileArr = res.object.attachmentList;
                                        $('#fileContent').append(echoAttachment(fileArr));
                                    }
                                }
                            })
                            form.render("select");//初始化表单
                        },
                        yes: function (index, layero) {
                            var resourcesName = $("#resourcesName").val();//资源名称
                            var resourcesNumber = $("#resourcesNumber").val();//数量
                            var resourcesType = $("#resourcesType").next('.layui-form-select').find('dl dd.layui-this').attr('lay-value'); //完成状态
                            var explain = $("#explain").val();//说明
                            // 附件
                            var attachmentId = '';
                            var attachmentName = '';
                            for (var i = 0; i < $('#fileContent .dech').length; i++) {
                                attachmentId += $('#fileContent .dech').eq(i).find('input').val();
                                attachmentName += $('#fileContent .dech').eq(i).find('input').attr('filename');

                            }
                            if(resourcesName==undefined||resourcesName==""){
                                layer.msg("请填写资源名称");
                                return false;
                            }else {
                                var works = {
                                    detailsId:datas[0].detailsId,
                                    resourceName:resourcesName,
                                    resourcesNumber:resourcesNumber,
                                    explain:explain,
                                    attachmentId:attachmentId,
                                    attachmentName:attachmentName,
                                    resourceType:resourcesType,
                                    workPlanId:workPlanId
                                }
                                //执行新增
                                $.ajax({
                                    url:"/workflow/workLog/updateResources",
                                    data:works,
                                    dataType:"json",
                                    success:function(res){
                                        if(res.code==="0"||res.code===0){
                                            layer.msg(res.msg);
                                            resourcesTable.reload();
                                            layer.close(index)
                                        }else{
                                            layer.msg(res.msg);
                                        }
                                    }
                                })
                            }
                        }
                    });
                }
            }else if(events == 'delTest'){
                if(datas.length<1){
                    layer.msg("请至少勾选一条进行删除")
                }else{
                    layui.layer.confirm('确定要删除吗?', {icon: 3, title:'提示'}, function(index){
                        var ids = "";
                        for(var i=0;i<datas.length;i++){
                            ids+=datas[i].detailsId;
                        }
                        $.ajax({
                            url:"/workflow/workLog/delResources?ids="+ids,
                            dataType:"json",
                            success:function(res){
                                if(res.code==="0"||res.code===0){
                                    layer.msg(res.msg);
                                    resourcesTable.reload();
                                    layer.close(index)
                                }else{
                                    layer.msg(res.msg);
                                }
                            }
                        })
                    })
                }
            }
        })

        //明日日表格头事件
        table.on('toolbar(tomorrowFilter)', function (obj) {
            var events = obj.event;
            var datas = table.checkStatus('tomorrowWork').data;
            // 新增
            if (events == 'addTest') {
                layer.open({
                    type: 1,
                    skin: 'layui-layer-molv', //加上边框
                    area: ['80%', '90%'], //宽高
                    title: '明日工作填报',
                    maxmin: true,
                    btn: ['提交', '取消'],
                    content: '<form class="layui-form" id="form1" lay-filter="formTest1"><div class="layui-form" style="margin-top: 20px;">' +
                        '<div class="layui-form-item">\n' +
                        '    <div class="layui-inline" style="width: 98%;">\n' +
                        '         <label class="layui-form-label" style="width: 11%"><span style="color:red">*</span>工作内容</label>\n' +
                        '         <div class="layui-input-inline" style="width: 84%;">\n' +
                        '         <textarea type="text" id="jobContent" style="min-height: 100px !important;float: left;" autocomplete="off" class="layui-input"></textarea>' +
                        '         </div>\n' +
                        '    </div>\n' +
                        '</div>\n' +
                        '<div class="layui-form-item">\n' +
                        '    <div class="layui-inline" style="width: 98%;">\n' +
                        '         <label class="layui-form-label" style="width: 11%">说明</label>\n' +
                        '         <div class="layui-input-inline" style="width: 84%;">\n' +
                        '             <textarea type="text" id="explain" style="min-height: 100px !important;" autocomplete="off" class="layui-input"></textarea>' +
                        '         </div>\n' +
                        '<input hidden id="attachmentId" name="attachmentId"/>'+
                        '<input hidden id="attachmentName" name="attachmentName"/>'+
                        '    </div>\n' +
                        '</div>\n' +
                        '<div class="layui-input-inline" style="margin-left: 130px;">\n' +
                        '    <div class="layui-inline" style="width: 98%;">\n' +
                        '         <label class="layui-form-label" style="width: 10%">附件</label>\n' +
                        '         <div class="layui-input-inline" style="width: 90%;">\n' +
                        '             <div class="file_module">' +
                        '                  <div id="fileContent" class="file_content"></div>' +
                        '                  <div class="file_upload_box">' +
                        '                       <a href="javascript:;" class="open_file">' +
                        '                            <img src="/img/mg11.png" style="margin: -3px 5px 0 0;"><span>添加附件</span>' +
                        '                            <input type="file" multiple id="fileupload" data-url="/upload?module=workflow" name="file">' +
                        '                       </a>' +
                        '                       <div class="progress" id="progress">' +
                        '                             <div class="bar"></div>\n' +
                        '                       </div>' +
                        '                       <div class="bar_text"></div>' +
                        '                  </div>' +
                        '             </div>' +
                        '         </div>\n' +
                        '    </div>\n' +
                        // '<div id="fujians"></div>' +
                        // ' <div id="fileAll">\n' +
                        // '</div>\n' +
                        // '<a href="javascript:;" class="openFile" style="float: left;margin-top:8px;position:relative">\n' +
                        // '<img src="../img/mg11.png" alt="">\n' +
                        // '<span>添加附件</span>\n' +
                        // '<input type="file" multiple id="fileupload" data-url="/upload?module=workflow" name="file">\n' +
                        // '</a>\n' +
                        '</div>\n' +
                        '</div></form>',
                    success: function () {
                        form.render("select");//初始化表单
                        // fileuploadFn('#fileupload', $('#fileAll'));
                        fileuploadFn('#fileupload', $('#fileContent'));
                    },
                    yes: function (index, layero) {
                        var jobContent = $("#jobContent").val();//工作内容
                        var explain = $("#explain").val();//说明
                        // 附件
                        var attachmentId = '';
                        var attachmentName = '';
                        for (var i = 0; i < $('#fileContent .dech').length; i++) {
                            attachmentId += $('#fileContent .dech').eq(i).find('input').val();
                            attachmentName += $('#fileContent .dech').eq(i).find('input').attr('filename');

                        }
                        if(jobContent==undefined||jobContent==""){
                            layer.msg("请填写工作内容");
                            return false;
                        }else {
                            var works = {
                                jobContent:jobContent,
                                explain:explain,
                                workType:"2",
                                attachmentId:attachmentId,
                                attachmentName:attachmentName,
                                workPlanId:workPlanId
                            }
                            //执行新增
                            $.ajax({
                                url:"/workflow/workLog/insertManager",
                                data:works,
                                dataType:"json",
                                success:function(res){
                                    if(res.code==="0"||res.code===0){
                                        layer.msg(res.msg);
                                        tomorrowWorkTable.reload();
                                        layer.close(index)
                                    }else{
                                        layer.msg(res.msg);
                                    }
                                }
                            })
                        }
                    }
                });
            }else if(events == 'updateTest'){
                if(datas.length!=1){
                    layer.msg("请勾选一条进行编辑")
                }else{
                    layer.open({
                        type: 1,
                        skin: 'layui-layer-molv', //加上边框
                        area: ['80%', '90%'], //宽高
                        title: '明日工作编辑',
                        maxmin: true,
                        btn: ['提交', '取消'],
                        content: '<form class="layui-form" id="form1" lay-filter="formTest1"><div class="layui-form" style="margin-top: 20px;">' +
                            '<div class="layui-form-item">\n' +
                            '    <div class="layui-inline" style="width: 98%;">\n' +
                            '         <label class="layui-form-label" style="width: 11%"><span style="color:red">*</span>工作内容</label>\n' +
                            '         <div class="layui-input-inline" style="width: 84%;">\n' +
                            '         <textarea type="text" id="jobContent" style="min-height: 100px !important;float: left;" autocomplete="off" class="layui-input"></textarea>' +
                            '         </div>\n' +
                            '    </div>\n' +
                            '</div>\n' +
                            '<div class="layui-form-item">\n' +
                            '    <div class="layui-inline" style="width: 98%;">\n' +
                            '         <label class="layui-form-label" style="width: 11%">说明</label>\n' +
                            '         <div class="layui-input-inline" style="width: 84%;">\n' +
                            '             <textarea type="text" id="explain" style="min-height: 100px !important;" autocomplete="off" class="layui-input"></textarea>' +
                            '         </div>\n' +
                            '    </div>\n' +
                            '</div>\n' +
                            '<div class="layui-input-inline" style="margin-left: 130px;">\n' +
                            '    <div class="layui-inline" style="width: 98%;">\n' +
                            '         <label class="layui-form-label" style="width: 10%">附件</label>\n' +
                            '         <div class="layui-input-inline" style="width: 90%;">\n' +
                            '             <div class="file_module">' +
                            '                  <div id="fileContent" class="file_content"></div>' +
                            '                  <div class="file_upload_box">' +
                            '                       <a href="javascript:;" class="open_file">' +
                            '                            <img src="/img/mg11.png" style="margin: -3px 5px 0 0;"><span>添加附件</span>' +
                            '                            <input type="file" multiple id="fileupload" data-url="/upload?module=workflow" name="file">' +
                            '                       </a>' +
                            '                       <div class="progress" id="progress">' +
                            '                             <div class="bar"></div>\n' +
                            '                       </div>' +
                            '                       <div class="bar_text"></div>' +
                            '                  </div>' +
                            '             </div>' +
                            '         </div>\n' +
                            '    </div>\n' +
                            // '<div id="fujians"></div>' +
                            // ' <div id="fileAll">\n' +
                            // '</div>\n' +
                            // '<a href="javascript:;" class="openFile" style="float: left;margin-top:8px;position:relative">\n' +
                            // '<img src="../img/mg11.png" alt="">\n' +
                            // '<span>添加附件</span>\n' +
                            // '<input type="file" multiple id="fileupload" data-url="/upload?module=workflow" name="file">\n' +
                            // '</a>\n' +
                            '</div>\n' +
                            '</div></form>',
                        success: function () {
                            $("#jobContent").text(datas[0].jobContent);
                            $("#explain").text(datas[0].explain);
                            form.render("select");//初始化表单
                            // fileuploadFn('#fileupload', $('#fileAll'));
                            fileuploadFn('#fileupload', $('#fileContent'));
                            $.ajax({
                                url:'/workflow/workLog/getWorkById?type=work',
                                dataType: 'json',
                                type: 'get',
                                data:{
                                    workId:datas[0].logId
                                },
                                success:function (res) {
                                    // var str = ''
                                    // if(res.object.attachmentList.length>0){
                                    //     for(var i=0;i<res.object.attachmentList.length;i++){
                                    //         str+='<div class="dech" deUrl="' +res.object.attachmentList[i].attUrl + '"><a href="/download?' + res.object.attachmentList[i].attUrl + '" NAME="' + res.object.attachmentList[i].attachName +'*"><img style="margin-right:10px;" src="/img/attachment_icon.png"/>' + res.object.attachmentList[i].attachName + '</a><img class="deImgs" style="margin-left:5px;cursor: pointer;" src="/img/file/icon_deletecha_03.png"/><input type="hidden" class="inHidden" value="' + res.object.attachmentList[i].aid + '@' + res.object.attachmentList[i].ym + '_' + res.object.attachmentList[i].attachId +',"></div>'
                                    //     }
                                    // }else{
                                    //     str='';
                                    // }
                                    // $('#fileAll').append(str)
                                    //附件
                                    if (res&&res.object&&res.object.attachmentList && res.object.attachmentList.length > 0) {
                                        var fileArr = res.object.attachmentList;
                                        $('#fileContent').append(echoAttachment(fileArr));
                                    }
                                }
                            })
                        },
                        yes: function (index, layero) {
                            var jobContent = $("#jobContent").val();//工作内容
                            var explain = $("#explain").val();//说明
                            // 附件
                            var attachmentId = '';
                            var attachmentName = '';
                            for (var i = 0; i < $('#fileContent .dech').length; i++) {
                                attachmentId += $('#fileContent .dech').eq(i).find('input').val();
                                attachmentName += $('#fileContent .dech').eq(i).find('input').attr('filename');

                            }
                            if(jobContent==undefined||jobContent==""){
                                layer.msg("请填写工作内容");
                                return false;
                            }else {
                                var works = {
                                    logId:datas[0].logId,
                                    jobContent:jobContent,
                                    explain:explain,
                                    attachmentId:attachmentId,
                                    attachmentName:attachmentName,
                                    workPlanId:workPlanId
                                }
                                //执行新增
                                $.ajax({
                                    url:"/workflow/workLog/updateManager",
                                    data:works,
                                    dataType:"json",
                                    success:function(res){
                                        if(res.code==="0"||res.code===0){
                                            layer.msg(res.msg);
                                            tomorrowWorkTable.reload();
                                            layer.close(index)
                                        }else{
                                            layer.msg(res.msg);
                                        }
                                    }
                                })
                            }
                        }
                    });
                }
            }else if(events == 'delTest'){
                if(datas.length<1){
                    layer.msg("请至少勾选一条进行删除")
                }else{
                    layui.layer.confirm('确定要删除吗?', {icon: 3, title:'提示'}, function(index){
                        var ids = "";
                        for(var i=0;i<datas.length;i++){
                            ids+=datas[i].logId+",";
                        }
                        $.ajax({
                            url:"/workflow/workLog/delTorrmorWork?ids="+ids,
                            dataType:"json",
                            success:function(res){
                                if(res.code==="0"||res.code===0){
                                    layer.msg(res.msg);
                                    tomorrowWorkTable.reload();
                                    layer.close(index)
                                }else if(res.code==="2"||res.code===2){
                                    layer.confirm(res.msg, {icon: 3, title:'提示',btn: ['确定']}, function(indexxx){
                                        layer.close(indexxx)
                                    })
                                }else{
                                    layer.msg(res.msg);
                                }
                            }
                        })
                    })
                }
            }
        })
        $(document).on("click","#close",function(){
            layer.open({
                type: 1,
                skin: 'layui-layer-molv', //加上边框
                area: ['80%', '90%'], //宽高
                title: '选择昨日工作安排',
                maxmin: true,
                btn: ['确定', '取消'],
                content: ' <div class="layui-form-item"><table id="choseWork" lay-filter="choseWork"></table></div>',
                success: function () {
                    layui.table.render({
                        elem: '#choseWork'
                        , url: '/workflow/workLog/getYestdayWork?status=1,10&workTypes=0,2&planId='+workPlanId//数据接口
                        , page: { //支持传入 laypage 组件的所有参数（某些参数除外，如：jump/elem） - 详见文档
                            layout: ['prev', 'page', 'next', 'skip', 'count', 'limit',]//自定义分页布局
                            , limits: [10, 15, 20, 25, 30, 35, 40, 45, 50, 55, 60, 65, 70, 75, 80, 85, 90, 95, 100]
                            , first: false //不显示首页
                            , last: false //不显示尾页
                        } //开启分页
                        // , toolbar: '#toolbar'
                        , cols: [[ //表头
                            {type: 'radio'}
                            , {type: 'numbers', title: '序号',width:50}
                            , {field: 'jobContent', title: '工作内容'}
                            , {field: 'completionStatus', title: '*完成状态',templet:function(d){
                                    if(d.completionStatus=="0"){
                                        return "全部完成";
                                    }else if(d.completionStatus=="1"){
                                        return "部分完成";
                                    }else if(d.completionStatus=="10"){
                                        return "未启动";
                                    }
                                }}
                            , {field: 'explain', title: '说明'}
                            //,{width:100, title: '操作',align:'center', toolbar: '#barOperation'}
                        ]]
                        , limit: 10
                        , done: function (res) {
                        }
                    });
                    form.render("select");//初始化表单
                },
                yes: function (indexx, layero) {
                    var datas = table.checkStatus('choseWork').data;
                    if(datas.length!=1){
                        layer.msg("请选择一条");
                    }else{
                        $("#jobContent").text(datas[0].jobContent);
                        $("#jobContent").prop("readonly",true)
                        $("#completionStatus").val(datas[0].completionStatus);
                        $("#explain").text(datas[0].explain);
                        $("#explain").prop("readonly",true)
                        form.render();
                        layer.close(indexx);
                    }
                }
            });
        })

        //监听选择角色下拉框
        form.on('select(formNoSelect)', function(data){
            console.log(data,'data')
            var pidt = undefind_nullStr($(data.elem[data.elem.selectedIndex]).attr("columnIds"));
            var valt = undefind_nullStr($(data.elem[data.elem.selectedIndex]).attr("name"));
            var roleId = undefind_nullStr($(data.elem[data.elem.selectedIndex]).attr("roleId"));
            var docfileClass = undefind_nullStr($(data.elem[data.elem.selectedIndex]).attr("docfileClass"));
            if(roleId!=null&&roleId!=undefined&&roleId!=''){
                $(".removeBox").remove();
                form.render();
                //开始重载知识栏目
                $.ajax({ //查询文档等级
                    url: '/knowledge/childTree?roleId='+roleId,
                    type: 'get',
                    dataType: 'json',
                    async:false,
                    success: function (res) {
                        if(res.code == 0){
                            var qdata = res.data;
                            var str = "";
                            if(qdata.length>0&&qdata.length%2 == 0){
                                for(var i =0; i<qdata.length;i++){
                                    if(i%2 == 0){
                                        str+= '<tr class="removeBox">' +
                                            '<td class="tdstyl">' +
                                            '<label  class="layui-form-label" paid="'+qdata[i].id+'" style="">'+qdata[i].name+'</label>' +
                                            '</td>' +
                                            '<td colspan="2" class="tdsty2" lay-event="eleFn">' +
                                            '<textarea type="text"  data-type="0" id="pele'+i+'" pid name="ptitle" required="" style="cursor: pointer"  placeholder="请选择" readonly="" autocomplete="off" class="textAreaBox ele treeNum"></textarea>' +
                                            '<div class="eleTree ele'+i+'" lay-filter="data1" style="display:none;position:absolute;border: 1px solid #d2d2d2;overflow-y: auto;background-color: #fff;border-radius: 2px;box-shadow: 0 2px 4px rgba(0,0,0,.12);box-sizing: border-box;overflow:hidden;z-index: 999;top:45px;left:15px;width: 90%;"></div></div></div></div>' +
                                            '</td>'
                                    }else if(i%2 != 0){
                                        str +=  '<td class="tdstyl">' +
                                            '<label class="layui-form-label" paid="'+qdata[i].id+'" style="">'+qdata[i].name+'</label>\n' +
                                            '</td>' +
                                            '<td colspan="2" class="tdsty2" lay-event="eleFn">\n' +
                                            '<textarea type="text"  data-type="0" id="pele'+i+'" pid name="ptitle" required="" style="cursor: pointer"  placeholder="请选择" readonly="" autocomplete="off" class="textAreaBox ele treeNum"></textarea>' +
                                                    
                                            '<div class="eleTree ele'+i+'" lay-filter="data1" style="display:none;position:absolute;border: 1px solid #d2d2d2;overflow-y: auto;background-color: #fff;border-radius: 2px;box-shadow: 0 2px 4px rgba(0,0,0,.12);box-sizing: border-box;overflow:hidden;z-index: 999;top:45px;left:15px;width: 90%;"></div></div></div></div>' +
                                            '</td>' +
                                            '</tr>'
                                    }
                                }
                            }else {
                                for (var i = 0; i < qdata.length-1; i++) {
                                    if (i % 2 == 0) {
                                        str += '<tr class="removeBox">' +
                                            '<td class="tdstyl">' +
                                            '<label  class="layui-form-label" style="" paid="'+qdata[i].id+'">'+qdata[i].name+'</label>' +
                                            '</td>' +
                                            '<td colspan="2" class="tdsty2" lay-event="eleFn">' +
                                            '<textarea type="text"  data-type="0" id="pele'+i+'" pid name="ptitle" required="" style="cursor: pointer"  placeholder="请选择" readonly="" autocomplete="off" class="textAreaBox ele treeNum"></textarea>' +
                                            '<div class="eleTree ele'+i+'" lay-filter="data1" style="display:none;position:absolute;border: 1px solid #d2d2d2;overflow-y: auto;background-color: #fff;border-radius: 2px;box-shadow: 0 2px 4px rgba(0,0,0,.12);box-sizing: border-box;overflow:hidden;z-index: 999;top:45px;left:15px;width: 90%;"></div></div></div></div>' +
                                            '</td>'
                                    } else if (i % 2 != 0) {
                                        str += '<td class="tdstyl">' +
                                            '<label class="layui-form-label" paid="'+qdata[i].id+'" style="">'+qdata[i].name+'</label>\n' +
                                            '</td>' +
                                            '<td colspan="2" class="tdsty2" lay-event="eleFn">\n' +
                                            '<textarea type="text"  data-type="0" id="pele'+i+'" pid name="ptitle" required="" style="cursor: pointer"  placeholder="请选择" readonly="" autocomplete="off" class="textAreaBox ele treeNum"></textarea>' +
                                            '<div class="eleTree ele'+i+'" lay-filter="data1" style="display:none;position:absolute;border: 1px solid #d2d2d2;overflow-y: auto;background-color: #fff;border-radius: 2px;box-shadow: 0 2px 4px rgba(0,0,0,.12);box-sizing: border-box;overflow:hidden;z-index: 999;top:45px;left:15px;width: 90%;"></div></div></div></div>' +
                                            '</td>' +
                                            '</tr>'
                                    }
                                }
                                str +=  '<tr class="removeBox">' +
                                    '<td class="tdstyl">' +
                                    '<label  class="layui-form-label" style="" paid="'+qdata[qdata.length-1].id+'">'+qdata[qdata.length-1].name+'</label>' +
                                    '</td>' +
                                    '<td colspan="2" class="tdsty2" lay-event="eleFn">' +
                                    '<textarea type="text"  data-type="0" id="pele'+i+'" pid name="ptitle" required="" style="cursor: pointer"  placeholder="请选择" readonly="" autocomplete="off" class="textAreaBox ele treeNum"></textarea>' +
                                    '<div class="eleTree ele'+i+'" lay-filter="data1" style="display:none;position:absolute;border: 1px solid #d2d2d2;overflow-y: auto;background-color: #fff;border-radius: 2px;box-shadow: 0 2px 4px rgba(0,0,0,.12);box-sizing: border-box;overflow:hidden;z-index: 999;top:45px;left:15px;width: 90%;"></div></div></div></div>' +
                                    '</td></tr>'
                            }
                            $("#finde").after(str);
                            form.render();
                            if(qdata.length>0) {
                                //var columnId = pdata.columnId;
                                for (var i = 0; i < qdata.length; i++) {
                                    (function (i) {
                                        var elm = '.ele' + i
                                        eleTree.render({
                                            elem: '.ele' + i,
                                            data: qdata[i].children,
                                            expandOnClickNode: false,
                                            highlightCurrent: true,
                                            showLine: true,
                                            showCheckbox: true,
                                            checked: true,
                                            defaultExpandAll: true,
                                            load: function (data, callback) {
                                            },
                                            done: function (res) {
                                            }
                                        });
                                        var $inp = $(elm +' input[eletree-status="1"]');
                                        var str = "";
                                        var str1 = "";
                                        for(var i=0;i<$inp.length;i++){
                                            str += $inp.eq(i).parent().find("span.eleTree-node-content-label").text()+",";
                                            str1 += $inp.eq(i).parent().parent().attr("data-id")+",";
                                        }
                                        $(elm).prev("textarea").attr("pid",str1)
                                        $(elm).prev("textarea").text(str);
                                    })(i);
                                }
                            }
                        }
                    }
                })
                var $td = $("#projectInfo").find('td[lay-event="eleFn"]');
                $td.click(function (obj) {
                    var td = $(this);
                    if(td.find("textarea.ele").attr("data-type") == "0"){
                        td.find(".eleTree").slideDown();
                        td.find("textarea.ele").attr("data-type","1");
                    }else{
                        td.find(".eleTree").slideUp();
                        td.find("textarea.ele").attr("data-type","0");
                    }
                    //点击本身外收起下拉的主体
                    document.onmouseup = function(e){
                        var e = e || window.event;
                        var target = e.target || e.srcElement;
                        //1. 点击事件的对象不是目标区域本身
                        //2. 事件对象同时也不是目标区域的子元素
                        if(!td.is(e.target) &&td.has(e.target).length === 0){
                            $(".eleTree").slideUp();
                            $("textarea.ele").attr("data-type","0");
                        }
                    }
                    //选中监听事件
                    var arr = [];
                    var arr1 = [];
                    var pidt = td.find("textarea.ele").attr("pid");
                    var valt = td.find("textarea.ele").val();
                    if(pidt != undefined || pidt != "undefined" || pidt != ""){
                        var arrr = pidt.split(",")
                        for(var i=0;i<arrr.length;i++){
                            if(arrr[i] == ""){

                            }else{
                                arr.push(arrr[i]);
                            }
                        }
                    }else{
                        arr = []
                    }
                    if(valt != undefined || valt != "undefined" || valt != ""){
                        var arrr1 = valt.split(",")
                        for(var i=0;i<arrr1.length;i++){
                            if(arrr1[i] == ""){

                            }else{
                                arr1.push(arrr1[i]);
                            }
                        }
                    }else{
                        arr1 = []
                    }
                    layui.eleTree.on("nodeChecked(data1)",function(d) {
                        var id = d.data.currentData.columnId+"";
                        var label = d.data.currentData.label+"";
                        if(d.isChecked == true || d.isChecked == "true"){
                            arr.push(id);
                            arr1.push(label);
                        }else{
                            arr.remove(id);
                            arr1.remove(label);
                        }
                        var str ="";
                        var str1 ="";
                        for(var i=0;i<arr.length;i++){
                            str+=arr[i]+","
                            str1+=arr1[i]+","
                        }
                        td.find("textarea.ele").val(str1);
                        td.find("textarea.ele").attr("pid",str);
                    })
                })
                //结束重载知识栏目
            }else{
                $(".removeBox").remove();
                form.render();
                //开始重载知识栏目
                $.ajax({ //查询文档等级
                    url: '/knowledge/childTree',
                    type: 'get',
                    dataType: 'json',
                    async:false,
                    success: function (res) {
                        if(res.code == 0){
                            var qdata = res.data;
                            var str = "";
                            if(qdata.length>0&&qdata.length%2 == 0){
                                for(var i =0; i<qdata.length;i++){
                                    if(i%2 == 0){
                                        str+= '<tr class="removeBox">' +
                                            '<td class="tdstyl">' +
                                            '<label  class="layui-form-label" paid="'+qdata[i].id+'" style="">'+qdata[i].name+'</label>' +
                                            '</td>' +
                                            '<td colspan="2" class="tdsty2" lay-event="eleFn">' +
                                            '<textarea type="text"  data-type="0" id="pele'+i+'" pid name="ptitle" required="" style="cursor: pointer"  placeholder="请选择" readonly="" autocomplete="off" class="textAreaBox ele treeNum"></textarea>' +
                                            '<div class="eleTree ele'+i+'" lay-filter="data1" style="display:none;position:absolute;border: 1px solid #d2d2d2;overflow-y: auto;background-color: #fff;border-radius: 2px;box-shadow: 0 2px 4px rgba(0,0,0,.12);box-sizing: border-box;overflow:hidden;z-index: 999;top:45px;left:15px;width: 90%;"></div></div></div></div>' +
                                            '</td>'
                                    }else if(i%2 != 0){
                                        str +=  '<td class="tdstyl">' +
                                            '<label class="layui-form-label" paid="'+qdata[i].id+'" style="">'+qdata[i].name+'</label>\n' +
                                            '</td>' +
                                            '<td colspan="2" class="tdsty2" lay-event="eleFn">\n' +
                                            '<textarea type="text"  data-type="0" id="pele'+i+'" pid name="ptitle" required="" style="cursor: pointer"  placeholder="请选择" readonly="" autocomplete="off" class="textAreaBox ele treeNum"></textarea>' +
                                            '<div class="eleTree ele'+i+'" lay-filter="data1" style="display:none;position:absolute;border: 1px solid #d2d2d2;overflow-y: auto;background-color: #fff;border-radius: 2px;box-shadow: 0 2px 4px rgba(0,0,0,.12);box-sizing: border-box;overflow:hidden;z-index: 999;top:45px;left:15px;width: 90%;"></div></div></div></div>' +
                                            '</td>' +
                                            '</tr>'
                                    }
                                }
                            }else {
                                for (var i = 0; i < qdata.length-1; i++) {
                                    if (i % 2 == 0) {
                                        str += '<tr class="removeBox">' +
                                            '<td class="tdstyl">' +
                                            '<label  class="layui-form-label" style="" paid="'+qdata[i].id+'">'+qdata[i].name+'</label>' +
                                            '</td>' +
                                            '<td colspan="2" class="tdsty2" lay-event="eleFn">' +
                                            '<textarea type="text"  data-type="0" id="pele'+i+'" pid name="ptitle" required="" style="cursor: pointer"  placeholder="请选择" readonly="" autocomplete="off" class="textAreaBox ele treeNum"></textarea>' +
                                            '<div class="eleTree ele'+i+'" lay-filter="data1" style="display:none;position:absolute;border: 1px solid #d2d2d2;overflow-y: auto;background-color: #fff;border-radius: 2px;box-shadow: 0 2px 4px rgba(0,0,0,.12);box-sizing: border-box;overflow:hidden;z-index: 999;top:45px;left:15px;width: 90%;"></div></div></div></div>' +
                                            '</td>'
                                    } else if (i % 2 != 0) {
                                        str += '<td class="tdstyl">' +
                                            '<label class="layui-form-label" paid="'+qdata[i].id+'" style="">'+qdata[i].name+'</label>\n' +
                                            '</td>' +
                                            '<td colspan="2" class="tdsty2" lay-event="eleFn">\n' +
                                            '<textarea type="text"  data-type="0" id="pele'+i+'" pid name="ptitle" required="" style="cursor: pointer"  placeholder="请选择" readonly="" autocomplete="off" class="textAreaBox ele treeNum"></textarea>' +
                                            '<div class="eleTree ele'+i+'" lay-filter="data1" style="display:none;position:absolute;border: 1px solid #d2d2d2;overflow-y: auto;background-color: #fff;border-radius: 2px;box-shadow: 0 2px 4px rgba(0,0,0,.12);box-sizing: border-box;overflow:hidden;z-index: 999;top:45px;left:15px;width: 90%;"></div></div></div></div>' +
                                            '</td>' +
                                            '</tr>'
                                    }
                                }
                                str +=  '<tr class="removeBox">' +
                                    '<td class="tdstyl">' +
                                    '<label  class="layui-form-label" style="" paid="'+qdata[qdata.length-1].id+'">'+qdata[qdata.length-1].name+'</label>' +
                                    '</td>' +
                                    '<td colspan="2" class="tdsty2" lay-event="eleFn">' +
                                    '<textarea type="text"  data-type="0" id="pele'+i+'" pid name="ptitle" required="" style="cursor: pointer"  placeholder="请选择" readonly="" autocomplete="off" class="textAreaBox ele treeNum"></textarea>' +
                                    '<div class="eleTree ele'+i+'" lay-filter="data1" style="display:none;position:absolute;border: 1px solid #d2d2d2;overflow-y: auto;background-color: #fff;border-radius: 2px;box-shadow: 0 2px 4px rgba(0,0,0,.12);box-sizing: border-box;overflow:hidden;z-index: 999;top:45px;left:15px;width: 90%;"></div></div></div></div>' +
                                    '</td></tr>'
                            }
                            $("#finde").after(str);
                            form.render();
                            if(qdata.length>0) {
                                //var columnId = pdata.columnId;
                                for (var i = 0; i < qdata.length; i++) {
                                    (function (i) {
                                        var elm = '.ele' + i
                                        eleTree.render({
                                            elem: '.ele' + i,
                                            data: qdata[i].children,
                                            expandOnClickNode: false,
                                            highlightCurrent: true,
                                            showLine: true,
                                            showCheckbox: true,
                                            checked: true,
                                            defaultExpandAll: true,
                                            load: function (data, callback) {
                                            },
                                            done: function (res) {
                                            }
                                        });
                                        var $inp = $(elm +' input[eletree-status="1"]');
                                        var str = "";
                                        var str1 = "";
                                        for(var i=0;i<$inp.length;i++){
                                            str += $inp.eq(i).parent().find("span.eleTree-node-content-label").text()+",";
                                            str1 += $inp.eq(i).parent().parent().attr("data-id")+",";
                                        }
                                        $(elm).prev("textarea").attr("pid",str1)
                                        $(elm).prev("textarea").text(str);
                                    })(i);
                                }
                            }
                        }
                    }
                })
                var $td = $("#projectInfo").find('td[lay-event="eleFn"]');
                $td.click(function (obj) {
                    var td = $(this);
                    if(td.find("textarea.ele").attr("data-type") == "0"){
                        td.find(".eleTree").slideDown();
                        td.find("textarea.ele").attr("data-type","1");
                    }else{
                        td.find(".eleTree").slideUp();
                        td.find("textarea.ele").attr("data-type","0");
                    }
                    //点击本身外收起下拉的主体
                    document.onmouseup = function(e){
                        var e = e || window.event;
                        var target = e.target || e.srcElement;
                        //1. 点击事件的对象不是目标区域本身
                        //2. 事件对象同时也不是目标区域的子元素
                        if(!td.is(e.target) &&td.has(e.target).length === 0){
                            $(".eleTree").slideUp();
                            $("textarea.ele").attr("data-type","0");
                        }
                    }
                    //选中监听事件
                    var arr = [];
                    var arr1 = [];
                    var pidt = td.find("textarea.ele").attr("pid");
                    var valt = td.find("textarea.ele").val();
                    if(pidt != undefined || pidt != "undefined" || pidt != ""){
                        var arrr = pidt.split(",")
                        for(var i=0;i<arrr.length;i++){
                            if(arrr[i] == ""){

                            }else{
                                arr.push(arrr[i]);
                            }
                        }
                    }else{
                        arr = []
                    }
                    if(valt != undefined || valt != "undefined" || valt != ""){
                        var arrr1 = valt.split(",")
                        for(var i=0;i<arrr1.length;i++){
                            if(arrr1[i] == ""){

                            }else{
                                arr1.push(arrr1[i]);
                            }
                        }
                    }else{
                        arr1 = []
                    }
                    layui.eleTree.on("nodeChecked(data1)",function(d) {
                        var id = d.data.currentData.columnId+"";
                        var label = d.data.currentData.label+"";
                        if(d.isChecked == true || d.isChecked == "true"){
                            arr.push(id);
                            arr1.push(label);
                        }else{
                            arr.remove(id);
                            arr1.remove(label);
                        }
                        var str ="";
                        var str1 ="";
                        for(var i=0;i<arr.length;i++){
                            str+=arr[i]+","
                            str1+=arr1[i]+","
                        }
                        td.find("textarea.ele").val(str1);
                        td.find("textarea.ele").attr("pid",str);
                    })
                })
                //结束重载知识栏目
            }
            $("#userPriv").val(undefind_nullStr($(data.elem[data.elem.selectedIndex]).attr("privId")));
            //$("#userPriv").attr("privid",undefind_nullStr($(data.elem[data.elem.selectedIndex]).attr("privId")))
            $("#docfileClass").val(undefind_nullStr(docfileClass))
            form.render('select');
        });
        //监听选择权限类别下拉框
        form.on('select(privTypeFilter)', function(data){
            if(data.value=='1'){ //下载
                $(".lookDiv").hide();
                $(".downDiv").show();
            }else if(data.value=='0'){ //浏览
                $(".lookDiv").show();
                $(".downDiv").hide();
            }else{
                $(".lookDiv").show();
                $(".downDiv").show();
            }
            form.render('select');
        });
        $("#password").blur(function () {
            $("#passwordTxt").css("display","");
        })
        $("#password2").blur(function () {
            $("#passwordTxt2").css("display","");
        })
        form.on('submit(btnSubmit)', function (data) {
            customer= data.field;
            var $td = $("#projectInfo").find('td[lay-event="eleFn"]');
            var str = "";
            for(var i=0;i<$td.length;i++){
                str += $td.eq(i).find("textarea.ele").attr("pid");
            }
            if(str != "" || str != undefined){
                var astr = str.split(",");
            }
            var coid = "";
            for(var i =0;i<astr.length;i++){
                if(astr[i] == ""){

                }else{
                    coid += astr[i]+",";
                }
            }
            customer.columnId = coid;
            var p1 = customer.password +"";
            var p2 = customer.password2 +"";
            if(customer.privType!=undefined&&customer.privType!=""){
                if(customer.privType==='1'||customer.privType===1){ //下载权限
                    if(customer.downloadBDate==undefined||customer.downloadEDate==undefined||customer.downloadBDate==""||customer.downloadEDate==""){
                        parent.layui.layer.msg("请选择下载时间")
                    }else{
                        if(p1==undefined||p2==undefined){
                            layui.layer.msg("请输入密码")
                            return false
                        }else{
                            if(p1!=p2){
                                layui.layer.msg("两次密码不一致")
                                return false
                            }else{
                                if(type=="add"){
                                    if(p1.length<parseInt(secPassMin) || p1.length>parseInt(secPassMax)){
                                        layui.layer.msg("密码长度不符合要求")
                                        return false
                                    }
                                    if(p2.length<parseInt(secPassMin) || p2.length>parseInt(secPassMax)){
                                        layui.layer.msg("密码长度不符合要求")
                                        return false
                                    }
                                }else if(type=="edit"){
                                    if((p1!=''&&p1.length<parseInt(secPassMin)) || (p1!=null&&p1.length>parseInt(secPassMax))){
                                        layui.layer.msg("密码长度不符合要求")
                                        return false
                                    }
                                    if((p2!=''&&p2.length<parseInt(secPassMin)) || (p2!=''&&p2.length>parseInt(secPassMax))){
                                        layui.layer.msg("密码长度不符合要求")
                                        return false
                                    }
                                }
                                var columnId="";
                                var treeNum = $(".treeNum").length;
                                for(var i=0;i<treeNum;i++){
                                    columnId+=$('.ele' + i).prev("textarea").attr("pid")
                                }
                                customer.columnId=columnId;
                                var contactUser = $("#contactUser").attr("user_id");
                                customer.contactUser = contactUser;
                                var userPriv = $("#userPriv").val();
                                if(userPriv.substring(userPriv.length-1,userPriv.length)==','){
                                    userPriv = userPriv.substring(0,userPriv.length-1)
                                }
                                customer.customerId = $("#customerId").val();
                                customer.browseBDate = '';
                                customer.browseEDate = '';
                                customer.userPriv = userPriv;
                                customer.userName = customer.companyName;
                                if(type== 'add'){
                                    $.ajax({
                                        url:'/client/addCustomer',
                                        dataType: 'json',
                                        type: 'post',
                                        async: false,
                                        data:customer,
                                        success:function (res) {
                                            if(res.flag){
                                                parent.layui.table.reload("clientCustomer");
                                                parent.layer.closeAll();
                                            }
                                            parent.layer.msg(res.msg)
                                        }
                                    })
                                }else if(type=='edit'){
                                    $.ajax({
                                        url:'/client/editCustomer',
                                        dataType: 'json',
                                        type: 'post',
                                        async: false,
                                        data:customer,
                                        success:function (res) {
                                            if(res.flag){
                                                parent.layer.closeAll();
                                                parent.layui.table.reload("clientCustomer");
                                            }
                                            parent.layer.msg(res.msg)
                                        }
                                    })
                                }
                            }
                        }
                    }
                }else if(customer.privType==='0'||customer.privType===0){ //浏览权限
                    if(p1==undefined||p2==undefined){
                        layui.layer.msg("请输入密码")
                        return false
                    }else{
                        if(p1!=p2){
                            layui.layer.msg("两次密码不一致")
                            return false
                        }else{
                            if(type=="add"){
                                if(p1.length<parseInt(secPassMin) || p1.length>parseInt(secPassMax)){
                                    layui.layer.msg("密码长度不符合要求")
                                    return false
                                }
                                if(p2.length<parseInt(secPassMin) || p2.length>parseInt(secPassMax)){
                                    layui.layer.msg("密码长度不符合要求")
                                    return false
                                }
                            }else if(type=="edit"){
                                if((p1!=''&&p1.length<parseInt(secPassMin)) || (p1!=null&&p1.length>parseInt(secPassMax))){
                                    layui.layer.msg("密码长度不符合要求")
                                    return false
                                }
                                if((p2!=''&&p2.length<parseInt(secPassMin)) || (p2!=''&&p2.length>parseInt(secPassMax))){
                                    layui.layer.msg("密码长度不符合要求")
                                    return false
                                }
                            }
                            // if((p1!=''&&p1.length<8) || (p1!=null&&p1.length>20)){
                            //     layui.layer.msg("密码长度不符合要求")
                            //     return false
                            // }
                            // if((p2!=''&&p2.length<8) || (p2!=''&&p2.length>20)){
                            //     layui.layer.msg("密码长度不符合要求")
                            //     return false
                            // }
                            if(customer.browseBDate==undefined||customer.browseEDate==undefined||customer.browseBDate==""||customer.browseEDate==""){
                                parent.layui.layer.msg("请选择浏览时间")
                                return false
                            }else{
                                var columnId="";
                                var treeNum = $(".treeNum").length;
                                for(var i=0;i<treeNum;i++){
                                    columnId+=$('.ele' + i).prev("textarea").attr("pid")
                                }
                                customer.columnId=columnId;
                                customer.customerId = $("#customerId").val();
                                var contactUser = $("#contactUser").attr("user_id");
                                customer.contactUser = contactUser;
                                var userPriv = $("#userPriv").val();
                                if(userPriv.substring(userPriv.length-1,userPriv.length)==','){
                                    userPriv = userPriv.substring(0,userPriv.length-1)
                                }
                                customer.downloadBDate='';
                                customer.downloadEDate='';
                                customer.userPriv = userPriv;
                                customer.userName = customer.companyName;
                                if(type== 'add'){
                                    $.ajax({
                                        url:'/client/addCustomer',
                                        dataType: 'json',
                                        type: 'post',
                                        async: false,
                                        data:customer,
                                        success:function (res) {
                                            if(res.flag){
                                                parent.layui.table.reload("clientCustomer");
                                                parent.layer.closeAll();
                                            }
                                            parent.layer.msg(res.msg)
                                        }
                                    })
                                }else if(type=='edit'){
                                    $.ajax({
                                        url:'/client/editCustomer',
                                        dataType: 'json',
                                        type: 'post',
                                        async: false,
                                        data:customer,
                                        success:function (res) {
                                            if(res.flag){
                                                parent.layer.closeAll();
                                                parent.layui.table.reload("clientCustomer");
                                            }
                                            parent.layer.msg(res.msg)
                                        }
                                    })
                                }
                            }
                        }
                    }
                }
            }else{
                if(p1==undefined||p2==undefined){
                    layui.layer.msg("请输入密码")
                    return false
                }else{
                    if(p1!=p2){
                        layui.layer.msg("两次密码不一致")
                        return false
                    }else{
                        if(p1.length<parseInt(secPassMin) || p1.length>parseInt(secPassMax)){
                            layui.layer.msg("密码长度不符合要求")
                            return false
                        }
                        if(p2.length<parseInt(secPassMin) || p2.length>parseInt(secPassMax)){
                            layui.layer.msg("密码长度不符合要求")
                            return false
                        }
                        var columnId="";
                        var treeNum = $(".treeNum").length;
                        for(var i=0;i<treeNum;i++){
                            columnId+=$('.ele' + i).prev("textarea").attr("pid")
                        }
                        customer.columnId=columnId;
                        var contactUser = $("#contactUser").attr("user_id");
                        customer.contactUser = contactUser;
                        var userPriv = $("#userPriv").val();
                        if(userPriv.substring(userPriv.length-1,userPriv.length)==','){
                            userPriv = userPriv.substring(0,userPriv.length-1)
                        }
                        customer.customerId = $("#customerId").val();
                        customer.userPriv = userPriv;
                        customer.userName = customer.companyName;
                        if(type== 'add'){
                            $.ajax({
                                url:'/client/addCustomer',
                                dataType: 'json',
                                type: 'post',
                                async: false,
                                data:customer,
                                success:function (res) {
                                    if(res.flag){
                                        parent.layui.table.reload("clientCustomer");
                                        parent.layer.closeAll();
                                    }
                                    parent.layer.msg(res.msg)
                                }
                            })
                        }else if(type=='edit'){
                            $.ajax({
                                url:'/client/editCustomer',
                                dataType: 'json',
                                type: 'post',
                                async: false,
                                data:customer,
                                success:function (res) {
                                    if(res.flag){
                                        parent.layer.closeAll();
                                        parent.layui.table.reload("clientCustomer");
                                    }
                                    parent.layer.msg(res.msg)
                                }
                            })
                        }
                    }
                }
            }
        });
    })
    //判断undefined
    function undefind_nullStr(value) {
        if(value==undefined || value == "undefined"){
            return ""
        }
        return value
    }

    //删除附件
    $(document).on('click', '.deImgs', function () {
        var _this = this;
        var attUrl = $(this).parents('.dech').attr('deUrl');
        layer.confirm('确定删除该附件吗？', function (index) {
            $.ajax({
                type: 'get',
                url: '/delete?' + attUrl,
                dataType: 'json',
                success: function (res) {
                    if (res.flag == true) {
                        layer.msg('删除成功', {icon: 6, time: 1000});
                        $(_this).parent().remove();
                    } else {
                        layer.msg('删除失败', {icon: 2, time: 1000});
                    }
                }
            })
        });
    });
    //选人框架
    var user_id;
    $(document).on("click", "#contactUser", function () {
        user_id='contactUser';
        $.popWindow("../common/selectUserIMAddGroup");
    })
    function getDate(){
        var obj={};
        obj.workPlanId=workPlanId;
        obj.weather = $("#water").val();
        obj.createUserName = $("#createUserName").val();
        obj.planSummary=$("#planSummary").val();
        //获取所有昨日工作
        var yestdayDatas = layui.table.cache['yesterdayWork'];
        var yestdayIds="";
        for(var i=0;i<yestdayDatas.length;i++){
            yestdayIds+=yestdayDatas[i].logId+",";
        }

        obj.yestdayIds = yestdayIds;

        var yestWorkArr = []
        $('.yester_Table [name="memo"]').each(function(){
            var yestWorkObj = {
                memo:$(this).val()||'',
                logId:$(this).attr('logId')||''
            }
            yestWorkArr.push(yestWorkObj)
        })
        obj.yestWork = JSON.stringify(yestWorkArr)


        //获取所有今日工作
        var todayDatas = layui.table.cache['todayWork'];
        var todayIds="";
        for(var i=0;i<todayDatas.length;i++){
            todayIds+=todayDatas[i].logId+",";
        }
        obj.todayIds = todayIds;
        //获取所有明日工作
        var tomorrowDatas = layui.table.cache['tomorrowWork'];
        var tomorrowIds="";
        for(var i=0;i<tomorrowDatas.length;i++){
            tomorrowIds+=tomorrowDatas[i].logId+",";
        }
        obj.tomorrowIds = tomorrowIds;

        var flag = true
        $('.yester_Table [name="completionStatus"]').each(function(){
            if(!($(this).val())){
                flag = false
            }
        })
        obj.completionStatusflag = flag
        return obj;
    }
    function getDate2(){
        //遍历表格获取每行数据
        var $trs = $('.table_box').find('.layui-table tbody tr ');

        var dataArr = [];
        // 判断是否完成
        var flay = false
        $trs.each(function (index) {
            var dataObj = {
                recordBeginDate: $(this).find('[name="recordBeginDate"]').val(),
                recordDate: $(this).find('[name="recordDate"]').val(),
                recordProgress: $(this).find('[name="recordProgress"]').val(),
                percentComplete: $(this).find('[name="percentComplete"]').val(),
                dataForm : '3'
            }
            if($(this).find('[name="recordDate"]').attr('scheduleId')){
                dataObj.scheduleId = $(this).find('[name="recordDate"]').attr('scheduleId')
            }
            if(dataObj.percentComplete=='100'&&$(this).find('[data-field="isComplete"] span').attr('isComplete')!=1){
                // dataObj.isComplete = '1'
                flay = true
            }

            dataArr.push(dataObj);
        })
        return dataArr
    }
    function clickdata(_this){
        layui.laydate.render({
            elem: _this
            , trigger: 'click'
            , format: 'yyyy-MM-dd'
            // , format: 'yyyy-MM-dd HH:mm:ss'
            //,value: new Date()
            /*, done: function(value, date){
                if(value&&$(_this).attr('name')=='recordBeginDate'){
                    $(_this).attr('disabled','disabled')
                    $(_this).css('background','#e7e7e7')
                }
            }*/
        });
    }
    function getweatherBefore(){
        var area="";
        var areaText = "";
        //获取地理位置
        if(BMap!=undefined) {
            var map = new BMap.Map("allmap");
            var point = new BMap.Point(108.95, 34.27);
            // map.centerAndZoom(point, 18);
            var geolocation = new BMap.Geolocation();
            geolocation.getCurrentPosition(function (r) {
                if (this.getStatus() == BMAP_STATUS_SUCCESS) {
                    // var mk = new BMap.Marker(r.point);
                    // map.addOverlay(mk);//标出所在地
                    // map.panTo(r.point);//地图中心移动
                    //alert('您的位置：'+r.point.lng+','+r.point.lat);
                    var point = new BMap.Point(r.point.lng, r.point.lat);//用所定位的经纬度查找所在地省市街道等信息
                    var gc = new BMap.Geocoder();
                    gc.getLocation(point, function (rs) {
                        var addComp = rs.addressComponents; //地址信息
                        area = rs.addressComponents.city;
                        $.ajax({
                            type:'get',
                            url:'/widget/getWeatherNew',
                            dataType:'json',
                            data:{cityName:area},
                            success:function(res){
                                if(res.flag && res.object){
                                    $("#water").val(res.object.weather)
                                }
                            }
                        })
                    });
                } else {
                    alert('failed' + this.getStatus());
                }

            }, {enableHighAccuracy: true})

        }
    }
</script>
</body>
</html>
