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
    <title><fmt:message code="vote.th.New" /></title>
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
        background: none!important;
    }

</style>
<link rel="stylesheet" type="text/css" href="/css/commonTheme/${sessionScope.InterfaceModel}/commonTheme.css"/>

<body style="background: #fff">

<div class="content">
    <div class="header">
        <div class="title">
            <span class="big3"><fmt:message code="vote.th.New" /></span>
        </div>
    </div>
    <div class="main">
        <form id="from_1">
        <table id="main_table">
            <tr>
                <input id="proId" type="hidden">
                <td class="span_td"><fmt:message code="vote.th.OfficeName" />:<span style="color: #FF0000;margin-left: 10px;font-size: 16px;">*</span></td>
                <td class="span_td2"><input class="input_1" name="proName" id="proName" /></td>
                <td class="span_td"><fmt:message code="vote.th.Specificatio-model" />:<span style="color: #FF0000;margin-left: 10px;font-size: 16px;">*</span></td>
                <td class="span_td2"><input class="input_1" name="proDesc" id="proDesc" /></td>
            </tr>
            <tr>
                <td class="span_td"><fmt:message code="vote.th.Registration" />:<span style="color: #FF0000;margin-left: 10px;font-size: 16px;">*</span></td>
                <td class="span_td2">
                    <select style="background: none!important;" class="select" name="officeProductType"  id="officeProductType">
                        <option value=""><fmt:message code="hr.th.PleaseSelect" /></option>
                        <option value="1"><fmt:message code="vote.th.user" /></option>
                        <option value="2"><fmt:message code="vote.th.borrow" /></option>
                    </select>
                </td>
                <td class="span_td"><fmt:message code="vote.th.Measurement" />:</td>
                <td span_td2><input class="input_1" name="proUnit" id="proUnit"></td>
            </tr>
            <tr>
                <td class="span_td"><fmt:message code="vote.th.OfficeStorehouse" />:<span style="color: #FF0000;margin-left: 10px;font-size: 16px;">*</span></td>
                <td class="span_td2"><select style="background: none!important" class="select" name="OFFICE_DEPOSITORY"  id="OFFICE_DEPOSITORY"></select></td>
                <td class="span_td"><fmt:message code="vote.th.UnitPrice" />:</td>
                <td class="span_td2"><input type="number" id="proPrice" name="proPrice" class="input_1" />(<fmt:message code="vote.th.element" />)</td>
            </tr>
            <tr>
                <td class="span_td"><fmt:message code="vote.th.OfficeCategory" />:<span style="color: #FF0000;margin-left: 10px;font-size: 16px;">*</span></td>
                <td class="span_td2"><select style="background: none!important" class="select" name="officeProtype"  id="officeProtype"></select></td>
                <td class="span_td"><fmt:message code="vote.th.Supplier" />:</td>
                <td class="span_td2"><input class="input_1" name="proSupplier" id="proSupplier" /></td>
            </tr>
            <tr>
                <td class="span_td"><fmt:message code="vote.th.Code" />:<span style="color: #FF0000;margin-left: 10px;font-size: 16px;">*</span></td>
                <td class="span_td2"><input class="input_1" disabled="disabled" readonly="readonly" id="proCode" /></td>
                <td class="span_td"><fmt:message code="file.th.builder" />:</td>
                <td class="span_td2"><input class="input_1" contid="" disabled="disabled" id="proCreator" /></td>
            </tr>
            <tr>
                <td class="span_td"><fmt:message code="vote.th.CurrentStock" />:<span style="color: #FF0000;margin-left: 10px;font-size: 16px;">*</span></td>
                <td class="span_td2"><input  type="number" class="input_1" name="proStock" id="proStock" /></td>
                <td class="span_td"><fmt:message code="vote.th.SortNumber" />:</td>
                <td class="span_td2"><input type="number" class="input_1" name="proOrder" id="proOrder" /></td>
            </tr>

            <tr>
                <td class="span_td"><fmt:message code="vote.th.MinimumInventory" />:</td>
                <td class="span_td2"><input type="number" class="input_1" name="proLowstock" id="proLowstock"></td>
                <td class="span_td"><fmt:message code="vote.th.HighestInventory" />:</td>
                <td class="span_td2"><input type="number" class="input_1" name="proMaxstock" id="proMaxstock"></td>
            </tr>
            <tr>
                <td class="span_td"><fmt:message code="vote.th.Registration(user)" />:</td>
                <td class="span_td2">
                    <textarea  id="proManager" user_id="" cols="" style="background-color:#e7e7e7;min-width: 200px;min-height: 60px;" rows=""></textarea>
                    <a href="javascript:;" id="addProManager"><fmt:message code="global.lang.select" /></a>
                    <a href="javascript:;" id="clearProManager" style="color: red"><fmt:message code="global.lang.empty" /></a>
                </td>
                <td class="span_td"><fmt:message code="vote.th.Registration(Department)" />:</td>
                <td class="span_td2">
                    <textarea  id="proDept" deptid="" style="background-color:#e7e7e7;min-width: 200px;min-height: 60px;" cols="" rows=""></textarea>
                    <a href="javascript:;" id="addProDept"><fmt:message code="global.lang.select" /></a>
                    <a href="javascript:;" id="clearProDept" style="color: red"><fmt:message code="global.lang.empty" /></a>
                </td>
            </tr>
           <%-- <tr></tr>--%><%--附件--%>
        </table>
        </form>
    </div>
    <div class="save_div">
        <button class="btn_ok"><fmt:message code="main.th.confirm" /></button>
        <button class="btn_reset" style="color: red"><fmt:message code="global.lang.empty"  /></button>
    </div>
</div>
</body>
<script>
    var editFlag=${editFlag};
    var proId=${proId};

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
    function isNumber(val) {
        var regPos = /^\d+(\.\d+)?$/; //非负浮点数
        var regNeg = /^(-(([0-9]+\.[0-9]*[1-9][0-9]*)|([0-9]*[1-9][0-9]*\.[0-9]+)|([0-9]*[1-9][0-9]*)))$/; //负浮点数
        if(regPos.test(val) || regNeg.test(val)) {
            return true;
        } else {
            return false;
        }
    }
    var datas;
    $(function(){
        //新建
     if(editFlag==0){
         init1();
     }
     //编辑
     else{
         $('.big3').html("<fmt:message code="vote.th.Amend" />");

         //加载办公用品类别
         $.ajax({
             type:'post',
             url:'/officeSupplies/getOfficeProductById',
             dataType:'json',
             data:{proId:proId},
             success:function(res){
                 datas=res.object;
                 $('#proId').val(datas.proId);
                 $('#proName').val(datas.proName);
                 $('#proDesc').val(datas.proDesc);
                 $('#officeProductType').val(datas.officeProductType);
                 $('#proUnit').val(datas.proUnit);
                 //加载办公用品库下拉框
                 $.ajax({
                     type:'post',
                     url:'/officeDepository/selAllDepository',
                     dataType:'json',
                     success:function(res){
                         var data=res.obj;
                         var str="<option value=''><fmt:message code="hr.th.PleaseSelect" /></option>";
                         if(data!=undefined){
                             for(var i=0;i<data.length;i++){
                                 str+="<option value='"+data[i].id+"'>"+data[i].depositoryName+"</option>"
                             }
                         }
                         $('#OFFICE_DEPOSITORY').html(str);
                         $("#OFFICE_DEPOSITORY").val(datas.officeDepositoryId);
                     }
                 })

              if(datas.officeDepositoryId!=''){
                  $.ajax({
                      type:'post',
                      url:'/officeSupplies/selectAllOffType',
                      dataType:'json',
                      data:{typeDepository:datas.officeDepositoryId},
                      success:function(res){
                          var str="";
                          var str1="<option value=''><fmt:message code="hr.th.PleaseSelect" /></option>";
                          var data=res.obj;
                          if(data!=undefined){
                              for(var i=0;i<data.length;i++){
                                  str+="<option value='"+data[i].id+"'>"+data[i].typeName+"</option>";
                              }
                              $('#officeProtype').html(str);
                          }else{
                              $('#officeProtype').html(str1);
                          }
                          $('#officeProtype').val(datas.officeProtype);
                      }
                  })
              }else{
                 var str="<option value=''><fmt:message code="hr.th.PleaseSelect" /></option>";
                  $('#officeProtype').html(str);
              }
              $('#proPrice').val(datas.proPrice);
              $('#officeProtype').val(datas.officeProtype);
              $('#proSupplier').val(datas.proSupplier);
              $('#proCode').val(datas.proCode);
                 $('#proCreator').val(datas.proCreatorName);
                 $('#proCreator').attr('contid',datas.proCreator);
              $('#proStock').val(datas.proStock);
                 $('#proLowstock').val(datas.proLowstock);
                 $('#proMaxstock').val(datas.proMaxstock);
              $('#proOrder  ').val(datas.proOrder);
              $('#proManager').attr('user_id',datas.proManager);
              $('#proManager').val(datas.proManagerName);
              $('#proDept').attr('deptid',datas.proDept);
              $('#proDept').val(datas.proDeptName);
             }
         })
         $('#OFFICE_DEPOSITORY').change(function(){
             $.ajax({
                 type:'post',
                 url:'/officeSupplies/selectAllOffType',
                 dataType:'json',
                 data:{typeDepository:$('#OFFICE_DEPOSITORY option:checked').val()},
                 success:function(res){
                     var str="";
                     var str1="<option value=''><fmt:message code="hr.th.PleaseSelect" /></option>";
                     var datas=res.obj;
                     if(datas!=undefined){
                         for(var i=0;i<datas.length;i++){
                             str+="<option value='"+datas[i].id+"'>"+datas[i].typeName+"</option>";
                         }
                         $('#officeProtype').html(str);
                     }else{
                         $('#officeProtype').html(str1);
                     }

                 }
             })
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
                                location.reload()
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
        }else{
            if(!isNumber($('#proStock').val())){
                $.layerMsg({content:"当前库存必须为数字！", icon: 2});
                return false;
            }
        }
        if($('#proPrice').val() != ''){
            if(!isNumber($('#proPrice').val())){
                $.layerMsg({content:"单价必须为数字！", icon: 2});
                return false;
            }
        }

        if($('#proOrder').val() != ''){
            if(!isNumber($('#proOrder').val())){
                $.layerMsg({content:"排序号必须为数字！", icon: 2});
                return false;
            }
        }

        if($('#proLowstock').val() != ''){
            if(!isNumber($('#proLowstock').val())){
                $.layerMsg({content:"最低警戒库存必须为数字！", icon: 2});
                return false;
            }
        }

        if($('#proMaxstock').val() != ''){
            if(!isNumber($('#proMaxstock').val())){
                $.layerMsg({content:"最高警戒库存必须为数字！", icon: 2});
                return false;
            }
        }

        return true;
    }
</script>
</html>
