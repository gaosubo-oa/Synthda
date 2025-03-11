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
    <title>栏目管理</title>
    <link rel="stylesheet" href="/lib/layui/layui/css/layui.css?20210319.1">
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
<%--                <li num="1" class="layui-this">工程类别</li>--%>
<%--                <li num="2">WBS</li>--%>
<%--                <li num="3">模块类型</li>--%>
<%--                <li num="4">文档级别</li>--%>
<%--                <li num="5">文档查询</li>--%>
<%--                <li num="5">文档查询2</li>--%>
            </ul>
            </div>
            <div class="layui-tab-content" id="divBox" style="height:90%;display: block;position: relative;width:100%;padding: 2px">
                <%--工程类别--%>
                <%--<div class="layui-tab-item layui-show">
                    <div class="layui-card-body" style="padding-left: 6px;">
                        <div class="layui-lf rtfix">
                            &lt;%&ndash;<div class="treeTitle" id="equip" dataType="0" >设备类别&ndash;%&gt;
                            &lt;%&ndash;</div>&ndash;%&gt;
                            <div class="panel-body">
                                <div class="eleTree ele1" lay-filter="tdata"></div>
                            </div>
                        </div>
                        <div class="layui-rt" style="position: relative">
                            <iframe id="ifram1" class="iframe" name="notices" src="/fileManage/getFileManagePage" frameborder="0"></iframe>
                        </div>
                    </div>
                </div>
                &lt;%&ndash;WBS&ndash;%&gt;
                <div class="layui-tab-item">
                    <div class="layui-card-body" style="padding-left: 6px;">
                        <div class="layui-lf rtfix">
                            &lt;%&ndash;<div class="treeTitle" id="equip" dataType="0" >设备类别&ndash;%&gt;
                            &lt;%&ndash;</div>&ndash;%&gt;
                            <div class="panel-body">
                                <div class="eleTree ele2" lay-filter="tdata"></div>
                            </div>
                        </div>
                        <div class="layui-rt" style="position: relative">
                            <iframe id="ifram2" class="iframe" name="notices" src="" frameborder="0"></iframe>
                        </div>
                    </div>
                </div>
                &lt;%&ndash;模块类型&ndash;%&gt;
                <div class="layui-tab-item">
                    <div class="layui-card-body" style="padding-left: 6px;">
                        <div class="layui-lf rtfix">
                            &lt;%&ndash;<div class="treeTitle" id="equip" dataType="0" >设备类别&ndash;%&gt;
                            &lt;%&ndash;</div>&ndash;%&gt;
                            <div class="panel-body">
                                <div class="eleTree ele3" lay-filter="tdata"></div>
                            </div>
                        </div>
                        <div class="layui-rt" style="position: relative">
                            <iframe id="ifram3" class="iframe" name="notices" src="" frameborder="0"></iframe>
                        </div>
                    </div>
                </div>
                &lt;%&ndash;文档级别&ndash;%&gt;
                <div class="layui-tab-item">
                    <div class="layui-card-body" style="padding-left: 6px;">
                        <div class="layui-lf rtfix">
                            &lt;%&ndash;<div class="treeTitle" id="equip" dataType="0" >设备类别&ndash;%&gt;
                            &lt;%&ndash;</div>&ndash;%&gt;
                            <div class="panel-body">
                                <div class="eleTree ele4" lay-filter="tdata"></div>
                            </div>
                        </div>
                        <div class="layui-rt" style="position: relative">
                            <iframe id="ifram4" class="iframe" name="notices" src="" frameborder="0"></iframe>
                        </div>
                    </div>
                </div>
                &lt;%&ndash;文档查询&ndash;%&gt;
                <div class="layui-tab-item">
                    <div class="layui-card-body" style="padding-left: 6px;">
                        <div class="layui-lf rtfix">
                            &lt;%&ndash;<div class="treeTitle" id="equip" dataType="0" >设备类别&ndash;%&gt;
                            &lt;%&ndash;</div>&ndash;%&gt;
                            <div class="panel-body">
                                <div class="eleTree ele5" lay-filter="tdata"></div>
                            </div>
                        </div>
                        <div class="layui-rt" style="position: relative">
                            <iframe id="ifram5" class="iframe" name="notices" src="" frameborder="0"></iframe>
                        </div>
                    </div>
                </div>--%>
            </div>
        </div>
    </div>
</div>
<%----------------------------------------------------数据操作--------------------------------------------------------------------------%>
<script type="text/javascript">
    $('.rtfix').css('max-height',autodivheight()-55)
    var el;
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
        // //原部门所属组织下拉框

        $.ajax({ //初始化加载所有页签
            url:'/knowledge/getColumnTag?type=tag',
            dataType:'json',
            async : false,
            success:function(res){
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
                                '                            <iframe class="iframe" name="notices"   frameborder="0" style="width: 100%;height: 100%;overflow-y: scroll"></iframe>\n' +
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
                                '                            <iframe class="iframe" name="notices"  frameborder="0" style="width: 100%;height: 100%;overflow-y: scroll"></iframe>\n' +
                                '                        </div>\n' +
                                '                    </div>\n' +
                                '                </div>';
                        }

                    }
                    if(type == 2 || type == "2"){
                        childNodeLi+='<li>文档查询</li>';
                        childNodeDiv+='<div class="layui-tab-item" style="height: 100%">' +
                            '<div class="layui-card-body" style="padding-left: 6px;height:100%;min-height: 100%;padding: 0">' +
                            '                        <iframe class="" id="fileIf" style="height:auto!important;height:100%;min-height:100%;width: 100%!important" name="notices" src="" frameborder="0"></iframe>' +
                            '</div>' +
                            '</div>';
                    }
                    $("#ulBox").html(childNodeLi);
                    $("#divBox").html(childNodeDiv);
                    // 初始化渲染 树形菜单
                    el = eleTree.render({
                        elem: '.ele1',
                        // showCheckbox: true,
                        showLine:true,
                        url:'/knowledge/getKnowledgeType?colunmType='+res.data[0].columnType+'&parentColumnId=0',
                        lazy: true,
                        // checked: true,
                        load: function(data,callback) {
                            $.post('/knowledge/getKnowledgeType?parentColumnId='+data.id,function (res) {
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
                            }
                            if(type == 1 || type == "1"){
                                urrl = '/columManage/getColumManagePage?columnTrId='+columnTrId+'&codeNo='+codeNo+'&codeName'+'&codeName='+codNam
                            }else if(type == 2 || type == "2"){
                                urrl = '/fileManage/getFileManagePage?columnTrId='+columnTrId
                            }
                            $("#divBox").find("div.layui-show").find(".iframe").attr("src",urrl);
                        }
                    });
                }else{
                    layer.msg("请先添加栏目")
                }
            }
        })
        // //底部页签切换
        element.on('tab(tabTaggle)', function(data){
            var index=tabIndex=data.index;
            var lilen = $("#ulBox").find("li");
            if(type == "2" || type == 2){
                if((lilen.length -1) == index){
                    $("#fileIf").attr("src","/fileManage/getFilSerchPage")
                }else{
                    treeFn(".ele1");
                }
            }else{
                treeFn(".ele1");
            }
        });
        // 节点点击事件
        eleTree.on("nodeClick(tdata)",function(d) {
            parData = d.data.currentData;
            var n1 = $("#ulBox").find("li.layui-this").attr("codeNo");
            var na = $("#ulBox").find("li.layui-this").html();
            codNam = encodeURI(encodeURI(na));
            codeNo = n1;
            var columnId = d.data.currentData.id;
            columnTrId = columnId;
            if(type == 1 || type == "1"){
                urrl = '/columManage/getColumManagePage?columnTrId='+columnTrId+'&codeNo='+codeNo+'&codeName='+codNam
            }else if(type == 2 || type == "2"){
                urrl = '/fileManage/getFileManagePage?columnTrId='+columnTrId
            }
            $("#divBox").find("div.layui-show").find(".iframe").attr("src",urrl);
            var clas = "";
            var idn = ""
            var dataid=$(clas+' div').attr("data-id")
            $('.eleTree-node').removeClass('back')
            $(d.node[0]).addClass('back')
            $('.eleTree-node-group').css('background','#fff')
            //调用子页面的方法
            var iframeFun = $("#divBox").find("div.layui-show").find("iframe")[0].contentWindow.childFunc;
            if(iframeFun && typeof(iframeFun) == "function"){  //验证方法存在
                $("#divBox").find("div.layui-show").find("iframe")[0].contentWindow.childFunc();  //调用应用中方法
            }
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
                    if(type == 1 || type == "1"){
                        urrl = '/columManage/getColumManagePage?columnTrId='+columnTrId+'&codeNo='+codeNo+'&codeName='+codNam
                    }else if(type == 2 || type == "2"){
                        urrl = '/fileManage/getFileManagePage?columnTrId='+columnTrId
                    }
                    $("#divBox").find("div.layui-show").find(".iframe").attr("src",urrl);
                }
            });
        }
    });
</script>
</body>
</html>

