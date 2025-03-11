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
    <title>文档查询</title>
    <link rel="stylesheet" href="/lib/layui/layui/css/layui.css?20210319.1">
    <link rel="stylesheet" href="/lib/layui/layui/css/common.css">
    <link rel="stylesheet" href="/lib/layui/layui/css/eleTree.css">
    <script src="/lib/layui/layui/layui.js"></script>
    <script type="text/javascript" src="/lib/layui/layui/global.js"></script>
    <script type="text/javascript" src="../../js/xoajq/xoajq1.js"></script>
    <script src="../../js/base/base.js" type="text/javascript" charset="utf-8"></script>
    <script src="/lib/layui/layui/js/common.js?v=20190726" type="text/javascript" charset="utf-8"></script>
    <script src="/lib/layui/layui/js/baseCode/base.js?v=2019080918:09" type="text/javascript" charset="utf-8"></script>
    <style>
        html,body{
            background: #fff;
        }
        .layui-card-header{
            border-bottom: 1px solid #eee;
        }
        .mbox{
            padding: 0;
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
        .layui-lf{
            min-width: 16%;
            overflow-x: auto;
            height: 600px !important;
        }
        .layui-rt{
            width: 84%;
            margin-left: 6px;
            margin-top: -10px;
        }
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
            width:200px;
            overflow-x: scroll;
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
        /*.rtfix::-webkit-scrollbar {!*滚动条整体样式*!*/
        /*width: 4px;     !*高宽分别对应横竖滚动条的尺寸*!*/
        /*height: 10px;*/
        /*}*/
        /*.rtfix::-webkit-scrollbar-button{*/
        /*background-color: #000;*/
        /*border:1px solid #ccc;*/
        /*display:block;*/
        /*}*/
        /*.rtfix::-webkit-scrollbar-thumb {!*滚动条里面小方块*!*/
        /*border-radius: 5px;*/
        /*-webkit-box-shadow: inset 0 0 5px rgba(0,0,0,0.2);*/
        /*background: rgba(0,0,0,0.2);*/
        /*}*/
        /*.rtfix::-webkit-scrollbar-track {!*滚动条里面轨道*!*/
        /*-webkit-box-shadow: inset 0 0 5px rgba(0,0,0,0.2);*/
        /*border-radius: 0;*/
        /*background: rgba(0,0,0,0.1);}*/
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
            margin-bottom: 5px!important;
        }
        .layui-form-label{
            width: 70px!important;
        }
        .mbox .layui-table-view{
            margin: 5px 0!important;
        }
        .ele1{
            overflow: hidden;
        }
    </style>
</head>
<body>
<div id="Confidential"></div>
<div class="mbox">
    <div class="layui-tab layui-tab-card" style="margin: 3px 0 10px 0;">
        <div id="clientSerch" style="height: 40px">
            <%--表格上方搜索栏--%>
            <form class="layui-form" action="" style="height: 40px">
                <div class="demoTable" style="height: 40px" >
                    <label style="float: left;height: 40px;line-height: 40px;margin: 0 10px;padding: 0 10px">查询字段</label>
                    <div class="layui-input-inline" style="float:left;margin-top: 4px">
                        <select name="serchSelect" id="serchSelect" lay-filter="columnName" placeholder="请选择" lay-search="" style="height: 10px">
                            <option value="0">请选择查询字段</option>
<%--                            <option value="docfileNo">文档编号</option>--%>
                            <option value="docfileName">文档名称</option>
                            <option value="docfileClass">文档等级</option>
                            <option value="columnId">知识类别</option>
                            <option value="keyWord">关键词</option>
                            <option value="createUserId">上传人</option>
                            <option value="serchTime">上传时间</option>
                            <option value="docfileDesc">文档摘要</option>
                        </select>
                    </div>
                    <div class="layui-input-inline" style="float: left;height: 32px;margin-top: 4px;">
                        <input class="layui-input" id="searchtext" autocomplete="off"  name="searchtext" style="height: 38px;margin-left: 6px;">
                        <input class="layui-input" readonly id="dsearchtext" autocomplete="off"  name="searchtext" style="display:none;height: 38px;margin-left: 6px;">
                        <input type="text" id="pele" pid name="ttitle" required="" style="cursor: pointer;display:none;" placeholder="请选择" readonly="" autocomplete="off" class="layui-input">
                        <div class="eleTree ele1" lay-filter="data1" style="display:none;position:absolute;border: 1px solid #d2d2d2;overflow-y: auto;background-color: #fff;border-radius: 2px;box-shadow: 0 2px 4px rgba(0,0,0,.12);box-sizing: border-box;overflow:hidden;z-index: 999;top:38px;left:0px;width: 100%;"></div>
                        <div id="selha" style="display: none">
                            <select name="docfileClass" id="docfileClass" ></select></div>
                    </div>
                    <div class="layui-input-inline" style="float: left;height: 32px;margin-top: 4px;">
                        <a class="layui-btn" data-type="reload" lay-event="searchCust" id="searchCust" style="float:left;height:32px;line-height: 32px;margin-left: 10px">搜索</a>
                        <a class="layui-btn" data-type="reload" lay-event="adSearch" id="adSearch" style="float:left;height:32px;line-height: 32px;margin-left: 10px" >高级搜索</a>
                    </div>
                </div>
            </form>
        </div>
        <table id="Settlement" lay-filter="SettlementFilter"></table>
    </div>
</div>
<script type="text/html" id="barOperation">
    <a class="layui-btn layui-btn-xs" lay-event="info" >详情</a>
    <a class="layui-btn layui-btn-xs" lay-event="detail" >查看</a>
    <a class="layui-btn layui-btn-xs" lay-event="down" >下载</a>
</script>
<%----------------------------------------------------数据操作--------------------------------------------------------------------------%>

<script type="text/javascript">
    function getUrlParam(name){
        var reg = new RegExp(name +"=(.*?)((?=&|$))"); //构造一个含有目标参数的正则表达式对象
        var r = window.location.href.match(reg); //匹配目标参数
        if (r!=null) return unescape(r[1]); return null; //返回参数值
    }
    var columnId = parent.columnTrId;
    var SettlementTable;

    layui.use(['table','layer','form','laydate','element','eleTree','upload'], function() {
        var table = layui.table;
        var layer = layui.layer;
        var form = layui.form;
        var eleTree = layui.eleTree;
        var element = layui.element;
        var $ = layui.jquery;
        var upload = layui.upload;
        var laydate = layui.laydate;

        // 树右侧表格实例
        SettlementTable = layui.table.render({
            elem: '#Settlement'
            // , data: []
            , url: '/fileManage/getFile'//数据接口
            , page: { //支持传入 laypage 组件的所有参数（某些参数除外，如：jump/elem） - 详见文档
                layout: ['prev', 'page', 'next', 'skip', 'count', 'limit',]//自定义分页布局
                , limits: [10, 15, 20, 25, 30, 35, 40, 45, 50, 55, 60, 65, 70, 75, 80, 85, 90, 95, 100]
                , first: false //不显示首页
                , last: false //不显示尾页
            } //开启分页
            , cols: [[ //表头
                {field: 'docfileId', title: 'ID'}
                //, {field: 'docfileNo', title: '文档编号'}
                , {field: 'docfileName', title: '文档名称'}
                , {field: 'keyWord', title: '关键词'}
                , {field: 'docfileClass', title: '文档等级'}
                , {field: 'createUserId', title: '上传人'}
                , {field: 'createTime', title: '上传时间'}
                // , {field: 'downloadPassword', title: '下载密码'}
                , {field: 'docfileDesc', title: '文档摘要'}
                , {field: 'columnName', title: '知识类别'}
                ,{width:200, title: '操作',align:'center', toolbar: '#barOperation'}
            ]]
            , limit: 10
            , done: function (res) {
            }
        });
        var $select1 = $("select[name='docfileClass']");
        var optionStr = '<option value="">请选择</option>';
        $.ajax({ //查询文档等级
            url: '/code/getCode?parentNo=KNOWLEDGE_DOCFILE_CLASS',
            type: 'get',
            dataType: 'json',
            async:false,
            success: function (res) {
                if(res.obj!=undefined&&res.obj.length>0){
                    for(var i=0;i<res.obj.length;i++){
                        optionStr += '<option value="' + res.obj[i].codeNo + '">' + res.obj[i].codeName + '</option>'
                    }
                }
            }
        })
        $select1.html(optionStr);
        form.render();//初始化表单
        form.on('select(columnName)',function (data) {
            if(data.value=="serchTime"){
                laydate.render({
                    elem: '#dsearchtext'
                    , trigger: 'click'
                    , format: 'yyyy-MM-dd'
                    // , format: 'yyyy-MM-dd HH:mm:ss'
                });
                $("#searchtext").hide();
                $("#pele").hide();
                $("#dsearchtext").show();
                $("#selha").hide();
            }else if(data.value=="columnId") {
                $("#searchtext").hide();
                $("#pele").show();
                $("#dsearchtext").hide();
                $("#selha").hide();
            }else if(data.value=="docfileClass"){
                $("#searchtext").hide();
                $("#dsearchtext").hide();
                $("#pele").hide();
                $("#selha").show();
            } else{
                $("#searchtext").show();
                $("#dsearchtext").hide();
                $("#pele").hide();
                $("#selha").hide();
            }
        })
        //表格行操作事件
        table.on('tool(SettlementFilter)', function(obj){ //注：tool 是工具条事件名，test 是 table 原始容器的属性 lay-filter="对应的值"
            var data = obj.data; //获得当前行数据
            var layEvent = obj.event; //获得 lay-event 对应的值（也可以是表头的 event 参数对应的值）
            var tr = obj.tr; //获得当前行 tr 的 DOM 对象（如果有的话）
            if(layEvent === 'detail'){ //查看
                if(data.attachmentId==undefined||data.attachmentId==''){
                    layer.msg("文件损坏或未上传文件")
                }else{
                    selectFile1(data.attachmentId,"knowledge");
                }
            } else if(layEvent === 'down'){ //下载
                if(data.attachmentId==undefined||data.attachmentId==''){
                    layer.msg("文件损坏或未上传附件")
                }else{
                    window.location.href = "/equipment/limsDownload?model=knowlage&attachId=" +data.attachmentId
                }
            }else if(layEvent === 'info'){ //查看详情
                var index = layer.open({
                    type: 1,
                    skin: 'layui-layer-molv', //加上边框
                    area: ['80%', '80%'], //宽高
                    title: '文档详情',
                    maxmin: true,
                    btn: ['确定'],
                    content: '<div class="layui-form" >' +
                        '<div class="inbox"><label class="layui-form-label" style="width: 100px;">文档名称</label><div class="layui-input-block" style="margin-left: 130px;">' +
                        //'<button type="button" class="layui-btn" id="but_chose" style=" float: right"> <i class="layui-icon">&#xe67c;</i>选择文件 </button>' +
                        '<input disabled id="docfileName" name="docfileName" class="layui-input"></div></div>' +
                        '<div class="inbox"><label class="layui-form-label" style="width: 100px;">知识类别</label><div class="layui-input-block" style="margin-left: 130px;">' +
                        '<input disabled id="pele" pid name="ttitle" required="" style="cursor: pointer" lay-verify="required" readonly="" autocomplete="off" class="layui-input">' +
                        '<div class="eleTree ele1" lay-filter="data1" style="display:none;position:absolute;border: 1px solid #d2d2d2;overflow-y: auto;background-color: #fff;border-radius: 2px;box-shadow: 0 2px 4px rgba(0,0,0,.12);box-sizing: border-box;overflow:hidden;z-index: 999;top:38px;left:0px;width: 100%;"></div></div></div>' +
                        //'<div class="inbox"><label class="layui-form-label" style="width: 100px;">文档编号</label><div class="layui-input-block" style="margin-left: 130px;">' +
                        //'<input disabled class="layui-input" lay-verify="required" name="docfileNo" id="docfileNo"></div></div>' +
                        '<div class="inbox"><label class="layui-form-label" style="width: 100px;">关键词</label><div class="layui-input-block" style="margin-left: 130px;">' +
                        '<input disabled class="layui-input"  lay-verify="required" name="keyWord" id="keyWord"></div></div>' +
                        //'<div class="inbox"><label class="layui-form-label" style="width: 100px;"><span class="red">*</span>下载密码</label><div class="layui-input-block" style="margin-left: 130px;">' +
                        //'<input class="layui-input"  lay-verify="required" name="downloadPassword" id="downloadPassword"></div></div>' +
                        '<div class="inbox"><label class="layui-form-label" style="width: 100px;"><span class="red">*</span>文档等级</label><div class="layui-input-block" style="margin-left: 130px;">' +
                        '<select disabled name="docfileClass" lay-verify="required"></select></div></div>' +
                        //'<div class="inbox"><label class="layui-form-label" style="width: 100px;">下载地址</label><div class="layui-input-block" style="margin-left: 130px;">' +
                        //'<input disabled class="layui-input"  lay-verify="required" name="downloadKey" id="downloadKey"></div></div>' +
                        '<div class="inbox"><label class="layui-form-label" style="width: 100px;">文档摘要</label><div class="layui-input-block" style="margin-left: 130px;">' +
                        '<textarea readonly name="docfileDesc" id="docfileDesc" style="width: 100%;height:100px"></textarea></div></div>' +
                        '<div class="layui-form-item layui-hide"><input type="button" lay-submit lay-filter="add-file-submit" id="add-file-submit" value="确认"></div>' +
                        //'<button hidden id="uploadButton"></button>'+
                        //'<input hidden id="attachmentId" name="attachmentId"/>'+
                        //'<input hidden id="attachmentName" name="attachmentName"/>'+
                        '</div>',
                    success: function () {
                        var $select1 = $("select[name='docfileClass']");
                        var optionStr = '<option value="">请选择</option>';
                        $.ajax({ //查询文档等级
                            url: '/code/getCode?parentNo=KNOWLEDGE_DOCFILE_CLASS',
                            type: 'get',
                            dataType: 'json',
                            async:false,
                            success: function (res) {
                                if(res.obj!=undefined&&res.obj.length>0){
                                    for(var i=0;i<res.obj.length;i++){
                                        if(res.obj[i].codeName==data.docfileClass){
                                            optionStr += '<option  selected value="' + res.obj[i].codeNo + '">' + res.obj[i].codeName + '</option>'
                                        }else{
                                            optionStr += '<option value="' + res.obj[i].codeNo + '">' + res.obj[i].codeName + '</option>'
                                        }
                                    }
                                }
                            }
                        })
                        $select1.html(optionStr);//文档等级
                        $("#docfileName").val(undefind_nullStr(data.docfileName));//文档名称
                        $("#keyWord").val(undefind_nullStr(data.keyWord));//关键词
                        debugger
                        $("#pele").val(undefind_nullStr("data.columnName"));//栏目名称
                        $("#pele").val()
                        //$("#docfileNo").val(undefind_nullStr(data.docfileNo));//文档编号
                        $("#docfileDesc").text(undefind_nullStr(data.docfileDesc));//文档摘要
                        $("#downloadKey").val(undefind_nullStr(data.downloadAddress));//下载地址
                        form.render();//初始化表单
                    },
                    yes: function (index, layero) {
                        layer.close(index)
                    }
                });
            }
        });
        //头工具栏事件
        $('#searchCust').click(function () {
            var serchSelect = $("#serchSelect").next(".layui-form-select").find("dl dd.layui-this").attr("lay-value"); //下拉列表的值
            if(serchSelect == "serchTime"){
                var searchtext = $("#dsearchtext").val();
            }else{
                var searchtext = $("#searchtext").val(); //输入框的值
            }
            if(serchSelect == "docfileClass"){
                var searchtext = $("#docfileClass").next(".layui-form-select").find("dl dd.layui-this").attr("lay-value");
            }
            var serchObjUrl = "/subscribe/search?"+serchSelect+"="+searchtext;
            //栏目类别用的搜索
            if(serchSelect == "columnId"){
                var searchtext =$("#pele").attr("pid");
                var syscode = $("#pele").attr("syscode");
                serchObjUrl = "/subscribe/search?"+serchSelect+"="+searchtext+"&isSysCode="+syscode;
            }
            if((searchtext==''&&serchSelect=='0') || (searchtext==''&&serchSelect==0)){ //两个都为空查询全部
                table.reload("Settlement",{
                    url: serchObjUrl
                });
            }else if((searchtext!=""&&serchSelect=='0') || (searchtext!=""&&serchSelect==0)){ //只输入，没有选择
                layer.msg("请选择查询条件");
            }else{
                table.reload("Settlement",{
                    url: serchObjUrl
                })
            }
        })
        var str ='<form class="layui-form" id="formBox1" action="" lay-filter="formTest1">\n' +
            // '            <div class="layui-form-item" style="margin:10px 0;display: inline-block">\n' +
            // '                <div class="layui-inline">\n' +
            // '                    <label class="layui-form-label">文档编号</label>\n' +
            // '                    <div class="layui-input-inline">\n' +
            // '                        <input type="text" id="docfileNo" name="docfileNo" autocomplete="off" class="layui-input">\n' +
            // '                    </div>\n' +
            // '                </div>\n' +
            // '            </div>\n' +
            '            <div class="layui-form-item" style="margin:10px 0;display: inline-block">\n' +
            '                <div class="layui-inline">\n' +
            '                    <label class="layui-form-label">文档名称</label>\n' +
            '                    <div class="layui-input-inline">\n' +
            '                        <input type="text" id="docfileName" name="docfileName" autocomplete="off" class="layui-input">\n' +
            '                    </div>\n' +
            '                </div>\n' +
            '            </div>\n' +
            '            <div class="layui-form-item" style="margin:10px 0;display: inline-block">\n' +
            '                <div class="layui-inline">\n' +
            '                    <label class="layui-form-label">文档等级</label>\n' +
            '                    <div class="layui-input-inline">\n' +
            '                        <select name="docfileClass1" id="docfileClass1"></select>' +
            '                    </div>\n' +
            '                </div>\n' +
            '            </div>\n' +
            '           <div class="layui-form-item" style="margin:10px 0;display: inline-block">\n' +
            '                <div class="layui-inline">\n' +
            '                    <label class="layui-form-label">知识类别</label>\n' +
            '                    <div class="layui-input-inline">\n' +
            '                        <input type="text" id="pele" pid name="ttitle1" required="" style="cursor: pointer;" placeholder="请选择" readonly="" autocomplete="off" class="layui-input">\n' +
            '                        <div class="eleTree ele2" lay-filter="data2" style="display:none;position:absolute;border: 1px solid #d2d2d2;overflow-y: auto;background-color: #fff;border-radius: 2px;box-shadow: 0 2px 4px rgba(0,0,0,.12);box-sizing: border-box;overflow:hidden;z-index: 999;top:38px;left:0px;width: 100%;"></div>\n' +
            '                    </div>\n' +
            '                </div>\n' +
            '            </div>\n' +
            '            <div class="layui-form-item" style="margin:10px 0;display: inline-block">\n' +
            '                <div class="layui-inline">\n' +
            '                    <label class="layui-form-label">关键词</label>\n' +
            '                    <div class="layui-input-inline">\n' +
            '                        <input type="text" id="keyWord" name="keyWord" autocomplete="off" class="layui-input">\n' +
            '                    </div>\n' +
            '                </div>\n' +
            '            </div>\n' +
            '            <div class="layui-form-item" style="margin:10px 0;display: inline-block">\n' +
            '                <div class="layui-inline">\n' +
            '                    <label class="layui-form-label">上传人</label>\n' +
            '                    <div class="layui-input-inline">\n' +
            '                        <input type="text" id="createUserId" name="createUserId" autocomplete="off" class="layui-input">\n' +
            '                    </div>\n' +
            '                </div>\n' +
            '            </div>\n' +
            '            <div class="layui-form-item" style="margin:10px 0;display: inline-block">\n' +
            '                <div class="layui-inline">\n' +
            '                    <label class="layui-form-label">上传时间</label>\n' +
            '                    <div class="layui-input-inline">\n' +
            '                        <input type="text" readonly id="beginTime" style="display: inline-block;width:88px;" name="beginTime" autocomplete="off" class="layui-input">到<input type="text" style="display: inline-block;width:88px;" readonly id="endTime" name="endTime" autocomplete="off" class="layui-input">\n' +
            '                    </div>\n' +
            '                </div>\n' +
            '            </div>\n' +
            '            <div class="layui-form-item" style="margin:10px 0;display: inline-block">\n' +
            '                <div class="layui-inline">\n' +
            '                    <label class="layui-form-label">文档摘要</label>\n' +
            '                    <div class="layui-input-inline">\n' +
            '                        <input type="text" id="docfileDesc" name="docfileDesc" autocomplete="off" class="layui-input">\n' +
            '                    </div>\n' +
            '                </div>\n' +
            '            </div>\n' +
            '</form>'
        $('#adSearch').click(function () {
            layer.open({
                type: 1
                , title: ['高级搜索', 'font-size:18px;']
                , maxmin: true
                , area: ['60%', '80%']
                , btn: ['搜索', '关闭']
                , content:  str
                ,success: function (res) {
                    laydate.render({
                        elem: '#beginTime' //指定元素
                        , trigger: 'click'
                        ,type: 'datetime'
                    });
                    laydate.render({
                        elem: '#endTime' //指定元素
                        , trigger: 'click'
                        ,type: 'datetime'
                    });
                    var el;
                    $("[name='ttitle1']").on("click",function (e) {
                        e.stopPropagation();
                        if(!el){
                            el=eleTree.render({
                                elem: '.ele2',
                                url:'/knowledge/childTree',
                                expandOnClickNode: false,
                                highlightCurrent: true,
                                showLine:true,
                                showCheckbox: true,
                                checked: true,
                                done: function(res){
                                    // var arr1 = [];
                                    // var arr2 = res.obj;
                                    // for(var i =0;i<res.data.length;i++){
                                    //     arr1.push(res.data[i].id);
                                    // }
                                    // for(var i =0;i<arr1.length;i++){
                                    //     for(var j=0;j<arr2.length;j++){
                                    //         if(arr1[i] == arr2[j]){
                                    //             $("div[data-id="+arr2[j]+"]").find("input").attr("disabled",true);
                                    //             $("div[data-id="+arr2[j]+"]").find("input").attr("eletree-status","0");
                                    //             $("div[data-id="+arr2[j]+"]").find("input").addClass("eleTree-disabled");
                                    //             $("div[data-id="+arr2[j]+"]").find("input").next("div.eleTree-checkbox").addClass("eleTree-checkbox-disabled");
                                    //         }
                                    //     }
                                    // }
                                }
                            });
                        }
                        $(".ele2").slideDown();
                    })
                    // eleTree.on("nodeClick(data1)",function(d) {
                    //     $("[name='ttitle']").val(d.data.currentData.label)
                    //     // $("#pele").attr("pid",d.data.currentData.id)
                    //     PcolumnId = d.data.currentData.id;
                    //     $(".ele1").slideUp();
                    // })
                    $(document).on("click",function() {
                        $(".ele2").slideUp();
                    })
                    //选中监听事件
                    var arr = [];
                    var arr1 = [];
                    var arr2 = [];
                    eleTree.on("nodeChecked(data2)",function(d) {
                        var id = d.data.currentData.columnId;
                        if(id == undefined){
                            id = d.data.currentData.columnType;
                        }
                        var label = d.data.currentData.label;
                        var syscode = d.data.currentData.sysCode;
                        if(d.isChecked == true || d.isChecked == "true"){
                            arr.push(id);
                            arr1.push(label);
                            arr2.push(syscode);
                        }else{
                            arr.remove(id);
                            arr1.remove(label);
                            arr2.remove(syscode);
                        }
                        var str = "";
                        var str1 = "";
                        var str2 = "";
                        for(var i=0;i<arr.length;i++){
                            str+=arr[i]+","
                            str1+=arr1[i]+","
                            str2+=arr2[i]+","
                        }
                        $("[name='ttitle1']").val(str1);
                        $("#pele").attr("pid",str);
                        $("#pele").attr("syscode",str2);
                    })

                    var $select1 = $("select[name='docfileClass1']");
                    var optionStr = '<option value="">请选择</option>';
                    $.ajax({ //查询文档等级
                        url: '/code/getCode?parentNo=KNOWLEDGE_DOCFILE_CLASS',
                        type: 'get',
                        dataType: 'json',
                        async:false,
                        success: function (res) {
                            if(res.obj!=undefined&&res.obj.length>0){
                                for(var i=0;i<res.obj.length;i++){
                                    optionStr += '<option value="' + res.obj[i].codeNo + '">' + res.obj[i].codeName + '</option>'
                                }
                            }
                        }
                    })
                    $select1.html(optionStr);
                    form.render();//初始化表单

                }
                , yes: function (index, layero) {
                    //$("input[name='docfileNo']").val() == ""&&
                    if($("input[name='docfileName']").val() == ""
                        &&$("#docfileClass").next(".layui-form-select").find("dl dd.layui-this").attr("lay-value") == ""
                        &&$("#pele").attr("pid") == ""
                        &&$("input[name='keyWord']").val() == ""
                        &&$("input[name='createUserId']").val()==""
                        &&$("input[name='docfileDesc']").val() == ""
                        &&$("input[name='beginTime']").val() == ""
                        &&$("input[name='endTime']").val() == ""
                    ){
                        layer.msg("请输入查询信息")
                        return;
                    }
                    layer.close(index)
                    table.reload("Settlement",{
                        url: '/subscribe/search',
                        //docfileNo:$("input[name='docfileNo']").val(),
                        where:{
                            docfileName:$("input[name='docfileName']").val(),
                            docfileClass:$("#docfileClass1").next(".layui-form-select").find("dl dd.layui-this").attr("lay-value"),
                            columnId:$("#pele").attr("pid"),
                            isSysCode:$("#pele").attr("syscode"),
                            keyWord:$("input[name='keyWord']").val(),
                            createUserId:$("input[name='createUserId']").val(),
                            beginTime:$("input[name='beginTime']").val(),
                            endTime:$("input[name='endTime']").val(),
                            docfileDesc:$("input[name='docfileDesc']").val()
                        }
                    })
                }
            });
        });
        var el;
        $("[name='ttitle']").on("click",function (e) {
            e.stopPropagation();
            if(!el){
                el=eleTree.render({
                    elem: '.ele1',
                    url:'/knowledge/childTree',
                    expandOnClickNode: false,
                    highlightCurrent: true,
                    showLine:true,
                    showCheckbox: true,
                    checked: true,
                    done: function(res){
                        // var arr1 = [];
                        // var arr2 = res.obj;
                        // for(var i =0;i<res.data.length;i++){
                        //     arr1.push(res.data[i].id);
                        // }
                        // for(var i =0;i<arr1.length;i++){
                        //     for(var j=0;j<arr2.length;j++){
                        //         if(arr1[i] == arr2[j]){
                        //             $("div[data-id="+arr2[j]+"]").find("input").attr("disabled",true);
                        //             $("div[data-id="+arr2[j]+"]").find("input").attr("eletree-status","0");
                        //             $("div[data-id="+arr2[j]+"]").find("input").addClass("eleTree-disabled");
                        //             $("div[data-id="+arr2[j]+"]").find("input").next("div.eleTree-checkbox").addClass("eleTree-checkbox-disabled");
                        //         }
                        //     }
                        // }
                    }
                });
            }
            $(".ele1").slideDown();
        })
        // eleTree.on("nodeClick(data1)",function(d) {
        //     $("[name='ttitle']").val(d.data.currentData.label)
        //     // $("#pele").attr("pid",d.data.currentData.id)
        //     PcolumnId = d.data.currentData.id;
        //     $(".ele1").slideUp();
        // })
        $(document).on("click",function() {
            $(".ele1").slideUp();
        })
        //选中监听事件
        var arr = [];
        var arr1 = [];
        var arr2 = [];
        eleTree.on("nodeChecked(data1)",function(d) {
            var id = d.data.currentData.columnId;
            if(id == undefined){
                id = d.data.currentData.columnType;
            }
            var label = d.data.currentData.label;
            var syscode = d.data.currentData.sysCode;
            if(d.isChecked == true || d.isChecked == "true"){
                arr.push(id);
                arr1.push(label);
                arr2.push(syscode);
            }else{
                arr.remove(id);
                arr1.remove(label);
                arr2.remove(syscode);
            }
            var str = "";
            var str1 = "";
            var str2 = "";
            for(var i=0;i<arr.length;i++){
                str+=arr[i]+","
                str1+=arr1[i]+","
                str2+=arr2[i]+","
            }
            $("[name='ttitle']").val(str1);
            $("#pele").attr("pid",str);
            $("#pele").attr("syscode",str2);
        })
    })

    //查看附件
    function selectFile1(attchId,model) {
        if(attchId){
            //查看附件
            var data={
                attachId:attchId,
                model:model
            }
            var res=toAjaxT1("/equipment/selectAttchUrl",data);
            if(res.code==0){
                if(res.object){
                    limsPreview1(res.object);
                }
            }
        }

    }
    //附件预览点击调取
    function limsPreview1(attrUrl) {
        var url = '';
        if(attrUrl != undefined&&attrUrl.indexOf('&ATTACHMENT_NAME=') > -1){
            var atturl1 = attrUrl.split('&ATTACHMENT_NAME=')[0] + '&ATTACHMENT_NAME=';
            var atturl2 = '';
            if(attrUrl.split('&ATTACHMENT_NAME=')[1] != undefined&&attrUrl.split('&ATTACHMENT_NAME=')[1].indexOf('&') > -1){
                for(var i=1;i<attrUrl.split('&ATTACHMENT_NAME=')[1].split('&').length;i++){
                    atturl2 += '&' + attrUrl.split('&ATTACHMENT_NAME=')[1].split('&')[i];
                }
                url = atturl1 + atturl2;
            }else{
                url = atturl1;
            }
        }
        if(limsUrlGetRequest('?'+attrUrl) == 'pdf' || limsUrlGetRequest('?'+attrUrl) == 'PDF'){
            layui.layer.open({
                type: 2,
                title: '预览',
                offset:["20px",""],
                content: "/pdfPreview?"+url,
                area: ['80%', '80%']
            })
            // $.popWindow("/pdfPreview?"+url,PreviewPage,'0','0','1200px','600px');
        }else if(limsUrlGetRequest('?'+attrUrl) == 'png' || limsUrlGetRequest('?'+attrUrl) == 'PNG'|| limsUrlGetRequest('?'+attrUrl) == 'jpg' || limsUrlGetRequest('?'+attrUrl) == 'JPG'|| limsUrlGetRequest('?'+attrUrl) == 'txt'|| limsUrlGetRequest('?'+attrUrl) == 'TXT'){
            layui.layer.open({
                type: 2,
                title: '预览',
                content: "/xs?"+url,
                offset:["20px",""],
                area: ['80%', '80%'],
                success:function(layero, index){
                    var iframeWindow = window['layui-layer-iframe'+ index];
                    var doc = $(iframeWindow.document);
                    doc.find('img').css("width","100%");
                }
            })
            // $.popWindow("/xs?"+url,PreviewPage,'0','0','1200px','600px');
        }else{
            pdurl1(limsUrlGetRequest('?'+attrUrl),attrUrl)
            // $.ajax({
            //     type:'get',
            //     url:'/sysTasks/getOfficePreviewSetting',
            //     dataType:'json',
            //     success:function (res) {
            //         if(res.flag){
            //             var strOfficeApps = res.object.previewUrl;//在线预览服务地址
            //             if(strOfficeApps == ''){
            //                 strOfficeApps = 'https://view.officeapps.live.com';
            //             }
            //             layui.layer.open({
            //                 type: 2,
            //                 title: '预览',
            //                 offset:["20px",""],
            //                 content: strOfficeApps+'/op/view.aspx?src='+domains+'/download?'+encodeURIComponent(url),
            //                 area: ['80%', '80%']
            //             })
            //             // $.popWindow(strOfficeApps+'/op/view.aspx?src='+domains+'/download?'+encodeURIComponent(url),'','0','0','1200px','600px')
            //         }
            //     }
            // })

        }
    }
    //同步
    function toAjaxT1(url,data) {
        var result;
        $.ajax({
            url:url,
            data:data,
            type: 'post',
            async:false,
            dataType: 'json',
            success: function (res){
                result=res;
            }
        });
        return result;
    }
    //截取附件文件后缀
    function limsUrlGetRequest(name) {
        var attach=name
        return attach.substring(attach.lastIndexOf(".")+1,attach.length);
    }
    function pdurl1(gs,atturl){ //根据后缀判断选择调取那种打开方式
        if(atturl != undefined&&atturl.indexOf('&ATTACHMENT_NAME=') > -1){
            var atturl1 = atturl.split('&ATTACHMENT_NAME=')[0] + '&ATTACHMENT_NAME=';
            var atturl2 = '';
            if(atturl.split('&ATTACHMENT_NAME=')[1] != undefined&&atturl.split('&ATTACHMENT_NAME=')[1].indexOf('&') > -1){
                for(var i=1;i<atturl.split('&ATTACHMENT_NAME=')[1].split('&').length;i++){
                    atturl2 += '&' + atturl.split('&ATTACHMENT_NAME=')[1].split('&')[i];
                }
                atturl = atturl1 + atturl2;
            }else{
                atturl = atturl1;
            }
        }
        if(gs == 'png'||gs == 'jpg'||gs == 'bmp' || gs == 'emf' || gs == 'gif'|| gs == 'pcx'|| gs == 'pcd'|| gs == 'ai'|| gs == 'webp'|| gs == 'WMF'|| gs == 'dxf' ||gs == 'PNG'||gs == 'JPG'||gs == 'BMP' || gs == 'EMF' || gs == 'GIF'|| gs == 'PCX'|| gs == 'PCD'|| gs == 'AI'|| gs == 'WEBP'|| gs == 'wmf'|| gs == 'DXF'|| gs == 'txt'|| gs == 'TXT'){
            $.popWindow("/xs?"+atturl,PreviewPage,'0','0','1200px','600px');
        }else if(gs == 'mp4'||gs == 'rmvb'||gs == 'avi'||gs == 'ifo'||gs == 'wmv'||gs == 'MP4'||gs == 'RMVB'||gs == 'AVI'||gs == 'IFO'||gs == 'WMV'){
            layer.open({type: 2, title: false, area: ['630px', '360px'], shade: 0.8, closeBtn: 0, shadeClose: true, content: "/common/video?videoatturlsplit="+atturl});
            layer.msg('点击任意处关闭');
        }else if(gs == 'pdf'||gs == 'PDF'){
            $.popWindow("/pdfPreview?"+atturl,PreviewPage,'0','0','1200px','600px');
        }else if(gs == 'ofd'|| gs=='OFD'||gs == 'oFD'||gs == 'oFd'){
            $.popWindow("../../lib/ofdViewer/viewer.html?file="+'/download?'+atturl , PreviewPage, '0', '0', '1200px', '600px')
        }else{
            var url = "/common/webOfficeView?documentEditPriv=0&fomat="+gs+"&"+atturl;
            $.ajax({
                url:'/syspara/selectTheSysPara?paraName=OFFICE_EDIT',
                type:'post',
                datatype:'json',
                async:false,
                success: function (res) {
                    if(res.flag){
                        if(res.object[0].paraValue == 0){
                            //默认加载NTKO插件 进行跳转
                            url = "/common/ntkoview?documentEditPriv=0&fomat="+gs+"&"+atturl;
                        }else if(res.object[0].paraValue == 2){
                            //默认加载NTKO插件 进行跳转
                            url = "/wps/info?"+ atturl +"&permission=read";
                        }else if(res.object[0].paraValue == 3){
                            //默认加载onlyoffice插件 进行跳转
                            url = "/common/onlyoffice?"+ atturl +"&edit=false";
                        }
                    }

                }
            })
            setTimeout(function(){
                $.popWindow(url,PreviewPage,'0','0','1200px','600px');
            }, 1000);
        }
    }
    function undefind_nullStr(value) {
        if(value==undefined){
            return ""
        }
        return value
    }
    $.ajax({
        type:'get',
        url:'/syspara/selectTheSysPara?paraName=IS_SHOW_JMJ',
        dataType:'json',
        success:function (res) {
                var data=res.object[0]
                if (data.paraValue!=0){
                    $('#Confidential').append('<span style="color: red;font-family: Microsoft YaHei;font-weight: bolder;font-size: 16pt;margin-left: 20px;margin-top: 10px;"> 机密级★ </span>')
                }
        }
    })
</script>
</body>
</html>
