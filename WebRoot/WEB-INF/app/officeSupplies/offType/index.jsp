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
    <title><fmt:message code="vote.th.Classification" /></title>

    <style>
        .news{
            cursor: pointer;
        }
        .div_tr input {
            float: none;
            height: 28px;
            border-width: 1px;
            border-style: solid;
            border-color: rgb(153, 153, 153);
            border-image: initial;
        }
        .span_td{
            display: inline-block;
            width: 120px;
            text-align: right;
        }
        .inputlayout>ul ul>li.active {
            background: #4898d5;
            color: #fff;
        }
        .inPole{
            display: inline-block;
        }
        .Return{
            background: #4d90fe;
            margin-right: 40px;
            padding:5px 10px;
            margin-top: 5px;
            border-radius: 4px;
            color: #fff;
            cursor: pointer;
            float: right;
        }
        .ADD{
            float: right;
            background: #4d90fe;
            margin-top: 5px;
            margin-right: 40px;
            padding:5px 10px;
            border-radius: 4px;
            color: #fff;
            cursor: pointer;
        }
        .deleteok{
            width: 109px;
            height:24px;
            background: url(../../img/btn_deleteannounce.png) 0px 0px no-repeat;
        }
        .delete_check {
            text-align: center;
            cursor: pointer;
        }

        .ADD{
            border-radius: 6px;
            padding: 5px 15px;
            background-color: #2b7fe0!important;
        }
        .Return{
            padding: 5px 32px;
            background-color: #2b7fe0!important;
        }
    </style>
    <link rel="stylesheet" href="../../lib/layui/layui/css/layui.css?20210319.1">
    <link rel="stylesheet" href="/css/office/depository/index.css">
    <script type="text/javascript" src="../js/xoajq/xoajq1.js"></script>
    <script src="/lib/layer/layer.js?20201106"></script>
    <script src="/js/base/base.js"></script>
    <style>
        .maintop p {
            line-height: 35px;
        }
    </style>
</head>
<body style="background: #fff">
<div class="maintop clearfix" style="margin-top: 4px;border-bottom: #999 1px solid;" >
    <p style="margin-left: 10px">
        <label><fmt:message code="vote.th.Classificationlist" /></label>
    </p>
    <button  type="button" class="ADD"><fmt:message code="vote.th.ClassificationNew" /></button>
    <button  type="button" class="Return"><fmt:message code="notice.th.return" /></button>
</div>



<div class="mainBottom" id="mainBottom" style="margin-top: 10px;">
    <table>
        <thead>
        <tr>
            <th class="th" style="color: #2F5C8F;width:8%;" align="center"><fmt:message code="workflow.th.Serial" /></th>
            <th class="th" style="color: #2F5C8F;" width="10%" align="center"><fmt:message code="vote.th.ClassificationOffice" /></th>
            <th class="th" style="color: #2F5C8F;" width="10%" align="center"><fmt:message code="vote.th.SubordinateLibrary" /></th>
            <th class="th" style="color: #2F5C8F;" width="10%" align="center"><fmt:message code="vote.th.SortNumber" /></th>
            <th class="th" style="color: #2F5C8F;" width="20%" align="center"><fmt:message code="menuSSetting.th.menuSetting" /></th><%--操作--%>
        </tr>
        </thead>
        <tbody id="j_tb">
        </tbody >
    </table>
</div>
</body>
<script>
    var typeDepository=${typeDepository};
    $(function(){
        init(typeDepository);
    })
    function init(typeDepository){
        $.ajax({
            url: '/officeSupplies/selectAllOffType',
            type: 'get',
            dataType: 'json',
            data:{
                typeDepository:typeDepository
            },
            success: function (result) {
                var str="";
                var arr =result.obj;
                for(var i=0;i<arr.length;i++){
                    str+='<tr>'+
                        '<td>'+(i+1)+'</td>'+
                        '<td>'+arr[i].typeName+'</td>'+
                        '<td>'+arr[i].typeDepositoryName+'</td>'+
                        '<td>'+arr[i].typeOrder+'</td>'+
                        '<td>'+
                        ' <a href="javascript:;" class="details" onclick="edit('+arr[i].id+');">'+"<fmt:message code="global.lang.edit" />"+'</a>&nbsp'+
                        ' <a href="javascript:;" class="details" onclick="deleteone('+arr[i].id+');">'+"<fmt:message code="global.lang.delete" />"+'</a>&nbsp'+
                        '</td>'+
                        '</tr>';
                }
                $('.mainBottom table tbody').html(str);
            }
        })
    }


    function deleteone(e){
        layer.confirm('<fmt:message code="sup.th.Delete1" />？', {
            btn: ['<fmt:message code="global.lang.ok" />','<fmt:message code="depatement.th.quxiao" />'], //按钮
            title:"<fmt:message code="vote.th.DeletingSupplies" />",
            offset: ['100px', '300px']
        }, function(){
            //确定删除，调接口
            $.ajax({
                type:'post',
                url:'/officeSupplies/deleteOfficeTypeById',
                dataType:'json',
                data:{'id':e},
                success:function(res){
                    if(res.flag){
                        layer.msg('<fmt:message code="workflow.th.delsucess" />', { icon:6});
                        init(typeDepository);

                    }else{
                        layer.msg('<fmt:message code="lang.th.deleSucess" />', { icon:2});
                        init(typeDepository);
                    }

                }
            })
        }, function(){
            layer.closeAll();
        });
    }

    function edit(e){
        layer.open({
            type: 1,
            title: ['<fmt:message code="vote.th.editorsSupplies" />', 'background-color:#2b7fe0;color:#fff;'],
            area: ['450px', '250px'],
            offset: ['80px', '300px'],
            shadeClose: true, //点击遮罩关闭
            btn: ['<fmt:message code="global.lang.save" />', '<fmt:message code="global.lang.close" />'],
            content: '<div class="div_table" style="height: 100px;width: 250px; margin-top: 20px; margin-left: 10px;">'+
            '<input type="hidden" id="id">'+
            '<input type="hidden" id="typeDepository">'+
            '<div class="div_tr" style="width:400px;margin:10px;line-height: 18px; ">'+'<span class="span_td" ><fmt:message code="vote.th.SubordinateLibrary" />：</span><span style="color: #FF0000;font-size: 13px; margin-left:16px">*</span><span><input type="text" disabled="disabled" style="width: 220px;" id="typeDepositoryName" name="typeDepositoryName"  value="" /></span></div>' +
            '<div class="div_tr" style="width:400px;margin:10px;line-height: 18px; ">'+'<span class="span_td"><fmt:message code="vote.th.SortNumber" />：</span><span style="margin-left: 8px;margin-left:22px"><input type="text" style="width: 220px;" id="typeOrder" name="typeOrder"  value="" /></span></div>' +
            '<div class="div_tr" style="width:400px;margin:10px;line-height: 18px; ">'+'<span class="span_td"><fmt:message code="vote.th.goodsClass" />：</span><span style="color: #FF0000;font-size: 13px;margin-left:16px">*</span><span><input type="text" style="width: 220px;" id="typeName" name="typeName"  value="" /></span></div>' +
            '</div>',
            success:function(){
                $.ajax({
                    type: 'get',
                    url: '/officeSupplies/getOfficeTypeById',
                    data: {id: e},
                    dataType: 'json',
                    success: function (res) {
                        var datas = res.object;
                        $('#id').val(datas.id);
                        $('#typeDepository').val(datas.typeDepository);
                        $('#typeDepositoryName').val(datas.typeDepositoryName);
                        $('#typeOrder').val(datas.typeOrder);
                        $('#typeName').val(datas.typeName);
                    }
                })
            },
            yes: function (index) {
                var data = {
                    id:$('#id').val(),
                    typeDepository:$('#typeDepository').val(),
                    typeOrder:$('#typeOrder').val(),
                    typeName:$('#typeName').val()

                }
                if(checkForm()){
                    editClassification(data);
                    layer.close(index);
                }
            },
        });
    }




    $('.Return').click(function(){
        window.location.href='/officeDepository/goDepositoryindex';
    })
    $('.ADD').click(function(){
        layer.open({
            type: 1,
            title: ['<fmt:message code="vote.th.ClassificationNew" />', 'background-color:#2b7fe0;color:#fff;'],
            area: ['450px', '250px'],
            offset: ['80px', '300px'],
            shadeClose: true, //点击遮罩关闭
            btn: ['<fmt:message code="global.lang.save" />', '<fmt:message code="global.lang.close" />'],
            content: '<div class="div_table" style="height: 100px;width: 250px; margin-top: 20px; margin-left: 10px;">'+
            '<div class="div_tr" style="width:400px;margin:10px;line-height: 18px; ">'+'<span class="span_td"><fmt:message code="vote.th.SubordinateLibrary" />：</span><span style="color: #FF0000;font-size: 16px;">*</span><span><input type="text" disabled="disabled" style="width: 220px;" id="typeDepository" name="typeDepository"  value="" /></span></div>' +
            '<div class="div_tr" style="width:400px;margin:10px;line-height: 18px; ">'+'<span class="span_td"><fmt:message code="vote.th.SortNumber" />：</span><span style="margin-left: 8px;"><input type="text" style="width: 220px;" id="typeOrder" name="typeOrder"  value="" /></span></div>' +
            '<div class="div_tr" style="width:400px;margin:10px;line-height: 18px; ">'+'<span class="span_td"><fmt:message code="vote.th.goodsClass" />：</span><span style="color: #FF0000;font-size: 16px;">*</span><span><input type="text" style="width: 220px;" id="typeName" name="typeName"  value="" /></span></div>' +
            '</div>',
            yes: function (index) {
                var data = {
                    typeDepository: typeDepository,
                    typeOrder:$('#typeOrder').val(),
                    typeName: $('#typeName').val()

                }
                if(checkForm()){
                    newClassification(data);
                    layer.close(index);
                }
            },
            success:function(){
                $.ajax({
                    type:'post',
                    url:'/officeDepository/getDepositoryNameById',
                    dataType:'json',
                    data:{'id':typeDepository},
                    success:function(res){
                        var datas=res.object;
                        $('#typeDepository').val(datas.depositoryName);
                    }
                })
            }
        });
    })
    function checkForm() {
        if ($('#typeName').val() == "") {
            layer.msg('<fmt:message code="vote.th.FillCategory" />', {icon: 2});
            return false;
        }
        return true;
    }
    function newClassification(data){
        $.ajax({
            type:'post',
            url:'/officeSupplies/addOffType',
            dataType:'json',
            data:data,
            success:function(res){
                init(typeDepository);
                if(res.flag){
                    $.layerMsg({content:'<fmt:message code="url.th.addSuccess" />！',icon:1});
                }else{
                    $.layerMsg({content:'<fmt:message code="hr.th.AddFailed" />！',icon:2});
                }
            }
        })
    }
    function editClassification(data){
        $.ajax({
            type:'post',
            url:'/officeSupplies/editOfficeType',
            dataType:'json',
            data:data,
            success:function(res){
                init(typeDepository);
                if(res.flag){
                    $.layerMsg({content:'<fmt:message code="vote.th.UpdateSuccess" />！',icon:1});
                }else{
                    $.layerMsg({content:'<fmt:message code="vote.th.UpdateFailure" />！',icon:2});
                }
            }
        })
    }

</script>
</html>
