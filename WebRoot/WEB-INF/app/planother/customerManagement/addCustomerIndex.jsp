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
    <title>新建客户</title>
    <link rel="stylesheet" href="/lib/layui/layui/css/layui.css?20190817.1">
    <link rel="stylesheet" href="/lib/layui/layui/css/common.css">
    <link rel="stylesheet" href="/lib/layui/layui/css/eleTree.css">
    <link rel="stylesheet" type="text/css" href="/lib/layui/layui/css/layui.css"/>
    <script src="/lib/layui/layui/layui.js"></script>
    <script type="text/javascript" src="../../js/xoajq/xoajq1.js"></script>
    <script src="/lib/layui/layui/js/limstree.js?v=2019080601" type="text/javascript" charset="utf-8"></script>
    <script src="/lib/layui/layui/js/common.js?v=20190726" type="text/javascript" charset="utf-8"></script>
    <script type="text/javascript" src="/lib/layui/layui/global.js"></script>
    <script src="/js/base/base.js" type="text/javascript" charset="utf-8"></script>
    <link rel="stylesheet" href="/lib/layui/layui/css/eleTree.css">

    <style>
        .mbox {
            padding: 8px;
        }

        .inbox {
            padding: 5px;
            padding-right: 30px;
        }

        .deptinput {
            display: inline-block;
            width: 75%;
        }

        .layui-btn {
            margin-left: 10px;
        }

        .layui-btn .layui-icon {
            margin-right: 0px;
        }

        .red {
            color: red;
            font-size: 16px;
        }

        .layui-form-label {
            padding: 8px 15px;
        }

        .layui-card-body {
            display: flex;
        }

        .layui-lf {
            min-width: 10%;
            overflow-x: auto;
        }
        .layui-rt {
            width: 93%;
        }
        .tdstyl {
            width: 70px;
        }
        /*客户信息样式*/
        #customerInfo{
            width:100%;
        }
        #customerInfo tr{
            height: 46px !important;
            line-height: 46px;
        }
        #customerInfo tr td{
            height: 38px;
            padding: 4px 15px;
        }
        #customerInfo tr td .layui-form-label{
            width:130px;
        }
        /*项目信息样式*/
        #projectInfo{
            width:100%;
        }
        #projectInfo tr{
            height: 46px !important;
            line-height: 46px;
        }
        #projectInfo tr td{
            height: 38px;
            padding: 4px 15px;
        }
        #projectInfo tr td .layui-form-label{
            width:130px;
        }
        .layui-radio-disbaled>i{
            color:#5FB878 !important;
        }
        .layui-disabled, .layui-disabled:hover{
            color:#666 !important;
        }
        /*.layui-form-select .layui-input{*/
        /*padding-right: 20px;*/
        /*}*/
        /**去掉数字的上下箭头*/
        input::-webkit-outer-spin-button, input::-webkit-inner-spin-button {
            -webkit-appearance: none;
        }
        input[type="number"] {
            -moz-appearance: textfield;
        }
        #layui-treeSelect-body-1578045742906_1_a{
            display: block;
        }
        #__vconsole .vc-switch{
            margin-top: 200px;
        }
        .tdsty2{
            width:30%;
        }
        /*.layui-input{*/
        /*width: 30%;*/
        /*}*/
        /*.layui-form-label{*/
        /*width:15%;*/
        /*}*/
        .disable{
            pointer-events: none;
            cursor: default;
        }

        .textAreaBox{
            width: 100%;
            max-width: 100%;
            cursor: pointer;
            margin: 0px;
            overflow-y:visible;
            min-height: 37px;
        }
    </style>
</head>
<body>
<div class="mbox" style="padding-bottom: 100px;">
    <form class="layui-form" lay-filter="formTest">
        <div class="layui-collapse" lay-filter="test">
            <div class="layui-colla-item">
                <h2 class="layui-colla-title">客户信息
                    <input type="hidden">
                </h2>
                <div class="layui-colla-content layui-show" style="padding: 0 15px;">
                    <table class="layui-table" lay-skin="line" id="customerInfo" lay-filter="customerInfoFilter">
                        <tr>
                            <td class="tdstyl">
                                <label class="layui-form-label" style=""><span class="red">*</span> 企业名称</label>
                            </td>
                            <td colspan="2" class="tdsty2">
                                <input type="text"  name="ogrName"    placeholder="请输入" id="ogrName" autocomplete="off" class="layui-input">
                                <input type="hidden" id="orgId" name="orgId">
                            </td>
                            <td class="tdstyl" >
                                <label class="layui-form-label" style="">
                                    <span class="red">*</span>社会统一信用代码</label>
                            </td>
                            <td colspan="2" class="tdsty2">
                                <input type="text"  name="orgCode"    placeholder="请输入" id="orgCode" autocomplete="off" class="layui-input">
                            </td>
                            <%--<td class="tdstyl">
                                <label class="layui-form-label">栏目角色</label>
                            </td>
                            <td colspan="2" class="tdsty2">
                                <select id="role" name="role" lay-filter="formNoSelect"></select>
                            </td>--%>
                        </tr>
                        <tr>
                            <td class="tdstyl" >
                                <label class="layui-form-label" style="">
                                    <span class="red">*</span>企业编码</label>
                            </td>
                            <td colspan="2" class="tdsty2">
                                <input type="text"  name="orgEnterpriseCode"    placeholder="请输入" id="orgEnterpriseCode" autocomplete="off" class="layui-input">
                            </td>
                            <td class="tdstyl">
                                <label class="layui-form-label"><span class="red">*</span>联系人</label>
                            </td>
                            <td colspan="2" class="tdsty2">
                                <input type="text" id="contactUser" readonly  placeholder="请输入" name="contactUser" autocomplete="off" class="layui-input">
                            </td>
                        </tr>
                        <tr>
                            <td class="tdstyl">
                                <label class="layui-form-label" style="">联系电话</label>
                            </td>
                            <td colspan="2" class="tdsty2">
                                <input type="text" id="contactPhone" name="contactPhone" autocomplete="off" placeholder="请输入" class="layui-input">
                            </td>
                            <td class="tdstyl">
                                <label class="layui-form-label" style="">备注</label>
                            </td>
                            <td colspan="2" class="tdsty2">
                                <input type="text" id="memo" name="memo" placeholder="请输入" autocomplete="off" class="layui-input">
                            </td>
                            <%--<td class="tdstyl">
                                <label class="layui-form-label">企业性质</label>
                            </td>
                            <td colspan="2" class="tdsty2">
                                <select name="companyNatrue" id="companyNatrue"></select>
                            </td>--%>
                        </tr>
                    </table>
                </div>
            </div>
            <div class="layui-colla-item">
                <h2 class="layui-colla-title">
                    权限设置
                </h2>
                <div class="layui-colla-content layui-show">
                    <table class="layui-table" lay-skin="line" id="projectInfo" lay-filter="projectInfoFilter">
                        <tr>
                            <td class="tdstyl">
                                <label class="layui-form-label" style=""><span class="red">*</span>授权开始时间</label>
                            </td>
                            <td colspan="2" class="tdsty2">
                                <select id="privType" lay-filter="privTypeFilter" name="privType"><option value="">请选择</option><option value="0">浏览</option><option value="1">下载</option></select>
                            </td>
                            <td class="tdstyl">
                                <label class="layui-form-label" style="">授权结束时间</label>
                            </td>
                            <td colspan="2" class="tdsty2">
                                <select id="docfileClass" lay-filter="docfileClass" name="docfileClass"><option value="">请选择</option></select>
                            </td>
                        </tr>
                        <tr>
                            <td class="tdstyl">
                                <label class="layui-form-label" style=""><span class="red">*</span>是否允许线上咨询</label>
                            </td>
                            <td colspan="4" class="tdsty2">
                                <select id="privType" lay-filter="privTypeFilter" name="privType"><option value="">请选择</option><option value="0">浏览</option><option value="1">下载</option></select>
                            </td>
                        </tr>
                        <tr>
                            <td class="tdstyl">
                                <label class="layui-form-label" style=""><span class="red">*</span>线上咨询开始时间</label>
                            </td>
                            <td colspan="2" class="tdsty2">
                                <select id="privType" lay-filter="privTypeFilter" name="privType"><option value="">请选择</option><option value="0">浏览</option><option value="1">下载</option></select>
                            </td>
                            <td class="tdstyl">
                                <label class="layui-form-label" style="">线上咨询结束时间</label>
                            </td>
                            <td colspan="2" class="tdsty2">
                                <select id="docfileClass" lay-filter="docfileClass" name="docfileClass"><option value="">请选择</option></select>
                            </td>
                        </tr>
                        <tr>
                            <td class="tdstyl">
                                <label class="layui-form-label" style=""><span class="red">*</span>是否允许浏览知识模板</label>
                            </td>
                            <td colspan="4" class="tdsty2">
                                <select id="privType" lay-filter="privTypeFilter" name="privType"><option value="">请选择</option><option value="0">浏览</option><option value="1">下载</option></select>
                            </td>
                        </tr>
                        <tr>
                            <td class="tdstyl">
                                <label class="layui-form-label" style=""><span class="red">*</span>开始浏览时间</label>
                            </td>
                            <td colspan="2" class="tdsty2">
                                <select id="privType" lay-filter="privTypeFilter" name="privType"><option value="">请选择</option><option value="0">浏览</option><option value="1">下载</option></select>
                            </td>
                            <td class="tdstyl">
                                <label class="layui-form-label" style="">结束浏览时间</label>
                            </td>
                            <td colspan="2" class="tdsty2">
                                <select id="docfileClass" lay-filter="docfileClass" name="docfileClass"><option value="">请选择</option></select>
                            </td>
                        </tr>
                    </table>
                </div>
            </div>
        </div>
        <button type="button" id="btnSubmit" lay-filter="btnSubmit" lay-submit style="display: none"></button>
    </form>
</div>
<script type="text/javascript">
    //    // 获取地址栏参数值
    function getQueryString(name){
        var reg = new RegExp("(^|&)"+ name +"=([^&]*)(&|$)");
        var r = window.location.search.substr(1).match(reg);
        if(r!=null)return  unescape(r[2]); return null;
    }
    var type = getQueryString("type");
    console.log(type)
    var pdata = parent.parentData;
    console.log(pdata)
    layui.use(['laydate','table','layer','form','eleTree','element'], function () {
        var form = layui.form
            ,layer = layui.layer
            ,$ = layui.jquery
            ,laydate = layui.laydate
            ,element=layui.element
            ,eleTree = layui.eleTree
            ,table = layui.table;


        if (type === 'add'){

        }else if(type === 'edit'||type === 'look'){
            $('#ogrName').val(pdata.ogrName);
            $('#orgId').val(pdata.orgId);
            $('#orgCode').val(pdata.orgCode);
            $('#orgEnterpriseCode').val(pdata.orgEnterpriseCode);
            $('#contactUser').val(pdata.contactUser);
            $('#contactPhone').val(pdata.contactPhone);
            $('#memo').val(pdata.memo);
            if (type === 'look'){
                $('#ogrName').attr("disabled","disabled");
                $('#orgId').attr("disabled","disabled");
                $('#orgCode').attr("disabled","disabled");
                $('#orgEnterpriseCode').attr("disabled","disabled");
                $('#contactUser').attr("disabled","disabled");
                $('#contactPhone').attr("disabled","disabled");
                $('#memo').attr("disabled","disabled");
            }
        }
    })
    function getDate() {
        //debugger
        var obj = {};
        obj.ogrName = $('#ogrName').val();
        //obj.orgId= $('#orgId').val();
        obj.orgCode = $('#orgCode').val();
        obj.orgEnterpriseCode = $('#orgEnterpriseCode').val();
        obj.contactUser= $('#contactUser').val();
        obj.contactPhone = $('#contactPhone').val();
        obj.memo = $('#memo').val();

        return obj;
    }

    //判断undefined
    function undefind_nullStr(value) {
        if(value==undefined || value == "undefined"){
            return ""
        }
        return value
    }

    //选人框架
    var user_id;
    $(document).on("click", "#contactUser", function () {
        user_id='contactUser';
        $.popWindow("../common/selectUserIMAddGroup");
    })
</script>
</body>
</html>
