<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@taglib prefix="mvc" uri="http://www.springframework.org/tags/form" %>
<%@taglib prefix="fmt" uri="http://www.springframework.org/tags" %>

<html>
<head>
    <title>站点管理</title>
    <link rel="stylesheet" href="/css/officialDocument/officialDocument.css">

    <link rel="stylesheet" href="/lib/layer/skin/default/layer.css">
    <link rel="stylesheet" href="/lib/laydate/need/laydate.css">
    <link rel="stylesheet" href="/lib/pagination/style/pagination.css">
    <link rel="stylesheet" href="/css/base.css">
    <script type="text/javascript" src="/js/xoajq/xoajq1.js"></script>
    <script src="/lib/layer/layer.js?20201106"></script>
    <script src="/js/base/base.js"></script>
    <script src="/lib/laydate/laydate.js"></script>
    <script src="/js/portal/CapacitySiteInfoJs.js"></script>
    <script src="/lib/pagination/js/jquery.pagination.min.js" type="text/javascript" charset="utf-8"></script>

</head>
<body>
<div class="headTop">
    <div class="headImg">
        <img src="/img/commonTheme/${sessionScope.InterfaceModel}/daibanshouwen.png" alt="">
    </div>
    <div class="divTitle">
        站点管理
    </div>


</div>
<div style="margin: 0 auto;margin-top: 46px;height: 60px;width: 97%;" class="clearfix">
    <button  type="button" class="Query fl" onclick="add()">创建站点</button>
    <div id="dbgz_page" class="M-box3 fr">
    </div>
</div>


<div class="pagediv" style="margin: 0 auto;width: 97%;">
    <table>
        <thead>
        <tr>
            <th>站点名称</th>
            <th>站点标识</th>
            <th>排序号</th>
            <th>存放位置</th>
            <th>操作</th>

        </tr>
        </thead>
        <tbody>
        </tbody>
    </table>
</div>
</body>
</html>
