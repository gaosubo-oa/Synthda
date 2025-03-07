<%--
  Created by IntelliJ IDEA.
  User: 高亚峰
  Date: 2017/10/9
  Time: 15:290
--%>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@taglib prefix="mvc" uri="http://www.springframework.org/tags/form" %>
<%@taglib prefix="fmt" uri="http://www.springframework.org/tags" %>
<html>
<head>
    <title><fmt:message code="work.th.workApply" /><fmt:message code="file.th.detail" /></title>
    <link rel="stylesheet" href="/lib/layer/skin/default/layer.css">
    <link rel="stylesheet" href="/css/base.css">
   <script type="text/javascript" src="../js/xoajq/xoajq1.js"></script>
    <script src="/lib/layer/layer.js?20201106"></script>
    <script src="/js/base/base.js"></script>
    <script src="/js/jquery/jquery.form.min.js"></script>
</head>
<style>
    td{
        font-size: 13pt;
    }
    .header{
        line-height: 60px;
    }
    .title{
        margin-left: 30px;
        height: 50px;
    }
    .big3{
        font-family: Microsoft yahei,Helvetica Neue,Helvetica,PingFang SC,Tahoma,Arial,sans-serif;
        font-size: 22px;
        line-height: 60px;
        color: #494d59;
    }
    .main{
        margin-top: 20px;
    }

    #main_table{
        width: 100%;
        /*width: 90%;*/
        margin: 0 auto;
    }
    .select{
        width: 200px;
        height: 30px;
    }
    .input_1{
        width: 200px;
        height: 30px;
    }
    .span_td{
        text-align: right;
        /*width: 12%;*/
        width: 17%;
        border-right: #ccc 1px solid;
    }
    .span_td2{
        width: 33%;
        /*width: 25%;*/
        border-right: #ccc 1px solid;
    }
    .btn_ok{
        border-color: #4898d5;
        background-color: #2e8ded;
        color: #fff;
        width: 56px;
        height: 30px;
        border-radius: 5%;
        margin-left: 35%;
        cursor: pointer;
    }
    .btn_sl{
        border-color: #4898d5;
        background-color: #2e8ded;
        color: #fff;
        width: 56px;
        height: 30px;
        border-radius: 5%;
        margin-left: 35%;
        cursor: pointer;
    }
    .btn_reset{
        border: 1px solid #dcdcdc;
        background-color: #f3f3f3;
        color: #333;
        width: 56px;
        height: 30px;
        border-radius: 5%;
        margin-left: 10px;
        cursor: pointer;
    }
    .remark{
        vertical-align: middle;
        border: #999 1px solid;
    }
    a{
        color: #207bd6;
        cursor: pointer;
        text-decoration:none;
    }
    .save_div{
        margin-top: 5%;
        margin-left: 14%;
    }

    .select{
        /*background: none!important;*/
    }
</style>
<link rel="stylesheet" type="text/css" href="/css/commonTheme/${sessionScope.InterfaceModel}/commonTheme.css"/>

<body style="background: #fff">

<div class="content">
    <div class="header">
        <div class="title">
            <span class="big3">办公用品申领详情</span>
        </div>
    </div>
    <div class="main">
        <form id="from_1">
        <table id="main_table">
            <tr>
                <input id="proId" type="hidden">
                <td class="span_td"><fmt:message code="vote.th.OfficeName" />:<span style="color: #FF0000;margin-left: 10px;font-size: 16px;">*</span></td>
                <td class="span_td2"><input disabled="disabled" class="input_1" name="proName" id="proName" /></td>
                <td class="span_td"><fmt:message code="vote.th.Specificatio-model"/>:<span style="color: #FF0000;margin-left: 10px;font-size: 16px;">*</span></td>
                <td class="span_td2"><input disabled="disabled" class="input_1" name="proDesc" id="proDesc" /></td>
            </tr>
            <tr>
                <td class="span_td"><fmt:message code="vote.th.Registration"/>:<span style="color: #FF0000;margin-left: 10px;font-size: 16px;">*</span></td>
                <td class="span_td2">
                    <input disabled="disabled" class="select" name="officeProductType"  id="officeProductType" />
                </td>
                <td class="span_td"><fmt:message code="vote.th.Measurement" />:</td>
                <td span_td2><input disabled="disabled" class="input_1" name="proUnit" id="proUnit"></td>
            </tr>
            <tr>
                <td class="span_td"><fmt:message code="vote.th.OfficeStorehouse" />:<span style="color: #FF0000;margin-left: 10px;font-size: 16px;">*</span></td>
                <td class="span_td2"><input disabled="disabled" class="select" name="OFFICE_DEPOSITORY"  id="OFFICE_DEPOSITORY"/></td>
                <td class="span_td"><fmt:message code="vote.th.UnitPrice" />:</td>
                <td class="span_td2"><input disabled="disabled" id="proPrice" name="proPrice" class="input_1" />(<fmt:message code="vote.th.element" />)</td>
            </tr>
            <tr>
                <td class="span_td"><fmt:message code="vote.th.OfficeCategory" />:<span style="color: #FF0000;margin-left: 10px;font-size: 16px;">*</span></td>
                <td class="span_td2"><input disabled="disabled" class="select" name="officeProtype"  id="officeProtype"/></td>
                <td class="span_td"><fmt:message code="vote.th.Supplier" />:</td>
                <td class="span_td2"><input disabled="disabled" class="input_1" name="proSupplier" id="proSupplier" /></td>
            </tr>
            <tr>
                <td class="span_td"><fmt:message code="vote.th.Code" />:<span style="color: #FF0000;margin-left: 10px;font-size: 16px;">*</span></td>
                <td class="span_td2"><input disabled="disabled" class="input_1" disabled="disabled" readonly="readonly" id="proCode" /></td>
                <td class="span_td"><fmt:message code="file.th.builder" />:</td>
                <td class="span_td2"><input disabled="disabled" class="input_1" contid="" disabled="disabled" id="proCreator" /></td>
            </tr>
            <tr>
                <td class="span_td"><fmt:message code="vote.th.CurrentStock" />:<span style="color: #FF0000;margin-left: 10px;font-size: 16px;">*</span></td>
                <td class="span_td2"><input disabled="disabled" class="input_1" name="proStock" id="proStock" /></td>
                <td class="span_td"><fmt:message code="vote.th.SortNumber" />:</td>
                <td class="span_td2"><input disabled="disabled" class="input_1" name="proOrder" id="proOrder" /></td>
            </tr>

            <tr>
                <td class="span_td"><fmt:message code="vote.th.MinimumInventory" />:</td>
                <td class="span_td2"><input disabled="disabled" class="input_1" name="proLowstock" id="proLowstock"></td>
                <td class="span_td"><fmt:message code="vote.th.HighestInventory" />:</td>
                <td class="span_td2"><input disabled="disabled" class="input_1" name="proMaxstock" id="proMaxstock"></td>
            </tr>
            <tr>
                <td class="span_td"><fmt:message code="vote.th.Registration(user)" />:</td>
                <td class="span_td2">
                    <textarea disabled  id="proManager" cols="" style="background-color:#e7e7e7;min-width: 200px;min-height: 60px;" rows=""></textarea>
                    <%--<a href="javascript:;" id="addProManager"><fmt:message code="global.lang.select" /></a>--%>
                    <%--<a href="javascript:;" id="clearProManager"><fmt:message code="global.lang.empty" /></a>--%>
                </td>
                <td class="span_td"><fmt:message code="vote.th.Registration(Department)" />:</td>
                <td class="span_td2">
                    <textarea disabled id="proDept" style="background-color:#e7e7e7;min-width: 200px;min-height: 60px;" cols="" rows=""></textarea>
                    <%--<a href="javascript:;" id="addProDept"><fmt:message code="global.lang.select" /></a>--%>
                    <%--<a href="javascript:;" id="clearProDept"><fmt:message code="global.lang.empty" /></a>--%>
                </td>
            </tr>
           <%-- <tr></tr>--%><%--附件--%>
        </table>
        </form>
    </div>
    <div class="save_div">
                <%--<button class="btn_ok"><fmt:message code="main.th.confirm" /></button>--%>
        <button class="btn_sl"><fmt:message code="office.add"/></button>
        <button class="btn_reset"><fmt:message code="global.lang.empty" /></button>
    </div>
</div>
</body>
<script>

    /**
     * 寇义东：
     * 将当前url的所有参数改为键值对
     **/
    var obj = {};
    var url = $(window.parent.document).find('.iframe_1').attr('src');
    var list = url.split('?')[1].split('&');
    for(var i = 0; i < list.length; i++){
        obj[list[i].split('=')[0]] = list[i].split('=')[1];
    }

    var depositoryid = '';
    var protypeid = '';



    <%--var editFlag=${editFlag};--%>
    <%--var proId=${proId};--%>

    //登记用户
    $('#addProManager').click(function(){
        user_id="proManager";
        $.popWindow("../../common/selectUser");
    });
    //登记用户清空
    $('#clearProManager').click(function(){
        $('#proManager').attr("dataid","");
        $('#proManager').attr("user_id","");
        $('#proManager').val("");
    });
    //登记用户
    $('#addProDept').click(function(){
        dept_id="proDept";
        $.popWindow("../../common/selectDept");
    });
    //登记部门清空
    $('#clearProDept').click(function(){
        $('#proDept').attr("deptno","");
        $('#proDept').attr("deptid","");
        $('#proDept').val("");
    });

    $(function(){


        //新建
     if(obj.editFlag==0){
         init1();
     // 详情
     }else{
         <%--$('.big3').html("<fmt:message code="vote.th.Amend" />");--%>

         //加载办公用品类别
         $.ajax({
             type:'post',
             url:'/officeSupplies/getOfficeProductById',
             dataType:'json',
             data:{proId:obj.proid},
             success:function(res){
                 console.log(res);
                // 登记类型：1.领用 2.借用
                 var officeProductType = '';
                 if(res.object.officeProductType == '1'){
                     officeProductType = '<fmt:message code="vote.th.user"/>';
                 }else if(res.object.officeProductType == '2'){
                     officeProductType = '<fmt:message code="vote.th.borrow"/>';
                 }

                 // 办公用品的返回结果
                 var bgypNum = '';
                 $.ajax({
                     type:'post',
                     url:'/officeDepository/selAllDepository',
                     dataType:'json',
                     success:function(res2){
                         var data=res2.obj;
                         if(data!=undefined){
                             for(var i=0;i<data.length;i++){
                                 if(data[i].id == res.object.officeDepositoryId){
                                     bgypNum = data[i].id;
                                     $('#OFFICE_DEPOSITORY').val(data[i].depositoryName); // 办公用品库
                                     depositoryid = res.object.officeDepositoryId;
                                     return;
                                 }
                             }
                         }
                     }
                 })

                 // 根据后台返回的ID判断办公用品类别是什么
                 $.ajax({
                     type:'post',
                     url:'/officeSupplies/selectAllOffType',
                     dataType:'json',
                     data:{typeDepository:res.object.officeDepositoryId},
                     success:function(res3){
                         console.log(res3);
                         var data=res3.obj;
                         if(data!=undefined){
                             for(var i=0;i<data.length;i++){
                                 if(data[i].id == res.object.officeProtype){
                                     $('#officeProtype').val(data[i].typeName); // 办公用品类别
                                     protypeid = res.object.officeProtype;
                                     return;
                                 }
                             }
                         }
                     }
                 })



                $('#proName').val(res.object.proName); // 办公用品名称
                $('#proDesc').val(res.object.proDesc); // 规格型号
                 $('#officeProductType').val(officeProductType); // 登记类型
                 $('#proUnit').val(res.object.proUnit); // 计量单位

                 $('#proPrice').val(res.object.proPrice); // 单价

                 $('#proSupplier').val(res.object.proSupplier); // 供应商
                 $('#proCode').val(res.object.proCode); // 办公用品编码
                 $('#proCreator').val(res.object.proCreatorName); // 创建人
                 $('#proCreator').attr('contid',res.object.proCreator);
                 $('#proStock').val(res.object.proStock); // 当前库存
                 $('#proOrder').val(res.object.proOrder); // 排序号
                 $('#proLowstock').val(res.object.proLowstock); // 最低警戒库存
                 $('#proMaxstock').val(res.object.proMaxstock); // 最高警戒库存
                 $('#proManager').html(res.object.proManagerName); // 登记权限(用户)
                 $('#proManager').attr('user_id',res.object.proManager);
                 $('#proDept').html(res.object.proDeptName); // 登记权限(部门)
                 $('#proDept').attr('deptid',res.object.proDept);


             }
         })












     }
    })
    function init1(){
        //加载办公用品库下拉框
        $.ajax({
            type:'post',
            url:'/officeDepository/selAllDepository',
            dataType:'json',
            success:function(res){
                var datas=res.obj;
                var str="<option value=''><fmt:message code="hr.th.PleaseSelect" /></option>";
                if(datas!=undefined){
                    for(var i=0;i<datas.length;i++){
                        str+="<option value='"+datas[i].id+"'>"+datas[i].depositoryName+"</option>"
                    }
                }
                $('#OFFICE_DEPOSITORY').html(str);
            }
        })
        //加载办公用品类别
        $('#OFFICE_DEPOSITORY').change(function(){
            $.ajax({
                type:'post',
                url:'/officeSupplies/selectAllOffType',
                dataType:'json',
                data:{typeDepository:$('#OFFICE_DEPOSITORY').val()},
                success:function(res){
                    var str="<option value=''><fmt:message code="hr.th.PleaseSelect" /></option>";
                    var datas=res.obj;
                    if(datas!=undefined){
                        for(var i=0;i<datas.length;i++){
                            str+="<option value='"+datas[i].id+"'>"+datas[i].typeName+"</option>";
                        }
                    }
                    $('#officeProtype').html(str);
                }
            })
        })
        //加载创建人和办公用品编码
        $.ajax({
            type: 'post',
            url: '/officeSupplies/getInfo',
            dataType: 'json',
            success: function (res) {
             var data =res.object;
             $('#proCode').val(data.proCode);
             $('#proCreator').val(data.proCreatorName);
             $('#proCreator').attr('contid',data.proCreator);
            }
        })
    }
    $('.btn_ok').click(function(){
        var editFlag = obj[editFlag];
        if(editFlag==0){
            if(checkForm()){
                $('#from_1').ajaxSubmit({
                    url:"/officeSupplies/addOfficeProducts",
                    type:'post',
                    dataType:'json',
                    data:{
                        proCode:$('#proCode').val(),
                        proManager: $('#proManager').attr("user_id"),
                        proDept:$('#proDept').attr("deptid"),
                        proCreator:$('#proCreator').attr('contid')
                    },
                    success:function (json) {
                        if(json.flag) {
                            $.layerMsg({content: '<fmt:message code="url.th.addSuccess" />！', icon: 1}, function () {
                            });
                        }else{
                            $.layerMsg({content: '<fmt:message code="hr.th.AddFailed" />', icon: 1}, function () {
                            });
                        }
                    }
                })
            }
        }else{
            if(checkForm()){
                $('#from_1').ajaxSubmit({
                    url:"/officeSupplies/editOfficeProducts",
                    type:'post',
                    dataType:'json',
                    data:{
                        proId:$('#proId').val(),
                        proCode:$('#proCode').val(),
                        proManager: $('#proManager').attr("user_id"),
                        proDept:$('#proDept').attr("deptid"),
                        proCreator:$('#proCreator').attr('contid')
                    },
                    success:function (json) {
                        if(json.flag) {
                            $.layerMsg({content: '<fmt:message code="vote.th.UpdateSuccess" />！', icon: 1}, function () {
                                window.location.href='/officeSupplies/goOfficeList?typeId='+$('#officeProtype').val();
                            });
                        }else{
                            $.layerMsg({content: '<fmt:message code="vote.th.UpdateFailure" />', icon: 1}, function () {
                            });
                        }
                    }
                })
            }
        }
    })
    //重新填写
    $('.btn_reset').click(function(){
        $('#proName').val("");
        $('#proDesc').val("");
        $('#officeProductType').val("");
        $('#OFFICE_DEPOSITORY').val("");
        $('#officeProtype').val("");
        $('#proCode').val("");
        $('#proStock').val("");
        $('#proUnit').val("");
        $('#proPrice').val("");
        $('#proCreator').val("");
        $('#proSupplier').val('');
        $('#proLowstock').val('');
        $('#proOrder').val("");
        $('#proMaxstock').val("");
        $('#proManager').attr("user_id","");
        $('#proManager').val("");
        $('#proDept').attr("deptid","");
        $('#proDept').val("");
        $('#officeProtype').val("");
    })
    function checkForm(){
        if($('#proName').val()==''){
            $.layerMsg({content:"<fmt:message code="vote.th.Officelies" />", icon: 2});
            return false;
        }
        if($('#proDesc').val()==''){
            $.layerMsg({content:"<fmt:message code="vote.th.specifications-models" />", icon: 2});
            return false;
        }
        if($('#officeProductType').val()==''){
            $.layerMsg({content:"<fmt:message code="vote.th.Registrations" />", icon: 2});
            return false;
        }
        if($('#OFFICE_DEPOSITORY').val()==''){
            $.layerMsg({content:"<fmt:message code="vote.th.Library" />", icon: 2});
            return false;
        }
        if($('#officeProtype').val()==''){
            $.layerMsg({content:"<fmt:message code="vote.th.category" />", icon: 2});
            return false;
        }
        if($('#proCode').val()==''){
            $.layerMsg({content:"<fmt:message code="vote.th.Supplies" />", icon: 2});
            return false;
        }
        if($('#proStock').val()==''){
            $.layerMsg({content:"<fmt:message code="vote.th.PleaseStock" />", icon: 2});
            return false;
        }
        return true;
    }
    $('.save_div').on('click', '.btn_sl', function (e){
        e.stopPropagation();
//        var url = $(this).attr('url');
//        var that=$(this);
//        var url = $('.proIdTxt').val();

//        console.log('proid: '+proid+',' + 'depositoryid: '+ depositoryid + ',' + 'protypeid: ' + protypeid);

        $(window.parent.document).find('.iframe_1').attr('src', '/officetransHistory/gpProApply?editFlag=0&transId=0&proid='+obj.proid+'&depositoryid='+obj.depositoryid+'&protypeid='+obj.protypeid+'');
//        $(window.parent.document).find('.iframe_1').attr('src', '/officetransHistory/gpProApply?editFlag=0&transId=0&proid="'+obj.proid+'"&depositoryid="'+depositoryid+'"&protypeid="'+protypeid+'"');
//        init1();
    });






</script>
</html>
