<%--
  Created by IntelliJ IDEA.
  User: 张继斌
  Date: 2022/2/24
  Time: 10:30
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>薪资数据统计</title>
    <meta name="renderer" content="webkit">
    <meta http-equiv="X-UA-Compatible" content="IE=10,chrome=1">
    <meta name="viewport"
          content="width=device-width, initial-scale=1.0, user-scalable=0, minimum-scale=1.0, maximum-scale=1.0">
    <link rel="stylesheet" type="text/css" href="/lib/layui/layui/css/layui.css?20210319.1"/>
    <link rel="stylesheet" href="/lib/layui/layui/css/layui.css">
    <script type="text/javascript" src="/ui/js/xoajq/xoajq3.js"></script>
    <script type="text/javascript" src="/lib/layui/layui/layui.all_v2.5.js"></script>
    <script type="text/javascript" src="/js/base/base.js"></script>
    <script type="text/javascript" src="/lib/layui/layui/global.js?20201229.1"></script>
    <script type="text/javascript" src="/lib/layui/layui/lay/mymodules/tableFilter.js"></script>
    <script type="text/javascript" src="/lib/layui/layui/lay/mymodules/tableChild.js"></script>
    <script type="text/javascript" src="/lib/layui/layui/lay/mymodules/tableMerge.js"></script>
    <script src="/ui/js/qrcode.min.js"></script>
    <script src="../../lib/laydate/laydate.js"></script>
    <script src="/lib/layui/layui/js/common.js?v=20190726" type="text/javascript" charset="utf-8"></script>
    <script src="/lib/ueditor/ueditor.config.js?20200919" type="text/javascript" charset="utf-8"></script>
    <script src="/lib/ueditor/ueditor.all.js?20200919" type="text/javascript" charset="utf-8"></script>
    <script src="/lib/ueditor/UEcontroller.js?20200919" type="text/javascript" charset="utf-8"></script>
    <script type="text/javascript" src="/lib/jQuery-File-Upload-master/jquery-ui.js"></script>
    <script type="text/javascript" src="/lib/jQuery-File-Upload-master/jquery.iframe-transport.js"></script>
    <script type="text/javascript" src="/lib/jQuery-File-Upload-master/jquery.fileupload.js"></script>
    <script type="text/javascript" src="/js/email/fileupload.js"></script>
    <script type="text/javascript" src="/js/common/fileupload.js"></script>
    <script src="/lib/jQuery-File-Upload-master/jquery.fileupload.js" type="text/javascript" charset="utf-8"></script>

</head>
<style>


    #box .layui-from {
        width: 100%;
    }
    .layui-table-page>div{
        float: right;
    }
    #box .layui-table {
        width: 90%;
        margin: 0 auto;
    }

    .asd {
        font-weight: bold;
        font-size: 18px;
        margin-left: 30px;
    }

    .evaluation span {
        font-weight: bold;
        font-size: 18px;
        margin-left: 55px;
    }
    /*#layui-laydate2 .layui-laydate-header {*/
    /*    display: none;*/
    /*}*/

    #box button {
        right: -14px;
        z-index: 999;
        top:77px
    }
    #btn{
        margin-right: 35px;
        position: absolute;
        right: 30px;
        z-index: 999;
        top:77px
    }
    #from {
        width: 100%;
        margin: 0 auto;
        padding-top: 20px;
    }

    #from .new {
        font-weight: bold;
        font-size: 18px;
        margin-left: 30px;
    }

    .people {
        width: 100%;
        overflow: hidden;
        margin-bottom: 15px;
    }

    .people1 {
        width: 44%;
        float: left;
        overflow: hidden;
    }

    .people2 {
        float: right;
        overflow: hidden;
        margin-right: 61px;
    }

    .tbtn {
        text-align: center;
    }

    .tbtn button {
        margin-bottom: 20px;
        width: 100px;
    }

    .annex {
        font-size: 14px;
        margin-left: 30px;
    }
    .layui-form-select{
        width: 200px!important;
        height: 35px!important;
    }
    @media print {.notprint{display: none;}}
    #test3 {
        margin-left: 68px;
    }

    .layui-form-label {
        width: 60px;
    }

    .layui-table-view .layui-form-checkbox[lay-skin=primary] i {
        margin-top: 5px;
    }

    .layui-form {
        margin-left: 10px;
        margin-top: 10px;
        display: block;
        margin-right: 10px;
    }

    .layui-table-cell laytable-cell-1-0-5 {
        width: 268px;
    }
    .layui-table-body{
        height: 55%;
    }
    /*.layui-table-page{*/
    /*    width: 1054px;*/
    /*}*/
    .layui-laypage-btn{
        display: none;
    }
    .layui-box layui-laypage layui-laypage-default{
        margin-left: 1060px;
    }
    .thHeight1 td {
        height: 80px;
    }

    .thHeight2 td {
        height: 120px;
        letter-spacing: 7px;
    }

    .layui-form input[type=checkbox], .layui-form input[type=radio], .layui-form select {
    }

    .layui-form select {

    }

    .evaluation {
        width: 800px;
        padding-top: 10px;
    }

    tr {
        text-align: center;
    }

    td {
        text-align: center;
    }

    #asd {
        width: 10px;
    }

    .layui-table td, .layui-table th {
        padding: 10px 9px;
    }

    .layui-form-checkbox {
        display: none;
    }

    .layui-table-view .layui-table td, .layui-table-view .layui-table th {
        text-align: center;
    }

    .layui-table-tool {
        display: none;
    }
    .layui-input{
        width: 200px;
    }
    .box1 {
        overflow: hidden;
        margin-left: 55px;
        margin-bottom: 50px;
    }

    .top1 {
        width: 199px;
        height: 39px;
        background-color: rgb(204 204 204);
        display: block;
        font-weight: bold;
        font-size: 18px;
        float: left;
        text-align: center;
        line-height: 39px;
        border: 1px solid rgba(121, 121, 121, 1);
    }

    .top2 {
        width: 228px;
        height: 39px;
        background-color: rgba(121, 121, 121, 1);
        display: block;
        font-weight: bold;
        font-size: 18px;
        float: left;
        text-align: center;
        line-height: 39px;
    }

    #meeting {
        width: 84px;
    }

    #textarea {
        width: 73%;
        height: 100px;
    }

    #party {
        float: right;
        position: absolute;
        left: 1000px;
        top: 75px;
    }

    #year {
        float: right;
        position: absolute;
        left: 1320px;
        top: 75px;
    }
    .layui-tab-content{
        margin-top: 20px;
    }
    .laytable-cell-1-0-6{
        maxWidth: 220px;

    }
    .niuma{
        width: 1000px;
        position: relative;
    }
    .laydate-icon {
        border: 1px solid #C6C6C6;
         background-image: none;
    }
</style>
<body>
<div style="margin-top: 20px">
    <div style="
    height: 45px;
    line-height: 45px;
    font-size: 22px;
    margin-left: 50px;
    color: #494d59;">
        <img src="/ui/img/zkim/category.png">
        薪资数据统计</div>
    <form class="layui-form" action="">
        <div style="position: relative;line-height: 60px;">
            <div class="layui-inline">
                <label class="layui-form-label">开始时间</label>
                <div class="layui-input-inline">
                    <input type="text" name="expireDate"  id="expireDate" lay-verify="required|phone" autocomplete="off" class="layui-input">
                </div>
            </div>
            <div class="layui-inline">
                <label class="layui-form-label">结束时间</label>
                <div class="layui-input-inline">
                    <input type="text" name="expireDates"  id="expireDates" lay-verify="required|phone" autocomplete="off" class="layui-input">
                </div>
            </div>
            <div class="layui-inline">
                <label class="layui-form-label" >部门</label>
                <div class="layui-input-inline"  style="display: flex">
                    <input  style="width: 200px" id="deptName" name="deptName" class="layui-input" type="text">
                </div>
            </div>
            <span id="Adddept" style="width: 30px;cursor: hand">添加</span> <span id="Deletedept" style="width: 30px;cursor: hand">清除</span>

            <div class="layui-inline">
                <label class="layui-form-label">姓名</label>
                <div class="layui-input-inline">
                    <input  style="width: 200px" id="userName" name="userName" class="layui-input" type="text">
                </div>
            </div>
            <button type="button" class="layui-btn layui-btn-sm" id="search1" lay-event="search1" style="height: 30px;line-height: 30px;margin-left: 10px">查询</button>
            <button type="button" class="layui-btn layui-btn-sm" id="export" lay-event="" style="height: 30px;line-height: 30px;">导出</button>
        </div>
    </form>
    <table class="layui-hide" id="test1" lay-filter="test1"></table>
</div>
<%--<script id="barDemos" type="text/html">--%>
<%--    <div class="long">--%>
<%--        <a id="detail2" lay-event="detail2" data-index="i" style="color: blue;cursor:pointer; text-decoration:underline">重新计算</a>--%>
<%--        <a id="detail1" lay-event="detail1" data-index="i" style="color: blue;cursor:pointer; text-decoration:underline">修改备注</a>--%>
<%--    </div>--%>

<%--</script>--%>

</body>
<script>

    $("#Adddept").on("click", function () {
        dept_id = 'deptName';
        $.popWindow("../common/selectDept?0");
    });

    $('#Deletedept').on("click",function () {
        $('#deptName').val('');
        $('#deptName').attr('deptid','');
    })
    layui.use(['form', 'table', 'element', 'layedit','eleTree'], function () {
        var table = layui.table
        var form = layui.form
        var element = layui.element
        var layedit = layui.layedit
        var laydate = layui.laydate
        var eleTree = layui.eleTree;
        //时间选择器(开始时间)
        laydate.render({
            elem: '#expireDate',
            type: "month"
        });
        //时间选择器(结束时间)
        laydate.render({
            elem: '#expireDates',
            type: "month"
        });
        form.render()
        var y  = new Date().getFullYear();
        var month = new Date().getMonth()+1
        $('#expireDate').val(y+'-'+'0'+1)
        if(month <= 9){
            $('#expireDates').val(y+'-'+'0'+month)
        }else{
            $('#expireDates').val(y+'-'+month)
        }

        var startTime = $('#expireDate').val()
        var endTime = $('#expireDates').val()
        form.render('select');
        form.render()


        //导出
        $('#export').on("click",function () {
            var startTime = $("#expireDate").val()
            var endTime = $("#expireDates").val()
            var userName = $("#userName").val()
            var deptId = $('#deptName').attr('deptid');
            if (deptId==undefined){
                deptId=''
            }
            window.location.href='/WagesSalaryData/export?startTime='+startTime+'&endTime='+endTime+'&deptId='+deptId+'&userName='+userName;
            layer.msg('正在导出中，请耐心等待')
        });
        $('#search1').on("click",function () {
            var startTime = $('#expireDate').val()
            var endTime = $('#expireDates').val()
            var deptName = $("#deptName").val()
            var userName = $("#userName").val()
            table.render({
                elem: '#test1'
                ,cellMinWidth:'100'
                , url:'/WagesSalaryData/selectAll?startTime='+startTime+'&endTime='+endTime+'&deptName='+deptName+'&userName='+userName+'&pageSize='+'10'+'&useflag='+true
                ,cols:[[
                    {field: 'dataYear',title: '年份',  }
                    ,{field: 'dataMonth',title: '月份',  }
                    , {field: 'deptName',title: '部门', }
                    , {field: 'jobNumber',width:'130', title: '工号',}
                    , {field: 'userName', title: '姓名',}
                    , {field: 'idNumber',width:'190', title: '身份证号',}
                    , {field: 'manageIdName',title: '薪岗', }
                    , {field: 'jobRatio', title: '薪岗比例', }
                    , {field: 'seaGoingPerformance', title: '出海绩效', }
                    , {field: 'floatPay', title: '浮动工资', }
                    , {field: 'basePay',title: '基本工资', }
                    , {field: 'jobPay',width:'130',title: '机关岗位工资', }
                    , {field: 'other1', title: '其他1', }
                    , {field: 'other2',title: '其他2',}
                    , {field: 'onSiteWork',title: '现场上班', }
                    , {field: 'jobWork', title: '机关上班',}
                    , {field: 'rest', title: '休息',}
                    , {field: 'totalAttendance', title: '出勤合计',}
                    , {field: 'onSiteWorkPay',width:'130', title: '现场上班工资',}
                    , {field: 'jobWorkPay',width:'130', title: '机关上班工资',}
                    , {field: 'restPay', title: '休息工资',}
                    , {field: 'assessmentName', title: '考核类型',}
                    , {field: 'assessmentRatio', title: '考核比例',}
                    , {field: 'assessmentRetained',width:'130', title: '考核留存工资',}
                    , {field: 'assessmentScore', title: '考核分',}
                    , {field: 'deductAssessmentPay', title: '扣考核工资',}
                    , {field: 'actuaiAssessmentPay',width:'130', title: '实发考核工资',}
                    , {field: 'deductShippingBusiness',width:'190', title: '扣船务期公司发放部分',}
                    , {field: 'deductPublicHoliday',width:'190', title: '扣公休期间个人缴金部分',}
                    , {field: 'actualJobPay',width:'130', title: '应发岗位工资',}
                    , {field: 'emplName', title: '用工形式',}
                    , {field: 'employmentCompany', width:'130',title: '所属劳务公司',}
                    , {field: 'performancePay1', title: '绩效工资1',}
                    , {field: 'performancePay2', title: '绩效工资2',}
                    , {field: 'performancePay3', title: '绩效工资3',}
                    , {field: 'remarks', title: '备注',}
                    , {field: 'ackStatus', title: '状态',templet:function(d){
                            if(d.ackStatus==1){
                                return '已确认'
                            }else if(d.ackStatus==0){
                                return '待确认'
                            }
                        }}
                    // , {field: '', title: '操作',width:'160', toolbar: '#barDemos',fixed: 'right', rowspan:2}

                ]],
                page:true,
                limit:10
                ,parseData: function(res){ //res 即为原始返回的数据
                    return {
                        "code":0,
                        "count":res.totleNum,
                        "data": res.obj //解析数据列表
                    };
                }
            });
        });
        table.render({
            elem: '#test1'
            , url: '/WagesSalaryData/selectAll?pageSize='+'10'+'&useflag='+true+'&startTime='+startTime+'&endTime='+endTime
            ,cellMinWidth:'100'
            , toolbar: '#toolbarDemo' //开启头部工具栏，并为其绑定左侧模板
            , defaultToolbar: ['filter', 'exports', 'print', { //自定义头部工具栏右侧图标。如无需自定义，去除该参数即可
                title: '提示'
                , layEvent: 'LAYTABLE_TIPS'
                , icon: 'layui-icon-tips'
            }]
            , title: '用户数据表'
            , cols: [[
                {field: 'dataYear',title: '年份',  }
                ,{field: 'dataMonth',title: '月份',  }
                , {field: 'deptName',title: '部门', }
                , {field: 'jobNumber',width:'130', title: '工号',}
                , {field: 'userName', title: '姓名',}
                , {field: 'idNumber',width:'190', title: '身份证号',}
                , {field: 'manageIdName',title: '薪岗', }
                , {field: 'jobRatio', title: '薪岗比例', }
                , {field: 'seaGoingPerformance', title: '出海绩效', }
                , {field: 'floatPay', title: '浮动工资', }
                , {field: 'basePay',title: '基本工资', }
                , {field: 'jobPay',width:'130',title: '机关岗位工资', }
                , {field: 'other1', title: '其他1', }
                , {field: 'other2',title: '其他2',}
                , {field: 'onSiteWork',title: '现场上班', }
                , {field: 'jobWork', title: '机关上班',}
                , {field: 'rest', title: '休息',}
                , {field: 'totalAttendance', title: '出勤合计',}
                , {field: 'onSiteWorkPay',width:'130', title: '现场上班工资',}
                , {field: 'jobWorkPay',width:'130', title: '机关上班工资',}
                , {field: 'restPay', title: '休息工资',}
                , {field: 'assessmentName', title: '考核类型',}
                , {field: 'assessmentRatio', title: '考核比例',}
                , {field: 'assessmentRetained',width:'130', title: '考核留存工资',}
                , {field: 'assessmentScore', title: '考核分',}
                , {field: 'deductAssessmentPay', title: '扣考核工资',}
                , {field: 'actuaiAssessmentPay',width:'130', title: '实发考核工资',}
                , {field: 'deductShippingBusiness',width:'190', title: '扣船务期公司发放部分',}
                , {field: 'deductPublicHoliday',width:'190', title: '扣公休期间个人缴金部分',}
                , {field: 'actualJobPay',width:'130', title: '应发岗位工资',}
                , {field: 'emplName', title: '用工形式',}
                , {field: 'employmentCompany', width:'130',title: '所属劳务公司',}
                , {field: 'performancePay1', title: '绩效工资1',}
                , {field: 'performancePay2', title: '绩效工资2',}
                , {field: 'performancePay3', title: '绩效工资3',}
                , {field: 'remarks', title: '备注',}
                , {field: 'ackStatus', title: '状态',templet:function(d){
                        if(d.ackStatus==1){
                            return '已确认'
                        }else if(d.ackStatus==0){
                            return '待确认'
                        }
                    }}
                // , {field: '', title: '操作',width:'160', toolbar: '#barDemos',fixed: 'right', rowspan:2}
            ]]
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




        $(document).on("click","#submit",function(){
            layer.close('page')
        })
        table.on('tool(test1)', function (obj) {
            data = obj.data;
            var data = obj.data;
            var dataObj = obj.data;
            var layEvent = obj.event;
            if (obj.event === 'detail1') {
                layer.open({
                    type: 1,
                    area: ['400px', '300px'], //宽高
                    title: '修改',
                    maxmin: true,
                    btn: ['确定'], //可以无限个按钮
                    content: '<div style="margin: 43px auto;">' +
                        '<form class="layui-form" action="">\n' +
                        ' <div class="layui-form-item" >\n' +
                        '     <div class="layui-inline" >\n' +
                        '         <label class="layui-form-label" >修改备注</label>\n' +
                        '         <div class="layui-input-inline">\n' +
                        '             <input  type="text" name="remarks"  id="remarks" lay-verify="required|phone" autocomplete="off" class="layui-input noEdit mustEdit">\n' +
                        '         </div>\n' +
                        '     </div>\n' +
                        ' </div>\n' +
                        '</form>' +
                        '</div>',
                    success: function () {
                        $.ajax({
                            type: 'post',
                            url: '/WagesSalaryData/selectById',
                            dataType: 'json',
                            data: {
                                salaryDataId:data.salaryDataId
                            },
                            success: function (json) {
                                $('#remarks').val(json.object.remarks)
                            }
                        })

                    },
                    yes: function () {
                        $.ajax({
                            type: 'post',
                            url: '/WagesSalaryData/update',
                            dataType: 'json',
                            data: {
                                salaryDataId:data.salaryDataId,
                                remarks: $('#remarks').val()
                            },
                            success: function (json) {
                                $.layerMsg({content: '修改成功！', icon: 1}, function () {
                                    location.reload();
                                })
                            }
                        })
                    }
                });
            }else if(obj.event === 'detail2'){
                var theYear = $("#dataYear1").val()
                var theMonth = $("#dataMonth1").val()
                $.ajax({
                    type: 'post',
                    url: '/WagesSalaryData/calculateSalary',
                    dataType: 'json',
                    data: {
                        theYear:theYear,
                        theMonth:theMonth,
                        userId:data.userId
                    },
                    success: function (json) {
                        if(json.flag){
                            layer.closeAll();
                            $.layerMsg({content: '计算成功！', icon: 1}, function () {
                                location.reload();
                            })
                        }
                    }
                })
            }

        })


    });


</script>
</html>