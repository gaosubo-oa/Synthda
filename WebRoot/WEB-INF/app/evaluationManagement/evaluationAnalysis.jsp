<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@taglib prefix="mvc" uri="http://www.springframework.org/tags/form" %>
<%@taglib prefix="fmt" uri="http://www.springframework.org/tags" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
%>

<!DOCTYPE html>
<html>
<head lang="en">
    <meta charset="UTF-8">
    <title>评价分析</title>
    <link rel="stylesheet" type="text/css" href="../../lib/layui/layui/css/layui.css?20210319.1"/>
    <script type="text/javascript" src="../../lib/layui/layui/layui.js"></script>
<%--    <script type="text/javascript" src="../../js/xoajq/xoajq2.js"></script>--%>
    <script type="text/javascript" src="../../lib/layui/layui/layui.all.js"></script>
    <script type="text/javascript" src="/ui/js/xoajq/xoajq3.js"></script>
    <script src="/js/base/base.js" type="text/javascript" charset="utf-8"></script>
    <script src="/lib/jQuery-File-Upload-master/jquery-ui.js"></script>
    <script src="/lib/jQuery-File-Upload-master/jquery.fileupload.js" type="text/javascript" charset="utf-8"></script>
    <script type="text/javascript" src="/js/common/fileupload.js"></script>
    <style>
        * {
            font-family: "Microsoft Yahei" !important;
        }

        .add {
            margin-top: 10px;
            margin-left: 10px;
        }

        .layui-layer-btn .layui-layer-btn1 {
            background: #009688;
            color: #fff;
        }

        #Settlement {
            table-layout: fixed;
            border-collapse: collapse;
            width: 100%;
        }

        .layui-body {
            overflow-y: scroll;
        }

        #pensons .layui-table-cell {
            font-size: 14px;
            padding: 0 5px;
            height: auto;
            overflow: visible;
            text-overflow: inherit;
            white-space: normal;
            word-break: break-all;
            text-align: center;
        }

        .layui-table-view .layui-table td, .layui-table-view .layui-table th:nth-child(8) {
            width: 100px;
        }

        a {
            color: blue;
        }

        .layui-textarea {
            min-height: 35px;
            width: 300px;
            height: 35px;
            margin-top: 2px;
            /*padding: 6px 10px;*/
            resize: vertical;
            line-height: 20px;
        }

        .layui-input-block {
            width: 100px;
        }

        .layui-rate {
            padding: 0;
            font-size: 0;
        }

        .layui-table-view .layui-table {
            width: 100%;
        }

        .laytable-cell-1-0-0 {
            width: 100px!important;
        }

        .layui-input, .layui-textarea {
            display: inline-block;
            width: 150px;
        }
    </style>
    <link rel="stylesheet" type="text/css" href="/css/commonTheme/${sessionScope.InterfaceModel}/commonTheme.css"/>
</head>
<body>
<p>
    <span class="layui-btn layui-btn-primary" id="chakan">查看评价</span>
    <span class="layui-btn layui-btn-primary" id="fenxi"
          style="background-color: #009688; color: white;">评价分析</span>
</p>

<form class="layui-form" action="" style="margin-top: 15px">
    <div class="layui-inline layui-form-text">
        <label class="layui-form-label">选择部门：</label>
        <div class="layui-input-inline">
            <textarea placeholder="请选择部门" deptid="" style="width: 200px" readonly name="textUser" id="textUser"
                      class="layui-textarea"></textarea>
        </div>
        <span style="color: red">*</span>
        <a href="javascript:;" class="governor" id="market_pop"><fmt:message code="global.lang.add"/></a>
        <a href="javascript:;" class="clearTwo" onclick="market_pop()"><fmt:message code="global.lang.empty"/></a>
    </div>

    <div class="layui-inline" style="margin-left: 50px">
        <div class="layui-input-inline" style="display: flex">
            <label class="layui-form-label">综合评价：</label>
            <select name="evLevel" id="evLevel" lay-verify="required">
                <option value="">请选择</option>
                <option value="1">优秀</option>
                <option value="2">一般</option>
                <option value="3">黑名单</option>
            </select>
        </div>
    </div>

    <div class="layui-inline">
        <label class="layui-form-label">年份：</label>
        <div class="layui-input-inline">
            <input id="nianfen" tyle="width: 150" class="layui-input" placeholder="请选择年份">
            <span>到</span><input id="nianfen2" tyle="width: 150" class="layui-input" placeholder="请选择年份">
        </div>
    </div>
    <div class="layui-inline" style="margin-top: 10px;">
        <label class="layui-form-label">所在项目：</label>
        <div class="layui-input-inline">
            <input type="text" name="xiangmu" id="xiangmu" style="width: 200px" placeholder="请输入" autocomplete="off"
                   class="layui-input">
        </div>
    </div>

    <div class="layui-inline" style="">
        <div class="layui-input-inline" style="    margin-left: 10px;
    margin-top: 10px">
            <button type="button" class="layui-btn" id="insert">查询</button>
            <button type="button" class="layui-btn" id="print">导出</button>
        </div>
    </div>
    <table id="test" lay-filter="SettlementFilter1"></table>
</form>

<script type="text/javascript">
    $("#chakan").on("click",function () {
        window.location.href = "/hrEvaluate/evaluationView";
    })
    $(function () {
        laydate.render({
            elem: '#nianfen'
            , type: 'year'
        });
        laydate.render({
            elem: '#nianfen2'
            , type: 'year'
        });
    })
    var dept_id = '';
    $('#market_pop').on("click",function () {
        dept_id = 'textUser';
        $.popWindow("../common/selectDept?0");
    });

    //清除数据
    function market_pop() {
        $('#textUser').attr('deptid', '');
        $('#textUser').val('');
    }

    var laydate;
    var table = layui.table;
    layui.use('form', function () {
        var form = layui.form; //只有执行了这一步，部分表单元素才会自动修饰成功
        //但是，如果你的HTML是动态生成的，自动渲染就会失效
        //因此你需要在相应的地方，执行下述方法来手动渲染，跟这类似的还有 element.init();
        form.render();
    });
    layui.use(['table', 'form', 'rate'], function () {
        var rate = layui.rate;
        var form = layui.form;
        var table = layui.table;
        laydate = layui.laydate;
        var tableIns = table.render({
            elem: '#test'
            , url: '/hrEvaluate/hrEvaluateCompre'
            , parseData: function (res) {
                return {
                    "code": 0,
                    "msg": "",
                    "count": res.totleNum,
                    "data": res.obj,
                }
            }
            , cols: [[
                , {
                    title: '部门', edit: 'text', width: '30%', templet: function (a) {
                        if (!a.deptId) {
                            return "无部门"
                        }
                        return a.deptName
                    }
                }
                , {
                    field: 'evAttitude', title: '工作技能', templet: function (a) {
                        return '<div id="evSkill' + a.deptId + '"></div>'
                    }, width: '25%'
                }
                , {
                    field: 'evSkill', title: '工作态度', templet: function (a) {
                        return '<div id="evAttitude' + a.deptId + '"></div>'
                    }, width: '25%'
                }
                , {
                    field: 'deptId', title: '综合评价', edit: 'text', width: '25%', templet: evLevelName
                }
            ]]
            , done: function (res, curr, count) {
                var data = res.data;//返回的json中data数据
                console.log(res)
                for (var item in data) {
                    console.log(item)
                    var evSkill = data[item].evSkill / 2
                    var evAttitude = data[item].evAttitude / 2
                    rate.render({
                        elem: '#evSkill' + data[item].deptId + ''         //绑定元素
                        , length: 5            //星星个数
                        , value: evSkill          //初始化值
                        , readonly: true      //只读
                        , half: true
                    });
                    rate.render({
                        elem: '#evAttitude' + data[item].deptId + ''         //绑定元素
                        , length: 5            //星星个数
                        , value: evAttitude          //初始化值
                        , readonly: true      //只读
                        , half: true
                    });
                }
            }
            , page: true
        });
        $('#insert').on("click",function () {
            // location.reload();
            var currentPage = 1;
            tableIns.reload({
                url: '/hrEvaluate/hrEvaluateCompre',
                data: {page: currentPage},
                page: {
                    curr: currentPage
                },
                where: {
                    startTime: $('#nianfen').val(),
                    endTime: $('#nianfen2').val(),
                    evLevel: $('#evLevel').val(),
                    project: $('#xiangmu').val(),
                    deptId: $('#textUser').attr("deptid")
                }
            })

        })
    });

    function evLevelName(data) {
        var evLevel = data.evLevel;
        if (evLevel == 1) {
            return "优秀";
        } else if (evLevel == 2) {
            return "一般 ";
        } else if (evLevel == 3) {
            return "黑名单";
        } else {
            return "";
        }
    }

    $('#print').on("click",function () {
        window.location.href = '/hrEvaluate/hrEvaluateFileExport?&evLevel=' + $('#evLevel').val() + '&project=' + $('#xiangmu').val() + '&deptId=' + $('#textUser').attr('deptid');
    })
</script>

</body>
</html>
