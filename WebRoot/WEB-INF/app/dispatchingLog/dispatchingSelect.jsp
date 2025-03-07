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
    <title>查询日志</title>
    <link rel="stylesheet" type="text/css" href="../../lib/pagination/style/pagination.css"/>
    <link rel="stylesheet" type="text/css" href="../../css/base.css"/>
    <link rel="stylesheet" type="text/css" href="../../css/news/center.css"/>
    <link rel="stylesheet" href="/lib/laydate/need/laydate.css">
    <link rel="stylesheet" href="/lib/layui/layui/css/layui.css?20210319.1">
<%--    <script type="text/javascript" src="../../js/xoajq/xoajq1.js"></script>--%>
    <script type="text/javascript" src="/js/xoajq/xoajq3.js"></script>
<%--    <script type="text/javascript" src="/js/jquery/jquery-migrate-3.4.0.js"></script>--%>
    <script src="/lib/laydate/laydate.js"></script>
    <script type="text/javascript" src="/js/base/tablePage.js"></script>
    <script src="../../js/news/page.js"></script>
    <script src="../../js/base/base.js" type="text/javascript" charset="utf-8"></script>
    <script src="../../lib/pagination/js/jquery.pagination.min.js" type="text/javascript" charset="utf-8"></script>
    <script src="../../lib/layer/layer.js?20201106"></script>
    <script src="../../lib/laydate/laydate.js"></script>
    <script src="../js/sys/citys.js" type="text/javascript" charset="utf-8"></script>
    <script src="/lib/layui/layui/layui.js"></script>
    <script src="/lib/jQuery-File-Upload-master/jquery-ui.js" type="text/javascript" charset="utf-8"></script>
    <script src="/lib/jQuery-File-Upload-master/jquery.iframe-transport.js" type="text/javascript" charset="utf-8"></script>
    <script src="/lib/jQuery-File-Upload-master/jquery.fileupload.js" type="text/javascript" charset="utf-8"></script>
    <script type="text/javascript" src="/js/email/fileupload.js"></script>
    <style>
        * {font-family: "Microsoft Yahei" !important;}
        b{
            color: red;
        }
        .head_title .title{
            margin-left: 22px;
        }
        .head_title span{
            float: none;
            /*margin-top: 9px;*/
            font-size: 22px;
            color: #333;
            display: inline-block;
            margin-left: 10px;
            vertical-align: middle;
            margin-top: -6px;
        }
        select{
            width: 250px;
            height: 30px;
        }
        .newTbale tr td {
            border-right: #ccc 1px solid;
            /*padding: 5px 30px;*/
        }
        input[type="text"]{
            width: 80%;
            height: 30px;
        }
        table {
            border-collapse: collapse;
            border-spacing: 0;
        }
        input[type="file"]{
            width: 80%;
        }
        .attachmentId input[type=file]{
            position: absolute;
            top: 0;
            right: 0;
            bottom: 0;
            left: 0;
            width: 100%;
            height: 18px;
            z-index: 99;
            opacity: 0;
        }
        .addTd input{
            width: 90%;
        }
        .addTd td{
            padding: 4px;
        }
        .layui-card-body {
            position: relative;
            padding: 0 15px;
            line-height: 24px;
        }
        .head-top {
            width: 100%;
            position: fixed;
            top: 0px;
            left: 0px;
            height: 45px;
            border-bottom: 1px solid #999;
            background: #fff;
            overflow: hidden;
            z-index: 9999999;
        }
        .head-top ul {
            padding-left: 10px;
        }
        .head-top ul .head-top-li {
            height: 26px;
            line-height: 26px;
            margin: 10px 11px 0px 11px;
            padding: 1px 20px;
            font-size: 14px;
            border-radius: 20px;
            cursor: pointer;
        }
        .head-top ul .head-top-li.active {
            background: #2F8AE3;
            color: #fff;
        }
    </style>
    <link rel="stylesheet" type="text/css" href="/css/commonTheme/${sessionScope.InterfaceModel}/commonTheme.css"/>
</head>
<body>
<div class="head-top" style="background-color: #eeeeee;">
    <ul class="clearfix">
        <li class="fl head-top-li addLog" data-type="" style="font-weight:bold;">新增</li>
        <li class="fl head-top-img"><img src="/img/twoth.png" alt=""></li>
        <li class="fl head-top-li selectLog active" data-type="1" style="font-weight:bold;">日志列表</li>
    </ul>
</div>
<div class="insert" style="margin-top: 5%;">
    <div class="chaxun" style="margin: 0 auto;width: 98.4%;">
        <table id="plan4" lay-filter="plan4">

        </table>
    </div>
</div>
</body>
<script>
    $('.addLog').on('click',function () {
        window.location.href= "/dispatchingLog/dispatchingLogIndex"
    })
    $('.selectLog').on('click',function () {
        window.location.href= "/dispatchingLog/dispatchingLogSelect"
    })
    //获取日期
    var date = new Date();
    // var times = date.getFullYear()+"-"+(date.getMonth()+1)+"-"+date.getDate();
    var year = date.getFullYear();//月份从0~11，所以加一
    var dateArr = [date.getMonth() + 1,date.getDate()];
    for(var i=0;i<dateArr.length;i++){
        if (dateArr[i] >= 1 && dateArr[i] <= 9) {
            dateArr[i] = "0" + dateArr[i];
        }
    }
    var strDate = year+'-'+dateArr[0]+'-'+dateArr[1];
    $(function () {
        layui.use(['table','laydate','upload'], function() {
            $ = layui.jquery,
                laydate = layui.laydate
                ,upload = layui.upload
                ,table = layui.table;

            var table4 = table.render( {
                elem: '#plan4'
                ,url : '/dispatchingLog/query'
                ,page : true
                ,limit:'10'
                ,cols: [[
                    {field:'userName', title: '创建人' ,align : 'center'}
                    ,{field:'createDate', title: '创建日期' ,align : 'center'}
                    ,{field:'week', title: '星期' ,align : 'center'}
                    ,{field: 'type',title: '操作',width:'25%',align : 'center',toolbar: '#barDemo'}
                ]]
                ,parseData: function(res){ //res 即为原始返回的数据
                    return {
                        "code": 0, //解析接口状态
                        "msg": res.msg, //解析提示文本
                        "count": res.totle, //解析数据长度
                        "data": res.data, //解析数据列表
                    };
                },done: function (res, curr, count) {
                }

            });

            //表格监听工具事件
            table.on('tool(plan4)', function(obj){

                var data = obj.data;
                var layEvent = obj.event;
                var tr = obj.tr;
                if(layEvent == 'editLog'){
                    window.location.href= "/dispatchingLog/dispatchingLogIndex?type=1&edit=yes&logId="+data.logId
                }
                else if(layEvent === 'deleteLog'){
                    $.ajax({
                        url: "/dispatchingLog/delete",
                        type: 'post',
                        dataType: 'json',
                        data:{
                            logId:data.logId
                        },
                        success: function (res) {
                            if(res.flag == true){
                                layer.msg('删除成功！', {icon: 1, time: 2000}, function() {
                                    table4.reload();
                                });
                            }
                        }
                    })
                }
                else if(layEvent == 'lookLog'){
                    window.location.href= "/dispatchingLog/dispatchingLogIndex?type=1&edit=no&logId="+data.logId
                }
            });
        })

    })
</script>
<script type="text/html" id="barDemo">
    <a class="layui-btn layui-btn-xs" lay-event="lookLog" id="look">查看</a>
    {{#  if(d.createDate == strDate){ }}
    <a class="layui-btn layui-btn-xs" lay-event="editLog" id="edit">编辑</a>
    {{#  } }}

</script>

</html>
