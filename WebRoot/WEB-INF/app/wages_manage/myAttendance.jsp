<%--
  Created by IntelliJ IDEA.
  User: 张继斌
  Date: 2021/11/25
  Time: 11:06
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>我的考勤</title>
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
    .select{
        background-color: #FBD4B4;
    }
</style>
<body>
<div id="box" style="display: block">
    <div class="box2">
    </div>
    <div class="layui-tab layui-tab-brief" lay-filter="docDemoTabBrief">
        <ul class="layui-tab-title">
            <li id="shan">我的考勤</li>
            <li id="daiqueren">待确认考勤</li>
            <li>我的下属考勤</li>
        </ul>
        <div class="layui-tab-content">
            <div id="one" class="layui-tab-item">
            <div>
                <div style="float: left">
                    <label class="layui-form-label">年份</label>
                    <div class="layui-input-inline">
                        <input type="text" name="theYear"  id="theYear" lay-verify="required|phone" autocomplete="off" title="年份" class="layui-input jinyong mustEdit">
                    </div>
                </div>
                <div style="float: left">
                    <label class="layui-form-label">月份</label>
                    <div class="layui-input-inline">
                        <input type="text" name="theMonth"  id="theMonth" lay-verify="required|phone" autocomplete="off" title="月份" class="layui-input jinyong mustEdit">
                    </div>
                </div>
                <button type="button" class="layui-btn layui-btn-sm" id="search" lay-event="search" style="margin-left: 20px">查询</button>
            </div>
                <table class="layui-hide" id="test" lay-filter="test"></table>
            </div>
            <div id="two" class="layui-tab-item two">
                <div class="relative-right" style="display: inline-block;float: right; margin-top:-35px;height: 57px;">
                    <div class="niuma">


                    </div>
                </div>

                <table class="layui-hide" id="test1" lay-filter="test1"></table>
            </div>
            <div class="layui-tab-item three">
                <div>
                    <div style="float: left">
                        <label class="layui-form-label">年份</label>
                        <div class="layui-input-inline">
                            <input type="text" name="theYear1"  id="theYears" lay-verify="required|phone" autocomplete="off" title="年份" class="layui-input jinyong mustEdit">
                        </div>
                    </div>
                    <div style="float: left">
                        <label class="layui-form-label">月份</label>
                        <div class="layui-input-inline">
                            <input type="text" name="theMonth1"  id="theMonths" lay-verify="required|phone" autocomplete="off" title="月份" class="layui-input jinyong mustEdit">
                        </div>
                    </div>
                    <button type="button" class="layui-btn layui-btn-sm" id="searchs" lay-event="searchs" style="margin-left: 20px">查询</button>
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
        var cols = [{field: 'theYear',width:'100',title: '年份', rowspan:2}
            ,{field: 'theMonth',title: '月份', rowspan:2}
            ,{field: 'userName', title: '姓名', minWidth:100, rowspan:2}
            , {field: 'idNumber',width:'190', title: '身份证号', minWidth:100, rowspan:2}
            , {field: 'jobManageId', title: '薪岗', minWidth:120, event:'岗薪', rowspan:2, templet: function(res){
                    return res.jobManageName
                }}
            , {field: 'jobRatio', title: '薪岗比例', minWidth:100,event:'薪岗比例', rowspan:2}
            , {field: 'jobRatioType', title: '薪岗工资标准',colspan:6}
            , {field: 'attendType1', title: '1', event:'1', rowspan:2}
            , {field: 'attendType2', title: '2', event:'2', rowspan:2}
            , {field: 'attendType3', title: '3', event:'3', rowspan:2}
            , {field: 'attendType4', title: '4', event:'4', rowspan:2}
            , {field: 'attendType5', title: '5', event:'5', rowspan:2}
            , {field: 'attendType6', title: '6', event:'6', rowspan:2}
            , {field: 'attendType7', title: '7', event:'7', rowspan:2}
            , {field: 'attendType8', title: '8', event:'8', rowspan:2}
            , {field: 'attendType9', title: '9', event:'9', rowspan:2}
            , {field: 'attendType10', title: '10', event:'10', rowspan:2}
            , {field: 'attendType11', title: '11', event:'11', rowspan:2}
            , {field: 'attendType12', title: '12', event:'12', rowspan:2}
            , {field: 'attendType13', title: '13', event:'13', rowspan:2}
            , {field: 'attendType14', title: '14', event:'14', rowspan:2}
            , {field: 'attendType15', title: '15', event:'15', rowspan:2}
            , {field: 'attendType16', title: '16', event:'16', rowspan:2}
            , {field: 'attendType17', title: '17', event:'17', rowspan:2}
            , {field: 'attendType18', title: '18', event:'18', rowspan:2}
            , {field: 'attendType19', title: '19', event:'19', rowspan:2}
            , {field: 'attendType20', title: '20', event:'20', rowspan:2}
            , {field: 'attendType21', title: '21', event:'21', rowspan:2}
            , {field: 'attendType22', title: '22', event:'22', rowspan:2}
            , {field: 'attendType23', title: '23', event:'23', rowspan:2}
            , {field: 'attendType24', title: '24', event:'24', rowspan:2}
            , {field: 'attendType25', title: '25', event:'25', rowspan:2}
            , {field: 'attendType26', title: '26', event:'26', rowspan:2}
            , {field: 'attendType27', title: '27', event:'27', rowspan:2}
            , {field: 'attendType28', title: '28', event:'28', rowspan:2}
            , {field: 'attendType29', title: '29', event:'29', rowspan:2}
            , {field: 'attendType30', title: '30', event:'30', rowspan:2}
            , {field: 'attendType31', title: '31', event:'31', rowspan:2}]
        var cols2 = [ {field: 'salaryTypea', title: '出海绩效(A)',width:130}
            , {field: 'salaryTypeb', title: '浮动工资(B)',width:130}
            , {field: 'salaryTypec', title: '基本工资(C)', width:130}
            , {field: 'salaryTyped', title: '机关岗位工资(D)', width:140}
            , {field: 'salaryTypee', title: '其他1(E)', width:130}
            , {field: 'salaryTypef',title: '其他2(F)',width:130}];
        var colNum = 0, colNumMax = 0, colNum3 = 0;
        $.ajax({
            url: '/AttendanceRecord/selectAllAttendanceRecord',
            type: 'post',
            async: false,
            success: function(data){
                colNumMax = data.obj.length;
                cols.push({field: 'list', title: '考勤类型合计', minWidth: 80, colspan: colNumMax+1})
                cols.push({field: 'list1', title: '考勤薪资合计', minWidth: 80, colspan: colNumMax+1})
                for(var j = 0; j < data.obj.length; j++){
                    cols2.push({
                        field: 'type' + j, title: data.obj[j].typeCode, templet: function(res){
                            if(colNum >= colNumMax){
                                colNum = 0;
                            }
                            var str = "";
                            str += res.list[colNum].attendanceTypeCount;
                            colNum++;
                            return str;
                        }
                    })
                }
                cols2.push({
                    field: 'typeSum', title: '合计', minWidth: 80, templet: function(res){
                        var count = 0;
                        for (var i = 0; i < res.list.length; i++){
                            count = count + res.list[i].attendanceTypeCount;
                        }
                        return count + '天';
                    }
                })
                for(var j = 0; j < data.obj.length; j++){
                    cols2.push({
                        field: 'typeThree' + j, title: data.obj[j].typeCode, templet: function(res){
                            if(colNum3 >= colNumMax){
                                colNum3 = 0;
                            }
                            var str = "";
                            str += parseFloat(res.dailySalary[colNum3].daikySakary);
                            colNum3++;
                            return str;
                        }
                    })
                }
                cols2.push({
                    field: 'typeThreeSum', title: '合计', minWidth: 80, templet: function(res){
                        var count = 0;
                        for (var i = 0; i < res.dailySalary.length; i++){
                            count = count + parseFloat(res.dailySalary[i].daikySakary);
                        }
                        return count + '元';
                    }
                })
                var colsAfter = [
                    {field: 'remarks', title: '备注', rowspan:2},

                    , {field: 'confirmStatus', title: '状态', minWidth:90, rowspan:2, templet:function(d){
                            if(d.confirmStatus==1){
                                return '已确认'
                            }else if(d.confirmStatus==0){
                                return '待确认'
                            }
                        }},
                    {field: 'confirmStatus', title: '操作',minWidth:70, toolbar: '#barDemos', rowspan:2}
                ]
                cols = cols.concat(colsAfter)

            }
        })
        $('#search').on("click",function () {
            var theYear=$("[name='theYear']").val()
            var theMonth=$("[name='theMonth']").val();
            table.render({
                elem: '#test'
                , url:'/AttendanceType/selectAttendance'
                ,where:{
                    theYear:theYear,
                    theMonth:theMonth,
                }
                , cols: [
                    cols,cols2
                ],
                page:true,
                limit:10
                ,parseData: function(res){ //res 即为原始返回的数据
                    return {
                        "code":0,
                        "count":res.totleNum,
                        "data": res.obj //解析数据列表
                    };
                }
                ,done:function(res){
                    $('[data-field="42"]').hide()
                    // var trList = $('#test1').next().find('tr')
                    // for(var i = 1;i<trList.length;i++){
                    //     for(var j=0;j<trList.eq(i).find('td[lay-event]').length;j++){
                    //         if(res.data[i-1].jobObject != undefined){
                    //             if(res.data[i-1].jobObject['salaryPost' + (j+1)] != 0){
                    //                 trList.eq(i).find('td[lay-event]').eq(j).attr('class','select')
                    //             }
                    //         }
                    //     }
                    // }
                }
            });
        });

        $('#searchs').on("click",function () {
            var theYear=$("[name='theYear1']").val()
            var theMonth=$("[name='theMonth1']").val();
            table.render({
                elem: '#tests'
                , url:'/AttendanceType/selectAttendance'
                ,where:{
                    theYear:theYear,
                    theMonth:theMonth,
                }
                , cols: [
                    cols,cols2
                ],
                page:true,
                limit:10
                ,parseData: function(res){ //res 即为原始返回的数据
                    return {
                        "code":0,
                        "count":res.totleNum,
                        "data": res.obj //解析数据列表
                    };
                }
                ,done:function(res){
                    $('[data-field="42"]').hide()
                    // var trList = $('#test1').next().find('tr')
                    // for(var i = 1;i<trList.length;i++){
                    //     for(var j=0;j<trList.eq(i).find('td[lay-event]').length;j++){
                    //         if(res.data[i-1].jobObject != undefined){
                    //             if(res.data[i-1].jobObject['salaryPost' + (j+1)] != 0){
                    //                 trList.eq(i).find('td[lay-event]').eq(j).attr('class','select')
                    //             }
                    //         }
                    //     }
                    // }
                }
            });
        });
        $.ajax({
            url:'/orgDepartment/getPartyList',
            async:false,
            success:function(res){
                for(var i=0;i<res.obj.length;i++){
                    $("[name='orgDeptId']").append('<option value="'+res.obj[i].orgDeptId+'">'+res.obj[i].orgDeptName+'</option>');
                }
                form.render();
            }
        })

      // 我的考勤
            var meetTable=table.render({
                elem: '#test'
                , url: '/AttendanceType/selectAttendance?useFlag=true&confirmStatus=1'
                , defaultToolbar: ['filter', 'exports', 'print', { //自定义头部工具栏右侧图标。如无需自定义，去除该参数即可
                    title: '提示'
                    , layEvent: 'LAYTABLE_TIPS'
                    , icon: 'layui-icon-tips'
                }]
                , title: '用户数据表'
                , cols: [
                    cols,cols2
                ]
                , parseData: function (res) { //res 即为原始返回的数据
                    return {
                        "code": 0, //解析接口状态
                        "msg": res.msg, //解析提示文本
                        "count": res.totleNum, //解析数据长度
                        "data": res.obj, //解析数据列表
                    };
                }
                ,done:function(res){
                    $('[data-field="42"]').hide()
                    // var trList = $('#test').next().find('tr')
                    // for(var i = 1;i<trList.length;i++){
                    //     for(var j=0;j<trList.eq(i).find('td[lay-event]').length;j++){
                    //         if(res.data[i-1].jobObject != undefined){
                    //             if(res.data[i-1].jobObject['salaryPost' + (j+1)] != 0){
                    //                 trList.eq(i).find('td[lay-event]').eq(j).attr('class','select')
                    //             }
                    //         }
                    //     }
                    // }

                }
                , page: true
            })



        // 待确认考勤
        toBeConfirmed()
        function toBeConfirmed(){
            table.render({
                elem: '#test1'
                , url: '/AttendanceType/selectAttendance?useFlag=true&confirmStatus=0'
                , defaultToolbar: ['filter', 'exports', 'print', { //自定义头部工具栏右侧图标。如无需自定义，去除该参数即可
                    title: '提示'
                    , layEvent: 'LAYTABLE_TIPS'
                    , icon: 'layui-icon-tips'
                }]
                , title: '用户数据表'
                , cols: [
                    cols,cols2
                ]
                , width:"100%"
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

                    // var trList = $('#test1').next().find('tr')
                    // for(var i = 1;i<trList.length;i++){
                    //     for(var j=0;j<trList.eq(i).find('td[lay-event]').length;j++){
                    //         if(res.data[i-1].jobObject != undefined){
                    //             if(res.data[i-1].jobObject['salaryPost' + (j+1)] != 0){
                    //                 trList.eq(i).find('td[lay-event]').eq(j).attr('class','select')
                    //             }
                    //         }
                    //     }
                    // }
                }
                , page: true
            })
        }
        var y  = new Date().getFullYear();
        var month=new Date().getMonth()
        // 我的下属考勤
        table.render({
            elem: '#tests'
            , url: '/AttendanceType/selectSubordinate?useFlag=true&theYear='+y+'&theMonth='+month
            , defaultToolbar: ['filter', 'exports', 'print', { //自定义头部工具栏右侧图标。如无需自定义，去除该参数即可
                title: '提示'
                , layEvent: 'LAYTABLE_TIPS'
                , icon: 'layui-icon-tips'
            }]
            , title: '用户数据表'
            , cols: [
                cols,cols2
            ]
            , parseData: function (res) { //res 即为原始返回的数据
                return {
                    "code": 0, //解析接口状态
                    "msg": res.msg, //解析提示文本
                    "count": res.totleNum, //解析数据长度
                    "data": res.obj, //解析数据列表
                };
            }
            ,done:function(res){
                $('[data-field="42"]').hide()
                // var trList = $('#tests').next().find('tr')
                // for(var i = 1;i<trList.length;i++){
                //     for(var j=0;j<trList.eq(i).find('td[lay-event]').length;j++){
                //         if(res.data[i-1].jobObject != undefined){
                //             if(res.data[i-1].jobObject['salaryPost' + (j+1)] != 0){
                //                 trList.eq(i).find('td[lay-event]').eq(j).attr('class','select')
                //             }
                //         }
                //     }
                // }
            }
            , page: true
        })
        //详情弹窗
        table.on('tool(test)', function (obj) {
            if(obj.event != "detail2" || obj.event != "detail4" || obj.event != "detail1"){
                var jobRatio = obj.data.jobRatio
                attendTypeId = obj.data.attendTypeId
                var attendType = obj.event
                var value = obj.value
                if(isNaN(attendType) == 0){
                    $.ajax({
                        type: 'post',
                        url: '/AttendanceType/selectOneDayDate',
                        dataType: 'json',
                        data: {
                            attendTypeId:attendTypeId,
                            day:attendType,
                        },
                        success: function (res) {
                            var oneDayPerDiem = res.object.oneDayPerDiem
                            var oneDaySalaryRatio = res.object.oneDaySalaryRatio
                            var oneAttendanceType = res.object.oneAttendanceType
                            var jobRatio = res.object.jobRatio
                            var oneDayPerDiem = res.object.oneDayPerDiem
                            layer.open({
                                type: 1,
                                area: ['531px', '372px'], //宽高
                                title: '修改',
                                maxmin: true,
                                btn: ['取消'], //可以无限个按钮
                                content: '<div style="margin: 43px auto;">' +
                                    '<form class="layui-form" action="">\n' +
                                    ' <div class="layui-form-item" >\n' +
                                    '     <div class="layui-inline" >\n' +
                                    '         <label class="layui-form-label" >日薪</label>\n' +
                                    '         <div class="layui-input-inline">\n' +
                                    '             <input disabled="disabled" type="text" name="oneDayPerDiem"  lay-verify="required|phone" autocomplete="off" class="layui-input noEdit mustEdit" title="机构全称">\n' +
                                    '         </div>\n' +
                                    '     </div>\n' +
                                    ' <div class="layui-form-item" >\n' +
                                    '     <div class="layui-inline" >\n' +
                                    '         <label class="layui-form-label" style="margin-top: 15px" >岗薪比例</label>\n' +
                                    '         <div class="layui-input-inline">\n' +
                                    '             <input style="margin-top: 15px" disabled="disabled" type="text" name="oneDaySalaryRatio"  lay-verify="required|phone" autocomplete="off" class="layui-input noEdit mustEdit" title="机构全称">\n' +
                                    '         </div>\n' +
                                    '     </div>\n' +
                                    ' </div>\n' +
                                    '<div class="layui-form-item" >\n' +
                                    '     <div class="layui-inline" >\n' +
                                    '         <label class="layui-form-label" >考勤类型</label>\n' +
                                    '         <div class="layui-input-inline">\n' +
                                    '            <select id="zhu" disabled="disabled" name="schoolTypes" class="schoolType noEdit" lay-verify="required" lay-search="" title="考勤类型">\n' +
                                    '                <option value="">请选择</option>\n' +
                                    '            </select>\n' +
                                    '         </div>\n' +
                                    '     </div>\n' +
                                    ' </div>' +
                                    ' </div>\n' +
                                    '</form>' +
                                    '</div>',
                                success: function () {

                                    form.render()
                                    $("input[name='oneDayPerDiem']").val(oneDayPerDiem)
                                    $("input[name='oneDaySalaryRatio']").val(oneDaySalaryRatio)
                                    $("input[name='oneAttendanceType1']").val(oneAttendanceType)
                                    $.ajax({
                                        type: 'post',
                                        url: '/AttendanceRecord/selectAllAttendanceRecord',
                                        dataType: 'json',
                                        success: function (json) {
                                            var str=''
                                            for(var i=0;i<json.obj.length;i++){
                                                str+='<option value="'+json.obj[i].typeCode+'" selected=selected>'+json.obj[i].attendanceRecordClassifyName+'---'+json.obj[i].attendanceRecordType+'---'+json.obj[i].typeCode+'</option>'
                                            }
                                            $("select[name='schoolTypes']").html(str)
                                            form.render();
                                            if(oneDayPerDiem == undefined){
                                                $("input[name='oneDayPerDiem']").val('')
                                            }else{
                                                $("input[name='oneDayPerDiem']").val(oneDayPerDiem)
                                            }
                                            $("input[name='oneDaySalaryRatio']").val(jobRatio)
                                            if(oneAttendanceType !=''){
                                                $("#zhu option[value="+oneAttendanceType+"]").prop("selected",true)
                                            }
                                                form.render();
                                        }
                                    })
                                },
                                // yes: function (index, layero) {
                                //     var oneDaySalaryRatio = $("input[name='oneDaySalaryRatio']").val()
                                //     var oneAttendanceType1 = $("select[name='schoolTypes']").val()
                                //     $.ajax({
                                //         type: 'post',
                                //         url: '/AttendanceType/updateOneDayDate',
                                //         dataType: 'json',
                                //         data: {
                                //             attendTypeId:attendTypeId,
                                //             day:attendType,
                                //             oneDaySalaryRatio:oneDaySalaryRatio,
                                //             oneAttendanceType:oneAttendanceType1
                                //         },
                                //         success: function (json) {
                                //             layer.close(index);
                                //             layer.msg('修改成功！',{icon:1});
                                //         }
                                //     })
                                // }
                            });
                        }
                    })
                }
                // else if(attendType == '岗薪'){
                //     $.ajax({
                //         type: 'post',
                //         url: '/WagesJobManage/selectAll',
                //         async:false,
                //         dataType: 'json',
                //         success: function (res) {
                //             console.log(res.obj)
                //             var obj = res.obj
                //             layer.open({
                //                 type: 1,
                //                 area: ['531px', '372px'], //宽高
                //                 title: '修改',
                //                 maxmin: true,
                //                 btn: ['确定'], //可以无限个按钮
                //                 content: '<div style="margin: 43px auto;">' +
                //                     '<form class="layui-form" action="">\n' +
                //                     ' <div class="layui-form-item" >\n' +
                //                     '    <div class="layui-inline">\n' +
                //                     '        <label class="layui-form-label">岗薪</label>\n' +
                //                     '        <div class="layui-input-inline">\n' +
                //                     '            <select id="zhu" name="schoolType" class="schoolType noEdit" lay-verify="required" lay-search="" title="岗薪">\n' +
                //                     '                <option value="">请选择</option>\n' +
                //                     '            </select>\n' +
                //                     '        </div>\n' +
                //                     '    </div>\n' +
                //                     '</div>' +
                //                     '</form>' +
                //                     '</div>',
                //                 success: function () {
                //                     var str=''
                //                     for(var i=0;i<obj.length;i++){
                //                         str+='<option value="'+obj[i].jobManageId+'" selected=selected>'+obj[i].job+'</option>'
                //                     }
                //                     $("select[name='schoolType']").html(str)
                //                     form.render();
                //                     if(jobManageId != ''){
                //                         $("#zhu option[value="+jobManageId+"]").prop("selected",true)
                //                     }
                //                     form.render();
                //                 },
                //                 yes: function (index, layero) {
                //                     var jobManageId = $("select[name='schoolType']").val()
                //                     $.ajax({
                //                         type: 'post',
                //                         url: '/AttendanceType/updateAttendanceType',
                //                         dataType: 'json',
                //                         data: {
                //                             attendTypeId:attendTypeId,
                //                             jobManageId:jobManageId
                //                         },
                //                         success: function (json) {
                //                             layer.close(index);
                //                             layer.msg('修改成功！',{icon:1});
                //                             table.reload('test1');
                //                         }
                //                     })
                //                 }
                //             });
                //         }
                //     })
                // }
                // else if(attendType == '薪岗比例'){
                //     layer.open({
                //         type: 1,
                //         area: ['531px', '372px'], //宽高
                //         title: '修改',
                //         maxmin: true,
                //         btn: ['确定'], //可以无限个按钮
                //         content: '<div style="margin: 43px auto;">' +
                //             '<form class="layui-form" action="">\n' +
                //             ' <div class="layui-form-item" >\n' +
                //             '     <div class="layui-inline" >\n' +
                //             '         <label class="layui-form-label" style="margin-top: 15px" >岗薪比例</label>\n' +
                //             '         <div class="layui-input-inline">\n' +
                //             '             <input style="margin-top: 15px"  type="text" name="jobRatio"  lay-verify="required|phone" autocomplete="off" class="layui-input noEdit mustEdit" title="机构全称">\n' +
                //             '         </div>\n' +
                //             '     </div>\n' +
                //             ' </div>\n' +
                //             '</form>' +
                //             '</div>',
                //         success: function () {
                //             $("input[name='jobRatio']").val(jobRatio)
                //         },
                //         yes: function (index, layero) {
                //             var jobRatio = $("input[name='jobRatio']").val()
                //             var jobManageId = $("select[name='schoolType']").val()
                //             $.ajax({
                //                 type: 'post',
                //                 url: '/AttendanceType/updateAttendanceType',
                //                 dataType: 'json',
                //                 data: {
                //                     attendTypeId:attendTypeId,
                //                     jobManageId:jobManageId,
                //                     jobRatio:jobRatio
                //                 },
                //                 success: function (json) {
                //                     layer.close(index);
                //                     layer.msg('修改成功！',{icon:1});
                //                     table.reload('test1');
                //                 }
                //             })
                //         }
                //     });
                // }
            }
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
            if(obj.event != "detail2" || obj.event != "detail4" || obj.event != "detail1"){
                var jobRatio = obj.data.jobRatio
                attendTypeId = obj.data.attendTypeId
                var attendType = obj.event
                var value = obj.value
                if(isNaN(attendType) == 0){
                    $.ajax({
                        type: 'post',
                        url: '/AttendanceType/selectOneDayDate',
                        dataType: 'json',
                        data: {
                            attendTypeId:attendTypeId,
                            day:attendType,
                        },
                        success: function (res) {
                            var oneDayPerDiem = res.object.oneDayPerDiem
                            var oneDaySalaryRatio = res.object.oneDaySalaryRatio
                            var oneAttendanceType = res.object.oneAttendanceType
                            var jobRatio = res.object.jobRatio
                            var oneDayPerDiem = res.object.oneDayPerDiem
                            layer.open({
                                type: 1,
                                area: ['531px', '372px'], //宽高
                                title: '修改',
                                maxmin: true,
                                btn: ['取消'], //可以无限个按钮
                                content: '<div style="margin: 43px auto;">' +
                                    '<form class="layui-form" action="">\n' +
                                    ' <div class="layui-form-item" >\n' +
                                    '     <div class="layui-inline" >\n' +
                                    '         <label class="layui-form-label" >日薪</label>\n' +
                                    '         <div class="layui-input-inline">\n' +
                                    '             <input disabled="disabled" type="text" name="oneDayPerDiem"  lay-verify="required|phone" autocomplete="off" class="layui-input noEdit mustEdit" title="机构全称">\n' +
                                    '         </div>\n' +
                                    '     </div>\n' +
                                    ' <div class="layui-form-item" >\n' +
                                    '     <div class="layui-inline" >\n' +
                                    '         <label class="layui-form-label" style="margin-top: 15px" >岗薪比例</label>\n' +
                                    '         <div class="layui-input-inline">\n' +
                                    '             <input style="margin-top: 15px" disabled="disabled" type="text" name="oneDaySalaryRatio"  lay-verify="required|phone" autocomplete="off" class="layui-input noEdit mustEdit" title="机构全称">\n' +
                                    '         </div>\n' +
                                    '     </div>\n' +
                                    ' </div>\n' +
                                    '<div class="layui-form-item" >\n' +
                                    '     <div class="layui-inline" >\n' +
                                    '         <label class="layui-form-label" >考勤类型</label>\n' +
                                    '         <div class="layui-input-inline">\n' +
                                    '            <select id="zhu" disabled="disabled" name="schoolTypes" class="schoolType noEdit" lay-verify="required" lay-search="" title="考勤类型">\n' +
                                    '                <option value="">请选择</option>\n' +
                                    '            </select>\n' +
                                    '         </div>\n' +
                                    '     </div>\n' +
                                    ' </div>' +
                                    ' </div>\n' +
                                    '</form>' +
                                    '</div>',
                                success: function () {

                                    form.render()
                                    $("input[name='oneDayPerDiem']").val(oneDayPerDiem)
                                    $("input[name='oneDaySalaryRatio']").val(oneDaySalaryRatio)
                                    $("input[name='oneAttendanceType1']").val(oneAttendanceType)
                                    $.ajax({
                                        type: 'post',
                                        url: '/AttendanceRecord/selectAllAttendanceRecord',
                                        dataType: 'json',
                                        success: function (json) {
                                            var str=''
                                            for(var i=0;i<json.obj.length;i++){
                                                str+='<option value="'+json.obj[i].typeCode+'" selected=selected>'+json.obj[i].attendanceRecordClassifyName+'---'+json.obj[i].attendanceRecordType+'---'+json.obj[i].typeCode+'</option>'
                                            }
                                            $("select[name='schoolTypes']").html(str)
                                            form.render();
                                            if(oneDayPerDiem == undefined){
                                                $("input[name='oneDayPerDiem']").val('')
                                            }else{
                                                $("input[name='oneDayPerDiem']").val(oneDayPerDiem)
                                            }
                                            $("input[name='oneDaySalaryRatio']").val(jobRatio)
                                            if(oneAttendanceType !=''){
                                                $("#zhu option[value="+oneAttendanceType+"]").prop("selected",true)
                                            }
                                            form.render();
                                        }
                                    })
                                },
                                // yes: function (index, layero) {
                                //     var oneDaySalaryRatio = $("input[name='oneDaySalaryRatio']").val()
                                //     var oneAttendanceType1 = $("select[name='schoolTypes']").val()
                                //     $.ajax({
                                //         type: 'post',
                                //         url: '/AttendanceType/updateOneDayDate',
                                //         dataType: 'json',
                                //         data: {
                                //             attendTypeId:attendTypeId,
                                //             day:attendType,
                                //             oneDaySalaryRatio:oneDaySalaryRatio,
                                //             oneAttendanceType:oneAttendanceType1
                                //         },
                                //         success: function (json) {
                                //             layer.close(index);
                                //             layer.msg('修改成功！',{icon:1});
                                //         }
                                //     })
                                // }
                            });
                        }
                    })
                }
                // else if(attendType == '岗薪'){
                //     $.ajax({
                //         type: 'post',
                //         url: '/WagesJobManage/selectAll',
                //         async:false,
                //         dataType: 'json',
                //         success: function (res) {
                //             console.log(res.obj)
                //             var obj = res.obj
                //             layer.open({
                //                 type: 1,
                //                 area: ['531px', '372px'], //宽高
                //                 title: '修改',
                //                 maxmin: true,
                //                 btn: ['确定'], //可以无限个按钮
                //                 content: '<div style="margin: 43px auto;">' +
                //                     '<form class="layui-form" action="">\n' +
                //                     ' <div class="layui-form-item" >\n' +
                //                     '    <div class="layui-inline">\n' +
                //                     '        <label class="layui-form-label">岗薪</label>\n' +
                //                     '        <div class="layui-input-inline">\n' +
                //                     '            <select id="zhu" name="schoolType" class="schoolType noEdit" lay-verify="required" lay-search="" title="岗薪">\n' +
                //                     '                <option value="">请选择</option>\n' +
                //                     '            </select>\n' +
                //                     '        </div>\n' +
                //                     '    </div>\n' +
                //                     '</div>' +
                //                     '</form>' +
                //                     '</div>',
                //                 success: function () {
                //                     var str=''
                //                     for(var i=0;i<obj.length;i++){
                //                         str+='<option value="'+obj[i].jobManageId+'" selected=selected>'+obj[i].job+'</option>'
                //                     }
                //                     $("select[name='schoolType']").html(str)
                //                     form.render();
                //                     if(jobManageId != ''){
                //                         $("#zhu option[value="+jobManageId+"]").prop("selected",true)
                //                     }
                //                     form.render();
                //                 },
                //                 yes: function (index, layero) {
                //                     var jobManageId = $("select[name='schoolType']").val()
                //                     $.ajax({
                //                         type: 'post',
                //                         url: '/AttendanceType/updateAttendanceType',
                //                         dataType: 'json',
                //                         data: {
                //                             attendTypeId:attendTypeId,
                //                             jobManageId:jobManageId
                //                         },
                //                         success: function (json) {
                //                             layer.close(index);
                //                             layer.msg('修改成功！',{icon:1});
                //                             table.reload('test1');
                //                         }
                //                     })
                //                 }
                //             });
                //         }
                //     })
                // }
                // else if(attendType == '薪岗比例'){
                //     layer.open({
                //         type: 1,
                //         area: ['531px', '372px'], //宽高
                //         title: '修改',
                //         maxmin: true,
                //         btn: ['确定'], //可以无限个按钮
                //         content: '<div style="margin: 43px auto;">' +
                //             '<form class="layui-form" action="">\n' +
                //             ' <div class="layui-form-item" >\n' +
                //             '     <div class="layui-inline" >\n' +
                //             '         <label class="layui-form-label" style="margin-top: 15px" >岗薪比例</label>\n' +
                //             '         <div class="layui-input-inline">\n' +
                //             '             <input style="margin-top: 15px"  type="text" name="jobRatio"  lay-verify="required|phone" autocomplete="off" class="layui-input noEdit mustEdit" title="机构全称">\n' +
                //             '         </div>\n' +
                //             '     </div>\n' +
                //             ' </div>\n' +
                //             '</form>' +
                //             '</div>',
                //         success: function () {
                //             $("input[name='jobRatio']").val(jobRatio)
                //         },
                //         yes: function (index, layero) {
                //             var jobRatio = $("input[name='jobRatio']").val()
                //             var jobManageId = $("select[name='schoolType']").val()
                //             $.ajax({
                //                 type: 'post',
                //                 url: '/AttendanceType/updateAttendanceType',
                //                 dataType: 'json',
                //                 data: {
                //                     attendTypeId:attendTypeId,
                //                     jobManageId:jobManageId,
                //                     jobRatio:jobRatio
                //                 },
                //                 success: function (json) {
                //                     layer.close(index);
                //                     layer.msg('修改成功！',{icon:1});
                //                     table.reload('test1');
                //                 }
                //             })
                //         }
                //     });
                // }
            }
            if(obj.event == "detail"){
                $.ajax({
                    url:'/AttendanceType/updateConfirm',
                    dataType:'json',
                    data:{
                        attendTypeId:obj.data.attendTypeId
                    },
                    success:function(res){
                        table.reload('test')
                        table.reload('test1')
                    }
                })
            }
        })

        $(document).on("click","#submit",function(){
            layer.close('page')
        })
    });


</script>
</html>
