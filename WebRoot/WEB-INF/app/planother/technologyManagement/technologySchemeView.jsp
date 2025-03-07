<%--
  Created by IntelliJ IDEA.
  User: 王秋彤
  Date: 2021/10/12
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
    <title>技术方案预览</title>

    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">

    <link rel="stylesheet" href="/lib/layui/layui/css/layui.css?20210319.1">
    <link rel="stylesheet" href="/lib/layui/layui/css/eleTree.css">

    <script type="text/javascript" src="/js/xoajq/xoajq1.js"></script>
    <script type="text/javascript" src="/lib/layui/layui/layui.all_v2.5.js"></script>
    <script type="text/javascript" src="/js/base/base.js"></script>
    <script type="text/javascript" src="/lib/layui/layui/global.js?20201229.1"></script>
    <script type="text/javascript" src="/lib/layui/layui/lay/mymodules/tableFilter.js"></script>
    <script type="text/javascript" src="/lib/layui/layui/lay/mymodules/tableChild.js"></script>
    <script type="text/javascript" src="/lib/layui/layui/lay/mymodules/tableMerge.js"></script>
    <script type="text/javascript" src="/lib/jQuery-File-Upload-master/jquery-ui.js"></script>
    <script type="text/javascript" src="/lib/jQuery-File-Upload-master/jquery.iframe-transport.js"></script>
    <script type="text/javascript" src="/lib/jQuery-File-Upload-master/jquery.fileupload.js"></script>
    <%--    <script type="text/javascript" src="/js/common/fileupload.js"></script>--%>
    <script type="text/javascript" src="/js/planbudget/common.js?20210413"></script>
    <script src="../js/jquery/jquery.cookie.js"></script>
    <script type="text/javascript" src="/js/planother/planotherUtil.js?221202108301508"></script>

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

        /* region 左侧样式 */
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

        /* endregion */

        /* region 右侧样式 */
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

        /* endregion */

        /* region 上传附件样式 */
        .file_upload_box {
            position: relative;
            height: 22px;
            overflow: hidden;
        }

        .open_file {
            float: left;
            position: relative;
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

        /*选中行样式*/
        .selectTr {
            background: #009688 !important;
            color: #fff !important;
        }

        .refresh_no_btn {
            display: none;
            margin-left: 2%;
            color: #00c4ff !important;
            font-weight: 600;
            cursor: pointer;
        }
        /*.layui-col-xs4{*/
        /*	width: 20%;*/
        /*}*/

        .project_objectives .layui-table-cell,.project_objectives .layui-table-box,.project_objectives .layui-table-body {
            overflow: visible;
        }
        /* 设置下拉框的高度与表格单元格的高度相同 */
        .project_objectives td .layui-form-select {
            margin-top: -10px;
            margin-left: -15px;
            margin-right: -15px;
        }
    </style>
</head>
<body>

<div class="container" id="htm"></div>

<script type="text/html" id="toolbarPlan">
    <div class="layui-btn-container" style="height: 30px;">
        <button class="layui-btn layui-btn-sm" lay-event="add">加行</button>
    </div>
</script>

<script type="text/html" id="toolbarPlan2">
    <div class="layui-btn-container" style="height: 30px;">
        <button class="layui-btn layui-btn-sm" lay-event="add">选择</button>
    </div>
</script>

<script type="text/html" id="barPlan">
    <a class="layui-btn layui-btn-danger layui-btn-xs" lay-event="del">删行</a>
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
    //var type = getQueryString("type");
    var type;
    if('0'!=_disabled){
        type = 4
    }else {
        type = 1
    }

    var data = null

    var htm = ['<div class="layui-collapse _disabled">\n' +
    /* region 方案内容 */
    '  <div class="layui-colla-item">\n' +
    '    <h2 class="layui-colla-title">方案内容</h2>\n' +
    '    <div class="layui-colla-content layui-show plan_base_info">' +
    '       <form class="layui-form" id="baseForm" lay-filter="formTest">' +
    /* region 第一行 */
    '           <div class="layui-row">' +
    '               <div class="layui-col-xs3" style="padding: 0 5px;">' +
    '                   <div class="layui-form-item">\n' +
    '                       <label class="layui-form-label form_label">单据号<span field="documnetNo" class="field_required">*</span><a title="刷新单据号" class="refresh_no_btn"><i class="layui-icon layui-icon-refresh"></i></a></label>\n' +
    '                       <div class="layui-input-block form_block">\n' +
    '                       <input type="text" name="documnetNo" readonly autocomplete="off" style="background: #e7e7e7" class="layui-input">\n' +
    '                       </div>\n' +
    '                   </div>' +
    '               </div>' +
    '               <div class="layui-col-xs3" style="padding: 0 5px;">' +
    '                   <div class="layui-form-item">\n' +
    '                       <label class="layui-form-label form_label">项目名称<span field="projectName" class="field_required">*</span></label>\n' +
    '                       <div class="layui-input-block form_block">\n' +
    '                           <input type="text" name="projectName" id="projectName" readonly style="background: #e7e7e7" autocomplete="off" class="layui-input">' +
    '                       </div>\n' +
    '                   </div>' +
    '               </div>' +
    '               <div class="layui-col-xs3" style="padding: 0 5px;">' +
    '                   <div class="layui-form-item">\n' +
    '                       <label class="layui-form-label form_label">技术方案名称<span field="technicalName" class="field_required">*</span></label>\n' +
    '                       <div class="layui-input-block form_block">\n' +
    '                           <input type="text" name="technicalName"  autocomplete="off" class="layui-input">' +
    '                       </div>\n' +
    '                   </div>' +
    '               </div>' +
    '               <div class="layui-col-xs3" style="padding: 0 5px;">' +
    '                   <div class="layui-form-item">\n' +
    '                       <label class="layui-form-label form_label">方案类型<span field="schemeType" class="field_required">*</span></label>\n' +
    '                       <div class="layui-input-block form_block">\n' +
    '                       	<select class="schemeType" name="schemeType" ></select>\n' +
    '                       </div>\n' +
    '                   </div>' +
    '               </div>' +
    '           </div>' ,
        '<div class="layui-row">' +
        '               <div class="layui-col-xs12" style="padding: 0 5px;">' +
        '                   <div class="layui-form-item">\n' +
        '                       <label class="layui-form-label form_label">方案概述<span field="schemeSummary" class="field_required">*</span></label>\n' +
        '                       <div class="layui-input-block form_block">\n' +
        ' 							<textarea type="text" name="schemeSummary" style="resize: vertical;min-height: 80px" autocomplete="off" class="layui-input"></textarea>' +
        '                       </div>\n' +
        '                   </div>' +
        '               </div>' +
        '</div>',
        '           <div class="layui-row">' +
        '               <div class="layui-col-xs12" style="padding: 0 5px;">' +
        '                   <div class="layui-form-item">\n' +
        '                       <label class="layui-form-label form_label">附件<span field="attachmentId" class="field_required">*</span></label>' +
        '                       <div class="layui-input-block form_block">' +
        '<div class="file_module">' +
        '<div id="fileContent" class="file_content"></div>' +
        '<div class="file_upload_box">' +
        '<a href="javascript:;" class="open_file">' +
        '<img src="/img/mg11.png" style="margin: -3px 5px 0 0;"><span>添加附件</span>' +
        '<input type="file" multiple id="fileupload" data-url="/upload?module=technologyScheme" name="file">' +
        '</a>' +
        '<div class="progress" id="progress">' +
        '<div class="bar"></div>\n' +
        '</div>' +
        '<div class="bar_text"></div>' +
        '</div>' +
        '</div>' +
        '                       </div>\n' +
        '                   </div>' +
        '               </div>' +
        '           </div>',
        /* endregion */
        '       </form>' +
        '    </div>\n' +
        '  </div>\n' +
        /* endregion */
        '  <div class="layui-colla-item">\n' +
        '    <h2 class="layui-colla-title">方案主要内容</h2>\n' +
        '    <div class="layui-colla-content layui-show project_detailed_information">' +
        '		<table id="detailedTable" lay-filter="detailedTable"></table>' +
        '    </div>\n' +
        '  </div>\n' +
        '  <div class="layui-colla-item">\n' +
        '    <h2 class="layui-colla-title">策划要求</h2>\n' +
        '    <div class="layui-colla-content layui-show project_objectives">' +
        '		<table id="objectivesTable" lay-filter="objectivesTable"></table>' +
        '    </div>\n' +
        '  </div>\n' +
        /* endregion */
        '</div>'].join('');

    $("#htm").html(htm)


    // 获取数据字典数据
    var dictionaryObj = {
        SCHEME_TYPE:{}
    }
    var dictionaryStr = 'SCHEME_TYPE';
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



    function initPage() {
        layui.use(['form', 'laydate', 'table', 'element', 'eleTree', 'layer','soulTable'], function () {
            var laydate = layui.laydate;
            var form = layui.form;
            var table = layui.table;
            var element = layui.element;
            var eleTree = layui.eleTree;
            var layer = layui.layer;
            var soulTable = layui.soulTable;


            var param = {};
            var fla = true;
            if(runId){
                param.runId=runId;
            }else{
                fla = false;
                layer.msg("信息获取失败！")
                return false;
            }
            if(fla){
                $.ajax({
                    url:"/technologyScheme/getById",
                    data:param,
                    dataType:"json",
                    success:function(res){
                        if(res.code===0||res.code==="0"){
                             data = res.obj;

                            //方案类型
                            var $select1 = $(".schemeType");
                            var optionStr = '<option value="">请选择</option>';
                            optionStr += dictionaryObj&&dictionaryObj['SCHEME_TYPE']&&dictionaryObj['SCHEME_TYPE']['str']
                            $select1.html(optionStr);

                            fileuploadFn('#fileupload', $('#fileContent'));
                            //回显项目名称
                            getProjName('#projectName',data.projectId)

                            //回显数据
                            if (type == 1 || type == 4) {
                                form.val("formTest", data);
                                $('input[name="documnetNo"]', $('#baseForm')).val(data.documnetNo);
                                //附件
                                if (data.attachmentList && data.attachmentList.length > 0) {
                                    var fileArr = data.attachmentList;
                                    $('#fileContent').append(echoAttachment(fileArr));
                                }
                            }else{
                                // 获取自动编号
                                getAutoNumber({autoNumberType: 'technologyScheme'}, function(res) {
                                    $('input[name="documnetNo"]', $('#baseForm')).val(res.obj);
                                });
                                $('.refresh_no_btn').show().on('click', function() {
                                    getAutoNumber({technologyScheme: 'technologyScheme'}, function(res) {
                                        $('input[name="documnetNo"]', $('#baseForm')).val(res.obj);
                                    });
                                });
                            }

                            //方案主要内容
                            var cols = [
                                {type: 'numbers', title: '序号'},
                                {
                                    field: 'mainSchemeName', title: '名称', minWidth: 150, templet: function (d) {
                                        return '<input technologyId="' + (d.technologyId || '') + '" mainSchemeId="'+(d.mainSchemeId || '')+'" type="text" name="mainSchemeName" class="layui-input" style="height: 100%;" value="' + (d.mainSchemeName || '') + '">'
                                    }
                                },
                                {
                                    field: 'mainSchemeContent', title: '主要内容', minWidth: 160, templet: function (d) {
                                        return '<input type="text" name="mainSchemeContent" class="layui-input" style="height: 100%;" value="' + (d.mainSchemeContent || '') + '">'
                                    }
                                },
                                {
                                    field: 'completedUser', title: '完成人', minWidth: 160, templet: function (d) {
                                        return '<input type="text" name="completedUser" class="layui-input" style="height: 100%;" value="' + (d.completedUser || '') + '">'
                                    }
                                }
                            ]
                            //策划要求
                            var cols2 = [
                                {type: 'numbers', title: '序号'},
                                {
                                    field: 'technical', title: '技术方案', minWidth: 140, templet: function (d) {
                                        return '<span technologyId="' + (d.technologyId || '') + '" planAskId="'+(d.planAskId || '')+'" planningTechnologyId="'+(d.planningTechnologyId || '')+'" class="technical">' + (d.technical || '') + '</span>'
                                    }
                                },
                                {field: 'technologyScheme', title: '方案描述', minWidth: 140},
                                {field: 'importanceLevel', title: '重要级别', minWidth: 140},
                                {
                                    field: 'projectUser', title: '项目责任人', minWidth: 140, templet: function (d) {
                                        return '<span projectUser="' + (d.projectUser || '') + '" class="projectUser">' + (d.projectUserName || '') + '</span>'
                                    }
                                },
                                {
                                    field: 'companyUser', title: '公司责任人', minWidth: 140, templet: function (d) {
                                        return '<span companyUser="' + (d.companyUser || '') + '" class="companyUser">' + (d.companyUserName || '') + '</span>'
                                    }
                                },
                                {field: 'plannedCompletionTime', title: '计划完成时间', minWidth: 160},
                                {field: 'fruitAsk', title: '成果物要求', minWidth: 150},
                                {
                                    field: 'isFinish', title: '是否已完成', minWidth: 150, templet: function (d) {
                                        return '<select name="isFinish">' +
                                            '<option value="">请选择</option>' +
                                            '<option value="0" '+(d.isFinish=='0'?'selected':'')+'>是</option>' +
                                            '<option value="1" '+(d.isFinish=='1'?'selected':'')+'>否</option>' +
                                            '</select>'
                                    }
                                }
                            ]
                            //查看详情
                            if(type!=4){
                                cols.push({align: 'center', toolbar: '#barPlan', title: '操作', minWidth: 100})
                                cols2.push({align: 'center', toolbar: '#barPlan', title: '操作',  minWidth: 100})
                            }
                            table.render({
                                elem: '#detailedTable',
                                data: data&&data.schemeDetailList||[],
                                height: data&&data.schemeDetailList&&data.schemeDetailList.length>5?'full-350':false,
                                toolbar: type==4?false:'#toolbarPlan',
                                defaultToolbar: [''],
                                limit: 1000,
                                cols: [cols],
                            });

                            table.render({
                                elem: '#objectivesTable',
                                data: data&&data.schemeLists||[],
                                height: data&&data.schemeLists&&data.schemeLists.length>5?'full-350':false,
                                toolbar: type==4?false:'#toolbarPlan2',
                                defaultToolbar: [''],
                                limit: 1000,
                                cols: [cols2],
                            });

                            //查看详情
                            if(type==4){
                                $('._disabled [name]').attr('disabled', 'disabled');
                                $('.refresh_no_btn').hide();
                                $('.file_upload_box').hide()
                                $('.deImgs').hide();
                            }

                            element.render();
                            form.render();
                        }else{
                            layer.msg("信息获取失败！")
                            return false;
                        }
                    }
                })
            }


            // 方案主要内容-加行
            table.on('toolbar(detailedTable)', function (obj) {
                switch (obj.event) {
                    case 'add':
                        //遍历表格获取每行数据进行保存
                        var dataArr = planningDetailsData().scheduleData;
                        dataArr.push({});
                        table.reload('detailedTable', {
                            data: dataArr,
                            height: dataArr&&dataArr.length>5?'full-350':false
                        });
                        break;
                }
            });
            // 方案主要内容-删行
            table.on('tool(detailedTable)', function (obj) {
                var data = obj.data;
                var layEvent = obj.event;
                var $tr = obj.tr;
                if (layEvent === 'del') {
                    if (data.mainSchemeId) {
                        $.get('/technologyScheme/del', {ids: data.mainSchemeId,type:"schemeDetail"}, function (res) {
                            if (res.flag) {
                                layer.msg('删除成功!', {icon: 1, time: 2000});
                                obj.del();
                                table.reload('detailedTable', {
                                    data: planningDetailsData().scheduleData,
                                    height: planningDetailsData().scheduleData&&planningDetailsData().scheduleData.length>5?'full-350':false
                                });
                            } else {
                                layer.msg('删除失败!', {icon: 2, time: 2000});
                            }
                        });
                    } else {
                        layer.msg('删除成功!', {icon: 1, time: 2000});
                        obj.del();
                        table.reload('detailedTable', {
                            data: planningDetailsData().scheduleData,
                            height: planningDetailsData().scheduleData&&planningDetailsData().scheduleData.length>5?'full-350':false
                        });
                    }
                }
            })

            // 策划要求-选择
            table.on('toolbar(objectivesTable)', function (obj) {
                switch (obj.event) {
                    case 'add':
                        layer.open({
                            type: 1,
                            title: '选择技术方案',
                            area: ['80%', '80%'],
                            btn: ['确定', '取消'],
                            btnAlign: 'c',
                            content: ['<div class="layui-form" style="padding:0px 10px">' +
                            '<div class="query_module layui-form layui-row" style="padding:10px">\n' +
                            '                <div class="layui-col-xs2">\n' +
                            '                    <input type="text" name="documentNo" placeholder="单据号" autocomplete="off" class="layui-input">\n' +
                            '                </div>\n' +
                            '                <div class="layui-col-xs2" style="margin-left: 10px">\n' +
                            '                    <input type="text" name="workPlanningName" id="" placeholder="策划名称" autocomplete="off" class="layui-input">\n' +
                            '                </div>\n' +
                            '                <div class="layui-col-xs2" style="margin-top: 3px;text-align: center">\n' +
                            '                    <button type="button" class="layui-btn layui-btn-sm InSearchData">查询</button>\n' +
                            '                </div>\n' +
                            '</div>' +
                            '<div>' +
                            '     <table id="tableDemoIn" lay-filter="tableDemoIn"></table>\n' +
                            '     <div id="downBox">\n' +
                            '         <table id="tableDemoInDown" lay-filter="tableDemoInDown"></table>\n' +
                            '      </div>' +
                            '</div>' +
                            '</div>'].join(''),
                            success: function () {
                                var tableDemoIn=table.render({
                                    elem: '#tableDemoIn',
                                    url: '/workPlanning/select?delFlag=0&projectId='+data.projectId,
                                    cols: [[
                                        {field: 'documentNo', title: '单据号', minWidth: 90,sort: true, hide: false},
                                        {field:'projectName',title:'项目名称',minWidth: 120,sort:true,hide:false},
                                        {field: 'workPlanningName', title: '策划名称', minWidth: 120,sort: true, hide: false},
                                        {field: 'createUserName', title: '编制人',minWidth: 120, sort: true, hide: false},
                                        {field: 'createTime', title: '编制时间',minWidth: 120, sort: true, hide: false},
                                        {field: 'memo', title: '备注',minWidth: 120, sort: true, hide: false}
                                    ]],
                                    // height: 'full-430',
                                    page: true
                                });
                                $('.InSearchData').click(function(){
                                    var documentNo=$('[name="documentNo"]').val();
                                    var workPlanningName=$('[name="workPlanningName"]').val();
                                    tableDemoIn.reload({
                                        where:{
                                            documentNo:documentNo,
                                            workPlanningName:workPlanningName
                                        }
                                    })
                                })
                            },
                            yes: function (index) {

                                var checkStatus = table.checkStatus('tableDemoInDown'); //获取选中行状态
                                var datas = checkStatus.data;  //获取选中行数据

                                //判断是否选择数据
                                if (datas.length == 0) {
                                    layer.msg('请选择一项！', {icon: 0});
                                    return false
                                }

                                //遍历表格获取每行数据进行保存
                                var dataArr = planningDetailsData().qualityData;

                                datas.forEach(function (item) {
                                    var obj = {
                                        planningTechnologyId: item.planningTechnologyId,
                                        technical: item.technologyName,
                                        technologyScheme: item.technologyDesc,
                                        importanceLevel: item.importanceLevel,
                                        projectUser: item.projectUser,
                                        projectUserName: item.projectUserName,
                                        companyUser: item.companyUser,
                                        companyUserName: item.companyUserName,
                                        plannedCompletionTime: item.planEndDate,
                                        fruitAsk: item.achieveRequire
                                    }
                                    if(dataArr){
                                        var _flag = true
                                        for(var j=0;j<dataArr.length;j++){
                                            if(dataArr[j].planningTechnologyId==obj.planningTechnologyId){
                                                _flag = false
                                            }
                                        }
                                        if(_flag){
                                            dataArr.push(obj)
                                        }
                                    }else{
                                        dataArr.push(obj)
                                    }
                                })
                                table.reload('objectivesTable', {
                                    data: dataArr,
                                    height: dataArr&&dataArr.length>5?'full-350':false
                                });
                                layer.close(index)
                            },
                        })
                        break;
                }
            });
            //监听行单击事件
            table.on('row(tableDemoIn)', function (obj) {
                // console.log(obj.data) //得到当前行数据
                var data = obj.data
                $('#downBox').show()
                obj.tr.addClass('selectTr').siblings('tr').removeClass('selectTr')
                tableShowDown(data.technologyList)
            });

            //技术策划明细表格
            function tableShowDown(data) {
                table.render({
                    elem: '#tableDemoInDown',
                    data: data,
                    cellMinWidth:150,
                    cols: [[
                        {type: 'checkbox'},
                        {field: 'technologyName', title: '技术方案'},
                        {field: 'technologyDesc', title: '方案描述'},
                        {field: 'importanceLevel', title: '重要级别'},
                        {field: 'projectUserName', title: '项目责任人'},
                        {field: 'companyUserName', title: '公司责任人'},
                        {field: 'planEndDate', title: '计划完成时间'},
                        {field: 'achieveRequire', title: '成果物要求'}
                    ]],
                    // height: 'full-430',
                    page: true,
                    done:function(res){
                        var oldDataArr = planningDetailsData().qualityData;
                        var _dataa=res.data;
                        if(oldDataArr!=undefined&&oldDataArr.length>0){
                            for(var i = 0 ; i <_dataa.length;i++){
                                for(var n = 0 ; n < oldDataArr.length; n++){
                                    if(_dataa[i].planningTechnologyId == oldDataArr[n].planningTechnologyId){
                                        $('.layui-table tr[data-index=' + i + '] input[type="checkbox"]').next(".layui-form-checkbox").click();
                                        //form.render('checkbox');
                                    }
                                }
                            }
                        }

                    }
                });
            }
            // 策划要求-删行
            table.on('tool(objectivesTable)', function (obj) {
                var data = obj.data;
                var layEvent = obj.event;
                var $tr = obj.tr;
                if (layEvent === 'del') {
                    if (data.planAskId) {
                        $.get('/technologyScheme/del', {ids: data.planAskId,type:"schemeList"}, function (res) {
                            if (res.flag) {
                                layer.msg('删除成功!', {icon: 1, time: 2000});
                                obj.del();
                                table.reload('objectivesTable', {
                                    data: planningDetailsData().qualityData,
                                    height: planningDetailsData().scheduleData&&planningDetailsData().scheduleData.length>5?'full-350':false
                                });
                            } else {
                                layer.msg('删除失败!', {icon: 2, time: 2000});
                            }
                        });
                    } else {
                        layer.msg('删除成功!', {icon: 1, time: 2000});
                        obj.del();
                        table.reload('objectivesTable', {
                            data: planningDetailsData().qualityData,
                            height: planningDetailsData().qualityData&&planningDetailsData().qualityData.length>5?'full-350':false
                        });
                    }
                }
            })
        })
    }

    /**
     * 获取子表数据
     */
    function planningDetailsData() {
        //遍历表格获取每行数据
        //方案主要内容
        var $trs = $('.project_detailed_information').find('.layui-table-main tr');
        var dataArr = [];
        $trs.each(function () {
            var dataObj = {
                technologyId: $(this).find('input[name="mainSchemeName"]').attr('technologyId') || '',
                mainSchemeId: $(this).find('input[name="mainSchemeName"]').attr('mainSchemeId') || '',
                mainSchemeName: $(this).find('input[name="mainSchemeName"]').val(),
                mainSchemeContent: $(this).find('input[name="mainSchemeContent"]').val(),
                completedUser: $(this).find('input[name="completedUser"]').val()
            }
            dataArr.push(dataObj);
        });

        //策划要求
        var $trs2 = $('.project_objectives').find('.layui-table-main tr');
        var dataArr2 = [];
        $trs2.each(function () {
            var dataObj = {
                technologyId: $(this).find('.technical').attr('technologyId') || '',
                planningTechnologyId: $(this).find('.technical').attr('planningTechnologyId') || '',
                planAskId: $(this).find('.technical').attr('planAskId') || '',
                technical: $(this).find('.technical').text(),
                technologyScheme: $(this).find('[data-field="technologyScheme"] div').text(),
                importanceLevel: $(this).find('[data-field="importanceLevel"] div').text(),
                projectUserName: $(this).find('.projectUser').text(),
                projectUser: $(this).find('.projectUser').attr('projectUser') || '',
                companyUserName: $(this).find('.companyUser').text(),
                companyUser: $(this).find('.companyUser').attr('companyUser') || '',
                plannedCompletionTime: $(this).find('[data-field="plannedCompletionTime"] div').text(),
                fruitAsk: $(this).find('[data-field="fruitAsk"] div').text(),
                isFinish: $(this).find('[name="isFinish"]').val()
            }
            dataArr2.push(dataObj);
        });

        return {
            scheduleData: dataArr,
            qualityData: dataArr2
        }
    }


    function childFunc() {
        if('0'!=_disabled){
            return true
        }
        var datas = $('#baseForm').serializeArray();
        var obj = {}
        datas.forEach(function (item) {
            obj[item.name] = item.value
        });

        obj.projectId = data.projectId


        if(type == '1'){
            obj.technologyId= data.technologyId;
        }

        // 附件
        var attachmentId = '';
        var attachmentName = '';
        for (var i = 0; i < $('#fileContent .dech').length; i++) {
            attachmentId += $('#fileContent .dech').eq(i).find('input').val();
            attachmentName += $('#fileContent .dech').eq(i).find("a").eq(0).attr('name');
        }
        obj.attachmentId = attachmentId;
        obj.attachmentName = attachmentName;

        obj.schemeDetailList = planningDetailsData().scheduleData;
        obj.schemeLists = planningDetailsData().qualityData;

        // 判断必填项
        var requiredFlag = false;
        $('#baseForm').find('.field_required').each(function(){
            var field = $(this).attr('field');
            if (!obj[field]) {
                var fieldName = $(this).parent().text().replace('*', '');
                layer.msg(fieldName+'不能为空！', {icon: 0, time: 2000});
                requiredFlag = true;
                return false;
            }
        });
        if (requiredFlag) {
            return false;
        }
        var loadIndex = layer.load();


        var _flag = false;

        $.ajax({
            url: '/technologyScheme/updateById',
            data:JSON.stringify(obj),
            // data: obj ,
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
