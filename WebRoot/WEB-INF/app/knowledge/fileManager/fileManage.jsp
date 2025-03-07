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
    <title>文档管理</title>
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
            padding: 0px;
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
            margin-top:0px;
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
            margin-bottom: 5px; !important;
        }
        .layui-form-label{
            width: 70px; !important;
        }
        .textAreaBox{
            width: 100%;
            max-width: 100%;
            cursor: pointer;
            margin: 0px;
            overflow-y:visible;
            min-height: 37px;
        }
    </style>
</head>
<body>
<div id="Confidential"></div>
<div class="mbox">
    <div class="layui-tab layui-tab-card" style="margin: 3px 0 10px 0;">
        <table id="Settlement" lay-filter="SettlementFilter"></table>
    </div>
</div>

<script type="text/html" id="toolbar">
    <div class="layui-btn-container">
        <button class="layui-btn layui-btn-sm" lay-event="upfile" style="width: 100px" id="">上传文件</button>
        <button class="layui-btn layui-btn-sm layui-btn-danger" lay-event="delete" style="width: 60px">删除</button>
    </div>
</script>
<script type="text/html" id="barOperation">
    <a class="layui-btn layui-btn-xs" lay-event="edit" >编辑</a>
    <a class="layui-btn layui-btn-xs" lay-event="info" >详情</a>
    <a class="layui-btn layui-btn-xs" lay-event="detail" >查看</a>
    <a class="layui-btn layui-btn-xs" lay-event="down" >下载</a>
</script>
<%----------------------------------------------------数据操作--------------------------------------------------------------------------%>

<script type="text/javascript">
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
    function getUrlParam(name){
        var reg = new RegExp(name +"=(.*?)((?=&|$))"); //构造一个含有目标参数的正则表达式对象
        var r = window.location.href.match(reg); //匹配目标参数
        if (r!=null) return unescape(r[1]); return null; //返回参数值
    }
    var columnId = parent.columnTrId;//getUrlParam('columnId');
    var SettlementTable;

    layui.use(['table','layer','form','element','eleTree','upload'], function() {
        var table = layui.table;
        var layer = layui.layer;
        var form = layui.form;
        var eleTree = layui.eleTree;
        var element = layui.element;
        var $ = layui.jquery;
        var upload = layui.upload;

        // 树右侧表格实例
        SettlementTable = layui.table.render({
            elem: '#Settlement'
            // , data: []
            , url: '/fileManage/getFile?columnIds='+columnId//数据接口
            , page: { //支持传入 laypage 组件的所有参数（某些参数除外，如：jump/elem） - 详见文档
                layout: ['prev', 'page', 'next', 'skip', 'count', 'limit',]//自定义分页布局
                , limits: [10, 15, 20, 25, 30, 35, 40, 45, 50, 55, 60, 65, 70, 75, 80, 85, 90, 95, 100]
                , first: false //不显示首页
                , last: false //不显示尾页
            } //开启分页
            , toolbar: '#toolbar'
            , cols: [[ //表头
                {type: 'checkbox'}
                , {field: 'docfileId', title: 'ID'}
                //, {field: 'docfileNo', title: '文档编号'}
                , {field: 'docfileName', title: '文档名称'}
                , {field: 'keyWord', title: '关键词'}
                , {field: 'docfileClass', title: '文档等级'}
                , {field: 'createUserId', title: '上传人'}
                , {field: 'createTime', title: '上传时间'}
               // , {field: 'downloadPassword', title: '下载密码'}
                , {field: 'docfileDesc', title: '文档摘要'}
                , {field: 'columnName', title: '知识类别'}
                ,{width:250, title: '操作',align:'center', toolbar: '#barOperation'}
            ]]
            , limit: 10
            , done: function (res) {
            }
        });
        //表格头工具事件
        table.on('toolbar(SettlementFilter)', function(obj){
            var checkStatus = table.checkStatus("Settlement").data;
            var event = obj.event;
            switch(event){
                case 'upfile': //上传附件
                    if(columnId==undefined){
                        layer.msg("请选择栏目");
                        return false;
                    }
                    var index = layer.open({
                        type: 1,
                        skin: 'layui-layer-molv', //加上边框
                        area: ['80%', '80%'], //宽高
                        title: '上传文档',
                        maxmin: true,
                        btn: ['提交', '取消'],
                        content: '<div class="layui-form" id="boxfo">' +
                            //'<div class="inbox"><label class="layui-form-label" style="width: 100px;"><span class="red">*</span>文档编号</label><div class="layui-input-block" style="margin-left: 130px;">' +
                            //'<input class="layui-input" lay-verify="required" name="docfileNo"></div></div>' +
                            '<div class="inbox" id="finde"><label class="layui-form-label" style="width: 100px;"><span class="red">*</span>关键词</label><div class="layui-input-block" style="margin-left: 130px;">' +
                            '<input class="layui-input"  lay-verify="required" name="keyWord"></div></div>' +
                            //'<div class="inbox"><label class="layui-form-label" style="width: 100px;"><span class="red">*</span>下载密码</label><div class="layui-input-block" style="margin-left: 130px;">' +
                            //'<input class="layui-input"  lay-verify="required" name="downloadPassword" id="downloadPassword"></div></div>' +
                            '<div class="inbox"><label class="layui-form-label" style="width: 100px;"><span class="red">*</span>文档等级</label><div class="layui-input-block" style="margin-left: 130px;">' +
                            '<select name="docfileClass" lay-verify="required"></select></div></div>' +
                            '<div class="inbox"><label class="layui-form-label" style="width: 100px;">下载标识</label><div class="layui-input-block" style="margin-left: 130px;">' +
                            '<input disabled class="layui-input" style="width: 90%;float: left;"  lay-verify="required" name="downloadKey" id="downloadKey"><i id="reKey" style="cursor: pointer; position: relative;top: 7px;left: 10px;" class="layui-icon layui-icon-refresh"></i>  </div></div>' +
                            '<div class="inbox"><label class="layui-form-label" style="width: 100px;">文档摘要</label><div class="layui-input-block" style="margin-left: 130px;">' +
                            '<textarea name="docfileDesc" style="max-width: 100%;width: 100%;height:100px"></textarea></div></div>' +
                            '<div class="layui-form-item layui-hide"><input type="button" lay-submit lay-filter="add-file-submit" id="add-file-submit" value="确认"></div>' +
                            '<button hidden id="uploadButton"></button>'+
                            '<input hidden id="attachmentId" name="attachmentId"/>'+
                            '<input hidden id="attachmentName" name="attachmentName"/>'+
                            '</div>',
                        success: function () {
                            $.ajax({ //查询文档等级
                                url: '/knowledge/childTree',
                                type: 'get',
                                dataType: 'json',
                                async:false,
                                success: function (res) {
                                    if(res.code == 0){
                                        var qdata = res.data;
                                        var str1 = '<div class="inbox"><label class="layui-form-label" style="width: 100px;"><span class="red">*</span>文档名称</label><div class="layui-input-block" style="margin-left: 130px;">' +
                                            '<button type="button" class="layui-btn" id="but_chose" style=" float: right"> <i class="layui-icon">&#xe67c;</i>选择文件 </button>' +
                                            '<input id="docfileName" readonly name="docfileName" style="width:80%; float: left"  class="layui-input"></div></div>' ;
                                        var str2 = ""
                                        if(qdata.length>0){
                                            for(var i =0; i<qdata.length;i++){
                                                str2+='<div class="inbox" ><label class="layui-form-label" style="width: 100px;" paid="'+qdata[i].id+'">'+qdata[i].name+'</label><div class="layui-input-block" style="margin-left: 130px;" lay-event="eleFn">' +
                                                    '<textarea type="text"  data-type="0" id="pele'+i+'" pid name="ptitle" required="" style="cursor: pointer"  placeholder="请选择" readonly="" autocomplete="off" class="textAreaBox ele treeNum"></textarea>' +
                                                    '<div class="eleTree ele'+i+'" lay-filter="data1" style="display:none;position:absolute;border: 1px solid #d2d2d2;overflow-y: auto;background-color: #fff;border-radius: 2px;box-shadow: 0 2px 4px rgba(0,0,0,.12);box-sizing: border-box;overflow:hidden;z-index: 999;top:38px;left:0px;width: 100%;"></div></div></div>'
                                            }
                                        }
                                        var str = str1 + str2;
                                        $("#finde").before(str);
                                        form.render();
                                        if(qdata.length>0) {
                                            for (var i = 0; i < qdata.length; i++) {
                                                (function (i) {
                                                    var elm = '.ele' + i
                                                    eleTree.render({
                                                        elem: '.ele' + i,
                                                        data: qdata[i].children,
                                                        expandOnClickNode: false,
                                                        highlightCurrent: true,
                                                        showLine: true,
                                                        showCheckbox: true,
                                                        checked: true,
                                                        // defaultExpandAll: true,
                                                        load: function (data, callback) {
                                                        },
                                                        done: function (res) {

                                                        }
                                                    });
                                                })(i);
                                            }
                                        }
                                    }


                                }
                            })
                            var $td = $("#boxfo").find('div[lay-event="eleFn"]');
                            $td.click(function (obj) {
                                var td = $(this);
                                if(td.find("textarea.ele").attr("data-type") == "0"){
                                    td.find(".eleTree").slideDown();
                                    td.find("textarea.ele").attr("data-type","1");
                                }else{
                                    td.find(".eleTree").slideUp();
                                    td.find("textarea.ele").attr("data-type","0");
                                }
                                //点击本身外收起下拉的主体
                                document.onmouseup = function(e){
                                    var e = e || window.event;
                                    var target = e.target || e.srcElement;
                                    //1. 点击事件的对象不是目标区域本身
                                    //2. 事件对象同时也不是目标区域的子元素
                                    if(!td.is(e.target) &&td.has(e.target).length === 0){
                                        $(".eleTree").slideUp();
                                        $("textarea.ele").attr("data-type","0");
                                    }
                                }
                                //选中监听事件
                                var arr = [];
                                var arr1 = [];
                                var pidt = td.find("textarea.ele").attr("pid");
                                var valt = td.find("textarea.ele").val();
                                layui.eleTree.on("nodeChecked(data1)",function(d) {
                                    var id = d.data.currentData.columnId+"";
                                    var label = d.data.currentData.label+"";
                                    if(d.isChecked == true || d.isChecked == "true"){
                                        arr.push(id);
                                        arr1.push(label);
                                    }else{
                                        arr.remove(id);
                                        arr1.remove(label);
                                    }
                                    if(pidt != undefined || pidt != "undefined" || pidt != ""){
                                        var str = pidt;
                                    }else{
                                        var str= "";
                                    }
                                    if(valt != undefined || valt != "undefined" || valt != ""){
                                        var str1 = valt;
                                    }else{
                                        var str1 = "";
                                    }
                                    for(var i=0;i<arr.length;i++){
                                        str+=arr[i]+","
                                        str1+=arr1[i]+","
                                    }
                                    td.find("textarea.ele").val(str1);
                                    td.find("textarea.ele").attr("pid",str);
                                    // var data =  layui.table.cache["addTable"]
                                    // var ind = td.find("textarea.ele").parents("tr").attr("data-index");
                                    // data[ind].columnName = str1;
                                    // data[ind].columnId = str;
                                })
                            })
                            $.ajax({ //随机生成不重复的key
                                url: '/fileManage/generStr',
                                type: 'post',
                                dataType: 'json',
                                // async:false,
                                success: function (res) {
                                    $("#downloadKey").val(undefind_nullStr(res.obj));
                                }
                            })

                            $("#reKey").on("click",function (e) {
                                $.ajax({ //随机生成不重复的key
                                    url: '/fileManage/generStr',
                                    type: 'post',
                                    dataType: 'json',
                                    // async:false,
                                    success: function (res) {
                                        $("#downloadKey").val(undefind_nullStr(res.obj));
                                    }
                                })
                            })
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
                            var uploadInst = upload.render({
                                elem: '#but_chose' //绑定元素
                                , url: '/upload?module=knowlage '//上传接口
                                , accept: 'file'
                                , auto: false
                                , bindAction: '#uploadButton'
                                , multiple: false
                                , choose: function (obj) {
                                    obj.preview(function (index, file, result) {
                                        $('#attachmentName').val(file.name);//显示文件名
                                        $('#docfileName').val(file.name);//显示文件名
                                    });
                                }
                                , done: function (res) {
                                    if(res.obj.length == 0){
                                        if(res.msg == "The file size is 0"){
                                            layer.msg("不可上传空文件!");
                                        }else{
                                            layer.msg(res.msg);
                                        }
                                    }else{
                                        var obj = res.obj[0];
                                        $('#attachmentId').val(getAttachIds(obj));
                                        $("#add-file-submit").click();
                                    }
                                }
                            });
                        },
                        yes: function (index, layero) {
                            var $select1 = $("select[name='itemFileType']");
                            if($("#attachmentName").val()==undefined||$("#attachmentName").val()==""){
                                layer.msg("请选择需要上传的文档");
                                return false;
                            }else if($("select[name='itemFileType']").val()==""){
                                layer.msg("请选择文档等级");
                                return false;
                            }else {
                                $('#uploadButton').click();
                            }
                        }
                    });
            form.on('submit(add-file-submit)', function (data) {
                var knowledgeDocfile = data.field;
                var columnId="";
                var treeNum = $(".treeNum").length;
                for(var i=0;i<treeNum;i++){
                    columnId+=$('.ele' + i).prev("textarea").attr("pid")
                }
                knowledgeDocfile.columnId = columnId;
                knowledgeDocfile.downloadAddress = $("#downloadKey").val();
                $.ajax({
                    url:'/fileManage/insertFile',
                    type: 'post',
                    dataType:'json',
                    data:knowledgeDocfile,
                    success:function(res){
                        if(res.flag){
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
                        var docfileIds = "";
                        for(var i=0;i<checkStatus.length;i++){
                            docfileIds += checkStatus[i].docfileId+",";
                        }
                        layer.confirm('确定要删除吗？', function(index){
                            $.ajax({
                                type: "post",
                                url: '/fileManage/delFile',
                                dataType: "json",
                                data:{
                                    columnIds:docfileIds
                                },
                                success:function (res) {
                                    if(res.code == "0" || res.code == 0){
                                        SettlementTable.reload();
                                    }
                                    layer.msg(res.msg);
                                }
                            })
                            layer.close(index);
                        });
                    }
                    break;
            };
        });
        //表格行操作事件
        table.on('tool(SettlementFilter)', function(obj){ //注：tool 是工具条事件名，test 是 table 原始容器的属性 lay-filter="对应的值"
        var data = obj.data; //获得当前行数据
        var layEvent = obj.event; //获得 lay-event 对应的值（也可以是表头的 event 参数对应的值）
        var tr = obj.tr; //获得当前行 tr 的 DOM 对象（如果有的话）
        if(layEvent === 'detail'){ //查看
            var attachId = data.attachmentId;
            if(attachId==undefined||attachId==''){
                layer.msg("文件损坏或未上传文件")
            }else{
                lookFile(attachId);
            }
        } else if(layEvent === 'edit'){ //编辑
            var docfileIds = data.docfileId;
            var index = layer.open({
                type: 1,
                skin: 'layui-layer-molv', //加上边框
                area: ['80%', '80%'], //宽高
                title: '编辑',
                maxmin: true,
                btn: ['提交', '取消'],
                content: '<div class="layui-form" id="boxfo">' +
                //'<div class="inbox"><label class="layui-form-label" style="width: 100px;"><span class="red">*</span>文档编号</label><div class="layui-input-block" style="margin-left: 130px;">' +
                //'<input class="layui-input" lay-verify="required" id="docfileNo" name="docfileNo"></div></div>' +
                '<div class="inbox" id="finde"><label class="layui-form-label" style="width: 100px;"><span class="red">*</span>关键词</label><div class="layui-input-block" style="margin-left: 130px;">' +
                '<input class="layui-input"  lay-verify="required"id="keyWord" name="keyWord"></div></div>' +
                //'<div class="inbox"><label class="layui-form-label" style="width: 100px;"><span class="red">*</span>下载密码</label><div class="layui-input-block" style="margin-left: 130px;">' +
                //'<input class="layui-input"  lay-verify="required" name="downloadPassword" id="downloadPassword"></div></div>' +
                '<div class="inbox"><label class="layui-form-label" style="width: 100px;"><span class="red">*</span>文档等级</label><div class="layui-input-block" style="margin-left: 130px;">' +
                '<select name="docfileClass" lay-verify="required"></select></div></div>' +
                //'<div class="inbox"><label class="layui-form-label" style="width: 100px;">下载标识</label><div class="layui-input-block" style="margin-left: 130px;">' +
                //'<input disabled class="layui-input" style="width: 90%;float: left;"  lay-verify="required" name="downloadKey" id="downloadKey"><i id="keyWord" style="cursor: pointer; position: relative;top: 7px;left: 10px;" class="layui-icon layui-icon-refresh"></i>  </div></div>' +
                '<div class="inbox"><label class="layui-form-label" style="width: 100px;">下载标识</label><div class="layui-input-block" style="margin-left: 130px;">' +
                '<input disabled class="layui-input" style="width: 90%;float: left;"  lay-verify="required" name="downloadKey" id="downloadKey"><i id="reKey" style="cursor: pointer; position: relative;top: 7px;left: 10px;" class="layui-icon layui-icon-refresh"></i>  </div></div>' +
                '<div class="inbox"><label class="layui-form-label" style="width: 100px;">文档摘要</label><div class="layui-input-block" style="margin-left: 130px;">' +
                '<textarea id="docfileDesc" name="docfileDesc" style="max-width: 100%;width: 100%;height:100px"></textarea></div></div>' +
                '<div class="layui-form-item layui-hide"><input type="button" lay-submit lay-filter="edit-file-submit" id="edit-file-submit" value="确认"></div>' +
                '<button hidden id="uploadButton1"></button>'+
                '<input hidden id="attachmentId" name="attachmentId"/>'+
                '<input hidden id="attachmentName" name="attachmentName"/>'+
                '</div>',
                success: function () {
                    $.ajax({ //查询文档等级
                        url: '/knowledge/childTree?docFileId='+docfileIds,
                        type: 'get',
                        dataType: 'json',
                        async:false,
                        success: function (res) {
                            if(res.code == 0){
                                var qdata = res.data;
                                var str1 = '<div class="inbox"><label class="layui-form-label" style="width: 100px;"><span class="red">*</span>文档名称</label><div class="layui-input-block" style="margin-left: 130px;">' +
                                    '<button type="button" class="layui-btn" id="but_chose1" style=" float: right"> <i class="layui-icon">&#xe67c;</i>选择文件 </button>' +
                                    '<input id="docfileName" readonly name="docfileName" style="width:80%; float: left"  class="layui-input"></div></div>' ;
                                var str2 = ""
                                if(qdata.length>0){
                                    for(var i =0; i<qdata.length;i++){
                                        str2+='<div class="inbox" ><label class="layui-form-label" style="width: 100px;" paid="'+qdata[i].id+'">'+qdata[i].name+'</label><div class="layui-input-block" style="margin-left: 130px;" lay-event="eleFn">' +
                                            '<textarea type="text"  data-type="0" id="pele'+i+'" pid name="ptitle" required="" style="cursor: pointer" placeholder="请选择" readonly="" autocomplete="off" class="textAreaBox ele treeNum"></textarea>' +
                                            '<div class="eleTree ele'+i+'" lay-filter="data1" style="display:none;position:absolute;border: 1px solid #d2d2d2;overflow-y: auto;background-color: #fff;border-radius: 2px;box-shadow: 0 2px 4px rgba(0,0,0,.12);box-sizing: border-box;overflow:hidden;z-index: 999;top:38px;left:0px;width: 100%;"></div></div></div>'
                                    }
                                }
                                var str = str1 + str2;
                                $("#finde").before(str);
                                form.render();
                                if(qdata.length>0) {
                                    for (var i = 0; i < qdata.length; i++) {
                                        (function (i) {
                                            var elm = '.ele' + i
                                            eleTree.render({
                                                elem: '.ele' + i,
                                                data: qdata[i].children,
                                                expandOnClickNode: false,
                                                highlightCurrent: true,
                                                showLine: true,
                                                showCheckbox: true,
                                                checked: true,
                                                defaultExpandAll: true,
                                                load: function (data, callback) {
                                                },
                                                done: function (res) {
                                                    var pidar = obj.data.columnId.split(",");
                                                    var pidarr = [];
                                                    for (var j = 0; j < pidar.length; j++) {
                                                        if (pidar[j] == "") {

                                                        } else {
                                                            pidarr.push(pidar[j]);
                                                        }
                                                    }
                                                    for (var j = 0; j < pidarr.length; j++) {
                                                        $(elm + " div[data-id=" + pidarr[j] + "]").find("input").eq(0).attr("checked", true);
                                                        $(elm + " div[data-id=" + pidarr[j] + "]").find("input").eq(0).attr("eletree-status", "1");
                                                        // $(elm+" div[data-id="+pidarr[j]+"]").find("input").eq(0).addClass("eleTree-disabled");
                                                        $(elm + " div[data-id=" + pidarr[j] + "]").find("input").eq(0).next("div.eleTree-checkbox").addClass("eleTree-checkbox-checked");
                                                        $(elm + " div[data-id=" + pidarr[j] + "]").find("input").eq(0).next("div.eleTree-checkbox").find("i").addClass("layui-icon-ok");
                                                    }
                                                    var $inp = $(elm +' input[eletree-status="1"]');
                                                    var str = "";
                                                    var str1 = "";
                                                    for(var i=0;i<$inp.length;i++){
                                                        str += $inp.eq(i).parent().find("span.eleTree-node-content-label").text()+",";
                                                        str1 += $inp.eq(i).parent().parent().attr("data-id")+",";
                                                    }
                                                    $(elm).prev("textarea").attr("pid",str1)
                                                    $(elm).prev("textarea").text(str);
                                                }
                                            });
                                            var $inp = $(elm +' input[eletree-status="1"]');
                                            var str = "";
                                            var str1 = "";
                                            for(var i=0;i<$inp.length;i++){
                                                str += $inp.eq(i).parent().find("span.eleTree-node-content-label").text()+",";
                                                str1 += $inp.eq(i).parent().parent().attr("data-id")+",";
                                            }
                                            $(elm).prev("textarea").attr("pid",str1)
                                            $(elm).prev("textarea").text(str);
                                        })(i);
                                    }
                                }
                            }


                        }
                    })
                    var $td = $("#boxfo").find('div[lay-event="eleFn"]');
                    $td.click(function (obj) {
                        var td = $(this);
                        if(td.find("textarea.ele").attr("data-type") == "0"){
                            td.find(".eleTree").slideDown();
                            td.find("textarea.ele").attr("data-type","1");
                        }else{
                            td.find(".eleTree").slideUp();
                            td.find("textarea.ele").attr("data-type","0");
                        }
                        //点击本身外收起下拉的主体
                        document.onmouseup = function(e){
                            var e = e || window.event;
                            var target = e.target || e.srcElement;
                            //1. 点击事件的对象不是目标区域本身
                            //2. 事件对象同时也不是目标区域的子元素
                            if(!td.is(e.target) &&td.has(e.target).length === 0){
                                $(".eleTree").slideUp();
                                $("textarea.ele").attr("data-type","0");
                            }
                        }
//选中监听事件
                        var arr = [];
                        var arr1 = [];
                        var pidt = td.find("textarea.ele").attr("pid");
                        var valt = td.find("textarea.ele").val();
                        if(pidt != undefined || pidt != "undefined" || pidt != ""){
                            var arrr = pidt.split(",")
                            for(var i=0;i<arrr.length;i++){
                                if(arrr[i] == ""){

                                }else{
                                    arr.push(arrr[i]);
                                }
                            }
                        }else{
                            arr = []
                        }
                        if(valt != undefined || valt != "undefined" || valt != ""){
                            var arrr1 = valt.split(",")
                            for(var i=0;i<arrr1.length;i++){
                                if(arrr1[i] == ""){

                                }else{
                                    arr1.push(arrr1[i]);
                                }
                            }
                        }else{
                            arr1 = []
                        }

                        layui.eleTree.on("nodeChecked(data1)",function(d) {
                            var id = d.data.currentData.columnId+"";
                            var label = d.data.currentData.label+"";
                            if(d.isChecked == true || d.isChecked == "true"){
                                arr.push(id);
                                arr1.push(label);
                            }else{
                                arr.remove(id);
                                arr1.remove(label);
                            }
                            var str ="";
                            var str1 ="";
                            for(var i=0;i<arr.length;i++){
                                str+=arr[i]+","
                                str1+=arr1[i]+","
                            }
                            td.find("textarea.ele").val(str1);
                            td.find("textarea.ele").attr("pid",str);
                            // var data =  layui.table.cache["addTable"]
                            // var ind = td.find("textarea.ele").parents("tr").attr("data-index");
                            // data[ind].columnName = str1;
                            // data[ind].columnId = str;
                        })
                    })
                    $("#reKey").on("click",function (e) {
                        $.ajax({ //随机生成不重复的key
                            url: '/fileManage/generStr',
                            type: 'post',
                            dataType: 'json',
                            // async:false,
                            success: function (res) {
                                $("#downloadKey").val(undefind_nullStr(res.obj));
                            }
                        })
                    })
                    $("#docfileName").val(undefind_nullStr(data.docfileName));//文档名称
                    $('#attachmentName').val(undefind_nullStr(data.attachmentName));//显示文件名
                    $('#attachmentId').val(undefind_nullStr(data.attachmentId));
                    $("#keyWord").val(undefind_nullStr(data.keyWord));//关键词
                    $("#ppele").val(undefind_nullStr(data.columnName));//栏目名称
                    $("#ppele").attr("pid",undefind_nullStr(data.columnId));//栏目id
                    //$("#docfileNo").val(undefind_nullStr(data.docfileNo));//文档编号
                    $("#docfileDesc").text(undefind_nullStr(data.docfileDesc));//文档摘要
                    $("#downloadKey").val(undefind_nullStr(data.downloadAddress));//下载标识
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
                    if(data.docfileClass == "一级" || data.docfileClass == "1"){
                        var val = "1";
                    }
                    if(data.docfileClass == "二级" || data.docfileClass == "2"){
                        var val = "2";
                    }
                    if(data.docfileClass == "三级" || data.docfileClass == "3"){
                        var val = "3";
                    }
                    $("select[name='docfileClass']").find('option[value="'+val+'"]').prop('selected','selected');
                    form.render();//初始化表单
                    var uploadInst = upload.render({
                        elem: '#but_chose1' //绑定元素
                        , url: '/upload?module=knowlage '//上传接口
                        , accept: 'file'
                        , auto: false
                        , bindAction: '#uploadButton1'
                        , multiple: false
                        , choose: function (obj) {
                            obj.preview(function (index, file, result) {
                                $('#attachmentName').val(file.name);//显示文件名
                                $('#docfileName').val(file.name);//显示文件名
                            });
                        }
                        , done: function (res) {
                            if(res.obj.length == 0){
                                if(res.msg == "The file size is 0"){
                                    layer.msg("不可上传空文件!");
                                }else{
                                    layer.msg(res.msg);
                                }
                            }else{
                                var obj = res.obj[0];
                                $('#attachmentId').val(getAttachIds(obj));
                                layer.closeAll();
                            }
                        }
                    });
                },
                yes: function (index, layero) {
                    layer.closeAll();
                    var $select1 = $("select[name='docfileClass']");
                    if($("#attachmentName").val()==undefined||$("#attachmentName").val()==""){
                        layer.msg("请选择需要上传的文档");
                        return false;
                    }else if($("select[name='docfileClass']").val()==""){
                        layer.msg("请选择文档等级");
                        return false;
                    }else {
                        var record = {};
                        var columnId="";
                        var treeNum = $(".treeNum").length;
                        for(var i=0;i<treeNum;i++){
                            columnId+=$('.ele' + i).prev("textarea").attr("pid")
                        }
                        record.columnId = columnId;
                        record.downloadAddress = $("#downloadKey").val();
                        record.columnName = $("#ppele").val();
                        record.docfileName = $("#docfileName").val();
                        record.docfileDesc = $("#docfileDesc").val();
                        record.docfileId = data.docfileId;
                        //record.docfileNo = $("#docfileNo").val();
                        record.keyWord = $("#keyWord").val();
                        record.attachmentId = $("#attachmentId").val();
                        record.attachmentName = $("#attachmentName").val();
                        record.docfileClass = $("select[name='docfileClass']").next(".layui-form-select").find("dl dd.layui-this").text();
                        record.createTime = data.createTime;
                        record.createUserId = data.createUserId;
                        $.ajax({
                            url:'/fileManage/updateBySelective',
                            type: 'post',
                            dataType:'json',
                            data:record,
                            success:function(res){
                                if(res.flag){
                                    $(".layui-laypage-btn").click();
                                }
                                layer.msg(res.msg)
                            }
                        })
                    }
                }
            });
        } else if(layEvent === 'down'){ //下载
            var attachId = data.attachmentId;
            if(attachId==undefined||attachId==''){
                layer.msg("文件损坏或未上传附件")
            }else{
                window.location.href = "/equipment/limsDownload?model=knowlage&attachId=" +attachId
            }
        }else if(layEvent === 'info'){ //查看详情
            var index = layer.open({
                type: 1,
                skin: 'layui-layer-molv', //加上边框
                area: ['80%', '80%'], //宽高
                title: '文档详情',
                maxmin: true,
                btn: ['确定'],
                content: '<div class="layui-form" id="boxfo">' +
                    //'<div class="inbox"><label class="layui-form-label" style="width: 100px;"><span class="red">*</span>文档编号</label><div class="layui-input-block" style="margin-left: 130px;">' +
                    //'<input disabled class="layui-input" lay-verify="required" name="docfileNo" id="docfileNo"></div></div>' +
                    '<div class="inbox" id="finde"><label class="layui-form-label" style="width: 100px;"><span class="red">*</span>关键词</label><div class="layui-input-block" style="margin-left: 130px;">' +
                    '<input disabled class="layui-input"  lay-verify="required" name="keyWord" id="keyWord"></div></div>' +
                    //'<div class="inbox"><label class="layui-form-label" style="width: 100px;"><span class="red">*</span>下载密码</label><div class="layui-input-block" style="margin-left: 130px;">' +
                    //'<input class="layui-input"  lay-verify="required" name="downloadPassword" id="downloadPassword"></div></div>' +
                    '<div class="inbox"><label class="layui-form-label" style="width: 100px;"><span class="red">*</span>文档等级</label><div class="layui-input-block" style="margin-left: 130px;">' +
                    '<select disabled name="docfileClass" lay-verify="required"></select></div></div>' +
                    '<div class="inbox"><label class="layui-form-label" style="width: 100px;">下载标识</label><div class="layui-input-block" style="margin-left: 130px;">' +
                    '<input disabled class="layui-input"  lay-verify="required" name="downloadKey" id="downloadKey"></div></div>' +
                    '<div class="inbox"><label class="layui-form-label" style="width: 100px;">文档摘要</label><div class="layui-input-block" style="margin-left: 130px;">' +
                    '<textarea readonly name="docfileDesc" id="docfileDesc" style="max-width: 100%;width: 100%;height:100px"></textarea></div></div>' +
                    //'<div class="layui-form-item layui-hide"><input type="button" lay-submit lay-filter="add-file-submit" id="add-file-submit" value="确认"></div>' +
                    //'<button hidden id="uploadButton"></button>'+
                    //'<input hidden id="attachmentId" name="attachmentId"/>'+
                    //'<input hidden id="attachmentName" name="attachmentName"/>'+
                    '</div>',
                success: function () {
                    $.ajax({ //查询文档等级
                        url: '/knowledge/childTree?docFileId='+data.docfileId,
                        type: 'get',
                        dataType: 'json',
                        async:false,
                        success: function (res) {
                            if(res.code == 0){
                                var qdata = res.data;
                                var str1 = '<div class="inbox"><label class="layui-form-label" style="width: 100px;"><span class="red">*</span>文档名称</label><div class="layui-input-block" style="margin-left: 130px;">' +
                                    '<button type="button" class="layui-btn" id="but_chose1" style=" float: right"> <i class="layui-icon">&#xe67c;</i>选择文件 </button>' +
                                    '<input id="docfileName" disabled readonly name="docfileName" style="width:80%; float: left"  class="layui-input"></div></div>' ;
                                var str2 = ""
                                if(qdata.length>0){
                                    for(var i =0; i<qdata.length;i++){
                                        str2+='<div class="inbox" ><label class="layui-form-label" style="width: 100px;" paid="'+qdata[i].id+'"><span class="red">*</span>'+qdata[i].name+'</label><div class="layui-input-block" style="margin-left: 130px;" lay-event="eleFn">' +
                                            '<textarea type="text" readonly data-type="0" id="pele'+i+'" pid name="ptitle" required="" style="cursor: pointer" lay-verify="required" placeholder="请选择" readonly="" autocomplete="off" class="textAreaBox ele"></textarea>' +
                                            '<div class="eleTree ele'+i+'" lay-filter="data1" style="display:none;position:absolute;border: 1px solid #d2d2d2;overflow-y: auto;background-color: #fff;border-radius: 2px;box-shadow: 0 2px 4px rgba(0,0,0,.12);box-sizing: border-box;overflow:hidden;z-index: 999;top:38px;left:0px;width: 100%;"></div></div></div>'
                                    }
                                }
                                var str = str1 + str2;
                                $("#finde").before(str);
                                form.render();
                                if(qdata.length>0) {
                                    for (var i = 0; i < qdata.length; i++) {
                                        (function (i) {
                                            var elm = '.ele' + i
                                            eleTree.render({
                                                elem: '.ele' + i,
                                                data: qdata[i].children,
                                                expandOnClickNode: false,
                                                highlightCurrent: true,
                                                showLine: true,
                                                showCheckbox: true,
                                                checked: true,
                                                defaultExpandAll: true,
                                                load: function (data, callback) {
                                                },
                                                done: function (res) {
                                                    var pidar = obj.data.columnId.split(",");
                                                    var pidarr = [];
                                                    for (var j = 0; j < pidar.length; j++) {
                                                        if (pidar[j] == "") {

                                                        } else {
                                                            pidarr.push(pidar[j]);
                                                        }
                                                    }
                                                    for (var j = 0; j < pidarr.length; j++) {
                                                        $(elm + " div[data-id=" + pidarr[j] + "]").find("input").eq(0).attr("checked", true);
                                                        $(elm + " div[data-id=" + pidarr[j] + "]").find("input").eq(0).attr("eletree-status", "1");
                                                        // $(elm+" div[data-id="+pidarr[j]+"]").find("input").eq(0).addClass("eleTree-disabled");
                                                        $(elm + " div[data-id=" + pidarr[j] + "]").find("input").eq(0).next("div.eleTree-checkbox").addClass("eleTree-checkbox-checked");
                                                        $(elm + " div[data-id=" + pidarr[j] + "]").find("input").eq(0).next("div.eleTree-checkbox").find("i").addClass("layui-icon-ok");
                                                    }
                                                    var $inp = $(elm +' input[eletree-status="1"]');
                                                    var str = "";
                                                    var str1 = "";
                                                    for(var i=0;i<$inp.length;i++){
                                                        str += $inp.eq(i).parents(".eleTree-node-content").attr("title")+",";
                                                        str1 += $inp.eq(i).parents(".eleTree-node-content").parent().attr("data-id")+",";
                                                    }
                                                    $(elm).prev("textarea").attr("pid",str1)
                                                    $(elm).prev("textarea").text(str);
                                                //    $(elm).prev("input").attr("pid",str1)
                                                //    $(elm).prev("input").text(str);
                                                }
                                            });
                                            var $inp = $(elm +' input[eletree-status="1"]');
                                            var str = "";
                                            var str1 = "";
                                            for(var i=0;i<$inp.length;i++){
                                                str += $inp.eq(i).parents(".eleTree-node-content").attr("title")+",";
                                                str1 += $inp.eq(i).parents(".eleTree-node-content").parent().attr("data-id")+",";
                                            }
                                            $(elm).prev("textarea").attr("pid",str1)
                                            $(elm).prev("textarea").text(str);
                                        })(i);
                                    }
                                }
                            }


                        }
                    })
                    // var $td = $("#boxfo").find('div[lay-event="eleFn"]');
                    // $td.click(function (obj) {
                    //     var td = $(this);
                    //     if(td.find("textarea.ele").attr("data-type") == "0"){
                    //         td.find(".eleTree").slideDown();
                    //         td.find("textarea.ele").attr("data-type","1");
                    //     }else{
                    //         td.find(".eleTree").slideUp();
                    //         td.find("textarea.ele").attr("data-type","0");
                    //     }
                    //     //点击本身外收起下拉的主体
                    //     document.onmouseup = function(e){
                    //         var e = e || window.event;
                    //         var target = e.target || e.srcElement;
                    //         //1. 点击事件的对象不是目标区域本身
                    //         //2. 事件对象同时也不是目标区域的子元素
                    //         if(!td.is(e.target) &&td.has(e.target).length === 0){
                    //             $(".eleTree").slideUp();
                    //             $("textarea.ele").attr("data-type","0");
                    //         }
                    //     }
                    //     //选中监听事件
                    //     var arr = [];
                    //     var arr1 = [];
                    //     var pidt = td.find("textarea.ele").attr("pid");
                    //     var valt = td.find("textarea.ele").val();
                    //     layui.eleTree.on("nodeChecked(data1)",function(d) {
                    //         var id = d.data.currentData.columnId+"";
                    //         var label = d.data.currentData.label+"";
                    //         if(d.isChecked == true || d.isChecked == "true"){
                    //             arr.push(id);
                    //             arr1.push(label);
                    //         }else{
                    //             arr.remove(id);
                    //             arr1.remove(label);
                    //         }
                    //         if(pidt != undefined || pidt != "undefined" || pidt != ""){
                    //             var str = pidt;
                    //         }else{
                    //             var str= "";
                    //         }
                    //         if(valt != undefined || valt != "undefined" || valt != ""){
                    //             var str1 = valt;
                    //         }else{
                    //             var str1 = "";
                    //         }
                    //         for(var i=0;i<arr.length;i++){
                    //             str+=arr[i]+","
                    //             str1+=arr1[i]+","
                    //         }
                    //         td.find("textarea.ele").val(str1);
                    //         td.find("textarea.ele").attr("pid",str);
                    //         // var data =  layui.table.cache["addTable"]
                    //         // var ind = td.find("textarea.ele").parents("tr").attr("data-index");
                    //         // data[ind].columnName = str1;
                    //         // data[ind].columnId = str;
                    //     })
                    // })
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
                    $("#pele").val(undefind_nullStr(data.columnName));//栏目名称
                    //$("#docfileNo").val(undefind_nullStr(data.docfileNo));//文档编号
                    $("#docfileDesc").text(undefind_nullStr(data.docfileDesc));//文档摘要
                    $("#downloadKey").val(undefind_nullStr(data.downloadAddress));//下载标识
                    form.render();//初始化表单
                },
                yes: function (index, layero) {
                    layer.close(index)
                }
            });
        }
    });
    })
    function childFunc(){
        columnId = parent.columnTrId
        SettlementTable.reload({
            url: '/fileManage/getFile?columnIds='+columnId//数据接口
        });
    }
    function lookFile(repalogId){//查看附件
        if (repalogId == undefined || repalogId == "") {
            layer.msg("文件已被损坏，无法查看");
        } else {
            selectFile1(repalogId,'knowlage');
            //window.location.href = "/equipment/limsDownload?model=" + model + "&attachId=" + attachId  下载
        }
    }
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
</script>
</body>
</html>
