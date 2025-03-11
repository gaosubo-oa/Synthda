

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
    <title>知识库-客户角色管理</title>
    <link rel="stylesheet" href="/lib/layui/layui/css/layui.css?20210319.1">
    <link rel="stylesheet" href="/lib/layui/layui/css/common.css">
    <link rel="stylesheet" href="/lib/layui/layui/css/eleTree.css">
    <script src="/lib/layui/layui/layui.js"></script>
    <script type="text/javascript" src="../../js/xoajq/xoajq1.js"></script>
    <script src="/lib/layui/layui/js/limstree.js?v=2019080601" type="text/javascript" charset="utf-8"></script>
    <script src="/lib/layui/layui/js/common.js?v=20190726" type="text/javascript" charset="utf-8"></script>
    <script type="text/javascript" src="/lib/layui/layui/global.js"></script>
    <%--<script type="text/javascript" src="/lims/layer/layer.js?20201106"></script>--%>


    <style>
        .layui-card-header {
            border-bottom: 1px solid #eee;
        }

        .inbox {
            padding: 10px;
            padding-right: 30px;
        }

        .deptinput {
            display: inline-block;
            width: 75%;
        }

        .layui-btn {
            margin-left: 10px;
        }

        .layui-btn .layui-icon {
            margin-right: 0px;
        }

        .red {
            color: red;
            font-size: 16px;
        }

        .layui-form-label {
            padding: 8px 15px;
        }
        .laytable-cell-1-0-4,.laytable-cell-1-0-5{
            overflow: visible;
        }
        #addTableDiv .laytable-cell-2-0-3{
            overflow: visible;
        }

    </style>
    <style>
        /*  lr 添加   */
        #addTableButton ,#ready{
            width: 70px;
            margin-top: 20px;
            margin-left: 16px;
        }
        #syncactive{
            width: 90px;
            margin-top: 20px;
            margin-left: 16px;
        }
        #deleteButton{
            width: 70px;
            margin-top: 20px;
            margin-left: 16px;
            background-color: #ff5722;
        }
        #saveTbleButton{
            width: 70px;
            margin-top: 20px;
            margin-left: 89%;
            display: none;
        }
        .layui-table-sort{
            margin-left: -5px;
        }
        #outTableButton{
            width: 70px;
            margin-top: 20px;
            margin-left: 16px;
        }
        #redTableButton{
            width: 70px;
            margin-top: 20px;
            margin-left: 16px;
        }
    </style>
    <style>

        .layui-btn {
            margin-left: 10px;
        }
        .inbox{
            padding: 10px;
            padding-right: 30px;
        }
        .layui-btn .layui-icon {
            margin-right: 0px;
        }

        #addTableButton{
            width: 70px;
            margin-top: 20px;
            margin-left: 16px;
        }
        #deleteButton{
            width: 70px;
            margin-top: 20px;
            margin-left: 16px;
            background-color: #ff5722;
        }
        #saveTbleButton{
            width: 70px;
            margin-top: 20px;
            display: none;
            position: absolute;
            right: 3%;
        }

        .layui-collapse{
            margin-top: 15px;
        }

        .layui-table, .layui-table-view{
            margin: 0;
        }

        .laytable-cell-2-0-2{
            overflow: visible !important;
        }

        .laytable-cell-2-0-4{
            overflow: visible !important;
        }
        .layui-table-box {
            overflow: visible !important;
        }

        .layui-table-body {
            overflow: visible !important;
        }
        .layui-colla-item{
            position: relative;
        }
        .gnbox{
            position: absolute;
            right: 5px;
            top:12px;
            margin-right: 10px;
            z-index: 88;
        }

        .ydel{
            margin-left: 5px;
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
        td .layui-form-select {
            margin-top: -10px;
            margin-left: -15px;
            margin-right: -15px;
        }
        .red{
            color: red;
            font-size: 16px;
        }
        .layui-form-label{
            padding: 8px 15px;
        }
        #addTableDivp td[data-field="columnName"] .layui-table-cell .layui-input.layui-unselect,
        #addTableDiv td[data-field="columnName"] .layui-table-cell .layui-input.layui-unselect{
            height: 100%;
        }
        .layui-table-click{
            background-color: inherit;
        }
        .bgss{
            background-color: #e8f4fc;
        }
        .layui-disabled, .layui-disabled:hover{
            color: rgb(102, 102, 102)!important;
        }
        .layui-treeSelect .ztree li span.button.switch{
            top: -10px!important;
        }
        .disable{
            pointer-events: none;
            cursor: not-allowed!important;
        }
        .disabled:hover{
            cursor:not-allowed!important;
        }

        .eleTree-node-content-label{
            display: inline-block;
            width:99%!important;
        }
        .ele1 div.eleTree-node:nth-child(1){
            overflow: hidden;
        }

        .eleTree-node-content-label{
            display: inline-block;
            width:99%!important;
        }
        .ele1 div.eleTree-node:nth-child(1){
            overflow: hidden;
        }
        #addTableDivp td[data-field="columnName"] .layui-table-cell,
        #addTableDiv td[data-field="columnName"] .layui-table-cell{
            overflow: visible !important;
        }
        /*.layui-form-select dl dd, .layui-form-select dl dt{*/
        /*line-height: 21px;*/
        /*}*/
        .disable{
            pointer-events: none;
            cursor: default;
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


<div class="mbox">
    <div class="layui-card">
        <div>
            <button data-type="0" id="addTableButton" class="layui-btn layui-btn-sm">新增</button>
            <button data-type="0" id="deleteButton" class="layui-btn layui-btn-sm">删除</button>
            <%--            <button data-type="0" id="outTableButton" class="layui-btn layui-btn-sm" lay-event="add"  >导出</button>--%>
            <%--            <button data-type="0" id="redTableButton" class="layui-btn layui-btn-sm" lay-event="add"  >导入</button>--%>
            <button data-type="0" id="saveTbleButton" class="layui-btn layui-btn-sm">保存</button>
        </div>
        <div id="addTableDiv" class="layui-card-body" style="display: none">
            <table id="addTable" lay-filter="addTableFilter"></table>
        </div>
        <div class="layui-card-body" id="addTableDivp">
            <table id="Settlement" lay-filter="SettlementFilter"></table>
        </div>
    </div>

</div>


<script type="text/html" id="barOperation">
    <a data-type="1" class="layui-btn layui-btn-xs" lay-event="edit">编辑</a>
    <a class="layui-btn layui-btn-xs" lay-event="info">详情</a>
    <a class="layui-btn layui-btn-danger layui-btn-xs" lay-event="del">删除</a>
</script>

<script type="text/html" id="addTableDel">
    <a class="layui-btn layui-btn-danger layui-btn-xs" lay-event="del2">删除</a>
</script>

<script type="text/javascript">
    var deptAll;
    var privAll;
    var docclassAll;
    var data=[];
    var  resultform; //形态
    var selectform="";

    var unitId = ""; //单位ID
    var addTabledata; //单位回显
    var  resultinputType;  //输入类型
    var selectinputType=""; //当前输入类型

    layui.use(['table', 'layer', 'form','treeSelect','eleTree'], function () {
        var table = layui.table;
        var layer = layui.layer;
        var form = layui.form;
        var treeSelect = layui.treeSelect;
        var eleTree = layui.eleTree;

        //第一个实例
        var tableIns = table.render({
            elem: '#Settlement'
            ,url: '/clientRole/getAllRoleColumn' //数据接口
            ,page: true //开启分页
            ,toolbar:'#toolbar'
            ,cols: [[ //表头
                {type: 'checkbox'}
                ,{type: 'numbers', title: '序号', width: 60}
                ,{field: 'roleName', title: '角色名称'}
                ,{field: 'columnName', title: '知识类别',event: 'eeleFn',templet:function(d){
                        var str = '<div class="layui-input-inline" id="parentColumnId" style="position: relative;top:-5px;width: 100%;">\n' +
                            '<input type="text" data-type="0" id="pele'+d.LAY_TABLE_INDEX+'" ind="'+d.LAY_TABLE_INDEX+'"  value="'+undefind_nullStr(d.columnName)+'" pid="'+undefind_nullStr(d.columnId)+'" name="tatitle" required="" style="cursor: pointer" lay-verify="required" placeholder="请选择" readonly="" autocomplete="off" class="layui-input eele">\n' +
                            '<div class="eleTree eele'+d.LAY_TABLE_INDEX+'" lay-filter="data1" style="display:none;position:absolute;border: 1px solid #d2d2d2;overflow-y: auto;background-color: #fff;border-radius: 2px;box-shadow: 0 2px 4px rgba(0,0,0,.12);box-sizing: border-box;overflow:hidden;z-index: 999;top:38px;left:0px;width: 100%;"></div></div></div>'
                        return str;
                    }}
                ,{field: 'privId', title: 'oa角色',templet:function(d){
                        var str = "<select name='privId' lay-filter='privId'><option>请选择</option>";
                        if(d.privList!=undefined&&d.privList.length>0){
                            for(var i=0;i<d.privList.length;i++){
                                if(d.privId===d.privList[i].userPriv){
                                    str+="<option selected value="+d.privList[i].userPriv+">"+d.privList[i].privName+"</option>"
                                }else{
                                    str+="<option value="+d.privList[i].userPriv+">"+d.privList[i].privName+"</option>"
                                }
                            }
                        }
                        str +="</select>";
                        return str;
                    }}
                ,{field: 'docfileClass', title: '文档等级',templet:function(d){
                        var str = "<select name='docfileClass' lay-filter='docfileClass'><option>请选择</option>";
                        if(d.fileClassList!=undefined&&d.fileClassList.length>0){
                            for(var i=0;i<d.fileClassList.length;i++){
                                if(d.docfileClass===d.fileClassList[i].codeNo){
                                    str+="<option selected value="+d.fileClassList[i].codeNo+">"+d.fileClassList[i].codeName+"</option>"
                                }else{
                                    str+="<option value="+d.fileClassList[i].codeNo+">"+d.fileClassList[i].codeName+"</option>"
                                }
                            }
                        }
                        str +="</select>";
                        return str;
                    }}
                ,{width:180, title: '操作',align:'center',toolbar:'#barOperation'}
            ]]
            ,done:function(obj){
                var data = obj.data;
                if(obj.data!=undefined&&obj.data.length>0){
                    deptAll = obj.data[0].deptList;
                    privAll = obj.data[0].privList;
                    docclassAll =  obj.data[0].fileClassList;
                }else{
                    $.ajax({
                        url: '/userPriv/getAllPriv?IsPriv=1',
                        dataType: 'json',
                        type: 'get',
                        success: function (res) {
                            privAll = res.obj
                        }
                    })
                    $.ajax({ //查询文档等级
                        url: '/code/getCode?parentNo=KNOWLEDGE_DOCFILE_CLASS',
                        type: 'get',
                        dataType: 'json',
                        async:false,
                        success: function (res) {
                            if(res.obj!=undefined&&res.obj.length>0){
                                docclassAll = res.obj
                            }
                        }
                    })
                }
                if(obj.data!=undefined&&obj.data.length>0){
                    for(var i=0;i<obj.data.length;i++){
                        (function(i){
                            var columnId = obj.data[i].columnId;
                            var elm = '.eele'+i
                            eleTree.render({
                                elem: '.eele'+i,
                                url:'/knowledge/childTree',
                                expandOnClickNode: false,
                                highlightCurrent: true,
                                showLine:true,
                                showCheckbox: true,
                                checked: true,
                                defaultExpandAll: true,
                                load: function (data, callback) {
                                },
                                done: function(res){
                                    var pidar = columnId.split(",");
                                    var pidarr=[];
                                    for(var j =0;j<pidar.length;j++){
                                        if(pidar[j] == ""){

                                        }else{
                                            pidarr.push(pidar[j]);
                                        }
                                    }
                                    for(var j=0;j<pidarr.length;j++){
                                        $(elm+" div[data-id="+pidarr[j]+"]").find("input").eq(0).attr("checked",true);
                                        $(elm+" div[data-id="+pidarr[j]+"]").find("input").eq(0).attr("eletree-status","1");
                                        // $(elm+" div[data-id="+pidarr[j]+"]").find("input").eq(0).addClass("eleTree-disabled");
                                        $(elm+" div[data-id="+pidarr[j]+"]").find("input").eq(0).next("div.eleTree-checkbox").addClass("eleTree-checkbox-checked");
                                        $(elm+" div[data-id="+pidarr[j]+"]").find("input").eq(0).next("div.eleTree-checkbox").find("i").addClass("layui-icon-ok");
                                    }
                                }
                            });
                        })(i);
                    }
                }
                $('#addTableDivp td[data-field="columnName"]').addClass("disable")
                $('#addTableDivp td[data-field="privId"]').addClass("disable")
                $('#addTableDivp td[data-field="deptId"]').addClass("disable")
                $('#addTableDivp td[data-field="docfileClass"]').addClass("disable")
                form.on('select(deptId)', function(pr){
                    var dataindex=$(pr.elem).parents('tr').attr("data-index");
                    data[dataindex].deptId=pr.value;
                });
                var selectId = $(this.elem[0].nextElementSibling)
                    , mineSelparentTyepNo = $(selectId).find("select[name='deptId']")
                if(obj.data!=undefined&&obj.data.length>0){
                    for (var i = 0; i < obj.data.length; i++) {
                        layui.each(mineSelparentTyepNo, function (index, item) {
                            if (index == i) $(item).find('option[value="' + obj.data[i].deptId + '"]').prop('selected', 'selected');
                            // $(item).attr('disabled', 'disabled').attr('dataType', '1')
                        });
                    }
                }
                form.on('select(privId)', function(pr){
                    var dataindex=$(pr.elem).parents('tr').attr("data-index");
                    data[dataindex].privId=pr.value;
                });
                var selectId = $(this.elem[0].nextElementSibling)
                    , mineSelparentTyepNo = $(selectId).find("select[name='privId']")
                if(obj.data!=undefined&&obj.data.length>0){
                    for (var i = 0; i < obj.data.length; i++) {
                        layui.each(mineSelparentTyepNo, function (index, item) {
                            if (index == i) $(item).find('option[value="' + obj.data[i].privId + '"]').prop('selected', 'selected');
                            // $(item).attr('disabled', 'disabled').attr('dataType', '1')
                        });
                    }
                }
                form.render()
            }
            ,parseData: function(res){ //res 即为原始返回的数据
                return {
                    "code": 0, //解析接口状态
                    "msg": res.msg, //解析提示文本
                    "count": res.totleNum, //解析数据长度
                    "data": res.data //解析数据列表
                };
            }
        });
        table.on('tool(SettlementFilter)', function (obj) { //注：tool是工具条事件名，test是table原始容器的属性 lay-filter="对应的值"
            var data = obj.data; //获得当前行数据
            var roleId = data.roleId;
            var layEvent = obj.event; //获得 lay-event 对应的值（也可以是表头的 event 参数对应的值）
            var tr = obj.tr; //获得当前行 tr 的DOM对象
            var me=$(this);
            var isEdit=$(this).data("edit"); //是否编辑
            var sort=data.sort;//得到排序号
            var type=0;
            if (layEvent === 'edit') { //编辑
                layer.open({
                    type: 1,
                    skin: 'layui-layer-molv', //加上边框
                    area: ['60%', '80%'], //宽高
                    title: '编辑',
                    closeBtn: 1,
                    btn: ['确定','取消'],
                    content: '<div class="layui-form" style="width: 80%;margin: 0 auto;">'+
                    '<div class="layui-form-item" style="margin-top: 15px;">'+
                    '<label class="layui-form-label" style="">角色名称</label>'+
                    '<div class="layui-input-block">'+
                    '<input type="text" style="height: 38px;" id="roleName" name="roleName" lay-verify="required" placeholder="请输入" autocomplete="off" class="layui-input">'+
                    '</div>'+
                    '</div>'+
                    '<div class="layui-form-item">'+
                    '<label class="layui-form-label" style="">文档等级</label>'+
                    '<div class="layui-input-block">'+
                    '<select id="adddocfileClass" style="height: 38px;" name="adddocfileClass" lay-filter="adddocfileClass"></select>'+
                    '</div>'+
                    '</div>'+
                    '<div class="layui-form-item">'+
                    '<label class="layui-form-label" style="">OA角色</label>'+
                    '<div class="layui-input-block">'+
                    '<select id="addprivId" style="height: 38px;" name="addprivId" lay-filter="addprivId"></select>'+
                    '</div>'+
                    '</div>'+
                    '<div class="layui-form-item">'+
                    '<label class="layui-form-label" style="">知识栏目</label>'+
                    '<div class="layui-input-block">'+
                    '<div id="treeBox"><textarea type="text" data-type="0" id="addpele"   value="" pid="" name="ttitle" required="" style="cursor: pointer" lay-verify="required" placeholder="请选择" readonly="" autocomplete="off" class="layui-input ele"></textarea>' +
                    '<div class="eleTree addele" lay-filter="data2" style="display:none;position:absolute;border: 1px solid #d2d2d2;overflow-y: auto;background-color: #fff;border-radius: 2px;box-shadow: 0 2px 4px rgba(0,0,0,.12);box-sizing: border-box;overflow:hidden;z-index: 999;top:38px;left:0px;width: 100%;"></div></div>'+
                    '</div>'+
                    '</div>'+
                    '</div>'
                    , success: function () {
                        $("#roleName").val(undefind_nullStr(data.roleName))
                        //查询文档等级
                        $.ajax({ //查询文档等级
                            url: '/code/getCode?parentNo=KNOWLEDGE_DOCFILE_CLASS',
                            type: 'get',
                            dataType: 'json',
                            async:false,
                            success: function (res) {
                                if(res.obj!=undefined&&res.obj.length>0){
                                    var optionStr = '<option>请选择</option>'
                                    for(var i=0;i<res.obj.length;i++){
                                        optionStr += '<option value="' + res.obj[i].codeNo + '">' + res.obj[i].codeName + '</option>'
                                    }
                                    $("#adddocfileClass").html(optionStr);
                                    $("#adddocfileClass").find('option[value="'+data.docfileClass+'"]').prop('selected', 'selected');
                                    form.render();
                                }
                            }
                        })
                        $.ajax({
                            url: '/userPriv/getAllPriv?IsPriv=1',
                            dataType: 'json',
                            type: 'get',
                            success: function (res) {
                                if(res.obj!=undefined&&res.obj.length>0){
                                    var optionStr = '<option>请选择</option>'
                                    for(var i=0;i<res.obj.length;i++){
                                        optionStr += '<option value="'+res.obj[i].userPriv+'">'+res.obj[i].privName+'</option>'
                                    }
                                    $("#addprivId").html(optionStr);
                                    $("#addprivId").find('option[value="'+data.privId+'"]').prop("selected",true);
                                    form.render();
                                }
                            }
                        })
                        //知识栏目
                        eleTree.render({
                            elem: '.addele',
                            url:'/knowledge/childTree',
                            expandOnClickNode: false,
                            highlightCurrent: true,
                            showLine:true,
                            showCheckbox: true,
                            checked: true,
                            defaultExpandAll: true,
                            done: function(res){
                                var arr1 = [];
                                var arr2 = res.obj;
                                for(var i =0;i<res.data.length;i++){
                                    arr1.push(res.data[i].id);
                                }
                                for(var i =0;i<arr1.length;i++){
                                    for(var j=0;j<arr2.length;j++){
                                        if(arr1[i] == arr2[j]){
                                            $("div[data-id="+arr2[j]+"]").find("input").eq(0).attr("disabled",true);
                                            $("div[data-id="+arr2[j]+"]").find("input").eq(0).attr("eletree-status","0");
                                            $("div[data-id="+arr2[j]+"]").find("input").eq(0).addClass("eleTree-disabled");
                                            $("div[data-id="+arr2[j]+"]").find("input").eq(0).next("div.eleTree-checkbox").addClass("eleTree-checkbox-disabled");
                                        }
                                    }
                                }
                                var columnId = data.columnId;
                                var columnName = data.columnName;
                                var pidarr = [];
                                var idstr = "";
                                var nastr = "";
                                if(columnId != undefined || columnId != "undefined" || columnId != "" || columnId != null){
                                    var idarr = columnId.split(",")
                                    for(var i=0;i<idarr.length;i++){
                                        if(idarr[i] == ""){

                                        }else{
                                            idstr += idarr[i] + ",";
                                            pidarr.push(idarr[i]);
                                        }
                                    }
                                }
                                if(columnName != undefined || columnName != "undefined" || columnName != "" || columnName != null){
                                    var naarr = columnName.split(",")
                                    for(var i=0;i<naarr.length;i++){
                                        if(naarr[i] == ""){

                                        }else{
                                            nastr += naarr[i] + ",";
                                        }
                                    }
                                }
                                $('#treeBox').find("textarea.ele").val(nastr);
                                $('#treeBox').find("textarea.ele").attr("pid",idstr);
                                for(var j=0;j<pidarr.length;j++){
                                    $(".addele div[data-id="+pidarr[j]+"]").find("input").eq(0).attr("checked",true);
                                    $(".addele div[data-id="+pidarr[j]+"]").find("input").eq(0).attr("eletree-status","1");
                                    // $(elm+" div[data-id="+pidarr[j]+"]").find("input").eq(0).addClass("eleTree-disabled");
                                    $(".addele div[data-id="+pidarr[j]+"]").find("input").eq(0).next("div.eleTree-checkbox").addClass("eleTree-checkbox-checked");
                                    $(".addele div[data-id="+pidarr[j]+"]").find("input").eq(0).next("div.eleTree-checkbox").find("i").addClass("layui-icon-ok");
                                }
                            }
                        });
                        $('#treeBox').click(function(e){
                            e.stopPropagation();
                            if($('#treeBox').find("textarea.ele").attr("data-type") == "0"){
                                $('#treeBox').find(".eleTree").slideDown();
                                $('#treeBox').find("textarea.ele").attr("data-type","1");
                            }else{
                                $('#treeBox').find(".eleTree").slideUp();
                                $('#treeBox').find("textarea.ele").attr("data-type","0");
                            }
                        })
                        //点击本身外收起下拉的主体
                        document.onmouseup = function(e){
                            var e = e || window.event;
                            var target = e.target || e.srcElement;
                            //1. 点击事件的对象不是目标区域本身
                            //2. 事件对象同时也不是目标区域的子元素
                            if(!$('#treeBox').is(e.target) &&$('#treeBox').has(e.target).length === 0){
                                $(".eleTree").slideUp();
                                $("input.ele").attr("data-type","0");
                            }
                        }
                        //选中监听事件
                        var arr = [];
                        var arr1 = [];
                        var pidt = $('#treeBox').find("textarea.ele").attr("pid");
                        var valt = $('#treeBox').find("textarea.ele").val();
                        if(pidt != undefined || pidt != "undefined" || pidt != "" || pidt != null){
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
                        if(valt != undefined || valt != "undefined" || valt != "" || valt != null){
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
                        layui.eleTree.on("nodeChecked(data2)",function(d) {
                            var id = d.data.currentData.columnId + "";
                            var label = d.data.currentData.label + "";
                            if(d.isChecked == true || d.isChecked == "true"){
                                arr.push(id);
                                arr1.push(label);
                            }else{
                                arr.remove(id);
                                arr1.remove(label);
                            }
                            var str = "";
                            var str1 = "";
                            for(var i=0;i<arr.length;i++){
                                str+=arr[i]+","
                                str1+=arr1[i]+","
                            }
                            $('#treeBox').find("textarea.ele").val(str1);
                            $('#treeBox').find("textarea.ele").attr("pid",str);
                        })
                    },
                    yes: function (index, layero) {
                        var columnId = $('#treeBox').find("textarea.ele").attr("pid");
                        var columnName = $('#treeBox').find("textarea.ele").val();
                        var data = [];
                        var obj = {};
                        obj.roleId = roleId;
                        obj.columnId = columnId;
                        obj.columnName = columnName;
                        obj.roleName = $("#roleName").val();
                        obj.privId=$("select[name='addprivId']").next(".layui-unselect").find("dl dd.layui-this").attr("lay-value")
                        obj.privName=$("select[name='addprivId']").next(".layui-unselect").find("dl dd.layui-this").text();
                        obj.docfileClass = $("#adddocfileClass").next(".layui-unselect").find("dl dd.layui-this").attr("lay-value");
                        $.ajax({
                            url:"/clientRole/editRole",
                            data:obj,
                            type: 'post',
                            dataType: 'json',
                            success: function (res){
                                layui.layer.msg(res.msg)
                                if(res.flag){
                                    tableIns.reload();
                                    layer.close(index)
                                }
                            }
                        });
                    }
                });
            }else if(layEvent=='del'){//删除
                layui.layer.confirm('确定要删除吗?', {icon: 3, title:'提示'}, function(index){
                    var ids=data.roleId+",";
                    $.ajax({
                        url:"/clientRole/delRole",
                        data:{ids:ids},
                        type: 'post',
                        dataType: 'json',
                        success: function (res){
                            layui.layer.msg(res.msg)
                            if(res.flag){
                                tableIns.reload();
                            }
                        }
                    });
                })
            }else if(layEvent=='info'){
                var roleId = data.roleId;
                layer.open({
                    type: 1,
                    skin: 'layui-layer-molv', //加上边框
                    area: ['60%', '80%'], //宽高
                    title: '详情',
                    closeBtn: 1,
                    btn: ['关闭'],
                    content: '<div class="layui-form disable" style="width: 80%;margin: 0 auto;">'+
                    '<div class="layui-form-item" style="margin-top: 15px;">'+
                    '<label class="layui-form-label" style="">角色名称</label>'+
                    '<div class="layui-input-block">'+
                    '<input type="text" style="height: 38px;" id="roleName" name="roleName" lay-verify="required" placeholder="请输入" autocomplete="off" class="layui-input">'+
                    '</div>'+
                    '</div>'+
                    '<div class="layui-form-item">'+
                    '<label class="layui-form-label" style="">文档等级</label>'+
                    '<div class="layui-input-block">'+
                    '<select id="adddocfileClass" style="height: 38px;" name="adddocfileClass" lay-filter="adddocfileClass"></select>'+
                    '</div>'+
                    '</div>'+
                    '<div class="layui-form-item">'+
                    '<label class="layui-form-label" style="">OA角色</label>'+
                    '<div class="layui-input-block">'+
                    '<select id="addprivId" style="height: 38px;" name="addprivId" lay-filter="addprivId"></select>'+
                    '</div>'+
                    '</div>'+
                    '<div class="layui-form-item">'+
                    '<label class="layui-form-label" style="">知识栏目</label>'+
                    '<div class="layui-input-block">'+
                    '<div id="treeBox"><textarea type="text" data-type="0" id="addpele"   value="" pid="" name="ttitle" required="" style="cursor: pointer" lay-verify="required" placeholder="请选择" readonly="" autocomplete="off" class="layui-input ele"></textarea>' +
                    '<div class="eleTree addele" lay-filter="data2" style="display:none;position:absolute;border: 1px solid #d2d2d2;overflow-y: auto;background-color: #fff;border-radius: 2px;box-shadow: 0 2px 4px rgba(0,0,0,.12);box-sizing: border-box;overflow:hidden;z-index: 999;top:38px;left:0px;width: 100%;"></div></div>'+
                    '</div>'+
                    '</div>'+
                    '</div>'
                    , success: function () {
                        $("#roleName").val(undefind_nullStr(data.roleName))
                        //查询文档等级
                        $.ajax({ //查询文档等级
                            url: '/code/getCode?parentNo=KNOWLEDGE_DOCFILE_CLASS',
                            type: 'get',
                            dataType: 'json',
                            async:false,
                            success: function (res) {
                                if(res.obj!=undefined&&res.obj.length>0){
                                    var optionStr = '<option>请选择</option>'
                                    for(var i=0;i<res.obj.length;i++){
                                        optionStr += '<option value="' + res.obj[i].codeNo + '">' + res.obj[i].codeName + '</option>'
                                    }
                                    $("#adddocfileClass").html(optionStr);
                                    $("#adddocfileClass").find('option[value="'+data.docfileClass+'"]').prop("selected",true);
                                    form.render();
                                }
                            }
                        })
                        $.ajax({
                            url: '/userPriv/getAllPriv?IsPriv=1',
                            dataType: 'json',
                            type: 'get',
                            success: function (res) {
                                if(res.obj!=undefined&&res.obj.length>0){
                                    var optionStr = '<option>请选择</option>'
                                    for(var i=0;i<res.obj.length;i++){
                                        optionStr += '<option value="'+res.obj[i].userPriv+'">'+res.obj[i].privName+'</option>'
                                    }
                                    $("#addprivId").html(optionStr);
                                    $("#addprivId").find('option[value="'+data.privId+'"]').prop("selected",true);
                                    form.render();
                                }
                            }
                        })
                        //知识栏目
                        eleTree.render({
                            elem: '.addele',
                            url:'/knowledge/childTree',
                            expandOnClickNode: false,
                            highlightCurrent: true,
                            showLine:true,
                            showCheckbox: true,
                            checked: true,
                            defaultExpandAll: true,
                            done: function(res){
                                var arr1 = [];
                                var arr2 = res.obj;
                                for(var i =0;i<res.data.length;i++){
                                    arr1.push(res.data[i].id);
                                }
                                for(var i =0;i<arr1.length;i++){
                                    for(var j=0;j<arr2.length;j++){
                                        if(arr1[i] == arr2[j]){
                                            $("div[data-id="+arr2[j]+"]").find("input").eq(0).attr("disabled",true);
                                            $("div[data-id="+arr2[j]+"]").find("input").eq(0).attr("eletree-status","0");
                                            $("div[data-id="+arr2[j]+"]").find("input").eq(0).addClass("eleTree-disabled");
                                            $("div[data-id="+arr2[j]+"]").find("input").eq(0).next("div.eleTree-checkbox").addClass("eleTree-checkbox-disabled");
                                        }
                                    }
                                }
                                var columnId = data.columnId;
                                var columnName = data.columnName;
                                var pidarr = [];
                                var idstr = "";
                                var nastr = "";
                                if(columnId != undefined || columnId != "undefined" || columnId != "" || columnId != null){
                                    var idarr = columnId.split(",")
                                    for(var i=0;i<idarr.length;i++){
                                        if(idarr[i] == ""){

                                        }else{
                                            idstr += idarr[i] + ",";
                                            pidarr.push(idarr[i]);
                                        }
                                    }
                                }
                                if(columnName != undefined || columnName != "undefined" || columnName != "" || columnName != null){
                                    var naarr = columnName.split(",")
                                    for(var i=0;i<naarr.length;i++){
                                        if(naarr[i] == ""){

                                        }else{
                                            nastr += naarr[i] + ",";
                                        }
                                    }
                                }
                                $('#treeBox').find("textarea.ele").val(nastr);
                                $('#treeBox').find("textarea.ele").attr("pid",idstr);
                                for(var j=0;j<pidarr.length;j++){
                                    $(".addele div[data-id="+pidarr[j]+"]").find("input").eq(0).attr("checked",true);
                                    $(".addele div[data-id="+pidarr[j]+"]").find("input").eq(0).attr("eletree-status","1");
                                    // $(elm+" div[data-id="+pidarr[j]+"]").find("input").eq(0).addClass("eleTree-disabled");
                                    $(".addele div[data-id="+pidarr[j]+"]").find("input").eq(0).next("div.eleTree-checkbox").addClass("eleTree-checkbox-checked");
                                    $(".addele div[data-id="+pidarr[j]+"]").find("input").eq(0).next("div.eleTree-checkbox").find("i").addClass("layui-icon-ok");
                                }
                            }
                        });
                        $('#treeBox').click(function(e){
                            e.stopPropagation();
                            if($('#treeBox').find("textarea.ele").attr("data-type") == "0"){
                                $('#treeBox').find(".eleTree").slideDown();
                                $('#treeBox').find("textarea.ele").attr("data-type","1");
                            }else{
                                $('#treeBox').find(".eleTree").slideUp();
                                $('#treeBox').find("textarea.ele").attr("data-type","0");
                            }
                        })
                        //点击本身外收起下拉的主体
                        document.onmouseup = function(e){
                            var e = e || window.event;
                            var target = e.target || e.srcElement;
                            //1. 点击事件的对象不是目标区域本身
                            //2. 事件对象同时也不是目标区域的子元素
                            if(!$('#treeBox').is(e.target) &&$('#treeBox').has(e.target).length === 0){
                                $(".eleTree").slideUp();
                                $("input.ele").attr("data-type","0");
                            }
                        }
                        //选中监听事件
                        var arr = [];
                        var arr1 = [];
                        var pidt = $('#treeBox').find("textarea.ele").attr("pid");
                        var valt = $('#treeBox').find("textarea.ele").val();
                        if(pidt != undefined || pidt != "undefined" || pidt != "" || pidt != null){
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
                        if(valt != undefined || valt != "undefined" || valt != "" || valt != null){
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
                        layui.eleTree.on("nodeChecked(data2)",function(d) {
                            var id = d.data.currentData.columnId + "";
                            var label = d.data.currentData.label + "";
                            if(d.isChecked == true || d.isChecked == "true"){
                                arr.push(id);
                                arr1.push(label);
                            }else{
                                arr.remove(id);
                                arr1.remove(label);
                            }
                            var str = "";
                            var str1 = "";
                            for(var i=0;i<arr.length;i++){
                                str+=arr[i]+","
                                str1+=arr1[i]+","
                            }
                            $('#treeBox').find("textarea.ele").val(str1);
                            $('#treeBox').find("textarea.ele").attr("pid",str);
                        })
                    },
                    yes: function (index, layero) {
                        layer.close(index)
                    }
                });
            }else if(layEvent == "eeleFn"){
                var td = $(this);
                if(td.find("input.eele").attr("data-type") == "0"){
                    td.find(".eleTree").slideDown();
                    td.find("input.eele").attr("data-type","1");
                }else{
                    td.find(".eleTree").slideUp();
                    td.find("input.eele").attr("data-type","0");
                }
                //点击本身外收起下拉的主体
                document.onmouseup = function(e){
                    var e = e || window.event;
                    var target = e.target || e.srcElement;
                    //1. 点击事件的对象不是目标区域本身
                    //2. 事件对象同时也不是目标区域的子元素
                    if(!td.is(e.target) &&td.has(e.target).length === 0){
                        $(".eleTree").slideUp();
                        $("input.eele").attr("data-type","0");
                    }
                }
                //选中监听事件
                var arr = [];
                var arr1 = [];
                var pidt = td.find("input.eele").attr("pid");
                var valt = td.find("input.eele").val();
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
                    var id = d.data.currentData.columnId +"";
                    var label = d.data.currentData.label +"";
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
                    td.find("input.eele").val(str1);
                    td.find("input.eele").attr("pid",str);
                    var data =  layui.table.cache["Settlement"]
                    var ind = td.find("input.eele").parents("tr").attr("data-index");
                    data[ind].columnName = str1;
                    data[ind].columnId = str;
                })
            }

        });
        //是否提醒
        form.on('switch(remindYn)', function(data){
            var tabledata = table.cache["Settlement"];
            var elem = data.othis.parents('tr');
            var dataindex = elem.attr("data-index");
            if (data.elem.checked==true)
                data.value=1   //标准
            else data.value=0  //非标准
            tabledata[dataindex].remindYn = data.value
        });


        //        下拉框更新数据
        function operUpdate(data,tablename,valname) {
            var tabledata = table.cache[tablename]
                ,elem = data.othis.parents('tr')
                ,dataindex = elem.attr("data-index");
            tabledata[dataindex][valname] = data.value
        }

        //添加按钮点击事件
        $("#addTableButton").click(function () {
            layer.open({
                type: 1,
                skin: 'layui-layer-molv', //加上边框
                area: ['60%', '80%'], //宽高
                title: '新增',
                closeBtn: 1,
                btn: ['确定','取消'],
                content: '<div class="layui-form" style="width: 80%;margin: 0 auto;">'+
                '<div class="layui-form-item" style="margin-top: 15px;">'+
                '<label class="layui-form-label" style="">角色名称</label>'+
                '<div class="layui-input-block">'+
                '<input type="text" style="height: 38px;" id="roleName" name="roleName" lay-verify="required" placeholder="请输入" autocomplete="off" class="layui-input">'+
                '</div>'+
                '</div>'+
                '<div class="layui-form-item">'+
                '<label class="layui-form-label" style="">文档等级</label>'+
                '<div class="layui-input-block">'+
                '<select id="adddocfileClass" style="height: 38px;" name="adddocfileClass" lay-filter="adddocfileClass"></select>'+
                '</div>'+
                '</div>'+
                '<div class="layui-form-item">'+
                '<label class="layui-form-label" style="">OA角色</label>'+
                '<div class="layui-input-block">'+
                '<select id="addprivId" style="height: 38px;" name="addprivId" lay-filter="addprivId"></select>'+
                '</div>'+
                '</div>'+
                '<div class="layui-form-item">'+
                '<label class="layui-form-label" style="">知识栏目</label>'+
                '<div class="layui-input-block">'+
                '<div id="treeBox"><textarea type="text" data-type="0" id="addpele"   value="" pid="" name="ttitle" required="" style="cursor: pointer" lay-verify="required" placeholder="请选择" readonly="" autocomplete="off" class="layui-input ele"></textarea>' +
                '<div class="eleTree addele" lay-filter="data2" style="display:none;position:absolute;border: 1px solid #d2d2d2;overflow-y: auto;background-color: #fff;border-radius: 2px;box-shadow: 0 2px 4px rgba(0,0,0,.12);box-sizing: border-box;overflow:hidden;z-index: 999;top:38px;left:0px;width: 100%;"></div></div>'+
                '</div>'+
                '</div>'+
                '</div>'
                , success: function () {
                    //查询文档等级
                    $.ajax({ //查询文档等级
                        url: '/code/getCode?parentNo=KNOWLEDGE_DOCFILE_CLASS',
                        type: 'get',
                        dataType: 'json',
                        async:false,
                        success: function (res) {
                            if(res.obj!=undefined&&res.obj.length>0){
                                var optionStr = '<option>请选择</option>'
                                for(var i=0;i<res.obj.length;i++){
                                    optionStr += '<option value="' + res.obj[i].codeNo + '">' + res.obj[i].codeName + '</option>'
                                }
                                $("#adddocfileClass").html(optionStr);
                                form.render();
                            }
                        }
                    })
                    $.ajax({
                        url: '/userPriv/getAllPriv?IsPriv=1',
                        dataType: 'json',
                        type: 'get',
                        success: function (res) {
                            if(res.obj!=undefined&&res.obj.length>0){
                                var optionStr = '<option>请选择</option>'
                                for(var i=0;i<res.obj.length;i++){
                                    optionStr += '<option value="'+res.obj[i].userPriv+'">'+res.obj[i].privName+'</option>'
                                }
                                $("#addprivId").html(optionStr);
                                form.render();
                            }
                        }
                    })
                    //知识栏目
                    eleTree.render({
                        elem: '.addele',
                        url:'/knowledge/childTree',
                        expandOnClickNode: false,
                        highlightCurrent: true,
                        showLine:true,
                        showCheckbox: true,
                        checked: true,
                        done: function(res){
                            var arr1 = [];
                            var arr2 = res.obj;
                            for(var i =0;i<res.data.length;i++){
                                arr1.push(res.data[i].id);
                            }
                            for(var i =0;i<arr1.length;i++){
                                for(var j=0;j<arr2.length;j++){
                                    if(arr1[i] == arr2[j]){
                                        $("div[data-id="+arr2[j]+"]").find("input").attr("disabled",true);
                                        $("div[data-id="+arr2[j]+"]").find("input").attr("eletree-status","0");
                                        $("div[data-id="+arr2[j]+"]").find("input").addClass("eleTree-disabled");
                                        $("div[data-id="+arr2[j]+"]").find("input").next("div.eleTree-checkbox").addClass("eleTree-checkbox-disabled");
                                    }
                                }
                            }
                        }
                    });
                    $('#treeBox').click(function(e){
                        e.stopPropagation();
                        if($('#treeBox').find("textarea.ele").attr("data-type") == "0"){
                            $('#treeBox').find(".eleTree").slideDown();
                            $('#treeBox').find("textarea.ele").attr("data-type","1");
                        }else{
                            $('#treeBox').find(".eleTree").slideUp();
                            $('#treeBox').find("textarea.ele").attr("data-type","0");
                        }
                    })
                    //点击本身外收起下拉的主体
                    document.onmouseup = function(e){
                        var e = e || window.event;
                        var target = e.target || e.srcElement;
                        //1. 点击事件的对象不是目标区域本身
                        //2. 事件对象同时也不是目标区域的子元素
                        if(!$('#treeBox').is(e.target) &&$('#treeBox').has(e.target).length === 0){
                            $(".eleTree").slideUp();
                            $("input.ele").attr("data-type","0");
                        }
                    }
                    //选中监听事件
                    var arr = [];
                    var arr1 = [];
                    var pidt = $('#treeBox').find("textarea.ele").attr("pid");
                    var valt = $('#treeBox').find("textarea.ele").text();
                    if(pidt != undefined || pidt != "undefined" || pidt != "" || pidt != null){
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
                    if(valt != undefined || valt != "undefined" || valt != "" || valt != null){
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
                    layui.eleTree.on("nodeChecked(data2)",function(d) {
                        var id = d.data.currentData.columnId + "";
                        var label = d.data.currentData.label + "";
                        if(d.isChecked == true || d.isChecked == "true"){
                            arr.push(id);
                            arr1.push(label);
                        }else{
                            arr.remove(id);
                            arr1.remove(label);
                        }
                        var str = "";
                        var str1 = "";
                        for(var i=0;i<arr.length;i++){
                            str+=arr[i]+","
                            str1+=arr1[i]+","
                        }
                        $('#treeBox').find("textarea.ele").val(str1);
                        $('#treeBox').find("textarea.ele").attr("pid",str);
                    })
                },
                yes: function (index, layero) {
                    layer.close(index);
                    var columnId = $('#treeBox').find("textarea.ele").attr("pid");
                    var columnName = $('#treeBox').find("textarea.ele").val();
                    var data = [];
                    var obj = {};
                    obj.columnId = columnId;
                    obj.columnName = columnName;
                    obj.roleName = $("#roleName").val();
                    obj.privId=$("select[name='addprivId']").next(".layui-unselect").find("dl dd.layui-this").attr("lay-value")
                    obj.privName=$("select[name='addprivId']").next(".layui-unselect").find("dl dd.layui-this").text();
                    obj.docfileClass = $("#adddocfileClass").next(".layui-unselect").find("dl dd.layui-this").attr("lay-value");
                    data.push(obj);
                    var param= {
                        json:JSON.stringify(data)
                    }
                    $.ajax({
                        url:"/clientRole/addRole",
                        data:param,
                        type: 'post',
                        dataType: 'json',
                        success: function (res){
                            layui.layer.msg(res.msg)
                            if(res.flag){
                                tableIns.reload();
                                //关闭第二表格
                                closeTable();
                            }
                        }
                    });
                }
            });
        });

        //多选删除按钮点击事件
        $("#deleteButton").click(function () {
            var data=layui.table.checkStatus('Settlement').data;
            if(data.length>0){
                layui.layer.confirm('确定要删除吗?', {icon: 3, title:'提示'}, function(index){
                    var ids='';
                    for(var i=0;i<data.length;i++){
                        ids+=data[i].roleId+",";
                    }
                    $.ajax({
                        url:"/clientRole/delRole",
                        data:{ids:ids},
                        type: 'post',
                        dataType: 'json',
                        success: function (res){
                            layui.layer.msg(res.msg)
                            if(res.flag){
                                tableIns.reload();
                            }
                        }
                    });
                })
            }else{
                layer.msg("请选中要删除的行");
            }
        })

        //判断是否是undefined
        function undefind_nullStr(value) {
            if(value==undefined){
                return ""
            }
            return value
        }

        //关闭方法
        function closeTable() {
            $("#addTableButton").attr("data-type","0");
            var $addTable=$("#addTableDiv");//得到第二个实例
            $addTable.css("display","none");
            $("#saveTbleButton").css("display","none");
        }
    });
    function alone(ob,parent,count,deptId){
        var str = '';
        count +="|-- ";
        for(var i=0;i<ob.length;i++){
            if(ob[i].deptParent == parent.deptId){
                if(deptId!=null&&deptId===ob[i].deptId){
                    str += '<option selected style="text-align: left" value="' + ob[i].deptId + '">'+count + ob[i].deptName + '</option>'
                }else{
                    str += '<option style="text-align: left" value="' + ob[i].deptId + '">'+count + ob[i].deptName + '</option>'
                }
                str += alone(ob,ob[i],count,deptId);
            }
        }
        return str;
    }
</script>

</body>


</html>