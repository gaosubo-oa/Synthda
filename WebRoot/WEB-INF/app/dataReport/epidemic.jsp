<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@taglib prefix="mvc" uri="http://www.springframework.org/tags/form" %>
<%@taglib prefix="fmt" uri="http://www.springframework.org/tags" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <title>报表设置</title>
    <meta name="renderer" content="webkit">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport"
          content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=0">
    <link rel="stylesheet" href="/lib/layui/layui/css/layui.css?20210319.1">
    <link rel="stylesheet" href="/lib/layui/layui/css/common.css">
    <link rel="stylesheet" href="/lib/layui/layui/css/eleTree.css">
    <script type="text/javascript" src="/ui/js/xoajq/xoajq3.js"></script>
    <script src="/lib/layui/layui/layui.js"></script>
    <script src="../../lib/laydate/laydate.js"></script>
    <script src="/js/jquery/jquery.form.min.js"></script>
    <script src="/lib/layui/layui/js/common.js?v=20190726" type="text/javascript" charset="utf-8"></script>
    <script src="/lib/layui/layui/js/baseCode/base.js?v=2019080918:09" type="text/javascript" charset="utf-8"></script>
    <script type="text/javascript" src="/lib/layui/layui/global.js"></script>
    <script src="/js/base/base.js" type="text/javascript" charset="utf-8"></script>
    <style>
        html{
            background-color: #fff;
        }
        .layui-form-label {
            width: 100px;
        }

        .layui-input-block {
            margin-left: 130px;
        }

        .layui-disabled, .layui-disabled:hover {
            color: #797979 !important;
        }

        .ztree * {
            font-size: 11pt !important;
        }

        #questionTree li {
            border-bottom: 1px solid #ddd;
            line-height: 40px;
            padding-left: 10px;
            cursor: pointer;
            border-radius: 3px;
            overflow: hidden;
            white-space: nowrap;
            text-overflow: ellipsis;
        }

        .select {
            background: #c7e1ff;
        }

        .ContAdd {
            position: absolute;
            right: 144px;
            bottom: 195px;

        }

        .laytable-cell-1-0-8{
            width: 170px!important;
        }
        .laytable-cell-1-0-0{
            width: 60px!important;
        }

        .item1 {
            margin-left: 5%;
            font-size: 16px;
            font-weight: bold;
        }

        .item2 {
            width: 90%;
            margin: 2px auto;
        }

        .num {
            color: #2F7CE7;
        }

        .required {
            color: #CE5841;
            margin-left: 1%;
            font-size: 13px;
        }

        .itemTotal {
            margin: 13px 0px;
        }

        .layui-input {
            /*width: 90%;*/
            /*margin: 2px auto;*/
            height: 30px;
            border-radius: 5px;
            line-height: 30px;
        }

        .layui-input[fieldtype='2'] {
            text-align: center;
        }

        .fieldDesc {
            font-size: 13px;
            color: #292929;
            margin: 5px 0px;
            margin-left: 5%;
        }

        .fieldName {
            margin-left: 1%;
        }

        .layui-form-radio > i {
            font-size: 18px;
        }

        .layui-form-radio {
            margin: 0px 10px 0px 0px;
        }

        .baoTitle {
            font-size: 20px;
            margin: 17px 0px 0px 10px;
            font-weight: bold;
        }

        .laytable-cell-1-0-0, .laytable-cell-1-0-1, .laytable-cell-1-0-2, .laytable-cell-1-0-3 {
            font-size: 14px;
            /*padding:0 5px;*/
            height: auto;
            overflow: visible;
            text-overflow: inherit;
            white-space: normal;
            word-break: break-all;
        }

        .layui-btn + .layui-btn {
            margin: 0px;
        }

        .layui-btn-xs {
            height: 25px;
            line-height: 25px;
            padding: 0 10px;
            font-size: 13px;
            /*margin: 8px 0px;*/
        }
        .layui-form-select{
            width: 100%!important;
        }

        .box {
            width: 73px;
            float: right;
            margin-right: -49px;
            margin-top: -37px;
            height: 30px;
            line-height: 30px;
        }

        .layui-input-block textarea {
            background: #eee;
            border-color: #c2c2c2;
        }
        .overflows{
            width: 140px;
            overflow: hidden;/*超出部分隐藏*/
            white-space: nowrap;/*禁止换行*/
            text-overflow: ellipsis;/*省略号*/
            display: inline-block;
        }
        .liHeigh{
            height: 42px;
        }
    </style>
    <link rel="stylesheet" href="/lib/zTree_v3/css/zTreeStyle/zTreeStyle.css"/>
    <script type="text/javascript" src="/lib/zTree_v3/js/jquery.ztree.all.min.js"></script>
    <%--    <link rel="stylesheet" href="/duplopages/manage/standard/form/css/treeselect.css"/>--%>
</head>
<body>
<div style="margin-top: 20px;position: relative;">
    <img src="../../img/addcodemain.png" style="position: absolute;left: 22px;top:4px "><span
        style="margin-left: 49px;font-size: 20px;">报表设置</span>
</div>
<%--蓝色分割线--%>
<hr class="layui-bg-blue" style="height: 5px">
<div class="layui-fluid" id="LAY-app-message">
    <input type="hidden" id="sortId">
    <div class="layui-row ">
        <div class="layui-lf" style="width:250px;float:left">
            <div class="layui-card">
                <div class="layui-card-body" id="leftHeight" style="height:650px;">
                    <div style="margin-bottom:10px" id="yanchi">
                        <button type="button" class="layui-btn layui-btn-primary layui-btn-sm add" id="addPlan"
                                style="margin-right: 7px;">新建
                        </button>
                        <button type="button" class="layui-btn layui-btn-primary layui-btn-sm add" id="editPlan"
                                style="margin-right: 7px;">编辑
                        </button>
                        <button type="button" class="layui-btn layui-btn-primary layui-btn-sm del" id="delPlan"
                                style="margin-right: 7px;">删除
                        </button>
                        <button type="button" class="layui-btn layui-btn-primary layui-btn-sm clone" id="clonePlan"
                                style="">克隆
                        </button>
                    </div>
                    <div class="layui-form" lay-filter="selectStatus" style="margin: 15px 0px;">
                        <select name="" id="" lay-filter="selectStatus">
                            <option value="a">请选择报表状态</option>
                            <option value="0">未启用</option>
                            <option value="1">收集中</option>
                            <option value="2">已结束</option>
                        </select>
                    </div>
                    <ul id="questionTree" style="overflow:auto;height:100%">
                    </ul>
                </div>
            </div>
        </div>
        <div class="layui-rt " style="width:calc(100% - 250px);float:left">
            <div class="layui-card rightHeight" style="padding-left: 10px;">
                <button type="button" class="layui-btn " style="margin-top: 12px;" id="addTable">新增字段</button>
                <button type="button" class="layui-btn " style="margin-top: 12px;margin-left: 20px" id="previewReport">
                    报表预览
                </button>
                <button type="button" class="layui-btn " style="margin-top: 12px;margin-left: 20px" id="import">导入字段
                </button>
                <button type="button" class="layui-btn layui-btn-danger" style="margin-top: 12px;margin-left: 20px;" id="endCollection">结束收集</button>
                <button type="button" class="layui-btn" style="margin-top: 12px;margin-left: 20px;" id="recyclingStation">回收站</button>
                <table id="questionTable" lay-filter="questionTable-table" onload=''></table>
            </div>
        </div>
    </div>
    <script type="text/html" id="barDemo">
        <a class="layui-btn layui-btn-xs" lay-event="edit">编辑</a>
        <a class="layui-btn layui-btn-danger layui-btn-xs" lay-event="del">删除</a>
    </script>
</div>
<script>
    var tableIns
    var form
    var table
    var height = $(window).height()
    var fieldType
    $('#leftHeight').height(height - 130);
    $('.rightHeight').height(height - 110);
    $('#questionTree').height(height - 160);
    // $('.rightHeight').height('auto');
    var type = $.GetRequest().type;
    var dataType = $.GetRequest().dataType;
    var shitiType = '';
    var num = 0;
    var mobiletype = false;
    if (( /(iPhone|iPad|iPod|iOS)/i.test(navigator.userAgent) )) {
        mobiletype = true;
    } else if (/(Android)/i.test(navigator.userAgent)) {
        mobiletype = true;
    }
    if (mobiletype) {
        $('.layui-lf').width('100%');
        $('.layui-rt').width('100%').hide().find('.rightHeight').height('auto');
        $('head').append('<style>button.layui-btn{height: 30px;\n' +
            '    line-height: 30px;\n' +
            '    padding: 0 10px;}</style>');
        $('#addTable').before('<button type="button" class="layui-btn layui-bg-red" style="margin-top: 12px;margin-right: 24px;" id="backTable">返回</button>');
    }

    $('#questionTree').on('click', 'li', function () {
        var repTableId = $(this).attr('repTableId');
        $(this).addClass('select').siblings().removeClass('select');
        // var  currentPage=1;
        table.reload('questionTable', {
            url: '/repField/getFieldByTableId',
            // data:{page:currentPage},
            // page:{
            //     curr:currentPage
            // },
            where: {
                tableId: repTableId
            }
        })
        if (mobiletype) {
            $('.layui-rt').show();
            $('.layui-lf').hide();
        }
        // console.log($(this).find('span').hasClass('isOver'))
        // console.log($(this).find('span').is('isOver'))
        //对于已结束状态的报表 隐藏结束按钮
        if($(this).find('span').hasClass('isOver')){
            $("#endCollection").hide();
        }else{
            $("#endCollection").show();
        }
        //设置报表结束收集
        $('#endCollection').on('click',function () {
            $.ajax({
                url: '/repTable/updateRepTables',
                data: {repTableId: repTableId},
                type: 'get',
                dataType: 'json',
                success: function (res) {
                    if (res.flag) {
                        layer.msg('结束收集成功', {icon: 1})
                        location.reload();
                        // getlis();
                    } else {
                        layer.msg('结束收集失败', {icon: 2})
                    }
                }
            })
        })
    })
    function addNumBtn() {
        var index = layer.load();
        for (var i = 0; i < $('input[fieldtype=2]').length; i++) {
            var $this = $('input[fieldtype=2]').eq(i);
            $this.css({
                'display': 'inline-block',
                'padding-right': '10px',
                // 'width': '63px'
            });
            // $this.before('<i class="layui-icon layui-icon-subtraction" style="color: #1E9FFF;font-weight: bold;" onclick="subtraction($(this))"></i>&nbsp;');
            // $this.after('&nbsp;<i class="layui-icon layui-icon-addition" onclick="addition($(this))" style="\n' +
            //     '    color: #1E9FFF;\n' +
            //     '    font-weight: bold;\n' +
            //     '"></i>');
        }
        layer.close(index);
    }
    function subtraction(e) {
        var $this = e.next();
        if ($this.val() != '') {
            var val = parseInt($this.val());
        } else {
            var val = 1;
        }
        if (val != 0) {
            $this.val(val - 1);
        }
    }
    function addition(e) {
        var $this = e.prev();
        if ($this.val() != '') {
            var val = parseInt($this.val());

        } else {
            var val = -1;
        }
        $this.val(val + 1);
    }
    //根据选择的报表状态显示左侧列表
    layui.use(['form'], function() {
        var form = layui.form;

    })
    //判断报表状态
    function tableStatus(myStatus){
        var isHtml = "";
        if(myStatus == 0){
            myStatus = '未启用';
            for(var i=0; i<myStatus.length; i++){
                isHtml += '<span class="notEnable" style="float: right;margin-right: 10px;">'+ myStatus + '</span>'
            }
            return isHtml;
        }else if(myStatus == 1){
            myStatus = '收集中';
            isHtml += '<span class="isCollect" style="color:mediumseagreen;float: right;margin-right: 10px;">'+ myStatus + '</span>'
            return isHtml;
        }else if(myStatus == 2){
            myStatus = '已结束';
            isHtml += '<span class="isOver" style="color: red;float: right;margin-right: 10px;">'+ myStatus + '</span>'
            return isHtml;
        }
    }
    //获取当前时间  年月日
    function nowformat() {
        var nstr = "";
        var now = new Date();
        var nyear = now.getFullYear();
        var nmonth = now.getMonth() + 1;
        var nday = now.getDate();
        if (nmonth < 10) {
            nmonth = "0" + nmonth;
        }
        if (nday < 10) {
            nday = "0" + nday;
        }
        nstr = nyear + "-" + nmonth + "-" + nday;
        return nstr;
    }
    //回收站功能
    $("#recyclingStation").on('click',function(){
        window.location.href='/repField/dataDeleted';
    })
    //左侧新建
    $('#addPlan').on('click',function () {
        create(0, '')
    })
    //左侧修改
    $('#editPlan').on('click',function () {
        var repTableId = $('.select').attr('repTableId');
        create(1, repTableId)
    })
    //左侧删除
    $('#delPlan').on('click',function () {
        // var cbsId = $('#leftId').attr('cbsId');
        // if (!cbsId) {
        //     layer.msg('请选择需要删除的模板！', {icon: 0});
        //     return false;
        // }
        var repTableId = $('.select').attr('repTableId');
        if (!repTableId) {
            layer.msg('请选择报表！', {icon: 0});
            return false;
        }
        var text = $('.select .overflows').text();
        layer.confirm('是否要删除' + text, {icon: 3, title: '删除'}, function (index) {
            $.ajax({
                url: '/repTable/deleteRepTable',
                data: {repTableId: repTableId},
                type: 'get',
                dataType: 'json',
                success: function (res) {
                    if (res.flag) {
                        layer.msg('删除成功', {icon: 1})
                        // getlis()
                        location.reload();
                    } else {
                        layer.msg('删除失败', {icon: 2})
                    }
                }
            })
            layer.close(index);
        });
    })

    //左侧克隆
    $('#clonePlan').on('click',function () {
        var repTableId = $('.select').attr('repTableId');
        if (!repTableId) {
            layer.msg('请选择报表！', {icon: 0});
            return false;
        }
        layer.open({
            type: 1,
            title: '报表克隆',
            btn: ['确定', '取消'],
            shade: 0.5,
            maxmin: true, //开启最大化最小化按钮
            area: ['75%', '35%'],
            content: ' <div class="layui-form" id="report">' +
            '<div class="itemTotal">\n' +
            ' <div class="item1"><span class="fieldName">克隆报表名称</span><span class="required">(必填)</span></div><div class="fieldDesc"></div>\n' +
            ' <div class="item2"><input value="" placeholder="请输入克隆后生成报表的名称" type="text" name="repTableName" lay-verify="required" autocomplete="off" class="layui-input fieldSize fieldId fieldType ismust"></div>\n' +
            '            </div>' +
            '</div>',
            success: function () {

            }, yes: function () {

                var index = layer.confirm('是否确定克隆新的报表', {
                    btn: ['确定', '取消'], //按钮
                    title: "提示信息"
                }, function () {
                    var repTableName = $('input[name=repTableName]').val() || '';
                    if (repTableName == '') {
                        layer.msg('克隆的报表名称不能为空')
                    } else {
                        $.ajax({
                            url: '/repTable/cloneRepTable',
                            data: {
                                repTableName: repTableName,
                                repTableId: repTableId
                            },
                            dataType: 'json',
                            type: 'post',
                            success: function (res) {
                                if(res.msg=='err'){
                                    layer.msg('克隆失败!报表名称重复！', {icon: 0 , time: 2000}, function () {
                                        layer.closeAll();
                                    });
                                    return false;
                                }

                                if (res.flag) {
                                    layer.msg('克隆成功', {icon: 1, time: 2000}, function () {
                                        getlis();
                                        layer.closeAll();
                                    });

                                } else {
                                    layer.msg('克隆失败', {icon: 1, time: 2000}, function () {
                                        layer.closeAll();
                                    });
                                }
                            }
                        })
                    }
                }, function () {
                    layer.close();
                })


            }
        });
    })

    //    左侧新建编辑共有函数
    function create(type, repTableId) {
        if (type == '0') {
            var title = '新建报表'
            var url = '/repTable/inserRepTable'
        } else {
            var title = '编辑'
            var url = '/repTable/updateRepTable'
            var repTableId = $('.select').attr('repTableId');
            if (!repTableId) {
                layer.msg('请选择报表！', {icon: 0});
                return false;
            }
        }
        if ($(window).height() < 650) {
            var width = '600px';
            var height = '550px';
        } else {
            var width = '600px';
            var height = '650px';
        }

        if (mobiletype) {
            var width = '98%';
            var height = '90%';
        }
        layer.open({
            type: 1,
            title: title,
            btn: ['确定', '取消'],
            shade: 0.5,
            maxmin: true, //开启最大化最小化按钮
            area: [width, height],
            content: ' <div class="layui-form" xmlns="http://www.w3.org/1999/html">' +
            '<form class="layui-form"  id="forms" lay-filter="formsTest" action="">\n' +
            '<div class="layui-form-item"style="width: 80%;margin-top: 10px;">\n' +
            '    <label class="layui-form-label"><span style="color: red;">*</span>报表名称:</label>\n' +
            '    <div class="layui-input-block" style="width: 320px">\n' +
            '      <input type="text" name="repTableName" required  lay-verify="required" placeholder="请输入报表名称" autocomplete="off" class="layui-input">\n' +
            '    </div>\n' +
            '  </div>' +
            '<div class="layui-form-item"style="width: 80%;">\n' +
            '    <label class="layui-form-label"><span style="color: red;">*</span>报表状态:</label>\n' +
            '    <div class="layui-input-block" style="width:320px">\n' +
            '   <select lay-verify="required" class="tableState"  lay-filter="fieldType" name="status">\n' +
            '       <option value="0" selected>未启用</option>\n' +
            '       <option value="1">收集中</option>\n' +
            '       <option value="2">已结束</option>\n' +
            '   </select>\n' +
            '    </div>\n' +
            '  </div>' +
            '<div class="layui-form-item" style="width: 80%;margin-top: 10px;">\n' +
            '    <label class="layui-form-label"><span style="color: red;">*</span>排序号</label>\n' +
            '    <div class="layui-input-block" style="width: 320px">\n' +
            '      <input oninput="value=value.replace(/[^\\d{1,}\\.\\d{1,}|\\d{1,}]/g,\'\')" type="text" name="sortNo" required="" lay-verify="required" placeholder="请输入排序号" autocomplete="off" class="layui-input">\n' +
            '    </div>\n' +
            '  </div>' +

                '<div class="layui-form-item" style="width: 80%;margin-top: 10px;">\n' +
                '    <label class="layui-form-label">开始时间</label>\n' +
                '    <div class="layui-input-block" style="width: 320px">\n' +
                '      <input onclick="laydate({istime: true, format: \'YYYY-MM-DD hh:mm:ss\'})" type="text" name="beginTime" class="layui-input" id="beginTime">\n' +
                '    </div>\n' +
                '  </div>' +
            '<div class="layui-form-item" style="width: 80%;margin-top: 10px;">\n' +
            '    <label class="layui-form-label">截止时间</label>\n' +
            '    <div class="layui-input-block" style="width: 320px">\n' +
            '      <input onclick="laydate({istime: true, format: \'YYYY-MM-DD hh:mm:ss\'})" type="text" name="closingTime" class="layui-input" id="closingTime">\n' +
            '    </div>\n' +
            '  </div>' +
                '<div class="layui-form-item"style="width: 500px"  id="suoshuren">\n' +
                '    <label class="layui-form-label">所属人:</label>\n' +
                '    <div class="layui-input-block" style="width: 320px">\n' +
                '      <textarea  type="text" name="Owner" user_id=""  id="Owner" placeholder="请选择所属人" readonly="readonly"style="height: 30px;border-radius: 5px;line-height: 30px; display: block;width: 96%;padding-left: 10px;"></textarea>\n' +
                ' </div>\n' +
                '<div class="box">' +
                '<a href="javascript:;" style="color:#1E9FFF" class="addExecute1">添加</a>\n' +
                ' <a href="javascript:;" style="color:#1E9FFF" class="clear">清空</a>\n' +
                '</div>\n' +
                '  </div>\n' +
            '<div class="layui-form-item"style="width: 500px">\n' +
            '    <label class="layui-form-label">查阅权限(人员):</label>\n' +
            '    <div class="layui-input-block" style="width: 320px">\n' +
            '      <textarea  type="text" name="manageUserId" user_id=""  id="rescueUser"  placeholder="请选择查阅人员" readonly="readonly"style="height: 45px;width: 315px;text-indent:1em;border-radius: 4px;"></textarea>\n' +
            ' </div>\n' +
            '<div class="box">' +
            '<a href="javascript:;" style="color:#1E9FFF" class="addExecute">添加</a>\n' +
            ' <a href="javascript:;" style="color:#1E9FFF" class="clearExecute">清空</a>\n' +
            '</div>\n' +
            '  </div>\n' +
            '<div class="layui-form-item"style="width: 500px">\n' +
            '    <label class="layui-form-label">查阅权限(角色):</label>\n' +
            '    <div class="layui-input-block" style="width: 320px">\n' +
            '      <textarea  type="text" name="managePrivId" id="managementRole" userpriv=""  placeholder="请选择角色"readonly="readonly" style="height: 45px;width: 315px;text-indent:1em;border-radius: 4px;"></textarea>\n' +
            ' </div>\n' +
            '<div class="box">\n' +
            '<a href="javascript:;" style="color:#1E9FFF" class="roleAdd">添加</a>\n' +
            ' <a href="javascript:;" style="color:#1E9FFF" class="roleClear">清空</a>\n' +
            '</div>\n' +
            '  </div>\n' +
            '<div class="layui-form-item"style="width: 500px">\n' +
            '    <label class="layui-form-label">查阅权限(部门):</label>\n' +
            '    <div class="layui-input-block" style="width: 320px">\n' +
            '      <textarea type="text" name="manageDeptId" id="department" deptid=""   placeholder="请选择部门" readonly="readonly" style="height: 45px;width: 315px;text-indent:1em;border-radius: 4px;"></textarea>\n' +
            ' </div>\n' +
            '<div class="box">' +
            '<a href="javascript:;" style="color:#1E9FFF" class="departmentadd">添加</a>\n' +
            ' <a href="javascript:;" style="color:#1E9FFF" class="departmentclear">清空</a>\n' +
            '</div>\n' +
            '  </div>\n' +
            '<div class="layui-form-item"style="width: 500px">\n' +
            '    <label class="layui-form-label">上报权限(人员):</label>\n' +
            '    <div class="layui-input-block" style="width: 320px">\n' +
            '      <textarea  type="text" name="viewUserId" id="inspector" user_id=""  placeholder="请选择上报人员"readonly="readonly" style="height: 45px;width: 315px;text-indent:1em;border-radius: 4px;"></textarea>\n' +
            ' </div>\n' +
            '<div class="box">' +
            '<a href="javascript:;" style="color:#1E9FFF" class="inspectoradd">添加</a>\n' +
            ' <a href="javascript:;" style="color:#1E9FFF" class="inspectorclear">清空</a>\n' +
            '</div>\n' +
            '  </div>\n' +
            '<div class="layui-form-item"style="width: 500px">\n' +
            '    <label class="layui-form-label">上报权限(角色):</label>\n' +
            '    <div class="layui-input-block" style="width: 320px">\n' +
            '      <textarea  type="text" name="viewPrivId" id="viewRole" userpriv="" placeholder="请选择角色" readonly="readonly"style="height: 45px;width: 315px;text-indent:1em;border-radius: 4px;"></textarea>\n' +
            ' </div>\n' +
            '<div class="box">' +
            '<a href="javascript:;" style="color:#1E9FFF" class="viewadd">添加</a>\n' +
            ' <a href="javascript:;" style="color:#1E9FFF" class="viewclear">清空</a>\n' +
            '</div>\n' +
            '  </div>\n' +
            '<div class="layui-form-item"style="width: 500px">\n' +
            '    <label class="layui-form-label">上报权限(部门):</label>\n' +
            '    <div class="layui-input-block" style="width: 320px">\n' +
            '      <textarea type="text" name="viewDeptId" id="review" deptid="" placeholder="请选择部门"readonly="readonly" style="height: 45px;width: 315px;text-indent:1em;border-radius: 4px;"></textarea>\n' +
            ' </div>\n' +
            '<div class="box">' +
            '<a href="javascript:;" style="color:#1E9FFF" class="reviewadd">添加</a>\n' +
            ' <a href="javascript:;" style="color:#1E9FFF" class="reviewclear">清空</a>\n' +
            '</div>\n' +
            '  </div>\n' +
            '</form>\n' +
            '</div>',
            success: function () {
                if(title=="新建报表"){
                    $("#suoshuren").css("display","none");
                }
                //所输入控件添加
                $(".addExecute1").on("click", function () {
                    user_id = 'Owner';
                    $.popWindow("../../common/selectUser?0");
                });
                //选择所输入的删除
                $('.clear').on('click',function () {
                    $("#Owner").val("");
                    $("#Owner").attr('username', '');
                    $("#Owner").attr('dataid', '');
                    $("#Owner").attr('user_id', '');
                    $("#Owner").attr('userprivname', '');
                });
                //选人员控件的添加
                $(".addExecute").on("click", function () {
                    user_id = 'rescueUser';
                    $.popWindow("../../common/selectUser");
                });
                //选人控件的删除
                $('.clearExecute1').on('click',function () {
                    $("#rescueUser").val("");
                    $("#rescueUser").attr('username', '');
                    $("#rescueUser").attr('dataid', '');
                    $("#rescueUser").attr('user_id', '');
                    $("#rescueUser").attr('userprivname', '');
                });

                //选角色控件的添加
                $(".roleAdd").on("click", function () {
                    priv_id = 'managementRole';
                    $.popWindow("../../common/selectPriv?1");
                });
                //选角色控件的删除
                $('.roleClear').on('click',function () {
                    $('#managementRole').removeAttr('userpriv');
                    $('#managementRole').removeAttr('privid');
                    $('#managementRole').attr('dataid', '');
                    $('#managementRole').val('');
                });

                //选部门控件的添加
                $(".departmentadd").on("click", function () {
                    dept_id = 'department';
                    $.popWindow("../../common/selectDept");
                });
                //选部门控件的删除
                $('.departmentclear').on('click',function () {
                    $('#department').removeAttr('deptid');
                    $('#department').attr('deptno', '');
                    $('#department').removeAttr('deptname');
                    $('#department').val('');
                });

                //选人员控件的添加
                $(".inspectoradd").on("click", function () {
                    user_id = 'inspector';
                    $.popWindow("../../common/selectUser");
                });
                //选人员控件的删除
                $('.inspectorclear').on('click',function () {
                    $("#inspector").val("");
                    $("#inspector").attr('username', '');
                    $("#inspector").attr('dataid', '');
                    $("#inspector").attr('user_id', '');
                    $("#inspector").attr('userprivname', '');
                });
                //选角色控件的添加
                $(".viewadd").on("click", function () {
                    priv_id = 'viewRole';
                    $.popWindow("../../common/selectPriv");
                });
                //选角色控件的删除
                $('.viewclear').on('click',function () {
                    $('#viewRole').removeAttr('userpriv');
                    $('#viewRole').removeAttr('privid');
                    $('#viewRole').attr('dataid', '');
                    $('#viewRole').val('');
                });

                //选部门控件的添加
                $(".reviewadd").on("click", function () {
                    dept_id = 'review';
                    $.popWindow("../../common/selectDept");
                });
                //选部门控件的删除
                $('.reviewclear').on('click',function () {
                    $('#review').removeAttr('deptid');
                    $('#review').attr('deptno', '');
                    $('#review').removeAttr('deptname');
                    $('#review').val('');
                });
                // layui.laydate.render({
                //     elem: '#closingTime' + num
                //     , type: 'datetime'
                // });
                num++;
                //编辑的页面回显
                if (type == 1) {
                    $.ajax({
                        url: '/repTable/findRepTableById',   //编辑页面根据id页面回显的接口
                        type: 'get',
                        data: {repTableId: repTableId},
                        dataType: 'json',
                        success: function (res) {
                            $('[name="repTableName"]').attr('repTableName', res.object.repTableName)
                            form.val("formsTest", res.object);
                            $('textarea[name=Owner]').val(res.object.createUser).attr('user_id', res.object.Owner);
                            $('textarea[name=manageUserId]').val(res.object.manageUserName).attr('user_id', res.object.manageUserId);
                            $('textarea[name=managePrivId]').val(res.object.managePrivName).attr('userpriv', res.object.managePrivId);
                            $('textarea[name=manageDeptId]').val(res.object.manageDeptName).attr('deptid', res.object.manageDeptId);
                            $('textarea[name=viewUserId]').val(res.object.viewUserName).attr('user_id', res.object.viewUserId);
                            $('textarea[name=viewPrivId]').val(res.object.viewPrivName).attr('userpriv', res.object.viewPrivId);
                            $('textarea[name=viewDeptId]').val(res.object.viewDeptName).attr('deptid', res.object.viewDeptId);

                        }
                    })
                }
                form.render();
            },
            yes: function () {
                if ($('[name="repTableName"]').attr('repTableName') == $('input[name="repTableName"]').val()&&type == '1') {
                    saveData()
                }else{
                    $.ajax({
                        url: '/repTable/checkTableName',
                        type: 'post',
                        data: {
                            tableName: $('input[name="repTableName"]').val()
                        },
                        dataType: 'json',
                        success: function (res) {
                            if (res.flag == false) {
                                layer.confirm('报表名称已存在，是否继续保存？', {
                                    btn: ['确定', '取消'], //按钮
                                    title: "提示信息"
                                }, function () {
                                    saveData()
                                    layer.closeAll();
                                }, function () {
                                    layer.close();
                                })
                            }else{
                                saveData()
                            }
                        }
                    })
                }

                function saveData() {
                    var repTableName = $('input[name="repTableName"]').val() || '';
                    var tableState = $('.tableState').val() || '';
                    var sortNo = $('input[name=sortNo]').val() || '';
                    var closingTime = $('input[name=closingTime]').val() || '';
                    if (repTableName == "" || tableState == "" || sortNo == "") {
                        layer.msg('必填项不能为空')
                    } else {

                        $.ajax({
                            url: url,
                            data: {
                                repTableName: repTableName,
                                status: tableState,
                                repTableId: repTableId,
                                viewUserId: IsUndefined( $('#inspector').attr('user_id') ),
                                viewPrivId: IsUndefined( $('#viewRole').attr('userpriv') ),
                                viewDeptId: IsUndefined($('#review').attr('deptid')),
                                manageUserId: IsUndefined($('#rescueUser').attr('user_id')),
                                createUser:IsUndefined($('#Owner').attr('user_id')),
                                managePrivId: IsUndefined($('#managementRole').attr('userpriv')),
                                manageDeptId: IsUndefined($('#department').attr('deptid')),
                                sortNo: parseInt(sortNo),
                                closingTime: $("#closingTime").val(),
                                beginTime: $("#beginTime").val(),

                            },
                            dataType: 'json',
                            type: 'post',
                            success: function (res) {
                                if (res.flag) {
                                    layer.msg('保存成功', {icon: 1, time: 2000}, function () {
                                        // getlis();
                                        layer.closeAll();
                                        location.reload();
                                    });
                                }
                            }
                        })
                    }
                }


            },
            cancel: function (index) {

            }
        });
    }
    //进货人点击添加的按钮
    function x() {
        layui.use(['form', 'table', 'laydate', 'element', 'layer', 'upload'], function () {
            var layer = layui.layer;
            table = layui.table;
            form = layui.form;
            var upload = layui.upload;
            var laydate = layui.laydate
            if ($(window).width() > 1492) {
                var sum = $(window).width() - 292;
                var w1 = (60 / 1250) * sum;
                var w2 = (250 / 1250) * sum;
                var w3 = (100 / 1250) * sum;
                var w4 = (100 / 1250) * sum;
                var w5 = (90 / 1250) * sum;
                var w6 = (250 / 1250) * sum;
                var w7 = (90 / 1250) * sum;
                var w8 = (100 / 1250) * sum;
                var w9 = (150 / 1250) * sum;
            } else {
                var w1 = 60;
                var w2 = 250;
                var w3 = 100;
                var w4 = 100;
                var w5 = 90;
                var w6 = 250;
                var w7 = 90;
                var w8 = 100;
                var w9 = 150;
            }
            function getlis() {
                $.ajax({
                    url: '/repTable/findRepTable',
                    type: 'get',
                    async: false,
                    dataType: 'json',
                    success: function (res) {
                        var data = res.obj
                        var str = ''
                        for (var i = 0; i < data.length; i++) {
                            if (i == 0) {
                                str += '<li class="select liHeigh" title="' + data[i].repTableName +
                                    '" dictNo="' + data[i].repTableName + '"  repTableId="' + data[i].repTableId + '">' +'<div class="overflows">' +
                                    data[i].repTableName + '</div>' + "&nbsp;&nbsp;" + tableStatus(data[i].status) + '</li>'
                            } else {
                                str += '<li class="liHeigh" dictNo="' + data[i].repTableName + '" repTableId="' + data[i].repTableId +
                                    '" title="' + data[i].repTableName + '">' + '<div class="overflows">' +
                                    data[i].repTableName + '</div>' + "&nbsp;&nbsp;" + tableStatus(data[i].status) + '</li>'
                            }
                        }
                        $('#questionTree').html(str);
                        //判断出现滚动条时候的宽度
                        var isScroll = $(".layui-lf").prop('offsetWidth') > $(".layui-lf").prop('scrollWidth');
                        if(isScroll){
                            $(".liHeigh span").css({"margin-right": "5px"});
                        }
                        // if(data[0].repTableId != undefined || data[0].repTableId != ''){
                        //     // console.log(data[0].repTableId)
                        //     table.reload('questionTable', {
                        //         url: '/repField/getFieldByTableId',
                        //         where: {
                        //             tableId: data[0].repTableId
                        //         }
                        //     })
                        // }
                        //对于已结束状态的报表 隐藏结束按钮
                        if($('.select').find('span').hasClass('isOver')){
                            $("#endCollection").hide();
                        }else{
                            $("#endCollection").show();
                        }
                    }
                })
            }
            getlis();
            form.render('select','selectStatus');
            layui.form.on('select(selectStatus)', function (data) {
                // console.log(data);
                if (data.value == 0) {
                    for(var i=0; i<$(".notEnable").length; i++){
                        $(".notEnable").parent().eq(i).css('display','block');
                    }
                    $(".isOver").parent().css('display','none');
                    $(".isCollect").parent().css('display','none');
                }else if (data.value == 1) {
                    for(var i=0; i<$(".isCollect").length; i++){
                        $(".isCollect").parent().eq(i).css('display','block');
                    }
                    $(".isOver").parent().css('display','none');
                    $(".notEnable").parent().css('display','none');
                }else if (data.value == 2) {
                    for(var i=0; i<$(".isOver").length; i++){
                        var ac = $(".isOver").parent().eq(i)
                        $(".isOver").parent().eq(i).css('display','block');
                    }
                    $(".notEnable").parent().css('display','none');
                    $(".isCollect").parent().css('display','none');
                }else{
                    $(".notEnable").parent().css('display','block');
                    $(".isCollect").parent().css('display','block');
                    $(".isOver").parent().css('display','block');
                }
            })
            if(typeof($('.select').attr('repTableId')) != 'undefined'){
                tableIns = table.render({
                    elem: '#questionTable'
                    , url: '/repField/getFieldByTableId?tableId=' + $('.select').attr('repTableId')//数据接口
                    , parseData: function (res) { //res 即为原始返回的数据
                        return {
                            "code": 0, //解析接口状态
                            "data": res.object.repFieldList //解析数据列表
                        };
                    }
                    , toolbar: '#toolbar'
                    , cols: [[ //表头
                        {field: 'filedNo', title: '序号'}
                        , {field: 'fieldName',width:130, title: '字段名称'}
                        , {field: 'fieldGroup',width:130, title: '分组名称'}
                        , {
                            field: 'fieldType',width:130, title: '字段类型', templet: function (d) {
                                if (d.fieldType == "1") {
                                    return '单行文本'
                                } else if (d.fieldType == "2") {
                                    return '单行数字'
                                } else if (d.fieldType == "3") {
                                    return '多行文本'
                                } else if (d.fieldType == "4") {
                                    return '日期'
                                } else if (d.fieldType == "5") {
                                    return '单选'
                                } else if (d.fieldType == "6") {
                                    return '多选'
                                }else if (d.fieldType == "7") {
                                    return '附件'
                                }
                            }
                        }
                        , {
                            field: 'isgroup',width:130, title: '分组统计', templet: function (d) {
                                if (d.isgroup == "0") {
                                    return '否'
                                } else if (d.isgroup == "1") {
                                    return '是'
                                }
                            }
                        }
                        , {field: 'fieldDesc',width:130, title: '字段说明'}
                        , {field: 'fieldSize', width:130,title: '字段长度'}
                        , {
                            field: 'ismust',width:130, title: '是否必填', templet: function (d) {
                                if (d.ismust == "0") {
                                    return '非必填'
                                } else if (d.ismust == "1") {
                                    return '必填字段'
                                }
                            }
                        }
                        , {title: '操作',width:180, align: 'center', toolbar: '#barDemo'}

                    ]]
                    // ,limit:10
                    , done: function (res) {


                    }
                });
            }
            if ($('.select').attr('repTableId') == undefined) {
                $('.layui-table-body').hide()
            }

            //监听工具条
            table.on('tool(questionTable-table)', function (obj) { //注：tool 是工具条事件名，test 是 table 原始容器的属性 lay-filter="对应的值"
                var data = obj.data; //获得当前行数据
                var layEvent = obj.event; //获得 lay-event 对应的值（也可以是表头的 event 参数对应的值）
                var tr = obj.tr; //获得当前行 tr 的 DOM 对象（如果有的话）
                var fieldId = data.fieldId   //获取当前行得id
                if (layEvent === 'edit') {
                    $.ajax({
                        url: '/repField/getFieldByFieldId',
                        data: {fieldId: fieldId},
                        dataType: 'json',
                        type: 'get',
                        success: function (res) {
                            $('.fieldContent').val(res.object.fieldContent)
                            form.val("formTest", res.object);
                            $('.Contents').show()
                            if (res.object.fieldType == "5" || res.object.fieldType == "6") {
                                $('.Contents p').html('单选或多选时请用<span style="font-weight: bold">/</span>分割')
                            } else if (res.object.fieldType == "1" || res.object.fieldType == "2" || res.object.fieldType == "3") {
                                $('.Contents p').html('可使用公式：[姓名]、[部门]、[手机号]')
                            } else {
                                $('.Contents').hide();
                            }
                        }
                    })
                    if ($(window).height() < 650) {
                        var width = '650px';
                        var height = '550px';
                    } else {
                        var width = '700px';
                        var height = '650px';
                    }
                    if (mobiletype) {
                        var width = '95%';
                        var height = '90%';
                    }
                    layer.open({
                        type: 1,
                        title: '编辑',
                        // shadeClose: true,
                        btn: ['确定', '取消'],
                        shade: 0.5,
                        maxmin: true, //开启最大化最小化按钮
                        area: [width, height],
                        content: ' <div class="layui-form" style="padding:8px">' +
                        '<form class="layui-form"  id="ajaxforms" lay-filter="formTest" action="">\n' +
                        '<div class="layui-form-item"style="width: 80%;">\n' +
                        '    <label class="layui-form-label">字段排序号:</label>\n' +
                        '    <div class="layui-input-block">\n' +
                        '      <input type="text" name="filedNo" required oninput = "value=value.replace(/[^\\d]/g,\'\')" lay-verify="required" placeholder="请输入字段排序号" autocomplete="off" class="layui-input">\n' +
                        '    </div>\n' +
                        '<p style="margin-left:138px;color:red">此文本框只能输入数字</p>\n' +
                        '  </div>' +
                        '<div class="layui-form-item" style="width: 80%;">\n' +
                        '    <label class="layui-form-label">字段名称:</label>\n' +
                        '    <div class="layui-input-block">\n' +
                        '      <input type="text" id="fieldName" name="fieldName" required  lay-verify="required" placeholder="请输入字段名称" autocomplete="off" class="layui-input">\n' +
                        '    </div>\n' +
                        '  </div>\n' +
                        '<div class="layui-form-item"style="width: 80%;">\n' +
                        '    <label class="layui-form-label">字段分组名称:</label>\n' +
                        '    <div class="layui-input-block">\n' +
                        '      <input type="text" name="fieldGroup" required  lay-verify="required" placeholder="请输入字段分组名称" autocomplete="off" class="layui-input">\n' +
                        '    </div>\n' +
                        '  </div>' +
                        '<div class="layui-form-item"style="width: 80%;">\n' +
                        '    <label class="layui-form-label">字段类型:</label>\n' +
                        '    <div class="layui-input-block">\n' +
                        '<select lay-verify="required" id="fieldType" class="fieldType"  lay-filter="fieldType" name="fieldType">\n' +
                        '   <option value="1" selected>单行文本</option>\n' +
                        '   <option value="2">单行数字</option>\n' +
                        '   <option value="3">多行文本</option>\n' +
                        '   <option value="4">日期</option>\n' +
                        '   <option value="5">单选</option>\n' +
                        '   <option value="6">多选</option>\n' +
                        '   <option value="7">附件</option>\n' +
                        '  </select>\n' +
                        '    </div>\n' +
                        '  </div>' +
                        '<div class="layui-form-item Contents"style="width: 80%;display: none">\n' +
                        '    <label class="layui-form-label">选填内容:</label>\n' +
                        '    <div class="layui-input-block" id="index-div1" >\n' +
                        '      <input type="text" name="fieldContent" required   lay-verify="required" placeholder="请输入选填内容" autocomplete="off" class="layui-input fieldContent">\n' +
                        '    </div>\n' +
                        '<p style="color:red;margin-left:138px;">单选或多选时请用<span style="font-weight: bold">/</span>分割</p>\n' +
                        '  </div>' +
                        '<div class="layui-form-item"style="width: 80%;">\n' +
                        '    <label class="layui-form-label">字段说明:</label>\n' +
                        '    <div class="layui-input-block">\n' +
                        '      <input type="text" name="fieldDesc" required  lay-verify="required" placeholder="请输入字段说明" autocomplete="off" class="layui-input">\n' +
                        '    </div>\n' +
                        '  </div>' +
                        '<div class="layui-form-item"style="width: 80%;">\n' +
                        '    <label class="layui-form-label">字段长度限制:</label>\n' +
                        '    <div class="layui-input-block">\n' +
                        '      <input type="text" name="fieldSize" required oninput = "value=value.replace(/[^\\d]/g,\'\')" lay-verify="required" placeholder="请输入字段长度限制" autocomplete="off" class="layui-input">\n' +
                        '    </div>\n' +
                        '<p style="margin-left:138px;color:red">此文本框只能输入数字</p>\n' +
                        '  </div>' +
                        '<div class="layui-form-item"style="width: 80%;">\n' +
                        '    <label class="layui-form-label">是否必填字段:</label>\n' +
                        '    <div class="layui-input-block">\n' +
                        '      <input type="radio" name="ismust" value="1" title="必填字段" checked="">\n' +
                        '      <input type="radio" name="ismust" value="0" title="非必填">\n' +
                        '    </div>\n' +
                        '  </div>' +
                        '<div class="layui-form-item"style="width: 80%;">\n' +
                        '    <label class="layui-form-label">是否可写字段:</label>\n' +
                        '    <div class="layui-input-block">\n' +
                        '      <input type="radio" name="readonly" value="0" title="可写字段" checked="">\n' +
                        '      <input type="radio" name="readonly" value="1" title="只读字段">\n' +
                        '    </div>\n' +
                        '  </div>' +
                        '<div class="layui-form-item"style="width: 80%;">\n' +
                        '    <label class="layui-form-label">是否分组统计:</label>\n' +
                        '    <div class="layui-input-block">\n' +
                        '      <input type="radio" name="isgroup" value="0" title="否" checked="">\n' +
                        '      <input type="radio" name="isgroup" value="1" title="是">\n' +
                        '    </div>\n' +
                        '  </div>' +
                        '</form>\n' +
                        '</div>',
                        success: function () {
                            form.on('select(fieldType)', function (data) {
                                fieldType = $('.fieldType').val()  //获取下拉框的value值
                                $('.Contents').show()
                                if (fieldType == "5" || fieldType == "6") {
                                    $('.Contents p').html('单选或多选时请用<span style="font-weight: bold">/</span>分割')
                                } else if (fieldType == "1" || fieldType == "2" || fieldType == "3") {
                                    $('.Contents p').html('可使用公式：[姓名]、[部门]、[手机号]')
                                } else {
                                    $('.Contents').hide();
                                }

                            });
                            // $('.ContAdd').on('click',function(){
                            //     var html = ""
                            //     html += '<input type="text" required  lay-verify="required" placeholder="请输入选填内容" autocomplete="off" class="layui-input fieldContent" style="width:350px;margin:6px auto;">';
                            //     $("#index-div1").append(html);
                            // })
                            form.render()
                        },
                        yes: function (index) {
                            // var strs=''
                            // for(var i=0;i<$('.fieldContent').length;i++){
                            //     strs+=$('.fieldContent').eq(i).val()+'/'
                            // }
                            $.ajax({
                                url: '/repField/updateRepField',
                                data: $('#ajaxforms').serialize() + '&fieldId=' + fieldId,
                                dataType: 'json',
                                type: 'get',
                                success: function (res) {
                                    if (res.flag) {
                                        layer.msg('修改成功', {icon: 1});
                                        layer.close(index);
                                        tableIns.reload()
                                    }
                                }
                            })
                        },

                    });
                } else if (layEvent === 'del') {
                    layer.confirm('真的删除该数据吗？', function (index) {
                        $.ajax({
                            url: '/repField/deleteRepField',
                            data: {fieldId: fieldId},
                            dataType: 'json',
                            type: 'get',
                            success: function (res) {
                                if (res.flag) {
                                    layer.msg('删除成功', {icon: 1});
                                    tableIns.reload()
                                }
                            }
                        })
                        layer.close(index);

                    });
                }
            });
            //移动端右侧返回
            $('#backTable').on('click',function () {
                if (mobiletype) {
                    $('.layui-rt').hide();
                    $('.layui-lf ').show();
                }
            });
            //右侧新建
            $('#addTable').on('click',function () {
                var repTableId = $('.select').attr('repTableId')
                if (repTableId == undefined) {
                    layer.msg('请先创建报表!', {icon: 0});
                    return false
                }
                if ($(window).height() < 650) {
                    var width = '650px';
                    var height = '550px';
                } else {
                    var width = '700px';
                    var height = '650px';
                }
                if (mobiletype) {
                    var width = '95%';
                    var height = '90%';
                }
                layer.open({
                    type: 1,
                    title: '新增字段',
                    // shadeClose: true,
                    btn: ['确定', '取消'],
                    shade: 0.5,
                    maxmin: true, //开启最大化最小化按钮
                    area: [width, height],
                    content: ' <div class="layui-form" style="padding:8px">' +
                    '<form class="layui-form"  id="ajaxforms" lay-filter="formTest" action="">\n' +
                    '<div class="layui-form-item"style="width: 80%;">\n' +
                    '    <label class="layui-form-label">字段排序号:</label>\n' +
                    '    <div class="layui-input-block" style="display: flex;line-height: 35px;" >\n' +
                    '      <input type="text" id="filedNo" name="filedNo" required oninput = "value=value.replace(/[^\\d]/g,\'\')" lay-verify="required" placeholder="请输入字段排序号" autocomplete="off" class="layui-input"><span style="color:red">*</span>\n' +
                    '    </div>\n' +
                    '<p style="margin-left:138px;color:red">此文本框只能输入数字</p>\n' +
                    '  </div>' +
                    '<div class="layui-form-item" style="width: 80%;">\n' +
                    '    <label class="layui-form-label">字段名称:</label>\n' +
                    '    <div class="layui-input-block" style="display: flex;line-height: 35px;">\n' +
                    '      <input type="text" id="fieldName" name="fieldName" required  lay-verify="required" placeholder="请输入字段名称" autocomplete="off" class="layui-input"><span style="color:red">*</span>\n' +
                    '    </div>\n' +
                    '  </div>\n' +
                    '<div class="layui-form-item"style="width: 80%;">\n' +
                    '    <label class="layui-form-label">字段分组名称:</label>\n' +
                    '    <div class="layui-input-block">\n' +
                    '      <input type="text" name="fieldGroup" required  lay-verify="required" placeholder="请输入字段分组名称" autocomplete="off" class="layui-input">\n' +
                    '    </div>\n' +
                    '  </div>' +
                    '<div class="layui-form-item" style="width: 80%;">\n' +
                    '    <label class="layui-form-label">字段类型:</label>\n' +
                    '    <div class="layui-input-block" style="display: flex;line-height: 35px;">\n' +
                    '<select lay-verify="required" id="fieldType" class="fieldType"  lay-filter="fieldType" name="fieldType">\n' +
                    '   <option value="1" selected>单行文本</option>\n' +
                    '   <option value="2">单行数字</option>\n' +
                    '   <option value="3">多行文本</option>\n' +
                    '   <option value="4">日期</option>\n' +
                    '   <option value="5">单选</option>\n' +
                    '   <option value="6">多选</option>\n' +
                    '   <option value="7">附件</option>\n' +
                    '  </select>\n' +
                        '<div style="color:red">*</div>' +
                    '    </div>' +
                    '  </div>' +
                    '<div class="layui-form-item Contents"style="width: 80%;display: none">\n' +
                    '    <label class="layui-form-label">选填内容:</label>\n' +
                    '    <div class="layui-input-block"  style="display: flex;line-height: 35px;" id="index-div1">\n' +
                    '      <input type="text" id="fieldContent" name="fieldContent" required   lay-verify="required" placeholder="请输入选填内容" autocomplete="off" class="layui-input fieldContent">\n' +
                    '    </div>\n' +
                    '<p style="color:red;margin-left:138px;">单选或多选时请用<span style="font-weight: bold">/</span>分割</p>\n' +
                    '  </div>' +
                    '<div class="layui-form-item"style="width: 80%;">\n' +
                    '    <label class="layui-form-label">字段说明:</label>\n' +
                    '    <div class="layui-input-block">\n' +
                    '      <input type="text" name="fieldDesc" required  lay-verify="required" placeholder="请输入字段说明" autocomplete="off" class="layui-input">\n' +
                    '    </div>\n' +
                    '  </div>' +
                    '<div class="layui-form-item"style="width: 80%;">\n' +
                    '    <label class="layui-form-label">字段长度限制:</label>\n' +
                    '    <div class="layui-input-block" style="display: flex;line-height: 35px">\n' +
                    '      <input type="text" id="fieldSize" name="fieldSize" required oninput = "value=value.replace(/[^\\d]/g,\'\')" lay-verify="required" placeholder="请输入字段长度限制" autocomplete="off" class="layui-input">\n' +
                    '    </div>\n' +
                    '<p style="margin-left:138px;color:red">此文本框只能输入数字</p>\n' +
                    '  </div>' +
                    '<div class="layui-form-item"style="width: 80%;">\n' +
                    '    <label class="layui-form-label">是否必填字段:</label>\n' +
                    '    <div class="layui-input-block">\n' +
                    '      <input type="radio" name="ismust" value="1" title="必填字段" checked="">\n' +
                    '      <input type="radio" name="ismust" value="0" title="非必填">\n' +
                    '    </div>\n' +
                    '  </div>' +
                    '<div class="layui-form-item"style="width: 80%;">\n' +
                    '    <label class="layui-form-label">是否可写字段:</label>\n' +
                    '    <div class="layui-input-block">\n' +
                    '      <input type="radio" name="readonly" value="0" title="可写字段" checked="">\n' +
                    '      <input type="radio" name="readonly" value="1" title="只读字段">\n' +
                    '    </div>\n' +
                    '  </div>' +
                    '<div class="layui-form-item"style="width: 80%;">\n' +
                    '    <label class="layui-form-label">是否分组统计:</label>\n' +
                    '    <div class="layui-input-block">\n' +
                    '      <input type="radio" name="isgroup" value="0" title="否" checked="">\n' +
                    '      <input type="radio" name="isgroup" value="1" title="是">\n' +
                    '    </div>\n' +
                    '  </div>' +
                    '</form>\n' +
                    '</div>',
                    success: function (res) {
                        form.on('select(fieldType)', function (data) {
                            fieldType = $('.fieldType').val()  //获取下拉框的value值
                            $('.Contents').show()
                            if (fieldType == "5" || fieldType == "6") {
                                $('.Contents p').html('单选或多选时请用<span style="font-weight: bold">/</span>分割')
                            } else if (fieldType == "1" || fieldType == "2" || fieldType == "3") {
                                $('.Contents p').html('可使用公式：[姓名]、[部门]、[手机号]')
                            } else {
                                $('.Contents').hide();
                            }
                        });
                        // $('.ContAdd').on('click',function(){
                        //     var html = ""
                        //     html += '<input type="text" required  lay-verify="required" placeholder="请输入选填内容" autocomplete="off" class="layui-input fieldContent" style="width:350px;margin:6px auto;">';
                        //     $("#index-div1").append(html);
                        // })

                        form.render()
                    },
                    yes: function (index) {
                        if($('#filedNo').val()==''){
                        layer.msg('字段排序号不能为空', { icon:6});
                        return false;
                    }
                        if($('#fieldName').val()==''){
                            layer.msg('字段名称不能为空', { icon:6});
                            return false;
                        }
                        if($('#fieldType').val()==''){
                            layer.msg('字段类型不能为空', { icon:6});
                            return false;
                        }

                        var strs = ''
                        for (var i = 0; i < $('.fieldContent').length; i++) {
                            strs += $('.fieldContent').eq(i).val() + '/'
                        }
                        $.ajax({
                            url: '/repField/inserRepField',
                            data: $('#ajaxforms').serialize() + '&repTableId=' + repTableId,
                            dataType: 'json',
                            type: 'get',
                            success: function (res) {
                                if (res.flag) {
                                    layer.msg('新建成功', {icon: 1});
                                    layer.close(index);
                                    tableIns.reload()
                                }
                            }
                        })
                    },
                    cancel: function (index) {

                    }
                });
            })

            //右侧的报表导入字段
            $('#import').on('click',function () {
                var repTableId = $('.select').attr('repTableId');
                Import(repTableId);
            })
            //导入
            function Import(data) {
                layer.open({
                    type: 1,
                    area: ['531px', '372px'], //宽高
                    title: '导入',
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
                    '      <button type="button" class="layui-btn layui-btn-sm" id="test1">\n' +
                    '       <i class="layui-icon">&#xe67c;</i>上传文件\n' +
                    '       </button>' +
                    '    </div>\n' +
                    '    <div class="layui-form-mid layui-word-aux" id="textfilter">未选择文件</div>\n' +
                    '  </div>' +
                    '  <div class="layui-form-item">\n' +
                    '    <label class="layui-form-label" style="width: 30%;">格式说明：</label>\n' +
                    '    <div class="layui-form-mid layui-word-aux">1.导入数据源只支持xls格式</div>\n' +
                    '  </div>' +
                    '</form>' +
                    '</div>',
                    success: function () {
                        $('#load').on('click',function () {
                            window.location.href = "/ui/file/dataReport/数据报表字段导入模板.xlsx"
                        })
                        //执行实例
                        var uploadInst = upload.render({
                            elem: '#test1' //绑定元素
                            , url: '/repField/importField?repTableId=' + data //上传接口
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
                                $.each(res.object, function (key, value) {
                                    str += key + '->' + value + '\n'
                                });
                                if(res.flag==false){
                                    $.layerMsg({content: '导入失败！字段名称、是否必填、是否分组统计不能为空！', icon: 0}, function () {
                                    })
                                    return false;
                                }else if(str == '') {
                                    layer.msg("导入成功");
                                    table.reload('questionTable', {
                                        url: '/repField/getFieldByTableId',
                                        where: {
                                            tableId: data
                                        }
                                    })
                                } else {
                                    alert(str)
                                }
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

            // 右侧的报表预览
            $('#previewReport').on('click',function () {
                var repTableId = $('.select').attr('repTableId');
                if (repTableId == undefined) {
                    layer.msg('请先创建报表!', {icon: 0});
                    return false
                }
                layer.open({
                    type: 1,
                    title: '预览报表    ',
                    btn: ['取消'],
                    shade: 0.5,
                    maxmin: true, //开启最大化最小化按钮
                    area: ['75%', '90%'],
                    content: ' <div class="layui-form" id="report">' +
                    '</div>',
                    success: function () {
                        // console.log($(window).width())
                        if ($(window).width() < 768) {
                            $('.layui-layer').width('90%')
                            $('.layui-layer').css('left', '20px')
                        } else if ($(window).width() >= 768 && $(window).width() <= 992) {
                            $('.layui-layer').width('80%')
                        } else if ($(window).width() >= 992 && $(window).width() <= 1200) {
                            $('.layui-layer').width('70%')
                        } else if ($(window).width() >= 1200) {
                            $('.layui-layer').width('60%')
                            $('.layui-layer').css('left', '300px')
                        }
                        $.ajax({
                            url: '/repField/getFieldByTableId?tableId=' + $('.select').attr('repTableId'),
                            type: 'get',
                            dataType: 'json',
                            success: function (res) {
                                var data = res.object.repFieldList
                                $('#report').attr('repTableId', res.object.repTableId)
                                for (var i = 0; i < data.length; i++) {
                                    if (data[i].fieldType == 1) { //单行文本
                                        var item1 = ''
                                        item1 += ' <div class="itemTotal">\n' +
                                            ' <div class="item1"><span class="num">' + [i + 1] + '</span><span class="fieldName">' + data[i].fieldName + '</span><span class="required">' + function () {
                                                if (data[i].ismust == 1) {
                                                    return '(必填)'
                                                } else {
                                                    return ''
                                                }
                                            }() + '</span></div>\n' +
                                            '<div class="fieldDesc">' + data[i].fieldDesc + '</div>' +
                                            ' <div class="item2"><input ismust="' + data[i].ismust + '" fieldType="' + data[i].fieldType + '" fieldName="' + data[i].fieldName + '" fieldId="' + data[i].fieldId + '"  fieldSize="' + data[i].fieldSize + '" type="text" name="' + data[i].fieldName + '" required  lay-verify="required"   autocomplete="off" class="layui-input fieldSize fieldId fieldType ismust"></div>\n' +
                                            '            </div>'
                                        $('#report').append(item1)
                                    }
                                    if (data[i].fieldType == 2) { //单行数字
                                        var item2 = ''
                                        item2 += ' <div class="itemTotal">\n' +
                                            ' <div class="item1"><span class="num">' + [i + 1] + '</span><span class="fieldName">' + data[i].fieldName + '</span><span class="required">' + function () {
                                                if (data[i].ismust == 1) {
                                                    return '(必填)'
                                                } else {
                                                    return ''
                                                }
                                            }() + '</span></div>\n' +
                                            '<div class="fieldDesc">' +
                                            function () {
                                                if (data[i].fieldDesc == undefined || data[i].fieldDesc == '') {
                                                    return '<span  style="color: red;">要求为数字</span>'
                                                } else {
                                                    return data[i].fieldDesc + '<span style="color: red;margin-left: 10px;">要求为数字</span>'

                                                }
                                            }()
                                            + '</div>' +
                                            ' <div class="item2">' +
                                            function () {
                                                /*if((data[i].fieldName=='人员总数')&& res.object.repTableId==1){
                                                 return  '<input oninput = "value=value.replace(/[^\\d{1,}\\.\\d{1,}|\\d{1,}]/g,\'\')" ismust="'+data[i].ismust+'" fieldType="'+data[i].fieldType+'" fieldName="'+data[i].fieldName+'" fieldId="'+data[i].fieldId+'"  fieldSize="'+data[i].fieldSize+'" type="text" name="title" required  lay-verify="required"  autocomplete="off" class="layui-input fieldSize fieldId  ismust  pepleTotal testNum">'
                                                 }else if((data[i].fieldName=='在沪人员：核查人数'|| data[i].fieldName=='在湖北：核查人数'|| data[i].fieldName=='在其它地区：核查人数'|| data[i].fieldName=='返校途中：核查人数'|| data[i].fieldName=='失联人数')&& res.object.repTableId==1){
                                                 return  '<input oninput = "value=value.replace(/[^\\d{1,}\\.\\d{1,}|\\d{1,}]/g,\'\')" ismust="'+data[i].ismust+'" fieldType="'+data[i].fieldType+'" fieldName="'+data[i].fieldName+'" fieldId="'+data[i].fieldId+'"  fieldSize="'+data[i].fieldSize+'" type="text" name="title" required  lay-verify="required"  autocomplete="off" class="layui-input fieldSize fieldId  ismust  pepleNum testNum">'
                                                 }
                                                 else{
                                                 return  '<input oninput = "value=value.replace(/[^\\d{1,}\\.\\d{1,}|\\d{1,}]/g,\'\')" ismust="'+data[i].ismust+'" fieldType="'+data[i].fieldType+'" fieldName="'+data[i].fieldName+'" fieldId="'+data[i].fieldId+'"  fieldSize="'+data[i].fieldSize+'" type="text" name="title" required  lay-verify="required"  autocomplete="off" class="layui-input fieldSize fieldId  ismust testNum ">'
                                                 }*/
                                                return '<input oninput = "value=value.replace(/[^\\d{1,}\\.\\d{1,}|\\d{1,}]/g,\'\')" ismust="' + data[i].ismust + '" fieldType="' + data[i].fieldType + '" fieldName="' + data[i].fieldName + '" fieldId="' + data[i].fieldId + '"  fieldSize="' + data[i].fieldSize + '" type="text" name="title" required  lay-verify="required"  autocomplete="off" class="layui-input fieldSize fieldId  ismust testNum ">'
                                            }() +
                                            '</div>\n' +
                                            '            </div>'
                                        $('#report').append(item2)
                                    }
                                    if (data[i].fieldType == 3) { //多行文本
                                        var item3 = ''
                                        item3 += ' <div class="itemTotal">\n' +
                                            ' <div class="item1"><span class="num">' + [i + 1] + '</span><span class="fieldName">' + data[i].fieldName + '</span><span class="required">' + function () {
                                                if (data[i].ismust == 1) {
                                                    return '(必填)'
                                                } else {
                                                    return ''
                                                }
                                            }() + '</span></div>\n' +
                                            '<div class="fieldDesc">' + data[i].fieldDesc + '</div>' +
                                            ' <div class="item2"><textarea ismust="' + data[i].ismust + '" fieldType="' + data[i].fieldType + '" fieldName="' + data[i].fieldName + '" fieldId="' + data[i].fieldId + '"  fieldSize="' + data[i].fieldSize + '"  name="desc"  class="layui-textarea fieldSize fieldId fieldType ismust"></textarea></div>\n' +
                                            '            </div>'
                                        $('#report').append(item3)
                                    }
                                    if (data[i].fieldType == 4) { //日期
                                        var item4 = ''
                                        item4 += ' <div class="itemTotal">\n' +
                                            ' <div class="item1"><span class="num">' + [i + 1] + '</span><span class="fieldName">' + data[i].fieldName + '</span><span class="required">' + function () {
                                                if (data[i].ismust == 1) {
                                                    return '(必填)'
                                                } else {
                                                    return ''
                                                }
                                            }() + '</span></div>\n' +
                                            '<div class="fieldDesc">' + data[i].fieldDesc + '</div>' +
                                            ' <div class="item2"><input ismust="' + data[i].ismust + '"  fieldName="' + data[i].fieldName + '" fieldId="' + data[i].fieldId + '" type="text" class="layui-input fieldId ismust" id="test' + [i] + '"></div>\n' +
                                            '            </div>'
                                        $('#report').append(item4)
                                        //执行一个laydate实例
                                        laydate.render({
                                            elem: '#test' + [i]//指定元素
                                        });
                                    }
                                    if (data[i].fieldType == 5) { //单选
                                        var item5 = ''
                                        item5 += ' <div class="itemTotal">\n' +
                                            ' <div class="item1"><span class="num">' + [i + 1] + '</span><span class="fieldName">' + data[i].fieldName + '</span><span class="required">' + function () {
                                                if (data[i].ismust == 1) {
                                                    return '(必填)'
                                                } else {
                                                    return ''
                                                }
                                            }() + '</span></div>\n' +
                                            '<div class="fieldDesc">' + data[i].fieldDesc + '</div>' +
                                            ' <div class="item2 radio" ismust="' + data[i].ismust + '" fieldName="' + data[i].fieldName + '" > ' +
                                            function () {
                                                var arr = data[i].fieldContent.split('/')
                                                var str = ''
                                                for (var k = 0; k < arr.length; k++) {
                                                    str += '<div><input fieldId="' + data[i].fieldId + '" type="radio" name="' + data[i].fieldId + '" value="' + arr[k] + '" title="' + arr[k] + '" ></div>'
                                                }
                                                return str
                                            }() +
                                            ' </div>'
                                        $('#report').append(item5)
                                        form.render('radio')
                                    }
                                    if (data[i].fieldType == 6) { //多选
                                        var item6 = ''
                                        item6 += ' <div class="itemTotal">\n' +
                                            ' <div class="item1"><span class="num">' + [i + 1] + '</span><span class="fieldName">' + data[i].fieldName + '</span><span class="required">' + function () {
                                                if (data[i].ismust == 1) {
                                                    return '(必填)'
                                                } else {
                                                    return ''
                                                }
                                            }() + '</span></div>\n' +
                                            '<div class="fieldDesc">' + data[i].fieldDesc + '</div>' +
                                            ' <div class="item2 checkbox" ismust="' + data[i].ismust + '" fieldName="' + data[i].fieldName + '" > \n' +
                                            function () {
                                                var arr = data[i].fieldContent.split('/')
                                                var str = ''
                                                for (var k = 0; k < arr.length; k++) {
                                                    str += '<div style="margin: 5px 0px;"><input lay-skin="primary" fieldId="' + data[i].fieldId + '" type="checkbox" name="" value="' + arr[k] + '" title="' + arr[k] + '" ></div>'
                                                }
                                                return str
                                            }() +
                                            '    </div>\n' +
                                            '            </div>'
                                        $('#report').append(item6)
                                        form.render('checkbox')
                                    }
                                    if (data[i].fieldType == 7) { //附件
                                        var item7 = ''
                                        item7 += ' <div class="itemTotal">\n' +
                                            ' <div class="item1"><span class="num">' + [i + 1] + '</span><span class="fieldName">' + data[i].fieldName + '</span><span class="required">' + function () {
                                                if (data[i].ismust == 1) {
                                                    return '(必填)'
                                                } else {
                                                    return ''
                                                }
                                            }() + '</span></div>\n' +
                                            ' <div class="item2" ismust="' + data[i].ismust + '" fieldName="' + data[i].fieldName + '" > \n' +
                                            function () {
                                                return '<input  ismust="' + data[i].ismust + '" fieldType="' + data[i].fieldType + '" fieldName="' + data[i].fieldName + '" fieldId="' + data[i].fieldId + '"  fieldSize="' + data[i].fieldSize + '" type="text" name="title" required  lay-verify="required"  autocomplete="off" class="layui-input">'
                                            }() +
                                            '    </div>\n' +
                                            '            </div>'
                                        $('#report').append(item7)
                                        form.render('checkbox')
                                    }
                                }
                                addNumBtn();
                            }

                        })

                    },
                });
            })


        })
    }
    $(function () {
        setTimeout(x, 330);
    })
    $(function () {
        $(function () {
            $("#LAY-app-message").hide()
        })
        function showmsg(){
            $("#LAY-app-message").show();
        }
        $(function (){
            window.setInterval(showmsg,300)
        })
    })

    //判断参数是否为un\
    function IsUndefined(item){
        if (item != undefined){
            return item;
        }
        return '';
    }

</script>
</body>
</html>
