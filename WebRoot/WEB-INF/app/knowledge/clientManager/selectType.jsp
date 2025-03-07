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
    <title>浏览文档</title>
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
            height: 100%;
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
            float: left;
            position: relative;
            border: 1px solid #eee;
            width: 200px;
            overflow-x: auto;
            height: 100%;
            /*height: 600px !important;*/
        }
        .layui-rt{
            float: left;
            width: 84%;
            margin-left: 6px;
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
            width:200px;
            overflow-x: hidden;
            border: 1px solid #eee;
        }
        .rtfix:hover{
            cursor: e-resize;
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
        .header{
            width: 100%;
            height: 57px;
            position: relative;
            background-color: #fff;
        }
    </style>
</head>
<body>
<div class="mbox" style="height: 100%">
    <div class="header" style="position: fixed;top: 0;z-index: 9999">
        <div class="logo" style="height: 57px;border-bottom: 1px solid #eee;">
            <img style="float: left;margin-left: 120px;height: 57px;" src="/img/default/epmlogo.png" ><img style="float: left;margin-left: 10px;margin-top: 4px;" src="/img/default/jijialogo.png" >
            <button style="position: absolute;right: 130px;top:50%;margin-top: -15px;" type="button" class="layui-btn layui-btn-sm comeback">注销</button>
        </div>
    </div>
    <div class="container" style="height: 100%;width: 1080px;margin: 60px auto;position: relative;">
        <div class="layui-tab layui-tab-card" lay-filter="tabTaggle" style="height: 100%;margin: 3px 0 10px 0;">
            <ul class="layui-tab-title" id="ulBox">

            </ul>
            <div class="layui-tab-content" id="divBox" style="height:100%;display: block;position: relative;width:100%;padding: 2px">

            </div>
        </div>
    </div>
   <div id="footer" class="footer" style="background-color:#ffffff;position: fixed;bottom: 0;width: 100%;height: 60px;border-top: 1px solid #eee">
    <div id="footerBox" style="transition:3s;width: 600px;overflow:hidden;height: 60px;margin: 0 auto;line-height: 60px;color: #666666;font-size: 16px;text-align: center">
        <ul id="footerUlBox" style="">

        </ul>
        <div id="footerCoBox" style="width: 600px;height: 60px;margin: 0 auto;line-height: 60px;color: #666666;font-size: 16px;text-align: center"></div>
    </div>
</div>
</div>
<script type="text/html" id="toolbar">
    <div id="clientSerch" style="height: 40px">
        <%--表格上方搜索栏--%>
        <form class="layui-form" action="" style="height: 40px">
            <div class="demoTable" style="height: 40px" >
                <label style="float: left;height: 40px;line-height: 40px;margin: 0 10px;padding: 0 10px">查询条件</label>
                <div class="layui-input-inline" style="float:left;margin-top: 4px">
                    <select name="serchSelect" id="serchSelect" lay-filter="columnName" placeholder="请选择" lay-search="" style="height: 10px">
                        <option value="0">请选择查询条件</option>
                        <option value="docfileName">文档名称</option>
                        <option value="docfileDesc">文档摘要</option>
                        <option value="keyWord">关键词</option>
<%--                        <option value="columnId">知识类别</option>--%>
                    </select>
                </div>
                <div class="layui-input-inline" style="float: left;height: 32px;margin-top: 4px;">
                    <input class="layui-input" id="searchtext" autocomplete="off"  name="searchtext" style="height: 38px;margin-left: 6px;">
                    <input class="layui-input" readonly id="dsearchtext" autocomplete="off"  name="searchtext" style="display:none;height: 38px;margin-left: 6px;">
                    <input type="text" id="pele" pid  required="" style="cursor: pointer;display:none;" placeholder="请选择" readonly="" autocomplete="off" class="layui-input ttitle">
                    <div class="eleTree ele2" lay-filter="data1" style="display:none;position:absolute;border: 1px solid #d2d2d2;overflow-y: auto;background-color: #fff;border-radius: 2px;box-shadow: 0 2px 4px rgba(0,0,0,.12);box-sizing: border-box;overflow:hidden;z-index: 999;top:38px;left:0px;width: 100%;"></div>
                    <div id="selha" style="display: none">
                        <select name="docfileClass" id="docfileClass" ></select></div>
                </div>
                <div class="layui-input-inline" style="float: left;height: 32px;margin-top: 4px;">
                    <a class="layui-btn" data-type="reload" lay-event="searchCust" id="searchCust" style="float:left;height:32px;line-height: 32px;margin-left: 10px">搜索</a>
                    <%--                        <a class="layui-btn" data-type="reload" lay-event="adSearch" id="adSearch" style="float:left;height:32px;line-height: 32px;margin-left: 10px" >高级搜索</a>--%>
                </div>
            </div>
        </form>
    </div>
</script>
<%--<script type="text/html" id="barOperation">--%>
<%--    <a class="layui-btn layui-btn-xs" lay-event="detail" >查看</a>--%>
<%--    <a class="layui-btn layui-btn-xs" lay-event="down" >下载</a>--%>
<%--</script>--%>
<script type="text/html" id="barDown">
    <a class="layui-btn layui-btn-xs" lay-event="detail" >浏览</a>
    <a class="layui-btn layui-btn-xs" lay-event="down" >下载</a>
</script>
<script type="text/html" id="barLook">
    <a class="layui-btn layui-btn-xs" lay-event="detail" >浏览</a>
</script>
<%----------------------------------------------------数据操作--------------------------------------------------------------------------%>

<script type="text/javascript">
    function getUrlParam(name){
        var reg = new RegExp(name +"=(.*?)((?=&|$))"); //构造一个含有目标参数的正则表达式对象
        var r = window.location.href.match(reg); //匹配目标参数
        if (r!=null) return unescape(r[1]); return null; //返回参数值
    }
    var SettlementTable;
    var el;
    var leftcolumnId;
    var urlColumnId = getUrlParam("columnId");
    var urlCodeNo="";// = getUrlParam("codeNo");
    var urrl = "";
    var openTreeArr=[];
    layui.use(['table','layer','form','laydate','element','eleTree','upload'], function() {
        var table = layui.table;
        var layer = layui.layer;
        var form = layui.form;
        var eleTree = layui.eleTree;
        var element = layui.element;
        var $ = layui.jquery;
        var upload = layui.upload;
        var laydate = layui.laydate;
        var url="";
        if(urlColumnId!=undefined&&urlColumnId!=""){
            url = '/knowledge/getKnowledgeTypeByCode?columnId='+urlColumnId;
        }else{
            url = '/knowledge/getKnowledgeTypeByCode';
        }
        $.ajax({ //初始化加载所有页签
            url: url,
            dataType: 'json',
            async: false,
            success: function (res) {
                if(res.obj!=undefined&&res.obj.length>0){
                    openTreeArr = res.obj;
                }
                if(res.object!=undefined&&res.object!=""){
                    urlCodeNo = res.object;
                }
                if(res.data.length>0){
                    var childNodeLi = "";
                    var childNodeDiv = "";
                    codeNo = res.data[0].columnType;
                    for(var i=0;i<res.data.length;i++){
                        if(i==0){
                            childNodeLi+='<li codeNo='+res.data[i].columnType+' class="layui-this">'+res.data[i].name+'</li>';
                            childNodeDiv+='<div class="layui-tab-item layui-show" style="height: 100%">\n' +
                                '                    <div class="layui-card-body" style="height: 100%;padding-left: 6px;padding: 0">\n' +
                                '                        <div class="layui-lf rtfix">\n' +
                                '                            <div class="panel-body">\n' +
                                '                                <div class="eleTree ele1" lay-filter="tdata"></div>\n' +
                                '                            </div>\n' +
                                '                        </div>\n' +
                                '                        <div class="layui-rt" style="position: relative">\n' +
                                '                             <table id="Settlement'+res.data[i].columnType+'" lay-filter="SettlementFilter"></table> \n'+
                                '                        </div>\n' +
                                '                    </div>\n' +
                                '                </div>';
                        }else{
                            childNodeLi+='<li codeNo='+res.data[i].columnType+'>'+res.data[i].name+'</li>';
                            childNodeDiv+='<div class="layui-tab-item" style="height: 100%">\n' +
                                '                    <div class="layui-card-body" style="height:100%;padding-left: 6px;padding: 0">\n' +
                                '                        <div class="layui-lf rtfix">\n' +
                                '                            <div class="panel-body">\n' +
                                '                                <div class="eleTree ele1" lay-filter="tdata"></div>\n' +
                                '                            </div>\n' +
                                '                        </div>\n' +
                                '                        <div class="layui-rt" style="position: relative">\n' +
                                '                             <table id="Settlement'+res.data[i].columnType+'" lay-filter="SettlementFilter"></table>\n'+
                                '                        </div>\n' +
                                '                    </div>\n' +
                                '                </div>';
                        }

                    }

                    $("#ulBox").html(childNodeLi);
                    $("#divBox").html(childNodeDiv);
                    if(res.obj!=undefined&&res.obj.length>0){
                        $("#ulBox").find("li[codeno="+urlCodeNo+"]").click();
                        // 初始化渲染 树形菜单
                        el = eleTree.render({
                            elem: '.ele1',
                            // showCheckbox: true,
                            showLine:true,
                            url:'/knowledge/getColumnById?columnType='+urlCodeNo,
                            lazy: false,
                            done:function (data) { //渲染完成回调
                                var n1 = $("#ulBox").find("li.layui-this").attr("codeNo");
                                var na = $("#ulBox").find("li.layui-this").html();
                                codNam = encodeURI(encodeURI(na));
                                codeNo = n1;
                                if(data.data.length == 0){
                                    $('.ele1').html('<div style="text-align: center">暂无数据</div>');
                                    columnTrId = undefined;
                                    // 初始化渲染 树形菜单
                                    el = eleTree.render({
                                        elem: '.ele1',
                                        // showCheckbox: true,
                                        showLine:true,
                                        url:'/knowledge/getColumnById?columnType='+res.data[0].columnType,
                                        lazy: false,
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
                                                leftcolumnId = data.data[0].id;
                                                var dataid=$('.ele1 div').attr("data-id")
                                                $('.eleTree-node').removeClass('back')
                                                $('.ele1 div[data-id='+dataid+']').addClass('back')
                                                $('.eleTree-node-group').css('background','#fff');
                                            }
                                            getTable(columnTrId,codeNo);
                                        }
                                    });
                                }else{
                                    columnTrId = data.data[0].id;
                                    leftcolumnId = data.data[0].id;
                                    var dataid=$('.ele1 div').attr("data-id")
                                    $('.eleTree-node').removeClass('back')
                                    $('.ele1 div[data-id='+dataid+']').addClass('back')
                                    $('.eleTree-node-group').css('background','#fff');
                                }
                                getTable(columnTrId,codeNo);
                            }
                        });
                        //此处做一个自动定位到某个树下面
                        if(openTreeArr!=undefined&&openTreeArr.length>0){
                            var i=openTreeArr.length-1;
                            var haveInt={};
                            var index = setInterval(function(){
                                if(i<0){
                                    clearInterval(index);
                                }
                                if(haveInt[i]!=undefined){

                                }else{
                                    if(i>=0){
                                        openTree(openTreeArr[i])
                                    }
                                    haveInt[i]=i;
                                }
                                i--;
                            }, 500);
                        }
                    }else{
                        // 初始化渲染 树形菜单
                        el = eleTree.render({
                            elem: '.ele1',
                            // showCheckbox: true,
                            showLine:true,
                            url:'/knowledge/getColumnById?columnType='+res.data[0].columnType,
                            lazy: false,
                            // checked: true,
                            // load: function(data,callback) {
                            //     $.post('/knowledge/getKnowledgeType?parentColumnId='+data.id,function (res) {
                            //         callback(res.data);//点击节点回调
                            //     })
                            // },
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
                                    leftcolumnId = data.data[0].id;
                                    var dataid=$('.ele1 div').attr("data-id")
                                    $('.eleTree-node').removeClass('back')
                                    $('.ele1 div[data-id='+dataid+']').addClass('back')
                                    $('.eleTree-node-group').css('background','#fff');
                                }
                                getTable(columnTrId,codeNo);
                            }
                        });
                    }
                }
            }
        })
        // //顶部页签切换
        element.on('tab(tabTaggle)', function(data){
            var index=tabIndex=data.index;
            var lilen = $("#ulBox").find("li");
            var n1 = $("#ulBox").find("li.layui-this").attr("codeNo");
            treeFn(".ele1",n1);
        });

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

        //初始化加载客户树
        var ell;
        $(document).on('click','.ttitle',function (e) {
            e.stopPropagation();
            if(!ell){
                ell=eleTree.render({
                    elem: '.ele2',
                    url:'/knowledge/getCustomerTree',
                    expandOnClickNode: false,
                    highlightCurrent: true,
                    showLine:true,
                    showCheckbox: true,
                    checked: true,
                    done: function(res){
                    }
                });
            }
            $(".ele2").slideDown();
        })

        // //搜索点击事件
        // $(document).on('click',"#searchCust",function(){
        //     var serchSelect = $("#serchSelect").next(".layui-form-select").find("dl dd.layui-this").attr("lay-value"); //下拉列表的值
        //     if(serchSelect == "serchTime"){ //使用时间查询
        //         var searchtext = $("#dsearchtext").val();
        //         table.reload("Settlement",{
        //             url: "/knowledge/getCurrentPriv?"+serchSelect+"="+searchtext+"&columnId="+leftcolumnId
        //             ,page: {
        //                 curr: 1 //重新从第 1 页开始
        //             }
        //         })
        //     }else if(serchSelect == "docfileClass"){
        //         var searchtext = $("#docfileClass").next(".layui-form-select").find("dl dd.layui-this").attr("lay-value");
        //         table.reload("Settlement",{
        //             url: "/knowledge/getCurrentPriv?"+serchSelect+"="+searchtext+"&columnId="+leftcolumnId
        //             ,page: {
        //                 curr: 1 //重新从第 1 页开始
        //             }
        //         })
        //     }else if(serchSelect == "columnId"){
        //         var searchtext =$("#pele").attr("pid");
        //         var syscode = $("#pele").attr("syscode");
        //         table.reload("Settlement",{
        //             url: "/knowledge/getCurrentPriv?"+serchSelect+"="+searchtext+"&isSysCode="+syscode+"&columnId="+leftcolumnId
        //             ,page: {
        //                 curr: 1 //重新从第 1 页开始
        //             }
        //         })
        //     }else{
        //         var searchtext = $("#searchtext").val(); //输入框的值
        //         if((searchtext!=""&&serchSelect=='0') || (searchtext!=""&&serchSelect==0)){ //只输入，没有选择
        //             layer.msg("请选择查询条件");
        //         }else{
        //             table.reload("Settlement",{
        //                 url: "/knowledge/getCurrentPriv?"+serchSelect+"="+searchtext+"&columnId="+leftcolumnId
        //                 ,page: {
        //                     curr: 1 //重新从第 1 页开始
        //                 }
        //             })
        //         }
        //     }
        // })

        // 节点点击事件
        eleTree.on("nodeClick(tdata)",function(d) {
            leftcolumnId = d.data.currentData.id;
            var columnId = d.data.currentData.id;
            var n1 = $("#ulBox").find("li.layui-this").attr("codeNo");
            getTable(columnId,n1)
            $('.eleTree-node').removeClass('back')
            $(d.node[0]).addClass('back')
            $('.eleTree-node-group').css('background','#fff')
        });
        function getTable(id,codeNotr) {
            // 树右侧表格实例
            SettlementTable = layui.table.render({
                elem: '#Settlement'+codeNotr
                // , data: []
                , url: '/knowledge/getFileByColumnId?columnId='+id//数据接口
                , page: { //支持传入 laypage 组件的所有参数（某些参数除外，如：jump/elem） - 详见文档
                    layout: ['prev', 'page', 'next', 'skip', 'count', 'limit',]//自定义分页布局
                    , limits: [10, 15, 20, 25, 30, 35, 40, 45, 50, 55, 60, 65, 70, 75, 80, 85, 90, 95, 100]
                    , first: false //不显示首页
                    , last: false //不显示尾页
                } //开启分页
                , toolbar: '#toolbar'
                , cols: [[ //表头
                    // {type: 'checkbox'}
                    {field: 'docfileName', title: '文档名称'}
                    // , {field: 'docfileClass', title: '文档等级'}
                    , {field: 'keyWord', title: '关键词'}
                    , {field: 'docfileDesc', title: '文档摘要'}
                    , {field: 'columnName', title: '知识类别'}
                    ,{width:200, title: '操作',align:'center', templet:function(d){ //toolbar: '#barLook',
                            if(d.code===0){
                                return "<a class='layui-btn layui-btn-xs' lay-event='detail' >浏览</a>"
                            }else if(d.code===1){
                                return " <a class='layui-btn layui-btn-xs' lay-event='detail' >浏览</a><a class='layui-btn layui-btn-xs' lay-event='down' >下载</a>"
                            }else{
                                return ""
                            }
                        }}
                ]]
                , limit: 10
                , done: function (res) {
                }
            });
        }

        //表头操作事件
        table.on('toolbar(SettlementFilter)', function (obj) {
            var checkStatus = table.checkStatus(obj.config.id);
            var n1 = $("#ulBox").find("li.layui-this").attr("codeNo");
            switch (obj.event) {
                case 'searchCust':
                    var serchSelect = $("#serchSelect").next(".layui-form-select").find("dl dd.layui-this").attr("lay-value"); //下拉列表的值
                    if(serchSelect == "serchTime"){ //使用时间查询
                        var searchtext = $("#dsearchtext").val();
                        table.reload("Settlement"+n1,{
                            url: "/knowledge/getCurrentPriv?"+serchSelect+"="+searchtext+"&columnId="+leftcolumnId
                            ,page: {
                                curr: 1 //重新从第 1 页开始
                            }
                        })
                    }else if(serchSelect == "docfileClass"){
                        var searchtext = $("#docfileClass").next(".layui-form-select").find("dl dd.layui-this").attr("lay-value");
                        table.reload("Settlement"+n1,{
                            url: "/knowledge/getCurrentPriv?"+serchSelect+"="+searchtext+"&columnId="+leftcolumnId
                            ,page: {
                                curr: 1 //重新从第 1 页开始
                            }
                        })
                    }else if(serchSelect == "columnId"){
                        var searchtext =$("#pele").attr("pid");
                        var syscode = $("#pele").attr("syscode");
                        table.reload("Settlement"+n1,{
                            url: "/knowledge/getCurrentPriv?"+serchSelect+"="+searchtext+"&isSysCode="+syscode+"&columnId="+leftcolumnId
                            ,page: {
                                curr: 1 //重新从第 1 页开始
                            }
                        })
                    }else{
                        var searchtext = $("#searchtext").val(); //输入框的值
                        if((searchtext!=""&&serchSelect=='0') || (searchtext!=""&&serchSelect==0)){ //只输入，没有选择
                            layer.msg("请选择查询条件");
                        }else{
                            table.reload("Settlement"+n1,{
                                url: "/knowledge/getCurrentPriv?"+serchSelect+"="+searchtext+"&columnId="+leftcolumnId
                                ,page: {
                                    curr: 1 //重新从第 1 页开始
                                },done:function(data){
                                   $("#searchtext").val(searchtext); //输入框的值
                                   $("#serchSelect").find("option[value="+serchSelect+"]").attr("selected",true); //输入框的值
                                    layui.form.render("select");
                                }
                            })
                        }
                    }
                    break;
            }
        });

        //表格行操作事件
        table.on('tool(SettlementFilter)', function(obj){ //注：tool 是工具条事件名，test 是 table 原始容器的属性 lay-filter="对应的值"
            var data = obj.data; //获得当前行数据
            var layEvent = obj.event; //获得 lay-event 对应的值（也可以是表头的 event 参数对应的值）
            var tr = obj.tr; //获得当前行 tr 的 DOM 对象（如果有的话）
            if(layEvent === 'detail'){ //查看
                if(data.attachmentId==undefined||data.attachmentId==''){
                    layer.msg("浏览地址错误")
                }else{
                    selectFile1(data.docfileId);
                }
            }else if(layEvent === 'down'){ //下载
                if(data.attachmentId==undefined||data.attachmentId==''){
                    layer.msg("下载地址错误")
                }else{
                    window.location.href = "/knowledge/down?docId="+data.docfileId;
                }
            }
        });
        //注销功能
        $('.comeback').click(function () {
            window.location.href='/'
        })

        //树的方法
        function treeFn(cla,codeNotr) {
            var n1 = $("#ulBox").find("li.layui-this").attr("codeNo");
            codeNo = n1;
            var na = $("#ulBox").find("li.layui-this").html();
            codNam = encodeURI(encodeURI(na));
            // 初始化渲染 树形菜单
            el = eleTree.render({
                elem: cla,
                showLine:true,
                // showCheckbox: true,
                url:'/knowledge/getColumnById?columnType='+n1,
                lazy: false,
                // load: function(data,callback) {
                //     $.post('/knowledge/getKnowledgeType?parentColumnId='+data.id,function (res) {
                //         callback(res.data);//点击节点回调
                //     })
                // },
                done:function (data) { //渲染完成回调
                    if(data.data.length == 0){
                        $(cla).html('<div style="text-align: center">暂无数据</div>');
                        columnTrId = undefined;
                    }else{
                        aldata = data.data
                        columnTrId = data.data[0].id;
                        leftcolumnId = data.data[0].id;
                        var dataid=$(cla+' div').attr("data-id")
                        $('.eleTree-node').removeClass('back')
                        $(cla+' div[data-id='+dataid+']').addClass('back')
                        $('.eleTree-node-group').css('background','#fff');
                    }
                    getTable(columnTrId,codeNotr);
                    // urrl = '/columManage/getColumManagePage?columnTrId='+columnTrId+'&codeNo='+codeNo+'&codeName='+codNam
                    // $("#divBox").find("div.layui-show").find(".iframe").attr("src",urrl);
                }
            });
        }
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

    //假休眠
    function sleep(n) {
        var start = new Date().getTime();
        while (true) {
            if (new Date().getTime() - start > n) {
                break;
            }
        }
    }
    function openTree(dataId){
        $("div[data-id="+dataId+"]").find("div[class=eleTree-node-content]").click();
        $("div[data-id="+dataId+"]").addClass("back");
    }

    //底部文字滚动
    $.ajax({
        url:"/sys/getStatusText",
        type: 'post',
        async:false,
        dataType: 'json',
        success: function (res){
            if(res.flag){
                if(res.object.length>0){
                    var str = '';
                    for(var i=0;i<res.object.length;i++){
                        str += '<li style="height: 60px;">'+res.object[i]+'</li>'
                    }
                    $("#footerUlBox").append(str);
                }
                $.ajax({
                    url:"/syspara/selectSysPara",
                    type: 'post',
                    async:false,
                    dataType: 'json',
                    success: function (res){
                        if(res.flag){
                            var speed=Number(res.object[0].paraValue)*1000;
                            var footerBox=document.getElementById("footerBox");
                            var footerUlBox=document.getElementById("footerUlBox");
                            var footerCoBox=document.getElementById("footerCoBox");
                            footerCoBox.innerHTML=footerUlBox.innerHTML
                            function Marquee(){
                                if(footerBox.scrollTop>=footerUlBox.offsetHeight){
                                    footerBox.scrollTop=0;
                                }
                                else{
                                    var h =footerBox.scrollTop+60;
                                    $("#footerBox").animate({scrollTop: h}, 2000);
                                }
                            }
                            var MyMar=setInterval(Marquee,speed)
                            footerBox.onmouseover=function(){clearInterval(MyMar)}
                            footerBox.onmouseout=function(){MyMar=setInterval(Marquee,speed)}
                        }
                    }
                });
            }
        }
    });
</script>
</body>
</html>

