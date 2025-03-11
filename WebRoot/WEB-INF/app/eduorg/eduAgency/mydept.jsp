<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@taglib prefix="mvc" uri="http://www.springframework.org/tags/form" %>
<%@taglib prefix="fmt" uri="http://www.springframework.org/tags" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
%>

<html>
<head>

    <title>我的机构</title>
    <meta name="renderer" content="webkit">
    <meta http-equiv="X-UA-Compatible" content="IE=10,chrome=1">
    <meta name="viewport"
          content="width=device-width, initial-scale=1.0, user-scalable=0, minimum-scale=1.0, maximum-scale=1.0">
    <link rel="stylesheet" href="/lib/layui/layui/css/layui.css?20210319.1">
    <link rel="stylesheet" href="/lib/layui/layui/css/layui.css">
    <link rel="stylesheet" href="/lib/layui/layui/css/eleTree.css">
        <script type="text/javascript" src="/js/xoajq/xoajq1.js"></script>
        <script type="text/javascript" src="/lib/layui/layui/layui.all_v2.5.js"></script>
    <script type="text/javascript" src="/js/base/base.js"></script>
    <script type="text/javascript" src="/js/base/tablePage.js"></script>
    <script type="text/javascript" src="/lib/layui/layui/global.js?20201229.1"></script>
    <script type="text/javascript" src="/lib/layui/layui/lay/mymodules/tableFilter.js"></script>
    <script type="text/javascript" src="/lib/layui/layui/lay/mymodules/tableChild.js"></script>
    <script type="text/javascript" src="/lib/layui/layui/lay/mymodules/tableMerge.js"></script>
    <script type="text/javascript" src="/lib/jQuery-File-Upload-master/jquery-ui.js"></script>
    <script type="text/javascript" src="/lib/jQuery-File-Upload-master/jquery.iframe-transport.js"></script>
    <script type="text/javascript" src="/lib/jQuery-File-Upload-master/jquery.fileupload.js"></script>
    <script type="text/javascript" src="/js/email/fileupload.js"></script>
    <script type="text/javascript" src="/js/common/fileupload.js"></script>
    <script type="text/javascript" src="/js/planbudget/common.js?20210413"></script>
<%--    <script src="//res.layui.com/layui/dist/layui.js" charset="utf-8"></script>--%>
    <script src="../js/jquery/jquery.cookie.js"></script>
    <script src="../../lib/laydate/laydate.js"></script>
    <script src="/lib/jQuery-File-Upload-master/jquery-ui.js" type="text/javascript" charset="utf-8"></script>
    <script src="/lib/jQuery-File-Upload-master/jquery.iframe-transport.js" type="text/javascript" charset="utf-8"></script>
    <script src="/lib/jQuery-File-Upload-master/jquery.fileupload.js" type="text/javascript" charset="utf-8"></script>
    <script src="/js/jquery/jquery.form.min.js"></script>





    <style>
        .openFile input[type=file] {
            position: absolute;
            top: 13px;
            right: 0;
            bottom: 0;
            left: 0;
            width: 100%;
            height: 18px;
            z-index: 99;
            opacity: 0;
        }
        .layui-table-cell{
            height: 40px!important;
        }
        .locality-p {
            height: 40px;
            /*background: #3791DA;*/
            /*color: #fff;*/
            font-size: 18px;
            line-height: 40px;
            /*border-bottom:1px solid #9E9E9E;*/
            display: inline-block;
            padding: 0 10px;
            margin: 10px;
            /*border-radius: 10px;*/
            /*border-right: 1px solid;*/
        }

        /*.content{*/
        /*    height: 100%;*/
        /*}*/
        /* region 上传附件样式 */
        /*.file_upload_box {*/
        /*    position: relative;*/
        /*    height: 22px;*/
        /*    overflow: hidden;*/
        /*}*/

        .open_file {
            float: left;
            position: relative;
        }
        .layui-col-xs4{
            height: 70px;
        }
        .open_file input[type=file] {
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            z-index: 2;
            opacity: 0;
        }
        .imgs{
            position: absolute;
            margin: 2px;
            margin-left: 20px;
        }
        .layui-table th{
            text-align: center!important;
        }
        .operationDiv{
            position: absolute;
            width: 150px;
            border: #ccc 1px solid;
            border-radius: 4px;
            background-color: #ffffff;
            z-index: 99;
        }
        #x1{
            margin-top: 0px!important;
        }
        .layui-table-view{
            width: 100% !important;
        }
        .layui-table-main{
            overflow-x: hidden!important;
        }
        .layui-table-page{
            text-align: right;
        }
        .layui-form-label{
            margin-top: 20px;
            width: 100px;
        }
        .layui-table-view .layui-table td{
            height: 50px;
        }
        .layui-input-inline{
            width: 200px;
            margin-top: 20px;
        }
        .layui-layer-tips{
            z-index: 9999999999 !important;
        }
        .layui-table-cell{
            height: auto;
            overflow: visible;
            text-overflow: inherit;
            white-space: normal ;
            word-break: break-word;
        }
        .layui-table-cell, .layui-table-tool-panel li {
            text-overflow: ellipsis;
            white-space: nowrap;
            overflow: hidden;}
        .layui-table-body {
            overflow-x: auto !important;
        }
    </style>
    <link rel="stylesheet" type="text/css" href="/css/commonTheme/theme6/commonTheme.css"/>
</head>
<body>
<div style="margin-left: 20px"><h1 style="margin-top: 20px">我的机构</h1></div>
<input type="hidden" id="userId">
<div class="layui-tab layui-tab-card" style="margin-top: 20px">
    <ul class="layui-tab-title">
        <li class="layui-this jiben">基本信息</li>
        <li class="faren">法人库信息</li>
        <li class="zhengzhao">证照信息</li>
        <li class="banyuan">办园信息</li>
        <li class="shenhe" >审核数据</li>
    </ul>
    <div class="layui-tab-content" style="height: 74%">
        <div class="layui-tab-item layui-show " id="jiben">
            <%-- 页面1--%>
            <div class="container">
                <div>
                    <form class="layui-form" action="">

                        <div class="layui-inline" >
                            <label class="layui-form-label">机构简称</label>
                            <div class="layui-input-inline">
                                <input disabled="disabled" id="deptName" name="deptName" class="layui-input" type="text">
                            </div>
                        </div>
                        <div class="layui-inline" style="margin-left: 5%">
                            <label class="layui-form-label">机构全称</label>
                            <div class="layui-input-inline">
                                <input disabled="disabled" id="orgFullname" name="orgFullname" class="layui-input" type="text">
                            </div>
                        </div>
                        <div class="layui-inline" style="margin-left: 5%">
                            <label class="layui-form-label">上级部门名称</label>
                            <div class="layui-input-inline">
                                <input disabled="disabled" id="deptParentName" name="deptParentName" class="layui-input" type="text">
                            </div>
                        </div>
                    </form></div>
                <div>
                    <form class="layui-form" action="">
                        <div class="layui-inline">
                            <label class="layui-form-label">关联部门名称</label>
                            <div class="layui-input-inline">
                                <input disabled="disabled" id="deptIdName" name="deptIdName" class="layui-input" type="text">
                            </div>
                        </div>
                        <div class="layui-inline" style="margin-left: 5%">
                            <label class="layui-form-label" >统一信用代码</label>
                            <div class="layui-input-inline">
                                <input disabled="disabled" id="unifiedCreditCode" name="unifiedCreditCode" class="layui-input" type="text">
                            </div>
                        </div>
                        <div class="layui-inline" style="margin-left: 5%">
                            <label class="layui-form-label">机构编码</label>
                            <div class="layui-input-inline">
                                <input disabled="disabled" id="orgNum2" name="orgNum2" class="layui-input" type="text">
                            </div>
                        </div>
                    </form></div>
                <div>
                    <form class="layui-form" action="">
                        <div class="layui-inline">
                            <label class="layui-form-label">教育部编码</label>
                            <div class="layui-input-inline">
                                <input disabled="disabled" id="educationNum" name="educationNum" class="layui-input" type="text">
                            </div>
                        </div>
                        <div class="layui-inline" style="margin-left: 5%">
                            <label class="layui-form-label">分校码</label>
                            <div class="layui-input-inline">
                                <input disabled="disabled" id="orgChildNum" name="orgChildNum" class="layui-input" type="text">
                            </div>
                        </div>
                        <div class="layui-inline" style="margin-left: 5%">
                            <label class="layui-form-label">学校办别</label>
                            <div class="layui-input-inline">
                                <input disabled="disabled" id="statePrivateId" name="statePrivateId" class="layui-input" type="text">
                            </div>
                        </div>
                    </form></div>
                <div>
                    <form>
                        <div class="layui-form">
                            <div class="layui-inline"   >
                                <label class="layui-form-label" >办学类型</label>
                                <div class="layui-input-inline">
                                    <input disabled="disabled" id="schoolType" name="schoolType" class="layui-input" type="text">
                                </div>
                            </div>

                            <div class="layui-inline"   style="margin-left: 5%" >
                                <label class="layui-form-label">学段</label>
                                <div class="layui-input-inline">
                                    <input disabled="disabled" id="studyPart" name="studyPart" class="layui-input" type="text">
                                </div>
                            </div>
                            <div class="layui-inline"   style="margin-left: 5%" >
                                <label class="layui-form-label">管理类型</label>
                                <div class="layui-input-inline">
                                    <input disabled="disabled" id="schoolManageType" name="schoolManageType" class="layui-input" type="text">
                                </div>
                            </div>

                        </div>

                    </form>
                </div>

                <div><form>
                    <div class="layui-inline" >
                        <label class="layui-form-label">所在街镇</label>
                        <div class="layui-input-inline">
                            <input disabled="disabled" id="deptAvenue" name="deptAvenue" class="layui-input" type="text">
                        </div>
                    </div>
                    <div class="layui-inline"  style="margin-left: 5%" >
                        <label class="layui-form-label">咨询电话</label>
                        <div class="layui-input-inline">
                            <input id="telNo" name="telNo" class="layui-input" type="text">
                        </div>
                    </div>
                    <div class="layui-inline" style="margin-left: 5%">
                        <label class="layui-form-label">地址</label>
                        <div class="layui-input-inline">
                            <input id="deptAddress" name="deptAddress" class="layui-input" type="text">
                        </div>
                    </div>
                </form></div>

                <div><form>
                    <div class="layui-inline" >
                        <label class="layui-form-label">邮编</label>
                        <div class="layui-input-inline">
                            <input id="deptCode" name="deptCode" class="layui-input" type="text">
                        </div>
                    </div>
                    <div class="layui-inline"style="margin-left: 5%" >
                        <label class="layui-form-label">传真</label>
                        <div class="layui-input-inline">
                            <input id="faxNo" name="faxNo" class="layui-input" type="text">
                        </div>
                    </div>

                </form></div>
                <div style="text-align: center">
                <button  class="layui-btn" id="save1" style="margin-top: 50px" type="button">提交审核</button>
                </div>
            </div>
        </div>
        <div class="layui-tab-item" id="page2">
            <%-- 页面2--%>

                <div class="oneClick" style="background: #e5e5e5;margin-top: 20px">
                    <img id="img5" class="imgs" src="/ui/img/selectX.png"></img>
                    <h2 style="margin-left: 5%;height: 40px;
    line-height: 40px;">法人登记信息</h2></div>

                <div class="one1" style="background-color: white;" >
                    <div>
                        <div class="layui-inline"  >
                            <label class="layui-form-label">事业单位证书号</label>
                            <div class="layui-input-inline">
                                <input disabled="disabled" id="certificateNo" name="certificateNo  " class="layui-input" type="text">
                            </div>
                        </div>
                        <div class="layui-inline"  style="margin-left: 5%">
                            <label class="layui-form-label">社会组织登记证号</label>
                            <div class="layui-input-inline">
                                <input disabled="disabled" id="society" name="society " class="layui-input" type="text">
                            </div>
                        </div>
                    <div class="layui-inline"  style="margin-left: 5%">
                        <label class="layui-form-label">法人类别</label>
                        <div class="layui-input-inline">
                            <input disabled="disabled" id="legalType" name="legalType " class="layui-input" type="text">
                        </div>
                    </div>
                        </div>
                    <div>
                        <div class="layui-inline" >
                            <label class="layui-form-label">法人代表人</label>
                            <div class="layui-input-inline">
                                <input disabled="disabled" id="legalRepresentative" name="legalRepresentative " class="layui-input" type="text">
                            </div>
                        </div>
                        <div class="layui-inline" style="margin-left: 5%">
                            <label class="layui-form-label">法定代表人证件类型</label>
                            <div class="layui-input-inline">
                                <input disabled="disabled" id="legalCertificates" name="legalCertificates " class="layui-input" type="text">
                            </div>
                        </div>
                        <div class="layui-inline" style="margin-left: 5%">
                            <label class="layui-form-label">法定代表人证件号码</label>
                            <div class="layui-input-inline">
                                <input disabled="disabled" id="legalcertificatesNo" name="legalcertificatesNo " class="layui-input" type="text">
                            </div>
                        </div>
                    </div>
                    <div>
                        <div class="layui-inline" >
                            <label class="layui-form-label">法人名称</label>
                            <div class="layui-input-inline">
                                <input disabled="disabled" id="legalName" name="legalName " class="layui-input" type="text">
                            </div>
                        </div>
                        <div class="layui-inline" style="margin-left: 5%">
                            <label class="layui-form-label">工商注册号</label>
                            <div class="layui-input-inline">
                                <input id="businessNum" disabled="disabled"  name="businessNum " class="layui-input" type="text">
                            </div>
                        </div>
                        <div class="layui-inline" style="margin-left: 5%">
                            <label class="layui-form-label">组织机构代码</label>
                            <div class="layui-input-inline">
                                <input disabled="disabled" id="orgNum1" name="orgNum1" class="layui-input" type="text">
                            </div>
                        </div>
                    </div>
                    <div>
                        <div class="layui-inline" >
                            <label class="layui-form-label">税务登记号</label>
                            <div class="layui-input-inline">
                                <input disabled="disabled" id="taxNo1" name="taxNo1" class="layui-input" type="text">
                            </div>
                        </div>
                        <div class="layui-inline" style="margin-left: 5%">
                            <label class="layui-form-label">注册地址/住所/经营场所</label>
                            <div class="layui-input-inline">
                                <input disabled="disabled" id="address" name="address " class="layui-input" type="text">
                            </div>
                        </div>
                        <div class="layui-inline" style="margin-left: 5%">
                            <label class="layui-form-label">区划</label>
                            <div class="layui-input-inline">
                                <input disabled="disabled" id="areaCode" name="areaCode " class="layui-input" type="text">
                            </div>
                        </div>
                </div>
                    <div>
                        <div class="layui-inline" >
                            <label class="layui-form-label">经营范围/业务范围</label>
                            <div class="layui-input-inline">
                                <input disabled="disabled" id="businessScope" name="businessScope  " class="layui-input" type="text">
                            </div>
                        </div>
                        <div class="layui-inline" style="margin-left: 5%">
                            <label class="layui-form-label">联络员证件类型</label>
                            <div class="layui-input-inline">
                                <input disabled="disabled" id="contactCerType" name="contactCerType " class="layui-input" type="text">
                            </div>
                        </div>
                        <div class="layui-inline" style="margin-left: 5%">
                            <label class="layui-form-label">联络员证件号码</label>
                            <div class="layui-input-inline">
                                <input disabled="disabled" id="contactCerNo" name="contactCerNo " class="layui-input" type="text">
                            </div>
                        </div>
                    </div>
                    <div>
                        <div class="layui-inline" >
                            <label class="layui-form-label">电子邮箱</label>
                            <div class="layui-input-inline">
                                <input disabled="disabled" id="contactEmail" name="contactEmail " class="layui-input" type="text">
                            </div>
                        </div>
                        <div class="layui-inline" style="margin-left: 5%">
                            <label class="layui-form-label">联络人姓名</label>
                            <div class="layui-input-inline">
                                <input disabled="disabled" id="contactName" name="contactName " class="layui-input" type="text">
                            </div>
                        </div>
                        <div class="layui-inline" style="margin-left: 5%">
                            <label class="layui-form-label">联系电话</label>
                            <div class="layui-input-inline">
                                <input disabled="disabled" id="contactTelephone" name="contactTelephone " class="layui-input" type="text">
                            </div>
                        </div>
                    </div>
                    <div>
                        <div class="layui-inline" >
                            <label class="layui-form-label">联络人类型</label>
                            <div class="layui-input-inline">
                                <input disabled="disabled" id="contactType" name="contactType " class="layui-input" type="text">
                            </div>
                        </div>
                        <div class="layui-inline" style="margin-left: 5%">
                            <label class="layui-form-label">国别(地区)</label>
                            <div class="layui-input-inline">
                                <input disabled="disabled" id="corpCountry" name="corpCountry " class="layui-input" type="text">
                            </div>
                        </div>
                        <div class="layui-inline" style="margin-left: 5%">
                            <label class="layui-form-label">法人状态</label>
                            <div class="layui-input-inline">
                                <input disabled="disabled" id="corpStatus" name="corpStatus " class="layui-input" type="text">
                            </div>
                        </div>
                    </div>
                    <div>
                        <div class="layui-inline" >
                            <label class="layui-form-label">币种</label>
                            <div class="layui-input-inline">
                                <input disabled="disabled" id="currency" name="currency  " class="layui-input" type="text">
                            </div>
                        </div>
                        <div class="layui-inline" style="margin-left: 5%">
                            <label class="layui-form-label">登记日期</label>
                            <div class="layui-input-inline">
                                <input disabled="disabled" id="establish1" name="establish1" class="layui-input" type="text">
                            </div>
                        </div>
                        <div class="layui-inline" style="margin-left: 5%">
                            <label class="layui-form-label">经营地址</label>
                            <div class="layui-input-inline">
                                <input disabled="disabled" id="businessAddress" name="businessAddress " class="layui-input" type="text">
                            </div>
                        </div>
                    </div>
                    <div>
                        <div class="layui-inline" >
                            <label class="layui-form-label">行业类别</label>
                            <div class="layui-input-inline">
                                <input disabled="disabled" id="industryCode" name="industryCode   " class="layui-input" type="text">
                            </div>
                        </div>
                        <div class="layui-inline" style="margin-left: 5%">
                            <label class="layui-form-label">经费来源</label>
                            <div class="layui-input-inline">
                                <input disabled="disabled" id="jjly" name="jjly  " class="layui-input" type="text">
                            </div>
                        </div>
                        <div class="layui-inline" style="margin-left: 5%">
                            <label class="layui-form-label">经营期限至</label>
                            <div class="layui-input-inline">
                                <input disabled="disabled" id="jyqxzh" name="jyqxzh   " class="layui-input" type="text">
                            </div>
                        </div>
                    </div>
                    <div>
                        <div class="layui-inline" >
                            <label class="layui-form-label">经营期限自</label>
                            <div class="layui-input-inline">
                                <input disabled="disabled" id="jyqxzi" name="jyqxzi " class="layui-input" type="text">
                            </div>
                        </div>
                        <div class="layui-inline" style="margin-left: 5%">
                            <label class="layui-form-label">举办单位/业务主管单位</label>
                            <div class="layui-input-inline">
                                <input disabled="disabled" id="organ" name="organ " class="layui-input" type="text">
                            </div>
                        </div>
                        <div class="layui-inline" style="margin-left: 5%">
                            <label class="layui-form-label">企业大类</label>
                            <div class="layui-input-inline">
                                <input disabled="disabled" id="subObj" name="subObj " class="layui-input" type="text">
                            </div>
                        </div>
                    </div>
                    <div>
                        <div class="layui-inline" >
                            <label class="layui-form-label">注册资金/开办资金</label>
                            <div class="layui-input-inline">
                                <input disabled="disabled" id="regCapital" name="regCapital " class="layui-input" type="text">
                            </div>
                        </div>
                        <div class="layui-inline" style="margin-left: 5%">
                            <label class="layui-form-label">注册海关</label>
                            <div class="layui-input-inline">
                                <input disabled="disabled" id="regCustom" name="regCustom  " class="layui-input" type="text">
                            </div>
                        </div>
                        <div class="layui-inline" style="margin-left: 5%">
                            <label class="layui-form-label">受理机关名称</label>
                            <div class="layui-input-inline">
                                <input disabled="disabled" id="regOrgan" name="regOrgan " class="layui-input" type="text">
                            </div>
                        </div>
                    </div>
                    <div>
                        <div class="layui-inline" >
                            <label class="layui-form-label">事业单位证书号</label>
                            <div class="layui-input-inline">
                                <input disabled="disabled" id="registnumber" name="registnumber " class="layui-input" type="text">
                            </div>
                        </div>
                        <div class="layui-inline" style="margin-left: 5%">
                            <label class="layui-form-label">注销日期</label>
                            <div class="layui-input-inline">
                                <input disabled="disabled" id="repealDate" name="repealDate" class="layui-input" type="text">
                            </div>
                        </div>
                        <div class="layui-inline" style="margin-left: 5%">
                            <label class="layui-form-label">注销原因</label>
                            <div class="layui-input-inline">
                                <input disabled="disabled" id="repealReason" name="repealReason " class="layui-input" type="text">
                            </div>
                        </div>
                    </div>
                </div>

                <div class="twoClick" style="background: #e5e5e5;margin-top: 20px">
                    <img id="img1" class="imgs" src="/ui/img/selectX.png"></img>
                    <h2 style="margin-left: 5%;height: 40px;
    line-height: 40px;">变更信息</h2>
                    <div style="display: none"><button name="plus" id="plus" type="button" class="layui-btn layui-btn-normal  layui-btn-sm" style="margin-top: 5px;margin-top: -35px; margin-right: 10px;
    position: relative;display: inline-block;float: right"><i class="layui-icon layui-icon-addition"></i></button></div>
                </div>

                <div class="two1" style="background-color: white;margin-top: 20px" >

                        <div  class="layui-form" id="planTableDiv">
    <form action="" id="planTi">
        <table class="layui-hide"  id="tableDemocratic" lay-filter="tableDemocratic"></table>
    </form>
                        </div>

                    </div>

<%--                <div class="threeClick" style="background: #e5e5e5;margin-top: 20px">--%>
<%--                    <img id="img2" src="/ui/img/selectX.png"></img>--%>
<%--                    <h2 style="margin-left: 5%;height: 40px;--%>
<%--    line-height: 40px;">主要成员</h2>--%>
<%--                    <div><button name="plus1" id="plus1" type="button" class="layui-btn layui-btn-normal  layui-btn-sm" style="margin-top: 5px;margin-top: -35px; margin-right: 10px;--%>
<%--    position: relative;display: inline-block;float: right"><i class="layui-icon layui-icon-addition"></i></button></div>--%>
<%--                </div>--%>

<%--                <div class="three1" style="background-color: white;margin-top: 20px" >--%>

<%--                    <div  class="layui-form">--%>
<%--                        <form action="" id="planTi">--%>
<%--                            <table class="layui-hide" id="plan1" lay-filter="plan1"></table>--%>
<%--                        </form>--%>
<%--                    </div>--%>

<%--                </div>--%>

<%--                <div class="fourClick" style="background: #e5e5e5;margin-top: 20px">--%>
<%--                    <img id="img3" src="/ui/img/selectX.png"></img>--%>
<%--                    <h2 style="margin-left: 5%;height: 40px;--%>
<%--    line-height: 40px;">注入注销/吊销/撤销信息</h2>--%>
<%--                    <div><button name="plus2" id="plus2" type="button" class="layui-btn layui-btn-normal  layui-btn-sm" style="margin-top: 5px;margin-top: -35px; margin-right: 10px;--%>
<%--    position: relative;display: inline-block;float: right"><i class="layui-icon layui-icon-addition"></i></button></div>--%>
<%--                </div>--%>

<%--                <div class="four1" style="background-color: white;margin-top: 20px" >--%>

<%--                    <div  class="layui-form">--%>
<%--                        <form action="" id="planTi">--%>
<%--                            <table class="layui-hide" id="plan2" lay-filter="plan2"></table>--%>
<%--                        </form>--%>
<%--                    </div>--%>

<%--                </div>--%>

<%--                <div class="fiveClick" style="background: #e5e5e5;margin-top: 20px">--%>
<%--                    <img id="img4" src="/ui/img/selectX.png"></img>--%>
<%--                    <h2 style="margin-left: 5%;height: 40px;--%>
<%--    line-height: 40px;">联络信息</h2>--%>
<%--                    <div><button name="plus3" id="plus3" type="button" class="layui-btn layui-btn-normal  layui-btn-sm" style="margin-top: 5px;margin-top: -35px; margin-right: 10px;--%>
<%--    position: relative;display: inline-block;float: right"><i class="layui-icon layui-icon-addition"></i></button></div>--%>
<%--                </div>--%>

<%--                <div class="five1" style="background-color: white;margin-top: 20px" >--%>

<%--                    <div  class="layui-form">--%>
<%--                        <form action="" id="planTi">--%>
<%--                            <table class="layui-hide" id="plan3" lay-filter="plan3"></table>--%>
<%--                        </form>--%>
<%--                    </div>--%>

<%--                </div>--%>
                <div style="text-align: center;margin-top: 20px">
                    <button type="button" class="layui-btn layui-btn-sm" id="save2" lay-event="search" style="height: 30px;line-height: 30px;display: none">保存</button>
                </div>

        </div>
        <div class="layui-tab-item" id="page3">
            <%-- 页面3--%>
            <div>
                <div class="layui-form">
                    <div class="layui-input-block">
                        <div style="display: flex">
                        <div id="book1" style="margin-top: 10px;">
                        <input id="book1" name="radio" title="全部证书" type="radio" checked="" value="全部证书">
                        </div>
                        <div id="book2" style="margin-top: 10px;">
                        <input id="book2" onclick="book2()" name="radio" title="一个月内过期证书" type="radio" value="一个月内过期证书">
                        </div>
                            <div id="book3" style="margin-top: 10px">
                        <input id="book3" name="radio" title="已过期证书" type="radio" value="已过期证书">
                            </div>

                        <div class="layui-inline" style="margin-left: 5%">
                            <label class="layui-form-label">证件照名称</label>
                            <div class="layui-input-inline">
                                <input id="licenceName" name="licenceName" class="layui-input" type="text">
                            </div>
                        </div>
                        <button class="layui-btn" id="search1" style="margin-top: 20px" type="button">搜索</button>
                        <button style="float: right;margin-top: 20px" id="add" class="layui-btn" type="button">新建</button>
                    </div>
                </div>
                </div>
            </div>
            <table class="layui-hide" id="tableDemo" lay-filter="tableDemo"></table>
        </div>
        <div class="layui-tab-item" id="page4">
            <table class="layui-hide" id="tableDemo4" lay-filter="tableDemo4"></table>
            <div style="text-align: center;">
                <button type="button" class="layui-btn layui-btn-sm banyuanbtn" style="height: 32px;line-height: 32px;text-align: center">提交审核</button>
            </div>
        </div>
        <div class="layui-tab-item" id="page5">
            <table class="layui-hide" id="tableDemo5" lay-filter="tableDemo5"></table>
        </div>
        </div>

    </div>
</div>
</div>
    <script id="doSth" type="text/html">
        <div class="long">
            <a id="detail1" class="layui-btn layui-btn-xs" lay-event="detail1" data-index="i" >详情</a>&nbsp&nbsp&nbsp
<%--            <a id="detail2" lay-event="detail2" data-index="i" style="color: blue;cursor:pointer; text-decoration:underline">编辑</a>&nbsp&nbsp&nbsp--%>
<%--            <a id="detail3" lay-event="detail3" data-index="i" style="color: blue;cursor:pointer; text-decoration:underline">删除</a>--%>
        </div>

</script>
<script id="doSth1" type="text/html">
    <div class="long">
        <a id="detail1" class="layui-btn layui-btn-xs" lay-event="detail1">查看</a>&nbsp&nbsp&nbsp
        <%--            <a id="detail2" lay-event="detail2" data-index="i" style="color: blue;cursor:pointer; text-decoration:underline">编辑</a>&nbsp&nbsp&nbsp--%>
        <%--            <a id="detail3" lay-event="detail3" data-index="i" style="color: blue;cursor:pointer; text-decoration:underline">删除</a>--%>
    </div>

</script>
<script id="planDel" type="text/html">
        <a id="del" lay-event="del" data-index="del" style="color: blue;cursor:pointer; text-decoration:underline">删除</a>
</script>
<script>
    var deptId;
    var orgId='';
    var deptName;
    var orgIds;
    var orgLegal;
    var parentOrgId;
    var changeInfo,mainMember;
            $.ajax({
                type: 'post',
                url: '/EduorgMessage/myOrg',
                dataType: 'json',
                success: function (res) {
                    orgId=res.object.orgId;
                    orgIds=res.object.orgId;
                    deptName=res.object.deptName;
                    orgLegal = res.object.orgId;
                    var data = res.object;
                    if(data.schoolType=='4'){
                        $('.banyuan').show()
                    }else {
                        $('.banyuan').hide()
                    }
                    if(data.deptName==''||data.deptName==undefined){
                        $('.faren').css('pointer-events','none')
                        $('.zhengzhao').css('pointer-events','none')
                        $('.banyuan').css('pointer-events','none')
                        $('.shenhe').css('pointer-events','none')
                        $('#save1').css('pointer-events','none');
                        $('#save1').css('background-color','#ccc');
                    }
                        $('#orgFullname').val(data.orgFullname);
                        $('#deptName').val(data.deptName);
                        $('#orgChildNum').val(data.orgChildNum);
                        $('#schoolType').val(data.schoolTypeNmae);
                        $('#studyPart').val(data.studyPartName);
                        $('#telNo').val(data.telNo);
                        $('#deptAddress').val(data.deptAddress);
                        $('#deptCode').val(data.deptCode);
                        $('#faxNo').val(data.faxNo);
                        $('#deptAvenue').val(data.deptAvenueName);
                        $('#orgNum2').val(data.orgNum);
                        $('#unifiedCreditCode').val(data.unifiedCreditCode);
                        $('#parentOrgId').val(data.parentOrgId);
                        $('#statePrivateId').val(data.statePrivateIdName+'/'+data.statePrivateId2Name);
                        $('#deptIdName').val(data.deptIdName);
                        $('#deptParentName').val(data.deptParentName);
                        $('#educationNum').val(data.educationNum);
                        $('#orgChildNum').val(data.orgChildNum);
                        $('#schoolManageType').val(data.schoolManageTypeName);
                    if($('#orgFullname').val()==''&&$('#deptName').val()==''){
                        $('#save1').css('display','none');
                    }

                }
            })
    $('.faren').click(function(){
        if($('#orgFullname').val()==''&&$('#deptName').val()==''){
            $.layerMsg({content: '基本信息为空！', icon:3});
            return false;
        }
        $.ajax({
            type: 'post',
            url: '/EduorgChanage/selectByOrgId',
            dataType: 'json',
            data:{
                orgId:orgId
            },
            success: function (json) {
                console.log(json)
            }
        })
        $.ajax({
            type: 'post',
            url: '/EduorgLegal/selectByOrgId',
            dataType: 'json',
            data:{
                orgId:orgId
            },
            success: function (json) {
                var data1 = json.obj;
                if(data1.length!='0') {
                    $('#certificateNo').val(data1[0].certificateNo);
                    $('#society').val(data1[0].society);
                    $('#legalType').val(data1[0].legalType);
                    $('#legalRepresentative').val(data1[0].legalRepresentative);
                    $('#legalCertificates').val(data1[0].legalCertificates);
                    $('#legalcertificatesNo').val(data1[0].legalcertificatesNo);
                    $('#legalName').val(data1[0].legalName);
                    $('#businessNum').val(data1[0].businessNum);
                    $('#orgNum1').val(data1[0].orgNum);
                    $('#address').val(data1[0].address);
                    $('#areaCode').val(data1[0].areaCode);
                    $('#businessScope').val(data1[0].businessScope);
                    $('#contactCerType').val(data1[0].contactCerType);
                    $('#contactCerNo').val(data1[0].contactCerNo);
                    $('#contactEmail').val(data1[0].contactEmail);
                    $('#contactName').val(data1[0].contactName);
                    $('#contactTelephone').val(data1[0].contactTelephone);
                    $('#contactType').val(data1[0].contactType);
                    $('#corpCountry').val(data1[0].corpCountry);
                    $('#corpStatus').val(data1[0].corpStatus);
                    $('#currency').val(data1[0].currency);
                    $('#establish1').val(data1[0].establishDate);
                    $('#businessAddress').val(data1[0].businessAddress);
                    $('#industryCode').val(data1[0].industryCode);
                    $('#jjly').val(data1[0].jjly);
                    $('#taxNo1').val(data1[0].taxNo);
                    $('#jyqxzh').val(data1[0].jyqxzh);
                    $('#jyqxzi').val(data1[0].jyqxzi);
                    $('#organ').val(data1[0].organ);
                    $('#subObj').val(data1[0].subObj);
                    $('#regCapital').val(data1[0].regCapital);
                    $('#regCustom').val(data1[0].regCustom);
                    $('#regOrgan').val(data1[0].regOrgan);
                    $('#registnumber').val(data1[0].registnumber);
                    $('#repealDate').val(data1[0].repealDate);
                    $('#repealReason').val(data1[0].repealReason);

                }
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

    })

    $('.zhengzhao').click(function(){
        if($('#orgFullname').val()==''&&$('#deptName').val()==''){
            $.layerMsg({content: '基本信息为空！', icon:3});
            return false;
        }
    })
    $('.banyuan').click(function(){
        if($('#orgFullname').val()==''&&$('#deptName').val()==''){
            $.layerMsg({content: '基本信息为空！', icon:3});
            return false;
        }
    })



    function getQueryString(name) {
        var reg = new RegExp("(^|&)" + name + "=([^&]*)(&|$)");
        var r = window.location.search.substr(1).match(reg);
        if (r != null) return unescape(r[2]);
        return null;
    }
    var editXia = getQueryString('editXia')
    var tablePlus = [{
        changeMatter: ""
        ,changeBefore: ''
        ,changeAfter:''
        ,changeDate: ""
        ,changeRegister: ''
    }]

    var change1='1'
    var change2='1'
    var change3='1'
    var change4='1'
    var change5='1'
    $('#img5').click(function(){
        $('.one1').toggle()
        if(change1=='1'){
        var img1=document.getElementById("img5");
        img1.src="/ui/img/zkim/selectX1.png"
            change1='2'
        }
        else if (change1=='2'){
            var img2=document.getElementById("img5");
            img2.src="/ui/img/selectX.png"
            change1='1'
        }
    })


    $('#img1').click(function(){
        $('.two1').toggle()
        if(change2=='1'){
            var img1=document.getElementById("img1");
            img1.src="/ui/img/zkim/selectX1.png"
            change2='2'
        }
        else if (change2=='2'){
            var img2=document.getElementById("img1");
            img2.src="/ui/img/selectX.png"
            change2='1'
        }
    })
    $('#img2').click(function(){
        $('.three1').toggle()
        if(change3=='1'){
            var img1=document.getElementById("img2");
            img1.src="/ui/img/zkim/selectX1.png"
            change3='2'
        }
        else if (change3=='2'){
            var img2=document.getElementById("img2");
            img2.src="/ui/img/selectX.png"
            change3='1'
        }
    })
    $('#img3').click(function(){
        $('.four1').toggle()
        if(change4=='1'){
            var img1=document.getElementById("img3");
            img1.src="/ui/img/zkim/selectX1.png"
            change4='2'
        }
        else if (change4=='2'){
            var img2=document.getElementById("img3");
            img2.src="/ui/img/selectX.png"
            change4='1'
        }
    })
    $('#img4').click(function(){
        $('.five1').toggle()
        if(change5=='1'){
            var img1=document.getElementById("img4");
            img1.src="/ui/img/zkim/selectX1.png"
            change5='2'
        }
        else if (change5=='2'){
            var img2=document.getElementById("img4");
            img2.src="/ui/img/selectX.png"
            change5='1'
        }
    })
    elem: '#tableDemo'
    ,cols = [[
        {field: 'changeMatter', title: '变更事项', edit: true, align: 'center'}
        , {field: 'changeBefore', title: '变更前内容', edit: true, align: 'center'}
        , {field: 'changeAfter', title: '变更后内容', edit: true, align: 'center'}
        , {field: 'changeDate', title: '变更日期', edit: true, align: 'center'}
        , {field: 'changeRegister', title: '变更登记机关', edit: true, align: 'center'}

    ]]

    var cols1 = [[
        {field: 'memberName', title: '成员姓名', edit: true, align: 'center'}
        , {field: 'memberSex', title: '成员性别', edit: true, align: 'center'}
        , {field: 'memberNationality', title: '国籍', edit: true, align: 'center'}
        , {field: 'memberPrefecture', title: '省(市)', edit: true, align: 'center'}
        , {field: 'memberType', title: '成员类型', edit: true, align: 'center'}
        , {title: '操作', toolbar: '#planDel1', align: 'center',event: 'enclosure'}
    ]]
    var cols2 = [[
        {field: 'revokeReason', title: '吊销原因', edit: true, align: 'center'}
        , {field: 'cancellationReason', title: '注销原因', edit: true, align: 'center'}
        , {field: 'revokeDate', title: '吊销日期', edit: true, align: 'center'}
        , {field: 'cancekkationDate', title: '撤销日期', edit: true, align: 'center'}
        , {field: 'IimplementingAuthority', title: '实施机关', edit: true, align: 'center'}
        , {title: '操作', toolbar: '#planDel2', align: 'center',event: 'enclosure'}
    ]]
    var cols3 = [[
        {field: 'liaisonName', title: '联系人姓名', edit: true, align: 'center'}
        , {field: 'liaisonCertificatesNo', title: '联络员证件号码', edit: true, align: 'center'}
        , {field: 'legalCertificates', title: '联络人证件类型', edit: true, align: 'center'}
        , {field: 'liaisonType', title: '联络人类型', edit: true, align: 'center'}
        , {field: 'telNo', title: '联络电话', edit: true, align: 'center'}
        , {title: '操作', toolbar: '#planDel3', align: 'center',event: 'enclosure'}
    ]]




    var user_id = '';
    var tipsIndex;
    var str

    function showShopm(t){
        var attachmentUrl = $(t).attr('atturl')
        var row='<div style="display: flex;flex-direction: column;" id="tips">' +
            '<a class="operation" onclick="preview($(this))" href="javascript:;" attrurl="' + encodeURI(attachmentUrl) +'" style="margin-left: 10px"><img src="/img/attachmentIcon/icon_skim.png" style="margin-right: 5px;" alt="">预览</a>' +
            '<a class="operation download" style="margin-left: 10px;" href="/download?' + encodeURI(attachmentUrl) + '"><img src="/img/attachmentIcon/icon_down.png" style="margin-right: 5px;" alt="">下载</a>' +
            '</div>'

        tipsIndex = layer.tips(row,t,{
            tips:[1,'#ffffff'],
            time:4000
        })
    }

    layui.use(['form', 'table', 'laypage'], function () {
        var laydate = layui.laydate;
        var form = layui.form;
        var table = layui.table;
        var element = layui.element;
        // var layer = layui.layer
        var laypage = layui.laypage;
        form.render();
        $('#save1').click(function(){
            $.ajax({
                type: 'post',
                url: '/EduorgMessage/selectIsExistenceAudit?orgId='+orgIds+'&changeType=1',
                dataType: 'json',
                data: {
                    faxNo: $("#faxNo").val(),
                    telNo: $("#telNo").val(),
                    deptAddress : $("#deptAddress").val(),
                    deptCode : $("#deptCode").val(),
                }, success: function (res) {
                    if(res.msg=='1'){
                        layer.msg('基础信息没有数据变更，不能提交！', {icon: 2});
                        return false
                    }else if(res.msg=='error'){
                        layer.msg('还有未审核数据，不能提交！', {icon: 2});
                        return false
                    }
                    layer.open({
                        type: 1 //Page层类型
                        ,area: ['430px', '400px']
                        ,title: '确认提交审核？'
                        ,maxmin: true //允许全屏最小化
                        ,content: '<div style="overflow-x: hidden;overflow-y: hidden"><div><form>\n' +
                            '                    <div class="layui-inline" >\n' +
                            '                        <label class="layui-form-label" >变更原因</label>\n' +
                            '                        <div class="layui-input-inline" style="display: flex">\n' +
                            '                            <textarea id="changeReason" name="changeReason" class="layui-textarea" type="text"></textarea>\n' +
                            '<span style="color: red;margin-left: 5px;font-size: 25px">*</span>' +
                            '                        </div>\n' +
                            '                    </div>\n' +
                            '                                    <div class="layui-col-xs12" style="padding: 0 5px;">\n' +
                            '                                        <div class="layui-form-item" >\n' +
                            '                                            <div class="layui-inline" style="width:100%">\n' +
                            '                                                <label class="layui-form-label" >附件</label>\n' +
                            '                                               <div class="layui-input-block" style="padding-top: 9px;style="display: flex"">\n' +
                            '                                                   <div id="fileuploadAgendas1" style="text-align: left;"></div>\n' +
                            '                                                   <a href="javascript:;" class="openFile" style="float: left;position:relative;margin-top:9px">\n' +
                            '                                                       <img src="../img/mg11.png" alt="">\n' +
                            '                                                       <span>添加附件</span>\n' +
                            '<span style="color: red;margin-left: 5px;font-size: 25px">*</span>' +
                            '                                                       <input type="file" multiple id="fileuploadAgendas" data-url="../upload?module=meeting" name="file">\n' +
                            '                                                   </a>\n' +
                            '                                                </div>' +
                            '                                            </div>\n' +
                            '                                        </div>\n' +
                            '                                    </div>\n' +
                            '                                </div>\n' +
                            '<center><div><button style="margin-top: 40px" class="layui-btn" id="queding"  type="button">确定</button>\n' +
                            '                        <button style="margin-top: 40px"  id="quxiao" class="layui-btn" type="button">取消</button></div></center>' +
                            '                </form></div></div>'
                        ,yes: function(index, layero){

                        }, success: function (json) {
                            fileuploadFn('#fileuploadAgendas',$('#fileuploadAgendas1'));

                             $('#queding').click(function(){
                               var  obj={
                                   faxNo: $("#faxNo").val(),
                                   telNo: $("#telNo").val(),
                                   deptAddress : $("#deptAddress").val(),
                                   deptCode : $("#deptCode").val(),
                                   changeReason:$("#changeReason").val(),
                                   changeType:'1'
                                }
                               // 附件
                                var attachmentId = '';
                                var attachmentName = '';
                                for (var i = 0; i < $('#fileuploadAgendas1 .dech').length; i++) {
                                    attachmentId += $('#fileuploadAgendas1 .dech').eq(i).find('input').val();
                                    attachmentName += $('#fileuploadAgendas1 a').eq(i).attr('name');
                                }
                                obj.attachmentId=attachmentId
                                obj.attachmentName=attachmentName
                                 if(obj.changeReason==''||obj.changeReason==undefined){
                                     layer.msg('变更原因不能为空！',{icon:0});
                                     return false
                                 }
                                $.ajax({
                                    type: 'post',
                                    url: '/EduorgMessage/addInfoAudit?orgId='+orgIds,
                                    dataType: 'json',
                                    data:obj,
                                    success: function (json) {
                                        $.layerMsg({content: '提交审核成功！', icon: 1}, function () {
                                            shenhe()
                                            layer.closeAll()
                                            $('.jiben').removeClass('layui-this')
                                            $('.shenhe').addClass('layui-this');
                                            $('#jiben').removeClass('layui-show');
                                            $('#page2').removeClass('layui-show');
                                            $('#page3').removeClass('layui-show');
                                            $('#page4').removeClass('layui-show');
                                            $('#page5').addClass('layui-show');

                                        })

                                    }

                                })
                            })
                            $('#quxiao').click(function(){
                                layer.closeAll();
                            })
                        }
                    });
                }
            })
        })

        $('#save2').click(function(){
            var tableDemocratic = layui.table.cache["tableDemocratic"];
            var $tr = $('.two1').find('.layui-table-main tr');
            if(orgLegal != null || orgLegal != undefined){
                $tr.each(function (index) {
                    tableDemocratic[index].orgId = orgLegal
                });
            }
                        $.ajax({
                            type: 'post',
                            url: '/EduorgMessage/selectAll',
                            dataType: 'json',
                            data: {
                                deptId: deptId
                            },
                            success: function (res) {
                                var data = res.obj;
                                orgId = data[0].orgId;
                                $.ajax({
                                    url: '/EduorgChanage/updateByChangeId?orgId='+orgId,
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


                            }
                        })
            $.ajax({
                type: 'post',
                url: '/EduorgMessage/selectAll',
                dataType: 'json',
                data: {
                    deptId: deptId
                },
                success: function (res) {
                    var data = res.obj;
                    orgId = data[0].orgId;
                    $.ajax({
                        type: 'post',
                        url: '/EduorgLegal/updateByLegalId',
                        dataType: 'json',
                        data: {
                            orgId:orgId,
                            certificateNo: $("#certificateNo").val(),
                            society: $("#society").val(),
                            legalType: $("#legalType ").val(),
                            legalRepresentative: $("#legalRepresentative").val(),
                            legalCertificates: $("#legalCertificates").val(),
                            legalcertificatesNo: $("#legalcertificatesNo").val(),
                            legalName: $("#legalName").val(),
                            businessNum: $("#businessNum").val(),
                            orgNum: $("#orgNum1").val(),
                            taxNo: $("#taxNo1").val(),
                            address: $("#address").val(),
                            areaCode: $("#areaCode").val(),
                            businessScope: $("#businessScope").val(),
                            contactCerType: $("#contactCerType").val(),
                            contactCerNo: $("#contactCerNo").val(),
                            contactEmail: $("#contactEmail").val(),
                            contactName: $("#contactName").val(),
                            contactTelephone: $("#contactTelephone").val(),
                            contactType: $("#contactType").val(),
                            corpCountry: $("#corpCountry").val(),
                            businessAddress: $("#businessAddress").val(),
                            industryCode: $("#industryCode").val(),
                            jjly: $("#jjly").val(),
                            currency: $("#currency").val(),
                            establishDate: $("#establish1").val(),
                            businessAddress: $("#businessAddress").val(),
                            jyqxzh: $("#jyqxzh").val(),
                            jyqxzi: $("#jyqxzi").val(),
                            organ: $("#organ").val(),
                            subObj: $("#subObj").val(),
                            regCapital: $("#regCapital").val(),
                            regCustom: $("#regCustom").val(),
                            regOrgan: $("#regOrgan").val(),
                            registnumber: $("#registnumber").val(),
                            repealDate: $("#repealDate").val(),


                        },
                        success: function (json) {
                            $.layerMsg({content: '修改成功！', icon: 1}, function () {
                                location.reload();
                            })
                        }
                    })

                }
            })


        })

        //变更信息表格渲染
        changeInfo = table.render({
            elem: '#tableDemocratic'
            ,data : tablePlus
            ,cols: cols

        });

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
//第二页的表格1
        table.render({
            elem: '#tableDemocratic'
            , data: tablePlus
            , cellMinWidth: 80
            , page: false
            , cols: cols
            , done: function (doneres, curr, count) {
                // 详情下禁用编辑
                if (editXia == 2) {
                    var tableView = this.elem.next(); // 当前表格渲染之后的视图
                    layui.each(doneres.data, function(i, item){
                        tableView.find('tr[data-index=' + i + ']').css("background-color", "#f2f2f2").find('td').data('edit',false)
                    });
                    $('input').attr("readonly","readonly");//设为只读
                    $('input').css("background", "#f2f2f2");
                    $('select').css("background", "#f2f2f2");
                    $('select').css("pointer-events","none");
                    $('.biwI').parents("tr").css("background", "#f2f2f2");
                }

                for (var i = 0; i < doneres.data.length; i++) {
                    // 查阅预览
                    var lookF = $('tr[data-index='+ i +']').find('a[lay-event="lookF"]');
                    if(tablePlus[i] != undefined) {
                        lookF.attr('NAME', tablePlus[i].attachmentName)
                        lookF.attr('fileExtension', tablePlus[i].fileExtension)
                        lookF.attr('deUrl', tablePlus[i].deUrl)
                    }
                    $('tr[data-index='+ i +']').find('button[name="butfile"]').attr('id', i);
                    // $('#fileName'+i).html(tablePlus[i].attachmentName)

                }
                tableDemocratic = layui.table.cache["tableDemocratic"];

            }
        });
        //第二页 的表格2
        table.render({
            elem: '#plan1'
            , data: tablePlus
            , cellMinWidth: 80
            , page: false
            , cols: cols1
            , done: function (doneres, curr, count) {
                // 详情下禁用编辑
                if (editXia == 2) {
                    var tableView = this.elem.next(); // 当前表格渲染之后的视图
                    layui.each(doneres.data, function(i, item){
                        tableView.find('tr[data-index=' + i + ']').css("background-color", "#f2f2f2").find('td').data('edit',false)
                    });
                    $('input').attr("readonly","readonly");//设为只读
                    $('input').css("background", "#f2f2f2");
                    $('select').css("background", "#f2f2f2");
                    $('select').css("pointer-events","none");
                    $('.biwI').parents("tr").css("background", "#f2f2f2");
                }
                for (var i = 0; i < doneres.data.length; i++) {
                    // 查阅预览
                    var lookF = $('tr[data-index='+ i +']').find('a[lay-event="lookF"]');
                    if(tablePlus[i] != undefined) {
                        lookF.attr('NAME', tablePlus[i].attachmentName)
                        lookF.attr('fileExtension', tablePlus[i].fileExtension)
                        lookF.attr('deUrl', tablePlus[i].deUrl)
                    }
                    $('tr[data-index='+ i +']').find('button[name="butfile"]').attr('id', i);
                    // $('#fileName'+i).html(tablePlus[i].attachmentName)

                }
                plan = layui.table.cache["plan1"];

            }
        });
        table.render({
            elem: '#plan2'
            , data: tablePlus
            , cellMinWidth: 80
            , page: false
            , cols: cols2
            , done: function (doneres, curr, count) {
                // 详情下禁用编辑
                if (editXia == 2) {
                    var tableView = this.elem.next(); // 当前表格渲染之后的视图
                    layui.each(doneres.data, function(i, item){
                        tableView.find('tr[data-index=' + i + ']').css("background-color", "#f2f2f2").find('td').data('edit',false)
                    });
                    $('input').attr("readonly","readonly");//设为只读
                    $('input').css("background", "#f2f2f2");
                    $('select').css("background", "#f2f2f2");
                    $('select').css("pointer-events","none");
                    $('.biwI').parents("tr").css("background", "#f2f2f2");
                }

                for (var i = 0; i < doneres.data.length; i++) {
                    // 查阅预览
                    var lookF = $('tr[data-index='+ i +']').find('a[lay-event="lookF"]');
                    if(tablePlus[i] != undefined) {
                        lookF.attr('NAME', tablePlus[i].attachmentName)
                        lookF.attr('fileExtension', tablePlus[i].fileExtension)
                        lookF.attr('deUrl', tablePlus[i].deUrl)
                    }
                    $('tr[data-index='+ i +']').find('button[name="butfile"]').attr('id', i);
                    // $('#fileName'+i).html(tablePlus[i].attachmentName)

                }
                plan = layui.table.cache["plan2"];

            }
        });
        table.render({
            elem: '#plan3'
            , data: tablePlus
            , cellMinWidth: 80
            , page: false
            , cols: cols3
            , done: function (doneres, curr, count) {
                // 详情下禁用编辑
                if (editXia == 2) {
                    var tableView = this.elem.next(); // 当前表格渲染之后的视图
                    layui.each(doneres.data, function(i, item){
                        tableView.find('tr[data-index=' + i + ']').css("background-color", "#f2f2f2").find('td').data('edit',false)
                    });
                    $('input').attr("readonly","readonly");//设为只读
                    $('input').css("background", "#f2f2f2");
                    $('select').css("background", "#f2f2f2");
                    $('select').css("pointer-events","none");
                    $('.biwI').parents("tr").css("background", "#f2f2f2");
                }

                for (var i = 0; i < doneres.data.length; i++) {
                    // 查阅预览
                    var lookF = $('tr[data-index='+ i +']').find('a[lay-event="lookF"]');
                    if(tablePlus[i] != undefined) {
                        lookF.attr('NAME', tablePlus[i].attachmentName)
                        lookF.attr('fileExtension', tablePlus[i].fileExtension)
                        lookF.attr('deUrl', tablePlus[i].deUrl)
                    }
                    $('tr[data-index='+ i +']').find('button[name="butfile"]').attr('id', i);
                    // $('#fileName'+i).html(tablePlus[i].attachmentName)

                }
                plan = layui.table.cache["plan3"];

            }
        });


var orgId1='';

        $.ajax({
            type: 'post',
            url: '/EduorgMessage/myOrg',
            dataType: 'json',
            data: {
                deptId: deptId
            },
            success: function (res) {
                orgId1=res.object.orgId;
                var data = res.object;
//第三页的表格
                var noticeTable = table.render({
                    elem: '#tableDemo'
                    , url: '/license/selectListLicenseByCond?useFlag=true&paseSize=10&orgId='+orgId1
                    , page: true
                    , type: 'get'
                    // ,toolbar:'#toolbar'
                    , cols: [[
                        {field: 'licenceName', title: '证书名称', align: 'center',event:'subjectDetail', style:'cursor: pointer;color:blue;text-decoration: underline;'}
                        , {field: 'deptName', title: '机构名称', align: 'center'}
                        , {field: 'licenseTypeName', title: '证照类别', align: 'center'}
                        , {field: 'effectiveDate', title: '有效日期', align: 'center'}
                        , {field: 'validPeriod', title: '到期日期', align: 'center'}
                        , {field: 'attachmentName', title: '附件', align: 'center', templet: function (d) {
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
                        , {title: '操作', align: 'center', toolbar: '#doSth'}
                    ]]
                    , parseData: function (res) { //res 即为原始返回的数据
                        // $('#userId').attr('userId',res.data.userId)
                        // $('#userId').attr('userName',res.data.userName)
                        // $('#addMeeting input[name="createUser"]').attr('userId',res.data.userId)
                        // $('#addMeeting input[name="createUser"]').val(res.data.userName)
                        return {
                            "code": 0, //解析接口状态
                            "msg": res.msg, //解析提示文本
                            "count": res.totleNum, //解析数据长度
                            "data": res.obj, //解析数据列表
                        };
                    }
                });
                $('#search1').click(function () {
                    var licenceName = $("#licenceName").val()
                    table.render({
                        elem: '#tableDemo'
                        , url:'/license/selectListLicenseByCond?useFlag=true&paseSize=10&licenceName='+licenceName+'&orgId='+orgId1
                        ,cols:[[
                            {field:'licenceName',title:'证书名称',align:'center'},
                            {field:'deptName',title:'机构名称',align:'center'},
                            {field:'licenseTypeName',title:'证照类别',align:'center'},
                            {field:'effectiveDate',title:'有效日期',align:'center'},
                            {field:'validPeriod',title:'到期日期',align:'center'},
                            {field:'attachmentName',title:'附件',align:'center', templet: function (d) {
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
                                }},
                            {title:'操作',toolbar:'#doSth',minWidth:200,align:'center'},
                        ]],
                        page:true,
                        limit:10
                        ,parseData: function(res){ //res 即为原始返回的数据
                            return {
                                "code":0,
                                "count":res.totleNum,
                                "data": res.obj //解析数据列表
                            };
                        }
                    });
                });
                $('#book1').click(function () {
                    var licenceName = $("#licenceName").val()
                    table.render({
                        elem: '#tableDemo'
                        , url:'/license/selectListLicenseByCond?useFlag=true&paseSize=10&licenceName='+licenceName+'&orgId='+orgId1
                        ,cols:[[
                            {field:'licenceName',title:'证书名称',align:'center'},
                            {field:'organName',title:'机构名称',align:'center'},
                            {field:'licenseTypeName',title:'证照类别',align:'center'},
                            {field:'effectiveDate',title:'有效日期',align:'center'},
                            {field:'validPeriod',title:'到期日期',align:'center'},
                            {field:'attachmentName',title:'附件',align:'center', templet: function (d) {
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
                                }},
                            {title:'操作',toolbar:'#doSth',minWidth:200,align:'center'},
                        ]],
                        page:true,
                        limit:10
                        ,parseData: function(res){ //res 即为原始返回的数据
                            return {
                                "code":0,
                                "count":res.totleNum,
                                "data": res.obj //解析数据列表
                            };
                        }
                    });
                });
                $('#book2').click(function () {
                    function book2(){
                    }
                    var licenceName = $("#licenceName").val()
                    table.render({
                        elem: '#tableDemo'
                        , url:'/license/selectListLicenseByCond?useFlag=true&paseSize=10&expired='+'one'+'&orgId='+orgId1
                        ,cols:[[
                            {field:'licenceName',title:'证书名称',align:'center'},
                            {field:'organName',title:'机构名称',align:'center'},
                            {field:'licenseTypeName',title:'证照类别',align:'center'},
                            {field:'effectiveDate',title:'有效日期',align:'center'},
                            {field:'validPeriod',title:'到期日期',align:'center'},
                            {field:'attachmentName',title:'附件',align:'center', templet: function (d) {
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
                                }},
                            {title:'操作',toolbar:'#doSth',minWidth:200,align:'center'},
                        ]],
                        page:true,
                        limit:10
                        ,parseData: function(res){ //res 即为原始返回的数据
                            return {
                                "code":0,
                                "count":res.totleNum,
                                "data": res.obj //解析数据列表
                            };
                        }
                    });
                });
                $('#book3').click(function () {
                    var licenceName = $("#licenceName").val()
                    table.render({
                        elem: '#tableDemo'
                        , url:'/license/selectListLicenseByCond?useFlag=true&paseSize=10&expired='+'expired'+'&orgId='+orgId1
                        ,cols:[[
                            {field:'licenceName',title:'证书名称',align:'center'},
                            {field:'organName',title:'机构名称',align:'center'},
                            {field:'licenseTypeName',title:'证照类别',align:'center'},
                            {field:'effectiveDate',title:'有效日期',align:'center'},
                            {field:'validPeriod',title:'到期日期',align:'center'},
                            {field:'attachmentName',title:'附件',align:'center', templet: function (d) {
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
                                }},
                            {title:'操作',toolbar:'#doSth',minWidth:200,align:'center'},
                        ]],
                        page:true,
                        limit:10
                        ,parseData: function(res){ //res 即为原始返回的数据
                            return {
                                "code":0,
                                "count":res.totleNum,
                                "data": res.obj //解析数据列表
                            };
                        }
                    });
                });


                banyuan()
                function banyuan(){
                    table.render({
                        elem: '#tableDemo4'
                        , url:'/EduorgMessage/selectClassInformation?orgId='+orgId1
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
                                "code":0,
                                "count":res.totleNum,
                                "data": res.obj //解析数据列表
                            };
                        }
                    });
                }
                $('.banyuanbtn').click(function(){
                    var $tr = $('#page4').find('.layui-table-main tr');
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
                            orgId: orgId1,
                            changeType:'2'
                        }
                    })
                    $.ajax({
                        url:'/EduorgMessage/selectIsExistenceAudit?orgId='+orgId1,
                        data: materialDetailsObj,
                        dataType: 'json',
                        type: 'post',
                        success: function (res) {
                            if (res.msg=='ok') {
                                layer.open({
                                    type: 1 //Page层类型
                                    ,area: ['430px', '400px']
                                    ,title: '确认提交审核？'
                                    ,maxmin: true //允许全屏最小化
                                    ,content: '<div style="overflow-x: hidden;overflow-y: hidden"><div><form>\n' +
                                        '                    <div class="layui-inline" >\n' +
                                        '                        <label class="layui-form-label" >变更原因</label>\n' +
                                        '                        <div class="layui-input-inline" style="display: flex">\n' +
                                        '                            <textarea id="changeReason" name="changeReason" class="layui-textarea" type="text"></textarea>\n' +
                                        '<span style="color: red;margin-left: 5px;font-size: 25px">*</span>' +
                                        '                        </div>\n' +
                                        '                    </div>\n' +
                                        '                                    <div class="layui-col-xs12" style="padding: 0 5px;">\n' +
                                        '                                        <div class="layui-form-item" >\n' +
                                        '                                            <div class="layui-inline" style="width:100%">\n' +
                                        '                                                <label class="layui-form-label" >附件</label>\n' +
                                        '                                               <div class="layui-input-block" style="padding-top: 9px;style="display: flex"">\n' +
                                        '                                                   <div id="fileAllAgenda" style="text-align: left;"></div>\n' +
                                        '                                                   <a href="javascript:;" class="openFile" style="float: left;position:relative">\n' +
                                        '                                                       <img src="../img/mg11.png" alt="">\n' +
                                        '                                                       <span>添加附件</span>\n' +
                                        '<span style="color: red;margin-left: 5px;font-size: 25px">*</span>' +
                                        '                                                       <input type="file" multiple id="fileuploadAgenda" data-url="../upload?module=meeting" name="file">\n' +
                                        '                                                   </a>\n' +
                                        '                                                </div>' +
                                        '                                            </div>\n' +
                                        '                                        </div>\n' +
                                        '                                    </div>\n' +
                                        '                                </div>\n' +
                                        '<center><div><button style="margin-top: 40px" class="layui-btn" id="queding"  type="button">确定</button>\n' +
                                        '                        <button style="margin-top: 40px"  id="quxiao" class="layui-btn" type="button">取消</button></div></center>' +
                                        '                </form></div></div>'
                                    ,yes: function(index, layero){

                                    }, success: function (json) {
                                        fileuploadFn('#fileuploadAgenda',$('#fileAllAgenda'));
                                        $('#queding').click(function(){
                                            materialDetailsObj.changeReason=$("#changeReason").val()
                                            // 附件
                                            var attachmentId = '';
                                            var attachmentName = '';
                                            for (var i = 0; i < $('#fileAllAgenda .dech').length; i++) {
                                                attachmentId += $('#fileAllAgenda .dech').eq(i).find('input').val();
                                                attachmentName += $('#fileAllAgenda a').eq(i).attr('name');
                                            }
                                            materialDetailsObj.attachmentId=attachmentId
                                            materialDetailsObj.attachmentName=attachmentName
                                            if(materialDetailsObj.changeReason==''||materialDetailsObj.changeReason==undefined){
                                                layer.msg('变更原因不能为空！',{icon:0});
                                                return false
                                            }
                                            $.ajax({
                                                type: 'post',
                                                url: '/EduorgMessage/addInfoAudit?orgId='+orgId1,
                                                dataType: 'json',
                                                data:materialDetailsObj,
                                                success: function (res) {
                                                    if (res.flag) {
                                                        shenhe()
                                                        layer.msg('提交审批成功！', {icon: 1});
                                                        layer.closeAll();
                                                        $('.banyuan').removeClass('layui-this')
                                                        $('.shenhe').addClass('layui-this');
                                                        $('#jiben').removeClass('layui-show');
                                                        $('#page2').removeClass('layui-show');
                                                        $('#page3').removeClass('layui-show');
                                                        $('#page4').removeClass('layui-show');
                                                        $('#page5').addClass('layui-show');

                                                    } else {
                                                        layer.msg('提交失败！', {icon: 2});
                                                    }
                                                }

                                            })
                                        })
                                        $('#quxiao').click(function(){
                                            layer.closeAll();
                                        })
                                    }
                                });

                            }else if(res.msg=='error'){
                                layer.msg('还有未审核数据，不能提交！', {icon: 2});
                            }else if(res.msg== '2'){
                                layer.msg('办园信息没有数据变更，不能提交！', {icon: 2});
                            }

                        }

                    })

                })
            }
        })
        shenhe()
        function shenhe(){
            $.ajax({
                type: 'post',
                url: '/EduorgMessage/myOrg',
                dataType: 'json',
                success:function(res){
                    orgId=res.object.orgId;
                    table.render({
                        elem: '#tableDemo5'
                        , url:'/EduorgMessage/selectInfoAudit?orgId='+orgId+'&useFlag=true'
                        ,cols:[[
                            {field:'applicant',title:'申请人',align:'center',minWidth:150,},
                            {field:'changeType',title:'变更类型',align:'center',minWidth:150,templet: function (d) {
                                    if (d.changeType == '1') {
                                        return '基础信息'
                                    }else {
                                        return '办园信息'
                                    }
                                }},
                            {field:'changes',title:'变更事项',align:'center',minWidth:150,},
                            {field:'beforeChange',title:'变更前',align:'center',minWidth:150,},
                            {field:'afterChange',title:'变更后',align:'center',minWidth:150,},
                            {field:'submissionTime',title:'提交时间',align:'center',},
                            {field:'auditTime',title:'审核时间',align:'center',},
                            {field:'auditStatus',title:'审核状态',align:'center',minWidth:150,templet: function (d) {
                                    if (d.auditStatus == '0') {
                                        return '待审批'
                                    }else  if (d.auditStatus == '1') {
                                        return '同意'
                                    }else  if (d.auditStatus == '2') {
                                        return '不同意'
                                    }
                                }},
                            {field:'auditDesc',title:'审核意见',align:'center',minWidth:150,},
                            {field: 'attachmentName', title: '附件', align: 'center',minWidth:150, templet: function (d) {
                                    var strr = ''
                                    var object=d
                                    if(d.attachmentList==undefined){
                                        return ''
                                    }else{
                                        for(var i=0;i<object.attachmentList.length;i++){
                                            var str1 = ""
                                            if( object.attachmentList[i].attUrl != undefined ){
                                                var fileExtension=object.attachmentList[i].attachName.substring(object.attachmentList[i].attachName.lastIndexOf(".")+1,object.attachmentList[i].attachName.length);
                                                str1 = '' +
                                                    '<div class="dech" deurl="' +object.attachmentList[i].attUrl + '">' +
                                                    '<a href="/download?' + object.attachmentList[i].attUrl + '" name="'+object.attachmentList[i].attachName+'*" style="text-decoration:none;margin-left:5px;">' +
                                                    '<img src="/img/attachment_icon.png">' + object.attachmentList[i].attachName + '</a>' +
                                                    '' +
                                                    // '<img class="deImgs" style="margin-left:5px;cursor: pointer;" src="/img/file/icon_deletecha_03.png">' +
                                                    '<input type="hidden" class="inHidden" value="' + object.attachmentList[i].aid + '@' + object.attachmentList[i].ym + '_' + object.attachmentList[i].attachId +',">' +
                                                    '<a fileExtension="'+fileExtension+'"onclick="pdurls($(this))" href="javascript:;" style="padding-left: 5px">' +
                                                    '<img src="/img/attachmentIcon/icon_skim.png" style="padding: 0 5px;">查阅</a>' +
                                                    '<a style="padding-left: 5px" href="/download?' + object.attachmentList[i].attUrl + '">' +
                                                    '<img src="/img/attachmentIcon/icon_down.png" style="padding: 0 5px;">下载</a>\n' +
                                                    '</div>' +
                                                    '</div>'
                                            }else{
                                                str1 = '';
                                            }
                                            strr += str1;
                                        }
                                        return strr
                                    }
                                }},
                            {title:'操作',toolbar:'#doSth1',minWidth:200,align:'center'},
                        ]],
                        page:true,
                        limit:10
                        ,parseData: function(res){ //res 即为原始返回的数据
                            return {
                                "code":0,
                                "count":res.totleNum,
                                "data": res.obj //解析数据列表
                            };
                        }
                    });

                    table.on('tool(tableDemo5)', function(obj){
                        var data = obj.data;
                        var orgId = data.orgId;
                        var infoAuditId=data.infoAuditId
                        if(obj.event=='detail1'){
                            layer.open({
                                type: 1
                                , title: '查看'
                                , area: ['60%', '80%'],
                                content: '<div class="layui-tab-item layui-show">\n' +
                                    '                <div>\n' +
                                    '                    <form class="layui-form" action="">\n' +
                                    '                        <div class="layui-inline" style="margin-left: 5%">\n' +
                                    '                            <label class="layui-form-label">申请人</label>\n' +
                                    '                            <div class="layui-input-inline">\n' +
                                    '                                <input id="applicants" disabled="disabled" name="applicant" class="layui-input" type="text">\n' +
                                    '                            </div>\n' +
                                    '                        </div>\n' +
                                    '                        <div class="layui-inline" style="margin-left: 5%">\n' +
                                    '                            <label class="layui-form-label">变更类型</label>\n' +
                                    '                            <div class="layui-input-inline">\n' +
                                    '                                <input id="changeType" disabled="disabled" name="changeType" class="layui-input" type="text">\n' +
                                    '                            </div>\n' +
                                    '                        </div>\n' +
                                    '                    </form></div>\n' +
                                    '                <div>\n' +
                                    '                    <form class="layui-form" action="">\n' +
                                    '                        <div class="layui-inline" style="margin-left: 5%">\n' +
                                    '                            <label class="layui-form-label">变更事项</label>\n' +
                                    '                            <div class="layui-input-inline">\n' +
                                    '                                <input id="changes" disabled="disabled" name="changes" class="layui-input" type="text">\n' +
                                    '                            </div>\n' +
                                    '                        </div>\n' +
                                    '                        <div class="layui-inline" style="margin-left: 5%">\n' +
                                    '                            <label class="layui-form-label">变更前</label>\n' +
                                    '                            <div class="layui-input-inline">\n' +
                                    '                                <input id="beforeChange" disabled="disabled" name="beforeChange" class="layui-input" type="text">\n' +
                                    '                            </div>\n' +
                                    '                        </div>\n' +
                                    '                    </form></div>\n' +
                                    '                <div>\n' +
                                    '                    <form class="layui-form" action="">\n' +
                                    '                        <div class="layui-inline" style="margin-left: 5%">\n' +
                                    '                            <label class="layui-form-label">变更后</label>\n' +
                                    '                            <div class="layui-input-inline">\n' +
                                    '                                <input id="afterChange" disabled="disabled" name="afterChange" class="layui-input" type="text">\n' +
                                    '                            </div>\n' +
                                    '                        </div>\n' +
                                    '                        <div class="layui-inline" style="margin-left: 5%">\n' +
                                    '                            <label class="layui-form-label">提交时间</label>\n' +
                                    '                            <div class="layui-input-inline">\n' +
                                    '                                <input id="submissionTime" disabled="disabled" name="submissionTime" class="layui-input" type="text">\n' +
                                    '                            </div>\n' +
                                    '                        </div>\n' +
                                    '                    </form></div>\n' +
                                    '                <div>\n' +
                                    '                    <form class="layui-form" action="">\n' +
                                    '                        <div class="layui-inline" style="margin-left: 5%">\n' +
                                    '                            <label class="layui-form-label">变更原因</label>\n' +
                                    '                            <div class="layui-input-inline">\n' +
                                    '                                <input id="changeReason" disabled="disabled" name="changeReason" class="layui-input" type="text" style="border: none">\n' +
                                    '                            </div>\n' +
                                    '                        </div>\n' +
                                     '                     <div class="layui-inline" style="width:100%">\n' +
                                    '                        <label class="layui-form-label"style="margin-left: 5%;">附件</label>\n' +
                                    '                               <div class="layui-input-block" style="padding-top: 9px">\n' +
                                    '                                   <div id="fileAllAgendas1" style="text-align: left;"></div>\n' +
                                    '                                          <a href="javascript:;" class="openFile" style="float: left;position:relative;margin-top:9px">\n' +
                                    '                                           </a>\n' +
                                    '                                     </div>' +
                                    '                               </div>' +
                                    '                        <div class="layui-inline" style="margin-left: 5%;margin-bottom: 20px">\n' +
                                    '                            <label class="layui-form-label">审核时间</label>\n' +
                                    '                            <div class="layui-input-inline">\n' +
                                    '                                <input id="auditTime" disabled="disabled" name="auditTime" class="layui-input" type="text">\n' +
                                    '                            </div>\n' +
                                    '                        </div>\n' +
                                    '                        <div class="layui-inline" style="margin-left: 5%;margin-bottom: 20px">\n' +
                                    '                            <label class="layui-form-label">审核状态</label>\n' +
                                    '                            <div class="layui-input-inline">\n' +
                                    '                                <input  disabled="disabled" id="auditStatus" name="auditStatus" class="layui-input" type="text" style="border: none">\n' +
                                    '                            </div>\n' +
                                    '                        </div>\n' +
                                    '                    </form></div>\n' +
                                    '                <div>\n' +
                                    '                    <form class="layui-form" action="">\n' +
                                    '                        <div class="layui-inline" style="margin-left: 5%">\n' +
                                    '                            <label class="layui-form-label">审核意见</label>\n' +
                                    '                            <div class="layui-input-inline">\n' +
                                    '                                <input id="auditDesc" disabled="disabled" name="auditDesc" class="layui-input" type="text" style="border: none">\n' +
                                    '                            </div>\n' +
                                    '                        </div>\n' +
                                    '                    </form></div>\n' +
                                    '                <div style="margin-top: 30px;text-align: center">\n' +
                                    '                    <button class="layui-btn" id="return" type="button">返回</button>\n' +
                                    '                </div>\n' +
                                    '            </div>\n' +
                                    '            <div>\n' +
                                    '            </div>\n' +
                                    '        </div>'
                                ,
                                success: function () {
                                    $('#changes').val(data.changes);
                                    $('#beforeChange').val(data.beforeChange);
                                    $('#orgName').val(data.orgName);
                                    $('#submissionTime').val(data.submissionTime);
                                    $('#afterChange').val(data.afterChange);
                                    $('#applicants').val(data.applicant);
                                    $('#auditTime').val(data.auditTime);
                                    $('#auditDesc').val(data.auditDesc);
                                    $('#changeReason').val(data.changeReason);

                                        if (data.auditStatus == '0') {
                                            $('#auditStatus').val('待审批');
                                        }else  if (data.auditStatus == '1') {
                                            $('#auditStatus').val('同意');
                                        }else  if (data.auditStatus == '2') {
                                            $('#auditStatus').val('不同意');
                                        }
                                    if(data.changeType=='1'){
                                        $('#changeType').val('基础信息');
                                    }else if(data.changeType=='2'){
                                        $('#changeType').val('办园信息');
                                    }
                                    var strr = ''
                                    if((data.attachmentList!=undefined && data.attachmentList[0] != undefined && data.attachmentList.length>0)){
                                        for(var i=0;i<data.attachmentList.length;i++){
                                            var str1 = ""
                                            var fileExtension=data.attachmentList[i].attachName.substring(data.attachmentList[i].attachName.lastIndexOf(".")+1,data.attachmentList[i].attachName.length);
                                            if( data.attachmentList[i].attUrl != undefined ){
                                                str1 = '<div class="dech" deurl="' +data.attachmentList[i].attUrl + '">' +
                                                    '<a href="/download?' + data.attachmentList[i].attUrl + '" name="'+data.attachmentList[i].attachName+'*" style="text-decoration:none;margin-left:5px;">' +
                                                    '<img src="/img/attachment_icon.png">' + data.attachmentList[i].attachName + '</a>' +
                                                    //'<img class="deImgs" style="margin-left:5px;cursor: pointer;" src="/img/file/icon_deletecha_03.png">' +
                                                    '<input type="hidden" class="inHidden" value="' + data.attachmentList[i].aid + '@' + data.attachmentList[i].ym + '_' + data.attachmentList[i].attachId +',">' +
                                                    '<a fileExtension="'+fileExtension+'" onclick="pdurls($(this))" href="javascript:;" style="padding-left: 5px">' +
                                                    '<img src="/img/attachmentIcon/icon_skim.png" style="padding: 0 5px;">查阅</a>' +
                                                    '<a style="padding-left: 5px" href="/download?' + data.attachmentList[i].attUrl + '">' +
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
                                    $('#fileAllAgendas1').html(strr);
                                    // $('#licenceId').val(data.licenceName);
                                    $("#return").click(function() {
                                        layer.closeAll();
                                    })
                                    form.render()

                                },

                            })
                        }
                    })
                }
            })
        }







        fileuploadFn('#fileupload1', $('#fileContent1'));

        $.ajax({
            url:'/code/getCode?parentNo=PARTY_MEETING_TYPE',
            dataType:'json',
            type:'get',
            success:function(data){

                $.each(data.obj,function(index,item){
                    $('#select').append(new Option(item.codeName,item.codeId));//往下拉菜单里添加元素
                })

                form.render();//菜单渲染 把内容加载进去
            }
        })

        table.on('tool(tableDemocratic)', function(obj){
            var data = obj.data;
            var orgId = data.orgId;
            var tr = obj.tr;
            if(obj.event === 'del'){
                var index = tr.attr("data-index");
                obj.del(tr);
            }
        });


        table.on('tool(tableDemo)', function (obj) {
            data = obj.data;
            var dataObj = obj.data;
            var orgId = data.orgId;
            var layEvent = obj.event;
            if (obj.event === 'detail1') {
                licence1()
            }else if(obj.event === 'detail2'){
                layer.open({
                    type: 1 //此处以iframe举例
                    , title: '编辑'
                    , area: ['90%', '95%'],
                    offset:'20',
                    btn: ['确定', '取消'],
                    content: '<form class="layui-form" action=""><div>\n' +
                        '                <div class="oneClick" style="background-color: #e5e5e5;"><h2 style="margin-left: 10%;height: 40px;\n' +
                        '    line-height: 40px;">基本信息</h2></div>\n' +
                        '\n' +
                        '                <div class="one2" style="background-color: white;" >\n' +
                        '                    <div>\n' +
                        '                    <div class="layui-inline" >\n' +
                        '                        <label class="layui-form-label" style="width:100px">证明名称</label>\n' +
                        '                        <div class="layui-input-inline">\n' +
                        '                            <input id="licenceName2"  style="width: 200px" name="licenceName2" class="layui-input" type="text">\n' +
                        '                        </div>\n' +
                        '                    </div>\n' +
                        '                    <div class="layui-inline"  style="margin-left: 3%">\n' +
                        '                            <label class="layui-form-label">借阅机构</label>\n' +
                        '                            <div class="layui-input-inline" >\n' +
                        '                                <select id="organName5"  name="organName5" lay-verify="organName5">\n' +
                        // '                                    <option value="请选择" class="layui-this">请选择</option>\n' +
                        '\n' +
                        '                                </select>\n' +
                        '                            </div>\n' +
                        '                        </div>\n' +
                        '                    <div class="layui-inline" style="margin-left: 3%">\n' +
                        '                        <label class="layui-form-label" style="width:100px">有效日期</label>\n' +
                        '                        <div class="layui-input-inline">\n' +
                        '                            <input onclick="laydate({istime: true, format: \'YYYY-MM-DD\'})" id="effectiveDate" style="width: 200px" name="effectiveDate" class="layui-input" type="text">\n' +
                        '                        </div>\n' +
                        '                    </div>\n' +
                        '                        </div>\n' +
                        '                    <div>\n' +
                        '                        <div class="layui-inline" >\n' +
                        '                            <label class="layui-form-label" style="width:100px">到期日期</label>\n' +
                        '                            <div class="layui-input-inline">\n' +
                        '                                <input onclick="laydate({istime: true, format: \'YYYY-MM-DD\'})" id="validPeriod";width: 200px" name="validPeriod" class="layui-input" type="text">\n' +
                        '                            </div>\n' +
                        '                        </div>\n' +
                        '                        <div class="layui-inline" style="margin-left: 3%">\n' +
                        '                            <label class="layui-form-label " style="width:100px">发证日期</label>\n' +
                        '                            <div class="layui-input-inline">\n' +
                        '                                <input onclick="laydate({istime: true, format: \'YYYY-MM-DD\'})" id="issueDate" width: 200px" name="issueDate" class="layui-input" type="text">\n' +
                        '                            </div>\n' +
                        '                        </div>\n' +
                        '                        <div class="layui-inline" style="margin-left: 3%">\n' +
                        '                            <label class="layui-form-label" style="width:100px">年检日期</label>\n' +
                        '                            <div class="layui-input-inline">\n' +
                        '                                <input onclick="laydate({istime: true, format: \'YYYY-MM-DD\'})" id="yearlyInspectionDate" style="width: 200px" name="yearlyInspectionDate" class="layui-input" type="text">\n' +
                        '                            </div>\n' +
                        '                        </div>\n' +
                        '                    </div>\n' +
                        '                    <div>\n' +
                        '                        <div class="layui-inline">\n' +
                        '                            <label class="layui-form-label" style="width:100px" >发证单位</label>\n' +
                        '                            <div class="layui-input-inline">\n' +
                        '                                <input style="width: 200px" id="issuingUnit" name="issuingUnit" class="layui-input" type="text">\n' +
                        '                            </div>\n' +
                        '                        </div>\n' +
                        '<div class="layui-inline" style="margin-left: 3%;width:100%">\n' +
                        '                            <label class="layui-form-label" style="width:100px" >附件</label>\n' +
                        '                            <div class="layui-input-inline">\n' +
                        '                                <input style="width: 200px" id="fileuploadAgenda" name="fileuploadAgenda" class="layui-input" type="file">\n' +
                        '                            </div>\n' +
                        '                        </div>' +
                        '<div class="layui-inline" style="margin-left: 3%"><label class="layui-form-label" style="width:100px">证照类型</label>\n' +
                        '                                <div class="layui-input-inline">\n' +
                        '                                    <select name="licenseTypeId" id="licenseTypeId" lay-verify="orgDeptId">\n' +
                        '                                        <option value="" class="layui-this">请选择</option>\n' +
                        '                                    </select>\n' +
                        '                                </div></div>' +
                        '                    </div>\n' +
                        '                </div>\n' +
                        '\n' +
                        '                <div class="twoClick" style="background-color: #e5e5e5;margin-top: 20px"><h2 style="margin-left: 10%;height: 40px;\n' +
                        '    line-height: 40px;">自定义属性(根据证照类型自动获取)</h2></div>\n' +
                        '                <div class="two2" style="background-color: white;" >\n' +
                        '<div class="customize" > </div>' +
                        '                </div>\n' +
                        '            </div></form>'
                    ,
                    success: function () {
                        var licenseTypeId=data.licenseTypeId
                        $.ajax({
                            url:'/licenseType/selectLicenseTypeByCond',
                            type:'post',
                            dataType:'json',
                            data:{
                            },
                            success:function(res){
                                var arr=[];
                                var str
                                for(var i=0;i<res.data.length;i++){
                                    str+='<option orgFullname="'+res.data[i].orgFullname+'"  value="'+res.data[i].orgId+'">'+res.data[i].licenseTypeName+'</option>'
                                }

                                $('select[name="licenseTypeId"]').append(str);
                                form.render('select');
                            }
                        })
                        var optionItem1 = $("select[name='licenseTypeId']").find("option")
                        for(var i=0;i<$("select[name='licenseTypeId']").find("option").length;i++){
                            if(licenseTypeId==$(optionItem1[i]).val()){
                                $("#licenseTypeId").find('option[value="'+licenseTypeId+'"]').attr('selected','selected')

                            }

                        }



                        $.ajax({
                            url:'/EduorgMessage/selectAll',
                            type:'post',
                            dataType:'json',
                            async:false,
                            data:{
                            },
                            success:function(res){
                                var orgId=data.orgId
                                var arr=[];
                                var str
                                for(var i=0;i<res.obj.length;i++){
                                    str+='<option value="'+res.obj[i].orgId+'">'+res.obj[i].orgFullname+'</option>'
                                    if(orgId==res.obj[i].orgId){
                                       // $("#organName5 option[value="+orgId+"]").prop("selected","selected");
                                        $("#organName5").find('option[value="'+orgId+'"]').prop('selected','selected')

                                    }

                                 }

                                $('select[name="organName5"]').append(str);
                                form.render('select');
                            }

                        })
                        var optionItem = $("select[name='organName5']").find("option")
                        for(var i=0;i<$("select[name='organName5']").find("option").length;i++){
                            if(orgId==$(optionItem[i]).val()){
                                $("#organName5").find('option[value="'+orgId+'"]').attr('selected','selected')

                            }

                        }

                        form.render();
                        $('.oneClick').click(function(){
                            $('.one2').toggle()
                        })
                        $('.twoClick').click(function(){
                            $('.two2').toggle()
                        })
                        $.ajax({
                            type:'post',
                            url:'/license/selectLicenseById',
                            dataType:'json',
                            data:{
                                licenceId:data.licenceId,
                            },
                            success: function (json) {

                                $('#licenceName2').val(json.object.licenceName);
                                $('#organName5').val(json.object.organName);
                                $('#effectiveDate').val(json.object.effectiveDate);
                                $('#validPeriod').val(json.object.validPeriod);
                                $('#issueDate').val(json.object.issueDate);
                                $('#yearlyInspectionDate').val(json.object.yearlyInspectionDate);
                                $('#issuingUnit').val(json.object.issuingUnit);
                                $('#attachmentName').val(json.object.attachmentName);
                                $('#licenseTypeId').val(json.object.licenseTypeId);


                            }
                        })

                    },yes:function(){
                        $.ajax({
                            type:'post',
                            url:'/license/updateEduorgLicenseById',
                            dataType:'json',
                            data: {
                                orgId:$("#organName").val(),
                                licenceName: $("#licenceName").val(),
                                organName: $("#organName5").find("option:selected").text(),
                                effectiveDate: $("#effectiveDate").val(),
                                validPeriod: $("#validPeriod").val(),
                                issueDate: $("#issueDate").val(),
                                yearlyInspectionDate: $("#yearlyInspectionDate").val(),
                                issuingUnit: $("#issuingUnit").val(),
                                attachmentName: $("#attachmentName").val(),
                                borrowSubject: $("#borrowSubject").val(),
                                borrowSubject: $("#borrowSubject").val(),
                                borrowSubject: $("#borrowSubject").val(),
                            },
                            success: function (json) {
                               layui.closeAll();

                            }
                        })
                    }


                })
            }else if(obj.event === 'detail3'){
                layer.confirm('确定删除该条数据吗？', {
                    btn: ['确定','取消'], //按钮
                    title:"删除"
                }, function(){
                    $.ajax({
                        type: 'post',
                        url: '/license/deleteEduorgLicenseById',
                        dataType: 'json',
                        data: {
                            licenceId:data.licenceId
                        },
                        success: function (json) {
                            if(json.flag){
                                layer.closeAll();
                                $.layerMsg({content: '删除成功！', icon: 1}, function () {
                                    location.reload();
                                })
                            }
                        }
                    })
                })
            }

        })
var orgId;
        var orgFullname;
        $('#add').on('click',function(){
            licence()
        })
        function licence(type2,licenceId,datas){
            layer.open({
                type: 1,
                area: ['90%', '90%'], //宽高
                title:'新建证照',
                maxmin:true,
                btn: ['保存','取消'], //可以无限个按钮
                content: '<div class="layui-collapse artifical">\n' +
                    '                            <form class="layui-form" action="" id="licencePart1" lay-filter="formTest2">\n' +
                    '                            <p class="headerPic" ><i class="layui-icon layui-icon-down" style=""></i> 基础信息</p>\n' +
                    '                                <%-- 第一行--%>\n' +
                    '                                <div class="layui-row" style="margin-top: 20px;">\n' +
                    '                                    <div class="layui-col-xs4" style="padding: 0 5px;">\n' +
                    '                                        <div class="layui-form-item">\n' +
                    '                                            <div class="layui-inline" >\n' +
                    '                                                <label class="layui-form-label" >证照名称</label>\n' +
                    '                                                <div class="layui-input-inline" style="display: flex">\n' +
                    '                                                    <input type="text" id="licenceName1" name="licenceName"  lay-verify="required|phone"  class="layui-input ">\n' +
                    '                                                </div>\n' +
                    '<span style="color: red;margin-left: 5px;font-size: 25px;line-height: 80px;">*</span>' +
                    '                                            </div>\n' +
                    '                                        </div>\n' +
                    '                                    </div>\n' +
                    '                                    <div class="layui-col-xs4" style="padding: 0 5px;">\n' +
                    '                                        <div class="layui-form-item" >\n' +
                    '                                            <div class="layui-inline" >\n' +
                    '                                                <label class="layui-form-label" >机构名称</label>\n' +
                    '                                                <div class="layui-input-inline"style="display: flex">\n' +
                    '                                                    <input type="text" id="organName" readonly name="organName" lay-verify="required|phone" autocomplete="off" class="layui-input">\n' +
                    '                                                </div>\n' +
                    '<span style="color: red;margin-left: 5px;font-size: 25px;line-height: 80px;">*</span>' +
                    '                                            </div>\n' +
                    '                                        </div>\n' +
                    '                                    </div>\n' +
                    '                                    <div class="layui-col-xs4" style="padding: 0 5px;">\n' +
                    '                                        <div class="layui-form-item" >\n' +
                    '                                            <div class="layui-inline" >\n' +
                    '                                                <label class="layui-form-label" >有效日期</label>\n' +
                    '                                                <div class="layui-input-inline"style="display: flex">\n' +
                    '                                                    <input type="text" id="effectiveDate" name="effectiveDate" id="effectiveDate"  autocomplete="off" class="layui-input ">\n' +

                    '                                                </div>\n' +
                    '<span style="color: red;margin-left: 5px;font-size: 25px;line-height: 80px;">*</span>' +
                    '                                            </div>\n' +
                    '                                        </div>\n' +
                    '                                    </div>\n' +
                    '                                </div>\n' +
                    '                                <%-- 第二行--%>\n' +
                    '                                <div class="layui-row">\n' +
                    '                                    <div class="layui-col-xs4" style="padding: 0 5px;">\n' +
                    '                                        <div class="layui-form-item" >\n' +
                    '                                            <div class="layui-inline" >\n' +
                    '                                                <label class="layui-form-label">到期日期</label>\n' +
                    '                                                <div class="layui-input-inline"style="display: flex">\n' +
                    '                                                    <input type="text" id="validPeriod" name="validPeriod"  lay-verify="required|phone" autocomplete="off" class="layui-input">\n' +

                    '                                                </div>\n' +
                    '<span style="color: red;margin-left: 5px;font-size: 25px;line-height: 80px;">*</span>' +
                    '                                            </div>\n' +
                    '                                        </div>\n' +
                    '                                    </div>\n' +
                    '                                    <div class="layui-col-xs4" style="padding: 0 5px;">\n' +
                    '                                        <div class="layui-form-item" >\n' +
                    '                                            <div class="layui-inline" >\n' +
                    '                                                <label class="layui-form-label" >发证日期</label>\n' +
                    '                                                <div class="layui-input-inline"style="display: flex">\n' +
                    '                                                    <input type="text" name="issueDate" id="issueDate" lay-verify="required|phone" autocomplete="off" class="layui-input ">\n' +
                    '                                                </div>\n' +
                    '                                            </div>\n' +
                    '                                        </div>\n' +
                    '                                    </div>\n' +
                    '                                    <div class="layui-col-xs4" style="padding: 0 5px;">\n' +
                    '                                        <div class="layui-form-item" >\n' +
                    '                                            <div class="layui-inline" >\n' +
                    '                                                <label class="layui-form-label" >年检日期</label>\n' +
                    '                                                <div class="layui-input-inline"style="display: flex">\n' +
                    '                                                    <input type="text" name="yearlyInspectionDate" id="yearlyInspectionDate" lay-verify="required|phone" autocomplete="off" class="layui-input ">\n' +

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
                    '                                                <div class="layui-input-inline"style="display: flex">\n' +
                    '                                                    <input type="text" id="issuingUnit" name="issuingUnit" lay-verify="required|phone" autocomplete="off" class="layui-input ">\n' +
                    '                                                </div>\n' +
                    '                                            </div>\n' +
                    '                                        </div>\n' +
                    '                                    </div>\n' +
                    '                                    <div class="layui-col-xs4" style="padding: 0 5px;">\n' +
                    '                                        <div class="layui-form-item" >\n' +
                    '                                            <div class="layui-inline">\n' +
                    '                                                <label class="layui-form-label">证照类型</label>\n' +
                    '                                                <div class="layui-input-inline"style="display: flex">\n' +
                    '                                                    <select type="text" id="licenseTypeId" name="licenseTypeId" lay-verify="required|phone" autocomplete="off"  lay-filter="licenseTypeId">\n' +
                    '                                                    </select>\n' +
                    '                                                </div>\n' +
                    '<span style="color: red;margin-left: 5px;font-size: 25px;line-height: 80px;">*</span>' +
                    '                                            </div>\n' +
                    '                                        </div>\n' +
                    '                                    </div>\n' +
                    '                                </div>\n' +
                    '                                <div class="layui-row">' +
                    '                                    <div class="layui-col-xs12" style="padding: 0 5px;">\n' +
                    '                                        <div class="layui-form-item" >\n' +
                    '                                            <div class="layui-inline" style="width:100%">\n' +
                    '                                                <label class="layui-form-label">附件</label>\n' +
                    '                                               <div class="layui-input-block" style="padding-top: 9px;style="display: flex"">\n' +
                    '                                                   <div id="fileAllAgenda" style="text-align: left;"></div>\n' +
                    '                                                   <a href="javascript:;" class="openFile" style="float: left;position:relative;margin-top:9px">\n' +
                    '                                                       <img src="../img/mg11.png" alt="">\n' +
                    '                                                       <span>添加附件</span>\n' +
                    '<span style="color: red;margin-left: 5px;font-size: 25px">*</span>' +
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
                    $("input[name='organName']").val(deptName)
                    $("input[name='organName']").attr('orgId',orgIds)
                    laydate.render({
                        elem: '#effectiveDate'
                        , trigger: 'click' //采用click弹出
                        , type: 'date'
                    });
                    laydate.render({
                        elem: '#validPeriod'
                        , trigger: 'click' //采用click弹出
                        , type: 'date'
                    });
                    laydate.render({
                        elem: '#issueDate'
                        , trigger: 'click' //采用click弹出
                        , type: 'date'
                    });
                    laydate.render({
                        elem: '#yearlyInspectionDate'
                        , trigger: 'click' //采用click弹出
                        , type: 'date'
                    });
                    fileuploadFn('#fileuploadAgenda',$('#fileAllAgenda'));
                    // $.ajax({
                    //     type: 'get',
                    //     url: '/EduorgMessage/selectAllByOrgId',
                    //     dataType: 'json',
                    //     data: {
                    //         orgId: '39'
                    //     },
                    //     success: function (res) {
                    //         var object = res.object;
                    //         $('input[name="organName"]').val(object.orgFullname)
                    //     }
                    // });
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
                                orgId: orgId,
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
                    if ($("#licenceName1").val()==''||$("#licenceName1").val()==undefined){
                        layer.msg('证照名称不能为空！',{icon:0});
                        return false;
                    }
                    if ($("#organName").val()==''||$("#organName").val()==undefined){
                        layer.msg('机构名称不能为空！',{icon:0});
                        return false;
                    }
                    if ($("#effectiveDate").val()==''||$("#effectiveDate").val()==undefined){
                        layer.msg('有效日期不能为空！',{icon:0});
                        return false;
                    }
                    if ($("#validPeriod").val()==''||$("#validPeriod").val()==undefined){
                        layer.msg('到期日期不能为空！',{icon:0});
                        return false;
                    }
                    if ($("#licenseTypeId").val()==''||$("#licenseTypeId").val()==undefined){
                        layer.msg('证照类型不能为空！',{icon:0});
                        return false;
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
                        layer.msg('附件不能为空！',{icon:0});
                        return false;
                    }

                    var attachmentId1 = '';
                    var attachmentName1 = '';
                    for (var i = 0; i < $('#fileAllAgenda1 .dech').length; i++) {
                        attachmentId1 += $('#fileAllAgenda1 .dech').eq(i).find('input').val();
                        attachmentName1 += $('#fileAllAgenda1 a').eq(i).attr('name');
                    }
                    if(attachmentId == '' || attachmentId == undefined){
                        layer.msg('附件不能为空！',{icon:0});
                        return false;
                    }
                    $.ajax({
                        type: 'post',
                        url: '/EduorgMessage/selectAll',
                        dataType: 'json',
                        data: {
                        },
                        success: function (json) {
                            if(json.flag){
                                deptId = json.object.deptId
                                $.ajax({
                                    type: 'post',
                                    url: '/EduorgMessage/selectAll',
                                    dataType: 'json',
                                    data: {
                                        deptId: deptId
                                    },
                                    success: function (res) {
                                        var data2 = res.obj;
                                        orgId1 = data2[0].orgId;
                                        if(type == '1' || type == '2'){
                                            if(type2 == '1'){
                                                var url = "/license/updateEduorgLicenseById";
                                                var data = {
                                                    orgId: orgId1,
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
                                                    orgId: orgId1,
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
                                                    orgId: orgId1,
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
                                                    orgId: orgId1,
                                                    attachmentId: attachmentId,
                                                    attachmentName: attachmentName
                                                }
                                                for(var i=0; i<inputItem.length; i++){
                                                    data["col"+ (i+1)] = $(inputItem[i]).val();
                                                }
                                            }
                                        }
                                        $('#licencePart1').attr('action',url)
                                        $('#licencePart1').ajaxSubmit({
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
                                                            oneExpired: '',
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
                                })
                            }
                        }
                    })


                }
            });
        }


        function licence1(type2,licenceId,datas){
            layer.open({
                type: 1,
                area: ['90%', '90%'], //宽高
                title:'详情证照',
                maxmin:true,
                btn: ['取消'], //可以无限个按钮
                content: '<div class="layui-collapse artifical">\n' +
                    '                            <form class="layui-form" action="" id="licencePart" lay-filter="formTest2">\n' +
                    '                            <p class="headerPic1" ><i class="layui-icon layui-icon-down" style=""></i> 基础信息</p>\n' +
                    '<div class="add">' +
                    '                                <%-- 第一行--%>\n' +
                    '                                <div class="layui-row" style="margin-top: 20px;">\n' +
                    '                                    <div class="layui-col-xs4" style="padding: 0 5px;">\n' +
                    '                                        <div class="layui-form-item" >\n' +
                    '                                            <div class="layui-inline">\n' +
                    '                                                <label class="layui-form-label" >证照名称</label>\n' +
                    '                                                <div class="layui-input-inline">\n' +
                    '                                                    <input disabled="disabled"  type="text" id="licenceName5" name="licenceName5"  lay-verify="required|phone" autocomplete="off" class="layui-input jinyong">\n' +
                    '                                                </div>\n' +
                    '                                            </div>\n' +
                    '                                        </div>\n' +
                    '                                    </div>\n' +
                    '                                    <div class="layui-col-xs4" style="padding: 0 5px;">\n' +
                    '                                        <div class="layui-form-item" >\n' +
                    '                                            <div class="layui-inline" >\n' +
                    '                                                <label class="layui-form-label" >机构名称</label>\n' +
                    '                                                <div class="layui-input-inline">\n' +
                    '                                                    <input disabled="disabled" type="text" id="organName1" name="organName1" lay-verify="required|phone" autocomplete="off" disabled class="layui-input jinyong">\n' +
                    '                                                </div>\n' +
                    '                                            </div>\n' +
                    '                                        </div>\n' +
                    '                                    </div>\n' +
                    '                                    <div class="layui-col-xs4" style="padding: 0 5px;">\n' +
                    '                                        <div class="layui-form-item" >\n' +
                    '                                            <div class="layui-inline" >\n' +
                    '                                                <label class="layui-form-label" >有效日期</label>\n' +
                    '                                                <div class="layui-input-inline">\n' +
                    '                                                    <input disabled="disabled" type="text"  name="effectiveDate" id="effectiveDate"  autocomplete="off" class="layui-input jinyong">\n' +
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
                    '                                                <label class="layui-form-label">到期日期</label>\n' +
                    '                                                <div class="layui-input-inline">\n' +
                    '                                                    <input disabled="disabled" type="text" id="validPeriod" name="validPeriod"  lay-verify="required|phone" autocomplete="off" class="layui-input jinyong">\n' +
                    '                                                </div>\n' +
                    '                                            </div>\n' +
                    '                                        </div>\n' +
                    '                                    </div>\n' +
                    '                                    <div class="layui-col-xs4" style="padding: 0 5px;">\n' +
                    '                                        <div class="layui-form-item" >\n' +
                    '                                            <div class="layui-inline" >\n' +
                    '                                                <label class="layui-form-label" >发证日期</label>\n' +
                    '                                                <div class="layui-input-inline">\n' +
                    '                                                    <input disabled="disabled" type="text" name="issueDate" id="issueDate" lay-verify="required|phone" autocomplete="off" class="layui-input jinyong">\n' +
                    '                                                </div>\n' +
                    '                                            </div>\n' +
                    '                                        </div>\n' +
                    '                                    </div>\n' +
                    '                                    <div class="layui-col-xs4" style="padding: 0 5px;">\n' +
                    '                                        <div class="layui-form-item" >\n' +
                    '                                            <div class="layui-inline" >\n' +
                    '                                                <label class="layui-form-label" >年检日期</label>\n' +
                    '                                                <div class="layui-input-inline">\n' +
                    '                                                    <input disabled="disabled" type="text" name="yearlyInspectionDate" id="yearlyInspectionDate" lay-verify="required|phone" autocomplete="off" class="layui-input jinyong">\n' +
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
                    '                                                    <input disabled="disabled" type="text" id="issuingUnit" name="issuingUnit" lay-verify="required|phone" autocomplete="off" class="layui-input jinyong">\n' +
                    '                                                </div>\n' +
                    '                                            </div>\n' +
                    '                                        </div>\n' +
                    '                                    </div>\n' +
                    '                                    <div class="layui-col-xs4" style="padding: 0 5px;">\n' +
                    '                                        <div class="layui-form-item" >\n' +
                    '                                            <div class="layui-inline">\n' +
                    '                                                <label class="layui-form-label">证照类型</label>\n' +
                    '                                                <div class="layui-input-inline">\n' +
                    '                                                    <select  disabled="disabled"  type="text" id="licenseTypeId" name="licenseTypeId" lay-verify="required|phone" autocomplete="off" class="jinyong" lay-filter="licenseTypeId">\n' +
                    '                                                    </select>\n' +
                    '                                                </div>\n' +
                    '                                            </div>\n' +
                    '                                        </div>\n' +
                    '                                    </div>\n' +
                    '                                <div class="layui-row">' +
                    '                                    <div class="layui-col-xs12" style="padding: 0 5px;">\n' +
                    '                                        <div class="layui-form-item" >\n' +
                    '                                            <div class="layui-inline" style="width:100%">\n' +
                    '                                                <label class="layui-form-label">附件</label>\n' +
                    '                                               <div class="layui-input-block" style="padding-top: 9px">\n' +
                    '                                                   <div id="fileAllAgenda" style="text-align: left;"></div>\n' +
                    '                                                   <a href="javascript:;" class="openFile" style="float: left;position:relative;margin-top:9px">\n' +
                    '                                                   </a>\n' +
                    '                                                </div>' +
                    '                                            </div>\n' +
                    '                                        </div>\n' +
                    '                                    </div>\n' +
                    '                                </div>\n' +
                    '                                </div>\n' +
                    '</div>' +
                    '                            </form>\n' +
                    '                            <p class="headerPic2"><i class="layui-icon layui-icon-down" style=""></i> 自定义属性（根据证照类型自动获取）</p>\n' +
                    '                             <div class="customize" > </div>' +
                    '                    </div>',
                success:function () {

                    $.ajax({
                        type:'post',
                        url:'/license/selectLicenseById',
                        dataType:'json',
                        data:{
                            licenceId:data.licenceId,
                        },
                        success: function (json) {
                            if(json.object.licenseTypeId!=''){
                                $("#licenseTypeId option[value="+json.object.licenseTypeId+"]").attr("selected","selected")
                            }
                            form.render('select');
                            $('#licenceName5').val(json.object.licenceName);
                            $('#organName1').val(json.object.organName);
                            $('#effectiveDate').val(json.object.effectiveDate);
                            $('#validPeriod').val(json.object.validPeriod);
                            $('#issueDate').val(json.object.issueDate);
                            $('#yearlyInspectionDate').val(json.object.yearlyInspectionDate);
                            $('#issuingUnit').val(json.object.issuingUnit);
                            $('#attachmentName').val(json.object.attachmentName);
                            $('#licenseTypeId').val(json.object.licenseTypeId);
                            $('input[name="col1"]').val(json.object.col1);
                            $('input[name="col2"]').val(json.object.col2);

                            var strr = ''
                            if((json.object.attUrl[0] != undefined && json.object.attUrl.length>0)){
                                for(var i=0;i<json.object.attUrl.length;i++){
                                    var str1 = ""
                                    if( json.object.attUrl[i].attUrl != undefined ){
                                        str1 = '<div class="dech" deurl="' +json.object.attUrl[i].attUrl + '">' +
                                            '<a href="/download?' + json.object.attUrl[i].attUrl + '" name="'+json.object.attUrl[i].attachName+'*" style="text-decoration:none;margin-left:5px;">' +
                                            '<img src="/img/attachment_icon.png">' + json.object.attUrl[i].attachName + '</a>' +
                                            '<img class="deImgs" style="margin-left:5px;cursor: pointer;" src="/img/file/icon_deletecha_03.png">' +
                                            '<input type="hidden" class="inHidden" value="' + json.object.attUrl[i].aid + '@' + json.object.attUrl[i].ym + '_' + json.object.attUrl[i].attachId +',">' +
                                            '<a onclick="pdurls($(this))" href="javascript:;" style="padding-left: 5px">' +
                                            '<img src="/img/attachmentIcon/icon_skim.png" style="padding: 0 5px;">查阅</a>' +
                                            '<a style="padding-left: 5px" href="/download?' + json.object.attUrl[i].attUrl + '">' +
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


                            form.render();
                            $('#col1').val(json.object.licTypeVal[0]);
                            $('#col2').val(json.object.licTypeVal[1]);
                            $('#col3').val(json.object.licTypeVal[2]);
                            $('#col4').val(json.object.licTypeVal[3]);
                            $('#col5').val(json.object.licTypeVal[4]);
                            $('#col6').val(json.object.licTypeVal[5]);
                            $('#col7').val(json.object.licTypeVal[6]);
                            $('#col8').val(json.object.licTypeVal[7]);
                            $('#col9').val(json.object.licTypeVal[8]);
                            $('#col10').val(json.object.licTypeVal[9]);
                        }
                    })


                    $('.headerPic2').click(function(){
                        $('.customize').toggle()

                    })
                    $('.headerPic1').click(function(){
                        $('.add').toggle()

                    })
                    laydate.render({
                        elem: '#effectiveDate'
                        , trigger: 'click' //采用click弹出
                        , type: 'date'
                    });
                    laydate.render({
                        elem: '#validPeriod'
                        , trigger: 'click' //采用click弹出
                        , type: 'date'
                    });
                    laydate.render({
                        elem: '#issueDate'
                        , trigger: 'click' //采用click弹出
                        , type: 'date'
                    });
                    laydate.render({
                        elem: '#yearlyInspectionDate'
                        , trigger: 'click' //采用click弹出
                        , type: 'date'
                    });
                    fileuploadFn('#fileuploadAgenda',$('#fileAllAgenda'));
                    $.ajax({
                        type: 'get',
                        url: '/EduorgMessage/selectAllByOrgId',
                        dataType: 'json',
                        data: {
                            orgId: '39'
                        },
                        success: function (res) {
                            var object = res.object;
                            $('input[name="organName"]').val(object.orgFullname)
                        }
                    });
                    $.ajax({
                        type: 'get',
                        async:false,
                        url: '/licenseType/selectLicenseTypeByCond',
                        dataType: 'json',
                        success: function (res) {
                            var object = res.data;
                            var strs = '<option value="">请选择</option>';
                            for(var i=0; i<object.length;i++){
                                strs += '<option value="' + object[i].licenseTypeId + '">' + object[i].licenseTypeName + '</option>';
                            }
                            $('select[name="licenseTypeId"]').append(strs)
                            form.render('select');

                            if(type2 == "1" || type2 == "2"){
                                $('select[name="licenseTypeId"]').find('option').each(function (i,n) {
                                    if($(this).val()== datas.licenseTypeId){
                                        $(this).attr('selected','selected')
                                        return false
                                    }

                                })
                            }

                            form.render();
                            $('.customize').show();

                        }
                    })

                    //动态显示自定义属性
                        $.ajax({
                            type: 'get',
                            url: '/licenseType/selectLicTypeById',
                            dataType: 'json',
                            data: {
                                licenseTypeId: data.licenseTypeId
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
                                        '                                        <input type="text" id="col'+ (i+1) + '" name="col'+ (i+1) + '" lay-verify="required|phone" autocomplete="off" class="layui-input">\n' +
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
                                form.val("formTest2",object);
                            }
                        })
                        if(type2 == '2'){
                            $('.jinyong').attr('disabled','disabled')
                            $('.layui-layer-btn0').css('display','none')
                        }
                    }
                    $.ajax({
                        type:'post',
                        url:'/license/selectLicenseById',
                        dataType:'json',
                        data:{
                            licenceId:data.licenceId,
                        },
                        success: function (json) {
                            $('#col1').val(json.object.licTypeVal[0]);
                            $('#col2').val(json.object.licTypeVal[1]);
                            $('#col3').val(json.object.licTypeVal[2]);
                            $('#col4').val(json.object.licTypeVal[3]);
                            $('#col5').val(json.object.licTypeVal[4]);
                            $('#col6').val(json.object.licTypeVal[5]);
                            $('#col7').val(json.object.licTypeVal[6]);
                            $('#col8').val(json.object.licTypeVal[7]);
                            $('#col9').val(json.object.licTypeVal[8]);
                            $('#col10').val(json.object.licTypeVal[9]);
                        }
                    })
                },
                yes: function(index, layero){
                    var inputItem = $('.customize').find('input');
                    if(type == '1' || type == '2'){
                        if(type2 == '1'){
                            // for(var i=0; i<inputItem.length; i++){
                            //     LicTypeName.push($(inputItem[i]).parent().prev().text());
                            //     LicTypeVal.push();
                            // }
                            var url = "/license/updateEduorgLicenseById";
                            var data = {
                                orgId: orgId,
                                licenceId: licenceId,
                            }
                            for(var i=0; i<inputItem.length; i++){
                                data["col"+ (i+1)] = $(inputItem[i]).val();
                            }
                        }else{
                            var url = "/license/addEduorgLicense";
                            var data = {
                                orgId: orgId,
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
                            }
                            for(var i=0; i<inputItem.length; i++){
                                data["col"+ (i+1)] = $(inputItem[i]).val();
                            }
                        }else{
                            var url = "/license/addEduorgLicense";
                            var data = {
                                orgId: orgLegal,
                            }
                            for(var i=0; i<inputItem.length; i++){
                                data["col"+ (i+1)] = $(inputItem[i]).val();
                            }
                        }
                    }
                    console.log(data)
                    $('#licencePart').attr('action',url)
                    // $('#licencePart').ajaxSubmit({
                    //     type: 'post',
                    //     dataType: 'json',
                    //     data: data,
                    //     success: function (json) {
                    //         if(json.flag){
                    //             // licenceId = json.licenceId
                    //             $.layerMsg({content:'保存成功！',icon:1});
                    //             table.reload('tableDemocratic4',{
                    //                 where: {
                    //                     orgId:orgLegal,
                    //                     oneExpired: '',
                    //                     expired: '',
                    //                 }
                    //             })
                    //         }else{
                    //             $.layerMsg({content:json.msg,icon:1});
                    //         }
                    //     }
                    // })
                    layer.close(index);
                }
            });
        }


        laydate.render({
            elem: '#beginTimeAdd' //指定元素
            , trigger: 'click' //采用click弹出
            , type: 'datetime'
        });
        laydate.render({
            elem: '#createTimeAdd' //指定元素
            //, trigger: 'click' //采用click弹出
            , type: 'datetime'
            , value: new Date(new Date())
        });
        laydate.render({
            elem: '#endTimeAdd' //指定元素
            , trigger: 'click' //采用click弹出
            , type: 'datetime'
        });
        //参会人员
        $("#partUsersAdd").on("click", function () {
            user_id = 'partUsers';
            $.popWindow("../common/selectUser");
        });

        //查看人员
        $("#viewUsersAdd").on("click", function () {
            user_id = 'viewUsers';
            $.popWindow("../common/selectUser");
        });

        $('#partUsersDelete').click(function () {
            $('#partUsers').val('');
            $('#partUsers').attr('username','');
            $('#partUsers').attr('dataid','');
            $('#partUsers').attr('user_id','');
            $('#partUsers').attr('userprivname','');
            return false
        })

        $('#viewUsersDelete').click(function () {
            $('#viewUsers').val('');
            $('#viewUsers').attr('username','');
            $('#viewUsers').attr('dataid','');
            $('#viewUsers').attr('user_id','');
            $('#viewUsers').attr('userprivname','');
            return false
        })



    });
</script>
</body>
</html>

