<%--
  Created by IntelliJ IDEA.
  User: 张继斌
  Date: 2022/2/24
  Time: 10:34
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>考勤数据统计</title>
    <meta name="renderer" content="webkit">
    <meta http-equiv="X-UA-Compatible" content="IE=10,chrome=1">
    <meta name="viewport"
          content="width=device-width, initial-scale=1.0, user-scalable=0, minimum-scale=1.0, maximum-scale=1.0">
    <link rel="stylesheet" type="text/css" href="/lib/layui/layui/css/layui.css?20210319.1"/>
    <link rel="stylesheet" href="/lib/layui/layui/css/layui.css">
    <script type="text/javascript" src="/ui/js/xoajq/xoajq3.js"></script>
    <script type="text/javascript" src="/lib/layui/layui/layui.all_v2.5.js"></script>
    <script type="text/javascript" src="/js/base/base.js?20211220.2"></script>
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
    .layui-table-body{
        height: 54%;
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
    /*.select{*/
    /*    background-color: #FBD4B4;*/
    /*}*/
    .selectNum2{
        background-color: red;
        color: #fff;
    }
    .selectNaN{
        background-color: yellow;
        color: #fff;
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
        考勤数据统计</div>

    <form class="layui-form" action="">
        <div style="position: relative;line-height: 60px;">
            <div class="layui-inline">
                <label class="layui-form-label" >开始时间</label>
                <div class="layui-input-inline">
                    <input type="text" name="effectiveDate"  id="effectiveDate" lay-verify="required|phone" autocomplete="off" class="layui-input">
                </div>
            </div>
            <div class="layui-inline">
                <label class="layui-form-label" >结束时间</label>
                <div class="layui-input-inline" >
                    <input type="text" name="expireDate"  id="expireDate" lay-verify="required|phone" autocomplete="off" class="layui-input">
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
<%--            <div style="display: flex">--%>
<%--&lt;%&ndash;                <div style="width: 120px;margin-left: 20px;margin-top: 10px">&ndash;%&gt;--%>
<%--&lt;%&ndash;                    <label class="layui-form-label">异常数据</label>&ndash;%&gt;--%>
<%--&lt;%&ndash;                    <input id="yichang" type="checkbox" class="yichang" name="yichang"  style="height: 40px;&ndash;%&gt;--%>
<%--&lt;%&ndash;    width: 20px;; display: inline-block;" fuxuan="no">&ndash;%&gt;--%>
<%--&lt;%&ndash;                </div>&ndash;%&gt;--%>
<%--&lt;%&ndash;                <div style="width: 120px;margin-left: 20px;margin-top: 10px">&ndash;%&gt;--%>
<%--&lt;%&ndash;                    <label class="layui-form-label" style="width: 70px">多岗位数据</label>&ndash;%&gt;--%>
<%--&lt;%&ndash;                    <input id="duogang" type="checkbox" class="duogang" name="duogang"  style="height: 40px;&ndash;%&gt;--%>
<%--&lt;%&ndash;    width: 20px;; display: inline-block;" fuxuan="no">&ndash;%&gt;--%>
<%--&lt;%&ndash;                </div>&ndash;%&gt;--%>
<%--            </div>--%>
                <button type="button" class="layui-btn layui-btn-sm" id="search1" lay-event="search1" style="height: 30px;line-height: 30px;margin-left: 10px">查询</button>
                <button type="button" class="layui-btn layui-btn-sm" id="export" lay-event="" style="height: 30px;line-height: 30px;">导出</button>
        </div>
    </form>
    <table class="layui-hide" id="test1" lay-filter="test1"></table>
</div>
<%--<script id="barDemos" type="text/html">--%>
<%--    <div class="long">--%>
<%--        <a id="add" lay-event="details" data-index="i" style="color: blue;cursor:pointer; text-decoration:underline">批量设置</a>--%>
<%--        <a id="add" lay-event="detail2" data-index="i" style="color: blue;cursor:pointer; text-decoration:underline">增加岗薪数据</a>--%>
<%--        &lt;%&ndash;        <a id="edit" lay-event="detail1" data-index="i" style="color: blue;cursor:pointer; text-decoration:underline">薪岗排布</a>&ndash;%&gt;--%>
<%--        <a id="del" lay-event="detail4" data-index="i" style="color: blue;cursor:pointer; text-decoration:underline">删除</a>--%>
<%--    </div>--%>

<%--</script>--%>

</body>
<script>
    $("#yichang").on("click", function () {
        $('#yichang').find('input[type=checkbox]').prop('checked',true)
    })
    $("#duogang").on("click", function () {
        $('#duogang').find('input[type=checkbox]').prop('checked',true)
    })
    var pickUnusual=''
    var ct = ''
    var url = ''
    var str1=''
    $("#Adddept").on("click", function () {
        dept_id = 'deptName';
        $.popWindow("../common/selectDept?0");
    });

    $('#Deletedept').on("click",function () {
        $('#deptName').val('');
        $('#deptName').attr('deptid', '');
    })
    layui.use(['form', 'table', 'element', 'layedit', 'eleTree', 'upload'], function () {
        var table = layui.table;
        var form = layui.form;
        var element = layui.element;
        var layedit = layui.layedit;
        var upload = layui.upload;
        var laydate = layui.laydate
        var eleTree = layui.eleTree;
        var attendTypeId;
        laydate.render({
            elem: '#effectiveDate'
            ,trigger: 'click'
            , type: 'month'
        });
        laydate.render({
            elem: '#expireDate'
            ,trigger: 'click'
            , type: 'month'
        });
        form.render();
        var y  = new Date().getFullYear();
        var month = new Date().getMonth()+1
        $('#effectiveDate').val(y+'-'+'0'+1)
        if(month <= 9){
            $('#expireDate').val(y+'-'+'0'+month)
        }else{
            $('#expireDate').val(y+'-'+month)
        }

        var startTime = $('#effectiveDate').val()
        var endTime = $('#expireDate').val()
        form.render('select');
        // laydate.render({
        //     elem: '#dataYear'
        //     , type: 'year'
        //     , trigger: 'click'
        // });
        //
        // laydate.render({
        //     elem: '#dataMonth'
        //     , type: 'month'
        //     , format: "M"
        //     , trigger: 'click'
        // });
        form.render()
        $('#search1').on("click",function () {
            var startTime = $("#effectiveDate").val()
            var endTime = $("#expireDate").val()
            var deptId = $('#deptName').attr('deptid');
            if (deptId==undefined){
                deptId=''
            }
            var userName = $("#userName").val()
            var ins1 = table.render({
                elem: '#test1'
                ,id: 'exportTable'
                , url:'/AttendanceType/selectAllYear?startTime='+startTime+'&endTime='+endTime+'&deptId='+deptId+'&userName='+userName+''
                , title: '考勤数据表'
                ,cols:[
                    cols, cols2
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
                ,done: function(res){
                    // exportData=res.data;
                    var trList = $('#test1').next().find('tr')
                    for(var i = 1; i < trList.length; i++){
                        for(var j = 2; j < trList.eq(i+1).find('td[lay-event]').length; j++){
                            var month = $("#theMonth").val();
                            var day = trList.eq(i+1).find('td[lay-event]').eq(j).attr('lay-event');
                            if(parseInt(day) < 10){
                                day = '0' + day;
                            }
                            var date = $('#theYear').val() + '-' + month + '-' + day;
                            if(res.data[i - 1]['attendType'+ (j - 1)] == ''&&checkDate(date)){
                                trList.eq(i+1).find('td[lay-event]').eq(j).attr('class', 'selectNaN')
                                trList.eq(i+1).find('td[lay-event]').eq(j).attr('flag', true)
                            }else{
                                if(res.data[i - 1]['attendTypeFlag'+ (j - 1)] == 1){
                                    trList.eq(i+1).find('td[lay-event]').eq(j).attr('class', 'selectNum2')
                                    trList.eq(i+1).find('td[lay-event]').eq(j).attr('flag', true)
                                }

                            }
                        }
                    }

                }
            })

        });
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
                    field: 'collection', title: '合计', minWidth: 80, templet: function(res){
                        var count = res.collection;
                        return count + '元';
                    }
                })
                var colsAfter = [
                    {field: 'remarks', title: '备注', rowspan:2}
                    , {field: 'confirmStatus', title: '状态', minWidth:90, rowspan:2, templet:function(d){
                            if(d.confirmStatus==1){
                                return '已确认'
                            }else if(d.confirmStatus==0){
                                return '待确认'
                            }
                        }}
                    // , {field: '', title: '操作',width:'20%', toolbar: '#barDemos', fixed: 'right', rowspan:2}
                ]
                cols = cols.concat(colsAfter)

            }
        })
        var ins1 = table.render({
            elem: '#test1'
            ,id: 'exportTable'
            , url: '/AttendanceType/selectAllYear?useFlag='+true+'&startTime='+startTime+'&endTime='+endTime
            , toolbar: '#toolbarDemo' //开启头部工具栏，并为其绑定左侧模板
            , defaultToolbar: ['filter', 'exports', 'print', { //自定义头部工具栏右侧图标。如无需自定义，去除该参数即可
                title: '提示'
                , layEvent: 'LAYTABLE_TIPS'
                , icon: 'layui-icon-tips'
            }]
            , title: '考勤数据表'
            , cols: [
                cols, cols2
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
                // exportData=res.data;
                var trList = $('#test1').next().find('tr')
                for(var i = 1;i < trList.length;i++){
                    for(var j = 2;j < trList.eq(i+1).find('td[lay-event]').length;j++){
                        var month = $("#theMonth").val();
                        var day = trList.eq(i+1).find('td[lay-event]').eq(j).attr('lay-event');
                        if(parseInt(day) < 10){
                            day = '0' + day;
                        }
                        var date = $('#theYear').val() + '-' + month + '-' + day;
                        if(res.data[i - 1]['attendType'+ (j - 1)] == ''&&checkDate(date)){
                            trList.eq(i+1).find('td[lay-event]').eq(j).attr('class', 'selectNaN')
                            trList.eq(i+1).find('td[lay-event]').eq(j).attr('flag', true)
                        }else{
                            if(res.data[i - 1]['attendTypeFlag'+ (j - 1)] == 1){
                                trList.eq(i+1).find('td[lay-event]').eq(j).attr('class', 'selectNum2')
                                trList.eq(i+1).find('td[lay-event]').eq(j).attr('flag', true)
                            }
                            // else{
                            //     if(res.data[i-1].jobObject != undefined){
                            //         if(res.data[i-1].jobObject['salaryPost' + (j-1)] != 0){
                            //             trList.eq(i+1).find('td[lay-event]').eq(j).attr('class', 'select')
                            //             trList.eq(i+1).find('td[lay-event]').eq(j).attr('flag', true)
                            //         }
                            //     }
                            // }

                        }
                    }
                }

                // var firstindexrow;
                // var firstindexcol;
                // var curindexrow;
                // var curindexcol;
                // var aaa = 0;
                // var isMouseDown = false,
                //     isHighlighted
                //
                //
                // /*   *********************************   选中事件开始   *****************************************************    */
                // //添加点击事件     拖拽选择表格
                // $(".select").mousedown(function (res) {
                //     isMouseDown = true;
                //     var currentTD = $(this);
                //         $(this).removeClass('select1');
                //
                //     firstindexrow = currentTD.parent().index();
                //     firstindexcol=currentTD.index();
                //     curindexrow = currentTD.parent().index();
                //     curindexcol = currentTD.index();
                //     $("tr:eq("+curindexrow+") td:eq("+curindexcol+")").addClass("select1");
                //     // return false;
                // }).mouseenter(function (e) {
                //     if (isMouseDown) {
                //         aaa = 1
                //         var currentTD = $(this);
                //             $(this).removeClass('select1');
                //         curindexrow = currentTD.parent().index();
                //         curindexcol = currentTD.index();
                //         var minrow = curindexrow>firstindexrow?firstindexrow:curindexrow;
                //         var mincol = curindexcol>firstindexcol?firstindexcol:curindexcol;
                //         var maxrow = curindexrow>firstindexrow?curindexrow:firstindexrow;
                //         var maxcol = curindexcol>firstindexcol?curindexcol:firstindexcol;
                //         for(var i=minrow;i<=maxrow;i++){
                //             for(var j=mincol;j<=maxcol;j++){
                //                 $("tr:eq("+i+") td:eq("+j+")").addClass("select1");
                //             }
                //         }
                //     }
                // });
                // $(document).mouseup(function () {
                //     isMouseDown = false;
                // });
                //
                //
                // //
                // $(".select").on("click", function (event) {
                //     //兼容任何浏览器
                //     var e = arguments.callee.caller.arguments[0] || event;
                //     if (e && e.stopPropagation) {
                //         // 兼容 Mozilla and Opera 浏览器
                //         e.stopPropagation();
                //     } else if (window.event) {
                //         // 兼容IE浏览器
                //         window.event.cancelBubble = true;
                //     }
                // });
                //
                // /*  ***************************************  选中结束  ****************************************  */
                //
                //
                // /*  *******************************************     **************************************  */
                // // 这个是干什么的？
                // $(document).on("click",function () {
                //     if(aaa == 1){
                //         aaa = 0
                //         return false
                //     }else{
                //         for(var i=1;i<=31;i++){
                //             $("td[data-field='attendType"+i+"']").attr('class','select select1')
                //         }
                //     }
                //
                // })
            }
            , page: true
        })
        $("#export").on("click",function(){
            var theYear = $("#effectiveDate").val()
            var theMonth = $("#expireDate").val()
            var deptId = $('#deptName').attr('deptid');
            if (deptId==undefined){
                deptId=''
            }
            var userName = $("#userName").val()
            $.ajax({
                url:'/AttendanceType/selectAllYear?startTime='+startTime+'&endTime='+endTime+'&deptId='+deptId+'&userName='+userName+'&useFlag=false',
                type: 'post',
                async: false,
                dataType: 'json',
                success: function (res) {
                    //使用table.exportFile()导出数据
                    table.exportFile('exportTable', res.obj, 'xls');
                    layer.msg('正在导出中，请耐心等待')
                }
            });
        })


        $(document).on("click","#submit",function(){
            layer.close('page')
        })
        // table.on('tool(test1)', function (obj) {
        //     data = obj.data;
        //     var data = obj.data;
        //     var dataObj = obj.data;
        //     var layEvent = obj.event;
        //     if (obj.event === 'detail1') {
        //         layer.confirm('确定删除该条数据吗？', {
        //             btn: ['确定','取消'], //按钮
        //             title:"删除"
        //         }, function(){
        //             $.ajax({
        //                 type: 'post',
        //                 url: '/Antiepidemic/deleteById',
        //                 dataType: 'json',
        //                 data: {
        //                     antiId:data.antiId
        //                 },
        //                 success: function (json) {
        //                     if(json.flag){
        //                         layer.closeAll();
        //                         $.layerMsg({content: '删除成功！', icon: 1}, function () {
        //                             location.reload();
        //                         })
        //                     }
        //                 }
        //             })
        //         })
        //     }else if(obj.event === 'detail2'){
        //         layer.confirm('确定同意审批该条数据吗？', {
        //             btn: ['确定','取消'], //按钮
        //             title:"通过审批"
        //         }, function() {
        //             $.ajax({
        //                 type: 'post',
        //                 url: '/Antiepidemic/update',
        //                 dataType: 'json',
        //                 data: {
        //                     state: '1',
        //                     antiId: data.antiId
        //                 },
        //                 success: function (json) {
        //                     data.approveStatus = '同意'
        //                     $.layerMsg({content: '通过成功！', icon: 1}, function () {
        //                         layer.closeAll();
        //                         location.reload();
        //                     })
        //                 }
        //             })
        //         })
        //
        //     }else if(obj.event === 'detail3'){
        //         layer.confirm('确定不通过该条数据吗？', {
        //             btn: ['确定','取消'], //按钮
        //             title:"不通过"
        //         }, function() {
        //             $.ajax({
        //                 type: 'post',
        //                 url: '/Antiepidemic/update',
        //                 dataType: 'json',
        //                 data: {
        //                     state: '0',
        //                     antiId: data.antiId
        //                 },
        //                 success: function (json) {
        //                     data.approveStatus = '不同意'
        //                     $.layerMsg({content: '确定成功！', icon: 1}, function () {
        //                         layer.closeAll();
        //                         location.reload();
        //                     })
        //                 }
        //             })
        //         })
        //
        //     }
        //
        // })
        // $(document).on('click','#add',function(){
        //     $.ajax({
        //         type: 'post',
        //         url: '/AttendanceType/addAttendanceType',
        //         dataType: 'json',
        //         data: {
        //             attendTypeId: attendTypeId,
        //         },
        //         success:function(res){
        //             table.reload('test1')
        //         }
        //     })
        // })
        // $(document).on('click','#del',function(){
        //     $.ajax({
        //         type: 'post',
        //         url: '/AttendanceType/deleteAttendanceType',
        //         dataType: 'json',
        //         data: {
        //             attendTypeId: attendTypeId,
        //         },
        //         success:function(res){
        //             table.reload('test1')
        //         }
        //     })
        // })
        // table.on('tool(test1)',function(obj){
        //     var jobManageName = obj.data.jobManageName
        //     var jobRatio = obj.data.jobRatio
        //     var aaa = $(this)
        //     var flag = aaa.attr('flag')
        //     var attendTypeId = obj.data.attendTypeId
        //     var jobManageId = obj.data.jobManageId
        //     if(obj.event != "detail2" || obj.event != "detail4" || obj.event != "detail1"){
        //         var jobRatio = obj.data.jobRatio
        //         attendTypeId = obj.data.attendTypeId
        //         var attendType = obj.event
        //         var value = obj.value
        //         if(isNaN(attendType) == 0){
        //             $.ajax({
        //                 type: 'post',
        //                 url: '/AttendanceType/selectOneDayDate',
        //                 dataType: 'json',
        //                 data: {
        //                     attendTypeId:attendTypeId,
        //                     day:attendType,
        //                 },
        //                 success: function (res) {
        //                     var oneDayPerDiem = res.object.oneDayPerDiem
        //                     var oneDaySalaryRatio = res.object.oneDaySalaryRatio
        //                     var oneAttendanceType = res.object.oneAttendanceType
        //                     var jobRatio = res.object.jobRatio
        //                     var oneDayPerDiem = res.object.oneDayPerDiem
        //                     layer.open({
        //                         type: 1,
        //                         area: ['531px', '372px'], //宽高
        //                         title: '修改',
        //                         maxmin: true,
        //                         btn: ['确定','取消'], //可以无限个按钮
        //                         content: '<div style="margin: 43px auto;">' +
        //                             '<form class="layui-form" action="">\n' +
        //                             ' <div class="layui-form-item" >\n' +
        //                             '     <div class="layui-inline" >\n' +
        //                             '         <label class="layui-form-label" >日薪</label>\n' +
        //                             '         <div class="layui-input-inline">\n' +
        //                             '             <input disabled="disabled" type="text" name="oneDayPerDiem"  lay-verify="required|phone" autocomplete="off" class="layui-input noEdit mustEdit" title="机构全称">\n' +
        //                             '         </div>\n' +
        //                             '     </div>\n' +
        //                             ' <div class="layui-form-item" >\n' +
        //                             '     <div class="layui-inline" >\n' +
        //                             '         <label class="layui-form-label" style="margin-top: 15px" >岗薪比例</label>\n' +
        //                             '         <div class="layui-input-inline">\n' +
        //                             '             <input style="margin-top: 15px"  type="text" name="oneDaySalaryRatio"  lay-verify="required|phone" autocomplete="off" class="layui-input noEdit mustEdit" title="机构全称">\n' +
        //                             '         </div>\n' +
        //                             '     </div>\n' +
        //                             ' </div>\n' +
        //                             '<div class="layui-form-item" >\n' +
        //                             '     <div class="layui-inline" >\n' +
        //                             '         <label class="layui-form-label" >考勤类型</label>\n' +
        //                             '         <div class="layui-input-inline">\n' +
        //                             '            <select id="zhu" name="schoolTypes" class="schoolType noEdit" lay-verify="required" lay-search="" title="考勤类型">\n' +
        //                             '                <option value="">无考勤类型</option>\n' +
        //                             '            </select>\n' +
        //                             '         </div>\n' +
        //                             '     </div>\n' +
        //                             ' </div>' +
        //                             ' </div>\n' +
        //                             '</form>' +
        //                             '</div>',
        //                         success: function () {
        //
        //                             form.render()
        //                             $("input[name='oneDayPerDiem']").val(oneDayPerDiem)
        //                             $("input[name='oneDaySalaryRatio']").val(oneDaySalaryRatio)
        //                             $("input[name='oneAttendanceType1']").val(oneAttendanceType)
        //                             $.ajax({
        //                                 type: 'post',
        //                                 url: '/AttendanceRecord/selectAllAttendanceRecord',
        //                                 dataType: 'json',
        //                                 success: function (json) {
        //                                     var str = '<option selected=selected>无考勤类型</option>'
        //                                     for(var i=0;i<json.obj.length;i++){
        //                                         str+='<option value="'+json.obj[i].typeCode+'">'+json.obj[i].attendanceRecordClassifyName+'---'+json.obj[i].attendanceRecordType+'---'+json.obj[i].typeCode+'</option>'
        //                                     }
        //                                     $("select[name='schoolTypes']").html(str)
        //                                     form.render();
        //                                     if(oneDayPerDiem == undefined){
        //                                         $("input[name='oneDayPerDiem']").val('0')
        //                                     }else{
        //                                         $("input[name='oneDayPerDiem']").val(oneDayPerDiem)
        //                                     }
        //
        //                                     $("input[name='oneDaySalaryRatio']").val(oneDaySalaryRatio)
        //                                     if(oneAttendanceType !=''){
        //                                         $("#zhu option[value="+oneAttendanceType+"]").prop("selected",true)
        //                                     }else{
        //                                         $("select[name='schoolTypes']").html(str)
        //                                     }
        //                                     form.render();
        //
        //
        //                                 }
        //                             })
        //                             // if(flag == undefined){
        //                             //     $("input[name='oneDaySalaryRatio']").attr('disabled','disabled')
        //                             //     $("select[name='schoolTypes']").attr('disabled','disabled')
        //                             // }
        //                         },
        //                         yes: function (index, layero) {
        //                             var oneDaySalaryRatio = $("input[name='oneDaySalaryRatio']").val()
        //                             var oneAttendanceType1 = $("select[name='schoolTypes']").val()
        //                             if(oneAttendanceType1 == '无考勤类型'){
        //                                 oneAttendanceType1 = ''
        //                             }
        //                             $.ajax({
        //                                 type: 'post',
        //                                 url: '/AttendanceType/updateOneDayDate',
        //                                 dataType: 'json',
        //                                 data: {
        //                                     attendTypeId:attendTypeId,
        //                                     day:attendType,
        //                                     oneDaySalaryRatio:oneDaySalaryRatio,
        //                                     oneAttendanceType:oneAttendanceType1
        //                                 },
        //                                 success: function (json) {
        //                                     layer.close(index);
        //                                     layer.msg('修改成功！',{icon:1});
        //                                     table.reload('test1')
        //                                 }
        //                             })
        //                         }
        //                     });
        //                 }
        //             })
        //         }
        //     }
        //     if(obj.event == "detail2"){
        //         $.ajax({
        //             type: 'post',
        //             url: '/AttendanceType/addAttendanceType',
        //             dataType: 'json',
        //             data: {
        //                 attendTypeId: attendTypeId,
        //             },
        //             success:function(res){
        //                 table.reload('test1')
        //             }
        //         })
        //     }else if(obj.event == "detail4"){
        //         $.ajax({
        //             type: 'post',
        //             url: '/AttendanceType/deleteAttendanceType',
        //             dataType: 'json',
        //             data: {
        //                 attendTypeId: attendTypeId,
        //             },
        //             success:function(res){
        //                 table.reload('test1')
        //             }
        //         })
        //     }else if(obj.event == "detail1"){
        //         var data = obj.data.jobObject
        //         if(data != undefined){
        //             delete data.attendJobId
        //             delete data.attendTypeId
        //         }
        //         if(jobManageName != '' && jobManageName != undefined){
        //             if(jobRatio != '' && jobRatio != undefined){
        //                 layer.open({
        //                     type: 2,
        //                     area: ['80%', '80%'], //宽高
        //                     title: '修改岗薪排布',
        //                     maxmin: true,
        //                     btn: ['确定'], //可以无限个按钮
        //                     content: '/wages/attendance',
        //                     success: function (layero,index) {
        //                         var iframe = window['layui-layer-iframe'+index]
        //                         iframe.childs(obj)
        //                         var flag=false
        //                     },
        //                     yes: function (index, layero) {
        //                         layer.closeAll();
        //                         table.reload('test1');
        //                     }
        //                 });
        //             }else{
        //                 layer.msg('请先选择薪岗比例！',{icon:2});
        //             }
        //
        //         }else{
        //             layer.msg('请先选择薪岗！',{icon:2});
        //         }
        //
        //     }else if(obj.event == "details"){
        //         layer.open({
        //             type: 1,
        //             area: ['531px', '372px'], //宽高
        //             title: '修改',
        //             offset:'150',
        //             maxmin: true,
        //             btn: ['确定','取消'], //可以无限个按钮
        //             content: '<div style="margin: 43px auto;">' +
        //                 '<form class="layui-form" action="">\n' +
        //                 ' <div class="layui-form-item" >\n' +
        //                 '     <div class="layui-inline" >\n' +
        //                 '         <label class="layui-form-label" >日期范围</label>\n' +
        //                 '         <div class="layui-input-inline" style="width:210px;display: inline-block">\n' +
        //                 '             <input placeholder="1~31" style="width:90px;display: inline-block" type="text" name="start"  lay-verify="required|phone" autocomplete="off" class="layui-input noEdit mustEdit" title="机构全称">\n' +
        //                 '               <span>~</span>\n' +
        //                 '             <input placeholder="1~31" style="width:90px;display: inline-block" type="text" name="end"  lay-verify="required|phone" autocomplete="off" class="layui-input noEdit mustEdit" title="机构全称">\n' +
        //                 '         </div>\n' +
        //                 '     </div>\n' +
        //                 ' </div>\n' +
        //                 '<div class="layui-form-item" >\n' +
        //                 '     <div class="layui-inline" >\n' +
        //                 '         <label class="layui-form-label" >考勤类型</label>\n' +
        //                 '         <div class="layui-input-inline">\n' +
        //                 '            <select id="zhu" name="attendType" class="schoolType noEdit" lay-verify="required" lay-search="" title="考勤类型">\n' +
        //                 '                <option value="">无考勤类型</option>\n' +
        //                 '            </select>\n' +
        //                 '         </div>\n' +
        //                 '     </div>\n' +
        //                 ' </div>' +
        //                 '</form>' +
        //                 '</div>',
        //             success: function () {
        //                 $.ajax({
        //                     type: 'post',
        //                     url: '/AttendanceRecord/selectAllAttendanceRecord',
        //                     dataType: 'json',
        //                     success: function (json) {
        //                         var str = '<option selected=selected>无考勤类型</option>'
        //                         for(var i=0;i<json.obj.length;i++){
        //                             str+='<option value="'+json.obj[i].typeCode+'">'+json.obj[i].attendanceRecordClassifyName+'---'+json.obj[i].attendanceRecordType+'---'+json.obj[i].typeCode+'</option>'
        //                         }
        //                         $("select[name='attendType']").html(str)
        //                         form.render();
        //                         //if(oneDayPerDiem == undefined){
        //                         //    $("input[name='oneDayPerDiem']").val('0')
        //                         //}else{
        //                         //    $("input[name='oneDayPerDiem']").val(oneDayPerDiem)
        //                         //}
        //
        //                         //$("input[name='oneDaySalaryRatio']").val(oneDaySalaryRatio)
        //                         //if(oneAttendanceType !=''){
        //                         //    $("#zhu option[value="+oneAttendanceType+"]").prop("selected",true)
        //                         //}else{
        //                         //    $("select[name='schoolTypes']").html(str)
        //                         //}
        //                         //form.render();
        //
        //
        //                     }
        //                 })
        //                 form.render()
        //             },
        //             yes: function (index, layero) {
        //                 var start = $("input[name='start']").val()
        //                 var end = $("input[name='end']").val()
        //                 var attendType = $("select[name='attendType']").val()
        //                 if(attendType == '无考勤类型'){
        //                     attendType = '0'
        //                 }
        //                 var attendTypeId = obj.data.attendTypeId
        //                 if(start == '' || start == undefined){
        //                     layer.msg('请输入日期范围！',{icon:2});
        //                     return false
        //                 }
        //                 if(end == '' || end == undefined){
        //                     layer.msg('请输入日期范围！',{icon:2});
        //                     return false
        //                 }
        //                 if(/^[1-9]$|^[12]\d$|^3[01]$/.test(start) && /^[1-9]$|^[12]\d$|^3[01]$/.test(end)){
        //                     $.ajax({
        //                         type: 'post',
        //                         url: '/AttendanceType/updateBatchAttendanceType',
        //                         dataType: 'json',
        //                         data:{
        //                             start:start,
        //                             end:end,
        //                             attendType:attendType,
        //                             attendTypeId:attendTypeId
        //                         },
        //                         success: function (json) {
        //                             if(json.flag = 'true'){
        //                                 layer.closeAll()
        //                                 layer.msg('设置成功！',{icon:1});
        //                                 table.reload('test1');
        //                             }else{
        //                                 layer.msg('修设失败！',{icon:2});
        //                             }
        //                         }
        //                     })
        //                 }else{
        //                     layer.msg('请输入1~31！',{icon:2});
        //                     return false
        //                 }
        //
        //             }
        //         });
        //     }
        //
        // })
    });


</script>
</html>
