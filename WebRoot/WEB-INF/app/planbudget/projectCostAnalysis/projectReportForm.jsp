<%--
  Created by IntelliJ IDEA.
  User: 戎成路
  Date: 2021/2/3
  Time: 16:38
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
    <title>材料入库台账</title>

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
    <script type="text/javascript" src="/js/planbudget/projectCostAnalysis.js"></script>
    <style>
        html, body {
            width: 100%;
            height: 100%;
            background: #fff;
        }

       /* .layui-table-header,.layui-table-header,.layui-table-box,.layui-table-body,.layui-table-main{
            overflow: visible;
        }*/

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
        /*.layui-table-box{*/
        /*    overflow: scroll;*/
        /*}*/
        /*.layui-table-header{*/
        /*    overflow: initial;*/
        /*}*/

    </style>
</head>
<body>
<div class="container">
    <input type="hidden" id="leftId" class="layui-input">
    <div class="wrapper">
        <div class="wrap_left">
            <h2 id="h2Html" style="text-align: center;line-height: 35px;"></h2>
            <div class="left_form">
                <div class="search_icon">
                    <i class="layui-icon layui-icon-search"></i>
                </div>
                <input type="text" name="title" id="search_project" placeholder="项目名称" autocomplete="off" class="layui-input"/>
            </div>
            <div class="tree_module">
                <div id="leftTree" class="eleTree" lay-filter="leftTree"></div>
            </div>
        </div>
        <div class="wrap_right" style="margin-top: 10px">
            <div class="query_module layui-form layui-row" id="headerRow" style="position: relative;margin-top: 2px">
                <div class="layui-col-xs1" style="margin-top: 3px;text-align: center;width: 5%;float: right">
                    <i class="layui-icon layui-icon-screen-full screen-full" title="全屏" style="font-size: 33px;cursor: pointer;"></i>
                </div>
               <%-- <div style="position: absolute;top: -1px;right: 10px;height: 35px;line-height: 35px;">
                    <i class="layui-icon layui-icon-read icon_img" style="margin-right: 15px" text="知识库"></i>
                    <i class="layui-icon layui-icon-survey icon_img" text="帮助"></i>
                </div>--%>
            </div>
            <div style="position: relative;margin-top: 10px">
                <div class="table_box">
                    <table id="tableObj" lay-filter="parse-table-demo" class="layui-table"  style="display: none" >
                        <%--<thead id="thOneRow" style="display: none">
                            <tr id="thOneRowOneTr">

                            </tr>
                            <tr id="thOneRowTowTr">

                            </tr>
                        </thead>--%>
                        <thead id="thTwoRow" style="display: none">
                            <tr id="thTwoRowOneTr">

                            </tr>
                        </thead>
                    </table>
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
    <button class="layui-btn layui-btn-sm" lay-event="export">导出</button>
</script>
<script>
    var user_id = '';
    var dept_id = '';
    var projectIds = '';
    var form
    var insTb
    var tipIndex = null
    var headerInp;//头部搜索标签
    var colsObj;//表头
    var tableUrl;//渲染表格接口
    $('.icon_img').hover(function () {
        var tip = $(this).attr('text');
        tipIndex = layer.tips(tip, this);
    }, function () {
        layer.close(tipIndex);
    });



    var TableUIObj = new TableUI('plb_proj_wbs');

    // 获取数据字典数据
    var dictionaryObj = {
        WBS_LEVEL: {},
        PBAG_NATURE: {},
        PBAG_TYPE: {},
        CUSTOMER_UNIT: {},
    }
    var dictionaryStr = 'WBS_LEVEL,PBAG_NATURE,PBAG_TYPE,CUSTOMER_UNIT';
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

    //获取报表类型
    function getUrlParam(name){
        var reg = new RegExp(name +"=(.*?)((?=&|$))"); //构造一个含有目标参数的正则表达式对象
        var r = window.location.href.match(reg); //匹配目标参数
        if (r!=null) return unescape(r[1]); return null; //返回参数值
    }
    var reportType=getUrlParam("type");

    var animateFlag = true
    $(".screen-full").click(function(){
        $(".wrap_left").animate({
            width:'toggle'
        });
        $(".wrap_right").animate({
            marginLeft:'0'
        },function(){
            // $('.search').click()
        });
        if(animateFlag){
            $(this).removeClass("layui-icon-screen-full").addClass('layui-icon-screen-restore').attr('title','退出全屏');

        }else {
            $(this).removeClass("layui-icon-screen-restore").addClass('layui-icon-screen-full').attr('title','全屏');
        }

        animateFlag = !animateFlag
    });

    layui.use(['form', 'laydate', 'eleTree', 'xmSelect', 'treeTable', 'table'], function () {
        var layForm = layui.form,
            laydate = layui.laydate,
            eleTree = layui.eleTree,
            treeTable = layui.treeTable,
            table = layui.table,
            xmSelect = layui.xmSelect;
        var url="";
       switch (reportType) {
             case "mtlContract":
                 //材料采购合同台账
                 $("#h2Html").html("材料采购合同报表");
                 headerInp='<div class="layui-col-xs2" style="margin-left: 9px">' +
                     '<input type="text" name="projectName" class="layui-input" autocomplete="off" placeholder="项目名称" >'+
                     '</div>'+
                     '<div class="layui-col-xs2" style="margin-left: 9px">' +
                     '<input type="text" name="contractName" class="layui-input" autocomplete="off" placeholder="合同名称" >'+
                     '</div>'+
                     '<div class="layui-col-xs2" style="margin-left: 9px">' +
                     '<input type="text" name="firstParty" class="layui-input" autocomplete="off" placeholder="甲方" >'+
                     '</div>'+
                     '<div class="layui-col-xs2" style="margin-left: 9px">' +
                     '<input type="text" name="secondParty" class="layui-input" autocomplete="off" placeholder="乙方" >'+
                     '</div>'+
                     '<div class="layui-col-xs2">' +
                     '<button class="layui-btn layui-btn-sm search" type="button" style="margin-left: 9px;margin-top: 2px">查询</button>'+
                     '</div>'
                $("#headerRow").prepend(headerInp);
                 $("#thTwoRow").show();

                 var thTwoRowOneTrHtml = "        <th lay-data=\"{field:'projectName',minWidth:100,align:'center'}\">项目名称</th>\n" +
                     "                            <th lay-data=\"{field:'contractName',minWidth:100,align:'center'}\">合同名称</th>\n" +
                     "                            <th lay-data=\"{field:'contractId',minWidth:150,align:'center'}\">合同编号</th>\n" +
                     "                            <th lay-data=\"{field:'contractDate',minWidth:100,align:'center'}\">合同签订日期</th>\n" +
                     "                            <th id=\"th1\" lay-data=\"{field:'contractA',minWidth:100,align:'center'}\">甲方</th>\n" +
                     "                            <th lay-data=\"{field:'contractB',minWidth:100,align:'center'}\">乙方</th>\n" +
                     "                            <th lay-data=\"{field:'contractMon',minWidth:100,align:'center'}\">合同金额</th>\n" +
                     "                            <th lay-data=\"{field:'settlementMon',minWidth:100,align:'center'}\">结算金额</th>\n" +
                     /*"                            <th lay-data=\"{field:'stockInPrice',minWidth:100,align:'center'}\">入库单价</th>\n" +*/
                     "                            <th lay-data=\"{field:'paymentMon',minWidth:100,align:'center'}\">累计付款金额</th>\n" ;
                 $("#thTwoRowOneTr").html(thTwoRowOneTrHtml);
                 break;
             case "mtlOut":
                 //材料出库报表
                 $("#h2Html").html("材料出库报表");
                 // headerInp='<div class="layui-col-xs2" style="margin-left: 9px;width: 15.666667%">' +
                 //     '<input type="text" name="projectName" class="layui-input" autocomplete="off" placeholder="项目名称" >'+
                 //     '</div>'+
                 headerInp='<div class="layui-col-xs2" style="margin-left: 9px;width: 15.666667%">' +
                     '<input type="text" name="mtlStockOutNo" class="layui-input" autocomplete="off" placeholder="出库单编号" >'+
                     '</div>'+
                     '<div class="layui-col-xs2" style="margin-left: 9px;width: 15.666667%">' +
                     '<input type="text" name="customerName" class="layui-input" autocomplete="off" placeholder="供应商" >'+
                     '</div>'+
                     '<div class="layui-col-xs2" style="margin-left: 9px;width: 15.666667%">' +
                     '<input type="text" name="mtlName" class="layui-input" autocomplete="off" placeholder="材料名称" >'+
                     '</div>'+
                     // '<div class="layui-col-xs2" style="margin-left: 9px">' +
                     // '<input type="text" name="secondParty" class="layui-input" autocomplete="off" placeholder="CBS" >'+
                     // '</div>'+
                     /*'<div class="layui-col-xs2" style="margin-left: 9px;margin-top: 8px">' +
                     '<input type="text" name="stockOutDate" class="layui-input" autocomplete="off" placeholder="出库日期" >'+
                     '</div>'+*/
                     '<div class="layui-col-xs2" style="margin-left: 9px;width: 15.666667%">' +
                     '<input class="layui-input"  autocomplete="off" name="stockOutStartDate" style="height: 38px;position: relative" placeholder="开始日期">\n' +
                     '<span style="display: block; width: 5px; position: absolute;top: 8px;left: 100.5%;">-</span>\n' +
                     '</div>'+
                     '<div class="layui-col-xs2" style="margin-left: 9px;width: 15.666667%">' +
                     '<input class="layui-input"  autocomplete="off" name="stockOutEndDate" style="height: 38px;" placeholder="结束日期">' +
                     '</div>'+
                     '<div class="layui-col-xs2"style="width: 10%">' +
                     '<button class="layui-btn layui-btn-sm search" type="button" style="margin-left: 16px;margin-top: 3px">查询</button>'+
                     '</div>'
                 $("#headerRow").prepend(headerInp);
                 $("#thTwoRow").show();
                 url="/stockInAnnalysis/stockOutData";

                 var thTwoRowOneTrHtml ="         <th lay-data=\"{field:'projName',minWidth:100,align:'center'}\">项目名称</th>\n" +
                     "                            <th lay-data=\"{field:'stockOutDate',minWidth:140,align:'center'}\">出库日期</th>\n" +
                     "                            <th lay-data=\"{field:'mtlStockOutNo',minWidth:170,align:'center'}\">出库编号</th>\n" +
                     "                            <th lay-data=\"{field:'customerName',minWidth:100,align:'center'}\">供应商</th>\n" +
                     "                            <th id=\"th1\" lay-data=\"{field:'mtlName',minWidth:100,align:'center'}\">材料名称</th>\n" +
                     "                            <th lay-data=\"{field:'mtlStand',minWidth:100,align:'center'}\">规格</th>\n" +
                     "                            <th lay-data=\"{field:'mtlValuationUnit',minWidth:100,align:'center'}\">单位</th>\n" +
                     "                            <th lay-data=\"{field:'stockOutQuantity',minWidth:100,align:'center'}\">出库数量</th>\n" +
                     "                            <th lay-data=\"{field:'noTaxPeice',minWidth:100,align:'center'}\">不含税单价</th>\n" +
                     "                            <th lay-data=\"{field:'taxPeice',minWidth:100,align:'center'}\">含税单价 </th>\n" +
                     "                            <th lay-data=\"{field:'noTaxMoney',minWidth:100,align:'center'}\">不含税金额</th>\n" +
                     "                            <th lay-data=\"{field:'taxMoney',minWidth:100,align:'center'}\">含税金额</th>\n" ;
                 $("#thTwoRowOneTr").html(thTwoRowOneTrHtml);
                 break;
             case "mtlPayment":
                 //材料付款台账
                 $("#h2Html").html("材料付款报表");
                 headerInp='<div class="layui-col-xs2" style="margin-left: 9px">' +
                     '<input type="text" name="projectName" class="layui-input" autocomplete="off" placeholder="项目名称" >'+
                     '</div>'+
                     '<div class="layui-col-xs2" style="margin-left: 9px">' +
                     '<input type="text" name="contractName" class="layui-input" autocomplete="off" placeholder="合同名称" >'+
                     '</div>'+
                     '<div class="layui-col-xs2" style="margin-left: 9px">' +
                     '<input type="text" name="firstParty" class="layui-input" autocomplete="off" placeholder="供应商" >'+
                     '</div>'+
                     '<div class="layui-col-xs2" style="margin-left: 9px">' +
                     '<input type="text" name="secondParty" class="layui-input" autocomplete="off" placeholder="付款日期" >'+
                     '</div>'+
                     '<div class="layui-col-xs2">' +
                     '<button class="layui-btn layui-btn-sm search" type="button" style="margin-left: 9px;margin-top: 2px">查询</button>'+
                     '</div>'
                 $("#headerRow").prepend(headerInp);
                 var thTwoRowOneTrHtml = "        <th lay-data=\"{field:'projectName',minWidth:100,align:'center'}\">项目名称</th>\n" +
                     "                            <th lay-data=\"{field:'contractName',minWidth:100,align:'center'}\">合同名称</th>\n" +
                     "                            <th lay-data=\"{field:'contractId',minWidth:150,align:'center'}\">合同编号</th>\n" +
                     "                            <th lay-data=\"{field:'contractMon',minWidth:100,align:'center'}\">合同金额</th>\n" +
                     "                            <th lay-data=\"{field:'paymentDate',minWidth:100,align:'center'}\">付款日期</th>\n" +
                     "                            <th lay-data=\"{field:'paymentNode',minWidth:100,align:'center'}\">本次付款节点</th>\n" +
                     "                            <th lay-data=\"{field:'paymentMon',minWidth:100,align:'center'}\">本次付款金额</th>\n";
                 $("#thTwoRowOneTr").html(thTwoRowOneTrHtml);
                 break;
             case "mtlSettleup":
                 //材料结算台账
                 $("#h2Html").html("材料结算报表");
                 headerInp='<div class="layui-col-xs2" style="margin-left: 9px">' +
                     '<input type="text" name="projectName" class="layui-input" autocomplete="off" placeholder="项目名称" >'+
                     '</div>'+
                     '<div class="layui-col-xs2" style="margin-left: 9px">' +
                     '<input type="text" name="firstParty" class="layui-input" autocomplete="off" placeholder="供应商" >'+
                     '</div>'+
                     '<div class="layui-col-xs2" style="margin-left: 9px">' +
                     '<input type="text" name="secondParty" class="layui-input" autocomplete="off" placeholder="结算日期" >'+
                     '</div>'+
                     '<div class="layui-col-xs2">' +
                     '<button class="layui-btn layui-btn-sm" type="button" style="margin-left: 9px;margin-top: 2px">查询</button>'+
                     '</div>'
                 $("#headerRow").prepend(headerInp);
                 var thTwoRowOneTrHtml = "<th lay-data=\"{field:'sum',minWidth:100,align:'center'}\"></th>" +
                     "                                <th lay-data=\"{field:'projName',minWidth:100,align:'center'}\">项目名称</th>\n" +
                     "                            <th lay-data=\"{field:'settlementId',minWidth:140,align:'center'}\">结算编号</th>\n" +
                     "                            <th lay-data=\"{field:'settlementDate',minWidth:170,align:'center'}\">结算日期</th>\n" +
                     "                            <th lay-data=\"{field:'belongDate',minWidth:100,align:'center'}\">所属期</th>\n" +
                     "                            <th lay-data=\"{field:'warehouseId',minWidth:100,align:'center'}\">入库单号</th>\n" +
                     "                            <th lay-data=\"{field:'supplier',minWidth:100,align:'center'}\">供应商</th>\n" +
                     "                            <th lay-data=\"{field:'materialName',minWidth:100,align:'center'}\">物料名称</th>\n" +
                     "                            <th lay-data=\"{field:'specifications',minWidth:80,align:'center'}\">规格</th>\n" +
                     /*"                            <th lay-data=\"{field:'stockInPrice',minWidth:100,align:'center'}\">入库单价</th>\n" +*/
                     "                            <th lay-data=\"{field:'measureUnit',minWidth:100,align:'center'}\">计量单位</th>\n" +
                     "                            <th lay-data=\"{field:'number',minWidth:100,align:'center'}\">数量</th>\n" +
                     "                            <th lay-data=\"{field:'taxPrice',minWidth:100,align:'center'}\">含税单价</th>\n" +
                     "                            <th lay-data=\"{field:'notaxMon',minWidth:100,align:'center'}\">不含税金额</th>\n" +
                     "                            <th lay-data=\"{field:'setTaxRate',minWidth:100,align:'center'}\">结算税率</th>\n" +
                     "                            <th lay-data=\"{field:'taxMon',minWidth:100,align:'center'}\">含税金额</th>";
                 $("#thTwoRowOneTr").html(thTwoRowOneTrHtml);
                 break;
             case "mtlStockIn":
                 //材料入库报表
                 $("#h2Html").html("材料入库报表");
                 url="/stockInAnnalysis/stockInData";
                 // headerInp='<div class="layui-col-xs2" style="margin-left: 9px">' +
                 //     '<input type="text" name="projectName" class="layui-input" autocomplete="off" placeholder="项目名称" >'+
                 //     '</div>'+
                 headerInp='<div class="layui-col-xs2" style="margin-left: 9px;width: 15.666667%">' +
                     '<input type="text" name="mtlStockInNo" class="layui-input" autocomplete="off" placeholder="入库单号" >'+
                     '</div>'+
                     '<div class="layui-col-xs2" style="margin-left: 9px;width: 15.666667%">' +
                     '<input type="text" name="customerName" class="layui-input" autocomplete="off" placeholder="供应商" >'+
                     '</div>'+
                     '<div class="layui-col-xs2" style="margin-left: 9px;width: 15.666667%">' +
                     '<input type="text" name="mtlName" class="layui-input" autocomplete="off" placeholder="材料名称" >'+
                     '</div>'+
                     '<div class="layui-col-xs2" style="margin-left: 9px;width: 15.666667%">' +
                     '<input type="text" name="mtlContractName" class="layui-input" autocomplete="off" placeholder="合同名称" >'+
                     '</div>'+
                     // '<div class="layui-col-xs2" style="margin-left: 9px">' +
                     // '<input type="text" name="secondParty" class="layui-input" autocomplete="off" placeholder="CBS" >'+
                     // '</div>'+
                     '<div class="layui-col-xs1" style="margin-left: 9px;">' +
                     '<input class="layui-input"  autocomplete="off" name="stockInStartDateStr" style="height: 38px;position: relative" placeholder="开始日期">\n' +
                     '<span style="display: block; width: 5px; position: absolute;top: 8px;left: 100.5%;">-</span>\n' +
                     '</div>'+
                     '<div class="layui-col-xs1" style="margin-left: 9px;">' +
                     '<input class="layui-input"  autocomplete="off" name="stockInEndDateStr" style="height: 38px;" placeholder="结束日期">' +
                     '</div>'+
                     '<div class="layui-col-xs2" style="width: 10%">' +
                     '<button class="layui-btn layui-btn-sm search" type="button" style="margin-left: 16px;margin-top: 3px">查询</button>'+
                     '</div>'
                 $("#headerRow").prepend(headerInp);
                 $("#thTwoRow").show();

                 var thTwoRowOneTrHtml = "        <th lay-data=\"{field:'projName',minWidth:100,align:'center'}\">项目名称</th>\n" +
                     "                            <th lay-data=\"{field:'stockInDate',minWidth:140,align:'center'}\">入库日期</th>\n" +
                     "                            <th lay-data=\"{field:'mtlStockInNo',minWidth:170,align:'center'}\">入库单号</th>\n" +
                     "                            <th lay-data=\"{field:'mtlContractName',minWidth:100,align:'center'}\">合同名称</th>\n" +
                     "                            <th lay-data=\"{field:'customerName',minWidth:100,align:'center'}\">供应商</th>\n" +
                     "                            <th id=\"th1\" lay-data=\"{field:'mtlName',minWidth:100,align:'center'}\">材料名称</th>\n" +
                     "                            <th lay-data=\"{field:'mtlStand',minWidth:100,align:'center'}\">规格</th>\n" +
                     "                            <th lay-data=\"{field:'mtlValuationUnit',minWidth:100,align:'center'}\">单位</th>\n" +
                     "                            <th lay-data=\"{field:'stockInQuantity',minWidth:100,align:'center'}\">入库数量</th>\n" +
                     /*"                            <th lay-data=\"{field:'stockInPrice',minWidth:100,align:'center'}\">入库单价</th>\n" +*/
                     "                            <th lay-data=\"{field:'noTaxPeice',minWidth:100,align:'center'}\">不含税单价</th>\n" +
                     "                            <th lay-data=\"{field:'taxPeice',minWidth:100,align:'center'}\">含税单价</th>\n" +
                     "                            <th lay-data=\"{field:'noTaxMoney',minWidth:100,align:'center'}\">不含税金额</th>\n" +
                     "                            <th lay-data=\"{field:'taxMoney',minWidth:100,align:'center'}\">含税金额</th>\n" +
                     "                            <th lay-data=\"{field:'taxRate',minWidth:100,align:'center'}\">税率</th>\n" +
                     "                            <th lay-data=\"{field:'taxes',minWidth:100,align:'center'}\">税额</th>\n" +
                     "                            <th lay-data=\"{field:'isSettleup',minWidth:100,align:'center'}\">是否结算</th>";
                 $("#thTwoRowOneTr").html(thTwoRowOneTrHtml);
                 break;
             case "mtlSubcontractPay":
                 //分包付款台账
                 $("#h2Html").html("分包付款报表");
                 headerInp='<div class="layui-col-xs2" style="margin-left: 9px">' +
                     '<input type="text" name="projectName" class="layui-input" autocomplete="off" placeholder="项目名称" >'+
                     '</div>'+
                     '<div class="layui-col-xs2" style="margin-left: 9px">' +
                     '<input type="text" name="contractName" class="layui-input" autocomplete="off" placeholder="合同名称" >'+
                     '</div>'+
                     '<div class="layui-col-xs2" style="margin-left: 9px">' +
                     '<input type="text" name="firstParty" class="layui-input" autocomplete="off" placeholder="分包商" >'+
                     '</div>'+
                     '<div class="layui-col-xs2" style="margin-left: 9px">' +
                     '<input type="text" name="secondParty" class="layui-input" autocomplete="off" placeholder="付款日期" >'+
                     '</div>'+
                     '<div class="layui-col-xs2">' +
                     '<button class="layui-btn layui-btn-sm search" type="button" style="margin-left: 9px;margin-top: 2px">查询</button>'+
                     '</div>'
                 $("#headerRow").prepend(headerInp);
                 var thTwoRowOneTrHtml = "        <th lay-data=\"{field:'projectName',minWidth:100,align:'center'}\">项目名称</th>\n" +
                     "                            <th lay-data=\"{field:'contractName',minWidth:100,align:'center'}\">合同名称</th>\n" +
                     "                            <th lay-data=\"{field:'contractId',minWidth:150,align:'center'}\">合同编号</th>\n" +
                     "                            <th lay-data=\"{field:'contractMon',minWidth:100,align:'center'}\">合同金额</th>\n" +
                     "                            <th lay-data=\"{field:'paymentDate',minWidth:100,align:'center'}\">付款日期</th>\n" +
                     "                            <th lay-data=\"{field:'paymentNode',minWidth:100,align:'center'}\">付款节点</th>\n" +
                     "                            <th lay-data=\"{field:'paymentMon',minWidth:100,align:'center'}\">本次付款金额</th>\n";
                 $("#thTwoRowOneTr").html(thTwoRowOneTrHtml);
                 break;
             case "mtlSubsettleup":
                 //分包合同台账
                 $("#h2Html").html("分包合同报表");
                 headerInp='<div class="layui-col-xs2" style="margin-left: 9px">' +
                     '<input type="text" name="projectName" class="layui-input" autocomplete="off" placeholder="项目名称" >'+
                     '</div>'+
                     '<div class="layui-col-xs2" style="margin-left: 9px">' +
                     '<input type="text" name="contractName" class="layui-input" autocomplete="off" placeholder="合同名称" >'+
                     '</div>'+
                     '<div class="layui-col-xs2" style="margin-left: 9px">' +
                     '<input type="text" name="firstParty" class="layui-input" autocomplete="off" placeholder="甲方" >'+
                     '</div>'+
                     '<div class="layui-col-xs2" style="margin-left: 9px">' +
                     '<input type="text" name="secondParty" class="layui-input" autocomplete="off" placeholder="乙方" >'+
                     '</div>'+
                     '<div class="layui-col-xs2">' +
                     '<button class="layui-btn layui-btn-sm search" type="button" style="margin-left: 9px;margin-top: 2px">查询</button>'+
                     '</div>'
                 $("#headerRow").prepend(headerInp);
                 var thTwoRowOneTrHtml = "        <th lay-data=\"{field:'projectName',minWidth:100,align:'center'}\">项目名称</th>\n" +
                     "                            <th lay-data=\"{field:'contractName',minWidth:100,align:'center'}\">合同名称</th>\n" +
                     "                            <th lay-data=\"{field:'contractId',minWidth:150,align:'center'}\">合同编号</th>\n" +
                     "                            <th lay-data=\"{field:'subcontractType',minWidth:150,align:'center'}\">分包类型</th>\n" +
                     "                            <th lay-data=\"{field:'contractDate',minWidth:100,align:'center'}\">合同签订日期</th>\n" +
                     "                            <th lay-data=\"{field:'contractA',minWidth:100,align:'center'}\">甲方</th>\n" +
                     "                            <th lay-data=\"{field:'contractB',minWidth:100,align:'center'}\">乙方</th>\n" +
                     "                            <th lay-data=\"{field:'contractMon',minWidth:100,align:'center'}\">合同总价</th>\n" +
                     "                            <th lay-data=\"{field:'paymentMon',minWidth:100,align:'center'}\">累计结算金额</th>\n" +
                     /*"                            <th lay-data=\"{field:'stockInPrice',minWidth:100,align:'center'}\">入库单价</th>\n" +*/
                     "                            <th lay-data=\"{field:'paymentMon',minWidth:100,align:'center'}\">累计付款金额</th>\n" ;
                 $("#thTwoRowOneTr").html(thTwoRowOneTrHtml);

                 break;
             case "mtlSubcontract":
                 //分包结算台账
                 $("#h2Html").html("分包结算报表");
                 headerInp='<div class="layui-col-xs2" style="margin-left: 9px">' +
                     '<input type="text" name="projectName" class="layui-input" autocomplete="off" placeholder="项目名称" >'+
                     '</div>'+
                     '<div class="layui-col-xs2" style="margin-left: 9px">' +
                     '<input type="text" name="firstParty" class="layui-input" autocomplete="off" placeholder="分包商" >'+
                     '</div>'+
                     '<div class="layui-col-xs2" style="margin-left: 9px">' +
                     '<input type="text" name="secondParty" class="layui-input" autocomplete="off" placeholder="结算日期" >'+
                     '</div>'+
                     '<div class="layui-col-xs2">' +
                     '<button class="layui-btn layui-btn-sm search" type="button" style="margin-left: 9px;margin-top: 2px">查询</button>'+
                     '</div>'
                 $("#headerRow").prepend(headerInp);
                 var thTwoRowOneTrHtml = "        <th lay-data=\"{field:'projectName',minWidth:100,align:'center'}\">项目名称</th>\n" +
                     "                            <th lay-data=\"{field:'contractName',minWidth:100,align:'center'}\">合同名称</th>\n" +
                     "                            <th lay-data=\"{field:'subcontractPeo',minWidth:150,align:'center'}\">分包商</th>\n" +
                     "                            <th lay-data=\"{field:'settlementDate',minWidth:100,align:'center'}\">结算日期</th>\n" +
                     "                            <th lay-data=\"{field:'contractMon',minWidth:100,align:'center'}\">合同金额</th>\n" +
                     "                            <th lay-data=\"{field:'paymentMon',minWidth:100,align:'center'}\">累计结算金额</th>\n" +
                     "                            <th lay-data=\"{field:'paymentMon',minWidth:100,align:'center'}\">累计付款金额</th>\n" ;
                 $("#thTwoRowOneTr").html(thTwoRowOneTrHtml);
                 break;
       }

        //材料入库
        //开始日期
        laydate.render({
            elem: 'input[name="stockInStartDateStr"]' //指定元素
            ,trigger: 'dblclick' //采用click弹出
            ,format: 'yyyy-MM-dd'
        });
        //结束日期
        laydate.render({
            elem: 'input[name="stockInEndDateStr"]' //指定元素
            ,trigger: 'dblclick' //采用click弹出
            ,format: 'yyyy-MM-dd'
        });

        $('input[name="stockInStartDateStr"]').val(getMonthBeforeFormatAndDay(0,'-',1))
        $('input[name="stockInEndDateStr"]').val(getMonthBeforeFormatAndDay(1,'-',1))

        //材料出库
        //开始日期
        laydate.render({
            elem: 'input[name="stockOutStartDate"]' //指定元素
            ,trigger: 'dblclick' //采用click弹出
            ,format: 'yyyy-MM-dd'
        });
        //结束日期
        laydate.render({
            elem: 'input[name="stockOutEndDate"]' //指定元素
            ,trigger: 'dblclick' //采用click弹出
            ,format: 'yyyy-MM-dd'
        });

        $('input[name="stockOutStartDate"]').val(getMonthBeforeFormatAndDay(0,'-',1))
        $('input[name="stockOutEndDate"]').val(getMonthBeforeFormatAndDay(1,'-',1))



        layForm.render();



        /* region 修改左侧项目名称 */
        var searchTimer = null;
        $('#search_project').on('input propertychange', function () {
            clearTimeout(searchTimer);
            searchTimer = null;
            var val = $(this).val();
            searchTimer = setTimeout(function () {
                projectLeft(val);
            }, 300);
        });
        $('.search_icon').on('click', function () {
            projectLeft($('#search_project').val());
        });
        /* endregion */

        projectLeft();

        /**
         * 左侧项目信息列表
         * @param projectName 项目名称
         */
        function projectLeft(projectName) {
            projectName = projectName ? projectName : '';
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
                }
            });
        }
        var projectId;
        // 树节点点击事件
        eleTree.on("nodeClick(leftTree)", function (d) {
            $("#tableObj").css("display","block");
            var currentData = d.data.currentData;
            if (currentData.projId) {
                $('#leftId').attr('projId', currentData.projId);
                $('#leftId').attr('decomposeLevel', currentData.decomposeLevel);
                $('#leftId').attr('contractStartDate', currentData.contractStartDate || '');
                $('#leftId').attr('contractEndDate', currentData.contractEndDate || '');
                $('.no_data').hide();
                $('.table_box').show();
                tableInit(currentData.projId);
                projectId=currentData.projId;
            } else {
                $('#leftId').attr('projId', '');
                $('#leftId').attr('decomposeLevel', '');
                $('#leftId').attr('contractStartDate', '');
                $('#leftId').attr('contractEndDate', '');
                $('.table_box').hide();
                $('.no_data').show();
            }
        });

        var wbsHtm;
        var rbsHtm;
        var cbsHtm;
        function tableInit(projId) {
            var data = searchParam()
            $(".th").remove();
            var loadingIndex = layer.load();
            $.ajax({
                //url:'/projectCostAnalysis/getWbsCbsLayerNum?projId='+projId+'',
                url:url+"?projId="+projId,
                datatype:'json',
                type:'get',
                data:data,
                //async:false,
                success:function(res){
                    var wbsNum=res.obj&&res.obj.wbsLayerNum?res.obj.wbsLayerNum:0;
                    var cbsNum=res.obj&&res.obj.cbsLayerNum?res.obj.cbsLayerNum:0;
                    var rbsNum=res.obj&&res.obj.rbsLayerNum?res.obj.rbsLayerNum:0;
                    wbsHtm="";
                    rbsHtm="";
                    cbsHtm="";
                    var htm = "minWidth:100";
                    //WBS
                    if(wbsNum==0||wbsNum=="0"){

                    }else if(wbsNum==1||wbsNum=="1"){
                        wbsHtm+='<th class="th" lay-data="{field:\'wbs'+wbsNum+'\',align:\'center\','+htm+'}" rowspan="2">WBS一级</th>'

                    }else if(wbsNum==2||wbsNum=="2"){
                        for(var i=0;i<wbsNum;i++){
                            if(i==1){
                                break;
                            }
                            wbsHtm+='<th class="th" lay-data="{field:\'wbs'+(i+1)+'\',align:\'center\','+htm+'}" rowspan="2">WBS'+getNum(i+1)+'级</th>'
                        }
                        wbsHtm+='<th class="th" lay-data="{field:\'wbs'+wbsNum+'\',align:\'center\','+htm+'}" rowspan="2">WBS末级</th>'
                    }else if(wbsNum>2){
                        for(var i=0;i<wbsNum;i++){
                            if(i>1){
                                break;
                            }
                            wbsHtm+='<th class="th" lay-data="{field:\'wbs'+(i+1)+'\',align:\'center\','+htm+'}" rowspan="2">WBS'+getNum(i+1)+'级</th>'
                        }
                        wbsHtm+='<th class="th" lay-data="{field:\'wbs'+wbsNum+'\',align:\'center\','+htm+'}" rowspan="2">WBS末级</th>'
                    }
                    //RBS
                    if(rbsNum==0||rbsNum=="0"){

                    }else if(rbsNum==1||rbsNum=="1"){
                        rbsHtm+='<th class="th" lay-data="{field:\'rbs'+rbsNum+'\',align:\'center\','+htm+'}" rowspan="2">RBS一级</th>'

                    }else if(rbsNum==2||rbsNum=="2"){
                        for(var i=0;i<rbsNum;i++){
                            if(i==1){
                                break;
                            }
                            rbsHtm+='<th class="th" lay-data="{field:\'rbs'+(i+1)+'\',align:\'center\','+htm+'}" rowspan="2">RBS'+getNum(i+1)+'级</th>'
                        }
                        rbsHtm+='<th class="th" lay-data="{field:\'rbs'+rbsNum+'\',align:\'center\','+htm+'}" rowspan="2">RBS末级</th>'
                    }else if(rbsNum>2){
                        for(var i=0;i<rbsNum;i++){
                            if(i>1){
                                break;
                            }
                            rbsHtm+='<th class="th" lay-data="{field:\'rbs'+(i+1)+'\',align:\'center\','+htm+'}" rowspan="2">RBS'+getNum(i+1)+'级</th>'
                        }
                        rbsHtm+='<th class="th" lay-data="{field:\'rbs'+rbsNum+'\',align:\'center\','+htm+'}" rowspan="2">RBS末级</th>'
                    }


                    //CBS
                    if(cbsNum==0||cbsNum=="0"){

                    }else if(cbsNum==1||cbsNum=="1"){
                        cbsHtm+='<th class="th" lay-data="{field:\'cbs'+cbsNum+'\',align:\'center\','+htm+'}" rowspan="2">CBS一级</th>'

                    }else if(cbsNum==2||cbsNum=="2"){
                        for(var i=0;i<cbsNum;i++){
                            if(i==1){
                                break;
                            }
                            cbsHtm+='<th class="th" lay-data="{field:\'cbs'+(i+1)+'\',align:\'center\','+htm+'}" rowspan="2">CBS'+getNum(i+1)+'级</th>'
                        }
                        cbsHtm+='<th class="th" lay-data="{field:\'cbs'+cbsNum+'\',align:\'center\','+htm+'}" rowspan="2">CBS末级</th>'
                    }else if(cbsNum>2){
                        for(var i=0;i<cbsNum;i++){
                            if(i>1){
                                break;
                            }
                            cbsHtm+='<th class="th" lay-data="{field:\'cbs'+(i+1)+'\',align:\'center\','+htm+'}" rowspan="2">CBS'+getNum(i+1)+'级</th>'
                        }
                        cbsHtm+='<th class="th" lay-data="{field:\'cbs'+cbsNum+'\',align:\'center\','+htm+'}" rowspan="2">CBS末级</th>'
                    }
                    $("#th1").before(wbsHtm,rbsHtm,cbsHtm);
                    //if(url!=''){
                        table.init('parse-table-demo', { //转化静态表格
                            //url:url+"?projId="+projId
                            data:res.data
                            ,toolbar: '#toolbarDemo' //开启头部工具栏，并为其绑定左侧模板
                            ,defaultToolbar: ['filter', 'exports', 'print', { //自定义头部工具栏右侧图标。如无需自定义，去除该参数即可
                                title: '提示'
                                ,layEvent: 'LAYTABLE_TIPS'
                                ,icon: 'layui-icon-tips'
                            }]
                            ,height: 'full-150'
                            ,page:false
                            ,limit:99999999999999999999
                            ,done:function(res,curr,count){
                                // layuiRowspan('sum',1);
                                layer.close(loadingIndex)
                                // $(".layui-table-tool").css("width",$(".layui-table-view").find("table").width());
                                // $(".layui-table-view").css("width",$(".layui-table-view").find("table").width());
                            }
                        });
                    // }else{
                    //     layer.close(loadingIndex)
                    // }
                }
            })
        }

       table.on('toolbar(parse-table-demo)',function(obj){
            var layEvent=obj.event;
            var _url = '';
            switch (layEvent) {
                 case "export":
                     if(reportType=='mtlOut'){//材料出库报表
                         var mtlStockOutNo = $('[name="mtlStockOutNo"]').val()
                         var customerName = $('[name="customerName"]').val()
                         var mtlName = $('[name="mtlName"]').val()
                         var stockInStartDateStr = $('[name="stockInStartDateStr"]').val()
                         var stockInEndDateStr = $('[name="stockInEndDateStr"]').val()
                         var stockOutStartDate = $('[name="stockOutStartDate"]').val()
                         var stockOutEndDate = $('[name="stockOutEndDate"]').val()
                         if(mtlStockOutNo){
                             _url +='&mtlStockOutNo='+mtlStockOutNo
                         }
                         if(customerName){
                             _url += '&customerName='+customerName
                         }
                         if(mtlName){
                             _url += '&mtlName='+mtlName
                         }
                         if(stockOutStartDate){
                             _url += '&stockOutStartDate='+stockOutStartDate
                         }
                         if(stockOutEndDate){
                             _url += '&stockOutEndDate='+stockOutEndDate
                         }
                     }else if(reportType=='mtlStockIn'){//材料入库报表
                         var mtlStockInNo = $('[name="mtlStockInNo"]').val()
                         var customerName = $('[name="customerName"]').val()
                         var mtlName = $('[name="mtlName"]').val()
                         var mtlContractName = $('[name="mtlContractName"]').val()
                         var stockInStartDateStr = $('[name="stockInStartDateStr"]').val()
                         var stockInEndDateStr = $('[name="stockInEndDateStr"]').val()
                         if(mtlStockInNo){
                             _url += '&mtlStockInNo='+mtlStockInNo
                         }
                         if(customerName){
                             _url += '&customerName='+customerName
                         }
                         if(mtlName){
                             _url += '&mtlName='+mtlName
                         }
                         if(mtlContractName){
                             _url += '&mtlContractName='+mtlContractName
                         }
                         if(stockInStartDateStr){
                             _url += '&stockInStartDateStr='+stockInStartDateStr
                         }
                         if(stockInEndDateStr){
                             _url += '&stockInEndDateStr='+stockInEndDateStr
                         }
                     }
                     window.location.href=url+'?projId='+projectId+'&export=export'+_url;
                     break;
            }
        })

        //左边查询
        $('#searchBtn').on('click', function () {
            tableInit($('#leftId').attr('projId') || '');
        });

        //右边查询
        $(document).on('click', '.search', function () {
            tableInit($('#leftId').attr('projId'))
        })
        //返回搜索参数
        function searchParam() {
            var _obj = {}
            switch (reportType) {
                case "mtlContract":
                    //材料采购合同台账

                    break;
                case "mtlOut":
                    //材料出库报表
                    var mtlStockOutNo = $('[name="mtlStockOutNo"]').val()
                    var customerName = $('[name="customerName"]').val()
                    var mtlName = $('[name="mtlName"]').val()
                    var stockInStartDateStr = $('[name="stockInStartDateStr"]').val()
                    var stockInEndDateStr = $('[name="stockInEndDateStr"]').val()
                    var stockOutStartDate = $('[name="stockOutStartDate"]').val()
                    var stockOutEndDate = $('[name="stockOutEndDate"]').val()
                    if(mtlStockOutNo){
                        _obj.mtlStockOutNo = mtlStockOutNo
                    }
                    if(customerName){
                        _obj.customerName = customerName
                    }
                    if(mtlName){
                        _obj.mtlName = mtlName
                    }
                    if(stockOutStartDate){
                        _obj.stockOutStartDate = stockOutStartDate
                    }
                    if(stockOutEndDate){
                        _obj.stockOutEndDate = stockOutEndDate
                    }
                    break;
                case "mtlPayment":
                    //材料付款台账

                    break;
                case "mtlSettleup":
                    //材料结算台账

                    break;
                case "mtlStockIn":
                    //材料入库报表
                    var mtlStockInNo = $('[name="mtlStockInNo"]').val()
                    var customerName = $('[name="customerName"]').val()
                    var mtlName = $('[name="mtlName"]').val()
                    var mtlContractName = $('[name="mtlContractName"]').val()
                    var stockInStartDateStr = $('[name="stockInStartDateStr"]').val()
                    var stockInEndDateStr = $('[name="stockInEndDateStr"]').val()
                    if(mtlStockInNo){
                        _obj.mtlStockInNo = mtlStockInNo
                    }
                    if(customerName){
                        _obj.customerName = customerName
                    }
                    if(mtlName){
                        _obj.mtlName = mtlName
                    }
                    if(mtlContractName){
                        _obj.mtlContractName = mtlContractName
                    }
                    if(stockInStartDateStr){
                        _obj.stockInStartDateStr = stockInStartDateStr
                    }
                    if(stockInEndDateStr){
                        _obj.stockInEndDateStr = stockInEndDateStr
                    }
                    break;
                case "mtlSubcontractPay":
                    //分包付款台账

                    break;
                case "mtlSubsettleup":
                    //分包合同台账

                    break;
                case "mtlSubcontract":
                    //分包结算台账

                    break;
            }
            return _obj
        }

    });


    //判断是否该为空
    function isUndefined(data) {
        if(data==1){
            return '是'
        }else if(data==0){
            return '否'
        }else{
            return ''
        }
    }


    function getNum(i){
        switch(i){
            case 1:
                return "一"
                break;
            case 2:
                return "二"
                break;
            case 3:
                return "三"
                break;
            case 4:
                return "四"
                break;
            case 5:
                return "五"
                break;
            case 6:
                return "六"
                break;
            case 7:
                return "七"
                break;
            case 8:
                return "八"
                break;
            case 9:
                return "九"
                break;
            case 10:
                return "十"
                break;
        }

    }

    //求自然月日期
    function getMonthBeforeFormatAndDay(num, format, day) {
        var date = new Date();
        date.setMonth(date.getMonth() + (num*1), 1);
        //读取日期自动会减一，所以要加一
        var mo = date.getMonth() + 1;
        //小月
        if (mo == 4 || mo == 6 || mo == 9 || mo == 11) {
            if (day > 30) {
                day = 30
            }
        }
        //2月
        else if (mo == 2) {
            if (isLeapYear(date.getFullYear())) {
                if (day > 29) {
                    day = 29
                } else {
                    day = 28
                }
            }
            if (day > 28) {
                day = 28
            }
        }
        //大月
        else {
            if (day > 31) {
                day = 31
            }
        }

        if(day>0&&day<10){
            day = '0'+day
        }

        retureValue = date.format('yyyy' + format + 'MM' + format + day);

        return retureValue;
    }

    //JS判断闰年代码
    function isLeapYear(Year) {
        if (((Year % 4) == 0) && ((Year % 100) != 0) || ((Year % 400) == 0)) {
            return (true);
        } else { return (false); }
    }

    //日期格式化
    Date.prototype.format = function (format) {
        var o = {
            "M+": this.getMonth() + 1, // month
            "d+": this.getDate(), // day
            "h+": this.getHours(), // hour
            "m+": this.getMinutes(), // minute
            "s+": this.getSeconds(), // second
            "q+": Math.floor((this.getMonth() + 3) / 3), // quarter
            "S": this.getMilliseconds()
            // millisecond
        }

        if (/(y+)/.test(format))
            format = format.replace(RegExp.$1, (this.getFullYear() + "").substr(4 - RegExp.$1.length));
        for (var k in o)
            if (new RegExp("(" + k + ")").test(format))
                format = format.replace(RegExp.$1, RegExp.$1.length == 1 ? o[k] : ("00" + o[k]).substr(("" + o[k]).length));
        return format;
    }

</script>
</body>
</html>
