<%--
  Created by IntelliJ IDEA.
  User: 王秋彤
  Date: 2021/6/29
  Time: 9:11
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>材料需求计划预览</title>

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
    <script type="text/javascript" src="/js/planbudget/common.js?20210414"></script>
    <script src="../js/jquery/jquery.cookie.js"></script>
    <script type="text/javascript" src="/js/planother/planotherUtil.js?221202108311508"></script>

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
            margin-left: 2%;
            color: #00c4ff !important;
            font-weight: 600;
            cursor: pointer;
        }
        .layui-col-xs4{
            width:20%
        }
        .back{
            background-color: #F2F2F2;
        }
        .radioCenter .layui-form-radio{
            padding-top: 15px;
        }
    </style>
</head>
<body>

<div id="htmBox">

</div>

</body>

<script type="text/html" id="toolbarDemoIn">
    <div class="layui-btn-container" style="height: 30px;">
        <button class="layui-btn layui-btn-sm addRow" lay-event="add">加行</button>
    </div>
</script>

<script type="text/html" id="barDemo">
    <a class="layui-btn layui-btn-danger layui-btn-xs" lay-event="del">删行</a>
</script>

<script>

    var htmBox = ['<div class="layui-collapse">\n' ,
        /* region 材料计划 */
        '  <div class="layui-colla-item">\n' +
        '    <h2 class="layui-colla-title">材料计划</h2>\n' +
        '    <div class="layui-colla-content layui-show plan_base_info">' +
        '       <form class="layui-form" id="baseForm" lay-filter="formTest">',
        /* region 第一行 */
        '           <div class="layui-row">' +
        '               <div class="layui-col-xs4" style="padding: 0 5px;">' +
        '                   <div class="layui-form-item">\n' +
        '                       <label class="layui-form-label form_label">需求计划编号<span field="planNo" class="field_required">*</span><a title="刷新编号" class="refresh_no_btn"><i class="layui-icon layui-icon-refresh"></i></a></label>\n' +
        '                       <div class="layui-input-block form_block">\n' +
        '                       <input type="text" name="planNo" readonly autocomplete="off" class="layui-input" style="background:#e7e7e7;display: inline-block;">\n' +
        '                       </div>\n' +
        '                   </div>' +
        '               </div>' +
        '               <div class="layui-col-xs4" style="padding: 0 5px;">' +
        '                   <div class="layui-form-item">\n' +
        '                       <label class="layui-form-label form_label">项目名称<span field="projectName" class="field_required">*</span></label>\n' +
        '                       <div class="layui-input-block form_block">\n' +
        '                       <input type="text" name="projectName" id="projectName" readonly autocomplete="off" class="layui-input">\n' +
        '                       </div>\n' +
        '                   </div>' +
        '               </div>' +
        '               <div class="layui-col-xs4" style="padding: 0 5px;">' +
        '                   <div class="layui-form-item">\n' +
        '                       <label class="layui-form-label form_label">需求计划名称<span field="planName" class="field_required">*</span></label>\n' +
        '                       <div class="layui-input-block form_block">\n' +
        '                       <input type="text" name="planName" autocomplete="off" class="layui-input">\n' +
        '                       </div>\n' +
        '                   </div>' +
        '               </div>' +
        '               <div class="layui-col-xs4" style="padding: 0 5px;">' +
        '                   <div class="layui-form-item">\n' +
        '                       <label class="layui-form-label form_label">需求计划时间<span field="planDate" class="field_required">*</span></label>\n' +
        '                       <div class="layui-input-block form_block">\n' +
        '                       <input type="text" name="planDate" readonly id="planDate" autocomplete="off" class="layui-input" style="background:#e7e7e7;width: 53%;display: inline-block">\n' +
        '                     <button type="button" class="layui-btn  layui-btn-sm chooseManagementBudget">选择管理目标</button>'+
        '                       </div>\n' +
        '                   </div>' +
        '               </div>' +
        '               <div class="layui-col-xs4" style="padding: 0 5px;">' +
        '                   <div class="layui-form-item">\n' +
        '                       <label class="layui-form-label form_label">WBS<span field="wbsId" class="field_required">*</span></label>\n' +
        '                       <div class="layui-input-block form_block">\n' +
        '                       <input type="text" name="wbsId" readonly autocomplete="off" class="layui-input" style="background:#e7e7e7;">\n' +
        '                       </div>\n' +
        '                   </div>' +
        '               </div>' +

        '           </div>' ,
        /* endregion */
        /* region 第二行 */
        '           <div class="layui-row">' +
        '               <div class="layui-col-xs4" style="padding: 0 5px;">' +
        '                   <div class="layui-form-item">\n' +
        '                       <label class="layui-form-label form_label">RBS<span field="rbsLongName" class="field_required">*</span></label>\n' +
        '                       <div class="layui-input-block form_block">\n' +
        '                       <input type="text" name="rbsLongName" readonly autocomplete="off" class="layui-input" style="background:#e7e7e7">\n' +
        '                       </div>\n' +
        '                   </div>' +
        '               </div>' +
        '               <div class="layui-col-xs4" style="padding: 0 5px;">' +
        '                   <div class="layui-form-item">\n' +
        '                       <label class="layui-form-label form_label">CBS<span field="cbsId" class="field_required">*</span></label>\n' +
        '                       <div class="layui-input-block form_block">\n' +
        '                       <input type="text" name="cbsId" readonly autocomplete="off" class="layui-input" style="background:#e7e7e7">\n' +
        '                       </div>\n' +
        '                   </div>' +
        '               </div>' +
        '               <div class="layui-col-xs4" style="padding: 0 5px;">' +
        '                   <div class="layui-form-item">\n' +
        '                       <label class="layui-form-label form_label">控制方式<span field="controlMode" class="field_required">*</span></label>\n' +
        '                       <div class="layui-input-block form_block">\n' +
        '                       <input type="text" name="controlMode" id="inputid" readonly autocomplete="off" class="layui-input" style="background:#e7e7e7">\n' +
        '                       </div>\n' +
        '                   </div>' +
        '               </div>' +
        '               <div class="layui-col-xs4" style="padding: 0 5px;">' +
        '                   <div class="layui-form-item">\n' +
        '                       <label class="layui-form-label form_label">单位</label>\n' +
        '                       <div class="layui-input-block form_block">\n' +
        '                       <input type="text" name="valuationUnit" readonly autocomplete="off" class="layui-input" style="background:#e7e7e7">\n' +
        '                       </div>\n' +
        '                   </div>' +
        '               </div>' +
        '               <div class="layui-col-xs4" style="padding: 0 5px;">' +
        '                   <div class="layui-form-item">\n' +
        '                       <label class="layui-form-label form_label">管理目标数量<span field="budgetItemId" class="field_required">*</span></label>\n' +
        '                       <div class="layui-input-block form_block">\n' +
        // '<i style="position: absolute;top: 8px;right: 5px;" class="layui-icon layui-icon-search"></i>  ' +
        '                       <input type="text" name="totalManagementTarget" readonly autocomplete="off" class="layui-input" style="padding-right: 25px;background:#e7e7e7;">\n' +
        '                       </div>\n' +
        '                   </div>' +
        '               </div>' +
        '           </div>' ,
        /* endregion */
        /* region 第三行 */
        // '           <div class="layui-row">' +
        //
        //
        // '           </div>' ,
        /* endregion */
        /* region 第四行 */
        '           <div class="layui-row">' +
        '               <div class="layui-col-xs4 planNum" style="padding: 0 5px;display: none">' +
        '                   <div class="layui-form-item">\n' +
        '                       <label class="layui-form-label form_label">已提需求计划数量</label>\n' +
        '                       <div class="layui-input-block form_block">\n' +
        '                       <input type="text" readonly name="addupNeedAmount" autocomplete="off" class="layui-input" style="background:#e7e7e7">\n' +
        '                       </div>\n' +
        '                   </div>' +
        '               </div>' +
        '               <div class="layui-col-xs4 planNum" style="padding: 0 5px;display: none">' +
        '                   <div class="layui-form-item">\n' +
        '                       <label class="layui-form-label form_label">在途需求计划数量</label>\n' +
        '                       <div class="layui-input-block form_block">\n' +
        '                       <input type="text" readonly name="onwayAmount" autocomplete="off" class="layui-input" style="background:#e7e7e7">\n' +
        '                       </div>\n' +
        '                   </div>' +
        '               </div>' +
        '               <div class="layui-col-xs4 planNum" style="padding: 0 5px;display: none">' +
        '                   <div class="layui-form-item">\n' +
        '                       <label class="layui-form-label form_label">剩余可提需求计划数量</label>\n' +
        '                       <div class="layui-input-block form_block">\n' +
        '                       <input type="text" readonly name="surplusAmount" autocomplete="off" class="layui-input" style="background:#e7e7e7">\n' +
        '                       </div>\n' +
        '                   </div>' +
        '               </div>' +
        '               <div class="layui-col-xs4 planMoney" style="padding: 0 5px;display: none">' +
        '                   <div class="layui-form-item">\n' +
        '                       <label class="layui-form-label form_label">已提需求计划金额</label>\n' +
        '                       <div class="layui-input-block form_block">\n' +
        '                       <input type="text" readonly name="addupNeedMoney" autocomplete="off" class="layui-input" style="background:#e7e7e7">\n' +
        '                       </div>\n' +
        '                   </div>' +
        '               </div>' +
        '               <div class="layui-col-xs4 planMoney" style="padding: 0 5px;display: none">' +
        '                   <div class="layui-form-item">\n' +
        '                       <label class="layui-form-label form_label">在途需求计划金额</label>\n' +
        '                       <div class="layui-input-block form_block">\n' +
        '                       <input type="text" readonly name="onwayMoney" autocomplete="off" class="layui-input" style="background:#e7e7e7">\n' +
        '                       </div>\n' +
        '                   </div>' +
        '               </div>' +
        '               <div class="layui-col-xs4 planMoney" style="padding: 0 5px;display: none">' +
        '                   <div class="layui-form-item">\n' +
        '                       <label class="layui-form-label form_label">剩余可提需求计划金额</label>\n' +
        '                       <div class="layui-input-block form_block">\n' +
        '                       <input type="text" readonly name="surplusMoney" autocomplete="off" class="layui-input" style="background:#e7e7e7">\n' +
        '                       </div>\n' +
        '                   </div>' +
        '               </div>' +


        '               <div class="layui-col-xs4" style="padding: 0 5px;">' +
        '                   <div class="layui-form-item">\n' +
        '                       <label class="layui-form-label form_label">管理目标金额</label>\n' +
        '                       <div class="layui-input-block form_block">\n' +
        '                       <input type="text" readonly name="mgeTargetPrice" autocomplete="off" class="layui-input" style="background:#e7e7e7">\n' +
        '                       </div>\n' +
        '                   </div>' +
        '               </div>' +
        '               <div class="layui-col-xs4" style="padding: 0 5px;">' +
        '                   <div class="layui-form-item">\n' +
        '                       <label class="layui-form-label form_label">本次需求计划数量</label>\n' +
        '                       <div class="layui-input-block form_block">\n' +
        '                       <input type="text" readonly name="planAmount" autocomplete="off" class="layui-input" style="background:#e7e7e7">\n' +
        '                       </div>\n' +
        '                   </div>' +
        '               </div>' +
        '               <div class="layui-col-xs4" style="padding: 0 5px;">' +
        '                   <div class="layui-form-item">\n' +
        '                       <label class="layui-form-label form_label">本次需求计划预计金额</label>\n' +
        '                       <div class="layui-input-block form_block">\n' +
        '                       <input type="text" readonly name="planMoney" autocomplete="off" class="layui-input" style="background:#e7e7e7">\n' +
        '                       </div>\n' +
        '                   </div>' +
        '               </div>' +
        '               <div class="layui-col-xs4" style="padding: 0 5px;">' +
        '                   <div class="layui-form-item">\n' +
        '                       <label class="layui-form-label form_label">累计入库数量</label>\n' +
        '                       <div class="layui-input-block form_block">\n' +
        '                       <input type="text" readonly name="sumStockinNum" autocomplete="off" class="layui-input" style="background:#e7e7e7">\n' +
        '                       </div>\n' +
        '                   </div>' +
        '               </div>' +
        '               <div class="layui-col-xs4" style="padding: 0 5px;">' +
        '                   <div class="layui-form-item">\n' +
        '                       <label class="layui-form-label form_label">累计入库金额</label>\n' +
        '                       <div class="layui-input-block form_block">\n' +
        '                       <input type="text" readonly name="sumStockinAmunt" autocomplete="off" class="layui-input" style="background:#e7e7e7">\n' +
        '                       </div>\n' +
        '                   </div>' +
        '               </div>' +
        '               <div class="layui-col-xs4" style="padding: 0 5px;">' +
        '                   <div class="layui-form-item">\n' +
        '                       <label class="layui-form-label form_label">需用日期<span field="useDate" class="field_required">*</span></label>\n' +
        '                       <div class="layui-input-block form_block">\n' +
        '                       <input type="text" name="useDate" id="useDate" autocomplete="off" class="layui-input">\n' +
        '                       </div>\n' +
        '                   </div>' +
        '               </div>' +

        '               <div class="layui-col-xs4" style="padding: 0 5px;">' +
        '                   <div class="layui-form-item">\n' +
        '                       <label class="layui-form-label form_label">材料类型<span field="mtlPlanType" class="field_required">*</span></label>\n' +
        '                       <div class="layui-input-block form_block">\n' +
        '                       <select class="mtlPlanType" name="mtlPlanType" ></select>\n' +
        '                       </div>\n' +
        '                   </div>' +
        '               </div>' +
        '               <div class="layui-col-xs4" style="padding: 0 5px;">' +
        '                   <div class="layui-form-item">\n' +
        '                       <label class="layui-form-label form_label">备注</label>\n' +
        '                       <div class="layui-input-block form_block">\n' +
        '                       <input type="text"  name="remark" id="remark" autocomplete="off" class="layui-input" >\n' +
        '                       </div>\n' +
        '                   </div>' +
        '               </div>' +


        // '              <div id="_one">' +
        //
        // '              </div>' +
        '           </div>' ,
        /* endregion */
        '<div class="layui-row" id="_two">' +

        '</div>',
        /* region 第六行*/
        /*'           <div class="layui-row" style="display: none">' +

        '           </div>' ,*/
        /* endregion */
        /* region 第六行*/
        // '           <div class="layui-row" id="_two">' +
        //
        // '           </div>' ,
        /* endregion */
        /* region 第七行 */
        // '           <div class="layui-row">' +
        //
        // '           </div>' ,
        /* endregion */
        /* region 第八行 */
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
        '<input type="file" multiple id="fileupload" data-url="/upload?module=planbudget" name="file">' +
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
        '           </div>' ,
        /* endregion */
        '       </form>' +
        '    </div>\n' +
        '  </div>\n' ,
        /* endregion */
        /* region 材料明细 */
        '  <div class="layui-colla-item">\n' +
        '    <h2 class="layui-colla-title">材料明细</h2>\n' +
        '    <div class="layui-colla-content mtl_info layui-show">' +
        '       <div>' +
        '           <table id="materialDetailsTable" lay-filter="materialDetailsTable"></table>' +
        '      </div>' +
        '    </div>\n' +
        '  </div>\n' ,
        /* endregion */
        /* region 其他 */
        '  <div class="layui-colla-item">\n' +
        '    <h2 class="layui-colla-title">其他</h2>\n' +
        '    <div class="layui-colla-content other_info layui-show">' ,
        '           <div class="layui-row">' +
        '               <div class="layui-col-xs4" style="padding: 0 5px;">' +
        '                   <div class="layui-form-item">\n' +
        '                       <label class="layui-form-label form_label">编制人<span style="margin: 0 10px;">流程定义某节点为编制节点</span>编制时间</label>\n' +
        '                       <div class="layui-input-block form_block">\n' +
        '                       <input type="text" name="createTime" id="createTime" readonly autocomplete="off" class="layui-input">\n' +
        '                       </div>\n' +
        '                   </div>' +
        '               </div>' +
        '               <div class="layui-col-xs4" style="padding: 0 5px;">' +
        '                   <div class="layui-form-item">\n' +
        '                     <label class="layui-form-label form_label">审核人<span style="margin: 0 10px;">流程定义某节点为审核节点</span>审核时间</label>\n' +
        '                       <div class="layui-input-block form_block">\n' +
        '                       <input type="text" name="approvalDate" id="approvalDate" readonly autocomplete="off" class="layui-input">\n' +
        '                       </div>\n' +
        '                   </div>' +
        '               </div>' +
        '               <div class="layui-col-xs4" style="padding: 0 5px;">' +
        '                   <div class="layui-form-item">\n' +
        '                       <label class="layui-form-label form_label">审批人<span style="margin: 0 10px;">流程定义某节点为审批节点</span>审批时间</label>\n' +
        '                       <div class="layui-input-block form_block">\n' +
        '                       <input type="text" name="auditerDate" id="auditerDate" readonly autocomplete="off" class="layui-input">\n' +
        '                       </div>\n' +
        '                   </div>' +
        '               </div>' +
        '           </div>' +
        '   </div>' ,
        /* endregion */
        '  </div>\n' +
        '</div>'].join('');

    $("#htmBox").html(htmBox);

    var type =  $.GetRequest()['type'] || '';
    var mtlSettleupId = $.GetRequest()['mtlSettleupId'] || '';
    var runId = $.GetRequest()['runId'] || '';
    var _disabled = $.GetRequest()['disabled'] || '';

    if(_disabled){
        if(_disabled==="0"||_disabled===0){
            type = 1;
        }else if(_disabled==="1"||_disabled===1){
            type = 4;
        }
    }

    var _rbsObj={};

    // 获取数据字典数据
    var dictionaryObj = {
        CONTROL_TYPE: {},
        CBS_UNIT: {},
        MTL_PLAN_TYPE:{}
    }
    var dictionaryStr = 'CONTROL_TYPE,CBS_UNIT,MTL_PLAN_TYPE';
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
        var loadIndex = layer.load();
        // 获取项目信息
        if (runId) {
            $.get('/plbMtlPlan/selectByRunId', {runId: runId}, function (res) {
                layer.close(loadIndex);
                if (!res.flag) {
                    layer.msg('获取信息失败！', {icon: 2});
                }
                initPage(res.object);
            });
        } else if (mtlSettleupId) {
            $.get('/plbMtlPlan/selectByPlanId', {planId: mtlSettleupId}, function (res) {
                layer.close(loadIndex);
                if (!res.flag)  {
                    layer.msg('获取信息失败！', {icon: 2});
                }
                initPage(res.object);
            });
        } else {
            layer.close(loadIndex);
            layer.msg('获取信息失败！', {icon: 2});
            initPage();
        }
    });

    function initPage(data) {
        layui.use(['form', 'laydate', 'table', 'element', 'soulTable', 'eleTree', 'xmSelect'], function () {
            var laydate = layui.laydate;
            var form = layui.form;
            var table = layui.table;
            var element = layui.element;
            var soulTable = layui.soulTable;
            var eleTree = layui.eleTree;
            var xmSelect = layui.xmSelect;

            if (data) {
                //回显项目名称
                getProjName('#projectName',data.projId)
                $('#htmBox').attr('projId',data.projId)
                $('#htmBox').attr('mtlPlanId',data.mtlPlanId)
                $('#leftId').attr('projId',data.projId)

                //材料类型
                var $select1 = $(".mtlPlanType");
                var optionStr = '<option value="">请选择</option>';
                optionStr += dictionaryObj&&dictionaryObj['MTL_PLAN_TYPE']&&dictionaryObj['MTL_PLAN_TYPE']['str']
                $select1.html(optionStr);

                fileuploadFn('#fileupload', $('#fileContent'));

                var materialDetailsTableData = [];
                //回显数据
                if (type == 1 || type == 4) {


                    // $('#_one').append(_html);
                    // $('#_two').append(_html2);
                    laydate.render({
                        elem: '#useDate' //指定元素
                        , trigger: 'click' //采用click弹出
                        // , value: data ? format(data.useDate) : ''
                    });
                    form.val("formTest", data);

                    $('#planDate').val(data ? format(data.planDate) : '')

                    $('.plan_base_info input[name="totalManagementTarget"]').attr('budgetItemId', data.budgetItemId || '');

                    $('.plan_base_info input[name="wbsId"]').val(data.wbsName || '');
                    $('.plan_base_info input[name="wbsId"]').attr('wbsId', data.wbsId || '');
                    $('.plan_base_info input[name="rbsId"]').val(data.rbsName || '');
                    $('.plan_base_info input[name="rbsId"]').attr('rbsId', data.plbRbs.rbsId || '');
                    $('.plan_base_info input[name="cbsId"]').val(data.cbsName || '');
                    $('.plan_base_info input[name="cbsId"]').attr('cbsId', data.cbsId || '');
                    // 控制类型
                    $('.plan_base_info input[name="controlMode"]').val(dictionaryObj['CONTROL_TYPE']['object'][data.controlMode] || '');
                    $('.plan_base_info input[name="controlMode"]').attr('controlMode', data.controlMode || '');
                    // 计量单位
                    $('.plan_base_info input[name="valuationUnit"]').val(dictionaryObj['CBS_UNIT']['object'][data.valuationUnit] || '');
                    $('.plan_base_info input[name="valuationUnit"]').attr('valuationUnit', data.valuationUnit || '');

                    if (data.attachmentList && data.attachmentList.length > 0) {
                        var fileArr = data.attachmentList;
                        $('#fileContent').append(echoAttachment(fileArr));
                    }

                    materialDetailsTableData = data.listWithBLOBs;

                    //查看详情
                    if(type==4){
                        $('.layui-layer-btn-c').hide()
                        $('#baseForm [name="planName"]').attr('disabled','true')
                        $('#useDate').attr('disabled','true')
                        $('.mtlPlanType').attr('disabled','true')
                        $('#baseForm [name="remark"]').attr('disabled','true')
                        $('.file_upload_box').hide()
                        $('.deImgs').hide()
                        $('#createTime').attr('disabled','true')
                        $('#approvalDate').attr('disabled','true')
                        $('#auditerDate').attr('disabled','true')
                        $('.chooseManagementBudget').hide()
                    }
                    if (data.controlMode == '01') {    // 数量控制
                        $('.planNum').show()
                    }else if (data.controlMode == '02') {  // 金额控制
                        $('.planMoney').show()
                    }else if (data.controlMode == '03') {   // 数量+金额控制
                        $('.planNum').show()
                        $('.planMoney').show()
                    }
                }

                element.render();
                form.render();
                /*laydate.render({
                    elem: '#planDate' //指定元素
                    , trigger: 'click' //采用click弹出
                    , value: data ? format(data.planDate) : ''
                });*/
                laydate.render({
                    elem: '#useDate' //指定元素
                    , trigger: 'click' //采用click弹出
                    , value: data ? format(data.useDate) : ''
                });
                laydate.render({
                    elem: '#createTime' //指定元素
                    , trigger: 'click' //采用click弹出
                    , value: data ? format(data.createTime) : ''
                });
                laydate.render({
                    elem: '#approvalDate' //指定元素
                    , trigger: 'click' //采用click弹出
                    , value: data ? format(data.approvalDate) : ''
                });
                laydate.render({
                    elem: '#auditerDate' //指定元素
                    , trigger: 'click' //采用click弹出
                    , value: data ? format(data.auditerDate) : ''
                });


                var cols=[
                    {type: 'numbers', title: '操作'},
                    {
                        field: 'planMtlName', title: '材料名称', width: 200, templet: function (d) {
                            return '<input mtlPlanListId="' + (d.mtlPlanListId || '') + '" mtlLibId="'+(d.mtlLibId || '')+'" readonly type="text" name="planMtlName" class="layui-input" style="width: 90%;height: 100%;background: #e7e7e7;" value="' + (d.planMtlName || '') + '"><i class="layui-icon layui-icon-add-circle chooseMaterials" style="position: absolute;top: 0;right: 2px;font-size: 25px;cursor: pointer"></i>'
                        }
                    },
                    {
                        field: 'planMtlStandard', title: '材料规格', templet: function (d) {
                            return '<input type="text" readonly name="planMtlStandard" class="layui-input" style="height: 100%;background: #e7e7e7;" value="' + (d.planMtlStandard || '') + '">'
                        }
                    },
                    {
                        field: 'valuationUnit', title: '计量单位',
                        templet: function (d) {
                            // var controlMode = $('.plan_base_info input[name="controlMode"]').attr('controlMode') || '';
                            // if (controlMode == '01') {
                            //     return '<input type="text" valuationUnit="'+d.valuationUnit+'" name="valuationUnit" readonly class="layui-input '+(type==4 ?  '' : 'chooseMtlUnit')+'" style="height: 100%;cursor: pointer" value="' + (dictionaryObj['CBS_UNIT']['object'][d.valuationUnit] || '') + '">'
                            // }else{
                            //     return '<input type="text" valuationUnit="'+d.valuationUnit+'" name="valuationUnit" readonly class="layui-input '+(type==4 ?  '' : 'chooseMtlUnit')+'" style="height: 100%;cursor: pointer" value="' + (dictionaryObj['MTL_VALUATION_UNIT']['object'][d.valuationUnit] || '') + '">'
                            // }
                            return '<input type="text" valuationUnit="'+d.valuationUnit+'" name="valuationUnit" readonly class="layui-input '+(type==4 ?  '' : 'chooseMtlUnit')+'" style="height: 100%;cursor: pointer" value="' + (dictionaryObj['CBS_UNIT']['object'][d.valuationUnit] || '') + '">'
                        }
                    },
                    {
                        field: 'directUnitPrice', title: '指导单价',
                    },
                    {
                        field: 'estiUnitPrice', title: '预计单价', templet: function (d) {
                            return '<input type="text" name="estiUnitPrice" '+(type==4 ? 'readonly' : '')+' class="layui-input estiUnitPriceItem" autocomplete="off" style="height: 100%;" value="' + (d.estiUnitPrice || '') + '">'
                        }
                    },
                    {
                        field: 'thisAmount', title: '本次数量*', templet: function (d) {
                            return '<input type="text" name="thisAmount" '+(type==4 ? 'readonly' : '')+' class="layui-input thisAmountItem" autocomplete="off" style="height: 100%;" value="' + (d.thisAmount || '') + '">'
                        }
                    },
                    {
                        field: 'thisTotalPrice', title: '预计金额', templet: function (d) {
                            return '<input type="text" name="thisTotalPrice" readonly class="layui-input" autocomplete="off" style="height: 100%;background: #e7e7e7" value="' + (d.thisTotalPrice || '') + '">'
                        }
                    },
                    {
                        field: 'usePlace', title: '使用部位', templet: function (d) {
                            return '<input type="text" name="usePlace" '+(type==4 ? 'readonly' : '')+' class="layui-input" autocomplete="off" style="height: 100%;" value="' + (d.usePlace || '') + '">'
                        }
                    },
                ]
                if(type!=4){
                    cols.push({align: 'center', toolbar: '#barDemo', title: '操作', width: 100})
                }
                table.render({
                    elem: '#materialDetailsTable',
                    data: materialDetailsTableData,
                    height: materialDetailsTableData&&materialDetailsTableData.length>5?'full-450':false,
                    toolbar: '#toolbarDemoIn',
                    defaultToolbar: [''],
                    limit: 1000,
                    cols: [cols],
                    done:function () {
                        if(type==4){
                            $('.addRow').hide()
                            $('.chooseMaterials').hide()
                        }
                    }
                });

            }

            // 内部加行按钮
            table.on('toolbar(materialDetailsTable)', function (obj) {
                switch (obj.event) {
                    case 'add':
                        // 判断控制方式
                        var controlMode = $('.plan_base_info input[name="controlMode"]').attr('controlMode') || '';

                        if (!controlMode) {
                            layer.msg('请选择管理目标', {icon: 0, time: 1500});
                            return false;
                        }
                        // var valuationUnit = '';
                        // if (controlMode == '01') {
                        //     valuationUnit = $('.plan_base_info input[name="valuationUnit"]').attr('valuationUnit') || '';
                        // }

                        //遍历表格获取每行数据进行保存
                        var $tr = $('.mtl_info').find('.layui-table-main tr');
                        var oldDataArr = [];
                        $tr.each(function () {
                            var oldDataObj = {
                                planMtlName: $(this).find('input[name="planMtlName"]').val(),
                                planMtlStandard: $(this).find('input[name="planMtlStandard"]').val(),
                                valuationUnit: $(this).find('input[name="valuationUnit"]').attr('valuationUnit'),
                                directUnitPrice: $(this).find('[data-field="directUnitPrice"] .layui-table-cell').text(),
                                estiUnitPrice: retainDecimal($(this).find('input[name="estiUnitPrice"]').val(),3),
                                thisAmount: retainDecimal($(this).find('input[name="thisAmount"]').val(),3),
                                thisTotalPrice: $(this).find('input[name="thisTotalPrice"]').val(),
                                usePlace: $(this).find('input[name="usePlace"]').val(),
                                mtlPlanListId: $(this).find('input[name="planMtlName"]').attr('mtlPlanListId'),
                                mtlLibId:$(this).find('[name="planMtlName"]').attr('mtlLibId'), //材料资源库id
                            }
                            oldDataArr.push(oldDataObj);
                        });
                        var addRowData = {
                            //valuationUnit: valuationUnit
                        };
                        oldDataArr.push(addRowData);
                        table.reload('materialDetailsTable', {
                            data: oldDataArr,
                            height: oldDataArr&&oldDataArr.length>5?'full-450':false
                        });
                        break;
                }
            });
            // 内部删行操作
            table.on('tool(materialDetailsTable)', function (obj) {
                var data = obj.data;
                var layEvent = obj.event;
                if (layEvent === 'del') {
                    obj.del();
                    if (data.mtlPlanListId) {
                        $.get('/plbMtlPlanList/deleteByMtlPlanListIds', {mtlPlanListIds: data.mtlPlanListId}, function(res){

                        });
                    }
                    //遍历表格获取每行数据进行保存
                    var $tr = $('.mtl_info').find('.layui-table-main tr');
                    var oldDataArr = [];
                    $tr.each(function () {
                        var oldDataObj = {
                            planMtlName: $(this).find('input[name="planMtlName"]').val(),
                            planMtlStandard: $(this).find('input[name="planMtlStandard"]').val(),
                            valuationUnit: $(this).find('input[name="valuationUnit"]').attr('valuationUnit'),
                            directUnitPrice: $(this).find('[data-field="directUnitPrice"] .layui-table-cell').text(),
                            estiUnitPrice: retainDecimal($(this).find('input[name="estiUnitPrice"]').val(),3),
                            thisAmount: retainDecimal($(this).find('input[name="thisAmount"]').val(),3),
                            thisTotalPrice: $(this).find('input[name="thisTotalPrice"]').val(),
                            usePlace: $(this).find('input[name="usePlace"]').val(),
                            mtlPlanListId: $(this).find('input[name="planMtlName"]').attr('mtlPlanListId'),
                            mtlLibId:$(this).find('[name="planMtlName"]').attr('mtlLibId'), //材料资源库id
                        }
                        oldDataArr.push(oldDataObj);
                    });
                    table.reload('materialDetailsTable', {
                        data: oldDataArr,
                        height: oldDataArr&&oldDataArr.length>5?'full-450':false
                    });

                    //重新计算本次需求计划数量和本次需求计划预计金额
                    var thisAmount=0
                    var planMoney=0
                    $tr.each(function () {
                        thisAmount=accAdd(thisAmount,$(this).find('input[name="thisAmount"]').val())

                        var estiUnitPriceItem=$(this).find('input[name="estiUnitPrice"]').val()
                        var thisAmountItem=$(this).find('input[name="thisAmount"]').val()
                        planMoney=accAdd(planMoney,mul(estiUnitPriceItem,thisAmountItem))
                    });
                    $('#baseForm [name="planAmount"] ').val(thisAmount)
                    $('#baseForm [name="planMoney"] ').val(planMoney)
                }
            });

            // 点击选管理预算
            $(document).on('click', '.chooseManagementBudget', function () {
                var wbsSelectTree = null;
                var cbsSelectTree = null;
                var rbsSelectTree =null;
                layer.open({
                    type: 1,
                    title: '管理目标选择',
                    area: ['80%', '80%'],
                    maxmin: true,
                    btn: ['确定', '取消'],
                    btnAlign: 'c',
                    content: ['<div class="layui-form">' +
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
                    '               </div>' ,
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
                        '       <div style="padding: 10px" class="radioCenter">' +
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
                                if(parentId){
                                    obj.rbsName=parentId;
                                }else {
                                    obj.parentId='1';
                                }

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
                            //var itemNo = $('[name="itemNo"]').val();
                            //var itemName =$('[name="itemName"]').val();

                            laodTable(wbsId, cbsId,rbsId);
                        });

                        // 加载表格
                        function laodTable(wbsId, cbsId,rbsId) {
                            table.render({
                                elem: '#managementBudgetTable',
                                url: '/manageProject/getBudgetByProjId',
                                where: {
                                    projId: $('#leftId').attr('projId'),
                                    rbsTyep:'mtl',
                                    wbsId: wbsId || '',
                                    cbsId: cbsId || '',
                                    rbsId: rbsId || ''
                                    //itemNo: itemNo || '',
                                    //itemName: itemName || '',
                                },
                                cellMinWidth:120,
                                page: true,
                                limit: 20,
                                request: {
                                    limitName: 'pageSize'
                                },
                                // response: {
                                //     statusName: 'flag',
                                //     statusCode: true,
                                //     msgName: 'msg',
                                //     countName: 'totleNum',
                                //     dataName: 'data'
                                // },
                                cols: [[
                                    {type: 'radio', title: '选择'},
                                    {
                                        field: 'wbsName', title: 'WBS',width:200, templet: function(d) {
                                            var str = '';
                                            if (d.plbProjWbs) {
                                                str = d.plbProjWbs.wbsName;
                                            }
                                            return str;
                                        }
                                    },
                                    {
                                        field: 'rbsLongName', title: 'RBS',width:200, templet: function (d) {
                                            var str = '';
                                            if (d.plbRbs) {
                                                str = d.plbRbs.rbsLongName;
                                            }
                                            return str;
                                        }
                                    },
                                    {
                                        field: 'cbsName', title: 'CBS',width:200, templet: function (d) {
                                            var str = '';
                                            if (d.plbCbsTypeWithBLOBs) {
                                                str = d.plbCbsTypeWithBLOBs.cbsName;
                                            }
                                            return str;
                                        }
                                    },
                                    {
                                        field: 'controlType', title: '控制类型', width:100,templet: function (d) {
                                            return dictionaryObj['CONTROL_TYPE']['object'][d.controlType] || '';
                                        }
                                    },
                                    {
                                        field: 'itemUnit', title: '单位',width:100,templet: function (d) {
                                            var str = '';
                                            if (d.plbCbsTypeWithBLOBs) {
                                                str = dictionaryObj['CBS_UNIT']['object'][d.itemUnit] || '';
                                            }
                                            return str;
                                        }
                                    },
                                    {field: 'manageTarNum', title: '管理目标数量',width:120},
                                    {field: 'manageTarPrice', title: '管理目标单价',width:120},
                                    {field: 'manageTarAmount', title: '管理目标总价',width:120},
                                    {field: 'addupNeedAmount', title: '累计已提需求计划量',width:150},
                                    {field: 'addupNeedMoney', title: '累计已提需求计划金额',width:150},
                                    // {field: 'manageSurplusAmount', title: '管理目标数量余额',width:150},
                                    // {field: 'manageSurplusMoney', title: '管理目标金额余额',width:150},
                                ]]
                            });
                        }
                    },
                    yes: function (index) {
                        $('.planNum').hide()
                        $('.planMoney').hide()
                        var checkStatus = table.checkStatus('managementBudgetTable')
                        if (checkStatus.data.length > 0) {
                            var chooseData = checkStatus.data[0];
                            _rbsObj = chooseData.plbRbs;


                            var sum1=chooseData.manageTarNum - chooseData.addupNeedAmount - chooseData.onwayAmount
                            var sum2=chooseData.manageTarAmount - chooseData.addupNeedMoney - chooseData.onwayMoney
                            //判断能否选择管理目标
                            if (chooseData.controlType == '01') {    // 数量控制
                                //当控制方式为数量控制时，管理目标数量-已提需求计划数量-在途需求计划数量>0，否则无法选择到
                                if(sum1 < 0){
                                    layer.msg('需管理目标数量-已提需求计划数量-在途需求计划数量>0，否则无法选择到!', {icon: 0, time: 2000});
                                    return  false
                                }


                                $('.planNum').show()


                                // var _useDate = $('#useDate').val()
                                // var _remark = $('#remark').val()
                                // $('#_one').html(_html)
                                // $('#_two').hide();
                                // laydate.render({
                                //     elem: '#useDate' //指定元素
                                //     , trigger: 'click' //采用click弹出
                                //    // , value: data ? format(data.useDate) : ''
                                // });
                                // $('#useDate').val(_useDate)
                                // $('#remark').val(_remark)
                                //已提需求计划数量
                                var addupNeedAmount = chooseData.addupNeedAmount || 0;
                                $('.plan_base_info input[name="addupNeedAmount"]').val(retainDecimal(addupNeedAmount,3));
                                //在途需求计划数量
                                var onwayAmount = chooseData.onwayAmount || 0;
                                $('.plan_base_info input[name="onwayAmount"]').val(retainDecimal(onwayAmount,3));
                                //剩余可提需求计划数量
                                var surplusAmount = sub(chooseData.manageTarNum,accAdd(addupNeedAmount,onwayAmount)) || 0;
                                $('.plan_base_info input[name="surplusAmount"]').val(retainDecimal(surplusAmount,3));

                            } else if (chooseData.controlType == '02') {  // 金额控制
                                //当控制方式为金额控制时，管理目标金额-已提需求计划金额-在途需求计划金额>0,否则无法选择到
                                if(sum2 < 0){
                                    layer.msg('需管理目标金额-已提需求计划金额-在途需求计划金额>0,否则无法选择到', {icon: 0, time: 2000});
                                    return  false
                                }


                                $('.planMoney').show()

                                // var _useDate = $('#useDate').val()
                                // var _remark = $('#remark').val()
                                // $('#_one').html(_html);
                                // $('#_two').hide();
                                // laydate.render({
                                //     elem: '#useDate' //指定元素
                                //     , trigger: 'click' //采用click弹出
                                //     //, value: data ? format(data.useDate) : ''
                                // });
                                // $('#useDate').val(_useDate)
                                // $('#remark').val(_remark)

                                //已提需求计划金额
                                var addupNeedMoney = chooseData.addupNeedMoney || 0;
                                $('.plan_base_info input[name="addupNeedMoney"]').val(retainDecimal(addupNeedMoney,2));
                                //在途需求计划金额
                                var onwayMoney = chooseData.onwayMoney || 0;
                                $('.plan_base_info input[name="onwayMoney"]').val(retainDecimal(onwayMoney,2));
                                //剩余可提需求计划金额
                                var surplusMoney = accAdd(accAdd(chooseData.manageTarAmount,addupNeedMoney),onwayMoney) || 0;
                                $('.plan_base_info input[name="surplusMoney"]').val(retainDecimal(surplusMoney,2));
                            }else if (chooseData.controlType == '03') {   // 数量+金额控制
                                //当控制方式为数量+金额控制时，管理目标数量-已提需求计划数量-在途需求计划数量>0，且管理目标金额-已提需求计划金额-在途需求计划金额>0,否则无法选择到
                                if(sum1 < 0 && sum2 < 0){
                                    layer.msg('需管理目标数量-已提需求计划数量-在途需求计划数量>0，且管理目标金额-已提需求计划金额-在途需求计划金额>0,否则无法选择到', {icon: 0, time: 2000});
                                    return  false
                                }


                                $('.planNum').show()
                                $('.planMoney').show()

                                // var _useDate = $('#useDate').val()
                                // var _remark = $('#remark').val()
                                // $('#_one').html(_html)
                                // $('#_two').html(_html)
                                // laydate.render({
                                //     elem: '#useDate' //指定元素
                                //     , trigger: 'click' //采用click弹出
                                //     // , value: data ? format(data.useDate) : ''
                                // });
                                // $('#useDate').val(_useDate)
                                // $('#remark').val(_remark)

                                //已提需求计划数量
                                var addupNeedAmount = chooseData.addupNeedAmount || 0;
                                $('.plan_base_info input[name="addupNeedAmount"]').val(retainDecimal(addupNeedAmount,3));
                                //在途需求计划数量
                                var onwayAmount = chooseData.onwayAmount || 0;
                                $('.plan_base_info input[name="onwayAmount"]').val(retainDecimal(onwayAmount,3));
                                //剩余可提需求计划数量
                                var surplusAmount = sub(chooseData.manageTarNum,accAdd(addupNeedAmount,onwayAmount)) || 0;
                                $('.plan_base_info input[name="surplusAmount"]').val(retainDecimal(surplusAmount,3));
                                //已提需求计划金额
                                var addupNeedMoney = chooseData.addupNeedMoney || 0;
                                $('.plan_base_info input[name="addupNeedMoney"]').val(retainDecimal(addupNeedMoney,2));
                                //在途需求计划金额
                                var onwayMoney = chooseData.onwayMoney || 0;
                                $('.plan_base_info input[name="onwayMoney"]').val(retainDecimal(onwayMoney,2));
                                //剩余可提需求计划金额
                                var surplusMoney = accAdd(accAdd(chooseData.manageTarAmount,addupNeedMoney),onwayMoney) || 0;
                                $('.plan_base_info input[name="surplusMoney"]').val(retainDecimal(surplusMoney,2));

                            }


                            $('.plan_base_info input[name="totalManagementTarget"]').attr('budgetItemId', chooseData.budgetItemId);

                            //WBS
                            $('.plan_base_info input[name="wbsId"]').val(chooseData.plbProjWbs ? chooseData.plbProjWbs.wbsName : '');
                            $('.plan_base_info input[name="wbsId"]').attr('wbsId', chooseData.plbProjWbs ? chooseData.plbProjWbs.wbsId : '');
                            //RBS
                            $('.plan_base_info input[name="rbsLongName"]').val(chooseData.plbRbs ? chooseData.plbRbs.rbsLongName : '');
                            $('.plan_base_info input[name="rbsLongName"]').attr('rbsId', chooseData.plbRbs ? chooseData.plbRbs.rbsId : '');
                            //CBS
                            $('.plan_base_info input[name="cbsId"]').val(chooseData.plbCbsTypeWithBLOBs ? chooseData.plbCbsTypeWithBLOBs.cbsName : '');
                            $('.plan_base_info input[name="cbsId"]').attr('cbsId', chooseData.plbCbsTypeWithBLOBs ? chooseData.plbCbsTypeWithBLOBs.cbsId : '');
                            // 单位
                            var valuationUnit = chooseData.itemUnit ? chooseData.itemUnit : '';
                            $('.plan_base_info input[name="valuationUnit"]').val(dictionaryObj['CBS_UNIT']['object'][valuationUnit] || '');
                            $('.plan_base_info input[name="valuationUnit"]').attr('valuationUnit', valuationUnit);
                            //控制方式
                            $('.plan_base_info input[name="controlMode"]').val(dictionaryObj['CONTROL_TYPE']['object'][chooseData.controlType] || '');
                            $('.plan_base_info input[name="controlMode"]').attr('controlMode', chooseData.controlType);
                            //管理目标数量
                            var totalManagementTarget = chooseData.manageTarNum ? chooseData.manageTarNum : '';
                            $('.plan_base_info input[name="totalManagementTarget"]').val(retainDecimal(totalManagementTarget,3));
                            // 管理目标金额
                            var mgeTargetPrice = chooseData.manageTarAmount || '';
                            $('.plan_base_info input[name="mgeTargetPrice"]').val(retainDecimal(mgeTargetPrice,2));
                            //累计入库数量
                            var sumStockinNum = chooseData.sumStockinNum || 0;
                            $('.plan_base_info input[name="sumStockinNum"]').val(retainDecimal(sumStockinNum,3));
                            //累计入库金额
                            var sumStockinAmunt = chooseData.sumStockinAmunt || 0;
                            $('.plan_base_info input[name="sumStockinAmunt"]').val(retainDecimal(sumStockinAmunt,2));

                            layer.close(index);
                        } else {
                            layer.msg('请选择一项！', {icon: 0, time: 2000});
                            return false
                        }
                    }
                });
            });
            // 点击选择材料明细
            $(document).on('click', '.chooseMaterials', function () {
                var _this = $(this);
                layer.open({
                    type: 1,
                    title: '选择材料',
                    area: ['70%', '80%'],
                    maxmin: true,
                    btn: ['确定', '取消'],
                    btnAlign: 'c',
                    content: ['<div class="container">',
                        '<div class="wrapper">',
                        '<div class="wrap_left">' +
                        '<div class="layui-form">' +
                        '<select id="mtlTypeTree" lay-filter="mtlTypeTree"></select>' +
                        '<div class="tree_module" style="top: 48px;">' +
                        '<div id="chooseMtlTree" class="eleTree" lay-filter="chooseMtlTree"></div>' +
                        '</div>' +
                        '</div>' +
                        '</div>',
                        '<div class="wrap_right">' +
                        '<div class="layui-form">' +
                        '<div class="layui-row">' +
                        ' <div class="layui-col-xs4" style="width: 39%">' +
                        '  <div class="layui-form-item" style="margin: 0">' +
                        '  <label class="layui-form-label">材料名称</label>' +
                        '    <div class="layui-input-block">'+
                        '        <input type="text" name="mtlName" class="layui-input">' +
                        '    </div>'+
                        '  </div>'+
                        ' </div>'+
                        ' <div class="layui-col-xs4" style="width: 39%">' +
                        '  <div class="layui-form-item" style="margin: 0">' +
                        '  <label class="layui-form-label">材料规格</label>' +
                        '     <div class="layui-input-block">'+
                        '        <input type="text" name="mtlStandard" class="layui-input">' +
                        '     </div>'+
                        '  </div>'+
                        ' </div>'+
                        ' <div class="layui-col-xs4">' +
                        '<button type="button" id="searchBtn" class="layui-btn" style="height: 34px;line-height: 34px;margin-top: 2px;margin-left: 7px">查询</button>'+
                        ' </div>'+
                        '</div>',
                        '<div class="layui-row">'+
                        '<div class="mtl_table_box">' +
                        '<table id="materialsTable" lay-filter="materialsTable"></table>' +
                        '</div>' +
                        // '<div class="mtl_no_data" style="text-align: center;">' +
                        // '<div class="no_data_img" style="margin-top:12%;">' +
                        // '<img style="margin-top: 2%;" src="/img/noData.png">' +
                        // '</div>' +
                        // '<p style="text-align: center; font-size: 20px; font-weight: normal;">请选择左侧材料</p>' +
                        // '</div>' +
                        '</div>'+
                        '</div>'+
                        '</div>' +
                        '</div>'+
                        '</div>'].join(''),
                    success: function () {
                        // 获取材料类型
                        $.get('/plbDictonary/getTgTypeByDictNo?plbDictNo=MTL_TYPE', function (res) {
                            var str = '<option value="">请选择<option>';
                            if (res.flag && res.obj.length > 0) {
                                res.obj.forEach(function (item) {
                                    str += '<option value="' + item.plbDictNo + '">' + item.dictName + '<option>';
                                });
                            }
                            $('#mtlTypeTree').html(str);
                            form.render();
                        });

                        form.on('select(mtlTypeTree)', function (data) {
                            loadMtlType(data.value);
                        });

                        // 树节点点击事件
                        eleTree.on("nodeClick(chooseMtlTree)", function (d) {
                            var currentData = d.data.currentData;
                            if (currentData.rbsId) {
                                //$('.mtl_no_data').hide();
                                //$('.mtl_table_box').show();
                                loadMtlTable(currentData.rbsId);
                            } else {
                                $('.mtl_table_box').hide();
                                //$('.mtl_no_data').show();
                            }
                        });
                        loadMtlTable();

                        loadMtlType($('.plan_base_info input[name="rbsId"]').attr('rbsId'));
                        $('#searchBtn').click(function(){
                            //var rbsId=$("[name='rbsLongName']").attr("rbsid");
                            var mtlName=$("[name='mtlName']").val();
                            var mtlStandard=$("[name='mtlStandard']").val();
                            var url;
                            if(mtlName==''&&mtlStandard==''){
                                url='/plbMtlLibrary/queryByParentId'
                            }else if(mtlName==''){
                                url='/plbMtlLibrary/queryByParentId?mtlStandard='+mtlStandard+''
                            }else if(mtlStandard==''){
                                url='/plbMtlLibrary/queryByParentId?mtlName='+mtlName+''
                            }else{
                                url='/plbMtlLibrary/queryByParentId?mtlName='+mtlName+'&mtlStandard='+mtlStandard+''
                            }
                            table.reload('materialsTable',{
                                url:url,
                            })
                        })
                        function loadMtlType(mtlType) {
                            mtlType = mtlType ? mtlType : '0';
                            // 获取左侧树
                            //$.get('/plbRbs/selectAll', {parentId: mtlType}, function (res) {
                            //if (res.flag) {
                            var rbsO = [{
                                isFlag:false,
                                rbsName:"材料",
                                childList:[],
                                rbsId:1
                            }]
                            if(_rbsObj&&_rbsObj.rbsId){
                                // $.ajax({
                                //     url:"/plbRbs/selectAll?parentId=0",
                                //     dataType:"json",
                                //     type:"post",
                                //     //async:false,
                                //     success:function(res){
                                //         if(res.flag){


                                eleTree.render({
                                    elem: '#chooseMtlTree',
                                    //url:"/plbRbs/selectAll?parentId=1",
                                    data: rbsO,
                                    highlightCurrent: true,
                                    showLine: true,
                                    defaultExpandAll: false,
                                    lazy: true,
                                    request: {
                                        key: 'rbsId',
                                        name: 'rbsName',
                                        children: "childList",
                                    },
                                    response: {
                                        statusName: 'flag',
                                        statusCode: true,
                                        dataName: "data"
                                    },
                                    load: function (data, callback) {
                                        $.post('/plbRbs/selectAll?parentId='+data.rbsId, function (res) {
                                            callback(res.data);//点击节点回调
                                        })
                                    }
                                    ,done:function(data){
                                        //此处做一个自动定位到某个树下面
                                        // if(openTreeArr!=undefined&&openTreeArr.length>0){
                                        //     var i=openTreeArr.length-1;
                                        //     var haveInt={};
                                        //     var index = setInterval(function(){
                                        //         if(i<0){
                                        //             clearInterval(index);
                                        //         }
                                        //         if(haveInt[i]!=undefined){
                                        //
                                        //         }else{
                                        //             if(i>=0){
                                        //                 if(i==0){
                                        //                     openTree(openTreeArr[i],true)
                                        //                 }else{
                                        //                     openTree(openTreeArr[i],false)
                                        //                 }
                                        //
                                        //             }
                                        //             haveInt[i]=i;
                                        //         }
                                        //         i--;
                                        //     }, 5000);
                                        // }
                                    }
                                    // });
                                    //  }
                                    // }
                                })

                            }else{
                                eleTree.render({
                                    elem: '#chooseMtlTree',
                                    data: rbsO,
                                    highlightCurrent: true,
                                    showLine: true,
                                    defaultExpandAll: false,
                                    lazy: true,
                                    request: {
                                        key: 'rbsId',
                                        name: 'rbsName',
                                        children: "childList",
                                    },
                                    load: function (data, callback) {
                                        $.post('/plbRbs/selectAll?parentId=' + data.rbsId, function (res) {
                                            callback(res.data);//点击节点回调
                                        })
                                    }
                                });
                            }

                            //}
                            //});
                        }

                        function loadMtlTable(mtlLibId) {
                            table.render({
                                elem: '#materialsTable',
                                url: '/plbMtlLibrary/queryByParentId',
                                where: {
                                    rbsId: mtlLibId
                                },
                                page: true,
                                request: {
                                    limitName: 'pageSize' //每页数据量的参数名，默认：limit
                                },
                                response: {
                                    statusName: 'flag',
                                    statusCode: true,
                                    msgName: 'msg',
                                    countName: 'totleNum',
                                    dataName: 'data'
                                },
                                cols: [[
                                    {type: 'radio', title: '选择'},
                                    {field: 'mtlNo', title: '材料编码'},
                                    {field: 'mtlName', title: '材料名称'},
                                    {field: 'mtlStandard', title: '材料规格'},
                                    {
                                        field: 'mtlValuationUnit', title: '计量单位', templet: function (d) {
                                            return dictionaryObj['CBS_UNIT']['object'][d.mtlValuationUnit] || '';
                                        }
                                    },
                                    {field: 'mtlPriceUnit', title: '指导单价'}
                                ]],
                                done:function(d){
                                    this.where._ = new Date().getTime();
                                    // delete this.where.rbsId,
                                    // delete this.where.mtlName,
                                    // delete this.where.mtlStandard
                                }
                            });
                        }
                    },
                    yes: function (index) {
                        var checkStatus = table.checkStatus('materialsTable');
                        if (checkStatus.data.length > 0) {
                            var mtlData = checkStatus.data[0];

                            _this.parents('tr').find('[name="planMtlName"]').val(mtlData.mtlName);
                            _this.parents('tr').find('[name="planMtlStandard"]').val(mtlData.mtlStandard || '');
                            _this.parents('tr').find('[data-field="directUnitPrice"] .layui-table-cell').text(retainDecimal(mtlData.mtlPriceUnit,3));

                            //材料资源库id
                            _this.parents('tr').find('[name="planMtlName"]').attr('mtlLibId',mtlData.mtlLibId);

                            // 判断控制方式是否为数量
                            var controlMode = $('.plan_base_info input[name="controlMode"]').attr('controlMode') || '';
                            if (controlMode != '01') {
                                _this.parents('tr').find('[name="valuationUnit"]').val(dictionaryObj['CBS_UNIT']['object'][mtlData.mtlValuationUnit] || '');
                                _this.parents('tr').find('[name="valuationUnit"]').attr('valuationUnit', mtlData.mtlValuationUnit);
                            }else{
                                var valuationUnit = $('.plan_base_info input[name="valuationUnit"]').attr('valuationUnit') || '';
                                _this.parents('tr').find('[name="valuationUnit"]').val(dictionaryObj['CBS_UNIT']['object'][valuationUnit] || '');
                                _this.parents('tr').find('[name="valuationUnit"]').attr('valuationUnit', valuationUnit);
                            }
                            // var valuationUnit = $('.plan_base_info input[name="valuationUnit"]').attr('valuationUnit') || '';
                            // _this.parents('tr').find('[name="valuationUnit"]').val(dictionaryObj['CBS_UNIT']['object'][valuationUnit] || '');
                            // _this.parents('tr').find('[name="valuationUnit"]').attr('valuationUnit', valuationUnit);
                            layer.close(index);
                        } else {
                            layer.msg('请选择一项！', {icon: 0});
                        }
                    }
                });
            });
            // 点击选择计量单位
            $(document).on('click', '.chooseMtlUnit', function(){
                var $this = $(this);
                var controlMode = $('.plan_base_info input[name="controlMode"]').attr('controlMode') || '';

                if (controlMode != '01') {
                    layer.open({
                        type: 1,
                        title: '选择计量单位',
                        area: ['400px', '400px'],
                        btn: ['确定', '取消'],
                        btnAlign: 'c',
                        content: '<div style="padding: 10px"><table id="chooseMtlUnit" lay-filter="chooseMtlUnit"></table></div>',
                        success: function () {
                            var dataArr = []
                            $.each(dictionaryObj['CBS_UNIT']['object'], function (k, o) {
                                var obj = {
                                    mtlValuationUnit: k,
                                    mtlValuationUnitStr: o
                                }
                                dataArr.push(obj);
                            });
                            table.render({
                                elem: '#chooseMtlUnit',
                                data: dataArr,
                                cols: [[
                                    {type: 'radio', title: '选择'},
                                    {field: 'mtlValuationUnitStr', title: '计量单位'}
                                ]]
                            });
                        },
                        yes: function (index) {
                            var checkStatus = table.checkStatus('chooseMtlUnit');
                            if (checkStatus.data.length > 0) {
                                $this.val(checkStatus.data[0].mtlValuationUnitStr);
                                $this.attr('valuationunit', checkStatus.data[0].mtlValuationUnit);
                                layer.close(index);
                            } else {
                                layer.msg('请选择一项！', {icon: 0});
                            }
                        }
                    });
                }
            });

        });
    }

    //监听本次数量
    $(document).on('blur', '.thisAmountItem', function () {
        if(_disabled&&_disabled=='1'){
            return true
        }

        var $tr = $('.mtl_info').find('.layui-table-main tr');
        var thisAmount=0
        $tr.each(function () {
            thisAmount=accAdd(thisAmount,$(this).find('input[name="thisAmount"]').val())
        });
        $('#baseForm [name="planAmount"] ').val(retainDecimal(thisAmount,3))

        //计算本次需求计划预计金额
        if($(this).val() && $(this).parents('tr').find('[name="estiUnitPrice"]').val()){
            var planMoney=0
            $tr.each(function () {
                var estiUnitPriceItem=$(this).find('input[name="estiUnitPrice"]').val()
                var thisAmountItem=$(this).find('input[name="thisAmount"]').val()
                planMoney=accAdd(planMoney,mul(estiUnitPriceItem,thisAmountItem))
            });
            $('#baseForm [name="planMoney"] ').val(retainDecimal(planMoney,2))

            //计算预计金额
            $(this).parents('tr').find('[name="thisTotalPrice"]').val(retainDecimal(mul($(this).val(),$(this).parents('tr').find('[name="estiUnitPrice"]').val()),2))
        }
    });

    //监听预计单价
    $(document).on('input propertychange', '.estiUnitPriceItem', function () {
        if(_disabled&&_disabled=='1'){
            return true
        }

        var $tr = $('.mtl_info').find('.layui-table-main tr');
        //计算需求计划金额
        if($(this).val() && $(this).parents('tr').find('[name="thisAmount"]').val()){
            var planMoney=0
            $tr.each(function () {
                var estiUnitPriceItem=$(this).find('input[name="estiUnitPrice"]').val()
                var thisAmountItem=$(this).find('input[name="thisAmount"]').val()
                planMoney=accAdd(planMoney,mul(estiUnitPriceItem,thisAmountItem))
            });
            $('#baseForm [name="planMoney"] ').val(retainDecimal(planMoney,2))

            //计算预计金额
            $(this).parents('tr').find('[name="thisTotalPrice"]').val(retainDecimal(mul($(this).val() , $(this).parents('tr').find('[name="thisAmount"]').val()),2))
        }
    });

    function childFunc(){
        if(_disabled&&_disabled=='1'){
            return true
        }
        /* //需求计划金额不得大于剩余可提需求计划金额
                              if(Number($('#baseForm [name="planMoney"]').val()) > Number($('#baseForm [name="surplusMoney"]').val())){
                                  layer.msg('需求计划金额不得大于剩余可提需求计划金额!', {icon: 0, time: 2000});
                                  return  false
                              }*/

        var sum1=$('[name="totalManagementTarget"]').val() - $('[name="addupNeedAmount"]').val() -$('[name="onwayAmount"]').val() -$('[name="planAmount"]').val()
        var sum2=$('[name="mgeTargetPrice"]').val() - $('[name="addupNeedMoney"]').val() -$('[name="onwayMoney"]').val() -$('[name="planMoney"]').val()
        //当控制方式为数量控制时，管理目标数量-已提需求计划数量-在途需求计划数量-本次需求计划量>=0，否则无法提交
        if($('.plan_base_info input[name="controlMode"]').attr('controlMode') == '01' && sum1 < 0){
            layer.msg('需管理目标数量-已提需求计划数量-在途需求计划数量-本次需求计划量>=0，否则无法提交!', {icon: 0, time: 2000});
            return  false
        }
        //当控制方式为金额控制时，管理目标金额-已提需求计划金额-在途需求计划金额-本次需求计划预计金额>=0,否则无法提交
        else if($('.plan_base_info input[name="controlMode"]').attr('controlMode') == '02' && sum2 < 0){
            layer.msg('需管理目标金额-已提需求计划金额-在途需求计划金额-本次需求计划预计金额>=0,否则无法提交!', {icon: 0, time: 2000});
            return  false
        }
        //当控制方式为数量+金额控制时，需同时满足上述两种控制逻辑，否则无法提交
        else if($('.plan_base_info input[name="controlMode"]').attr('controlMode') == '02' && sum1 < 0 && sum2 < 0){
            layer.msg('需管理目标数量-已提需求计划数量-在途需求计划数量-本次需求计划量>=0且管理目标金额-已提需求计划金额-在途需求计划金额-本次需求计划预计金额>=0,否则无法提交!', {icon: 0, time: 2000});
            return  false
        }


        var loadIndex = layer.load();
        //材料计划数据
        var datas = $('#baseForm').serializeArray();
        var obj = {}
        datas.forEach(function (item) {
            obj[item.name] = item.value
        });
        obj.wbsId = $('.plan_base_info input[name="wbsId"]').attr('wbsId') || '';
        obj.rbsId = $('.plan_base_info input[name="rbsId"]').attr('rbsId') || '';
        obj.cbsId = $('.plan_base_info input[name="cbsId"]').attr('cbsId') || '';
        // 控制类型
        obj.controlMode = $('.plan_base_info input[name="controlMode"]').attr('controlMode') || '';
        // 计量单位
        obj.valuationUnit = $('.plan_base_info input[name="valuationUnit"]').attr('valuationUnit') || '';

        obj.budgetItemId = $('.plan_base_info input[name="totalManagementTarget"]').attr('budgetItemId') || '';
        // 附件
        var attachmentId = '';
        var attachmentName = '';
        for (var i = 0; i < $('#fileContent .dech').length; i++) {
            attachmentId += $('#fileContent .dech').eq(i).find('input').val();
            attachmentName += $('#fileContent a').eq(i).attr('name');
        }
        obj.attachmentId = attachmentId;
        obj.attachmentName = attachmentName;
        //材料明细数据
        var $tr = $('.mtl_info').find('.layui-table-main tr');
        var materialDetailsArr = [];
        $tr.each(function () {
            if($(this).find('input[name="thisAmount"]').val() == ''){
                layer.msg('请填写本次数量！', {icon: 0});
                return false
            }
            var materialDetailsObj = {
                planMtlName: $(this).find('input[name="planMtlName"]').val(),
                planMtlStandard: $(this).find('input[name="planMtlStandard"]').val(),
                valuationUnit: $(this).find('input[name="valuationUnit"]').attr('valuationUnit'),
                directUnitPrice: $(this).find('[data-field="directUnitPrice"] .layui-table-cell').text(),
                estiUnitPrice: retainDecimal($(this).find('input[name="estiUnitPrice"]').val(),3),
                thisAmount: retainDecimal($(this).find('input[name="thisAmount"]').val(),3),
                thisTotalPrice: $(this).find('input[name="thisTotalPrice"]').val(),
                usePlace: $(this).find('input[name="usePlace"]').val(),
                mtlPlanListId: $(this).find('input[name="planMtlName"]').attr('mtlPlanListId'),
                mtlLibId:$(this).find('[name="planMtlName"]').attr('mtlLibId'), //材料资源库id
            }
            if ($(this).find('input[name="planMtlName"]').attr('mtlPlanListId')) {
                materialDetailsObj.mtlPlanListId = $(this).find('input[name="planMtlName"]').attr('mtlPlanListId');
            }
            materialDetailsArr.push(materialDetailsObj);
        });
        obj.listWithBLOBS = materialDetailsArr;
        //其他数据
        obj.createTime = $('#createTime').val();
        obj.approvalDate = $('#approvalDate').val();
        obj.auditerDate = $('#auditerDate').val();
        //累计入库数量 累计入库金额
        obj.sumStockinNum=$('[name="sumStockinNum"]').val();
        obj.sumStockinAmunt=$('[name="sumStockinAmunt"]').val();
        //需用日期
        obj.useDate=$('[name="useDate"]').val();
        obj.remark = $('[name="remark"]').val()
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
            layer.close(loadIndex);
            return false;
        }

        if (type == 1) {
            obj.mtlPlanId = $('#htmBox').attr('mtlPlanId');
        }else{
            obj.projId = parseInt($('#htmBox').attr('projId'));
        }

        var _flag = false;
        $.ajax({
            url: "/plbMtlPlan/updateMtlPlan",
            data: JSON.stringify(obj),
            dataType: 'json',
            type: 'post',
            contentType: "application/json;charset=UTF-8",
            success: function (res) {
                layer.close(loadIndex);
                if (res.flag) {
                    layer.msg('保存成功！', {icon: 1});
                    layer.close(index);
                    /*tableIns.config.where._ = new Date().getTime();
                    tableIns.reload();*/
                } else {
                    _flag = true
                    layer.msg('保存失败！', {icon: 2});
                }
            }
        });
        if(_flag){
            return false;
        }
        return true;
    }

</script>
</html>
