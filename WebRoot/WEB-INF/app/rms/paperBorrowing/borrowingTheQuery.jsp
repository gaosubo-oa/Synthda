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
    <title>借阅详情</title>
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
    </style>
</head>
<body>

<div class="head">
    <span>借阅详情</span>
</div>

<div class="content">
    <table class="content_table">

    </table>
</div>

<script type="text/javascript">
    $(function () {
        var lendId = $.GetRequest().lendId;
        $.ajax({
            url:'/RmsLendController/selectByLend',
            data: {
                lendId: lendId
            },
            type: "get",
            success: function (res) {
                var str = '';
                if (res.flag) {
                    var object = res.obj1;
                    // 密级判断
                    if(object.allow==0){
                        object.allow = '待批准借阅';
                    }else if(object.allow==1){
                        object.allow = '已批准借阅';
                    }else if(object.allow==2){
                        object.allow = '未批准借阅';
                    }else if(object.allow==3){
                        object.allow = '已归还借阅';
                    }
                    function checkInner(object) {
                        if (object == "" || typeof (object) == "undefined") {
                            return " "
                        } else {
                            return object
                        }
                    }

                    str += '<tr>' +
                        '   <td>借阅名称：</td><td>'+checkInner(object.name)+'</td>' +
                        '</tr>' +
                        '<tr>' +
                        '<td>借阅状态：</td><td>'+checkInner(object.allow)+'</td>' +
                        '</tr>' +
                        '<tr>' +
                        '<td>借阅人：</td><td>'+checkInner(object.approve)+'</td>' +
                        '</tr>' +
                        '<tr>' +
                        '<td>申请时间：</td><td>'+checkInner(object.lendTime)+'</td>' +
                        '</tr>' +
                        '<tr>' +
                        '<td>归还时间：</td><td>'+checkInner(object.returnTime)+'</td>' +
                        '</tr>' +
                        '<tr>' +
                        '<td colspan="4"><div class="closeWindow">关闭</div></td>' +
                        '</tr>'
                }
                $('.content_table').html(str);
            },
            dataType: "json"
        })
        $('.content_table').on('click','.closeWindow',function () {
            window.close();
        })
    })
</script>
</body>
</html>
