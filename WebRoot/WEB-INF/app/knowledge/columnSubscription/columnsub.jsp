

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
    <title>客户订阅一览</title>
    <link rel="stylesheet" href="/lib/layui/layui/css/layui.css?20210319.1">
    <link rel="stylesheet" href="/lib/layui/layui/css/common.css">
    <link rel="stylesheet" href="/lib/layui/layui/css/eleTree.css">
    <script src="/lib/layui/layui/layui.js"></script>
    <script type="text/javascript" src="../../js/xoajq/xoajq1.js"></script>
    <script src="/lib/layui/layui/js/limstree.js?v=2019080601" type="text/javascript" charset="utf-8"></script>
    <script src="/lib/layui/layui/js/common.js?v=20190726" type="text/javascript" charset="utf-8"></script>
    <script type="text/javascript" src="/lib/layui/layui/global.js"></script>
    <script src="../../js/base/base.js" type="text/javascript" charset="utf-8"></script>
    <script src="/lib/layui/layui/js/baseCode/base.js?v=2019080918:09" type="text/javascript" charset="utf-8"></script>
    <style>
        #formBox .layui-form-item {
            width:49.5%;
            margin-top: 10px;
            margin-bottom: 10px;
            margin-bottom: 5px;
        }
        #formBox .layui-form-item .layui-inline{
            width:100%;
        }
        #formBox .layui-form-item  .layui-form-label{
            width:29%;
        }
        #formBox .layui-form-item  .layui-input-inline {
            width:58%;
        }
        .layui-layer-page .layui-layer-content{
            overflow-x: hidden !important;
        }
        .ele1{
            overflow: hidden;
        }
    </style>
</head>
<body>
<div class="main" style="padding: 20px 20px">
    <div id="clientSerch" style="height: 40px">
        <%--表格上方搜索栏--%>
        <form class="layui-form" action="" style="height: 40px">
            <div class="demoTable" style="height: 40px" >
                <label style="float: left;height: 40px;line-height: 40px;margin: 0 10px;padding: 0 10px">查询字段</label>
                <div class="layui-input-inline" style="float:left;"><%--margin-top: 4px--%>
                    <select name="serchSelect" id="serchSelect" lay-filter="columnName" placeholder="请选择" lay-search="" style="height: 10px">
                        <option value="0">请选择查询条件</option>
                        <option value="companyName">企业名称</option>
                        <option value="companyCode">机构代码</option>
                        <option value="companyNatrue">企业性质</option>
                        <option value="columnId">知识类别</option>
                        <option value="privType">权限</option>
                        <option value="userId">oa用户名</option>
                    </select>
                </div>
                <div class="layui-input-inline" style="float: left;"><%--height: 32px;margin-top: 4px;--%>
                    <input class="layui-input" id="searchtext" autocomplete="off"  name="searchtext" style="height: 38px;margin-left: 6px;">
                    <input type="text" id="pele" pid name="ttitle" required="" style="cursor: pointer;display:none;" placeholder="请选择" readonly="" autocomplete="off" class="layui-input">
                    <div class="eleTree ele1" lay-filter="data1" style="display:none;position:absolute;border: 1px solid #d2d2d2;overflow-y: auto;background-color: #fff;border-radius: 2px;box-shadow: 0 2px 4px rgba(0,0,0,.12);box-sizing: border-box;overflow:hidden;z-index: 999;top:38px;left:0px;width: 100%;"></div>
                    <div id="companyNatrueBox" style="display: none">
                        <select name="companyNatrue" id="companyNatrue" ></select>
                    </div>
                    <div id="privTypeBox" style="display: none">
                        <select name="privType" id="privType" >
                            <option value="">请选择</option>
                            <option value="0">浏览</option>
                            <option value="1">下载</option>
                        </select>
                    </div>
                </div>
                <div class="layui-input-inline" style="float: left;margin-top: 4px;"><%--height: 32px;--%>
                    <a class="layui-btn" data-type="reload" lay-event="searchCust" id="searchCust" style="float:left;height:32px;line-height: 32px;margin-left: 10px">搜索</a>
                    <a class="layui-btn" data-type="reload" lay-event="adSearch" id="adSearch" style="float:left;height:32px;line-height: 32px;margin-left: 10px" >高级搜索</a>
                </div>
            </div>
        </form>
    </div>
<%--    <div id="clientSerch">--%>
<%--        &lt;%&ndash;表格上方搜索栏&ndash;%&gt;--%>
<%--        <form class="layui-form" action="">--%>
<%--            <div class="layui-form-item" style="margin-bottom: 0">--%>
<%--                <div class="layui-inline">--%>
<%--                    <label class="layui-form-label" style="text-align:center;padding: 9px 3px;">企业名称</label>--%>
<%--                    <div class="layui-input-inline">--%>
<%--                        <input type="text" id="companyName" name="companyName" autocomplete="off" class="layui-input">--%>
<%--                    </div>--%>
<%--                </div>--%>
<%--                <div class="layui-inline">--%>
<%--                    <label class="layui-form-label" style="text-align:center;padding: 9px 3px;">联系人</label>--%>
<%--                    <div class="layui-input-inline">--%>
<%--                        <input type="text" id="contactUser" name="contactUser" autocomplete="off" class="layui-input">--%>
<%--                    </div>--%>
<%--                </div>--%>
<%--                <div class="layui-inline">--%>
<%--                    <label class="layui-form-label" style="text-align:center;padding: 9px 3px;">机构代码</label>--%>
<%--                    <div class="layui-input-inline">--%>
<%--                        <input type="text" id="companyCode" name="companyCode" autocomplete="off" class="layui-input">--%>
<%--                    </div>--%>
<%--                </div>--%>
<%--                <a  id="serch" href="javascript:void(0)" style="margin-bottom: 5px;" class="layui-btn">搜索</a>--%>
<%--            </div>--%>
<%--        </form>--%>
<%--    </div>--%>
    <div id="clientContent">
        <%--表格内容--%>
        <table id="clientCustomer" lay-filter="customer"></table>
    </div>
</div>
<script type="text/html" id="barDemo">
    <a class="layui-btn layui-btn-xs" lay-event="info">详情</a>
    <a class="layui-btn layui-btn-xs" lay-event="allDoc">查看使用记录</a>
</script>
<script type="text/html" id="toolBar">

</script>

<script type="text/javascript">
    var tabInit;
    var parentData;
    layui.use(['table','layer','laydate','form','eleTree','element'], function(){
        var table = layui.table
            ,layer = layui.layer
            ,$ = layui.jquery
            ,eleTree = layui.eleTree
            ,element=layui.element;
        var form = layui.form;
        var laydate = layui.laydate;
        tabInit = table.render({
            elem: '#clientCustomer'
            ,url:'/subscribe/getCustomerAndFile'
            ,toolbar: '#toolBar' //开启头部工具栏占位
            ,defaultToolbar: ['filter', 'exports', 'print', { //自定义头部工具栏右侧图标。如无需自定义，去除该参数即可
                title: '提示'
                ,layEvent: 'LAYTABLE_TIPS'
                ,icon: 'layui-icon-tips'
            }]
            ,cols: [[
                //{type: 'checkbox'}
                //,{field:'customerId', title:'序号'}
                {field:'companyName', title:'企业名称'}
                ,{field:'companyCode', title:'机构代码'}
                ,{field:'privType', title:'权限类别'}
                ,{field:'bTime', title:'开始时间'}
                ,{field:'eTime', title:'结束时间'}
                // ,{field:'companyNatrue', title:'企业性质'}
                // ,{field:'contactPhone', title:'联系电话'}
                // ,{field:'contactUser', title:'联系人'}
                //, {field: 'docfileNo', title: '文档编号'}
                //, {field: 'docfileName', title: '文档名称'}
                //, {field: 'keyWord', title: '关键词'}
                //, {field: 'docfileClass', title: '文档等级'}
                // , {field: 'createUserId', title: '上传人'}
                // , {field: 'createTime', title: '上传时间'}
                // , {field: 'downloadPassword', title: '下载密码'}
                //, {field: 'docfileDesc', title: '文档摘要'}
                , {field: 'columnName', title: '知识类别'}
                //,{field:'memo', title:'备注'}
                ,{fixed: 'right', title:'操作', toolbar: '#barDemo', width:170}
            ]]
            ,page: true
            ,id: 'clientCustomer'
            ,parseData: function(res){ //res 即为原始返回的数据
                return {
                    "code": 0, //解析接口状态
                    "msg": res.msg, //解析提示文本
                    "count": res.totleNum, //解析数据长度
                    "data": res.data //解析数据列表
                };
            }
        });
//*初始化加载搜索条件*//
        //企业性质
        var $select1 = $("select[name='companyNatrue']"); //企业性质
        var optionStr = '<option value="">请选择</option>';
        $.ajax({ //查询文档等级
            url: '/code/getCode?parentNo=KNOWLEDGE_COMPANY_NATRUE',
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
        //初始化知识类别
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
        form.on('select(columnName)',function (data) {
            if(data.value=="columnId") { //栏目类别
                $("#searchtext").hide();
                $("#pele").show();
                $("#privTypeBox").hide();
                $("#companyNatrueBox").hide();
            }else if(data.value=="companyNatrue"){ //企业性质
                $("#searchtext").hide();
                $("#pele").hide();
                $("#privTypeBox").hide(); //隐藏权限
                $("#companyNatrueBox").show();
            }else if(data.value=="privType"){ //权限
                $("#searchtext").hide();
                $("#pele").hide();
                $("#companyNatrueBox").hide(); //隐藏企业性质
                $("#privTypeBox").show();
            } else{
                $("#searchtext").show();
                $("#pele").hide();
                $("#companyNatrueBox").hide(); //隐藏企业性质
                $("#privTypeBox").hide(); //隐藏权限
            }
        })
        //监听行工具事件
        table.on('tool(customer)', function(obj){
            var data = obj.data
            parentData = obj.data;
            if(obj.event === 'allDoc'){
                layer.open({
                    type: 2
                    , title: ['查看浏览/下载记录', 'font-size:18px;']
                    , maxmin: true
                    , area: ['80%', '90%']
                    , btn: ['确定']
                    , content: '/client/showSubDocfile?userId='+data.userId
                    ,success: function (res) {

                    }
                    , yes: function (index, layero) {
                        layer.close(index)
                    }
                })
            }else if(obj.event === 'info'){
                layer.open({
                    type: 2
                    ,title: ['详情', 'font-size:18px;']
                    ,maxmin:true
                    ,area: ['90%', '90%']
                    ,content: '/client/addClient?customerId='+obj.data.customerId+'&type=look'
                    ,btn:['关闭']
                    ,yes: function(index, layero){
                        layer.close(index)
                    }
                });
            }
        });

        //搜索
        $('#searchCust').click(function () {
            var serchSelect = $("#serchSelect").next(".layui-form-select").find("dl dd.layui-this").attr("lay-value"); //下拉列表的值
            var searchtext=$("#searchtext").val();
            if(serchSelect == "companyNatrue"){
                searchtext = $("#companyNatrue").next(".layui-form-select").find("dl dd.layui-this").attr("lay-value");
            }
            if(serchSelect == "privType"){
                searchtext = $("#privType").next(".layui-form-select").find("dl dd.layui-this").attr("lay-value");
                if(searchtext==undefined||searchtext==''){
                    layer.msg("请选择查询权限");
                    return false;
                }
            }
            var serchObjUrl = "/subscribe/getCustomerAndFile?"+serchSelect+"="+searchtext;
            //栏目类别用的搜索
            if(serchSelect == "columnId"){
                var searchtext =$("#pele").attr("pid");
                var syscode = $("#pele").attr("syscode");
                serchObjUrl = "/subscribe/getCustomerAndFile?"+serchSelect+"="+searchtext+"&isSysCode="+syscode;
            }
            if((searchtext==undefined&&serchSelect=='0')||(searchtext==''&&serchSelect=='0')){ //两个都为空查询全部
                table.reload("clientCustomer",{
                    url: "/subscribe/getCustomerAndFile"
                });
            }else if(searchtext!=""&&serchSelect==''){ //只输入，没有选择
                layer.msg("请选择查询条件");
            }else{
                table.reload("clientCustomer",{
                    url: serchObjUrl
                })
            }
        })
        var str ='<form class="layui-form" id="formBox1" action="" lay-filter="formTest1">\n' +
            '<div class="layui-form-item" style="width: 47%;margin:10px 0;display: inline-block">\n' +
            '                <div class="layui-inline" style="width: 98%;">\n' +
            '                    <label class="layui-form-label" style="width: 30%;">企业名称</label>\n' +
            '                    <div class="layui-input-inline" style="width: 55%;">\n' +
            '                        <input type="text" id="companyName" name="companyName" autocomplete="off" class="layui-input">\n' +
            '                    </div>\n' +
            '                </div>\n' +
            '            </div>\n' +
            '            <div class="layui-form-item" style="width: 47%;margin:10px 0;display: inline-block">\n' +
            '                <div class="layui-inline" style="width: 98%;">\n' +
            '                    <label class="layui-form-label" style="width: 30%;">机构代码</label>\n' +
            '                    <div class="layui-input-inline" style="width: 55%;">\n' +
            '                        <input type="text" id="companyNo" name="companyNo" autocomplete="off" class="layui-input">\n' +
            '                    </div>\n' +
            '                </div>\n' +
            '            </div>\n' +
            '            <div class="layui-form-item" style="width: 47%;margin:10px 0;display: inline-block">\n' +
            '                <div class="layui-inline" style="width: 98%;">\n' +
            '                    <label class="layui-form-label" style="width: 30%;">企业性质</label>\n' +
            '                    <div class="layui-input-inline" style="width: 55%;">\n' +
            '                        <select name="companyNatrue" id="companyNatrue"></select>' +
            '                    </div>\n' +
            '                </div>\n' +
            '            </div>\n' +
            '            <div class="layui-form-item" style="width: 47%;margin:10px 0;display: inline-block">\n' +
            '                <div class="layui-inline" style="width: 98%;">\n' +
            '                    <label class="layui-form-label" style="width: 30%;">权限</label>\n' +
            '                    <div class="layui-input-inline" style="width: 55%;">\n' +
            '                        <select name="privType" id="privType">' +
            '                               <option value="">请选择</option><option value="0">浏览</option><option value="1">下载</option>' +
            '                         </select>' +
            '                    </div>\n' +
            '                </div>\n' +
            '            </div>\n' +
            '           <div class="layui-form-item" style="width: 47%;margin:10px 0;display: inline-block">\n' +
            '                <div class="layui-inline" style="width: 98%;">\n' +
            '                    <label class="layui-form-label" style="width: 30%;">知识类别</label>\n' +
            '                    <div class="layui-input-inline" style="width:55%;">\n' +
            '                        <input type="text" id="pele" pid name="ttitle1" required="" style="cursor: pointer;" placeholder="请选择" readonly="" autocomplete="off" class="layui-input">\n' +
            '                        <div class="eleTree ele2" lay-filter="data2" style="display:none;position:absolute;border: 1px solid #d2d2d2;overflow-y: auto;background-color: #fff;border-radius: 2px;box-shadow: 0 2px 4px rgba(0,0,0,.12);box-sizing: border-box;overflow:hidden;z-index: 999;top:38px;left:0px;width: 100%;"></div>\n' +
            '                    </div>\n' +
            '                </div>\n' +
            '            </div>\n' +
            '            <div class="layui-form-item" style="width: 47%;margin:10px 0;display: inline-block">\n' +
            '                <div class="layui-inline" style="width: 98%;">\n' +
            '                    <label class="layui-form-label" style="width: 30%;">oa用户名</label>\n' +
            '                    <div class="layui-input-inline" style="width: 55%;">\n' +
            '                        <input type="text" id="userId" name="userId" autocomplete="off" class="layui-input">\n' +
            '                    </div>\n' +
            '                </div>\n' +
            '            </div>\n' +
            '            <div class="layui-form-item" style="width: 98%;margin:10px 0;display: inline-block">\n' +
            '                <div class="layui-inline" style="width: 100%">\n' +
            '                    <label class="layui-form-label" style="width: 18%;">浏览开始时间</label>\n' +
            '                    <div class="layui-input-inline" style="width: 70%">\n' +
            '                        <input type="text"  readonly id="borrowBDate" style="width: 48%;display: inline-block;" name="borrowBDate" autocomplete="off" class="layui-input">到<input type="text" style="display: inline-block;width: 48%;" readonly id="borrowEDate" name="borrowEDate" autocomplete="off" class="layui-input">\n' +
            '                    </div>\n' +
            '                </div>\n' +
            '            </div>\n' +
            '            <div class="layui-form-item" style="width: 98%;margin:10px 0;display: inline-block">\n' +
            '                <div class="layui-inline" style="width: 100%">\n' +
            '                    <label class="layui-form-label" style="width: 18%;">下载开始时间</label>\n' +
            '                    <div class="layui-input-inline" style="width: 70%">\n' +
            '                        <input type="text"  readonly id="downloadBDate" style="width: 48%;display: inline-block;" name="downloadBDate" autocomplete="off" class="layui-input">到<input type="text" style="width: 48%;display: inline-block;" readonly id="downloadEDate" name="downloadEDate" autocomplete="off" class="layui-input">\n' +
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
                    $("input[name='companyName']").val("");
                    $("input[name='companyNo']").val("");
                    $('#companyNatrue').find('option[value=""]').prop('selected','selected');
                    $('#privType').find('option[value=""]').prop('selected','selected');
                    $("#pele").attr("pid","")
                    $("#pele").val("");
                    $("input[name='userId']").val("")
                    $("input[name='borrowBDate']").val("")
                    $("input[name='borrowEDate']").val("")
                    $("input[name='downloadBDate']").val("")
                    $("input[name='downloadEDate']").val("")
                    laydate.render({
                        elem: '#borrowBDate' //指定元素
                        , trigger: 'click'
                        ,type: 'datetime'
                    });
                    laydate.render({
                        elem: '#borrowEDate' //指定元素
                        , trigger: 'click'
                        ,type: 'datetime'
                    });
                    laydate.render({
                        elem: '#downloadBDate' //指定元素
                        , trigger: 'click'
                        ,type: 'datetime'
                    });
                    laydate.render({
                        elem: '#downloadEDate' //指定元素
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

                    var $select1 = $("select[name='companyNatrue']");
                    var optionStr = '<option value="">请选择</option>';
                    $.ajax({ //查询文档等级
                        url: '/code/getCode?parentNo=KNOWLEDGE_COMPANY_NATRUE',
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
                    if($("input[name='companyName']").val() == ""
                        &&$("input[name='companyNo']").val() == ""
                        &&($("#companyNatrue").next(".layui-form-select").find("dl dd.layui-this").attr("lay-value") == ""||$("#companyNatrue").next(".layui-form-select").find("dl dd.layui-this").attr("lay-value") == undefined)
                        &&($("#privType").next(".layui-form-select").find("dl dd.layui-this").attr("lay-value") == ""||$("#privType").next(".layui-form-select").find("dl dd.layui-this").attr("lay-value") == undefined)
                        &&$("#pele").attr("pid") == ""
                        &&$("#pele").val() == ""
                        &&$("input[name='userId']").val()==""
                        &&$("input[name='borrowBDate']").val() == ""
                        &&$("input[name='borrowEDate']").val() == ""
                        &&$("input[name='downloadBDate']").val() == ""
                        &&$("input[name='downloadEDate']").val() == ""
                    ){
                        layer.msg("请输入查询信息")
                        return;
                    }
                    layer.close(index)
                    table.reload("clientCustomer",{
                        url: '/subscribe/getCustomerAndFile',
                        where:{
                            companyName:$("input[name='companyName']").val(),
                            companyNo:$("input[name='companyNo']").val(),
                            companyNatrue:$("#companyNatrue").next(".layui-form-select").find("dl dd.layui-this").attr("lay-value"),
                            columnId:$("#pele").attr("pid"),
                            isSysCode:$("#pele").attr("syscode"),
                            userId:$("input[name='userId']").val(),
                            borrowBDate:$("input[name='borrowBDate']").val(),
                            borrowEDate:$("input[name='borrowEDate']").val(),
                            downloadBDate:$("input[name='downloadBDate']").val(),
                            downloadEDate:$("input[name='downloadEDate']").val(),
                        }
                    })
                }
            });
        });
    });
</script>
</body>
</html>