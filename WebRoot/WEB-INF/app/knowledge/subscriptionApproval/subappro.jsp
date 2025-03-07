

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
    <title>订阅审批</title>
    <link rel="stylesheet" href="/lib/layui/layui/css/layui.css?20210319.1">
    <link rel="stylesheet" href="/lib/layui/layui/css/common.css">
    <link rel="stylesheet" href="/lib/layui/layui/css/eleTree.css">
    <script src="/lib/layui/layui/layui.js"></script>
    <script type="text/javascript" src="../../js/xoajq/xoajq1.js"></script>
    <script src="/lib/layui/layui/js/limstree.js?v=2019080601" type="text/javascript" charset="utf-8"></script>
    <script src="/lib/layui/layui/js/common.js?v=20190726" type="text/javascript" charset="utf-8"></script>
    <script type="text/javascript" src="/lib/layui/layui/global.js"></script>
    <%--<script type="text/javascript" src="/lims/layer/layer.js?20201106"></script>--%>
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
            width:60%;
        }
        .layui-layer-page .layui-layer-content{
            overflow-x: hidden !important;
        }
    </style>
</head>
<body>
<div class="main" style="padding: 50px 20px">
<%--    <div id="clientSerch">--%>
<%--        &lt;%&ndash;表格上方搜索栏&ndash;%&gt;--%>
<%--        <form class="layui-form" action="">--%>
<%--            <div class="demoTable" style="position:absolute;top: 10px;width: 600px;height: 60px">--%>
<%--                <label style="float: left;height: 40px;line-height: 40px;margin-right: 10px">查询字段</label>--%>
<%--                <div class="layui-input-inline" style="float:left;">--%>
<%--                    <select name="modules" lay-verify="required" lay-filter="serachInfo"  placeholder="请选择" lay-search="" style="height: 10px">--%>
<%--                        <option value="0">请选择查询字段</option>--%>
<%--                        <option value="CUSTOMER_NAME">客户名称</option>--%>
<%--                        <option value="CUSTOMER_ADDRESS">地址</option>--%>
<%--                        <option value="INDUSTRY_CODE">所属行业</option>--%>
<%--                        <option value="CREDIT_CODE">统一社会信用代码</option>--%>
<%--                        <option value="REGIST_PERIOD">登记时间</option>--%>
<%--                        <option value="URL">网址</option>--%>
<%--                        <option value="PHONE_NUMBER">电话号码</option>--%>
<%--                        &lt;%&ndash;<option value="applicant">申请人</option>&ndash;%&gt;--%>
<%--                        &lt;%&ndash;<option value="APPLICATION_TYPE">申请类型</option>&ndash;%&gt;--%>
<%--                        <option value="MEMO">备注</option>--%>
<%--                    </select>--%>
<%--                </div>--%>
<%--                <div style="float: left">--%>
<%--                    <div class="layui-inline">--%>
<%--                        <input class="layui-input" autocomplete="off"  name="searchtext" style="height: 38px;margin-left: 6px;">--%>
<%--                    </div>--%>
<%--                    <button class="layui-btn" data-type="reload" lay-event="searchCust" style="height:36px;line-height: 36px;margin-left: 10px">搜索</button>--%>
<%--                </div>--%>
<%--            </div>--%>
<%--        </form>--%>
<%--    </div>--%>
    <div id="clientContent">
        <%--表格内容--%>
        <table id="subscribe" lay-filter="subscribe"></table>
    </div>
</div>
<script type="text/html" id="barDemo">
    <a class="layui-btn layui-btn-xs" lay-event="info">查看订阅客户</a>
    <a class="layui-btn layui-btn-xs" lay-event="agree">同意</a>
    <a class="layui-btn layui-btn-xs" lay-event="disagree">不同意</a>
</script>

<script type="text/javascript">
    var str = '<form class="layui-form" id="formBox" action="" lay-filter="formTest"><div class="layui-form-item" style="display: inline-block">\n' +
        '                <div class="layui-inline">\n' +
        '                    <label class="layui-form-label"><span style="color:red">*</span>下载开始时间：</label>\n' +
        '                    <div class="layui-input-inline">\n' +
        '                        <input type="text" id="downloadBDate" name="downloadBDate" autocomplete="off" class="layui-input">\n' +
        '                    </div>\n' +
        '                </div>\n' +
        '            </div>\n' +
        '            <div class="layui-form-item" style="display: inline-block">\n' +
        '                <div class="layui-inline">\n' +
        '                    <label class="layui-form-label"><span style="color:red">*</span>下载结束时间：</label>\n' +
        '                    <div class="layui-input-inline">\n' +
        '                        <input type="text" id="downloadEDate" name="downloadEDate" autocomplete="off" class="layui-input">\n' +
        '                    </div>\n' +
        '                </div>\n' +
        '            </div>\n' +
        '            <div class="layui-form-item" style="display: inline-block">\n' +
        '                <div class="layui-inline">\n' +
        '                    <label class="layui-form-label"><span style="color:red">*</span>浏览开始时间：</label>\n' +
        '                    <div class="layui-input-inline">\n' +
        '                        <input type="text" id="browseBDate" readonly placeholder="请选择" name="browseBDate" autocomplete="off" class="layui-input">\n' +
        '                    </div>\n' +
        '                </div>\n' +
        '            </div>\n' +
        '            <div class="layui-form-item" style="display: inline-block">\n' +
        '                <div class="layui-inline">\n' +
        '                    <label class="layui-form-label"><span style="color:red">*</span>浏览结束时间：</label>\n' +
        '                    <div class="layui-input-inline">\n' +
        '                        <input type="text" id="browseEDate" readonly placeholder="请选择" name="browseEDate" autocomplete="off" class="layui-input">\n' +
        '                    </div>\n' +
        '                </div>\n' +
        '            </div>\n' +
        '            <div class="layui-form-item" style="display: inline-block">\n' +
        '                <div class="layui-inline">\n' +
        '                    <label class="layui-form-label">下载密码</label>\n' +
        '                    <div class="layui-input-inline">\n' +
        '                        <input type="text" id="" name=""  placeholder="请选择" autocomplete="off" class="layui-input">\n' +
        '                    </div>\n' +
        '                </div>\n' +
        '            </div>\n' +
        '            <div class="layui-form-item" style="display: inline-block">\n' +
        '                <div class="layui-inline">\n' +
        '                    <label class="layui-form-label">下载地址</label>\n' +
        '                    <div class="layui-input-inline">\n' +
        '                        <input type="text" id="" name=""  placeholder="请选择" autocomplete="off" class="layui-input">\n' +
        '                    </div>\n' +
        '                </div>\n' +
        '            </div>\n' +
        '            <div class="layui-form-item" style="display: inline-block">\n' +
        '                <div class="layui-inline">\n' +
        '                    <label class="layui-form-label">备注</label>\n' +
        '                    <div class="layui-input-inline">\n' +
        '                        <input type="text" id="memo" name="memo" autocomplete="off" class="layui-input">\n' +
        '                    </div>\n' +
        '                </div>\n' +
        '            </div>\n' +
        '<button id="btnSubmit" lay-filter="btnSubmit" lay-submit style="display: none">保存</button></form>';

    layui.use(['table','layer','form','eleTree','element','laydate'], function(){
        var table = layui.table
            ,layer = layui.layer
            ,laydate = layui.laydate
            ,$ = layui.jquery
            ,eleTree = layui.eleTree
            ,element=layui.element;
        var tabInit = table.render({
            elem: '#subscribe'
            ,url:'/subscribe/getSubscription'
            ,toolbar: '#toolbarDemo' //开启头部工具栏，并为其绑定左侧模板
            ,defaultToolbar: ['filter', 'exports', 'print', { //自定义头部工具栏右侧图标。如无需自定义，去除该参数即可
                title: '提示'
                ,layEvent: 'LAYTABLE_TIPS'
                ,icon: 'layui-icon-tips'
            }]
            ,cols: [[
                {type: 'checkbox'}
                //,{field:'docfileNo', title:'文件编号'}
                ,{field:'docfileName', title:'文件名称'}
                ,{field:'subscribeUser', title:'订阅用户'}
                // ,{field:'contactPhone', title:'文件类别'}
                ,{fixed: 'right', title:'操作', toolbar: '#barDemo', width:280}
            ]]
            ,page: true
            ,id: 'subscribe'
            ,parseData: function(res){ //res 即为原始返回的数据
                // console.log(res)
                // return {
                //     "code": 0, //解析接口状态
                //     "msg": res.msg, //解析提示文本
                //     "count": res.count, //解析数据长度
                //     "data": res.data //解析数据列表
                // };
            }
        });


        //监听行工具事件
        table.on('tool(subscribe)', function(obj){
            var data = obj.data;
            //console.log(obj)
            if(obj.event === 'agree') {
                var index = layer.open({
                    type: 1,
                    area: ['75%', '80%'], //宽高
                    title: '审批',
                    maxmin: true,
                    btn: ['提交', '取消'],
                    content: str,
                    success: function () {
                        laydate.render({
                            elem: '#downloadBDate'
                            , trigger: 'click'//呼出事件改成click
                            ,type: 'datetime'
                        });
                        laydate.render({
                            elem: '#downloadEDate'
                            , trigger: 'click'//呼出事件改成click
                            ,type: 'datetime'
                        });
                        laydate.render({
                            elem: '#browseBDate'
                            , trigger: 'click'//呼出事件改成click
                            ,type: 'datetime'
                        });
                        laydate.render({
                            elem: '#browseEDate'
                            , trigger: 'click'//呼出事件改成click
                            ,type: 'datetime'
                        });
                    },
                    yes: function (index, layero) {
                        if($("#browseBDate").val()==''||$("#browseEDate").val()==''||$("#downloadBDate").val()==''||$("#downloadEDate").val()==''){
                            layer.msg("必填项不能为空");
                        }else{
                            var Column = {};
                            Column.subscribeId = data.subscribeId
                            Column.browseBDate = $("#browseBDate").val();
                            Column.browseEDate = $("#browseEDate").val();
                            Column.downloadBDate = $("#downloadBDate").val();
                            Column.downloadEDate = $("#downloadEDate").val();
                            Column.memo = $("#memo").val();
                            Column.status = "0";
                            $.ajax({
                                type: "post",
                                url: '/subscribe/update',
                                dataType: "json",
                                data:Column,
                                success:function (res) {
                                    if(res.code == "0" || res.code == 0){
                                        layer.msg(res.msg);
                                        layui.layer.close(index);
                                        table.reload();
                                    }else{
                                        layer.msg(res.msg);
                                    }
                                }
                            })
                        }
                    }
                    ,cancel:function () {
                        layui.layer.close(index);
                    }

                })
            }
            if(obj.event === 'disagree'){
                layer.confirm('确定不同意吗?', function(index){
                    var Column = {};
                    Column.status='1';
                    Column.subscribeId = data.subscribeId
                    $.ajax({
                        type: "post",
                        url: '/subscribe/update',
                        dataType: "json",
                        data:Column,
                        success:function (res) {
                            if(res.code == "0" || res.code == 0){
                                layer.msg(res.msg);
                                layui.layer.close(index);
                                table.reload();
                            }else{
                                layer.msg(res.msg);
                            }
                        }
                    })
                })
            }
            if(obj.event === 'info'){
                layer.open({
                    type: 2
                    , title: ['查看', 'font-size:18px;']
                    , maxmin: true
                    , area: ['80%', '90%']
                    , btn: ['确定']
                    , content: '/subscribe/showSubapproInfo?customerId='+data.customerId+'&fileId='+data.docfileId
                    ,success: function (res) {

                    }

                    , yes: function (index, layero) {
                        layer.close(index)
                    }
                })
            }
        });

        $("#serch").click(function(){
            //执行重载
            table.reload('subscribe', {
                where: {
                    companyName : $("#companyName").val(),
                    contactUser : $("#contactUser").val(),
                    companyCode : $("#companyCode").val()
                }
            }, 'data');
        })



    });
</script>
</body>
</html>