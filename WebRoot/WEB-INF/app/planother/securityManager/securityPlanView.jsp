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
    <title>安全检查计划预览</title>

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
        .layui-col-xs20{
            width: 20%;
        }
        .layui-col-xs40{
            width: 40%;
        }

        .project_detailed_information, .project_detailed_information .layui-table-cell,.project_detailed_information .layui-table-box,.project_detailed_information .layui-table-body {
            overflow: visible;
        }
        /* 设置下拉框的高度与表格单元格的高度相同 */
        .project_detailed_information td .layui-form-select {
            margin-top: -10px;
            margin-left: -15px;
            margin-right: -15px;
        }

        .layui-layer-content{
            overflow-x: hidden !important;
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
        <button class="layui-btn layui-btn-sm" lay-event="choice">选择</button>
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
    '               <div class="layui-col-xs2 layui-col-xs20" style="padding: 0 5px;">' +
    '                   <div class="layui-form-item">\n' +
    '                       <label class="layui-form-label form_label">单据号<span field="documentNo" class="field_required">*</span><a title="刷新单据号" class="refresh_no_btn"><i class="layui-icon layui-icon-refresh"></i></a></label>\n' +
    '                       <div class="layui-input-block form_block">\n' +
    '                       <input type="text" name="documentNo" readonly autocomplete="off" style="background: #e7e7e7" class="layui-input">\n' +
    '                       </div>\n' +
    '                   </div>' +
    '               </div>' +
    '               <div class="layui-col-xs2 layui-col-xs20" style="padding: 0 5px;">' +
    '                   <div class="layui-form-item">\n' +
    '                       <label class="layui-form-label form_label">项目名称<span field="projectName" class="field_required">*</span></label>\n' +
    '                       <div class="layui-input-block form_block">\n' +
    '                           <input type="text" name="projectName" id="projectName" readonly style="background: #e7e7e7" autocomplete="off" class="layui-input">' +
    '                       </div>\n' +
    '                   </div>' +
    '               </div>' +
    '               <div class="layui-col-xs2 layui-col-xs20" style="padding: 0 5px;">' +
    '                   <div class="layui-form-item">\n' +
    '                       <label class="layui-form-label form_label">检查计划名称<span field="securityPlanName" class="field_required">*</span></label>\n' +
    '                       <div class="layui-input-block form_block">\n' +
    '                           <input type="text" name="securityPlanName"  autocomplete="off" class="layui-input">' +
    '                       </div>\n' +
    '                   </div>' +
    '               </div>' +
    '               <div class="layui-col-xs2 layui-col-xs40" style="padding: 0 5px;">' +
    '                   <div class="layui-form-item">\n' +
    '                       <label class="layui-form-label form_label">计划描述<span field="planMemo" class="field_required">*</span></label>\n' +
    '                       <div class="layui-input-block form_block">\n' +
    '                           <input type="text" name="planMemo"  autocomplete="off" class="layui-input">' +
    '                       </div>\n' +
    '                   </div>' +
    '               </div>' +
    '           </div>' ,
        '           <div class="layui-row">' +
        '               <div class="layui-col-xs2 layui-col-xs20" style="padding: 0 5px;">' +
        '                   <div class="layui-form-item">\n' +
        '                       <label class="layui-form-label form_label">检查计划级别<span field="securityPlanLevel" class="field_required">*</span></label>\n' +
        '                       <div class="layui-input-block form_block">\n' +
        '                           <select id="securityPlanLevel" name="securityPlanLevel" ></select>' +
        '                       </div>\n' +
        '                   </div>' +
        '               </div>' +
        '               <div class="layui-col-xs2 layui-col-xs20" style="padding: 0 5px;">' +
        '                   <div class="layui-form-item">\n' +
        '                       <label class="layui-form-label form_label">检查计划类型<span field="securityPlanType" class="field_required">*</span></label>\n' +
        '                       <div class="layui-input-block form_block">\n' +
        '                           <select id="securityPlanType" name="securityPlanType" ></select>' +
        '                       </div>\n' +
        '                   </div>' +
        '               </div>' +
        '               <div class="layui-col-xs2 layui-col-xs20" style="padding: 0 5px;">' +
        '                   <div class="layui-form-item">\n' +
        '                       <label class="layui-form-label form_label">计划检查开始日期<span field="securityPlanBeginDate" class="field_required">*</span></label>\n' +
        '                       <div class="layui-input-block form_block">\n' +
        '                           <input type="text" name="securityPlanBeginDate"  id="securityPlanBeginDate" autocomplete="off" class="layui-input">' +
        '                       </div>\n' +
        '                   </div>' +
        '               </div>' +
        '               <div class="layui-col-xs2 layui-col-xs20" style="padding: 0 5px;">' +
        '                   <div class="layui-form-item">\n' +
        '                       <label class="layui-form-label form_label">计划检查结束日期<span field="securityPlanEndDate" class="field_required">*</span></label>\n' +
        '                       <div class="layui-input-block form_block">\n' +
        '                           <input type="text" name="securityPlanEndDate"  id="securityPlanEndDate" autocomplete="off" class="layui-input">' +
        '                       </div>\n' +
        '                   </div>' +
        '               </div>' +
        '           </div>' ,
        '           <div class="layui-row">' +
        '               <div class="layui-col-xs12" style="padding: 0 5px;">' +
        '                   <div class="layui-form-item">\n' +
        '                       <label class="layui-form-label form_label">附件</label>' +
        '                       <div class="layui-input-block form_block">' +
        '<div class="file_module">' +
        '<div id="fileContent" class="file_content"></div>' +
        '<div class="file_upload_box">' +
        '<a href="javascript:;" class="open_file">' +
        '<img src="/img/mg11.png" style="margin: -3px 5px 0 0;"><span>添加附件</span>' +
        '<input type="file" multiple id="fileupload" data-url="/upload?module=securityPlan" name="file">' +
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
        '    <h2 class="layui-colla-title">检查计划明细</h2>\n' +
        '    <div class="layui-colla-content layui-show project_detailed_information">' +
        '		<table id="detailedTable" lay-filter="detailedTable"></table>' +
        '    </div>\n' +
        '  </div>\n' +
        '  <div class="layui-colla-item">\n' +
        '    <h2 class="layui-colla-title">管理策划要求</h2>\n' +
        '    <div class="layui-colla-content layui-show project_objectives">' +
        '		<table id="objectivesTable" lay-filter="objectivesTable"></table>' +
        '    </div>\n' +
        '  </div>\n' +
        /* endregion */
        '</div>'].join('');

    $("#htm").html(htm)


    // 获取数据字典数据
    var dictionaryObj = {
        CHECK_FREQUENCY:{},
        INSPECTION_LEVEL:{},
        SECURITY_CHECK_TYPE:{}
    }
    var dictionaryStr = 'CHECK_FREQUENCY,INSPECTION_LEVEL,SECURITY_CHECK_TYPE';
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
                    url:"/securityPlan/getById",
                    data:param,
                    dataType:"json",
                    success:function(res){
                        if(res.code===0||res.code==="0"){
                             data = res.obj;

                            fileuploadFn('#fileupload', $('#fileContent'));
                            //回显项目名称
                            getProjName('#projectName',projectId?projectId:data.projectId)

                            //渲染检查计划级别
                            var str = '<option value="">请选择</option>'
                            if(dictionaryObj&&dictionaryObj['INSPECTION_LEVEL']&&dictionaryObj['INSPECTION_LEVEL']['str']){
                                str += dictionaryObj['INSPECTION_LEVEL']['str']
                            }
                            $('#inspectionlevel').html(str)
                            //渲染检查计划类型
                            var str = '<option value="">请选择</option>'
                            if(dictionaryObj&&dictionaryObj['SECURITY_CHECK_TYPE']&&dictionaryObj['SECURITY_CHECK_TYPE']['str']){
                                str += dictionaryObj['SECURITY_CHECK_TYPE']['str']
                            }
                            $('#testTypeNo').html(str)

                            //计划检查开始日期
                            laydate.render({
                                elem: '#securityPlanBeginDate'
                                , trigger: 'click'//呼出事件改成click
                                , format: 'yyyy-MM-dd'
                            });
                            //计划检查结束日期
                            laydate.render({
                                elem: '#securityPlanEndDate'
                                , trigger: 'click'//呼出事件改成click
                                , format: 'yyyy-MM-dd'
                            });

                            //回显数据
                            if (type == 1 || type == 4) {
                                form.val("formTest", data);

                                //附件
                                if (data.attachList && data.attachList.length > 0) {
                                    var fileArr = data.attachList;
                                    $('#fileContent').append(echoAttachment(fileArr));
                                }
                            }else{
                                // 获取自动编号
                                getAutoNumber({autoNumberType: 'securityPlan'}, function(res) {
                                    $('input[name="documentNo"]', $('#baseForm')).val(res.obj);
                                });
                                $('.refresh_no_btn').show().on('click', function() {
                                    getAutoNumber({autoNumberType: 'securityPlan'}, function(res) {
                                        $('input[name="documentNo"]', $('#baseForm')).val(res.obj);
                                    });
                                });
                            }

                            //检查计划明细
                            var cols = [
                                {type: 'numbers', title: '序号'},
                                {
                                    field: 'securityKnowledgeName', title: '检查项名称', minWidth: 160, templet: function (d) {
                                        return '<input type="text" name="securityKnowledgeName" re  class="layui-input" style="height: 100%;background: #e7e7e7;" value="' + (d.securityKnowledgeName || '') + '">'
                                    }
                                },
                                {
                                    field: 'mainDifficulties', title: '主要难点', minWidth: 160, templet: function (d) {
                                        return '<input type="text" name="mainDifficulties" class="layui-input" style="height: 100%;" value="' + (d.mainDifficulties || '') + '">'
                                    }
                                },
                                {
                                    field: 'mainRisk', title: '主要风险', minWidth: 160, templet: function (d) {
                                        return '<input type="text" name="mainRisk" class="layui-input" style="height: 100%;" value="' + (d.mainRisk || '') + '">'
                                    }
                                },
                                {
                                    field: 'riskSolutions', title: '风险解决措施', minWidth: 160, templet: function (d) {
                                        return '<input type="text" name="riskSolutions" class="layui-input" style="height: 100%;" value="' + (d.riskSolutions || '') + '">'
                                    }
                                },
                                {
                                    field: 'personLiableName', title: '责任人', minWidth: 160, event: 'chooseCollectionUser',templet: function (d) {
                                        return '<input type="text" name="personLiableName" id="personLiable_Name'+d.LAY_INDEX+'" user_id="'+(d.personLiable||'')+'" class="layui-input" style="height: 100%;" value="' + (d.personLiableName || '') + '">'
                                    }
                                },
                                {field: 'checkFrequency', title: '检查频率', minWidth: 100, templet: function (d) {
                                        var optionStr = '<option value="">请选择</option>';
                                        if(dictionaryObj.CHECK_FREQUENCY.object){
                                            for (index in dictionaryObj.CHECK_FREQUENCY.object){
                                                if(d.checkFrequency!=undefined&&index==d.checkFrequency){
                                                    optionStr += '<option value="'+index+'" selected>'+dictionaryObj.CHECK_FREQUENCY.object[index]+'</option>';
                                                }else{
                                                    optionStr += '<option value="'+index+'" >'+dictionaryObj.CHECK_FREQUENCY.object[index]+'</option>';
                                                }
                                            }
                                            return '<select name="checkFrequency" class="layui-input" style="height: 100%;"  value="' + (d.checkFrequency || '') + '">'+optionStr+'</select>'
                                        }else {
                                            return '';
                                        }
                                    }
                                },
                                {
                                    field: 'securityKnowledgeName', title: '检查详细内容', minWidth: 150, templet: function (d) {
                                        return '<input securityPlanId="' + (d.securityPlanId || '') + '" securityPlanDetailsId="'+(d.securityPlanDetailsId || '')+'" securityTermId="'+(d.securityTermId || '')+'" type="text" name="securityKnowledgeName" class="layui-input chooseMaterials" style="height: 100%;color: blue;background: #e7e7e7;cursor: pointer" readonly value="' + (d.securityKnowledgeName || '') + '">'
                                    }
                                }
                            ]
                            //管理策划要求
                            var cols2 = [
                                {type: 'numbers', title: '序号'},
                                {field: 'mainRisks', title: '主要重难点及风险',minWidth: 150, templet: function (d) {
                                        return '<span class="mainRisks" securityPlanId="'+(d.securityPlanId || '')+'" securityPlanInfoId="'+(d.securityPlanInfoId || '')+'" planingSecurityId="'+(d.planingSecurityId || '')+'"> '+(d.mainRisks || '')+'</span>'
                                    }},
                                {field: 'contentDesc', title: '内容描述',minWidth: 150},
                                {field: 'solutions', title: '解决措施',minWidth: 150},
                                {field: 'projectUserName', title: '项目责任人',minWidth: 150},
                                {field: 'companyUserName', title: '公司责任人',minWidth: 150}
                            ]
                            //查看详情
                            if(type!=4){
                                cols.push({align: 'center', toolbar: '#barPlan', title: '操作', minWidth: 100})
                                cols2.push({align: 'center', toolbar: '#barPlan', title: '操作', minWidth: 100})
                            }
                            table.render({
                                elem: '#detailedTable',
                                data: data&&data.details||[],
                                toolbar: type==4?false:'#toolbarPlan2',
                                defaultToolbar: [''],
                                limit: 1000,
                                cols: [cols],
                                done:function(res){
                                    $('.tips').on('mouseenter', function(){
                                        var content = $(this).val();
                                        if(!content){
                                            return false
                                        }

                                        this.index = layer.tips('<div style="padding: 10px; font-size: 14px; color: #eee;">'+ content + '</div>', this, {
                                            time: -1
                                            ,maxWidth: 280
                                            ,tips: [3, '#3A3D49']
                                        });
                                    }).on('mouseleave', function(){
                                        layer.close(this.index);
                                    });
                                }
                            });

                            table.render({
                                elem: '#objectivesTable',
                                data: data&&data.infoWithBLOBsList||[],
                                toolbar: type==4?false:'#toolbarPlan2',
                                defaultToolbar: [''],
                                limit: 1000,
                                cols: [cols2],
                                done:function(res){
                                    objectivesTableData = res.data
                                }
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


            // 检查计划明细-加行
            table.on('toolbar(detailedTable)', function (obj) {
                switch (obj.event) {
                    case 'choice':
                        layer.open({
                            type: 1,
                            title: '选择检查项',
                            area: ['80%', '80%'],
                            btn: ['确定', '取消'],
                            btnAlign: 'c',
                            content: ['<div class="layui-form" style="padding:0px 10px">' +
                            '<div class="query_module layui-form layui-row" style="padding:10px">\n' +
                            '                <div class="layui-col-xs2">\n' +
                            '                    <input type="text" name="documentNo" placeholder="单据号" autocomplete="off" class="layui-input">\n' +
                            '                </div>\n' +
                            '                <div class="layui-col-xs2" style="margin-top: 3px;text-align: center">\n' +
                            '                    <button type="button" class="layui-btn layui-btn-sm InSearch_Data">查询</button>\n' +
                            '                </div>\n' +
                            '</div>' +
                            '<div>' +
                            '     <table id="table_DemoIn" lay-filter="table_DemoIn"></table>\n' +
                            '</div>' +
                            '</div>'].join(''),
                            success: function () {
                                var table_DemoIn=table.render({
                                    elem: '#table_DemoIn',
                                    url: '/securityTerm/select?delFlag=0&projectId='+$('#leftId').attr('projId'),
                                    cols: [[
                                        {type: 'checkbox'},
                                        {field: 'documentNo', title: '单据号', minWidth: 90,sort: true, hide: false},
                                        {field: 'securityKnowledgeName', title: '检查项名称', minWidth: 120,sort: true, hide: false},
                                        {field: 'mainDifficulties', title: '主要隐患', minWidth: 120,sort: true, hide: false},
                                        {field: 'mainRisks', title: '主要风险', minWidth: 120,sort: true, hide: false},
                                        {field: 'solutions', title: '风险解决措施', minWidth: 120,sort: true, hide: false}
                                    ]],
                                    // height: 'full-430',
                                    page: true
                                });
                                $('.InSearch_Data').click(function(){
                                    var documentNo=$('[name="documentNo"]').val();
                                    table_DemoIn.reload({
                                        where:{
                                            documentNo:documentNo
                                        }
                                    })
                                })
                            },
                            yes: function (index) {

                                var checkStatus = table.checkStatus('table_DemoIn'); //获取选中行状态
                                var datas = checkStatus.data;  //获取选中行数据

                                //判断是否选择数据
                                if (datas.length == 0) {
                                    layer.msg('请选择一项！', {icon: 0});
                                    return false
                                }

                                //遍历表格获取每行数据进行保存
                                var dataArr = planningDetailsData().scheduleData;

                                datas.forEach(function (item) {
                                    item.mainRisk = item.mainRisks
                                    item.riskSolutions = item.solutions
                                })
                                dataArr = dataArr.concat(datas)

                                table.reload('detailedTable', {
                                    data: dataArr,
                                    height: dataArr&&dataArr.length>5?'full-350':false
                                });
                                layer.close(index)
                            },
                        })

                }
            });
            //检查详细内容
            $(document).on('click', '.chooseMaterials', function () {
                var loadIndex = layer.load();
                $.post('/securityTerm/getById', {kayId: $(this).attr('securityTermId')}, function (res) {
                    new_Edit(res.obj)
                    layer.close(loadIndex);
                })
            })
            // 检查计划明细-删行
            table.on('tool(detailedTable)', function (obj) {
                var data = obj.data;
                var layEvent = obj.event;
                var $tr = obj.tr;
                if (layEvent === 'del') {
                    if (data.securityPlanDetailsId) {
                        $.get('/securityPlan/del', {ids: data.securityPlanDetailsId,type:"planDetails"}, function (res) {
                            if (res.code == '0') {
                                layer.msg('删除成功!', {icon: 1, time: 2000});
                                obj.del();
                                table.reload('detailedTable', {
                                    data: planningDetailsData().scheduleData
                                });
                            } else {
                                layer.msg('删除失败!', {icon: 2, time: 2000});
                            }
                        });
                    } else {
                        layer.msg('删除成功!', {icon: 1, time: 2000});
                        obj.del();
                        table.reload('detailedTable', {
                            data: planningDetailsData().scheduleData
                        });
                    }
                }else if (layEvent == 'chooseCollectionUser') {
                    if(!$tr.find('[name="personLiableName"]').attr('disabled')){
                        user_id = $tr.find('[name="personLiableName"]').attr('id');
                        $.popWindow('/common/selectUser?0');
                    }
                }
            })


            // 管理策划要求-选择
            table.on('toolbar(objectivesTable)', function (obj) {
                switch (obj.event) {
                    case 'choice':
                        layer.open({
                            type: 1,
                            title: '选择管理策划',
                            area: ['80%', '80%'],
                            btn: ['确定', '取消'],
                            btnAlign: 'c',
                            content: ['<div class="layui-form" style="padding:0px 10px">' +
                            '<div class="query_module layui-form layui-row" style="padding:10px">\n' +
                            '                <div class="layui-col-xs2">\n' +
                            '                    <input type="text" name="documentNo" placeholder="单据号" autocomplete="off" class="layui-input">\n' +
                            '                </div>\n' +
                            '                <div class="layui-col-xs2" style="margin-left: 10px">\n' +
                            '                    <input type="text" name="managePlanningName" id="" placeholder="策划名称" autocomplete="off" class="layui-input">\n' +
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
                                    url: '/managePlanning/select?delFlag=0&projectId='+$('#leftId').attr('projId'),
                                    cols: [[
                                        {field: 'documentNo', title: '单据号', minWidth: 90,sort: true, hide: false},
                                        {field:'projectName',title:'项目名称',minWidth: 120,sort:true,hide:false},
                                        {field: 'managePlanningName', title: '策划名称', minWidth: 120,sort: true, hide: false},
                                        {field: 'createUserName', title: '编制人',minWidth: 120, sort: true, hide: false},
                                        {field: 'createTime', title: '编制时间',minWidth: 120, sort: true, hide: false},
                                        {field: 'managePlanningExplain', title: '策划说明',minWidth: 120, sort: true, hide: false}
                                    ]],
                                    // height: 'full-430',
                                    page: true
                                });
                                $('.InSearchData').click(function(){
                                    var documentNo=$('[name="documentNo"]').val();
                                    var managePlanningName=$('[name="managePlanningName"]').val();
                                    tableDemoIn.reload({
                                        where:{
                                            documentNo:documentNo,
                                            managePlanningName:managePlanningName
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
                                    if(dataArr){
                                        var _flag = true
                                        for(var j=0;j<dataArr.length;j++){
                                            if(dataArr[j].planingSecurityId==item.planingSecurityId){
                                                _flag = false
                                            }
                                        }
                                        if(_flag){
                                            dataArr.push(item)
                                        }
                                    }else{
                                        dataArr.push(item)
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
                tableShowDown(data.securityWithBLOBsList)
            });

            //技术策划明细表格
            function tableShowDown(data) {
                table.render({
                    elem: '#tableDemoInDown',
                    data: data,
                    cellMinWidth:150,
                    cols: [[
                        {type: 'checkbox'},
                        {field: 'mainRisks', title: '主要重难点及风险',minWidth: 150},
                        {field: 'contentDesc', title: '内容描述',minWidth: 150},
                        {field: 'solutions', title: '解决措施',minWidth: 150},
                        {field: 'projectUserName', title: '项目责任人',minWidth: 150},
                        {field: 'companyUserName', title: '公司责任人',minWidth: 150}
                    ]],
                    // height: 'full-430',
                    page: true,
                    done:function(res){
                        var oldDataArr = planningDetailsData().qualityData;
                        var _dataa=res.data;
                        if(oldDataArr!=undefined&&oldDataArr.length>0){
                            for(var i = 0 ; i <_dataa.length;i++){
                                for(var n = 0 ; n < oldDataArr.length; n++){
                                    if(_dataa[i].planingSecurityId == oldDataArr[n].planingSecurityId){
                                        $('.layui-table tr[data-index=' + i + '] input[type="checkbox"]').next(".layui-form-checkbox").click();
                                        //form.render('checkbox');
                                    }
                                }
                            }
                        }

                    }
                });
            }
            // 管理策划要求-删行
            table.on('tool(objectivesTable)', function (obj) {
                var data = obj.data;
                var layEvent = obj.event;
                var $tr = obj.tr;
                if (layEvent === 'del') {
                    if (data.securityPlanInfoId) {
                        $.get('/securityPlan/del', {ids: data.securityPlanInfoId,type:"planInfo"}, function (res) {
                            if (res.code == '0') {
                                layer.msg('删除成功!', {icon: 1, time: 2000});
                                obj.del();
                                table.reload('objectivesTable', {
                                    data: planningDetailsData().qualityData
                                });
                            } else {
                                layer.msg('删除失败!', {icon: 2, time: 2000});
                            }
                        });
                    } else {
                        layer.msg('删除成功!', {icon: 1, time: 2000});
                        obj.del();
                        table.reload('objectivesTable', {
                            data: planningDetailsData().qualityData
                        });
                    }
                }
            })
            function new_Edit(data) {
                var projectId = $('#leftId').attr('projId');
                layer.open({
                    type: 1,
                    title: '检查详细内容',
                    area: ['90%', '90%'],
                    btn: ['确定'],
                    btnAlign: 'c',
                    content: '<div style="margin:20px"><table id="detailed_Table" lay-filter="detailed_Table"></table></div>',
                    success: function () {

                        //检查计划明细
                        var cols = [
                            // {type: 'radio'},
                            {type: 'numbers', title: '序号'},
                            {field: 'securityDanger', minWidth:150,title: '检查内容'},
                            {field: 'securityDangerMeasures', minWidth:150,title: '整改措施'},
                            {field: 'securityDangerGrade',minWidth:100, title: '隐患级别',templet:function(d){
                                    if(d.securityDangerGrade!=undefined&&d.securityDangerGrade!=""){
                                        if(d.securityDangerGrade===0||d.securityDangerGrade==="0"){
                                            return '<span securityDangerGrade="'+(d.securityDangerGrade || '')+'" securityTermId="'+(d.securityTermId || '')+'" securityTermDetailId="'+(d.securityTermDetailId || '')+'" securityDangerId="'+(d.securityDangerId || '')+'" securityDangerTypeId="'+(d.securityDangerTypeId || '')+'" index="'+(d.index || d.LAY_INDEX || '')+'">重大隐患</span>';
                                        }else{
                                            return '<span securityDangerGrade="'+(d.securityDangerGrade || '')+'" securityTermId="'+(d.securityTermId || '')+'" securityTermDetailId="'+(d.securityTermDetailId || '')+'" securityDangerId="'+(d.securityDangerId || '')+'" securityDangerTypeId="'+(d.securityDangerTypeId || '')+'" index="'+(d.index || d.LAY_INDEX || '')+'">一般隐患</span>';
                                        }
                                    }else{
                                        return '<span securityDangerGrade="'+(d.securityDangerGrade || '')+'" securityTermId="'+(d.securityTermId || '')+'" securityTermDetailId="'+(d.securityTermDetailId || '')+'" securityDangerId="'+(d.securityDangerId || '')+'" securityDangerTypeId="'+(d.securityDangerTypeId || '')+'" index="'+(d.index ||  d.LAY_INDEX || '')+'"></span>';
                                    }
                                }
                            }
                        ]

                        table.render({
                            elem: '#detailed_Table',
                            data: data&&data.detailList||[],
                            defaultToolbar: [''],
                            limit: 1000,
                            cols: [cols],
                            done:function(res){
                                $('.layui-table-body [data-field="securityDanger"] div,.layui-table-body [data-field="securityDangerMeasures"] div').on('mouseenter', function(){
                                    var content = $(this).text();
                                    if(!content){
                                        return false
                                    }

                                    this.index = layer.tips('<div style="padding: 10px; font-size: 14px; color: #eee;">'+ content + '</div>', this, {
                                        time: -1
                                        ,maxWidth: 280
                                        ,tips: [3, '#3A3D49']
                                    });
                                }).on('mouseleave', function(){
                                    layer.close(this.index);
                                });
                            }
                        });

                        form.render();
                    },
                    yes: function (index) {
                        layer.close(index);
                    }
                });
            }
        })
    }

    /**
     * 获取子表数据
     */
    function planningDetailsData() {
        //遍历表格获取每行数据
        //检查计划明细
        var $trs = $('.project_detailed_information').find('.layui-table-main tr');
        var dataArr = [];
        $trs.each(function () {
            var schDom=$(this).find('input[name="personLiableName"]');
            var scheduleUser = $(schDom).attr('user_id')||''
            if(scheduleUser&&scheduleUser.indexOf(',')!=-1){
                scheduleUser=scheduleUser.substring(0,scheduleUser.lastIndexOf(','))
            }
            var dataObj = {
                securityPlanId: $(this).find('input[name="securityKnowledgeName"]').attr('securityPlanId') || '',
                securityPlanDetailsId: $(this).find('input[name="securityKnowledgeName"]').attr('securityPlanDetailsId') || '',
                securityTermId: $(this).find('input[name="securityKnowledgeName"]').attr('securityTermId') || '',
                securityKnowledgeName: $(this).find('input[name="securityKnowledgeName"]').val(),
                // inspectionContent: $(this).find('input[name="inspectionContent"]').val(),
                mainDifficulties: $(this).find('input[name="mainDifficulties"]').val(),
                mainRisk: $(this).find('input[name="mainRisk"]').val(),
                riskSolutions: $(this).find('input[name="riskSolutions"]').val(),
                personLiableName: $(this).find('input[name="personLiableName"]').val(),
                personLiable: scheduleUser,
                checkFrequency: $(this).find('[name="checkFrequency"]').val(),
            }
            dataArr.push(dataObj);
        });

        //管理策划要求
        var $trs2 = $('.project_objectives').find('.layui-table-main tr');
        var dataArr2 = [];
        $trs2.each(function () {
            var dataObj = {
                securityPlanId: $(this).find('.mainRisks').attr('securityPlanId') || '',
                securityPlanInfoId: $(this).find('.mainRisks').attr('securityPlanInfoId') || '',
                planingSecurityId: $(this).find('.mainRisks').attr('planingSecurityId') || '',
                mainRisks: $(this).find('.mainRisks').text(),
                contentDesc: $(this).find('[data-field="contentDesc"]').text(),
                solutions:  $(this).find('[data-field="solutions"]').text(),
                projectUserName:  $(this).find('[data-field="projectUserName"]').text(),
                companyUserName:  $(this).find('[data-field="companyUserName"]').text()
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

        obj.projectId = data.projectId;


        if(type == '1'){
            obj.securityPlanId= data.securityPlanId;
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

        obj.details = planningDetailsData().scheduleData;
        obj.infoWithBLOBsList = planningDetailsData().qualityData;

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


        var _flag = false;

        $.ajax({
            url: '/securityPlan/updateById',
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
