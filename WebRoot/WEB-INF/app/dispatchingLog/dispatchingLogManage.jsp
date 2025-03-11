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
    <title>调度日志管理</title>
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
        .queryBtn {
            width: 71px;
            height: 30px;
            font-family: 'Arial Normal', 'Arial';
            font-style: normal;
            font-size: 13px;
            color: #fff;
            background: #2b9688 url(../../img/taisousuo.png) no-repeat 12px 5px !important;
            border: none;
            padding-left: 20px;
            border-radius: 5px;
            display: inline-block;
            text-align: center;
            line-height: 24px;
            cursor: pointer;
        }
    </style>
    <link rel="stylesheet" type="text/css" href="/css/commonTheme/${sessionScope.InterfaceModel}/commonTheme.css"/>
</head>
<body>
<%--<div class="head-top">--%>
<%--&lt;%&ndash;    <ul class="clearfix">&ndash;%&gt;--%>
<%--&lt;%&ndash;        调度日志管理&ndash;%&gt;--%>
<%--&lt;%&ndash;    </ul>&ndash;%&gt;--%>
<%--</div>--%>
<%--class="navigation  clearfix"--%>

<div class="left" style="margin-left: 10px; margin-top: 1%;">
    <div class="news"><img style="margin-right: 10px;width: 24px;float: left;" src="/img/commonTheme/theme6/la2.png" alt="">调度日志管理</div>
    <div style="margin-top: 0.5%;">
        <select name="TYPE" class="button1 nav_type" id="select" style="width: 100px;">
            <optgroup label="查询条件"></optgroup><option value="1">姓名</option><option value="2">日期</option>
        </select>
        <div class="layui-input-inline button1 nav_type">
            <input id="searchBox" type="tel" name="phone" lay-verify="required|phone" autocomplete="off" class="layui-input nav_type button1" style="height: 30px;border: 1px solid #c0c0c0">
        </div>
        <!-- 查询按钮 -->
        <button class="0 layui-btn layui-btn-sm" type="button" id="search">查询</button>
    </div>
</div>

<div class="insert" style="margin-top: 0.2%;">
    <div class="chaxun" style="margin: 0 auto;width: 98.5%;">
        <table id="plan4" lay-filter="plan4">

        </table>
    </div>
</div>
</body>
<script>
    //获取日期
    // var date = new Date();
    // // var times = date.getFullYear()+"-"+(date.getMonth()+1)+"-"+date.getDate();
    // var year = date.getFullYear();//月份从0~11，所以加一
    // var dateArr = [date.getMonth() + 1,date.getDate()];
    // for(var i=0;i<dateArr.length;i++){
    //     if (dateArr[i] >= 1 && dateArr[i] <= 9) {
    //         dateArr[i] = "0" + dateArr[i];
    //     }
    // }
    // var strDate = year+'-'+dateArr[0]+'-'+dateArr[1];
    $(function () {
        layui.use(['table','laydate','upload'], function() {
            $ = layui.jquery,
                laydate = layui.laydate
                ,upload = layui.upload
                ,table = layui.table;

            var queryJson = {
                elem: '#plan4'
                ,url : '/dispatchingLogManage/query'
                ,page : true
                ,limit:'10'
                ,minWidth: 80
                ,cols: [[
                    {field:'userName', title: '创建人' ,align : 'center'},
                    {field:'createDate', title: '创建日期' ,align : 'center'},
                    {field:'week', title: '星期' ,align : 'center'},
                    {field: 'type',title: '操作',align : 'center',toolbar: '#barDemo'}
                ]]
                ,parseData: function(res){ //res 即为原始返回的数据
                    if (res.obj.length != 0) {
                        $.each(res.obj,function(index,priv){
                            if (priv.privType==1) {
                                window.check = priv.privType

                            };
                            if (priv.privType==2) {
                                window.edit = priv.privType;
                            };
                            if (priv.privType==3){
                                window.delete = priv.privType;
                            }
                        })
                    }

                    return {
                        "code": 0, //解析接口状态
                        "msg": res.msg, //解析提示文本
                        "count": res.totle, //解析数据长度
                        "data": res.data, //解析数据列表
                    };

                },done: function (res, curr, count) {
                }

            }

            // 页面初始加载日志数据
            var table4 = table.render(queryJson);

            // 关键词查询
            $('#search').on('click',function (){
                queryJson.url="/dispatchingLogManage/queryByKeyword?keyword=" + $('#searchBox').val();
                table.render(queryJson);
            })

            //表格监听工具事件
            table.on('tool(plan4)', function(obj){
                var data = obj.data;
                var layEvent = obj.event;
                var userName = encodeURI(obj.tr.find('div').html());
                if(layEvent == 'editLog'){
                    window.location.href= "/dispatchingLog/dispatchingLogIndex?type=1&edit=yes&logId="+data.logId+"&privType="+window.edit+"&userName="+userName
                }
                else if(layEvent === 'deleteLog'){
                     $.ajax({
                        url: "/dispatchingLog/dispatchingLogById",
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
                 }else if(layEvent == 'lookLog'){
                    window.location.href= "/dispatchingLog/dispatchingLogIndex?type=1&edit=no&logId="+data.logId+"&privType="+window.check+"&userName="+userName
                }
            });
        })

    })
</script>
<script type="text/html" id="barDemo">
    {{# if (window.check == 1 ){ }}
    <a class="layui-btn layui-btn-xs" lay-event="lookLog" id="look">查看</a>
    {{#  } }}
    <%--    {{#  if(d.createDate == strDate){ }}--%>
    {{# if (window.edit == 2 ){ }}
    <a class="layui-btn layui-btn-xs" lay-event="editLog" id="edit">编辑</a>
    {{#  } }}
    {{# if (window.delete == 3 ){ }}
    <a class="layui-btn layui-btn-xs" lay-event="deleteLog" id="delete" >删除</a>
    {{#  } }}

    {{# if (window.check !=1 && window.edit !=2 && window.delete!=3){ }}
    <p><font size="2" face="arial" color="gray" >没有权限</font></P>
    {{#  } }}
</script>
</html>
