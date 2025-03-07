<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@taglib prefix="mvc" uri="http://www.springframework.org/tags/form" %>
<%@taglib prefix="fmt" uri="http://www.springframework.org/tags" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <title>借阅</title>
    <link rel="stylesheet" type="text/css" href="../lib/laydate.css"/>
    <link rel="stylesheet" type="text/css" href="../lib/pagination/style/pagination.css"/>
    <link rel="stylesheet" type="text/css" href="../css/base.css"/>
<%--    <script type="text/javascript" src="../js/xoajq/xoajq1.js"></script>--%>
    <script type="text/javascript" src="/js/xoajq/xoajq3.js"></script>
    <script type="text/javascript" src="/js/jquery/jquery-migrate-3.4.0.js"></script>
    <script src="../js/news/page.js"></script>
    <script src="../lib/laydate.js"></script>
    <script src="../js/base/base.js" type="text/javascript" charset="utf-8"></script>
    <script src="../lib/pagination/js/jquery.pagination.min.js" type="text/javascript" charset="utf-8"></script>
    <script src="../lib/layer/layer.js?20201106"></script>
    <style>
        .head{
            font-size: 22px;
            color: #494d59;
            font-family: Microsoft yahei,Helvetica Neue,Helvetica,PingFang SC,Tahoma,Arial,sans-serif;
        }
        .head span{
            margin-left: 24px;
            margin-top: 10px;
        }
        .content_table {
            margin: 40px auto 0px auto;
            width: 88%;
        }
        .closeWindow{
            width: 50px;
            height: 30px;
            line-height: 30px;
            text-align: center;
            background: #2b7fe0;
            border-radius: 4px;
            cursor: pointer;
            color: #ffffff;
            margin: 0 auto;
        }
        input{
            width: 200px;
        }
    </style>
</head>
<body>

<div class="head">
    <span id="dome">借阅</span>
</div>

<div class="content">
    <form id="ajaxforms">
    <table class="content_table">
        <tr>
            <td>申请时间：
                <input type="text" name="lendTime" id="lendTime">
            </td>
        </tr>
        <tr>
            <td>归还时间：
                <input type="text" name="returnTime" id="returnTime">
            </td>
        </tr>
        <tr>
            <td colspan="4"><div class="closeWindow">保存</div></td>
        </tr>
    </table>
    </form>
</div>

<script type="text/javascript">
    var getRequestObj=$.GetRequest();
    $.ajax({
        type:'get',
        url:'/syspara/selectTheSysPara?paraName=IS_SHOW_JMJ',
        dataType:'json',
        success:function (res) {
            if(res.object.length!=0){
                var data=res.object[0]
                if (data.paraValue!=0){
                    $('#dome').after('<span style="color: red;font-family: Microsoft YaHei;font-weight: bolder;font-size: 16pt;margin-left: 20px;margin-top: 10px;"> 机密级★ </span>')
                }
            }
        }
    })
        $('.content_table').on('click','.closeWindow',function () {
            $(function () {
                $.ajax({
                    url:'/RmsLendController/addRmsLendRoll',
                    data: $('#ajaxforms').serialize()+ '&rollId=' + getRequestObj.rollId,
                    type: 'post',
                    dataType: 'json',
                    success: function (data) {
                        if(data.flag){
                            layer.msg('借阅成功！',{icon:1},function () {
                                window.close();
                            });/*添加成功*/
                        }else{
                            layer.msg('借阅失败！',{icon:2});/*添加失败*/
                        }
                    },
                    error: function (data) {
                        layer.msg('借阅失败！',{icon:2});/*添加失败*/
                    }
                })
        })
    })
    var start = {
        elem: '#lendTime',
        format: 'YYYY-MM-DD hh:mm:ss',
//        min: laydate.now(), //设定最小日期为当前日期
//        max: '2099-06-16 23:59:59', //最大日期
        istime: true,
        istoday: false,
        choose: function(datas){
            end.min = datas; //开始日选好后，重置结束日的最小日期
            end.start = datas //将结束日的初始值设定为开始日
        }
    };
    var end = {
        elem: '#returnTime',
        format: 'YYYY-MM-DD hh:mm:ss',
//        min: laydate.now(),
//        max: '2099-06-16 23:59:59',
        istime: true,
        istoday: false,
        choose: function(datas){
            start.max = datas; //结束日选好后，重置开始日的最大日期
        }
    };
    laydate(start);
    laydate(end);
</script>
</body>
</html>
