<%--
  Created by IntelliJ IDEA.
  User: 张继斌
  Date: 2022/1/6
  Time: 10:08
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>列表设计</title>
    <link rel="stylesheet" href="/lib/layui/layui/css/layui.css">
    <link rel="stylesheet" type="text/css" href="../../css/base.css"/>
    <link rel="stylesheet" type="text/css" href="/css/base/base.css?20201106.1"/>
    <link rel="stylesheet" type="text/css" href="../../lib/laydate.css"/>
    <link rel="stylesheet" type="text/css" href="../../lib/pagination/style/pagination.css"/>
    <link rel="stylesheet" href="/css/gapp/design/form_design.css">
    <script type="text/javascript" src="/js/xoajq/xoajq1.js"></script>
    <script type="text/javascript" src="/lib/layui/layui/layui.all_v2.5.js"></script>
    <script type="text/javascript" src="/js/base/base.js"></script>
    <script type="text/javascript" src="/lib/layui/layui/global.js?20201229.1"></script>
    <script type="text/javascript" src="/lib/layui/layui/lay/mymodules/tableFilter.js"></script>
    <script type="text/javascript" src="/lib/layui/layui/lay/mymodules/tableChild.js"></script>
    <script type="text/javascript" src="/lib/layui/layui/lay/mymodules/tableMerge.js"></script>
    <script src="/ui/js/qrcode.min.js"></script>
    <script src="../../lib/laydate/laydate.js"></script>
    <script src="/lib/layui/layui/js/common.js?v=20190726" type="text/javascript" charset="utf-8"></script>
    <script src="/lib/ueditor/ueditor.config.js?20200919" type="text/javascript" charset="utf-8"></script>
    <script src="/lib/ueditor/ueditor.all.js?20200919" type="text/javascript" charset="utf-8"></script>
    <script src="/lib/ueditor/UEcontroller.js?20200919" type="text/javascript" charset="utf-8"></script>
    <script type="text/javascript" src="/lib/jQuery-File-Upload-master/jquery-ui.js"></script>
    <script type="text/javascript" src="/lib/jQuery-File-Upload-master/jquery.iframe-transport.js"></script>
    <script type="text/javascript" src="/lib/jQuery-File-Upload-master/jquery.fileupload.js"></script>
    <script type="text/javascript" src="/js/email/fileupload.js"></script>
    <script type="text/javascript" src="/js/common/fileupload.js"></script>
    <script src="/lib/jQuery-File-Upload-master/jquery.fileupload.js" type="text/javascript" charset="utf-8"></script>
    <script type="text/javascript" src="/js/base/tablePage.js"></script>
    <script src="../../js/base/base.js" type="text/javascript" charset="utf-8"></script>
</head>
<style>
    .left{
        height: 100%;
        width: 83%;
        float: left;
        border-right: 1px solid rgb(239,241,247);
        background-color: white;
        padding: 16px 16px 32px 16px;
        overflow: hidden;
        overflow-y: auto;
    }
    .right{
        height: 100%;
        background-color: white;
        width: 15%;
        float: right;
        padding: 16px 0px 32px 0px;
    }
    .where1{
        height: 30px;
        line-height: 30px;
        padding-left: 15px;
        font-size: 14px;
        font-weight: 600;
        color: #304265;
    }
    .where2{
        padding-left: 15px;
    }
    .ji li{
        width: 30%;
        display: inline-block;
        margin-right: 45px;
        margin-bottom: 10px;
    }
    .you li{
        font-size: 14px;
        height: 30px;
        line-height: 30px;
        padding-left: 10px;
        width: 90%;
        border-left: 4px solid white;
        display: inline-block;
    }
    .you li div{
        display: inline-block;
        float: right;
    }
    /*.you li span{*/
    /*    display: none;*/
    /*}*/
    .you{
        margin-left: 15px;
    }
    .yous{
        margin-left: 15px;
        box-shadow: 2px 2px 7px black;
        background-color: white;
    }
    .yous li{
        font-size: 14px;
        height: 30px;
        line-height: 30px;
        padding-left: 10px;
        width: 90%;
    }
    .you li:hover{
        background-color: rgb(244,247,255);
        border-left: 4px solid rgb(94,144,255);
    }
    .layui-form-checkbox span{
        height: 100%;
    }
    .layui-input-block{
        margin: 0;
    }
    #asd li{
        float: left;
        width: 25%;
        height: 25px;
    }
    #asd1 li{
        float: left;
        width: 24%;
    }
    .zxc li{
        display: inline-block;
        height: 30px;
        width: 45%;
        line-height: 30px;
        text-align: center;
        border: 1px solid rgb(16,127,255);
    }
    .anniu{
        text-align: center;
    }
    .anniu li{
        border: 1px dashed rgb(221,221,221)!important;
        height: 30px!important;
        display: inline-block;
        width: 90%;
        line-height: 30px;
        margin-bottom: 5px;
        text-align: left;
        padding-left: 10px;
    }
    .action{
        width: 100%;
        height: 50px;
        text-align: center;
        line-height: 50px;
        border: 1px solid rgb(212,215,224);
        font-size: 14px;
    }
    .lie div{
        display: inline-block;
        margin-left: 25px;
    }
    .layui-table-body {
        overflow-x: hidden;
    }
    .moleft{
        height: 36px;
        line-height: 36px;
        width: 30%;
        text-align: center;
        display: inline-block;
        border: 1px solid rgb(207,207,207);
        position: relative;
        top: 0px;
        left: 5px;
    }
    .moright{
        width: 65%;
        display: inline-block;
    }
    .shizhi li{
        height: 40px;
        line-height: 40px;
    }
    #addss{
        display: inline-block;
        width: 80px;
        height: 35px;
        border-radius: 10px;
        text-align: center;
        line-height: 35px;
        margin-left: 30px;
        margin-bottom: 20px;
        border: 1px solid rgb(221,221,221);
    }
</style>

<body>
<div class="layui-tab layui-tab-brief" lay-filter="docDemoTabBrief" style="background-color: rgb(220,231,251)">
    <input type="text" id="tabName">

    <ul class="layui-tab-title">
        <li>表单设计</li>
<%--        <li>流程设计</li>--%>
        <li class="layui-this">列表设计</li>
<%--        <li>应用设置</li>--%>
    </ul>
</div>
<div class="bodys">
    <div id="header" style="background-color: rgb(245,247,250)">
        <div class="save" id="save"><img src="/ui/img/gapp/save.png" alt=""> 保存</div>
    </div>
    <div class="left">
        <div class="where">
            <div class="where1">查询条件</div>
            <div>
                <div class="action">请从右侧面板添加查询条件</div>
                <div id="leftYou" class="layui-tab-item layui-show ji" style="padding-left: 15px">
                    <%--                        <li><span style="display: inline-block;width: 20%;font-weight: bold;">合同名称</span><div style="width: 80%;display: inline-block"><input type="text" style="" name="name"  lay-verify="required|phone" autocomplete="off" class="layui-input"></div></li>--%>
                    <%--                        <li><span style="display: inline-block;width: 20%;font-weight: bold;">范本名称</span><div style="width: 80%;display: inline-block"><input type="text" style="" name=""  lay-verify="required|phone" autocomplete="off" class="layui-input"></div></li>--%>
                    <%--                        <li><span style="display: inline-block;width: 20%;font-weight: bold;">范本编号</span><div style="width: 80%;display: inline-block"><input type="text" style="" name=""  lay-verify="required|phone" autocomplete="off" class="layui-input"></div></li>--%>
                    <%--                        <li><span style="display: inline-block;width: 20%;font-weight: bold;">创建人</span><div style="width: 80%;display: inline-block"><input placeholder="点击选择创建人" type="text" id="creat" style="" name=""  lay-verify="required|phone" autocomplete="off" class="layui-input"></div></li>--%>
                    <%--                        <li><span style="display: inline-block;width: 20%;font-weight: bold;">拥有者</span><div style="width: 80%;display: inline-block"><input placeholder="点击选择拥有者" type="text" id="have" style="" name=""  lay-verify="required|phone" autocomplete="off" class="layui-input"></div></li>--%>
                    <%--                        <li><span style="display: inline-block;width: 20%;font-weight: bold;">所属部门</span><div style="width: 80%;display: inline-block"><input placeholder="点击选择部门" type="text" id="dept" style="" name=""  lay-verify="required|phone" autocomplete="off" class="layui-input"></div></li>--%>
                    <%--                        <li><span style="display: inline-block;width: 20%;font-weight: bold;">创建时间</span><div style="width: 80%;display: inline-block"><input id="timeRange" type="text" style="" name=""  lay-verify="required|phone" autocomplete="off" class="layui-input"></div></li>--%>
                    <%--                        <li><span style="display: inline-block;width: 20%;font-weight: bold;">修改时间</span><div style="width: 80%;display: inline-block"><input id="timeRanges" type="text" style="" name=""  lay-verify="required|phone" autocomplete="off" class="layui-input"></div></li>--%>
                    <%--                        <li><span style="display: inline-block;width: 20%;font-weight: bold;">单行文本1</span><div style="width: 80%;display: inline-block"><input type="text" style="" name=""  lay-verify="required|phone" autocomplete="off" class="layui-input"></div></li>--%>
                    <%--                        <li><span style="display: inline-block;width: 20%;font-weight: bold;">备注</span><div style="width: 80%;display: inline-block"><input type="text" style="" name=""  lay-verify="required|phone" autocomplete="off" class="layui-input"></div></li>--%>
                    <%--                        <li><span style="display: inline-block;width: 20%;font-weight: bold;">流程状态</span><div style="width: 80%;display: inline-block"><input type="text" style="" name=""  lay-verify="required|phone" autocomplete="off" class="layui-input"></div></li>--%>
                </div>
            </div>
        </div>
        <div class="listField">
            <div class="where1">列表字段</div>
            <table class="layui-hide" id="test" lay-filter="test"></table>
        </div>
    </div>
    <div class="right">
        <div class="layui-tab layui-tab-brief" lay-filter="docDemoTabBrief">
            <ul class="layui-tab-title">
                <li class="layui-this">字段设置</li>
                <li>列表设置</li>
            </ul>
            <div class="layui-tab-content" style="height: 100px;">
                <div class="layui-tab-item  layui-show">
                    <div class="where1" style="margin-top: 15px;">查询条件<span class="layui-icon layui-icon-add-1" id="condition" style="float: right;margin-right: 10px;"></span></div>
                    <form class="layui-form" action="">
                        <div id="yous" style="width: 240px;position: absolute;display: none">
                            <div class="layui-form-item" pane="">
                                <div class="layui-input-block">
                                    <ul id="youss" class="yous" style="height: 345px;overflow: scroll;overflow-x: hidden;">
                                        <li><input name="like1[write]" flag="false" data-type="all" lay-filter="yous" value="全选"  title="全选" type="checkbox" lay-skin="primary"></li>
                                        <li><input name="like1[write]" flag="false" data-type="choose" lay-filter="yous" value="拥有者"  title="拥有者" type="checkbox" lay-skin="primary"></li>
                                        <li><input name="like1[write]" flag="false" data-type="choose" lay-filter="yous" value="所属部门" title="所属部门" type="checkbox"  lay-skin="primary"></li>
                                        <li><input name="like1[write]" flag="false" data-type="time" lay-filter="yous" value="创建时间" title="创建时间" type="checkbox"  lay-skin="primary"></li>
                                        <li><input name="like1[write]" flag="false" data-type="time" lay-filter="yous" value="修改时间" title="修改时间" type="checkbox"  lay-skin="primary"></li>
                                        <li><input name="like1[write]" flag="false" data-type="input" lay-filter="yous" value="合同类型" title="合同类型" type="checkbox"  lay-skin="primary"></li>
                                        <li><input name="like1[write]" flag="false" data-type="input" lay-filter="yous" value="单行文本1" title="单行文本1" type="checkbox" lay-skin="primary"></li>
                                        <li><input name="like1[write]" flag="false" data-type="input" lay-filter="yous" value="范本名称" title="范本名称" type="checkbox" lay-skin="primary"></li>
                                        <li><input name="like1[write]" flag="false" data-type="input" lay-filter="yous" value="范本编号" title="范本编号" type="checkbox" lay-skin="primary"></li>
                                        <li><input name="like1[write]" flag="false" data-type="input" lay-filter="yous" value="备注"  title="备注" type="checkbox" lay-skin="primary"></li>
                                        <li><input name="like1[write]" flag="false" data-type="time" lay-filter="yous" value="日期"  title="日期" type="checkbox" lay-skin="primary"></li>
                                        <li><input name="like1[write]" flag="false" data-type="choose" lay-filter="yous" value="创建人"  title="创建人" type="checkbox" lay-skin="primary"></li>
                                        <li><input name="like1[write]" flag="false" data-type="input" lay-filter="yous" value="流程状态" title="流程状态" type="checkbox" lay-skin="primary"></li>
                                    </ul>
                                </div>
                            </div>
                        </div>
                    </form>
                    <ul id="you" class="you">
                        <%--                            <li>合同类型<span class="layui-icon layui-icon-delete" style="float: right;margin-right: 10px;color: red"></span><span class="layui-icon layui-icon-set" style="float: right;margin-right: 10px;color:blue;"></span></li>--%>
                        <%--                            <li>范本名称<span class="layui-icon layui-icon-delete" style="float: right;margin-right: 10px;color: red"></span><span class="layui-icon layui-icon-set" style="float: right;margin-right: 10px;color:blue;"></span></li>--%>
                        <%--                            <li>范本编号<span class="layui-icon layui-icon-delete" style="float: right;margin-right: 10px;color: red"></span><span class="layui-icon layui-icon-set" style="float: right;margin-right: 10px;color:blue;"></span></li>--%>
                        <%--                            <li>创建人<span class="layui-icon layui-icon-delete" style="float: right;margin-right: 10px;color: red"></span><span class="layui-icon layui-icon-set" style="float: right;margin-right: 10px;color:blue;"></span></li>--%>
                        <%--                            <li>拥有者<span class="layui-icon layui-icon-delete" style="float: right;margin-right: 10px;color: red"></span><span class="layui-icon layui-icon-set" style="float: right;margin-right: 10px;color:blue;"></span></li>--%>
                        <%--                            <li>所属部门<span class="layui-icon layui-icon-delete" style="float: right;margin-right: 10px;color: red"></span><span class="layui-icon layui-icon-set" style="float: right;margin-right: 10px;color:blue;"></span></li>--%>
                        <%--                            <li>创建时间<span class="layui-icon layui-icon-delete" style="float: right;margin-right: 10px;color: red"></span><span class="layui-icon layui-icon-set" style="float: right;margin-right: 10px;color:blue;"></span></li>--%>
                        <%--                            <li>修改时间<span class="layui-icon layui-icon-delete" style="float: right;margin-right: 10px;color: red"></span><span class="layui-icon layui-icon-set" style="float: right;margin-right: 10px;color:blue;"></span></li>--%>
                        <%--                            <li>单行文本1<span class="layui-icon layui-icon-delete" style="float: right;margin-right: 10px;color: red"></span><span class="layui-icon layui-icon-set" style="float: right;margin-right: 10px;color:blue;"></span></li>--%>
                        <%--                            <li>备注<span class="layui-icon layui-icon-delete" style="float: right;margin-right: 10px;color: red"></span><span class="layui-icon layui-icon-set" style="float: right;margin-right: 10px;color:blue;"></span></li>--%>
                        <%--                            <li>流程状态<span class="layui-icon layui-icon-delete" style="float: right;margin-right: 10px;color: red"></span><span class="layui-icon layui-icon-set" style="float: right;margin-right: 10px;color:blue;"></span></li>--%>
                    </ul>
                    <form class="layui-form" action="">
                        <div class="where1" style="margin-top: 15px;">列表字段<span class="lie" style="margin-right: 13px;display: inline-block;margin-left: 120px;">全选<input name="like1[write]" value="全选"  title="" type="checkbox" lay-skin="primary"></span></div>

                        <ul class="you">
                            <li>拥有者<input name="like11[write]" flag="false" lay-filter="you" value="A"  title="" checked="" type="checkbox" lay-skin="primary"></li>
                            <li>所属部门<input name="like11[write]" flag="false" value="B" lay-filter="you" title="" checked="" type="checkbox" lay-skin="primary"></li>
                            <li>修改时间<input name="like11[write]" flag="false" value="C" lay-filter="you" title="" checked="" type="checkbox" lay-skin="primary"></li>
                            <li>合同类型<input name="like11[write]" flag="false" value="D" lay-filter="you" title="" checked="" type="checkbox" lay-skin="primary"></li>
                            <li>范本名称<input name="like11[write]" flag="false" value="E" lay-filter="you" title="" checked="" type="checkbox" lay-skin="primary"></li>
                            <li>范本编号<input name="like11[write]" flag="false" value="F" lay-filter="you" title="" checked="" type="checkbox" lay-skin="primary"></li>
                            <li>创建人<input name="like11[write]" flag="false" value="G" lay-filter="you"  title="" checked="" type="checkbox" lay-skin="primary"></li>
                            <li>创建时间<input name="like11[write]" flag="false" value="H" lay-filter="you"  title="" checked="" type="checkbox" lay-skin="primary"></li>
                            <li>备注<input name="like11[write]" flag="false" value="I" lay-filter="you"  title="" checked="" type="checkbox" lay-skin="primary"></li>
                            <li>流程状态<input name="like11[write]" flag="false" value="J" lay-filter="you"  title="" checked="" type="checkbox" lay-skin="primary"></li>
                            <li>单行文本1<input name="like11[write]" flag="false" value="K" lay-filter="you"  title="" checked="" type="checkbox" lay-skin="primary"></li>
                            <li>节点名称<input name="like11[write]" flag="false" value="L" lay-filter="you"  title="" checked="" type="checkbox" lay-skin="primary"></li>
                            <li>当前处理人<input name="like11[write]" flag="false" value="M" lay-filter="you"  title="" checked="" type="checkbox" lay-skin="primary"></li>
                            <li>日期<input name="like11[write]" flag="false" value="N" lay-filter="you"  title="" checked="" type="checkbox" lay-skin="primary"></li>
                        </ul>
                    </form>
                </div>
                <div class="layui-tab-item">

                    <form class="layui-form" action="" lay-filter="example">
<%--                        <div class="where1" style="margin-top: 15px;">可选显示模式</div>--%>
<%--                        <div class="layui-input-block where2" id="asd">--%>
<%--                            <li><input name="like1[read]" lay-filter="check" title="列表" type="checkbox" checked="" lay-skin="primary" value="列表"></li>--%>
<%--                            <li><input name="like1[read]" lay-filter="check" flag="false" title="日历" type="checkbox" lay-skin="primary" value="日历"></li>--%>
<%--                            <li><input name="like1[read]" lay-filter="check" flag="false" title="时间轴" type="checkbox" lay-skin="primary" value="时间轴"></li>--%>
<%--                            <li><input name="like1[read]" lay-filter="check" flag="false" title="甘特图" type="checkbox" lay-skin="primary" value="甘特图"></li>--%>
<%--                        </div>--%>
<%--                        <div class="where1" style="margin-top: 15px;">默认显示模式</div>--%>
<%--                        <div class="zxc">--%>
<%--                            <li id="web" style="border-bottom-left-radius: 4px;border-top-left-radius: 4px;background-color: rgb(16,127,255);color: white;margin-left: 5%;">Web端</li><li id="yidong" style="border-bottom-right-radius: 4px;border-top-right-radius: 4px;">移动端</li>--%>
<%--                        </div>--%>
<%--                        <div class="layui-input-block where2" id="asd1" style="margin-top: 20px;height: 125px;">--%>
<%--                            <li class="list1"><input lay-filter="ChoiceRadio" name="sex1" title="列表" type="radio" checked="" value="列表"><div id="ChoiceRadio1" style="background-color: rgb(16,127,255);width: 60px;height: 30px;line-height: 30px;text-align: center;color:white;border-radius: 4px;margin-top: 20px;">列表</div></li>--%>
<%--                            <li class="list2" style="display: none"><input lay-filter="ChoiceRadio" name="sex1" title="日历" type="radio" value="日历"><div id="ChoiceRadio2" style="background-color: #f4f8fc;width: 60px;height: 30px;line-height: 30px;text-align: center;color:black;border-radius: 4px;margin-top: 20px;">日历</div></li>--%>
<%--                            <li class="list3" style="display: none"><input lay-filter="ChoiceRadio" name="sex1" title="时间轴" type="radio" value="时间轴"><div id="ChoiceRadio3" style="background-color: #f4f8fc;width: 60px;height: 30px;line-height: 30px;text-align: center;color:black;border-radius: 4px;margin-top: 20px;">时间轴</div></li>--%>
<%--                            <li class="list4" style="display: none"><input lay-filter="ChoiceRadio" name="sex1" title="甘特图" type="radio" value="甘特图"><div id="ChoiceRadio4" style="background-color: #f4f8fc;width: 60px;height: 30px;line-height: 30px;text-align: center;color:black;border-radius: 4px;margin-top: 20px;">甘特图</div></li>--%>
<%--                        </div>--%>
<%--                        <div class="where1" style="">批量操作</div>--%>
<%--                        <div class="where2">--%>
<%--                            <li style="display: inline-block"><input name="sex2" title="允许" type="radio" checked="" value="女"></li>--%>
<%--                            <li style="display: inline-block"><input name="sex2" title="不允许" type="radio" value="女"></li>--%>
<%--                        </div>--%>

<%--                        <div class="where1" style="margin-top: 15px">排序字段</div>--%>
<%--                        <div class="layui-input-inline where2" style="width:90%">--%>
<%--                            <select name="parentGtypeId" id="parentGtypeId" class="oneDayPerDiem bian">--%>
<%--                                <option value="A">A</option>--%>
<%--                                <option value="B">B</option>--%>
<%--                                <option value="C">C</option>--%>
<%--                            </select>--%>
<%--                        </div>--%>
<%--                        <div class="where1" style="margin-top: 15px">排序方式</div>--%>
<%--                        <div class="where2">--%>
<%--                            <li style="display: inline-block"><input name="sex" title="降序" type="radio" checked="" value="女"></li>--%>
<%--                            <li style="display: inline-block"><input name="sex" title="升序" type="radio" value="女"></li>--%>
<%--                        </div>--%>

<%--                        <div class="where1" style="margin-top: 15px">功能按钮</div>--%>
<%--                        <div id="gong" style="width: 80%;height: 30px;border-radius: 4px;border: 1px solid rgb(212,215,244);text-align: center;line-height: 30px;margin-left: 9%;">设置功能按钮</div>--%>
                        <div style="margin: 20px 15px">
                            <div>
                                <span style="font-weight: 600;font-size: 14px;color: #304265">开启试图</span>
                                <div class="layui-collapse" lay-accordion="" style="margin-top: 10px;">
                                    <div class="layui-colla-item">
                                        <h2 class="layui-colla-title">列表视图</h2>
                                        <div class="layui-colla-content layui-show">
                                            <p>排序字段</p>
                                            <div style="margin-top: 5px;margin-bottom: 10px;">
                                                <select id="zhu" name="schoolTypes" class="schoolType noEdit" lay-verify="required" lay-search="" title="考勤类型">
                                                    <option value="">1</option>
                                                    <option value="">2</option>
                                                    <option value="">3</option>
                                                </select>
                                            </div>

                                            <p>排序方式</p>
                                            <div>
                                                <li style="display: inline-block"><input name="sex" title="降序" type="radio" checked="" value="女"></li>
                                                <li style="display: inline-block"><input name="sex" title="升序" type="radio" value="女"></li>
                                            </div>
                                        </div>
                                    </div>
<%--                                    <div class="layui-colla-item">--%>
<%--                                        <h2 class="layui-colla-title">日历视图</h2>--%>
<%--                                        <div class="layui-colla-content">--%>
<%--                                            <p>时间跨度</p>--%>
<%--                                            <div style="height: 30px;">--%>
<%--                                                <div class="moleft">从</div>--%>
<%--                                                <div class="moright">--%>
<%--                                                    <div>--%>
<%--                                                        <select id="2" name="schoolTypes" class="schoolType noEdit" lay-verify="required" lay-search="" title="考勤类型">--%>
<%--                                                            <option value="">1</option>--%>
<%--                                                            <option value="">2</option>--%>
<%--                                                            <option value="">3</option>--%>
<%--                                                        </select>--%>
<%--                                                    </div>--%>
<%--                                                </div>--%>
<%--                                            </div>--%>
<%--                                            <div style="height: 30px;margin-top: 15px;margin-bottom: 10px;">--%>
<%--                                                <div class="moleft">至</div>--%>
<%--                                                <div class="moright">--%>
<%--                                                    <div>--%>
<%--                                                        <select id="2" name="schoolTypes" class="schoolType noEdit" lay-verify="required" lay-search="" title="考勤类型">--%>
<%--                                                            <option value="">1</option>--%>
<%--                                                            <option value="">2</option>--%>
<%--                                                            <option value="">3</option>--%>
<%--                                                        </select>--%>
<%--                                                    </div>--%>
<%--                                                </div>--%>
<%--                                            </div>--%>
<%--                                        </div>--%>
<%--                                    </div>--%>
<%--                                    <div class="layui-colla-item">--%>
<%--                                        <h2 class="layui-colla-title">时间轴--%>
<%--&lt;%&ndash;                                            <div class="layui-input-block">&ndash;%&gt;--%>
<%--&lt;%&ndash;                                                <input name="open" type="checkbox" checked="" lay-filter="switchTest" lay-skin="switch" lay-text="">&ndash;%&gt;--%>
<%--&lt;%&ndash;                                            </div>&ndash;%&gt;--%>
<%--                                        </h2>--%>

<%--                                        <div class="layui-colla-content">--%>
<%--                                            <p>时间轴字段</p>--%>
<%--                                            <div style="margin-top: 5px;margin-bottom: 10px;">--%>
<%--                                                <select id="zhu" name="schoolTypes" class="schoolType noEdit" lay-verify="required" lay-search="" title="考勤类型">--%>
<%--                                                    <option value="">1</option>--%>
<%--                                                    <option value="">2</option>--%>
<%--                                                    <option value="">3</option>--%>
<%--                                                </select>--%>
<%--                                            </div>--%>
<%--                                            <p>排序方式</p>--%>
<%--                                            <div>--%>
<%--                                                <li style="display: inline-block"><input name="sex" title="降序" type="radio" checked="" value="女"></li>--%>
<%--                                                <li style="display: inline-block"><input name="sex" title="升序" type="radio" value="女"></li>--%>
<%--                                            </div>--%>
<%--                                        </div>--%>

<%--                                    </div>--%>
<%--                                    <div class="layui-colla-item">--%>
<%--                                        <h2 class="layui-colla-title">甘特图</h2>--%>
<%--                                        <div class="layui-colla-content">--%>
<%--                                            <p>时间设置</p>--%>
<%--                                            <div style="height: 30px;">--%>
<%--                                                <div class="moleft">开始日期</div>--%>
<%--                                                <div class="moright">--%>
<%--                                                    <div>--%>
<%--                                                        <select id="2" name="schoolTypes" class="schoolType noEdit" lay-verify="required" lay-search="" title="考勤类型">--%>
<%--                                                            <option value="">1</option>--%>
<%--                                                            <option value="">2</option>--%>
<%--                                                            <option value="">3</option>--%>
<%--                                                        </select>--%>
<%--                                                    </div>--%>
<%--                                                </div>--%>
<%--                                            </div>--%>
<%--                                            <div style="height: 30px;margin-top: 15px;margin-bottom: 15px;">--%>
<%--                                                <div class="moleft">结束日期</div>--%>
<%--                                                <div class="moright">--%>
<%--                                                    <div>--%>
<%--                                                        <select id="2" name="schoolTypes" class="schoolType noEdit" lay-verify="required" lay-search="" title="考勤类型">--%>
<%--                                                            <option value="">1</option>--%>
<%--                                                            <option value="">2</option>--%>
<%--                                                            <option value="">3</option>--%>
<%--                                                        </select>--%>
<%--                                                    </div>--%>
<%--                                                </div>--%>
<%--                                            </div>--%>
<%--                                            <ul class="shizhi">--%>
<%--                                                <li>--%>
<%--                                                    <p style="display: inline-block">多层级关系</p>--%>
<%--                                                    <div class="layui-input-block" style="display: inline-block;float: right">--%>
<%--                                                        <input name="open" type="checkbox" checked="" lay-filter="switchTest" lay-skin="switch" lay-text="">--%>
<%--                                                    </div>--%>
<%--                                                </li>--%>
<%--                                                <li>--%>
<%--                                                    <p style="display: inline-block">依赖关系</p>--%>
<%--                                                    <div class="layui-input-block" style="display: inline-block;float: right">--%>
<%--                                                        <input name="open" type="checkbox" checked="" lay-filter="switchTest" lay-skin="switch" lay-text="">--%>
<%--                                                    </div>--%>
<%--                                                </li>--%>
<%--                                                <li>--%>
<%--                                                    <p style="display: inline-block">完成进度</p>--%>
<%--                                                    <div class="layui-input-block" style="display: inline-block;float: right">--%>
<%--                                                        <input name="open" type="checkbox" checked="" lay-filter="switchTest" lay-skin="switch" lay-text="">--%>
<%--                                                    </div>--%>
<%--                                                </li>--%>
<%--                                                <li>--%>
<%--                                                    <p style="display: inline-block">颜色规则</p>--%>
<%--                                                    <div class="layui-input-block" style="display: inline-block;float: right">--%>
<%--                                                        <input name="open" type="checkbox" checked="" lay-filter="switchTest" lay-skin="switch" lay-text="">--%>
<%--                                                    </div>--%>
<%--                                                </li>--%>
<%--                                            </ul>--%>
<%--                                            <p>默认时间刻度</p>--%>
<%--                                            <div style="margin-top: 5px;margin-bottom: 10px;">--%>
<%--                                                <select id="zhu" name="schoolTypes" class="schoolType noEdit" lay-verify="required" lay-search="" title="考勤类型">--%>
<%--                                                    <option value="">1</option>--%>
<%--                                                    <option value="">2</option>--%>
<%--                                                    <option value="">3</option>--%>
<%--                                                </select>--%>
<%--                                            </div>--%>
<%--                                            <p>排序字段</p>--%>
<%--                                            <div style="margin-top: 5px;margin-bottom: 10px;">--%>
<%--                                                <select id="zhu" name="schoolTypes" class="schoolType noEdit" lay-verify="required" lay-search="" title="考勤类型">--%>
<%--                                                    <option value="">1</option>--%>
<%--                                                    <option value="">2</option>--%>
<%--                                                    <option value="">3</option>--%>
<%--                                                </select>--%>
<%--                                            </div>--%>
<%--                                            <p>排序方式</p>--%>
<%--                                            <div>--%>
<%--                                                <li style="display: inline-block"><input name="sex" title="降序" type="radio" checked="" value="女"></li>--%>
<%--                                                <li style="display: inline-block"><input name="sex" title="升序" type="radio" value="女"></li>--%>
<%--                                            </div>--%>
<%--                                        </div>--%>
<%--                                    </div>--%>
                                </div>
                            </div>
<%--                            <div id="liemo">--%>
<%--                                <span style="font-weight: 600;font-size: 14px;color: #304265;display: inline-block;margin-top: 15px;">默认显示</span>--%>
<%--                                <div>--%>
<%--                                    <div style="height: 30px;">--%>
<%--                                        <div class="moleft">电脑端</div>--%>
<%--                                        <div class="moright">--%>
<%--                                            <div>--%>
<%--                                                <select id="2" name="schoolTypes" class="schoolType noEdit" lay-verify="required" lay-search="" title="考勤类型">--%>
<%--                                                    <option value="">1</option>--%>
<%--                                                    <option value="">2</option>--%>
<%--                                                    <option value="">3</option>--%>
<%--                                                </select>--%>
<%--                                            </div>--%>
<%--                                        </div>--%>
<%--                                    </div>--%>
<%--                                    <div style="height: 30px;margin-top: 10px;">--%>
<%--                                        <div class="moleft">手机端</div>--%>
<%--                                        <div class="moright">--%>
<%--                                            <div>--%>
<%--                                                <select id="1" name="schoolTypes" class="schoolType noEdit" lay-verify="required" lay-search="" title="考勤类型">--%>
<%--                                                    <option value="">1</option>--%>
<%--                                                    <option value="">2</option>--%>
<%--                                                    <option value="">3</option>--%>
<%--                                                </select>--%>
<%--                                            </div>--%>
<%--                                        </div>--%>
<%--                                    </div>--%>
<%--                                </div>--%>
<%--                            </div>--%>
                            <div style="margin-top: 20px">
                                <span style="font-weight: 600;font-size: 14px;color: #304265">批量操作（仅列表、日历可用）</span>
                                <div>
                                    <li style="display: inline-block"><input name="sex" title="允许" type="radio" checked="" value="女"></li>
                                    <li style="display: inline-block"><input name="sex" title="不允许" type="radio" value="女"></li>
                                </div>
                            </div>
                            <div>
                                <span style="font-weight: 600;font-size: 14px;color: #304265">功能按钮</span>
                                <p id="gong" style="color:rgb(16,127,255);">设置</p>
                            </div>
                        </div>
                    </form>
                </div>
            </div>
        </div>

    </div>
</div>
</body>
<script>
    // window.onbeforeunload = function (e) {
    //     var e = e || window.event,
    //         dialogText = '页面未保存，确定离开吗？';
    //     // 兼容IE8和Firefox 4之前的版本
    //     if (e) {
    //         e.returnValue = dialogText;
    //     };
    //     return dialogText;
    // };
    window.onbeforeunload=function(){//必须使用beforeunload
        var url ="device_saveDeviceStatus";
        $.ajax({
            url:url,
            async:false                //必须采用同步方法
        });
    }
    var datass = [];
    var strs = '';

    var typeList = [
        {value:'拥有者',type:'choose'},
        {value:'所属部门',type:'choose'},
        {value:'创建时间',type:'time'},
        {value:'修改时间',type:'time'},
        {value:'合同类型',type:'input'},
        {value:'单行文本1',type:'input'},
        {value:'范本名称',type:'input'},
        {value:'范本编号',type:'input'},
        {value:'备注',type:'input'},
        {value:'日期',type:'time'},
        {value:'创建人',type:'choose'},
        {value:'流程状态',type:'input'},
    ];

    layui.use(['form', 'table', 'element', 'layedit','eleTree','upload','laydate'], function () {
        var laydate = layui.laydate;
        var table = layui.table
        var form = layui.form
        var element = layui.element
        var layedit = layui.layedit
        var eleTree = layui.eleTree;
        var upload = layui.upload;
        var sum=0;
        var asd =0;
        var datas = '';
        layui.element.render('collapse')
        var tableData = [
            {
                "A": "1",
                "B": "人力资源服务合同 D35263",
                "C": "C",
                "D": "人力资源服务合同",
                "E": "D35263",
                "F": "131****2219",
                "G": "2021-12-23 14:37:04",
                "H": " 已结束"
            },
            {
                "A": "2",
                "B": "新奥尔良租凭合同 AS1749058",
                "C": "A",
                "D": "新奥尔良租凭合同",
                "E": "AS1749058",
                "F": "133****2219",
                "G": "2021-12-23 14:37:04",
                "H": " 已结束"
            },
            {
                "A": "3",
                "B": "奥来克产品采购合同 CG001",
                "C": "B",
                "D": "奥来克产品采购合同",
                "E": "CG001",
                "F": "149****2219",
                "G": "2021-12-23 14:37:04",
                "H": " 已结束"
            },
            {
                "A": "4",
                "B": "中外合作公司合同 HZ0009",
                "C": "C",
                "D": "中外合作公司合同",
                "E": "HZ0009",
                "F": "134****2219",
                "G": "2021-12-23 14:37:04",
                "H": " 已结束"
            },
            {
                "A": "5",
                "B": "成都信息科技劳务合同 X197403",
                "C": "C",
                "D": "成都信息科技劳务合同",
                "E": "X197403",
                "F": "139****2819",
                "G": "2021-12-23 14:37:04",
                "H": " 已结束",
                "I": " 已结束"
            }
        ];

        //固定列二维数组
        var col = [[
            // {type:'checkbox'}
            // ,{field: "name", title: "序号"}
            // , {field: "age", title: "数据标题"}
            // , {field: "class", title: "合同类型"}
        ]];
        //动态列
        var subjectField = ["A", "B", "C","D",'E','F','G','H','I','J','K','L','M','N'];
        var subjectTitle = ["拥有者", "所属部门", "修改时间","合同类型","范本名称","范本编号","创建人","创建时间",'备注','流程状态','单行文本1','节点名称','当前处理人','日期'];

        //给tableData动态添加数据
        //         for (var i = 0; i < subjectField.length; ++i) {
        //             for (var j = 0; j < tableData.length; ++j) {
        //                 tableData[j][subjectField[i]] = Math.floor((Math.random()*100)+1);
        //             }
        //         }
        //动态添加列属性
        for (var i = 0; i < subjectField.length; ++i) {
            //向数组插入元素：splice(index, howmany, items...)
            //index要插入的位置
            //howmany从该位置删除多少项元素
            //items要插入的元素
            //col[0],注意col是二维数组
            col[0].splice(col[0].length, 0, {field: subjectField[i], title: subjectTitle[i]});
        }
        // var data = json.data
        // xmSelect.render({
        // el: '#parentGtypeIds',
        // toolbar:{
        // show: true,
        // },
        // filterable: true,
        // height: '500px',
        // data: [
        // // {name: '销售员', children: [
        // //         {name: '张三1', value: 1, selected: true},
        // //         {name: '李四1', value: 2, selected: true},
        // //         {name: '王五1', value: 3, disabled: true},
        // // ]},
        // {name: '合同类型', children: [
        // {name: 'A', value: 1,},
        // {name: 'B', value: 2,},
        // {name: 'C', value: 3,},
        // ]},
        // ]
        //
        // });
        //日期时间范围
        laydate.render({
            elem: '#timeRange'
            , type: 'datetime'
            , range: '~'
            ,format: 'yyyy年MM月dd日'
        });
        //日期时间范围
        laydate.render({
            elem: '#timeRanges'
            , type: 'datetime'
            , range: '~'
            ,format: 'yyyy年MM月dd日'
        });
        form.render()
        // 支委会会议记录表格
        var meetTable=table.render({
            elem: '#test'
            , url: '/branchCommitteeMeeting/queryList'
            // , toolbar: '#toolbarDemo' //开启头部工具栏，并为其绑定左侧模板
            , defaultToolbar: ['filter', 'exports', 'print', { //自定义头部工具栏右侧图标。如无需自定义，去除该参数即可
                title: '提示'
                , layEvent: 'LAYTABLE_TIPS'
                , icon: 'layui-icon-tips'
            }]
            , title: '用户数据表'
            ,cellMinWidth:111
            , cols: col
            //     [[
            //     {type:'checkbox'}
            //     ,{field: 'A', title: '序号', sort:true, width:90}
            //     ,{field: 'B', title: '数据标题',  sort:true,minWidth:430,event:'shu'}
            //     , {field: 'C', title: '合同类型',  sort:true, width:117}
            //     , {field: 'D', title: '范本名称',  sort:true,minWidth:430}
            //     , {field: 'E', title: '范本编号', sort:true}
            //     , {field: 'F', title: '创建人',  sort:true,event:'creatUser'}
            //     , {field: 'G', title: '创建时间', sort:true}
            //     , {field: 'H', title: '流程状态', sort:true}
            //     , {field: 'I', title: '流程状态', sort:true}
            // ]]
            , parseData: function (res) { //res 即为原始返回的数据
                // var data = json.obj
                return {
                    "code": 0, //解析接口状态
                    "msg": res.msg, //解析提示文本
                    "count": res.totleNum, //解析数据长度
                    "data": tableData, //解析数据列表
                };
            }
            ,done:function(res){
                $("table").css("width","100%")
            }
            , page: true
        })
        $(document).on("click", "#creat", function () {
            org_id="creat";
            $.popWindow("../common/selectPartyMember?0");
        })
        $(document).on("click", "#have", function () {
            org_id="have";
            $.popWindow("../common/selectPartyMember?0");
        })
        $('#dept').click(function () {
            dept_id = 'dept';
            $.popWindow("../common/selectDept?0&eduOrg=1");
        });
        $(document).on('click','#gong',function(){
            layer.open({
                type: 1,
                area: ['40%', '60%'], //宽高
                title: ['设置功能按钮','font-size:20px'],
                maxmin: false,
                btn: ['取&nbsp&nbsp消','确&nbsp&nbsp定'], //可以无限个按钮
                content: '<div style="margin: 43px auto;">' +
                    '   <form class="layui-form" action="">\n' +
                    // '<p class="layui-icon layui-icon-add-1" id="addss" style="color:rgb(61,151,255);"><span style="color: rgb(137,137,137)">新增</span></p>\n'+
                    '<div class="anniu">' +
                    // '<li class="layui-icon layui-icon-add-1">新增</li><li class="layui-icon layui-icon-download-circle">导入</li><li class="layui-icon layui-icon-export">导出</li><li class="layui-icon layui-icon-delete" id="del">删除</li><li class="layui-icon layui-icon-print">打印二维码</li>\n' +
                    '<li class="layui-icon layui-icon-add-1">新增</li><li class="layui-icon layui-icon-download-circle">导入</li><li class="layui-icon layui-icon-export">导出</li><li class="layui-icon layui-icon-delete" id="del">删除</li>\n' +
                    '</div>\n' +
                    '   </form>\n' +
                    '</div>',
                success: function () {

                },
                yes: function (index, layero) {
                    layer.close(index);
                },
                btn2:function(){

                }
            });
        })

        $(document).on('click','#web',function(){
            $("#web").css('background-color','rgb(16,127,255)')
            $("#web").css('color','white')
            $("#yidong").css('background-color','white')
            $("#yidong").css('color','black')
        })
        $(document).on('click','#yidong',function(){
            $("#yidong").css('background-color','rgb(16,127,255)')
            $("#yidong").css('color','white')
            $("#web").css('background-color','white')
            $("#web").css('color','black')
        })
        form.on('radio(ChoiceRadio)', function(data){
            var data = data.value
            // console.log(data); //被点击的 radio 的 value 值
            if(data == '列表'){
                $("#ChoiceRadio1").css('background-color','rgb(16,127,255)')
                $("#ChoiceRadio1").css('color','white')
                $("#ChoiceRadio2").css('background-color','#f4f8fc')
                $("#ChoiceRadio2").css('color','black')
                $("#ChoiceRadio3").css('background-color','#f4f8fc')
                $("#ChoiceRadio3").css('color','black')
                $("#ChoiceRadio4").css('background-color','#f4f8fc')
                $("#ChoiceRadio4").css('color','black')
            }else if(data == '日历'){
                $("#ChoiceRadio2").css('background-color','rgb(16,127,255)')
                $("#ChoiceRadio2").css('color','white')
                $("#ChoiceRadio1").css('background-color','#f4f8fc')
                $("#ChoiceRadio1").css('color','black')
                $("#ChoiceRadio3").css('background-color','#f4f8fc')
                $("#ChoiceRadio3").css('color','black')
                $("#ChoiceRadio4").css('background-color','#f4f8fc')
                $("#ChoiceRadio4").css('color','black')
            }else if(data == '时间轴'){
                $("#ChoiceRadio3").css('background-color','rgb(16,127,255)')
                $("#ChoiceRadio3").css('color','white')
                $("#ChoiceRadio2").css('background-color','#f4f8fc')
                $("#ChoiceRadio2").css('color','black')
                $("#ChoiceRadio1").css('background-color','#f4f8fc')
                $("#ChoiceRadio1").css('color','black')
                $("#ChoiceRadio4").css('background-color','#f4f8fc')
                $("#ChoiceRadio4").css('color','black')
            }else if(data == '甘特图'){
                $("#ChoiceRadio4").css('background-color','rgb(16,127,255)')
                $("#ChoiceRadio4").css('color','white')
                $("#ChoiceRadio2").css('background-color','#f4f8fc')
                $("#ChoiceRadio2").css('color','black')
                $("#ChoiceRadio3").css('background-color','#f4f8fc')
                $("#ChoiceRadio3").css('color','black')
                $("#ChoiceRadio1").css('background-color','#f4f8fc')
                $("#ChoiceRadio1").css('color','black')
            }
        });
        form.on('checkbox(check)', function(data){
            var data = data.value
            var flag = $(this).attr('flag')
            if(flag == 'false'){
                if(data == '日历'){
                    $(".list2").show()
                }
                if(data == '时间轴'){
                    $(".list3").show()
                }
                if(data == '甘特图'){
                    $(".list4").show()
                }
                $(this).attr('flag','true')
            }else {
                if(data == '日历'){
                    $(".list2").hide()
                }
                if(data == '时间轴'){
                    $(".list3").hide()
                }
                if(data == '甘特图'){
                    $(".list4").hide()
                }
                $(this).attr('flag','false')
            }

        })
        $(document).on('click','#condition',function(){
            if(asd == 0){
                $('#yous').show()
                asd = 1
            }else if(asd == 1){
                $('#yous').hide()
                asd =0
            }

        })
        form.on('checkbox(yous)',function(data){
            $('.action').hide()
            var type = $(data.elem).attr('data-type')
            var flag = $(data.elem).attr('flag')

            //全选
            if(type == 'all'){
                var strr = ''
                var str1 = ''
                var child = $("#youss input[type='checkbox']");
                child.each(function (index, item) {
                    item.checked = data.elem.checked;
                });
                form.render('checkbox');
                //获取checkbox[name='like']的值
                var arrs = new Array();
                $("input:checkbox[name='like1[write]']:checked").each(function(i){
                    datass[i] = $(this).val();
                    arrs[i] = $(this).attr('data-type')
                });
                datass.splice(0,1)
                arrs.splice(0,1)
                if(flag == 'false'){
                    //全选创建右侧列表
                    if(datass != undefined || datass != ''){
                        for (var i=0;i<datass.length;i++){
                            strr+='<li>'+datass[i]+'<span class="layui-icon layui-icon-delete del" style="float: right;margin-right: 10px;color: red"></span><span class="layui-icon layui-icon-set" style="float: right;margin-right: 10px;color:blue;"></span></li>'
                        }
                        if(strr == undefined){
                            strr = ''
                        }
                        $('#you').html(strr)
                    }
                    // data.field.like = arr.join(",");//将数组合并成字符串
                    // console.log(data.field.like)
                    //全选创建左侧元素
                    for(var j=0;j<datass.length;j++){
                        if(arrs[j] == 'choose'){
                            str1 += '<li><span style="display: inline-block;width: 20%;font-weight: bold;">'+datass[j]+'</span><div style="width: 80%;display: inline-block"><input placeholder="点击选择'+datass[j]+'" type="text" id="creat" style="" name=""  lay-verify="required|phone" autocomplete="off" class="layui-input"></div></li>'
                            $('#leftYou').html(str1)
                        }else if (arrs[j] == 'time'){
                            str1 += '<li><span style="display: inline-block;width: 20%;font-weight: bold;">'+datass[j]+'</span><div style="width: 80%;display: inline-block"><input id="timeRange" type="text" style="" name=""  lay-verify="required|phone" autocomplete="off" class="layui-input"></div></li>'
                            $('#leftYou').html(str1)
                        }else if(arrs[j] == 'input'){
                            str1 += '<li><span style="display: inline-block;width: 20%;font-weight: bold;">'+datass[j]+'</span><div style="width: 80%;display: inline-block"><input type="text" style="" name=""  lay-verify="required|phone" autocomplete="off" class="layui-input"></div></li>'
                            $('#leftYou').html(str1)
                        }
                    }
                    // $(this).attr('flag','true')
                    $("#youss li input").attr('flag','true')
                }else{
                    $("#leftYou  li").remove()
                    $("#you li").remove()
                    // $(this).attr('flag','false')
                    $("#youss li input").attr('flag','false')
                    $('.action').show()
                    datass.length = 0
                }
            }else{
                var res = data.value
                // console.log('res',res)
                // console.log('data',data)
                if(flag == 'false'){
                    datass.push(data.value)
                    var str=''

                    // datas += data.value + ','
                    // var str=''
                    // datass = datas.split(',')
                    // datass.splice(-1,1)
                }else{
                    // for(var l = 0;l<datass.length;l++){
                    //     if (datass[l] == res){
                    //         delete datass[l]
                    //         var b = datass.toString()
                    //         console.log(b)
                    //         datas = b
                    //     }
                    // }
                    var index = datass.indexOf(res)
                    datass.splice(index,1)
                }

                if(flag == 'false'){
                    //添加右侧列表
                    if(data != undefined || data != ''){
                        var templateStr = ''
                        for (var i=0;i<datass.length;i++){
                            if(datass[i] == ''){

                            }else{
                                str+='<li name="'+datass[i]+'">'+datass[i]+'<span class="layui-icon layui-icon-delete" id="del" style="float: right;margin-right: 10px;color: red"></span><span class="layui-icon layui-icon-set" style="float: right;margin-right: 10px;color:blue;"></span></li>'
                            }
                        }
                        $('#you').html(str)
                    }
                    // 添加左侧元素
                    var templateStr = ''
                    for(var i = 0;i<datass.length;i++){
                        var nowType;
                        typeList.forEach(function(item,index,arr){
                            if(item.value == datass[i]){
                                nowType = item.type
                            }
                        })
                        if(nowType == 'choose'){
                            templateStr += '<li name="'+res+'"><span style="display: inline-block;width: 20%;font-weight: bold;">'+ datass[i] +'</span><div style="width: 80%;display: inline-block"><input placeholder="点击选择'+data.value+'" type="text" id="creat" style="" name=""  lay-verify="required|phone" autocomplete="off" class="layui-input"></div></li>'
                            // $('#leftYou').html(strs)
                        }else if (nowType == 'time'){
                            templateStr += '<li name="'+res+'"><span style="display: inline-block;width: 20%;font-weight: bold;">'+datass[i]+'</span><div style="width: 80%;display: inline-block"><input id="timeRange" type="text" style="" name=""  lay-verify="required|phone" autocomplete="off" class="layui-input"></div></li>'
                            // $('#leftYou').html(strs)
                        }else if(nowType == 'input'){
                            templateStr += '<li name="'+res+'"><span style="display: inline-block;width: 20%;font-weight: bold;">'+datass[i]+'</span><div style="width: 80%;display: inline-block"><input type="text" style="" name=""  lay-verify="required|phone" autocomplete="off" class="layui-input"></div></li>'
                            // $('#leftYou').html(strs)
                        }
                        $('#leftYou').html(templateStr)
                    }
                    // if(type == 'choose'){
                    //     strs += '<li name="'+res+'">' +
                    //             '   <span style="display: inline-block;width: 20%;font-weight: bold;">'+data.value+'</span>' +
                    //             '   <div style="width: 80%;display: inline-block">' +
                    //             '       <input placeholder="点击选择'+data.value+'" type="text" id="creat" style="" name=""  lay-verify="required|phone" autocomplete="off" class="layui-input">' +
                    //             '   </div>' +
                    //             '</li>'
                    //     $('#leftYou').html(strs)
                    // }else if (type == 'time'){
                    //     strs += '<li name="'+res+'">' +
                    //             '   <span style="display: inline-block;width: 20%;font-weight: bold;">'+data.value+'</span>' +
                    //             '   <div style="width: 80%;display: inline-block">' +
                    //             '       <input id="timeRange" type="text" style="" name=""  lay-verify="required|phone" autocomplete="off" class="layui-input">' +
                    //             '   </div>' +
                    //             '</li>'
                    //     $('#leftYou').html(strs)
                    // }else if(type == 'input'){
                    //     strs += '<li name="'+res+'">' +
                    //             '   <span style="display: inline-block;width: 20%;font-weight: bold;">'+data.value+'</span>' +
                    //             '   <div style="width: 80%;display: inline-block">' +
                    //             '       <input type="text" style="" name=""  lay-verify="required|phone" autocomplete="off" class="layui-input">' +
                    //             '   </div>' +
                    //             '</li>'
                    //     $('#leftYou').html(strs)
                    // }
                    $(this).attr('flag','true')
                }else if(flag == 'true'){
                    $(this).attr('flag','false')
                    var liStr = ''
                    if(datass.length == '0'){
                        $("#leftYou li").remove()
                    }
                    for (var i=0;i<datass.length;i++){
                        if(datass[i] == ''){

                        }else{
                            liStr+='<li name="'+datass[i]+'">'+datass[i]+'<span class="layui-icon layui-icon-delete" id="del" style="float: right;margin-right: 10px;color: red"></span><span class="layui-icon layui-icon-set" style="float: right;margin-right: 10px;color:blue;"></span></li>'
                        }
                    }
                    $('#you').html(liStr)

                    var templateStr = ''
                    for(var i = 0;i<datass.length;i++){
                        var nowType;
                        typeList.forEach(function(item,index,arr){
                            if(item.value == datass[i]){
                                nowType = item.type
                            }
                        })
                        if(nowType == 'choose'){
                            templateStr += '<li name="'+res+'"><span style="display: inline-block;width: 20%;font-weight: bold;">'+ datass[i] +'</span><div style="width: 80%;display: inline-block"><input placeholder="点击选择'+datass[i]+'" type="text" id="creat" style="" name=""  lay-verify="required|phone" autocomplete="off" class="layui-input"></div></li>'
                        }else if (nowType == 'time'){
                            templateStr += '<li name="'+res+'"><span style="display: inline-block;width: 20%;font-weight: bold;">'+datass[i]+'</span><div style="width: 80%;display: inline-block"><input id="timeRange" type="text" style="" name=""  lay-verify="required|phone" autocomplete="off" class="layui-input"></div></li>'
                        }else if(nowType == 'input'){
                            templateStr += '<li name="'+res+'"><span style="display: inline-block;width: 20%;font-weight: bold;">'+datass[i]+'</span><div style="width: 80%;display: inline-block"><input type="text" style="" name=""  lay-verify="required|phone" autocomplete="off" class="layui-input"></li>'
                        }
                        $('#leftYou').html(templateStr)
                    }
                    if(datass.length == '0'){
                        $('.action').show()
                    }
                }

            }

        })
        form.on('checkbox(you)',function(data){
            var type = $(data.elem).attr('value')
            var flag = $(data.elem).attr('flag')
            if(flag == 'false'){
                $("[data-field="+type+"]").hide()
                $(this).attr('flag','true')
            }else if(flag == 'true'){
                $("[data-field="+type+"]").show()
                $(this).attr('flag','false')
            }

        })
        // $(document).on('click','#del',function(){
        //     var data = $(this).parent("li").text()
        //     var index = datass.indexOf(data)
        //     datass.splice(index,1)
        //     var liStr = ''
        //     if(datass.length == '0'){
        //         $("#leftYou li").remove()
        //     }
        //     for (var i=0;i<datass.length;i++){
        //         if(datass[i] == ''){
        //
        //         }else{
        //             liStr+='<li name="'+datass[i]+'">'+datass[i]+'<span class="layui-icon layui-icon-delete" id="del" style="float: right;margin-right: 10px;color: red"></span><span class="layui-icon layui-icon-set" style="float: right;margin-right: 10px;color:blue;"></span></li>'
        //         }
        //     }
        //     $('#you').html(liStr)
        //
        //     var templateStr = ''
        //     for(var i = 0;i<datass.length;i++){
        //         var nowType;
        //         typeList.forEach(function(item,index,arr){
        //             if(item.value == datass[i]){
        //                 nowType = item.type
        //             }
        //         })
        //         if(nowType == 'choose'){
        //             templateStr += '<li name="'+res+'"><span style="display: inline-block;width: 20%;font-weight: bold;">'+ datass[i] +'</span><div style="width: 80%;display: inline-block"><input placeholder="点击选择'+datass[i]+'" type="text" id="creat" style="" name=""  lay-verify="required|phone" autocomplete="off" class="layui-input"></div></li>'
        //         }else if (nowType == 'time'){
        //             templateStr += '<li name="'+res+'"><span style="display: inline-block;width: 20%;font-weight: bold;">'+datass[i]+'</span><div style="width: 80%;display: inline-block"><input id="timeRange" type="text" style="" name=""  lay-verify="required|phone" autocomplete="off" class="layui-input"></div></li>'
        //         }else if(nowType == 'input'){
        //             templateStr += '<li name="'+res+'"><span style="display: inline-block;width: 20%;font-weight: bold;">'+datass[i]+'</span><div style="width: 80%;display: inline-block"><input type="text" style="" name=""  lay-verify="required|phone" autocomplete="off" class="layui-input"></li>'
        //         }
        //         $('#leftYou').html(templateStr)
        //     }
        //     if(datass.length == '0'){
        //         $('.action').show()
        //     }
        // })
    });

    function createTem(){

    }
    $(document).on('click','.del',function(res){
        var $this = $(this)
        var data = $this.parent()
        var index = datass.indexOf(data.text())
        var flag = $(res.elem).attr('flag')
        datass.splice(index,1)
            $(this).attr('flag','false')
            var liStr = ''
            if(datass.length == '0'){
                $("#leftYou li").remove()
            }
            for (var i=0;i<datass.length;i++){
                if(datass[i] == ''){

                }else{
                    liStr+='<li name="'+datass[i]+'">'+datass[i]+'<span class="layui-icon layui-icon-delete" id="del" style="float: right;margin-right: 10px;color: red"></span><span class="layui-icon layui-icon-set" style="float: right;margin-right: 10px;color:blue;"></span></li>'
                }
            }
            $('#you').html(liStr)

            var templateStr = ''
            for(var i = 0;i<datass.length;i++){
                var nowType;
                typeList.forEach(function(item,index,arr){
                    if(item.value == datass[i]){
                        nowType = item.type
                    }
                })
                if(nowType == 'choose'){
                    templateStr += '<li name="'+res+'"><span style="display: inline-block;width: 20%;font-weight: bold;">'+ datass[i] +'</span><div style="width: 80%;display: inline-block"><input placeholder="点击选择'+datass[i]+'" type="text" id="creat" style="" name=""  lay-verify="required|phone" autocomplete="off" class="layui-input"></div></li>'
                }else if (nowType == 'time'){
                    templateStr += '<li name="'+res+'"><span style="display: inline-block;width: 20%;font-weight: bold;">'+datass[i]+'</span><div style="width: 80%;display: inline-block"><input id="timeRange" type="text" style="" name=""  lay-verify="required|phone" autocomplete="off" class="layui-input"></div></li>'
                }else if(nowType == 'input'){
                    templateStr += '<li name="'+res+'"><span style="display: inline-block;width: 20%;font-weight: bold;">'+datass[i]+'</span><div style="width: 80%;display: inline-block"><input type="text" style="" name=""  lay-verify="required|phone" autocomplete="off" class="layui-input"></li>'
                }
                $('#leftYou').html(templateStr)
            }
            if(datass.length == '0'){
                $('.action').show()
            }
    })

</script>
</html>