<%--
  Created by IntelliJ IDEA.
  User: zhangyuan
  Date: 2020-08-31
  Time: 11:17
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
    <title>关键任务相关信息</title>
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
            <li id="projectShow">项目</li>
            <li>子任务</li>
            <li>流程</li>
        </ul>
        <div class="layui-tab-content">
            <div class="layui-tab-item layui-show dailyReport"></div>
            <div class="layui-tab-item file_list"></div>
            <div class="layui-tab-item projectDetail"></div>
            <div class="layui-tab-item">
                <table id="demo" lay-filter="test"></table>
            </div>
            <div class="layui-tab-item"></div>
        </div>
    </div>

    <script>
        var dictionaryObj = {
            PLAN_SYCLE: {},
            RENWUJIHUA_TYPE: {},
            UNIT:{},
        }
        var dictionaryStr = 'PLAN_SYCLE,RENWUJIHUA_TYPE,UNIT'
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
        /*判断是否显示项目*/
        if($('#hiddenDeptId',window.parent.document).attr('deptOrProject')!='0'){
            $('#projectShow').hide()
        }
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
        var projectTypeObj={}
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
        })
        /*展示项目信息*/
        $.get('/projectTarget/selectProByTgId',{tgId:parent.tgId_infor},function (res) {
            var data=res.object
            if(data){
                var str='<table class="layui-table">' +
                    '  <colgroup><col width="150"><col><col width="200"><col></colgroup>' +
                    '  <tbody>\n' +
                    '    <tr><td>项目名称</td><td>'+data.projectName+'</td><td>项目简称</td><td>'+data.projectAbbreviation+'</td></tr>' +
                    '    <tr><td>项目类型</td><td>'+function () {
                        if(projectTypeObj[data.projectType]){
                            return  projectTypeObj[data.projectType]
                        }else{
                            return ''
                        }
                    }()+'</td><td>项目地点</td><td>'+data.projectPlace+'</td></tr>' +
                    '    <tr><td>中标时间</td><td>'+format(data.winningDate)+'</td><td>责任部门</td><td>'+(data.respectiveRegionName || '')+'</td></tr>' +
                    '    <tr><td>合同额(万元)</td><td>'+data.contractMoney+'</td><td>计划开始时间</td><td>'+format(data.statrtTime)+'</td></tr>' +
                    '    <tr><td>计划结束时间</td><td>'+format(data.endTime)+'</td><td>合同总工期</td><td>'+data.contractDuration+'</td></tr>' +
                    '    <tr><td>审批人</td><td>'+(data.infoCheckName || '')+'</td><td>总承包部负责人</td><td>'+(data.overallLeaderName || '')+'</td></tr>' +
                    '    <tr><td>项目经理</td><td>'+(data.projectManageName || '')+'</td><td>项目经理电话</td><td>'+data.projectManagePhone+'</td></tr>' +
                    '    <tr><td>业主单位</td><td>'+(data.ownerUnitName || '')+'</td><td>业主单位联系方式</td><td>'+data.ownerPhone+'</td></tr>' +
                    '    <tr><td>监理单位</td><td>'+(data.manageUnitName || '')+'</td><td>监理单位联系方式</td><td>'+data.managePhone+'</td></tr>' +
                    '    <tr><td>验收标准</td><td colspan="3">'+data.acceptStandard+'</td></tr>' +
                    '    <tr><td>施工内容</td><td colspan="3">'+data.workContent+'</td></tr>' +
                    '  </tbody>\n' +
                    '</table>'
                $('.projectDetail').html(str)
            }
        })

        layui.use('table', function(){
            var table = layui.table;
            /*展示关联子任务*/
            table.render({
                elem: '#demo'
                ,url: '/projectTarget/findItemByTgId?tgId='+parent.tgId_infor//数据接口
                ,cols: [[
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
                        field: 'taskName', title: '子任务名称', width: 300,style:"color:blue;cursor: pointer",templet: function (d) {
                            return  '<span class="taskDetail" planItemId="'+d.planItemId+'" parentPlanItemId="'+d.parentPlanItemId+'">'+d.taskName+'</span>'
                        }
                    },
                    {
                        field: 'planSycle', title: '周期类型', width: 120, templet: function (d) {
                            return dictionaryObj['PLAN_SYCLE']['object'][d.planSycle] || ''
                        }
                    },
                    {
                        field: 'taskType', title: '子任务类型', width: 120, templet: function (d) {
                            return dictionaryObj['RENWUJIHUA_TYPE']['object'][d.taskType] || ''
                        }
                    },
                    {field: 'dutyUserName', title: '负责人',width: 100},
                    {field: 'mainCenterDeptName', title: '责任部门',width: 150},
                    {field: 'assistCompanyDeptsName', title: '协助部门',width: 150},
                    {
                        field: 'planStartDate', title: '计划开始时间', width: 150, templet: function (d) {
                            return format(d.planStartDate)
                        }
                    },
                    {
                        field: 'planEndDate', title: '计划结束时间', width: 150, templet: function (d) {
                            return format(d.planEndDate)
                        }
                    },
                    {field: 'planContinuedDate', title: '计划工期',width: 150},
                    {
                        field: 'resultStandard', title: '完成标准', width: 130,
                    },
                    {field: 'preTask', title: '前置子任务', width: 150,templet: function (d) {
                            var preTasks=''
                            if(d.preTasks){
                                d.preTasks.forEach(function (item) {
                                    preTasks+=item.workItemName+','
                                })
                                return preTasks.replace(/,$/, '').split(',')
                            }else{
                                return  ''
                            }
                        }},
                    {field: 'riskPoint', title: '风险点', width: 120},
                    {field: 'difficultPoint', title: '难度点', width: 120},
                    {field: 'hardDegree', title: '难度系数', width: 120},
                    {
                        field: 'taskDesc', title: '子任务描述', width: 120,
                    }
                ]]
                ,parseData: function(res){ //res 即为原始返回的数据
                    return {
                        "code": 0, //解析接口状态
                        "data": res.obj//解析数据列表
                    };
                }
            });
            $(document).on('click','.taskDetail',function () {
                parent.detail($(this).attr('planItemId'))
            })
        });

        //将毫秒数转为yyyy-MM-dd格式时间
        function format(t) {
            if(t) return new Date(t).Format("yyyy-MM-dd");
            else return ''
        }

        // 附件查阅
        $(document).on('click', '.yulan', function () {
            var url = $(this).attr('data-url');
            pdurl($.UrlGetRequest('?' + url), url);
        });

        $('.delReport').click(function () {
            parent.delReport($(this))
        })

        $('.fileDel').click(function () {
            parent.delFile($(this))
        })
        
    </script>
</body>
</html>
