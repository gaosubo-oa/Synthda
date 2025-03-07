<%--
  Created by IntelliJ IDEA.
  User: 戎成路
  Date: 2020/4/16
  Time: 18:09
  To change this template use File | Settings | File Templates.
--%>
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
    <title>子项目</title>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <link rel="stylesheet" href="/lib/layui/layui/css/eleTree.css?2019101815.40">
    <link rel="stylesheet" href="/lib/layui/layui/css/treeTable.css?2019101815.17">
    <link rel="stylesheet" href="/lib/layui/layui/css/layui.css?20210319.1">
    <link rel="stylesheet" href="/lib/layui/layui/css/modules/layer/default/layer.css">
    <link rel="stylesheet" href="/lib/layui/layui/css/layui.css?20210319.1">

    <script type="text/javascript" src="/js/xoajq/xoajq1.js"></script>
    <script type="text/javascript" src="/lib/layui/layui/layui.all.js"></script>
    <script type="text/javascript" src="/js/base/base.js" ></script>
    <script type="text/javascript" src="/lib/layui/layui/global.js"></script>

    <style>
        html,body {
            width: 100%;
            height: 100%;
            /*background: #fff;*/
            user-select: none;
        }
        /*伪元素是行内元素 正常浏览器清除浮动方法*/
        .clearfix:after{
            content: "";
            display: block;
            height: 0;
            clear:both;
            visibility: hidden;
        }
        .clearfix{
            *zoom: 1;/*ie6清除浮动的方式 *号只有IE6-IE7执行，其他浏览器不执行*/
        }

        .container {
            position: absolute;
            width: 100%;
            height: 175%;
        }

        .content {
            position: absolute;
            top: 115px;
            right: 0;
            bottom: 0;
            left: 0;
        }

        .con_left {
            float: left;
            width: 230px;
            height: 100%;
        }

        .left_List .left_List_item{
            width: 100%;
            line-height: 40px;
            padding-left: 10px;
            border-bottom: 1px solid #ddd;
            border-radius: 3px;
            overflow: hidden;
            box-sizing: border-box;
            word-break: break-all;
            white-space: nowrap;
            text-overflow: ellipsis;
            cursor: pointer;
        }

        .left_List .select{
            background: #c7e1ff;
        }

        .con_right {
            float: left;
            width: calc(100% - 230px);
            height: 100%;
        }

        .project_tree_module {
            float: left;
            width: 250px;
            min-height: 50px;
            padding-right: 15px;
            box-sizing: border-box;
            height: 100%;
            overflow: hidden;
        }
        .project_info {
            float: left;
            width: calc(100% - 250px);
            box-shadow: 0 0px 5px 0 rgba(0,0,0,.1);
            border-radius: 3px;
        }

        .project_name {
            font-size: 18px;
            font-weight: 500;
        }

        .layui-form-label {
            width: 130px;
        }
        .layui-input-block{
            margin-left: 160px;
        }
        .dept_input, .user_input {
            background-color: #ccc;
        }
        .select_input {
            width: 60% !important;
        }

        .disabled {
            border: none;
            background-color: #fff !important;
        }

        .choose_disabled {
            display: none;
        }

        .layui-select-disabled .layui-disabled{
            border: none;
            cursor: default !important;
            color: #222 !important;
        }
        .layui-select-disabled .layui-edge{
            display: none;
        }
        .query .layui-form-label{
            width: 70px
        }
        .query .layui-input-block{
            margin-left:110px;
        }
        .inputs .layui-form-select .layui-input{
            height: 30px; !important;
        }
    </style>

</head>
<body>
<div class="container">
    <div class="header">
        <div class="headImg" style="padding-top: 10px">
            <span style="font-size:22px;margin-left:10px;color:#494d59;margin-top: 2px"><img style="margin-left:1.5%" src="../img/commonTheme/theme6/icon_summary.png" alt=""><span style="margin-left: 10px">子项目</span></span>
        </div>
    </div>
    <hr>
    <%--筛选查询--%>
    <form class="layui-form" action="">
    <div class="query" style="display: flex" >
        <div class="layui-form-item" >
            <label class="layui-form-label" style="margin-top: -5px">子项目名称</label>
            <div class="layui-input-block">
                <input style="height: 30px;" type="text" name="title" required  lay-verify="required" autocomplete="off" class="layui-input">
            </div>
        </div>
        <div class="layui-form-item inputs" >
                <label class="layui-form-label" style="margin-top: -5px">子项目类型</label>
                <div class="layui-input-block" >
                    <select  name="city" lay-verify="required" >
                        <option value="">请选择</option>
                    </select>
                </div>

        </div>
        <%--<div class="layui-form-item">--%>
            <%--<label class="layui-form-label" style="margin-top: -5px">子项目性质</label>--%>
            <%--<div class="layui-input-block">--%>
                <%--<input style="height: 30px" type="text" name="title" required  lay-verify="required" autocomplete="off" class="layui-input">--%>
            <%--</div>--%>
        <%--</div>--%>
        <div class="layui-form-item inputs" >
            <label class="layui-form-label" style="margin-top: -5px">子项目性质</label>
            <div class="layui-input-block" >
                <select  name="city" lay-verify="required" >
                    <option value="">请选择</option>
                </select>
            </div>
        </div>

        <div class="layui-form-item inputs" >
            <label class="layui-form-label" style="margin-top: -5px">子项目分类</label>
            <div class="layui-input-block" >
                <select  name="city" lay-verify="required" >
                    <option value="">请选择</option>
                </select>
            </div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label" style="margin-top: -5px">建设单位</label>
            <div class="layui-input-block">
                <input style="height: 30px" type="text" name="title" required  lay-verify="required" autocomplete="off" class="layui-input">
            </div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label" style="margin-top: -5px">子项目进展</label>
            <div class="layui-input-block">
                <input style="height: 30px" type="text" name="title" required  lay-verify="required" autocomplete="off" class="layui-input">
            </div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label" style="margin-top: -5px">主要负责人</label>
            <div class="layui-input-block">
                <input style="height: 30px" type="text" name="title" required  lay-verify="required" autocomplete="off" class="layui-input">
            </div>
        </div>
        <button type="button" class="layui-btn layui-btn-sm" style="margin-left: 1%">查询</button>
    </div>
    </form>
    <hr style="margin-top: -8px">
    <div class="content clearfix">
        <div class="con_left" style="border-right: 1px solid #f2f2f2;">
            <div class="layui-card" style="height: 100%;">
                <div class="layui-card-body" style="height: 100%; padding-bottom: 20px; box-sizing: border-box; border-bottom:none">
                    <ul id="projectList" class="left_List" style="overflow:auto; height:100%">
                    </ul>
                </div>
            </div>
        </div>
        <div class="con_right" style="width: 82%">
            <div class="right_content" style="height: 100%;">
                <div class="layui-card" style="height: 100%;">
                    <div class="layui-card-header project_name"></div>
                    <div class="layui-card-body clearfix" style="height: calc(100% - 43px); box-sizing: border-box; padding-bottom: 20px;">
                        <div id="projectTree" class="project_tree_module">
                            <div class="eleTree project_tree" style="height: 100%; overflow: auto;" lay-filter="projectData"></div>
                        </div>
                        <div class="project_info">
                            <div class="layui-card-body clearfix">
                                <div class="layui-tab layui-tab-brief" lay-filter="docDemoTabBrief">
                                    <div class="layui-card-header dept_name" id="titles" style="font-size: 18px;font-weight: 500;display: none"></div>
                                    <ul class="layui-tab-title" id="title">
                                        <li class="layui-this">新增子项目</li>
                                        <%--<li>关键任务</li>--%>
                                        <%--<li>子任务</li>--%>
                                    </ul>
                                    <div class="layui-tab-content">
                                        <div class="layui-tab-item layui-show">
                                            <form id="pBagForm" class="layui-form" lay-filter="pBagForm">
                                                <div class="layui-row">
                                                    <div class="layui-col-xs6">
                                                        <div class="layui-form-item">
                                                            <label class="layui-form-label">子项目名称</label>
                                                            <div class="layui-input-block">
                                                                <input type="text" name="pbagName" placeholder="请输入" autocomplete="off" class="layui-input">
                                                            </div>
                                                        </div>
                                                        <div class="layui-form-item">
                                                            <label class="layui-form-label">子项目性质</label>
                                                            <div class="layui-input-block">
                                                                <select id="pbagNature" name="pbagNature" lay-verify="required">
                                                                    <option value=""></option>
                                                                </select>
                                                            </div>
                                                        </div>
                                                        <div class="layui-form-item">
                                                            <label class="layui-form-label">子项目分类</label>
                                                            <div class="layui-input-block">
                                                                <select id="pbagClass" name="pbagClass" lay-verify="required">
                                                                    <option value=""></option>
                                                                </select>
                                                            </div>
                                                        </div>
                                                        <div class="layui-form-item">
                                                            <label class="layui-form-label">责任人部门</label>
                                                            <div class="layui-input-inline">
                                                                <input style="width: 70%" type="text" readonly id="dutyDept" name="dutyDept" autocomplete="off" class="layui-input dept_input">
                                                            </div>
                                                            <div style="margin-left: 80%;margin-top: -35px" class="layui-form-mid layui-word-aux" deptid="dutyDept">
                                                                <a href="javascript:;" class="choose_dept" choosetype="1" style="color: blue;">添加</a>
                                                                <a href="javascript:;" class="clear_dept" style="color: red">删除</a>
                                                            </div>
                                                        </div>
                                                        <div class="layui-form-item">
                                                            <label class="layui-form-label">责任人</label>
                                                            <div class="layui-input-inline">
                                                                <input style="width: 70%" type="text" readonly id="dutyUser" name="dutyUser" autocomplete="off" class="layui-input user_input">
                                                            </div>
                                                            <div style="margin-left: 80%;margin-top: -35px" class="layui-form-mid layui-word-aux" userid="dutyUser">
                                                                <a href="javascript:;" class="choose_user" choosetype="1" style="color: blue;">添加</a>
                                                                <a href="javascript:;" class="clear_user" style="color: red">删除</a>
                                                            </div>
                                                        </div>
                                                        <div class="layui-form-item">
                                                            <label class="layui-form-label">责任人电话</label>
                                                            <div class="layui-input-block">
                                                                <input type="text" name="dutyUserTel" placeholder="请输入" autocomplete="off" class="layui-input">
                                                            </div>
                                                        </div>
                                                        <div class="layui-form-item">
                                                            <label class="layui-form-label">验收标准</label>
                                                            <div class="layui-input-block">
                                                                <input type="text" name="acceptStandard" placeholder="请输入" autocomplete="off" class="layui-input">
                                                            </div>
                                                        </div>
                                                        <div class="layui-form-item">
                                                            <label class="layui-form-label">是否预算控制</label>
                                                            <div class="layui-input-block">
                                                                <input type="radio" name="budgetYn" value="1" title="是">
                                                                <input type="radio" name="budgetYn" value="0" title="否" checked>
                                                            </div>
                                                        </div>
                                                        <div class="layui-form-item">
                                                            <label class="layui-form-label">是否开放下级子项目</label>
                                                            <div class="layui-input-block">
                                                                <input type="radio" name="idNewChild" value="1" title="是">
                                                                <input type="radio" name="idNewChild" value="0" title="否" checked>
                                                            </div>
                                                        </div>
                                                        <div class="layui-form-item">
                                                            <label class="layui-form-label">是否新建子任务</label>
                                                            <div class="layui-input-block">
                                                                <input type="radio" name="isNewItem" value="1" title="是" checked>
                                                                <input type="radio" name="isNewItem" value="0" title="否">
                                                            </div>
                                                        </div>
                                                        <div class="layui-form-item">
                                                            <label class="layui-form-label">是否新建关键任务</label>
                                                            <div class="layui-input-block">
                                                                <input type="radio" name="isNewTarget" value="1" title="是" checked>
                                                                <input type="radio" name="isNewTarget" value="0" title="否">
                                                            </div>
                                                        </div>
                                                        <div class="layui-form-item">
                                                            <label class="layui-form-label">建设单位</label>
                                                            <div class="layui-input-block">
                                                                <input type="text" name="buildUnit" placeholder="请输入" autocomplete="off" class="layui-input">
                                                            </div>
                                                        </div>
                                                        <div class="layui-form-item">
                                                            <label class="layui-form-label">设计单位</label>
                                                            <div class="layui-input-block">
                                                                <input type="text" name="designUnit" placeholder="请输入" autocomplete="off" class="layui-input">
                                                            </div>
                                                        </div>
                                                        <div class="layui-form-item">
                                                            <div class="layui-input-block" style="margin-left: 90%">
                                                                <button class="layui-btn" id="saveProjectBag">新增保存</button>
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <div class="layui-col-xs6">
                                                        <div class="layui-form-item">
                                                            <label class="layui-form-label">子项目内容</label>
                                                            <div class="layui-input-block">
                                                                <input type="text" name="pbagContent" placeholder="请输入" autocomplete="off" class="layui-input">
                                                            </div>
                                                        </div>
                                                        <div class="layui-form-item">
                                                            <label class="layui-form-label">子项目类型</label>
                                                            <div class="layui-input-block">
                                                                <select id="pbagType" name="pbagType" lay-verify="required">
                                                                    <option value=""></option>
                                                                </select>
                                                            </div>
                                                        </div>
                                                        <div class="layui-form-item">
                                                            <label class="layui-form-label">子项目层级</label>
                                                            <div class="layui-input-block">
                                                                <select id="pbagLevel" name="pbagLevel" lay-verify="required">
                                                                    <option value=""></option>
                                                                </select>
                                                            </div>
                                                        </div>
                                                        <div class="layui-form-item">
                                                            <label class="layui-form-label">成本类型</label>
                                                            <div class="layui-input-block">
                                                                <select id="costType" name="costType" lay-verify="required">
                                                                    <option value=""></option>
                                                                </select>
                                                            </div>
                                                        </div>
                                                        <div class="layui-form-item">
                                                            <label class="layui-form-label">计划开始时间</label>
                                                            <div class="layui-input-block">
                                                                <input type="text" name="planBeginDate" class="layui-input" id="planBeginDate">
                                                            </div>
                                                        </div>
                                                        <div class="layui-form-item">
                                                            <label class="layui-form-label">计划结束时间</label>
                                                            <div class="layui-input-block">
                                                                <input type="text" name="planEndDate" class="layui-input" id="planEndDate">
                                                            </div>
                                                        </div>
                                                        <div class="layui-form-item">
                                                            <label class="layui-form-label">实际开始时间</label>
                                                            <div class="layui-input-block">
                                                                <input type="text" name="realBeginDate" class="layui-input" id="realBeginDate">
                                                            </div>
                                                        </div>
                                                        <div class="layui-form-item">
                                                            <label class="layui-form-label">实际结束时间</label>
                                                            <div class="layui-input-block">
                                                                <input type="text" name="realEndDate" class="layui-input" id="realEndDate">
                                                            </div>
                                                        </div>
                                                        <div class="layui-form-item">
                                                            <label class="layui-form-label">计划工期</label>
                                                            <div class="layui-input-block">
                                                                <input type="text" name="planPeriod" placeholder="请输入" autocomplete="off" class="layui-input">
                                                            </div>
                                                        </div>
                                                        <div class="layui-form-item">
                                                            <label class="layui-form-label">实际工期</label>
                                                            <div class="layui-input-block">
                                                                <input type="text" name="truePeriod" placeholder="请输入" autocomplete="off" class="layui-input">
                                                            </div>
                                                        </div>
                                                        <div class="layui-form-item">
                                                            <label class="layui-form-label">子项目关键任务</label>
                                                            <div class="layui-input-block">
                                                                <input type="text" name="pbagTarget" placeholder="请输入" autocomplete="off" class="layui-input">
                                                            </div>
                                                        </div>
                                                        <div class="layui-upload" style="height: auto">
                                                            <div id="bagFiles" style="padding-left: 160px;"></div>
                                                            <label class="layui-form-label">附件：</label>
                                                            <button type="button" class="layui-btn layui-btn-primary " id="uploadBagFile" style="border: 0px;color:#3870d7;padding: 0;"><img src="/img/icon_uplod.png" style="margin-right: 5px;"><i style="display: none" class="layui-icon"></i>附件上传</button>
                                                        </div>
                                                    </div>
                                                </div>
                                            </form>
                                        </div>
                                        <div class="layui-tab-item">
                                            <table id="targetTable" lay-filter="targetTable"></table>
                                        </div>
                                        <div class="layui-tab-item">
                                            <table id="taskTable" lay-filter="taskTable"></table>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<%-- 关键任务工具条 --%>
<script type="text/html" id="targerBar">
    <a class="layui-btn layui-btn-xs" lay-event="detail">查看</a>
    <a class="layui-btn layui-btn-xs" lay-event="edit">编辑</a>
    <a class="layui-btn layui-btn-danger layui-btn-xs" lay-event="del">删除</a>
</script>

<%-- 子任务工具条 --%>
<%--<script type="text/html" id="taskBar">--%>
    <%--<a class="layui-btn layui-btn-xs" lay-event="detail">查看</a>--%>
    <%--<a class="layui-btn layui-btn-xs" lay-event="edit">编辑</a>--%>
    <%--<a class="layui-btn layui-btn-danger layui-btn-xs" lay-event="del">删除</a>--%>
<%--</script>--%>
<script type="text/html" id="toolbarDemo" >
    <div style="float: right;margin-right: -10%">
    <a class="layui-btn layui-btn-sm" lay-event="detail">查看</a>
    <a class="layui-btn layui-btn-sm" lay-event="edit" >编辑</a>
    <a class="layui-btn layui-btn-danger layui-btn-sm" lay-event="del" >删除</a>
    </div>
</script>

<script src="/js/planCheck/projectTaskOrganization/projectWorkAnalyze.js?20200422.1"></script>
</body>
</html>
