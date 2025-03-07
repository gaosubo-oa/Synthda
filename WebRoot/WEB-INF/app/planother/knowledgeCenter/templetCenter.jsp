<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@taglib prefix="mvc" uri="http://www.springframework.org/tags/form" %>
<%@taglib prefix="fmt" uri="http://www.springframework.org/tags" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html>
<html>
<head lang="en">
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <title>模板中心</title>
    <link rel="stylesheet" href="/lib/layui/layui/css/layui.css?20190817.1">
    <link rel="stylesheet" href="/lib/layui/layui/css/common.css">
    <%--<link rel="stylesheet" href="/lims/css/eleTree.css">--%>
    <link rel="stylesheet" href="/lib/layui/layui/css/eleTree.css">
    <script src="/lib/layui/layui/layui.js"></script>
    <script src="/lib/layui/layui/lay/mymodules/eleTree.js"></script>
    <script type="text/javascript" src="/lib/layui/layui/global.js"></script>
    <script type="text/javascript" src="../../js/xoajq/xoajq1.js"></script>
    <script src="../../js/base/base.js" type="text/javascript" charset="utf-8"></script>
    <script src="/lib/layui/layui/js/common.js?v=20190726" type="text/javascript" charset="utf-8"></script>
    <script src="/lib/layui/layui/js/baseCode/base.js?v=2019080918:09" type="text/javascript" charset="utf-8"></script>
    <script type="text/javascript" src="/lib/jquery-2.1.4.min.js"></script>
    <script src="/js/base/base.js" type="text/javascript" charset="utf-8"></script>
    <script src="../../js/jquery/jquery.cookie.js"></script>
    <script src="/lib/jquery.form.min.js"></script>
    <script src="/lib/jQuery-File-Upload-master/jquery-ui.js" type="text/javascript" charset="utf-8"></script>
    <script src="/lib/jQuery-File-Upload-master/jquery.iframe-transport.js" type="text/javascript" charset="utf-8"></script>
    <script src="/lib/jQuery-File-Upload-master/jquery.fileupload.js" type="text/javascript" charset="utf-8"></script>
    <script type="text/javascript" src="/js/email/fileuploadPlus.js?20230529"></script>
    <script type="text/javascript" src="/js/email/fileupload.js"></script>
    <style>
        html,body{
            height: 99.8%;
        }
        .layui-card-header{
            border-bottom: 1px solid #eee;
        }
        .mbox{
            height: 100%;
            padding:0px;
        }
        .inbox{
            padding: 5px;
            padding-right: 30px;
        }
        .deptinput{
            display: inline-block;
            width: 75%;
        }
        .layui-btn{
            margin-left: 10px;
        }
        .layui-btn .layui-icon{
            margin-right: 0px;
        }
        .red{
            color: red;
            font-size: 16px;
        }
        .layui-form-label{
            padding: 8px 15px;
        }
        .layui-card-body{
            display: flex;
        }
        /*.layui-lf{*/
        /*    float: left;*/
        /*    position: relative;*/
        /*    border: 1px solid #eee;*/
        /*    !*width: 200px;*!*/
        /*    width: 18%;*/
        /*    overflow-x: auto;*/
        /*    height: 100%;*/
        /*    !*height: 600px !important;*!*/
        /*}*/
        /*.layui-rt{*/
        /*    float: left;*/
        /*    width: 84%;*/
        /*    margin-left: 6px;*/
        /*    height: 100%;*/
        /*    !*margin-top: -10px;*!*/
        /*}*/
        .treeTitle{
            display: flex;
            box-sizing: border-box;
            justify-content: center;
            align-items: center;
            width: 100%;
            height: 30px;
            background-color: #00a0e9;
            color: #fff;
            padding: 15px;
            position: relative;
        }
        .layui-nav-item,.layadmin-flexible{
            position: absolute;
            left: 5px;
            top: 23px;
            z-index: 9999999;
        }
        .rtfix{
            /*width:200px;*/
            overflow-x: hidden;
        }
        .bg{
            background-color: #F2F2F2;
        }
        .bgs{
            background-color: #F2F2F2;
        }
        .back{
            background-color: #ccc;
        }
        /*滚动条样式*/
        .scroll::-webkit-scrollbar {/*滚动条整体样式*/
            width: 4px;     /*高宽分别对应横竖滚动条的尺寸*/
            height: 10px;
        }
        .scroll::-webkit-scrollbar-thumb {/*滚动条里面小方块*/
            border-radius: 5px;
            -webkit-box-shadow: inset 0 0 5px rgba(0,0,0,0.2);
            background: rgba(0,0,0,0.2);
        }
        .scroll::-webkit-scrollbar-track {/*滚动条里面轨道*/
            -webkit-box-shadow: inset 0 0 5px rgba(0,0,0,0.2);
            border-radius: 0;
            background: rgba(0,0,0,0.1);
        }

        .eleTree{
            cursor: pointer;
        }
        .layui-table-view .layui-table td, .layui-table-view .layui-table th{
            padding: 3px 0;
        }
        .layui-tab layui-tab-card{
            margin-top: -4px;
        }
        .layui-tab-card>.layui-tab-title .layui-this:after {
            border-width: 0px;
        }
        .baseinfo td{
            padding: 5px 2px;
        }
        .active{
            display: none;
        }
        .back{
            background-color: #F2F2F2;
        }
        .layui-colla-item {
            position: relative;
        }
        .layui-collapse .layui-card-body{
            padding: 0 8px;
        }
        .repairLable{
            padding: 8px 15px;
            text-align: right;
            vertical-align: middle;
        }
        .layui-form-select dl dd{
            height: 32px;
            line-height: 32px;
        }
        .layui-form-select .layui-select-title .layui-input{
            height: 32px;
        }
        #formTest .layui-form-select input,#lendListTest .layui-form-select input{
            height: 32px;
        }
        .layui-input{
            height: 32px !important;
        }
        .layui-form-item{
            margin-bottom: 5px; !important;
        }
        .layui-form-label{
            width: 70px; !important;
        }
        /*.iframe{*/
        /*width: 100% !important;*/
        /*height: 100% !important;*/
        /*}*/
        .layui-tab-title .layui-this {
            color: #000;
            background-color: #fff;
        }
        .con_left {
            float: left;
            width: 210px;
            height: 100%;
            margin-top: 10px;
        }
        .con_right {
            float: left;
            width: calc(100% - 230px);
            height: 100%;
            position: relative;
            overflow-y: auto;
            /*margin-top: 41px;*/
            /*left: -20px;*/
        }
        .icon_img {
            font-size: 25px;
            cursor: pointer;
        }

        .icon_img:hover {
            color: #0aa3e3;
        }
        .layui-tab-title li{
            min-width: 10%;
        }
    </style>
</head>
<body>
<div class="mbox">
    <div class="layui-card" style="height: 100%;">
        <div class="layui-tab layui-tab-card" lay-filter="docDemoTabBrief" style="position:relative;height: 100%;overflow-x: hidden">
            <div style="position: absolute;top: 4px;right: 23px;height: 35px;line-height: 35px;z-index: 10000;">
                <i class="layui-icon layui-icon-read icon_img" style="margin-right: 15px" text="知识库"></i>
                <i class="layui-icon layui-icon-survey icon_img" text="帮助"></i>
            </div>
            <div class="scroll" style="overflow-x:auto;overflow-y:hidden;background-color: #f2f2f2;">
                <ul class="layui-tab-title" id="ulBox">
                    <li num="1" class="layui-this">模板中心</li>
<%--                    <li num="2" >计家模板中心</li>--%>
                </ul>
            </div>
            <div class="layui-tab-content" id="divBox" style="height:90%;display: block;position: relative;width:100%;padding: 2px">
                <%--工程类别--%>
                <div class="layui-tab-item layui-show" style="height: 100%">
                    <div class="layui-card" style="height: 100%">
                        <div class="layui-card-body" style="height: 100%">
                            <div class="con_left">
                                <%--<div class="layui-lf rtfix">--%>
                                    <%--<div style="margin: 1% 1%;" id="editBox">
                                        <button type="button" style="width: 21%;margin-left: 1px;padding: 0 6px;" class="layui-btn layui-btn-primary layui-btn-sm add" id="addPlan">新增</button>
                                        <button type="button" style="width: 21%;margin-left: 1px;padding: 0 6px;" class="layui-btn layui-btn-primary layui-btn-sm add" id="editPlan">编辑</button>
                                        <button type="button" style="width: 21%;margin-left: 1px;padding: 0 6px;" class="layui-btn layui-btn-primary layui-btn-sm del" id="delPlan">删除</button>
                                        <button type="button" style="width: 21%;margin-left: 1px;padding: 0 6px;" class="layui-btn layui-btn-primary layui-btn-sm del" id="importPlan">导入</button>
                                    </div>--%>
                                    <div class="panel-body">
                                        <div class="eleTree ele1" lay-filter="tdata"></div>
                                    </div>
                                <%--</div>--%>
                            </div>
                            <div class="layui-md" style="width: 4px;cursor: e-resize;position: relative;"></div>
                            <div class="con_right">
                                <div class="tishi" style="height: 100%;text-align: center;border: none;">
                                    <div style="width:100%;padding-top:12%;"><img style="margin-top: 2%;text-align: center;" src="/img/noData.png" alt=""></div>
                                    <h2 style="margin: auto;text-align: center;font-size: 20px;font-weight: normal;">请选择左侧分类</h2>
                                </div>
                                <div class="layui-rt" style="position: relative;display: none;">
                                    <table id="Settlement" lay-filter="SettlementFilter"></table>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <%--工程类别--%>
<%--                <div class="layui-tab-item" style="height: 100%">--%>
<%--                    <div class="layui-card" style="height: 100%">--%>
<%--                        <div class="layui-card-body" style="height: 100%">--%>
<%--                            <div class="con_left">--%>
<%--                                &lt;%&ndash;<div class="layui-lf rtfix">&ndash;%&gt;--%>
<%--                                &lt;%&ndash;<div style="margin: 1% 1%;" id="editBox">--%>
<%--                                    <button type="button" style="width: 21%;margin-left: 1px;padding: 0 6px;" class="layui-btn layui-btn-primary layui-btn-sm add" id="addPlan">新增</button>--%>
<%--                                    <button type="button" style="width: 21%;margin-left: 1px;padding: 0 6px;" class="layui-btn layui-btn-primary layui-btn-sm add" id="editPlan">编辑</button>--%>
<%--                                    <button type="button" style="width: 21%;margin-left: 1px;padding: 0 6px;" class="layui-btn layui-btn-primary layui-btn-sm del" id="delPlan">删除</button>--%>
<%--                                    <button type="button" style="width: 21%;margin-left: 1px;padding: 0 6px;" class="layui-btn layui-btn-primary layui-btn-sm del" id="importPlan">导入</button>--%>
<%--                                </div>&ndash;%&gt;--%>
<%--                                <div class="panel-body">--%>
<%--                                    <div class="eleTree ele22" lay-filter="tdata22"></div>--%>
<%--                                </div>--%>
<%--                                &lt;%&ndash;</div>&ndash;%&gt;--%>
<%--                            </div>--%>
<%--                            <div class="layui-md" style="width: 4px;cursor: e-resize;position: relative;"></div>--%>
<%--                            <div class="con_right">--%>
<%--                                <div class="tishi" style="height: 100%;text-align: center;border: none;">--%>
<%--                                    <div style="width:100%;padding-top:12%;"><img style="margin-top: 2%;text-align: center;" src="/img/noData.png" alt=""></div>--%>
<%--                                    <h2 style="margin: auto;text-align: center;font-size: 20px;font-weight: normal;">请选择左侧项目</h2>--%>
<%--                                </div>--%>
<%--                                <div class="layui-rt" style="position: relative;display: none;">--%>
<%--                                    <table id="Settlement2" lay-filter="SettlementFilter2"></table>--%>
<%--                                </div>--%>
<%--                            </div>--%>
<%--                        </div>--%>
<%--                    </div>--%>
<%--                </div>--%>

            </div>
        </div>
    </div>
</div>

<%--<script type="text/html" id="toolbar">
    <div class="layui-btn-container">
        <button class="layui-btn layui-btn-sm" lay-event="upfile" style="width: 100px">新建</button>
        <button class="layui-btn layui-btn-sm" lay-event="edit" style="width: 100px">编辑</button>
        <button class="layui-btn layui-btn-sm" lay-event="supplierImport" style="width: 100px">导入</button>
        <button class="layui-btn layui-btn-sm" lay-event="supplierExport" style="width: 100px">导出</button>
        <button class="layui-btn layui-btn-sm layui-btn-danger" lay-event="delete" style="width: 60px">删除</button>
    </div>
</script>--%>
<%----------------------------------------------------数据操作--------------------------------------------------------------------------%>
<script type="text/javascript">
    var tipIndex = null;
    $('.icon_img').hover(function () {
        var tip = $(this).attr('text')
        tipIndex = layer.tips(tip, this)
    }, function () {
        layer.close(tipIndex)
    });

    $('.rtfix').css('max-height',autodivheight()-55)
    var el;
    var ell;
    var parData;
    var arr = [];
    var columnTrId;
    var codeNo;
    var codNam;
    var SettlementTable;
    function getUrlParam(name){
        var reg = new RegExp(name +"=(.*?)((?=&|$))"); //构造一个含有目标参数的正则表达式对象
        var r = window.location.href.match(reg); //匹配目标参数
        if (r!=null) return unescape(r[1]); return null; //返回参数值
    }
    layui.use(['table','layer','form','element','eleTree','laydate','upload'], function(){
        var table = layui.table;
        var layer = layui.layer;
        var form = layui.form;
        var eleTree = layui.eleTree;
        var element = layui.element;
        var $ = layui.jquery;
        var laydate = layui.laydate;
        var upload = layui.upload;

        var dictionaryObj = {
            CONTROL_LEVEL: {},
            //RESULT_DESC:{},
            MAIN_CENTER_DEPT: {},
            MAIN_AREA_DEPT: {},
            MAIN_PROJECT_DEPT: {},
            WAREHOUSING_YN: {},
            CGCL_TYPE: {},
            ORGANIZATION_TYPE: {},
            TG_TYPE: {},
            PLAN_PHASE: {},
            TG_GRADE: {},
            DUTY_TYPE:{},
        }
        var dictionaryStr = 'CONTROL_LEVEL,RESULT_DESC,MAIN_CENTER_DEPT,MAIN_AREA_DEPT,MAIN_PROJECT_DEPT,WAREHOUSING_YN,CGCL_TYPE,ORGANIZATION_TYPE,TG_TYPE,PLAN_PHASE,TG_GRADE,DUTY_TYPE';
        $.ajax({
            url: '/Dictonary/selectDictionaryByDictNos',
            dataType: 'json',
            type: 'get',
            async: false,
            data: {dictNos: dictionaryStr},
            success: function (res) {
                if (res.flag) {
                    for (var dict in dictionaryObj) {
                        dictionaryObj[dict] = {object: {}, str: ''}
                        if (res.object[dict]) {
                            res.object[dict].forEach(function (item) {
                                dictionaryObj[dict]['object'][item.dictNo] = item.dictName
                            })
                        }
                    }
                }
            }
        })

        // 初始化渲染 树形菜单
        el = eleTree.render({
            elem: '.ele1',
            showLine:true,
            url:'/knowledgeCenter/getTemplteTree',
            lazy: false,
            done:function (data) { //渲染完成回调
                var n1 = $("#ulBox").find("li.layui-this").attr("codeNo");
                var na = $("#ulBox").find("li.layui-this").html();
                codNam = encodeURI(encodeURI(na));
                codeNo = n1;
                if(data.data.length == 0){
                    $('.ele1').html('<div style="text-align: center">暂无数据</div>');
                    columnTrId = undefined;
                }
            }
        });

        // 节点点击事件
        eleTree.on("nodeClick(tdata)",function(d) {
            parData = d.data.currentData;
            var n1 = $("#ulBox").find("li.layui-this").attr("codeNo");
            var na = $("#ulBox").find("li.layui-this").html();
            codNam = encodeURI(encodeURI(na));
            codeNo = n1;
            columnTrId = d.data.currentData.id;
            console.log(d.data.currentData)
            var clas = "";
            var idn = ""
            var dataid=$(clas+' div').attr("data-id")
            $('.eleTree-node').removeClass('back')
            $(d.node[0]).addClass('back')
            $('.eleTree-node-group').css('background','#fff')
            //调用子页面的方法
            //debugger
            if(parData.haveData != undefined&&parData.haveData == false){
                $('.tishi').show();
                $('.layui-rt').hide();
            }else {
                $('.tishi').hide();
                $('.layui-rt').show();
                if(parData.haveData == undefined){
                    if(parData.securityKnowledgeId!=undefined&&parData.treesType=='securityKnowledge'){//隐患标准模板
                        childFunc(parData.securityKnowledgeId,'danger',true);
                    }else if(parData.tplTypeId!=undefined){ //任务管理-关键任务模板
                        childFunc(parData.tplTypeId,'targetTemplate',true);
                    }else if(parData.ttaskTypeId!=undefined){//任务管理-子任务模板
                        childFunc(parData.ttaskTypeId,'itemTemplate',true);
                    }else if(parData.templteId!=undefined&&parData.treesType=='securityTemplte'){//安全检查计划模板
                        childFunc(parData.templteId,'checkTemplte',true);
                    }else if(parData.qualityKnowledgeId!=undefined&&parData.treesType=='qualityKnowledge'){//质量检查标准
                        childFunc(parData.qualityKnowledgeId,'qualityDanger',true);
                    }else if(parData.qualityTemplteId!=undefined&&parData.treesType=='qualityTemplte'){//质量检查模板
                        childFunc(parData.qualityTemplteId,'qualityTemplte',true);
                    }
                }else{
                    if(parData.haveData == true){
                        childFunc('',parData.treeType,false);
                    }
                }
            }
            //childFunc(columnTrId,treeType);  //调用应用中方法
        });
        //选中监听事件
        eleTree.on("nodeChecked(tdata)",function(d) {
            var id = d.data.currentData.columnId;
            if(d.isChecked == true || d.isChecked == "true"){
                arr.push(id);
            }else{
                arr.remove(id);
            }
        })
        $(document).on("click",function() {
            $(".ele2").slideUp();
        })
        /*//树的方法
        function treeFn(cla) {
            var n1 = $("#ulBox").find("li.layui-this").attr("codeNo");

            codeNo = n1;
            var na = $("#ulBox").find("li.layui-this").html();
            codNam = encodeURI(encodeURI(na));
            // 初始化渲染 树形菜单
            el = eleTree.render({
                elem: cla,
                showLine:true,
                // showCheckbox: true,
                url:'/knowledge/getKnowledgeType?colunmType='+n1+'&parentColumnId=0',
                lazy: true,
                load: function(data,callback) {
                    $.post('/knowledge/getKnowledgeType?parentColumnId='+data.id,function (res) {
                        callback(res.data);//点击节点回调
                    })
                },
                done:function (data) { //渲染完成回调
                    if(data.data.length == 0){
                        $(cla).html('<div style="text-align: center">暂无数据</div>');
                        columnTrId = undefined;
                    }else{
                        aldata = data.data
                        columnTrId = data.data[0].id;
                        var dataid=$(cla+' div').attr("data-id")
                        $('.eleTree-node').removeClass('back')
                        $(cla+' div[data-id='+dataid+']').addClass('back')
                        $('.eleTree-node-group').css('background','#fff');
                    }
                }
            });
        }*/
        function childFunc(dataId,treeType,flag) {
            if (treeType == "danger") {//隐患标准
                if (flag) {
                    layui.table.render({
                        elem: '#Settlement'
                        // , data: []
                        , url: '/workflow/secirityManager/getSecurityByIds?ids=' + dataId//数据接口
                        , page: { //支持传入 laypage 组件的所有参数（某些参数除外，如：jump/elem） - 详见文档
                            layout: ['prev', 'page', 'next', 'skip', 'count', 'limit',]//自定义分页布局
                            , limits: [10, 15, 20, 25, 30, 35, 40, 45, 50, 55, 60, 65, 70, 75, 80, 85, 90, 95, 100]
                            , first: false //不显示首页
                            , last: false //不显示尾页
                        } //开启分页
                        //, toolbar: '#toolbar'
                        , cols: [[ //表头
                            {type: 'checkbox'}
                            //, {field: 'securityDangerId',  title: 'ID'}
                            , {type: 'numbers', title: '序号',}
                            , {field: 'securityDanger',  title: '隐患标准'}
                            , {field: 'securityDangerMeasures', title: '整改措施'}
                            , {
                                field: 'securityDangerGrade',  title: '重大隐患', templet: function (d) {
                                    if (d.securityDangerGrade != undefined && d.securityDangerGrade != "") {
                                        if (d.securityDangerGrade === 0 || d.securityDangerGrade === "0") {
                                            return "<div><span style='color:#ff0000'>是</span></div>";
                                        } else {
                                            return "<div>否</div>";
                                        }
                                    } else {
                                        return "";
                                    }
                                }
                            }
                            // ,{width:250, title: '操作',align:'center', toolbar: '#barOperation'}
                        ]]
                        , limit: 10
                        , done: function (res) {

                        }
                    });
                }
            }else if (treeType =="targetTemplate") { //关键任务模板
                if (parData.parentTypeId != 0) {
                    $('.layui-rt').show()
                    $('.tishi').hide()
                    table.render({
                        elem: '#Settlement'
                        , url: '/TemplateItem/findTemplateByTypeId'
                        , where: {
                            useFlag: true,
                            typeId:dataId
                        }
                        , page: true //开启分页
                        , limit: 50
                        //, height: 'full-180'
                        , toolbar: '#toolbar'
                        , defaultToolbar: ['']
                        , cols: [[ //表头
                            {type: 'checkbox'}
                            , {type: 'numbers', title: '序号',}
                            , {field: 'tgNo', title: '关键任务编号', width: 200}
                            , {field: 'tgName', title: '关键任务名称', event: 'detail', style: 'cursor: pointer;', width: 350}
                            , {
                                field: 'controlLevel', title: '关注等级', width: 150, templet: function (d) {
                                    return dictionaryObj['CONTROL_LEVEL']['object'][d.controlLevel] || ''
                                }
                            }
                            , {
                                field: 'tgGrade', title: '目标等级', width: 150, templet: function (d) {
                                    return dictionaryObj['TG_GRADE']['object'][d.tgGrade] || ''
                                }
                            }
                            , {field: 'resultStandard', title: '完成标准', width: 250}
                            , {field: 'hardDegree', title: '标准难度系数', width: 100}
                            , {
                                field: 'resultDict', title: '成果标准模板', width: 250, templet: function (d) {
                                    var resultDesc = ''
                                    if (d.resultDictList) {
                                        d.resultDictList.forEach(function (item, index) {
                                            resultDesc += item.dictName + ','
                                        })
                                    }
                                    return resultDesc
                                }
                            }
                            , {
                                field: 'mainCenterDeptName', title: '公司总部部门', width: 250, templet: function (d) {
                                    if (d.mainCenterDeptName) {
                                        return d.mainCenterDeptName.replace(/,$/, '')
                                    } else {
                                        return ''
                                    }
                                }
                            }
                            , {
                                field: 'mainAreaDept', title: '分/子公司部门', width: 250, templet: function (d) {
                                    return dictionaryObj['ORGANIZATION_TYPE']['object'][d.mainAreaDept] || ''
                                }
                            }
                            , {
                                field: 'mainProjectDept', title: '项目部责任部门', width: 250, templet: function (d) {
                                    return dictionaryObj['ORGANIZATION_TYPE']['object'][d.mainProjectDept] || ''
                                }
                            }
                            , {field: 'centerDuty', title: '公司总部职责', width: 100}
                            , {
                                field: 'centerDutyType', title: '公司总部职责类型', width: 100, templet: function (d) {
                                    return dictionaryObj['DUTY_TYPE']['object'][d.centerDutyType] || ''
                                }
                            }
                            , {field: 'areaDuty', title: '分/子公司部门职责', width: 100}
                            , {
                                field: 'areaDutyType', title: '分/子公司部门职责类型', width: 100, templet: function (d) {
                                    return dictionaryObj['DUTY_TYPE']['object'][d.areaDutyType] || ''
                                }
                            }
                            , {field: 'projectDuty', title: '项目部部门职责', width: 130}
                            , {
                                field: 'planStage', title: '计划阶段', width: 200, templet: function (d) {
                                    return dictionaryObj['PLAN_PHASE']['object'][d.planStage] || ''
                                }
                            }
                            , {
                                field: 'tgType', title: '关键任务类型', width: 200, templet: function (d) {
                                    return dictionaryObj['TG_TYPE']['object'][d.tgType] || ''
                                }
                            }
                            , {
                                field: 'forceCheck', title: '是否强制勾选', width: 130, templet: function (d) {
                                    if (d.forceCheck == 1) {
                                        return '是'
                                    } else if (d.forceCheck == 0) {
                                        return '否'
                                    } else {
                                        return ''
                                    }
                                }
                            }
                        ]], parseData: function (res) {
                            return {
                                "code": 0, //解析接口状态
                                "data": res.obj,//解析数据列表
                                "count": res.totleNum, //解析数据长度
                            };
                        },
                        request: {
                            pageName: 'page' //页码的参数名称，默认：page
                            , limitName: 'pageSize' //每页数据量的参数名，默认：limit
                        },
                        done: function () {
                            if ($('#tplTypeId').attr('disableYn') == 1) {
                                $('#import').css({
                                    'cursor': 'not-allowed',
                                    'background': '#C1C1C1'
                                })
                                $('#edit').css({
                                    'cursor': 'not-allowed',
                                    'background': '#C1C1C1'
                                })
                                $('#del').css({
                                    'cursor': 'not-allowed',
                                    'background': '#C1C1C1'
                                })
                                $('#forceCheck').css({
                                    'cursor': 'not-allowed',
                                    'background': '#C1C1C1'
                                })
                            }
                        }
                    });
                } else {
                    $('.layui-rt').hide()
                    $('.tishi').show()
                }
            }else if (treeType =="itemTemplate") { //子任务模板
                if (parData.parentTypeId != 0) {
                    $('.layui-rt').show()
                    $('.tishi').hide()
                    table.render({
                        elem: '#Settlement'
                        , url: '/TaskTemplateItem/findTemplateByTypeId'
                        , where: {
                            useFlag: true
                        }
                        , page: true //开启分页
                        , limit: 50
                        , height: 'full-180'
                        , toolbar: '#toolbar'
                        , defaultToolbar: ['']
                        , cols: [[ //表头
                            {type: 'checkbox'}
                            , {type: 'numbers', title: '序号',}
                            , {field: 'taskNo', title: '子任务编号', width: 200}
                            , {field: 'taskName', title: '子任务名称', event: 'detail', style: 'cursor: pointer;', width: 350}
                            /*  , {
                                  field: 'controlLevel', title: '关注等级', width: 150, templet: function (d) {
                                      return dictionaryObj['CONTROL_LEVEL']['object'][d.controlLevel] || ''
                                  }
                              }*/
                            , {field: 'resultStandard', title: '完成标准', width: 250}
                            , {
                                field: 'resultDict', title: '成果标准模板', width: 250, templet: function (d) {
                                    var resultDesc = ''
                                    if (d.resultDictList) {
                                        d.resultDictList.forEach(function (item, index) {
                                            resultDesc += item.dictName + ','
                                        })
                                    }
                                    return resultDesc
                                }
                            }
                            , {field: 'hardDegree', title: '标准难度系数', width: 150}
                            /*,{field: 'mainCenterDeptName', title: '公司总部部门',width:250,templet: function (d) {
                                    if(d.mainCenterDeptName){
                                        return d.mainCenterDeptName.replace(/,$/, '')
                                    }else{
                                        return ''
                                    }
                                }}
                            ,{field: 'mainAreaDept', title: '分/子公司部门',width:250,templet: function (d) {
                                    return dictionaryObj['ORGANIZATION_TYPE']['object'][d.mainAreaDept] || ''
                                }}
                            ,{field: 'mainProjectDept', title: '项目部责任部门',width:300,templet: function (d) {
                                    return dictionaryObj['ORGANIZATION_TYPE']['object'][d.mainProjectDept] || ''
                                }}*/
                        ]], parseData: function (res) {
                            return {
                                "code": 0, //解析接口状态
                                "data": res.obj,//解析数据列表
                                "count": res.totleNum, //解析数据长度
                            };
                        },
                        request: {
                            pageName: 'page' //页码的参数名称，默认：page
                            , limitName: 'pageSize' //每页数据量的参数名，默认：limit
                        },
                        done: function () {
                            if ($('#ttaskTypeId').attr('disableYn') == 1) {
                                $('#import').css({
                                    'cursor': 'not-allowed',
                                    'background': '#C1C1C1'
                                })
                                $('#edit').css({
                                    'cursor': 'not-allowed',
                                    'background': '#C1C1C1'
                                })
                                $('#del').css({
                                    'cursor': 'not-allowed',
                                    'background': '#C1C1C1'
                                })
                            }
                        }
                    });
                } else {
                    $('.layui-rt').hide()
                    $('.tishi').show()
                }
            }else if (treeType == "checkTemplte") {//安全检查计划模板
                if (flag) {
                    layui.table.render({
                        elem: '#Settlement'
                        // , data: []
                        , url: '/workflow/secirityManager/selectTemplteDetails?templteId='+dataId//数据接口
                        , page: { //支持传入 laypage 组件的所有参数（某些参数除外，如：jump/elem） - 详见文档
                            layout: ['prev', 'page', 'next', 'skip', 'count', 'limit',]//自定义分页布局
                            , limits: [10, 15, 20, 25, 30, 35, 40, 45, 50, 55, 60, 65, 70, 75, 80, 85, 90, 95, 100]
                            , first: false //不显示首页
                            , last: false //不显示尾页
                        } //开启分页
                        //,toolbar:'#formTable1toolbar'
                        , cols: [[ //表头
                            {type: 'checkbox'}
                            ,{type: 'numbers', title: '序号'}
                            ,{field:'detailsName',title:'名称'}
                            ,{field: 'securityKnowledgeName', title: '检查项'}
                            ,{field: 'securityDangerName', title: '检查内容'}
                            //,{title: '操作', align: 'center', width:100, toolbar: '#formTable1bar'}
                        ]]
                        , limit: 10
                        , done: function (res) {

                        }
                    });
                }
            }else if (treeType == "qualityDanger") {//质量控制点
                if (flag) {
                    layui.table.render({
                        elem: '#Settlement'
                        // , data: []
                        , url: '/workflow/qualityManager/getQualityByIds?ids=' + dataId//数据接口
                        , page: { //支持传入 laypage 组件的所有参数（某些参数除外，如：jump/elem） - 详见文档
                            layout: ['prev', 'page', 'next', 'skip', 'count', 'limit',]//自定义分页布局
                            , limits: [10, 15, 20, 25, 30, 35, 40, 45, 50, 55, 60, 65, 70, 75, 80, 85, 90, 95, 100]
                            , first: false //不显示首页
                            , last: false //不显示尾页
                        } //开启分页
                        //, toolbar: '#toolbar'
                        , cols: [[ //表头
                            {type: 'checkbox'}
                            //, {field: 'securityDangerId',  title: 'ID'}
                            , {type: 'numbers', title: '序号',}
                            , {field: 'securityDanger',  title: '质量控制点'}
                            , {field: 'securityDangerMeasures', title: '整改措施'}
                            , {
                                field: 'securityDangerGrade',  title: '重大隐患', templet: function (d) {
                                    if (d.securityDangerGrade != undefined && d.securityDangerGrade != "") {
                                        if (d.securityDangerGrade === 0 || d.securityDangerGrade === "0") {
                                            return "<div><span style='color:#ff0000'>是</span></div>";
                                        } else {
                                            return "<div>否</div>";
                                        }
                                    } else {
                                        return "";
                                    }
                                }
                            }
                            // ,{width:250, title: '操作',align:'center', toolbar: '#barOperation'}
                        ]]
                        , limit: 10
                        , done: function (res) {

                        }
                    });
                }
            }else if (treeType == "qualityTemplte") {//质量检查计划模板
                if (flag) {
                    layui.table.render({
                        elem: '#Settlement'
                        // , data: []
                        , url: '/workflow/qualityManager/selectTemplteDetails?templteId='+dataId//数据接口
                        , page: { //支持传入 laypage 组件的所有参数（某些参数除外，如：jump/elem） - 详见文档
                            layout: ['prev', 'page', 'next', 'skip', 'count', 'limit',]//自定义分页布局
                            , limits: [10, 15, 20, 25, 30, 35, 40, 45, 50, 55, 60, 65, 70, 75, 80, 85, 90, 95, 100]
                            , first: false //不显示首页
                            , last: false //不显示尾页
                        } //开启分页
                        //,toolbar:'#formTable1toolbar'
                        , cols: [[ //表头
                            {type: 'checkbox'}
                            ,{type: 'numbers', title: '序号'}
                            ,{field:'detailsName',title:'名称'}
                            ,{field: 'securityKnowledgeName', title: '检查项'}
                            ,{field: 'securityDangerName', title: '检查内容'}
                            //,{title: '操作', align: 'center', width:100, toolbar: '#formTable1bar'}
                        ]]
                        , limit: 10
                        , done: function (res) {

                        }
                    });
                }
            }else if (treeType =="workLibrary_task") { //任务管理-任务项库-关键任务模板
                table.render({
                    elem: '#Settlement'
                    , url: '/WorkItem/seldWorkItem?useFlag=true'//数据接口
                    , toolbar: '#toolbarDemo'
                    , page: true
                    //, height: 'full-220'
                    , limit: 50
                    , where: {
                        useFlag: true,
                        _: new Date().getTime()
                    }
                    , defaultToolbar: ['']
                    , cols: [[ //表头
                        {type: 'checkbox'}
                        , {type: 'numbers', title: '序号',}
                        , {field: 'tgNo', title: '工作项编号', width: 100}
                        , {field: 'tgName', title: '工作项名称', event: 'detail', style: 'cursor: pointer;', width: 100}
                        , {
                            field: 'controlLevel', title: '关注等级', width: 100, templet: function (d) {
                                return dictionaryObj['CONTROL_LEVEL']['object'][d.controlLevel] || ''
                            }
                        }
                        , {
                            field: 'tgGrade', title: '目标等级', width: 100, templet: function (d) {
                                return dictionaryObj['TG_GRADE']['object'][d.tgGrade] || ''
                            }
                        }
                        , {field: 'resultStandard', title: '完成标准', width: 100}
                        , {field: 'hardDegree', title: '标准难度系数', width: 120}
                        , {
                            field: 'resultDict', title: '成果标准模板', width: 120, templet: function (d) {
                                var resultDesc = ''
                                if (d.resultDictList) {
                                    d.resultDictList.forEach(function (item, index) {
                                        resultDesc += item.dictName + ','
                                    })
                                }
                                return resultDesc
                            }
                        }
                        , {
                            field: 'mainCenterDeptName', title: '公司总部部门', width: 120, templet: function (d) {
                                if (d.mainCenterDeptName) {
                                    return d.mainCenterDeptName.replace(/,$/, '')
                                } else {
                                    return ''
                                }
                            }
                        }
                        , {
                            field: 'centerDutyType', title: '公司总部职责类型', width: 160, templet: function (d) {
                                return dictionaryObj['DUTY_TYPE']['object'][d.centerDutyType] || ''
                            }
                        }
                        , {
                            field: 'mainAreaDept', title: '分/子公司部门', width: 120, templet: function (d) {
                                return dictionaryObj['ORGANIZATION_TYPE']['object'][d.mainAreaDept] || ''
                            }
                        }
                        , {
                            field: 'areaDutyType', title: '分/子公司部门职责类型', width: 180, templet: function (d) {
                                return dictionaryObj['DUTY_TYPE']['object'][d.areaDutyType] || ''
                            }
                        }
                        , {
                            field: 'mainProjectDept', title: '项目部责任部门', width: 140, templet: function (d) {
                                return dictionaryObj['ORGANIZATION_TYPE']['object'][d.mainProjectDept] || ''
                            }
                        }
                        , {
                            field: 'planStage', title: '计划阶段', width: 100, templet: function (d) {
                                return dictionaryObj['PLAN_PHASE']['object'][d.planStage] || ''
                            }
                        }
                        , {
                            field: 'tgType', title: '关键任务类型', width: 120, templet: function (d) {
                                return dictionaryObj['TG_TYPE']['object'][d.tgType] || ''
                            }
                        }
                        , {
                            field: 'forceCheck', title: '是否强制勾选', width: 130, templet: function (d) {
                                if (d.forceCheck == 1) {
                                    return '是'
                                } else if (d.forceCheck == 0) {
                                    return '否'
                                } else {
                                    return ''
                                }
                            }
                        }
                    ]]
                    , parseData: function (res) { //res 即为原始返回的数据
                        return {
                            "code": 0, //解析接口状态
                            "data": res.obj,//解析数据列表
                            "count": res.totleNum, //解析数据长度
                        };
                    },
                    request: {
                        pageName: 'page' //页码的参数名称，默认：page
                        , limitName: 'pageSize' //每页数据量的参数名，默认：limit
                    },
                });
            }else if (treeType =="workLibrary_item") { //任务管理-任务项库-子任务
                table.render({
                    elem: '#Settlement'
                    , url: '/TaskItem/seldWorkItem?useFlag=true'//数据接口
                    , toolbar: '#toolbarDemo'
                    , page: true
                    //, height: 'full-220'
                    , limit: 50
                    , where: {
                        useFlag: true,
                        _: new Date().getTime()
                    }
                    , defaultToolbar: ['']
                    , cols: [[ //表头
                        {type: 'checkbox'}
                        , {type: 'numbers', title: '序号',}
                        , {field: 'taskNo', title: '工作项编号',}
                        , {field: 'taskName', title: '工作项名称', event: 'detail', style: 'cursor: pointer;'}
                        , {field: 'resultStandard', title: '完成标准',}
                        , {
                            field: 'resultDict', title: '成果标准模板', templet: function (d) {
                                var resultDesc = ''
                                if (d.resultDictList) {
                                    d.resultDictList.forEach(function (item, index) {
                                        resultDesc += item.dictName + ','
                                    })
                                }
                                return resultDesc
                            }
                        }
                        , {field: 'hardDegree', title: '标准难度系数',}
                        /* ,{field: 'mainCenterDeptName', title: '公司总部部门',templet: function (d) {
								 if(d.mainCenterDeptName){
									 return d.mainCenterDeptName.replace(/,$/, '')
								 }else{
									 return ''
								 }
							 }}
						 ,{field: 'mainAreaDept', title: '分/子公司部门',templet: function (d) {
								 return dictionaryObj['ORGANIZATION_TYPE']['object'][d.mainAreaDept] || ''
							 }}
						 ,{field: 'mainProjectDept', title: '项目部责任部门',templet: function (d) {
								 return dictionaryObj['ORGANIZATION_TYPE']['object'][d.mainProjectDept] || ''
							 }}*/
                    ]]
                    , parseData: function (res) { //res 即为原始返回的数据
                        return {
                            "code": 0, //解析接口状态
                            "data": res.obj,//解析数据列表
                            "count": res.totleNum, //解析数据长度
                        };
                    },
                    request: {
                        pageName: 'page' //页码的参数名称，默认：page
                        , limitName: 'pageSize' //每页数据量的参数名，默认：limit
                    },
                });
            }
        }
        //表格头工具事件
        /*table.on('toolbar(SettlementFilter)', function(obj){
            var checkStatus = table.checkStatus("Settlement").data;
            var event = obj.event;
            switch(event){
                case 'upfile': //上传附件
                    if(columnTrId==undefined){
                        layer.msg("请选择知识类型");
                        return false;
                    }
                    var index = layer.open({
                        type: 1,
                        skin: 'layui-layer-molv', //加上边框
                        area: ['80%', '90%'], //宽高
                        title: '新建',
                        maxmin: true,
                        btn: ['提交', '取消'],
                        content: '<div class="layui-form" id="boxfo">' +
                            '<div class="inbox" style="margin-top:30px"><label class="layui-form-label" style="width: 100px;">排序号</label><div class="layui-input-block" style="margin-left: 130px;">' +
                            '<input class="layui-input"  lay-verify="required" name="securityDangerSort" id="securityDangerSort" style="width: 90%;float: left;"><div><i id="reKey" style="cursor: pointer; position: relative;top: 7px;left: 10px;" class="layui-icon layui-icon-refresh layui-anim " ></i></div></div>' +
                            '<div class="inbox"><label class="layui-form-label" style="width: 100px;"><span style="color:#ff0000">*</span>隐患标准</label><div class="layui-input-block" style="margin-left: 130px;">' +
                            '<textarea name="securityDanger" id="securityDanger" style="max-width: 100%;width: 100%;height:100px"></textarea></div></div>' +
                            '<div class="inbox"><label class="layui-form-label" style="width: 100px;"><span style="color:#ff0000">*</span>整改措施</label><div class="layui-input-block" style="margin-left: 130px;">' +
                            '<textarea name="securityDangerMeasures" id="securityDangerMeasures" style="max-width: 100%;width: 100%;height:100px"></textarea></div></div>' +
                            '<div class="inbox"><label class="layui-form-label" style="width: 100px;">重大隐患</label><div class="layui-input-block" style="margin-left: 130px;">' +
                            '<select name="securityDangerGrade" id="securityDangerGrade"></select></div></div>' +
                            '<div class="layui-form-item layui-hide"><input type="button" lay-submit lay-filter="add-file-submit" id="add-file-submit" value="确认"></div>' +
                            '</div>',
                        success: function () {
                            $.ajax({
                                url: '/workflow/secirityManager/getStandSort?parentId='+columnTrId+'&isStand=true',
                                type: 'get',
                                dataType: 'json',
                                async:false,
                                success: function (res) {
                                    $('#securityDangerSort').val(res.obj);
                                }
                            })
                            var $select1 = $("select[name='securityDangerGrade']");
                            var optionStr = '<option value="">请选择</option>';
                            optionStr += '<option value="0"><span style="color:red">是</span></option>'
                            optionStr += '<option value="1">否</option>'
                            $select1.html(optionStr);

                            $("#reKey").on("click",function (e) {
                                $("#reKey").addClass("layui-anim-rotate layui-anim-loop");
                                $.ajax({
                                    url: '/workflow/secirityManager/getStandSort?parentId='+columnTrId+'&isStand=true',
                                    type: 'get',
                                    dataType: 'json',
                                    async:false,
                                    success: function (res) {
                                        setTimeout(function(){
                                            $("#reKey").removeClass("layui-anim-rotate layui-anim-loop");
                                        },1000);
                                        $('#securityDangerSort').val(res.obj);
                                    }
                                })
                            })

                            form.render();//初始化表单
                        },
                        yes: function (index, layero) {
                            if($("#securityDanger").val()==undefined||$("#securityDanger").val()==""){
                                layer.msg("请输入隐患标准");
                                return false;
                            }else if($("#securityDangerMeasures").val()==undefined||$("#securityDangerMeasures").val()==""){
                                layer.msg("请输入整改措施");
                                return false;
                            }else {
                                $("#add-file-submit").click();
                            }
                        }
                    });
                    form.on('submit(add-file-submit)', function (data) {
                        var securityDanger = data.field;
                        securityDanger.securityDangerTypeId = columnTrId;
                        $.ajax({
                            url:'/workflow/secirityManager/insertSecurityDanger',
                            type: 'post',
                            dataType:'json',
                            data:securityDanger,
                            success:function(res){
                                if(res.code===0||res.code==="0"){
                                    SettlementTable.reload();
                                    layer.closeAll();
                                }
                                layer.msg(res.msg)
                            }
                        })
                    });
                    break;
                case 'delete':  //多条删除
                    if(checkStatus.length == 0){
                        layer.msg("请选中一条或多条数据，进行删除");
                        return false;
                    }else{
                        var ids = "";
                        for(var i=0;i<checkStatus.length;i++){
                            ids += checkStatus[i].securityDangerId+",";
                        }
                        layer.confirm('确定要删除吗？', function(index){
                            $.ajax({
                                type: "post",
                                url: '/workflow/secirityManager/delSecurityDanger',
                                dataType: "json",
                                data:{
                                    ids:ids
                                },
                                success:function (res) {
                                    if(res.code === "0" || res.code === 0){
                                        SettlementTable.reload();
                                    }
                                    layer.msg(res.msg);
                                }
                            })
                            layer.close(index);
                        });
                    }
                    break;
                case 'edit':
                    if(checkStatus.length == 1){
                        var danger = checkStatus[0];
                        var index = layer.open({
                            type: 1,
                            skin: 'layui-layer-molv', //加上边框
                            area: ['80%', '90%'], //宽高
                            title: '编辑',
                            maxmin: true,
                            btn: ['提交', '取消'],
                            content: '<div class="layui-form" id="boxfo">' +
                                '<div class="inbox" style="margin-top:30px"><label class="layui-form-label" style="width: 100px;">排序</label><div class="layui-input-block" style="margin-left: 130px;">' +
                                '<input class="layui-input"  lay-verify="required" name="securityDangerSort" id="securityDangerSort"><input type="hidden"  name="securityDangerId" id="securityDangerId"></div></div>' +
                                '<div class="inbox"><label class="layui-form-label" style="width: 100px;"><span style="color:#ff0000">*</span>隐患标准</label><div class="layui-input-block" style="margin-left: 130px;">' +
                                '<textarea name="securityDanger" id="securityDanger" style="max-width: 100%;width: 100%;height:100px"></textarea></div></div>' +
                                '<div class="inbox"><label class="layui-form-label" style="width: 100px;"><span style="color:#ff0000">*</span>整改措施</label><div class="layui-input-block" style="margin-left: 130px;">' +
                                '<textarea name="securityDangerMeasures" id="securityDangerMeasures" style="max-width: 100%;width: 100%;height:100px"></textarea></div></div>' +
                                '<div class="inbox"><label class="layui-form-label" style="width: 100px;">重大隐患</label><div class="layui-input-block" style="margin-left: 130px;">' +
                                '<select name="securityDangerGrade" id="securityDangerGrade"></select></div></div>' +
                                '<div class="layui-form-item layui-hide"><input type="button" lay-submit lay-filter="edit-file-submit" id="edit-file-submit" value="确认"></div>' +
                                '</div>',
                            success: function () {
                                var $select1 = $("select[name='securityDangerGrade']");
                                var optionStr = '<option value="">请选择</option>';
                                optionStr += '<option value="0"><span style="color:red">是</span></option>'
                                optionStr += '<option value="1">否</option>'
                                $select1.html(optionStr);
                                $("#securityDangerSort").val(danger.securityDangerSort)
                                $("#securityDanger").text(danger.securityDanger)
                                $("#securityDangerMeasures").text(danger.securityDangerMeasures)
                                $("#securityDangerGrade").val(danger.securityDangerGrade)
                                $("#securityDangerId").val(danger.securityDangerId)
                                form.render();//初始化表单
                            },
                            yes: function (index, layero) {
                                if($("#securityDanger").val()==undefined||$("#securityDanger").val()==""){
                                    layer.msg("请输入隐患标准");
                                    return false;
                                }else if($("#securityDangerMeasures").val()==undefined||$("#securityDangerMeasures").val()==""){
                                    layer.msg("请输入整改措施");
                                    return false;
                                }else {
                                    $("#edit-file-submit").click();
                                }
                            }
                        });
                        form.on('submit(edit-file-submit)', function (data) {
                            var plbSecurityDanger = data.field;
                            plbSecurityDanger.securityDangerGrade = $("#securityDangerGrade").val();
                            plbSecurityDanger.securityDangerTypeId = columnTrId;
                            $.ajax({
                                url:'/workflow/secirityManager/updateSecirityDanger',
                                type: 'post',
                                dataType:'json',
                                data:plbSecurityDanger,
                                success:function(res){
                                    if(res.code===0||res.code==="0"){
                                        SettlementTable.reload();
                                        layer.closeAll();
                                    }
                                    layer.msg(res.msg)
                                }
                            })
                        });
                    }else{
                        layer.msg("请选中一条进行编辑");
                    }
                    break;
                case 'supplierImport':
                    var index = layer.open({
                        type: 1
                        , area: ['100%', '100%']
                        , title: '导入'
                        , content:
                            '<div class="layui-form " id="ids">' +
                            '   <div class="main importTable">' +
                            '       <div class="layui-input-block" style="margin-left:0px">\n' +
                            '       <form class="form1" name="form1" id="uploadForm" method="post" action="/workflow/secirityManager/insertImport?type='+columnTrId+'" enctype="multipart/form-data">\n' +
                            '<div class="layui-form-item" style="width: 700px;border-bottom:1px solid #ccc;margin-bottom:0px">\n' +
                            '   <label style="padding: 15px 6px 15px 6px;width: 100px" class="layui-form-label">下载导入模板：</label>\n' +
                            '   <div style="padding: 15px;" style="display: inline-block;width: 70%;">\n' +
                            '     <a id="model" style="color: deepskyblue;cursor:pointer">隐患台账导入模板下载</a>\n' +
                            '   </div>\n' +
                            '</div>\n' +
                            '<div class="layui-form-item" style="width: 700px;border-bottom:1px solid #ccc;">\n' +
                            '   <label style="padding: 15px 6px 15px 6px;width: 100px" class="layui-form-label">选择导入文件：</label>\n' +
                            '   <div style="padding: 15px" style="display: inline-block;width: 70%;">\n' +
                            '     <input style="width: auto" type="file" name="file" accept="application/vnd.ms-excel,application/vnd.openxmlformats-officedocument.spreadsheetml.sheet"/>\n' +
                            '   </div>\n' +
                            ' </div>\n' +
                            ' <div style="width: 700px;border-bottom:1px solid #ccc;margin-bottom:0px">\n' +
                            '   <label style="padding: 0px 6px 15px 6px;width: 100px" class="layui-form-label">说明：</label>\n' +
                            '   <div style="display: inline-block;width: 70%">\n' +
                            '                    <p >1.请导入.xls文件或者.xlsx。</p>\n' +
                            '                    <p style="padding: 15px 0px 10px 0px">2.模版格式均为文本格式。</p>\n' +
                            '   </div>\n' +
                            ' </div>\n' +
                            ' <div style="text-align: center;padding-top: 20px;width: 700px;">\n' +
                            '      <input class="importBtn layui-btn layui-btn-normal" type="button" value="导入">\n' +
                            '      <input class="return layui-btn layui-btn-normal" type="button" value="返回">\n' +
                            ' </div>\n' +
                            '   </form>\n' +
                            '</div>\n'+
                            '</div>\n'+
                            '</div>'
                        , success: function (res) {
                            $('#model').click(function () {
                                window.location.href = encodeURI("/file/security/security.xls");
                            });

                            $('.importBtn').click(function () {
                                var flag = CheckForm();
                                if (flag) {
                                    $('#uploadForm').ajaxSubmit({
                                        dataType: 'json',
                                        success:function (res) {
                                            if (res.flag) {
                                                layer.msg("导入成功！", {icon: 1});
                                                layer.close(index);
                                                SettlementTable.reload();
                                            } else {
                                                layer.msg("导入失败！", {icon: 2});
                                            }
                                        }
                                    })
                                }
                            });
                            $(".return").click(function(){
                                layer.close(index);
                            })
                            function CheckForm() {
                                if (document.form1.file.value == "") {
                                    layer.msg("<fmt:message code='user.th.selectImport' />！", {icon: 2});
                                    return (false);
                                }
                                return (true);
                            }
                        }

                    })
                    break;
                case 'supplierExport':
                    window.location = "/workflow/secirityManager/export"
                    break;
            };
        });*/

        //左侧新建类型
        /*$('#addPlan').click(function () {
            layer.open({
                type: 1,
                title: "新建",
                shadeClose: true,
                btn: ['提交', '取消'],
                shade: 0.5,
                maxmin: true, //开启最大化最小化按钮
                area: ['40%', '50%'],
                content: '<form class="layui-form" lay-filter="formTest" action=""style="width: 100%;\n' +
                    'margin: 10px auto;">\n' +
                    '                                    <input type="text" name="equipId" style="display: none" id="layui-form">\n' +
                    '                                    <div class="layui-form-item">\n' +
                    '                                        <label class="layui-form-label" style=""><span style="color: red;">*</span>排序号</label>\n' +
                    '                                        <div class="layui-input-block">\n' +
                    '                                            <input type="text" id="securityKnowledgeSort" name="securityKnowledgeSort" lay-verify="required" placeholder="请输入排序号" autocomplete="off" class="layui-input">\n' +
                    '                                        </div>\n' +
                    '                                    </div>\n' +
                    '                                    <div class="layui-form-item">\n' +
                    '                                        <label class="layui-form-label"><span style="color: red;">*</span>类型名称</label>\n' +
                    '                                        <div class="layui-input-block">\n' +
                    '                                            <input type="text" name="securityKnowledgeName" id="securityKnowledgeName" lay-verify="required" placeholder="请输入" autocomplete="off" class="layui-input">\n' +
                    '                                        </div>\n' +
                    '                                    </div>\n' +
                    '                                    <div class="layui-form-item">\n' +
                    '                                        <label class="layui-form-label"><span style="color: red;">*</span>父级栏目</label>\n' +
                    '                                        <div class="layui-input-block" id="parent" style="position: relative">\n' +
                    '                                            <input type="text" style="cursor: pointer" id="pele" pid name="ttitle" required="" placeholder="请选择父级(不选择默认为一级)" readonly="" autocomplete="off" class="layui-input">\n' +
                    '                                            <div class="eleTree ele2" lay-filter="data1" style="display:none;position:absolute;border: 1px solid #d2d2d2;overflow-y: auto;background-color: #fff;border-radius: 2px;box-shadow: 0 2px 4px rgba(0,0,0,.12);box-sizing: border-box;z-index: 999;top:38px;left:0px;width: 99%;"></div>\n' +
                    '                                        </div>\n' +
                    '                                    </div>\n' +
                    '                                </form>',
                success: function () {
                    $.ajax({
                        url: '/workflow/secirityManager/getStandSort?parentId='+columnTrId+'&isStand=false',
                        type: 'get',
                        dataType: 'json',
                        async:false,
                        success: function (res) {
                            $('#securityKnowledgeSort').val(res.obj);
                        }
                    })
                    $("[name='ttitle']").on("click",function (e) {
                        e.stopPropagation();
                        ell=eleTree.render({
                            elem: '.ele2',
                            url:'/knowledgeCenter/getTemplteTree',
                            expandOnClickNode: false,
                            highlightCurrent: true,
                            showLine:true,
                            lazy: true,
                            load: function(data,callback) {
                                $.post('/workflow/secirityManager/getSecurityByType?parent='+data.id,function (res) {
                                    callback(res.data);//点击节点回调
                                })
                            },
                            done: function(res){

                            }
                        });
                        $(".ele2").slideDown();
                    })
                    eleTree.on("nodeClick(data1)",function(d) {
                        $("[name='ttitle']").val(d.data.currentData.label)
                        $("#pele").attr("pid",d.data.currentData.id)
                        $(".ele2").slideUp();
                    })
                    $(document).on("click",function() {
                        $(".ele2").slideUp();
                    })
                },
                yes: function (indexx) {
                    var plbSecurityKnowledge = {};
                    plbSecurityKnowledge.securityKnowledgeSort = $("#securityKnowledgeSort").val();
                    plbSecurityKnowledge.securityKnowledgeName = $("#securityKnowledgeName").val();
                    // plbSecurityKnowledge.columnDesc = $("#columnDesc").val();
                    var parent = $("#pele").attr("pid");
                    if(parent==undefined||parent==""){
                        parent=0;
                    }
                    plbSecurityKnowledge.securityKnowledgeParent =parent;
                    // plbSecurityKnowledge.sysCode = $("#pele").attr("pcode")
                    if($("#securityKnowledgeName").val()==''||$("#securityKnowledgeSort").val()==''){ //||$("#columnCode").val()==''
                        layer.msg("必填项不能为空")
                    }else{
                        $.ajax({
                            type: "post",
                            url: '/workflow/secirityManager/insertSecirityManager',
                            dataType: "json",
                            data:plbSecurityKnowledge,
                            success:function (res) {
                                if(res.code == "0" || res.code == 0){
                                    layer.msg(res.msg);
                                    setTimeout(function(){
                                        if(el){
                                            el.reload()
                                        }
                                        if(ell){
                                            ell.reload();
                                        }
                                        layer.close(indexx)
                                    },1000)
                                }else{
                                    layer.msg(res.msg);
                                }
                            }
                        })
                    }
                }
            });
        })*/

        //左侧导入类型
        /*$('#importPlan').click(function () {
            var index = layer.open({
                type: 1
                , area: ['100%', '100%']
                , title: '导入'
                , content:
                    '<div class="layui-form " id="ids">' +
                    '   <div class="main importTable">' +
                    '       <div class="layui-input-block" style="margin-left:0px">\n' +
                    '       <form class="form1" name="form1" id="uploadForm" method="post" action="/workflow/secirityManager/importSecurityKnowledge" enctype="multipart/form-data">\n' +
                    '<div class="layui-form-item" style="width: 700px;border-bottom:1px solid #ccc;margin-bottom:0px">\n' +
                    '   <label style="padding: 15px 6px 15px 6px;width: 100px" class="layui-form-label">下载导入模板：</label>\n' +
                    '   <div style="padding: 15px;" style="display: inline-block;width: 70%;">\n' +
                    '     <a id="model" style="color: deepskyblue;cursor:pointer">隐患台账导入模板下载</a>\n' +
                    '   </div>\n' +
                    '</div>\n' +
                    '<div class="layui-form-item" style="width: 700px;border-bottom:1px solid #ccc;">\n' +
                    '   <label style="padding: 15px 6px 15px 6px;width: 100px" class="layui-form-label">选择导入文件：</label>\n' +
                    '   <div style="padding: 15px" style="display: inline-block;width: 70%;">\n' +
                    '     <input style="width: auto" type="file" name="file" accept="application/vnd.ms-excel,application/vnd.openxmlformats-officedocument.spreadsheetml.sheet"/>\n' +
                    '   </div>\n' +
                    ' </div>\n' +
                    ' <div style="width: 700px;border-bottom:1px solid #ccc;margin-bottom:0px">\n' +
                    '   <label style="padding: 0px 6px 15px 6px;width: 100px" class="layui-form-label">说明：</label>\n' +
                    '   <div style="display: inline-block;width: 70%">\n' +
                    '                    <p >1.请导入.xls文件或者.xlsx。</p>\n' +
                    '                    <p style="padding: 15px 0px 10px 0px">2.模版格式均为文本格式。</p>\n' +
                    '   </div>\n' +
                    ' </div>\n' +
                    ' <div style="text-align: center;padding-top: 20px;width: 700px;">\n' +
                    '      <input class="importBtn layui-btn layui-btn-normal" type="button" value="导入">\n' +
                    '      <input class="return layui-btn layui-btn-normal" type="button" value="返回">\n' +
                    ' </div>\n' +
                    '   </form>\n' +
                    '</div>\n'+
                    '</div>\n'+
                    '</div>'
                , success: function (res) {
                    $('#model').click(function () {
                        window.location.href = encodeURI("/file/security/security.xls");
                    });

                    $('.importBtn').click(function () {
                        var flag = CheckForm();
                        if (flag) {
                            $('#uploadForm').ajaxSubmit({
                                dataType: 'json',
                                success:function (res) {
                                    if (res.flag) {
                                        layer.msg("导入成功！", {icon: 1});
                                        layer.close(index);
                                        SettlementTable.reload();
                                    } else {
                                        layer.msg("导入失败！", {icon: 2});
                                    }
                                }
                            })
                        }
                    });
                    $(".return").click(function(){
                        layer.close(index);
                    })
                    function CheckForm() {
                        if (document.form1.file.value == "") {
                            layer.msg("<fmt:message code='user.th.selectImport' />！", {icon: 2});
                            return (false);
                        }
                        return (true);
                    }
                }

            })
        })*/
        //左侧编辑类型
       /* $('#editPlan').click(function () {
            layer.open({
                type: 1,
                title: "编辑",
                shadeClose: true,
                btn: ['提交', '取消'],
                shade: 0.5,
                maxmin: true, //开启最大化最小化按钮
                area: ['40%', '50%'],
                content: '<form class="layui-form" lay-filter="formTest" action=""style="width: 100%;\n' +
                    'margin: 10px auto;">\n' +
                    // '                                    <input type="text" name="equipId" style="display: none" id="layui-form">\n' +
                    '                                    <div class="layui-form-item">\n' +
                    '                                        <label class="layui-form-label" style=""><span style="color: red;">*</span>排序号</label>\n' +
                    '                                        <div class="layui-input-block">\n' +
                    '                                            <input type="text" id="securityKnowledgeSort" name="securityKnowledgeSort" lay-verify="required" placeholder="请输入排序号" autocomplete="off" class="layui-input">\n' +
                    '                                        </div>\n' +
                    '                                    </div>\n' +
                    '                                    <div class="layui-form-item">\n' +
                    '                                        <label class="layui-form-label"><span style="color: red;">*</span>类型名称</label>\n' +
                    '                                        <div class="layui-input-block">\n' +
                    '                                            <input type="text" name="securityKnowledgeName" id="securityKnowledgeName" lay-verify="required" placeholder="请输入" autocomplete="off" class="layui-input">\n' +
                    '                                        </div>\n' +
                    '                                    </div>\n' +
                    '                                    <div class="layui-form-item">\n' +
                    '                                        <label class="layui-form-label"><span style="color: red;">*</span>父级栏目</label>\n' +
                    '                                        <div class="layui-input-block" id="parent" style="position: relative">\n' +
                    '                                            <input type="text" style="cursor: pointer" id="pele" pid name="ttitle" required="" placeholder="请选择父级(不选择默认为一级)" readonly="" autocomplete="off" class="layui-input">\n' +
                    '                                            <div class="eleTree ele2" lay-filter="data1" style="display:none;position:absolute;border: 1px solid #d2d2d2;overflow-y: auto;background-color: #fff;border-radius: 2px;box-shadow: 0 2px 4px rgba(0,0,0,.12);box-sizing: border-box;z-index: 999;top:38px;left:0px;width: 99%;"></div>\n' +
                    '                                        </div>\n' +
                    '                                    </div>\n' +
                    '                                </form>',
                success: function () {
                    $.ajax({
                        url:'/workflow/secirityManager/selectSecurityManager?secirityId='+columnTrId,
                        dataType:'json',
                        type:'post',
                        success:function(res){
                            if(res.code===0||res.code==="0"){
                                if(res.obj){
                                    if(res.obj.securityKnowledgeSort!=undefined&&res.obj.securityKnowledgeSort!=""){
                                        $("#securityKnowledgeSort").val(res.obj.securityKnowledgeSort);
                                    }
                                    if(res.obj.securityKnowledgeName!=undefined&&res.obj.securityKnowledgeName!=""){
                                        $("#securityKnowledgeName").val(res.obj.securityKnowledgeName);
                                    }
                                    if(res.obj.parentName!=undefined&&res.obj.parentName!=""){
                                        $("#pele").val(res.obj.parentName);
                                        $("#pele").attr("pid",res.obj.securityKnowledgeParent);
                                    }
                                }
                            }
                        }
                    })
                    $("[name='ttitle']").on("click",function (e) {
                        e.stopPropagation();
                        ell=eleTree.render({
                            elem: '.ele2',
                            url:'/knowledgeCenter/getTemplteTree',
                            expandOnClickNode: false,
                            highlightCurrent: true,
                            showLine:true,
                            lazy: true,
                            load: function(data,callback) {
                                $.post('/workflow/secirityManager/getSecurityByType?parent='+data.id,function (res) {
                                    callback(res.data);//点击节点回调
                                })
                            },
                            done: function(res){

                            }
                        });
                        $(".ele2").slideDown();
                    })
                    eleTree.on("nodeClick(data1)",function(d) {
                        $("[name='ttitle']").val(d.data.currentData.label)
                        $("#pele").attr("pid",d.data.currentData.id)
                        $(".ele2").slideUp();
                    })
                    $(document).on("click",function() {
                        $(".ele2").slideUp();
                    })
                },
                yes: function (indexx) {
                    var plbSecurityKnowledge = {};
                    plbSecurityKnowledge.securityKnowledgeId = columnTrId;
                    plbSecurityKnowledge.securityKnowledgeSort = $("#securityKnowledgeSort").val();
                    plbSecurityKnowledge.securityKnowledgeName = $("#securityKnowledgeName").val();
                    // plbSecurityKnowledge.columnDesc = $("#columnDesc").val();
                    var parent = $("#pele").attr("pid");
                    if(parent==undefined||parent==""){
                        parent=0;
                    }
                    plbSecurityKnowledge.securityKnowledgeParent =parent;
                    // plbSecurityKnowledge.sysCode = $("#pele").attr("pcode")
                    if($("#securityKnowledgeName").val()==''||$("#securityKnowledgeSort").val()==''){ //||$("#columnCode").val()==''
                        layer.msg("必填项不能为空")
                    }else{
                        $.ajax({
                            type: "post",
                            url: '/workflow/secirityManager/updateSecirityManager',
                            dataType: "json",
                            data:plbSecurityKnowledge,
                            success:function (res) {
                                if(res.code == "0" || res.code == 0){
                                    layer.msg(res.msg);
                                    setTimeout(function(){
                                        if(el){
                                            el.reload()
                                        }
                                        if(ell){
                                            ell.reload();
                                        }
                                        layer.close(indexx)
                                    },1000)
                                }else{
                                    layer.msg(res.msg);
                                }
                            }
                        })
                    }
                }
            });
        })*/

        //左侧删除类型
       /* $('#delPlan').click(function () {
            if(columnTrId){
                layer.confirm('是否要删除', {icon: 3, title: '删除'}, function (index) {
                    $.ajax({
                        url: '/workflow/secirityManager/delSecurityByType',
                        data: {secirityId: columnTrId},
                        type: 'get',
                        dataType: 'json',
                        success: function (res) {
                            if (res.code===0||res.code==="1") {
                                if(el){
                                    el.reload()
                                }
                                if(ell){
                                    ell.reload();
                                }
                                layer.msg(res.msg, {icon: 1})
                            } else {
                                layer.msg(res.msg, {icon: 2})
                            }
                        }
                    })
                    layer.close(index);
                });
            }else{
                layer.msg('请点击左侧类型进行删除')
            }
        })*/




        //计家模板中心
        var parData2;
        var arr2 = [];
        var columnTrId2;
        var codeNo2;
        var codNam2;
        //var SettlementTable2;
        // 初始化渲染 树形菜单
       var el2 = eleTree.render({
            elem: '.ele22',
            showLine:true,
            url:'/knowledge/goToParent?url=/knowledgeCenter/getTemplteTree',
            lazy: false,
            done:function (data) { //渲染完成回调
                var n1 = $("#ulBox").find("li.layui-this").attr("codeNo2");
                var na = $("#ulBox").find("li.layui-this").html();
                codNam2 = encodeURI(encodeURI(na));
                codeNo2 = n1;
                if(data.data.length == 0){
                    $('.ele22').html('<div style="text-align: center">暂无数据</div>');
                    columnTrId2 = undefined;
                }
            }
        });
        // 节点点击事件
        eleTree.on("nodeClick(tdata22)",function(d) {
            parData2 = d.data.currentData;
            var n1 = $("#ulBox").find("li.layui-this").attr("codeNo2");
            var na = $("#ulBox").find("li.layui-this").html();
            codNam2 = encodeURI(encodeURI(na));
            codeNo2 = n1;
            columnTrId2 = d.data.currentData.id;
            console.log(d.data.currentData)
            var clas = "";
            var idn = ""
            var dataid=$(clas+' div').attr("data-id")
            $('.eleTree-node').removeClass('back')
            $(d.node[0]).addClass('back')
            $('.eleTree-node-group').css('background','#fff')
            //调用子页面的方法
            //debugger
            if(parData2.haveData != undefined&&parData2.haveData == false){
                $('.tishi').show();
                $('.layui-rt').hide();
            }else {
                $('.tishi').hide();
                $('.layui-rt').show();
                if(parData2.haveData == undefined){
                    if(parData2.securityKnowledgeId!=undefined){//隐患标准模板
                        childFunc2(parData2.securityKnowledgeId,'danger',true);
                    }else if(parData2.tplTypeId!=undefined){ //任务管理-关键任务模板
                        childFunc2(parData2.tplTypeId,'targetTemplate',true);
                    }else if(parData2.ttaskTypeId!=undefined){//任务管理-子任务模板
                        childFunc2(parData2.ttaskTypeId,'itemTemplate',true);
                    }/*else if(parData2.!=undefined){
                        childFunc2(parData2.,'',true);
                    }else if(parData2.!=undefined){
                        childFunc2(parData2.,'',true);
                    }else if(parData2.!=undefined){
                        childFunc2(parData2.,'',true);
                    }*/
                }else{
                    if(parData2.haveData == true){
                        childFunc2('',parData2.treeType,false);
                    }
                }
            }
            //childFunc2(columnTrId2,treeType);  //调用应用中方法
        });
        //选中监听事件
        eleTree.on("nodeChecked(tdata22)",function(d) {
            var id = d.data.currentData.columnId;
            if(d.isChecked == true || d.isChecked == "true"){
                arr2.push(id);
            }else{
                arr2.remove(id);
            }
        })
        $(document).on("click",function() {
            $(".ele2").slideUp();
        })
        /*//树的方法
        function treeFn(cla) {
            var n1 = $("#ulBox").find("li.layui-this").attr("codeNo2");

            codeNo2 = n1;
            var na = $("#ulBox").find("li.layui-this").html();
            codNam2 = encodeURI(encodeURI(na));
            // 初始化渲染 树形菜单
            el = eleTree.render({
                elem: cla,
                showLine:true,
                // showCheckbox: true,
                url:'/knowledge/getKnowledgeType?colunmType='+n1+'&parentColumnId=0',
                lazy: true,
                load: function(data,callback) {
                    $.post('/knowledge/getKnowledgeType?parentColumnId='+data.id,function (res) {
                        callback(res.data);//点击节点回调
                    })
                },
                done:function (data) { //渲染完成回调
                    if(data.data.length == 0){
                        $(cla).html('<div style="text-align: center">暂无数据</div>');
                        columnTrId2 = undefined;
                    }else{
                        aldata = data.data
                        columnTrId2 = data.data[0].id;
                        var dataid=$(cla+' div').attr("data-id")
                        $('.eleTree-node').removeClass('back')
                        $(cla+' div[data-id='+dataid+']').addClass('back')
                        $('.eleTree-node-group').css('background','#fff');
                    }
                }
            });
        }*/
        function childFunc2(dataId,treeType,flag) {
            if (treeType == "danger") {//隐患标准
                if (flag) {
                    layui.table.render({
                        elem: '#Settlement2'
                        // , data: []
                        , url: '/knowledge/goToParent?url=/workflow/secirityManager/getSecurityByIds&ids=' + dataId//数据接口
                        , page: { //支持传入 laypage 组件的所有参数（某些参数除外，如：jump/elem） - 详见文档
                            layout: ['prev', 'page', 'next', 'skip', 'count', 'limit',]//自定义分页布局
                            , limits: [10, 15, 20, 25, 30, 35, 40, 45, 50, 55, 60, 65, 70, 75, 80, 85, 90, 95, 100]
                            , first: false //不显示首页
                            , last: false //不显示尾页
                        } //开启分页
                        //, toolbar: '#toolbar'
                        , cols: [[ //表头
                            {type: 'checkbox'}
                            //, {field: 'securityDangerId',  title: 'ID'}
                            , {type: 'numbers', title: '序号',}
                            , {field: 'securityDanger',  title: '隐患标准'}
                            , {field: 'securityDangerMeasures', title: '整改措施'}
                            , {
                                field: 'securityDangerGrade',  title: '重大隐患', templet: function (d) {
                                    if (d.securityDangerGrade != undefined && d.securityDangerGrade != "") {
                                        if (d.securityDangerGrade === 0 || d.securityDangerGrade === "0") {
                                            return "<div><span style='color:#ff0000'>是</span></div>";
                                        } else {
                                            return "<div>否</div>";
                                        }
                                    } else {
                                        return "";
                                    }
                                }
                            }
                            // ,{width:250, title: '操作',align:'center', toolbar: '#barOperation'}
                        ]]
                        , limit: 10
                        , done: function (res) {

                        }
                    });
                }
            }else if (treeType =="targetTemplate") { //关键任务模板
                if (parData2.parentTypeId != 0) {
                    $('.layui-rt').show()
                    $('.tishi').hide()
                    table.render({
                        elem: '#Settlement2'
                        , url: '/knowledge/goToParent?url=/TemplateItem/findTemplateByTypeId'
                        , where: {
                            useFlag: true,
                            typeId:dataId
                        }
                        , page: true //开启分页
                        , limit: 50
                        //, height: 'full-180'
                        , toolbar: '#toolbar'
                        , defaultToolbar: ['']
                        , cols: [[ //表头
                            {type: 'checkbox'}
                            , {type: 'numbers', title: '序号',}
                            , {field: 'tgNo', title: '关键任务编号', width: 200}
                            , {field: 'tgName', title: '关键任务名称', event: 'detail', style: 'cursor: pointer;', width: 350}
                            , {
                                field: 'controlLevel', title: '关注等级', width: 150, templet: function (d) {
                                    return dictionaryObj['CONTROL_LEVEL']['object'][d.controlLevel] || ''
                                }
                            }
                            , {
                                field: 'tgGrade', title: '目标等级', width: 150, templet: function (d) {
                                    return dictionaryObj['TG_GRADE']['object'][d.tgGrade] || ''
                                }
                            }
                            , {field: 'resultStandard', title: '完成标准', width: 250}
                            , {field: 'hardDegree', title: '标准难度系数', width: 100}
                            , {
                                field: 'resultDict', title: '成果标准模板', width: 250, templet: function (d) {
                                    var resultDesc = ''
                                    if (d.resultDictList) {
                                        d.resultDictList.forEach(function (item, index) {
                                            resultDesc += item.dictName + ','
                                        })
                                    }
                                    return resultDesc
                                }
                            }
                            , {
                                field: 'mainCenterDeptName', title: '公司总部部门', width: 250, templet: function (d) {
                                    if (d.mainCenterDeptName) {
                                        return d.mainCenterDeptName.replace(/,$/, '')
                                    } else {
                                        return ''
                                    }
                                }
                            }
                            , {
                                field: 'mainAreaDept', title: '分/子公司部门', width: 250, templet: function (d) {
                                    return dictionaryObj['ORGANIZATION_TYPE']['object'][d.mainAreaDept] || ''
                                }
                            }
                            , {
                                field: 'mainProjectDept', title: '项目部责任部门', width: 250, templet: function (d) {
                                    return dictionaryObj['ORGANIZATION_TYPE']['object'][d.mainProjectDept] || ''
                                }
                            }
                            , {field: 'centerDuty', title: '公司总部职责', width: 100}
                            , {
                                field: 'centerDutyType', title: '公司总部职责类型', width: 100, templet: function (d) {
                                    return dictionaryObj['DUTY_TYPE']['object'][d.centerDutyType] || ''
                                }
                            }
                            , {field: 'areaDuty', title: '分/子公司部门职责', width: 100}
                            , {
                                field: 'areaDutyType', title: '分/子公司部门职责类型', width: 100, templet: function (d) {
                                    return dictionaryObj['DUTY_TYPE']['object'][d.areaDutyType] || ''
                                }
                            }
                            , {field: 'projectDuty', title: '项目部部门职责', width: 130}
                            , {
                                field: 'planStage', title: '计划阶段', width: 200, templet: function (d) {
                                    return dictionaryObj['PLAN_PHASE']['object'][d.planStage] || ''
                                }
                            }
                            , {
                                field: 'tgType', title: '关键任务类型', width: 200, templet: function (d) {
                                    return dictionaryObj['TG_TYPE']['object'][d.tgType] || ''
                                }
                            }
                            , {
                                field: 'forceCheck', title: '是否强制勾选', width: 130, templet: function (d) {
                                    if (d.forceCheck == 1) {
                                        return '是'
                                    } else if (d.forceCheck == 0) {
                                        return '否'
                                    } else {
                                        return ''
                                    }
                                }
                            }
                        ]], parseData: function (res) {
                            return {
                                "code": 0, //解析接口状态
                                "data": res.obj,//解析数据列表
                                "count": res.totleNum, //解析数据长度
                            };
                        },
                        request: {
                            pageName: 'page' //页码的参数名称，默认：page
                            , limitName: 'pageSize' //每页数据量的参数名，默认：limit
                        },
                        done: function () {
                            if ($('#tplTypeId').attr('disableYn') == 1) {
                                $('#import').css({
                                    'cursor': 'not-allowed',
                                    'background': '#C1C1C1'
                                })
                                $('#edit').css({
                                    'cursor': 'not-allowed',
                                    'background': '#C1C1C1'
                                })
                                $('#del').css({
                                    'cursor': 'not-allowed',
                                    'background': '#C1C1C1'
                                })
                                $('#forceCheck').css({
                                    'cursor': 'not-allowed',
                                    'background': '#C1C1C1'
                                })
                            }
                        }
                    });
                } else {
                    $('.layui-rt').hide()
                    $('.tishi').show()
                }
            }else if (treeType =="itemTemplate") { //子任务模板
                if (parData2.parentTypeId != 0) {
                    $('.layui-rt').show()
                    $('.tishi').hide()
                    table.render({
                        elem: '#Settlement2'
                        , url: '/knowledge/goToParent?url=/TaskTemplateItem/findTemplateByTypeId'
                        , where: {
                            useFlag: true
                        }
                        , page: true //开启分页
                        , limit: 50
                        , height: 'full-180'
                        , toolbar: '#toolbar'
                        , defaultToolbar: ['']
                        , cols: [[ //表头
                            {type: 'checkbox'}
                            , {type: 'numbers', title: '序号',}
                            , {field: 'taskNo', title: '子任务编号', width: 200}
                            , {field: 'taskName', title: '子任务名称', event: 'detail', style: 'cursor: pointer;', width: 350}
                            /*  , {
                                  field: 'controlLevel', title: '关注等级', width: 150, templet: function (d) {
                                      return dictionaryObj['CONTROL_LEVEL']['object'][d.controlLevel] || ''
                                  }
                              }*/
                            , {field: 'resultStandard', title: '完成标准', width: 250}
                            , {
                                field: 'resultDict', title: '成果标准模板', width: 250, templet: function (d) {
                                    var resultDesc = ''
                                    if (d.resultDictList) {
                                        d.resultDictList.forEach(function (item, index) {
                                            resultDesc += item.dictName + ','
                                        })
                                    }
                                    return resultDesc
                                }
                            }
                            , {field: 'hardDegree', title: '标准难度系数', width: 150}
                            /*,{field: 'mainCenterDeptName', title: '公司总部部门',width:250,templet: function (d) {
                                    if(d.mainCenterDeptName){
                                        return d.mainCenterDeptName.replace(/,$/, '')
                                    }else{
                                        return ''
                                    }
                                }}
                            ,{field: 'mainAreaDept', title: '分/子公司部门',width:250,templet: function (d) {
                                    return dictionaryObj['ORGANIZATION_TYPE']['object'][d.mainAreaDept] || ''
                                }}
                            ,{field: 'mainProjectDept', title: '项目部责任部门',width:300,templet: function (d) {
                                    return dictionaryObj['ORGANIZATION_TYPE']['object'][d.mainProjectDept] || ''
                                }}*/
                        ]], parseData: function (res) {
                            return {
                                "code": 0, //解析接口状态
                                "data": res.obj,//解析数据列表
                                "count": res.totleNum, //解析数据长度
                            };
                        },
                        request: {
                            pageName: 'page' //页码的参数名称，默认：page
                            , limitName: 'pageSize' //每页数据量的参数名，默认：limit
                        },
                        done: function () {
                            if ($('#ttaskTypeId').attr('disableYn') == 1) {
                                $('#import').css({
                                    'cursor': 'not-allowed',
                                    'background': '#C1C1C1'
                                })
                                $('#edit').css({
                                    'cursor': 'not-allowed',
                                    'background': '#C1C1C1'
                                })
                                $('#del').css({
                                    'cursor': 'not-allowed',
                                    'background': '#C1C1C1'
                                })
                            }
                        }
                    });
                } else {
                    $('.layui-rt').hide()
                    $('.tishi').show()
                }
            }else if (treeType == "checkTemplte") {//安全检查计划模板
                if (flag) {
                    layui.table.render({
                        elem: '#Settlement'
                        // , data: []
                        , url: '/knowledge/goToParent?url=/workflow/secirityManager/selectTemplteDetails&templteId='+dataId//数据接口
                        , page: { //支持传入 laypage 组件的所有参数（某些参数除外，如：jump/elem） - 详见文档
                            layout: ['prev', 'page', 'next', 'skip', 'count', 'limit',]//自定义分页布局
                            , limits: [10, 15, 20, 25, 30, 35, 40, 45, 50, 55, 60, 65, 70, 75, 80, 85, 90, 95, 100]
                            , first: false //不显示首页
                            , last: false //不显示尾页
                        } //开启分页
                        //,toolbar:'#formTable1toolbar'
                        , cols: [[ //表头
                            {type: 'checkbox'}
                            ,{type: 'numbers', title: '序号'}
                            ,{field:'detailsName',title:'名称'}
                            ,{field: 'securityKnowledgeName', title: '检查项'}
                            ,{field: 'securityDangerName', title: '检查内容'}
                            //,{title: '操作', align: 'center', width:100, toolbar: '#formTable1bar'}
                        ]]
                        , limit: 10
                        , done: function (res) {

                        }
                    });
                }
            }else if (treeType == "qualityDanger") {//质量控制点
                if (flag) {
                    layui.table.render({
                        elem: '#Settlement'
                        // , data: []
                        , url: '/knowledge/goToParent?url=/workflow/qualityManager/getQualityByIds&ids=' + dataId//数据接口
                        , page: { //支持传入 laypage 组件的所有参数（某些参数除外，如：jump/elem） - 详见文档
                            layout: ['prev', 'page', 'next', 'skip', 'count', 'limit',]//自定义分页布局
                            , limits: [10, 15, 20, 25, 30, 35, 40, 45, 50, 55, 60, 65, 70, 75, 80, 85, 90, 95, 100]
                            , first: false //不显示首页
                            , last: false //不显示尾页
                        } //开启分页
                        //, toolbar: '#toolbar'
                        , cols: [[ //表头
                            {type: 'checkbox'}
                            //, {field: 'securityDangerId',  title: 'ID'}
                            , {type: 'numbers', title: '序号',}
                            , {field: 'securityDanger',  title: '质量控制点'}
                            , {field: 'securityDangerMeasures', title: '整改措施'}
                            , {
                                field: 'securityDangerGrade',  title: '重大隐患', templet: function (d) {
                                    if (d.securityDangerGrade != undefined && d.securityDangerGrade != "") {
                                        if (d.securityDangerGrade === 0 || d.securityDangerGrade === "0") {
                                            return "<div><span style='color:#ff0000'>是</span></div>";
                                        } else {
                                            return "<div>否</div>";
                                        }
                                    } else {
                                        return "";
                                    }
                                }
                            }
                            // ,{width:250, title: '操作',align:'center', toolbar: '#barOperation'}
                        ]]
                        , limit: 10
                        , done: function (res) {

                        }
                    });
                }
            }else if (treeType == "qualityTemplte") {//质量检查计划模板
                if (flag) {
                    layui.table.render({
                        elem: '#Settlement'
                        // , data: []
                        , url: '/knowledge/goToParent?url=/workflow/qualityManager/selectTemplteDetails&templteId='+dataId//数据接口
                        , page: { //支持传入 laypage 组件的所有参数（某些参数除外，如：jump/elem） - 详见文档
                            layout: ['prev', 'page', 'next', 'skip', 'count', 'limit',]//自定义分页布局
                            , limits: [10, 15, 20, 25, 30, 35, 40, 45, 50, 55, 60, 65, 70, 75, 80, 85, 90, 95, 100]
                            , first: false //不显示首页
                            , last: false //不显示尾页
                        } //开启分页
                        //,toolbar:'#formTable1toolbar'
                        , cols: [[ //表头
                            {type: 'checkbox'}
                            ,{type: 'numbers', title: '序号'}
                            ,{field:'detailsName',title:'名称'}
                            ,{field: 'securityKnowledgeName', title: '检查项'}
                            ,{field: 'securityDangerName', title: '检查内容'}
                            //,{title: '操作', align: 'center', width:100, toolbar: '#formTable1bar'}
                        ]]
                        , limit: 10
                        , done: function (res) {

                        }
                    });
                }
            }else if (treeType =="workLibrary_task") { //任务管理-任务项库-关键任务模板
                table.render({
                    elem: '#Settlement2'
                    , url: '/knowledge/goToParent?url=/WorkItem/seldWorkItem&useFlag=true'//数据接口
                    , toolbar: '#toolbarDemo'
                    , page: true
                    //, height: 'full-220'
                    , limit: 50
                    , where: {
                        useFlag: true,
                        _: new Date().getTime()
                    }
                    , defaultToolbar: ['']
                    , cols: [[ //表头
                        {type: 'checkbox'}
                        , {type: 'numbers', title: '序号',}
                        , {field: 'tgNo', title: '工作项编号',}
                        , {field: 'tgName', title: '工作项名称', event: 'detail', style: 'cursor: pointer;'}
                        , {
                            field: 'controlLevel', title: '关注等级', templet: function (d) {
                                return dictionaryObj['CONTROL_LEVEL']['object'][d.controlLevel] || ''
                            }
                        }
                        , {
                            field: 'tgGrade', title: '目标等级', templet: function (d) {
                                return dictionaryObj['TG_GRADE']['object'][d.tgGrade] || ''
                            }
                        }
                        , {field: 'resultStandard', title: '完成标准',}
                        , {field: 'hardDegree', title: '标准难度系数',}
                        , {
                            field: 'resultDict', title: '成果标准模板', templet: function (d) {
                                var resultDesc = ''
                                if (d.resultDictList) {
                                    d.resultDictList.forEach(function (item, index) {
                                        resultDesc += item.dictName + ','
                                    })
                                }
                                return resultDesc
                            }
                        }
                        , {
                            field: 'mainCenterDeptName', title: '公司总部部门', templet: function (d) {
                                if (d.mainCenterDeptName) {
                                    return d.mainCenterDeptName.replace(/,$/, '')
                                } else {
                                    return ''
                                }
                            }
                        }
                        , {
                            field: 'centerDutyType', title: '公司总部职责类型', templet: function (d) {
                                return dictionaryObj['DUTY_TYPE']['object'][d.centerDutyType] || ''
                            }
                        }
                        , {
                            field: 'mainAreaDept', title: '分/子公司部门', templet: function (d) {
                                return dictionaryObj['ORGANIZATION_TYPE']['object'][d.mainAreaDept] || ''
                            }
                        }
                        , {
                            field: 'areaDutyType', title: '分/子公司部门职责类型', templet: function (d) {
                                return dictionaryObj['DUTY_TYPE']['object'][d.areaDutyType] || ''
                            }
                        }
                        , {
                            field: 'mainProjectDept', title: '项目部责任部门', templet: function (d) {
                                return dictionaryObj['ORGANIZATION_TYPE']['object'][d.mainProjectDept] || ''
                            }
                        }
                        , {
                            field: 'planStage', title: '计划阶段', templet: function (d) {
                                return dictionaryObj['PLAN_PHASE']['object'][d.planStage] || ''
                            }
                        }
                        , {
                            field: 'tgType', title: '关键任务类型', templet: function (d) {
                                return dictionaryObj['TG_TYPE']['object'][d.tgType] || ''
                            }
                        }
                        , {
                            field: 'forceCheck', title: '是否强制勾选', width: 130, templet: function (d) {
                                if (d.forceCheck == 1) {
                                    return '是'
                                } else if (d.forceCheck == 0) {
                                    return '否'
                                } else {
                                    return ''
                                }
                            }
                        }
                    ]]
                    , parseData: function (res) { //res 即为原始返回的数据
                        return {
                            "code": 0, //解析接口状态
                            "data": res.obj,//解析数据列表
                            "count": res.totleNum, //解析数据长度
                        };
                    },
                    request: {
                        pageName: 'page' //页码的参数名称，默认：page
                        , limitName: 'pageSize' //每页数据量的参数名，默认：limit
                    },
                });
            }else if (treeType =="workLibrary_item") { //任务管理-任务项库-子任务
                table.render({
                    elem: '#Settlement2'
                    , url: '/knowledge/goToParent?url=/TaskItem/seldWorkItem&useFlag=true'//数据接口
                    , toolbar: '#toolbarDemo'
                    , page: true
                    //, height: 'full-220'
                    , limit: 50
                    , where: {
                        useFlag: true,
                        _: new Date().getTime()
                    }
                    , defaultToolbar: ['']
                    , cols: [[ //表头
                        {type: 'checkbox'}
                        , {type: 'numbers', title: '序号',}
                        , {field: 'taskNo', title: '工作项编号',}
                        , {field: 'taskName', title: '工作项名称', event: 'detail', style: 'cursor: pointer;'}
                        , {field: 'resultStandard', title: '完成标准',}
                        , {
                            field: 'resultDict', title: '成果标准模板', templet: function (d) {
                                var resultDesc = ''
                                if (d.resultDictList) {
                                    d.resultDictList.forEach(function (item, index) {
                                        resultDesc += item.dictName + ','
                                    })
                                }
                                return resultDesc
                            }
                        }
                        , {field: 'hardDegree', title: '标准难度系数',}
                        /* ,{field: 'mainCenterDeptName', title: '公司总部部门',templet: function (d) {
								 if(d.mainCenterDeptName){
									 return d.mainCenterDeptName.replace(/,$/, '')
								 }else{
									 return ''
								 }
							 }}
						 ,{field: 'mainAreaDept', title: '分/子公司部门',templet: function (d) {
								 return dictionaryObj['ORGANIZATION_TYPE']['object'][d.mainAreaDept] || ''
							 }}
						 ,{field: 'mainProjectDept', title: '项目部责任部门',templet: function (d) {
								 return dictionaryObj['ORGANIZATION_TYPE']['object'][d.mainProjectDept] || ''
							 }}*/
                    ]]
                    , parseData: function (res) { //res 即为原始返回的数据
                        return {
                            "code": 0, //解析接口状态
                            "data": res.obj,//解析数据列表
                            "count": res.totleNum, //解析数据长度
                        };
                    },
                    request: {
                        pageName: 'page' //页码的参数名称，默认：page
                        , limitName: 'pageSize' //每页数据量的参数名，默认：limit
                    },
                });
            }
        }


    });
</script>
</body>
</html>

