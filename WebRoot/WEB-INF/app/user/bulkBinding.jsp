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
    <title>批量绑定</title>
    <link rel="stylesheet" href="/lib/pagination/style/pagination.css">
    <link rel="stylesheet" href="/css/base/base.css?20201106.1">
    <link rel="stylesheet" href="/css/notice/noticeManagement.css">
    <script src="/js/common/language.js"></script>
    <%--<script src="/js/jquery/jquery.cookie.js"></script>--%>
    <script type="text/javascript" src="/js/xoajq/xoajq1.js"></script>
    <script type="text/javascript" src="/js/base/tablePage.js"></script>
    <script src="/js/base/base.js"></script>
    <script src="/lib/laydate/laydate.js"></script>
    <script src="/js/jquery/jquery.form.min.js"></script>
    <script src="/lib/pagination/js/jquery.pagination.min.js" type="text/javascript" charset="utf-8"></script>
    <link rel="stylesheet" type="text/css" href="/css/commonTheme/${sessionScope.InterfaceModel}/commonTheme.css"/>
    <style>
        table tbody td{
            text-align: left;
            padding: 10px;
            box-sizing: border-box;
        }
        table tbody td.color{
            padding:10px 10px 10px 50px;
        }
        input{
            float: none;
        }
        .editAndDelete3{
            color: red;
        }
        .color{
            font-size: 11pt;
            color: #2a588c;
            font-weight: bold;
        }
        table tbody td textarea{
            width: 229px;
            height: 34px;
            line-height: 34px;
            padding-left: 10px;
            outline: none;
            border-radius: 4px;
            vertical-align: middle;
            font-family:"Microsoft Yahei";
        }
        table tbody td a{
            vertical-align: middle;
            font-size: 10pt;
        }
        table tbody td select{
            width: 119px;
            height: 28px;
            border-radius: 4px;
        }
        table tbody td input[type=text]{
            width: 288px;
            height: 32px;
            border-radius: 4px;
            padding-left: 10px;
            box-sizing: border-box;
        }
        .btnsava{
            padding:5px 15px;
            border-radius: 4px;
            background: #2F8AE3;
            color: #fff;
        }
        .btnsava_close{
            padding:5px 15px;
            border-radius: 4px;
            color:#000000;
            background: whitesmoke;
            border: 1px silver solid;
        }
        .pagediv .page-bottom-outer-layer table td{
            text-align: left;
        }
        #pagediv{
            width: 100%;
        }
        #pagediv table{
            width: 80%;
            margin: 0 auto;
        }
        #pagediv table tr:nth-child(odd){
            background-color: #F6F7F9;
        }
        #pagediv table tr:nth-child(even){
            background-color: #ffffff;
        }
        #pagediv table tr th{
            padding: 8px;
            font-size: 13pt;
            color: #2F5C8F;
            font-weight: bold;
            text-align: center;
        }
        #pagediv table tr td{
            padding: 8px;
            font-size: 11pt;
        }
    </style>
    <%--<script src="/js/notice/theQuery.js"></script>--%>
</head>
<body>
<div class="navigation">
    <img src="/img/commonTheme/${sessionScope.InterfaceModel}/gonggaochaxun.png" alt="">
    <h2>批量绑定用户和卡</h2>
</div>
<div class="query">
    <div class="header">批量绑定用户和卡</div>
    <form id="ajaxform" method="post" action="/user/imputBindUserInfo"  enctype="multipart/form-data">
        <table style="width: 100%;    border: 1px solid #c0c0c0;
    border-top: none;">
            <tbody>
            <tr class="borderNone">
                <td width="30%" class="color">下载绑定模板：</td>
                <td width="70%">
                    <a href="/file/user/动态密码卡批量绑定模板.xls" style="text-decoration: underline">批量绑定模板下载</a>
                </td>
            </tr>
            <tr class="borderNone">
                <td width="30%" class="color">选择绑定文件：</td>
                <td width="70%">
                    <input type="file" name="file" value="请选择文件"/>
                </td>
            </tr>
            <tr class="borderNone">
                <td width="30%"  class="color">说明：</td>
                <td width="70%">
                    <p>1、请导入Excel文件。</p>
                    <p>2、下载导入模板进行批量添加数据。</p>
                    <p>3、导入的数据字段不可为空。</p>
                    <%--<p>4、产品提供商需要根据提供商表填写提供商id。</p>--%>
                </td>
            </tr>

            <tr class="borderNone">
                <td colspan="2" style="text-align: center">
                    <a href="javascript:;" class="btnsava">绑定</a>
                    <a href="javascript:;" class="btnsava_close" onclick="javascript:window.location.href='/user/passwordCard'">返回</a>
                </td>
            </tr>
            </tbody>
        </table>
    </form>
</div>
<script type="text/javascript">
    $('.btnsava').click(function () {
        $('#ajaxform').ajaxSubmit({
            dataType: 'json',
            success:function (res) {
                if(res.flag){
                    $.layerMsg({content: '绑定成功！', icon: 1}, function () {
                        parent.$('[name="notices"]').attr('src','/user/imputBindUserInfo');
                        parent.$('.head-top ul li').removeClass('active');
                        $((parent.$('.head-top ul li'))[0]).addClass('active');
                        //跳转到首页
                        window.location.href='/user/passwordCard'
                    });
                }else {
                    $.layerMsg({content: '绑定失败！', icon: 2});
                }
            }
        })
    })
</script>

</body>
</html>