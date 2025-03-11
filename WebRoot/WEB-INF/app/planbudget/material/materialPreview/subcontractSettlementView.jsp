<%--
  Created by IntelliJ IDEA.
  User: dongke
  Date: 2021/8/12
  Time: 16:19
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<head>
    <title>分包结算预览</title>

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
    <script type="text/javascript" src="/js/planbudget/common.js"></script>
    <script src="../js/jquery/jquery.cookie.js"></script>

    <script type="text/javascript" src="/js/planother/planotherUtil.js?22120210604.11"></script>
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
        .refresh_no_btn {
            display: none;
            margin-left: 2%;
            color: #00c4ff !important;
            font-weight: 600;
            cursor: pointer;
        }
        .layui-col-xs4{
            width: 20%;
        }
    </style>
</head>
<body>
      <div class="container" id="htmBox"></div>
      <script type="text/html" id="toolbarDemoIn">
          <div class="layui-btn-container" style="height: 30px;">
              <button class="layui-btn layui-btn-sm addRow" lay-event="add">加行</button>
          </div>
      </script>
      <script type="text/html" id="barDemo">
          <a class="layui-btn layui-btn-danger layui-btn-xs" lay-event="del">删行</a>
      </script>
      <script>
       function getUrlParam(name){
           var reg = new RegExp(name +"=(.*?)((?=&|$))"); //构造一个含有目标参数的正则表达式对象
           var r = window.location.href.match(reg); //匹配目标参数
           if (r!=null) return unescape(r[1]); return null; //返回参数值
       }
       var runId=getUrlParam("runId");
       var disabled=getUrlParam("disabled");
       var htm='<div class="layui-collapse">\n'+
           '  <div class="layui-colla-item">\n' +
           '    <h2 class="layui-colla-title">分包结算</h2>\n' +
       '    <div class="layui-colla-content layui-show plan_base_info">' +
       '       <form class="layui-form" id="baseForm" lay-filter="baseForm">'+
       '           <div class="layui-row">' +
       '               <div class="layui-col-xs4" style="padding: 0 5px;">' +
       '                   <div class="layui-form-item">\n' +
       '                       <label class="layui-form-label form_label">分包结算编号<span class="field_required">*</span><a title="刷新编号" class="refresh_no_btn"><i class="layui-icon layui-icon-refresh"></i></a></label>\n' +
       '                       <div class="layui-input-block form_block">\n' +
       '                       <input type="text" name="subsettleup" readonly autocomplete="off" class="layui-input testNull" style="background: #e7e7e7" title="合同编号">\n' +
       '                       </div>\n' +
       '                   </div>' +
       '               </div>' +
       '               <div class="layui-col-xs4" style="padding: 0 5px;">' +
       '                   <div class="layui-form-item">\n' +
       '                       <label class="layui-form-label form_label">项目名称<span class="field_required">*</span></label>\n' +
       '                       <div class="layui-input-block form_block">\n' +
       '                       <input type="text" name="projName" readonly style="cursor: pointer;background: #ffffff" autocomplete="off" class="layui-input" title="项目名称">\n' +
       '                       </div>\n' +
       '                   </div>' +
       '               </div>' +
       '               <div class="layui-col-xs4" style="padding: 0 5px;">' +
       '                   <div class="layui-form-item">\n' +
       '                       <label class="layui-form-label form_label">分包商<span class="field_required">*</span></label>\n' +
       '                       <div class="layui-input-block form_block">\n' +
       '                       <input type="text" name="customerName" readonly style="cursor: pointer;background: #e7e7e7" autocomplete="off" class="layui-input chen chooseCustomerName" title="客商单位名称">\n' +
       '                       </div>\n' +
       '                   </div>' +
       '               </div>' +
       '               <div class="layui-col-xs4" style="padding: 0 5px;">' +
       '                   <div class="layui-form-item">\n' +
       '                       <label class="layui-form-label form_label">合同名称</label>\n' +
       '                       <div class="layui-input-block form_block">\n' +
       '<i style="position: absolute;top: 8px;right: 5px;" class="layui-icon layui-icon-search"></i>  ' +
       '                       <input type="text" name="contractName" placeholder="查找分包合同" readonly autocomplete="off" class="layui-input chooseManagementBudget" style="padding-right: 25px;background:#e7e7e7;cursor: pointer;">\n' +
       '                       </div>\n' +
       '                   </div>' +
       '               </div>' +
       '               <div class="layui-col-xs4" style="padding: 0 5px;">' +
       '                   <div class="layui-form-item">\n' +
       '                       <label class="layui-form-label form_label">合同金额<span class="field_required">*</span></label>\n' +
       '                       <div class="layui-input-block form_block">\n' +
       '                       <input type="number" name="contractFee" readonly style="background: #e7e7e7"  autocomplete="off" class="layui-input chen chinese" title="合同金额">\n' +
       '                       </div>\n' +
       '                   </div>' +
       '               </div>' +
       '           </div>'+
       '           <div class="layui-row">' +
       '               <div class="layui-col-xs4" style="padding: 0 5px;">' +
       '                   <div class="layui-form-item">\n' +
       '                       <label class="layui-form-label form_label">累计已结算金额</label>\n' +
       '                       <div class="layui-input-block form_block">\n' +
       '                       <input type="text"  name="subsettleupMoney" readonly style="background: #e7e7e7" autocomplete="off" class="layui-input">\n' +
       '                       </div>\n' +
       '                   </div>' +
       '               </div>' +
       '               <div class="layui-col-xs4" style="padding: 0 5px;">' +
       '                   <div class="layui-form-item">\n' +
       '                       <label class="layui-form-label form_label">在途结算金额</label>\n' +
       '                       <div class="layui-input-block form_block">\n' +
       '                       <input type="text" name="settleupMoney" readonly style="background: #e7e7e7" autocomplete="off" class="layui-input chinese" title="本次结算金额">\n' +
       '                       </div>\n' +
       '                   </div>' +
       '               </div>' +
       '               <div class="layui-col-xs4" style="padding: 0 5px;">' +
       '                   <div class="layui-form-item">\n' +
       '                       <label class="layui-form-label form_label">本次结算金额</label>\n' +
       '                       <div class="layui-input-block form_block">\n' +
       '                       <input type="text" name="settleupMoney" readonly style="background: #e7e7e7" autocomplete="off" class="layui-input chinese" title="本次结算金额">\n' +
       '                       </div>\n' +
       '                   </div>' +
       '               </div>' +
       '               <div class="layui-col-xs4" style="padding: 0 5px;">' +
       '                   <div class="layui-form-item">\n' +
       '                       <label class="layui-form-label form_label">结算日期<span class="field_required">*</span></label>\n' +
       '                       <div class="layui-input-block form_block">\n' +
       '                       <input type="text" name="settleupDate" readonly id="settleupDate" autocomplete="off" class="layui-input chen" title="结算日期">\n' +
       '                       </div>\n' +
       '                   </div>' +
       '               </div>' +
       '               <div class="layui-col-xs4" style="padding: 0 5px;">' +
       '                   <div class="layui-form-item">\n' +
       '                       <label class="layui-form-label form_label">备注</label>\n' +
       '                       <div class="layui-input-block form_block">\n' +
       '                       <input type="text" name="remark" autocomplete="off" class="layui-input">\n' +
       '                       </div>\n' +
       '                   </div>' +
       '               </div>' +
       '           </div>' +
       '           <div class="layui-row">' +
       '               <div class="layui-col-xs4" style="padding: 0 5px;">' +
       '                   <div class="layui-form-item">\n' +
       '                       <label class="layui-form-label form_label">结算年</label>\n' +
       '                       <div class="layui-input-block form_block">\n' +
       '                       <input type="text" id="settleupYear" name="settleupYear" autocomplete="off" class="layui-input">\n' +
       '                       </div>\n' +
       '                   </div>' +
       '               </div>' +
       '               <div class="layui-col-xs4" style="padding: 0 5px;">' +
       '                   <div class="layui-form-item">\n' +
       '                       <label class="layui-form-label form_label">结算季</label>\n' +
       '                       <div class="layui-input-block form_block">\n' +
       '                           <select name="settleupQuarter"><option value="1">1</option><option value="2">2</option><option value="3">3</option><option value="4">4</option></select>' +
       '                       </div>\n' +
       '                   </div>' +
       '               </div>' +
       '               <div class="layui-col-xs4" style="padding: 0 5px;">' +
       '                   <div class="layui-form-item">\n' +
       '                       <label class="layui-form-label form_label">结算月</label>\n' +
       '                       <div class="layui-input-block form_block">\n' +
       '                           <select name="settleupMonth">' +
       '                               <option value="1">1</option><option value="2">2</option><option value="3">3</option><option value="4">4</option>' +
       '                               <option value="5">5</option><option value="6">6</option><option value="7">7</option><option value="8">8</option>' +
       '                               <option value="9">9</option><option value="10">10</option><option value="11">11</option><option value="12">12</option>' +
       '                           </select>' +
       '                       </div>\n' +
       '                   </div>' +
       '               </div>' +
       '           </div>' +
       '           <div class="layui-row">' +
       '               <div class="layui-col-xs12" style="padding: 0 5px;">' +
       '                   <div class="layui-form-item">\n' +
       '                       <label class="layui-form-label form_label">结算合同附件</label>' +
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
       '           </div>'+
           /* endregion */
       '       </form>' +
       '    </div>\n' +
       '  </div>\n'+
           /* endregion */
           /* region 分包结算明细 */
       '  <div class="layui-colla-item">\n' +
       '    <h2 class="layui-colla-title">分包结算明细</h2>\n' +
       '    <div class="layui-colla-content mtl_info layui-show">' +
       '       <div>' +
       '           <table id="materialDetailsTable" lay-filter="materialDetailsTable"></table>' +
       '      </div>' +
       '    </div>\n' +
       '  </div>\n'+
           /* endregion */
           '</div>'
       $("#htmBox").html(htm);
       var dictionaryObj = {
           CONTROL_MODE: {},
           CBS_UNIT: {},
           CONTRACT_TYPE: {},
       }
       var dictionaryStr = 'CONTROL_MODE,CBS_UNIT,CONTRACT_TYPE';
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
       var runIdData;
       $.ajax({
           url:'/plbMtlSubsettleup/selectByRunId?runId='+runId,
           async:false,
           success:function(res){
               runIdData=res.object
           }
       })
       layui.use(['form','table','eleTree'],function(){
           var form=layui.form;
           var table=layui.table;
           var eleTree=layui.eleTree;
           form.val('baseForm',runIdData);
           $("[name='customerName']").attr("customerid",runIdData.customerId)
           $("[name='contractName']").attr("subcontractid",runIdData.subcontractId);
           $.ajax({
               //项目名称赋值
               url:'/technicalManager/getProjInfoById?projectId='+runIdData.projId,
               async:false,
               success:function(res){
                   $("[name='projName']").val(res.obj.projName)
               }
           })
           $.ajaxSettings.async = false;
           $.get('/plbMtlSubcontract/queryId',{subContractId:runIdData.subcontractId},function (res) {
               $('.plan_base_info input[name="contractName"]').val(res.object.contractName);
               $('.plan_base_info input[name="contractName"]').data('data', res.object.plbMtlSubcontractOuts);
           })
           $.ajaxSettings.async = true;
           //附件回显
           if (runIdData.attachments && runIdData.attachments.length > 0) {

               var fileArr = runIdData.attachments;
               $('#fileContent').append(echoAttachment(fileArr));
           }
           fileuploadFn('#fileupload', $('#fileContent'));
           var detailsCols=[
               {type: 'numbers', title: '序号'},
               {
                   field: 'wbsName', title: 'WBS', width: 200,templet:function(d){
                       return '<span class="subcontractOutId" subcontractOutId="' + (d.subcontractOutId || '') + '">' + d.wbsName + '</span>'
                   }
               },
               {
                   field: 'rbsName', title: 'RBS', width: 200,
               },
               {
                   field: 'cbsName', title: 'CBS', width: 200,
               },
               {
                   field: 'contractOtherContent', title: '合同明细',minWidth:100
               },
               {
                   field: 'contractPrice', title: '合同金额',minWidth: 100
               },
               {
                   field: 'conSettleupMoney', title: '累计结算金额',minWidth: 100
               },
               {
                   field: 'settleupMoney', title: '本次结算金额',minWidth:100, templet: function (d) {
                       return '<input type="text" '+(type==4 ? 'readonly' : '')+' cbsId="'+(d.cbsId || '')+'" wbsId="'+(d.wbsId || '')+'" subSettleupLisId="'+(d.subsettleupLisId || '')+'" name="settleupMoney" class="layui-input settleupMoneyItem" style="height: 100%;" value="' + (d.settleupMoney || '') + '">'
                   }
               },
               {
                   field: 'remark', title: '备注',minWidth:100, templet: function (d) {
                       return '<input type="text" '+(type==4 ? 'readonly' : '')+' name="remark" class="layui-input" style="height: 100%;" subSettleupLisId="'+(d.subsettleupLisId || '')+'" cbsId="'+(d.cbsId || '')+'" value="' + (d.remark || '') + '">'
                   }
               },
               {align: 'center', toolbar: '#barDemo', title: '操作', width: 100}
           ]
           //判断不可编辑
           if(disabled=="1"){
               $('input').attr('disabled',true);
               $("select").attr('disabled',true);
               $('.open_file').hide();
                detailsCols=[
                   {type: 'numbers', title: '序号'},
                   {
                       field: 'wbsName', title: 'WBS', width: 200,templet:function(d){
                           return '<span class="subcontractOutId" subcontractOutId="' + (d.subcontractOutId || '') + '">' + d.wbsName + '</span>'
                       }
                   },
                   {
                       field: 'rbsName', title: 'RBS', width: 200,
                   },
                   {
                       field: 'cbsName', title: 'CBS', width: 200,
                   },
                   {
                       field: 'contractOtherContent', title: '合同明细',minWidth:100
                   },
                   {
                       field: 'contractPrice', title: '合同金额',minWidth: 100
                   },
                   {
                       field: 'conSettleupMoney', title: '累计结算金额',minWidth: 100
                   },
                   {
                       field: 'settleupMoney', title: '本次结算金额',minWidth:100, templet: function (d) {
                           return '<input type="text" '+(type==4 ? 'readonly' : '')+' cbsId="'+(d.cbsId || '')+'" wbsId="'+(d.wbsId || '')+'" subSettleupLisId="'+(d.subsettleupLisId || '')+'" name="settleupMoney" class="layui-input settleupMoneyItem" style="height: 100%;" value="' + (d.settleupMoney || '') + '">'
                       }
                   },
                   {
                       field: 'remark', title: '备注',minWidth:100, templet: function (d) {
                           return '<input type="text" '+(type==4 ? 'readonly' : '')+' name="remark" class="layui-input" style="height: 100%;" subSettleupLisId="'+(d.subsettleupLisId || '')+'" cbsId="'+(d.cbsId || '')+'" value="' + (d.remark || '') + '">'
                       }
                   },
               ]
               form.render();
           }

           var  materialDetailsTableData=runIdData.plbMtlSubsettleupListWithBLOBs[0]
           //分包结算明细表
           table.render({
               elem:'#materialDetailsTable',
               data:[materialDetailsTableData],
               toolbar:('0'!=disabled) ? false : '#toolbarDemoIn',
               cols:[detailsCols],
               defaultToolbar: [''],
               limit: 1000,
           })
           // 内部加行按钮
           table.on('toolbar(materialDetailsTable)', function (obj) {
               switch (obj.event) {
                   case 'add':
                       // 判断分包合同
                       var subcontractId = $('.plan_base_info input[name="contractName"]').attr('subcontractId') || '';

                       if (!subcontractId) {
                           layer.msg('请选择分包合同', {icon: 0, time: 1500});
                           return false;
                       }
                       layer.open({
                           type: 1,
                           title: '选择',
                           area: ['70%', '60%'],
                           btnAlign: 'c',
                           btn: ['确定', '取消'],
                           content: ['<div class="layui-form">' +
                           //表格数据
                           '       <div style="padding: 10px">' +
                           '           <table id="mtlPlanIdTable" lay-filter="mtlPlanIdTable"></table>' +
                           '      </div>' +
                           '</div>'].join(''),
                           success: function () {
                               table.render({
                                   elem: '#mtlPlanIdTable',
                                   data:$('.plan_base_info input[name="contractName"]').data('data'),
                                   limit: 1000,
                                   cols: [[
                                       {type: 'radio', title: '选择'},
                                       {field: 'wbsName', title: 'WBS', width: 200,templet:function(d){
                                               return '<span class="subcontractOutId" subcontractOutId="' + (d.subcontractOutId || '') + '">' + d.wbsName + '</span>'
                                           }
                                       },
                                       {field:'rbsName',title:'RBS',width:200},
                                       {field: 'cbsName', title: 'CBS', width: 200,},
                                       {field: 'contractPrice', title: '合同金额',minWidth:100},
                                       {field:'contractOtherContent',title:'合同明细',minWidth:100},
                                       {
                                           field: 'settleupMoney', title: '累计结算金额',minWidth:100,templet: function (d) {
                                               return d.settleupMoney || 0
                                           }
                                       },
                                   ]]
                               });
                           },
                           yes: function (index) {
                               var checkStatus = table.checkStatus('mtlPlanIdTable')
                               if (checkStatus.data.length > 0) {
                                   var chooseData = checkStatus.data[0];

                                   //遍历表格获取每行数据进行保存
                                   var $tr = $('.mtl_info').find('.layui-table-main tr');
                                   var oldDataArr = [];
                                   $tr.each(function () {
                                       var oldDataObj = {
                                           contractPrice: $(this).find('[data-field="contractPrice"] .layui-table-cell').text(),
                                           conSettleupMoney: $(this).find('[data-field="conSettleupMoney"] .layui-table-cell').text(),
                                           settleupMoney: $(this).find('[name="settleupMoney"]').val(),
                                           remark: $(this).find('[name="remark"]').val(),
                                           // leasesettleupListId: $(this).find('[name="remark"]').attr('leasesettleupListId'),
                                           cbsName: $(this).find('[data-field="cbsName"] .layui-table-cell').text(),
                                           cbsId: $(this).find('[name="settleupMoney"]').attr('cbsId'),
                                           subSettleupLisId: $(this).find('[name="remark"]').attr('subSettleupLisId'),
                                           wbsName: $(this).find('[data-field="wbsName"] .layui-table-cell').text(),
                                           wbsId: $(this).find('[name="settleupMoney"]').attr('wbsId'),
                                           subcontractOutId:$(this).find('.subcontractOutId').attr('subcontractOutId')
                                       }
                                       oldDataArr.push(oldDataObj);
                                   });
                                   var addRowData = {
                                       cbsName: chooseData.cbsName,
                                       cbsId: chooseData.cbsId,
                                       rbsName:chooseData.rbsName,
                                       wbsName: chooseData.wbsName,
                                       wbsId: chooseData.wbsId,
                                       contractOtherContent:chooseData.contractOtherContent,
                                       contractPrice: chooseData.contractPrice,
                                       conSettleupMoney: chooseData.settleupMoney || 0,
                                       subcontractOutId:chooseData.subcontractOutId,
                                   };
                                   oldDataArr.push(addRowData);
                                   table.reload('materialDetailsTable', {
                                       data: oldDataArr
                                   });

                                   layer.close(index);
                               } else {
                                   layer.msg('请选择一项！', {icon: 0, time: 2000});
                               }
                           }
                       });
                       break;
               }
           });
           // 内部删行操作
           table.on('tool(materialDetailsTable)', function (obj) {
               var data = obj.data
               var layEvent = obj.event;
               if (layEvent === 'del') {
                   obj.del();
                   if (data.subsettleupLisId) {
                       $.get('/plbMtlSubsettleup/delPlbMtlSubsettleupList', {subSettleupLisIds: data.subsettleupLisId}, function (res) {

                       });
                   }
                   //遍历表格获取每行数据进行保存
                   var $tr = $('.mtl_info').find('.layui-table-main tr');
                   var oldDataArr = [];
                   $tr.each(function () {
                       var oldDataObj = {
                           contractPrice: $(this).find('[data-field="contractPrice"] .layui-table-cell').text(),
                           conSettleupMoney: $(this).find('[data-field="settleupMoney"] .layui-table-cell').text(),
                           settleupMoney: $(this).find('[name="settleupMoney"]').val(),
                           remark: $(this).find('[name="remark"]').val(),
                           // leasesettleupListId: $(this).find('[name="remark"]').attr('leasesettleupListId'),
                           cbsName: $(this).find('[data-field="cbsName"] .layui-table-cell').text(),
                           cbsId: $(this).find('[name="settleupMoney"]').attr('cbsId'),
                           subsettleupLisId: $(this).find('[name="remark"]').attr('subsettleuplisid'),
                           wbsName: $(this).find('[data-field="wbsName"] .layui-table-cell').text(),
                           wbsId: $(this).find('[name="settleupMoney"]').attr('wbsId'),
                       }
                       oldDataArr.push(oldDataObj);
                   });
                   table.reload('materialDetailsTable', {
                       data: oldDataArr
                   });
               }
           });
           //选择客商单位名称
           $(document).on('click', '.chooseCustomerName', function () {
               var _this = $(this);
               layer.open({
                   type: 1,
                   title: '选择分包商',
                   area: ['70%', '80%'],
                   maxmin: true,
                   btn: ['确定', '取消'],
                   btnAlign: 'c',
                   content: ['<div class="container">',
                       '<div class="wrapper">',
                       '<div class="wrap_left">' +
                       '<div class="layui-form">' +
                       '<select id="mtlTypeTree" lay-filter="mtlTypeTree"></select>' +
                       '<div class="tree_module" style="top: 10px;">' +
                       '<div id="chooseMtlTree" class="eleTree" lay-filter="chooseMtlTree"></div>' +
                       '</div>' +
                       '</div>' +
                       '</div>',
                       '<div class="wrap_right">' +
                       '<div class="mtl_table_box" style="display: none;">' +
                       '<table id="materialsTable" lay-filter="materialsTable"></table>' +
                       '</div>' +
                       '<div class="mtl_no_data" style="text-align: center;">' +
                       '<div class="no_data_img">' +
                       '<img style="margin-top: 12%;" src="/img/noData.png">' +
                       '</div>' +
                       '<p style="text-align: center; font-size: 20px; font-weight: normal;">请选择左侧单位</p>' +
                       '</div>' +
                       '</div>',
                       '</div></div>'].join(''),
                   success: function () {
                       // 树节点点击事件
                       eleTree.on("nodeClick(chooseMtlTree)", function (d) {
                           var currentData = d.data.currentData;
                           if (currentData.typeNo) {
                               $('.mtl_no_data').hide();
                               $('.mtl_table_box').show();
                               loadMtlTable(currentData.typeNo);
                           } else {
                               $('.mtl_table_box').hide();
                               $('.mtl_no_data').show();
                           }
                       });

                       loadMtlType();

                       function loadMtlType(typeNo) {
                           typeNo = typeNo ? typeNo : '';
                           // 获取左侧树
                           $.get('/PlbCustomerType/treeList', function (res) {
                               if (res.flag) {
                                   eleTree.render({
                                       elem: '#chooseMtlTree',
                                       data: res.data,
                                       highlightCurrent: true,
                                       showLine: true,
                                       defaultExpandAll: false,
                                       request: {
                                           name: "typeName", // 显示的内容
                                           key: "typeNo", // 节点id
                                           parentId: 'parentTypeId', // 节点父id
                                           isLeaf: "isLeaf",// 是否有子节点
                                           children: 'child',
                                       }
                                   });
                               }
                           });
                       }

                       function loadMtlTable(typeNo) {
                           table.render({
                               elem: '#materialsTable',
                               url: '/PlbCustomer/getDataByCondition',
                               where: {
                                   merchantType:typeNo,
                                   useFlag: true
                               },
                               page: true, //开启分页
                               limit: 50,
                               height: 'full-180'
                               , toolbar: '#toolbar'
                               , defaultToolbar: ['']
                               ,
                               cols: [[ //表头
                                   {type: 'radio'}
                                   , {field: 'customerNo', title: '客商编号', sort: true, width: 200}
                                   , {field: 'customerName', title: '客商单位名称',}
                                   , {field: 'customerShortName', title: '客商单位简称',}
                                   , {field: 'customerOrgCode', title: '组织机构代码'}
                                   , {field: 'taxNumber', title: '税务登记号'}
                                   , {field: 'accountNumber', title: '开户行账户'}
                               ]], parseData: function (res) {
                                   return {
                                       "code": 0, //解析接口状态
                                       "data": res.data,//解析数据列表
                                       "count": res.totleNum, //解析数据长度
                                   };
                               },
                               request: {
                                   pageName: 'page' //页码的参数名称，默认：page
                                   , limitName: 'pageSize' //每页数据量的参数名，默认：limit
                               },
                           });
                       }
                   },
                   yes: function (index) {
                       var checkStatus = table.checkStatus('materialsTable');
                       if (checkStatus.data.length > 0) {
                           var mtlData = checkStatus.data[0];
                           _this.val(mtlData.customerName);
                           _this.attr('customerId',mtlData.customerId);


                           layer.close(index);
                       } else {
                           layer.msg('请选择一项！', {icon: 0});
                       }
                   }
               });
           });
           // 点击选分包合同
           $(document).on('click', '.chooseManagementBudget', function () {
               if(!$('#baseForm [name="customerName"]').attr('customerId')){
                   layer.msg('请先选择客商单位名称！', {icon: 0, time: 2000});
                   return false
               }
               layer.open({
                   type: 1,
                   title: '选择分包合同',
                   area: ['70%', '60%'],
                   maxmin: true,
                   btnAlign:'c',
                   btn: ['确定', '取消'],
                   content: ['<div class="layui-form">' +
                   //表格数据
                   '       <div style="padding: 10px">' +
                   '           <table id="mtlPlanIdTable" lay-filter="mtlPlanIdTable"></table>' +
                   '      </div>' +
                   '</div>'].join(''),
                   success: function () {
                       table.render({
                           elem: '#mtlPlanIdTable',
                           url: '/plbMtlSubcontract/selectAll',
                           where:{projId:runIdData.projId,customerId:$('#baseForm [name="customerName"]').attr('customerId')},
                           page:true,
                           cols: [[
                               {type: 'radio', title: '选择'},
                               {field: 'contractName', title: '合同名称', width: 200,},
                               {field: 'contractType', title: '合同类型',templet: function (d) {
                                       return dictionaryObj['CONTRACT_TYPE']['object'][d.contractType] || ''
                                   }},
                               {
                                   field: 'contractPeriod', title: '合同工期',
                               },
                               {field: 'customerName', title: '乙方',},
                               {field: 'contractMoney', title: '合同金额',},
                               {field: 'subcontractNo', title: '合同编号',},
                               {field: 'settleupMoney', title: '累计已结算金额',templet: function (d) {
                                       return d.settleupMoney || 0
                                   }},
                           ]],
                           parseData: function(res){ //res 即为原始返回的数据
                               return {
                                   "code": 0, //解析接口状态
                                   "count": res.totleNum, //解析数据长度
                                   "data": res.obj //解析数据列表
                               };
                           }
                       });
                   },
                   yes: function (index) {
                       var checkStatus = table.checkStatus('mtlPlanIdTable')
                       if (checkStatus.data.length > 0) {
                           var chooseData = checkStatus.data[0];
                           $('#baseForm [name="contractName"]').val(chooseData.contractName)
                           $('#baseForm [name="contractName"]').attr('subcontractId',chooseData.subcontractId)
                           $('#baseForm [name="contractName"]').data('data',chooseData.plbMtlSubcontractOuts)

                           //合同金额
                           $('#baseForm [name="contractFee"]').val(chooseData.contractMoney)

                           //累计已结算金额
                           $('#baseForm [name="subsettleupMoney"]').val(chooseData.settleupMoney || 0)

                           layer.close(index);
                       } else {
                           layer.msg('请选择一项！', {icon: 0, time: 2000});
                       }
                   }
               });
           });


       })
       function childFunc() {
           if('0'!=disabled){
               return false
           }
           var loadIndex = layer.load();
           //合同结算数据
           var datas = $('#baseForm').serializeArray();
           var obj = {}
           datas.forEach(function (item) {
               obj[item.name] = item.value;
           });
           obj.projectId=runIdData.projId;
           obj.customerid= $("[name='customerName']").attr("customerid");
           obj.subcontractid= $("[name='contractName']").attr("subcontractid");
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
           var $trs = $('.mtl_info').find('.layui-table-main tr');
           var materialDetailsArr = [];
           $trs.each(function(index,element){
               var dataObj={
                   contractPrice: $(this).find('[data-field="contractPrice"] .layui-table-cell').text(),
                   conSettleupMoney: $(this).find('[data-field="conSettleupMoney"] .layui-table-cell').text(),
                   settleupMoney: $(this).find('[name="settleupMoney"]').val(),
                   remark: $(this).find('[name="remark"]').val(),
                   cbsName: $(this).find('[data-field="cbsName"] .layui-table-cell').text(),
                   cbsId: $(this).find('[name="settleupMoney"]').attr('cbsId'),
                   subSettleupLisId: $(this).find('[name="remark"]').attr('subsettleuplisid'),
                   wbsName: $(this).find('[data-field="wbsName"] .layui-table-cell').text(),
                   wbsId: $(this).find('[name="settleupMoney"]').attr('wbsId'),
                   rbsName:$(this).find('[data-field="rbsName"] .layui-table-cell').text(),
                   contractOtherContent:$(this).find('[data-field="contractOtherContent"] .layui-table-cell').text(),
                   subcontractOutId:$(this).find('.subcontractOutId').attr('subcontractOutId'),
               }
               materialDetailsArr.push(dataObj);
           })
           obj.plbMtlSubsettleupListWithBLOBs = materialDetailsArr;
           obj.projId = parseInt(runIdData.projId);
           if (requiredFlag) {
               layer.close(loadIndex);
               return false;
           }
           var _flag = false;

           $.ajax({
               url: '/plbMtlSubsettleup/updatePlbMtlSubsettleup',
               data: JSON.stringify(obj),
               dataType: 'json',
               contentType: "application/json;charset=UTF-8",
               type: 'post',
               success: function (res) {
                   layer.close(loadIndex);
                   if (res.flag) {
                       layer.msg('保存成功！', {icon: 1});
                       layer.close(index);
                       tableIns.config.where._ = new Date().getTime();
                       tableIns.reload();
                   } else {
                       layer.msg('保存失败！', {icon: 2});
                       _flag = true;
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
