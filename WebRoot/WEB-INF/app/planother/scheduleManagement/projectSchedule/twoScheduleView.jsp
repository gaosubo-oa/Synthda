<%--
  Created by IntelliJ IDEA.
  User: 王秋彤
  Date: 2021/10/14
  Time: 9:41
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
    <title>节点计划预览</title>

    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <link rel="stylesheet" href="/lib/layui/layui/css/layui.css?20210319.1">
    <link rel="stylesheet" href="/lib/layui/layui/css/eleTree.css">
    <link rel="stylesheet" href="/lib/layui/layui/css/treeTable.css">

    <script type="text/javascript" src="/js/xoajq/xoajq1.js"></script>
    <script type="text/javascript" src="/lib/layui/layui/layui.all.js"></script>
    <script type="text/javascript" src="/js/base/base.js"></script>
    <script type="text/javascript" src="/lib/layui/layui/global.js?20201229.1"></script>
    <script type="text/javascript" src="/lib/jQuery-File-Upload-master/jquery-ui.js"></script>
    <script type="text/javascript" src="/lib/jQuery-File-Upload-master/jquery.iframe-transport.js"></script>
    <script type="text/javascript" src="/lib/jQuery-File-Upload-master/jquery.fileupload.js"></script>
    <script type="text/javascript" src="/js/common/fileupload.js"></script>
    <script type="text/javascript" src="/js/planbudget/common.js?20210413.1"></script>
    <script type="text/javascript" src="/js/planother/planotherUtil.js?221202108091508"></script>

    <style>
        html, body {
            width: 100%;
            height: 100%;
            background: #fff;
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
            padding: 15px 0 10px;
            box-sizing: border-box;
        }

        .wrapper {
            position: relative;
            width: 100%;
            height: 100%;
            padding: 0 8px;
            box-sizing: border-box;
        }

        .wrap_left {
            position: relative;
            float: left;
            width: 230px;
            height: 100%;
            padding-right: 10px;
            box-sizing: border-box;
        }

        .wrap_left h2 {
            line-height: 35px;
            text-align: center;
        }

        .wrap_left .left_form {
            position: relative;
            overflow: hidden;
        }

        .left_form .layui-input {
            height: 35px;
            margin: 10px 0;
            padding-right: 25px;
        }

        .tree_module {
            position: absolute;
            top: 90px;
            right: 10px;
            bottom: 0;
            left: 0;
            overflow: auto;
            box-sizing: border-box;
        }

        .eleTree-node-content {
            overflow: hidden;
            word-break: break-all;
            white-space: nowrap;
            text-overflow: ellipsis;
        }

        .search_icon {
            position: absolute;
            top: 10px;
            right: 0;
            height: 35px;
            width: 25px;
            padding-top: 8px;
            text-align: center;
            cursor: pointer;
            box-sizing: border-box;
        }

        .search_icon:hover {
            color: #0aa3e3;
        }

        .wrap_right {
            position: relative;
            height: 100%;
            margin-left: 230px;
            overflow: auto;
        }

        .query_module .layui-input {
            height: 35px;
        }

        /* region 图标样式 */
        .icon_img {
            font-size: 25px;
            cursor: pointer;
        }

        .icon_img:hover {
            color: #0aa3e3;
        }
        /* endregion */

        .form_label {
            float: none;
            padding: 9px 0;
            text-align: left;
            width: auto;
        }

        .form_block {
            margin: 0;
        }

        .field_required {
            color: red;
            font-size: 16px;
        }

        .layer_wrap .layui_col {
            width: 20% !important;
            padding: 0 5px;
        }

        /* region 上传附件样式 */
        .file_upload_box {
            position: relative;
            height: 22px;
            overflow: hidden;
        }
        .open_file {
            float: left;
            position:relative;
        }
        .open_file input[type=file] {
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            z-index: 2;
            opacity: 0;
        }

        .progress {
            float: left;
            width: 200px;
            margin-left: 10px;
            margin-top: 2px;
        }

        .bar {
            width: 0%;
            height: 18px;
            background: green;
        }

        .bar_text {
            float: left;
            margin-left: 10px;
        }
        /* endregion */

        .refresh_no_btn, .refresh_sort_btn {
            display: none;
            margin-left: 8%;
            color: #00c4ff !important;
            font-weight: 600;
            cursor: pointer;
        }
    </style>
</head>
<body>

<div class="container">
    <table id="tableIns" lay-filter="tableIns"></table>
</div>

<script type="text/html" id="toolbarHead">
    <div class="layui-btn-container display" style="float: left; height: 30px;">
        <button class="layui-btn layui-btn-sm" lay-event="edit">编辑</button>
    </div>
</script>

<script type="text/html" id="toolBar">
    <a class="layui-btn  layui-btn-xs" lay-event="detail">查看详情</a>
</script>

<script>
    // 获取地址栏参数值
    function getQueryString(name){
        var reg = new RegExp("(^|&)"+ name +"=([^&]*)(&|$)");
        var r = window.location.search.substr(1).match(reg);
        if(r!=null)return  unescape(r[2]); return null;
    }

    var runId = getQueryString("runId");
    var _disabled = getQueryString('disabled');
    //var type = getQueryString("type")||'';
    //var projectId = getQueryString("projectId")||'';
    var companyScheduleId = getQueryString("companyScheduleId")||'';
    if('0'!=_disabled){
        type = 4
    }else {
        type = 1
    }


    var data = null

    var tableIns = null;

    // 表格显示顺序
    var colShowObj = {
        documentNo: {field: 'documentNo', title: '编号', minWidth: 150},
        // companySort:{field:'companySort',title:'排序号',minWidth: 100},
        scheduleName: {field: 'scheduleName', title: '任务名称', minWidth: 100},
        scheduleEndDate: {field: 'scheduleEndDate', title: '完成时间', minWidth: 130},
        scheduleGrade: {field: 'scheduleGrade', title: '节点等级',minWidth: 100,templet: function (d) {
                if(d.scheduleGrade) {
                    return '<span>'+((dictionaryObj&&dictionaryObj['SCHEDULE_GRADE']&&dictionaryObj['SCHEDULE_GRADE']['object'][d.scheduleGrade])||'')+'</span>'
                }else {
                    return ''
                }
            }},
        scheduleUserName: {field: 'scheduleUserName', title: '责任人',minWidth: 120},
        supervisorUserName: {field: 'supervisorUserName', title: '监督人',minWidth: 120},
        importanceLevel: {field: 'importanceLevel', title: '重要性',minWidth: 120,templet: function (d) {
                if(d.importanceLevel) {
                    return '<span>'+((dictionaryObj&&dictionaryObj['SCHEDULE_INPORTANCE']&&dictionaryObj['SCHEDULE_INPORTANCE']['object'][d.importanceLevel])||'')+'</span>'
                }else {
                    return ''
                }
            }},
        revisionTime: {field: 'revisionTime', title: '修编时间',minWidth: 120},
        revisionUserName: {field: ' revisionUserName', title: '修编人',minWidth: 120}
    }

    var TableUIObj = new TableUI('plb_other_schedule_1');

    var dictionaryObj = {
        SCHEDULE_GRADE: {},
        SCHEDULE_INPORTANCE:{}
    }
    var dictionaryStr = 'SCHEDULE_GRADE,SCHEDULE_INPORTANCE';
    $.get('/plbDictonary/selectDictionaryByDictNos', {plbDictNos: dictionaryStr}, function (res) {
        if (res.flag) {
            for (var dict in dictionaryObj) {
                dictionaryObj[dict] = {object: {}, str: ''}
                if (res.object[dict]) {
                    res.object[dict].forEach(function (item) {
                        dictionaryObj[dict]['object'][item.plbDictNo] = item.dictName;
                        dictionaryObj[dict]['str'] += '<option value=' + item.plbDictNo + '>' + item.dictName + '</option>';
                    });
                }
            }
        }
        initPage();
    });


    //选选人控件添加
    //监督人
    $(document).on('click', '#scheduleUserName', function () {
        user_id = "scheduleUserName";
        $.popWindow("/projectTarget/selectOwnDeptUser?0");
    })
    //责任人
    $(document).on('click', '#supervisorUserName', function () {
        user_id = "supervisorUserName";
        $.popWindow("/projectTarget/selectOwnDeptUser?0");
    })



    function initPage() {
        layui.use(['form', 'laydate', 'table', 'element', 'eleTree', 'layer','treeTable'], function () {
            var laydate = layui.laydate;
            var form = layui.form;
            var table = layui.table;
            var element = layui.element;
            var eleTree = layui.eleTree;
            var layer = layui.layer;
            var treeTable = layui.treeTable;

           /* var param = {};
            var fla = true;
            var url = ''

            if(type == 0 ){
                fla = false;
            }else {
                if(runId){
                    param.runId=runId;
                    url = "/companySchedule/getById"
                }else if(companyScheduleId){
                    param.kayId=companyScheduleId;
                    url = "/companySchedule/getById"
                }else{
                    fla = false;
                    layer.msg("信息获取失败！")
                    return false;
                }
            }

            if(fla){
                $.ajax({
                    url:url,
                    data:param,
                    dataType:"json",
                    async:false,
                    success:function(res){
                        if(res.code===0||res.code==="0"){
                             data = res.obj;
                        }else{
                            layer.msg("信息获取失败！")
                            return false;
                        }
                    }
                })
            }*/
            if(!runId){
                layer.msg("信息获取失败！")
            }

            TableUIObj.init(colShowObj, function () {
                tableInit(runId)
            });

            form.render();

            // 监听列表头部按钮事件
            treeTable.on('toolbar(tableIns)', function (obj) {
                var checkStatus = tableIns.checkStatus();
                switch (obj.event) {
                    case 'edit':
                        if (checkStatus.length != 1) {
                            layer.msg('请选择一项！', {icon: 0});
                            return false
                        }
                        if (checkStatus[0].auditerStatus!=0) {
                            layer.msg('已提交不可编辑！', {icon: 0});
                            return false
                        }
                        newOrEdit(1, checkStatus[0])
                        break;
                }
            });
            treeTable.on('tool(tableIns)', function (obj) {
                var data = obj.data;
                var layEvent = obj.event;
                if (layEvent === 'detail') {
                    newOrEdit(4,data)
                }
            });


            function tableInit(runId) {

                var cols = [{type: 'checkbox'},].concat(TableUIObj.cols);

                cols.push({
                    fixed: 'right',
                    align: 'center',
                    toolbar: '#toolBar',
                    title: '操作',
                    minWidth: 200
                });

                tableIns = treeTable.render({
                    elem: '#tableIns',
                    // data: data||[],
                    url: '/companySchedule/getByRunId',
                    where:{runId:runId},
                    toolbar: '#toolbarHead',
                    height: 'full-100',
                    defaultToolbar: ['filter'],
                    // page: {
                    // 	limit: TableUIObj.onePageRecoeds,
                    // 	limits: [10, 20, 30, 40, 50]
                    // },
                    tree: {
                        iconIndex: 1,
                        idName: 'scheduleId',
                        childName: "child"
                    },
                    cols: cols,
                    // parseData: function (res) { //res 即为原始返回的数据
                    // 	return {
                    // 		"code": 0, //解析接口状态
                    // 		"data": res.data //解析数据列表
                    // 	};
                    // },
                    // initSort: {
                    //     field: TableUIObj.orderbyFields,
                    //     type: TableUIObj.orderbyUpdown
                    // },
                    done: function (res) {
                        data = res
                        if('0'!=_disabled){
                            $('.display').hide()
                        }
                    }
                });
            }

            // 新建/编辑
            function newOrEdit(type, data) {
                var title = '';
                var url = '';
                //var content = ''
                var projectId = data.projectId;
                if (type == '0') {
                    title = '新增';
                    url = '/companySchedule/insert';
                    //content = '/companySchedule/companyScheduleView?type=0&projectId='+projectId
                } else if (type == '1') {
                    title = '编辑';
                    url = '/companySchedule/updateById';
                    //content = '/companySchedule/companyScheduleView?type=1&scheduleId='+data.scheduleId
                }else if(type == '4'){
                    title = '查看详情'
                    //content = '/companySchedule/companyScheduleView?type=4&scheduleId='+data.scheduleId
                }
                layer.open({
                    type: 1,
                    title: title,
                    area: ['80%', '90%'],
                    btn: type != '4'?['保存','取消']:['确定'],
                    btnAlign: 'c',
                    content: ['<form class="layui-form _disabled" id="baseForm" lay-filter="formTest">' +
                    '<div class="layui-collapse">\n' +
                    /* region 进度信息 */
                    '  <div class="layui-colla-item">\n' +
                    '    <h2 class="layui-colla-title">进度信息</h2>\n' +
                    '    <div class="layui-colla-content layui-show plan_base_info">' +
                    /* region 第一行 */
                    '           <div class="layui-row">' +
                    '               <div class="layui-col-xs3" style="padding: 0 5px;">' +
                    '                   <div class="layui-form-item">\n' +
                    '                       <label class="layui-form-label form_label">编号</label>\n' +
                    '                       <div class="layui-input-block form_block">\n' +
                    '                           <input type="text" name="documentNo" readonly style="background: #e7e7e7"  autocomplete="off" class="layui-input">' +
                    '                       </div>\n' +
                    '                   </div>' +
                    '               </div>' +
                    /*'               <div class="layui-col-xs3" style="padding: 0 5px;">' +
                    '                   <div class="layui-form-item">\n' +
                    '                       <label class="layui-form-label form_label">排序号</label>\n' +
                    '                       <div class="layui-input-block form_block">\n' +
                    '                           <input type="text" name="companySort"  autocomplete="off" class="layui-input">' +
                    '                       </div>\n' +
                    '                   </div>' +
                    '               </div>' +*/
                    '               <div class="layui-col-xs3" style="padding: 0 5px;">' +
                    '                   <div class="layui-form-item">\n' +
                    '                       <label class="layui-form-label form_label">任务名称</label>\n' +
                    '                       <div class="layui-input-block form_block">\n' +
                    '                           <input type="text" name="scheduleName"  autocomplete="off" class="layui-input">' +
                    '                       </div>\n' +
                    '                   </div>' +
                    '               </div>' +
                    '               <div class="layui-col-xs3" style="padding: 0 5px;">' +
                    '                   <div class="layui-form-item">\n' +
                    '                       <label class="layui-form-label form_label">项目名称</label>\n' +
                    '                       <div class="layui-input-block form_block">\n' +
                    '                           <input type="text" name="projectName" id="projectName" readonly style="background: #e7e7e7" autocomplete="off" class="layui-input">' +
                    '                       </div>\n' +
                    '                   </div>' +
                    '               </div>' +
                    '               <div class="layui-col-xs3" style="padding: 0 5px;">' +
                    '                   <div class="layui-form-item">\n' +
                    '                       <label class="layui-form-label form_label">完成时间<!--<span field="scheduleEndDate" class="field_required">*</span>--></label>\n' +
                    '                       <div class="layui-input-block form_block">\n' +
                    '                       <input type="text" name="scheduleEndDate" id="scheduleEndDate"  autocomplete="off" class="layui-input" >\n' +
                    '                       </div>\n' +
                    '                   </div>' +
                    '               </div>' +
                    '           </div>' ,
                        '           <div class="layui-row">' +
                        '               <div class="layui-col-xs3" style="padding: 0 5px;">' +
                        '                   <div class="layui-form-item">\n' +
                        '                       <label class="layui-form-label form_label">节点等级<!--<span field="scheduleGrade" class="field_required">*</span>--></label>\n' +
                        '                       <div class="layui-input-block form_block">\n' +
                        '                       <select class="scheduleGrade" name="scheduleGrade" ></select>\n' +
                        '                       </div>\n' +
                        '                   </div>' +
                        '               </div>' +
                        '               <div class="layui-col-xs3" style="padding: 0 5px;">' +
                        '                   <div class="layui-form-item">\n' +
                        '                       <label class="layui-form-label form_label">责任人<!--<span field="scheduleUserName" class="field_required">*</span>--></label>\n' +
                        '                       <div class="layui-input-block form_block">\n' +
                        '                       <input type="text" name="scheduleUserName" id="scheduleUserName" autocomplete="off" class="layui-input">\n' +
                        '                       </div>\n' +
                        '                   </div>' +
                        '               </div>' +
                        '               <div class="layui-col-xs3" style="padding: 0 5px;">' +
                        '                   <div class="layui-form-item">\n' +
                        '                       <label class="layui-form-label form_label">监督人<!--<span field="supervisorUserName" class="field_required">*</span>--></label>\n' +
                        '                       <div class="layui-input-block form_block">\n' +
                        '                       <input type="text" name="supervisorUserName" id="supervisorUserName" autocomplete="off" class="layui-input">\n' +
                        '                       </div>\n' +
                        '                   </div>' +
                        '               </div>' +
                        '               <div class="layui-col-xs3" style="padding: 0 5px;">' +
                        '                   <div class="layui-form-item">\n' +
                        '                       <label class="layui-form-label form_label">重要性<!--<span field="importanceLevel" class="field_required">*</span>--></label>\n' +
                        '                       <div class="layui-input-block form_block">\n' +
                        '                       <select class="importanceLevel" name="importanceLevel" ></select>\n' +
                        '                       </div>\n' +
                        '                   </div>' +
                        '               </div>' +
                        '           </div>',
                        '           <div class="layui-row">' +
                        '               <div class="layui-col-xs3" style="padding: 0 5px;">' +
                        '                   <div class="layui-form-item">\n' +
                        '                       <label class="layui-form-label form_label">备注<!--<span field="memo" class="field_required">*</span>--></label>\n' +
                        '                       <div class="layui-input-block form_block">\n' +
                        '                       <input type="text" name="memo" autocomplete="off" class="layui-input">\n' +
                        '                       </div>\n' +
                        '                   </div>' +
                        '               </div>' +
                        '               <div class="layui-col-xs3" style="padding: 0 5px;">' +
                        '                   <div class="layui-form-item">\n' +
                        '                       <label class="layui-form-label form_label">修编人</label>\n' +
                        '                       <div class="layui-input-block form_block">\n' +
                        '                       <input type="text" name="revisionUserName" readonly style="background: #e7e7e7" autocomplete="off" class="layui-input">\n' +
                        '                       </div>\n' +
                        '                   </div>' +
                        '               </div>' +
                        '               <div class="layui-col-xs3" style="padding: 0 5px;">' +
                        '                   <div class="layui-form-item">\n' +
                        '                       <label class="layui-form-label form_label">修编时间</label>\n' +
                        '                       <div class="layui-input-block form_block">\n' +
                        '                       <input type="text" name="revisionTime" readonly style="background: #e7e7e7" autocomplete="off" class="layui-input">\n' +
                        '                       </div>\n' +
                        '                   </div>' +
                        '               </div>' +
                        '           </div>' +
                        /* endregion */
                        '    </div>\n' +
                        '  </div>\n' +
                        '</div>' +
                        '</form>'].join(''),
                    success: function () {
                        //回显项目名称
                        getProjName('#projectName',projectId?projectId:data.projectId)

                        //节点等级
                        var $select1 = $(".scheduleGrade");
                        var optionStr = '<option value="">请选择</option>';
                        optionStr += dictionaryObj&&dictionaryObj['SCHEDULE_GRADE']&&dictionaryObj['SCHEDULE_GRADE']['str']
                        $select1.html(optionStr);

                        //重要性
                        var $select2 = $(".importanceLevel");
                        var optionStr2 = '<option value="">请选择</option>';
                        optionStr2 += dictionaryObj&&dictionaryObj['SCHEDULE_INPORTANCE']&&dictionaryObj['SCHEDULE_INPORTANCE']['str']
                        $select2.html(optionStr2);

                        laydate.render({
                            elem: '#scheduleEndDate'
                            , trigger: 'click'
                            , format: 'yyyy-MM-dd'
                            // , format: 'yyyy-MM-dd HH:mm:ss'
                            //,value: new Date()
                        });

                        //回显数据
                        if (type == 1 || type == 4) {
                            form.val("formTest", data);
                            //责任人id
                            $('[name="scheduleUserName"]').attr('user_id',data.scheduleUser)
                            //监督人id
                            $('[name="supervisorUserName"]').attr('user_id',data.supervisorUser)

                            //查看详情
                            if(type==4){
                                $('._disabled').find('input,select').attr('disabled', 'disabled');
                                $('.refresh_no_btn').hide();
                                // $('.file_upload_box').hide()
                                // $('.deImgs').hide();
                            }
                        }
                        element.render();
                        form.render()
                    },
                    yes: function (index,layero) {
                        if(type!='4'){
                            var datas = $('#baseForm').serializeArray();
                            var obj = {}
                            datas.forEach(function (item) {
                                obj[item.name] = item.value
                            });

                            //责任人id
                            var scheduleUser = $('#baseForm input[name="scheduleUserName"]').attr('user_id')
                            if(scheduleUser&&scheduleUser.indexOf(',')!=-1){
                                scheduleUser = scheduleUser.substring(0,scheduleUser.lastIndexOf(','))
                            }
                            obj.scheduleUser = scheduleUser || '';

                            //监督人id
                            var supervisorUser = $('#baseForm input[name="supervisorUserName"]').attr('user_id')
                            if(supervisorUser&&supervisorUser.indexOf(',')!=-1){
                                supervisorUser = supervisorUser.substring(0,supervisorUser.lastIndexOf(','))
                            }
                            obj.supervisorUser = supervisorUser || '';


                            obj.projectId = projectId?projectId:data.projectId;

                            obj.dataForm = '1'

                            if(type == '1'){
                                obj.scheduleId= data.scheduleId;
                            }


                            // 判断必填项
                            // var requiredFlag = false;
                            // $('#baseForm').find('.field_required').each(function(){
                            // 	var field = $(this).attr('field');
                            // 	if (!obj[field]) {
                            // 		var fieldName = $(this).parent().text().replace('*', '');
                            // 		layer.msg(fieldName+'不能为空！', {icon: 0, time: 2000});
                            // 		requiredFlag = true;
                            // 		return false;
                            // 	}
                            // });
                            // if (requiredFlag) {
                            // 	return false;
                            // }
                            var loadIndex = layer.load();

                            $.ajax({
                                url: url,
                                data: obj,
                                dataType: 'json',
                                type: 'post',
                                success: function (res) {
                                    layer.close(loadIndex);
                                    if (res.code=='0') {
                                        layer.msg('保存成功！', {icon: 1});
                                        layer.close(index);

                                        tableIns.reload();
                                    } else {
                                        layer.msg(res.msg, {icon: 7});
                                    }
                                }
                            });
                        }else {
                            layer.close(index);
                        }

                    }
                });
            }

        })
    }



    function childFunc() {
        if('0'!=_disabled){
            return true
        }

        var loadIndex = layer.load();


        var _flag = false;

        $.ajax({
            url: '/companySchedule/updateById',
            data:JSON.stringify(data),
            // data: data ,
            dataType: 'json',
            contentType: "application/json;charset=UTF-8",
            type: 'post',
            success: function (res) {
                layer.close(loadIndex);
                if (res.flag) {
                    layer.msg('保存成功！', {icon: 1});
                    /*layer.close(index);
                    tableIns.config.where._ = new Date().getTime();
                    tableIns.reload();*/
                } else {
                    layer.msg(res.msg, {icon: 2});
                    _flag = true
                }
            }
        });

        if(_flag){
            return false;
        }
        return true;

    }

</script>
</body>
</html>
