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
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <title>供应商管理</title>
    <link rel="stylesheet" href="layui.css" media="all">
    <meta name="renderer" content="webkit">
    <meta http-equiv="X-UA-Compatible" content="IE=10,chrome=1">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=0, minimum-scale=1.0, maximum-scale=1.0">
    <link rel="stylesheet" href="/lib/layui/layui/css/layui.css?20210319.1">
    <link rel="stylesheet" href="/lib/layui/layui/css/common.css">
    <link rel="stylesheet" href="/lib/layui/layui/css/eleTree.css">
    <script type="text/javascript" src="/js/xoajq/xoajq1.js"></script>
    <script src="/lib/layui/layui/layui.js"></script>
    <script src="/js/jquery/jquery.form.min.js"></script>
    <script src="/lib/layui/layui/js/common.js?v=20190726" type="text/javascript" charset="utf-8"></script>
    <script src="/lib/layui/layui/js/baseCode/base.js?v=2019080918:09" type="text/javascript" charset="utf-8"></script>
    <script type="text/javascript" src="/lib/layui/layui/global.js"></script>
    <script src="/js/base/base.js" type="text/javascript" charset="utf-8"></script>
    <script type="text/javascript" src="/js/xoajq/xoajq1.js"></script>
    <script type="text/javascript" src="/js/xoajq/xoajq2.js"></script>
    <style>
        hr {
            margin-top:7px;
            *margin: 0;
            border: 0;
            height: 3px
        }
        .select{
            background: #c7e1ff;
        }
        .Tab .layui-nav  li a:hover{
            background-color:#009688 ;
        }
        .displayNone .layui-form-item{
            margin-bottom: 0px;
        }
    </style>
</head>
<body>
<%--左侧切换得功能--%>
<div class="layui-side layui-bg-black">
    <div class="layui-side-scroll Tab">
        <ul class="layui-nav layui-nav-tree layui-nav-side" style="background-color: #20222A">
            <li class="layui-nav-item" ><a style="font-weight: bold;"onclick="show('compile1')" >客户管理</a></li>
            <li class="layui-nav-item "><a  style="font-weight: bold;" onclick="show('compile2')">供货商管理</a></li>
            <li class="layui-nav-item "><a  style="font-weight: bold;"  onclick="show('compile3')"  >往来单位管理</a></li>
        </ul>
    </div>
</div>
<%--所有的主题内容--%>
<div class="layui-body">
    <!-- 内容主体区域 -->
    <%--第一个--%>
    <div id="compile1" class="displayNone">
        <%--头部--%>
        <div class="headTop">
            <div class="headImg">
                <p style="margin-left: 15px">
                    <label style="display: inline-block; font-size: 22px;">&nbsp;&nbsp;供货管理</label>
                </p>
                <hr class="layui-bg-blue "  >
            </div>
        </div>
        <%--第一个--%>
        <form class="layui-form" action="">
            <%--第一个--%>
            <div class="layui-form-item" style="display: flex;width: 100%">
                <div class="layui-inline">
                    <label class="layui-form-label" style="width: 112px;"><span style="color: red;">*</span>客户名称</label>
                    <div class="layui-input-inline">
                        <input type="text" name="number" lay-verify="required|number" autocomplete="off" class="layui-input">
                    </div>
                </div>
                <div class="layui-inline">
                    <label class="layui-form-label">客户姓名</label>
                    <div class="layui-input-inline">
                        <input type="tel" name="url" lay-verify="url" autocomplete="off" class="layui-input">
                    </div>
                </div>
                <div class="layui-inline">
                    <label class="layui-form-label">性别</label>
                    <div class="layui-input-inline">
                        <select name="city" lay-verify="required">
                            <option value=""></option>
                            <option value="0">男</option>
                            <option value="1">女</option>
                            <option value="1">其他</option>
                        </select>
                    </div>
                </div>
                <div class="layui-inline">
                    <label class="layui-form-label">职务</label>
                    <div class="layui-input-inline">
                        <select name="city" lay-verify="required">
                            <option value=""></option>
                            <option value="0">职务</option>
                            <option value="1">负责人</option>
                            <option value="2">总经理</option>
                            <option value="3">总裁</option>
                            <option value="4">书记</option>
                            <option value="4">局长</option>
                            <option value="4">处长</option>
                            <option value="4">主任</option>
                            <option value="4">文员</option>
                            <option value="4">参谋</option>
                            <option value="4">其他</option>
                        </select>
                    </div>
                </div>
            </div>
            <%--第二个--%>
            <div class="layui-form-item" style="display: flex;width: 100%">
                <div class="layui-inline">
                    <label class="layui-form-label" style="width: 112px;">联系电话</label>
                    <div class="layui-input-inline">
                        <input type="text" name="number" lay-verify="required|number" autocomplete="off" class="layui-input">
                    </div>
                </div>
                <div class="layui-inline">
                    <label class="layui-form-label">手机</label>
                    <div class="layui-input-inline">
                        <input type="tel" name="url" lay-verify="url" autocomplete="off" class="layui-input">
                    </div>
                </div>
                <div class="layui-inline">
                    <label class="layui-form-label">电子邮箱</label>
                    <div class="layui-input-inline">
                        <input type="tel" name="url" lay-verify="url" autocomplete="off" class="layui-input">
                    </div>
                </div>
                <div class="layui-inline">
                    <label class="layui-form-label">QQ/MSN</label>
                    <div class="layui-input-inline">
                        <input type="tel" name="url" lay-verify="url" autocomplete="off" class="layui-input">
                    </div>
                </div>
            </div>
            <%--第三个--%>
            <div class="layui-form-item" style="display: flex;width: 100%">
                <div class="layui-inline" style="width: 50%;">
                    <label class="layui-form-label" style="width: 112px;">客户公司名</label>
                    <div class="layui-input-inline" style="width: 74%;">
                        <input type="text" name="number" lay-verify="required|number" autocomplete="off" class="layui-input">
                    </div>
                </div>
                <div class="layui-inline"  style="width: 50%;">
                    <label class="layui-form-label" style="margin-left: -28px;">网址</label>
                    <div class="layui-input-inline" style="width: 74%;">
                        <input type="tel" name="url" lay-verify="url" autocomplete="off" class="layui-input">
                    </div>
                </div>
            </div>
            <%--第四个--%>
            <div class="layui-form-item" style="display: flex;width: 100%">
                <div class="layui-inline" style="width: 48%;">
                    <label class="layui-form-label" style="width: 112px;">通讯地址</label>
                    <div class="layui-input-inline"style="width: 76%;">
                        <input type="text" name="number" lay-verify="required|number" autocomplete="off" class="layui-input">
                    </div>
                </div>
                <div class="layui-inline">
                    <label class="layui-form-label" style="margin-left: -8px;">邮编</label>
                    <div class="layui-input-inline">
                        <input type="tel" name="url" lay-verify="url" autocomplete="off" class="layui-input">
                    </div>
                </div>
                <div class="layui-inline">
                    <label class="layui-form-label">传真</label>
                    <div class="layui-input-inline">
                        <input type="tel" name="url" lay-verify="url" autocomplete="off" class="layui-input">
                    </div>
                </div>
            </div>
            <%--第五个--%>
            <div class="layui-form-item" style="display: flex;width: 100%">
                <div class="layui-inline" style="width: 71%;">
                    <label class="layui-form-label" style="width: 112px;">备注</label>
                    <div class="layui-input-inline" style="width: 84%;">
                        <input type="text" name="number" lay-verify="required|number" autocomplete="off" class="layui-input">
                    </div>
                </div>
                <div class="layui-inline">
                    <label class="layui-form-label" style="margin-left: -8px;">业务员</label>
                    <div class="layui-input-inline">
                        <input type="tel" name="url" lay-verify="url" autocomplete="off" class="layui-input">
                    </div>
                </div>
            </div>
        </form>
        <%--表格--%>
        <div>
            <table class="layui-hide" id="test" lay-filter="test"></table>
        </div>
    </div>
    <%--第二个--%>
    <div id="compile2" class="displayNone" style ="display: none">
        <%--头部--%>
        <div class="headTop">
            <div class="headImg">
                <p style="margin-left: 15px">
                    <label style="display: inline-block; font-size: 22px;">&nbsp;&nbsp;供货管理</label>
                </p>
                <hr class="layui-bg-blue "  >
            </div>
        </div>
        <%--第一个--%>
        <form class="layui-form" action="">
            <%--第一个--%>
            <div class="layui-form-item" style="display: flex;width: 100%">
                <div class="layui-inline">
                    <label class="layui-form-label" style="width: 112px;"><span style="color: red;">*</span>供货商名称</label>
                    <div class="layui-input-inline">
                        <input type="text" name="number" lay-verify="required|number" autocomplete="off" class="layui-input">
                    </div>
                </div>
                <div class="layui-inline">
                    <label class="layui-form-label">供货商姓名</label>
                    <div class="layui-input-inline">
                        <input type="tel" name="url" lay-verify="url" autocomplete="off" class="layui-input">
                    </div>
                </div>
                <div class="layui-inline">
                    <label class="layui-form-label">性别</label>
                    <div class="layui-input-inline">
                        <select name="city" lay-verify="required">
                            <option value=""></option>
                            <option value="0">男</option>
                            <option value="1">女</option>
                            <option value="1">其他</option>
                        </select>
                    </div>
                </div>
                <div class="layui-inline">
                    <label class="layui-form-label">职务</label>
                    <div class="layui-input-inline">
                        <select name="city" lay-verify="required">
                            <option value=""></option>
                            <option value="0">职务</option>
                            <option value="1">负责人</option>
                            <option value="2">总经理</option>
                            <option value="3">总裁</option>
                            <option value="4">书记</option>
                            <option value="4">局长</option>
                            <option value="4">处长</option>
                            <option value="4">主任</option>
                            <option value="4">文员</option>
                            <option value="4">参谋</option>
                            <option value="4">其他</option>
                        </select>
                    </div>
                </div>
            </div>
            <%--第二个--%>
            <div class="layui-form-item" style="display: flex;width: 100%">
                <div class="layui-inline">
                    <label class="layui-form-label" style="width: 112px;">联系电话</label>
                    <div class="layui-input-inline">
                        <input type="text" name="number" lay-verify="required|number" autocomplete="off" class="layui-input">
                    </div>
                </div>
                <div class="layui-inline">
                    <label class="layui-form-label">手机</label>
                    <div class="layui-input-inline">
                        <input type="tel" name="url" lay-verify="url" autocomplete="off" class="layui-input">
                    </div>
                </div>
                <div class="layui-inline">
                    <label class="layui-form-label">电子邮箱</label>
                    <div class="layui-input-inline">
                        <input type="tel" name="url" lay-verify="url" autocomplete="off" class="layui-input">
                    </div>
                </div>
                <div class="layui-inline">
                    <label class="layui-form-label">QQ/MSN</label>
                    <div class="layui-input-inline">
                        <input type="tel" name="url" lay-verify="url" autocomplete="off" class="layui-input">
                    </div>
                </div>
            </div>
            <%--第三个--%>
            <div class="layui-form-item" style="display: flex;width: 100%">
                <div class="layui-inline" style="width: 50%;">
                    <label class="layui-form-label" style="width: 112px;">供货商公司名</label>
                    <div class="layui-input-inline" style="width: 74%;">
                        <input type="text" name="number" lay-verify="required|number" autocomplete="off" class="layui-input">
                    </div>
                </div>
                <div class="layui-inline"  style="width: 50%;">
                    <label class="layui-form-label" style="margin-left: -28px;">网址</label>
                    <div class="layui-input-inline" style="width: 74%;">
                        <input type="tel" name="url" lay-verify="url" autocomplete="off" class="layui-input">
                    </div>
                </div>
            </div>
            <%--第四个--%>
            <div class="layui-form-item" style="display: flex;width: 100%">
                <div class="layui-inline" style="width: 48%;">
                    <label class="layui-form-label" style="width: 112px;">通讯地址</label>
                    <div class="layui-input-inline"style="width: 76%;">
                        <input type="text" name="number" lay-verify="required|number" autocomplete="off" class="layui-input">
                    </div>
                </div>
                <div class="layui-inline">
                    <label class="layui-form-label" style="margin-left: -8px;">邮编</label>
                    <div class="layui-input-inline">
                        <input type="tel" name="url" lay-verify="url" autocomplete="off" class="layui-input">
                    </div>
                </div>
                <div class="layui-inline">
                    <label class="layui-form-label">传真</label>
                    <div class="layui-input-inline">
                        <input type="tel" name="url" lay-verify="url" autocomplete="off" class="layui-input">
                    </div>
                </div>
            </div>
            <%--第五个--%>
            <div class="layui-form-item" style="display: flex;width: 100%">
                <div class="layui-inline" style="width: 71%;">
                    <label class="layui-form-label" style="width: 112px;">备注</label>
                    <div class="layui-input-inline" style="width: 84%;">
                        <input type="text" name="number" lay-verify="required|number" autocomplete="off" class="layui-input">
                    </div>
                </div>
                <div class="layui-inline">
                    <label class="layui-form-label" style="margin-left: -8px;">业务员</label>
                    <div class="layui-input-inline">
                        <input type="tel" name="url" lay-verify="url" autocomplete="off" class="layui-input">
                    </div>
                </div>
            </div>
        </form>
        <%--表格--%>
        <div>
            <table class="layui-hide" id="test1" lay-filter="test"></table>
        </div>
    </div>
    <%--第三个--%>
    <div id="compile3" class="displayNone" style ="display: none">
        <%--头部--%>
        <div class="headTop">
            <div class="headImg">
                <p style="margin-left: 15px">
                    <label style="display: inline-block; font-size: 22px;">&nbsp;&nbsp;供货管理</label>
                </p>
                <hr class="layui-bg-blue "  >
            </div>
        </div>
        <%--第一个--%>
        <form class="layui-form" action="">
            <%--第一个--%>
            <div class="layui-form-item" style="display: flex;width: 100%">
                <div class="layui-inline">
                    <label class="layui-form-label" style="width: 112px;"><span style="color: red;">*</span>往来单位名称</label>
                    <div class="layui-input-inline">
                        <input type="text" name="number" lay-verify="required|number" autocomplete="off" class="layui-input">
                    </div>
                </div>
                <div class="layui-inline">
                    <label class="layui-form-label">往来单位姓名</label>
                    <div class="layui-input-inline">
                        <input type="tel" name="url" lay-verify="url" autocomplete="off" class="layui-input">
                    </div>
                </div>
                <div class="layui-inline">
                    <label class="layui-form-label">性别</label>
                    <div class="layui-input-inline">
                        <select name="city" lay-verify="required">
                            <option value=""></option>
                            <option value="0">男</option>
                            <option value="1">女</option>
                            <option value="1">其他</option>
                        </select>
                    </div>
                </div>
                <div class="layui-inline">
                    <label class="layui-form-label">职务</label>
                    <div class="layui-input-inline">
                        <select name="city" lay-verify="required">
                            <option value=""></option>
                            <option value="0">职务</option>
                            <option value="1">负责人</option>
                            <option value="2">总经理</option>
                            <option value="3">总裁</option>
                            <option value="4">书记</option>
                            <option value="4">局长</option>
                            <option value="4">处长</option>
                            <option value="4">主任</option>
                            <option value="4">文员</option>
                            <option value="4">参谋</option>
                            <option value="4">其他</option>
                        </select>
                    </div>
                </div>
            </div>
            <%--第二个--%>
            <div class="layui-form-item" style="display: flex;width: 100%">
                <div class="layui-inline">
                    <label class="layui-form-label" style="width: 112px;">联系电话</label>
                    <div class="layui-input-inline">
                        <input type="text" name="number" lay-verify="required|number" autocomplete="off" class="layui-input">
                    </div>
                </div>
                <div class="layui-inline">
                    <label class="layui-form-label">手机</label>
                    <div class="layui-input-inline">
                        <input type="tel" name="url" lay-verify="url" autocomplete="off" class="layui-input">
                    </div>
                </div>
                <div class="layui-inline">
                    <label class="layui-form-label">电子邮箱</label>
                    <div class="layui-input-inline">
                        <input type="tel" name="url" lay-verify="url" autocomplete="off" class="layui-input">
                    </div>
                </div>
                <div class="layui-inline">
                    <label class="layui-form-label">QQ/MSN</label>
                    <div class="layui-input-inline">
                        <input type="tel" name="url" lay-verify="url" autocomplete="off" class="layui-input">
                    </div>
                </div>
            </div>
            <%--第三个--%>
            <div class="layui-form-item" style="display: flex;width: 100%">
                <div class="layui-inline" style="width: 50%;">
                    <label class="layui-form-label" style="width: 112px;">往来单位公司名</label>
                    <div class="layui-input-inline" style="width: 74%;">
                        <input type="text" name="number" lay-verify="required|number" autocomplete="off" class="layui-input">
                    </div>
                </div>
                <div class="layui-inline"  style="width: 50%;">
                    <label class="layui-form-label" style="margin-left: -28px;">网址</label>
                    <div class="layui-input-inline" style="width: 74%;">
                        <input type="tel" name="url" lay-verify="url" autocomplete="off" class="layui-input">
                    </div>
                </div>
            </div>
            <%--第四个--%>
            <div class="layui-form-item" style="display: flex;width: 100%">
                <div class="layui-inline" style="width: 48%;">
                    <label class="layui-form-label" style="width: 112px;">通讯地址</label>
                    <div class="layui-input-inline"style="width: 76%;">
                        <input type="text" name="number" lay-verify="required|number" autocomplete="off" class="layui-input">
                    </div>
                </div>
                <div class="layui-inline">
                    <label class="layui-form-label" style="margin-left: -8px;">邮编</label>
                    <div class="layui-input-inline">
                        <input type="tel" name="url" lay-verify="url" autocomplete="off" class="layui-input">
                    </div>
                </div>
                <div class="layui-inline">
                    <label class="layui-form-label">传真</label>
                    <div class="layui-input-inline">
                        <input type="tel" name="url" lay-verify="url" autocomplete="off" class="layui-input">
                    </div>
                </div>
            </div>
            <%--第五个--%>
            <div class="layui-form-item" style="display: flex;width: 100%">
                <div class="layui-inline" style="width: 71%;">
                    <label class="layui-form-label" style="width: 112px;">备注</label>
                    <div class="layui-input-inline" style="width: 84%;">
                        <input type="text" name="number" lay-verify="required|number" autocomplete="off" class="layui-input">
                    </div>
                </div>
                <div class="layui-inline">
                    <label class="layui-form-label" style="margin-left: -8px;">业务员</label>
                    <div class="layui-input-inline">
                        <input type="tel" name="url" lay-verify="url" autocomplete="off" class="layui-input">
                    </div>
                </div>
            </div>
        </form>
        <%--表格--%>
        <div>
            <table class="layui-hide" id="test2" lay-filter="test"></table>
        </div>
    </div>
</body>
</html>
<script type="text/html" id="toolbarDemo">
    <div class="layui-btn-container">
        <button class="layui-btn layui-btn-sm" lay-event="getCheckData">增加</button>
        <button class="layui-btn layui-btn-sm" lay-event="getCheckLength">删除</button>
        <button class="layui-btn layui-btn-sm" lay-event="isAll">修改</button>
        <button class="layui-btn layui-btn-sm" lay-event="isAll">全部记录</button>
        <button class="layui-btn layui-btn-sm" lay-event="search"><i class="layui-icon layui-icon-search" style="vertical-align: middle;"></i>查询</button>
    </div>
</script>
<script>
    layui.use(['form', 'element','layedit', 'laydate','table'], function() {
        var form = layui.form;
        var element = layui.element;
        layer = layui.layer
        ,layedit = layui.layedit
        ,laydate = layui.laydate
        ,table = layui.table
        /*第一个表格*/
        table.render({
            elem: '#test'
            ,url:'/test/table/demo1.json'
            ,toolbar: '#toolbarDemo' //开启头部工具栏，并为其绑定左侧模板
            ,defaultToolbar: ['filter', 'exports', 'print', { //自定义头部工具栏右侧图标。如无需自定义，去除该参数即可
                title: '提示'
                ,layEvent: 'LAYTABLE_TIPS'
                ,icon: 'layui-icon-tips'
            }]
            ,title: '用户数据表'
            ,cols: [[
                ,{field:'username', title:'客户简称'}
                ,{field:'sex', title:'主联系人'}
                ,{field:'city', title:'公司名'}
                ,{field:'sign', title:'联系电话'}
                ,{field:'experience', title:'手机'}
                ,{field:'ip', title:'电子邮箱'}
                ,{field:'logins', title:'传真'}
                ,{field:'joinTime', title:'通讯地址'}
                ,{field:'joinTime', title:'邮编'}
                ,{field:'joinTime', title:'性别'}
                ,{field:'joinTime', title:'职务'}
                ,{field:'joinTime', title:'QQ/MSN'}
                ,{field:'joinTime', title:'网址'}
                ,{field:'joinTime', title:'业务员'}
                ,{field:'joinTime', title:'备注'}
            ]]
            ,page: true
        });
        /*第二个表格*/
        table.render({
            elem: '#test1'
            ,url:'/test/table/demo1.json'
            ,toolbar: '#toolbarDemo' //开启头部工具栏，并为其绑定左侧模板
            ,defaultToolbar: ['filter', 'exports', 'print', { //自定义头部工具栏右侧图标。如无需自定义，去除该参数即可
                title: '提示'
                ,layEvent: 'LAYTABLE_TIPS'
                ,icon: 'layui-icon-tips'
            }]
            ,title: '用户数据表'
            ,cols: [[
                ,{field:'username', title:'客户简称'}
                ,{field:'sex', title:'主联系人'}
                ,{field:'city', title:'公司名'}
                ,{field:'sign', title:'联系电话'}
                ,{field:'experience', title:'手机'}
                ,{field:'ip', title:'电子邮箱'}
                ,{field:'logins', title:'传真'}
                ,{field:'joinTime', title:'通讯地址'}
                ,{field:'joinTime', title:'邮编'}
                ,{field:'joinTime', title:'性别'}
                ,{field:'joinTime', title:'职务'}
                ,{field:'joinTime', title:'QQ/MSN'}
                ,{field:'joinTime', title:'网址'}
                ,{field:'joinTime', title:'业务员'}
                ,{field:'joinTime', title:'备注'}
            ]]
            ,page: true
        });
        /*第三个表格*/
        table.render({
            elem: '#test2'
            ,url:'/test/table/demo1.json'
            ,toolbar: '#toolbarDemo' //开启头部工具栏，并为其绑定左侧模板
            ,defaultToolbar: ['filter', 'exports', 'print', { //自定义头部工具栏右侧图标。如无需自定义，去除该参数即可
                title: '提示'
                ,layEvent: 'LAYTABLE_TIPS'
                ,icon: 'layui-icon-tips'
            }]
            ,title: '用户数据表'
            ,cols: [[
                ,{field:'username', title:'客户简称'}
                ,{field:'sex', title:'主联系人'}
                ,{field:'city', title:'公司名'}
                ,{field:'sign', title:'联系电话'}
                ,{field:'experience', title:'手机'}
                ,{field:'ip', title:'电子邮箱'}
                ,{field:'logins', title:'传真'}
                ,{field:'joinTime', title:'通讯地址'}
                ,{field:'joinTime', title:'邮编'}
                ,{field:'joinTime', title:'性别'}
                ,{field:'joinTime', title:'职务'}
                ,{field:'joinTime', title:'QQ/MSN'}
                ,{field:'joinTime', title:'网址'}
                ,{field:'joinTime', title:'业务员'}
                ,{field:'joinTime', title:'备注'}
            ]]
            ,page: true
        });
        form.render()
        //第一个表格
        table.on('toolbar(test)', function(obj) {
            var checkStatus = table.checkStatus(obj.config.id);
            switch(obj.event){
                case 'search':
                    layer.open({
                        type: 1 //Page层类型
                        ,area: ['500px', '260px']
                        ,title: '仓库查询'
                        ,maxmin: true //允许全屏最小化
                        ,content:'<div class="layui-form">' +
                            '<div style="margin-left:20px;margin-top: 8px;"><i class="layui-icon layui-icon-help" style="color: red"></i><span>查询提示</span></div>'+
                            ' <div class="layui-input-block" style="margin-left: 20px;width:470px">\n' +
                            '      <textarea name="desc" placeholder="您可以输入仓库名称，负责人，联系电话，仓库地址，备注进行查询" class="layui-textarea" style="height: 40px;min-height: 20px;"></textarea>\n' +
                            '    </div>'+
                            ' <div class="layui-form-item" style="width: 350px;margin-left:20px;margin-top: 15px;">\n' +
                            '    <label class="layui-form-label" style="width: 100px;padding: 9px 0px;">请输入查询内容</label>\n' +
                            '    <div class="layui-input-block">\n' +
                            '      <input type="text" name="title" required  lay-verify="required" placeholder="请输入查询内容" autocomplete="off" class="layui-input">\n' +
                            '    </div>\n' +
                            '  </div>'+
                            '</div>'
                        ,btn: ['查询','取消','全部记录']
                        ,success:function () {
                            form.render()
                        }
                    });
                    break;
            }
        })
        //第二个表格
        table.on('toolbar(test)', function(obj) {
            var checkStatus = table.checkStatus(obj.config.id);
            switch(obj.event){
                case 'search':
                    layer.open({
                        type: 1 //Page层类型
                        ,area: ['500px', '260px']
                        ,title: '仓库查询'
                        ,maxmin: true //允许全屏最小化
                        ,content:'<div class="layui-form">' +
                            '<div style="margin-left:20px;margin-top: 8px;"><i class="layui-icon layui-icon-help" style="color: red"></i><span>查询提示</span></div>'+
                            ' <div class="layui-input-block" style="margin-left: 20px;width:470px">\n' +
                            '      <textarea name="desc" placeholder="您可以输入仓库名称，负责人，联系电话，仓库地址，备注进行查询" class="layui-textarea" style="height: 40px;min-height: 20px;"></textarea>\n' +
                            '    </div>'+
                            ' <div class="layui-form-item" style="width: 350px;margin-left:20px;margin-top: 15px;">\n' +
                            '    <label class="layui-form-label" style="width: 100px;padding: 9px 0px;">请输入查询内容</label>\n' +
                            '    <div class="layui-input-block">\n' +
                            '      <input type="text" name="title" required  lay-verify="required" placeholder="请输入查询内容" autocomplete="off" class="layui-input">\n' +
                            '    </div>\n' +
                            '  </div>'+
                            '</div>'
                        ,btn: ['查询','取消','全部记录']
                        ,success:function () {
                            form.render()
                        }
                    });
                    break;
            }
        })
        //第三个表格
        table.on('toolbar(test)', function(obj) {
            var checkStatus = table.checkStatus(obj.config.id);
            switch(obj.event){
                case 'search':
                    layer.open({
                        type: 1 //Page层类型
                        ,area: ['500px', '260px']
                        ,title: '仓库查询'
                        ,maxmin: true //允许全屏最小化
                        ,content:'<div class="layui-form">' +
                            '<div style="margin-left:20px;margin-top: 8px;"><i class="layui-icon layui-icon-help" style="color: red"></i><span>查询提示</span></div>'+
                            ' <div class="layui-input-block" style="margin-left: 20px;width:470px">\n' +
                            '      <textarea name="desc" placeholder="您可以输入仓库名称，负责人，联系电话，仓库地址，备注进行查询" class="layui-textarea" style="height: 40px;min-height: 20px;"></textarea>\n' +
                            '    </div>'+
                            ' <div class="layui-form-item" style="width: 350px;margin-left:20px;margin-top: 15px;">\n' +
                            '    <label class="layui-form-label" style="width: 100px;padding: 9px 0px;">请输入查询内容</label>\n' +
                            '    <div class="layui-input-block">\n' +
                            '      <input type="text" name="title" required  lay-verify="required" placeholder="请输入查询内容" autocomplete="off" class="layui-input">\n' +
                            '    </div>\n' +
                            '  </div>'+
                            '</div>'
                        ,btn: ['查询','取消','全部记录']
                        ,success:function () {
                            form.render()
                        }
                    });
                    break;
            }
        })
    })
    function show(id){
        $(".displayNone").hide();
        $("#"+id).show();
    }


</script>