<%--
  Created by IntelliJ IDEA.
  User: zhangyuan
  Date: 2020-09-01
  Time: 14:15
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
<!DOCTYPE html >
<html>
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <title>子任务相关信息</title>
    <meta name="renderer" content="webkit">
    <meta http-equiv="X-UA-Compatible" content="IE=10,chrome=1">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=0, minimum-scale=1.0, maximum-scale=1.0">
    <link rel="stylesheet" type="text/css" href="/lib/layui/layui/css/layui.css?20210319.1"/>

    <script type="text/javascript" src="/js/xoajq/xoajq1.js"></script>
    <script src="/js/base/base.js" type="text/javascript" charset="utf-8"></script>
    <script src="../../js/jquery/jquery.cookie.js"></script>
    <script src="/lib/jQuery-File-Upload-master/jquery-ui.js" type="text/javascript" charset="utf-8"></script>
    <script src="/lib/jQuery-File-Upload-master/jquery.iframe-transport.js" type="text/javascript" charset="utf-8"></script>
    <script src="/lib/jQuery-File-Upload-master/jquery.fileupload.js" type="text/javascript" charset="utf-8"></script>
    <script type="text/javascript" src="/js/common/fileupload.js"></script>
    <script type="text/javascript" src="/lib/layui/layui/layui.js"></script>
    <script type="text/javascript" src="/lib/layui/layui/layui.all.js"></script>
    <style>
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
        .operationDiv {
            display: none;
            position: absolute;
            top: -50px;
            left: 5px;
            background: #fff;
            box-shadow: 0 0 5px 0 rgb(0, 0, 0);
            border-radius: 5px;
        }
        .divShow {
            position: relative;
        }
        .divShow:hover .operationDiv {
            display: block;
        }
        .td_img {
            width: 20px;
        }
        .fileDel{
            position: absolute;
            top: 5px;
            right: 8px;
        }
    </style>
</head>
<body>
<div class="layui-tab layui-tab-brief" lay-filter="docDemoTabBrief">
    <ul class="layui-tab-title">
        <li class="layui-this">进展情况</li>
        <li>附件</li>
        <li>关键任务</li>
        <li>流程</li>
    </ul>
    <div class="layui-tab-content">
        <div class="layui-tab-item layui-show dailyReport"></div>
        <div class="layui-tab-item file_list"></div>
        <div class="layui-tab-item">
            <div class="layui-form-item" id="relationTarget">
                <label class="layui-form-label" style="width: 60px">关联关键任务</label>
                <div class="layui-input-block" style="margin-left: 80px;">
                    <input type="text" name="tgId" readonly style="background:#e7e7e7;width:70%;display:inline-block" autocomplete="off" class="layui-input">
                    <a href="javascript:;" style="color:#1E9FFF;margin-left:10px" class="relationAdd">添加</a>
                    <a href="javascript:;" style="color:#1E9FFF;margin-left:5px" class="relationDel">清空</a>
                    <button type="button" class="layui-btn layui-btn-sm" id="save" style="margin-left: 10px">保存</button>
                </div>
            </div>
            <table id="demo" lay-filter="test"></table>
        </div>
        <div class="layui-tab-item"></div>
    </div>
</div>

<script>
    var txt = $(".targetOrItem li.layui-this",parent.document).html();
   if(txt == '已完成'){
       $(".relationAdd").hide();
       $("#save").hide();
       $(".relationDel").hide();
   }else{
       $(".relationAdd").show();
       $("#save").show();
       $(".relationDel").show();
   }
    var dictionaryObj = {
        CONTROL_LEVEL: {},
        PLAN_SYCLE: {},
        TG_TYPE:{},
        PLAN_PHASE:{},
        UNIT:{},
        CGCL_TYPE:{},
    }
    var dictionaryStr = 'CONTROL_LEVEL,PLAN_SYCLE,TG_TYPE,PLAN_PHASE,UNIT,CGCL_TYPE'
    // 获取数据字典数据
    $.ajax({
        url: '/Dictonary/selectDictionaryByDictNos',
        dataType: 'json',
        type: 'get',
        async: false,
        data: {dictNos: dictionaryStr},
        success: function (res) {
            if (res.flag) {
                for (var dict in dictionaryObj) {
                    dictionaryObj[dict] = {object: {}, str: '<option value="">请选择</option>'}
                    if (res.object[dict]) {
                        res.object[dict].forEach(function (item) {
                            dictionaryObj[dict]['object'][item.dictNo] = item.dictName
                            dictionaryObj[dict]['str'] += '<option value=' + item.dictNo + '>' + item.dictName + '</option>'
                        })
                    }
                }
            }
        }
    })
    /*获取父页面的每日填报信息*/
    $('.dailyReport').html(parent.dayReport)
    /*获取父页面的成果材料附件、异常原因附件*/
    $('.file_list').html('<table class="layui-table">\n' +
        '  <tbody>\n' +
        function () {
            if(parent.successFileStr){
                return   '<tr align="center"><td colspan="2">阶段成果（成果材料）</td></tr>'+parent.successFileStr
            }else{
                return  ''
            }
        }()+
        function () {
            if(parent.failFIleStr){
                return   '<tr align="center"><td colspan="2">阶段成果（异常材料）</td></tr>'+parent.failFIleStr
            }else{
                return ''
            }
        }()+
        function () {
            if(parent.finalSuccessFileStr){
                return   '<tr align="center"><td colspan="2">最终成果（成果材料）</td></tr>'+parent.finalSuccessFileStr
            }else{
                return ''
            }
        }()+
        function () {
            if(parent.finalFailFIleStr){
                return  '<tr align="center"><td colspan="2">最终成果（异常材料）</td></tr>'+parent.finalFailFIleStr
            }else{
                return ''
            }
        }()+
        '  </tbody>\n' +
        '</table>')
    /*var projectTypeObj={}
    $.ajax({
        url:'/ProjectInfo/selectProjectTypeByNo',
        dataType:'json',
        type:'post',
        async:false,
        success:function(res){
            for(var i=0;i<res.data.length;i++){
                projectTypeObj[res.data[i].dictNo]=res.data[i].dictName
            }
        }
    })*/

    layui.use('table', function(){
        var table = layui.table;
        /*展示关联关键任务*/
        $.get('/ProjectDaily/selectProjectDailyByItemId',{planItemId:parent.planItemId_relation,deptId:parent.deptId_relation},function (res) {
            if(res.object.tgIds && res.object.tgIds.length>0){
                if(res.object.tgIds && res.object.tgIds.length>0){
                    $('#relationTarget').hide()
                }else{
                    $('#relationTarget').show()
                }
                table.render({
                    elem: '#demo'
                    ,data: res.object.tgIds
                    , cols: [[ //表头
                        {
                            field: 'taskStatus', title: '状态', width: 60, align: 'center', templet: function (d) {
                                if (d.taskStatus == '0') {
                                    // '未开始';
                                    return '<img class="td_img" src="/img/planCheck/planProgressReport/not_started.png"/>';
                                } else if (d.taskStatus == '1') {
                                    // '进行中';
                                    return '<img class="td_img" src="/img/planCheck/planProgressReport/underway.png"/>';
                                } else if (d.taskStatus == '2') {
                                    // '将到期';
                                    return '<img class="td_img" src="/img/planCheck/planProgressReport/delay_underway.png"/>';
                                } else if (d.taskStatus == '4') {
                                    // '已延期';
                                    return '<img class="td_img" src="/img/planCheck/planProgressReport/out_underway.png"/>';
                                } else if (d.taskStatus == '7') {
                                    // '暂停';
                                    return '<img class="td_img" src="/img/planCheck/planProgressReport/suspend.png"/>';
                                } else if (d.taskStatus == '5') {
                                    // '完成';
                                    return '<img class="td_img" src="/img/planCheck/planProgressReport/complete.png"/>';
                                } else if (d.taskStatus == '6') {
                                    // '延期完成';
                                    return '<img class="td_img" src="/img/planCheck/planProgressReport/delay_complete.png"/>';
                                }
                                else if (d.taskStatus == '9') {
                                    // '成果不符';
                                    return '<img class="td_img" src="/img/planCheck/planProgressReport/result_default.png"/>';
                                }
                                else if (d.taskStatus == '8') {
                                    // '关闭';
                                    return '<img class="td_img" src="/img/planCheck/planProgressReport/closed.png"/>';
                                } else {
                                    return '';
                                }
                            }
                        },
                        {
                            field: 'tgName', title: '关键任务名称', width: 300, event: 'tgDetail', templet: function (d) {
                                return '<span class="tgName" style="color: blue;cursor: pointer;" tgId="' + d.tgId + '" >' + d.tgName + '</span>'
                            }
                        }
                        , {
                            field: 'planStartDate', title: '计划开始时间', width: 130, templet: function (d) {
                                return format(d.planStartDate);
                            }
                        }
                        , {
                            field: 'planEndDate', title: '计划完成时间', width: 130, templet: function (d) {
                                return format(d.planEndDate);
                            }
                        }
                        , {
                            field: 'planContinuedDate', title: '计划工期', width: 100,
                        }
                        , {field: 'mainCenterDeptName', title: '中心责任部门', width: 130}
                        , {field: 'mainAreaDeptName', title: '区域责任部门', width: 130}
                        , {field: 'mainProjectDeptName', title: '总承包部责任部门', width: 150}
                        , {
                            field: 'controlLevel', title: '关注等级', width: 100, templet: function (d) {
                                return dictionaryObj['CONTROL_LEVEL']['object'][d.controlLevel] || ''
                            }
                        }
                        , {
                            field: 'planSycle', title: '周期类型', width: 100, templet: function (d) {
                                return dictionaryObj['PLAN_SYCLE']['object'][d.planSycle] || ''
                            }
                        }
                        , {
                            field: 'tgType', title: '关键任务类型', width: 100, templet: function (d) {
                                return dictionaryObj['TG_TYPE']['object'][d.tgType] || ''
                            }
                        }
                        , {
                            field: 'planStage', title: '计划阶段', width: 100, templet: function (d) {
                                return dictionaryObj['PLAN_PHASE']['object'][d.planStage] || '';
                            }
                        }
                        , {field: 'designQuantity', title: '设计量', width: 100}
                        , {field: 'itemQuantity', title: '工程量', width: 100}
                        , {
                            field: 'itemQuantityNuit', title: '单位', width: 100, templet: function (d) {
                                return dictionaryObj['UNIT']['object'][d.itemQuantityNuit] || '';
                            }
                        }
                        , {
                            field: 'dutyUserName', title: '中心责任部门负责人', width: 160, templet: function (d) {
                                if (d.dutyUserName) {
                                    return d.dutyUserName.replace(/,$/, '');
                                } else {
                                    return ''
                                }
                            }
                        }
                        , {field: 'mainAreaUserName', title: '区域责任部门负责人', width: 160}
                        , {field: 'mainProjectUserName', title: '总承包部责任部门负责人', width: 200}
                        , {field: 'resultStandard', title: '完成标准', width: 150}
                        , {field: 'riskPoint', title: '风险点', width: 130}
                        , {
                            field: 'resultDict', title: '成果标准模板', width: 150, templet: function (d) {
                                var resultDictName = '';
                                if (!!d.resultDict) {
                                    var resultDictList = d.resultDict.split(',');

                                    resultDictList.forEach(function (item) {
                                        resultDictName += (!!dictionaryObj['CGCL_TYPE']['object'][item] ? dictionaryObj['CGCL_TYPE']['object'][item] + ',' : '');
                                    });
                                }

                                return resultDictName.replace(/,$/, '');
                            }
                        }
                        , {field: 'difficultPoint', title: '难度点', width: 130}
                        , {field: 'tgDesc', title: '关键任务描述', width: 150}
                    ]]
                });
            }
        })
        $(document).on('click','.tgName',function () {
            parent.detail($(this).attr('tgId'))
        })
        //关联关键任务
        $('.relationAdd').click(function () {
            parent.relationAdd()
        })
        $('.relationDel').click(function () {
            $('input[name="tgId"]').val('')
            $('input[name="tgId"]').attr('tgId','')
        })
        /*点击保存*/
        $('#save').click(function () {
            var tgId=$('[name="tgId"]').attr('tgId')
            if(tgId){
                $.get('/plcProjectItem/addTgId',{tgId:tgId,planItemId:parent.planItemId_relation},function (res) {
                    if(res.flag){
                        layer.msg('保存成功！', {icon: 1, time: 1000}, function(){
                            $('.layui_tr_active',parent.document).trigger('click')
                        });
                    }
                })
            }else{
                layer.msg('暂无关键任务可关联！', {icon: 0, time: 1000});
            }
        })
    });

    // 附件查阅
    $(document).on('click', '.yulan', function () {
        var url = $(this).attr('data-url');
        pdurl($.UrlGetRequest('?' + url), url);
    });

    //将毫秒数转为yyyy-MM-dd格式时间
    function format(t) {
        if(t) return new Date(t).Format("yyyy-MM-dd");
        else return ''
    }

    $('.delReport').click(function () {
        parent.delReport($(this))
    })

    $('.fileDel').click(function () {
        parent.delFile($(this))
    })
</script>
</body>
</html>

