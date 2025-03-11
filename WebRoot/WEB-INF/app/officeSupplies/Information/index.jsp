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
    <title><fmt:message code="work.th.workList" /></title>

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
            width: 150px;
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
            background: #00a0e9;
            margin-right: 40px;
            padding:5px 10px;
            margin-top: 10px;
            border-radius: 4px;
            color: #fff;
            cursor: pointer;
            float: right;
        }
        .ADD{
            float: right;
            background: #00a0e9;
            margin-top: 10px;
            margin-right: 20px;
            padding:5px 10px;
            border-radius: 4px;
            color: #fff;
            cursor: pointer;
        }
        .deleteok{
            padding-left: 20px;
            line-height: 24px;
            color: #666;
            margin-left: 12px;
            display: inline-block;
            width: 56px;
            height: 24px;
            background: url(../../img/file/cabinet12.png) 0px 0px no-repeat;
        }
        .delete_check {
            text-align: center;
            cursor: pointer;
        }

    </style>
    <link rel="stylesheet" href="../../lib/layui/layui/css/layui.css?20210319.1">
    <link rel="stylesheet" href="/css/office/depository/index.css">
    <script type="text/javascript" src="../js/xoajq/xoajq1.js"></script>
    <script src="/lib/layer/layer.js?20201106"></script>
    <script src="/js/base/base.js"></script>
</head>
<body style="background: #fff">
<div class="maintop clearfix" >
    <p style="margin-left: 10px">
        <label><fmt:message code="work.th.workList" /></label>
    </p>
    <button  type="button" class="Return"><fmt:message code="notice.th.return" /></button>
    <button  type="button" class="ADD" onclick="newObject();"><fmt:message code="vote.th.New" /></button>
</div>



<div class="mainBottom" id="mainBottom" style="margin-top: 10px;">
    <table>
        <thead>
        <tr>
            <th class="th" style="color: #2F5C8F;width:8%;" align="center"><fmt:message code="global.lang.select" /></th>
            <th class="th" style="color: #2F5C8F;" width="15%" align="center"><fmt:message code="vote.th.OfficeName" /></th>
            <th class="th" style="color: #2F5C8F;" width="15%" align="center"><fmt:message code="vote.th.OfficeCategory" /></th>
            <th class="th" style="color: #2F5C8F;" width="10%" align="center"><fmt:message code="vote.th.Measurement" /></th>
            <th class="th" style="color: #2F5C8F;" width="10%" align="center"><fmt:message code="vote.th.Supplier" /></th>
            <th class="th" style="color: #2F5C8F;" width="10%" align="center"><fmt:message code="vote.th.VigilanceInventory" /></th>
            <th class="th" style="color: #2F5C8F;" width="10%" align="center"><fmt:message code="vote.th.CurrentStock" /></th>
            <th class="th" style="color: #2F5C8F;" width="15%" align="center"><fmt:message code="file.th.builder" /></th>
            <th class="th" style="color: #2F5C8F;" width="10%" align="center"><fmt:message code="menuSSetting.th.menuSetting" /></th><%--操作--%>
        </tr>
        </thead>
        <tbody id="j_tb">
        </tbody >
    </table>
</div>
</body>
<script>
    var typeId=${typeId};
    var user_id="";
    var dept_id="";
    var priv_id="";

    $(function(){
     init(typeId);
    })
    function init(typeId){
        $.ajax({
            url: '/officeSupplies/selProductByType',
            type: 'get',
            dataType: 'json',
            data:{
                typeId:typeId
            },
            success: function (result) {
                var str="";
                var arr =result.obj;
                for(var i=0;i<arr.length;i++){
                    var proStockStr = "";
                    if(arr[i].proStock < arr[i].proLowstock){
                        proStockStr = '<td>'+arr[i].proStock+'<p style="display: inline-block; color: red;">（低于警戒）</p></td>';
                    } else if (arr[i].proStock > arr[i].proMaxstock) {
                        proStockStr = '<td>'+arr[i].proStock+'<p style="display: inline-block; color: red;">（高于警戒）</p></td>';
                    } else {
                        proStockStr = '<td>'+arr[i].proStock+'</td>';
                    }
                    str+='<tr>'+
                        "<td style='width:8%;'align='center';><input class='checkChild'  type='checkbox' conid='" + arr[i].proId + "' name='check' value=''></td>"+
                        '<td>'+arr[i].proName+'</td>'+
                        '<td>'+arr[i].officeProtypeName+'</td>'+
                        '<td>'+arr[i].proUnit+'</td>'+
                        '<td>'+arr[i].proSupplier+'</td>'+
                        '<td>'+arr[i].proLowstock+'</td>'+
                        proStockStr+
                        '<td>'+arr[i].proCreatorName+'</td>'+
                        '<td>'+
                        ' <a href="javascript:;" class="details" onclick="edit('+arr[i].proId+');">'+"<fmt:message  code="global.lang.edit"/>"+'</a>&nbsp'+
                        '</td>'+
                        '</tr>';
                }
                <%--var last_str = "<tr class='last_str'><td colspan='2'><input id='checkedAll' style='margin-left: -47%;' class='checkChild' type='checkbox' conid='' name='check' value=''><fmt:message code="notice.th.allchose" /></td><td class='btnStyle delete_check'><div class='deleteok'><span class='delete_ok1'><fmt:message code="global.lang.delete" /></span></div></td><td class=''></td><td></td><td></td><td></td><td></td><td></td></tr>";--%>
                var last_str="<tr><td colspan='9' style='text-align: left;'><input type='checkbox' style='margin-left: 20px;' id='checkedAll' class='checkChild' conid='' name='check' value=''><span><fmt:message code="notice.th.allchose" /></span><a href='javascript:;' class='deleteok'><fmt:message code="global.lang.delete" /></a></td></tr>"
                $('.mainBottom table tbody').html(str+last_str);
            }
        })
    }
    function deleteone(e){
        layer.confirm('<fmt:message code="sup.th.Delete" />？', {
            btn: ['<fmt:message code="global.lang.ok" />','<fmt:message code="depatement.th.quxiao" />'], //按钮
            title:"<fmt:message  code="vote.th.DeleteSupplies"/>"
        }, function(){
            //确定删除，调接口
            $.ajax({
                type:'post',
                url:'/officeDepository/deleteOfficeProducts',
                dataType:'json',
                data:{'proIds':e},
                success:function(res){
                    if(res.flag){
                        layer.msg('<fmt:message code="workflow.th.delsucess" />', { icon:6});
                        init(typeId);

                    }else{
                        layer.msg('<fmt:message  code="lang.th.deleSucess"/>', { icon:2});
                        init(typeId);
                    }

                }
            })
        }, function(){
            layer.closeAll();
        });
    }

    function edit(e){
        window.location.href='/officeSupplies/newProduct?editFlag=1&proId='+e;
    }

    //点击复选框
    $("#mainBottom").on('click', '#notice_tr', function () {
        /*    alert('111');*/
        var state = $(this).find('.checkChild').prop("checked");
        if (state == true) {
            $(this).find('.checkChild').prop("checked", true);
            $(this).addClass('bgcolor');
        } else {
            $('#checkedAll').prop("checked", false);
            $(this).find('.checkChild').prop("checked", false);
            $(this).removeClass('bgcolor');
        }
        var child = $(".checkChild");
        for (var i = 0; i < child.length; i++) {
            var childstate = $(child[i]).prop("checked");
            if (state != childstate) {
                return
            }
        }
        $('#notice_tr').prop("checked", state);
    })

    $('.Return').click(function(){
        window.history.go(-1);
    });


    //点击全选
    $('#j_tb').on('click', '#checkedAll', function () {
        /*alert('111');*/
        var state = $(this).prop("checked");
        if (state == true) {
            $(this).prop("checked", true);
            $(".checkChild").prop("checked", true);
            $(this).parents('tr').siblings('#notice_tr').addClass('bgcolor');
        } else {
            $(this).prop("checked", false);
            $(".checkChild").prop("checked", false);
            ;
            $(this).parents('tr').siblings('#notice_tr').removeClass('bgcolor');
        }
    })


    //点击删除选中按钮
    $('#j_tb').on('click', '.deleteok', function () {
        /* alert('111');*/
        var fileId = "";
        $("#j_tb .checkChild:checkbox:checked").each(function () {

            var conId = $(this).attr("conId");
            fileId += conId + ",";

        })
        if (fileId == '') {
            $.layerMsg({content: '<fmt:message  code="meet.th.PleaseDelete"/>', icon: 0});
        } else {
            layer.confirm('<fmt:message  code="global.lang.sure"/>', {
                btn: [' <fmt:message  code="global.lang.ok"/>', ' <fmt:message  code="depatement.th.quxiao"/>'], //按钮
                title: "<fmt:message  code="vote.th.DeleteSupplies"/>"
            }, function () {
                //确定删除，调接口
                $.ajax({
                    type: 'post',
                    url: '/officeSupplies/deleteOfficeProducts',
                    dataType: 'json',
                    data: {'proIds': fileId},
                    success: function () {
                        layer.msg(' <fmt:message  code="workflow.th.delsucess"/>', {icon: 6});
                        init(typeId);
                    }
                })
            }, function () {
                layer.closeAll();
            });
        }
    })
    function newObject(){
        debugger;
        var url=document.URL;
        console.log('url');
      window.location.href='/officeSupplies/newProduct?editFlag=0&proId=0';
    }

</script>
</html>
