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
    <title>经营立项</title>

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
    <script type="text/javascript" src="/js/common/fileupload.js"></script>
    <script type="text/javascript" src="/js/planbudget/common.js?20210604.123"></script>
    <script type="text/javascript" src="/js/planother/planotherUtil.js?22120210604.1"></script>

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
        .layui-col-xs4{
            width:20%
        }
    </style>
</head>
<body>
<div class="layui-collapse" id="htm"></div>
<script type="text/html" id="detailBarDemo">
    <a class="layui-btn  layui-btn-xs" lay-event="detail">查看详情</a>
</script>

<script type="text/html" id="toolbarDemoIn">
    <div class="layui-btn-container" style="height: 30px;">
        <button class="layui-btn layui-btn-sm" lay-event="add">选择</button>
    </div>
</script>

<script type="text/html" id="barDemo">
    <a class="layui-btn layui-btn-danger layui-btn-xs" lay-event="del">删行</a>
</script>

<script type="text/html" id="toolbarDemoIn2">
    <div class="layui-btn-container" style="height: 30px;">
        <button class="layui-btn layui-btn-sm" lay-event="add2">选择</button>
    </div>
</script>

<script type="text/html" id="barDemo2">
    <a class="layui-btn layui-btn-danger layui-btn-xs addRow" lay-event="del2">删行</a>
    <a class="layui-btn  layui-btn-xs" lay-event="details">查看详情</a>
</script>
<script>
    var _projectId;
    var manageProj_state;
    var manageProj_data;
    var materialDetailsTableData = [];
    var materialDetailsTableData2 = [];
    var _dataa;
    var _dataa2;

    var _type = getUrlParam('type');
    var runId = getUrlParam('runId');
    var _disabled=getUrlParam('disabled');
    var manageProjId = getUrlParam('manageProjId');

    var data=null;

    var type;
    if('0'!=_disabled){
        type = 4
    }else {
        type = 1
    }

    var htm = ['<div class="layui-collapse _disabled">\n' +
        <%--    /* region 立项项目基础信息 */--%>
        '    <div class="layui-colla-item">\n' +
        '        <h2 class="layui-colla-title">立项信息</h2>\n' +
        '        <div class="layui-colla-content layui-show plan_base_info">\n' +
        '            <form class="layui-form" id="baseForm" lay-filter="baseForm">\n' +
        <%--                /* region 第一行 */--%>
        '                <div class="layui-row">\n' +
        '                    <div class="layui-col-xs4" style="padding: 0 5px;">\n' +
        '                        <div class="layui-form-item">\n' +
        '                            <label class="layui-form-label form_label">单据号<span field="manageProjNo" class="field_required">*</span><a title="刷新编号" class="refresh_no_btn"><i class="layui-icon layui-icon-refresh"></i></a></label>\n' +
        '                            <div class="layui-input-block form_block">\n' +
        '                                <input type="text" readonly name="manageProjNo" autocomplete="off" class="layui-input">\n' +
        '                            </div>\n' +
        '                        </div>\n' +
        '                    </div>\n' +
        '                    <div class="layui-col-xs4" style="padding: 0 5px;">\n' +
        '                        <div class="layui-form-item">\n' +
        '                            <label class="layui-form-label form_label">项目名称<span field="projectName" class="field_required">*</span></label>\n' +
        '                            <div class="layui-input-block form_block">\n' +
        '                                <input type="text" id="projectName" name="projectName" autocomplete="off"  class="layui-input ">\n' +
        '                            </div>\n' +
        '                        </div>\n' +
        '                    </div>\n' +
        '                    <div class="layui-col-xs4" style="padding: 0 5px;">\n' +
        '                        <div class="layui-form-item">\n' +
        '                            <label class="layui-form-label form_label">经营立项名称<span field="manageProjName" class="field_required">*</span></label>\n' +
        '                            <div class="layui-input-block form_block">\n' +
        '                                <input type="text" name="manageProjName" autocomplete="off"  class="layui-input ">\n' +
        '                            </div>\n' +
        '                        </div>\n' +
        '                    </div>\n' +
        // '                    <div class="layui-col-xs4" style="padding: 0 5px;">\n' +
        // '                        <div class="layui-form-item">\n' +
        // '                            <label class="layui-form-label form_label">经营立项类型<span field="manageProjType" class="field_required">*</span></label>\n' +
        // '                            <div class="layui-input-block form_block">\n' +
        // '                                <select name="manageProjType" id="manageProjType" lay-filter="test">\n' +
        // '                                </select>\n' +
        // '                            </div>\n' +
        // '                        </div>\n' +
        // '                    </div>\n' +
        '                    <div class="layui-col-xs4" style="padding: 0 5px;">\n' +
        '                        <div class="layui-form-item">\n' +
        '                            <label class="layui-form-label form_label">经营目标选择</label>\n' +
        '                            <div class="layui-input-block form_block">\n' +
        '<i style="position: absolute;top: 8px;right: 5px;" class="layui-icon layui-icon-search"></i>  ' +
        '                               <input type="text" name="itemType" id="itemType" placeholder="请选择经营目标" readonly autocomplete="off" class="layui-input" style="padding-right: 25px;background:#e7e7e7;cursor: pointer;">\n' +
        '                               <input type="hidden" name="projBudgetId" id="projBudgetId" readonly autocomplete="off" class="layui-input" style="padding-right: 25px;background:#e7e7e7;cursor: pointer;">\n' +
        '                            </div>\n' +
        '                        </div>\n' +
        '                    </div>\n' +
        '                    <div class="layui-col-xs4" style="padding: 0 5px;">\n' +
        '                        <div class="layui-form-item">\n' +
        '                            <label class="layui-form-label form_label">预计变更收入<span field="changeIncome" class="field_required">*</span></label>\n' +
        '                            <div class="layui-input-block form_block">\n' +
        '                                <input type="text" readonly name="changeIncome" autocomplete="off"  class="layui-input" style="background:#e7e7e7;">\n' +
        '                            </div>\n' +
        '                        </div>\n' +
        '                    </div>\n' +
        '                </div>\n' +
        <%--                /* endregion */--%>
        <%--                /* region 第二行 */--%>
        '                <div class="layui-row">\n' +
        // '                    <div class="layui-col-xs4" style="padding: 0 5px;">\n' +
        // '                        <div class="layui-form-item">\n' +
        // '                            <label class="layui-form-label form_label">甲方是否已下达指令<span field="firstPartyOrderFlag" class="field_required">*</span></label>\n' +
        // '                            <div class="layui-input-block form_block">\n' +
        // '                                <select name="firstPartyOrderFlag" id="firstPartyOrderFlag">\n' +
        // '                                    <option value="">请选择</option>\n' +
        // '                                    <option value="0">是</option>\n' +
        // '                                    <option value="1">否</option>\n' +
        // '                                </select>\n' +
        // '                            </div>\n' +
        // '                        </div>\n' +
        // '                    </div>\n' +

        '                    <div class="layui-col-xs4" style="padding: 0 5px;">\n' +
        '                        <div class="layui-form-item">\n' +
        '                            <label class="layui-form-label form_label">实施成本<span field="implementationCost" class="field_required">*</span></label>\n' +
        '                            <div class="layui-input-block form_block">\n' +
        '                                <input type="text" readonly name="implementationCost" autocomplete="off" class="layui-input" style="background:#e7e7e7;">\n' +
        '                            </div>\n' +
        '                        </div>\n' +
        '                    </div>\n' +
        '                    <div class="layui-col-xs4" style="padding: 0 5px;">\n' +
        '                        <div class="layui-form-item">\n' +
        '                            <label class="layui-form-label form_label">预计利润<span field="estimatedProfit" class="field_required">*</span></label>\n' +
        '                            <div class="layui-input-block form_block">\n' +
        '                                <input type="text" readonly name="estimatedProfit" autocomplete="off" class="layui-input" style="background:#e7e7e7;">\n' +
        '                            </div>\n' +
        '                        </div>\n' +
        '                    </div>\n' +
        '                    <div class="layui-col-xs4" style="padding: 0 5px;">\n' +
        '                        <div class="layui-form-item">\n' +
        '                            <label class="layui-form-label form_label">经营立项日期<span field="projectDate" class="field_required">*</span></label>\n' +
        '                            <div class="layui-input-block form_block">\n' +
        '                                <input type="text" name="projectDate" id="projectDate" autocomplete="off"  class="layui-input ">\n' +
        '                            </div>\n' +
        '                        </div>\n' +
        '                    </div>\n' +
        '                    <div class="layui-col-xs4" style="padding: 0 5px;">\n' +
        '                        <div class="layui-form-item">\n' +
        '                            <label class="layui-form-label form_label">备注</label>\n' +
        '                            <div class="layui-input-block form_block">\n' +
        '                                <input name="memo"  class="layui-input">\n' +
        '                            </div>\n' +
        '                        </div>\n' +
        '                    </div>\n' +
        '                    <div class="layui-col-xs4" style="padding: 0 5px;">\n' +
        '                        <div class="layui-form-item">\n' +
        '                            <label class="layui-form-label form_label">填报人<span field="createUserName" class="field_required">*</span></label>\n' +
        '                            <div class="layui-input-block form_block">\n' +
        '                                <input type="text" readonly name="createUserName" autocomplete="off" class="layui-input" style="cursor: pointer;">\n' +
        '                            </div>\n' +
        '                        </div>\n' +
        '                    </div>\n' +
        '                </div>\n' +
        <%--                /* endregion */--%>
        <%--                /* region 第三行 */--%>
        // '                <div class="layui-row">\n' +
        //
        //
        //
        // '                </div>\n' +
        <%--                /* endregion */--%>
        <%--                /* region 第四行 */--%>
        // '                <div class="layui-row">\n' +
        /*'                    <div class="layui-col-xs4" style="padding: 0 5px;display: none;">\n' +
        '                        <div class="layui-form-item">\n' +
        '                            <label class="layui-form-label form_label">变更单选择</label>\n' + //<span field="itemType2" class="field_required">*</span>
        '                            <div class="layui-input-block form_block">\n' +
        '                                <input type="text" name="itemType2" id="itemType2" autocomplete="off"  class="layui-input ">\n' +
        '                            </div>\n' +
        '                        </div>\n' +
        '                    </div>\n' +*/

        // '                </div>\n' +
        <%--                /* endregion */--%>
        <%--                /* region 第五行 */--%>
        '                <div class="layui-row">\n' +
        '                    <div class="layui-col-xs4" style="padding: 0 5px;">\n' +
        '                        <div class="layui-form-item">\n' +
        '                            <label class="layui-form-label form_label">填报时间<span field="createTime" class="field_required">*</span></label>\n' +
        '                            <div class="layui-input-block form_block">\n' +
        '                                <input type="text" readonly name="createTime" autocomplete="off" class="layui-input" style="cursor: pointer;">\n' +
        '                            </div>\n' +
        '                        </div>\n' +
        '                    </div>\n' +
        '                </div>\n' +
        <%--                /* endregion */--%>
        <%--                /* region 第六行 */--%>
        '                <div class="layui-row">\n' +
        '                    <div class="layui-col-xs6" style="padding: 0 5px;">\n' +
        '                        <div class="layui-form-item">\n' +
        '                            <label class="layui-form-label form_label">经营立项内容<span field="manageProjContent" class="field_required">*</span></label>\n' +
        '                            <div class="layui-input-block form_block">\n' +
        '                                <textarea name="manageProjContent" id="manageProjContent" placeholder="请输入立项内容" class="layui-textarea"></textarea>\n' +
        '                            </div>\n' +
        '                        </div>\n' +
        '                    </div>\n' +
        '                </div>\n' +
        <%--                /* endregion */--%>
        <%--                /* region 第七行 */--%>
        '                <div class="layui-row">\n' +
        '                    <div class="layui-col-xs12" style="padding: 0 5px;">\n' +
        '                        <div class="layui-form-item">\n' +
        '                            <label class="layui-form-label form_label">附件</label>\n' +
        '                            <div class="layui-input-block form_block">\n' +
        '                                <div class="file_module">\n' +
        '                                    <div id="fileContent" class="file_content"></div>\n' +
        '                                    <div class="file_upload_box">\n' +
        '                                        <a href="javascript:;" class="open_file">\n' +
        '                                            <img src="/img/mg11.png" style="margin: -3px 5px 0 0;"><span>添加附件</span>\n' +
        '                                            <input type="file" multiple id="fileupload" data-url="/upload?module=operateManage" name="file">\n' +
        '                                        </a>\n' +
        '                                        <div class="progress" id="progress">\n' +
        '                                            <div class="bar"></div>\n' +
        '                                        </div>\n' +
        '                                        <div class="bar_text"></div>\n' +
        '                                    </div>\n' +
        '                                </div>\n' +
        '                            </div>\n' +
        '                        </div>\n' +
        '                    </div>\n' +
        '                </div>\n' +
        <%--                /* endregion */--%>
        '            </form>\n' +
        '        </div>\n' +
        '    </div>\n' +
        <%--    /* endregion */--%>
        <%--    /* region 立项明细 */--%>
        '    <div class="layui-colla-item">\n' +
        '        <h2 class="layui-colla-title">立项明细</h2>\n' +
        '        <div class="layui-colla-content mtl_info layui-show">\n' +
        '            <div>\n' +
        '                <table id="materialDetailsTable" lay-filter="materialDetailsTable"></table>\n' +
        '            </div>\n' +
        '        </div>\n' +
        '    </div>\n' +
        <%--    /* endregion */--%>
        <%--    /* region 立项明细 */--%>
        '    <div class="layui-colla-item">\n' +
        '        <h2 class="layui-colla-title">变更单明细</h2>\n' +
        '        <div class="layui-colla-content mtl_info2 layui-show">\n' +
        '            <div>\n' +
        '                <table id="materialDetailsTable2" lay-filter="materialDetailsTable2"></table>\n' +
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
    layui.use(['form', 'table', 'element', 'soulTable', 'eleTree','xmSelect','laydate'], function () {
        var form = layui.form,
            table = layui.table,
            element = layui.element,
            soulTable = layui.soulTable,
            eleTree = layui.eleTree,
            xmSelect = layui.xmSelect
            laydate = layui.laydate;
        //回显数据

        if(manageProjId!=undefined&&manageProjId!=""&&manageProjId!=null){ //根据主键id查询数据
            $.ajax({
                url:"/manageProject/getById?registerId="+manageProjId,
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
                url:"/manageProject/getById?runId="+runId,
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
            //回显项目名称
            getProjName('#projectName',data.projectId)

            //经营立项类型
            var $select1 = $("#manageProjType");
            var optionStr = '<option value="">请选择</option>';
            var _str=dictionaryObj.MANAGE_ITEM_TYPE.str;
            if(_str!=undefined){
                optionStr += _str
            }
            $select1.html(optionStr);

            form.on('select(test)', function(data){

                manageProj_state = data.value;
                if(manageProj_state=='01'){
                    $('#firstPartyOrderFlag').val(manageProj_data ? manageProj_data.firstPartyOrderFlag : '');
                    $('#manageProjContent').val(manageProj_data ? manageProj_data.registerContent : '');
                }
            });
            //经营立项日期
            laydate.render({
                elem: '#projectDate'
                , trigger: 'click'
                , format: 'yyyy-MM-dd'
                // , format: 'yyyy-MM-dd HH:mm:ss'
                //,value: new Date()
            });

            //附件
            fileuploadFn('#fileupload', $('#fileContent'));

            //回显数据
            if (type == 1 || type == 4) {
                if(data!=undefined){
                    form.val("baseForm", data);
                    //项目名称
                    _projectId = data.projectId;

                    $('#itemType').val(data ? data.itemName : '');

                    //$('#planDate').val(data ? format(data.planDate) : '')

                    if (data.attachmentList && data.attachmentList.length > 0) {
                        var fileArr = data.attachmentList;
                        $('#fileContent').append(echoAttachment(fileArr));
                    }

                    materialDetailsTableData = data.manageInfoList;
                    materialDetailsTableData2 = data.detailList;
                }
            }

            //立项明细
            var cols=[
                {type: 'numbers', title: '序号'},
                /*{
                    field: 'projBudgetId', title: '目标选择',minWidth:100, templet: function (d) {
                        return '<p name="projBudgetId" style="text-align: center"><i class="layui-icon layui-icon-add-circle chooseMaterials" style="font-size: 25px;cursor: pointer"></i></p>'
                    }
                },*/
                {
                    field: 'wbsId', title: 'WBS',minWidth:230, templet: function (d) {
                        return '<input type="text" readonly name="wbsId" wbsId="'+d.wbsId+'" projBudgetId="'+(d.projBudgetId||"")+'"  manageProjInfoId="'+(d.manageProjInfoId||"")+'" manageProjId="'+(d.manageProjId||"")+'" class="layui-input" style="height: 100%;background: #e7e7e7;" value="' + (d.wbsName || '') + '">'
                    }
                },
                {
                    field: 'rbsId', title: 'RBS',minWidth:230, templet: function (d) {
                        return '<input type="text" readonly name="rbsId" rbsId="'+d.rbsId+'"  class="layui-input" style="height: 100%;background: #e7e7e7;" value="' + (d.rbsName || '') + '">'
                    }
                },
                {
                    field: 'cbsId', title: 'CBS',minWidth:200, templet: function (d) {
                        return '<input type="text" readonly name="cbsId" cbsId="'+d.cbsId+'" class="layui-input" style="height: 100%;background: #e7e7e7;" value="' + (d.cbsName || '') + '">'
                    }
                },
                {
                    field: 'incomeTarNum', title: '收入目标数量',minWidth:120, templet: function (d) {
                        return '<input type="number" readonly name="incomeTarNum" class="layui-input" style="height: 100%;background: #e7e7e7;" value="' + (d.incomeTarNum || 0) + '">'
                    }
                },
                {
                    field: 'incomeTarPrice', title: '收入目标单价',minWidth:120, templet: function (d) {
                        return '<input type="number" readonly name="incomeTarPrice" class="layui-input" style="height: 100%;background: #e7e7e7;" value="' + (d.incomeTarPrice || 0) + '">'
                    }
                },
                {
                    field: 'incomeTarAmount', title: '收入目标金额',minWidth:120, templet: function (d) {
                        return '<input type="number" readonly name="incomeTarAmount" class="layui-input" style="height: 100%;background: #e7e7e7;" value="' + (d.incomeTarAmount || 0) + '">'
                    }
                },
                {
                    field: 'optTarNum', title: '优化目标数量',minWidth:120, templet: function (d) {
                        return '<input type="number" readonly name="optTarNum" class="layui-input" style="height: 100%;background: #e7e7e7;" value="' + (d.optTarNum || 0) + '">'
                    }
                },
                {
                    field: 'optTarPrice', title: '优化目标单价',minWidth:120, templet: function (d) {
                        return '<input type="number" readonly name="optTarPrice" class="layui-input" style="height: 100%;background: #e7e7e7;" value="' + (d.optTarPrice || 0) + '">'
                    }
                },
                {
                    field: 'optTarAmount', title: '优化目标金额',minWidth:120, templet: function (d) {
                        return '<input type="number" readonly name="optTarAmount" class="layui-input" style="height: 100%;background: #e7e7e7;" value="' + (d.optTarAmount || 0) + '">'
                    }
                },
                {
                    field: 'manageTarNum', title: '管理目标数量',minWidth:120, templet: function (d) {
                        return '<input type="number" readonly name="manageTarNum" class="layui-input" style="height: 100%;background: #e7e7e7;" value="' + (d.manageTarNum || 0) + '">'
                    }
                },
                {
                    field: 'manageTarPrice', title: '管理目标单价',minWidth:120, templet: function (d) {
                        return '<input type="number" readonly name="manageTarPrice" class="layui-input" style="height: 100%;background: #e7e7e7;" value="' + (d.manageTarPrice || 0) + '">'
                    }
                },
                {
                    field: 'manageTarAmount', title: '管理目标金额',minWidth:120, templet: function (d) {
                        return '<input type="number" readonly name="manageTarAmount" class="layui-input" style="height: 100%;background: #e7e7e7;" value="' + (d.manageTarAmount || 0) + '">'
                    }
                },
                {
                    field: 'runTarNum', title: '经营目标数量',minWidth:120, templet: function (d) {
                        return '<input type="number" name="runTarNum" class="layui-input" style="height: 100%;" value="' + (d.runTarNum || 0) + '">'
                    }
                },
                // {
                //     field: 'runTarPrice', title: '经营目标单价',minWidth:120, templet: function (d) {
                //         return '<input type="number" name="runTarPrice" class="layui-input" style="height: 100%;" value="' + (d.runTarPrice || 0) + '">'
                //     }
                // },
                {
                    field: 'runTarAmount', title: '经营目标金额',minWidth:120, templet: function (d) {
                        return '<input type="number" name="runTarAmount" class="layui-input target_amount" style="height: 100%;" value="' + (d.runTarAmount || 0) + '">'
                    }
                },
                {
                    field: 'manTarOptNum', title: '经营目标优化数量',minWidth:160, templet: function (d) {
                        return '<input type="number" name="manTarOptNum" class="layui-input" style="height: 100%;" value="' + (d.manTarOptNum || 0) + '">'
                    }
                },
                {
                    field: 'manTarOptAmount', title: '经营目标优化金额',minWidth:160, templet: function (d) {
                        return '<input type="number" name="manTarOptAmount" class="layui-input target_amount" style="height: 100%;" value="' + (d.manTarOptAmount || 0) + '">'
                    }
                },
                {
                    field: 'aftManTarNum', title: '优化后经营目标数量',minWidth:160, templet: function (d) {
                        return '<input type="number" readonly name="aftManTarNum" class="layui-input" style="height: 100%;background: #e7e7e7;" value="' + (d.aftManTarNum || 0) + '">'
                    }
                },
                // {
                //     field: 'aftManTarPrice', title: '优化后经营目标单价',minWidth:160, templet: function (d) {
                //         return '<input type="number" readonly name="aftManTarPrice" class="layui-input" style="height: 100%;background: #e7e7e7;" value="' + (d.aftManTarPrice || 0) + '">'
                //     }
                // },
                {
                    field: 'aftManTarAmount', title: '优化后经营目标金额',minWidth:160, templet: function (d) {
                        return '<input type="number" readonly name="aftManTarAmount" class="layui-input" style="height: 100%;background: #e7e7e7;" value="' + (d.aftManTarAmount || 0) + '">'
                    }
                },
                {
                    field: 'adjIncomeTarNum', title: '调整后收入目标数量',minWidth:160, templet: function (d) {
                        return '<input type="number" readonly name="adjIncomeTarNum" class="layui-input" style="height: 100%;background: #e7e7e7;" value="' + (d.adjIncomeTarNum || 0) + '">'
                    }
                },
                {
                    field: 'adjIncomeTarPrice', title: '调整后收入目标单价',minWidth:160, templet: function (d) {
                        return '<input type="number" readonly name="adjIncomeTarPrice" class="layui-input" style="height: 100%;background: #e7e7e7;" value="' + (d.adjIncomeTarPrice || 0) + '">'
                    }
                },
                {
                    field: 'adjIncomeTarAmount', title: '调整后收入目标金额',minWidth:160, templet: function (d) {
                        return '<input type="number" readonly name="adjIncomeTarAmount" class="layui-input" style="height: 100%;background: #e7e7e7;" value="' + (d.adjIncomeTarAmount || 0) + '">'
                    }
                },
                {
                    field: 'adjOptTarNum', title: '调整后优化目标数量',minWidth:160, templet: function (d) {
                        return '<input type="number" readonly name="adjOptTarNum" class="layui-input" style="height: 100%;background: #e7e7e7;" value="' + (d.adjOptTarNum || 0) + '">'
                    }
                },
                {
                    field: 'adjOptTarPrice', title: '调整后优化目标单价',minWidth:160, templet: function (d) {
                        return '<input type="number" readonly name="adjOptTarPrice" class="layui-input" style="height: 100%;background: #e7e7e7;" value="' + (d.adjOptTarPrice || 0) + '">'
                    }
                },
                {
                    field: 'adjOptTarAmount', title: '调整后优化目标金额',minWidth:160, templet: function (d) {
                        return '<input type="number" readonly name="adjOptTarAmount" class="layui-input" style="height: 100%;background: #e7e7e7;" value="' + (d.adjOptTarAmount || 0) + '">'
                    }
                },
                {
                    field: 'adjManTarNum', title: '调整后管理目标数量',minWidth:160, templet: function (d) {
                        return '<input type="number" readonly name="adjManTarNum" class="layui-input" style="height: 100%;background: #e7e7e7;" value="' + (d.adjManTarNum || 0) + '">'
                    }
                },
                {
                    field: 'adjManTarPrice', title: '调整后管理目单价',minWidth:160, templet: function (d) {
                        return '<input type="number" readonly name="adjManTarPrice" class="layui-input" style="height: 100%;background: #e7e7e7;" value="' + (d.adjManTarPrice || 0) + '">'
                    }
                },
                {
                    field: 'adjManTarAmount', title: '调整后管理目金额',minWidth:160, templet: function (d) {
                        return '<input type="number" readonly name="adjManTarAmount" class="layui-input" style="height: 100%;background: #e7e7e7;" value="' + (d.adjManTarAmount || 0) + '">'
                    }
                }
            ]
            if(type!=4){
                cols.push({align: 'center', toolbar: '#barDemo', title: '操作', minWidth: 100,fixed:'right'})
            }
            table.render({
                elem: '#materialDetailsTable',
                data: materialDetailsTableData,
                toolbar: type==4?false:'#toolbarDemoIn',
                defaultToolbar: [''],
                limit: 1000,
                cols: [cols],
                done:function (obj) {
                    /*if(type==4){
                        $('.addRow').hide()
                    }*/
                    if(obj != undefined&&obj.data != undefined){
                        //
                        materialDetailsTableData = obj.data;
                    }

                }
            });

            //变更单明细表
            var cols2=[
                {type: 'numbers', title: '序号'},
                {field: 'registerNo', title: '变更单编号',minWidth:180, templet: function (d) {
                        return '<input type="text" name="registerNo" readonly registerId="'+d.registerId+'" manageProjInfoId="'+(d.manageProjInfoId||"")+'" projectId="'+(d.projectId||"")+'" class="layui-input " style="height: 100%;" value="' + (d.registerNo || '') + '">'
                    }},
                {field: 'registerName', title: '变更单名称',minWidth:120, templet: function (d) {
                        return '<input type="text" name="registerName" readonly class="layui-input " style="height: 100%;" value="' + (d.registerName || '') + '">'
                    }},
                {
                    field: 'registerCategory', title: '变更单类别',minWidth:120, templet: function (d) {
                        return '<input type="text" name="registerCategoryName" readonly registerCategory="'+d.registerCategory+'" class="layui-input " style="height: 100%;" value="' + (d.registerCategoryName || '') + '">'
                    }
                },
                {
                    field: 'registerType', title: '变更单类型', minWidth:120,templet: function (d) {
                        return '<input type="text" name="registerTypeName" readonly registerType="'+d.registerType+'" class="layui-input " style="height: 100%;" value="' + (d.registerTypeName || '') + '">'
                    }
                },
                {field: 'constructionDrawingsNo', title: '施工图纸编号',minWidth:140, templet: function (d) {
                        return '<input type="text" name="constructionDrawingsNo" readonly class="layui-input " style="height: 100%;" value="' + (d.constructionDrawingsNo || '') + '">'
                    }},
                {field: 'firstPartyOrderFlag', title: '甲方是否下达指令',minWidth:180, templet: function (d) {
                        if (d.firstPartyOrderFlag){
                            if(d.firstPartyOrderFlag=='0'){
                                return '<span firstPartyOrderFlag="' + (d.firstPartyOrderFlag || '') + '">是</span>'
                            }else if(d.firstPartyOrderFlag=='1'){
                                return '<span firstPartyOrderFlag="' + (d.firstPartyOrderFlag || '') + '">否</span>'
                            }
                        }else {
                            return ''
                        }
                    }
                },
                {field: 'registerDate', title: '变更日期',minWidth:160, templet: function (d) {
                        return '<input type="text" name="registerDate" readonly class="layui-input " style="height: 100%;" value="' + (d.registerDate || '') + '">'
                    }}
            ]
            // if(type!=4){
                cols2.push({align: 'center', toolbar: '#barDemo2', title: '操作', minWidth: 150,fixed:'right'})
            // }
            table.render({
                elem: '#materialDetailsTable2',
                data: materialDetailsTableData2,
                toolbar: type==4?false:'#toolbarDemoIn2',
                defaultToolbar: [''],
                limit: 1000,
                cols: [cols2],
                done:function (obj) {
                    if(type==4){
                        $('.addRow').hide()
                    }
                    if(obj != undefined&&obj.data != undefined){
                        materialDetailsTableData2 = obj.data;
                    }
                }
            });
            //查看详情
            if(type==4){
                $('._disabled [name]').attr('disabled', true);
                // $('.layui-layer-btn-c').hide()
                $('.file_upload_box').hide()
                $('.deImgs').hide()
                $('.chooseManagementBudget').hide()
            }
            form.render();
            element.render();
        }
        // 立项明细-选择
        table.on('toolbar(materialDetailsTable)', function (obj) {
            switch (obj.event) {
                case 'add':

                    var wbsSelectTree = null;
                    var rbsSelectTree = null;
                    var cbsSelectTree = null;
                    var _this = $(this);
                    layer.open({
                        type: 1,
                        title: '管理目标选择',
                        area: ['90%', '80%'],
                        maxmin: true,
                        btn: ['确定', '取消'],
                        btnAlign: 'c',
                        content: ['<div class="layui-form" id="objectives">' +
                        //下拉选择
                        '           <div class="layui-row" style="margin-top: 10px">' +
                        // '               <div class="layui-col-xs2">' +
                        // '                   <div class="layui-form-item">\n' +
                        // '                       <label class="layui-form-label" style="width:85px">预算科目编号</label>\n' +
                        // '                       <div class="layui-input-block" style="margin-left: 115px">\n' +
                        // '                          <input type="text" name="itemNo"  autocomplete="off" class="layui-input">'+
                        // '                       </div>\n' +
                        // '                   </div>' +
                        // '               </div>' +
                        // '               <div class="layui-col-xs2">' +
                        // '                   <div class="layui-form-item">\n' +
                        // '                       <label class="layui-form-label" style="width:85px">预算科目名称</label>\n' +
                        // '                       <div class="layui-input-block" style="margin-left: 115px">\n' +
                        // '                          <input type="text" name="itemName"  autocomplete="off" class="layui-input">'+
                        // '                       </div>\n' +
                        // '                   </div>' +
                        // '               </div>' +
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
                        '                       <label class="layui-form-label">RBS</label>\n' +
                        '                       <div class="layui-input-block">\n' +
                        '<div id="rbsSelectTree" class="xm-select-demo" style="width: 100%;"></div>' +
                        '                       </div>\n' +
                        '                   </div>' +
                        '               </div>' ,
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
                            wbsSelectTree = xmSelect.render({
                                el: '#wbsSelectTree',
                                content: '<input type="text" placeholder="请输入关键字进行搜索" autocomplete="off" class="layui-input eleTree-search wbsSearch" style="width: 80%;margin: 5px"><div id="wbsTree" class="eleTree" lay-filter="wbsTree"></div>',
                                name: 'wbsName',
                                prop: {
                                    name: 'wbsName',
                                    value: 'id'
                                }
                            });
                            wbsData()
                            // 树节点点击事件
                            eleTree.on("nodeClick(wbsTree)", function (d) {
                                var currentData = d.data.currentData;
                                var obj = {
                                    wbsName: currentData.wbsName,
                                    id: currentData.id
                                }
                                wbsSelectTree.setValue([obj]);
                            });

                            var searchTimerWBS = null
                            $('.wbsSearch').on('input propertychange', function () {
                                clearTimeout(searchTimerWBS)
                                searchTimerWBS = null
                                var val = $(this).val()
                                searchTimerWBS = setTimeout(function () {
                                    wbsData(val)
                                }, 300)
                            });

                            function wbsData(wbsName){
                                $.get('/plbProjWbs/getWbsTreeByProjId',{projId:$('#leftId').attr('projId'),wbsName:wbsName}, function (res) {
                                    eleTree.render({
                                        elem: '#wbsTree',
                                        data: res.obj,
                                        highlightCurrent: true,
                                        showLine: true,
                                        // defaultExpandAll: false,
                                        request: {
                                            name: 'wbsName',
                                            children: "child"
                                        }
                                    });
                                });
                            }


                            // 获取CBS数据
                            cbsSelectTree = xmSelect.render({
                                el: '#cbsSelectTree',
                                content: '<input type="text" placeholder="请输入关键字进行搜索" autocomplete="off" class="layui-input eleTree-search cbsSearch" style="width: 80%;margin: 5px"><div id="cbsTree" class="eleTree" lay-filter="cbsTree"></div>',
                                name: 'cbsName',
                                prop: {
                                    name: 'cbsName',
                                    value: 'cbsId'
                                }
                            });
                            cbsData()
                            // 树节点点击事件
                            eleTree.on("nodeClick(cbsTree)", function (d) {
                                var currentData = d.data.currentData;
                                var obj = {
                                    cbsName: currentData.cbsName,
                                    cbsId: currentData.cbsId
                                }
                                cbsSelectTree.setValue([obj]);
                            });

                            var searchTimerCBS = null
                            $('.cbsSearch').on('input propertychange', function () {
                                clearTimeout(searchTimerCBS)
                                searchTimerCBS = null
                                var val = $(this).val()
                                searchTimerCBS = setTimeout(function () {
                                    cbsData(val)
                                }, 300)
                            });

                            function cbsData(cbsName){
                                $.get('/plbCbsType/getAllList',{cbsName:cbsName}, function (res) {
                                    eleTree.render({
                                        elem: '#cbsTree',
                                        data: res.data,
                                        highlightCurrent: true,
                                        showLine: true,
                                        // defaultExpandAll: false,
                                        request: {
                                            name: 'cbsName',
                                            children: "childList"
                                        }
                                    });
                                });
                            }

                            //获取RBS数据
                            rbsSelectTree = xmSelect.render({
                                el: '#rbsSelectTree',
                                content: '<input type="text" placeholder="请输入关键字进行搜索" autocomplete="off" class="layui-input eleTree-search rbsSearch" style="width: 80%;margin: 5px"><div id="rbsTree" class="eleTree" lay-filter="rbsTree"></div>',
                                name: 'rbsName',
                                prop: {
                                    name: 'rbsName',
                                    value: 'rbsId'
                                }
                            });
                            rbsData();
                            // 树节点点击事件
                            eleTree.on("nodeClick(rbsTree)", function (d) {
                                var currentData = d.data.currentData;
                                var obj = {
                                    rbsName: currentData.rbsName,
                                    rbsId: currentData.rbsId
                                }
                                rbsSelectTree.setValue([obj]);
                            });
                            var searchTimerRBS = null
                            $('.rbsSearch').on('input propertychange', function () {
                                clearTimeout(searchTimerRBS)
                                searchTimerRBS = null
                                var val = $(this).val()
                                searchTimerRBS = setTimeout(function () {
                                    rbsData(val,'1')
                                }, 300)
                            });
                            function rbsData(parentId,type){
                                var obj = {};
                                if(type == '1'){
                                    obj.rbsName=parentId?parentId:'';
                                }else {
                                    obj.parentId=parentId?parentId:'0';
                                }
                                // 获取RBS数据
                                $.get('/plbRbs/selectAll',obj, function (res) {
                                    var rbsTreeData = res.data || [];

                                    eleTree.render({
                                        elem: '#rbsTree',
                                        data: rbsTreeData,
                                        highlightCurrent: true,
                                        showLine: true,
                                        defaultExpandAll: false,
                                        accordion: true,
                                        lazy: true,
                                        request: {
                                            name: 'rbsName',
                                            children: "childList"
                                        },
                                        load: function (data, callback) {
                                            $.post('/plbRbs/selectAll?parentId=' + data.rbsId, function (res) {
                                                callback(res.data);//点击节点回调
                                            })
                                        }
                                    });

                                });
                            }
                            laodTable();

                            $('.search_mtl').on('click', function(){
                                var cbsId = cbsSelectTree.getValue('valueStr');
                                var wbsId = wbsSelectTree.getValue('valueStr');
                                var rbsId = rbsSelectTree.getValue('valueStr');
                                var itemNo = $('[name="itemNo"]').val();
                                var itemName =$('[name="itemName"]').val();

                                laodTable(wbsId, cbsId,rbsId,itemNo,itemName);
                            });

                            // 加载表格
                            function laodTable(wbsId, cbsId,rbsId,itemNo,itemName) {
                                table.render({
                                    elem: '#managementBudgetTable',
                                    url: '/manageProject/getBudgetByProjId',
                                    where: {
                                        projId: $('#leftId').attr('projId'),
                                        wbsId: wbsId || '',
                                        cbsId: cbsId || '',
                                        rbsId: rbsId || '',
                                        itemNo: itemNo || '',
                                        itemName: itemName || '',
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
                                            field: 'wbsName', title: 'WBS',minWidth:200, templet: function(d) {
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
                                            field: 'cbsName', title: 'CBS',minWidth:200, templet: function (d) {
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
                                        {field: 'manageTarNum', title: '管理目标数量',minWidth:120},
                                        {field: 'manageTarPrice', title: '管理目标单价',minWidth:120},
                                        {field: 'manageTarAmount', title: '管理目标金额',minWidth:120},
                                        {field:'incomeTarAmount',title:'收入目标金额',minWidth:120},
                                        {field:'optTarAmount',title:'优化目标金额',minWidth:120},
                                        // {field: 'addupNeedAmount', title: '已提需求计划数量',minWidth:170},
                                        // {field: 'addupNeedMoney', title: '累计已提需求计划金额',minWidth:170},
                                        // {field: 'manageSurplusAmount', title: '管理目标数量余额',minWidth:150},
                                        // {field: 'manageSurplusMoney', title: '管理目标金额余额',minWidth:150},

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

                            //立项明细
                            var $tr = $('.mtl_info').find('.layui-table-main tr');
                            var manageInfoList = [];
                            $tr.each(function () {
                                var plbManageItemObj = {
                                    wbsName: $(this).find('input[name="wbsId"]').val(),
                                    wbsId: $(this).find('input[name="wbsId"]').attr('wbsId'),
                                    rbsName: $(this).find('input[name="rbsId"]').val(),
                                    rbsId: $(this).find('input[name="rbsId"]').attr('rbsId'),
                                    cbsName: $(this).find('input[name="cbsId"]').val(),
                                    cbsId: $(this).find('input[name="cbsId"]').attr('cbsId'),
                                    incomeTarNum: $(this).find('input[name="incomeTarNum"]').val(),
                                    incomeTarPrice: $(this).find('input[name="incomeTarPrice"]').val(),
                                    incomeTarAmount: $(this).find('input[name="incomeTarAmount"]').val(),
                                    optTarNum: $(this).find('input[name="optTarNum"]').val(),
                                    optTarPrice: $(this).find('input[name="optTarPrice"]').val(),
                                    optTarAmount: $(this).find('input[name="optTarAmount"]').val(),
                                    manageTarNum: $(this).find('input[name="manageTarNum"]').val(),
                                    manageTarPrice: $(this).find('input[name="manageTarPrice"]').val(),
                                    manageTarAmount: $(this).find('input[name="manageTarAmount"]').val(),

                                    runTarNum: $(this).find('input[name="runTarNum"]').val(),
                                    // runTarPrice: $(this).find('input[name="runTarPrice"]').val(),
                                    runTarAmount: $(this).find('input[name="runTarAmount"]').val(),

                                    manTarOptNum: $(this).find('input[name="manTarOptNum"]').val(),
                                    manTarOptAmount: $(this).find('input[name="manTarOptAmount"]').val(),

                                    aftManTarNum: $(this).find('input[name="aftManTarNum"]').val(),
                                    // aftManTarPrice: $(this).find('input[name="aftManTarPrice"]').val(),
                                    aftManTarAmount: $(this).find('input[name="aftManTarAmount"]').val(),
                                    adjIncomeTarNum: $(this).find('input[name="adjIncomeTarNum"]').val(),
                                    adjIncomeTarPrice: $(this).find('input[name="adjIncomeTarPrice"]').val(),
                                    adjIncomeTarAmount: $(this).find('input[name="adjIncomeTarAmount"]').val(),
                                    adjOptTarNum: $(this).find('input[name="adjOptTarNum"]').val(),
                                    adjOptTarPrice: $(this).find('input[name="adjOptTarPrice"]').val(),
                                    adjOptTarAmount: $(this).find('input[name="adjOptTarAmount"]').val(),
                                    adjManTarNum: $(this).find('input[name="adjManTarNum"]').val(),
                                    adjManTarPrice: $(this).find('input[name="adjManTarPrice"]').val(),
                                    adjManTarAmount: $(this).find('input[name="adjManTarAmount"]').val(),
                                }
                                if($(this).find('input[name="wbsId"]').attr('projBudgetId')){
                                    plbManageItemObj.projBudgetId=$(this).find('input[name="wbsId"]').attr('projBudgetId');
                                }
                                if($(this).find('input[name="wbsId"]').attr('manageProjInfoId')){
                                    plbManageItemObj.manageProjInfoId=$(this).find('input[name="wbsId"]').attr('manageProjInfoId');
                                }
                                if($(this).find('input[name="wbsId"]').attr('manageProjId')){
                                    plbManageItemObj.manageProjInfoId=$(this).find('input[name="wbsId"]').attr('manageProjId');
                                }
                                manageInfoList.push(plbManageItemObj);
                            });
                            materialDetailsTableData = manageInfoList;

                            var oldDataArr = [];
                            if (checkStatus.length > 0) {
                                for(var i=0;i<checkStatus.length;i++){
                                    var oldDataObj = {
                                        projBudgetId:checkStatus[i].projBudgetId||'',
                                        wbsName:checkStatus[i].plbProjWbs?checkStatus[i].plbProjWbs.wbsName:'',
                                        wbsId:checkStatus[i].plbProjWbs?checkStatus[i].plbProjWbs.wbsId:'',
                                        rbsName:checkStatus[i].plbRbs?checkStatus[i].plbRbs.rbsLongName:'',
                                        rbsId:checkStatus[i].plbRbs?checkStatus[i].plbRbs.rbsId:'',
                                        cbsName:checkStatus[i].plbCbsTypeWithBLOBs?checkStatus[i].plbCbsTypeWithBLOBs.cbsName:'',
                                        cbsId:checkStatus[i].plbCbsTypeWithBLOBs?checkStatus[i].plbCbsTypeWithBLOBs.cbsId:'',
                                        incomeTarNum:checkStatus[i].incomeTarNum,
                                        incomeTarPrice:checkStatus[i].incomeTarPrice,
                                        incomeTarAmount:checkStatus[i].incomeTarAmount,
                                        optTarNum:checkStatus[i].optTarNum,
                                        optTarPrice:checkStatus[i].optTarPrice,
                                        optTarAmount:checkStatus[i].optTarAmount,
                                        manageTarNum:checkStatus[i].manageTarNum,
                                        manageTarPrice:checkStatus[i].manageTarPrice,
                                        manageTarAmount:checkStatus[i].manageTarAmount,


                                        adjIncomeTarNum:checkStatus[i].incomeTarNum,
                                        adjIncomeTarPrice:checkStatus[i].incomeTarPrice,
                                        adjIncomeTarAmount:checkStatus[i].incomeTarAmount,
                                        adjOptTarNum:checkStatus[i].optTarNum,
                                        adjOptTarPrice:checkStatus[i].optTarPrice,
                                        adjOptTarAmount:checkStatus[i].optTarAmount,
                                        adjManTarNum:checkStatus[i].manageTarNum,
                                        adjManTarPrice:checkStatus[i].manageTarPrice,
                                        adjManTarAmount:checkStatus[i].manageTarAmount
                                    }
                                    if(manageProj_state=='02'){
                                        oldDataObj.runTarNum=checkStatus[i].runTarNum;
                                        // oldDataObj.runTarPrice=checkStatus[i].runTarPrice;
                                        oldDataObj.runTarAmount=checkStatus[i].runTarAmount;
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


                                /* _this.parents('tr').find('[name="wbsId"]').attr('projBudgetId',mtlData ? mtlData.projBudgetId : '');

                                 _this.parents('tr').find('[name="wbsId"]').val(mtlData.plbProjWbs ? mtlData.plbProjWbs.wbsName : '');
                                 _this.parents('tr').find('[name="wbsId"]').attr('wbsId', mtlData.plbProjWbs ? mtlData.plbProjWbs.wbsId : '');
                                 _this.parents('tr').find('[name="cbsId"]').val(mtlData.plbCbsTypeWithBLOBs ? mtlData.plbCbsTypeWithBLOBs.cbsName : '');
                                 _this.parents('tr').find('[name="cbsId"]').attr('cbsId', mtlData.plbCbsTypeWithBLOBs ? mtlData.plbCbsTypeWithBLOBs.cbsId : '');
                                 _this.parents('tr').find('[name="incomeTarNum"]').val(mtlData ? mtlData.incomeTarNum : '');
                                 _this.parents('tr').find('[name="incomeTarPrice"]').val(mtlData ? mtlData.incomeTarPrice : '');
                                 _this.parents('tr').find('[name="incomeTarAmount"]').val(mtlData ? mtlData.incomeTarAmount : '');
                                 _this.parents('tr').find('[name="optTarNum"]').val(mtlData ? mtlData.optTarNum : '');
                                 _this.parents('tr').find('[name="optTarPrice"]').val(mtlData ? mtlData.optTarPrice : '');
                                 _this.parents('tr').find('[name="optTarAmount"]').val(mtlData ? mtlData.optTarAmount : '');
                                 _this.parents('tr').find('[name="manageTarNum"]').val(mtlData ? mtlData.manageTarNum : '');
                                 _this.parents('tr').find('[name="manageTarPrice"]').val(mtlData ? mtlData.manageTarPrice : '');
                                 _this.parents('tr').find('[name="manageTarAmount"]').val(mtlData ? mtlData.manageTarAmount : '');

                                 if(manageProj_state=='02'){
                                     _this.parents('tr').find('[name="runTarNum"]').val(mtlData ? mtlData.runTarNum : '');
                                     _this.parents('tr').find('[name="runTarPrice"]').val(mtlData ? mtlData.runTarPrice : '');
                                     _this.parents('tr').find('[name="runTarAmount"]').val(mtlData ? mtlData.runTarAmount : '');
                                 }*/

                            } else {
                                layer.msg('请选择一项！', {icon: 0});
                            }
                        }
                    });
                    break;
            }
        });
        // 立项明细-删行操作
        table.on('tool(materialDetailsTable)', function (obj) {
            var data = obj.data;
            var layEvent = obj.event;
            if (layEvent === 'del') {
                if(data.manageProjInfoId){
                    $.ajax({
                        url: '/manageInfo/del?ids='+data.manageProjInfoId,
                        dataType: 'json',
                        type: 'post',
                        success: function (res) {
                            /*if (res.code==='0'||res.code===0) {
                                layer.msg(res.msg, {icon: 1});
                            } else {
                                layer.msg(res.msg, {icon: 2});
                            }*/
                        }
                    });
                }

                obj.del();

                //遍历表格获取每行数据进行保存
                var $tr = $('.mtl_info').find('.layui-table-main tr');
                var oldDataArr = [];
                $tr.each(function () {
                    var oldDataObj = {
                        projBudgetId:$(this).find('input[name="wbsId"]').attr('projBudgetId')||'',
                        manageProjInfoId:$(this).find('input[name="wbsId"]').attr('manageProjInfoId')||'',
                        manageProjId: $(this).find('input[name="wbsId"]').attr('manageProjId')||'',
                        wbsName: $(this).find('input[name="wbsId"]').val(),
                        wbsId: $(this).find('input[name="wbsId"]').attr('wbsId')||'',
                        rbsName: $(this).find('input[name="rbsId"]').val(),
                        rbsId: $(this).find('input[name="rbsId"]').attr('rbsId')||'',
                        cbsName: $(this).find('input[name="cbsId"]').val(),
                        cbsId: $(this).find('input[name="cbsId"]').attr('cbsId')||'',
                        incomeTarNum: $(this).find('input[name="incomeTarNum"]').val(),
                        incomeTarPrice: $(this).find('input[name="incomeTarPrice"]').val(),
                        incomeTarAmount: $(this).find('input[name="incomeTarAmount"]').val(),
                        optTarNum: $(this).find('input[name="optTarNum"]').val(),
                        optTarPrice: $(this).find('input[name="optTarPrice"]').val(),
                        optTarAmount: $(this).find('input[name="optTarAmount"]').val(),
                        manageTarNum: $(this).find('input[name="manageTarNum"]').val(),
                        manageTarPrice: $(this).find('input[name="manageTarPrice"]').val(),
                        manageTarAmount: $(this).find('input[name="manageTarAmount"]').val(),

                        runTarNum: $(this).find('input[name="runTarNum"]').val(),
                        // runTarPrice: $(this).find('input[name="runTarPrice"]').val(),
                        runTarAmount: $(this).find('input[name="runTarAmount"]').val(),

                        manTarOptNum: $(this).find('input[name="manTarOptNum"]').val(),
                        manTarOptAmount: $(this).find('input[name="manTarOptAmount"]').val(),

                        aftManTarNum: $(this).find('input[name="aftManTarNum"]').val(),
                        // aftManTarPrice: $(this).find('input[name="aftManTarPrice"]').val(),
                        aftManTarAmount: $(this).find('input[name="aftManTarAmount"]').val(),
                        adjIncomeTarNum: $(this).find('input[name="adjIncomeTarNum"]').val(),
                        adjIncomeTarPrice: $(this).find('input[name="adjIncomeTarPrice"]').val(),
                        adjIncomeTarAmount: $(this).find('input[name="adjIncomeTarAmount"]').val(),
                        adjOptTarNum: $(this).find('input[name="adjOptTarNum"]').val(),
                        adjOptTarPrice: $(this).find('input[name="adjOptTarPrice"]').val(),
                        adjOptTarAmount: $(this).find('input[name="adjOptTarAmount"]').val(),
                        adjManTarNum: $(this).find('input[name="adjManTarNum"]').val(),
                        adjManTarPrice: $(this).find('input[name="adjManTarPrice"]').val(),
                        adjManTarAmount: $(this).find('input[name="adjManTarAmount"]').val(),
                    }
                    oldDataArr.push(oldDataObj);
                });
                table.reload('materialDetailsTable', {
                    data: oldDataArr
                });
            }
        });

        // 变更单明细-选择
        table.on('toolbar(materialDetailsTable2)', function (obj) {

            switch (obj.event) {
                case 'add2':
                    layer.open({
                        type: 1,
                        // skin: 'layui-layer-molv', //加上边框
                        area: ['80%', '70%'], //宽高
                        title: '变更单登记选择',
                        maxmin: true,
                        btn: ['确定', '取消'],
                        btnAlign: 'c',
                        content: '<div class="mbox" id="objectives2">\n' +
                            '    <div class="layui-card">\n' +
                            '        <div class="layui-card-body">\n' +
                            '            <div class="layui-rt">\n' +
                            '                <div class="layui-tab layui-tab-card" lay-filter="tabtoggle">\n' +
                            '                    <div class="layui-tab-content" style="height:100%;padding: 0 10px 10px 10px">\n' +
                            '                        <div id="firstBox" class="layui-tab-item layui-show">\n' +
                            '                            <table class="layui-table" lay-skin="line" id="Settlement3" lay-size="sm" lay-filter="SettlementFilter3"></table>\n' +
                            '                        </div>\n' +
                            '                    </div>\n' +
                            '                </div>\n' +
                            '            </div>\n' +
                            '        </div>\n' +
                            '    </div>\n' +
                            '</div>',
                        success: function () {

                            table.render({
                                elem: '#Settlement3'
                                , url: '/plbOperateManage/selectRegister?auditerStatus=2&model=operateManage&projectId='+_projectId+'&registerCategory=01'
                                //, toolbar: "#toolbar"
                                , defaultToolbar: []
                                , page: { //支持传入 laypage 组件的所有参数（某些参数除外，如：jump/elem） - 详见文档
                                    layout: ['prev', 'page', 'next', 'skip', 'count', 'limit',]//自定义分页布局
                                    , limits: [15, 30, 45, 60, 75, 90, 105, 120]
                                    , first: '首页'
                                    , last: '尾页'
                                }
                                , limit: 15
                                , cols: [[//表头
                                    {type: 'checkbox'},
                                    {type: 'numbers', minWidth: 60, title: '序号'},
                                    {field:'registerNo',title:'单据号',templet:function(d){
                                            return '<span id="registerNo" projectId='+(d.projectId||"")+'>'+d.registerNo+'</span>'
                                        }
                                    },
                                    {field:'registerName',title:'变更单名称'},
                                    // {field: 'projectName', title: '项目名称', sort: true, hide: false},
                                    {field: 'registerTypeName', title: '变更类型', sort: true, hide: false},
                                    {field: 'registerCategoryName', title: '变更类别', sort: true, hide: false},
                                    {field:'registerDate',title:'变更日期'},
                                    // {field: 'itemAmount', title: '分部分项工程', minWidth:140,sort: true, hide: false},
                                    // {field: 'approvaler', title: '审批人', sort: true, hide: false, templet: function (d) {
                                    //         return d.approvalerName || '';
                                    //     }},
                                    // {field: 'auditerStatus', title: '审批状态', sort: true, hide: false, templet: function (d) {
                                    //         var str = '';
                                    //         if (d.auditerStatus == '1') {
                                    //             str = '<span style="color: orange;">审批中</span>';
                                    //         } else if (d.auditerStatus == '2') {
                                    //             str = '<span style="color: green;">批准</span>';
                                    //         } else if (d.auditerStatus == '3') {
                                    //             str = '<span style="color: red;">不批准</span>';
                                    //         } else {
                                    //             str = '未提交';
                                    //         }
                                    //         return str;
                                    //     }},
                                    // {field: 'approvalTime', title: '审批时间', sort: true, hide: false, templet: function (d) {
                                    //         return format(d.approvalTime);
                                    //     }},
                                    // {field: 'createTime', title: '创建时间', sort: true, hide: false, templet: function (d) {
                                    //         return format(d.createTime);
                                    //     }}
                                    //{title: '操作', minWidth: 190, toolbar: '#barOperation'}
                                ]],
                                request: {
                                    pageName: 'page' //页码的参数名称，默认：page
                                    ,limitName: 'pageSize' //每页数据量的参数名，默认：limit
                                }
                                , done: function (res) {
                                    _dataa2=res.data;
                                    if(materialDetailsTableData2!=undefined&&materialDetailsTableData2.length>0){
                                        for(var i = 0 ; i <_dataa2.length;i++){
                                            for(var n = 0 ; n < materialDetailsTableData2.length; n++){
                                                if(_dataa2[i].registerId == materialDetailsTableData2[n].registerId){
                                                    $('.layui-table tr[data-index=' + i + '] input[type="checkbox"]').next(".layui-form-checkbox").click();
                                                    //form.render('checkbox');
                                                }
                                            }
                                        }
                                    }
                                }
                            });

                            form.render();//重置表格


                        },
                        yes: function (index, layero) {
                            layer.close(index);
                            //var checkStatus = table.checkStatus('Settlement3').data;


                            var checkStatus=[];
                            $('#objectives2 .layui-table-body .laytable-cell-checkbox').each(function(index,item){
                                if($(item).find('.layui-form-checked').length>0){
                                    checkStatus.push(_dataa2[index]);
                                }
                            })
                            var oldDataArr = [];
                            if (checkStatus.length > 0) {
                                for(var i=0;i<checkStatus.length;i++){
                                    var oldDataObj = {
                                        projectId:checkStatus[i].projectId||'',
                                        registerId:checkStatus[i].registerId||'',
                                        registerNo:checkStatus[i].registerNo,
                                        registerName:checkStatus[i].registerName,
                                        registerCategory:checkStatus[i].registerCategory,
                                        registerCategoryName:checkStatus[i].registerCategoryName,
                                        registerType:checkStatus[i].registerType,
                                        registerTypeName:checkStatus[i].registerTypeName,
                                        constructionDrawingsNo:checkStatus[i].constructionDrawingsNo,
                                        firstPartyOrderFlag:checkStatus[i].firstPartyOrderFlag,
                                        registerDate:checkStatus[i].registerDate,
                                    }
                                    if(materialDetailsTableData2){
                                        var _flag = true
                                        for(var j=0;j<materialDetailsTableData2.length;j++){
                                            if(materialDetailsTableData2[j].registerId==checkStatus[i].registerId){
                                                _flag = false
                                            }
                                        }
                                        if(_flag){
                                            materialDetailsTableData2.push(oldDataObj);
                                        }

                                    }else{
                                        materialDetailsTableData2.push(oldDataObj);
                                    }
                                }


                                layer.close(index);

                                table.reload('materialDetailsTable2', {
                                    data: materialDetailsTableData2
                                });
                            } else {
                                layer.msg('请选择一项！', {icon: 0});
                            }
                        }
                    });

                    break;
            }
        });
        // 变更单明细-删行操作
        table.on('tool(materialDetailsTable2)', function (obj) {
            var data = obj.data;
            var projectId=data.projectId;
            var registerId=data.registerId
            var layEvent = obj.event;
            if (layEvent === 'del2') {
                if(data.manageProjInfoId){
                    $.ajax({
                        url: '/projectDetails/del?ids='+data.manageProjInfoId,
                        dataType: 'json',
                        type: 'post',
                        success: function (res) {
                            /*if (res.code==='0'||res.code===0) {
                                layer.msg(res.msg, {icon: 1});
                            } else {
                                layer.msg(res.msg, {icon: 2});
                            }*/
                        }
                    });
                }
                obj.del();

                //遍历表格获取每行数据进行保存
                var $tr = $('.mtl_info2').find('.layui-table-main tr');
                var oldDataArr = [];
                $tr.each(function () {
                    var oldDataObj = {
                        manageProjInfoId:$(this).find('input[name="registerNo"]').attr('manageProjInfoId')||'',
                        registerId:$(this).find('input[name="registerNo"]').attr('registerId')||'',
                        registerNo: $(this).find('input[name="registerNo"]').val(),
                        registerName: $(this).find('input[name="registerName"]').val(),
                        registerCategory: $(this).find('input[name="registerCategoryName"]').attr('registerCategory'),
                        registerType: $(this).find('input[name="registerTypeName"]').attr('registerType'),
                        constructionDrawingsNo: $(this).find('input[name="constructionDrawingsNo"]').val(),
                        firstPartyOrderFlag: $(this).find('span').attr('firstPartyOrderFlag'),
                        registerDate: $(this).find('input[name="registerDate"]').val(),
                    }
                    oldDataArr.push(oldDataObj);
                });
                table.reload('materialDetailsTable2', {
                    data: oldDataArr
                });
            }else {
                layer.open({
                    type: 2,
                    title: '查看变更登记',
                    area: ['100%', '100%'],
                    btn: ['确定'],
                    btnAlign: 'c',
                    content: '/plbOperateManage/addOperateRegister?tableBtn=details&projectId=' + projectId + '&registerId=' + registerId + '',
                })

            }
        });

        // // 选择经营目标
        $(document).on('click', '#itemType', function () {
            layer.open({
                type: 1,
                title: '选择经营目标',
                area: ['70%', '60%'],
                maxmin: true,
                btnAlign:'c',
                btn: ['确定', '取消'],
                content: ['<div class="layui-form" >' +
                //表格数据
                '       <div style="padding: 10px">' +
                '           <table id="Settlement2" lay-filter="SettlementFilter2"></table>' +
                '      </div>' +
                '</div>'].join(''),
                success: function () {
                    //setTimeout(function(){
                    table.render({
                        elem: '#Settlement2',
                        url: '/manageProject/getBudgetByProjId?projectId='+_projectId,//数据接口
                        //where:{projId:$('#leftId').attr('projId'),customer:$('#baseForm [name="customerName"]').attr('customerId'),auditerStatusFlag:"true"},
                        page:true,
                        cols: [[//表头
                            {type: 'radio'},
                            {type: 'numbers', minWidth: 60, title: '序号'},
                            {field: 'itemName', title: '预算名称'},
                            {field: 'wbsName', title: 'WBS', templet: function (d) {
                                    if (d.plbProjWbs && d.plbProjWbs.wbsName) {
                                        return "<span>"+d.plbProjWbs.wbsName+"</span>"
                                    } else {
                                        return "";
                                    }
                                }},
                            {field: 'rbsName', title: 'RBS', templet: function (d) {
                                    if (d.plbRbs && d.plbRbs.rbsName) {
                                        return "<span>"+d.plbRbs.rbsName+"</span>"
                                    } else {
                                        return "";
                                    }
                                }},
                            {field: 'cbsName', title: 'CBS', templet: function (d) {
                                    if (d.plbCbsTypeWithBLOBs && d.plbCbsTypeWithBLOBs.cbsName) {
                                        return "<span>"+d.plbCbsTypeWithBLOBs.cbsName+"</span>"
                                    } else {
                                        return "";
                                    }
                                }},
                            {field: 'runTarNum', title: '经营目标收入金额',minWidth:180},
                            {field: 'runTarPrice', title: '经营目标利润金额',minWidth:180},
                            {field: 'runTarExplain', title: '经营目标说明',minWidth:140}
                            //{title: '操作', minWidth: 190, toolbar: '#barOperation'}
                        ]],
                        request: {
                            pageName: 'page' //页码的参数名称，默认：page
                            ,limitName: 'pageSize' //每页数据量的参数名，默认：limit
                        },
                        done:function(res){
                            var _dataa=res.data;
                            var _projBudgetId=$('#projBudgetId').val();
                            if(_projBudgetId!=undefined){
                                for(var i = 0 ; i <_dataa.length;i++){
                                    if(_dataa[i].projBudgetId == _projBudgetId){
                                        $('.layui-table tr[data-index=' + i + '] input[type="radio"]').next(".layui-form-radio").click();
                                        //form.render('checkbox');
                                    }
                                }
                            }

                        }
                    });
                    //},1)
                },
                yes: function (index) {
                    layer.close(index);
                    var datas = table.checkStatus('Settlement2').data[0];
                    $('#itemType').val(datas ? datas.itemName : '');
                    $('#projBudgetId').val(datas.projBudgetId==undefined?'':datas.projBudgetId);
                }
            });
        });

        // 变更单选择
        /*$(document).on('click', '#itemType2', function () {
            layer.open({
                type: 1,
                skin: 'layui-layer-molv', //加上边框
                area: ['80%', '70%'], //宽高
                title: '变更单选择',
                maxmin: true,
                btn: ['确定'],
                content: '<div class="mbox">\n' +
                    '    <div class="layui-card">\n' +
                    '        <div class="layui-card-body">\n' +
                    '            <div class="layui-rt">\n' +
                    '                <div class="layui-tab layui-tab-card" lay-filter="tabtoggle">\n' +
                    '                    <div class="layui-tab-content" style="height:100%;padding: 0 10px 10px 10px">\n' +
                    '                        <div id="firstBox" class="layui-tab-item layui-show">\n' +
                    '                            <table class="layui-table" lay-skin="line" id="Settlement3" lay-size="sm" lay-filter="SettlementFilter3"></table>\n' +
                    '                        </div>\n' +
                    '                    </div>\n' +
                    '                </div>\n' +
                    '            </div>\n' +
                    '        </div>\n' +
                    '    </div>\n' +
                    '</div>',
                success: function () {

                    table.render({
                        elem: '#Settlement3'
                        , url: '/plbOperateManage/selectRegister?page=1&pageSize=10&projectId='+_projectId//数据接口
                        //, toolbar: "#toolbar"
                        , defaultToolbar: []
                        , page: { //支持传入 laypage 组件的所有参数（某些参数除外，如：jump/elem） - 详见文档
                            layout: ['prev', 'page', 'next', 'skip', 'count', 'limit',]//自定义分页布局
                            , limits: [15, 30, 45, 60, 75, 90, 105, 120]
                            , first: '首页'
                            , last: '尾页'
                        }
                        , limit: 15
                        , cols: [[//表头
                            {type: 'radio'},
                            {type: 'numbers', minWidth: 60, title: '序号'},
                            {field: 'registerNo', title: '单据号'},
                            {field: 'registerName', title: '变更单名称'},
                            {field: 'registerCategoryName', title: '变更单类别'},
                            {field: 'registerTypeName', title: '变更单类型'},
                            {field: 'registerDate', title: '变更日期'}
                            //{title: '操作', minWidth: 190, toolbar: '#barOperation'}
                        ]]
                        , done: function () {

                        }
                    });

                    form.render();//重置表格


                },
                yes: function (index, layero) {
                    layer.close(index);
                    var datas = table.checkStatus('Settlement3').data[0];
                    manageProj_data = datas;
                    $('#itemType2').val(datas ? datas.registerName : '');
                    if(manageProj_state=='01'){
                        $('#firstPartyOrderFlag').val(manageProj_data ? manageProj_data.firstPartyOrderFlag : '');
                        $('#manageProjContent').val(manageProj_data ? manageProj_data.registerContent : '');
                    }
                }
            });
        })*/
        //监听经营目标金额
        // $(document).on('input propertychange','input[name="runTarAmount"]',function(){
        //     var $tr = $('.mtl_info').find('.layui-table-main tr');
        //     if($(this).val() && $(this).parents('tr').find('[name="runTarAmount"]').val()){
        //         //经营目标数量
        //         var runTarNum=$(this).parents('tr').find('input[name="runTarNum"]').val();
        //         //经营目标单价
        //         var runTarPrice=$(this).parents('tr').find('input[name="runTarPrice"]').val();
        //         //经营目标金额
        //         var runTarAmount=runTarNum*runTarPrice
        //         $(this).val(retainDecimal(runTarAmount,3));
        //     }
        // })
        //数据列表点击审批状态查看流程功能
        $(document).on('click', '.preview_flow', function() {
            var flowId = $(this).attr('flowId'),
                runId = $(this).attr('runId');
            if (flowId && runId) {
                $.popWindow("/workflow/work/workformPreView?flowId=" + flowId + '&flowStep=&prcsId=&runId=' + runId);
            }
        });

        //监听经营目标单价
        $(document).on('input propertychange','input[name="runTarPrice"]',function(){
            var $tr = $('.mtl_info').find('.layui-table-main tr');
            if($(this).val() && $(this).parents('tr').find('[name="runTarNum"]').val()){
                //经营目标数量
                var runTarNum=$(this).parents('tr').find('input[name="runTarNum"]').val();
                //经营目标单价
                var runTarPrice=$(this).parents('tr').find('input[name="runTarPrice"]').val();
                //经营目标金额
                var runTarAmount=runTarNum*runTarPrice
                //$(this).parents('tr').find('input[name="runTarAmount"]').val(retainDecimal(runTarAmount,3));
            }
        })
        //监听经营目标数量
        $(document).on('input propertychange','input[name="runTarNum"]',function(){
            //调整后收入目标数量
            var adjIncomeTarNum=0
            //经营目标数量
            var runTarNum=$(this).parents('tr').find('input[name="runTarNum"]').val()
            //收入目标数量
            var incomeTarNum=$(this).parents('tr').find('input[name="incomeTarNum"]').val()
            adjIncomeTarNum=accAdd(incomeTarNum,runTarNum)
            $(this).parents('tr').find('[name="adjIncomeTarNum"]').val(retainDecimal(adjIncomeTarNum,3))

            //调整后管理目标数量
            var adjManTarNum=0
            //优化后经营目标数量
            var aftManTarNum=0
            //经营目标优化数量
            var manTarOptNum=$(this).parents('tr').find('input[name="manTarOptNum"]').val()
            aftManTarNum=sub(runTarNum,manTarOptNum)
            //管理目标数量
            var manageTarNum=$(this).parents('tr').find('input[name="manageTarNum"]').val()
            adjManTarNum=accAdd(manageTarNum,aftManTarNum)
            $(this).parents('tr').find('[name="adjManTarNum"]').val(retainDecimal(adjManTarNum,3))

            $(this).parents('tr').find('[name="aftManTarNum"]').val(retainDecimal(aftManTarNum,3))
        })
        //监听经营目标优化数量
        $(document).on('input propertychange', 'input[name="manTarOptNum"]', function () {
            var $tr = $('.mtl_info').find('.layui-table-main tr');
            //计算优化后经营目标数量
            if($(this).val() && $(this).parents('tr').find('[name="manTarOptNum"]').val()){
                //优化后经营目标数量
                var aftManTarNum=0
                //经营目标数量
                var runTarNum=$(this).parents('tr').find('input[name="runTarNum"]').val()
                //经营目标优化数量
                var manTarOptNum=$(this).parents('tr').find('input[name="manTarOptNum"]').val()
                //经营目标金额
                var runTarAmount=$(this).parents('tr').find('input[name="runTarAmount"]').val()
                //经营目标优化金额
                var manTarOptAmount=$(this).parents('tr').find('input[name="manTarOptAmount"]').val()
                //优化后经营目标单价
                //var aftManTarPrice=0
                aftManTarNum=sub(runTarNum,manTarOptNum)
                $(this).parents('tr').find('[name="aftManTarNum"]').val(retainDecimal(aftManTarNum,3))
                // if(aftManTarNum=="0"){
                //     aftManTarNum=1
                // }
                //优化优化后经营目标单价
                //aftManTarPrice=div(sub(runTarAmount,manTarOptAmount),aftManTarNum||1)
                //$(this).parents('tr').find('[name="aftManTarPrice"]').val(retainDecimal(aftManTarPrice,3))



                //调整后收入目标数量
                var adjIncomeTarNum=0
                //收入目标数量
                var incomeTarNum=$(this).parents('tr').find('input[name="incomeTarNum"]').val()
                adjIncomeTarNum=accAdd(incomeTarNum,runTarNum)
                $(this).parents('tr').find('[name="adjIncomeTarNum"]').val(retainDecimal(adjIncomeTarNum,3))

                //调整后优化目标数量
                var adjOptTarNum=0
                //优化目标数量
                var optTarNum=$(this).parents('tr').find('input[name="optTarNum"]').val()
                adjOptTarNum=accAdd(optTarNum,manTarOptNum)
                $(this).parents('tr').find('[name="adjOptTarNum"]').val(retainDecimal(adjOptTarNum,3))

                //调整后管理目标数量
                var adjManTarNum=0
                //管理目标数量
                var manageTarNum=$(this).parents('tr').find('input[name="manageTarNum"]').val()
                adjManTarNum=accAdd(manageTarNum,aftManTarNum)
                $(this).parents('tr').find('[name="adjManTarNum"]').val(retainDecimal(adjManTarNum,3))
            }
        });

        //监听经营目标金额
        //监听经营目标优化金额
        $(document).on('input propertychange', '.target_amount', function () {
            var $tr = $('.mtl_info').find('.layui-table-main tr');
            //计算优化后经营目标单价
            if($(this).val() && $(this).parents('tr').find('[name="manTarOptAmount"]').val()){
                //优化后经营目标单价
                //var aftManTarPrice=0
                //优化后经营目标金额
                var aftManTarAmount=0
                //优化后经营目标数量
                var aftManTarNum=0
                //经营目标金额
                var runTarAmount=$(this).parents('tr').find('input[name="runTarAmount"]').val()
                //经营目标优化金额
                var manTarOptAmount=$(this).parents('tr').find('input[name="manTarOptAmount"]').val()
                //经营目标数量
                var runTarNum=$(this).parents('tr').find('input[name="runTarNum"]').val()
                //经营目标优化数量
                var manTarOptNum=$(this).parents('tr').find('input[name="manTarOptNum"]').val()

                aftManTarNum=sub(runTarNum,manTarOptNum)
                // if(aftManTarNum=="0"){
                //     aftManTarNum=1
                // }
                //aftManTarPrice=div(sub(runTarAmount,manTarOptAmount),aftManTarNum)
                //$(this).parents('tr').find('[name="aftManTarPrice"]').val(retainDecimal(aftManTarPrice,3))

                aftManTarAmount=sub(runTarAmount,manTarOptAmount)
                $(this).parents('tr').find('[name="aftManTarAmount"]').val(retainDecimal(aftManTarAmount,3))

                aftManTarNum=sub(runTarNum,manTarOptNum)
                $(this).parents('tr').find('[name="aftManTarNum"]').val(retainDecimal(aftManTarNum,3))

                //调整后收入目标单价
                var adjIncomeTarPrice=0
                //调整后收入目标金额
                var adjIncomeTarAmount=0
                //收入目标金额
                var incomeTarAmount=$(this).parents('tr').find('input[name="incomeTarAmount"]').val()
                //收入目标数量
                var incomeTarNum=$(this).parents('tr').find('input[name="incomeTarNum"]').val()

                adjIncomeTarPrice=div(accAdd(incomeTarAmount,runTarAmount),accAdd(incomeTarNum,runTarNum))
                $(this).parents('tr').find('[name="adjIncomeTarPrice"]').val(retainDecimal(adjIncomeTarPrice,3))

                adjIncomeTarAmount=accAdd(incomeTarAmount,runTarAmount)
                $(this).parents('tr').find('[name="adjIncomeTarAmount"]').val(retainDecimal(adjIncomeTarAmount,3))

                //调整后优化目标单价
                var adjOptTarPrice=0
                //调整后优化目标金额
                var adjOptTarAmount=0
                //优化目标金额
                var optTarAmount=$(this).parents('tr').find('input[name="optTarAmount"]').val()

                //管理目标金额
                var manageTarAmount=$(this).parents('tr').find('input[name="manageTarAmount"]').val()
                //管理目标数量
                var manageTarNum=$(this).parents('tr').find('input[name="manageTarNum"]').val()


                adjOptTarPrice=sub(div(accAdd(incomeTarAmount,runTarAmount),accAdd(incomeTarNum,runTarNum)),div(accAdd(manageTarAmount,aftManTarAmount),accAdd(manageTarNum,aftManTarNum)))
                $(this).parents('tr').find('[name="adjOptTarPrice"]').val(retainDecimal(adjOptTarPrice,3))

                adjOptTarAmount=accAdd(optTarAmount,manTarOptAmount)
                $(this).parents('tr').find('[name="adjOptTarAmount"]').val(retainDecimal(adjOptTarAmount,3))

                //调整后管理目标单价
                var adjManTarPrice=0
                //调整后管理目标金额
                var adjManTarAmount=0

                adjManTarPrice=div(accAdd(manageTarAmount,aftManTarAmount),accAdd(manageTarNum,aftManTarNum))
                $(this).parents('tr').find('[name="adjManTarPrice"]').val(retainDecimal(adjManTarPrice,3))

                adjManTarAmount=accAdd(manageTarAmount,aftManTarAmount)
                $(this).parents('tr').find('[name="adjManTarAmount"]').val(retainDecimal(adjManTarAmount,3))


                //预计变更收入
                var changeIncome=0
                var changeIncome_sum=0
                //实施成本
                var implementationCost=0
                var implementationCost_sum=0
                //预计收入
                var estimatedProfit_sum=0
                $tr.each(function () {
                    changeIncome=$(this).find('input[name="runTarAmount"]').val()
                    changeIncome_sum=accAdd(changeIncome_sum,changeIncome)

                    implementationCost=$(this).find('input[name="aftManTarAmount"]').val()
                    implementationCost_sum=accAdd(implementationCost_sum,implementationCost)
                });
                $('input[name="changeIncome"]').val(retainDecimal(changeIncome_sum,3))
                $('input[name="implementationCost"]').val(retainDecimal(implementationCost_sum,3))
                estimatedProfit_sum = changeIncome_sum-implementationCost_sum
                $('input[name="estimatedProfit"]').val(retainDecimal(estimatedProfit_sum,3))

            }
        });

    })

    function childFunc() {
        if('0'!=_disabled){
            return true
        }
        var loadIndex = layer.load();
        //材料计划数据
        var datas = $('#baseForm').serializeArray();
        var obj = {}
        datas.forEach(function (item) {
            obj[item.name] = item.value;
        });
        obj.projectId=_projectId;
        if (type == '1') {
            obj.manageProjId=data.manageProjId;
        }

        // 合同附件
        var attachmentId = '';
        var attachmentName = '';
        for (var i = 0; i < $('#fileContent .dech').length; i++) {
            attachmentId += $('#fileContent .dech').eq(i).find('input').val();
            attachmentName += $('#fileContent .dech').eq(i).find("a").eq(0).attr('name');
        }
        obj.attachmentId = attachmentId;
        obj.attachmentName = attachmentName;

        // 判断必填项
        var requiredFlag = false;
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
        }

        //立项明细
        var $tr = $('.mtl_info').find('.layui-table-main tr');
        var manageInfoList = [];
        $tr.each(function () {
            var plbManageItemObj = {
                wbsName: $(this).find('input[name="wbsId"]').val(),
                wbsId: $(this).find('input[name="wbsId"]').attr('wbsId'),
                rbsName: $(this).find('input[name="rbsId"]').val(),
                rbsId: $(this).find('input[name="rbsId"]').attr('rbsId'),
                cbsName: $(this).find('input[name="cbsId"]').val(),
                cbsId: $(this).find('input[name="cbsId"]').attr('cbsId'),
                incomeTarNum: $(this).find('input[name="incomeTarNum"]').val(),
                incomeTarPrice: $(this).find('input[name="incomeTarPrice"]').val(),
                incomeTarAmount: $(this).find('input[name="incomeTarAmount"]').val(),
                optTarNum: $(this).find('input[name="optTarNum"]').val(),
                optTarPrice: $(this).find('input[name="optTarPrice"]').val(),
                optTarAmount: $(this).find('input[name="optTarAmount"]').val(),
                manageTarNum: $(this).find('input[name="manageTarNum"]').val(),
                manageTarPrice: $(this).find('input[name="manageTarPrice"]').val(),
                manageTarAmount: $(this).find('input[name="manageTarAmount"]').val(),

                runTarNum: $(this).find('input[name="runTarNum"]').val(),
                // runTarPrice: $(this).find('input[name="runTarPrice"]').val(),
                runTarAmount: $(this).find('input[name="runTarAmount"]').val(),

                manTarOptNum: $(this).find('input[name="manTarOptNum"]').val(),
                manTarOptAmount: $(this).find('input[name="manTarOptAmount"]').val(),

                aftManTarNum: $(this).find('input[name="aftManTarNum"]').val(),
                // aftManTarPrice: $(this).find('input[name="aftManTarPrice"]').val(),
                aftManTarAmount: $(this).find('input[name="aftManTarAmount"]').val(),
                adjIncomeTarNum: $(this).find('input[name="adjIncomeTarNum"]').val(),
                adjIncomeTarPrice: $(this).find('input[name="adjIncomeTarPrice"]').val(),
                adjIncomeTarAmount: $(this).find('input[name="adjIncomeTarAmount"]').val(),
                adjOptTarNum: $(this).find('input[name="adjOptTarNum"]').val(),
                adjOptTarPrice: $(this).find('input[name="adjOptTarPrice"]').val(),
                adjOptTarAmount: $(this).find('input[name="adjOptTarAmount"]').val(),
                adjManTarNum: $(this).find('input[name="adjManTarNum"]').val(),
                adjManTarPrice: $(this).find('input[name="adjManTarPrice"]').val(),
                adjManTarAmount: $(this).find('input[name="adjManTarAmount"]').val(),
            }
            if($(this).find('input[name="wbsId"]').attr('projBudgetId')){
                plbManageItemObj.projBudgetId=$(this).find('input[name="wbsId"]').attr('projBudgetId');
            }
            if($(this).find('input[name="wbsId"]').attr('manageProjInfoId')){
                plbManageItemObj.manageProjInfoId=$(this).find('input[name="wbsId"]').attr('manageProjInfoId');
            }
            if(data!=undefined&&data.manageProjId!=undefined){
                plbManageItemObj.manageProjId=data.manageProjId
            }
            manageInfoList.push(plbManageItemObj);
        });
        obj.manageInfoList = manageInfoList;

        //变更单明细
        var $tr = $('.mtl_info2').find('.layui-table-main tr');
        var detailList = [];
        $tr.each(function () {
            var plbManageItemObj = {
                registerId:$(this).find('input[name="registerNo"]').attr('registerId'),
                registerNo: $(this).find('input[name="registerNo"]').val(),
                registerName: $(this).find('input[name="registerName"]').val(),
                registerCategory: $(this).find('input[name="registerCategoryName"]').attr('registerCategory'),
                registerType: $(this).find('input[name="registerTypeName"]').attr('registerType'),
                constructionDrawingsNo: $(this).find('input[name="constructionDrawingsNo"]').val(),
                firstPartyOrderFlag: $(this).find('span').attr('firstPartyOrderFlag'),
                registerDate: $(this).find('input[name="registerDate"]').val(),
            }
            if($(this).find('input[name="registerNo"]').attr('manageProjInfoId')){
                plbManageItemObj.manageProjInfoId=$(this).find('input[name="registerNo"]').attr('manageProjInfoId')
            }
            detailList.push(plbManageItemObj);
        });
        obj.detailList = detailList;


        var _flag = false;

        $.ajax({
            url: '/manageProject/updateRegister',
            data: JSON.stringify(obj),
            dataType: 'json',
            contentType: "application/json;charset=UTF-8",
            type: 'post',
            success: function (res) {
                layer.close(loadIndex);
                if (res.code==='0'||res.code===0) {
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

    function getUrlParam(name){
        var reg = new RegExp(name +"=(.*?)((?=&|$))"); //构造一个含有目标参数的正则表达式对象
        var r = window.location.href.match(reg); //匹配目标参数
        if (r!=null) return unescape(r[1]); return null; //返回参数值
    }
</script>
</body>
</html>
