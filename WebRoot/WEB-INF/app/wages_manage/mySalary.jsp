<%--
  Created by IntelliJ IDEA.
  User: 张继斌
  Date: 2021/11/30
  Time: 13:30
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>我的工资</title>
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
    <script type="text/javascript" src="/lib/jQuery-File-Upload-master/jquery-ui.js"></script>
    <script type="text/javascript" src="/lib/jQuery-File-Upload-master/jquery.iframe-transport.js"></script>
    <script type="text/javascript" src="/lib/jQuery-File-Upload-master/jquery.fileupload.js"></script>
    <script src="/lib/layui/layui/js/common.js?v=20190726" type="text/javascript" charset="utf-8"></script>
    <script src="/lib/ueditor/ueditor.config.js?20200919" type="text/javascript" charset="utf-8"></script>
    <script src="/lib/ueditor/ueditor.all.js?20200919" type="text/javascript" charset="utf-8"></script>
    <script src="/lib/ueditor/UEcontroller.js?20200919" type="text/javascript" charset="utf-8"></script>

    <script src="/lib/jQuery-File-Upload-master/jquery-ui.js?20201221.1" type="text/javascript" charset="utf-8"></script>
    <script src="/lib/jQuery-File-Upload-master/jquery.fileupload.js?20201221.1" type="text/javascript" charset="utf-8"></script>
</head>
<style>
    #layui-laydate2 .layui-laydate-header {
        display: none;
    }
</style>
<body>
<div id="box" style="display: block">
    <div class="box2">
    </div>
    <div class="layui-tab layui-tab-brief" lay-filter="docDemoTabBrief">
        <ul class="layui-tab-title">
            <li  id="shan" class="layui-this">我的工资</li>
            <li id="daiqueren">待确认工资</li>
            <li>我的下属工资</li>
        </ul>
        <div class="layui-tab-content">
            <div id="one" class="layui-tab-item one">
                <div>
                    <div style="float: left">
                        <label class="layui-form-label">年份</label>
                        <div class="layui-input-inline">
                            <input type="text" name="dataYear"  id="theYear" lay-verify="required|phone" autocomplete="off" title="年份" class="layui-input jinyong mustEdit">
                        </div>
                    </div>
                    <div style="float: left">
                        <label class="layui-form-label">月份</label>
                        <div class="layui-input-inline">
                            <input type="text" name="dataMonth"  id="theMonth" lay-verify="required|phone" autocomplete="off" title="月份" class="layui-input jinyong mustEdit">
                        </div>
                    </div>
                    <button type="button" class="layui-btn layui-btn-sm" id="search" lay-event="search" style="margin-left: 20px">查询</button>
                </div>
                <table class="layui-hide" id="test" lay-filter="test"></table>
            </div>
            <div id="two" class="layui-tab-item two ">
                <div class="relative-right" style="display: inline-block;float: right; margin-top:-35px;height: 57px;">
                    <div class="niuma">


                    </div>
                </div>

                <table class="layui-hide" id="test1" lay-filter="test1"></table>
            </div>
            <div id="three" class="layui-tab-item three">
                <div>
                    <div style="float: left">
                        <label class="layui-form-label">年份</label>
                        <div class="layui-input-inline">
                            <input type="text" name="dataYears"  id="theYears" lay-verify="required|phone" autocomplete="off" title="年份" class="layui-input jinyong mustEdit">
                        </div>
                    </div>
                    <div style="float: left">
                        <label class="layui-form-label">月份</label>
                        <div class="layui-input-inline">
                            <input type="text" name="dataMonths"  id="theMonths" lay-verify="required|phone" autocomplete="off" title="月份" class="layui-input jinyong mustEdit">
                        </div>
                    </div>
                    <button type="button" class="layui-btn layui-btn-sm" id="searchs" lay-event="search" style="margin-left: 20px">查询</button>
                </div>
                <table class="layui-hide" id="tests" lay-filter="test"></table>
            </div>
        </div>
    </div>

</div>


</table>
<script id="barDemo" type="text/html">
    <div class="long">
        <a id="detail" lay-event="detail" data-index="i" style="color: blue;cursor:pointer; text-decoration:underline">详情</a>
        <a lay-event="edit" id="edit" style="color: blue;cursor:pointer; text-decoration:underline">编辑</a>
        <a lay-event="del" id="delete" style="color: blue;cursor:pointer; text-decoration:underline">删除</a>
    </div>

</script>
<script id="barDemos" type="text/html">
    <div class="long">
        <a id="detail1" lay-event="detail" data-index="i" style="color: blue;cursor:pointer; text-decoration:underline">确认</a>
    </div>

</script>

</body>
<script>
    var param = $.GetRequest();
    var flag = param.flag
    if(flag=='true'){
        flag()
    }
    function flag(){
        if(flag=='true'){
            $("#shan").attr('class','')
            $("#daiqueren").attr('class','layui-this')
            $("#two").addClass("layui-show")
        }else{
            $("#daiqueren").attr('class','')
            $("#shan").attr('class','layui-this')
            $("#one").addClass("layui-show")
        }
    }

    for(var i =2010;i<=2040;i++){
        $("[name='yearSel']").append('<option value="' + i + '">' + i + '</option>');
    }
    layui.use(['form', 'table', 'element', 'layedit','eleTree'], function () {
        var table = layui.table
        var form = layui.form
        var element = layui.element
        var layedit = layui.layedit
        var eleTree = layui.eleTree
        var laydate = layui.laydate;
        var attendTypeId;
        var daiqueren;
        laydate.render({
            elem: '#theYear'
            , type: 'year'
        });
        laydate.render({
            elem: '#theMonth'
            , type: 'month'
            ,format: "M"
        });
        laydate.render({
            elem: '#theYears'
            , type: 'year'
        });
        laydate.render({
            elem: '#theMonths'
            , type: 'month'
            ,format: "M"
        });
        form.render()

        var el;

        $("[name='orgDeptId']").on("click",function (e) {
            e.stopPropagation();
            if(!el){
                $.get('/orgDepartment/queryByDepIdList?deptId=0', function (res) {
                    //layer.close(loadingIndex);
                    if (res.flag) {
                        el = layui.eleTree.render({
                            elem: '.ele2',
                            data: res.obj,
                            expandOnClickNode: false,
                            highlightCurrent: true,
                            showLine: true,
                            showCheckbox: false,
                            checked: false,
                            lazy: true,
                            //defaultExpandAll: false,
                            request: {
                                name: 'orgDeptName',
                                id:'orgDeptId',
                                isLeaf:false
                                //children: "plbProjList",
                            },
                            load: function(data,callback) {
                                $.post('/orgDepartment/queryByDepIdList?deptId='+data.deptId,function (res) {
                                    callback(res.obj);//点击节点回调
                                })
                            },
                            done: function(res){
                                if(res.data.length == 0){
                                    $(".ele2").html('<div style="text-align: center">暂无数据</div>');
                                }
                            }
                        });

                    }
                });
            }
            $(".ele2").slideDown();
        })
        $(document).on("click",function() {
            $(".ele2").slideUp();
        })
        //节点点击事件
        layui.eleTree.on("nodeClick(data2)",function(d) {
            var parData1 = d.data.currentData;
            $("[name='orgDeptId']").val(parData1.deptName);
            $("#orgDeptName").attr("pid",parData1.deptId);
        })

        $('#search').on("click",function () {
            var theYear=$("[name='dataYear']").val()
            var theMonth=$("[name='dataMonth']").val();
            table.render({
                elem: '#test'
                , url:'/WagesSalaryData/Mysalary?useFlag=true'+'&pageSize='+'10'
                ,where:{
                    dataYear:theYear,
                    dataMonth:theMonth,
                    ackStatus:'1'
                }
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
                    , {field: 'deductPublicHoliday',width:'190', title: '扣公休期间个人奖金部分',}
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
                    // , {field: '', title: '操作',width:'160', toolbar: '#barDemos',}
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
        form.render()
        $('#searchs').on("click",function () {
            var theYear=$("[name='dataYears']").val()
            var theMonth=$("[name='dataMonths']").val();
            table.render({
                elem: '#tests'
                , url:'/WagesSalaryData/subordinate?useFlag=true'+'&pageSize='+'10'
                ,where:{
                    dataYear:theYear,
                    dataMonth:theMonth,

                }
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
                    , {field: 'deductPublicHoliday',width:'190', title: '扣公休期间个人奖金部分',}
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
                    // , {field: '', title: '操作',width:'160', toolbar: '#barDemos',}
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

        // 我的工资
        var meetTable=table.render({
            elem: '#test'
            , url: '/WagesSalaryData/Mysalary?useFlag=true&ackStatus=1'+'&pageSize='+'10'
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
                , {field: 'jobRatio', title: '薪岗比例', width:90}
                , {field: 'seaGoingPerformance', title: '出海绩效',width:90 }
                , {field: 'floatPay', title: '浮动工资', width: 90}
                , {field: 'basePay',title: '基本工资', width: 90}
                , {field: 'jobPay',width:'130',title: '机关岗位工资', }
                , {field: 'other1', title: '其他1', width: 68}
                , {field: 'other2',title: '其他2',width: 68}
                , {field: 'onSiteWork',title: '现场上班', width: 90}
                , {field: 'jobWork', title: '机关上班', width: 90}
                , {field: 'rest', title: '休息',}
                , {field: 'totalAttendance', title: '出勤合计',width: 90}
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
                , {field: 'deductPublicHoliday',width:'190', title: '扣公休期间个人奖金部分',}
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
                // , {field: '', title: '操作',width:'160', toolbar: '#barDemos',}
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


        // 待确认工资
        toBeConfirmed()
        function toBeConfirmed(){
            table.render({
                elem: '#test1'
                , url: '/WagesSalaryData/Mysalary?useFlag=true&ackStatus=0'+'&pageSize='+'10'
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
                    , {field: 'jobRatio', title: '薪岗比例', width:90}
                    , {field: 'seaGoingPerformance', title: '出海绩效',width:90 }
                    , {field: 'floatPay', title: '浮动工资', width: 90}
                    , {field: 'basePay',title: '基本工资', width: 90}
                    , {field: 'jobPay',width:'130',title: '机关岗位工资', }
                    , {field: 'other1', title: '其他1', width: 68}
                    , {field: 'other2',title: '其他2',width: 68}
                    , {field: 'onSiteWork',title: '现场上班', width: 90}
                    , {field: 'jobWork', title: '机关上班', width: 90}
                    , {field: 'rest', title: '休息',}
                    , {field: 'totalAttendance', title: '出勤合计',width: 90}
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
                    , {field: 'deductPublicHoliday',width:'190', title: '扣公休期间个人奖金部分',}
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
                    , {field: '', title: '操作',width:'160', toolbar: '#barDemos',}
                ]]
                , parseData: function (res) { //res 即为原始返回的数据
                    return {
                        "code": 0, //解析接口状态
                        "msg": res.msg, //解析提示文本
                        "count": res.totleNum, //解析数据长度
                        "data": res.obj, //解析数据列表
                    };
                }
                ,done:function(res){
                    daiqueren = res.data
                    if(daiqueren.length != 0){
                        $("#shan").removeClass("layui-this")
                        $("#daiqueren").attr('class','layui-this')
                        $("#two").addClass("layui-show")
                    }else{
                        $("#daiqueren").attr('class','')
                        $("#shan").attr('class','layui-this')
                        $("#one").addClass("layui-show")
                    }
                }
                , page: true
            })
        }
        // 我的下属工资
        table.render({
            elem: '#tests'
            , url: '/WagesSalaryData/subordinate?useFlag=true'+'&pageSize='+'10'
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
                , {field: 'jobRatio', title: '薪岗比例', width:90}
                , {field: 'seaGoingPerformance', title: '出海绩效',width:90 }
                , {field: 'floatPay', title: '浮动工资', width: 90}
                , {field: 'basePay',title: '基本工资', width: 90}
                , {field: 'jobPay',width:'130',title: '机关岗位工资', }
                , {field: 'other1', title: '其他1', width: 68}
                , {field: 'other2',title: '其他2',width: 68}
                , {field: 'onSiteWork',title: '现场上班', width: 90}
                , {field: 'jobWork', title: '机关上班', width: 90}
                , {field: 'rest', title: '休息',}
                , {field: 'totalAttendance', title: '出勤合计',width: 90}
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
                , {field: 'deductPublicHoliday',width:'190', title: '扣公休期间个人奖金部分',}
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
                // , {field: '', title: '操作',width:'160', toolbar: '#barDemos',}
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
        //详情弹窗
        table.on('tool(test)', function (obj) {
            var data = obj.data;
            var dataObj = obj.data;
            var layEvent = obj.event;
            if (obj.event === 'del') {
                layer.confirm('确定要删除吗',{icon: 3, title:'提示'},function(){
                    $.ajax({
                        url:'/branchCommitteeMeeting/remove',
                        dataType:'json',
                        data:{
                            committeeId:data.committeeId
                        },
                        success:function(res){
                            table.reload('test');
                            form.render();
                            layer.closeAll();
                        }
                    })
                })
                // layer.confirm('真的删除行么', function (index) {
                //     obj.del();
                //     layer.close(index);
                // });
            } else if (obj.event === 'edit') {
                data = obj.data;
                layer.open({
                    type: 2 //此处以iframe举例
                    , title: ''
                    , area: ['80%', '90%'],
                    btn:['提交','取消'],
                    content: '/orgLife/addBranchCommitteeMeeting?btnType=2&committeeId='+dataObj.committeeId+'',
                    // success:function(){
                    //     fileuploadFn('#fileupload', $('#fileAll'));
                    // },
                    yes:function(index,layero){
                        var dataobj = $(layero).find("iframe")[0].contentWindow.getDataInsert();
                        if (dataobj!=undefined){
                            $.ajax({
                                url:'/branchCommitteeMeeting/edit?committeeId='+dataObj.committeeId+'',
                                data:dataobj,
                                success:function(res){
                                    // fileuploadFn('#miSongFiles',$('#fileAlls'));
                                    if(res.flag){
                                        layer.msg(res.msg)
                                        layer.close(index);
                                        meetTable.reload();
                                    }
                                }
                            })
                        }

                    }


                })


            } else if (obj.event === 'detail') {
                data = obj.data;
                layer.open({
                    type: 2 //此处以iframe举例
                    , title: ''
                    , area: ['80%', '90%'],
                    content: '/orgLife/addBranchCommitteeMeeting?btnType=1&committeeId='+dataObj.committeeId+''
                    ,
                    success: function () {
                        form.val("formTest",obj.data);
                        $.ajax({
                            url:'/branchCommitteeMeeting/queryById',
                            dataType:'json',
                            data:{
                                committeeId:data.committeeId
                            },
                            success:function(res){
                                // fileuploadFn('#miSongFiles',$('#fileAlls'));
                                var datas = res.object.moderatorId;
                                form.render();
                            }
                        })

                        $.ajax({
                            url:'/PtyMemberComment/getOrgDepartment',
                            dataType:'json',
                            success:function(res){
                                var datas = res.obj;
                                var str = '<option value=""></option>';
                                for(var i=0;i<datas.length;i++){
                                    str += '<option value="' +datas[i].orgDeptId + '"> '+ datas[i].orgDeptName + '</option>'
                                }
                                $('#belog').html(str)
                                $("#belog").each(function() {
                                    $(this).children("option").each(function() {
                                        if (this.value == data.orgDeptId) {
                                            $(this).attr("selected","selected");
                                        }

                                    });
                                })
                                form.render();
                            }

                        })

                        form.render()
                    },


                })


            }
        })

        $(document).on("click", "#people1", function () {
            org_id="people1";
            $.popWindow("../common/selectPartyMember?0");
        })
        table.on('tool(test1)', function(obj){
            $.ajax({
                url:'/WagesSalaryData/update',
                dataType:'json',
                data:{
                    salaryDataId:obj.data.salaryDataId,
                    ackStatus:'1'
                },
                success:function(res){
                    table.reload('test')
                    table.reload('test1')
                }
            })
        })

        $(document).on("click","#submit",function(){
            layer.close('page')
        })
    });


</script>
</html>
