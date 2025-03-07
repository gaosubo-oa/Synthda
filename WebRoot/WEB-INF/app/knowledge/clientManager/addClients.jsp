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
    <link rel="stylesheet" href="/lib/layui/layui/css/layui.css?20210319.1">
    <link rel="stylesheet" href="/lib/layui/layui/css/common.css">
    <link rel="stylesheet" href="/lib/layui/layui/css/eleTree.css">
    <link rel="stylesheet" type="text/css" href="/lib/layui/layui/css/layui.css?20210319.1"/>
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
                                <input type="text"  name="companyName"    placeholder="请输入" id="companyName" autocomplete="off" class="layui-input">
                                <input type="hidden" id="customerId" name="customerId">
                            </td>
                            <td class="tdstyl">
                                <label class="layui-form-label">栏目角色</label>
                            </td>
                            <td colspan="2" class="tdsty2">
                                <select id="role" name="role" lay-filter="formNoSelect"></select>
                            </td>
                        </tr>
                        <tr>
                            <td class="tdstyl" >
                                <label class="layui-form-label" style="">
                                    <span class="red">*</span>机构代码</label>
                            </td>
                            <td colspan="2" class="tdsty2">
                                <input type="text"  name="companyCode"    placeholder="请输入" id="companyCode" autocomplete="off" class="layui-input">
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
                                <label class="layui-form-label">企业性质</label>
                            </td>
                            <td colspan="2" class="tdsty2">
                                <select name="companyNatrue" id="companyNatrue"></select>
                            </td>
                        </tr>
                        <tr>
                            <td class="tdstyl">
                                <label class="layui-form-label"><span class="red">*</span>oa用户名</label>
                            </td>
                            <td colspan="2" class="tdsty2">
                                <input type="text" id="byName" name="byName" autocomplete="off" class="layui-input">
                                <input type="hidden" id="userId" name="userId">
                            </td>
                            <td class="tdstyl">
                                <label class="layui-form-label"><span class="red">*</span>oa角色</label>
                            </td>
                            <td colspan="2" class="tdsty2">
                                <input type="text" id="userPriv" name="userPriv" placeholder="请输入" autocomplete="off" class="layui-input">
                            </td>
                        </tr>
                        <tr style="height:80px!important;">
                            <td class="tdstyl">
                                <label class="layui-form-label" style=""><span class="red pwdBox">*</span>oa密码</label>
                            </td>
                            <td colspan="2" class="tdsty2">
                                <input type="password" style="margin-top: -10px" id="password" name="password" autocomplete="new-password" class="layui-input">
                                <span id="passwordTxt" style="position: absolute;display: none"></span>
                            </td>
                            <td class="tdstyl">
                                <label class="layui-form-label" style=""><span class="red pwdBox">*</span>重复密码</label>
                            </td>
                            <td colspan="2" class="tdsty2">
                                <input type="password" style="margin-top: -10px" id="password2" name="password2" autocomplete="off" class="layui-input">
                                <span id="passwordTxt2" style="position: absolute;display: none"></span>
                            </td>
                        </tr>
                        <tr>
                            <td class="tdstyl">
                                <label class="layui-form-label" style="">备注</label>
                            </td>
                            <td colspan="2" class="tdsty2">
                                <input type="text" id="memo" name="memo" placeholder="请输入" autocomplete="off" class="layui-input">
                            </td>
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
                                <label class="layui-form-label" style=""><span class="red">*</span>权限类别</label>
                            </td>
                            <td colspan="2" class="tdsty2">
                                <select id="privType" lay-filter="privTypeFilter" name="privType"><option value="">请选择</option><option value="0">浏览</option><option value="1">下载</option></select>
                            </td>
                            <td class="tdstyl">
                                <label class="layui-form-label" style="">文档等级</label>
                            </td>
                            <td colspan="2" class="tdsty2">
                                <select id="docfileClass" lay-filter="docfileClass" name="docfileClass"><option value="">请选择</option></select>
                            </td>
                        </tr>
                        <tr class="downDiv">
                            <td class="tdstyl">
                                <label  class="layui-form-label" style=""><span class="red">*</span>下载开始时间</label>
                            </td>
                            <td colspan="2" class="tdsty2">
                                <input type="text" readonly id="downloadBDate" placeholder="请选择" name="downloadBDate" autocomplete="off" class="layui-input">
                            </td>
                            <td class="tdstyl">
                                <label class="layui-form-label" style=""><span class="red">*</span>下载结束时间</label>
                            </td>
                            <td colspan="2" class="tdsty2">
                                <input type="text" readonly id="downloadEDate"  placeholder="请选择" name="downloadEDate" autocomplete="off" class="layui-input">
                            </td>
                        </tr>
                        <tr id="finde" class="lookDiv">
                            <td class="tdstyl">
                                <label class="layui-form-label"><span class="red">*</span>浏览开始时间</label>
                            </td>
                            <td colspan="2" class="tdsty2">
                                <input type="text" readonly id="browseBDate"  placeholder="请选择" name="browseBDate" autocomplete="off" class="layui-input">
                            </td>
                            <td class="tdstyl">
                                <label class="layui-form-label" style=""><span class="red">*</span>浏览结束时间</label>
                            </td>
                            <td colspan="2" class="tdsty2">
                                <input type="text" readonly id="browseEDate" placeholder="请选择" name="browseEDate" autocomplete="off" class="layui-input">
                            </td>
                        </tr>
                    </table>
                </div>
            </div>
            <div class="layui-colla-item">
                <h2 class="layui-colla-title">
                    氚云对接
                </h2>
                <div class="layui-colla-content layui-show">
                    <table class="layui-table" lay-skin="line" id="h3Yun" lay-filter="projectInfoFilter">
                        <tr>
                            <td class="tdstyl">
                                <label class="layui-form-label">appCode：</label>
                            </td>
                            <td colspan="2" class="tdsty2">
                                <input type="text" id="appCode"  name="appCode" autocomplete="off" class="layui-input">
                            </td>
                            <td class="tdstyl">
                                <label class="layui-form-label">engineCode：</label>
                            </td>
                            <td colspan="2" class="tdsty2">
                                <input type="text" id="engineCode" name="engineCode" autocomplete="off" class="layui-input">
                            </td>
                        </tr>
                        <tr style="height:80px!important;">
                            <td class="tdstyl">
                                <label class="layui-form-label">secret：</label>
                            </td>
                            <td colspan="2" class="tdsty2">
                                <input type="text" id="engineSecret" name="engineSecret" autocomplete="off" class="layui-input">
                            </td>
                            <td class="tdstyl">
                                <label class="layui-form-label">companyObjectId：</label>
                            </td>
                            <td colspan="2" class="tdsty2">
                                <input type="text" id="companyObjectId"  name="companyObjectId" autocomplete="off" class="layui-input">
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
    var pdata = parent.parentData;
    var secPassMax="20";//密码最大位
    var secPassMin= "8";//密码最小位
    layui.use(['laydate','table','layer','form','eleTree','element'], function () {
        var form = layui.form
            ,layer = layui.layer
            ,$ = layui.jquery
            ,laydate = layui.laydate
            ,element=layui.element
            ,eleTree = layui.eleTree
            ,table = layui.table;

        //查询密码最大位和最小位
        $.ajax({
            url:"/user/getPwRule",
            dataType:'json',
            async: false,
            success:function(res){
                 if(res.flag){
                     if(res.object!=undefined){
                        if(res.object.secPassMax!=undefined){
                            secPassMax = res.object.secPassMax;
                        }
                         if(res.object.secPassMin!=undefined){
                             secPassMin = res.object.secPassMin;
                         }
                     }
                 }
            }
        })
        $("#passwordTxt").text("密码长度"+secPassMin+"-"+secPassMax+"位");
        $("#passwordTxt2").text("密码长度"+secPassMin+"-"+secPassMax+"位");
        if(type == "add"){
            $(".pwdBox").show();
            var $select1 = $("select[name='companyNatrue']");
            var optionStr = '<option value="">请选择</option>';
            $.ajax({ //查询企业性质
                url: '/code/getCode?parentNo=KNOWLEDGE_COMPANY_NATRUE',
                type: 'get',
                dataType: 'json',
                async: false,
                success: function (res) {
                    if (res.obj != undefined && res.obj.length > 0) {
                        for (var i = 0; i < res.obj.length; i++) {
                            optionStr += '<option value="' + res.obj[i].codeNo + '">' + res.obj[i].codeName + '</option>'
                        }
                    }
                }
            })
            $select1.html(optionStr);
            //渲染文档等级
            var $select3 = $("select[name='docfileClass']");
            var optionStr3 = '<option value="">请选择</option>';
            $.ajax({ //查询文档等级
                url: '/code/getCode?parentNo=KNOWLEDGE_DOCFILE_CLASS',
                type: 'get',
                dataType: 'json',
                async: false,
                success: function (res) {
                    if (res.obj != undefined && res.obj.length > 0) {
                        for (var i = 0; i < res.obj.length; i++) {
                            optionStr3 += '<option value="' + res.obj[i].codeNo + '">' + res.obj[i].codeName + '</option>'
                        }
                    }
                }
            })
            $select3.html(optionStr3);
            //渲染角色
            var $select2 = $("select[name='role']");
            var optionStr2 = '<option value="">请选择</option>';
            $.ajax({ //查询所有角色
                url: '/clientRole/getAllRoleColumn',
                type: 'post',
                dataType: 'json',
                async: false,
                success: function (res) {
                    if (res.data != undefined && res.data.length > 0) {
                        for (var i = 0; i < res.data.length; i++) {
                            optionStr2 += '<option name="' + res.data[i].columnName + '" roleId="' + res.data[i].roleId + '" docfileClass="' + res.data[i].docfileClass + '" privId="' + res.data[i].privId + '" privName="' + res.data[i].privName + '"  value="' + res.data[i].columnId + '">' + res.data[i].roleName + '</option>'
                        }
                    }

                }
            })
            $select2.html(optionStr2);
            laydate.render({
                elem: '#downloadBDate'
                , trigger: 'click'//呼出事件改成click
                , type: 'datetime'
            });
            laydate.render({
                elem: '#downloadEDate'
                , trigger: 'click'//呼出事件改成click
                , type: 'datetime'
            });
            laydate.render({
                elem: '#browseBDate'
                , trigger: 'click'//呼出事件改成click
                , type: 'datetime'
            });
            laydate.render({
                elem: '#browseEDate'
                , trigger: 'click'//呼出事件改成click
                , type: 'datetime'
            });
            form.render();//初始化表单
            $.ajax({ //查询文档等级
                url: '/knowledge/childTree',
                type: 'get',
                dataType: 'json',
                async:false,
                success: function (res) {
                    if(res.code == 0){
                        var qdata = res.data;
                        var str = "";
                        if(qdata.length>0&&qdata.length%2 == 0){
                            for(var i =0; i<qdata.length;i++){
                                if(i%2 == 0){
                                    str+= '<tr class="removeBox">' +
                                        '<td class="tdstyl">' +
                                        '<label  class="layui-form-label" paid="'+qdata[i].id+'" style="">'+qdata[i].name+'</label>' +
                                        '</td>' +
                                        '<td colspan="2" class="tdsty2" lay-event="eleFn">' +
                                        '<textarea type="text"  data-type="0" id="pele'+i+'" pid name="ptitle" required="" style="cursor: pointer"  placeholder="请选择" readonly="" autocomplete="off" class="textAreaBox ele treeNum"></textarea>' +
                                        '<div class="eleTree ele'+i+'" lay-filter="data1" style="display:none;position:absolute;border: 1px solid #d2d2d2;overflow-y: auto;background-color: #fff;border-radius: 2px;box-shadow: 0 2px 4px rgba(0,0,0,.12);box-sizing: border-box;overflow:hidden;z-index: 999;top:45px;left:15px;width: 90%;"></div></div></div></div>' +
                                        '</td>'
                                }else if(i%2 != 0){
                                    str +=  '<td class="tdstyl">' +
                                        '<label class="layui-form-label" paid="'+qdata[i].id+'" style="">'+qdata[i].name+'</label>\n' +
                                        '</td>' +
                                        '<td colspan="2" class="tdsty2" lay-event="eleFn">\n' +
                                        '<textarea type="text"  data-type="0" id="pele'+i+'" pid name="ptitle" required="" style="cursor: pointer"  placeholder="请选择" readonly="" autocomplete="off" class="textAreaBox ele treeNum"></textarea>' +
                                        '<div class="eleTree ele'+i+'" lay-filter="data1" style="display:none;position:absolute;border: 1px solid #d2d2d2;overflow-y: auto;background-color: #fff;border-radius: 2px;box-shadow: 0 2px 4px rgba(0,0,0,.12);box-sizing: border-box;overflow:hidden;z-index: 999;top:45px;left:15px;width: 90%;"></div></div></div></div>' +
                                        '</td>' +
                                        '</tr>'
                                }
                            }
                        }else {
                            for (var i = 0; i < qdata.length-1; i++) {
                                if (i % 2 == 0) {
                                    str += '<tr class="removeBox">' +
                                        '<td class="tdstyl">' +
                                        '<label  class="layui-form-label" style="" paid="'+qdata[i].id+'">'+qdata[i].name+'</label>' +
                                        '</td>' +
                                        '<td colspan="2" class="tdsty2" lay-event="eleFn">' +
                                        '<textarea type="text"  data-type="0" id="pele'+i+'" pid name="ptitle" required="" style="cursor: pointer"  placeholder="请选择" readonly="" autocomplete="off" class="textAreaBox ele treeNum"></textarea>' +
                                        '<div class="eleTree ele'+i+'" lay-filter="data1" style="display:none;position:absolute;border: 1px solid #d2d2d2;overflow-y: auto;background-color: #fff;border-radius: 2px;box-shadow: 0 2px 4px rgba(0,0,0,.12);box-sizing: border-box;overflow:hidden;z-index: 999;top:45px;left:15px;width: 90%;"></div></div></div></div>' +
                                        '</td>'
                                } else if (i % 2 != 0) {
                                    str += '<td class="tdstyl">' +
                                        '<label class="layui-form-label" paid="'+qdata[i].id+'" style="">'+qdata[i].name+'</label>\n' +
                                        '</td>' +
                                        '<td colspan="2" class="tdsty2" lay-event="eleFn">\n' +
                                        '<textarea type="text"  data-type="0" id="pele'+i+'" pid name="ptitle" required="" style="cursor: pointer"  placeholder="请选择" readonly="" autocomplete="off" class="textAreaBox ele treeNum"></textarea>' +
                                        '<div class="eleTree ele'+i+'" lay-filter="data1" style="display:none;position:absolute;border: 1px solid #d2d2d2;overflow-y: auto;background-color: #fff;border-radius: 2px;box-shadow: 0 2px 4px rgba(0,0,0,.12);box-sizing: border-box;overflow:hidden;z-index: 999;top:45px;left:15px;width: 90%;"></div></div></div></div>' +
                                        '</td>' +
                                        '</tr>'
                                }
                            }
                            str +=  '<tr class="removeBox">' +
                                '<td class="tdstyl">' +
                                '<label  class="layui-form-label" style="" paid="'+qdata[qdata.length-1].id+'">'+qdata[qdata.length-1].name+'</label>' +
                                '</td>' +
                                '<td colspan="2" class="tdsty2" lay-event="eleFn">' +
                                '<textarea type="text"  data-type="0" id="pele'+i+'" pid name="ptitle" required="" style="cursor: pointer"  placeholder="请选择" readonly="" autocomplete="off" class="textAreaBox ele treeNum"></textarea>' +
                                '<div class="eleTree ele'+i+'" lay-filter="data1" style="display:none;position:absolute;border: 1px solid #d2d2d2;overflow-y: auto;background-color: #fff;border-radius: 2px;box-shadow: 0 2px 4px rgba(0,0,0,.12);box-sizing: border-box;overflow:hidden;z-index: 999;top:45px;left:15px;width: 90%;"></div></div></div></div>' +
                                '</td></tr>'
                        }
                        $("#finde").after(str);
                        form.render();
                        if(qdata.length>0) {
                            for (var i = 0; i < qdata.length; i++) {
                                (function (i) {
                                    var columnId = qdata[i].columnId;
                                    var elm = '.ele' + i
                                    eleTree.render({
                                        elem: '.ele' + i,
                                        data: qdata[i].children,
                                        expandOnClickNode: false,
                                        highlightCurrent: true,
                                        showLine: true,
                                        showCheckbox: true,
                                        checked: true,
                                        // defaultExpandAll: true,
                                        load: function (data, callback) {
                                        },
                                        done: function (res) {
                                            // var pidar = columnId.split(",");
                                            // var pidarr = [];
                                            // for (var j = 0; j < pidar.length; j++) {
                                            //     if (pidar[j] == "") {
                                            //
                                            //     } else {
                                            //         pidarr.push(pidar[j]);
                                            //     }
                                            // }
                                            // for (var j = 0; j < pidarr.length; j++) {
                                            //     $(elm + " div[data-id=" + pidarr[j] + "]").find("input").eq(0).attr("checked", true);
                                            //     $(elm + " div[data-id=" + pidarr[j] + "]").find("input").eq(0).attr("eletree-status", "1");
                                            //     // $(elm+" div[data-id="+pidarr[j]+"]").find("input").eq(0).addClass("eleTree-disabled");
                                            //     $(elm + " div[data-id=" + pidarr[j] + "]").find("input").eq(0).next("div.eleTree-checkbox").addClass("eleTree-checkbox-checked");
                                            //     $(elm + " div[data-id=" + pidarr[j] + "]").find("input").eq(0).next("div.eleTree-checkbox").find("i").addClass("layui-icon-ok");
                                            // }
                                        }
                                    });
                                })(i);
                            }
                        }
                    }


                }
            })
            var $td = $("#projectInfo").find('td[lay-event="eleFn"]');
            $td.click(function (obj) {
                var td = $(this);
                if(td.find("textarea.ele").attr("data-type") == "0"){
                    td.find(".eleTree").slideDown();
                    td.find("textarea.ele").attr("data-type","1");
                }else{
                    td.find(".eleTree").slideUp();
                    td.find("textarea.ele").attr("data-type","0");
                }
                //点击本身外收起下拉的主体
                document.onmouseup = function(e){
                    var e = e || window.event;
                    var target = e.target || e.srcElement;
                    //1. 点击事件的对象不是目标区域本身
                    //2. 事件对象同时也不是目标区域的子元素
                    if(!td.is(e.target) &&td.has(e.target).length === 0){
                        $(".eleTree").slideUp();
                        $("textarea.ele").attr("data-type","0");
                    }
                }
                //选中监听事件
                var arr = [];
                var arr1 = [];
                var pidt = td.find("textarea.ele").attr("pid");
                var valt = td.find("textarea.ele").val();
                layui.eleTree.on("nodeChecked(data1)",function(d) {
                    var id = d.data.currentData.columnId+"";
                    var label = d.data.currentData.label+"";
                    if(d.isChecked == true || d.isChecked == "true"){
                        arr.push(id);
                        arr1.push(label);
                    }else{
                        arr.remove(id);
                        arr1.remove(label);
                    }
                    if(pidt != undefined || pidt != "undefined" || pidt != ""){
                        var str = pidt;
                    }else{
                        var str= "";
                    }
                    if(valt != undefined || valt != "undefined" || valt != ""){
                        var str1 = valt;
                    }else{
                        var str1 = "";
                    }
                    for(var i=0;i<arr.length;i++){
                        str+=arr[i]+","
                        str1+=arr1[i]+","
                    }
                    td.find("textarea.ele").val(str1);
                    td.find("textarea.ele").attr("pid",str);
                    // var data =  layui.table.cache["addTable"]
                    // var ind = td.find("textarea.ele").parents("tr").attr("data-index");
                    // data[ind].columnName = str1;
                    // data[ind].columnId = str;
                })
            })
        }
        if(type == "edit" || type == "look"){
            $(".pwdBox").hide();
            $("#companyName").val(pdata.companyName);
            $("#companyCode").val(pdata.companyCode);
            $("#contactUser").val(pdata.contactUser);
            $("#contactPhone").val(pdata.contactPhone);
            $("#downloadBDate").val(pdata.downloadBDate);
            $("#downloadEDate").val(pdata.downloadEDate);
            $("#browseBDate").val(pdata.browseBDate);
            $("#browseEDate").val(pdata.browseEDate);
            $("#byName").val(pdata.byName);
            $("#password").val(pdata.password);
            $("#password2").val(pdata.password2);
            $("#memo").val(pdata.memo);
            $("#userPriv").val(pdata.userPrivName);
            $("#userPriv").attr("privid",pdata.userPriv);
            if(pdata.customerId!=undefined){
                $("#customerId").val(pdata.customerId);
            }
            var n;
            if(pdata.privType == "浏览"){
                n = "0"
            }
            if(pdata.privType == "下载"){
                n = "1"
            }
            if(n=='1'){ //下载
                $(".lookDiv").hide();
                $(".downDiv").show();
            }else if(n=='0'){ //浏览
                $(".lookDiv").show();
                $(".downDiv").hide();
            }else{
                $(".lookDiv").show();
                $(".downDiv").show();
            }
            $("#appCode").val(pdata.appCode);
            $("#engineCode").val(pdata.engineCode);
            $("#engineSecret").val(pdata.engineSecret);
            $("#companyObjectId").val(pdata.companyObjectId);
            $('#privType').find('option[value="'+n+'"]').prop('selected','selected');
            var $select1 = $("select[name='companyNatrue']");
            var optionStr = '<option value="">请选择</option>';
            $.ajax({ //查询企业性质
                url: '/code/getCode?parentNo=KNOWLEDGE_COMPANY_NATRUE',
                type: 'get',
                dataType: 'json',
                async: false,
                success: function (res) {
                    if (res.obj != undefined && res.obj.length > 0) {
                        for (var i = 0; i < res.obj.length; i++) {
                            optionStr += '<option value="' + res.obj[i].codeNo + '">' + res.obj[i].codeName + '</option>'
                        }
                    }
                }
            })
            $select1.html(optionStr);
            //渲染文档等级
            var $select3 = $("select[name='docfileClass']");
            var optionStr3 = '<option value="">请选择</option>';
            $.ajax({ //查询文档等级
                url: '/code/getCode?parentNo=KNOWLEDGE_DOCFILE_CLASS',
                type: 'get',
                dataType: 'json',
                async: false,
                success: function (res) {
                    if (res.obj != undefined && res.obj.length > 0) {
                        for (var i = 0; i < res.obj.length; i++) {
                            if(pdata.docfileClass===res.obj[i].codeNo){
                                optionStr3 += '<option selected value="' + res.obj[i].codeNo + '">' + res.obj[i].codeName + '</option>'
                            }else{
                                optionStr3 += '<option value="' + res.obj[i].codeNo + '">' + res.obj[i].codeName + '</option>'
                            }
                        }
                    }
                }
            })
            $select3.html(optionStr3);
            if(pdata.companyNatrue == "国企"){
                var n = "1"
            }
            if(pdata.companyNatrue == "民营"){
                var n = "2"
            }
            if(pdata.companyNatrue == "个体"){
                var n = "3"
            }
            $('#companyNatrue').find('option[value="'+n+'"]').prop('selected','selected');
            form.render();
            //渲染角色
            var $select2 = $("select[name='role']");
            var optionStr2 = '<option value="">请选择</option>';
            $.ajax({ //查询所有角色
                url: '/clientRole/getAllRoleColumn',
                type: 'post',
                dataType: 'json',
                async: false,
                success: function (res) {
                    if (res.data != undefined && res.data.length > 0) {
                        for (var i = 0; i < res.data.length; i++) {
                            optionStr2 += '<option name="' + res.data[i].columnName + '" roleId="' + res.data[i].roleId + '" privId="' + res.data[i].privId + '" privName="' + res.data[i].privName + '"  value="' + res.data[i].columnId + '">' + res.data[i].roleName + '</option>'
                        }
                    }

                }
            })
            $select2.html(optionStr2);
            $('#role').find('option[value="'+pdata.role+'"]').prop('selected','selected');
            form.render();
            laydate.render({
                elem: '#downloadBDate'
                , trigger: 'click'//呼出事件改成click
                , type: 'datetime'
            });
            laydate.render({
                elem: '#downloadEDate'
                , trigger: 'click'//呼出事件改成click
                , type: 'datetime'
            });
            laydate.render({
                elem: '#browseBDate'
                , trigger: 'click'//呼出事件改成click
                , type: 'datetime'
            });
            laydate.render({
                elem: '#browseEDate'
                , trigger: 'click'//呼出事件改成click
                , type: 'datetime'
            });
            form.render();//初始化表单
            $.ajax({
                url: '/knowledge/childTree?customerId='+pdata.customerId,
                type: 'get',
                dataType: 'json',
                async:false,
                success: function (res) {
                    if(res.code == 0){
                        var qdata = res.data;
                        var str = "";
                        if(qdata.length>0&&qdata.length%2 == 0){
                            for(var i =0; i<qdata.length;i++){
                                if(i%2 == 0){
                                    str+= '<tr class="removeBox">' +
                                        '<td class="tdstyl">' +
                                        '<label  class="layui-form-label" paid="'+qdata[i].id+'" style="">'+qdata[i].name+'</label>' +
                                        '</td>' +
                                        '<td colspan="2" class="tdsty2" lay-event="eleFn">' +
                                        '<textarea type="text"  data-type="0" id="pele'+i+'" pid name="ptitle" required="" style="cursor: pointer"  placeholder="请选择" readonly="" autocomplete="off" class="textAreaBox ele treeNum"></textarea>' +
                                        '<div class="eleTree ele'+i+'" lay-filter="data1" style="display:none;position:absolute;border: 1px solid #d2d2d2;overflow-y: auto;background-color: #fff;border-radius: 2px;box-shadow: 0 2px 4px rgba(0,0,0,.12);box-sizing: border-box;overflow:hidden;z-index: 999;top:45px;left:15px;width: 90%;"></div></div></div></div>' +
                                        '</td>'
                                }else if(i%2 != 0){
                                    str +=  '<td class="tdstyl">' +
                                        '<label class="layui-form-label" paid="'+qdata[i].id+'" style="">'+qdata[i].name+'</label>\n' +
                                        '</td>' +
                                        '<td colspan="2" class="tdsty2" lay-event="eleFn">\n' +
                                        '<textarea type="text"  data-type="0" id="pele'+i+'" pid name="ptitle" required="" style="cursor: pointer"  placeholder="请选择" readonly="" autocomplete="off" class="textAreaBox ele treeNum"></textarea>' +
                                        '<div class="eleTree ele'+i+'" lay-filter="data1" style="display:none;position:absolute;border: 1px solid #d2d2d2;overflow-y: auto;background-color: #fff;border-radius: 2px;box-shadow: 0 2px 4px rgba(0,0,0,.12);box-sizing: border-box;overflow:hidden;z-index: 999;top:45px;left:15px;width: 90%;"></div></div></div></div>' +
                                        '</td>' +
                                        '</tr>'
                                }
                            }
                        }else {
                            for (var i = 0; i < qdata.length-1; i++) {
                                if (i % 2 == 0) {
                                    str += '<tr class="removeBox">' +
                                        '<td class="tdstyl">' +
                                        '<label  class="layui-form-label" style="" paid="'+qdata[i].id+'">'+qdata[i].name+'</label>' +
                                        '</td>' +
                                        '<td colspan="2" class="tdsty2" lay-event="eleFn">' +
                                        '<textarea type="text"  data-type="0" id="pele'+i+'" pid name="ptitle" required="" style="cursor: pointer"  placeholder="请选择" readonly="" autocomplete="off" class="textAreaBox ele treeNum"></textarea>' +
                                        '<div class="eleTree ele'+i+'" lay-filter="data1" style="display:none;position:absolute;border: 1px solid #d2d2d2;overflow-y: auto;background-color: #fff;border-radius: 2px;box-shadow: 0 2px 4px rgba(0,0,0,.12);box-sizing: border-box;overflow:hidden;z-index: 999;top:45px;left:15px;width: 90%;"></div></div></div></div>' +
                                        '</td>'
                                } else if (i % 2 != 0) {
                                    str += '<td class="tdstyl">' +
                                        '<label class="layui-form-label" paid="'+qdata[i].id+'" style="">'+qdata[i].name+'</label>\n' +
                                        '</td>' +
                                        '<td colspan="2" class="tdsty2" lay-event="eleFn">\n' +
                                        '<textarea type="text"  data-type="0" id="pele'+i+'" pid name="ptitle" required="" style="cursor: pointer"  placeholder="请选择" readonly="" autocomplete="off" class="textAreaBox ele treeNum"></textarea>' +
                                        '<div class="eleTree ele'+i+'" lay-filter="data1" style="display:none;position:absolute;border: 1px solid #d2d2d2;overflow-y: auto;background-color: #fff;border-radius: 2px;box-shadow: 0 2px 4px rgba(0,0,0,.12);box-sizing: border-box;overflow:hidden;z-index: 999;top:45px;left:15px;width: 90%;"></div></div></div></div>' +
                                        '</td>' +
                                        '</tr>'
                                }
                            }
                            str +=  '<tr class="removeBox">' +
                                '<td class="tdstyl">' +
                                '<label  class="layui-form-label" style="" paid="'+qdata[qdata.length-1].id+'">'+qdata[qdata.length-1].name+'</label>' +
                                '</td>' +
                                '<td colspan="2" class="tdsty2" lay-event="eleFn">' +
                                '<textarea type="text"  data-type="0" id="pele'+i+'" pid name="ptitle" required="" style="cursor: pointer"  placeholder="请选择" readonly="" autocomplete="off" class="textAreaBox ele treeNum"></textarea>' +
                                '<div class="eleTree ele'+i+'" lay-filter="data1" style="display:none;position:absolute;border: 1px solid #d2d2d2;overflow-y: auto;background-color: #fff;border-radius: 2px;box-shadow: 0 2px 4px rgba(0,0,0,.12);box-sizing: border-box;overflow:hidden;z-index: 999;top:45px;left:15px;width: 90%;"></div></div></div></div>' +
                                '</td></tr>'
                        }
                        $("#finde").after(str);
                        form.render();
                        if(qdata.length>0) {
                            //var columnId = pdata.columnId;
                            for (var i = 0; i < qdata.length; i++) {
                                (function (i) {
                                    var elm = '.ele' + i
                                    eleTree.render({
                                        elem: '.ele' + i,
                                        data: qdata[i].children,
                                        expandOnClickNode: false,
                                        highlightCurrent: true,
                                        showLine: true,
                                        showCheckbox: true,
                                        checked: true,
                                        defaultExpandAll: true,
                                        load: function (data, callback) {
                                        },
                                        done: function (res) {
                                            // var pidar = pdata.columnId.split(",");
                                            // var pidarr = [];
                                            // for (var j = 0; j < pidar.length; j++) {
                                            //     if (pidar[j] == "") {
                                            //
                                            //     } else {
                                            //         pidarr.push(pidar[j]);
                                            //     }
                                            // }
                                            // for (var j = 0; j < pidarr.length; j++) {
                                            //     $(elm + " div[data-id=" + pidarr[j] + "]").find("input").eq(0).attr("checked", true);
                                            //     $(elm + " div[data-id=" + pidarr[j] + "]").find("input").eq(0).attr("eletree-status", "1");
                                            //     // $(elm+" div[data-id="+pidarr[j]+"]").find("input").eq(0).addClass("eleTree-disabled");
                                            //     $(elm + " div[data-id=" + pidarr[j] + "]").find("input").eq(0).next("div.eleTree-checkbox").addClass("eleTree-checkbox-checked");
                                            //     $(elm + " div[data-id=" + pidarr[j] + "]").find("input").eq(0).next("div.eleTree-checkbox").find("i").addClass("layui-icon-ok");
                                            // }
                                            // var $inp = $(elm +' input[eletree-status="1"]');
                                            // var str = "";
                                            // var str1 = "";
                                            // for(var i=0;i<$inp.length;i++){
                                            //     str += $inp.eq(i).parents(".eleTree-node-content").attr("title")+",";
                                            //     str1 += $inp.eq(i).parents(".eleTree-node-content").parent().attr("data-id")+",";
                                            // }
                                            // $(elm).prev("textarea").attr("pid",str1)
                                            // $(elm).prev("textarea").text(str);
                                        }
                                    });
                                    var $inp = $(elm +' input[eletree-status="1"]');
                                    var str = "";
                                    var str1 = "";
                                    for(var i=0;i<$inp.length;i++){
                                        str += $inp.eq(i).parents(".eleTree-node-content").attr("title")+",";
                                        str1 += $inp.eq(i).parents(".eleTree-node-content").parent().attr("data-id")+",";
                                    }
                                    $(elm).prev("textarea").attr("pid",str1)
                                    $(elm).prev("textarea").text(str);
                                })(i);
                            }
                        }
                    }


                }
            })
            var $td = $("#projectInfo").find('td[lay-event="eleFn"]');
            $td.click(function (obj) {
                var td = $(this);
                if(td.find("textarea.ele").attr("data-type") == "0"){
                    td.find(".eleTree").slideDown();
                    td.find("textarea.ele").attr("data-type","1");
                }else{
                    td.find(".eleTree").slideUp();
                    td.find("textarea.ele").attr("data-type","0");
                }
                //点击本身外收起下拉的主体
                document.onmouseup = function(e){
                    var e = e || window.event;
                    var target = e.target || e.srcElement;
                    //1. 点击事件的对象不是目标区域本身
                    //2. 事件对象同时也不是目标区域的子元素
                    if(!td.is(e.target) &&td.has(e.target).length === 0){
                        $(".eleTree").slideUp();
                        $("textarea.ele").attr("data-type","0");
                    }
                }
                //选中监听事件
                var arr = [];
                var arr1 = [];
                var pidt = td.find("textarea.ele").attr("pid");
                var valt = td.find("textarea.ele").val();
                if(pidt != undefined || pidt != "undefined" || pidt != ""){
                    var arrr = pidt.split(",")
                    for(var i=0;i<arrr.length;i++){
                        if(arrr[i] == ""){

                        }else{
                            arr.push(arrr[i]);
                        }
                    }
                }else{
                    arr = []
                }
                if(valt != undefined || valt != "undefined" || valt != ""){
                    var arrr1 = valt.split(",")
                    for(var i=0;i<arrr1.length;i++){
                        if(arrr1[i] == ""){

                        }else{
                            arr1.push(arrr1[i]);
                        }
                    }
                }else{
                    arr1 = []
                }
                layui.eleTree.on("nodeChecked(data1)",function(d) {
                    var id = d.data.currentData.columnId+"";
                    var label = d.data.currentData.label+"";
                    if(d.isChecked == true || d.isChecked == "true"){
                        arr.push(id);
                        arr1.push(label);
                    }else{
                        arr.remove(id);
                        arr1.remove(label);
                    }
                    var str ="";
                    var str1 ="";
                    for(var i=0;i<arr.length;i++){
                        str+=arr[i]+","
                        str1+=arr1[i]+","
                    }
                    td.find("textarea.ele").val(str1);
                    td.find("textarea.ele").attr("pid",str);
                    // var data =  layui.table.cache["addTable"]
                    // var ind = td.find("textarea.ele").parents("tr").attr("data-index");
                    // data[ind].columnName = str1;
                    // data[ind].columnId = str;
                })
            })
            if(type == "look"){
                $(".layui-colla-content").eq(0).addClass("disable");
                $(".layui-colla-content").eq(1).addClass("disable");
            }
        }

        //监听选择角色下拉框
        form.on('select(formNoSelect)', function(data){
            console.log(data,'data')
            var pidt = undefind_nullStr(data.value);
            var valt = undefind_nullStr($(data.elem[data.elem.selectedIndex]).attr("name"));
            var roleId = undefind_nullStr($(data.elem[data.elem.selectedIndex]).attr("roleId"));
            var docfileClass = undefind_nullStr($(data.elem[data.elem.selectedIndex]).attr("docfileClass"));
            if(roleId!=null&&roleId!=undefined&&roleId!=''){
                $(".removeBox").remove();
                form.render();
                //开始重载知识栏目
                $.ajax({ //查询文档等级
                    url: '/knowledge/childTree?roleId='+roleId,
                    type: 'get',
                    dataType: 'json',
                    async:false,
                    success: function (res) {
                        if(res.code == 0){
                            var qdata = res.data;
                            var str = "";
                            if(qdata.length>0&&qdata.length%2 == 0){
                                for(var i =0; i<qdata.length;i++){
                                    if(i%2 == 0){
                                        str+= '<tr class="removeBox">' +
                                            '<td class="tdstyl">' +
                                            '<label  class="layui-form-label" paid="'+qdata[i].id+'" style="">'+qdata[i].name+'</label>' +
                                            '</td>' +
                                            '<td colspan="2" class="tdsty2" lay-event="eleFn">' +
                                            '<textarea type="text"  data-type="0" id="pele'+i+'" pid name="ptitle" required="" style="cursor: pointer"  placeholder="请选择" readonly="" autocomplete="off" class="textAreaBox ele treeNum"></textarea>' +
                                            '<div class="eleTree ele'+i+'" lay-filter="data1" style="display:none;position:absolute;border: 1px solid #d2d2d2;overflow-y: auto;background-color: #fff;border-radius: 2px;box-shadow: 0 2px 4px rgba(0,0,0,.12);box-sizing: border-box;overflow:hidden;z-index: 999;top:45px;left:15px;width: 90%;"></div></div></div></div>' +
                                            '</td>'
                                    }else if(i%2 != 0){
                                        str +=  '<td class="tdstyl">' +
                                            '<label class="layui-form-label" paid="'+qdata[i].id+'" style="">'+qdata[i].name+'</label>\n' +
                                            '</td>' +
                                            '<td colspan="2" class="tdsty2" lay-event="eleFn">\n' +
                                            '<textarea type="text"  data-type="0" id="pele'+i+'" pid name="ptitle" required="" style="cursor: pointer"  placeholder="请选择" readonly="" autocomplete="off" class="textAreaBox ele treeNum"></textarea>' +
                                                    
                                            '<div class="eleTree ele'+i+'" lay-filter="data1" style="display:none;position:absolute;border: 1px solid #d2d2d2;overflow-y: auto;background-color: #fff;border-radius: 2px;box-shadow: 0 2px 4px rgba(0,0,0,.12);box-sizing: border-box;overflow:hidden;z-index: 999;top:45px;left:15px;width: 90%;"></div></div></div></div>' +
                                            '</td>' +
                                            '</tr>'
                                    }
                                }
                            }else {
                                for (var i = 0; i < qdata.length-1; i++) {
                                    if (i % 2 == 0) {
                                        str += '<tr class="removeBox">' +
                                            '<td class="tdstyl">' +
                                            '<label  class="layui-form-label" style="" paid="'+qdata[i].id+'">'+qdata[i].name+'</label>' +
                                            '</td>' +
                                            '<td colspan="2" class="tdsty2" lay-event="eleFn">' +
                                            '<textarea type="text"  data-type="0" id="pele'+i+'" pid name="ptitle" required="" style="cursor: pointer"  placeholder="请选择" readonly="" autocomplete="off" class="textAreaBox ele treeNum"></textarea>' +
                                            '<div class="eleTree ele'+i+'" lay-filter="data1" style="display:none;position:absolute;border: 1px solid #d2d2d2;overflow-y: auto;background-color: #fff;border-radius: 2px;box-shadow: 0 2px 4px rgba(0,0,0,.12);box-sizing: border-box;overflow:hidden;z-index: 999;top:45px;left:15px;width: 90%;"></div></div></div></div>' +
                                            '</td>'
                                    } else if (i % 2 != 0) {
                                        str += '<td class="tdstyl">' +
                                            '<label class="layui-form-label" paid="'+qdata[i].id+'" style="">'+qdata[i].name+'</label>\n' +
                                            '</td>' +
                                            '<td colspan="2" class="tdsty2" lay-event="eleFn">\n' +
                                            '<textarea type="text"  data-type="0" id="pele'+i+'" pid name="ptitle" required="" style="cursor: pointer"  placeholder="请选择" readonly="" autocomplete="off" class="textAreaBox ele treeNum"></textarea>' +
                                            '<div class="eleTree ele'+i+'" lay-filter="data1" style="display:none;position:absolute;border: 1px solid #d2d2d2;overflow-y: auto;background-color: #fff;border-radius: 2px;box-shadow: 0 2px 4px rgba(0,0,0,.12);box-sizing: border-box;overflow:hidden;z-index: 999;top:45px;left:15px;width: 90%;"></div></div></div></div>' +
                                            '</td>' +
                                            '</tr>'
                                    }
                                }
                                str +=  '<tr class="removeBox">' +
                                    '<td class="tdstyl">' +
                                    '<label  class="layui-form-label" style="" paid="'+qdata[qdata.length-1].id+'">'+qdata[qdata.length-1].name+'</label>' +
                                    '</td>' +
                                    '<td colspan="2" class="tdsty2" lay-event="eleFn">' +
                                    '<textarea type="text"  data-type="0" id="pele'+i+'" pid name="ptitle" required="" style="cursor: pointer"  placeholder="请选择" readonly="" autocomplete="off" class="textAreaBox ele treeNum"></textarea>' +
                                    '<div class="eleTree ele'+i+'" lay-filter="data1" style="display:none;position:absolute;border: 1px solid #d2d2d2;overflow-y: auto;background-color: #fff;border-radius: 2px;box-shadow: 0 2px 4px rgba(0,0,0,.12);box-sizing: border-box;overflow:hidden;z-index: 999;top:45px;left:15px;width: 90%;"></div></div></div></div>' +
                                    '</td></tr>'
                            }
                            $("#finde").after(str);
                            form.render();
                            if(qdata.length>0) {
                                //var columnId = pdata.columnId;
                                for (var i = 0; i < qdata.length; i++) {
                                    (function (i) {
                                        var elm = '.ele' + i
                                        eleTree.render({
                                            elem: '.ele' + i,
                                            data: qdata[i].children,
                                            expandOnClickNode: false,
                                            highlightCurrent: true,
                                            showLine: true,
                                            showCheckbox: true,
                                            checked: true,
                                            defaultExpandAll: true,
                                            load: function (data, callback) {
                                            },
                                            done: function (res) {
                                            }
                                        });
                                        var $inp = $(elm +' input[eletree-status="1"]');
                                        var str = "";
                                        var str1 = "";
                                        for(var i=0;i<$inp.length;i++){
                                            str += $inp.eq(i).parents(".eleTree-node-content").attr("title")+",";
                                            str1 += $inp.eq(i).parents(".eleTree-node-content").parent().attr("data-id")+",";
                                        }
                                        $(elm).prev("textarea").attr("pid",str1)
                                        $(elm).prev("textarea").text(str);
                                    })(i);
                                }
                            }
                        }
                    }
                })
                var $td = $("#projectInfo").find('td[lay-event="eleFn"]');
                $td.click(function (obj) {
                    var td = $(this);
                    if(td.find("textarea.ele").attr("data-type") == "0"){
                        td.find(".eleTree").slideDown();
                        td.find("textarea.ele").attr("data-type","1");
                    }else{
                        td.find(".eleTree").slideUp();
                        td.find("textarea.ele").attr("data-type","0");
                    }
                    //点击本身外收起下拉的主体
                    document.onmouseup = function(e){
                        var e = e || window.event;
                        var target = e.target || e.srcElement;
                        //1. 点击事件的对象不是目标区域本身
                        //2. 事件对象同时也不是目标区域的子元素
                        if(!td.is(e.target) &&td.has(e.target).length === 0){
                            $(".eleTree").slideUp();
                            $("textarea.ele").attr("data-type","0");
                        }
                    }
                    //选中监听事件
                    var arr = [];
                    var arr1 = [];
                    var pidt = td.find("textarea.ele").attr("pid");
                    var valt = td.find("textarea.ele").val();
                    if(pidt != undefined || pidt != "undefined" || pidt != ""){
                        var arrr = pidt.split(",")
                        for(var i=0;i<arrr.length;i++){
                            if(arrr[i] == ""){

                            }else{
                                arr.push(arrr[i]);
                            }
                        }
                    }else{
                        arr = []
                    }
                    if(valt != undefined || valt != "undefined" || valt != ""){
                        var arrr1 = valt.split(",")
                        for(var i=0;i<arrr1.length;i++){
                            if(arrr1[i] == ""){

                            }else{
                                arr1.push(arrr1[i]);
                            }
                        }
                    }else{
                        arr1 = []
                    }
                    layui.eleTree.on("nodeChecked(data1)",function(d) {
                        var id = d.data.currentData.columnId+"";
                        var label = d.data.currentData.label+"";
                        if(d.isChecked == true || d.isChecked == "true"){
                            arr.push(id);
                            arr1.push(label);
                        }else{
                            arr.remove(id);
                            arr1.remove(label);
                        }
                        var str ="";
                        var str1 ="";
                        for(var i=0;i<arr.length;i++){
                            str+=arr[i]+","
                            str1+=arr1[i]+","
                        }
                        td.find("textarea.ele").val(str1);
                        td.find("textarea.ele").attr("pid",str);
                    })
                })
                //结束重载知识栏目
            }else{
                $(".removeBox").remove();
                form.render();
                //开始重载知识栏目
                $.ajax({ //查询文档等级
                    url: '/knowledge/childTree',
                    type: 'get',
                    dataType: 'json',
                    async:false,
                    success: function (res) {
                        if(res.code == 0){
                            var qdata = res.data;
                            var str = "";
                            if(qdata.length>0&&qdata.length%2 == 0){
                                for(var i =0; i<qdata.length;i++){
                                    if(i%2 == 0){
                                        str+= '<tr class="removeBox">' +
                                            '<td class="tdstyl">' +
                                            '<label  class="layui-form-label" paid="'+qdata[i].id+'" style="">'+qdata[i].name+'</label>' +
                                            '</td>' +
                                            '<td colspan="2" class="tdsty2" lay-event="eleFn">' +
                                            '<textarea type="text"  data-type="0" id="pele'+i+'" pid name="ptitle" required="" style="cursor: pointer"  placeholder="请选择" readonly="" autocomplete="off" class="textAreaBox ele treeNum"></textarea>' +
                                            '<div class="eleTree ele'+i+'" lay-filter="data1" style="display:none;position:absolute;border: 1px solid #d2d2d2;overflow-y: auto;background-color: #fff;border-radius: 2px;box-shadow: 0 2px 4px rgba(0,0,0,.12);box-sizing: border-box;overflow:hidden;z-index: 999;top:45px;left:15px;width: 90%;"></div></div></div></div>' +
                                            '</td>'
                                    }else if(i%2 != 0){
                                        str +=  '<td class="tdstyl">' +
                                            '<label class="layui-form-label" paid="'+qdata[i].id+'" style="">'+qdata[i].name+'</label>\n' +
                                            '</td>' +
                                            '<td colspan="2" class="tdsty2" lay-event="eleFn">\n' +
                                            '<textarea type="text"  data-type="0" id="pele'+i+'" pid name="ptitle" required="" style="cursor: pointer"  placeholder="请选择" readonly="" autocomplete="off" class="textAreaBox ele treeNum"></textarea>' +
                                            '<div class="eleTree ele'+i+'" lay-filter="data1" style="display:none;position:absolute;border: 1px solid #d2d2d2;overflow-y: auto;background-color: #fff;border-radius: 2px;box-shadow: 0 2px 4px rgba(0,0,0,.12);box-sizing: border-box;overflow:hidden;z-index: 999;top:45px;left:15px;width: 90%;"></div></div></div></div>' +
                                            '</td>' +
                                            '</tr>'
                                    }
                                }
                            }else {
                                for (var i = 0; i < qdata.length-1; i++) {
                                    if (i % 2 == 0) {
                                        str += '<tr class="removeBox">' +
                                            '<td class="tdstyl">' +
                                            '<label  class="layui-form-label" style="" paid="'+qdata[i].id+'">'+qdata[i].name+'</label>' +
                                            '</td>' +
                                            '<td colspan="2" class="tdsty2" lay-event="eleFn">' +
                                            '<textarea type="text"  data-type="0" id="pele'+i+'" pid name="ptitle" required="" style="cursor: pointer"  placeholder="请选择" readonly="" autocomplete="off" class="textAreaBox ele treeNum"></textarea>' +
                                            '<div class="eleTree ele'+i+'" lay-filter="data1" style="display:none;position:absolute;border: 1px solid #d2d2d2;overflow-y: auto;background-color: #fff;border-radius: 2px;box-shadow: 0 2px 4px rgba(0,0,0,.12);box-sizing: border-box;overflow:hidden;z-index: 999;top:45px;left:15px;width: 90%;"></div></div></div></div>' +
                                            '</td>'
                                    } else if (i % 2 != 0) {
                                        str += '<td class="tdstyl">' +
                                            '<label class="layui-form-label" paid="'+qdata[i].id+'" style="">'+qdata[i].name+'</label>\n' +
                                            '</td>' +
                                            '<td colspan="2" class="tdsty2" lay-event="eleFn">\n' +
                                            '<textarea type="text"  data-type="0" id="pele'+i+'" pid name="ptitle" required="" style="cursor: pointer"  placeholder="请选择" readonly="" autocomplete="off" class="textAreaBox ele treeNum"></textarea>' +
                                            '<div class="eleTree ele'+i+'" lay-filter="data1" style="display:none;position:absolute;border: 1px solid #d2d2d2;overflow-y: auto;background-color: #fff;border-radius: 2px;box-shadow: 0 2px 4px rgba(0,0,0,.12);box-sizing: border-box;overflow:hidden;z-index: 999;top:45px;left:15px;width: 90%;"></div></div></div></div>' +
                                            '</td>' +
                                            '</tr>'
                                    }
                                }
                                str +=  '<tr class="removeBox">' +
                                    '<td class="tdstyl">' +
                                    '<label  class="layui-form-label" style="" paid="'+qdata[qdata.length-1].id+'">'+qdata[qdata.length-1].name+'</label>' +
                                    '</td>' +
                                    '<td colspan="2" class="tdsty2" lay-event="eleFn">' +
                                    '<textarea type="text"  data-type="0" id="pele'+i+'" pid name="ptitle" required="" style="cursor: pointer"  placeholder="请选择" readonly="" autocomplete="off" class="textAreaBox ele treeNum"></textarea>' +
                                    '<div class="eleTree ele'+i+'" lay-filter="data1" style="display:none;position:absolute;border: 1px solid #d2d2d2;overflow-y: auto;background-color: #fff;border-radius: 2px;box-shadow: 0 2px 4px rgba(0,0,0,.12);box-sizing: border-box;overflow:hidden;z-index: 999;top:45px;left:15px;width: 90%;"></div></div></div></div>' +
                                    '</td></tr>'
                            }
                            $("#finde").after(str);
                            form.render();
                            if(qdata.length>0) {
                                //var columnId = pdata.columnId;
                                for (var i = 0; i < qdata.length; i++) {
                                    (function (i) {
                                        var elm = '.ele' + i
                                        eleTree.render({
                                            elem: '.ele' + i,
                                            data: qdata[i].children,
                                            expandOnClickNode: false,
                                            highlightCurrent: true,
                                            showLine: true,
                                            showCheckbox: true,
                                            checked: true,
                                            defaultExpandAll: true,
                                            load: function (data, callback) {
                                            },
                                            done: function (res) {
                                            }
                                        });
                                        var $inp = $(elm +' input[eletree-status="1"]');
                                        var str = "";
                                        var str1 = "";
                                        for(var i=0;i<$inp.length;i++){
                                            str += $inp.eq(i).parents(".eleTree-node-content").attr("title")+",";
                                            str1 += $inp.eq(i).parents(".eleTree-node-content").parent().attr("data-id")+",";
                                        }
                                        $(elm).prev("textarea").attr("pid",str1)
                                        $(elm).prev("textarea").text(str);
                                    })(i);
                                }
                            }
                        }
                    }
                })
                var $td = $("#projectInfo").find('td[lay-event="eleFn"]');
                $td.click(function (obj) {
                    var td = $(this);
                    if(td.find("textarea.ele").attr("data-type") == "0"){
                        td.find(".eleTree").slideDown();
                        td.find("textarea.ele").attr("data-type","1");
                    }else{
                        td.find(".eleTree").slideUp();
                        td.find("textarea.ele").attr("data-type","0");
                    }
                    //点击本身外收起下拉的主体
                    document.onmouseup = function(e){
                        var e = e || window.event;
                        var target = e.target || e.srcElement;
                        //1. 点击事件的对象不是目标区域本身
                        //2. 事件对象同时也不是目标区域的子元素
                        if(!td.is(e.target) &&td.has(e.target).length === 0){
                            $(".eleTree").slideUp();
                            $("textarea.ele").attr("data-type","0");
                        }
                    }
                    //选中监听事件
                    var arr = [];
                    var arr1 = [];
                    var pidt = td.find("textarea.ele").attr("pid");
                    var valt = td.find("textarea.ele").val();
                    if(pidt != undefined || pidt != "undefined" || pidt != ""){
                        var arrr = pidt.split(",")
                        for(var i=0;i<arrr.length;i++){
                            if(arrr[i] == ""){

                            }else{
                                arr.push(arrr[i]);
                            }
                        }
                    }else{
                        arr = []
                    }
                    if(valt != undefined || valt != "undefined" || valt != ""){
                        var arrr1 = valt.split(",")
                        for(var i=0;i<arrr1.length;i++){
                            if(arrr1[i] == ""){

                            }else{
                                arr1.push(arrr1[i]);
                            }
                        }
                    }else{
                        arr1 = []
                    }
                    layui.eleTree.on("nodeChecked(data1)",function(d) {
                        var id = d.data.currentData.columnId+"";
                        var label = d.data.currentData.label+"";
                        if(d.isChecked == true || d.isChecked == "true"){
                            arr.push(id);
                            arr1.push(label);
                        }else{
                            arr.remove(id);
                            arr1.remove(label);
                        }
                        var str ="";
                        var str1 ="";
                        for(var i=0;i<arr.length;i++){
                            str+=arr[i]+","
                            str1+=arr1[i]+","
                        }
                        td.find("textarea.ele").val(str1);
                        td.find("textarea.ele").attr("pid",str);
                    })
                })
                //结束重载知识栏目
            }
            $("#userPriv").val(undefind_nullStr($(data.elem[data.elem.selectedIndex]).attr("privName")));
            $("#userPriv").attr("privid",undefind_nullStr($(data.elem[data.elem.selectedIndex]).attr("privId")))
            $("#docfileClass").val(undefind_nullStr(docfileClass))
            form.render('select');
        });
        //监听选择权限类别下拉框
        form.on('select(privTypeFilter)', function(data){
            if(data.value=='1'){ //下载
                $(".lookDiv").hide();
                $(".downDiv").show();
            }else if(data.value=='0'){ //浏览
                $(".lookDiv").show();
                $(".downDiv").hide();
            }else{
                $(".lookDiv").show();
                $(".downDiv").show();
            }
            form.render('select');
        });
        $("#password").blur(function () {
            $("#passwordTxt").css("display","");
        })
        $("#password2").blur(function () {
            $("#passwordTxt2").css("display","");
        })
        form.on('submit(btnSubmit)', function (data) {
            customer= data.field;
            var $td = $("#projectInfo").find('td[lay-event="eleFn"]');
            var str = "";
            debugger
            for(var i=0;i<$td.length;i++){
                str += $td.eq(i).find("textarea.ele").attr("pid");
            }
            if(str != "" || str != undefined){
                var astr = str.split(",");
            }
            var coid = "";
            for(var i =0;i<astr.length;i++){
                if(astr[i] == ""){

                }else{
                    coid += astr[i]+",";
                }
            }
            customer.columnId = coid;
            var p1 = customer.password +"";
            var p2 = customer.password2 +"";
            if(customer.privType!=undefined&&customer.privType!=""){
                if(customer.privType==='1'||customer.privType===1){ //下载权限
                    if(customer.downloadBDate==undefined||customer.downloadEDate==undefined||customer.downloadBDate==""||customer.downloadEDate==""){
                        parent.layui.layer.msg("请选择下载时间")
                    }else{
                        if(p1==undefined||p2==undefined){
                            layui.layer.msg("请输入密码")
                            return false
                        }else{
                            if(p1!=p2){
                                layui.layer.msg("两次密码不一致")
                                return false
                            }else{
                                if(type=="add"){
                                    if(p1.length<parseInt(secPassMin) || p1.length>parseInt(secPassMax)){
                                        layui.layer.msg("密码长度不符合要求")
                                        return false
                                    }
                                    if(p2.length<parseInt(secPassMin) || p2.length>parseInt(secPassMax)){
                                        layui.layer.msg("密码长度不符合要求")
                                        return false
                                    }
                                }else if(type=="edit"){
                                    if((p1!=''&&p1.length<parseInt(secPassMin)) || (p1!=null&&p1.length>parseInt(secPassMax))){
                                        layui.layer.msg("密码长度不符合要求")
                                        return false
                                    }
                                    if((p2!=''&&p2.length<parseInt(secPassMin)) || (p2!=''&&p2.length>parseInt(secPassMax))){
                                        layui.layer.msg("密码长度不符合要求")
                                        return false
                                    }
                                }
                                var columnId="";
                                var treeNum = $(".treeNum").length;
                                for(var i=0;i<treeNum;i++){
                                    columnId+=$('.ele' + i).prev("textarea").attr("pid")
                                }
                                customer.columnId=columnId;
                                var contactUser = $("#contactUser").attr("user_id");
                                customer.contactUser = contactUser;
                                var userPriv = $("#userPriv").attr("privid");
                                if(userPriv.substring(userPriv.length-1,userPriv.length)==','){
                                    userPriv = userPriv.substring(0,userPriv.length-1)
                                }
                                customer.customerId = $("#customerId").val();
                                customer.browseBDate = '';
                                customer.browseEDate = '';
                                customer.userPriv = userPriv;
                                customer.userName = customer.companyName;
                                if(type== 'add'){
                                    $.ajax({
                                        url:'/client/addCustomer',
                                        dataType: 'json',
                                        type: 'post',
                                        async: false,
                                        data:customer,
                                        success:function (res) {
                                            if(res.flag){
                                                parent.layui.table.reload("clientCustomer");
                                                parent.layer.closeAll();
                                            }
                                            parent.layer.msg(res.msg)
                                        }
                                    })
                                }else if(type=='edit'){
                                    $.ajax({
                                        url:'/client/editCustomer',
                                        dataType: 'json',
                                        type: 'post',
                                        async: false,
                                        data:customer,
                                        success:function (res) {
                                            if(res.flag){
                                                parent.layer.closeAll();
                                                parent.layui.table.reload("clientCustomer");
                                            }
                                            parent.layer.msg(res.msg)
                                        }
                                    })
                                }
                            }
                        }
                    }
                }else if(customer.privType==='0'||customer.privType===0){ //浏览权限
                    if(p1==undefined||p2==undefined){
                        layui.layer.msg("请输入密码")
                        return false
                    }else{
                        if(p1!=p2){
                            layui.layer.msg("两次密码不一致")
                            return false
                        }else{
                            if(type=="add"){
                                if(p1.length<parseInt(secPassMin) || p1.length>parseInt(secPassMax)){
                                    layui.layer.msg("密码长度不符合要求")
                                    return false
                                }
                                if(p2.length<parseInt(secPassMin) || p2.length>parseInt(secPassMax)){
                                    layui.layer.msg("密码长度不符合要求")
                                    return false
                                }
                            }else if(type=="edit"){
                                if((p1!=''&&p1.length<parseInt(secPassMin)) || (p1!=null&&p1.length>parseInt(secPassMax))){
                                    layui.layer.msg("密码长度不符合要求")
                                    return false
                                }
                                if((p2!=''&&p2.length<parseInt(secPassMin)) || (p2!=''&&p2.length>parseInt(secPassMax))){
                                    layui.layer.msg("密码长度不符合要求")
                                    return false
                                }
                            }
                            // if((p1!=''&&p1.length<8) || (p1!=null&&p1.length>20)){
                            //     layui.layer.msg("密码长度不符合要求")
                            //     return false
                            // }
                            // if((p2!=''&&p2.length<8) || (p2!=''&&p2.length>20)){
                            //     layui.layer.msg("密码长度不符合要求")
                            //     return false
                            // }
                            if(customer.browseBDate==undefined||customer.browseEDate==undefined||customer.browseBDate==""||customer.browseEDate==""){
                                parent.layui.layer.msg("请选择浏览时间")
                                return false
                            }else{
                                var columnId="";
                                var treeNum = $(".treeNum").length;
                                for(var i=0;i<treeNum;i++){
                                    columnId+=$('.ele' + i).prev("textarea").attr("pid")
                                }
                                customer.columnId=columnId;
                                customer.customerId = $("#customerId").val();
                                var contactUser = $("#contactUser").attr("user_id");
                                customer.contactUser = contactUser;
                                var userPriv = $("#userPriv").attr("privid");
                                if(userPriv.substring(userPriv.length-1,userPriv.length)==','){
                                    userPriv = userPriv.substring(0,userPriv.length-1)
                                }
                                customer.downloadBDate='';
                                customer.downloadEDate='';
                                customer.userPriv = userPriv;
                                customer.userName = customer.companyName;
                                if(type== 'add'){
                                    $.ajax({
                                        url:'/client/addCustomer',
                                        dataType: 'json',
                                        type: 'post',
                                        async: false,
                                        data:customer,
                                        success:function (res) {
                                            if(res.flag){
                                                parent.layui.table.reload("clientCustomer");
                                                parent.layer.closeAll();
                                            }
                                            parent.layer.msg(res.msg)
                                        }
                                    })
                                }else if(type=='edit'){
                                    $.ajax({
                                        url:'/client/editCustomer',
                                        dataType: 'json',
                                        type: 'post',
                                        async: false,
                                        data:customer,
                                        success:function (res) {
                                            if(res.flag){
                                                parent.layer.closeAll();
                                                parent.layui.table.reload("clientCustomer");
                                            }
                                            parent.layer.msg(res.msg)
                                        }
                                    })
                                }
                            }
                        }
                    }
                }
            }else{
                if(p1==undefined||p2==undefined){
                    layui.layer.msg("请输入密码")
                    return false
                }else{
                    if(p1!=p2){
                        layui.layer.msg("两次密码不一致")
                        return false
                    }else{
                        if(p1.length<parseInt(secPassMin) || p1.length>parseInt(secPassMax)){
                            layui.layer.msg("密码长度不符合要求")
                            return false
                        }
                        if(p2.length<parseInt(secPassMin) || p2.length>parseInt(secPassMax)){
                            layui.layer.msg("密码长度不符合要求")
                            return false
                        }
                        var columnId="";
                        var treeNum = $(".treeNum").length;
                        for(var i=0;i<treeNum;i++){
                            columnId+=$('.ele' + i).prev("textarea").attr("pid")
                        }
                        customer.columnId=columnId;
                        var contactUser = $("#contactUser").attr("user_id");
                        customer.contactUser = contactUser;
                        var userPriv = $("#userPriv").attr("privid");
                        if(userPriv.substring(userPriv.length-1,userPriv.length)==','){
                            userPriv = userPriv.substring(0,userPriv.length-1)
                        }
                        customer.customerId = $("#customerId").val();
                        customer.userPriv = userPriv;
                        customer.userName = customer.companyName;
                        if(type== 'add'){
                            $.ajax({
                                url:'/client/addCustomer',
                                dataType: 'json',
                                type: 'post',
                                async: false,
                                data:customer,
                                success:function (res) {
                                    if(res.flag){
                                        parent.layui.table.reload("clientCustomer");
                                        parent.layer.closeAll();
                                    }
                                    parent.layer.msg(res.msg)
                                }
                            })
                        }else if(type=='edit'){
                            $.ajax({
                                url:'/client/editCustomer',
                                dataType: 'json',
                                type: 'post',
                                async: false,
                                data:customer,
                                success:function (res) {
                                    if(res.flag){
                                        parent.layer.closeAll();
                                        parent.layui.table.reload("clientCustomer");
                                    }
                                    parent.layer.msg(res.msg)
                                }
                            })
                        }
                    }
                }
            }
        });
    })
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
