<%--
  Created by IntelliJ IDEA.
  User: dongke
  Date: 2021/6/29
  Time: 18:31
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>间接费月额度预览</title>
</head>
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
<script type="text/javascript" src="/js/common/fileupload.js"></script>
<script type="text/javascript" src="/js/planbudget/common.js?20210604.1"></script>
<script type="text/javascript" src="/js/planother/planotherUtil.js?22120210604.2"></script>

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

    .refresh_no_btn {
        display: none;
        margin-left: 8%;
        color: #00c4ff !important;
        font-weight: 600;
        cursor: pointer;
    }
    #objectives .layui-table-cell .layui-form-checkbox[lay-skin="primary"]{
        top: 50%;
        transform: translateY(-50%);
    }
</style>

<body>
<div id="htm"></div>
<script type="text/html" id="toolbarDemoIn">
    <div class="layui-btn-container" style="height: 30px;">
        <button class="layui-btn layui-btn-sm" lay-event="add">选择</button>
    </div>
</script>

<script type="text/html" id="barDemo">
    <a class="layui-btn layui-btn-danger layui-btn-xs" lay-event="del">删行</a>
</script>
<script>

    var _dataa;


    var type = null
    
    var materialDetailsTableData = [];
    //var columnId = parent.columnTrId;//getUrlParam('columnId');
    var runId = getUrlParam('runId');
    var targetCostId = getUrlParam('targetCostId');
    var _disabled = getUrlParam('disabled');
    if(_disabled&&_disabled=='0'){
        type = '1'
    }else {
        type = '4'
    }

    var htm = ['<div class="layui-collapse" id="leftId" >\n' +
    <%--    /* region 立项项目基础信息 */--%>
    '    <div class="layui-colla-item">\n' +
    '        <h2 class="layui-colla-title">立项信息</h2>\n' +
    '        <div class="layui-colla-content layui-show plan_base_info">\n' +
    '            <form class="layui-form" id="baseForm" lay-filter="baseForm">\n' +
    <%--                /* region 第一行 */--%>
    '                <div class="layui-row">\n' +
    '                    <div class="layui-col-xs6" style="padding: 0 5px;">\n' +
    '                        <div class="layui-form-item">\n' +
    '                            <label class="layui-form-label form_label">单据号<span field="documnetNum" class="field_required">*</span><a title="刷新编号" class="refresh_no_btn"><i class="layui-icon layui-icon-refresh"></i></a></label>\n' +
    '                            <div class="layui-input-block form_block">\n' +
    '                                <input type="text" readonly name="documnetNum" autocomplete="off" class="layui-input">\n' +
    '                            </div>\n' +
    '                        </div>\n' +
    '                    </div>\n' +
    '                    <div class="layui-col-xs6" style="padding: 0 5px;">\n' +
    '                        <div class="layui-form-item">\n' +
    '                            <label class="layui-form-label form_label">项目名称<span field="projectName" class="field_required">*</span></label>\n' +
    '                            <div class="layui-input-block form_block">\n' +
    '                                <input type="text" readonly id="projectName" name="projectName" autocomplete="off"  class="layui-input ">\n' +
    '                            </div>\n' +
    '                        </div>\n' +
    '                    </div>\n' +
    '                </div>\n' +
    <%--                /* endregion */--%>
    <%--                /* region 第二行 */--%>
    '                <div class="layui-row">\n' +
    '                    <div class="layui-col-xs6" style="padding: 0 5px;">\n' +
    '                        <div class="layui-form-item">\n' +
    '                            <label class="layui-form-label form_label">月度<span field="month" class="field_required">*</span></label>\n' +
    '                            <div class="layui-input-block form_block">\n' +
    '                                <input type="text" readonly name="month" id="month" autocomplete="off"  class="layui-input ">\n' +
    '                            </div>\n' +
    '                        </div>\n' +
    '                    </div>\n' +
    '                    <div class="layui-col-xs6" style="padding: 0 5px;">\n' +
    '                        <div class="layui-form-item">\n' +
    '                            <label class="layui-form-label form_label">本月其他费用总额度<span field="monIndExp" class="field_required">*</span></label>\n' +
    '                            <div class="layui-input-block form_block">\n' +
    '                                <input type="text" readonly name="monIndExp" autocomplete="off" class="layui-input" style="background:#e7e7e7;">\n' +
    '                            </div>\n' +
    '                        </div>\n' +
    '                    </div>\n' +
    '                </div>\n' +
    <%--                /* endregion */--%>
    '            </form>\n' +
    '        </div>\n' +
    '    </div>\n' +
    <%--    /* endregion */--%>
    <%--    /* region 间接费额度 */--%>
    '    <div class="layui-colla-item">\n' +
    '        <h2 class="layui-colla-title">其他费用额度</h2>\n' +
    '        <div class="layui-colla-content mtl_info layui-show">\n' +
    '            <div>\n' +
    '                <table id="materialDetailsTable" lay-filter="materialDetailsTable"></table>\n' +
    '            </div>\n' +
    '        </div>\n' +
    '    </div>\n' +
    <%--    /* endregion */--%>
    '</div>'].join('');
    $("#htm").html(htm)
    var dictionaryObj = {
        CONTROL_TYPE: {},
        CBS_UNIT: {},
        MTL_VALUATION_UNIT:{},
        MANAGE_ITEM_TYPE:{}
    }
    var dictionaryStr = 'CONTROL_TYPE,CBS_UNIT,MTL_VALUATION_UNIT,MANAGE_ITEM_TYPE';
    $.ajaxSettings.async = false;
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
    $.ajaxSettings.async = true;
    layui.use(['form', 'table', 'element', 'soulTable', 'eleTree','xmSelect'],function(){
        if((runId==undefined||runId==""||runId==null)&&(targetCostId==undefined||targetCostId==null||targetCostId=="")){
            layer.msg("获取信息失败")
        }
        var form = layui.form,
            table = layui.table,
            element = layui.element,
            soulTable = layui.soulTable,
            eleTree = layui.eleTree,
            xmSelect = layui.xmSelect
        //回显数据
        var data=undefined;
        if(targetCostId!=undefined&&targetCostId!=""&&targetCostId!=null){ //根据主键id查询数据
            $.ajax({
                url:"/overheadLimit/getById?kayId="+targetCostId,
                dataType:"json",
                type:"post",
                async:false,
                success:function(res){
                    if(res.code===0||res.code==="0"){
                        data = res.obj;
                    }else{
                        layer.msg("信息获取失败，请刷新重试")
                        return false;
                    }
                }
            })
        }else if(runId!=undefined&&runId!=null&&runId!=""){ //根据流程id查询数据
            $.ajax({
                url:"/overheadLimit/getById?runId="+runId,
                dataType:"json",
                type:"post",
                async:false,
                success:function(res){
                    if(res.code===0||res.code==="0"){
                        data = res.obj;
                    }else{
                        layer.msg("信息获取失败，请刷新重试")
                    }
                }
            })
        }else{
            layer.msg("信息获取失败")
        }
        if(data){
            //回显数据
            if (type == 1 || type == 4) {
                if(data!=undefined){
                    //项目名称
                    getProjName('#getProjName',data.projId)
                    form.val("baseForm", data);

                    $('#leftId').attr('projId', data.projId);
                    $('#leftId').attr('targetCostId', data.targetCostId);

                    materialDetailsTableData = data.detailList;
                }
            }

            form.render();

            //间接费额度
            var cols=[
                {type: 'numbers', title: '序号'},
                {
                    field: 'wbsId', title: 'WBS',minWidth:230, templet: function (d) {
                        return '<input type="text" readonly name="wbsId" wbsId="'+d.wbsId+'" projBudgetId="'+(d.projBudgetId||"")+'"  targetCostDetailsId="'+(d.targetCostDetailsId||"")+'" targetCostId="'+d.targetCostId+'" class="layui-input" style="height: 100%;background: #e7e7e7;" value="' + (d.wbsName || '') + '">'
                    }
                },
                {
                    field: 'rbsId', title: 'RBS',minWidth:240, templet: function (d) {
                        return '<input type="text" readonly name="rbsId" cbsId="'+d.rbsId+'" class="layui-input" style="height: 100%;background: #e7e7e7;" value="' + (d.rbsLongName || '') + '">'
                    }
                },
                {
                    field: 'cbsId', title: 'CBS',minWidth:200, templet: function (d) {
                        return '<input type="text" readonly name="cbsId" cbsId="'+d.cbsId+'" class="layui-input" style="height: 100%;background: #e7e7e7;" value="' + (d.cbsName || '') + '">'
                    }
                },
                {
                    field: 'manageTarAmount', title: '管理目标金额',minWidth:120, templet: function (d) {
                        return '<input type="number" readonly name="manageTarAmount" class="layui-input" style="height: 100%;background: #e7e7e7;" value="' + (d.manageTarAmount || 0) + '">'
                    }
                },
                {
                    field: 'monQuata', title: '截止当前累计额度',minWidth:120, templet: function (d) {
                        return '<input type="number" readonly name="monQuata" class="layui-input" style="height: 100%;background: #e7e7e7;" value="' + (d.monQuata || 0) + '">'
                    }
                },
                {
                    field: 'surQuata', title: '管理目标剩余额度',minWidth:120, templet: function (d) {
                        return '<input type="number" readonly name="surQuata" class="layui-input" style="height: 100%;background: #e7e7e7;" value="' + (d.surQuata || 0) + '">'
                    }
                },
                {
                    field: 'monthQuata', title: '本次额度*',minWidth:120, templet: function (d) {
                        return '<input type="number" name="monthQuata" class="layui-input" style="height: 100%;" value="' + (d.monthQuata || "") + '">'
                    }
                },
            ]
            if(type!=4){
                cols.push({align: 'center', toolbar: '#barDemo', title: '操作', minWidth: 100,fixed:'right'})
            }
            table.render({
                elem: '#materialDetailsTable',
                data: materialDetailsTableData,
                toolbar: type!=4?'#toolbarDemoIn':false,
                defaultToolbar: [''],
                limit: 1000,
                cols: [cols],
                done:function (obj) {
                    if(type==4){
                        $('[name="monthQuata"]').attr("disabled",'disabled');
                    }
                    if(obj != undefined&&obj.data != undefined){
                        //
                        materialDetailsTableData = obj.data;
                    }
                }
            });
        }

        // 间接费额度-选择
        table.on('toolbar(materialDetailsTable)', function (obj) {

            switch (obj.event) {
                case 'add':
                    var wbsSelectTree = null;
                    var cbsSelectTree = null;
                    var _this = $(this);
                    layer.open({
                        type: 1,
                        title: '管理目标选择',
                        area: ['100%', '100%'],
                        maxmin: true,
                        btn: ['确定', '取消'],
                        btnAlign: 'c',
                        content: ['<div class="layui-form" id="objectives">' +
                        //下拉选择
                        '           <div class="layui-row" style="margin-top: 10px">' +
                        '               <div class="layui-col-xs2">' +
                        '                   <div class="layui-form-item">\n' +
                        '                       <label class="layui-form-label" style="width:85px">预算科目编号</label>\n' +
                        '                       <div class="layui-input-block" style="margin-left: 115px">\n' +
                        '                          <input type="text" name="itemNo"  autocomplete="off" class="layui-input">'+
                        '                       </div>\n' +
                        '                   </div>' +
                        '               </div>' +
                        '               <div class="layui-col-xs2">' +
                        '                   <div class="layui-form-item">\n' +
                        '                       <label class="layui-form-label" style="width:85px">预算科目名称</label>\n' +
                        '                       <div class="layui-input-block" style="margin-left: 115px">\n' +
                        '                          <input type="text" name="itemName"  autocomplete="off" class="layui-input">'+
                        '                       </div>\n' +
                        '                   </div>' +
                        '               </div>' +
                        '               <div class="layui-col-xs3">' +
                        '                   <div class="layui-form-item">\n' +
                        '                       <label class="layui-form-label">WBS</label>\n' +
                        '                       <div class="layui-input-block">\n' +
                        '<div id="wbsSelectTree" class="xm-select-demo" style="width: 100%;"></div>' +
                        '                       </div>\n' +
                        '                   </div>' +
                        '               </div>' +
                        '               <div class="layui-col-xs3">' +
                        '                   <div class="layui-form-item">\n' +
                        '                       <label class="layui-form-label">CBS</label>\n' +
                        '                       <div class="layui-input-block">\n' +
                        '<div id="cbsSelectTree" class="xm-select-demo" style="width: 100%;"></div>' +
                        '                       </div>\n' +
                        '                   </div>' +
                        '               </div>' +
                        '               <div class="layui-col-xs2">' +
                        '<button class="layui-btn layui-btn-sm search_mtl" style="margin: 4px 0 0 10px;">搜索<i class="layui-icon layui-icon-search" style="margin: 0 0 0 3px;"></i></button>' +
                        '               </div>' +
                        '           </div>' +
                        //表格数据
                        '       <div style="padding: 10px">' +
                        '           <table id="managementBudgetTable" lay-filter="managementBudgetTable"></table>' +
                        '      </div>' +
                        '</div>'].join(''),
                        success: function () {
                            // 获取WBS数据
                            $.get('/plbProjWbs/getWbsTreeByProjId',{projId:$('#leftId').attr('projId')}, function (res) {
                                wbsSelectTree = xmSelect.render({
                                    el: '#wbsSelectTree',
                                    content: '<div id="wbsTree" class="eleTree" lay-filter="wbsTree"></div>',
                                    name: 'wbsName',
                                    prop: {
                                        name: 'wbsName',
                                        value: 'id'
                                    }
                                });

                                eleTree.render({
                                    elem: '#wbsTree',
                                    data: res.obj,
                                    highlightCurrent: true,
                                    showLine: true,
                                    defaultExpandAll: false,
                                    request: {
                                        name: 'wbsName',
                                        children: "child"
                                    }
                                });

                                // 树节点点击事件
                                eleTree.on("nodeClick(wbsTree)", function (d) {
                                    var currentData = d.data.currentData;
                                    var obj = {
                                        wbsName: currentData.wbsName,
                                        id: currentData.id
                                    }
                                    wbsSelectTree.setValue([obj]);
                                });
                            });

                            // 获取CBS数据
                            $.get('/plbCbsType/getAllList', function (res) {
                                cbsSelectTree = xmSelect.render({
                                    el: '#cbsSelectTree',
                                    content: '<div id="cbsTree" class="eleTree" lay-filter="cbsTree"></div>',
                                    name: 'cbsName',
                                    prop: {
                                        name: 'cbsName',
                                        value: 'cbsId'
                                    }
                                });

                                eleTree.render({
                                    elem: '#cbsTree',
                                    data: res.data,
                                    highlightCurrent: true,
                                    showLine: true,
                                    defaultExpandAll: false,
                                    request: {
                                        name: 'cbsName',
                                        children: "childList"
                                    }
                                });

                                // 树节点点击事件
                                eleTree.on("nodeClick(cbsTree)", function (d) {
                                    var currentData = d.data.currentData;
                                    var obj = {
                                        cbsName: currentData.cbsName,
                                        cbsId: currentData.cbsId
                                    }
                                    cbsSelectTree.setValue([obj]);
                                });
                            });

                            laodTable();

                            $('.search_mtl').on('click', function(){
                                var cbsId = cbsSelectTree.getValue('valueStr');
                                var wbsId = wbsSelectTree.getValue('valueStr');
                                var itemNo = $('[name="itemNo"]').val();
                                var itemName =$('[name="itemName"]').val();

                                laodTable(wbsId, cbsId,itemNo,itemName);
                            });

                            // 加载表格
                            function laodTable(wbsId, cbsId,itemNo,itemName) {
                                table.render({
                                    elem: '#managementBudgetTable',
                                    url: '/manageProject/getBudgetByProjId',
                                    where: {
                                        projId: $('#leftId').attr('projId'),
                                        wbsId: wbsId || '',
                                        cbsId: cbsId || '',
                                        itemNo: itemNo || '',
                                        itemName: itemName || '',
                                        rbsTyep:'other'
                                    },
                                    page: true,
                                    limit: 20,
                                    request: {
                                        limitName: 'pageSize'
                                    },
                                    response: {
                                        statusName: 'flag',
                                        statusCode: true,
                                        msgName: 'msg',
                                        countName: 'count',
                                        dataName: 'data'
                                    },
                                    cols: [[
                                        {type: 'checkbox'},
                                        {
                                            field: 'wbsName', title: 'WBS',minWidth:100, templet: function(d) {
                                                var str = '';
                                                if (d.plbProjWbs) {
                                                    str = d.plbProjWbs.wbsName;
                                                }
                                                return str;
                                            }
                                        },
                                        {
                                            field: 'rbsName', title: 'RBS',minWidth:200, templet: function(d) {
                                                var str = '';
                                                if (d.plbRbs) {
                                                    str = d.plbRbs.rbsLongName;
                                                }
                                                return str;
                                            }
                                        },
                                        {
                                            field: 'cbsName', title: 'CBS',minWidth:100, templet: function (d) {
                                                var str = '';
                                                if (d.plbCbsTypeWithBLOBs) {
                                                    str = d.plbCbsTypeWithBLOBs.cbsName;
                                                }
                                                return str;
                                            }
                                        },
                                        {
                                            field: 'controlType', title: '控制类型', minWidth:120,templet: function (d) {
                                                return dictionaryObj['CONTROL_TYPE']['object'][d.controlType] || '';
                                            }
                                        },
                                        {
                                            field: 'rbsUnit', title: '单位',minWidth:120, templet: function (d) {
                                                var str = '';
                                                if (d.plbRbs) {
                                                    str = dictionaryObj['CBS_UNIT']['object'][d.plbRbs.rbsUnit] || '';
                                                }
                                                return str;
                                            }
                                        },
                                        // {field: 'manageTarNum', title: '管理目标数量',minWidth:120},
                                        // {field: 'manageTarPrice', title: '管理目标单价',minWidth:120},
                                        {field: 'manageTarAmount', title: '管理目标金额',minWidth:120},
                                        // {field: 'addupNeedAmount', title: '已提需求计划数量',minWidth:170},
                                        {field: 'monQuata', title: '截止当前累计额度',minWidth:170},
                                        {field: 'surQuata', title: '剩余额度',minWidth:170},
                                        //{field: 'addupNeedMoney', title: '累计已提需求计划金额',minWidth:170},
                                        //{field: 'manageSurplusMoney', title: '管理目标金额余额',minWidth:150},
                                    ]],
                                    done:function(res){
                                        _dataa=res.data;
                                        if(materialDetailsTableData!=undefined&&materialDetailsTableData.length>0){
                                            for(var i = 0 ; i <_dataa.length;i++){
                                                for(var n = 0 ; n < materialDetailsTableData.length; n++){
                                                    if(_dataa[i].projBudgetId == materialDetailsTableData[n].projBudgetId){
                                                        $('.layui-table tr[data-index=' + i + '] input[type="checkbox"]').next(".layui-form-checkbox").click();
                                                        //form.render('checkbox');
                                                    }
                                                }
                                            }
                                        }

                                    }
                                });
                            }
                        },
                        yes: function (index) {
                            var checkStatus=[];
                            $('#objectives .layui-table-body .laytable-cell-checkbox').each(function(index,item){
                                if($(item).find('.layui-form-checked').length>0){
                                    checkStatus.push(_dataa[index]);
                                }
                            })
                            //var checkStatus = table.checkStatus('managementBudgetTable').data;

                            var oldDataArr = [];
                            if (checkStatus.length > 0) {
                                for(var i=0;i<checkStatus.length;i++){
                                    var oldDataObj = {
                                        projBudgetId:checkStatus[i].projBudgetId,
                                        manageTarAmount:checkStatus[i].manageTarAmount,
                                        monQuata:checkStatus[i].monQuata,
                                        monthQuata:checkStatus[i].monthQuata,
                                        surQuata:checkStatus[i].surQuata
                                    }
                                    if(checkStatus[i].plbCbsTypeWithBLOBs!=undefined){
                                        if(checkStatus[i].plbCbsTypeWithBLOBs.cbsName!=undefined){
                                            oldDataObj.cbsName=checkStatus[i].plbCbsTypeWithBLOBs.cbsName;
                                        }
                                        if(checkStatus[i].plbCbsTypeWithBLOBs.cbsId!=undefined){
                                            oldDataObj.cbsId=checkStatus[i].plbCbsTypeWithBLOBs.cbsId;
                                        }
                                    }
                                    if(checkStatus[i].plbProjWbs!=undefined){
                                        if(checkStatus[i].plbProjWbs.wbsName!=undefined){
                                            oldDataObj.wbsName=checkStatus[i].plbProjWbs.wbsName;
                                        }
                                        if(checkStatus[i].plbProjWbs.wbsId!=undefined){
                                            oldDataObj.wbsId=checkStatus[i].plbProjWbs.wbsId;
                                        }
                                    }
                                    if(checkStatus[i].plbRbs!=undefined){
                                        if(checkStatus[i].plbRbs.rbsLongName!=undefined){
                                            oldDataObj.rbsLongName=checkStatus[i].plbRbs.rbsLongName;
                                        }
                                        if(checkStatus[i].plbRbs.wbsId!=undefined){
                                            oldDataObj.rbsId=checkStatus[i].plbRbs.rbsId;
                                        }
                                    }
                                    if(materialDetailsTableData){
                                        var _flag = true
                                        for(var j=0;j<materialDetailsTableData.length;j++){
                                            if(materialDetailsTableData[j].projBudgetId==checkStatus[i].projBudgetId){
                                                _flag = false
                                            }
                                        }
                                        if(_flag){
                                            materialDetailsTableData.push(oldDataObj);
                                        }

                                    }else{
                                        materialDetailsTableData.push(oldDataObj);
                                    }

                                }

                                layer.close(index);

                                table.reload('materialDetailsTable', {
                                    data: materialDetailsTableData
                                });
                            } else {
                                layer.msg('请选择一项！', {icon: 0});
                            }
                        }
                    });

                    break;
            }
        });
        // 间接费额度-删行操作
        table.on('tool(materialDetailsTable)', function (obj) {
            var data = obj.data;
            var layEvent = obj.event;
            if (layEvent === 'del') {
                if(data.targetCostDetailsId){
                    $.ajax({
                        url: '/overheadLimit/delDetails?ids='+data.targetCostDetailsId,
                        dataType: 'json',
                        type: 'post',
                        success: function (res) {
                            //本月额度
                            var monIndExp=data.monthQuata;
                            var monIndExp_sum = $('input[name="monIndExp"]').val()
                            var monIndExp_sum=sub(monIndExp_sum,monIndExp)
                            $('input[name="monIndExp"]').val(retainDecimal(monIndExp_sum,3))
                            /*if (res.code==='0'||res.code===0) {
                                layer.msg(res.msg, {icon: 1});
                            } else {
                                layer.msg(res.msg, {icon: 2});
                            }*/
                        }
                    });
                }else{
                    //本月额度
                    var monIndExp=data.monthQuata;
                    var monIndExp_sum = $('input[name="monIndExp"]').val()
                    var monIndExp=sub(monIndExp_sum,monIndExp)
                    $('input[name="monIndExp"]').val(retainDecimal(monIndExp,3))
                }

                obj.del();

                //遍历表格获取每行数据进行保存
                var $tr = $('.mtl_info').find('.layui-table-main tr');
                var oldDataArr = [];
                $tr.each(function () {
                    var oldDataObj = {
                        projBudgetId:$(this).find('input[name="wbsId"]').attr('projBudgetId'),
                        targetCostId: $(this).find('input[name="wbsId"]').attr('targetCostId'),
                        targetCostDetailsId: $(this).find('input[name="wbsId"]').attr('targetCostDetailsId'),
                        wbsName: $(this).find('input[name="wbsId"]').val(),
                        wbsId: $(this).find('input[name="wbsId"]').attr('wbsId'),
                        cbsName: $(this).find('input[name="cbsId"]').val(),
                        cbsId: $(this).find('input[name="cbsId"]').attr('cbsId'),
                        rbsName: $(this).find('input[name="rbsId"]').val(),
                        rbsLongName: $(this).find('input[name="rbsId"]').val(),
                        rbsId: $(this).find('input[name="rbsId"]').attr('rbsId'),
                        manageTarAmount: $(this).find('input[name="manageTarAmount"]').val(),
                        monQuata: $(this).find('input[name="monQuata"]').val(),
                        surQuata: $(this).find('input[name="surQuata"]').val(),
                        monthQuata: $(this).find('input[name="monthQuata"]').val(),
                    }
                    oldDataArr.push(oldDataObj);
                });
                table.reload('materialDetailsTable', {
                    data: oldDataArr
                });
            }
        });

        //监听本月额度
        $(document).on('input propertychange', 'input[name="monthQuata"]', function () {
            /*if(type=='4'){
                return false
            }*/

            var $tr = $('.mtl_info').find('.layui-table-main tr');
            if($(this).val() && $(this).parents('tr').find('[name="monthQuata"]').val()){

                //本月额度
                var monIndExp=0
                var monIndExp_sum=0

                $tr.each(function () {
                    monIndExp=$(this).find('input[name="monthQuata"]').val()
                    monIndExp_sum=accAdd(monIndExp_sum,monIndExp)
                });
                $('input[name="monIndExp"]').val(retainDecimal(monIndExp_sum,2))
            }
        });

    })

    function childFunc() {
        if(_disabled&&_disabled!='0'){
            return false
        }

        var loadIndex = layer.load();
        //材料计划数据
        var datas = $('#baseForm').serializeArray();
        var obj = {}
        datas.forEach(function (item) {
            obj[item.name] = item.value;
        });
        obj.projectId=$('#leftId').attr('projId');
        if (type == '1') {
            obj.targetCostId=$('#leftId').attr('targetCostId');
        }


        // 判断必填项
        /*var requiredFlag = false;
        $('#baseForm').find('.field_required').each(function(){
            var field = $(this).attr('field');
            if (field && !obj[field] && obj[field] != '0') {
                var fieldName = $(this).parent().text().replace('*', '');
                layer.msg(fieldName+'不能为空！', {icon: 0, time: 2000});
                requiredFlag = true;
                return false;
            }
        });

        if (requiredFlag) {
            layer.close(loadIndex);
            return false;
        }*/

        var requiredFlag = false;
        var $tr = $('.mtl_info').find('.layui-table-main tr [name="monthQuata"]');
        $tr.each(function (index,element) {
            if(!$(element).val()){
                layer.msg('本月额度不能为空！', {icon: 0, time: 2000});
                requiredFlag = true;
                return false;
            }
        });

        //间接费额度
        var $tr = $('.mtl_info').find('.layui-table-main tr');
        var detailList = [];
        $tr.each(function () {
            var plbManageItemObj = {
                wbsName: $(this).find('input[name="wbsId"]').val(),
                wbsId: $(this).find('input[name="wbsId"]').attr('wbsId'),
                cbsName: $(this).find('input[name="cbsId"]').val(),
                cbsId: $(this).find('input[name="cbsId"]').attr('cbsId'),
                rbsName: $(this).find('input[name="rbsId"]').val(),
                rbsId: $(this).find('input[name="rbsId"]').attr('rbsId'),
                manageTarAmount: $(this).find('input[name="manageTarAmount"]').val(),
                monQuata: $(this).find('input[name="monQuata"]').val(),
                surQuata: $(this).find('input[name="surQuata"]').val(),
                monthQuata: retainDecimal($(this).find('input[name="monthQuata"]').val(),2),
            }
            if($(this).find('input[name="wbsId"]').attr('projBudgetId')){
                plbManageItemObj.projBudgetId=$(this).find('input[name="wbsId"]').attr('projBudgetId');
            }
            if($(this).find('input[name="wbsId"]').attr('targetCostDetailsId')){
                plbManageItemObj.targetCostDetailsId=$(this).find('input[name="wbsId"]').attr('targetCostDetailsId');
            }
            if($('#leftId').attr('targetCostId')){
                plbManageItemObj.targetCostId=$('#leftId').attr('targetCostId')
            }
            detailList.push(plbManageItemObj);

            //管理目标余额>=本次额度  可以提交
            if(Number(plbManageItemObj.surQuata)<Number(plbManageItemObj.monthQuata)){
                requiredFlag = true;
                layer.msg('管理目标余额>=本次额度！', {icon: 0, time: 3000});
            }
        });
        obj.detailList = detailList;

        if (requiredFlag) {
            layer.close(loadIndex);
            return false;
        }

        var _flag = false;

        $.ajax({
            url: '/overheadLimit/updateById?targetCostId='+$('#leftId').attr('targetCostId'),
            data: JSON.stringify(obj),
            dataType: 'json',
            contentType: "application/json;charset=UTF-8",
            type: 'post',
            success: function (res) {
                layer.close(loadIndex);
                if (res.code==='0'||res.code===0) {
                    layer.msg('保存成功！', {icon: 1});
                    /*layer.close(index);
                    reloadTableData();*/
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

    function getUrlParam(name){
        var reg = new RegExp(name +"=(.*?)((?=&|$))"); //构造一个含有目标参数的正则表达式对象
        var r = window.location.href.match(reg); //匹配目标参数
        if (r!=null) return unescape(r[1]); return null; //返回参数值
    }
</script>
</body>
</html>
