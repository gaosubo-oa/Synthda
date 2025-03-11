<%--
  Created by IntelliJ IDEA.
  User: 戎成路
  Date: 2020/5/4
  Time: 10:36
  To change this template use File | Settings | File Templates.
--%>
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
    <title>部门计划执行审批</title>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">

    <link rel="stylesheet" type="text/css" href="/lib/layui/layui/css/layui.css?20210319.1"/>

    <script type="text/javascript" src="/js/xoajq/xoajq1.js"></script>
    <script type="text/javascript" src="/js/base/base.js"></script>
    <script type="text/javascript" src="/lib/layui/layui/layui.js"></script>
    <script type="text/javascript" src="/lib/layui/layui/layui.all.js"></script>

    <style>
        html {
            width: 100%;
            height: 100%;
            background: #fff;
        }

        html, body {
            user-select: none;
        }

        /*伪元素是行内元素 正常浏览器清除浮动方法*/
        .clearfix:after {
            content: "";
            display: block;
            height: 0;
            clear: both;
            visibility: hidden;
        }

        .clearfix {
            *zoom: 1; /*ie6清除浮动的方式 *号只有IE6-IE7执行，其他浏览器不执行*/
        }

        .container {
            position: relative;
            width: 100%;
            height: 100%;
        }

        .content {
            padding: 0 30px;
        }

        .layui-form-label {
            width: 130px;
        }

        .layui-input-block {
            margin-left: 160px;
        }

        .dept_input, .user_input {
            background-color: #ccc;
        }

        .select_input {
            width: 60% !important;
        }

        .disabled {
            border: none;
            background-color: #fff !important;
        }

        .choose_disabled {
            display: none;
        }

        .layui-select-disabled .layui-disabled {
            border: none;
            cursor: default !important;
            color: #222 !important;
        }

        .layui-select-disabled .layui-edge {
            display: none;
        }
        .deImgs {
            display: none;
        }

        #resultFiles a {
            color: #0A5FA2;
        }
        .query .layui-form-item{
            width: 19%;
            margin:7px 0px 0px 5px
        }
        .query .layui-form-label{
            width: 60px;
        }
        .query .layui-input-block{
            margin-left: 90px;
        }
        .query .layui-input-block{
            margin-left: 90px;
        }
        .query .layui-input-block input{
            height: 35px;
        }
    </style>

</head>
<body>
<div class="container">
    <div class="header">
        <div class="headImg" style="padding-top: 10px">
					<span style="font-size:22px;margin-left:10px;color:#494d59;margin-top: 2px"><img
                            style="margin-left:1.5%" src="../img/commonTheme/theme6/icon_summary.png" alt=""><span
                            style="margin-left: 10px">计划执行审核</span></span>
        </div>
    </div>
    <hr>
    <%--筛选查询--%>
    <div class="query" style="display: flex">
        <div class="layui-form-item">
            <label class="layui-form-label">年度</label>
            <div class="layui-input-block">
                <input type="text" name="title" id="date" required  lay-verify="required" autocomplete="off" class="layui-input">
            </div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label">月度</label>
            <div class="layui-input-block">
                <input type="text" name="title" id="month" required  lay-verify="required" autocomplete="off" class="layui-input">
            </div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label">责任人</label>
            <div class="layui-input-block">
                <input type="text" name="title" required  lay-verify="required" autocomplete="off" class="layui-input">
            </div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label">所属部门</label>
            <div class="layui-input-block">
                <input type="text" name="title" required  lay-verify="required" autocomplete="off" class="layui-input">
            </div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label">计划类型</label>
            <div class="layui-input-block">
                <input type="text" name="title" required  lay-verify="required" autocomplete="off" class="layui-input">
            </div>
        </div>
    </div>
    <div class="query" style="display: flex">
        <div class="layui-form-item">
            <label class="layui-form-label">关键任务类型</label>
            <div class="layui-input-block">
                <input type="text" name="title" required  lay-verify="required" autocomplete="off" class="layui-input">
            </div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label">关键任务状态</label>
            <div class="layui-input-block">
                <input type="text" name="title" required  lay-verify="required" autocomplete="off" class="layui-input">
            </div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label">子任务状态</label>
            <div class="layui-input-block">
                <input type="text" name="title" required  lay-verify="required" autocomplete="off" class="layui-input">
            </div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label">责任类型</label>
            <div class="layui-input-block">
                <input type="text" name="title" required  lay-verify="required" autocomplete="off" class="layui-input">
            </div>
        </div>
        <button type="button" class="layui-btn  layui-btn-sm" style="margin-left: 30px;margin-top: 10px">查询</button>
    </div>
    <div class="content">
        <table id="tableList" lay-filter="tableList"></table>
    </div>
</div>

<%-- 子任务工具条 --%>
<script type="text/html" id="taskBar">
    <a class="layui-btn layui-btn-xs" lay-event="detail">查看</a>
    <a class="layui-btn layui-btn-xs" lay-event="check">审批</a>
</script>
<script type="text/html" id="toolbarDemo">
    <div class="layui-btn-container" style="float: right;margin-right: -133px;">
        <button type="button" class="layui-btn layui-btn-sm" lay-event="detail">查看</button>
        <button type="button" class="layui-btn layui-btn-sm" lay-event="check">审批</button>
    </div>
</script>
<script>

    var dictionaryObj = {
        PLAN_TYPE: {},
        PLAN_PHASE: {},
        PLAN_RATE: {},
        PLAN_LEVEL: {},
        CONTROL_LEVEL: {},
        ACCORDING: {},
        PLAN_SYCLE: {},
        TASK_TYPE: {}
    }
    var dictionaryStr = 'PLAN_TYPE,PLAN_PHASE,PLAN_RATE,PLAN_LEVEL,CONTROL_LEVEL,ACCORDING,PLAN_SYCLE,TASK_TYPE'

    // 获取数据字典数据
    $.get('/Dictonary/selectDictionaryByDictNos', {dictNos: dictionaryStr}, function (res) {
        if (res.flag) {
            for (var dict in dictionaryObj) {
                dictionaryObj[dict] = {object: {}, str: ''}
                if (res.object[dict]) {
                    res.object[dict].forEach(function (item) {
                        dictionaryObj[dict]['object'][item.dictNo] = item.dictName
                        dictionaryObj[dict]['str'] += '<option value=' + item.dictNo + '>' + item.dictName + '</option>'
                    })
                }
            }
        }
    })

    layui.use(['table', 'layer', 'form', 'element', 'laydate', 'upload'], function () {
        var table = layui.table,
            form = layui.form,
            layer = layui.layer,
            laydate = layui.laydate,
            upload = layui.upload,
            element = layui.element;
        //日期
        laydate.render({
            elem: '#date',
            type:'year'
        });
        laydate.render({
            elem: '#month',
            type:'month'
        });

        var tableList = table.render({
            elem: '#tableList',
            url: '/plcProjectItem/query',
            toolbar: '#toolbarDemo',//开启头部工具栏
            defaultToolbar: [],
            page: true,
            cols: [[ //表头
                {type:'checkbox'}
                ,{field: 'taskNo', title: '子任务编码', minWidth: 90}
                , {field: 'taskName', title: '子任务名称', minWidth: 90}
                , {field: 'dutyUserName', title: '责任人', minWidth: 90}
                , {field: 'assistUserName', title: '协作人(多人)', minWidth: 110}
                , {field: 'mainCenterDeptName', title: '所属部门', minWidth: 120}
                , {field: 'mainAreaDeptName', title: '一级监督部门', minWidth: 120}
                , {field: 'mainProjectDeptName', title: '二级监督部门', minWidth: 120}
                , {field: 'assistCompanyDeptsName', title: '协助部门', minWidth: 120}
                , {
                    field: 'planType', title: '计划类型', minWidth: 90, templet: function (d) {
                        var object = dictionaryObj['PLAN_TYPE']['object']
                        return object[d.planType] ? object[d.planType] : ''
                    }
                }
                , {
                    field: 'planStage', title: '计划阶段', minWidth: 90, templet: function (d) {
                        var object = dictionaryObj['PLAN_PHASE']['object']
                        return object[d.planStage] ? object[d.planStage] : ''
                    }
                }
                , {
                    field: 'planRate', title: '计划形式', minWidth: 90, templet: function (d) {
                        var object = dictionaryObj['PLAN_RATE']['object']
                        return object[d.planRate] ? object[d.planRate] : ''
                    }
                }
                , {
                    field: 'planLevel', title: '计划级次', minWidth: 90, templet: function (d) {
                        var object = dictionaryObj['PLAN_LEVEL']['object']
                        return object[d.planLevel] ? object[d.planLevel] : ''
                    }
                }, {
                    field: 'controlLevel', title: '关注等级', minWidth: 90, templet: function (d) {
                        var object = dictionaryObj['CONTROL_LEVEL']['object']
                        return object[d.controlLevel] ? object[d.controlLevel] : ''
                    }
                }
                , {
                    field: 'according', title: '工作项依据', minWidth: 100, templet: function (d) {
                        var object = dictionaryObj['ACCORDING']['object']
                        return object[d.according] ? object[d.according] : ''
                    }
                }
                , {
                    field: 'isKeypoint', title: '是否关键工作项', minWidth: 130, templet: function (d) {
                        if (d.isKeypoint == 0) {
                            return '否'
                        } else if (d.isKeypoint == 1) {
                            return '是'
                        }
                    }
                }
                , {
                    field: 'isResult', title: '是否提交成果', minWidth: 120, templet: function (d) {
                        if (d.isResult == 0) {
                            return '否'
                        } else if (d.isResult == 1) {
                            return '是'
                        }
                    }
                }
                , {
                    field: 'planSycle', title: '周期类型', minWidth: 90, templet: function (d) {
                        var object = dictionaryObj['PLAN_SYCLE']['object']
                        return object[d.planSycle] ? object[d.planSycle] : ''
                    }
                }
                , {
                    field: 'planStartDate', title: '计划开始时间', minWidth: 120, templet: function (d) {
                        return format(d.planStartDate)
                    }
                }
                , {
                    field: 'planEndDate', title: '计划完成时间', minWidth: 120, templet: function (d) {
                        return format(d.planEndDate)
                    }
                }
                , {field: 'planContinuedDate', title: '计划工期', minWidth: 90}
                , {
                    field: 'realStartDate', title: '实际开始时间', minWidth: 120, templet: function (d) {
                        return format(d.realStartDate)
                    }
                }
                , {
                    field: 'realEndDate', title: '实际完成时间', minWidth: 120, templet: function (d) {
                        return format(d.realEndDate)
                    }
                }
                , {field: 'realContinuedDate', title: '实际工期', minWidth: 90}
                , {field: 'standardDegree', title: '标准难度系数', minWidth: 90}
                , {field: 'hardDegree', title: '难度系数', minWidth: 90}
                , {field: 'resultConfirm', title: '成果确认', minWidth: 90}
                , {field: 'resultDesc', title: '成果描述', minWidth: 90}
                , {field: 'finalResultDesc', title: '最终交付成果描述', minWidth: 150}
                , {field: 'unusualRes', title: '异常原因', minWidth: 90}
                , {field: 'unusualStuff', title: '异常支撑材料', minWidth: 120}
                , {field: 'qualityScore', title: '质量得分', minWidth: 90}
                , {field: 'taskStatus', title: '子任务状态', minWidth: 90}
                , {field: 'taskPrecess', title: '子任务进度', minWidth: 90}
                , {
                    field: 'taskType', title: '子任务类型', minWidth: 90, templet: function (d) {
                        var object = dictionaryObj['TASK_TYPE']['object']
                        return object[d.taskType] ? object[d.taskType] : ''
                    }
                }
                , {field: 'taskDesc', title: '子任务说明', minWidth: 90}
                , {field: 'riskPoint', title: '风险点', minWidth: 80}
                , {field: 'difficultPoint', title: '难度点', minWidth: 80}
                , {field: 'endScore', title: '单项得分', minWidth: 90}
                , {field: 'itemQuantity', title: '工程量', minWidth: 90}
                , {field: 'itemQuantityNuit', title: '工程量单位', minWidth: 110}
                // , {fixed: 'right', title: '操作', align: 'center', toolbar: '#taskBar', minWidth: 170}
            ]],
            where: { // 默认查询已提交审核和进度100的
                isExam: 1,
                taskPrecess: 100,
                useFlag: true,
                time: new Date().getTime()
            },
            request: {
                limitName: 'pageSize'
            },
            response: {
                statusName: 'flag',
                statusCode: true,
                dataName: 'obj',
                countName: 'totleNum'
            }
        })

        // 监听-子任务表格-工具条
        table.on('tool(tableList)', function (obj) {
            var tData = obj.data;
            var layEvent = obj.event;
            if (layEvent === 'detail') {
                creatTask(tData)
            } else if (layEvent === 'check') {

                var checkIndex = layer.open({
                    type: 1,
                    title: false,
                    area: ['600px', '80%'],
                    btn: ['确认', '取消'],
                    btnAlign: 'c',
                    content: '<div id="checkModule">\n' +
                        '\t\t\t<p style="padding: 10px 20px; font-size: 16px; background-color: #f2f2f2;">提交成果</p>\n' +
                        '\t\t\t<hr class="layui-bg-green" style="margin-top: 0;">\n' +
                        '\t\t\t<div class="layui-form" id="resulForm" lay-filter="resulForm" style="padding-right: 30px;">\n' +
                        '\t\t\t\t<div class="layui-form-item">\n' +
                        '\t\t\t\t\t<label class="layui-form-label">子任务/关键任务名称:</label>\n' +
                        '\t\t\t\t\t<div class="layui-input-block">\n' +
                        '\t\t\t\t\t\t<input type="text" style="border: none; line-height: 38px;" readonly name="taskName" autocomplete="off" class="layui-input">\n' +
                        '\t\t\t\t\t</div>\n' +
                        '\t\t\t\t</div>\n' +
                        '\t\t\t\t<div class="layui-form-item">\n' +
                        '\t\t\t\t\t<label class="layui-form-label">标准难度系数:</label>\n' +
                        '\t\t\t\t\t<div class="layui-input-block">\n' +
                        '\t\t\t\t\t\t<input type="text" style="border: none; line-height: 38px;" readonly name="standardDegree" autocomplete="off" class="layui-input">\n' +
                        '\t\t\t\t\t</div>\n' +
                        '\t\t\t\t</div>\n' +
                        '\t\t\t\t<div class="layui-form-item">\n' +
                        '\t\t\t\t\t<label class="layui-form-label">完成标准及提交成果:</label>\n' +
                        '\t\t\t\t\t<div class="layui-input-block">\n' +
                        '\t\t\t\t\t\t<input type="text" style="border: none; line-height: 38px;" readonly name="finalResultDesc" autocomplete="off" class="layui-input">\n' +
                        '<%--\t\t\t\t\t\t<textarea readonly style="border: none; line-height: 38px; padding: 0 0 0 10px;resize: none;" name="finalResultDesc" class="layui-textarea"></textarea>--%>\n' +
                        '\t\t\t\t\t</div>\n' +
                        '\t\t\t\t</div>\n' +
                        '\t\t\t\t<div class="layui-form-item">\n' +
                        '\t\t\t\t\t<label class="layui-form-label">提交成果:</label>\n' +
                        '\t\t\t\t\t<div class="layui-input-block">\n' +
                        '\t\t\t\t\t\t<div id="resultFiles" style="padding: 9px 0 0 10px;"></div>\n' +
                        '\t\t\t\t\t</div>\n' +
                        '\t\t\t\t</div>\n' +
                        '\t\t\t\t<div class="layui-form-item">\n' +
                        '\t\t\t\t\t<label class="layui-form-label">完成进度:</label>\n' +
                        '\t\t\t\t\t<div class="layui-input-block">\n' +
                        '\t\t\t\t\t\t<input type="text" readonly style="border: none; line-height: 38px;" name="taskPrecess" autocomplete="off" class="layui-input">\n' +
                        '\t\t\t\t\t</div>\n' +
                        '\t\t\t\t</div>\n' +
                        '\t\t\t</div>\n' +
                        '\t\t\t<p style="padding: 10px 20px; font-size: 16px; background-color: #f2f2f2;">成果确认</p>\n' +
                        '\t\t\t<hr class="layui-bg-green" style="margin-top: 0;">\n' +
                        '\t\t\t<div class="layui-form" id="resultCheckForm" lay-filter="resultCheckForm" style="padding-right: 30px;">\n' +
                        '\t\t\t\t<div class="layui-form-item">\n' +
                        '\t\t\t\t\t<label class="layui-form-label">难度系数:</label>\n' +
                        '\t\t\t\t\t<div class="layui-input-block">\n' +
                        '\t\t\t\t\t\t<input type="text" style="line-height: 38px;" name="hardDegree" autocomplete="off" class="layui-input number_input">\n' +
                        '\t\t\t\t\t</div>\n' +
                        '\t\t\t\t</div>\n' +
                        '\t\t\t\t<div class="layui-form-item">\n' +
                        '\t\t\t\t\t<label class="layui-form-label">完成度:</label>\n' +
                        '\t\t\t\t\t<div class="layui-input-block">\n' +
                        '\t\t\t\t\t\t<input type="text" style="line-height: 38px;" name="taskPrecess" autocomplete="off" class="layui-input number_input">\n' +
                        '\t\t\t\t\t</div>\n' +
                        '\t\t\t\t</div>\n' +
                        '\t\t\t\t<div class="layui-form-item">\n' +
                        '\t\t\t\t\t<label class="layui-form-label">质量得分:</label>\n' +
                        '\t\t\t\t\t<div class="layui-input-block">\n' +
                        '\t\t\t\t\t\t<input type="text" style="line-height: 38px;" name="qualityScore" autocomplete="off" class="layui-input number_input">\n' +
                        '\t\t\t\t\t</div>\n' +
                        '\t\t\t\t</div>\n' +
                        '\t\t\t\t<div class="layui-form-item">\n' +
                        '\t\t\t\t\t<label class="layui-form-label">说明:</label>\n' +
                        '\t\t\t\t\t<div class="layui-input-block">\n' +
                        '\t\t\t\t\t\t<textarea style="line-height: 38px; padding: 0 0 0 10px;" name="resultConfirm" class="layui-textarea"></textarea>\n' +
                        '\t\t\t\t\t</div>\n' +
                        '\t\t\t\t</div>\n' +
                        '\t\t\t</div>\n' +
                        '\t\t</div>',
                    success: function(){
                        form.render()
                        form.val("resulForm", tData)
                        $('#resulForm input[name="taskPrecess"]').val(tData.taskPrecess + '%')

                        var resultAttachments = tData ? tData.attachments2 || [] : []
                        var resultFileStr = ''
                        if (resultAttachments.length > 0) {
                            resultAttachments.forEach(function (attachment) {
                                var fileExtension = attachment.attachName.substring(attachment.attachName.lastIndexOf(".") + 1, attachment.attachName.length)//截取附件文件后缀
                                var attName = encodeURI(attachment.attachName).replace(/\+/g, "%2b").replace(/\@/g, "%40").replace(/\#/g, "%23").replace(/\&/g, "%26").replace(/\//g, "%2F").replace(/\?/g, "%3F").replace(/\￥/g, "%ef%bf%a5").replace(/\$/g, "%24").replace(/\！/g, "%ef%bc%81").replace(/\（/g, "%ef%bc%88").replace(/\）/g, "%ef%bc%89").replace(/\…/g, "%e2%80%a6%e2%80%a6")
                                var fileExtensionName = attName.substring(0, attName.lastIndexOf("."))
                                var deUrl = attachment.attUrl.split('&ATTACHMENT_NAME=')[0] + "&ATTACHMENT_NAME=" + fileExtensionName + "." + fileExtension + "&FILESIZE=" + attachment.size
                                resultFileStr += '<div class="dech" deUrl="' + deUrl + '"><a href="/download?' + encodeURI(deUrl) + '" NAME="' + attachment.attachName + '*"><img style="margin-top: -3px; margin-right: 3px;" src="/img/attachment_icon.png"/>' + attachment.attachName + '</a><img class="deImgs" style="margin-left:5px;cursor: pointer;" src="/img/file/icon_deletecha_03.png"/><input type="hidden" data-attachname="' + attachment.attachName + '" class="inHidden" value="' + attachment.aid + '@' + attachment.ym + '_' + attachment.attachId + ',"></div>'
                            })
                        }

                        $('#resultFiles').html(resultFileStr)
                    },
                    yes: function(){

                    }
                })
            }
        })

        function creatTask(tData) {
            var disabled = 'disabled';

            var taskLayer = layer.open({
                type: 1,
                title: '子任务详情',
                area: ['100%', '100%'],
                maxmin: true,
                min: function () {
                    $('.layui-layer-shade').hide()
                },
                btn: ['保存', '取消'],
                btnAlign: 'c',
                content: '<div id="taskFormBox" style="padding: 30px 50px 0 30px;">\n' +
                    '        <form class="layui-form" id="taskForm" lay-filter="taskForm">\n' +
                    '            <div class="layui-row">\n' +
                    '                <div class="layui-col-xs6" style="padding: 0 20px;">\n' +
                    '                    <div class="layui-form-item">\n' +
                    '                        <label class="layui-form-label">子任务编码</label>\n' +
                    '                        <div class="layui-input-block">\n' +
                    '                            <input ' + disabled + ' type="text" name="taskNo" autocomplete="off" class="layui-input ' + disabled + '">\n' +
                    '                        </div>\n' +
                    '                    </div>\n' +
                    '                    <div class="layui-form-item">\n' +
                    '                        <label class="layui-form-label">责任人</label>\n' +
                    '                        <div class="layui-input-inline select_input">\n' +
                    '                            <input type="text" readonly id="taskDutyUser" name="dutyUser" autocomplete="off" class="layui-input ' + disabled + ' user_input">\n' +
                    '                        </div>\n' +
                    '                        <div class="layui-form-mid layui-word-aux choose_' + disabled + '" userid="taskDutyUser">\n' +
                    '                            <a href="javascript:;" class="choose_user" choosetype="1" style="color: blue;">添加</a>\n' +
                    '                            <a href="javascript:;" class="clear_user" style="color: red">删除</a>\n' +
                    '                        </div>\n' +
                    '                    </div>\n' +
                    '                    <div class="layui-form-item">\n' +
                    '                        <label class="layui-form-label">所属部门</label>\n' +
                    '                        <div class="layui-input-inline select_input">\n' +
                    '                            <input type="text" readonly id="mainCenterDept" name="mainCenterDept" autocomplete="off" class="layui-input ' + disabled + ' dept_input">\n' +
                    '                        </div>\n' +
                    '                        <div class="layui-form-mid layui-word-aux choose_' + disabled + '" deptid="mainCenterDept">\n' +
                    '                            <a href="javascript:;" class="choose_dept" choosetype="1" style="color: blue;">添加</a>\n' +
                    '                            <a href="javascript:;" class="clear_dept" style="color: red">删除</a>\n' +
                    '                        </div>\n' +
                    '                    </div>\n' +
                    '                    <div class="layui-form-item">\n' +
                    '                        <label class="layui-form-label">一级监督部门</label>\n' +
                    '                        <div class="layui-input-inline select_input">\n' +
                    '                            <input type="text" readonly id="mainAreaDept" name="mainAreaDept" autocomplete="off" class="layui-input ' + disabled + ' dept_input">\n' +
                    '                        </div>\n' +
                    '                        <div class="layui-form-mid layui-word-aux choose_' + disabled + '" deptid="mainAreaDept">\n' +
                    '                            <a href="javascript:;" class="choose_dept" choosetype="1" style="color: blue;">添加</a>\n' +
                    '                            <a href="javascript:;" class="clear_dept" style="color: red">删除</a>\n' +
                    '                        </div>\n' +
                    '                    </div>\n' +
                    '                    <div class="layui-form-item">\n' +
                    '                        <label class="layui-form-label">计划类型</label>\n' +
                    '                        <div class="layui-input-block">\n' +
                    '                            <select id="planType" ' + disabled + ' name="planType" class="' + disabled + '" lay-verify="required">\n' +
                    '                                <option value=""></option>\n' +
                    '                            </select>\n' +
                    '                        </div>\n' +
                    '                    </div>\n' +
                    '                    <div class="layui-form-item">\n' +
                    '                        <label class="layui-form-label">周期类型</label>\n' +
                    '                        <div class="layui-input-block">\n' +
                    '                            <select id="planSycle" ' + disabled + ' name="planSycle" class="' + disabled + '" lay-verify="required">\n' +
                    '                                <option value=""></option>\n' +
                    '                            </select>\n' +
                    '                        </div>\n' +
                    '                    </div>\n' +
                    '                    <div class="layui-form-item">\n' +
                    '                        <label class="layui-form-label">子任务类型</label>\n' +
                    '                        <div class="layui-input-block">\n' +
                    '                            <select id="taskType" ' + disabled + ' name="taskType" class="' + disabled + '" lay-verify="required">\n' +
                    '                                <option value=""></option>\n' +
                    '                            </select>\n' +
                    '                        </div>\n' +
                    '                    </div>\n' +
                    '                    <div class="layui-form-item">\n' +
                    '                        <label class="layui-form-label">计划阶段</label>\n' +
                    '                        <div class="layui-input-block">\n' +
                    '                            <select id="planStage" ' + disabled + ' name="planStage" class="' + disabled + '" lay-verify="required">\n' +
                    '                                <option value=""></option>\n' +
                    '                            </select>\n' +
                    '                        </div>\n' +
                    '                    </div>\n' +
                    '                    <div class="layui-form-item">\n' +
                    '                        <label class="layui-form-label">计划开始时间</label>\n' +
                    '                        <div class="layui-input-block">\n' +
                    '                            <input type="text" id="taskPlanStartDate" ' + disabled + ' name="planStartDate" autocomplete="off" class="layui-input ' + disabled + '">\n' +
                    '                        </div>\n' +
                    '                    </div>\n' +
                    '                    <div class="layui-form-item">\n' +
                    '                        <label class="layui-form-label">计划完成时间</label>\n' +
                    '                        <div class="layui-input-block">\n' +
                    '                            <input type="text" id="taskPlanEndDate" ' + disabled + ' name="planEndDate" autocomplete="off" class="layui-input ' + disabled + '">\n' +
                    '                        </div>\n' +
                    '                    </div>\n' +
                    '                    <div class="layui-form-item">\n' +
                    '                        <label class="layui-form-label">计划工期</label>\n' +
                    '                        <div class="layui-input-block">\n' +
                    '                            <input ' + disabled + ' type="text" name="planContinuedDate" autocomplete="off" class="layui-input ' + disabled + '">\n' +
                    '                        </div>\n' +
                    '                    </div>\n' +
                    '                    <div class="layui-form-item">\n' +
                    '                        <label class="layui-form-label">子任务说明</label>\n' +
                    '                        <div class="layui-input-block">\n' +
                    '                            <input ' + disabled + ' type="text" name="taskDesc" autocomplete="off" class="layui-input ' + disabled + '">\n' +
                    '                        </div>\n' +
                    '                    </div>\n' +
                    '                    <div class="layui-form-item">\n' +
                    '                        <label class="layui-form-label">所属关键任务</label>\n' +
                    '                        <div class="layui-input-block">\n' +
                    '                            <select id="tgId" ' + disabled + ' name="tgId" class="' + disabled + '" lay-verify="required">\n' +
                    '                                <option value=""></option>\n' +
                    '                            </select>\n' +
                    '                        </div>\n' +
                    '                    </div>\n' +
                    '                    <div class="layui-form-item">\n' +
                    '                        <label class="layui-form-label">是否关键工作项</label>\n' +
                    '                        <div class="layui-input-block">\n' +
                    '                            <input type="radio" ' + disabled + ' name="isKeypoint" value="1" title="是">\n' +
                    '                            <input type="radio" ' + disabled + ' name="isKeypoint" value="0" title="否" checked>\n' +
                    '                        </div>\n' +
                    '                    </div>\n' +
                    '                    <div class="layui-form-item">\n' +
                    '                        <label class="layui-form-label">是否提交成果</label>\n' +
                    '                        <div class="layui-input-block">\n' +
                    '                            <input type="radio" ' + disabled + ' name="isResult" value="1" title="是">\n' +
                    '                            <input type="radio" ' + disabled + ' name="isResult" value="0" title="否" checked>\n' +
                    '                        </div>\n' +
                    '                    </div>\n' +
                    '                    <div class="layui-form-item">\n' +
                    '                        <label class="layui-form-label">标准难度系数</label>\n' +
                    '                        <div class="layui-input-block">\n' +
                    '                            <input ' + disabled + ' type="text" name="standardDegree" autocomplete="off" class="layui-input ' + disabled + '">\n' +
                    '                        </div>\n' +
                    '                    </div>\n' +
                    '                    <div class="layui-form-item">\n' +
                    '                        <label class="layui-form-label">难度系数</label>\n' +
                    '                        <div class="layui-input-block">\n' +
                    '                            <input ' + disabled + ' type="text" name="hardDegree" autocomplete="off" class="layui-input ' + disabled + '">\n' +
                    '                        </div>\n' +
                    '                    </div>\n' +
                    '                    <div class="layui-form-item">\n' +
                    '                        <label class="layui-form-label">成果确认</label>\n' +
                    '                        <div class="layui-input-block">\n' +
                    '                            <input ' + disabled + ' type="text" name="resultConfirm" autocomplete="off" class="layui-input ' + disabled + '">\n' +
                    '                        </div>\n' +
                    '                    </div>\n' +
                    '                    <div class="layui-form-item">\n' +
                    '                        <label class="layui-form-label">成果描述</label>\n' +
                    '                        <div class="layui-input-block">\n' +
                    '                            <input ' + disabled + ' type="text" name="resultDesc" autocomplete="off" class="layui-input ' + disabled + '">\n' +
                    '                        </div>\n' +
                    '                    </div>\n' +
                    '                    <div class="layui-form-item">\n' +
                    '                        <label class="layui-form-label">最终交付成果描述</label>\n' +
                    '                        <div class="layui-input-block">\n' +
                    '                            <input ' + disabled + ' type="text" name="finalResultDesc" autocomplete="off" class="layui-input ' + disabled + '">\n' +
                    '                        </div>\n' +
                    '                    </div>\n' +
                    '                </div>\n' +
                    '                <div class="layui-col-xs6" style="padding: 0 20px;">\n' +
                    '                    <div class="layui-form-item">\n' +
                    '                        <label class="layui-form-label">子任务名称</label>\n' +
                    '                        <div class="layui-input-block">\n' +
                    '                            <input ' + disabled + ' type="text" name="taskName" autocomplete="off" class="layui-input ' + disabled + '">\n' +
                    '                        </div>\n' +
                    '                    </div>\n' +
                    '                    <div class="layui-form-item">\n' +
                    '                        <label class="layui-form-label">协作人(多人)</label>\n' +
                    '                        <div class="layui-input-inline select_input">\n' +
                    '                            <input type="text" readonly id="assistUser" name="assistUser" autocomplete="off" class="layui-input ' + disabled + ' user_input">\n' +
                    '                        </div>\n' +
                    '                        <div class="layui-form-mid layui-word-aux choose_' + disabled + '" userid="assistUser">\n' +
                    '                            <a href="javascript:;" class="choose_user" style="color: blue;">添加</a>\n' +
                    '                            <a href="javascript:;" class="clear_user" style="color: red">删除</a>\n' +
                    '                        </div>\n' +
                    '                    </div>\n' +
                    '                    <div class="layui-form-item">\n' +
                    '                        <label class="layui-form-label">二级监督部门</label>\n' +
                    '                        <div class="layui-input-inline select_input">\n' +
                    '                            <input type="text" readonly id="mainProjectDept" name="mainProjectDept" autocomplete="off" class="layui-input ' + disabled + ' dept_input">\n' +
                    '                        </div>\n' +
                    '                        <div class="layui-form-mid layui-word-aux choose_' + disabled + '" deptid="mainProjectDept">\n' +
                    '                            <a href="javascript:;" class="choose_dept" choosetype="1" style="color: blue;">添加</a>\n' +
                    '                            <a href="javascript:;" class="clear_dept" style="color: red">删除</a>\n' +
                    '                        </div>\n' +
                    '                    </div>\n' +
                    '                    <div class="layui-form-item">\n' +
                    '                        <label class="layui-form-label">协助部门</label>\n' +
                    '                        <div class="layui-input-inline select_input">\n' +
                    '                            <input type="text" readonly id="assistCompanyDepts" name="assistCompanyDepts" autocomplete="off" class="layui-input ' + disabled + ' dept_input">\n' +
                    '                        </div>\n' +
                    '                        <div class="layui-form-mid layui-word-aux choose_' + disabled + '" deptid="assistCompanyDepts">\n' +
                    '                            <a href="javascript:;" class="choose_dept" choosetype="0" style="color: blue;">添加</a>\n' +
                    '                            <a href="javascript:;" class="clear_dept" style="color: red">删除</a>\n' +
                    '                        </div>\n' +
                    '                    </div>\n' +
                    '                    <div class="layui-form-item">\n' +
                    '                        <label class="layui-form-label">计划形式</label>\n' +
                    '                        <div class="layui-input-block">\n' +
                    '                            <select id="planRate" ' + disabled + ' name="planRate" class="' + disabled + '" lay-verify="required">\n' +
                    '                                <option value=""></option>\n' +
                    '                            </select>\n' +
                    '                        </div>\n' +
                    '                    </div>\n' +
                    '                    <div class="layui-form-item">\n' +
                    '                        <label class="layui-form-label">计划级次</label>\n' +
                    '                        <div class="layui-input-block">\n' +
                    '                            <select id="planLevel" ' + disabled + ' name="planLevel" class="' + disabled + '" lay-verify="required">\n' +
                    '                                <option value=""></option>\n' +
                    '                            </select>\n' +
                    '                        </div>\n' +
                    '                    </div>\n' +
                    '                    <div class="layui-form-item">\n' +
                    '                        <label class="layui-form-label">工作项依据</label>\n' +
                    '                        <div class="layui-input-block">\n' +
                    '                            <select id="according" ' + disabled + ' name="according" class="' + disabled + '" lay-verify="required">\n' +
                    '                                <option value=""></option>\n' +
                    '                            </select>\n' +
                    '                        </div>\n' +
                    '                    </div>\n' +
                    '                    <div class="layui-form-item">\n' +
                    '                        <label class="layui-form-label">关注等级</label>\n' +
                    '                        <div class="layui-input-block">\n' +
                    '                            <select id="controlLevel" ' + disabled + ' name="controlLevel" class="' + disabled + '" lay-verify="required">\n' +
                    '                                <option value=""></option>\n' +
                    '                            </select>\n' +
                    '                        </div>\n' +
                    '                    </div>\n' +
                    '                    <div class="layui-form-item">\n' +
                    '                        <label class="layui-form-label">实际开始时间</label>\n' +
                    '                        <div class="layui-input-block">\n' +
                    '                            <input type="text" id="taskRealStartDate" ' + disabled + ' name="realStartDate" autocomplete="off" class="layui-input ' + disabled + '">\n' +
                    '                        </div>\n' +
                    '                    </div>\n' +
                    '                    <div class="layui-form-item">\n' +
                    '                        <label class="layui-form-label">实际完成时间</label>\n' +
                    '                        <div class="layui-input-block">\n' +
                    '                            <input type="text" id="taskRealEndDate" ' + disabled + ' name="realEndDate" autocomplete="off" class="layui-input ' + disabled + '">\n' +
                    '                        </div>\n' +
                    '                    </div>\n' +
                    '                    <div class="layui-form-item">\n' +
                    '                        <label class="layui-form-label">实际工期</label>\n' +
                    '                        <div class="layui-input-block">\n' +
                    '                            <input ' + disabled + ' type="text" name="realContinuedDate" autocomplete="off" class="layui-input ' + disabled + '">\n' +
                    '                        </div>\n' +
                    '                    </div>\n' +
                    '                    <div class="layui-form-item">\n' +
                    '                        <label class="layui-form-label">子任务状态</label>\n' +
                    '                        <div class="layui-input-block">\n' +
                    '                            <input ' + disabled + ' type="text" name="taskStatus" autocomplete="off" class="layui-input ' + disabled + '">\n' +
                    '                        </div>\n' +
                    '                    </div>\n' +
                    '                    <div class="layui-form-item">\n' +
                    '                        <label class="layui-form-label">子任务进度</label>\n' +
                    '                        <div class="layui-input-block">\n' +
                    '                            <input ' + disabled + ' type="text" name="taskPrecess" autocomplete="off" class="layui-input ' + disabled + '">\n' +
                    '                        </div>\n' +
                    '                    </div>\n' +
                    '                    <div class="layui-form-item">\n' +
                    '                        <label class="layui-form-label">风险点</label>\n' +
                    '                        <div class="layui-input-block">\n' +
                    '                            <input ' + disabled + ' type="text" name="riskPoint" autocomplete="off" class="layui-input ' + disabled + '">\n' +
                    '                        </div>\n' +
                    '                    </div>\n' +
                    '                    <div class="layui-form-item">\n' +
                    '                        <label class="layui-form-label">难度点</label>\n' +
                    '                        <div class="layui-input-block">\n' +
                    '                            <input ' + disabled + ' type="text" name="difficultPoint" autocomplete="off" class="layui-input ' + disabled + '">\n' +
                    '                        </div>\n' +
                    '                    </div>\n' +
                    '                    <div class="layui-form-item">\n' +
                    '                        <label class="layui-form-label">质量得分</label>\n' +
                    '                        <div class="layui-input-block">\n' +
                    '                            <input ' + disabled + ' type="text" name="qualityScore" autocomplete="off" class="layui-input ' + disabled + '">\n' +
                    '                        </div>\n' +
                    '                    </div>\n' +
                    '                    <div class="layui-form-item">\n' +
                    '                        <label class="layui-form-label">单项得分</label>\n' +
                    '                        <div class="layui-input-block">\n' +
                    '                            <input ' + disabled + ' type="text" name="endScore" autocomplete="off" class="layui-input ' + disabled + '">\n' +
                    '                        </div>\n' +
                    '                    </div>\n' +
                    '                    <div class="layui-form-item">\n' +
                    '                        <label class="layui-form-label">工程量</label>\n' +
                    '                        <div class="layui-input-block">\n' +
                    '                            <input ' + disabled + ' type="text" name="itemQuantity" autocomplete="off" class="layui-input ' + disabled + '">\n' +
                    '                        </div>\n' +
                    '                    </div>\n' +
                    '                    <div class="layui-form-item">\n' +
                    '                        <label class="layui-form-label">工程量单位</label>\n' +
                    '                        <div class="layui-input-block">\n' +
                    '                            <input ' + disabled + ' type="text" name="itemQuantityNuit" autocomplete="off" class="layui-input ' + disabled + '">\n' +
                    '                        </div>\n' +
                    '                    </div>\n' +
                    '                    <div class="layui-form-item">\n' +
                    '                        <label class="layui-form-label">异常原因</label>\n' +
                    '                        <div class="layui-input-block">\n' +
                    '                            <input ' + disabled + ' type="text" name="unusualRes" autocomplete="off" class="layui-input ' + disabled + '">\n' +
                    '                        </div>\n' +
                    '                    </div>\n' +
                    '                    <div class="layui-form-item">\n' +
                    '                        <label class="layui-form-label">异常支撑材料</label>\n' +
                    '                        <div class="layui-input-block">\n' +
                    '                            <input ' + disabled + ' type="text" name="unusualStuff" autocomplete="off" class="layui-input ' + disabled + '">\n' +
                    '                        </div>\n' +
                    '                    </div>\n' +
                    '                    <div class="layui-form-item" style="height: auto">\n' +
                    '                        <div id="taskFiles" style="padding-left: 160px;"></div>\n' +
                    '                        <label class="layui-form-label">子任务文件：</label>\n' +
                    '                        <div class="layui-input-block" id="taskFileBox">\n' +
                    '                        <button type="button" class="layui-btn layui-btn-primary" id="uploadTaskFile" style="border: 0px;color:#3870d7;padding: 0;"><img src="/img/icon_uplod.png" style="margin-right: 5px;"><i style="display: none" class="layui-icon"></i>附件上传</button>\n' +
                    '                        </div>\n' +
                    '                    </div>\n' +
                    '                    <div class="layui-form-item" style="height: auto">\n' +
                    '                        <div id="resultFiles" style="padding-left: 160px;"></div>\n' +
                    '                        <label class="layui-form-label">成果文件：</label>\n' +
                    '                        <div class="layui-input-block" id="resultFileBox">\n' +
                    '                        <button type="button" class="layui-btn layui-btn-primary" id="uploadResultFile" style="border: 0px;color:#3870d7;padding: 0;"><img src="/img/icon_uplod.png" style="margin-right: 5px;"><i style="display: none" class="layui-icon"></i>附件上传</button>\n' +
                    '                        </div>\n' +
                    '                    </div>\n' +
                    '                </div>\n' +
                    '            </div>\n' +
                    '        </form>\n' +
                    '    </div>',
                success: function () {

                    $('#planType').append(dictionaryObj['PLAN_TYPE']['str'])
                    $('#planSycle').append(dictionaryObj['PLAN_SYCLE']['str'])
                    $('#taskType').append(dictionaryObj['TASK_TYPE']['str'])
                    $('#planStage').append(dictionaryObj['PLAN_PHASE']['str'])
                    $('#planRate').append(dictionaryObj['PLAN_RATE']['str'])
                    $('#planLevel').append(dictionaryObj['PLAN_LEVEL']['str'])
                    $('#according').append(dictionaryObj['ACCORDING']['str'])
                    $('#controlLevel').append(dictionaryObj['CONTROL_LEVEL']['str'])

                    // 获取关键任务
                    $.ajax({
                        url: '/projectTarget/getDropDown?pbagId=' + tData.pbagId,
                        type: 'GET',
                        datatype: 'JSON',
                        async: false,
                        success: function (res) {
                            if (res.flag && res.obj.length > 0) {
                                var str = ''
                                res.obj.forEach(function (item) {
                                    str += '<option value="' + item.tgId + '">' + item.tgName + '</option>'
                                })
                                $('#tgId').append(str)
                            }
                            form.render()
                        }
                    })

                    // 处理时间显示
                    // 计划开始时间
                    laydate.render({
                        elem: '#taskPlanStartDate',
                        value: tData && tData.planStartDate ? new Date(tData.planStartDate) : ''
                    })

                    // 计划完成时间
                    laydate.render({
                        elem: '#taskPlanEndDate',
                        value: tData && tData.planEndDate ? new Date(tData.planEndDate) : ''
                    })

                    // 实际开始时间
                    laydate.render({
                        elem: '#taskRealStartDate',
                        value: tData && tData.realStartDate ? new Date(tData.realStartDate) : ''
                    })

                    // 实际完成时间
                    laydate.render({
                        elem: '#taskRealEndDate',
                        value: tData && tData.realEndDate ? new Date(tData.realEndDate) : ''
                    })

                    form.val("taskForm", tData)

                    // 处理责任人显示
                    $('#taskDutyUser').val(tData ? tData.dutyUserName : '')
                    $('#taskDutyUser').attr('user_id', tData ? tData.dutyUser : '')

                    // 处理主责中心部门显示
                    $('#mainCenterDept').val(tData ? tData.mainCenterDeptName : '')
                    $('#mainCenterDept').attr('deptid', tData ? tData.mainCenterDept : '')

                    // 处理主责中心部门责任人显示
                    $('#mainCenterDeptUser').val(tData ? tData.mainCenterDeptUserName : '')
                    $('#mainCenterDeptUser').attr('user_id', tData ? tData.mainCenterDeptUser : '')

                    // 处理主责区域部门显示
                    $('#mainAreaDept').val(tData ? tData.mainAreaDeptName : '')
                    $('#mainAreaDept').attr('deptid', tData ? tData.mainAreaDept : '')

                    // 处理主责区域部门责任人显示
                    $('#mainAreaDeptUser').val(tData ? tData.mainAreaDeptUserName : '')
                    $('#mainAreaDeptUser').attr('user_id', tData ? tData.mainAreaDeptUser : '')

                    // 处理协作人(多人)显示
                    $('#assistUser').val(tData ? tData.assistUserName : '')
                    $('#assistUser').attr('user_id', tData ? tData.assistUser : '')

                    // 处理主责项目部门显示
                    $('#mainProjectDept').val(tData ? tData.mainProjectDeptName : '')
                    $('#mainProjectDept').attr('deptid', tData ? tData.mainProjectDept : '')

                    // 处理主责项目部门责任人显示
                    $('#mainProjectDeptUser').val(tData ? tData.mainProjectDeptUserName : '')
                    $('#mainProjectDeptUser').attr('user_id', tData ? tData.mainProjectDeptUser : '')

                    // 处理公司协助部门显示
                    $('#assistCompanyDepts').val(tData ? tData.assistCompanyDepts : '')
                    $('#assistCompanyDepts').attr('deptid', tData ? tData.assistCompanyDepts : '')

                    // 处理区域协助部门显示
                    $('#assistAreaDepts').val(tData ? tData.assistCompanyDeptsName : '')
                    $('#assistAreaDepts').attr('deptid', tData ? tData.assistAreaDepts : '')

                    // 处理附件显示
                    var taskAttachments = tData ? tData.attachments || [] : []
                    var taskFileStr = ''
                    if (taskAttachments.length > 0) {
                        taskAttachments.forEach(function (attachment) {
                            var fileExtension = attachment.attachName.substring(attachment.attachName.lastIndexOf(".") + 1, attachment.attachName.length)//截取附件文件后缀
                            var attName = encodeURI(attachment.attachName).replace(/\+/g, "%2b").replace(/\@/g, "%40").replace(/\#/g, "%23").replace(/\&/g, "%26").replace(/\//g, "%2F").replace(/\?/g, "%3F").replace(/\￥/g, "%ef%bf%a5").replace(/\$/g, "%24").replace(/\！/g, "%ef%bc%81").replace(/\（/g, "%ef%bc%88").replace(/\）/g, "%ef%bc%89").replace(/\…/g, "%e2%80%a6%e2%80%a6")
                            var fileExtensionName = attName.substring(0, attName.lastIndexOf("."))
                            var deUrl = attachment.attUrl.split('&ATTACHMENT_NAME=')[0] + "&ATTACHMENT_NAME=" + fileExtensionName + "." + fileExtension + "&FILESIZE=" + attachment.size
                            taskFileStr += '<div class="dech" deUrl="' + deUrl + '"><a href="/download?' + encodeURI(deUrl) + '" NAME="' + attachment.attachName + '*"><img style="margin-top: -3px; margin-right: 3px;" src="/img/attachment_icon.png"/>' + attachment.attachName + '</a><img class="deImgs" style="margin-left:5px;cursor: pointer;" src="/img/file/icon_deletecha_03.png"/><input type="hidden" data-attachname="' + attachment.attachName + '" class="inHidden" value="' + attachment.aid + '@' + attachment.ym + '_' + attachment.attachId + ',"></div>'
                        })
                    }

                    var resultAttachments = tData ? tData.attachments2 || [] : []
                    var resultFileStr = ''
                    if (resultAttachments.length > 0) {
                        resultAttachments.forEach(function (attachment) {
                            var fileExtension = attachment.attachName.substring(attachment.attachName.lastIndexOf(".") + 1, attachment.attachName.length)//截取附件文件后缀
                            var attName = encodeURI(attachment.attachName).replace(/\+/g, "%2b").replace(/\@/g, "%40").replace(/\#/g, "%23").replace(/\&/g, "%26").replace(/\//g, "%2F").replace(/\?/g, "%3F").replace(/\￥/g, "%ef%bf%a5").replace(/\$/g, "%24").replace(/\！/g, "%ef%bc%81").replace(/\（/g, "%ef%bc%88").replace(/\）/g, "%ef%bc%89").replace(/\…/g, "%e2%80%a6%e2%80%a6")
                            var fileExtensionName = attName.substring(0, attName.lastIndexOf("."))
                            var deUrl = attachment.attUrl.split('&ATTACHMENT_NAME=')[0] + "&ATTACHMENT_NAME=" + fileExtensionName + "." + fileExtension + "&FILESIZE=" + attachment.size
                            resultFileStr += '<div class="dech" deUrl="' + deUrl + '"><a href="/download?' + encodeURI(deUrl) + '" NAME="' + attachment.attachName + '*"><img style="margin-top: -3px; margin-right: 3px;" src="/img/attachment_icon.png"/>' + attachment.attachName + '</a><img class="deImgs" style="margin-left:5px;cursor: pointer;" src="/img/file/icon_deletecha_03.png"/><input type="hidden" data-attachname="' + attachment.attachName + '" class="inHidden" value="' + attachment.aid + '@' + attachment.ym + '_' + attachment.attachId + ',"></div>'
                        })
                    }

                    $('#taskFileBox').html(taskFileStr)
                    $('#resultFileBox').html(taskFileStr)

                    $('.layui-disabled').attr('placeholder', '').css('color', '#222')

                },
                yes: function () {
                    layer.close(taskLayer)
                }
            })
        }
    })

    //将毫秒数转为yyyy-MM-dd格式时间
    function format(t) {
        if (t) {
            return new Date(t).Format("yyyy-MM-dd")
        } else {
            return ''
        }
    }

    //监听键盘事件，number_input输入框只能输入数字
    $(document).on('keypress', '.number_input', function(e){

        var key = window.event ? e.keyCode : e.which

        if (!((key > 95 && key < 106) || (key > 47 && key < 58) || key == 8 || key == 9 || key == 13 || key == 37 || key == 39)) {
            return false
        }
    });

</script>
</body>
</html>
