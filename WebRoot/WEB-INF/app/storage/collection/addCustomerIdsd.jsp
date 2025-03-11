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
    <title>客户选择</title>
    <link rel="stylesheet" type="text/css" href="../../lib/pagination/style/pagination.css"/>
    <link rel="stylesheet" type="text/css" href="../../css/base.css"/>
    <link rel="stylesheet" type="text/css" href="../../css/news/center.css"/>
    <link rel="stylesheet" href="/lib/laydate/need/laydate.css">
    <link rel="stylesheet" href="../../lib/ueditor/formdesign/bootstrap/css/bootstrap.min.css">
<%--    <script type="text/javascript" src="../../js/xoajq/xoajq1.js"></script>--%>
    <script type="text/javascript" src="/js/xoajq/xoajq3.js"></script>
    <script type="text/javascript" src="/js/jquery/jquery-migrate-3.4.0.js"></script>
    <script src="/lib/laydate/laydate.js"></script>
    <script type="text/javascript" src="/js/base/tablePage.js"></script>
    <script src="../../js/news/page.js"></script>
    <script src="../../js/base/base.js" type="text/javascript" charset="utf-8"></script>
    <script src="../../lib/pagination/js/jquery.pagination.min.js" type="text/javascript" charset="utf-8"></script>
    <script src="../../lib/layer/layer.js?20201106"></script>
    <script src="../../lib/laydate/laydate.js"></script>
    <script src="../js/sys/citys.js" type="text/javascript" charset="utf-8"></script>
    <style>
        * {font-family: "Microsoft Yahei" !important;}
        b{
            color: red;
        }
        .head_title{
            margin-top: 10px;
            height: 40px;
            position: relative;
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
        .saveBtn{
            display: block;
            float: left;
            background: url(../img/confirm.png) no-repeat;
            border: none;
            width: 70px;
            height: 29px;
            line-height: 29px;
            margin-left: 10px;
            cursor: pointer;
        }
        .resetBtn {
            display: block;
            float: left;
            background: url(../img/news/new_filling.png) no-repeat;
            border: none;
            width: 70px;
            height: 29px;
            line-height: 29px;
            margin-left: 10px;
            cursor: pointer;
        }
        .ga-body .ga-media-item {
            margin-bottom: 15px;
            border-left: 10px solid #447DC0;
            box-shadow: 0px 4px 2px #d9d9d9;
            position: relative;
            cursor: pointer;
        }
        .ga-body .ga-media-item:hover {
            box-shadow: 0px 4px 2px #999999;
        }
        .ga-media-item-content {
            padding: 5px;
            line-height: 28px;
            font-size: 15px;
        }
        p {
            margin: 0px 0px 10px;
        }
        * {
            box-sizing: border-box;
        }
        user agent stylesheet
        p {
            display: block;
            -webkit-margin-before: 1em;
            -webkit-margin-after: 1em;
            -webkit-margin-start: 0px;
            -webkit-margin-end: 0px;
        }
        .ga-media-list{
            margin: 20px 140px;
        }
        .media-body{
            width: 800px;
            height: 190px;
            background-color: white;
            border: 1px gainsboro solid;
            border-radius: 5px;
        }
        .media-body:hover {
            box-shadow: 0 12px 16px 0 rgba(0,0,0,0.24), 0 17px 50px 0 rgba(0,0,0,0.19);
            background-color: #F2F2F2;
        }
        .media-body-css{
            box-shadow: 0 12px 16px 0 rgba(0,0,0,0.24), 0 17px 50px 0 rgba(0,0,0,0.19);
            background-color: #F2F2F2;
        }
        #keyWords{
            margin: 0px 155px;
            width: 79%;
            height: 50px;
        }
        .media-body{
            margin: 15px;
            padding: 5px 30px;
        }
        .text-muted{
            margin: 0px 0px 0px 85%
        }
        .ga-media-list{
            position: relative;
        }
        .div_Btn{
            position: absolute;
            left:45% ;
            margin: 10px auto;
        }

    </style>
    <link rel="stylesheet" type="text/css" href="/css/commonTheme/${sessionScope.InterfaceModel}/commonTheme.css"/>
</head>
<body>
<!--head开始-->
<div class="head_title">
    <div class="title">
        <img src="/img/commonTheme/${sessionScope.InterfaceModel}/flow_run_title.png"><span >客户管理</span>
    </div>
</div>
<div>
    <div class="container-fluid">
        <div>
            <input  placeholder="请输入客户名称" type="text" id="keyWords" style="border-radius: 10px;margin-bottom: 10px;"/>
        </div>
        <div class="ga-media-list">
            <div class="ga-media-item">

            </div>
        </div>
    </div>
</div>
<div class="div_Btn">
    <div class="saveBtn">
        <span  style="margin-left: 32px;">保存</span>
    </div>
    <div class="resetBtn">
        <span  style="margin-left: 32px;" >返回</span>
    </div>
</div>
</body>
<script>
    $('.resetBtn').on('click',function () {
        window.close();
        window.location.href='/order/addOrders'
    })
    $(function (me) {

        $.ajax({
            dataType:'json',
            type:"get",
            url:'/customer/potentialCustomer',
            success:function(json){
                var str=''
                for(var i=0;i<json.obj.length;i++){
                    str+='<div  class="media-body" style="width: 100%">' +
                        '<div class="ga-media-item-content">' +
                        '<h4 id="customerNo">'+json.obj[i].customerNo+'</h4>' +
                        '<h4 id="customerId" hidden="true">'+json.obj[i].customerId+'</h4>' +
                        '客户编号:<span>'+json.obj[i].customerNo+'</span><br/>' +
                        '客户名称:<span>'+json.obj[i].customerName+'</sapn><br/>' +
                        '客户经理:<span>'+json.obj[i].customerManager+'</span><br/>' +
                        '创建人:<span>'+json.obj[i].creator+'</span><br/>' +
                        '</div>' +
                        '<span class="text-muted">'+json.obj[i].createdTime+'</span>' +
                        '</div>';


                }

                $('.ga-media-item').html(str);

                $('.media-body').on('click',function() {
                    var customerNo = $(this).find('#customerNo').text();
                    var customerId= $(this).find('#customerId').text();
                    $(this).siblings('div').removeClass('media-body-css');  // 删除其他兄弟元素的样式
                    $(this).addClass('media-body-css');
                    $('.saveBtn').on('click',function () {
                        $('#customerNo',window.opener.document).val(customerNo);
                        $('#customerId',window.opener.document).val(customerId);
                        window.close();
                    })
                })

            }
        })
    })

    //模糊查询
    $('#keyWords').on('change',function () {
        var keyWords=$('#keyWords').val();
        $.ajax({
            dataType:'json',
            type:"get",
            url:'/customer/potentialCustomer',
            data:{'customerName':keyWords},
            success:function(json) {
                var str = ''
                for (var i = 0; i < json.obj.length; i++) {
                    str += '<div  class="media-body" style="width: 100%">' +
                        '<div class="ga-media-item-content">' +
                        '<h4 id="customerNo">' + json.obj[i].customerNo + '</h4>' +
                        '<h4 id="customerId" hidden="true">' + json.obj[i].customerId + '</h4>' +
                        '客户编号:<span>' + json.obj[i].customerNo + '</span><br/>' +
                        '客户名称:<span>' + json.obj[i].customerName + '</sapn><br/>' +
                        '客户经理:<span>' + json.obj[i].customerManager + '</span><br/>' +
                        '创建人:<span>' + json.obj[i].creator + '</span><br/>' +
                        '</div>' +
                        '<span class="text-muted">' + json.obj[i].createdTime + '</span>' +
                        '</div>';


                }

                $('.ga-media-item').html(str);
                $('.media-body').on('click',function() {
                    var customerNo = $(this).find('#customerNo').text();
                    var customerId= $(this).find('#customerId').text();
                    $(this).siblings('div').removeClass('media-body-css');  // 删除其他兄弟元素的样式
                    $(this).addClass('media-body-css');
                    $('.saveBtn').on('click',function () {

                        $('#customerNo',window.opener.document).val(customerNo);
                        $('#customerId',window.opener.document).val(customerId);
                        window.close();
                    })
                })
            }
        })

    })
</script>

</html>
