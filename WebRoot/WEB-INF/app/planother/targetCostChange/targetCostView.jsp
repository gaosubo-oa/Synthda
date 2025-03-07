<%--
  Created by IntelliJ IDEA.
  User: 王秋彤
  Date: 2021/7/22
  Time: 18:31
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<head>
    <title>成本目标调整查看详情</title>
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
<%--    <script type="text/javascript" src="/js/common/fileupload.js"></script>--%>
<script type="text/javascript" src="/js/planbudget/common.js?20210604.1"></script>
<script type="text/javascript" src="/js/planother/planotherUtil.js?22120210830.1"></script>

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

    .laytable-cell-radio {
        padding-top:15px;
    }

</style>

<body>
<div class="layui-collapse" id="htm"></div>
<script type="text/html" id="toolbarDemoIn">
    <div class="layui-btn-container" style="height: 30px;">
        <button class="layui-btn layui-btn-sm" id="addBtn" lay-event="add">加行</button>
    </div>
</script>

<script type="text/html" id="barDemo">
    <a class="layui-btn layui-btn-danger layui-btn-xs" id="delBtn" lay-event="del">删行</a>
</script>

<script>
    var formData;
    var _type = getUrlParam('disabled');
    var runId = getUrlParam('runId');

    var htm = '<div class="layui-collapse _disabled">\n' +
    <%--    /* region 立项项目基础信息 */--%>
    '    <div class="layui-colla-item">\n' +
    '        <h2 class="layui-colla-title">立项信息</h2>\n' +
    '        <div class="layui-colla-content layui-show plan_base_info">\n' +
    '            <form class="layui-form" id="baseForm" lay-filter="baseForm">\n' +
    <%--                /* region 第一行 */--%>
    '                <div class="layui-row">\n' +
    '                    <div class="layui-col-xs4" style="padding: 0 5px;">\n' +
    '                        <div class="layui-form-item">\n' +
    '                            <label class="layui-form-label form_label">单据号<span field="documnetNum" class="field_required">*</span><a title="刷新编号" class="refresh_no_btn"><i class="layui-icon layui-icon-refresh"></i></a></label>\n' +
    '                            <div class="layui-input-block form_block">\n' +
    '                                <input type="text" readonly name="documnetNum" autocomplete="off" class="layui-input" style="background:#e7e7e7;">\n' +
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
    '                            <label class="layui-form-label form_label">成本目标调整名称<span field="costChaName" class="field_required">*</span></label>\n' +
    '                            <div class="layui-input-block form_block">\n' +
    '                                <input type="text" name="costChaName" autocomplete="off"  class="layui-input ">\n' +
    '                            </div>\n' +
    '                        </div>\n' +
    '                    </div>\n' +
    '                </div>\n' +
    <%--                /* endregion */--%>
    <%--                /* region 第二行 */--%>
    '                <div class="layui-row">\n' +
    '                    <div class="layui-col-xs4" style="padding: 0 5px;">\n' +
    '                        <div class="layui-form-item">\n' +
    '                            <label class="layui-form-label form_label">优化目标类型<span field="optTarType" class="field_required">*</span></label>\n' +
    '                            <div class="layui-input-block form_block">\n' +
    '                                <select name="optTarType" id="optTarType" lay-filter="test">\n' +
    '                                </select>\n' +
    '                            </div>\n' +
    '                        </div>\n' +
    '                    </div>\n' +
    '                    <div class="layui-col-xs4" style="padding: 0 5px;">\n' +
    '                        <div class="layui-form-item">\n' +
    '                            <label class="layui-form-label form_label">收入变更总额<span field="incChaTotal" class="field_required">*</span></label>\n' +
    '                            <div class="layui-input-block form_block">\n' +
    '                                <input type="text" readonly name="incChaTotal" autocomplete="off" class="layui-input" style="background:#e7e7e7;" value=0>\n' +
    '                            </div>\n' +
    '                        </div>\n' +
    '                    </div>\n' +
    '                    <div class="layui-col-xs4" style="padding: 0 5px;">\n' +
    '                        <div class="layui-form-item">\n' +
    '                            <label class="layui-form-label form_label">优化变更总额<span field="optChaTotal" class="field_required">*</span></label>\n' +
    '                            <div class="layui-input-block form_block">\n' +
    '                                <input type="text" readonly name="optChaTotal" autocomplete="off"  class="layui-input" style="background:#e7e7e7;"value=0>\n' +
    '                            </div>\n' +
    '                        </div>\n' +
    '                    </div>\n' +
    '                </div>\n' +
    <%--                /* endregion */--%>
    <%--                /* region 第三行 */--%>
    '                <div class="layui-row">\n' +
    '                    <div class="layui-col-xs4" style="padding: 0 5px;">\n' +
    '                        <div class="layui-form-item">\n' +
    '                            <label class="layui-form-label form_label">备注</label>\n' +
    '                            <div class="layui-input-block form_block">\n' +
    '                                <input name="remarks"  class="layui-input">\n' +
    '                            </div>\n' +
    '                        </div>\n' +
    '                    </div>\n' +
    '                    <div class="layui-col-xs4" style="padding: 0 5px;">\n' +
    '                        <div class="layui-form-item">\n' +
    '                            <label class="layui-form-label form_label">填报人<span field="createUser" class="field_required">*</span></label>\n' +
    '                            <div class="layui-input-block form_block">\n' +
    '                                <input type="text" readonly name="createUser" autocomplete="off" class="layui-input" style="cursor: pointer;">\n' +
    '                            </div>\n' +
    '                        </div>\n' +
    '                    </div>\n' +
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
    <%--                /* region 第四行 */--%>
    '                <div class="layui-row">\n' +
    '                    <div class="layui-col-xs6" style="padding: 0 5px;">\n' +
    '                        <div class="layui-form-item">\n' +
    '                            <label class="layui-form-label form_label">变更内容<span field="chaContent" class="field_required">*</span></label>\n' +
    '                            <div class="layui-input-block form_block">\n' +
    '                                <textarea name="chaContent" id="chaContent" placeholder="请输入变更内容" class="layui-textarea"></textarea>\n' +
    '                            </div>\n' +
    '                        </div>\n' +
    '                    </div>\n' +
    '                </div>\n' +
    <%--                /* endregion */--%>
    <%--                /* region 第五行 */--%>
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
    '                                            <input type="file" multiple id="fileupload" data-url="/upload?module=targetCostChange" name="file">\n' +
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
    '    <div class="layui-colla-item" id="materialDetailsTableModule">\n' +
    '        <h2 class="layui-colla-title">立项明细</h2>\n' +
    '        <div class="layui-colla-content mtl_info layui-show">\n' +
    '            <div>\n' +
    '                <table id="materialDetailsTable" lay-filter="materialDetailsTable"></table>\n' +
    '            </div>\n' +
    '        </div>\n' +
    '    </div>\n' +
    <%--    /* endregion */--%>
    <%--    /* region 变更单明细 */--%>
    // '    <div class="layui-colla-item">\n' +
    // '        <h2 class="layui-colla-title">变更单明细</h2>\n' +
    // '        <div class="layui-colla-content mtl_info2 layui-show">\n' +
    // '            <div>\n' +
    // '                <table id="materialDetailsTable2" lay-filter="materialDetailsTable2"></table>\n' +
    // '            </div>\n' +
    // '        </div>\n' +
    // '    </div>\n' +
    <%--    /* endregion */--%>
    '</div>';
        $("#htm").html(htm)
    var dictionaryObj = {
        CONTROL_TYPE: {},
        CBS_UNIT: {},
        MTL_VALUATION_UNIT:{},
        MANAGE_ITEM_TYPE:{},
        OPT_TAR_TYPE:{}
    }
    var dictionaryStr = 'CONTROL_TYPE,CBS_UNIT,MTL_VALUATION_UNIT,MANAGE_ITEM_TYPE,OPT_TAR_TYPE';
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
    layui.use(['form','table','xmSelect','eleTree'],function() {
        var table=layui.table;
        var form=layui.form;
        var eleTree=layui.eleTree;
        var _data;
        if (_type != 0 && (runId == undefined || runId == "" || runId == null)) {
            layer.msg("获取信息失败")
        }
        //优化目标数据类型
        var $select1 = $("#optTarType");
        var optionStr = '<option value="">请选择</option>';
        var _str=dictionaryObj.OPT_TAR_TYPE.str;
        if(_str!=undefined){
            optionStr += _str
        }
        //附件
        fileuploadFn('#fileupload', $('#fileContent'));

        $select1.html(optionStr);
        $.ajax({
            url:'/targetCost/getById?runId='+runId,
            async:false,
            success:function(res){
                formData=res.obj
            }
        })
        //数据回显
        form.val('baseForm',formData);

        if (formData.attachmentList && formData.attachmentList.length > 0) {
            var fileArr = formData.attachmentList;
            $('#fileContent').append(echoAttachment(fileArr));
        }

        if(_type=="1"||_type==1){
            $('.deImgs').hide();
        }
        //立项明细
        var materialDetailsTableData=formData.detailsList;
        var cols=[
            {type: 'numbers', title: '序号'},
            /*{
                field: 'projBudgetId', title: '目标选择',minWidth:100, templet: function (d) {
                    return '<p name="projBudgetId" style="text-align: center"><i class="layui-icon layui-icon-add-circle chooseMaterials" style="font-size: 25px;cursor: pointer"></i></p>'
                }
            },*/
            {
                field: 'wbsId', title: 'WBS',minWidth:230, templet: function (d) {
                    return '<input type="text" readonly name="wbsId" wbsId="'+(d.wbsId||'')+'" projBudgetId="'+(d.projBudgetId||"")+'"  manageProjInfoId="'+(d.manageProjInfoId||"")+'" class="layui-input" style="height: 100%;background: #e7e7e7;" value="' + (d.wbsName || '') + '">'
                }
            },
            {
                field: 'rbsId', title: 'RBS',minWidth:200, templet: function (d) {
                    return '<input type="text" readonly name="rbsId" rbsId="'+(d.rbsId||'')+'" class="layui-input" style="height: 100%;background: #e7e7e7;" value="' + (d.rbsLongName || d.rbsName  ||'') + '">'
                }
            },
            {
                field: 'cbsId', title: 'CBS',minWidth:200, templet: function (d) {
                    return '<input type="text" readonly name="cbsId" cbsId="'+(d.cbsId||'')+'" class="layui-input" style="height: 100%;background: #e7e7e7;" value="' + (d.cbsName || '') + '">'
                }
            },
            {
                field: 'incomeTarNum', title: '收入目标数量',minWidth:120, templet: function (d) {
                    return '<input type="number" readonly name="incomeTarNum" class="layui-input" style="height: 100%;background: #e7e7e7;" value="' + (d.incomeTarNum || '0') + '">'
                }
            },
            {
                field: 'incomeTarPrice', title: '收入目标单价',minWidth:120, templet: function (d) {
                    return '<input type="number" readonly name="incomeTarPrice" class="layui-input" style="height: 100%;background: #e7e7e7;" value="' + (d.incomeTarPrice || '0') + '">'
                }
            },
            {
                field: 'incomeTarAmount', title: '收入目标金额',minWidth:120, templet: function (d) {
                    return '<input type="number" readonly name="incomeTarAmount" class="layui-input" style="height: 100%;background: #e7e7e7;" value="' + (d.incomeTarAmount || '0') + '">'
                }
            },
            {
                field: 'optTarNum', title: '优化目标数量',minWidth:120, templet: function (d) {
                    return '<input type="number" readonly name="optTarNum" class="layui-input" style="height: 100%;background: #e7e7e7;" value="' + (d.optTarNum || '0') + '">'
                }
            },
            {
                field: 'optTarPrice', title: '优化目标单价',minWidth:120, templet: function (d) {
                    return '<input type="number" readonly name="optTarPrice" class="layui-input" style="height: 100%;background: #e7e7e7;" value="' + (d.optTarPrice || '0') + '">'
                }
            },
            {
                field: 'optTarAmount', title: '优化目标金额',minWidth:120, templet: function (d) {
                    return '<input type="number" readonly name="optTarAmount" class="layui-input" style="height: 100%;background: #e7e7e7;" value="' + (d.optTarAmount || '0') + '">'
                }
            },
            {
                field: 'manageTarNum', title: '管理目标数量',minWidth:120, templet: function (d) {
                    return '<input type="number" readonly name="manageTarNum" class="layui-input" style="height: 100%;background: #e7e7e7;" value="' + (d.manageTarNum || '0') + '">'
                }
            },
            {
                field: 'manageTarPrice', title: '管理目标单价',minWidth:120, templet: function (d) {
                    return '<input type="number" readonly name="manageTarPrice" class="layui-input" style="height: 100%;background: #e7e7e7;" value="' + (d.manageTarPrice || '0') + '">'
                }
            },
            {
                field: 'manageTarAmount', title: '管理目标金额',minWidth:120, templet: function (d) {
                    return '<input type="number" readonly name="manageTarAmount" class="layui-input" style="height: 100%;background: #e7e7e7;" value="' + (d.manageTarAmount || '0') + '">'
                }
            },

            {
                field: 'icnTarNumCha', title: '收入目标数量变更',minWidth:150, templet: function (d) {
                    return '<input type="number" name="icnTarNumCha" class="layui-input" style="height: 100%;" value="' + (d.icnTarNumCha || 0) + '" onkeyup="extractNumber(this,3,true)">'
                }
            },
            {
                field: 'icnTarMonCha', title: '收入目标金额变更',minWidth:150, templet: function (d) {
                    return '<input type="number" name="icnTarMonCha" class="layui-input" style="height: 100%;" value="' + (d.icnTarMonCha || 0) + '" onkeyup="extractNumber(this,2,true)">'
                }
            },
            {
                field: 'optTarNumCha', title: '优化目标数量变更',minWidth:160, templet: function (d) {
                    return '<input type="number" name="optTarNumCha" class="layui-input" style="height: 100%;" value="' + (d.optTarNumCha || '0') + '" onkeyup="extractNumber(this,3,true)">'
                }
            },
            {
                field: 'optTarMonCha', title: '优化目标金额变更',minWidth:160, templet: function (d) {
                    return '<input type="number" name="optTarMonCha" class="layui-input" style="height: 100%;" value="' + (d.optTarMonCha || '0') + '" onkeyup="extractNumber(this,2,true)">'
                }
            },
            {
                field: 'adjIncomeTarNum', title: '调整后收入目标数量',minWidth:160, templet: function (d) {
                    return '<input type="number" readonly name="adjIncomeTarNum" class="layui-input" style="height: 100%;background: #e7e7e7;" value="' + (d.adjIncomeTarNum || '0') + '">'
                }
            },
            {
                field: 'adjIncomeTarPrice', title: '调整后收入目标单价',minWidth:160, templet: function (d) {
                    return '<input type="number" readonly name="adjIncomeTarPrice" class="layui-input" style="height: 100%;background: #e7e7e7;" value="' + (d.adjIncomeTarPrice || '0') + '">'
                }
            },
            {
                field: 'adjIncomeTarAmount', title: '调整后收入目标金额',minWidth:160, templet: function (d) {
                    return '<input type="number" readonly name="adjIncomeTarAmount" class="layui-input" style="height: 100%;background: #e7e7e7;" value="' + (d.adjIncomeTarAmount || '0') + '">'
                }
            },
            {
                field: 'adjManTarNum', title: '调整后管理目标数量',minWidth:160, templet: function (d) {
                    return '<input type="number" readonly name="adjManTarNum" class="layui-input" style="height: 100%;background: #e7e7e7;" value="' + (d.adjManTarNum || '0') + '">'
                }
            },
            {
                field: 'adjManTarPrice', title: '调整后管理目标单价',minWidth:160, templet: function (d) {
                    return '<input type="number" readonly name="adjManTarPrice" class="layui-input" style="height: 100%;background: #e7e7e7;" value="' + (d.adjManTarPrice || '0') + '">'
                }
            },
            {
                field: 'adjManTarAmount', title: '调整后管理目标金额',minWidth:160, templet: function (d) {
                    return '<input type="number" readonly name="adjManTarAmount" class="layui-input" style="height: 100%;background: #e7e7e7;" value="' + (d.adjManTarAmount || '0') + '">'
                }
            }
        ]
        if(_type=='0'){
            cols.push({align: 'center', toolbar: '#barDemo', title: '操作', minWidth: 100,fixed:'right'})
        }

        var incChaTotal;
        var optChaTotal;
        table.render({
            elem: '#materialDetailsTable',
            data: materialDetailsTableData,
            toolbar:type==4? false : '#toolbarDemoIn',
            defaultToolbar: [''],
            limit: 1000,
            height: materialDetailsTableData&&materialDetailsTableData.length>5?'full-350':false,
            cols: [cols],
            done:function (obj) {
                if(obj != undefined&&obj.data != undefined){
                }
                $('[name="icnTarNumCha"]').blur(function(){
                    calculation("adjIncomeTarNum,adjManTarNum,adjIncomeTarPrice,adjManTarPrice",$(this));
                })
                $('[name="icnTarMonCha"]').blur(function(){
                    incChaTotal=0
                    calculation("adjIncomeTarAmount,adjManTarAmount,adjIncomeTarPrice,adjManTarPrice",$(this));
                    var $tr = $('#materialDetailsTableModule').find('.layui-table-main tr [name="icnTarMonCha"]');
                    $tr.each(function (index,element) {
                        incChaTotal=accAdd(incChaTotal,($(element).val()||0));
                    });
                    $("[name='incChaTotal']").val(retainDecimal(incChaTotal,3)||0);
                })
                $('[name="optTarNumCha"]').blur(function(){
                    calculation("adjManTarNum,adjManTarPrice,adjManTarPrice",$(this));
                })
                $('[name="optTarMonCha"]').blur(function(){
                    optChaTotal=0
                    calculation("adjManTarAmount,adjManTarPrice,adjManTarPrice",$(this));
                    var $tr = $('#materialDetailsTableModule').find('.layui-table-main tr [name="optTarMonCha"]');
                    $tr.each(function (index,element) {
                        optChaTotal=accAdd(optChaTotal,($(element).val()||0));
                    });
                    $("[name='optChaTotal']").val(retainDecimal(optChaTotal,3)||0);
                })
            }
        });

        // 立项明细-选择
        table.on('toolbar(materialDetailsTable)', function (obj) {
            var wbsSelectTree = null;
            var cbsSelectTree = null;
            var rbsSelectTree =null;
            switch (obj.event) {
                case 'add':

                    var wbsSelectTree = null;
                    var cbsSelectTree = null;
                    var _this = $(this);
                    layer.open({
                        type: 1,
                        title: '管理目标选择',
                        area: ['80%', '80%'],
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
                                    obj.parentId=parentId?parentId:'1';
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
                                            field: 'itemUnit', title: '单位',minWidth:120, templet: function (d) {
                                                var str = '';
                                                if (d.plbRbs) {
                                                    str = dictionaryObj['CBS_UNIT']['object'][d.itemUnit] || '';
                                                }
                                                return str;
                                            }
                                        },
                                        {field: 'manageTarPrice', title: '管理目标单价',minWidth:120},
                                        {field: 'manageTarNum', title: '管理目标数量',minWidth:120},
                                        {field: 'manageTarAmount', title: '管理目标金额',minWidth:120},
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
                            var DataArr = [];
                            //遍历表格获取每行数据进行保存
                            var $tr = $('.mtl_info').find('.layui-table-main tr');
                            $tr.each(function () {
                                var oldDataObj = {
                                    wbsId:$(this).find("[name='wbsId']").attr("wbsId")||'',
                                    manageProjInfoId:$(this).find("[name='wbsId']").attr("manageProjInfoId"),
                                    projBudgetId:$(this).find("[name='wbsId']").attr("projBudgetId")||'0',
                                    wbsName:$(this).find("[name='wbsId']").val()||'',
                                    cbsId:$(this).find("[name='cbsId']").attr("cbsId")||'',
                                    cbsName:$(this).find("[name='cbsId']").val()||'',
                                    rbsLongName:$(this).find("[name='rbsId']").val()||'',
                                    rbsId:$(this).find("[name='rbsId']").attr("rbsId")||'',
                                    incomeTarNum:$(this).find("[name='incomeTarNum']").val()||'0',
                                    incomeTarPrice:$(this).find("[name='incomeTarPrice']").val()||'0',
                                    incomeTarAmount:$(this).find("[name='incomeTarAmount']").val()||'0',
                                    optTarNum:$(this).find("[name='optTarNum']").val()||'0',
                                    optTarPrice:$(this).find("[name='optTarPrice']").val()||'0',
                                    optTarAmount:$(this).find("[name='optTarAmount']").val()||'0',
                                    manageTarNum:$(this).find("[name='manageTarNum']").val()||'0',
                                    manageTarPrice:$(this).find("[name='manageTarPrice']").val()||'0',
                                    manageTarAmount:$(this).find("[name='manageTarAmount']").val()||'0',
                                    icnTarNumCha:$(this).find("[name='icnTarNumCha']").val()||'0',
                                    icnTarMonCha:$(this).find("[name='icnTarMonCha']").val()||'0',
                                    optTarNumCha:$(this).find("[name='optTarNumCha']").val()||'0',
                                    optTarMonCha:$(this).find("[name='optTarMonCha']").val()||'0',
                                    adjIncomeTarNum:$(this).find("[name='adjIncomeTarNum']").val()||'0',
                                    adjIncomeTarPrice:$(this).find("[name='adjIncomeTarPrice']").val()||'0',
                                    adjIncomeTarAmount:$(this).find("[name='adjIncomeTarAmount']").val()||'0',
                                    adjManTarNum:$(this).find("[name='adjManTarNum']").val()||'0',
                                    adjManTarPrice:$(this).find("[name='adjManTarPrice']").val()||'0',
                                    adjManTarAmount:$(this).find("[name='adjManTarAmount']").val()||'0',
                                }
                                DataArr.push(oldDataObj);
                            });
                            var checkStatus=[];
                            $('#objectives .layui-table-body .laytable-cell-checkbox').each(function(index,item){
                                if($(item).find('.layui-form-checked').length>0){
                                    checkStatus.push(_dataa[index]);
                                }
                            })
                            if (checkStatus.length > 0) {
                                for(var i=0;i<checkStatus.length;i++){
                                    var oldDataObj = {
                                        projBudgetId:checkStatus[i].projBudgetId||'',
                                        wbsName:checkStatus[i].plbProjWbs?checkStatus[i].plbProjWbs.wbsName:'',
                                        wbsId:checkStatus[i].plbProjWbs?checkStatus[i].plbProjWbs.wbsId:'',
                                        cbsName:checkStatus[i].plbCbsTypeWithBLOBs?checkStatus[i].plbCbsTypeWithBLOBs.cbsName:'',
                                        cbsId:checkStatus[i].plbCbsTypeWithBLOBs?checkStatus[i].plbCbsTypeWithBLOBs.cbsId:'',
                                        rbsLongName:checkStatus[i].plbProjWbs?checkStatus[i].plbRbs.rbsLongName:'',
                                        rbsId:checkStatus[i].plbProjWbs?checkStatus[i].plbRbs.rbsId:'',
                                        incomeTarNum:checkStatus[i].incomeTarNum||'0',
                                        incomeTarPrice:checkStatus[i].incomeTarPrice||'0',
                                        incomeTarAmount:checkStatus[i].incomeTarAmount||'0',
                                        optTarNum:checkStatus[i].optTarNum||'0',
                                        optTarPrice:checkStatus[i].optTarPrice||'0',
                                        optTarAmount:checkStatus[i].optTarAmount||'0',
                                        manageTarNum:checkStatus[i].manageTarNum||'0',
                                        manageTarPrice:checkStatus[i].manageTarPrice||'0',
                                        manageTarAmount:checkStatus[i].manageTarAmount||'0',

                                        adjIncomeTarNum:checkStatus[i].incomeTarNum||'0',
                                        adjIncomeTarAmount:checkStatus[i].incomeTarAmount||'0',
                                        adjManTarNum:checkStatus[i].manageTarNum||'0',
                                        adjManTarAmount:checkStatus[i].manageTarAmount||'0',
                                        adjIncomeTarPrice:retainDecimal(div(checkStatus[i].incomeTarAmount,(checkStatus[i].incomeTarNum||'1')),3)||'0',
                                        adjManTarPrice:retainDecimal(div(checkStatus[i].manageTarAmount,(checkStatus[i].manageTarNum||'1')),3)||'0',
                                    }
                                    if (DataArr){
                                        var _flag=true;
                                        for(var j=0;j<DataArr.length;j++){
                                            if(DataArr[j].projBudgetId==checkStatus[i].projBudgetId){
                                                _flag = false
                                            }
                                        }
                                        if(_flag){
                                            DataArr.push(oldDataObj)
                                        }
                                    }else{
                                        DataArr.push(oldDataObj)
                                    }
                                }


                                layer.close(index);

                                table.reload('materialDetailsTable', {
                                    data: DataArr,
                                    height: DataArr&&DataArr.length>5?'full-350':false
                                });

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
            var $tr=obj.tr;
            if (layEvent === 'del') {
                obj.del();
                var incChaTotalVal=$('[name="incChaTotal"]').val();
                var icnTarMonChaVal=$tr.find('[name="icnTarMonCha"]').val();
                $('[name="incChaTotal"]').val(sub(incChaTotalVal,icnTarMonChaVal)|| 0);
                var optChaTotalVal=$('[name="optChaTotal"]').val();
                var optTarMonChaVal=$tr.find('[name="optTarMonCha"]').val();
                $('[name="optChaTotal"]').val(sub(optChaTotalVal,optTarMonChaVal)|| 0);
                //遍历表格获取每行数据进行保存
                var $tr = $('.mtl_info').find('.layui-table-main tr');
                var oldDataArr = [];
                $tr.each(function () {
                    var oldDataObj = {
                        projBudgetId:$(this).find('input[name="wbsId"]').attr('projBudgetId'),
                        manageProjInfoId:$(this).find('input[name="wbsId"]').attr('manageProjInfoId'),
                        manageProjId: $(this).find('input[name="wbsId"]').attr('manageProjId'),
                        wbsName: $(this).find('input[name="wbsId"]').val(),
                        wbsId: $(this).find('input[name="wbsId"]').attr('wbsId'),
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

                        icnTarNumCha: $(this).find('input[name="icnTarNumCha"]').val(),
                        icnTarMonCha: $(this).find('input[name="icnTarMonCha"]').val(),
                        optTarNumCha: $(this).find('input[name="optTarNumCha"]').val(),

                        optTarMonCha: $(this).find('input[name="optTarMonCha"]').val(),
                        manTarOptAmount: $(this).find('input[name="manTarOptAmount"]').val(),

                        aftManTarNum: $(this).find('input[name="aftManTarNum"]').val(),
                        aftManTarPrice: $(this).find('input[name="aftManTarPrice"]').val(),
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
                if (data.manageProjInfoId) {
                    $.get('/targetCost/delDetail', {ids: data.manageProjInfoId}, function (res) {
                        if (res.code=='0') {
                            layer.msg('删除成功!', {icon: 1, time: 2000});
                            table.reload('materialDetailsTable', {
                                data: oldDataArr,
                                height: oldDataArr&&oldDataArr.length>5?'full-350':false
                            });
                        } else {
                            layer.msg('删除失败!', {icon: 2, time: 2000});
                        }
                    });
                } else {
                    layer.msg('删除成功!', {icon: 1, time: 2000});
                    table.reload('materialDetailsTable', {
                        data: oldDataArr,
                        height: oldDataArr&&oldDataArr.length>5?'full-350':false
                    });
                }

            }

        });
        if(_type=="1"||_type==1){
            // $('input').attr("disabled",true);
            // $('#baseForm [name="optTarType"]').attr('disabled','true')
            // $('textarea').attr('disabled',true);
            $('._disabled [name]').attr('disabled','true')
            $('.open_file').hide();
            $("#addBtn").hide();
            $('#delBtn').hide();
        }else{
            cols.push({align: 'center', toolbar: '#barDemo', title: '操作', minWidth: 100,fixed:'right'})
        }
        form.render();
    })
    function getUrlParam(name){
        var reg = new RegExp(name +"=(.*?)((?=&|$))"); //构造一个含有目标参数的正则表达式对象
        var r = window.location.href.match(reg); //匹配目标参数
        if (r!=null) return unescape(r[1]); return null; //返回参数值
    }
    function extractNumber(obj, decimalPlaces, allowNegative) {
        var temp = obj.value;


        // avoid changing things if already formatted correctly
        var reg0Str = '[0-9]*';
        if (decimalPlaces > 0) {
            reg0Str += '\\.?[0-9]{0,' + decimalPlaces + '}';
        } else if (decimalPlaces < 0) {
            reg0Str += '\\.?[0-9]*';
        }
        reg0Str = allowNegative ? '^-?' + reg0Str : '^' + reg0Str;
        reg0Str = reg0Str + '$';
        var reg0 = new RegExp(reg0Str);
        if (reg0.test(temp)) return true;


        // first replace all non numbers
        var reg1Str = '[^0-9' + (decimalPlaces != 0 ? '.' : '') + (allowNegative ? '-' : '') + ']';
        var reg1 = new RegExp(reg1Str, 'g');
        temp = temp.replace(reg1, '');


        if (allowNegative) {
            // replace extra negative
            var hasNegative = temp.length > 0 && temp.charAt(0) == '-';
            var reg2 = /-/g;
            temp = temp.replace(reg2, '');
            if (hasNegative) temp = '-' + temp;
        }


        if (decimalPlaces != 0) {
            var reg3 = /\./g;
            var reg3Array = reg3.exec(temp);
            if (reg3Array != null) {
                // keep only first occurrence of .
                // and the number of places specified by decimalPlaces or the entire string if decimalPlaces < 0
                var reg3Right = temp.substring(reg3Array.index + reg3Array[0].length);
                reg3Right = reg3Right.replace(reg3, '');
                reg3Right = decimalPlaces > 0 ? reg3Right.substring(0, decimalPlaces) : reg3Right;
                temp = temp.substring(0, reg3Array.index) + '.' + reg3Right;
            }
        }


        obj.value = temp;
    }
    function calculation(str,_this){
        /*
        调整后收入目标数量=收入目标数量+收入目标数量变更 (保留3位小数)
        调整后收入目标单价=调整后收入目标金额/调整后收入目标数量 (保留3位小数)
        调整后收入目标金额=收入目标金额+收入目标金额变更 (保留2位小数)
        调整后管理目标数量=管理目标数量+收入目标数量变更-优化目标数量变更 (保留3位小数)
        调整后管理目标单价=调整后管理目标金额/调整后管理目标数量 (保留3位小数)
        调整后管理目标金额=管理目标金额+收入目标金额变更-优化目标金额变更 (保留2位小数)
         */
        var incomeTarNumVal=_this.parents('tr').find('[name="incomeTarNum"]').val();//收入目标数量
        var icnTarNumChaVal=_this.parents('tr').find('[name="icnTarNumCha"]').val();//收入目标数量调整
        var adjIncomeTarAmount=$('[name="adjIncomeTarAmount"]').val();//调整后收入目标金额
        var adjIncomeTarNum=$('[name="adjIncomeTarNum"]').val();//调整收入目标数量
        var incomeTarAmountVal=_this.parents('tr').find('[name="incomeTarAmount"]').val();//收入目标金额
        var icnTarMonChaVal=_this.parents('tr').find('[name="icnTarMonCha"]').val();//收入目标金额变更
        var manageTarNumVal=_this.parents('tr').find('[name="manageTarNum"]').val();//管理目标数量
        var optTarNumChaVal=_this.parents('tr').find('[name="optTarNumCha"]').val();//优化目标数量变更
        var adjManTarAmount=$('[name="adjManTarAmount"]').val();//调整后管理目标金额
        var adjManTarNum=$('[name="adjManTarNum"]').val();//调整后管理目标数量
        var manageTarAmountVal=_this.parents('tr').find('[name="manageTarAmount"]').val();//管理目标金额
        var optTarMonChaVal=_this.parents('tr').find('[name="optTarMonCha"]').val();//优化目标金额变更
        var arr=new Array();
        arr=str.split(',');
        for(var i=0;i<arr.length;i++){
            switch (arr[i]) {
                case 'adjIncomeTarNum':
                    //调整后收入目标数量
                    var  adjIncomeTarNumVal=accAdd(incomeTarNumVal,icnTarNumChaVal);
                    _this.parents('tr').find('[name="adjIncomeTarNum"]').val(retainDecimal(adjIncomeTarNumVal,3)||0);
                    continue;
                case 'adjIncomeTarAmount':
                    //调整后收入目标金额
                    var adjIncomeTarAmountVal=accAdd(incomeTarAmountVal,icnTarMonChaVal);
                    _this.parents('tr').find('[name="adjIncomeTarAmount"]').val(retainDecimal(adjIncomeTarAmountVal,2)|0);

                    continue;
                case 'adjManTarNum':
                    //调整后管理目标数量
                    var adjManTarNumVal=sub(accAdd(manageTarNumVal,icnTarNumChaVal),optTarNumChaVal);
                    _this.parents('tr').find('[name="adjManTarNum"]').val(retainDecimal(adjManTarNumVal,3)||0);
                    continue;
                case 'adjManTarAmount':
                    //调整后管理目标金额
                    var adjManTarAmountVal=sub(accAdd(manageTarAmountVal,icnTarMonChaVal),optTarMonChaVal);
                    _this.parents('tr').find('[name="adjManTarAmount"]').val(retainDecimal(adjManTarAmountVal,2)||0);
                    continue;
                case 'adjIncomeTarPrice':
                    //调整后收入目标单价
                    var adjIncomeTarNumVal=_this.parents('tr').find('[name="adjIncomeTarNum"]').val();
                    if(adjIncomeTarNumVal=="0"||adjIncomeTarNumVal==0){
                        adjIncomeTarNumVal=1
                    }
                    var adjIncomeTarPriceVal=div(_this.parents('tr').find('[name="adjIncomeTarAmount"]').val(),adjIncomeTarNumVal);
                    _this.parents('tr').find('[name="adjIncomeTarPrice"]').val(retainDecimal(adjIncomeTarPriceVal,3)||0);

                    continue;
                case 'adjManTarPrice':
                    //调整后管理目标单价
                    var adjManTarNumVal=_this.parents('tr').find('[name="adjManTarNum"]').val();
                    if(adjManTarNumVal==0||adjManTarNumVal=="0"){
                        adjManTarNumVal=1;
                    }
                    var adjManTarPriceVal=div(_this.parents('tr').find('[name="adjManTarAmount"]').val(),adjManTarNumVal);
                    _this.parents('tr').find('[name="adjManTarPrice"]').val(retainDecimal(adjManTarPriceVal,3)||0);
                    continue;
            }
        }
    }
    function childFunc() {
        if (_type && _type == '1') {
            return true
        }
        var loadIndex = layer.load();
        //材料计划数据
        var datas = $('#baseForm').serializeArray();
        var obj = {}
        datas.forEach(function (item) {
            obj[item.name] = item.value;
        });
        obj.projectId=formData.projectId;

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
        if(formData!=undefined&&formData.tarCostCha!=undefined){
            obj.tarCostCha=formData.tarCostCha
        }
        //立项明细
        var $tr = $('.mtl_info').find('.layui-table-main tr');
        var manageInfoList = [];
        $tr.each(function () {
            var plbManageItemObj = {
                wbsId:$(this).find("[name='wbsId']").attr("wbsId")||'',
                manageProjInfoId:$(this).find("[name='wbsId']").attr("manageProjInfoId"),
                projBudgetId:$(this).find("[name='wbsId']").attr("projBudgetId")||'0',
                wbsName:$(this).find("[name='wbsId']").val()||'',
                cbsId:$(this).find("[name='cbsId']").attr("cbsId")||'',
                cbsName:$(this).find("[name='cbsId']").val()||'',
                rbsLongName:$(this).find("[name='rbsId']").val()||'',
                rbsId:$(this).find("[name='rbsId']").attr("rbsId")||'',
                incomeTarNum:$(this).find("[name='incomeTarNum']").val()||'0',
                incomeTarPrice:$(this).find("[name='incomeTarPrice']").val()||'0',
                incomeTarAmount:$(this).find("[name='incomeTarAmount']").val()||'0',
                optTarNum:$(this).find("[name='optTarNum']").val()||'0',
                optTarPrice:$(this).find("[name='optTarPrice']").val()||'0',
                optTarAmount:$(this).find("[name='optTarAmount']").val()||'0',
                manageTarNum:$(this).find("[name='manageTarNum']").val()||'0',
                manageTarPrice:$(this).find("[name='manageTarPrice']").val()||'0',
                manageTarAmount:$(this).find("[name='manageTarAmount']").val()||'0',
                icnTarNumCha:$(this).find("[name='icnTarNumCha']").val()||'0',
                icnTarMonCha:$(this).find("[name='icnTarMonCha']").val()||'0',
                optTarNumCha:$(this).find("[name='optTarNumCha']").val()||'0',
                optTarMonCha:$(this).find("[name='optTarMonCha']").val()||'0',
                adjIncomeTarNum:$(this).find("[name='adjIncomeTarNum']").val()||'0',
                adjIncomeTarPrice:$(this).find("[name='adjIncomeTarPrice']").val()||'0',
                adjIncomeTarAmount:$(this).find("[name='adjIncomeTarAmount']").val()||'0',
                adjManTarNum:$(this).find("[name='adjManTarNum']").val()||'0',
                adjManTarPrice:$(this).find("[name='adjManTarPrice']").val()||'0',
                adjManTarAmount:$(this).find("[name='adjManTarAmount']").val()||'0',
            }
            if($(this).find('input[name="wbsId"]').attr('projBudgetId')){
                plbManageItemObj.projBudgetId=$(this).find('input[name="wbsId"]').attr('projBudgetId');
            }
            manageInfoList.push(plbManageItemObj);
        });
        if(formData!=undefined&&formData.tarCostCha!=undefined){
            obj.tarCostCha=formData.tarCostCha
        }
        obj.detailsList = manageInfoList;

        var _flag = false;

        $.ajax({
            url: '/targetCost/updateById',
            data: JSON.stringify(obj),
            dataType: 'json',
            contentType: "application/json;charset=UTF-8",
            type: 'post',
            success: function (res) {
                layer.close(loadIndex);
                if (res.code==='0'||res.code===0) {
                    layer.msg('保存成功！', {icon: 1});
                    layer.close(loadIndex);
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
