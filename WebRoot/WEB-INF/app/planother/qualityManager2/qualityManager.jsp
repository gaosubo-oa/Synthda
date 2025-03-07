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
    <title>质量知识管理</title>
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
        .layui-lf{
            float: left;
            position: relative;
            border: 1px solid #eee;
            /*width: 200px;*/
            width: 14%;
            overflow-x: auto;
            height: 100%;
            /*height: 600px !important;*/
        }
        .layui-rt{
            float: left;
            width: 84%;
            margin-left: 6px;
            height: 100%;
            /*margin-top: -10px;*/
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
    </style>
</head>
<body>
<div class="mbox">
    <div class="layui-card" style="height: 100%;">
        <div class="layui-tab layui-tab-card" lay-filter="tabTaggle" style="position:relative;height: 100%;overflow: hidden">
            <div class="scroll" style="overflow-x:auto;overflow-y:hidden;background-color: #f2f2f2;">
            <ul class="layui-tab-title" id="ulBox">
                <li num="1" class="layui-this">隐患排查标准</li>
            </ul>
            </div>
            <div class="layui-tab-content" id="divBox" style="height:90%;display: block;position: relative;width:100%;padding: 2px">
                <%--工程类别--%>
                <div class="layui-tab-item layui-show" style="height: 100%">
                    <div class="layui-card" style="height: 100%">
                        <div class="layui-card-body" style="height: 100%">
                            <div class="layui-lf rtfix">
                                <div class="panel-body">
                                   <div class="eleTree ele1" lay-filter="tdata"></div>
                                </div>
                            </div>
                            <div class="layui-md" style="width: 4px;cursor: e-resize;position: relative;"></div>
                            <div class="layui-rt" style="position: relative">
                                <div style="margin: 10px 0;height: 30px;text-align: right;">
                                    <button id="add" type="button" style="margin: 0 5px;" class="layui-btn layui-btn-sm" lay-submit lay-filter="formDemo">新建</button>
                                    <%--                <button id="edit" type="button" style="margin: 0 5px;" class="layui-btn layui-btn-sm" lay-submit lay-filter="formDemo">修改</button>--%>
                                    <button id="del" type="button" style="margin: 0 5px;" class="layui-btn layui-btn-danger layui-btn-sm" lay-submit lay-filter="formDemo">删除</button>
                                </div>
                                <form class="layui-form" lay-filter="formTest" action=""style="width: 100%;
margin: 0 auto;">
                                    <input type="text" name="equipId" style="display: none" id="layui-form">
                                    <div class="layui-form-item">
                                        <label class="layui-form-label" style=""><span style="color: red;">*</span>排序号</label>
                                        <div class="layui-input-block">
                                            <input type="text" id="securityKnowledgeSort" name="securityKnowledgeSort" lay-verify="required" placeholder="请输入排序号" autocomplete="off" class="layui-input">
                                        </div>
                                    </div>
                                    <div class="layui-form-item">
                                        <label class="layui-form-label"><span style="color: red;">*</span>类型名称</label>
                                        <div class="layui-input-block">
                                            <input type="text" name="securityKnowledgeName" id="securityKnowledgeName" lay-verify="required" placeholder="请输入" autocomplete="off" class="layui-input">
                                        </div>
                                    </div>
                                    <div class="layui-form-item">
                                        <label class="layui-form-label"><span style="color: red;">*</span>父级栏目</label>
                                        <div class="layui-input-block" id="parent" style="position: relative">
                                            <input type="text" style="cursor: pointer" id="pele" pid name="ttitle" required="" placeholder="请选择父级(不选择默认为一级)" readonly="" autocomplete="off" class="layui-input">
                                            <div class="eleTree ele2" lay-filter="data1" style="display:none;position:absolute;border: 1px solid #d2d2d2;overflow-y: auto;background-color: #fff;border-radius: 2px;box-shadow: 0 2px 4px rgba(0,0,0,.12);box-sizing: border-box;z-index: 999;top:38px;left:0px;width: 99%;"></div>
                                        </div>
                                    </div>
                                    <div class="buttonbottom" style="text-align: center">
                                        <button id="submit" style="" optype="2" type="button" class="layui-btn layui-btn-sm" lay-submit lay-filter="formDemo">保存编辑</button>
                                    </div>
                                </form>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<%----------------------------------------------------数据操作--------------------------------------------------------------------------%>
<script type="text/javascript">
    $('.rtfix').css('max-height',autodivheight()-55)
    var el;
    var ell;
    var parData;
    var arr = [];
    var directjudge;
    var idkey;
    var AllEquipTypeId;
    var columnTrId;
    var codeNo;
    var codNam;
    function getUrlParam(name){
        var reg = new RegExp(name +"=(.*?)((?=&|$))"); //构造一个含有目标参数的正则表达式对象
        var r = window.location.href.match(reg); //匹配目标参数
        if (r!=null) return unescape(r[1]); return null; //返回参数值
    }
    var type = getUrlParam('pageType');
    var urrl = "";
    layui.use(['table','layer','form','element','eleTree','laydate','upload'], function(){
        var table = layui.table;
        var layer = layui.layer;
        var form = layui.form;
        var eleTree = layui.eleTree;
        var element = layui.element;
        var $ = layui.jquery;
        var laydate = layui.laydate;
        var upload = layui.upload;
        // 初始化渲染 树形菜单
            el = eleTree.render({
                elem: '.ele1',
                showLine:true,
                url:'/workflow/qualityManager/getQualityByType?parent=0',
                lazy: true,
                // checked: true,
                load: function(data,callback) {
                    $.post('/workflow/qualityManager/getQualityByType?parent='+data.id,function (res) {
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
                        columnTrId = undefined;
                    }else{
                        columnTrId = data.data[0].id;
                        var dataid=$('.ele1 div').attr("data-id")
                        $('.eleTree-node').removeClass('back')
                        $('.ele1 div[data-id='+dataid+']').addClass('back')
                        $('.eleTree-node-group').css('background','#fff');
                        childFunc(columnTrId);  //调用应用中方法
                    }
                    // if(type == 1 || type == "1"){
                    //     urrl = '/columManage/getColumManagePage?columnTrId='+columnTrId+'&codeNo='+codeNo+'&codeName'+'&codeName='+codNam
                    // }else if(type == 2 || type == "2"){
                    //     urrl = '/fileManage/getFileManagePage?columnTrId='+columnTrId
                    // }
                    //$("#divBox").find("div.layui-show").find(".iframe").attr("src",urrl);
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
            var clas = "";
            var idn = ""
            var dataid=$(clas+' div').attr("data-id")
            $('.eleTree-node').removeClass('back')
            $(d.node[0]).addClass('back')
            $('.eleTree-node-group').css('background','#fff')
            //调用子页面的方法
           childFunc(columnTrId);  //调用应用中方法
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
        //
        $("[name='ttitle']").on("click",function (e) {
            e.stopPropagation();
            if(!ell){
                ell=eleTree.render({
                    elem: '.ele2',
                    url:'/workflow/qualityManager/getQualityByType?parent=0',
                    expandOnClickNode: false,
                    highlightCurrent: true,
                    showLine:true,
                    lazy: true,
                    load: function(data,callback) {
                        $.post('/workflow/qualityManager/getQualityByType?parent='+data.id,function (res) {
                            callback(res.data);//点击节点回调
                        })
                    },
                    done: function(res){

                    }
                });
            }
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
        //树的方法
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
        }
    });
    function childFunc(secirityId){
        //数据回显
        $.ajax({
            type: "post",
            url: '/workflow/qualityManager/selectQualityManager?secirityId='+secirityId,
            dataType: "json",
            success:function (res) {
                $("#securityKnowledgeName").val(res.obj.securityKnowledgeName);
                $("#securityKnowledgeSort").val(res.obj.securityKnowledgeSort);
                $("#pele").val(res.obj.parentName);
            }
        })
    }
    //新增操作
    $("#add").click(function () {
        $(".buttonbottom").css("display","block");
        $("#submit").attr("optype","1");
        $("#submit").html("保存新建");
        $("#securityKnowledgeSort").val("");
        $("#securityKnowledgeName").val("");
        //$("#columnCode").val("");
        $("#pele").val("");
        $("#pele").attr("pid","");
        $("#pele").attr("pcode","");
    })

    //删除操作
    $("#del").click(function () {
        if(columnTrId == undefined){
            layer.msg("参数错误，不可删除");
            return false;
        }else{
            layer.confirm("确定要删除吗", {
                btn: ['确认','取消'],
                icon: 7,
                title: "系统提示"
            }, function () {
                $.ajax({
                    type: "post",
                    url: '/workflow/qualityManager/delQualityByType',
                    dataType: "json",
                    data:{
                        secirityId:columnTrId
                    },
                    success:function (res) {
                        if(res.code === "0" || res.code === 0){
                            layer.msg(res.msg,{icon:1,time:1500},function(d){
                                if(el){
                                    el.reload();
                                }
                                if(ell){
                                    ell.reload();
                                }
                            });
                        }else{
                            layer.msg(res.msg);
                        }
                    }
                })
            }, function () {
                layer.closeAll();
            });
        }
    })
    //保存操作
    $("#submit").click(function () {
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
        var optype = $("#submit").attr("optype");
        if($("#securityKnowledgeName").val()==''||$("#securityKnowledgeSort").val()==''){ //||$("#columnCode").val()==''
            layer.msg("必填项不能为空")
        }else{
            if(optype == "1"){
                $.ajax({
                    type: "post",
                    url: '/workflow/qualityManager/insertSecirityManager',
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
                            },1000)
                        }else{
                            layer.msg(res.msg);
                        }
                    }
                })
            }else if(optype == "2"){
                plbSecurityKnowledge.securityKnowledgeId = columnTrId;
                $.ajax({
                    type: "post",
                    url: '/workflow/qualityManager/updateSecirityManager',
                    dataType: "json",
                    data:knowledgeColumn,
                    success:function (res) {
                        if(res.code == "0" || res.code == 0){
                            layer.msg(res.msg);
                            // $('#ulBox li.layui-this', parent.document).click();
                            setTimeout(function(){
                                if(el){
                                    el.reload()
                                }
                                if(ell){
                                    ell.reload();
                                }
                            },1000)
                        }else{
                            layer.msg(res.msg);
                        }
                    }
                })
            }
        }
    })
</script>
</body>
</html>

