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
    <title>技术方案知识库</title>
    <link rel="stylesheet" href="/lib/layui/layui/css/layui.css?20190817.1">
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
        .mbox{
            height: 100%;
            padding:0px;
        }
        .inbox{
            padding: 5px;
            padding-right: 30px;
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
            float: left;
            position: relative;
            border: 1px solid #eee;
            /*width: 200px;*/
            width: 18%;
            overflow-x: auto;
            height: 100%;
            height: 540px !important;
        }
        .layui-rt{
            float: left;
            width: 80%;
            margin-left: 6px;

            height: 100%;
            /*margin-top: -10px;*/
        }
        .rtfix{
            /*width:200px;*/
            overflow-x: hidden;
        }
        .back{
            background-color: #ccc;
        }

        .eleTree{
            cursor: pointer;
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

    </style>
</head>
<body>
<div class="mbox">
    <div class="layui-card">
        <div class="layui-card-body" style="padding-left: 6px;">
            <div class="layui-tab layui-tab-brief" lay-filter="docDemoTabBrief"  style="width: 100%">
                <ul class="layui-tab-title" id="ulBox">
                    <li class="layui-this">技术方案知识库</li>
                    <%--<li >计家云</li>--%>
                </ul>
                <div class="layui-tab-content" id="divBox" style="height:90%;display: block;position: relative;width:100%;padding: 2px">
                    <div class="layui-tab-item layui-show" style="height: 100%">
                        <div class="layui-card" style="height: 100%">
                            <div class="layui-card-body" style="height: 100%;padding-left: 6px;padding: 0">
                                <div class="layui-lf rtfix">
                                    <div style="margin: 1% 1%;" id="editBox">
                                        <button type="button" style="width: 21%;margin-left: 1px;padding: 0 6px;" class="layui-btn layui-btn-primary layui-btn-sm add" id="addPlan">新增</button>
                                        <button type="button" style="width: 21%;margin-left: 1px;padding: 0 6px;" class="layui-btn layui-btn-primary layui-btn-sm add" id="editPlan">编辑</button>
                                        <button type="button" style="width: 21%;margin-left: 1px;padding: 0 6px;" class="layui-btn layui-btn-primary layui-btn-sm del" id="delPlan">删除</button>
                                        <button type="button" style="width: 21%;margin-left: 1px;padding: 0 6px;" class="layui-btn layui-btn-primary layui-btn-sm del" id="importPlan">导入</button>
                                    </div>
                                    <div class="panel-body">
                                        <div class="eleTree ele1" lay-filter="tdata"></div>
                                    </div>
                                </div>
                                <div class="layui-md" style="width: 4px;cursor: e-resize;position: relative;"></div>
                                <div class="layui-rt" style="position: relative">
                                    <table id="Settlement" lay-filter="SettlementFilter"></table>
                                </div>
                            </div>
                        </div>
                    </div>
                    <%--<div class="layui-tab-item" style="height: 100%">
                        <div class="layui-card" style="height: 100%">
                            <div class="layui-card-body" style="height: 100%;padding-left: 6px;padding: 0">
                                <div class="layui-lf rtfix">
                                    <div class="panel-body">
                                        <div class="eleTree ele22" lay-filter="tdata22"></div>
                                    </div>
                                </div>
                                <div class="layui-md" style="width: 4px;cursor: e-resize;position: relative;"></div>
                                <div class="layui-rt" style="position: relative">
                                    <table id="Settlement2" lay-filter="SettlementFilter2"></table>
                                </div>
                            </div>
                        </div>
                    </div>--%>
                </div>
            </div>
        </div>
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
    <%--<a class="layui-btn layui-btn-xs" lay-event="info" >详情</a>
    <a class="layui-btn layui-btn-xs" lay-event="detail" >查看</a>--%>
    <a class="layui-btn layui-btn-xs" lay-event="down" >下载</a>
</script>
<script type="text/html" id="toolbar2">
    <div class="layui-btn-container">
        <button class="layui-btn layui-btn-sm" lay-event="supplierImport2" style="width: 100px">导入本地</button>
    </div>
</script>
<%----------------------------------------------------数据操作--------------------------------------------------------------------------%>

<script type="text/javascript">
    function getUrlParam(name){
        var reg = new RegExp(name +"=(.*?)((?=&|$))"); //构造一个含有目标参数的正则表达式对象
        var r = window.location.href.match(reg); //匹配目标参数
        if (r!=null) return unescape(r[1]); return null; //返回参数值
    }
    //var columnId = parent.columnId;//getUrlParam('columnId');
    var SettlementTable;
    var columnId;

    var el;
    var codeNo;
    var codNam;

    var ell;

    layui.use(['table','layer','form','element','eleTree','upload'], function() {
        var table = layui.table;
        var layer = layui.layer;
        var form = layui.form;
        var eleTree = layui.eleTree;
        var element = layui.element;
        var $ = layui.jquery;
        var upload = layui.upload;


        function tab(date1,date2){
            var oDate1 = new Date(date1);
            var oDate2 = new Date(date2);
            var dataTime = new Date();
            if(oDate1!=undefined&&oDate2!=undefined){
                if(dataTime.getTime() >= oDate1.getTime()&&dataTime.getTime() <= oDate2.getTime()){
                    return true;
                }
            }
        }
        //判断权限
        $.ajax({
            url:'/knowledgeCenter/getCloudPriv',
            dataType:'json',
            type:'post',
            success:function(res){
                if(res.obj.knowledgeFlag!=undefined&&res.obj.knowledgeFlag==0){
                    if(tab(res.obj.knowledgeBTime,res.obj.knowledgeETime)){
                        $('#ulBox').append('<li >计家云</li>')
                        var htmlDiv = '<div class="layui-tab-item" style="height: 100%">\n' +
                            '                    <div class="layui-card" style="height: 100%">\n' +
                            '                        <div class="layui-card-body" style="height: 100%">\n' +
                            '                            <div class="layui-lf rtfix">\n' +
                            '                                <div class="panel-body">\n' +
                            '                                    <div class="eleTree ele22" lay-filter="tdata22"></div>\n' +
                            '                                </div>\n' +
                            '                            </div>\n' +
                            '                            <div class="layui-md" style="width: 4px;cursor: e-resize;position: relative;"></div>\n' +
                            '                            <div class="layui-rt" style="position: relative">\n' +
                            '                                <table id="Settlement2" lay-filter="SettlementFilter2"></table>\n' +
                            '                            </div>\n' +
                            '                        </div>\n' +
                            '                    </div>\n' +
                            '                </div>'
                        $('#divBox').append(htmlDiv);
                        // 初始化渲染 树形菜单

                        var el2 = eleTree.render({
                            elem: '.ele22',
                            showLine:true,
                            url:'/knowledge/goToParent?url=/technicalManager/getSecurityByType&parent=0',
                            lazy: true,
                            // checked: true,
                            load: function(data,callback) {
                                $.post('/knowledge/goToParent?url=/technicalManager/getSecurityByType&parent='+data.id,function (res) {
                                    callback(res.data);//点击节点回调
                                })
                            },
                            done:function (data) { //渲染完成回调
                                var n1 = $("#ulBox").find("li.layui-this").attr("codeNo2");
                                var na = $("#ulBox").find("li.layui-this").html();
                                codNam2 = encodeURI(encodeURI(na));
                                codeNo2 = n1;
                                if(data.data.length == 0){
                                    $('.ele22').html('<div style="text-align: center">暂无数据</div>');
                                    columnId2 = undefined;
                                }else{
                                    columnId2 = data.data[0].id;
                                    var dataid=$('.ele22 div').attr("data-id")
                                    $('.eleTree-node').removeClass('back')
                                    $('.ele22 div[data-id='+dataid+']').addClass('back')
                                    $('.eleTree-node-group').css('background','#fff');
                                    childFunc2(columnId2);  //调用应用中方法
                                }
                                // if(type == 1 || type == "1"){
                                //     urrl = '/columManage/getColumManagePage?columnId2='+columnId2+'&codeNo2='+codeNo2+'&codeName'+'&codeName='+codNam2
                                // }else if(type == 2 || type == "2"){
                                //     urrl = '/fileManage/getFileManagePage?columnId2='+columnId2
                                // }
                                //$("#divBox").find("div.layui-show").find(".iframe").attr("src",urrl);
                            }
                        })
                    }
                }
            }
        })


        // 初始化渲染 树形菜单
        el = eleTree.render({
            elem: '.ele1',
            showLine:true,
            url:'/technicalManager/getSecurityByType?parent=0',
            lazy: true,
            // checked: true,
            load: function(data,callback) {
                $.post('/technicalManager/getSecurityByType?parent='+data.id,function (res) {
                    callback(res.data);//点击节点回调
                })
            },
            done:function (data) { //渲染完成回调
                var n1 = $("#ulBox").find("li.layui-this").attr("codeNo");
                var na = $("#ulBox").find("li.layui-this").html();
                codNam = encodeURI(encodeURI(na));
                codeNo = n1;
                if(data.data.length == 0){
                    $('.ele1').html('<div style="text-align: center">暂无数据</div>');
                    columnId = undefined;
                }else{
                    columnId = data.data[0].id;
                    var dataid=$('.ele1 div').attr("data-id")
                    $('.eleTree-node').removeClass('back')
                    $('.ele1 div[data-id='+dataid+']').addClass('back')
                    $('.eleTree-node-group').css('background','#fff');
                    childFunc(columnId);  //调用应用中方法
                }
                // if(type == 1 || type == "1"){
                //     urrl = '/columManage/getColumManagePage?columnId='+columnId+'&codeNo='+codeNo+'&codeName'+'&codeName='+codNam
                // }else if(type == 2 || type == "2"){
                //     urrl = '/fileManage/getFileManagePage?columnId='+columnId
                // }
                //$("#divBox").find("div.layui-show").find(".iframe").attr("src",urrl);
            }
        })

        // 节点点击事件
        eleTree.on("nodeClick(tdata)",function(d) {
            var n1 = $("#ulBox").find("li.layui-this").attr("codeNo");
            var na = $("#ulBox").find("li.layui-this").html();
            codNam = encodeURI(encodeURI(na));
            codeNo = n1;
            columnId = d.data.currentData.technicalTypeId;
            var clas = "";
            var dataid=$(clas+' div').attr("data-id")
            $('.eleTree-node').removeClass('back')
            $(d.node[0]).addClass('back')
            $('.eleTree-node-group').css('background','#fff')
            //调用子页面的方法
            childFunc(columnId);  //调用应用中方法
        });
        //选中监听事件
        var arr = [];
        eleTree.on("nodeChecked(tdata)",function(d) {
            var id = d.data.currentData.columnId;
            if(d.isChecked == true || d.isChecked == "true"){
                arr.push(id);
            }else{
                arr.remove(id);
            }
        })
        /*$(document).on("click",function() {
            $(".ele1").slideUp();
        })*/

        function childFunc(columnId){
            // 树右侧表格实例
            SettlementTable = layui.table.render({
                elem: '#Settlement'
                // , data: []
                , url: '/technicalManager/getKnowdgeByTypeId?typeId='+columnId//数据接口
                , page: { //支持传入 laypage 组件的所有参数（某些参数除外，如：jump/elem） - 详见文档
                    layout: ['prev', 'page', 'next', 'skip', 'count', 'limit',]//自定义分页布局
                    , limits: [10, 15, 20, 25, 30, 35, 40, 45, 50, 55, 60, 65, 70, 75, 80, 85, 90, 95, 100]
                    , first: false //不显示首页
                    , last: false //不显示尾页
                } //开启分页
                , toolbar: '#toolbar'
                , cols: [[ //表头
                    {type: 'checkbox'}
                    , {field: 'docfileId',width:50, title: 'ID'}
                    //, {field: 'docfileNo', title: '文档编号'}
                    , {field: 'docfileName', event: 'detail',title: '文档名称',templet: function (d) {
                        var detail = d.docfileName;
                            if ('' == detail || null == detail || undefined == detail) {
                                return '';
                            }
                            if(detail.length > 0) {
                                return '<a style="cursor: pointer;color: blue" style="margin-left: 10px" href="javascript:;">'+d.docfileName+'</a>'
                            }
                        }}
                    , {field: 'keyWord', title: '关键词'}
                    , {field: 'docfileClass', title: '文档等级'}
                    , {field: 'createUserName', title: '上传人'}
                    , {field: 'createTime', title: '上传时间'}
                    // , {field: 'downloadPassword', title: '下载密码'}
                    , {field: 'docfileDesc', title: '文档摘要'}
                    //, {field: 'columnName', title: '知识类别'}
                    ,{width:250, title: '操作',align:'center', toolbar: '#barOperation'}
                ]]
                , limit: 10
                , done: function (res) {
                }
            });
        }
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
                        content: '<div class="layui-form" id="boxfo" style="margin-top: 20px;">' +
                            '<div class="inbox" id="finde"><label class="layui-form-label" style="width: 100px;"><span class="red">*</span>关键词</label><div class="layui-input-block" style="margin-left: 130px;">' +
                            '<input class="layui-input"  lay-verify="required" name="keyWord"></div></div>' +
                            '<div class="inbox"><label class="layui-form-label" style="width: 100px;"><span class="red">*</span>文档等级</label><div class="layui-input-block" style="margin-left: 130px;">' +
                            '<select name="docfileClass" lay-verify="required"></select></div></div>' +
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

                                        $("#finde").before(str1);
                                        form.render();
                                    }

                                }
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
                knowledgeDocfile.technicalTypeId = columnId;

                $.ajax({
                    url:'/technicalManager/insertSecurityDanger',
                    type: 'post',
                    dataType:'json',
                    data:knowledgeDocfile,
                    success:function(res){
                        if(res.code == '0'){
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
                                url: '/technicalManager/delSecurityDanger',
                                dataType: "json",
                                data:{
                                    ids:docfileIds
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
                content: '<div class="layui-form" id="boxfo" style="margin-top: 20px;">' +
                '<div class="inbox" id="finde"><label class="layui-form-label" style="width: 100px;"><span class="red">*</span>关键词</label><div class="layui-input-block" style="margin-left: 130px;">' +
                '<input class="layui-input"  lay-verify="required"id="keyWord" name="keyWord"></div></div>' +
                '<div class="inbox"><label class="layui-form-label" style="width: 100px;"><span class="red">*</span>文档等级</label><div class="layui-input-block" style="margin-left: 130px;">' +
                '<select name="docfileClass" lay-verify="required"></select></div></div>' +
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

                                $("#finde").before(str1);
                                form.render();
                            }

                        }
                    })

                    $("#docfileName").val(undefind_nullStr(data.docfileName));//文档名称
                    $('#attachmentName').val(undefind_nullStr(data.attachmentName));//显示文件名
                    $('#attachmentId').val(undefind_nullStr(data.attachmentId));
                    $("#keyWord").val(undefind_nullStr(data.keyWord));//关键词
                    $("#docfileDesc").text(undefind_nullStr(data.docfileDesc));//文档摘要
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
                                $("#edit-file-submit").click();
                            }
                        }
                    });
                },
                yes: function (index, layero) {
                    var $select1 = $("select[name='docfileClass']");
                    if($("#attachmentName").val()==undefined||$("#attachmentName").val()==""){
                        layer.msg("请选择需要上传的文档");
                        return false;
                    }else if($("select[name='docfileClass']").val()==""){
                        layer.msg("请选择文档等级");
                        return false;
                    }else {
                        if(data.docfileName==$("#docfileName").val()){
                            $("#edit-file-submit").click();
                        }else {
                            $('#uploadButton1').click();
                        }

                        /*var record = {};

                        record.technicalTypeId = parData.technicalTypeId;
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
                            url:'/technicalManager/updateSecirityDanger',
                            type: 'post',
                            dataType:'json',
                            data:record,
                            success:function(res) {
                                if (res.code == '0') {
                                    SettlementTable.reload();
                                    layer.closeAll();
                                }
                                layer.msg(res.msg);
                            }
                        })*/
                    }
                }
            });
            form.on('submit(edit-file-submit)', function (data) {
                var knowledgeDocfile = data.field;
                knowledgeDocfile.docfileId = docfileIds;
                knowledgeDocfile.technicalTypeId = columnId;

                $.ajax({
                    url:'/technicalManager/updateSecirityDanger',
                    type: 'post',
                    dataType:'json',
                    data:knowledgeDocfile,
                    success:function(res) {
                        if (res.code == '0') {
                            SettlementTable.reload();
                            layer.closeAll();
                        }
                        layer.msg(res.msg);
                    }
                })
            });
        } else if(layEvent === 'down'){ //下载
            var attachId = data.attachmentId;
            if(attachId==undefined||attachId==''){
                layer.msg("文件损坏或未上传附件")
            }else{
                window.location.href = "/equipment/limsDownload?model=knowlage&attachId=" +attachId
            }
        }
    });

        //左侧新建类型
        $('#addPlan').click(function () {
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
                    '                                            <input type="text" id="technicalSort" name="technicalSort" lay-verify="required" placeholder="请输入排序号" autocomplete="off" class="layui-input">\n' +
                    '                                        </div>\n' +
                    '                                    </div>\n' +
                    '                                    <div class="layui-form-item">\n' +
                    '                                        <label class="layui-form-label"><span style="color: red;">*</span>类型名称</label>\n' +
                    '                                        <div class="layui-input-block">\n' +
                    '                                            <input type="text" name="technicalTypeName" id="technicalTypeName" lay-verify="required" placeholder="请输入" autocomplete="off" class="layui-input">\n' +
                    '                                        </div>\n' +
                    '                                    </div>\n' +
                    '                                    <div class="layui-form-item">\n' +
                    '                                        <label class="layui-form-label"><span style="color: red;">*</span>父级类型</label>\n' +
                    '                                        <div class="layui-input-block" id="parent" style="position: relative">\n' +
                    '                                            <input type="text" style="cursor: pointer" id="pele" pid name="ttitle" required="" placeholder="请选择父级(不选择默认为一级)" readonly="" autocomplete="off" class="layui-input">\n' +
                    '                                            <div class="eleTree ele2" lay-filter="data1" style="display:none;position:absolute;border: 1px solid #d2d2d2;overflow-y: auto;background-color: #fff;border-radius: 2px;box-shadow: 0 2px 4px rgba(0,0,0,.12);box-sizing: border-box;z-index: 999;top:38px;left:0px;width: 99%;"></div>\n' +
                    '                                        </div>\n' +
                    '                                    </div>\n' +
                    '                                </form>',
                success: function () {
                    $.ajax({
                        url: '/technicalManager/getStandSort?parentId='+columnId+'&isStand=false',
                        type: 'get',
                        dataType: 'json',
                        async:false,
                        success: function (res) {
                            $('#technicalSort').val(res.obj);
                        }
                    })
                    $("[name='ttitle']").on("click",function (e) {
                        e.stopPropagation();
                        ell=eleTree.render({
                            elem: '.ele2',
                            url:'/technicalManager/getSecurityByType?parent=0',
                            expandOnClickNode: false,
                            highlightCurrent: true,
                            showLine:true,
                            lazy: true,
                            load: function(data,callback) {
                                $.post('/technicalManager/getSecurityByType?parent='+data.id,function (res) {
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
                    plbSecurityKnowledge.technicalSort = $("#technicalSort").val();
                    plbSecurityKnowledge.technicalTypeName = $("#technicalTypeName").val();
                    // plbSecurityKnowledge.columnDesc = $("#columnDesc").val();
                    var parent = $("#pele").attr("pid");
                    if(parent==undefined||parent==""){
                        parent=0;
                    }
                    plbSecurityKnowledge.technicalParent =parent;
                    // plbSecurityKnowledge.sysCode = $("#pele").attr("pcode")
                    if($("#technicalTypeName").val()==''||$("#technicalSort").val()==''){ //||$("#columnCode").val()==''
                        layer.msg("必填项不能为空")
                    }else{
                        var loadIndex = layer.load(1);
                        $.ajax({
                            type: "post",
                            url: '/technicalManager/insertSecirityManager',
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
                                layer.close(loadIndex);
                            }
                        })
                    }
                }
            });
        })

        //左侧导入类型
        $('#importPlan').click(function () {
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
        })
        //左侧编辑类型
        $('#editPlan').click(function () {
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
                    '                                            <input type="text" id="technicalSort" name="technicalSort" lay-verify="required" placeholder="请输入排序号" autocomplete="off" class="layui-input">\n' +
                    '                                        </div>\n' +
                    '                                    </div>\n' +
                    '                                    <div class="layui-form-item">\n' +
                    '                                        <label class="layui-form-label"><span style="color: red;">*</span>类型名称</label>\n' +
                    '                                        <div class="layui-input-block">\n' +
                    '                                            <input type="text" name="technicalTypeName" id="technicalTypeName" lay-verify="required" placeholder="请输入" autocomplete="off" class="layui-input">\n' +
                    '                                        </div>\n' +
                    '                                    </div>\n' +
                    '                                    <div class="layui-form-item">\n' +
                    '                                        <label class="layui-form-label"><span style="color: red;">*</span>父级类型</label>\n' +
                    '                                        <div class="layui-input-block" id="parent" style="position: relative">\n' +
                    '                                            <input type="text" style="cursor: pointer" id="pele" pid name="ttitle" required="" placeholder="请选择父级(不选择默认为一级)" readonly="" autocomplete="off" class="layui-input">\n' +
                    '                                            <div class="eleTree ele2"  lay-filter="data1" style="display:none;position:absolute;border: 1px solid #d2d2d2;overflow-y: auto;background-color: #fff;border-radius: 2px;box-shadow: 0 2px 4px rgba(0,0,0,.12);box-sizing: border-box;z-index: 999;top:38px;left:0px;width: 99%;"></div>\n' +
                    '                                        </div>\n' +
                    '                                    </div>\n' +
                    '                                </form>',
                success: function () {
                    $.ajax({
                        url:'/technicalManager/selectSecurityManagerById?secirityId='+columnId,
                        dataType:'json',
                        type:'post',
                        success:function(res){
                            if(res.code===0||res.code==="0"){
                                if(res.obj){
                                    if(res.obj.technicalSort!=undefined&&res.obj.technicalSort!=""){
                                        $("#technicalSort").val(res.obj.technicalSort);
                                    }
                                    if(res.obj.technicalTypeName!=undefined&&res.obj.technicalTypeName!=""){
                                        $("#technicalTypeName").val(res.obj.technicalTypeName);
                                    }
                                    if(res.obj.technicalParent!=undefined&&res.obj.technicalParent!=""){
                                        $("#pele").val(res.obj.technicalParentName);
                                        $("#pele").attr("pid",res.obj.technicalParent);
                                    }
                                }
                            }
                        }
                    })
                    $("[name='ttitle']").on("click",function (e) {
                        e.stopPropagation();
                        ell=eleTree.render({
                            elem: '.ele2',
                            url:'/technicalManager/getSecurityByType?parent=0',
                            expandOnClickNode: false,
                            highlightCurrent: true,
                            showLine:true,
                            showCheckbox:true,
                            lazy: true,
                            load: function(data,callback) {
                                $.post('/technicalManager/getSecurityByType?parent='+data.id,function (res) {
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
                    plbSecurityKnowledge.securityKnowledgeId = columnId;
                    plbSecurityKnowledge.technicalSort = $("#technicalSort").val();
                    plbSecurityKnowledge.technicalTypeName = $("#technicalTypeName").val();
                    // plbSecurityKnowledge.columnDesc = $("#columnDesc").val();
                    var parent = $("#pele").attr("pid");
                    if(parent==undefined||parent==""){
                        parent=0;
                    }
                    plbSecurityKnowledge.technicalParent =parent;
                    // plbSecurityKnowledge.sysCode = $("#pele").attr("pcode")
                    if($("#technicalTypeName").val()==''||$("#technicalSort").val()==''){ //||$("#columnCode").val()==''
                        layer.msg("必填项不能为空")
                    }else{
                        if(columnId==$("#pele").attr("pid")){
                            layer.msg("父级类型不能是本身");
                            return false;
                        }
                        var loadIndex = layer.load(1);
                        $.ajax({
                            type: "post",
                            url: '/technicalManager/updateSecirityManager',
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
                                layer.close(loadIndex);
                            }
                        })
                    }
                }
            });
        })

        //左侧删除类型
        $('#delPlan').click(function () {
            if(columnId){
                layer.confirm('是否要删除', {icon: 3, title: '删除'}, function (index) {
                    $.ajax({
                        url: '/technicalManager/delSecurityByType',
                        data: {secirityId: columnId},
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
        })


        //计家云
        var SettlementTable2;
        var columnId2;

        var codeNo2;
        var codNam2;

        element.on('tab(docDemoTabBrief)', function(){
            childFunc2(columnId2);
        });



        // 节点点击事件
        eleTree.on("nodeClick(tdata22)",function(d) {
            var n1 = $("#ulBox").find("li.layui-this").attr("codeNo2");
            var na = $("#ulBox").find("li.layui-this").html();
            codNam2 = encodeURI(encodeURI(na));
            codeNo2 = n1;
            columnId2 = d.data.currentData.technicalTypeId;
            var clas = "";
            var dataid=$(clas+' div').attr("data-id")
            $('.eleTree-node').removeClass('back')
            $(d.node[0]).addClass('back')
            $('.eleTree-node-group').css('background','#fff')
            //调用子页面的方法
            childFunc2(columnId2);  //调用应用中方法
        });
        //选中监听事件
        var arr2 = [];
        eleTree.on("nodeChecked(tdata22)",function(d) {
            var id = d.data.currentData.columnId2;
            if(d.isChecked == true || d.isChecked == "true"){
                arr2.push(id);
            }else{
                arr2.remove(id);
            }
        })
        /*$(document).on("click",function() {
            $(".ele22").slideUp();
        })*/

        function childFunc2(columnId2){
            // 树右侧表格实例
            SettlementTable2 = layui.table.render({
                elem: '#Settlement2'
                // , data: []
                , url:'/knowledge/goToParent?url=/technicalManager/getKnowdgeByTypeId&typeId='+columnId2 //数据接口
                , page: { //支持传入 laypage 组件的所有参数（某些参数除外，如：jump/elem） - 详见文档
                    layout: ['prev', 'page', 'next', 'skip', 'count', 'limit',]//自定义分页布局
                    , limits: [10, 15, 20, 25, 30, 35, 40, 45, 50, 55, 60, 65, 70, 75, 80, 85, 90, 95, 100]
                    , first: false //不显示首页
                    , last: false //不显示尾页
                } //开启分页
                , toolbar: '#toolbar2'
                , cols: [[ //表头
                    {type: 'checkbox'}
                    , {field: 'docfileId',width:50, title: 'ID'}
                    //, {field: 'docfileNo', title: '文档编号'}
                    , {field: 'docfileName', event: 'detail',title: '文档名称',templet: function (d) {
                            var detail = d.docfileName;
                            if ('' == detail || null == detail || undefined == detail) {
                                return '';
                            }
                            if(detail.length > 0) {
                                return '<a style="cursor: pointer;color: blue" style="margin-left: 10px" href="javascript:;">'+d.docfileName+'</a>'
                            }
                        }}
                    , {field: 'keyWord', title: '关键词'}
                    , {field: 'docfileClass', title: '文档等级'}
                    , {field: 'createUserId', title: '上传人'}
                    , {field: 'createTime', title: '上传时间'}
                    // , {field: 'downloadPassword', title: '下载密码'}
                    , {field: 'docfileDesc', title: '文档摘要'}
                    //, {field: 'columnName', title: '知识类别'}
                    //,{width:250, title: '操作',align:'center', toolbar: '#barOperation'}
                ]]
                , limit: 10
                , done: function (res) {
                }
            });
        }
        //表格头工具事件
        //var parData3;
        var columnTrId3;
        var codeNo3;
        var codNam3;
        table.on('toolbar(SettlementFilter2)', function(obj){
            var checkStatus = table.checkStatus("Settlement2").data[0];
            var event = obj.event;
            switch(event){
                case 'supplierImport2': //导入本地
                    if(table.checkStatus("Settlement2").data.length!='1'){
                        layer.msg("请选择一条");
                    }else{
                        layer.open({
                            type: 1,
                            skin: 'layui-layer-molv', //加上边框
                            area: ['23%', '64%'], //宽高
                            title: '导入本地',
                            maxmin: true,
                            btn: ['确定', '取消'],
                            content:
                                '<div class="layui-card-body" style="height: 100%">'+
                                '<div class="panel-body" style="width: 100%">'+
                                '<div class="eleTree elee4" lay-filter="tdata1"></div>'+
                                '</div>'+
                                '</div>',
                            success: function () {
                                // 初始化渲染 树形菜单
                                var el = eleTree.render({
                                    elem: '.elee4',
                                    showLine:true,
                                    url:'/technicalManager/getSecurityByType?parent=0',
                                    lazy: true,
                                    // checked: true,
                                    load: function(data,callback) {
                                        $.post('/technicalManager/getSecurityByType?parent='+data.id,function (res) {
                                            callback(res.data);//点击节点回调
                                        })
                                    },
                                    done:function (data) { //渲染完成回调
                                        var n1 = $("#ulBox").find("li.layui-this").attr("codeNo");
                                        var na = $("#ulBox").find("li.layui-this").html();
                                        codNam3 = encodeURI(encodeURI(na));
                                        codeNo3 = n1;
                                        if(data.data.length == 0){
                                            $('.elee4').html('<div style="text-align: center">暂无数据</div>');
                                            columnTrId3 = undefined;
                                        }else{
                                            columnTrId3 = data.data[0].id;
                                            var dataid=$('.elee4 div').attr("data-id")
                                            $('.eleTree-node').removeClass('back')
                                            $('.elee4 div[data-id='+dataid+']').addClass('back')
                                            $('.eleTree-node-group').css('background','#fff');
                                        }
                                    }
                                });
                                // 节点点击事件
                                eleTree.on("nodeClick(tdata1)",function(d) {
                                    //parData3 = d.data.currentData;
                                    var n1 = $("#ulBox").find("li.layui-this").attr("codeNo3");
                                    var na = $("#ulBox").find("li.layui-this").html();
                                    codNam3 = encodeURI(encodeURI(na));
                                    codeNo3 = n1;
                                    columnTrId3 = d.data.currentData.id;
                                    var clas = "";
                                    var dataid=$(clas+' div').attr("data-id")
                                    $('.eleTree-node').removeClass('back')
                                    $(d.node[0]).addClass('back')
                                    $('.eleTree-node-group').css('background','#fff')
                                });
                            },
                            yes: function (index, layero) {
                                delete  checkStatus.createUserId;
                                delete  checkStatus.createTime;
                                delete  checkStatus.docfileId;
                                checkStatus.technicalTypeId = columnTrId3;
                                $.ajax({
                                    url:'/technicalManager/insertSecurityDanger',
                                    type: 'post',
                                    dataType:'json',
                                    data:checkStatus,
                                    success:function(res){
                                        if(res.code===0||res.code==="0"){
                                            layer.close(index);
                                        }
                                        layer.msg(res.msg)
                                    }
                                })
                            }
                        });
                    }
                    break;
            };
        });

})
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
