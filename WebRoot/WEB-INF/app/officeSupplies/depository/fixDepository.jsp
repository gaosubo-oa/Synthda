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
    <title><fmt:message  code="vote.th.inventoryManagement"/></title>
    <link rel="stylesheet" href="/lib/layer/skin/default/layer.css">
    <link rel="stylesheet" href="/css/base.css">
    <link rel="stylesheet" href="/lib/laydate/need/laydate.css">
    <script type="text/javascript" src="/ui/js/xoajq/xoajq3.js"></script>
    <script src="../js/base/base.js" type="text/javascript" charset="utf-8"></script>
    <script src="/lib/laydate/laydate.js"></script>
    <script src="/js/jquery/jquery.form.min.js"></script>
</head>
<style>
    td{
        font-size: 11pt;
    }
    .header{
        line-height: 60px;
    }
    .title{
        margin-left: 3%;
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
        width: 60%;
        margin: 0 auto;
    }
    .span_td{
        text-align: right;
        width: 15%;
        border-right: #ccc 1px solid;
    }
    .span_td2{
        width: 45%;
    }
    .btn_ok{
        border-color: #4898d5;
        background-color: #2e8ded;
        color: #fff;
        width: 56px;
        height: 30px;
        border-radius: 5%;
        margin-left: 350px;
    }
    .btn_reset{
        border: 1px solid #dcdcdc;
        background-color: #f3f3f3;
        color: #333;
        width: 56px;
        height: 30px;
        border-radius: 5%;
        margin-left: 10px;
    }
    .remark{
        vertical-align: middle;
        border: #999 1px solid;
    }
    .navigation {
        heihgt: 70px;
        display: inline-block;
        float: left;
        width: 100%;
    }
     .left {
        margin-left: 10%;
        line-height: 71px;
    }
    a{
        font-size: 14px;
        color: #207bd6;
        cursor: pointer;
        text-decoration: none;
    }
    .header .headImg {
        float: left;
        width: 23px;
        /*height: 100%;*/
        margin-left: 30px;
        margin-top: 16px;
        margin-right: 15px;
    }

</style>
<link rel="stylesheet" type="text/css" href="/css/commonTheme/${sessionScope.InterfaceModel}/commonTheme.css"/>
<body style="background: #fff">

<div class="content">
    <div class="header">
        <div class="headImg">
            <img src="/img/commonTheme/${sessionScope.InterfaceModel}/icon_invenMainten.png" alt="">
        </div>
        <div class="title">
            <span class="big3" id="big4"><fmt:message  code="vote.th.InventoryMaintenance"/></span>
        </div>
    </div>
    <div class="main">
<table id="main_table"  style="margin-bottom: 50px;">
    <input type="hidden" id="transId">
    <form id="editApplyForm">
<tr>
    <td class="span_td"><fmt:message  code="vote.th.Registration"/>:<span style="color: #FF0000;margin-left: 10px;font-size: 16px;">*</span></td>
    <td class="span_td2">
        <select style="width: 270px; height: 30px;" id="transFlag" name="transFlag">
            <option value=""><fmt:message  code="hr.th.PleaseSelect"/></option>
            <option value="3"><fmt:message  code="vote.th.Purchasing"/></option>
            <option value="4"><fmt:message  code="vote.th.Maintain"/></option>
            <option value="5"><fmt:message  code="event.th.Scrap"/></option>
        </select>
    </td>
</tr>
    <tr>
        <td class="span_td"><fmt:message  code="vote.th.OfficeStorehouse"/>:<span style="color: #FF0000;margin-left: 10px;font-size: 16px;">*</span></td>
        <td class="span_td2"><select style="width: 270px; height: 30px;" id="depositoryId" name="depositoryId"><option value=""><fmt:message  code="hr.th.PleaseSelect"/></option></select></td>
    </tr>
    <tr>
        <td class="span_td"><fmt:message  code="vote.th.OfficeCategory"/>:<span style="color: #FF0000;margin-left: 10px;font-size: 16px;">*</span></td>
        <td class="span_td2"><select style="width: 270px; height: 30px;" id="officeProtype" name="typeId"><option value=""><fmt:message  code="hr.th.PleaseSelect"/></option></select></td>
    </tr>
    <tr>
        <td class="span_td"><fmt:message  code="vote.th.OfficeSupplies"/>:<span style="color: #FF0000;margin-left: 10px;font-size: 16px;">*</span></td>
        <td class="span_td2"><select style="width: 270px; height: 30px;" id="proId" name="proId"><option value=""><fmt:message  code="hr.th.PleaseSelect"/></option></select></td>
    </tr>
    <tr>
        <td class="span_td"><span style="margin-right: 15px;"><fmt:message code="office.Inventory"/>:</span></td>
        <td class="span_td2" id="proStock"></td>
    </tr>
    <tr>
        <td class="span_td span_td3" style="display: none"><span class="span_4" style="margin-right: 15px;"><fmt:message  code="vote.th.UnitPrice"/>:</span></td>
        <td class="span_td2 span_td3" style="display: none" ><input name="" class="span_input1" id="price" name="price" style="width: 270px; height: 30px;"></td>
    </tr>
        <tr>
            <td class="span_td span_td4" style="display: none"><span class="span_5" style="margin-right: 15px;"><fmt:message  code="event.th.MaintenanceDate"/>:</span></td>
            <td class="span_td2 span_td4" style="display: none" ><input name="num2" class="span_input2" id="transDate" name="transDate" onclick="laydate({istime: true, format: 'YYYY-MM-DD'})" id="num2" style="width: 270px; height: 30px;"></td>
        </tr>
    <tr>
        <td class="span_td"><span style="margin-right: 15px;"><fmt:message code="office.Registration"/>:</span></td>
        <td class="span_td2"><input name="transQty" id="transQty" style="width: 270px; height: 30px;"></td>
    </tr>


    <tr>
        <td class="span_td"><span style="margin-right: 15px;"><fmt:message  code="journal.th.Remarks"/>:</span></td>
        <td class="span_td2">
            <textarea id="remark" name="remark" style="min-width: 270px;min-height:78px;"></textarea>
        </td>
    </tr>
    </form>
    <tr>
        <td colspan="2">
        <button class="btn_ok"><fmt:message  code="main.th.confirm"/></button><button class="btn_reset" onclick="empty()" style="color: red"><fmt:message  code="global.lang.empty"/></button>
        </td>
    </tr>
</table>
        <div class="left"><span class="big3"><fmt:message code="vote.th.Today" /></span></div>
        <table class="tr_td tr_tds mainBottom" style="width: 80%;margin-bottom: 50px" align="center">
            <thead>
            <tr>
                <th class="th" style="color: #2F5C8F;" width="10%" align="center"><fmt:message code="vote.th.OfficeName" /></th>
                <th class="th" style="color: #2F5C8F;" width="10%" align="center"><fmt:message code="vote.th.Registration" /></th>
<%--                <th class="th" style="color: #2F5C8F;" width="15%" align="center"><fmt:message code="vote.th.Use-borrow-return" /></th>--%>
                <th class="th" style="color: #2F5C8F;" width="10%" align="center"><fmt:message code="event.th.Number" /></th>
                <th class="th" style="color: #2F5C8F;" width="10%" align="center"><fmt:message code="vote.th.CurrentStock" /></th>
                <th class="th" style="color: #2F5C8F;" width="10%" align="center"><fmt:message  code="vote.th.UnitPrice"/></th>
                <th class="th" style="color: #2F5C8F;" width="10%" align="center"><fmt:message code="vote.th.OperationDate" /></th>
                <th class="th" style="color: #2F5C8F;" width="10%" align="center"><fmt:message code="vote.th.Operator" /></th>
                <th class="th" style="color: #2F5C8F;" width="10%" align="center"><fmt:message code="menuSSetting.th.menuSetting" /></th><%--操作--%>
            </tr>
            </thead>
            <tbody>

            </tbody>
        </table>
    </div>
</div>
</body>
</html>

<script>
    var sign=0;
 $('#transFlag').on("change",function(){
    if($('#transFlag').val()==3){
      $('.span_4').text('<fmt:message  code="vote.th.UnitPrice"/>:');
      $('.span_input1').attr('disabled',"disabled");
      $('.span_td3').show();
    }else if($('#transFlag').val()==4){
        $('.span_td3').hide();
        $('.span_5').text('<fmt:message  code="event.th.MaintenanceDate"/>:');
        $('.span_td4').show();
        $("#price").val("0");
    }else{
        $('.span_td3').hide();
        $('.span_td4').hide();
        $("#price").val("0");
        $("#transDate").val();
    }
 })

 $("#depositoryId").on("change",function () {
     $.ajax({
         url:"/officetransHistory/getDownObjects",
         type:'post',
         dataType:'json',
         data:{
             typeDepository:$(this).val()
         },
         success:function (json) {
             var str='<option value=""><fmt:message  code="hr.th.PleaseSelect"/></option>';
             var data=json.obj;
             if(json.flag){
                 for(var i=0;i<data.length;i++){
                     str+='<option value="'+data[i].id+'">'+data[i].typeName+'</option>';
                     $('.span_td3').hide();
                 }
             }
             $("#officeProtype").html(str);
         }
     })
 })



 $("#officeProtype").on("change",function () {
     $.ajax({
         url:"/officetransHistory/getDownObjects",
         type:'post',
         dataType:'json',
         data:{
             officeProductType:$(this).val()
         },
         success:function (json) {
             var str='<option value=""><fmt:message  code="hr.th.PleaseSelect"/></option>';
             var data=json.obj;
             if(json.flag){
                 for(var i=0;i<data.length;i++){
                     str+='<option value="'+data[i].proId+'">'+data[i].proName+'('+data[i].proStock+')</option>';
                 }
             }
             $("#proId").html(str);
         }
     })
 })
 $("#proId").on("change",function () {
     $.ajax({
         url:"/officeSupplies/getOfficeProductById",
         type:'post',
         dataType:'json',
         data:{
             proId:$(this).val()
         },
         success:function (json) {
             var data=json.object;
             if(json.flag && data != undefined){
                $("#price").val(data.proPrice);
                if (data.proStock < data.proLowstock){
                    $("#proStock").html(data.proStock + ' ' + '<p style="display: inline-block; color: red;"><fmt:message code="office.lower"/>：'+ data.proLowstock +'</p>');
                } else if (data.proStock > data.proMaxstock){
                    $("#proStock").html(data.proStock + ' ' + '<p style="display: inline-block; color: red;"><fmt:message code="office.upper"/>：'+ data.proMaxstock +'</p>');
                } else {
                    $("#proStock").html(data.proStock);
                }
             } else {
                 $("#proStock").html('');
             }
         }
     })
 })
    $(function () {
        $.ajax({
            url:"/officeDepository/getDeposttoryByDept",
            type:'post',
            dataType:'json',
            success:function (json) {
                var str='<option value=""><fmt:message  code="hr.th.PleaseSelect"/></option>';
                var data=json.obj;
                if(json.flag){
                    for(var i=0;i<data.length;i++){
                        str+='<option value="'+data[i].id+'">'+data[i].depositoryName+'</option>';
                    }
                }
                $("#depositoryId").html(str);
            }
        })
        init();
    })

 $(".btn_ok").on("click",function () {
     if(sign==1){
         if(checkForm()){
             $('#editApplyForm').ajaxSubmit({/*添加时，保存按钮*/
                 url:'/officetransHistory/editObject',
                 type:'post',
                 dataType:'json',
                 data:{
                     flag:3,
                     transId:$('#transId').val()
                 },
                 success:function (json) {
                     if(json.flag) {
                         $.layerMsg({content: '<fmt:message  code="depatement.th.Modifysuccessfully"/>！', icon: 1}, function () {
                             empty();
                             init();
                         });
                     }else{
                         $.layerMsg({content: json.msg+'！', icon: 1}, function () {
                         });
                     }
                 }
             })
         }

     }else{
         if(checkForm()){
             $('#editApplyForm').ajaxSubmit({/*添加时，保存按钮*/
                 url:"/officetransHistory/insertObject",
                 type:'post',
                 dataType:'json',
                 data:{
                     flag:3
                 },
                 success:function (json) {
                     if(json.flag) {
                         $.layerMsg({content: '<fmt:message  code="diary.th.modify"/>！', icon: 1}, function () {
                             empty();
                             init();
                         });
                     }else{
                         if(json.msg=='numNoEnough'){
                             $.layerMsg({content: '<fmt:message  code="vote.th.LackInventory"/>！', icon: 1}, function () {
                             });
                         }else if(json.msg=='numMax'){
                             $.layerMsg({content: '<fmt:message  code="vote.th.LargerInventory"/>！', icon: 2}, function () {
                             });
                         }
                     }
                 }
             })
         }

     }
 })
    function checkForm(){
        if($('#proName').val()==''){
            $.layerMsg({content:"<fmt:message  code="vote.th.Officelies"/>", icon: 2});
            return false;
        }
        if($('#transFlag option:selected').text()=='<fmt:message  code="hr.th.PleaseSelect"/>'){
            $.layerMsg({content:"<fmt:message  code="vote.th.Registrations"/>", icon: 2});
            return false;
        }
        if($('#depositoryId option:selected').text()=='<fmt:message  code="hr.th.PleaseSelect"/>'){
            $.layerMsg({content:"<fmt:message  code="vote.th.Library"/>", icon: 2});
            return false;
        }
        if($('#officeProtype option:selected').text()=='<fmt:message  code="hr.th.PleaseSelect"/>'){
            $.layerMsg({content:"<fmt:message  code="vote.th.ChooseType"/>", icon: 2});
            return false;
        }
        if($('#proId option:selected').text()=='<fmt:message  code="hr.th.PleaseSelect"/>'){
            $.layerMsg({content:"<fmt:message  code="vote.th.ChooseSupplies"/>", icon: 2});
            return false;
        }

        return true;
    }
 function empty() {
     $("#transFlag").val("");
     $("#depositoryId").val("");
     $("#officeProtype").val("");
     $("#proId").val("");
     $("#price").val("");
     $("#transDate").val("");
     $("#transQty").val("");
     $("#remark").val("");
 }

 function init(){
     $.ajax({
         url: '/officetransHistory/selMaintain',
         type: 'get',
         dataType: 'json',
         success: function (result) {
             var str="";
             var arr =result.obj;
             for(var i=0;i<arr.length;i++){
                 str+='<tr>'+
                     '<td style="text-align: center">'+arr[i].proName+'</td>';
                 if(arr[i].transFlag==3){
                     str+='<td style="text-align: center"><fmt:message  code="vote.th.Purchasing"/></td>' ;
                 }else if(arr[i].transFlag==4){
                     str+='<td style="text-align: center"><fmt:message  code="vote.th.Maintain"/></td>' ;
                 }else if(arr[i].transFlag==5){
                     str+='<td style="text-align: center"><fmt:message  code="event.th.Scrap"/></td>' ;
                 }else{
                     str+='<td style="text-align: center"></td>' ;
                 }
                    str+= '<td style="text-align: center">'+arr[i].borrowerName+'</td>'+
                     '<td style="text-align: center">'+arr[i].transQty+'</td>'+
                     '<td style="text-align: center">'+arr[i].proStock+'</td>'+
                     '<td style="text-align: center">'+arr[i].price+'</td>'+
                     '<td style="text-align: center">'+arr[i].transDate+'</td>'+
                     '<td style="text-align: center">'+arr[i].operatorName+'</td>'+
                     '<td style="text-align: center">';

                    if(arr[i].transFlag==3 || arr[i].transFlag==5){
                        str+= ' <a href="#big4" class="details" onclick="edit_1('+arr[i].transId+');">'+"<fmt:message  code="depatement.th.modify"/>"+'</a>';
                    }
                    str+= ' <a href="javascript:;" class="details" onclick="delete_1('+arr[i].transId+');" style="color: red">'+"<fmt:message  code="vote.th.abortOperation"/>"+'</a>'+
                     '</td>'+
                     '</tr>';
             }
             $('.mainBottom tbody').html(str);
         }
     })
 }

 function edit_1(e){
     $.ajax({
         type:'post',
         url:'/officetransHistory/getObjectById',
         dataType:'json',
         data:{'transId':e},
         success:function(res){
             var data =res.object;
             $('#transId').val(data.transId);
          $('#transFlag').val(data.transFlag);
             $('#transFlag').attr('disabled',"disabled");
             $.ajax({
                 url:"/officeDepository/getDeposttoryByDept",
                 type:'post',
                 dataType:'json',
                 success:function (json) {
                     var str='<option value=""><fmt:message  code="hr.th.PleaseSelect"/></option>';
                     var data1=json.obj;
                     if(json.flag){
                         for(var i=0;i<data1.length;i++){
                             str+='<option value="'+data1[i].id+'">'+data1[i].depositoryName+'</option>';
                         }
                     }
                     $("#depositoryId").html(str);
                     $('#depositoryId').val(data.depositoryId);
                     $('#depositoryId').attr('disabled',"disabled");
                 }
             })

             $.ajax({
                 url:"/officetransHistory/getDownObjects",
                 type:'post',
                 dataType:'json',
                 data:{
                     typeDepository:data.depositoryId
                 },
                 success:function (json) {
                     var str='<option value=""><fmt:message  code="hr.th.PleaseSelect"/></option>';
                     var data2=json.obj;
                     if(json.flag){
                         for(var i=0;i<data2.length;i++){
                             str+='<option value="'+data2[i].id+'">'+data2[i].typeName+'</option>';
                         }
                     }
                     $("#officeProtype").html(str);
                     $('#officeProtype').val(data.typeId);
                     $('#officeProtype').attr('disabled',"disabled");
                 }
             })
             $.ajax({
                 url:"/officetransHistory/getDownObjects",
                 type:'post',
                 dataType:'json',
                 data:{
                     officeProductType:data.typeId
                 },
                 success:function (json) {
                     var str='<option value=""><fmt:message  code="hr.th.PleaseSelect"/></option>';
                     var data3=json.obj;
                     if(json.flag){
                         for(var i=0;i<data3.length;i++){
                             str+='<option value="'+data3[i].proId+'">'+data3[i].proName+'</option>';
                         }
                     }
                     $("#proId").html(str);
                     $('#proId').val(data.proId);
                     $('#proId').attr('disabled',"disabled");
                 }
             })
             $('.span_td3').show();
             $('#price').val(data.price);
             $('#price').attr('disabled',"disabled");
             $('#transQty').val(data.transQty);
             $('#remark').val(data.remark);
             var pardata={
                 transFlag: $('#transFlag').val(),
                 depositoryId:$('#depositoryId').val(),
                 officeProtype:$('#officeProtype').val(),
                 proId:$('#proId').val(),
                 price:$('#price').val(),
                 transQty:$('#transQty').val(),
                 remark:$('#remark').val(),
                 transId:data.transId
             }
             sign=1;
         }
     })
 }
 function delete_1(e){
     layer.confirm('<fmt:message  code="vote.th.Operation"/>？', {
         btn: ['<fmt:message code="global.lang.ok" />','<fmt:message code="depatement.th.quxiao" />'], //按钮
         title:"<fmt:message  code="vote.th.abortOperation"/>",
         offset: '100px'
     }, function(){
         //确定删除，调接口
         $.ajax({
             type:'post',
             url:'/officetransHistory/deleteObject',
             dataType:'json',
             data:{'transId':e},
             success:function(){
                 layer.msg('<fmt:message  code="user.th.SuccessfulOperation"/>', { icon:6});
                window.location.href='/officetransHistory/goFixDepository';
             }
         })
     }, function(){
         layer.closeAll();
     });
 }

</script>
