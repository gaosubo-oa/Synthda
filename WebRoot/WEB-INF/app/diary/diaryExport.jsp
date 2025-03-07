<%--
  Created by IntelliJ IDEA.
  User: 张继斌
  Date: 2022/4/13
  Time: 13:53
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>工作日志导出</title>
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
    .main{
        box-sizing: border-box;
        padding:30px 0px;
        display: flex;
        align-items: center;
        margin:0 auto;
        background:#fff;
        border-radius: 0 0 4px 4px;
        width: 100%;
    }
    .layui-form-label{
        width: 90px;
    }
    .layui-hide{
        display: inline-block !important;
    }
    .btn{
        height: 30px;
        border-radius: 10px;
        cursor: pointer;
    }
    .biao{
        margin: auto 36px;
    }
    .layui-table-cell {
        height: 90px;
        white-space: normal;
        width: auto;
    }
</style>
<body>
<div>
    <div class="main">
        <form class="layui-form" action="">
            <div class="layui-inline">
                <label class="layui-form-label">导出部门</label>
                <div class="layui-input-inline">
                    <input type="text" name="deptId" readonly id="deptId" placeholder="请选择导出部门" autocomplete="off" class="layui-input">
                </div>
            </div>
            <div class="layui-inline">
                <label class="layui-form-label">提交开始时间</label>
                <div class="layui-input-inline">
                    <input type="text" name="date" id="startDate" lay-verify="date" placeholder="请选择提交开始时间" autocomplete="off" class="layui-input">
                </div>
            </div>
            <div class="layui-inline">
                <label class="layui-form-label">提交截止时间</label>
                <div class="layui-input-inline">
                    <input type="text" name="date" id="endDate" lay-verify="date" placeholder="请选择提交截止时间" autocomplete="off" class="layui-input">
                </div>
            </div>
            <div class="layui-inline" >
                <label class="layui-form-label">评阅截止日期</label>
                <div class="layui-input-inline">
                    <input type="text" name="date" id="sendDate" lay-verify="date" placeholder="请选择评阅截止日期" autocomplete="off" class="layui-input">
                </div>
                <button type="button" class="btn btn-primary" id="btn_select" style="margin-left: 20px;margin-right: 10px">查 询</button>
                <button type="button" class="btn btn-primary" id="btn_export">导 出</button>
            </div>
        </form>
    </div>
    <div class="biao">
        <table class="layui-hide" id="tests" lay-filter="tests"></table>
    </div>
</div>

</body>
<script id="barDemos" type="text/html">
    <div class="long">
        <a lay-event="edit" class="layui-btn layui-btn-xs" id="edit">查看</a>
    </div>

</script>
<script>
    // 选部门
    $('#deptId').on('click', function () {
        dept_id = 'deptId';
        $.popWindow("../common/selectDept");
    });

    function obaganlestyle(snum, lnum) {
        var myDate = new Date();
        var day = myDate.getDay();//返回0-6
        //当天的日期
        var endday;
        var startday;

        endday = getthisDay(-day + lnum); //算得周日
        startday = getthisDay(-day + snum);//算的周一

        $("#endDate").val(startday);
        $("#startDate").val(endday);
        // $("#sendDate").val(getthisDay(-day + 2));
    }
    //取得日期
    function getthisDay(day) {
        var today = new Date();
        var targetday_milliseconds = today.getTime() + 1000 * 60 * 60 * 24 * day;
        today.setTime(targetday_milliseconds); //关键
        var tyear = today.getFullYear();
        var tMonth = today.getMonth();
        var tDate = today.getDate();
        if (tDate < 10) {
            tDate = "0" + tDate;
        }
        tMonth = tMonth + 1;
        if (tMonth < 10) {
            tMonth = "0" + tMonth;
        }
        return tyear + "-" + tMonth + "-" + tDate + "";
    };
    layui.use(['form', 'table', 'element', 'layedit','upload','laydate'], function () {
        var laydate = layui.laydate;
        var table = layui.table
        var form = layui.form
        laydate.render({
            elem: '#startDate'
        });
        laydate.render({
            elem: '#endDate'
        });
        laydate.render({
            elem: '#sendDate'
        });
        obaganlestyle(-1, -6);

        table.render({
            elem: '#tests'
            , cols: [[
                {field: 'oneDeptName',title: '一级部门', align:'center'}
                ,{field: 'twoDeptName',title: '二级部门', align:'center'}
                ,{field: 'threeDeptName',title: '三级部门', align:'center'}
                ,{field: 'fourDeptName',title: '四级部门', align:'center'}
                ,{field: 'userName',title: '姓名', align:'center'}
                ,{field: 'byName',title: '工号', align:'center'}
                ,{field: 'userPrivName',title: '岗位角色', align:'center'}
                ,{field: 'isFlag',title: '是否有提交工作日志', align:'center'}
                ,{field: 'subject',title: '日志标题', align:'center'}
                ,{field: 'diaDate',title: '日志日期', align:'center'}
                ,{field: 'diaTypeName',title: '日志类型', align:'center'}
                ,{field: 'contentStr',title: '日志内容', align:'center'}
                ,{field: 'diaTime',title: '提交时间', align:'center'}
                ,{field: 'userTopIdName',title: '汇报上级', align:'center'}
                ,{field: 'commentStatus',title: '是否完成日志评阅', align:'center'}
                ,{field: 'commentTxt',title: '评阅内容', align:'center'}
                ,{field: 'commentLengthJudge',title: '有无超过15个字', align:'center'}
            ]]
        })

        $(document).on('click','#btn_select',function(){
            if (!$("#deptId").attr("deptid") || $("#deptId").attr("deptid") === "") {
                $.layerMsg({content: "请选择导出部门", icon: 7, time: 1500});
                return false;
            }

            var layer = layui.layer;
            var index = layer.load(1); //添加laoding,0-2两种方式

            var startDate = $("#startDate").val()
            var endDate = $("#endDate").val()
            var sendDate = $("#sendDate").val()
            var deptIds = $("#deptId").attr("deptid")
            table.reload('tests',{
                url:'/diary/diaryModelExport',
                method: 'post',
                where:{
                    useFlag:true,
                    startDate:startDate,
                    endDate:endDate,
                    sendDate:sendDate,
                    deptIds:deptIds
                },
                done: function (res){
                    layer.close(index); //返回数据关闭loading
                    if (!res.flag) {
                        $.layerMsg({content: res.msg, icon: 2, time: 1500})
                    }
                }
            })
        })
        $(document).on('click','#btn_export',function(){
            var startDate = $("#startDate").val()
            var endDate = $("#endDate").val()
            var sendDate = $("#sendDate").val()
            var deptIds = $("#deptId").attr("deptid")
            window.location.href = '/diary/diaryModelExport?isExport=1&startDate='+startDate+'&endDate='+endDate+'&sendDate='+sendDate+'&deptIds='+deptIds
        })
    })

</script>
</html>
