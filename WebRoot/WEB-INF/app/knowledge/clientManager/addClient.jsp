

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
    <title>知识库-新增客户</title>
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
    <%--<script type="text/javascript" src="/lims/layer/layer.js?20201106"></script>--%>
    <style>
        body,html{
            background-color: #fff;
        }
        .layui-form-item {
            margin-bottom: 5px;
        }
        .layui-input-inline{
            /*width: 300px !important;*/
        }
        .layui-form-label{
            width: 120px;
        }
        #formBox .layui-form-item {
            width: 49%;
        }

        .eleTree-node-content-label{
            display: inline-block;
            width:99%!important;
        }
        .ele1 div.eleTree-node:nth-child(1){
            overflow: hidden;
        }
        #formBox .layui-form-item{
            margin-top: 10px;
            margin-bottom: 10px;
        }
        #detp .layui-form-select dl dd, .layui-form-select dl dt{
            line-height: 21px;
        }
    </style>
</head>
<body>
<div class="main" style="padding: 20px 20px;background-color: #fff;">
    <div>
        <form class="layui-form" id="formBox" action="" lay-filter="formTest">
            <div class="layui-form-item" style="display: inline-block">
            <div class="layui-inline">
                    <label class="layui-form-label"><span style="color:red">*</span>企业名称</label>
                    <div class="layui-input-inline">
                            <input type="text" id="companyName" lay-verify="required" name="companyName" autocomplete="off" class="layui-input">
                        </div>
                </div>
            </div>
            <div class="layui-form-item" style="display: inline-block">
            <div class="layui-inline">
                    <label class="layui-form-label">栏目角色</label>
                    <div class="layui-input-inline">
                            <select id="role" name="role" lay-filter="formNoSelect"></select>
                        </div>
                </div>
            </div>
            <div class="layui-form-item" style="display: inline-block">
            <div class="layui-inline">
                    <label class="layui-form-label">机构代码</label>
                    <div class="layui-input-inline">
                            <input type="text" id="companyCode" name="companyCode" autocomplete="off" class="layui-input">
                        </div>
                </div>
            </div>
            <div class="layui-form-item" style="display: inline-block">
            <div class="layui-inline">
                    <label class="layui-form-label"><span style="color:red">*</span>联系人</label>
                    <div class="layui-input-inline">
                            <input type="text" id="contactUser" lay-verify="required" readonly placeholder="请选择" name="contactUser" autocomplete="off" class="layui-input">
                        </div>
                </div>
            </div>
            <div class="layui-form-item" style="display: inline-block">
            <div class="layui-inline">
                    <label class="layui-form-label">联系电话</label>
                    <div class="layui-input-inline">
                            <input type="text" id="contactPhone" name="contactPhone" autocomplete="off" class="layui-input">
                        </div>
                </div>
            </div>
            <div class="layui-form-item" style="display: inline-block">
            <div class="layui-inline">
                    <label class="layui-form-label">企业性质</label>
                    <div class="layui-input-inline">
                            <select name="companyNatrue" id="companyNatrue"></select>
<%--                    <input type="text" id="companyNatrue" name="companyNatrue" autocomplete="off" class="layui-input">--%>
                        </div>
                </div>
            </div>
            <div class="layui-form-item" style="display: inline-block">
            <div class="layui-inline">
                    <label class="layui-form-label">权限类别</label>
                    <div class="layui-input-inline">
                            <select id="privType" lay-filter="privTypeFilter" name="privType"><option value="">请选择</option><option value="0">浏览</option><option value="1">下载</option></select>
<%--                            <input type="text" id="privType" name="privType" autocomplete="off" class="layui-input">--%>
                        </div>
                </div>
            </div>
            <div class="layui-form-item" style="display: inline-block">
            <div class="layui-inline">
                <label class="layui-form-label"><span style="color:red">*</span>知识类别</label>
                <div class="layui-input-inline" id="parentColumnId" style="position: relative">
                           <input type="text" id="pele" pid name="ttitle" required="" style="cursor: pointer" lay-verify="required" placeholder="请选择" readonly="" autocomplete="off" class="layui-input">
                     <div class="eleTree ele1" lay-filter="data1" style="display:none;position:absolute;border: 1px solid #d2d2d2;overflow-y: auto;background-color: #fff;border-radius: 2px;box-shadow: 0 2px 4px rgba(0,0,0,.12);box-sizing: border-box;overflow:hidden;z-index: 999;top:38px;left:0px;width: 100%;"></div></div></div></div>
            <div class="layui-form-item" style="display: inline-block">
            <div class="layui-inline">
                    <label class="layui-form-label">oa用户名</label>
                    <div class="layui-input-inline">
                            <input type="text" id="byName" name="byName" autocomplete="off" class="layui-input">
                            <input type="hidden" id="userId" name="userId">
                        </div>
                </div>
            </div>
            <div class="layui-form-item" style="display: inline-block">
            <div class="layui-inline">
                    <label class="layui-form-label">oa密码</label>
                    <div class="layui-input-inline">
                        <input type="password" id="password" name="password" autocomplete="new-password" class="layui-input">
                        <span id="passwordTxt" style="position: absolute;display: none">密码长度为8-20位</span>
                    </div>
                </div>
            </div>
            <div class="layui-form-item pwd2" style="display: inline-block">
                <div class="layui-inline">
                    <label class="layui-form-label">重复密码</label>
                    <div class="layui-input-inline">
                        <input type="password" id="password2" name="password2" autocomplete="off" class="layui-input">
                        <span id="passwordTxt2" style="position: absolute;display: none">密码长度为8-20位</span>
                    </div>
                </div>
            </div>
            <div class="layui-form-item" style="display: inline-block">
            <div class="layui-inline">
                    <label class="layui-form-label">oa角色</label>
                    <div class="layui-input-inline">
                            <input type="text" id="userPriv" name="userPriv" autocomplete="off" class="layui-input">
                        </div>
                </div>
            </div>
<%--            <div class="layui-form-item" style="display: inline-block" id="detp">--%>
<%--            <div class="layui-inline">--%>
<%--                    <label class="layui-form-label">选择部门</label>--%>
<%--                    <div class="layui-input-inline">--%>
<%--                                <select id="department" name="deptId"></select>--%>
<%--&lt;%&ndash;                     <input type="text" id="logingPassword" name="logingPassword" autocomplete="off" class="layui-input">&ndash;%&gt;--%>
<%--                        </div>--%>
<%--                </div>--%>
<%--            </div>--%>
            <div class="layui-form-item downDiv" style="display: inline-block">
               <div class="layui-inline">
                    <label class="layui-form-label"><span style="color:red">*</span>下载开始时间：</label>
                    <div class="layui-input-inline">
                            <input type="text" id="downloadBDate" placeholder="请选择" name="downloadBDate" autocomplete="off" class="layui-input">
                        </div>
                </div>
            </div>
            <div class="layui-form-item downDiv" style="display: inline-block">
            <div class="layui-inline">
                    <label class="layui-form-label"><span style="color:red">*</span>下载结束时间：</label>
                    <div class="layui-input-inline">
                            <input type="text" id="downloadEDate"  placeholder="请选择" name="downloadEDate" autocomplete="off" class="layui-input">
                        </div>
                </div>
            </div>
            <div class="layui-form-item lookDiv" style="display: inline-block">
            <div class="layui-inline">
                    <label class="layui-form-label"><span style="color:red">*</span>浏览开始时间：</label>
                    <div class="layui-input-inline">
                            <input type="text" id="browseBDate"  placeholder="请选择" name="browseBDate" autocomplete="off" class="layui-input">
                        </div>
                </div>
            </div>
            <div class="layui-form-item lookDiv" style="display: inline-block">
            <div class="layui-inline">
                    <label class="layui-form-label"><span style="color:red">*</span>浏览结束时间：</label>
                    <div class="layui-input-inline">
                            <input type="text" id="browseEDate" placeholder="请选择" name="browseEDate" autocomplete="off" class="layui-input">
                        </div>
                </div>
            </div>
            <div class="layui-form-item" style="display: inline-block;">
            <div class="layui-inline">
                    <label class="layui-form-label">备注</label>
                    <div class="layui-input-inline">
                            <input type="text" id="memo" name="memo" autocomplete="off" class="layui-input">
                        </div>
                </div>
            </div>
            <%--            氚云对接信息录入开始--%>
            <div class="layui-form-item" style="display: inline-block">
                <div class="layui-inline">
                    <label class="layui-form-label">appCode：</label>
                    <div class="layui-input-inline">
                        <input type="text" id="appCode"  name="appCode" autocomplete="off" class="layui-input">
                    </div>
                </div>
            </div>
            <div class="layui-form-item" style="display: inline-block">
                <div class="layui-inline">
                    <label class="layui-form-label">engineCode：</label>
                    <div class="layui-input-inline">
                        <input type="text" id="engineCode" name="engineCode" autocomplete="off" class="layui-input">
                    </div>
                </div>
            </div>
            <div class="layui-form-item" style="display: inline-block">
                <div class="layui-inline">
                    <label class="layui-form-label">secret：</label>
                    <div class="layui-input-inline">
                        <input type="text" id="engineSecret" name="engineSecret" autocomplete="off" class="layui-input">
                    </div>
                </div>
            </div>
            <div class="layui-form-item" style="display: inline-block">
                <div class="layui-inline">
                    <label class="layui-form-label">companyObjectId：</label>
                    <div class="layui-input-inline">
                        <input type="text" id="companyObjectId"  name="companyObjectId" autocomplete="off" class="layui-input">
                    </div>
                </div>
            </div>
            <%--            氚云对接信息录入结束--%>
            <button type="button" id="btnSubmit" lay-filter="btnSubmit" lay-submit style="display: none"></button>
        </form>
    </div>
</div>
<script type="text/javascript">
    // 获取地址栏参数值
    function getQueryString(name){
        var reg = new RegExp("(^|&)"+ name +"=([^&]*)(&|$)");
        var r = window.location.search.substr(1).match(reg);
        if(r!=null)return  unescape(r[2]); return null;
    }
    var seleId = 58;//=getQueryString('deptId');
    var customerId = getQueryString('customerId')
    var type = getQueryString('type')
    var PcolumnId;
    var customer;
    var dataObj = {};
    var arr = [];
    var arr1 = [];
    layui.use(['laydate','table','layer','form','eleTree','element'], function(){
        var form = layui.form
            ,layer = layui.layer
            ,$ = layui.jquery
            ,laydate = layui.laydate
            ,element=layui.element
            ,eleTree = layui.eleTree;

        // $.ajax({
        //     url: '/getOrgList',
        //     dataType: 'json',
        //     type: 'get',
        //     success: function (res) {
        //         var object = res.obj
        //         var str = '<option style="text-align: left">请选择</option>'
        //         for (var i = 0; i < object.length; i++) {
        //             if(object[i].deptParent==0){
        //                 str += '<option style="text-align: left" value="' + object[i].deptId + '">' + object[i].deptName + '</option>'
        //                 var parent = object[i];
        //                 var count = "";
        //                 str += alone(object,parent,count);
        //             }
        //         }
        //         $('#department').append(str)
        //         form.render('select');
        //     }
        // })
        // function alone(ob,parent,count){
        //     var str = '';
        //     count +="|-- ";
        //     for(var i=0;i<ob.length;i++){
        //         if(ob[i].deptParent == parent.deptId){
        //             str += '<option style="text-align: left" value="' + ob[i].deptId + '">'+count + ob[i].deptName + '</option>'
        //             str += alone(ob,ob[i],count);
        //         }
        //     }
        //     return str;
        // }
        var el;
        $("[name='ttitle']").on("click",function (e) {
            e.stopPropagation();
            if(!el){
                el=eleTree.render({
                    elem: '.ele1',
                    url:'/knowledge/childTree',
                    expandOnClickNode: false,
                    highlightCurrent: true,
                    showLine:true,
                    showCheckbox: true,
                    checked: true,
                    defaultExpandAll: true,
                    load: function (data, callback) {
                    },
                    done: function(res){
                        var columnId = $("#pele").attr("pid");;
                        var elm = '.ele1'
                        var pidar = columnId.split(",");
                        var pidarr=[];
                        for(var j =0;j<pidar.length;j++){
                            if(pidar[j] == ""){

                            }else{
                                pidarr.push(pidar[j]);
                            }
                        }
                        for(var j=0;j<pidarr.length;j++){
                            $(elm+" div[data-id="+pidarr[j]+"]").find("input").eq(0).attr("checked",true);
                            $(elm+" div[data-id="+pidarr[j]+"]").find("input").eq(0).attr("eletree-status","1");
                            // $(elm+" div[data-id="+pidarr[j]+"]").find("input").eq(0).addClass("eleTree-disabled");
                            $(elm+" div[data-id="+pidarr[j]+"]").find("input").eq(0).next("div.eleTree-checkbox").addClass("eleTree-checkbox-checked");
                            $(elm+" div[data-id="+pidarr[j]+"]").find("input").eq(0).next("div.eleTree-checkbox").find("i").addClass("layui-icon-ok");
                        }
                        var arr1 = [];
                        var arr2 = res.obj;
                        for(var i =0;i<res.data.length;i++){
                            arr1.push(res.data[i].id);
                        }
                        for(var i =0;i<arr1.length;i++){
                            for(var j=0;j<arr2.length;j++){
                                if(arr1[i] == arr2[j]){
                                    $("div[data-id="+arr2[j]+"]").find("input").eq(0).attr("disabled",true);
                                    $("div[data-id="+arr2[j]+"]").find("input").eq(0).attr("eletree-status","0");
                                    $("div[data-id="+arr2[j]+"]").find("input").eq(0).addClass("eleTree-disabled");
                                    $("div[data-id="+arr2[j]+"]").find("input").eq(0).next("div.eleTree-checkbox").addClass("eleTree-checkbox-disabled");
                                }
                            }
                        }
                    }
                });
            }
            $(".ele1").slideDown();
        })
        $(document).on("click",function() {
            $(".ele1").slideUp();
        })
        //选中监听事件
        eleTree.on("nodeChecked(data1)",function(d) {
            var id = d.data.currentData.columnId + "";
            var label = d.data.currentData.label + "";
            if(d.isChecked == true || d.isChecked == "true"){
                arr.push(id);
                arr1.push(label);
            }else{
                arr.remove(id);
                arr1.remove(label);
            }
            // if(dataObj.columnId != undefined || dataObj.columnId != "undefined" || dataObj.columnId != ""){
            //     var str = dataObj.columnId+ ",";
            // }else{
            //     var str= "";
            // }
            // if(dataObj.columnName != undefined || dataObj.columnName != "undefined" || dataObj.columnName != ""){
            //     var str1 = dataObj.columnName + ",";
            // }else{
            //     var str1 = "";
            // }
            var str ="";
            var str1 ="";
            for(var i=0;i<arr.length;i++){
                str+=arr[i]+","
                str1+=arr1[i]+","
            }
            // for(var i=0;i<arr.length;i++){
            //     str+=arr[i]+","
            //     str1+=arr1[i]+","
            // }
            // var astr = str.split(",");
            // var strr = "";
            // for(var j=0;j<astr.length;j++){
            //     if(astr[j] == ""){
            //
            //     }else{
            //         strr+=astr[j]+","
            //     }
            // }
            $("[name='ttitle']").val(str1);
            $("#pele").attr("pid",str);
        })
        var $select1 = $("select[name='companyNatrue']");
        var optionStr = '<option value="">请选择</option>';
        $.ajax({ //查询文档等级
            url: '/code/getCode?parentNo=KNOWLEDGE_COMPANY_NATRUE',
            type: 'get',
            dataType: 'json',
            async:false,
            success: function (res) {
                if(res.obj!=undefined&&res.obj.length>0){
                    for(var i=0;i<res.obj.length;i++){
                        optionStr += '<option value="' + res.obj[i].codeNo + '">' + res.obj[i].codeName + '</option>'
                    }
                }
            }
        })
        $select1.html(optionStr);
        //渲染角色
        var $select2 = $("select[name='role']");
        var optionStr2 = '<option value="">请选择</option>';
        $.ajax({ //查询所有角色
            url: '/clientRole/getAllRoleColumn',
            type: 'post',
            dataType: 'json',
            async:false,
            success: function (res) {
                if(res.data!=undefined&&res.data.length>0){
                    for(var i=0;i<res.data.length;i++){
                        optionStr2 += '<option name="' + res.data[i].columnName + '" deptId="' + res.data[i].deptId + '" privId="' + res.data[i].privId + '" privName="' + res.data[i].privName + '"  value="' + res.data[i].columnId + '">' + res.data[i].roleName + '</option>'
                    }
                }

            }
        })
        $select2.html(optionStr2);
        laydate.render({
            elem: '#downloadBDate'
            , trigger: 'click'//呼出事件改成click
            ,type: 'datetime'
        });
        laydate.render({
            elem: '#downloadEDate'
            , trigger: 'click'//呼出事件改成click
            ,type: 'datetime'
        });
        laydate.render({
            elem: '#browseBDate'
            , trigger: 'click'//呼出事件改成click
            ,type: 'datetime'
        });
        laydate.render({
            elem: '#browseEDate'
            , trigger: 'click'//呼出事件改成click
            ,type: 'datetime'
        });
        form.render();//初始化表单

        //监听选择角色下拉框
        form.on('select(formNoSelect)', function(data){
            console.log(data,'data')
            var pidt = undefind_nullStr(data.value);
            var valt = undefind_nullStr($(data.elem[data.elem.selectedIndex]).attr("name"));
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
            //$("#department").val(undefind_nullStr($(data.elem[data.elem.selectedIndex]).attr("deptId")));
             $("#userPriv").val(undefind_nullStr($(data.elem[data.elem.selectedIndex]).attr("privName")));
             $("#userPriv").attr("privid",undefind_nullStr($(data.elem[data.elem.selectedIndex]).attr("privId")))
            $("#pele").attr("pid",undefind_nullStr(data.value));
            $("#pele").val(undefind_nullStr($(data.elem[data.elem.selectedIndex]).attr("name")));
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
                                if(p1.length<8 || p1.length>20){
                                    layui.layer.msg("密码长度不符合要求")
                                    return false
                                }
                                if(p2.length<8 || p2.length>20){
                                    layui.layer.msg("密码长度不符合要求")
                                    return false
                                }
                                var columnId = $("#pele").attr("pid");
                                customer.columnId = columnId;
                                var contactUser = $("#contactUser").attr("user_id");
                                customer.contactUser = contactUser;
                                if(customer.customerId==undefined){
                                    customer.customerId = customerId;
                                }
                                var userPriv = $("#userPriv").attr("privid");
                                 if(userPriv.substring(userPriv.length-1,userPriv.length)==','){
                                     userPriv = userPriv.substring(0,userPriv.length-1)
                                 }
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
                            if(p1.length<8 || p1.length>20){
                                layui.layer.msg("密码长度不符合要求")
                                return false
                            }
                            if(p2.length<8 || p2.length>20){
                                layui.layer.msg("密码长度不符合要求")
                                return false
                            }
                            if(customer.browseBDate==undefined||customer.browseBDate==undefined||customer.browseBDate==""||customer.browseEDate==""){
                                parent.layui.layer.msg("请选择浏览时间")
                                return false
                            }else{
                                var columnId = $("#pele").attr("pid");
                                customer.columnId = columnId;
                                var contactUser = $("#contactUser").attr("user_id");
                                customer.contactUser = contactUser;
                                if(customer.customerId==undefined){
                                    customer.customerId = customerId;
                                }
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
                        if(p1.length<8 || p1.length>20){
                            layui.layer.msg("密码长度不符合要求")
                            return false
                        }
                        if(p2.length<8 || p2.length>20){
                            layui.layer.msg("密码长度不符合要求")
                            return false
                        }
                        var columnId = $("#pele").attr("pid");
                        customer.columnId = columnId;
                        var contactUser = $("#contactUser").attr("user_id");
                        customer.contactUser = contactUser;
                        if(customer.customerId==undefined){
                            customer.customerId = customerId;
                        }
                         var userPriv = $("#userPriv").attr("privid");
                         if(userPriv.substring(userPriv.length-1,userPriv.length)==','){
                            userPriv = userPriv.substring(0,userPriv.length-1)
                        }
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
    if(type== 'edit'||type== 'look'){
        $.ajax({
            url:'/client/getCustomerById',
            dataType: 'json',
            type: 'post',
            data:{
                customerId:customerId
            },
            success:function (res) {
                var data = res.object
                dataObj = res.object;
                if(data.privType=='1'){ //下载
                    $(".lookDiv").hide();
                    $(".downDiv").show();
                }else if(data.privType=='0'){ //浏览
                    $(".lookDiv").show();
                    $(".downDiv").hide();
                }else{
                    $(".lookDiv").show();
                    $(".downDiv").show();
                }
                $("#password2").val(undefind_nullStr(data.password));
                $("#pele").attr("pid",undefind_nullStr(data.columnId));
                $("#pele").val(undefind_nullStr(data.columnName));
                form.val("formTest",data)
                 $("#userPriv").attr("privid",data.userPriv)
                 $("#userPriv").val(data.userPrivName);
                /**
                 * {
                    "companyName": data.companyName
                    ,"companyCode": data.companyCode
                    ,"contactPhone": data.contactPhone
                    ,"contactUser": data.contactUser
                    ,"privType": data.privType
                    ,"memo": data.memo
                }
                 */
                if(type== 'look'){
                    $(".pwd2").hide()
                    $('input').attr("disabled","disabled")
                    $('select').attr("disabled","disabled")
                    form.render()
                }
            }
        })
    }
        // var el = eleTree.render({
        //     elem: '#elTre',
        //     // showCheckbox: true,
        //     showLine:true,
        //     url:'/knowledge/getKnowledgeType?colunmType='+0+'&parentColumnId=0',
        //     lazy: true,
        //     // checked: true,
        //     load: function(data,callback) {
        //         $.post('/knowledge/getKnowledgeType?parentColumnId='+data.id,function (res) {
        //             callback(res.data);//点击节点回调
        //         })
        //     },
        //     done:function (data) { //渲染完成回调
        //         if(data.data.length == 0){
        //             $('#elTre').css("text-align","center");
        //             $('#elTre').html('暂无数据');
        //             $('#elTre').hide();
        //         }else{
        //             $('#elTre').show();
        //         }
        //         // else{
        //         //     var parm ={
        //         //         equipTypeId:AllEquipTypeId
        //         //     }
        //         //     getTabke(parm,"#Settlement");
        //         //     var dataid=$('.ele1 div').attr("data-id")
        //         //     $('.eleTree-node').removeClass('back')
        //         //     $('.ele1 div[data-id='+dataid+']').addClass('back')
        //         //     $('.eleTree-node-group').css('background','#fff');
        //         //     $("#elTre").find(".back .eleTree-node-content").eq(0).click();
        //         // }
        //     }
        // });
        //
        //
        // // 节点点击事件
        // eleTree.on("nodeClick(tdata)",function(d) {
        //     console.log(d.node);
        //     $(d.node).find("span:not(.eleTree-node-content-icon)").click(function(){
        //         $("#elTreeBox").slideUp();
        //         $("#btn").attr("type","0");
        //     })
        //     var parData = d.data.currentData;
        //     var n = $("#ulBox").find("li.layui-this").attr("num");
        //     var columnId = d.data.currentData.id;
        //     var clas = "";
        //     var idn = ""
        //     var dataid=$(clas+' div').attr("data-id")
        //     $('.eleTree-node').removeClass('back')
        //     $(d.node[0]).addClass('back')
        //     $('.eleTree-node-group').css('background','#fff')
        //     var name = d.data.currentData.name;
        //     $("#tree").val(name);
        //     $("#columnId").val(columnId);
        // });
        // //保存操作
        // $(document).on("click", "#btn", function () {
        //     var type = $("#btn").attr("type")
        //     if(type == "0"){
        //         $("#elTreeBox").slideDown();
        //         $("#btn").attr("type","1");
        //     }else{
        //         $("#elTreeBox").slideUp();
        //         $("#btn").attr("type","0");
        //     }
        // })
    });
    //选人框架
    var user_id;
    $(document).on("click", "#contactUser", function () {
        user_id='contactUser';
        $.popWindow("../common/selectUserIMAddGroup");
    })

    //选角色框架
    var priv_id = 'userPriv';
    $(document).on("click", "#userPriv", function () {
        $.popWindow("/common/selectPriv?0");
    })



    // document.onmouseup = function(e){
    //     var e = e || window.event;
    //     var target = e.target || e.srcElement;
    //     var _con = $('#parentColumnId')//获取你的目标元素
    //     //1. 点击事件的对象不是目标区域本身
    //     //2. 事件对象同时也不是目标区域的子元素
    //     if(!_con.is(e.target) && _con.has(e.target).length === 0){
    //         $("#elTreeBox").slideUp();
    //         $("#btn").attr("type","0");
    //     }
    // }
    function undefind_nullStr(value) {
        if(value==undefined || value == "undefined"){
            return ""
        }
        return value
    }
</script>
</body>
</html>