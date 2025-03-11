<%--
  Created by IntelliJ IDEA.
  User: 吴祖明
  Date: 2021/7/1
  Time: 14:34
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
<title>新建机构</title>
<link rel="stylesheet" type="text/css" href="../../lib/pagination/style/pagination.css"/>
<link rel="stylesheet" type="text/css" href="../../css/base.css"/>
<link rel="stylesheet" type="text/css" href="../../css/news/center.css"/>
<link rel="stylesheet" href="/lib/laydate/need/laydate.css">
<link rel="stylesheet" href="/lib/layui/layui/css/layui.css?20210319.1">
<script type="text/javascript" src="../../js/xoajq/xoajq1.js"></script>
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
<script src="/js/jquery/jquery.cookie.js"></script>
<script src="/js/jquery/jquery.form.min.js"></script>


<style>
    html {
        background: white;
        color: #666;
    }
    .layui-card {
        margin-bottom: 15px;
        border-radius: 2px;
        background-color: #fff;
        box-shadow: none;
    }
    #divBox .layui-table-cell{
        height: auto;
        overflow:visible;
        text-overflow:inherit;
        white-space:normal;
        word-break: break-word;
    }

    .layui-collapse {
        border-style: none;
    }

    .formSelect {
        display: flex;
    }

    .layui-form-select dl {
        max-height: 152px;
    }

    .layui-form-select {
        width: 100%;
    }

    #baseForm > .layui-row {
        margin: 10px 0;
    }
    .layui-form-radio{
        margin: 0;
    }
    #secretaryTable td{
        pointer-events: none;
        cursor: default;
    }
    .header{
        background-color: #e5e5e5;
        font-size: 16px;
        height: 35px;
        line-height: 35px;
    }
    .layui-btn-sm {
        height: 25px;
        line-height: 25px;
        padding: 0 10px;
        font-size: 12px;
        /*float: right;*/
    }
    .headerPic{
        background-color: #e5e5e5;
        font-size: 16px;
        height: 35px;
        width: 94%;
        margin-left: 3%;
        margin-top: 30px;
        line-height: 35px;
    }
    .plusChange{
        float: right;
    }
    #legalForm .layui-form-label {
        float: left;
        display: block;
        padding: 9px 15px;
        width: 130px;
        font-weight: 400;
        line-height: 20px;
        text-align: right;
    }
    .artifical .layui-form-item .layui-input-inline {
        float: left;
         width: 170px;
        margin-right: 10px;
    }
    .openFile input[type=file] {
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
</style>
<link rel="stylesheet" type="text/css" href="/css/commonTheme/${sessionScope.InterfaceModel}/commonTheme.css"/>
</head>
<body>
<div class="container">
    <div class="layui-card">
        <div class="layui-card-body" style="padding-left: 6px;">
            <div class="layui-tab layui-tab-brief" lay-filter="debriefing"  style="width: 100%">
                <ul class="layui-tab-title" id="ulBox">
                    <li class="layui-this"  >基础信息</li>
                    <li id="tab1">法人库信息</li>
                    <li id="tab" >证照信息</li>
                    <li class="banyuan" style="display:none;">办园信息</li>
                    <button type="button" class="layui-btn layui-btn-sm return" style="height: 32px;line-height: 32px;float: right">返回</button>
                </ul>
                <div class="layui-tab-content" id="divBox" style="display: block;position: relative;width:96%;padding: 2px;margin-left: 2%">
                    <%--基础信息--%>
                        <div class="layui-collapse basicInfo">
                            <div class="layui-tab-item layui-show" id="basicInfo" style="margin-top: 20px;">
                                <form class="layui-form" action="" id="basicForm" lay-filter="formTest" style="margin-bottom: 50px;">
                                <%-- 第一行--%>
                                <div class="layui-row">
                                    <div class="layui-col-xs4" style="padding: 0 5px;">
                                        <div class="layui-form-item" >
                                            <div class="layui-inline">
                                                <label class="layui-form-label" >机构简称<span style="color: red; font-size: 15px;">*</span></label>
                                                <div class="layui-input-inline" style="width: 250px;display:contents; ">
                                                    <input type="text" id="orgDept" name="deptName" lay-verify="required|phone" autocomplete="off" class="layui-input noEdit mustEdit" style="width: 55%;display: inline-block;" title="机构简称">
                                                </div>
                                            </div>
                                            <a href="javascript:void(0)" id="selectDept" style="cursor: pointer;color: #207bd6">选择部门</a>
                                        </div>
                                    </div>
                                    <div class="layui-col-xs4" style="padding: 0 5px;">
                                        <div class="layui-form-item" >
                                            <div class="layui-inline" >
                                                <label class="layui-form-label" >机构全称<span style="color: red; font-size: 15px;">*</span></label>
                                                <div class="layui-input-inline">
                                                    <input type="text" name="orgFullname"  lay-verify="required|phone" autocomplete="off" class="layui-input noEdit mustEdit" title="机构全称">
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="layui-col-xs4" style="padding: 0 5px;">
                                        <div class="layui-form-item" >
                                            <div class="layui-inline" >
                                                <label class="layui-form-label" >上级部门<span style="color: red; font-size: 15px;">*</span></label>
                                                <div class="layui-input-inline" style="width: 250px;display:contents; ">
                                                    <input type="text" name="parentOrgId" id="highDept" lay-verify="required|phone" disabled autocomplete="off" class="layui-input mustEdit" style="width: 55%;display: inline-block;" title="上级部门">
                                                </div>
                                            </div>
                                            <a href="javascript:void(0)" name="parentOrgId" id="parentOrgId" style="cursor: pointer;color: #207bd6">选择部门</a>
                                        </div>
                                    </div>
                                </div>
                                <%-- 第二行--%>
                                <div class="layui-row">
                                    <div class="layui-col-xs4" style="padding: 0 5px;">
                                        <div class="layui-form-item" >
                                            <div class="layui-inline">
                                                <label class="layui-form-label" >关联部门</label>
                                                <div class="layui-input-inline" style="width: 250px;display:contents;">
                                                    <input type="text" id="deptId" name="deptId" lay-verify="required|phone" autocomplete="off" disabled class="layui-input" style="width: 55%;">
                                                    <a href="javascript:void(0)" id="aboutDept" style="cursor: pointer;color: #207bd6;display: none">选择部门</a>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="layui-col-xs4" style="padding: 0 5px;">
                                        <div class="layui-form-item" >
                                            <div class="layui-inline" >
                                                <label class="layui-form-label">统一社会信用代码<span style="color: red; font-size: 15px;">*</span></label>
                                                <div class="layui-input-inline">
                                                    <input type="text" name="unifiedCreditCode"  lay-verify="required|phone" autocomplete="off" class="layui-input noEdit mustEdit" title="统一社会信用代码">
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="layui-col-xs4" style="padding: 0 5px;">
                                        <div class="layui-form-item" >
                                            <div class="layui-inline" >
                                                <label class="layui-form-label" >机构编码</label>
                                                <div class="layui-input-inline">
                                                    <input type="text" name="orgNum"  lay-verify="required|phone" autocomplete="off" class="layui-input noEdit" title="机构编码">
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <%-- 第三行--%>
                                <div class="layui-row">
                                    <div class="layui-col-xs4" style="padding: 0 5px;">
                                        <div class="layui-form-item" >
                                            <div class="layui-inline" >
                                                <label class="layui-form-label" >教育部编码</label>
                                                <div class="layui-input-inline">
                                                    <input type="text" name="educationNum"  lay-verify="required|phone" autocomplete="off" class="layui-input noEdit" title="教育部编码">
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="layui-col-xs4" style="padding: 0 5px;">
                                        <div class="layui-form-item" >
                                            <div class="layui-inline" >
                                                <label class="layui-form-label" >分校码</label>
                                                <div class="layui-input-inline">
                                                    <input type="text" name="orgChildNum"  lay-verify="required|phone" autocomplete="off" class="layui-input noEdit" title="分校码">
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="layui-col-xs4" style="padding: 0 5px;">
                                        <div class="layui-form-item" >
                                            <div class="layui-inline">
                                                <label class="layui-form-label" >学校办别</label>
                                                <div class="layui-input-inline" style="width: 90px;">
                                                    <select name="statePrivateId" class="statePrivateId noEdit" lay-verify="required" lay-search="" lay-filter="statePrivateId" title="学校办别">
                                                    </select>
                                                </div>
                                                <div class="layui-input-inline" style="width: 90px;">
                                                    <select name="statePrivateId2" class="statePrivateId2 noEdit" lay-verify="required"  lay-search="" lay-filter="statePrivateId2"lay-search="" title="学校办别">
                                                    </select>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <%-- 第四行--%>
                                <div class="layui-row">
                                    <div class="layui-col-xs4" style="padding: 0 5px;">
                                        <div class="layui-form-item" >
                                            <div class="layui-inline">
                                                <label class="layui-form-label">办学类型</label>
                                                <div class="layui-input-inline">
                                                    <select name="schoolType"  lay-filter="schoolType" class="schoolType noEdit" lay-verify="required" lay-search="" title="办学类型">
                                                        <option value="">请选择</option>
                                                    </select>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="layui-col-xs4" style="padding: 0 5px;">
                                        <div class="layui-form-item" >
                                            <div class="layui-inline">
                                                <label class="layui-form-label">学段</label>
                                                <div class="layui-input-inline">
                                                    <select name="studyPart" class="studyPart noEdit" lay-verify="required" lay-search="" title="学段">
                                                        <option value="">请选择</option>
                                                    </select>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="layui-col-xs4" style="padding: 0 5px;">
                                        <div class="layui-form-item" >
                                            <div class="layui-inline">
                                                <label class="layui-form-label">管理类型</label>
                                                <div class="layui-input-inline">
                                                    <select name="schoolManageType" class="schoolManageType noEdit" lay-verify="required" lay-search="" title="管理类型">
                                                        <option value="">请选择</option>
                                                    </select>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="layui-row">
                                    <div class="layui-col-xs4" style="padding: 0 5px;">
                                        <div class="layui-form-item" >
                                            <div class="layui-inline" >
                                                <label class="layui-form-label" >所在街镇</label>
                                                <div class="layui-input-inline">
                                                    <select name="deptAvenue" class="deptAvenue noEdit" lay-verify="" lay-filter="deptAvenue">
                                                        <option value="">请选择</option>
                                                    </select>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="layui-col-xs4" style="padding: 0 5px;">
                                        <div class="layui-form-item" >
                                            <div class="layui-inline">
                                                <label class="layui-form-label">咨询电话</label>
                                                <div class="layui-input-inline">
                                                    <input type="text" name="telNo"  lay-verify="required|phone" autocomplete="off" class="layui-input noEdit">
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="layui-col-xs4" style="padding: 0 5px;">
                                        <div class="layui-form-item" >
                                            <div class="layui-inline">
                                                <label class="layui-form-label">地址</label>
                                                <div class="layui-input-inline">
                                                    <input type="text" name="deptAddress"  lay-verify="required|phone" autocomplete="off" class="layui-input noEdit">
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                    <div class="layui-row">
                                        <div class="layui-col-xs4" style="padding: 0 5px;">
                                            <div class="layui-form-item" >
                                                <div class="layui-inline">
                                                    <label class="layui-form-label" >邮编</label>
                                                    <div class="layui-input-inline">
                                                        <input type="text" name="deptCode"  lay-verify="required|phone" autocomplete="off" class="layui-input noEdit">
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="layui-col-xs4" style="padding: 0 5px;">
                                            <div class="layui-form-item" >
                                                <div class="layui-inline">
                                                    <label class="layui-form-label">传真</label>
                                                    <div class="layui-input-inline">
                                                        <input type="text" name="faxNo" lay-verify="required|phone" autocomplete="off" class="layui-input noEdit">
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </form>
                                <div style="text-align: center;">
                                    <button type="button" class="layui-btn layui-btn-sm basicSave" style="height: 32px;line-height: 32px;text-align: center">保存</button>
                                </div>
                            </div>
                        </div>
                    <%--法人库信息--%>
                    <div class="layui-collapse artifical">
                        <div class="layui-tab-item" id="artifical" style="margin-top: 20px;">
                            <p class="header"><i class="layui-icon layui-icon-down" style=""></i> 法人登记信息</p>
                            <form class="layui-form" action="" id="legalForm" lay-filter="formTest1">


                                <%-- 第一行--%>
                                <div class="layui-row" style="margin-top: 20px">
                                    <div class="layui-col-xs4" style="padding: 0 5px;">
                                        <div class="layui-form-item" >
                                            <div class="layui-inline">
                                                <label class="layui-form-label" >事业单位证书号</label>
                                                <div class="layui-input-inline">
                                                    <input type="text" name="certificateNo"  lay-verify="required|phone" autocomplete="off" class="layui-input noEdit">
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="layui-col-xs4" style="padding: 0 5px;">
                                        <div class="layui-form-item" >
                                            <div class="layui-inline">
                                                <label class="layui-form-label" >社会组织登记证号</label>
                                                <div class="layui-input-inline">
                                                    <input type="text" name="society" lay-verify="required|phone" autocomplete="off" class="layui-input noEdit">
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="layui-col-xs4" style="padding: 0 5px;">
                                        <div class="layui-form-item" >
                                            <div class="layui-inline">
                                                <label class="layui-form-label">法人类别</label>
                                                <div class="layui-input-inline">
                                                    <input type="text" name="legalType" lay-verify="required|phone" autocomplete="off" class="layui-input noEdit">
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <%-- 第三行--%>
                                <div class="layui-row">
                                    <div class="layui-col-xs4" style="padding: 0 5px;">
                                        <div class="layui-form-item" >
                                            <div class="layui-inline">
                                                <label class="layui-form-label">法定代表人</label>
                                                <div class="layui-input-inline">
                                                    <input type="text" name="legalRepresentative"  lay-verify="required|phone" autocomplete="off" class="layui-input noEdit">
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="layui-col-xs4" style="padding: 0 5px;">
                                        <div class="layui-form-item" >
                                            <div class="layui-inline">
                                                <label class="layui-form-label">法定代表人证件类型</label>
                                                <div class="layui-input-inline">
                                                    <input type="text" name="legalCertificates"  lay-verify="required|phone" autocomplete="off" class="layui-input noEdit">
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="layui-col-xs4" style="padding: 0 5px;">
                                        <div class="layui-form-item" >
                                            <div class="layui-inline">
                                                <label class="layui-form-label" >法定代表人证件号码</label>
                                                <div class="layui-input-inline">
                                                    <input type="text" name="legalcertificatesNo" lay-verify="required|phone" autocomplete="off" class="layui-input noEdit">
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <%-- 第四行--%>
                                <div class="layui-row">
                                    <div class="layui-col-xs4" style="padding: 0 5px;">
                                        <div class="layui-form-item" >
                                            <div class="layui-inline">
                                                <label class="layui-form-label" >法人名称</label>
                                                <div class="layui-input-inline">
                                                    <input type="text" name="legalName" lay-verify="required|phone" autocomplete="off" class="layui-input noEdit">
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="layui-col-xs4" style="padding: 0 5px;">
                                        <div class="layui-form-item" >
                                            <div class="layui-inline">
                                                <label class="layui-form-label">工商注册号</label>
                                                <div class="layui-input-inline">
                                                    <input type="text" name="businessNum" lay-verify="required|phone" autocomplete="off" class="layui-input noEdit">
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="layui-col-xs4" style="padding: 0 5px;">
                                        <div class="layui-form-item" >
                                            <div class="layui-inline" >
                                                <label class="layui-form-label">组织机构代码</label>
                                                <div class="layui-input-inline">
                                                    <input type="text" name="orgNum"  lay-verify="required|phone" autocomplete="off" class="layui-input noEdit">
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="layui-row">
                                        <div class="layui-col-xs4" style="padding: 0 5px;">
                                            <div class="layui-form-item" >
                                                <div class="layui-inline" >
                                                    <label class="layui-form-label" >税务登记号</label>
                                                    <div class="layui-input-inline">
                                                        <input type="text" name="taxNo" lay-verify="required|phone" autocomplete="off" class="layui-input noEdit">
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="layui-col-xs4" style="padding: 0 5px;">
                                            <div class="layui-form-item" >
                                                <div class="layui-inline" >
                                                    <label class="layui-form-label">注册地址/住所/经营场所</label>
                                                    <div class="layui-input-inline">
                                                        <input type="text" name="address"  lay-verify="required|phone" autocomplete="off" class="layui-input noEdit">
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="layui-col-xs4" style="padding: 0 5px;">
                                            <div class="layui-form-item" >
                                                <div class="layui-inline" >
                                                    <label class="layui-form-label" >区划</label>
                                                    <div class="layui-input-inline">
                                                        <input type="text" name="areaCode" lay-verify="required|phone" autocomplete="off" class="layui-input noEdit">
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="layui-row">
                                        <div class="layui-col-xs4" style="padding: 0 5px;">
                                            <div class="layui-form-item" >
                                                <div class="layui-inline" >
                                                    <label class="layui-form-label" >经营范围/业务范围</label>
                                                    <div class="layui-input-inline">
                                                        <input type="text" name="businessScope" lay-verify="required|phone" autocomplete="off" class="layui-input noEdit">
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="layui-col-xs4" style="padding: 0 5px;">
                                            <div class="layui-form-item" >
                                                <div class="layui-inline" >
                                                    <label class="layui-form-label">联络员证件类型</label>
                                                    <div class="layui-input-inline">
                                                        <input type="text" name="contactCerType"  lay-verify="required|phone" autocomplete="off" class="layui-input noEdit">
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="layui-col-xs4" style="padding: 0 5px;">
                                            <div class="layui-form-item" >
                                                <div class="layui-inline" >
                                                    <label class="layui-form-label" >联络员证件号码</label>
                                                    <div class="layui-input-inline">
                                                        <input type="text" name="contactCerNo" lay-verify="required|phone" autocomplete="off" class="layui-input noEdit">
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="layui-row">
                                        <div class="layui-col-xs4" style="padding: 0 5px;">
                                            <div class="layui-form-item" >
                                                <div class="layui-inline" >
                                                    <label class="layui-form-label" >电子邮箱</label>
                                                    <div class="layui-input-inline">
                                                        <input type="text" name="contactEmail" lay-verify="required|phone" autocomplete="off" class="layui-input noEdit">
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="layui-col-xs4" style="padding: 0 5px;">
                                            <div class="layui-form-item" >
                                                <div class="layui-inline" >
                                                    <label class="layui-form-label">联系人姓名</label>
                                                    <div class="layui-input-inline">
                                                        <input type="text" name="contactName"  lay-verify="required|phone" autocomplete="off" class="layui-input noEdit">
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="layui-col-xs4" style="padding: 0 5px;">
                                            <div class="layui-form-item" >
                                                <div class="layui-inline" >
                                                    <label class="layui-form-label" >联络电话</label>
                                                    <div class="layui-input-inline">
                                                        <input type="text" name="contactTelephone" lay-verify="required|phone" autocomplete="off" class="layui-input noEdit">
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="layui-row">
                                        <div class="layui-col-xs4" style="padding: 0 5px;">
                                            <div class="layui-form-item" >
                                                <div class="layui-inline" >
                                                    <label class="layui-form-label" >联络人类型</label>
                                                    <div class="layui-input-inline">
                                                        <input type="text" name="contactType" lay-verify="required|phone" autocomplete="off" class="layui-input noEdit">
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="layui-col-xs4" style="padding: 0 5px;">
                                            <div class="layui-form-item" >
                                                <div class="layui-inline" >
                                                    <label class="layui-form-label">国别(地区)</label>
                                                    <div class="layui-input-inline">
                                                        <input type="text" name="corpCountry"  lay-verify="required|phone" autocomplete="off" class="layui-input noEdit">
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="layui-col-xs4" style="padding: 0 5px;">
                                            <div class="layui-form-item" >
                                                <div class="layui-inline" >
                                                    <label class="layui-form-label" >法人状态</label>
                                                    <div class="layui-input-inline">
                                                        <input type="text" name="corpStatus" lay-verify="required|phone" autocomplete="off" class="layui-input noEdit">
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="layui-row">
                                        <div class="layui-col-xs4" style="padding: 0 5px;">
                                            <div class="layui-form-item" >
                                                <div class="layui-inline" >
                                                    <label class="layui-form-label" >币种</label>
                                                    <div class="layui-input-inline">
                                                        <input type="text" name="currency" lay-verify="required|phone" autocomplete="off" class="layui-input noEdit">
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="layui-col-xs4" style="padding: 0 5px;">
                                            <div class="layui-form-item" >
                                                <div class="layui-inline" >
                                                    <label class="layui-form-label">登记日期</label>
                                                    <div class="layui-input-inline">
                                                        <input type="text" name="establishDate"  id="establish" lay-verify="required|phone" autocomplete="off" class="layui-input noEdit" placeholder="yyyy-MM-dd">
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="layui-col-xs4" style="padding: 0 5px;">
                                            <div class="layui-form-item" >
                                                <div class="layui-inline" >
                                                    <label class="layui-form-label" >工商注册号</label>
                                                    <div class="layui-input-inline">
                                                        <input type="text" name="gszch" lay-verify="required|phone" autocomplete="off" class="layui-input noEdit">
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="layui-row">
                                        <div class="layui-col-xs4" style="padding: 0 5px;">
                                            <div class="layui-form-item" >
                                                <div class="layui-inline" >
                                                    <label class="layui-form-label" >行业类别</label>
                                                    <div class="layui-input-inline">
                                                        <input type="text" name="industryCode" lay-verify="required|phone" autocomplete="off" class="layui-input noEdit">
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="layui-col-xs4" style="padding: 0 5px;">
                                            <div class="layui-form-item" >
                                                <div class="layui-inline" >
                                                    <label class="layui-form-label">经费来源</label>
                                                    <div class="layui-input-inline">
                                                        <input type="text" name="jjly"  lay-verify="required|phone" autocomplete="off" class="layui-input noEdit">
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="layui-col-xs4" style="padding: 0 5px;">
                                            <div class="layui-form-item" >
                                                <div class="layui-inline" >
                                                    <label class="layui-form-label" >经营期限至</label>
                                                    <div class="layui-input-inline">
                                                        <input type="text" name="jyqxzh" id="jyqxzh" lay-verify="required|phone" autocomplete="off" class="layui-input noEdit" placeholder="yyyy-MM-dd">
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="layui-row">
                                        <div class="layui-col-xs4" style="padding: 0 5px;">
                                            <div class="layui-form-item" >
                                                <div class="layui-inline" >
                                                    <label class="layui-form-label" >经营期限自</label>
                                                    <div class="layui-input-inline">
                                                        <input type="text" name="jyqxzi" id="jyqxzi" lay-verify="required|phone" autocomplete="off" class="layui-input noEdit" placeholder="yyyy-MM-dd">
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="layui-col-xs4" style="padding: 0 5px;">
                                            <div class="layui-form-item" >
                                                <div class="layui-inline" >
                                                    <label class="layui-form-label">举办单位/业务主管单位</label>
                                                    <div class="layui-input-inline">
                                                        <input type="text" name="organ"  lay-verify="required|phone" autocomplete="off" class="layui-input noEdit">
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="layui-col-xs4" style="padding: 0 5px;">
                                            <div class="layui-form-item" >
                                                <div class="layui-inline" >
                                                    <label class="layui-form-label" >企业大类</label>
                                                    <div class="layui-input-inline">
                                                        <input type="text" name="subObj" lay-verify="required|phone" autocomplete="off" class="layui-input noEdit">
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="layui-row">
                                        <div class="layui-col-xs4" style="padding: 0 5px;">
                                            <div class="layui-form-item" >
                                                <div class="layui-inline" >
                                                    <label class="layui-form-label" >注册资金/开办资金</label>
                                                    <div class="layui-input-inline">
                                                        <input type="text" name="regCapital" lay-verify="required|phone" autocomplete="off" class="layui-input noEdit">
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="layui-col-xs4" style="padding: 0 5px;">
                                            <div class="layui-form-item" >
                                                <div class="layui-inline" >
                                                    <label class="layui-form-label">注册海关</label>
                                                    <div class="layui-input-inline">
                                                        <input type="text" name="regCustom"  lay-verify="required|phone" autocomplete="off" class="layui-input noEdit">
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="layui-col-xs4" style="padding: 0 5px;">
                                            <div class="layui-form-item" >
                                                <div class="layui-inline" >
                                                    <label class="layui-form-label" >受理机关名称</label>
                                                    <div class="layui-input-inline">
                                                        <input type="text" name="regOrgan" lay-verify="required|phone" autocomplete="off" class="layui-input noEdit">
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="layui-row">
                                        <div class="layui-col-xs4" style="padding: 0 5px;">
                                            <div class="layui-form-item" >
                                                <div class="layui-inline" >
                                                    <label class="layui-form-label" >事业单位证书号</label>
                                                    <div class="layui-input-inline">
                                                        <input type="text" name="registnumber" lay-verify="required|phone" autocomplete="off" class="layui-input noEdit">
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="layui-col-xs4" style="padding: 0 5px;">
                                            <div class="layui-form-item" >
                                                <div class="layui-inline" >
                                                    <label class="layui-form-label">注销日期</label>
                                                    <div class="layui-input-inline">
                                                        <input type="text" name="repealDate"  id="repeal" lay-verify="required|phone" autocomplete="off" class="layui-input noEdit" placeholder="yyyy-MM-dd">
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="layui-col-xs4" style="padding: 0 5px;">
                                            <div class="layui-form-item" >
                                                <div class="layui-inline" >
                                                    <label class="layui-form-label" >注销原因</label>
                                                    <div class="layui-input-inline">
                                                        <input type="text" name="repealReason" lay-verify="required|phone" autocomplete="off" class="layui-input noEdit">
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="layui-row">
                                        <div class="layui-col-xs4" style="padding: 0 5px;">
                                            <div class="layui-form-item" >
                                                <div class="layui-inline" >
                                                    <label class="layui-form-label" >经营地址</label>
                                                    <div class="layui-input-inline">
                                                        <input type="text" name="businessAddress" lay-verify="required|phone" autocomplete="off" class="layui-input noEdit">
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                            </form>
                            <div style="padding: 0px 8px;margin-top: 20px;" class="tableOne">
                                <p class="header"><i class="layui-icon layui-icon-down" style=""></i> 变更信息
                                    <button name="plus" type="button" class="layui-btn layui-btn-normal  layui-btn-sm plusChange">
                                        <i class="layui-icon layui-icon-addition"></i>
                                    </button>
                                </p>
                                <table class="layui-table" id="tableDemocratic" lay-filter="tableDemocratic"></table>
                            </div>
                            <div style="text-align: center;">
                                <button type="button" class="layui-btn layui-btn-sm legalSave" style="height: 32px;line-height: 32px;text-align: center">保存</button>
                            </div>
                        </div>
                    </div>

                    <%--证照信息--%>
                    <div class="layui-tab-item" id="licence" style="margin-top: 20px;">
                        <div class="layui-form" style="display: inline-block;">
                            <input type="radio" name="expired"  lay-filter="expired"  value="1" title="全部证书" checked>
                            <input type="radio" name="expired"  lay-filter="expired" value="2" title="一个月内过期证书">
                            <input type="radio" name="expired"  lay-filter="expired" value="3" title="已过期证书">
                        </div>
                        <form class="layui-form" action="" style="height: 40px;margin: 10px 0 10px 50px;display: inline-block;">
                            <div class="layui-form-item" style="margin-bottom: 0px">
                                <div class="layui-inline" style="margin-bottom: 0px;">
                                    <label class="layui-form-label" style=" margin-left: -21px;">证件照名称</label>
                                    <div class="layui-input-inline">
                                        <input type="text"  lay-verify="required|phone" autocomplete="off" class="layui-input licenceName">
                                    </div>
                                </div>
                                <a class="layui-btn" data-type="reload"  id="search" style="height:32px;line-height: 32px;margin-top: -4px;">查询</a>
                                <a class="layui-btn" data-type="reload"  id="addLicence" style="height:32px;line-height: 32px;margin-top: -4px;">新建</a>
                            </div>
                        </form>
                        <div>
                            <table id="tableDemocratic4" lay-filter="tableDemocratic4"></table>
                        </div>
                    </div>
                        <%--办园信息--%>
                        <div class="layui-tab-item" id="banyuan">
                            <table class="layui-hide" id="banyuantable" lay-filter="banyuantable"></table>
                            <div style="text-align: center;">
                                <button type="button" class="layui-btn layui-btn-sm banyuanbtn" style="height: 32px;line-height: 32px;text-align: center">保存</button>
                            </div>
                        </div>
                </div>
            </div>
        </div>
    </div>
</div>
<script type="text/html" id="barDemo">
    <a class="layui-btn layui-btn-danger layui-btn-xs" lay-event="delete">删除</a>
</script>
<script type="text/html" id="barDemo1">
    <a class="layui-btn layui-btn-xs" lay-event="detail">详情</a>
    <a class="layui-btn layui-btn-xs" lay-event="edit">编辑</a>
    <a class="layui-btn layui-btn-danger layui-btn-xs" lay-event="del">删除</a>
</script>
<script>
    var dept_id;
    var changeInfo,mainMember;
    var orgLegal;
    var tableDemocratic,tableDemocratic1,tableDemocratic2,tableDemocratic3;
    var expiredType = 1;
    // 获取地址栏参数值
    function getQueryString(name){
        var reg = new RegExp("(^|&)"+ name +"=([^&]*)(&|$)");
        var r = window.location.search.substr(1).match(reg);
        if(r!=null)return  unescape(r[2]); return null;
    }
    var type = getQueryString('type')
    var orgId = getQueryString('orgId')

    if(type == '1' || type == '2'){
        var pageNum = getQueryString('pageNum')
    }else{
        var pageNum = 1;
    }
    //返回
    $('.return').click(function () {
        if(type == '1' || type == '2'){
            window.location.href='/EduorgMessage/eduAgencyInfo?retrunType=1&pageNum='+ pageNum
        }else{
            window.location.href='/EduorgMessage/eduAgencyInfo?retrunType=1&pageNum='+ pageNum
        }
    });

    //选部门
    $('#selectDept').click(function () {
        dept_id = 'orgDept';
        $.popWindow("../common/selectDept?0&eduOrg=1");
    });
    //选上级部门
    $('#parentOrgId').click(function () {
        dept_id = 'highDept';
        $.popWindow("../common/selectDept?0&eduOrg=2");
    });
    //选关联部门
    $('#aboutDept').click(function () {
        dept_id = 'deptId';
        $.popWindow("../common/selectDept?0&eduOrg=3");
    });
    //上級部门自动回显
    function selectParent(selectParentId){
        $.ajax({
            type:'get',
            url:'/EduorgMessage/selectByDeptId',
            dataType:'json',
            data: {
                deptId: selectParentId.split(',')[0]
            },
            success:function (res) {
                var object = res.object;
                if(object.deptParentName != undefined){
                    $('#highDept').val(object.deptParentName)
                    $('#highDept').attr('deptid',object.deptParent+',')
                }
                if(object.deptName != undefined){
                    $('#deptId').val(object.deptName)
                    $('#deptId').attr('deptid',object.deptId)
                }

            }
        })
    }
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
    //变更信息  ,event: 'changeTime'
    var cols = [[
        { type:'checkbox'}
        ,{field:'changeMatter', title:'变更事项',align:'center',edit: true}
        ,{field:'changeBefore', title:'变更前内容',align:'center',edit: true}
        ,{field:'changeAfter', title:'变更后内容',align:'center',edit: true}
        ,{field:'changeDate', title:'变更日期',align:'center',edit: true}
        ,{field:'changeRegister', title:'变更登记机关',align:'center',edit: true}
        ,{title:'操作', toolbar: '#barDemo',align:'center'}
    ]]
    var tablePlus = [{
        changeMatter: ""
        ,changeBefore: ''
        ,changeAfter:''
        ,changeDate: ""
        ,changeRegister: ''
        // ,right:''
    }];
    $(function(){
        layui.use(['form', 'table', 'laypage','element','laydate','layer'], function () {
            var laydate = layui.laydate;
            var form = layui.form;
            var table = layui.table;
            var layer = layui.layer;
            var element = layui.element;
            form.render();

            //办学类型下拉框
            $.ajax({
                type:'get',
                url:'/code/getCode?parentNo=SCHOOLE_TYPE',
                dataType:'json',
                success:function (res) {
                    var data = res.obj;
                    var schoolType = '';
                    if(res.flag){
                        if(data.length>0){
                            for(var i=0;i<data.length;i++){
                                schoolType += '<option value="' + data[i].codeNo + '">' + data[i].codeName + '</option>'
                            }
                        }
                        $('.schoolType').append(schoolType);
                        form.render();
                    }
                }
            })

            //管理类型下拉框
            $.ajax({
                type:'get',
                url:'/code/getCode?parentNo=SCHOOL_MANAGE_TYPE',
                dataType:'json',
                success:function (res) {
                    var data = res.obj;
                    var schoolManageType = '';
                    if(res.flag){
                        if(data.length>0){
                            for(var i=0;i<data.length;i++){
                                schoolManageType += '<option value="' + data[i].codeNo + '">' + data[i].codeName + '</option>'
                            }
                        }
                        $('.schoolManageType').append(schoolManageType);
                        form.render();
                    }
                }
            })
            //所在街镇下拉框
            $.ajax({
                type:'get',
                url:'/code/getCode?parentNo=DEPT_AVENUE',
                dataType:'json',
                success:function (res) {
                    var data = res.obj;
                    var deptAvenue = '';
                    if(res.flag){
                        if(data.length>0){
                            for(var i=0;i<data.length;i++){
                                deptAvenue += '<option value="' + data[i].codeNo + '">' + data[i].codeName + '</option>'
                            }
                        }
                        $('.deptAvenue').append(deptAvenue);
                        form.render();
                    }
                }
            })
            // 办别级联下拉选
            $.ajax({
                type:'get',
                url:'/code/getCode?parentNo=STATE_PRIVATE_ID',
                dataType:'json',
                success:function (res) {
                    var data = res.obj;
                    var statePrivateId = '<option value="">请选择</option>';
                    if(res.flag){
                        if(data.length>0){
                            for(var i=0;i<data.length;i++){
                                statePrivateId += '<option value="' + data[i].codeNo + '">' + data[i].codeName + '</option>'
                            }
                        }
                        $('.statePrivateId').append(statePrivateId);
                        form.render();
                    }
                }
            })
            //学段下拉框
            $.ajax({
                type:'get',
                url:'/code/getCode?parentNo=STUDY_PART',
                dataType:'json',
                success:function (res) {
                    var data = res.obj;
                    var studyPart = '';
                    if(res.flag){
                        if(data.length>0){
                            for(var i=0;i<data.length;i++){
                                studyPart += '<option value="' + data[i].codeNo + '">' + data[i].codeName + '</option>'
                            }
                        }
                        $('.studyPart').append(studyPart);
                        form.render();
                    }
                }
            })
            laydate.render({
                elem: '#establish'
                , type: 'date'
            });
            laydate.render({
                elem: '#jyqxzh'
                , type: 'date'
            });
            laydate.render({
                elem: '#jyqxzi'
                , type: 'date'
            });
            laydate.render({
                elem: '#repeal'
                , type: 'date'
            });

            var type = getQueryString('type')
            if(type == '1' || type == '2' ||type == '3'){
                var legalId;
                var changeId = [];
                var memberId = [];
                var cancelId = [];
                //基础信息回显
                $.ajax({
                    url:'/EduorgMessage/selectAllByOrgId',
                    dataType:'json',
                    data:{orgId:orgId},
                    success:function(res){
                        var datas = res.object;
                        form.val("formTest",datas);
                        if(datas.schoolType=='4'){
                            $('.banyuan').show()
                        }
                        $.ajax({
                            type:'get',
                            url:'/code/getCode?parentNo=STATE_PRIVATE_ID2'+ '_' + datas.statePrivateId,
                            dataType:'json',
                            success:function (res) {
                                var data = res.obj;
                                var statePrivateId2 = '<option value="">请选择</option>';
                                if(res.flag){
                                    if(data.length>0){
                                        for(var i=0;i<data.length;i++){
                                            if(data[i].codeNo==datas.statePrivateId2){
                                                statePrivateId2 += '<option value="' + data[i].codeNo + '" selected>' + data[i].codeName + '</option>'
                                            }else {
                                                statePrivateId2 += '<option value="' + data[i].codeNo + '">' + data[i].codeName + '</option>'
                                            }


                                        }
                                    }
                                    $('.statePrivateId2').append(statePrivateId2);
                                    form.render()
                                }
                            }
                        })

                        $('#highDept').val(datas.deptParentName)
                        $('#deptId').val(datas.deptName)
                        $('#highDept').attr('deptid',datas.parentOrgId+',')
                        $('#deptId').attr('deptid',datas.deptId)
                    }

                })
                //法人库登记信息回显
                $.ajax({
                    url:'/EduorgLegal/selectByOrgId',
                    dataType:'json',
                    data:{orgId:orgId},
                    success:function(res){
                        var datas = res.obj[0];
                        legalId = datas.legalId;
                        form.val("formTest1",datas);
                    }

                })
                //变更信息回显
                $.ajax({
                    url:'/EduorgChanage/selectByOrgId',
                    dataType:'json',
                    data:{orgId:orgId},
                    success:function(res){
                        var data = res.obj;
                        for(var i = 0; i < data.length; i++){
                            changeId.push(data[i].changeId)
                            var temp = {};
                            temp.changeMatter = data[i].changeMatter;
                            temp.changeBefore = data[i].changeBefore;
                            temp.changeAfter = data[i].changeAfter
                            temp.changeDate = data[i].changeDate;
                            temp.changeRegister = data[i].changeRegister;
                            tablePlus[i] = temp
                        }
                        changeInfo.reload()
                    }

                })
                if(type == '2' ||type == '3'){
                    $('.basicSave').hide();
                    $('.legalSave').hide();
                    $('.noEdit').attr('disabled','disabled')
                }else{
                    $('.basicSave').show();
                    $('.legalSave').show();
                }
                //基础信息编辑保存
                $('.basicSave').on('click',function(){
                    //必填项提示
                    for(var i=0; i<$('.mustEdit').length; i++){
                        if ($('.mustEdit').eq(i).val() == '') {
                            layer.msg($('.mustEdit').eq(i).attr('title') + '为必填项！', {icon: 0});
                            return false
                        }
                    }
                    $('#basicForm').attr('action','/EduorgMessage/updateByOrgId')
                    $('#basicForm').ajaxSubmit({
                        type: 'post',
                        dataType: 'json',
                        data:{
                            orgId:orgId,
                            parentOrgId: $('#highDept').attr('deptid').split(',')[0],
                            deptId: $('#deptId').attr('deptid'),
                        },
                        success: function (json) {

                            if(json.flag){
                                $.layerMsg({content: '编辑成功' ,icon:1});
                                if($('.schoolType').val()!='4'){
                                    $(' .banyuan').hide()
                                }else {
                                    $('.banyuan').show()
                                }
                            }else{
                                $.layerMsg({content:json.msg,icon:2});
                            }
                        }
                    })
                })
                //法人库信息编辑保存
                $('.legalSave').on('click',function(){
                    //法人登记信息
                    $('#legalForm').attr('action','/EduorgLegal/updateByLegalId')
                    $('#legalForm').ajaxSubmit({
                        type: 'post',
                        dataType: 'json',
                        data: {
                            legalId:legalId,
                            orgId: orgId
                        },
                        success: function (json) {
                            if(json.flag){
                                $.layerMsg({content:'保存成功！',icon:1});
                            }else{
                                $.layerMsg({content:'保存失败！',icon:1});
                            }
                        }
                    })
                    //变更信息编辑
                    var tableDemocratic = layui.table.cache["tableDemocratic"];
                    var $tr = $('.tableOne').find('.layui-table-main tr');
                    $tr.each(function (index) {
                        tableDemocratic[index].orgId = orgId
                        tableDemocratic[index].changeId = changeId[index]
                    });
                    $.ajax({
                        url: '/EduorgChanage/updateByChangeId?orgId=' + orgId,
                        dataType:'json',
                        type:'post',
                        contentType: 'application/json;charset=UTF-8',
                        data: JSON.stringify(tableDemocratic),
                        success: function (data) {
                            if(data.flag == true){
                                layer.msg('保存成功！', {icon: 1, time: 2000});
                            }else{
                                layer.msg('保存失败！', {icon: 5, time: 2000});
                            }
                        }
                    })
                })
            }else{
                //基础信息保存
                $('.basicSave').on('click',function(){
                    //必填项提示
                    for(var i=0; i<$('.mustEdit').length; i++){
                        if ($('.mustEdit').eq(i).val() == '') {
                            layer.msg($('.mustEdit').eq(i).attr('title') + '为必填项！', {icon: 0});
                            return false
                        }
                    }
                    $('#basicForm').attr('action','/EduorgMessage/insert')
                    $('#basicForm').ajaxSubmit({
                        type: 'post',
                        dataType: 'json',
                        data: {
                            parentOrgId: $('#highDept').attr('deptid').split(',')[0],
                            deptId: $('#deptId').attr('deptid'),
                            orgId: orgLegal
                        },
                        success: function (json) {
                            if(json.flag){
                                orgId = json.object.orgId
                                orgLegal = json.object.orgId
                                $.layerMsg({content:'保存成功！',icon:1});
                                $('#deptId').val(json.object.deptName)
                                $('#deptId').attr('deptid',json.object.deptId)
                            }else{
                                layer.msg(json.msg, {icon: 5});
                            }
                        }
                    })
                })
                //法人库信息保存
                $('.legalSave').on('click',function(){
                    //法人登记信息保存
                    var data = {};
                    if(orgLegal == null || orgLegal == undefined){
                        data = {}
                    }else{
                        data = {
                            orgId:orgLegal
                        }
                    }
                    $('#legalForm').attr('action','/EduorgLegal/insert')
                    $('#legalForm').ajaxSubmit({
                        type: 'post',
                        dataType: 'json',
                        data: data,
                        success: function (json) {
                            if(json.flag){
                                $.layerMsg({content:'保存法人登记信息成功！',icon:1});
                            }else{
                                $.layerMsg({content:'保存法人登记信息失败！',icon:1});
                            }
                        }
                    })
                    //变更信息保存
                    var tableDemocratic = layui.table.cache["tableDemocratic"];
                    var $tr = $('.tableOne').find('.layui-table-main tr');
                    if(orgLegal != null || orgLegal != undefined){
                        $tr.each(function (index) {
                            tableDemocratic[index].orgId = orgLegal
                        });
                    }
                    $.ajax({
                        url: '/EduorgChanage/insert?orgId=' + orgLegal,
                        dataType:'json',
                        type:'post',
                        contentType: 'application/json;charset=UTF-8',
                        data: JSON.stringify(tableDemocratic),
                        success: function (data) {
                            if(data.flag == true){

                                layer.msg('变更信息保存成功！', {icon: 1, time: 2000});
                            }else{
                                layer.msg('变更信息保存失败！', {icon: 5, time: 2000});
                            }
                        }
                    })
                })
            }
            //办别二级下拉选
            form.on('select(statePrivateId)',function(){
                $('.statePrivateId2').html('')
                var statePrivateId1 = $('.statePrivateId').val()
                $.ajax({
                    type:'get',
                    url:'/code/getCode?parentNo=STATE_PRIVATE_ID2'+ '_' + statePrivateId1,
                    dataType:'json',
                    success:function (res) {
                        var data = res.obj;
                        var statePrivateId2 = '<option value="">请选择</option>';
                        if(res.flag){
                            if(data.length>0){
                                for(var i=0;i<data.length;i++){
                                    statePrivateId2 += '<option value="' + data[i].codeNo + '">' + data[i].codeName + '</option>'
                                }
                            }
                            $('.statePrivateId2').append(statePrivateId2);
                            form.render()
                        }
                    }
                })
            })
            //监听Tab切换
            element.on('tab(debriefing)', function (data) {
                if (data.index==0||data.index=="0"){
                    $('#basicInfo').addClass('layui-show');
                    $('#artifical').removeClass('layui-show');
                    $('#licence').removeClass('layui-show');
                    $('#banyuan').removeClass('layui-show');

                }else if(data.index==1||data.index=="1"){
                    //基础信息填写完毕后切换法人
                    for(var i=0; i<$('.mustEdit').length; i++){
                        if ($('.mustEdit').eq(i).val() == '') {
                            layer.msg('基础信息未填写完毕！', {icon: 0});
                            return false
                        }
                    }
                    $('#basicInfo').removeClass('layui-show');
                    $('#artifical').addClass('layui-show');
                    $('#licence').removeClass('layui-show');
                    $('#banyuan').removeClass('layui-show');
                }else if(data.index==2||data.index=="2"){
                    //基础信息填写完毕后切换证照
                    for(var i=0; i<$('.mustEdit').length; i++){
                        if ($('.mustEdit').eq(i).val() == '') {
                            layer.msg('基础信息未填写完毕！', {icon: 0});
                            return false
                        }
                    }
                    $('#basicInfo').removeClass('layui-show');
                    $('#artifical').removeClass('layui-show');
                    $('#licence').addClass('layui-show');
                    $('#banyuan').removeClass('layui-show');
                }else if(data.index==3||data.index=="3"){
                    //基础信息填写完毕后切换证照
                    for(var i=0; i<$('.mustEdit').length; i++){
                        if ($('.mustEdit').eq(i).val() == '') {
                            layer.msg('基础信息未填写完毕！', {icon: 0});
                            return false
                        }
                    }
                    $('#basicInfo').removeClass('layui-show');
                    $('#artifical').removeClass('layui-show');
                    $('#licence').removeClass('layui-show');
                    $('#banyuan').addClass('layui-show')

                }

            });

            //变更信息表格渲染
            changeInfo = table.render({
                elem: '#tableDemocratic'
                ,data : tablePlus
                ,cols: cols

            });
            //变更信息加行
            $('button[name="plus"]').click(function () {
                tableDemocratic = layui.table.cache["tableDemocratic"];
                tableDemocratic.push({
                    changeMatter: ""
                    ,changeBefore: ''
                    ,changeAfter:''
                    ,changeDate: ""
                    ,changeRegister: ''
                });
                table.reload('tableDemocratic', {
                    data: tableDemocratic
                });
            });
            table.on('tool(tableDemocratic)', function(obj){
                var data = obj.data;
                var orgId = data.orgId;
                var tr = obj.tr;
                if (obj.event === 'changeTime') { //变更日期
                    var field = $(this).data('field');
                    var index = tr.attr("data-index");
                    laydate.render({
                        elem: this.firstChild
                        , show: true
                        , done: function (value, date) {
                            table.cache["tableDemocratic"][index][field] = value
                        }
                    });
                }else if(obj.event === 'delete'){
                    var index = tr.attr("data-index");
                    obj.del(tr);
                }
            });

            //监听单选按钮
            form.on('radio(expired)', function(data){
                var licenceName = $('.licenceName').val();
                console.log(data)
                expiredType = data.value;
                if(expiredType == '1'){
                    table.reload('tableDemocratic4', {
                        where: {
                            expired: '',
                            licenceName: licenceName
                        }
                    });
                }else if(expiredType == '2'){
                    table.reload('tableDemocratic4', {
                        where: {
                            expired: 'one',
                            licenceName: licenceName
                        }
                    });
                }else{
                    table.reload('tableDemocratic4', {
                        where: {
                            expired: 'expired',
                            licenceName: licenceName
                        }
                    });
                }


            });

            form.render();
            //证照信息表格渲染

            table.on('tool(tableDemocratic4)', function(obj){
                var data = obj.data;
                var licenceId = data.licenceId;
                if (obj.event === 'detail') {
                    licence('2',licenceId,data)
                }else if(obj.event === 'del'){
                    layer.confirm('确定要删除该数据吗？', function(index){
                        $.ajax({
                            url:'/license/deleteEduorgLicenseById',
                            data:{
                                licenceId: licenceId,
                            },
                            dataType:'json',
                            type:'get',
                            success:function(res){
                                if(res.flag){
                                    layer.msg('删除成功',{icon:1});
                                    table.reload("tableDemocratic4")
                                }
                            }
                        })
                        layer.close(index);

                    });
                }else if(obj.event === 'edit'){
                    licence('1',licenceId,data)
                }
            });

            // 新建证照
            $('#addLicence').on('click',function(){
                licence()
            })
            function licence(type2,licenceId,datas){
                if(type2 == '1'){
                    var title = '编辑证照'
                }else if(type2 == '2'){
                    var title = '证照详情'
                }else{
                    var title = '新建证照'
                }
                layer.open({
                    type: 1,
                    area: ['70%', '70%'], //宽高
                    title: title,
                    maxmin:true,
                    btn: ['保存','取消'], //可以无限个按钮
                    content: '<div class="layui-collapse artifical">\n' +
                        '                            <form class="layui-form" action="" id="licencePart" lay-filter="formTest2">\n' +
                        '                            <p class="headerPic" ><i class="layui-icon layui-icon-down" style=""></i> 基础信息</p>\n' +
                        '                                <%-- 第一行--%>\n' +
                        '                                <div class="layui-row" style="margin-top: 20px;">\n' +
                        '                                    <div class="layui-col-xs4" style="padding: 0 5px;">\n' +
                        '                                        <div class="layui-form-item" >\n' +
                        '                                            <div class="layui-inline">\n' +
                        '                                                <label class="layui-form-label" >证照名称<span style="color: red; font-size: 15px;">*</span></label>\n' +
                        '                                                <div class="layui-input-inline">\n' +
                        '                                                    <input type="text" name="licenceName"  lay-verify="required|phone" autocomplete="off" class="layui-input jinyong mustEdit" title="证照名称">\n' +
                        '                                                </div>\n' +
                        '                                            </div>\n' +
                        '                                        </div>\n' +
                        '                                    </div>\n' +
                        '                                    <div class="layui-col-xs4" style="padding: 0 5px;">\n' +
                        '                                        <div class="layui-form-item" >\n' +
                        '                                            <div class="layui-inline" >\n' +
                        '                                                <label class="layui-form-label" >机构名称<span style="color: red; font-size: 15px;">*</span></label>\n' +
                        '                                                <div class="layui-input-inline">\n' +
                        '                                                    <input type="text" name="deptName" lay-verify="required|phone" autocomplete="off" disabled class="layui-input jinyong mustEdit" title="机构名称">\n' +
                        '                                                </div>\n' +
                        '                                            </div>\n' +
                        '                                        </div>\n' +
                        '                                    </div>\n' +
                        '                                    <div class="layui-col-xs4" style="padding: 0 5px;">\n' +
                        '                                        <div class="layui-form-item" >\n' +
                        '                                            <div class="layui-inline" >\n' +
                        '                                                <label class="layui-form-label" >有效日期<span style="color: red; font-size: 15px;">*</span></label>\n' +
                        '                                                <div class="layui-input-inline">\n' +
                        '                                                    <input type="text" name="effectiveDate" id="effectiveDate"  autocomplete="off" class="layui-input jinyong mustEdit" title="有效日期">\n' +
                        '                                                </div>\n' +
                        '                                            </div>\n' +
                        '                                        </div>\n' +
                        '                                    </div>\n' +
                        '                                </div>\n' +
                        '                                <%-- 第二行--%>\n' +
                        '                                <div class="layui-row">\n' +
                        '                                    <div class="layui-col-xs4" style="padding: 0 5px;">\n' +
                        '                                        <div class="layui-form-item" >\n' +
                        '                                            <div class="layui-inline" >\n' +
                        '                                                <label class="layui-form-label">到期日期<span style="color: red; font-size: 15px;">*</span></label>\n' +
                        '                                                <div class="layui-input-inline">\n' +
                        '                                                    <input type="text" name="expireDate"  id="expireDate" lay-verify="required|phone" autocomplete="off" title="到期日期" class="layui-input jinyong mustEdit">\n' +
                        '                                                </div>\n' +
                        '                                            </div>\n' +
                        '                                        </div>\n' +
                        '                                    </div>\n' +
                        '                                    <div class="layui-col-xs4" style="padding: 0 5px;">\n' +
                        '                                        <div class="layui-form-item" >\n' +
                        '                                            <div class="layui-inline" >\n' +
                        '                                                <label class="layui-form-label" >发证日期</label>\n' +
                        '                                                <div class="layui-input-inline">\n' +
                        '                                                    <input type="text" name="issueDate" id="issueDate" lay-verify="required|phone" autocomplete="off" class="layui-input jinyong">\n' +
                        '                                                </div>\n' +
                        '                                            </div>\n' +
                        '                                        </div>\n' +
                        '                                    </div>\n' +
                        '                                    <div class="layui-col-xs4" style="padding: 0 5px;">\n' +
                        '                                        <div class="layui-form-item" >\n' +
                        '                                            <div class="layui-inline" >\n' +
                        '                                                <label class="layui-form-label" >年检日期</label>\n' +
                        '                                                <div class="layui-input-inline">\n' +
                        '                                                    <input type="text" name="yearlyInspectionDate" id="yearlyInspectionDate" lay-verify="required|phone" autocomplete="off" class="layui-input jinyong">\n' +
                        '                                                </div>\n' +
                        '                                            </div>\n' +
                        '                                        </div>\n' +
                        '                                    </div>\n' +
                        '                                </div>\n' +
                        '                                <%-- 第三行--%>\n' +
                        '                                <div class="layui-row">\n' +
                        '                                    <div class="layui-col-xs4" style="padding: 0 5px;">\n' +
                        '                                        <div class="layui-form-item" >\n' +
                        '                                            <div class="layui-inline">\n' +
                        '                                                <label class="layui-form-label" >发证单位</label>\n' +
                        '                                                <div class="layui-input-inline">\n' +
                        '                                                    <input type="text" name="issuingUnit" lay-verify="required|phone" autocomplete="off" class="layui-input jinyong">\n' +
                        '                                                </div>\n' +
                        '                                            </div>\n' +
                        '                                        </div>\n' +
                        '                                    </div>\n' +
                        '                                    <div class="layui-col-xs4" style="padding: 0 5px;">\n' +
                        '                                        <div class="layui-form-item" >\n' +
                        '                                            <div class="layui-inline">\n' +
                        '                                                <label class="layui-form-label">证照类型<span style="color: red; font-size: 15px;">*</span></label>\n' +
                        '                                                <div class="layui-input-inline">\n' +
                        '                                                    <select type="text" name="licenseTypeId" lay-verify="required|phone" autocomplete="off" class="jinyong mustEdit" title="证照类型" lay-filter="licenseTypeId">\n' +
                        '                                                    </select>\n' +
                        '                                                </div>\n' +
                        '                                            </div>\n' +
                        '                                        </div>\n' +
                        '                                    </div>\n' +
                        '                                </div>\n' +
                        '                                <div class="layui-row">' +
                        '                                    <div class="layui-col-xs12" style="padding: 0 5px;">\n' +
                        '                                        <div class="layui-form-item" >\n' +
                        '                                            <div class="layui-inline">\n' +
                        '                                                <label class="layui-form-label">附件<span style="color: red; font-size: 15px;">*</span></label>\n' +
                        '                                               <div class="layui-input-block" style="padding-top: 9px">\n' +
                        '                                                   <div id="fileAllAgenda" style="text-align: left;"></div>\n' +
                        '                                                   <a href="javascript:;" class="openFile" style="float: left;position:relative">\n' +
                        '                                                       <img src="../img/mg11.png" alt="">\n' +
                        '                                                       <span>添加附件</span>\n' +
                        '                                                       <input type="file" multiple id="fileuploadAgenda" data-url="../upload?module=meeting" name="file">\n' +
                        '                                                   </a>\n' +
                        '                                                </div>' +
                        '                                            </div>\n' +
                        '                                        </div>\n' +
                        '                                    </div>\n' +
                        '                                </div>\n' +
                        '                            </form>\n' +
                        '                            <p class="headerPic"><i class="layui-icon layui-icon-down" style=""></i> 自定义属性（根据证照类型自动获取）</p>\n' +
                        '                             <div class="customize" > </div>' +
                        '                    </div>',
                    success:function () {
                        laydate.render({
                            elem: '#effectiveDate'
                            , type: 'date'
                        });
                        laydate.render({
                            elem: '#issueDate'
                            , type: 'date'
                        });
                        laydate.render({
                            elem: '#yearlyInspectionDate'
                            , type: 'date'
                        });
                        laydate.render({
                            elem: '#expireDate'
                            , type: 'date'
                        });
                        fileuploadFn('#fileuploadAgenda',$('#fileAllAgenda'));
                        if(type == "1" || type == "2"){
                            var jgmc = orgId
                        }else{
                            var jgmc = orgLegal
                        }
                        $.ajax({
                            type: 'get',
                            url: '/EduorgMessage/selectAllByOrgId',
                            dataType: 'json',
                            data: {
                                orgId: jgmc
                            },
                            success: function (res) {
                                var object = res.object;
                                $('input[name="deptName"]').val(object.deptName)
                            }
                        });
                        $.ajax({
                            type: 'get',
                            url: '/licenseType/selectLicenseTypeByCond',
                            dataType: 'json',
                            success: function (res) {
                                var object = res.data;
                                var strs = '<option value="">请选择</option>';
                                for(var i=0; i<object.length;i++){
                                    strs += '<option value="' + object[i].licenseTypeId + '">' + object[i].licenseTypeName + '</option>';
                                }
                                $('select[name="licenseTypeId"]').append(strs)
                                if(type2 == "1" || type2 == "2"){
                                    $('select[name="licenseTypeId"]').find('option').each(function (i,n) {
                                        if($(this).val()== datas.licenseTypeId){
                                            $(this).attr('selected','selected')
                                            return false
                                        }
                                    })
                                }
                                form.render();
                            }
                        })
                        //动态显示自定义属性
                        form.on('select(licenseTypeId)', function(data){
                            $.ajax({
                                type: 'get',
                                url: '/licenseType/selectLicTypeById',
                                dataType: 'json',
                                data: {
                                    licenseTypeId: data.value
                                },
                                success: function (res) {
                                    var object = res.obj;
                                    var strs = '';
                                    for(var i=0; i<object.length;i++){
                                        strs +=  '     <div class="layui-row" style="margin-top: 10px">\n' +
                                            '                 <div class="layui-col-xs4" style="padding: 0 5px;">\n' +
                                            '                        <div class="layui-form-item" >\n' +
                                            '                             <div class="layui-inline">\n' +
                                            '                                  <label class="layui-form-label" >' + object[i] + '</label>\n' +
                                        '                                  <div class="layui-input-inline">\n' +
                                        '                                        <input type="text" name="col'+ (i+1) + '" lay-verify="required|phone" autocomplete="off" class="layui-input jinyong">\n' +
                                        '                                  </div>\n' +
                                        '                             </div>\n' +
                                        '                        </div>\n' +
                                        '                 </div>\n' +
                                        '          </div>\n';
                                    }
                                    $('.customize').html(strs)
                                    form.render();
                                }
                            })
                        });
                        form.render();
                        if(type2 == "1" || type2 == "2"){
                            if(type == "1" || type == "2"){
                                var param = {
                                    orgId: orgId,
                                    licenceId: licenceId
                                }
                            }else{
                                var param = {
                                    orgId: orgLegal,
                                    licenceId: licenceId
                                }
                            }
                            $.ajax({
                                type: 'get',
                                url: '/license/selectLicenseById',
                                dataType: 'json',
                                data: param,
                                success: function (res) {
                                    var object = res.object;
                                    var licTypeName = object.licTypeName;
                                    var licTypeVal = object.licTypeVal;
                                    form.val("formTest2",object);
                                    if(licTypeName != undefined && licTypeName != null ){
                                        var strEdit = ''
                                        for(var i=0; i<licTypeName.length; i++){
                                            if(licTypeName[i] != ''){
                                                strEdit +=  '     <div class="layui-row" style="margin-top: 10px">\n' +
                                                    '                 <div class="layui-col-xs4" style="padding: 0 5px;">\n' +
                                                    '                        <div class="layui-form-item" >\n' +
                                                    '                             <div class="layui-inline">\n' +
                                                    '                                  <label class="layui-form-label" >' + licTypeName[i] + '</label>\n' +
                                                    '                                  <div class="layui-input-inline">\n' +
                                                    '                                        <input type="text" lay-verify="required|phone" autocomplete="off" class="layui-input jinyong" value="'+ licTypeVal[i] + '">\n' +
                                                    '                                  </div>\n' +
                                                    '                             </div>\n' +
                                                    '                        </div>\n' +
                                                    '                 </div>\n' +
                                                    '          </div>\n';
                                            }
                                        }
                                        $('.customize').html(strEdit)
                                        form.render();
                                        if(type2 == '2'){
                                            $('.jinyong').attr('disabled','disabled')
                                        }
                                    }
                                    var strr = ''
                                    if((object.attUrl[0] != undefined && object.attUrl.length>0)){
                                        for(var i=0;i<object.attUrl.length;i++){
                                            var str1 = ""
                                            if( object.attUrl[i].attUrl != undefined ){
                                                str1 = '<div class="dech" deurl="' +object.attUrl[i].attUrl + '">' +
                                                    '<a href="/download?' + object.attUrl[i].attUrl + '" name="'+object.attUrl[i].attachName+'*" style="text-decoration:none;margin-left:5px;">' +
                                                    '<img src="/img/attachment_icon.png">' + object.attUrl[i].attachName + '</a>' +
                                                    '<img class="deImgs" style="margin-left:5px;cursor: pointer;" src="/img/file/icon_deletecha_03.png">' +
                                                    '<input type="hidden" class="inHidden" value="' + object.attUrl[i].aid + '@' + object.attUrl[i].ym + '_' + object.attUrl[i].attachId +',">' +
                                                    '<a onclick="pdurls($(this))" href="javascript:;" style="padding-left: 5px">' +
                                                    '<img src="/img/attachmentIcon/icon_skim.png" style="padding: 0 5px;">查阅</a>' +
                                                    '<a style="padding-left: 5px" href="/download?' + object.attUrl[i].attUrl + '">' +
                                                    '<img src="/img/attachmentIcon/icon_down.png" style="padding: 0 5px;">下载</a>\n' +
                                                    '</div>' +
                                                    '</div>'
                                            }else{
                                                str1 = '';
                                            }
                                            strr += str1;
                                        }
                                    }else {
                                        strr='';
                                    }
                                    $('#fileAllAgenda').html(strr);
                                }
                            })
                            if(type2 == '2'){
                                $('.jinyong').attr('disabled','disabled')
                                $('.layui-layer-btn0').css('display','none')
                            }
                        }

                    },
                    yes: function(index, layero){
                        //必填项提示
                        for(var i=0; i<$('.mustEdit').length; i++){
                            if ($('.mustEdit').eq(i).val() == '') {
                                layer.msg($('.mustEdit').eq(i).attr('title') + '为必填项！', {icon: 0});
                                return false
                            }
                        }
                        var inputItem = $('.customize').find('input');
                        // 附件
                        var attachmentId = '';
                        var attachmentName = '';
                        for (var i = 0; i < $('#fileAllAgenda .dech').length; i++) {
                            attachmentId += $('#fileAllAgenda .dech').eq(i).find('input').val();
                            attachmentName += $('#fileAllAgenda a').eq(i).attr('name');
                        }
                        if(attachmentId == '' || attachmentId == undefined){
                            layer.msg('附件为必填项', {icon: 0});
                            return false
                        }
                        if(type == '1' || type == '2' ||type == '3'){
                            if(type2 == '1'){
                                var url = "/license/updateEduorgLicenseById";
                                var data = {
                                    orgId: orgId,
                                    licenceId: licenceId,
                                    attachmentId: attachmentId,
                                    attachmentName: attachmentName
                                }
                                for(var i=0; i<inputItem.length; i++){
                                    data["col"+ (i+1)] = $(inputItem[i]).val();
                                }
                            }else{
                                var url = "/license/addEduorgLicense";
                                var data = {
                                    orgId: orgId,
                                    attachmentId: attachmentId,
                                    attachmentName: attachmentName
                                }
                                for(var i=0; i<inputItem.length; i++){
                                    data["col"+ (i+1)] = $(inputItem[i]).val();
                                }

                            }
                        }else{
                            if(type2 == '1'){
                                var url = "/license/updateEduorgLicenseById";
                                var data = {
                                    orgId: orgLegal,
                                    licenceId: licenceId,
                                    attachmentId: attachmentId,
                                    attachmentName: attachmentName
                                }
                                for(var i=0; i<inputItem.length; i++){
                                    data["col"+ (i+1)] = $(inputItem[i]).val();
                                }
                            }else{
                                var url = "/license/addEduorgLicense";
                                var data = {
                                    orgId: orgLegal,
                                    attachmentId: attachmentId,
                                    attachmentName: attachmentName
                                }
                                for(var i=0; i<inputItem.length; i++){
                                    data["col"+ (i+1)] = $(inputItem[i]).val();
                                }
                            }
                        }
                        $('#licencePart').attr('action',url)
                        $('#licencePart').ajaxSubmit({
                            type: 'post',
                            dataType: 'json',
                            data: data,
                            success: function (json) {
                                if(json.flag){
                                    // licenceId = json.licenceId
                                    $.layerMsg({content:'保存成功！',icon:1});
                                    table.reload('tableDemocratic4',{
                                        where: {
                                            orgId:orgLegal,
                                            expired: '',
                                        }
                                    })
                                }else{
                                    $.layerMsg({content:json.msg,icon:1});
                                }
                            }
                        })
                        layer.close(index);
                    }
                });
            }
            // 删除附件
            $(document).on('click', '.deImgs', function () {
                var data = $(this).parents('.dech').attr('deUrl');
                var dome = $(this).parents('.dech');
                deleteChatment(data, dome);
            })
            //附件删除
            function deleteChatment(data, element) {
                layer.confirm('确定删除附件吗？', {
                    btn: ['确定', '取消'], //按钮
                    title: "删除附件"
                }, function () {
                    //确定删除，调接口
                    $.ajax({
                        type: 'get',
                        url: '../delete',
                        dataType: 'json',
                        data: data,
                        success: function (res) {
                            if (res.flag == true) {
                                layer.msg('删除成功', {icon: 6});
                                element.remove();
                            } else {
                                layer.msg('<fmt:message code="lang.th.deleSucess" />', {icon: 6});
                            }
                        }
                    });
                }, function (index) {
                    layer.close(index);
                });
            }
            $('#search').on('click',function(){
                var licenceName = $('.licenceName').val();
                if(expiredType == '1'){
                    table.reload('tableDemocratic4', {
                        where: {
                            expired: '',
                            licenceName: licenceName,
                        }
                    });
                }else if(expiredType == '2'){
                    table.reload('tableDemocratic4', {
                        where: {
                            expired: 'one',
                            licenceName: licenceName,
                        }
                    });
                }else{
                    table.reload('tableDemocratic4', {
                        where: {
                            expired: 'expired',
                            licenceName: licenceName
                        }
                    });
                }
            })
            $(document).on('click','#tab',function(){
                var orgIds = orgId
                if(orgIds != '' && orgIds != null && orgIds != undefined){
                    fu()
                }else{
                    $('#basicInfo').addClass('layui-show');
                    $('#artifical').removeClass('layui-show');
                    $('#licence').removeClass('layui-show');
                    $('#banyuan').removeClass('layui-show')
                    // layer.msg('请先保存', {icon: 1});
                }

            })
            $(document).on('click','#tab1',function(){
                var orgIds = orgId
                if(orgIds != '' && orgIds != null && orgIds != undefined){

                }else{
                    $('#basicInfo').addClass('layui-show');
                    $('#artifical').removeClass('layui-show');
                    $('#licence').removeClass('layui-show');
                    $('#banyuan').removeClass('layui-show');
                    // layer.msg('请先保存', {icon: 1});
                }

            })
            $(document).on('click','.banyuan',function(){
                var orgIds = orgId

                if(orgIds != '' && orgIds != null && orgIds != undefined){

                }else{
                    $('#basicInfo').addClass('layui-show');
                    $('#artifical').removeClass('layui-show');
                    $('#licence').removeClass('layui-show');
                    $('#banyuan').removeClass('layui-show');
                    // layer.msg('请先保存', {icon: 1});
                }
                banyuan()
                function banyuan(){
                    $.get('/EduorgMessage/selectClassInformation',{orgId:orgIds},function(res){
                        var banyuan=[{ }]
                        if(res.obj!=''){
                            var banyuan=res.obj
                        }
                        table.render({
                            elem: '#banyuantable'
                            , data:banyuan
                            , cols: [[
                                {field: '班级数', title: '年级',align: 'center',templet: function (d) {
                                        return '<input type="text" readonly  autocomplete="off" class="layui-input" style="height: 100%;text-align: center;border: none;" value="班级数">'
                                    }},
                                {field: 'trusteeshipClass', title: '托班', templet: function (d) {
                                        return '<input type="number" name="trusteeshipClass" '+(type==2||type == 3 ? 'readonly' : '')+'   autocomplete="off" class="layui-input" style="height: 100%;text-align: center;border: none;" value="' + (d.trusteeshipClass || '') + '">'
                                    }
                                },
                                {field: 'littleClass', title: '小班', align: 'center',templet: function (d) {
                                        return '<input type="number" name="littleClass" '+(type==2||type == 3 ? 'readonly' : '')+'   autocomplete="off" class="layui-input" style="height: 100%;text-align: center;border: none;" value="' + (d.littleClass || '') + '">'
                                    }},
                                {field: 'middleClass', title: '中班', align: 'center',templet: function (d) {
                                        return '<input type="number" name="middleClass" '+(type==2||type == 3 ? 'readonly' : '')+'   autocomplete="off" class="layui-input" style="height: 100%;text-align: center;border: none;" value="' + (d.middleClass || '') + '">'
                                    }},
                                {field: 'bigClass', title: '大班', align: 'center',templet: function (d) {
                                        return '<input type="number" name="bigClass" '+(type==2||type == 3 ? 'readonly' : '')+'   autocomplete="off" class="layui-input" style="height: 100%;text-align: center;border: none;" value="' + (d.bigClass || '') + '">'
                                    }},
                                {field: 'specialEducationClass', title: '特教班', align: 'center',templet: function (d) {
                                        return '<input type="number" name="specialEducationClass" '+(type==2||type == 3 ? 'readonly' : '')+'   autocomplete="off" class="layui-input" style="height: 100%;text-align: center;border: none;" value="' + (d.specialEducationClass || '') + '">'
                                    }},
                                {field: 'mixedAgeClass', title: '混龄班', align: 'center',templet: function (d) {
                                        return '<input type="number" name="mixedAgeClass" '+(type==2||type == 3 ? 'readonly' : '')+'   autocomplete="off" class="layui-input" style="height: 100%;text-align: center;border: none;" value="' + (d.mixedAgeClass || '') + '">'
                                    }},
                                {field: 'classTotal', title: '合计', align: 'center',templet: function (d) {
                                        return '<input type="number" name="classTotal" '+(type==2||type == 3 ? 'readonly' : '')+'   autocomplete="off" class="layui-input" style="height: 100%;text-align: center;border: none;" value="' + (d.classTotal || '') + '">'
                                    }},
                            ]]
                            ,parseData: function(res){ //res 即为原始返回的数据
                                return {
                                    "code": 0, //解析接口状态
                                    "data": res.obj, //解析数据列表
                                    "count": res.totleNum, //解析数据长度
                                };
                            },
                        })
                    })
                }

                if(type==2){
                    $('.banyuanbtn').hide()
                }
                $('.banyuanbtn').click(function(){
                    var $tr = $('#banyuan').find('.layui-table-main tr');
                    var materialDetailsObj ;
                    $tr.each(function () {
                     materialDetailsObj = {
                            classTotal: $(this).find('input[name="classTotal"]').val(),
                            trusteeshipClass: $(this).find('input[name="trusteeshipClass"]').val(),
                            littleClass: $(this).find('input[name="littleClass"]').val(),
                            middleClass: $(this).find('input[name="middleClass"]').val(),
                            bigClass: $(this).find('input[name="bigClass"]').val(),
                            specialEducationClass: $(this).find('input[name="specialEducationClass"]').val(),
                            mixedAgeClass: $(this).find('input[name="mixedAgeClass"]').val(),
                            changeType:'2'
                        }
                    })
                    $.ajax({
                        type: 'post',
                        url: '/EduorgMessage/updateClassInformation?orgId='+orgIds,
                        dataType: 'json',
                        data:materialDetailsObj,
                        success: function (res) {
                            if (res.flag) {
                                layer.msg('保存成功！', {icon: 1});
                                layer.closeAll();
                                banyuan()
                            } else {
                                layer.msg('保存失败！', {icon: 2});
                            }
                        }

                    })
                })
            })
            function fu(){
                table.render({
                    elem: '#tableDemocratic4'
                    ,url:'/license/selectListLicenseByCond?useFlag=true'
                    ,parseData: function(res){ //res 即为原始返回的数据
                        return {
                            "code": 0, //解析接口状态
                            "data": res.obj, //解析数据列表
                            "count": res.totleNum, //解析数据长度
                        };
                    },
                    where: {
                        orgId:orgId,
                        expired: '',
                    }
                    ,title: '用户数据表'
                    ,cols: [[
                        {field:'licenceName', title:'证照名称',align:'center'}
                        ,{field:'deptName', title:'机构名称',align:'center'}
                        ,{field:'licenseTypeName', title:'证照类别',align:'center'}
                        ,{field:'effectiveDate', title:'有效日期',align:'center'}
                        ,{field:'expireDate', title:'到期日期',align:'center'}
                        ,{field:'attachmentName', title:'附件',align:'center', templet: function (d) {
                                var strr = ''
                                var object=d
                                if(d.attUrl==undefined){
                                    return ''
                                }else{
                                    for(var i=0;i<object.attUrl.length;i++){
                                        var str1 = ""
                                        if( object.attUrl[i].attUrl != undefined ){
                                            str1 = '' +
                                                '<div class="dech" deurl="' +object.attUrl[i].attUrl + '">' +
                                                '<a href="/download?' + object.attUrl[i].attUrl + '" name="'+object.attUrl[i].attachName+'*" style="text-decoration:none;margin-left:5px;">' +
                                                '<img src="/img/attachment_icon.png">' + object.attUrl[i].attachName + '</a>' +
                                                '' +
                                                '<img class="deImgs" style="margin-left:5px;cursor: pointer;" src="/img/file/icon_deletecha_03.png">' +
                                                '<input type="hidden" class="inHidden" value="' + object.attUrl[i].aid + '@' + object.attUrl[i].ym + '_' + object.attUrl[i].attachId +',">' +
                                                '<a onclick="pdurls($(this))" href="javascript:;" style="padding-left: 5px">' +
                                                '<img src="/img/attachmentIcon/icon_skim.png" style="padding: 0 5px;">查阅</a>' +
                                                '<a style="padding-left: 5px" href="/download?' + object.attUrl[i].attUrl + '">' +
                                                '<img src="/img/attachmentIcon/icon_down.png" style="padding: 0 5px;">下载</a>\n' +
                                                '</div>' +
                                                '</div>'
                                        }else{
                                            str1 = '';
                                        }
                                        strr += str1;
                                    }
                                    return str1
                                }
                            }}
                        ,{fixed: 'right', title:'操作', toolbar: '#barDemo1',align:'center'}
                    ]],
                    page:true

                });
            }
        })

    })


</script>

</body>
</html>
