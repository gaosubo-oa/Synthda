<%--
  Created by IntelliJ IDEA.
  User: 高速波办公
  Date: 2021/11/29
  Time: 22:31
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="UTF-8">
    <title>表单设计</title>

    <meta name="renderer" content="ie-stand">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta http-equiv="Content-Type" content="text/html;">
    <meta name="viewport" content="width=device-width, initial-scale=0.3, user-scalable=0, minimum-scale=0, maximum-scale=5.0,user-scalable=yes">
    <meta name="apple-mobile-web-app-capable" content="yes">
    <meta name="apple-mobile-web-app-status-bar-style" content="black">
    <link rel="stylesheet" href="/css/gapp/design/form_design.css?20230422.1">
    <link rel="stylesheet" href="/css/gapp/design/city-picker.css">
    <link rel="stylesheet" type="text/css" href="/lib/layui/layui/css/layui.css"/>

    <script type="text/javascript"  src="/js/common/language.js"></script>
    <script src="/js/xoajq/xoajq3.js" type="text/javascript" charset="utf-8"></script>

    <script type="text/javascript" src="/lib/gapp/jquerygridly.js"></script>
    <script type="text/javascript" src="/lib/gapp/jquery.dragsort.js"></script>

    <script type="text/javascript"  src="/js/jquery/jquery.cookie.js"></script>
    <script type="text/javascript"  src="/lib/layer/layer.js?20201106"></script>
    <script type="text/javascript" src="/lib/layui/layui/lay/mymodules/xm-select.js"></script>
    <style>
        .jiantou_bottom{
            position: absolute;
            width: 15px;
            height: 15px;
            border-top: 4px solid #333;
            border-right: 4px solid #333;
            transform:rotate(135deg);
        }
    </style>

</head>
<body onselectstart="return false;">
<div class="layui-tab layui-tab-brief" lay-filter="docDemoTabBrief">
    <span style="font-size: 18px;display: inline-block;position: absolute;top: 14px;left: 10px">应用名称:</span>
    <input type="text" id="tabName" style="margin-left: 45px">
    <ul class="layui-tab-title">
        <li class="layui-this">表单设计</li>
        <li>流程设计(开发中...)</li>
        <li>列表设计</li>

        <li>应用设置</li>
    </ul>
    <div id="Confidential" style="display: inline-block"></div>
    <div class="layui-tab-content" >
        <p id="colDes"></p>

    <%--            提示框--%>
        <p id="tips"></p>

            <div class="layui-tab-item layui-show">
            <%-- 头部保存bar --%>
            <div id="header">
                <span>可视化表单设计</span>
                <div class="save" id="save"><img src="/ui/img/gapp/save.png" alt=""> 保存</div>
            </div>
            <div class="body" >
                <%--    选择控件    --%>
                <div id="chooses">
                    <div>
                        <div>
                            <div class="title">
                                <span>基础控件</span>
                            </div>
                            <ul class="control">
                                <li class="item" draggable="true" data-type="C01"><img src="/ui/img/gapp/singleline.svg" alt=""><span>单行文本</span><span class="add"><img class="icon-add" src="/ui/img/gapp/addCA.svg" alt=""></span></li>
                                <li class="item" draggable="true" data-type="C02"><img src="/ui/img/gapp/multiline.svg" alt=""><span>多行文本</span><span class="add"><img class="icon-add" src="/ui/img/gapp/addCA.svg" alt=""></span></li>
                                <li class="item" draggable="true" data-type="C03"><img src="/ui/img/gapp/date.svg" alt=""><span>日期</span><span class="add"><img class="icon-add" src="/ui/img/gapp/addCA.svg" alt=""></span></li>
                                <li class="item" draggable="true" data-type="C04"><img src="/ui/img/gapp/number.svg" alt=""><span>数字</span><span class="add"><img class="icon-add" src="/ui/img/gapp/addCA.svg" alt=""></span></li>
                                <li class="item" draggable="true" data-type="C05"><img src="/ui/img/gapp/radio.svg" alt=""><span>单选框</span><span class="add"><img class="icon-add" src="/ui/img/gapp/addCA.svg" alt=""></span></li>
                                <li class="item" draggable="true" data-type="C06"><img src="/ui/img/gapp/checkbox.svg" alt=""><span>复选框</span><span class="add"><img class="icon-add" src="/ui/img/gapp/addCA.svg" alt=""></span></li>
                                <li class="item" draggable="true" data-type="C07"><img src="/ui/img/gapp/select.svg" alt=""><span>下拉框</span><span class="add"><img class="icon-add" src="/ui/img/gapp/addCA.svg" alt=""></span></li>
                                <li class="item" draggable="true" data-type="C16"><img src="/ui/img/gapp/switch.svg" alt=""><span>是/否</span><span class="add"><img class="icon-add" src="/ui/img/gapp/addCA.svg" alt=""></span></li>
                                <li class="item" draggable="true" data-type="C08"><img src="/ui/img/gapp/annex.svg" alt=""><span>附件</span><span class="add"><img class="icon-add" src="/ui/img/gapp/addCA.svg" alt=""></span></li>
                                <li class="item" draggable="true" data-type="C09"><img src="/ui/img/gapp/picture.svg" alt=""><span>图片</span><span class="add"><img class="icon-add" src="/ui/img/gapp/addCA.svg" alt=""></span></li>
<%--                                <li class="item" draggable="true" data-type="C10"><img src="/ui/img/gapp/peopleOnly.svg" alt=""><span>人员单选</span><span class="add"><img class="icon-add" src="/ui/img/gapp/addCA.svg" alt=""></span></li>--%>
<%--                                <li class="item" draggable="true" data-type="C11"><img src="/ui/img/gapp/personToo.svg" alt=""><span>人员多选</span><span class="add"><img class="icon-add" src="/ui/img/gapp/addCA.svg" alt=""></span></li>--%>
<%--                                <li class="item" draggable="true" data-type="bmdanx"><img src="/ui/img/gapp/departmentOnly.svg" alt=""><span>部门单选</span><span class="add"><img class="icon-add" src="/ui/img/gapp/addCA.svg" alt=""></span></li>--%>
<%--                                <li class="item" draggable="true" data-type="bmduox"><img src="/ui/img/gapp/departmentToo.svg" alt=""><span>部门多选</span><span class="add"><img class="icon-add" src="/ui/img/gapp/addCA.svg" alt=""></span></li>--%>
                            </ul>
                        </div>
                        <div>
                            <div class="title">
                                <span>布局控件</span>
                            </div>
                            <ul class="control">
                                <li class="item" draggable="true" data-type="L02"><img src="/ui/img/gapp/title.svg" alt=""><span>分组控件</span><span class="add"><img class="icon-add" src="/ui/img/gapp/addCA.svg" alt=""></span></li>
                                <li class="item" draggable="true" data-type="L01"><img src="/ui/img/gapp/columns.svg" alt=""><span>行列控件</span><span class="add"><img class="icon-add" src="/ui/img/gapp/addCA.svg" alt=""></span></li>
<%--                                <li class="item" draggable="true"><img src="/ui/img/gapp/explain.svg" alt=""><span>描述说明</span><span class="add"><img class="icon-add" src="/ui/img/gapp/addCA.svg" alt=""></span></li>--%>
                                <li style="width: 100%;" class="item" draggable="true" data-type="L03"><img src="/ui/img/gapp/subTable.svg" alt=""><span>表单子表(开发中...)</span><span class="add"><img class="icon-add" src="/ui/img/gapp/addCA.svg" alt=""></span></li>
                            </ul>
                        </div>
                        <div>
                            <div class="title">
                                <span>系统控件</span>
                            </div>
                            <ul class="control">
                                <li class="item" draggable="true" data-type="S06"><img src="/ui/img/gapp/NO.svg" alt=""><span>流水号</span><span class="add"><img class="icon-add" src="/ui/img/gapp/addCA.svg" alt=""></span></li>
                                <li class="item" draggable="true" data-type="S01"><img src="/ui/img/gapp/create.svg" alt=""><span>创建人</span><span class="add"><img class="icon-add" src="/ui/img/gapp/addCA.svg" alt=""></span></li>
                                <li class="item" draggable="true" data-type="S04"><img src="/ui/img/gapp/have.svg" alt=""><span>拥有者</span><span class="add"><img class="icon-add" src="/ui/img/gapp/addCA.svg" alt=""></span></li>
                                <li class="item" draggable="true" data-type="S05"><img src="/ui/img/gapp/belong.svg" alt=""><span>所属部门</span><span class="add"><img class="icon-add" src="/ui/img/gapp/addCA.svg" alt=""></span></li>
                                <li class="item" draggable="true" data-type="S02"><img src="/ui/img/gapp/createTime.svg" alt=""><span>创建时间</span><span class="add"><img class="icon-add" src="/ui/img/gapp/addCA.svg" alt=""></span></li>
                                <li class="item" draggable="true" data-type="S03"><img src="/ui/img/gapp/changeTime.svg" alt=""><span>修改时间</span><span class="add"><img class="icon-add" src="/ui/img/gapp/addCA.svg" alt=""></span></li>
                            </ul>
                        </div>
                        <div>
                            <div class="title">
                                <span>高级控件</span>
                            </div>
                            <ul class="control">
                                <li style="width: 100%;" class="item" draggable="true" data-type="C15"><img src="/ui/img/gapp/relation.svg" alt=""><span>关联表单(开发中...)</span><span class="add"><img class="icon-add" src="/ui/img/gapp/addCA.svg" alt=""></span></li>
<%--                                <li class="item" draggable="true"><img src="/ui/img/gapp/attr.svg" alt=""><span>关联属性</span><span class="add"><img class="icon-add" src="/ui/img/gapp/addCA.svg" alt=""></span></li>--%>
<%--                                <li class="item" draggable="true"><img src="/ui/img/gapp/relationToo.svg" alt=""><span>关联表单多选</span><span class="add"><img class="icon-add" src="/ui/img/gapp/addCA.svg" alt=""></span></li>--%>
<%--                                <li class="item" draggable="true"><img src="/ui/img/gapp/formula.svg" alt=""><span>公式型空间</span><span class="add"><img class="icon-add" src="/ui/img/gapp/addCA.svg" alt=""></span></li>--%>
<%--                                <li class="item" draggable="true"><img src="/ui/img/gapp/button.svg" alt=""><span>按钮</span><span class="add"><img class="icon-add" src="/ui/img/gapp/addCA.svg" alt=""></span></li>--%>
<%--                                <li class="item" draggable="true"><img src="/ui/img/gapp/write.svg" alt=""><span>手写签名</span><span class="add"><img class="icon-add" src="/ui/img/gapp/addCA.svg" alt=""></span></li>--%>
                            </ul>
                        </div>
                    </div>
                </div>
                <%--    控件展示面板    --%>
                <div id="context">
                    <form class="layui-form" id="show-form">

                    </form>
                </div>
                <%--  控件属性面板     --%>
                <div id="set">
                    <ul class="btn">
                        <li id="controlBtn">
                            控件属性
                            <div></div>
                        </li>
                    </ul>
                    <div class="neirong">
                        <div class="control-data-box">

                        </div>
                    </div>
                </div>
            </div>
        </div>
<%--        <div class="layui-tab-item">--%>
<%--        </div>--%>
        <div class="layui-tab-item"></div>
<%--        <div class="layui-tab-item">内容4</div>--%>
    </div>
</div>
<script type="text/javascript" src="/js/gapp/design/city-picker.data.js"></script>

<script type="text/javascript" src="/lib/layui/layui/layui.js"></script>
<script type="text/javascript" src="/lib/layui/layui/global.js"></script>



<script type="text/javascript" src="/js/gapp/design/form_design.js?20230603.3"></script>
<script>
    $.ajax({
        type:'get',
        url:'/syspara/selectTheSysPara?paraName=IS_SHOW_JMJ',
        dataType:'json',
        success:function (res) {
                var data=res.object[0]
                if (data.paraValue!=0){
                    $('#Confidential').append('<span style="color: red;font-family: Microsoft YaHei;font-weight: bolder;font-size: 16pt;margin-left: 20px;margin-top: 10px;"> 机密级★ </span>')
                }
        }
    })
</script>
</body>
</html>
