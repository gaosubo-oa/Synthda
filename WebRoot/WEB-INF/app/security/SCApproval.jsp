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
    <title>发布内容审核</title>
<%--    <link rel="stylesheet" href="/css/officialDocument/officialDocument.css">--%>
    <link rel="stylesheet" type="text/css" href="../lib/pagination/style/pagination.css"/>
    <link rel="stylesheet" type="text/css" href="/css/base/base.css?20230330.1" />
    <link rel="stylesheet" href="/css/notice/noticeManagement.css">
    <link rel="stylesheet" type="text/css" href="../lib/laydate.css"/>
    <link rel="stylesheet" type="text/css" href="/lib/layui/layui/css/layui.css"/>
    <script type="text/javascript" src="/js/xoajq/xoajq3.js"></script>
    <script type="text/javascript" src="/js/jquery/jquery-migrate-3.4.0.js"></script>
    <script src="../lib/laydate/laydate.js"></script>
    <script src="../lib/layer/layer.js?20230330"></script>
    <script src="../js/base/base.js" type="text/javascript" charset="utf-8"></script>
    <script type="text/javascript" src="/lib/layui/layui/layui.js"></script>

</head>
<link rel="stylesheet" type="text/css" href="/css/commonTheme/${sessionScope.InterfaceModel}/commonTheme.css"/>
<style>
    .title {
        display: flex;
    }
    .content {
        margin: 20px;
    }
</style>
<body>
<div id="pagediv">
    <div class="layui-tab" lay-filter="test1">
        <ul class="layui-tab-title">
            <li class="layui-this" data-type="wait">待审批内容</li>
            <li data-type="over">已审批内容</li>
        </ul>
        <div class="layui-tab-content content">
            <div class="layui-tab-item layui-show">
                <div class="title">
                    <img src="/img/commonTheme/${sessionScope.InterfaceModel}/daishen.png" alt="">
                    <h2>待审批内容</h2>
                </div>
                <div class="main">
                    <table id="demo" lay-filter="test"></table>
                </div>
            </div>
            <div class="layui-tab-item">
                <div class="title">
                    <img src="/img/commonTheme/${sessionScope.InterfaceModel}/daishen.png" alt="">
                    <h2>已审批内容</h2>
                </div>
                <div class="main">
                    <table id="demo1" lay-filter="test1"></table>
                </div>
            </div>
        </div>
    </div>
</div>
<script>
    layui.use(['element','table'],function() {
        var element = layui.element;
        var table = layui.table;
        //选项卡切换事件
        element.on('tab(test1)', function(data){
            var type = $(this).attr("data-type");
            if(type == "wait") {
                renderTable()
            }else if(type == 'over') {
                renderOverData()
            }
        });
        renderTable()
        //渲染待审批数据
        function renderTable() {
            const tableInfo = table.render({
                elem: '#demo',
                url: '/security/selectByUserId', //数据接口
                page: true, //开启分页
                where: {
                    useFlag: true
                },
                request:{
                    pageName: 'page'
                    ,limitName: 'pageSize'
                },
                parseData:function(res) {
                    return {
                        "code": 0,
                        "msg": "",
                        "count": res.totleNum,
                        "data": res.obj
                    }
                },
                cols: [[ //表头
                    {title:"序号",templet:function(d) {
                            return d.LAY_TABLE_INDEX + 1
                        }},
                    {field:"moduleName",title:"模块"},
                    {field:"dataSubject",title:"标题",templet:function(d) {
                            if(d.dataUrl) {
                                return '<a style="color: #0b8aff;" href="'+d.dataUrl+'" target="_blank">'+d.dataSubject+'</a>'
                            }else {
                                return '<a style="color: #0b8aff;">'+d.dataSubject+'</a>'
                            }

                        }},
                    {field:"operationUserId",title:"操作人"},
                    {field:"operationTime",title:"操作时间"},
                    {field:"operationType",title:"操作类型"},
                    {field:"contentSecrecy",title:"密级"},
                    {field:"contentSecrecy",title:"操作",templet:function(d) {
                            return '<button class="layui-btn layui-btn-sm layui-btn-normal" lay-event="agree">同意</button> <button lay-event="noAgree" class="layui-btn layui-btn-sm layui-btn-danger">不同意</button>'
                        }},
                ]]
            });
            table.on('tool(test)',function(obj) {
                var event = obj.event;
                var data = obj.data;
                if(event == "agree") {
                    layer.open({
                        title:"同意",
                        type: 1,
                        area:['500px','300px'],
                        btn: ['确定','取消'],
                        content: '<div style="padding: 20px;box-sizing: border-box;"><span style="vertical-align: top;">请填写理由：</span><textarea style="display: inline-block;width: 80%;" name="approvalOpinion" required lay-verify="required" placeholder="请输入" class="layui-textarea"></textarea></div>',
                        btn1:function(index) {
                            var spcId = data.spcId;
                            var approvalOpinion = $('[name=approvalOpinion]').val();
                            $.ajax({
                                url:"/security/update",
                                data: {
                                    spcId:spcId,
                                    approvalOpinion:approvalOpinion,
                                    approvalStatus: 1
                                },
                                success:function(res) {
                                    if(res.flag) {
                                        layer.msg(res.msg,{icon:1},function() {
                                            layer.close(index)
                                            tableInfo.reload();
                                        })
                                    }else {
                                        layer.msg(res.msg,{icon:2},function() {
                                            layer.close(index)
                                        })
                                    }
                                }
                            })
                        }
                    })
                }else if(event == "noAgree") {
                    layer.open({
                        title:"不同意",
                        type: 1,
                        area:['500px','300px'],
                        btn: ['确定','取消'],
                        content: '<div style="padding: 20px;box-sizing: border-box;"><span style="vertical-align: top;">请填写理由：</span><textarea style="display: inline-block;width: 80%;" name="approvalOpinion" required lay-verify="required" placeholder="请输入" class="layui-textarea"></textarea></div>',
                        btn1:function(index) {
                            var spcId = data.spcId;
                            var approvalOpinion = $('[name=approvalOpinion]').val();
                            $.ajax({
                                url:"/security/update",
                                data: {
                                    spcId:spcId,
                                    approvalOpinion:approvalOpinion,
                                    approvalStatus: 2
                                },
                                success:function(res) {
                                    if(res.flag) {
                                        layer.msg(res.msg,{icon:1},function() {
                                            layer.close(index)
                                            tableInfo.reload();
                                        })
                                    }else {
                                        layer.msg(res.msg,{icon:2},function() {
                                            layer.close(index);

                                        })
                                    }
                                }
                            })
                        }
                    })
                }
            })
        }
    //    渲染已审批数据
        function renderOverData() {
            const tableInfo = table.render({
                elem: '#demo1',
                url: '/security/selectByUserId', //数据接口
                page: true, //开启分页
                where: {
                    useFlag: true,
                    approvalStatus: 1
                },
                request:{
                    pageName: 'page'
                    ,limitName: 'pageSize'
                },
                parseData:function(res) {
                    return {
                        "code": 0,
                        "msg": "",
                        "count": res.totleNum,
                        "data": res.obj
                    }
                },
                cols: [[ //表头
                    {title:"序号",templet:function(d) {
                            return d.LAY_TABLE_INDEX + 1
                        }},
                    {field:"moduleName",title:"模块"},
                    {field:"dataSubject",title:"标题",templet:function(d) {
                            if(d.dataUrl) {
                                return '<a style="color: #0b8aff;" href="'+d.dataUrl+'" target="_blank">'+d.dataSubject+'</a>'
                            }else {
                                return '<a style="color: #0b8aff;">'+d.dataSubject+'</a>'
                            }

                        }},
                    {field:"operationUserId",title:"操作人"},
                    {field:"operationTime",title:"操作时间"},
                    {field:"operationType",title:"操作类型"},
                    {field:"contentSecrecy",title:"密级"},
                    {field:"approvalStatus",title:"审批状态",templet:function(d) {
                        if(d.approvalStatus == "1") {
                            return "通过"
                        }else if(d.approvalStatus == "2") {
                            return "未通过"
                        }
                        }},
                ]]
            });
        }
    })
</script>

</body>
</html>
