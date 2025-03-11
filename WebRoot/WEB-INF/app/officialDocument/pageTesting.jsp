<%--
  Created by IntelliJ IDEA.
  User: 骆鹏
  Date: 2017/7/27
  Time: 11:05
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@taglib prefix="mvc" uri="http://www.springframework.org/tags/form" %>
<%@taglib prefix="fmt" uri="http://www.springframework.org/tags" %>

<html>
<head>
    <title><fmt:message code="doc.th.TemplateSetting"/></title>
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <link rel="stylesheet" href="/css/officialDocument/officialDocument.css">

    <link rel="stylesheet" href="/lib/layer/skin/default/layer.css">
    <link rel="stylesheet" href="/lib/laydate/need/laydate.css">
    <link rel="stylesheet" href="/lib/pagination/style/pagination.css">
    <link rel="stylesheet" href="/css/base.css">
    <script type="text/javascript" src="/js/xoajq/xoajq1.js"></script>
    <script src="/lib/layer/layer.js?20201106"></script>
    <script src="/js/base/base.js"></script>
    <script src="/lib/laydate/laydate.js"></script>
    <script src="/js/jquery/jquery.form.min.js"></script>
    <script src="/js/jquery/jquery-validate.js"></script>
    <script src="/lib/validate-mothods.js"></script>
    <script src="/lib/pagination/js/jquery.pagination.min.js" type="text/javascript" charset="utf-8"></script>
    <script src="/js/base/tablePage.js"></script>

</head>
<body>
<div class="headTop">
    <div class="headImg">
        <img src="/img/commonTheme/${sessionScope.InterfaceModel}/icon_templateSet.png" alt="">
    </div>
    <div class="divTitle">
        <fmt:message code="doc.th.TemplateSetting"/>
    </div>
    <a href="javascript:void(0)" class="new_xinjiano new_xinjianoTwo" data-id="1"><fmt:message code="global.lang.new"/></a>
</div>
<div style="margin: 0 auto;margin-top: 46px;height: 60px;width: 97%;" class="clearfix">
    <label class="fl" style="margin-top: 16px;">
        <select name="dispatchType" id="" style="float:left;">
            <option value=""><fmt:message code="hr.th.PleaseSelect"/></option>
            <option value="1"><fmt:message code="doc.th.WordTemplate"/></option>
            <option value="2"><fmt:message code="doc.th.RedTemplate"/></option>
        </select>
        <button  type="button" class="Query fl"><fmt:message code="global.lang.query"/></button>
    </label>


    <div id="dbgz_page" class="M-box3 fr">

    </div>
</div>

<div id="divoo">

</div>



<script>
    var arr=[{
            title:'序号',
            name:''
        },
        {
            title:'模板名称',
            name:'name'
        },
        {
            title:'所属分类',
            name:'categoryId',
            selectFun:function (type) {
                if(type==1){
                    return 'word模板'
                }else {
                    return '套红模板'
                }
            }
        },
        {
            title:'授权范围',
            name:'privOrgName'
        },
        {
            title:'操作',
            name:''
        }
    ]
    $(function (){
        var obj=$.tablePage('#divoo',arr,function (me){
            me.data.type='office';
            me.data.categoryId=$('[name="dispatchType"]').val();
            me.init('/template/query',['编辑','修改']);
        });

        $('.Query').click(function (){
            obj.data.categoryId=$('[name="dispatchType"]').val();
            obj.init();
        })

    })


</script>

</body>
</html>
