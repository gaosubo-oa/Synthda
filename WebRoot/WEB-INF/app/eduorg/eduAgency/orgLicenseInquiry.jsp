<%--
  Created by IntelliJ IDEA.
  User: 吴祖明
  Date: 2021/7/1
  Time: 14:34
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
<title>机构证照查询</title>
<link rel="stylesheet" type="text/css" href="../../lib/pagination/style/pagination.css"/>
<link rel="stylesheet" type="text/css" href="../../css/base.css"/>
<link rel="stylesheet" type="text/css" href="../../css/news/center.css"/>
<link rel="stylesheet" href="/lib/laydate/need/laydate.css">
<link rel="stylesheet" href="/lib/layui/layui/css/layui.css?20210319.1">
<script type="text/javascript" src="../../js/xoajq/xoajq1.js"></script>
<script src="/lib/laydate/laydate.js"></script>
<script type="text/javascript" src="/js/base/tablePage.js"></script>
<script src="../../js/news/page.js"></script>
<script src="../../js/base/base.js" type="text/javascript" charset="utf-8"></script>
<script src="../../lib/pagination/js/jquery.pagination.min.js" type="text/javascript" charset="utf-8"></script>
<script src="../../lib/layer/layer.js?20201106"></script>
<script src="../../lib/laydate/laydate.js"></script>
<script src="../js/sys/citys.js" type="text/javascript" charset="utf-8"></script>
<script src="/lib/layui/layui/layui.js"></script>
<script src="/lib/jQuery-File-Upload-master/jquery-ui.js" type="text/javascript" charset="utf-8"></script>
<script src="/lib/jQuery-File-Upload-master/jquery.iframe-transport.js" type="text/javascript" charset="utf-8"></script>
<script src="/lib/jQuery-File-Upload-master/jquery.fileupload.js" type="text/javascript" charset="utf-8"></script>
<script type="text/javascript" src="/js/email/fileupload.js"></script>
<script src="/js/jquery/jquery.cookie.js"></script>
<script src="/js/jquery/jquery.form.min.js"></script>


<style>
    html {
        background: white;
        color: #666;
    }
    .layui-card {
        margin-bottom: 15px;
        border-radius: 2px;
        background-color: #fff;
        box-shadow: none;
    }
    #divBox .layui-table-cell{
        height: auto;
        overflow:visible;
        text-overflow:inherit;
        white-space:normal;
        word-break: break-word;
    }

    .layui-collapse {
        border-style: none;
    }

    .layui-form-select dl {
        max-height: 152px;
    }

    .layui-form-select {
        width: 100%;
    }

    #baseForm > .layui-row {
        margin: 10px 0;
    }
    .layui-form-radio{
        margin: 0;
    }
    #secretaryTable td{
        pointer-events: none;
        cursor: default;
    }
    .layui-btn-sm {
        height: 25px;
        line-height: 25px;
        padding: 0 10px;
        font-size: 12px;
        /*float: right;*/
    }
    #legalForm .layui-form-label {
        float: left;
        display: block;
        padding: 9px 15px;
        width: 130px;
        font-weight: 400;
        line-height: 20px;
        text-align: right;
    }
    .lic_insert .layui-form-item .layui-input-inline {
        float: left;
        width: 300px;
        margin-right: 10px;
    }
    .lookDetail .layui-form-item .layui-input-inline {
        float: left;
        width: 170px;
        margin-right: 10px;
    }
    .headerPic {
        background-color: #e5e5e5;
        font-size: 16px;
        height: 35px;
        width: 94%;
        margin-left: 3%;
        margin-top: 30px;
        line-height: 35px;
    }
</style>
<link rel="stylesheet" type="text/css" href="/css/commonTheme/${sessionScope.InterfaceModel}/commonTheme.css"/>
</head>
<body>
<div class="container">
    <div class="layui-card">
        <div class="layui-card-body" style="padding-left: 6px;">
            <div class="layui-tab layui-tab-brief" lay-filter="debriefing"  style="width: 100%">
                <ul class="layui-tab-title" id="ulBox">
                    <li class="layui-this">证照查询列表</li>
                    <li>证照查询</li>
                </ul>
                <div class="layui-tab-content" id="divBox" style="display: block;position: relative;width:96%;padding: 2px;margin-left: 2%">
                    <%--证照查询列表--%>
                    <div class="layui-tab-item layui-show" id="lic_insertItem" style="margin-top: 20px;">
                        <div class="layui-form" style="display: inline-block;">
                            <input type="radio" name="expired"  lay-filter="expired"  value="1" title="全部证书" checked>
                            <input type="radio" name="expired"  lay-filter="expired" value="2" title="一个月内过期证书">
                            <input type="radio" name="expired"  lay-filter="expired" value="3" title="已过期证书">
                        </div>
                        <form class="layui-form" action="" style="height: 40px;margin: 10px 0 10px 50px;display: inline-block;">
                            <div class="layui-form-item" style="margin-bottom: 0px">
                                <div class="layui-inline" style="margin-bottom: 0px;">
                                    <label class="layui-form-label" style=" margin-left: -21px;">证照名称</label>
                                    <div class="layui-input-inline">
                                        <input type="text"  lay-verify="required|phone" autocomplete="off" class="layui-input licenceName">
                                    </div>
                                </div>
                                <div class="layui-inline" style="margin-bottom: 0px;">
                                    <label class="layui-form-label" style=" margin-left: -21px;">机构名称</label>
                                    <div class="layui-input-inline">
                                        <input type="text"  lay-verify="required|phone" autocomplete="off" class="layui-input deptName">
                                    </div>
                                </div>
                                <a class="layui-btn" data-type="reload"  id="search" style="height:32px;line-height: 32px;margin-top: -4px;">查询</a>
                            </div>
                        </form>
                        <div>
                            <table id="tableDemocratic" lay-filter="tableDemocratic"></table>
                        </div>
                    </div>
                    <%--证照查询--%>
                    <div class="layui-collapse lic_insert">
                            <div class="layui-tab-item" id="lic_insert" style="margin-top: 20px;">
                                <form class="layui-form" action="" id="basicForm" lay-filter="formTest" style="margin-bottom: 50px;">
                                    <%-- 第二行--%>
                                    <div class="layui-row">
                                        <div class="layui-col-xs6" style="padding: 0 5px;">
                                            <div class="layui-form-item" >
                                                <div class="layui-inline" >
                                                    <label class="layui-form-label">证照名称</label>
                                                    <div class="layui-input-inline">
                                                        <input type="text" name="licenceName"  lay-verify="required|phone" autocomplete="off" class="layui-input">
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="layui-col-xs6" style="padding: 0 5px;">
                                            <div class="layui-form-item" >
                                                <div class="layui-inline" >
                                                    <label class="layui-form-label" >机构名称</label>
                                                    <div class="layui-input-inline">
                                                        <input type="text" name="deptName"  lay-verify="required|phone" autocomplete="off" class="layui-input">
                                                    </div>
                                                </div>
                                            </div>
                                        </div>

                                    </div>
                                    <%-- 第三行--%>
                                    <div class="layui-row">
                                        <div class="layui-col-xs6" style="padding: 0 5px;">
                                            <div class="layui-form-item" >
                                                <div class="layui-inline" >
                                                    <label class="layui-form-label" >证照类别</label>
                                                    <div class="layui-input-inline">
                                                        <select type="text" name="licenseTypeId" lay-verify="required|phone" autocomplete="off" class="" lay-filter="licenseTypeId">
                                                        </select>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="layui-col-xs6" style="padding: 0 5px;">
                                            <div class="layui-form-item" >
                                                <div class="layui-inline" >
                                                    <label class="layui-form-label" >有效日期</label>
                                                    <div class="layui-input-inline">
                                                        <input type="text" name="effectiveDate"  id="effectiveDate" lay-verify="required|phone" autocomplete="off" class="layui-input">
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>

                                    <div class="layui-row">
                                        <div class="layui-col-xs6" style="padding: 0 5px;">
                                            <div class="layui-form-item" >
                                                <div class="layui-inline">
                                                    <label class="layui-form-label" >到期日期</label>
                                                    <div class="layui-input-inline" >
                                                        <input type="text" name="expireDate"  id="expireDate" lay-verify="required|phone" autocomplete="off" class="layui-input">
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="layui-col-xs6" style="padding: 0 5px;">
                                            <div class="layui-form-item" >
                                                <div class="layui-inline">
                                                    <label class="layui-form-label">年检日期</label>
                                                    <div class="layui-input-inline">
                                                        <input type="text" name="yearlyInspectionDate"  id="yearlyInspectionDate" lay-verify="required|phone" autocomplete="off" class="layui-input">
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="layui-row">
                                        <div class="layui-col-xs6" style="padding: 0 5px;">
                                            <div class="layui-form-item" >
                                                <div class="layui-inline">
                                                    <label class="layui-form-label">状态</label>
                                                    <div class="layui-input-inline">
                                                        <select name="licenseStatus" class="licenseStatus" lay-verify="required" lay-search="">
                                                            <option value="">请选择</option>
                                                            <option value="0">未生效</option>
                                                            <option value="1">生效中</option>
                                                            <option value="2">已到期</option>
                                                        </select>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </form>
                                <div style="text-align: center;">
                                    <button type="button" class="layui-btn layui-btn-sm searchMore" style="height: 32px;line-height: 32px;text-align: center">查询</button>
                                </div>
                                <div class="searchItem" style="display: none">
                                    <table id="tableDemocratic1" lay-filter="tableDemocratic1"></table>
                                </div>
                            </div>
                        </div>
                </div>
            </div>
        </div>
    </div>
</div>
<script type="text/html" id="barDemo">
    <a class="layui-btn layui-btn-xs" lay-event="lookDetail">查看详情</a>
</script>
<script>
    var dept_id;
    var changeInfo,mainMember;
    var orgLegal;
    var tableDemocratic,tableDemocratic1,tableDemocratic2,tableDemocratic3;
    var expiredType = 1;

    $(function(){
        layui.use(['form', 'table', 'laypage','element','laydate'], function () {
            var laydate = layui.laydate;
            var form = layui.form;
            var table = layui.table;
            var element = layui.element;
            laydate.render({
                elem: '#effectiveDate'
                , type: 'date'
            });
            laydate.render({
                elem: '#expireDate'
                , type: 'date'
            });
            laydate.render({
                elem: '#yearlyInspectionDate'
                , type: 'date'
            });
            form.render();
            $.ajax({
                type: 'get',
                url: '/licenseType/selectLicenseTypeByCond',
                dataType: 'json',
                success: function (res) {
                    var object = res.data;
                    var strs = '<option value="">请选择</option>';
                    for(var i=0; i<object.length;i++){
                        strs += '<option value="' + object[i].licenseTypeId + '">' + object[i].licenseTypeName + '</option>';
                    }
                    $('select[name="licenseTypeId"]').append(strs)
                    form.render();
                }
            })
            //监听Tab切换
            element.on('tab(debriefing)', function (data) {
                if (data.index==0||data.index=="0"){
                    $('#lic_insertItem').addClass('layui-show');
                    $('#lic_insert').removeClass('layui-show');
                }else if(data.index==1||data.index=="1"){
                    $('#lic_insertItem').removeClass('layui-show');
                    $('#lic_insert').addClass('layui-show');
                    $('.searchItem').css('display','none');
                    $('#basicForm').css('display','block');
                    $('.searchMore').show();
                }

            });
            //监听单选按钮
            form.on('radio(expired)', function(data){
                var licenceName = $('.licenceName').val();
                var deptName = $('.deptName').val();
                console.log(data)
                expiredType = data.value;
                if(expiredType == '1'){
                    table.reload('tableDemocratic', {
                        where: {
                            expired:'',
                            licenceName: licenceName,
                            deptName: deptName,
                        }
                    });
                }else if(expiredType == '2'){
                    table.reload('tableDemocratic', {
                        where: {
                            expired: 'one',
                            licenceName: licenceName,
                            deptName: deptName
                        }
                    });
                }else{
                    table.reload('tableDemocratic', {
                        where: {
                            expired: 'expired',
                            licenceName: licenceName,
                            deptName: deptName
                        }
                    });
                }


            });

            form.render();
            //证照信息表格渲染
            table.render({
                elem: '#tableDemocratic'
                ,url:'/license/selectListLicenseByCond?useFlag=true'
                ,parseData: function(res){ //res 即为原始返回的数据
                    return {
                        "code": 0, //解析接口状态
                        "data": res.obj, //解析数据列表
                        "count": res.totleNum, //解析数据长度
                    };
                }
                ,where: {
                    expired: '',
                }
                ,title: '用户数据表'
                ,cols: [[
                    {field:'licenceName', title:'证照名称',align:'center'}
                    ,{field:'deptName', title:'机构名称',align:'center'}
                    ,{field:'licenseTypeName', title:'证照类别',align:'center'}
                    ,{field:'effectiveDate', title:'有效日期',align:'center'}
                    ,{field:'expireDate', title:'到期日期',align:'center'}
                    ,{field:'issueDate', title:'发证日期',align:'center'}
                    ,{field:'yearlyInspectionDate', title:'年检日期',align:'center'}
                    ,{field:'licenseStatus', title:'状态',align:'center',templet:function(d){
                        if(d.licenseStatus == '1'){
                            return  '生效中'
                        }else{
                            return  '已到期'
                        }
                    }}
                    ,{fixed: 'right', title:'操作', toolbar: '#barDemo',align:'center'}
                ]],
                page:true

            });
            table.on('tool(tableDemocratic)', function(obj){
                var data = obj.data;
                var licenceId = data.licenceId;
                if (obj.event === 'lookDetail') {
                    lookLicence(licenceId)
                }else if(obj.event === 'delete'){
                    layer.confirm('确定要删除该数据吗？', function(index){
                        $.ajax({
                            url:'/license/deleteEduorgLicenseById',
                            data:{
                                licenceId: licenceId,
                            },
                            dataType:'json',
                            type:'get',
                            success:function(res){
                                if(res.flag){
                                    layer.msg('删除成功',{icon:1});
                                    table.reload("tableDemocratic")
                                }
                            }
                        })
                        layer.close(index);

                    });
                }
            });
            $('.searchMore').on('click',function(){
                $('.searchItem').css('display','block');
                $('#basicForm').css('display','none');
                $('.searchMore').css('display','none');
                var licenceName = $('input[name="licenceName"]').val();
                var deptName = $('input[name="deptName"]').val();
                var licenseTypeId = $('select[name="licenseTypeId"]').val();
                var effectiveDate = $('input[name="effectiveDate"]').val();
                var expireDate = $('input[name="expireDate"]').val();
                var yearlyInspectionDate = $('input[name="yearlyInspectionDate"]').val();
                var licenseStatus = $('select[name="licenseStatus"]').val();
                table.render({
                    elem: '#tableDemocratic1'
                    ,url:'/license/selectAllByMap?useFlag=true'
                    ,parseData: function(res){ //res 即为原始返回的数据
                        return {
                            "code": 0, //解析接口状态
                            "data": res.obj, //解析数据列表
                            "count": res.totleNum, //解析数据长度
                        };
                    }
                    ,where: {
                        licenceName: licenceName,
                        deptName: deptName,
                        licenseTypeId: licenseTypeId,
                        effectiveDate: effectiveDate,
                        expireDate: expireDate,
                        yearlyInspectionDate: yearlyInspectionDate,
                        licenseStatus: licenseStatus,
                    }
                    ,title: '用户数据表'
                    ,cols: [[
                        {field:'licenceName', title:'证照名称',align:'center'}
                        ,{field:'deptName', title:'机构名称',align:'center'}
                        ,{field:'licenseTypeName', title:'证照类别',align:'center'}
                        ,{field:'effectiveDate', title:'有效日期',align:'center'}
                        ,{field:'expireDate', title:'到期日期',align:'center'}
                        ,{field:'issueDate', title:'发证日期',align:'center'}
                        ,{field:'yearlyInspectionDate', title:'年检日期',align:'center'}
                        ,{field:'licenseStatus', title:'状态',align:'center',templet:function(d){
                            if(d.licenseStatus == '1'){
                                return  '生效中'
                            }else{
                                return  '已到期'
                            }
                            }}
                        ,{fixed: 'right', title:'操作', toolbar: '#barDemo',align:'center'}
                    ]],
                    page:true

                });
                table.on('tool(tableDemocratic1)', function(obj){
                    var data = obj.data;
                    var licenceId = data.licenceId;
                    if (obj.event === 'lookDetail') {
                        lookLicence(licenceId)
                    }
                });
            })
            $('#search').on('click',function(){
                var licenceName = $('.licenceName').val();
                var deptName = $('.deptName').val();
                if(expiredType == '1'){
                    table.reload('tableDemocratic', {
                        where: {
                            expired:'',
                            licenceName: licenceName,
                            deptName: deptName,
                        }
                    });
                }else if(expiredType == '2'){
                    table.reload('tableDemocratic', {
                        where: {
                            expired: 'one',
                            licenceName: licenceName,
                            deptName: deptName,
                        }
                    });
                }else{
                    table.reload('tableDemocratic', {
                        where: {
                            expired: 'expired',
                            licenceName: licenceName,
                            deptName: deptName,
                        }
                    });
                }
            })
            function lookLicence(licenceId){
                layer.open({
                    type: 1,
                    area: ['70%', '70%'], //宽高
                    title:'查看详情',
                    maxmin:true,
                    btn: ['确定','取消'],
                    content: '<div class="layui-collapse artifical lookDetail">\n' +
                        '                            <form class="layui-form" action="" id="licencePart" lay-filter="formTest2">\n' +
                        '                            <p class="headerPic" ><i class="layui-icon layui-icon-down" style=""></i> 基础信息</p>\n' +
                        '                                <%-- 第一行--%>\n' +
                        '                                <div class="layui-row" style="margin-top: 20px;">\n' +
                        '                                    <div class="layui-col-xs4" style="padding: 0 5px;">\n' +
                        '                                        <div class="layui-form-item" >\n' +
                        '                                            <div class="layui-inline">\n' +
                        '                                                <label class="layui-form-label" >证照名称</label>\n' +
                        '                                                <div class="layui-input-inline">\n' +
                        '                                                    <input type="text" name="licenceName"  lay-verify="required|phone" autocomplete="off" class="layui-input jinyong">\n' +
                        '                                                </div>\n' +
                        '                                            </div>\n' +
                        '                                        </div>\n' +
                        '                                    </div>\n' +
                        '                                    <div class="layui-col-xs4" style="padding: 0 5px;">\n' +
                        '                                        <div class="layui-form-item" >\n' +
                        '                                            <div class="layui-inline" >\n' +
                        '                                                <label class="layui-form-label" >机构名称</label>\n' +
                        '                                                <div class="layui-input-inline">\n' +
                        '                                                    <input type="text" name="deptName" lay-verify="required|phone" autocomplete="off" disabled class="layui-input jinyong">\n' +
                        '                                                </div>\n' +
                        '                                            </div>\n' +
                        '                                        </div>\n' +
                        '                                    </div>\n' +
                        '                                    <div class="layui-col-xs4" style="padding: 0 5px;">\n' +
                        '                                        <div class="layui-form-item" >\n' +
                        '                                            <div class="layui-inline" >\n' +
                        '                                                <label class="layui-form-label" >有效日期</label>\n' +
                        '                                                <div class="layui-input-inline">\n' +
                        '                                                    <input type="text" name="effectiveDate" id="effectiveDate"  autocomplete="off" class="layui-input jinyong">\n' +
                        '                                                </div>\n' +
                        '                                            </div>\n' +
                        '                                        </div>\n' +
                        '                                    </div>\n' +
                        '                                </div>\n' +
                        '                                <%-- 第二行--%>\n' +
                        '                                <div class="layui-row">\n' +
                        '                                    <div class="layui-col-xs4" style="padding: 0 5px;">\n' +
                        '                                        <div class="layui-form-item" >\n' +
                        '                                            <div class="layui-inline" >\n' +
                        '                                                <label class="layui-form-label">到期日期</label>\n' +
                        '                                                <div class="layui-input-inline">\n' +
                        '                                                    <input type="text" name="expireDate"  lay-verify="required|phone" autocomplete="off" class="layui-input jinyong">\n' +
                        '                                                </div>\n' +
                        '                                            </div>\n' +
                        '                                        </div>\n' +
                        '                                    </div>\n' +
                        '                                    <div class="layui-col-xs4" style="padding: 0 5px;">\n' +
                        '                                        <div class="layui-form-item" >\n' +
                        '                                            <div class="layui-inline" >\n' +
                        '                                                <label class="layui-form-label" >发证日期</label>\n' +
                        '                                                <div class="layui-input-inline">\n' +
                        '                                                    <input type="text" name="issueDate" id="issueDate" lay-verify="required|phone" autocomplete="off" class="layui-input jinyong">\n' +
                        '                                                </div>\n' +
                        '                                            </div>\n' +
                        '                                        </div>\n' +
                        '                                    </div>\n' +
                        '                                    <div class="layui-col-xs4" style="padding: 0 5px;">\n' +
                        '                                        <div class="layui-form-item" >\n' +
                        '                                            <div class="layui-inline" >\n' +
                        '                                                <label class="layui-form-label" >年检日期</label>\n' +
                        '                                                <div class="layui-input-inline">\n' +
                        '                                                    <input type="text" name="yearlyInspectionDate" id="yearlyInspectionDate" lay-verify="required|phone" autocomplete="off" class="layui-input jinyong">\n' +
                        '                                                </div>\n' +
                        '                                            </div>\n' +
                        '                                        </div>\n' +
                        '                                    </div>\n' +
                        '                                </div>\n' +
                        '                                <%-- 第三行--%>\n' +
                        '                                <div class="layui-row">\n' +
                        '                                    <div class="layui-col-xs4" style="padding: 0 5px;">\n' +
                        '                                        <div class="layui-form-item" >\n' +
                        '                                            <div class="layui-inline">\n' +
                        '                                                <label class="layui-form-label" >发证单位</label>\n' +
                        '                                                <div class="layui-input-inline">\n' +
                        '                                                    <input type="text" name="issuingUnit" lay-verify="required|phone" autocomplete="off" class="layui-input jinyong">\n' +
                        '                                                </div>\n' +
                        '                                            </div>\n' +
                        '                                        </div>\n' +
                        '                                    </div>\n' +
                        '                                    <div class="layui-col-xs4" style="padding: 0 5px;">\n' +
                        '                                        <div class="layui-form-item" >\n' +
                        '                                            <div class="layui-inline">\n' +
                        '                                                <label class="layui-form-label">证照类型</label>\n' +
                        '                                                <div class="layui-input-inline">\n' +
                        '                                                    <input type="text" name="licenceName" lay-verify="required|phone" autocomplete="off" class="layui-input jinyong">\n' +
                        '                                                </div>\n' +
                        '                                            </div>\n' +
                        '                                        </div>\n' +
                        '                                    </div>\n' +
                        '                                </div>\n' +
                        '                                <div class="layui-row">' +
                        '                                    <div class="layui-col-xs12" style="padding: 0 5px;">\n' +
                        '                                        <div class="layui-form-item" >\n' +
                        '                                            <div class="layui-inline">\n' +
                        '                                                <label class="layui-form-label">附件</label>\n' +
                        '                                               <div class="layui-input-block" style="padding-top: 9px">\n' +
                        '                                                   <div id="fileAllAgenda" style="text-align: left;"></div>\n' +
                        '                                                </div>' +
                        '                                            </div>\n' +
                        '                                        </div>\n' +
                        '                                    </div>\n' +
                        '                                </div>\n' +
                        '                            <p class="headerPic"><i class="layui-icon layui-icon-down" style=""></i> 自定义属性（根据证照类型自动获取）</p>\n' +
                        '                             <div class="customize" > </div>' +
                        '                            </form>\n' +
                        '                    </div>',
                    success:function () {
                        $('.jinyong').attr('disabled','disabled');
                        $('.layui-layer-btn0').css('display','none')
                        form.render();
                        $.ajax({
                            type: 'get',
                            url: '/license/selectLicenseById',
                            dataType: 'json',
                            data: {
                                licenceId: licenceId,
                            },
                            success: function (res) {
                                var object = res.object;
                                form.val("formTest2",object);
                                var licTypeName = object.licTypeName;
                                var licTypeVal = object.licTypeVal;
                                if(licTypeName != undefined && licTypeName != null ){
                                    var strEdit = ''
                                    for(var i=0; i<licTypeName.length; i++){
                                        strEdit +=  '     <div class="layui-row" style="margin-top: 10px">\n' +
                                            '                 <div class="layui-col-xs4" style="padding: 0 5px;">\n' +
                                            '                        <div class="layui-form-item" >\n' +
                                            '                             <div class="layui-inline">\n' +
                                            '                                  <label class="layui-form-label" >' + licTypeName[i] + '</label>\n' +
                                            '                                  <div class="layui-input-inline">\n' +
                                            '                                        <input type="text" lay-verify="required|phone" autocomplete="off" class="layui-input jinyong" value="'+ licTypeVal[i] + '">\n' +
                                            '                                  </div>\n' +
                                            '                             </div>\n' +
                                            '                        </div>\n' +
                                            '                 </div>\n' +
                                            '          </div>\n';
                                    }
                                    $('.customize').html(strEdit)
                                    form.render();
                                }
                                var strr = ''
                                if((object.attUrl[0] != undefined && object.attUrl.length>0)){
                                    for(var i=0;i<object.attUrl.length;i++){
                                        var str1 = ""
                                        if( object.attUrl[i].attUrl != undefined ){
                                            str1 = '<div class="dech" deurl="' +object.attUrl[i].attUrl + '">' +
                                                '<a href="/download?' + object.attUrl[i].attUrl + '" name="'+object.attUrl[i].attachName+'*" style="text-decoration:none;margin-left:5px;">' +
                                                '<img src="/img/attachment_icon.png">' + object.attUrl[i].attachName + '</a>' +
                                                '<img class="deImgs" style="margin-left:5px;cursor: pointer;" src="/img/file/icon_deletecha_03.png">' +
                                                '<input type="hidden" class="inHidden" value="' + object.attUrl[i].aid + '@' + object.attUrl[i].ym + '_' + object.attUrl[i].attachId +',">' +
                                                '<a onclick="pdurls($(this))" href="javascript:;" style="padding-left: 5px">' +
                                                '<img src="/img/attachmentIcon/icon_skim.png" style="padding: 0 5px;">查阅</a>' +
                                                '<a style="padding-left: 5px" href="/download?' + object.attUrl[i].attUrl + '">' +
                                                '<img src="/img/attachmentIcon/icon_down.png" style="padding: 0 5px;">下载</a>\n' +
                                                '</div>' +
                                                '</div>'
                                        }else{
                                            str1 = '';
                                        }
                                        strr += str1;
                                    }
                                }else {
                                    strr='';
                                }
                                $('#fileAllAgenda').html(strr);
                            }
                        })
                    }
                });
            }
        })
    })


</script>

</body>
</html>

