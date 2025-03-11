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
    <title>安全检查计划</title>

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


    </style>
</head>
<body>
<div class="container">
    <input type="hidden" id="leftId" class="layui-input">
    <div class="wrapper">
        <div class="wrap_left">
            <h2 style="text-align: center;line-height: 35px;">安全检查计划</h2>
            <div class="left_form">
                <div class="search_icon">
                    <i class="layui-icon layui-icon-search"></i>
                </div>
                <input type="text" name="title" id="search_project" placeholder="项目名称" autocomplete="off"
                       class="layui-input"/>
            </div>
            <div class="tree_module">
                <div id="leftTree" class="eleTree" lay-filter="leftTree"></div>
            </div>
        </div>
        <div class="wrap_right">
            <div class="query_module layui-form layui-row" style="position: relative">
                <div class="layui-col-xs2">
                    <input type="text" name="documentNo" placeholder="单据号" autocomplete="off" class="layui-input">
                </div>
                    <div class="layui-col-xs2" style="margin-left: 15px;">
                        <input type="text" name="securityPlanName" placeholder="检查计划名称" autocomplete="off" class="layui-input">
                    </div>
                <div class="layui-col-xs2" style="margin-left: 15px;">
                    <select name="auditerStatus">
                        <option value="">请选择审批状态</option>
                        <option value="0">未提交</option>
                        <option value="1">审批中</option>
                        <option value="2">批准</option>
                        <option value="3">不批准</option>
                    </select>
                </div>
                <div class="layui-col-xs2" style="margin-top: 3px;text-align: center">
                    <button type="button" class="layui-btn layui-btn-sm searchData">查询</button>
                    <%--                    <button type="button" class="layui-btn layui-btn-sm">高级查询</button>--%>
                </div>
                <div style="position: absolute;top: -1px;right: 10px;height: 35px;line-height: 35px;">
                    <i class="layui-icon layui-icon-read icon_img" style="margin-right: 15px" text="知识库"></i>
                    <i class="layui-icon layui-icon-survey icon_img" text="帮助"></i>
                </div>
            </div>
            <div style="position: relative">
                <div class="table_box" style="display: none">
                    <table id="tableDemo" lay-filter="tableDemo"></table>
                </div>
                <div class="no_data" style="text-align: center;">
                    <div class="no_data_img" style="margin-top:12%;">
                        <img style="margin-top: 2%;" src="/img/noData.png">
                    </div>
                    <p style="text-align: center; font-size: 20px; font-weight: normal;">请选择左侧项目</p>
                </div>
            </div>
        </div>
    </div>
</div>

<script type="text/html" id="toolbarDemo">
    <div class="layui-btn-container" style="height: 30px;">
        <button class="layui-btn layui-btn-sm layui-btn-normal" lay-event="choice">选择</button>
<%--        <button class="layui-btn layui-btn-sm layui-btn-normal" lay-event="add">新建</button>--%>
<%--        <button class="layui-btn layui-btn-sm" lay-event="edit">编辑</button>--%>
        <button class="layui-btn layui-btn-sm layui-btn-danger" lay-event="del">删除</button>
    </div>
    <div style="position:absolute;top: 10px;right:60px;">
        <button class="layui-btn layui-btn-sm" lay-event="preservation" style="margin-left:10px;">保存</button>
        <button class="layui-btn layui-btn-sm" lay-event="submit" style="margin-left:10px;">提交审批</button>
        <button class="layui-btn layui-btn-sm" lay-event="import" style="margin-left:10px;">导入</button>
        <button class="layui-btn layui-btn-sm" lay-event="export" style="margin-left:10px;">导出</button>
        <%--<div class="export_moudle">
            <p class="export_btn" type="1">导出所选数据</p>
            <p class="export_btn" type="2">导出当前页数据</p>
            <p class="export_btn" type="3">导出全部数据</p>
        </div>--%>
    </div>
</script>

<script type="text/html" id="detailBarDemo">
    <a class="layui-btn  layui-btn-xs" lay-event="detail">查看详情</a>
</script>

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

    var tipIndex = null;
    $('.icon_img').hover(function () {
        var tip = $(this).attr('text')
        tipIndex = layer.tips(tip, this)
    }, function () {
        layer.close(tipIndex)
    });

    var objectivesTableData = []

    var tableIns = null;
    layui.use(['form', 'laydate', 'table', 'element', 'eleTree', 'layer','soulTable'], function () {
        var laydate = layui.laydate;
        var form = layui.form;
        var table = layui.table;
        var element = layui.element;
        var eleTree = layui.eleTree;
        var layer = layui.layer;
        var soulTable = layui.soulTable;


        form.render();
        //表格显示顺序
        var colShowObj = {
            documentNo: {field: 'documentNo', title: '单据号', minWidth: 90,templet: function (d) {
                    return '<span securityPlanId="'+(d.securityPlanId||'')+'">'+(d.documentNo||'')+'</span>'
                }},
            projectName:{field:'projectName',title:'项目名称',minWidth: 120},
            securityKnowledgeName2: {field: 'securityKnowledgeName', title: '检查项名称', minWidth: 120},
            solutions:{field: 'solutions', title: '检查项描述', minWidth: 160},
            personLiableName: {field: 'personLiableName', title: '责任人', minWidth: 100},
            checkFrequency:{field: 'checkFrequency', title: '检查频率', minWidth: 100, templet: function (d) {
                    return '<span class="checkFrequency" checkFrequency="'+(d.checkFrequency || '') +'" >' + (d.checkFrequency&&dictionaryObj["CHECK_FREQUENCY"]?dictionaryObj["CHECK_FREQUENCY"].object[d.checkFrequency] : '') + '</span>'
                }},
            importance:{field: 'importance', title: '重要性', minWidth: 80, templet: function (d) {
                    return '<span class="importance" importance="'+(d.importance || '') +'" >' + (d.importance&&dictionaryObj["SCHEDULE_INPORTANCE"]?dictionaryObj["SCHEDULE_INPORTANCE"].object[d.importance] : '') + '</span>'
                }},
            securityKnowledgeName:{field: 'securityKnowledgeName', title: '检查详细内容',minWidth: 150, templet: function (d) {
                    return '<span  securityTermId="'+(d.securityTermId || '')+'" personLiable="'+(d.personLiable || '')+'" class="securityKnowledgeName chooseMaterials2"  style="cursor: pointer;color: blue;">' + (d.securityKnowledgeName || '') + '</span>'
                }},
            securityPlanBeginDate: {field: 'securityPlanBeginDate', title: '计划检查开始日期', minWidth: 150,templet: function (d) {
                    return '<input type="text" name="securityPlanBeginDate" autocomplete="off" onfocus="clickdata(this)" class="layui-input" '+(d.auditerStatus&&d.auditerStatus!='0'?'disabled':'')+' style="height: 100%;'+(d.auditerStatus&&d.auditerStatus!='0'?"background: #e7e7e7":"")+'" value="' + (d.securityPlanBeginDate||'') + '">'
                }},
            securityPlanEndDate: {field: 'securityPlanEndDate', title: '计划检查结束日期', minWidth: 150,templet: function (d) {
                    return '<input type="text" name="securityPlanEndDate" autocomplete="off" onfocus="clickdata(this)" class="layui-input" '+(d.auditerStatus&&d.auditerStatus!='0'?'disabled':'')+' style="height: 100%;'+(d.auditerStatus&&d.auditerStatus!='0'?"background: #e7e7e7":"")+'" value="' + (d.securityPlanEndDate||'') + '">'
                }},
            workPlanningName: {field: 'workPlanningName', title: '所属策划', minWidth: 150,templet: function (d) {
                    if(d.workPlanningId){
                        return '<span class="workPlanningName" workPlanningId="'+(d.workPlanningId||"")+'"> ' + (d.workPlanningName||'') + '</span>'
                    }
                    return '<input type="text" name="workPlanningName" workPlanningId="'+(d.workPlanningId||"")+'" placeholder="请选择" autocomplete="off" onclick="workPlan_choice(this)" readonly class="layui-input workPlanningName" '+(d.auditerStatus&&d.auditerStatus!='0'?'disabled':'')+' style="height: 100%;background: #e7e7e7;cursor: pointer" value="' + (d.workPlanningName||'') + '">'
                }},
            currFlowUserName: {field: 'currFlowUserName', title: '当前处理人',minWidth: 110},
            auditerStatus: {
                field: 'auditerStatus',
                title: '审核状态',
                minWidth: 120,
                sort: true,
                hide: false,
                templet: function (d) {
                    var str = '';
                    switch (d.auditerStatus) {
                        case '0':
                            str = '未提交';
                            break;
                        case '1':
                            var flowStr = d.flowRun ? 'flowId="' + (d.flowRun.flowId || '') + '" runId="' + (d.flowRun.runId || '') + '"' : '';
                            str = '<span class="preview_flow" style="color: orange;cursor: pointer;text-decoration: underline;" ' + flowStr + '>审批中</span>';
                            break;
                        case '2':
                            var flowStr = d.flowRun ? 'flowId="' + (d.flowRun.flowId || '') + '" runId="' + (d.flowRun.runId || '') + '"' : '';
                            str = '<span class="preview_flow" style="color: green;cursor: pointer;text-decoration: underline;" ' + flowStr + '>批准</span>';
                            break;
                        case '3':
                            var flowStr = d.flowRun ? 'flowId="' + (d.flowRun.flowId || '') + '" runId="' + (d.flowRun.runId || '') + '"' : '';
                            str = '<span class="preview_flow" style="color: red;cursor: pointer;text-decoration: underline;" ' + flowStr + '>不批准</span>';
                            break;
                    }
                    return str;
                }
            }
        }

        // 获取数据字典数据
        var dictionaryObj = {
            CHECK_FREQUENCY:{},
            INSPECTION_LEVEL:{},
            SECURITY_CHECK_TYPE:{},
            SCHEDULE_INPORTANCE:{}
        }
        var dictionaryStr = 'CHECK_FREQUENCY,INSPECTION_LEVEL,SECURITY_CHECK_TYPE,SCHEDULE_INPORTANCE';
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
        });

        var TableUIObj = new TableUI('plb_security_plant12');


        // 初始化左侧项目
        projectLeft();
        // 上方按钮显示
        table.on('toolbar(tableDemo)', function (obj) {
            var checkStatus = table.checkStatus(obj.config.id);
            var dataTable=table.checkStatus(obj.config.id).data;
            switch (obj.event) {
                case 'choice':
                    if($('#leftId').attr('projId')){
                        layer.open({
                            type: 1,
                            title: '选择安全检查项',
                            area: ['80%', '80%'],
                            btn: ['确定', '取消'],
                            btnAlign: 'c',
                            content: ['<div class="layui-form table_DemoIn" style="padding:0px 10px">' +
                            '<div class="query_module layui-form layui-row" style="padding:10px">\n' +
                            '                <div class="layui-col-xs2">\n' +
                            '                    <input type="text" name="documentNo" placeholder="单据号" autocomplete="off" class="layui-input">\n' +
                            '                </div>\n' +
                            // '                <div class="layui-col-xs2" style="margin-left: 10px">\n' +
                            // '                    <input type="text" name="securityPlanName" id="" placeholder="检查计划名称" autocomplete="off" class="layui-input">\n' +
                            // '                </div>\n' +
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
                                    url: '/securityTerm/selectSecurityTerm?delFlag=0&projectId='+$('#leftId').attr('projId'),
                                    cols: [[
                                        {checkbox: true},
                                        {field: 'documentNo', title: '单据号', minWidth: 90},
                                        // {field:'projectName',title:'项目名称',minWidth: 120,sort:true,hide:false},
                                        {field: 'securityKnowledgeName', title: '检查项名称', minWidth: 120},
                                        {field: 'personLiableName', title: '检查人', minWidth: 120},
                                        {field: 'checkFrequency', title: '检查频率', minWidth: 100, templet: function (d) {
                                                return '<span class="checkFrequency" checkFrequency="'+(d.checkFrequency || '') +'" >' + (d.checkFrequency&&dictionaryObj["CHECK_FREQUENCY"]?dictionaryObj["CHECK_FREQUENCY"].object[d.checkFrequency] : '') + '</span>'
                                            }},
                                        {field: 'importance', title: '重要性', minWidth: 100, templet: function (d) {
                                                return '<span class="importance" importance="'+(d.importance || '') +'" >' + (d.importance&&dictionaryObj["SCHEDULE_INPORTANCE"]?dictionaryObj["SCHEDULE_INPORTANCE"].object[d.importance] : '') + '</span>'
                                            }},
                                        {field: 'solutions', title: '检查项描述', minWidth: 160}
                                    ]],
                                    // height: 'full-430',
                                    page: true,
                                    done:function(res){
                                        var oldDataArr = planningDetailsData().securityData;
                                        var _dataa=res.data;
                                        if(oldDataArr!=undefined&&oldDataArr.length>0){
                                            for(var i = 0 ; i <_dataa.length;i++){
                                                for(var n = 0 ; n < oldDataArr.length; n++){
                                                    if(_dataa[i].securityTermId == oldDataArr[n].securityTermId){
                                                        $('.table_DemoIn .layui-table tr[data-index=' + i + '] input[type="checkbox"]').next(".layui-form-checkbox").click();
                                                        //form.render('checkbox');
                                                    }
                                                }
                                            }
                                        }

                                    }
                                });
                                $('.InSearchData').click(function(){
                                    var documentNo=$('[name="documentNo"]').val();
                                    // var securityPlanName=$('[name="securityPlanName"]').val();
                                    tableDemoIn.reload({
                                        where:{
                                            documentNo:documentNo,
                                            // securityPlanName:securityPlanName
                                        }
                                    })
                                })
                            },
                            yes: function (index) {

                                var checkStatus = table.checkStatus('tableDemoIn'); //获取选中行状态
                                var datas = checkStatus.data;  //获取选中行数据

                                //判断是否选择数据
                                if (datas.length == 0) {
                                    layer.msg('请选择一项！', {icon: 0});
                                    return false
                                }

                                //遍历表格获取每行数据进行保存
                                var dataArr = planningDetailsData().securityData;

                                datas.forEach(function (item) {
                                    if(dataArr){
                                        var _flag = true
                                        for(var j=0;j<dataArr.length;j++){
                                            if(dataArr[j].securityTermId==item.securityTermId){
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
                                table.reload('tableDemo', {
                                    data: dataArr,
                                    url:''
                                    // height: dataArr&&dataArr.length>5?'full-350':false
                                });
                                layer.close(index)
                            },
                        })
                    }else{
                        layer.msg('请选择左侧项目！', {icon: 0, time: 1500});
                        return false;
                    }
                    break;
                case 'del':
                    if (!checkStatus.data.length) {
                        layer.msg('请至少选择一项！', {icon: 0});
                        return false
                    }
                    var securityPlanId = ''
                    var $trs = $('.table_box .layui-table-body .layui-form-checked').parents('tr').find('[data-field="documentNo"] span')
                    $trs.each(function(){
                        securityPlanId += $(this).attr('securityPlanId') + ','
                    })
                    // checkStatus.data.forEach(function (v, i) {
                    // 	securityPlanId += v.securityPlanId + ','
                    // })
                    layer.confirm('确定删除该条数据吗？', function (index) {
                        $.post('/security2Plan/del', {ids: securityPlanId}, function (res) {
                            if (res.code=='0') {
                                layer.msg('删除成功！', {icon: 1});
                            } else {
                                layer.msg('删除失败！', {icon: 0});
                            }
                            layer.close(index)
                            tableIns.config.where._ = new Date().getTime();
                            tableIns.reload()
                        })
                    });
                    break;
                case 'preservation':
                    var dataArr = planningDetailsData().securityData;
                    var loadIndex = layer.load();
                    $.ajax({
                        url: '/security2Plan/insert',
                        data: JSON.stringify(dataArr),
                        dataType: 'json',
                        contentType: "application/json;charset=UTF-8",
                        type: 'post',
                        success: function (res) {
                            layer.close(loadIndex);
                            if (res.code=='0') {
                                layer.msg('保存成功！', {icon: 1});
                                layer.close(index);
                                tableIns.config.where._ = new Date().getTime();
                                tableIns.reload();
                            } else {
                                layer.msg(res.msg, {icon: 7});
                            }
                        }
                    });
                    break;
                case 'submit':
                    if (checkStatus.data.length != 1) {
                        layer.msg('请选择一条需要提交的数据！', {icon: 0, time: 2000});
                        return false;
                    }
                    if(checkStatus.data[0].auditerStatus != '0'){
                        layer.msg('该数据已提交！', {icon: 0, time: 2000});
                        return false;
                    }
                    layer.open({
                        type: 1,
                        title: '选择流程',
                        area: ['70%', '80%'],
                        btn: ['确定', '取消'],
                        btnAlign: 'c',
                        content: '<div style="padding: 10px"><table id="flowTable" lay-filter="flowTable"></table></div>',
                        success: function () {
                            $.get('/plbFlowSetting/getOwnFlowData', {plbDictNo: '72'}, function (res) {
                                var flowData = []
                                $.each(res.data.flowData, function (k, v) {
                                    flowData.push({
                                        flowId: k,
                                        flowName: v
                                    });
                                });
                                table.render({
                                    elem: '#flowTable',
                                    data: flowData,
                                    cols: [[
                                        {type: 'radio'},
                                        {field: 'flowName', title: '流程名称'}
                                    ]]
                                })
                            });
                        },
                        yes: function (index) {
                            var loadIndex = layer.load();
                            var checkStatus = table.checkStatus('flowTable');
                            if (checkStatus.data.length > 0) {
                                var flowData = checkStatus.data[0];
                                var approvalData = table.checkStatus(obj.config.id).data[0]
                                approvalData.projectName=approvalData.projName==undefined?approvalData.projectName:approvalData.projName;
                                approvalData.projectName=approvalData.projectName==undefined?approvalData.projName:approvalData.projectName;
                                newWorkFlow(flowData.flowId, function (res) {
                                    var submitData = {
                                        securityPlanId:approvalData.securityPlanId,
                                        runId: res.flowRun.runId,
                                        //auditerStatus:1
                                    }
                                    $.popWindow("/workflow/work/workform?opflag=1&flowId=" + flowData.flowId + '&type=new&flowStep=1&prcsId=1&runId=' + res.flowRun.runId, '<fmt:message code="newWork.th.Quick" />', '0', '0', '1150px', '700px');

                                    $.ajax({
                                        url: '/security2Plan/updateById',
                                        data: submitData,//JSON.stringify(submitData),
                                        dataType: 'json',
                                        //contentType: "application/json;charset=UTF-8",
                                        type: 'post',
                                        success: function (res) {
                                            layer.close(loadIndex);
                                            if (res.code=='0') {
                                                layer.close(index);
                                                layer.msg('提交成功!', {icon: 1});
                                                tableIns.config.where._ = new Date().getTime();
                                                tableIns.reload()
                                            } else {
                                                layer.msg(res.msg, {icon: 2});
                                            }
                                        }
                                    });
                                },approvalData);
                            } else {
                                layer.close(loadIndex);
                                layer.msg('请选择一项！', {icon: 0});
                            }
                        }
                    });
                    break;
                case 'import'://导入
                    layer.msg("功能正在开发中");
                    break;
                case 'export'://导出
                    layer.msg("功能正在开发中");
                    break;
            }
        });

        //监听行单击事件
        table.on('row(tableDemoIn)', function (obj) {
            // console.log(obj.data) //得到当前行数据
            var data = obj.data
            $('#downBox').show()
            // obj.tr.addClass('selectTr').siblings('tr').removeClass('selectTr')
            var loadIndex = layer.load();
            $.post('/securityTerm/getById', {kayId: data.securityTermId}, function (res) {
                tableShowDown(res.obj&&res.obj.detailList)
                layer.close(loadIndex);
            })
        });

        //安全检查计划明细表
        function tableShowDown(data) {
            table.render({
                elem: '#tableDemoInDown',
                data: data,
                cellMinWidth:150,
                cols: [[
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
                ]],
                // height: 'full-430',
                page: true,
                done:function(res){

                }
            });
        }

        //安全 检查详细内容
        $(document).on('click', '.chooseMaterials2', function () {
            var loadIndex = layer.load();
            $.post('/securityTerm/getById', {kayId: $(this).attr('securityTermId')}, function (res) {
                new_Edit2(res.obj)
                layer.close(loadIndex);
            })
        })

        //安全 检查详细内容
        function new_Edit2(data) {
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

                        }
                    });

                    form.render();
                },
                yes: function (index) {
                    layer.close(index);
                }
            });
        }
        // 监听排序事件
        table.on('sort(tableDemo)', function (obj) {
            var param = {
                orderbyFields: obj.field,
                orderbyUpdown: obj.type
            }

            TableUIObj.update(param, function () {
                tableShow($('#leftId').attr('projId'))
            })
        });


        // 监听筛选列
        form.on('checkbox()', function (data) {
            //判断监听的复选框是筛选列下的复选框
            if ($(data.elem).attr('lay-filter') == 'LAY_TABLE_TOOL_COLS') {
                setTimeout(function () {
                    var $parent = $(data.elem).parent().parent()
                    var arr = []
                    $parent.find('input[type="checkbox"]').each(function () {
                        var obj = {
                            showFields: $(this).attr('name'),
                            isShow: !$(this).prop('checked')
                        }
                        arr.push(obj)
                    })
                    var param = {showFields: JSON.stringify(arr)}
                    TableUIObj.update(param)
                }, 1000)
            }
        });

        var searchTimer = null
        $('#search_project').on('input propertychange', function () {
            clearTimeout(searchTimer)
            searchTimer = null
            var val = $(this).val()
            searchTimer = setTimeout(function () {
                projectLeft(val)
            }, 300)
        });
        $('.search_icon').on('click', function () {
            projectLeft($('#search_project').val())
        });

        //左侧项目信息列表
        function projectLeft(projectName) {
            projectName = projectName ? projectName : ''
            var loadingIndex = layer.load();
            $.get('/plbOrg/treeListOrg', {projectName: projectName}, function (res) {
                layer.close(loadingIndex);
                if (res.flag) {
                    eleTree.render({
                        elem: '#leftTree',
                        data: res.data,
                        highlightCurrent: true,
                        showLine: true,
                        defaultExpandAll: false,
                        request: {
                            name: 'name',
                            children: "plbProjList",
                        }
                    });
                    TableUIObj.init(colShowObj,function () {
                        // tableShow('')
                    });
                }
            });
        }

        // 树节点点击事件
        eleTree.on("nodeClick(leftTree)", function (d) {
            var currentData = d.data.currentData;
            if (currentData.projId) {
                $('#leftId').attr('projId', currentData.projId);
                $('.no_data').hide();
                $('.table_box').show();
                tableShow(currentData.projId);
            } else {
                $('.table_box').hide();
                $('.no_data').show();
            }
        });

        // 渲染表格
        function tableShow(projId) {
            var cols = [{checkbox: true}].concat(TableUIObj.cols)

            // cols.push({
            //     fixed: 'right',
            //     align: 'center',
            //     toolbar: '#detailBarDemo',
            //     title: '操作',
            //     width: 100
            // })

            tableIns = table.render({
                elem: '#tableDemo',
                url: '/security2Plan/select',
                toolbar: '#toolbarDemo',
                cols: [cols],
                defaultToolbar: ['filter'],
                height: 'full-80',
                // page: {
                //     limit: TableUIObj.onePageRecoeds,
                //     limits: [10, 20, 30, 40, 50]
                // },
                limit:100000000,
                where: {
                    projId: projId,
                    projectId: projId,
                    delFlag: '0'
                    //orderbyFields: upperFieldMatch(TableUIObj.orderbyFields),
                    //orderbyUpdown: TableUIObj.orderbyUpdown
                },
                autoSort: false,
                // parseData: function (res) { //res 即为原始返回的数据
                //     return {
                //         "code": 0, //解析接口状态
                //         "data": res.data, //解析数据列表
                //         "count": res.totleNum, //解析数据长度
                //     };
                // },
                /*request: {
                    limitName: 'pageSize' //每页数据量的参数名，默认：limit
                },*/
                done: function (res) {
                    //增加拖拽后回调函数
                    soulTable.render(this, function () {
                        TableUIObj.dragTable('tableDemo')
                    })

                    if (TableUIObj.onePageRecoeds != this.limit) {
                        TableUIObj.update({onePageRecoeds: this.limit})
                    }
                },
                initSort: {
                    field: TableUIObj.orderbyFields,
                    type: TableUIObj.orderbyUpdown
                }
            });
        }

        //点击查询
        $('.searchData').click(function () {
            var searchParams = {}
            var $seachData = $('.query_module [name]')
            $seachData.each(function () {
                searchParams[$(this).attr('name')] = $(this).val() ? $(this).val().trim() : ''
                // 将查询值保存至cookie中
                // $.cookie($(this).attr('name'), $(this).val(), {expires: 5, path: "/",});
            })
            tableIns.reload({
                where: searchParams,
                page: {
                    curr: 1 //重新从第 1 页开始
                }
            });
        });

        /**
         * 获取表格数据
         */
        function planningDetailsData() {

            //安全策划
            var $trs = $('.table_box').find('.layui-table-main tr');
            var dataArr = [];
            $trs.each(function () {
                var dataObj = {
                    securityPlanId: $(this).find('[data-field="documentNo"] span').attr('securityPlanId') || '',
                    documentNo: $(this).find('[data-field="documentNo"] span').text() || '',
                    projectName: $(this).find('[data-field="projectName"] div').text()|| '',
                    projectId: $('#leftId').attr('projId')|| '',
                    solutions: $(this).find('[data-field="solutions"] div').text()|| '',
                    personLiableName: $(this).find('[data-field="personLiableName"] div').text()|| '',
                    checkFrequency: $(this).find('.checkFrequency').attr('checkFrequency')|| '',
                    importance: $(this).find('.importance').attr('importance')|| '',

                    personLiable: $(this).find('.securityKnowledgeName').attr('personLiable') || '',
                    securityKnowledgeName: $(this).find('.securityKnowledgeName').text(),
                    securityTermId: $(this).find('.securityKnowledgeName').attr('securityTermId') || '',
                    workPlanningId: $(this).find('.workPlanningName').attr('workPlanningId') || '',
                    workPlanningName: $(this).find('.workPlanningName').val()||$(this).find('.workPlanningName').text() || '',

                    securityPlanBeginDate: $(this).find('[name="securityPlanBeginDate"]').val() || '',
                    securityPlanEndDate: $(this).find('[name="securityPlanEndDate"]').val() || '',

                    currFlowUserName: $(this).find('[data-field="currFlowUserName"] div').text() || '',
                    auditerStatus: $(this).find('[data-field="auditerStatus"]').attr('data-content')|| '',
                }
                dataArr.push(dataObj);
            });


            return {
                securityData: dataArr,
            }
        }
        var dom = '.layui-table-body [data-field="securityDanger"] div,' +
            '.layui-table-body [data-field="securityDangerMeasures"] div'
        $(document).on('mouseenter', dom, function() {
            var content = $(this).text();
            if(!content){
                return false
            }

            this.index = layer.tips('<div style="padding: 10px; font-size: 14px; color: #eee;">'+ content + '</div>', this, {
                time: -1
                ,maxWidth: 280
                ,tips: [3, '#3A3D49']
            });
        }).on('mouseleave', dom,function(){
            layer.close(this.index);
        });


        /**
         * 新建流程方法
         * @param flowId
         * @param urlParameter
         * @param cb
         */
        function newWorkFlow(flowId, cb,approvalData) {
            $.ajax({
                url: '/workflow/work/workfastAdd',
                type: 'get',
                dataType: 'json',
                data: {
                    flowId: flowId,
                    prcsId: 1,
                    flowStep: 1,
                    runId: '',
                    preView: 0,
                    isBudgetFlow: true,
                    approvalData:JSON.stringify(approvalData),
                    isTabApproval:true,
                },
                async: false,//同步请求,这里使用ajax必须使用同步方式请求，因为浏览器认为这种打开在ajax后新页面是不安全的
                success: function (res) {
                    if (res.flag == true) {
                        var data = res.object;
                        cb(data);
                    }
                }
            });
        }


        //数据列表点击审批状态查看流程功能
        $(document).on('click', '.preview_flow', function() {
            var flowId = $(this).attr('flowId'),
                runId = $(this).attr('runId');
            if (flowId && runId) {
                $.popWindow("/workflow/work/workformPreView?flowId=" + flowId + '&flowStep=&prcsId=&runId=' + runId);
            }
        });

    });
    function workPlan_choice(_this){
        var projectId = $('#leftId').attr('projId');
        layui.layer.open({
            type: 1,
            title: '选择实施策划',
            area: ['90%', '90%'],
            btn: ['确定','取消'],
            btnAlign: 'c',
            content: '<div style="margin:20px"><table id="detailed_Table" lay-filter="detailed_Table"></table></div>',
            success: function () {

                //检查计划明细
                var cols = [
                    {type: 'radio'},
                    {field: 'documentNo', title: '单据号', minWidth: 90},
                    {field:'projectName',title:'项目名称',minWidth: 120},
                    {field: 'workPlanningName', title: '策划名称', minWidth: 120},
                    {field: 'createUserName', title: '编制人',minWidth: 120},
                    {field: 'createTime', title: '编制时间',minWidth: 120},
                    {field: 'memo', title: '备注',minWidth: 120}
                ]

                layui.table.render({
                    elem: '#detailed_Table',
                    url: '/workPlanning/select',
                    defaultToolbar: [''],
                    where: {
                        // projId: projId,
                        projectId: projectId,
                        delFlag: '0'
                    },
                    limit: 1000,
                    cols: [cols],
                    done:function(res){

                    }
                });

                layui.form.render();
            },
            yes: function (index) {
                var data = layui.table.checkStatus('detailed_Table').data;
                if(data.length==0){
                    layer.msg('请选择一项！', {icon: 0});
                    return false
                }
                $(_this).val(data[0].workPlanningName).attr('workPlanningId',data[0].workPlanningId)
                layer.close(index);
            }
        });
    }
    function clickdata(_this){
        layui.laydate.render({
            elem: _this
            , trigger: 'click'
            , format: 'yyyy-MM-dd'
            // , format: 'yyyy-MM-dd HH:mm:ss'
            //,value: new Date()
            /*, done: function(value, date){
                if(value&&$(_this).attr('name')=='recordBeginDate'){
                    $(_this).attr('disabled','disabled')
                    $(_this).css('background','#e7e7e7')
                }
            }*/
        });
    }


    /**
     * 获取自动编号接口
     * @param params (参数{autoNumber: 数据库表名, costType: 报销单类型})
     * @param callback (回调函数)
     */
    function getAutoNumber(params, callback) {
        $.get('/planningManage/autoNumber', params, function (res) {
            callback(res);
        });
    }


    function openRold(){ //流程转交下一步后会调用此方法
        //刷新表格
        tableIns.config.where._ = new Date().getTime();
        tableIns.reload();
    }
</script>
</body>
</html>
