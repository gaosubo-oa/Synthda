<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@taglib prefix="mvc" uri="http://www.springframework.org/tags/form" %>
<%@taglib prefix="fmt" uri="http://www.springframework.org/tags" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
%>
<!DOCTYPE html>
<html>
    <head>
        <title>制度中心</title>
        <meta charset="UTF-8">
        <meta name="renderer" content="webkit">
        <meta http-equiv="X-UA-Compatible" content="IE=10,chrome=1">
        
        <link rel="stylesheet" type="text/css" href="/lib/layui/layui/css/layui.css?20210319.1"/>
        <link rel="stylesheet" type="text/css" href="/lib/layui/layui/css/eleTree.css">
        
        <script type="text/javascript" src="/js/xoajq/xoajq3.js"></script>
        <script type="text/javascript" src="/js/base/base.js"></script>
        <script type="text/javascript" src="/lib/layui/layui/layui.all.js"></script>
        <script type="text/javascript" src="/lib/layui/layui/global.js"></script>
        
        <style>
            html {
                width: 100%;
                height: 100%;
                background: #fff;
                user-select: none;
            }
                    
            .item {
                font-size: 22px;
                margin-left: 10px;
                color: #494d59;
                margin-top: 2px
            }
            
            #leftHeight {
                height: 350px;
            }
            
            #questionTree li {
                border-bottom: 1px solid #ddd;
                line-height: 40px;
                padding-left: 10px;
                cursor: pointer;
                border-radius: 3px;
            }
            
            .reader {
                width: 5px;
                height: 15px;
                display: inline-block;
                background: #77cff7;
                vertical-align: middle;
                margin-right: 10px;
            }
            
            .readCont ul li {
                height: 35px;
                line-height: 35px;
            }
            
            .licheng {
                hight: calc(100% - 450px);
            }
            
            .more {
                cursor: pointer;
            }
            
            /*ie下滚动条问题*/
            .layui-table-box .layui-table-body {
                overflow: inherit;
            }
            
            .select {
                background: #c7e1ff;
            }
            
            .receive>li a:hover {
                cursor: pointer;
                color: blue;
            }
            
            .list>li a:hover {
                cursor: pointer;
                color: blue;
            }
            
            #institutionalForm .layui-treeSelect .ztree li span.button.switch {
                position: relative;
                top: 1px;
            }
            
            .contact .layui-treeSelect .ztree li span.button.switch {
                position: relative;
                top: 1px;
            }
    
            .layui-table-header {
                display: none;
            }
        </style>
    
    </head>
    <body>
        <div class="headImg" style="margin-top: 10px">
            <span class="item">
                <img style="margin-left:1.5%" src="/img/commonTheme/theme6/icon_summary.png">
                <span class="headTitle" style="margin-left: 10px">制度中心</span>
            </span>
        </div>
        <hr class="layui-bg-blue">
        <div class="layui-fluid" id="LAY-app-message">
            <input type="hidden" id="sortId" />
            <input type="hidden" id="instId" />
            <div class="layui-row">
                <div class="layui-lf" style="width:250px;float:left;">
                    <div class="layui-card" >
                        <div class="layui-card-body" id="leftHeight" style="padding: 0;margin-right: 15px;border-right: 1px solid #ccc;">
                            <div class="layui-tab layui-tab-brief" lay-filter="leftTabs">
                                <ul class="layui-tab-title">
                                    <li class="layui-this">制度导航</li>
                                    <li>我的制度</li>
                                </ul>
                                <div class="layui-tab-content">
                                    <div class="layui-tab-item layui-show">
                                        <div class="layui-form" style="margin-bottom: 10px;">
                                            <select name="sortType" lay-verify="required" lay-filter="sortType">
                                            </select>
                                        </div>
                                        <div class="ele_tree" id="institutionTypeTree" lay-filter="institutionTypeTree"></div>
                                    </div>
                                    <div class="layui-tab-item">
                                        <!-- 我的收藏 -->
                                        <h3 style=" margin: 10px auto 10px auto;">
                                            <span class="reader"></span>我的收藏 <span style="float: right;margin-right: 10px;color: #fe8b06;font-weight: bold;cursor: pointer;" class="totle"></span>
                                        </h3>
                                        <div class="readCont">
                                            <ul class="receive" style="margin-right: 10px"></ul>
                                        </div>
                                        
                                        <!-- 最近阅读 -->
                                        <h3 style=" margin: 30px auto 10px auto;"><span class="reader"></span>最近阅读制度</h3>
                                        <div class="readCont">
                                            <ul class="list" style="margin-right: 10px"></ul>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="layui-rt" style="width:calc(100% - 250px);float:left ">
                    <%--最新制度--%>
                    <div style="height: 450px;overflow: auto;">
                        <div class="formlist">
                            <form class="layui-form" id="institutionalForm" lay-filter="formTest">
                                <span style="font-size: 18px;font-weight: bold">制度文档</span>
                                <div class="layui-inline">
                                    <label class="layui-form-label">制度名称</label>
                                    <div class="layui-input-inline" style="width:200px">
                                        <input type="text"  lay-verify="email" autocomplete="off" placeholder="请输入制度名称或关键字" class="layui-input keyWord">
                                    </div>
                                </div>
                                <button type="button" class="layui-btn search" style="margin-left: 50px;">查询</button>
                                <button type="reset" class="layui-btn" id="resetInstitutionalForm" style="margin-left: 10px;">重置</button>
                            </form>
                        </div>
                        <div class="layui-tab layui-tab-brief" lay-filter="institutionDocTab">
                            <ul class="layui-tab-title target_tabs">
                                <li class="layui-this tab_name" opttype="3">最新制度</li>
                            </ul>
                            <div class="layui-tab-content" style="height: 100px;">
                                <div class="layui-tab-item layui-show">
                                    <table class="layui-hide" id="system" lay-filter="test" style="height: 200px;overflow: auto"></table>
                                </div>
                            </div>
                        </div>
                    </div>
                    <%--相关流程--%>
                    <div class="licheng">
                        <%--相关查询--%>
                        <div class="">
                            <form class="layui-form contact"  lay-filter="formTest">
                                <span style="font-size: 18px;font-weight: bold">相关流程</span>
                                <div class="layui-inline" style="margin-left: 19px;width: 25%;">
                                    <label class="layui-form-label" style="margin-left: -6px;width: 85px">电子流程分类</label>
                                    <div class="layui-input-block dialiu" style="width: 60%;">
                                        <input type="text" id="electree"  lay-filter="electree" class="layui-input">
                                    </div>
                                </div>
                                <div class="layui-inline">
                                    <label class="layui-form-label">流程名称</label>
                                    <div class="layui-input-inline" style="width:200px">
                                        <input type="text" lay-verify="email" autocomplete="off" placeholder="请输入流程名称" class="layui-input flowName">
                                    </div>
                                </div>
                                <button type="button" class="layui-btn processSearch" style="margin-left: 50px;">查询</button>
                                <button type="reset" class="layui-btn processReset" style="margin-left: 10px;">重置</button>
                            </form>
                        </div>
                        <div class="layui-tab layui-tab-brief" lay-filter="flowTabs">
                            <ul class="layui-tab-title">
                                <li class="layui-this electricity">电子流程</li>
                                <li class="flow" style="pointer-events: none;">流程指引</li>
                            </ul>
                            <div class="layui-tab-content" style="min-height: 100px;">
                                <div class="layui-tab-item layui-show electronic">
                                    <%--电子流程--%>
                                    <div class="process"></div>
<%--                                    <p class="dimore" style="line-height: 35px;margin-top: 15px; text-align: center;background: #f2f2f2">查看更多<i class="layui-icon layui-icon-next"></i></p>--%>
                                </div>
                                <div class="layui-tab-item finger"></div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        
        <%--操作行--%>
        <script type="text/html" id="barDemo">
            <a class="layui-btn layui-btn-sm layui-btn-danger" lay-event="electronics">电子流程</a>
        </script>
        
        <script type="text/javascript">
            var height = $(window).height();
            var deptType = null;
            $('#leftHeight').height(height - 80);

            // 收藏
            $.ajax({
                url: '/InstitutionContent/findContentWhere',
                dataType: 'json',
                type: 'get',
                data: {
                    approveStatus: 1,
                    instStatus: 1,
                    order: 3,
                    page: 1,
                    limit: 5,
                    useFlag: true,
                    userIds: 1
                },
                success: function (res) {
                    var data = res.obj;
                    $('.totle').html(res.totleNum);
                    var str = ''
                    for (var i = 0; i < data.length; i++) {
                        str+='<li><a title="'+data[i].instName+'" href="/institution/selectInstitution?instId='+data[i].instId+'" target="_blank" style="display:'+
                        'inline-block;overflow: hidden; white-space: nowrap;text-overflow: ellipsis;width:100%">'+function(){
                            if (data[i].instName.indexOf('有限公司') > 0) {
                                return data[i].instName.split('有限公司')[1];
                            } else {
                                return data[i].instName;
                            }
                        }()+'</a></li>';
                    }
                    $('.receive').html(str);
                }
            });
            
            //左侧的最近阅读
            $.ajax({
                url:'/InstitutionContent/findRecentConten',
                dataType:'json',
                type:'get',
                success: function (res) {
                    var data = res.obj;
                    var str = '';
                    for (var i = 0; i < data.length; i++) {
                        str += '<li><a title="'+data[i].instName+'" href="/institution/selectInstitution?instId='+data[i].instId+'" target="_blank" style="display:'+
                             'inline-block;overflow: hidden; white-space: nowrap;text-overflow: ellipsis;width:100%;">'+function(){
                            if (data[i].instName.indexOf('有限公司') > 0) {
                                return data[i].instName.split('有限公司')[1];
                            } else {
                                return data[i].instName;
                            }
                        }()+'</a></li>';
                    }
                    $('.list').html(str);
                }
            });
            
            //右侧
            layui.use(['form','element','treeSelect','eleTree','table'], function() {
                var $ = layui.jquery,
                    form = layui.form,
                    table = layui.table,
                    treeSelect = layui.treeSelect,
                    eleTree = layui.eleTree;
                latest('','','','');
                // 获取分级类别接口
                $.get('/code/getCode?parentNo=INSTITUTION_SORT_LEVEL', function (res) {
                    var str = '';
                    if (res.flag && res.obj.length > 0) {
                        res.obj.forEach(function (item) {
                            str += '<option value="' + item.codeNo + '">' + item.codeName + '</option>';
                        });
                    }
                    $('[name="sortType"]').append(str);
                    form.render('select');
                });
                
                $.get('/InstitutionSort/getDeptType', function(res) {
                    if (res.flag && res.object) {
                        $('[name="sortType"]').val(res.object.deptType);
                        form.render('select');
                        deptType = res.object.deptType;
                        var val = $('select[name=sortType]').next('.layui-form-select').find('.layui-this').attr('lay-value')
                        initInstitutionTypeTree(val);
                    }    
                });
                
                // 监听左侧下拉框部门选择
                form.on('select(sortType)', function (data) {
                    initInstitutionTypeTree(data.value);
                });
                
                // 制度类别树
                function initInstitutionTypeTree(sortType) {
                    var institutionTypeTree = eleTree.render({
                        url: '/InstitutionSort/getByType?sortType=' + sortType,
                        elem: '#institutionTypeTree',
                        showCheckbox: false,
                        showLine: true,
                        accordion: true,
                        highlightCurrent: true,
                        request: { // 修改数据为组件需要的数据
                            name: "sortName", // 显示的内容
                            key: "sortId", // 节点id
                            parentId: 'sortParent', // 节点父id
                            isLeaf: "isLeaf",// 是否有子节点
                            children: 'children'
                        },
                        response: { // 修改响应数据为组件需要的数据
                            statusName: "flag",
                            statusCode: true,
                            dataName: "obj"
                        }
                    });
                }
                
                // 制度类别树节点点击事件
                eleTree.on("nodeClick(institutionTypeTree)", function (d) {
                    var data = d.data.currentData;
                    // 清空制度id
                    $('#instId').val('');
                    // 清空制度查询
                    $('#resetInstitutionalForm').trigger('click');
                    // 清空电子流程查询
                    $('.processReset').trigger('click');
                    $('.tab_name').text(data.sortName);
                    // 清除电子流程
                    $('.process').empty();
                    
                    $('.flow').removeClass('layui-this');
                    $('.electricity').addClass('layui-this');
                    
                    $('.finger').removeClass('layui-show');
                    $('.electronic').addClass('layui-show');
                    // 加载分类下制度
                    latest('',data.sortId,'',deptType);
                    $('#sortId').val(data.sortId);
                });
                
                form.render();
                
                var limit = 5;
                
                /**
                * 最新制度方法
                * @param keyWords
                * @param sortId
                * @param instId
                */
                function latest(keyWords,sortId,instId,sortType){
                    table.render({
                        elem: '#system',
                        url:'/InstitutionContent/findContentBySortIds',
                        where:{
                        approveStatus:1,
                        instStatus:1,
                        instType:1,
                        order:3,
                        keyWords:keyWords,
                        instName:keyWords,
                        sortId:sortId,
                        instId:instId,
                        sortType: sortType,
                        useFlag: true,
                        _: new Date().getTime()
                        },
                        parseData: function(res){ //res 即为原始返回的数据
                            return {
                        "code":0, //解析接口状态
                        "data": res.obj , //解析数据列表，
                        "count": res.totleNum, //解析数据长度
                        };
                        },
                        page: {
                            layout: ['prev', 'page', 'next', 'skip','count','limit'],
                            limits:[5,10,15,20],
                            limit:5,
                            first: false,
                            last: false
                        },
                        cols: [[
                            {field:'instName', title:'制度名称',align:'left',templet:function (d) {
                                var name = d.instName;
                                if (name.indexOf('有限公司') > 0) {
                                    name = name.split('有限公司')[1];
                                }
                                return '<a href="/institution/selectInstitution?instId='+d.instId+'" target="_blank">'+name+'</a>'
                            }},
                            {field:'sortName', title:'制度分类',templet:function(d) {
                                return !!d.institutionSort ? d.institutionSort.sortName || '' : '';
                            }},
                            {field:'createTime', title:'创建时间',width:200,templet:function(d) {
                                return d.createTime.substr(" ",10)
                            }},
                            {fixed: 'right', title:'操作',width:100, toolbar: '#barDemo',align:'center'}
                        ]],
                        done: function (res) {
                            $('th').hide();//表头隐藏的样式
                            if (res.data.length > 0) {
                                // 默认选中第一条
                                var instId = res.data[0].instId;
                                $('#instId').val(instId);
                                $('#system').parent().find('.layui-table-body').find('tr').eq(0).addClass('layui-table-click');
                                flow(instId, '', '');
                            } else {
                                $('#instId').val('');
                                var app = '<div class="noData" style="text-align: center;border: none;width: 15%;height: 22%;margin-left: 35%;margin-top: 10%">' +
                                '<img src="/img/main_img/shouyekong.png" alt="">' +
                                '<h6 style="text-align: center;color: #666;">'+'暂无数据'+'</h6>' +
                                '</div>';
                                $('.process').html(app);
                            }
                        },
                        success: function (res) {
                            if (res.obj == undefined || res.obj == '') {
                                $('.layui-show .layui-table-view').hide();
                            }
                        }
                    });
                }
                
                //监听最新制度的行事件
                table.on('tool(test)', function(obj){
                    var data = obj.data;
                    var instId = data.instId
                    $('#instId').val(instId);
                    if(obj.event === 'electronics'){
                        flow(instId, '', '');
                    }
                });
                
                // 关联制度
                $(document).on('click','.relatedSystem',function(){
                    var flowId = $(this).attr('flowId');
                    // if($('.target_tabs').children('.layui-this').text()=='最新制度'){
                    //     var elem='#system'
                    // }else{
                    //     var elem='#mostRead'
                    // }
                    table.render({
                        elem: '#system',
                        url:'/InstitutionContent/getContenFlowRun',
                        where:{
                            flowId:flowId,
                        },
                        parseData: function(res){ //res 即为原始返回的数据
                            return {
                                "code":0, //解析接口状态
                                "data": res.obj , //解析数据列表，
                                "count": res.totleNum, //解析数据长度
                            }
                        },
                        page: { //支持传入 laypage 组件的所有参数（某些参数除外，如：jump/elem） - 详见文档
                            layout: ['prev', 'page', 'next', 'skip','count','limit',]//自定义分页布局
                            ,limits:[5,10,15,20,25,30,35,40,45,50,55,60]
                            ,limit:5
                            ,first: false //不显示首页
                            ,last: false //不显示尾页
                        }
                        ,cols: [[
                            {field:'instName', title:'制度名称',align:'left',templet:function (d) {
                                var name = d.instName;
                                if (name.indexOf('有限公司') > 0) {
                                    name = name.split('有限公司')[1];
                                }
                                return '<a href="/institution/selectInstitution?instId='+d.instId+'" target="_blank">'+name+'</a>'
                            }}
                            ,{field:'readerNum', title:'制度分类'}
                            ,{field:'createTime', title:'创建时间',width:200}
                            ,{fixed: 'right', title:'操作',width:100, toolbar: '#barDemo',align:'center'}
                        ]],
                        done:function(res){
                            $('th').hide();//表头隐藏的样式
                        }
                    });
                });
                
                // 流程指引
                $(document).on('click','.guidelines',function(){
                    var flowId = $(this).attr('flowId')
                    $.ajax({
                        url:'/InstitutionContent/findContenFlowRun',
                        dataType:'json',
                        type:'get',
                        data:{
                            flowId :flowId,
                            status:2
                        },success:function(res) {
                            var strs = ''
                            var datas = res.object.attachment;
                            if (datas && datas.length > 0) {
                                for(var i=0;i<datas.length;i++){
                                    var times= 20+datas[i].ym.substr('',2)+'-'+datas[i].ym.substr(2);
                                    strs +='<div style="min-height: 40px;line-height: 40px;border-bottom: 1px solid #ccc;">'+
                                    ' <p style="float: left;"><a href="/download?' + encodeURI(datas[i].attUrl) +'">'+empty(datas[i].attachName)+'</a></p>\n'+
                                    ' <p style="float: right">\n'+
                                    ' <span>'+empty(times)+'</span>\n'+
                                    ' </p>\n'+
                                    ' </div>';
                                }
                            }
                            
                            $('.finger').html(strs);
                        }
                    });
                    $('.flow').addClass('layui-this')
                    $('.electricity').removeClass('layui-this')
                    
                    $('.finger').addClass('layui-show')
                    $('.electronic').removeClass('layui-show')
                });
                
                /**
                * 最多阅读的方法
                * @param limit
                * @param keyWords
                * @param sortId
                */
                function order(limit,keyWords,sortId) {
                    table.render({
                        elem: '#mostRead',
                        url:'/InstitutionContent/findContentWhere',
                        where:{
                            approveStatus:1,
                            instStatus: 1,
                            instType: 1,
                            keyWords: keyWords,
                            instName: keyWords,
                            limit: 6,
                            page: 1,
                            order: 2,
                            sortId:sortId,
                            useFlag: true
                        },
                        parseData: function(res){ //res 即为原始返回的数据
                            return {
                                "code":0, //解析接口状态
                                "data": res.obj , //解析数据列表，
                                "count": res.totleNum, //解析数据长度
                            };
                        },
                        cols: [[
                            {field:'instName', title:'制度名称',align:'left',templet:function (d) {
                                var name = d.instName;
                                if (name.indexOf('有限公司') > 0) {
                                    name = name.split('有限公司')[1];
                                }
                                return '<a href="/institution/selectInstitution?instId='+d.instId+'" target="_blank">'+name+'</a>'
                            }},
                            {field:'sortName', title:'制度分类',templet:function(d) {
                                return !!d.institutionSort ? d.institutionSort.sortName || '' : '';
                            }},
                            {field:'readerNum', title:'阅读数',templet:function(d) {
                                return '阅读:'+(d.readerNum || 0) +'次';
                            }},
                            {fixed: 'right', title:'操作',width:100, toolbar: '#barDemo',align:'center'}
                        ]],
                        done: function (res) {
                            $('th').hide();//表头隐藏的样式
                        },
                        success: function (res) {
                            if (res.obj == undefined || res.obj == '') {
                                $('.layui-show .layui-table-view').hide();
                            }
                        }
                    });
                }
                
                //新制度和最多阅读点击更多的方法
                $(document).on('click', '.more', function(){
                    var status = $('.target_tabs').children('.layui-this').attr('opttype');
                    if(status == 2){
                        limit = limit + 5;
                        order(limit,'','');
                    }
                });
                
                /**
                * 电子流程
                * @param limit
                * @param flowName
                * @param flowSort
                */
                function flow(instId,flowName,flowSort) {
                    $.ajax({
                        url:'/InstitutionContent/searchContentFlowRun',
                        dataType:'json',
                        type:'get',
                        data: {
                            flowName: flowName,
                            sortId: flowSort,
                            instId: instId
                        },
                        success:function(res){
                            var data = res.object;
                            var app='';
                            if(!!data && data.length>0){
                                for(var i=0;i<data.length;i++){
                                    app+='<div style="min-height: 40px;line-height: 40px;border-bottom: 1px solid #ccc;">'+
                                    '<p style="float: left;"><a target="_blank" href="/institution/ProcessDesignDetail?flowId='+data[i].flowId+'&rilwId=0'+'&type=banli"'+
                                    'style="display:block;width:500px">'+empty(data[i].flowName)+'</a></p>'+
                                    '<p style="float: right">\n'+
                                    '<span>'+empty(data[i].sortName)+'</span>\n'+
                                    '<button type="button" class="layui-btn layui-btn-sm layui-btn-warm relatedSystem" flowId = "'+data[i].flowId+'" style="margin-left:'+
                                    '30px;">关联制度</button>\n' +
                                    ' <button type="button" class="layui-btn layui-btn-sm layui-btn-danger guidelines" flowId = "'+data[i].flowId+'" style="margin-left:'+
                                    '30px;">流程指引</button>\n' +
                                    '</p>\n'+
                                    '</div>';
                                }
                                $('.process').html(app);
                            }else{
                                app = '<div class="noData" style="text-align: center;border: none;width: 15%;height: 22%;margin-left: 35%;margin-top: 10%">' +
                                '<img src="/img/main_img/shouyekong.png" alt="">' +
                                '<h6 style="text-align: center;color: #666;">'+'暂无数据'+'</h6>' +
                                '</div>';
                                $('.process').html(app);
                            }
                        }
                    });
                }
                
                //制度文档查询按钮
                $('.search').on("click",function() {
                    // var status = $('.target_tabs').children('.layui-this').attr('opttype');
                    var sortId = $('#sortId').val() || '';//$('#institutionalForm input[unselect="unselect"]').attr('treenodeid');
                    // if(status==3){
                        latest($('.keyWord').val(),sortId,'',deptType);
                    // }
                    // else if(status==2){
                    //     order(5,$('.keyWord').val(),sortId,'');
                    // }
                });
                // 清空制度查询
                $('#resetInstitutionalForm').on('click', function(){
                    // $('#institutionalForm input[unselect="unselect"]').attr('treenodeid', '');
                });    
                
                //制度文档分类下拉树
                treeSelect.render( {
                    elem: '#electree', // 选择器
                    data: '/workflow/flowDataSelect', // 数据
                    type: 'get', // 异步加载方式：get/post，默认get
                    placeholder: '请选择', // 占位符
                    search: true, // 是否开启搜索功能：true/false，默认false
                    style: { // 一些可定制的样式
                        folder: {enable: true},
                        line: {enable: true}
                    },
                    click: function(d){ // 点击回调
                        $('#electree').val(d.current.id);
                        form.render();
                    }
                });
                
                //流程查询
                $('.processSearch').on("click",function(){
                    // 清除电子流程
                    $('.process').empty();
                    
                    $('.flow').removeClass('layui-this');
                    $('.electricity').addClass('layui-this');
                    
                    $('.finger').removeClass('layui-show');
                    $('.electronic').addClass('layui-show');
                    
                    var flowSort = $('.dialiu input[unselect="unselect"]').attr('treenodeid');
                    var instId = $('#instId').val() || '';
                    if (!!instId) {
                        flow(instId, $('.flowName').val(), flowSort);
                    }
                });
                // 清空流程查询
                $('.processReset').on("click",function(){
                    $('.dialiu input[unselect="unselect"]').attr('treenodeid', '');
                });
                
                // 收藏查看更多
                $('.totle').on('click', function(){
                    layer.open({
                        title: '我的收藏',
                        type: 1,
                        btn: ['返回'],
                        area: ['70%', '90%'],
                        content: '<div><table class="layui-hide" id="collectTable" lay-filter="collectTable"></table></div>',
                        success: function(){
                            table.render({
                                elem: '#collectTable',
                                url: '/InstitutionContent/findContentWhere',
                                where: {
                                    approveStatus: 1,
                                    instStatus: 1,
                                    order: 3,
                                    useFlag: false,
                                    userIds: 1
                                },
                                parseData: function(res){ //res 即为原始返回的数据
                                    return {
                                        "code":0, //解析接口状态
                                        "data": res.obj , //解析数据列表，
                                        "count": res.totleNum, //解析数据长度
                                    };
                                },
                                cols: [[
                                    {field:'instName', title:'制度名称',align:'left',templet:function (d) {
                                        var name = d.instName;
                                        if (name.indexOf('有限公司') > 0) {
                                            name = name.split('有限公司')[1];
                                        }
                                        return '<a href="/institution/selectInstitution?instId='+d.instId+'" target="_blank">'+name+'</a>'
                                    }},
                                    {field:'sortName', title:'制度分类',templet:function(d) {
                                        return !!d.institutionSort ? d.institutionSort.sortName || '' : '';
                                    }},
                                    {field:'readerNum', title:'阅读数',templet:function(d) {
                                        return d.readerNum || 0;
                                    }}
                                ]]
                            }); 
                        },
                        yes: function(index){
                            layer.close(index);
                        }
                    });
                });
                
            });
            
            //判断返回是否为空
            function empty (esName) {
                if (esName == undefined || esName == ''){
                    return '';
                }else{
                    return esName;
                }
            }
        </script>
    </body>
</html>
