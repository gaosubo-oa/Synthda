
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@taglib prefix="mvc" uri="http://www.springframework.org/tags/form" %>
<%@taglib prefix="fmt" uri="http://www.springframework.org/tags" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
%>

<html>
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <title>薪资档案设置</title>
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

    /*#box th {*/
    /*    text-align: center;*/
    /*}*/

    /*#box tr {*/
    /*    height: 40px;*/
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
        width: 100px;
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
    #show{
        font-size: 20px;
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
        薪资档案设置</div>
    <form class="layui-form" action="">
        <div style="position: relative;line-height: 60px;">
            <div class="layui-inline" >
                <label class="layui-form-label">部门</label>
                <div class="layui-input-inline">
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
            <button type="button" class="layui-btn layui-btn-sm" id="search1" lay-event="search1" style="height: 30px;line-height: 30px;margin-left: 20px">查询</button>
            <button type="button" class="layui-btn layui-btn-sm" id="save" lay-event="save" style="height: 30px;line-height: 30px;margin-left: 20px">保存</button>
            <button type="button" class="layui-btn layui-btn-sm" id="import" lay-event="import" style="height: 30px;line-height: 30px;margin-left: 20px">导入</button>
            <button type="button" class="layui-btn layui-btn-sm" id="export" lay-event="export" style="height: 30px;line-height: 30px;margin-left: 20px">导出</button>
        </div>
    </form>
    <div style="padding: 0px 8px;margin-top: 20px;" class="tableOne">
    <table class="layui-hide" id="test1" lay-filter="test1"></table>
    </div>
</div>
</body>
<script>
    var str1='';
    var dept_id;
    var changeInfo,mainMember;
    var orgLegal;
    var tableDemocratic,tableDemocratic1,tableDemocratic2,tableDemocratic3;
    var expiredType = 1;
    $("#Adddept").on("click", function () {
        dept_id = 'deptName';
        $.popWindow("../common/selectDept?0");
    });

    $('#Deletedept').on("click",function () {
        $('#deptName').val('');
        $('#deptName').attr('deptid','');
    })

    $('#export').on("click",function () {
        var deptName = $('#deptName').attr('deptid');
        var userName = $("#userName").val();
        window.location.href = '/WagesEmployeeSalary/export?deptName='+deptName+'&userName='+userName
    })
    layui.use(['form', 'table', 'element', 'layedit','eleTree','upload'], function () {
        var table = layui.table
        var form = layui.form
        var element = layui.element
        var upload = layui.upload
        var layedit = layui.layedit
        var eleTree = layui.eleTree;
        form.render()
        //右侧的报表导入字段
        $('#import').on("click",function () {
            var repTableId = $('.select').attr('repTableId');
            Import(repTableId);
        })
        //导入
        function Import(data) {
            layer.open({

                type: 1,
                area: ['531px', '372px'], //宽高
                title: '导入',
                moveType: 1,
                maxmin: true,
                btn: ['确定'], //可以无限个按钮
                content: '<div style="margin: 43px auto;">' +
                    '<form class="layui-form" action="">\n' +
                    '  <div class="layui-form-item">\n' +
                    '    <label class="layui-form-label" style="width: 30%;">下载导入模板：</label>\n' +
                    '    <div class="layui-input-block">\n' +
                    '      <a class="layui-form-mid" id="load" style="text-decoration: underline; color: blue;cursor:pointer">下载模板</a>\n' +
                    '    </div>\n' +
                    '  </div>\n' +
                    '  <div class="layui-form-item">\n' +
                    '    <label class="layui-form-label" style="width: 30%;">选择导入文件：</label>\n' +
                    '    <div class="layui-input-inline" style="width: 87px;">\n' +
                    '      <button type="button" class="layui-btn layui-btn-sm" id="tests">\n' +
                    '       <i class="layui-icon">&#xe67c;</i>上传文件\n' +
                    '       </button>' +
                    '    </div>\n' +
                    '    <div class="layui-form-mid layui-word-aux" id="textfilter">未选择文件</div>\n' +
                    '  </div>' +
                    '</form>' +
                    '</div>',
                success: function () {
                    $('#load').on("click",function () {
                        window.location.href = "/ui/file/dataReport/员工薪资档案表.xlsx"
                    })
                    //执行实例
                    var uploadInst = upload.render({
                        elem: '#tests' //绑定元素
                        , url: '/WagesEmployeeSalary/imports'
                        , accept: 'file'
                        , auto: false
                        , bindAction: '.layui-layer-btn0'
                        , choose: function (obj) {
                            var files = obj.pushFile();
                            obj.preview(function (index, file, result) {
                                $("#textfilter").text(file.name);
                            });
                        }
                        , done: function (res) {
                            var str = ''
                            $.each(res.obj, function (key, value) {
                                str += key + '->' + value + '\n'
                            });
                                layer.msg(res.msg);
                                table.reload('test1', {
                                    url: '/WagesEmployeeSalary/selectAll',
                                    where: {
                                        tableId: data
                                    }
                                })
                            layer.open({
                                type: 1 //此处以iframe举例
                                , title: '导入情况详情'
                                , area: ['50%', '50%'],
                                offset:'100',
                                btn: ['确定'],
                                content:'<div id="show" name="show"></div>'
                                ,
                                success: function () {
                                },yes:function(){
                                    str1=''
                                    layer.closeAll();
                                }
                            })
                            var last2=res.object
                            var show3=JSON.stringify(last2);
                            str1 +='<div>'+res.msg+'</div><br/><div>'+show3+'</div><br/>'
                            for (var i = 0; i < res.obj.length; i++) {
                                var show2=res.obj[i]
                                str1 += '<div>'+show2+'</div><br/>'
                            }
                            $('[name="show"]').html(str1);
                        }
                        , error: function () {
                            //请求异常回调
                            layer.msg("请上传正确的附件信息");
                        }
                    });
                },
                yes: function (index, layero) {
                    layer.close(index);
                }
            });
        }
        $('#save').on("click",function () {

            var tableDemocratic = layui.table.cache["test1"];
            var $tr = $('.tableOne').find('.layui-table-main tr');
            if(orgLegal != null || orgLegal != undefined){
                $tr.each(function (index) {
                    tableDemocratic[index].salaryId = orgLegal
                });
            }
            $.ajax({
                url: '/WagesEmployeeSalary/update',
                dataType:'json',
                type:'post',
                contentType: 'application/json;charset=UTF-8',
                data: JSON.stringify(tableDemocratic),
                success: function (data) {
location.reload();
                }
            })

        })
        $('#search1').on("click",function () {
            var deptId =$('#deptName').attr('deptid');
            var deptName =$("#deptName").val();
            var userName = $("#userName").val();
            table.render({
                elem: '#test1'
                ,cellMinWidth:'100'
                , url:'/WagesEmployeeSalary/selectAll?deptName='+deptName+'&deptId='+deptId+'&userName='+userName+'&pageSize='+'10'+'&useflag='+true
                ,cols:[[
                    {field: 'deptName',width:'100', title: '部门',  }
                    , {field: 'userName',title: '姓名',}
                    , {field: 'jobNumber',width:'130',edit: true,title: '工号', }
                    , {field: 'idNumber',width:'190',title: '身份证号',}
                    , {field: 'mobilNo',width:'130',edit: true, title: '手机号', }
                    , {field: 'manageIdName',width:'130',edit: true, title: '薪岗1',}
                    , {field: 'jobRatio',edit: true ,title: '薪岗比例', }
                    , {field: 'manageId2Name',width:'130',edit: true, title: '薪岗2', }
                    , {field: 'jobRatio2',edit: true, title: '薪岗2比例', }
                    , {field: 'manageId3Name',width:'130',edit: true,title: '薪岗3', }
                    , {field: 'jobRatio3',edit: true,title: '薪岗3比例', }
                    , {field: 'assessmentProportion',edit: true, title: '考核比例', }
                    , {field: 'asserssName',edit: true, title: '考核形式', }
                    , {field: 'emplName',edit: true, title: '用工形式', }
                    , {field: 'employmentCompany',width:'150',edit: true, title: '所属劳务公司',}
                    , {field: 'employmentCompanyBase',width:'180', edit: true,title: '劳务公司代发工资基数', }
                    , {field: 'assessmentScore',edit: true, title: '考核分', }
                    , {field: 'assessmentKeepSalary',width:'130',edit: true, title: '考核留存工资', }
                    , {field: 'publicTimePayment',width:'190',edit: true, title: '扣公休期间个人缴金部分', }
                    , {field: 'performancePay1',edit: true, title: '绩效工资1', }
                    , {field: 'performancePay2',edit: true, title: '绩效工资2', }
                    , {field: 'performancePay3',edit: true, title: '绩效工资3', }
                    , {field: 'remarks',edit: true, title: '备注', }
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
            , url: '/WagesEmployeeSalary/selectAll?FpageSize='+'10'+'&useflag='+true
            ,cellMinWidth:'100'
            , toolbar: '#toolbarDemo' //开启头部工具栏，并为其绑定左侧模板
            , defaultToolbar: ['filter', 'exports', 'print', { //自定义头部工具栏右侧图标。如无需自定义，去除该参数即可
                title: '提示'
                , layEvent: 'LAYTABLE_TIPS'
                , icon: 'layui-icon-tips'
            }]
            , title: '用户数据表'
            , cols: [[
                {field: 'deptName',width:'100', title: '部门',  }
                , {field: 'userName',title: '姓名',}
                , {field: 'jobNumber',width:'130',edit: true,title: '工号', }
                , {field: 'idNumber',width:'190',title: '身份证号',}
                , {field: 'mobilNo',width:'130',edit: true, title: '手机号', }
                , {field: 'manageIdName',width:'130',edit: true, title: '薪岗1',}
                , {field: 'jobRatio',edit: true ,title: '薪岗比例', }
                , {field: 'manageId2Name',width:'130',edit: true, title: '薪岗2', }
                , {field: 'jobRatio2',edit: true, title: '薪岗2比例', }
                , {field: 'manageId3Name',width:'130',edit: true,title: '薪岗3', }
                , {field: 'jobRatio3',edit: true,title: '薪岗3比例', }
                , {field: 'assessmentProportion',edit: true, title: '考核比例', }
                , {field: 'asserssName',edit: true, title: '考核形式', }
                , {field: 'emplName',edit: true, title: '用工形式', }
                , {field: 'employmentCompany',width:'150',edit: true, title: '所属劳务公司',}
                , {field: 'employmentCompanyBase',width:'180', edit: true,title: '劳务公司代发工资基数', }
                , {field: 'assessmentScore',edit: true, title: '考核分', }
                , {field: 'assessmentKeepSalary',width:'130',edit: true, title: '考核留存工资', }
                , {field: 'publicTimePayment',width:'190',edit: true, title: '扣公休期间个人缴金部分', }
                , {field: 'performancePay1',edit: true, title: '绩效工资1', }
                , {field: 'performancePay2',edit: true, title: '绩效工资2', }
                , {field: 'performancePay3',edit: true, title: '绩效工资3', }
                , {field: 'remarks',edit: true, title: '备注', }
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
                layer.confirm('确定删除该条数据吗？', {
                    btn: ['确定','取消'], //按钮
                    title:"删除"
                }, function(){
                    $.ajax({
                        type: 'post',
                        url: '/Antiepidemic/deleteById',
                        dataType: 'json',
                        data: {
                            antiId:data.antiId
                        },
                        success: function (json) {
                            if(json.flag){
                                layer.closeAll();
                                $.layerMsg({content: '删除成功！', icon: 1}, function () {
                                    location.reload();
                                })
                            }
                        }
                    })
                })
            }else if(obj.event === 'detail2'){
                layer.confirm('确定同意审批该条数据吗？', {
                    btn: ['确定','取消'], //按钮
                    title:"通过审批"
                }, function() {
                    $.ajax({
                        type: 'post',
                        url: '/Antiepidemic/update',
                        dataType: 'json',
                        data: {
                            state: '1',
                            antiId: data.antiId
                        },
                        success: function (json) {
                            data.approveStatus = '同意'
                            $.layerMsg({content: '通过成功！', icon: 1}, function () {
                                layer.closeAll();
                                location.reload();
                            })
                        }
                    })
                })

            }else if(obj.event === 'detail3'){
                layer.confirm('确定不通过该条数据吗？', {
                    btn: ['确定','取消'], //按钮
                    title:"不通过"
                }, function() {
                    $.ajax({
                        type: 'post',
                        url: '/Antiepidemic/update',
                        dataType: 'json',
                        data: {
                            state: '0',
                            antiId: data.antiId
                        },
                        success: function (json) {
                            data.approveStatus = '不同意'
                            $.layerMsg({content: '确定成功！', icon: 1}, function () {
                                layer.closeAll();
                                location.reload();
                            })
                        }
                    })
                })

            }

        })


    });


</script>
</html>


