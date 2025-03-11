<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@taglib prefix="mvc" uri="http://www.springframework.org/tags/form" %>
<%@taglib prefix="fmt" uri="http://www.springframework.org/tags" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<html>
<head>
    <title>重点工作流程号设置</title>
    <meta charset="utf-8"/>
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <link rel="stylesheet" type="text/css" href="/css/base.css"/>
    <script src="/js/xoajq/xoajq1.js" type="text/javascript" charset="utf-8"></script>
    <script src="/lib/layer/layer.js?20201106"></script>
</head>
<style>
    .btn{
        text-align: center;
    }
    .btn_ {
        width:100px;
        height: 40px;
        padding-left: 10px;
        margin-top:25px;
        font-size: 14px;
        cursor: pointer;
        background: url(/img/save.png) no-repeat;
    }
    .table{
        width:60%;
        margin:20px auto;
    }
    td{
        width:50%;
    }
    table,tr,td,th{
        border:1px solid #eee;
        border-collapse: collapse;
    }
    .th{
        height: 50px;
        line-height: 50px;
        text-align: center;
        border: 1px solid #eee;
        color: #2F5C8F;
        background: #ddd;
    }
    input{
        width:80%;
    }
    .left{
        width:40%;
    }
    .right{
        width:60%;
    }
</style>
<body>
<table class="table">
    <tr class="th">
        <th colspan="2" >重点工作公式设置</th>
    </tr>
    <tr>
        <td class="left">请设置重点工作子流程号:</td>
        <td class="right"><input type="number" id="num1"></td>
    </tr>
    <tr>
        <td class="left">请设置重点工作父流程流程号:</td>
        <td class="right"><input type="number" id="num2"></td>
    </tr>
    <%--<tr>--%>
        <%--<td class="left">请设置重点工作子流程流程号:</td>--%>
        <%--<td class="right"><input type="number" id="num3"></td>--%>
    <%--</tr>--%>

</table>
<div class="btn"><button id="saveBtn"  class="btn_">保存</button></div>

</body>
<script>
    //初始化
    init();
    function init(){
        $.ajax({
            url:"/FlowPara/selectFlowPara",
            dataType:"json",
            type:"get",
            success:function(res){
                if(res.flag){
                    var obj=res.obj;
                    if(obj!=undefined&&obj.length>0){
                        for(var i=0;i<obj.length;i++){
                            var para=obj[i];
                            if(para.paraName=="FLOW_ID_F"){
                                $("#num1").val(para.paraValue);
                            }
                            if(para.paraName=="FLOW_ID_S"){
                                $("#num2").val(para.paraValue);
                            }
                        }
                    }
               /* var arr1 =  res.obj.filter(function(item){
                    return item.paraName=="FLOW_ID_Q";
                })
                $("#num1").val(arr1[0].paraValue);
                var arr2 =  res.obj.filter(function(item){
                    return item.paraName=="FLOW_ID_F";
                })
                $("#num2").val(arr2[0].paraValue);
                var arr3 =  res.obj.filter(function(item){
                    return item.paraName=="FLOW_ID_S";
                })

//                $("#num3").val(arr3[0].paraValue);
                    sava()
*/
                }
            }
        })
    }
    //点击保存
    function sava(){
        $("#saveBtn").click(function(){
            var num1 = $("#num1").val();
            var num2 = $("#num2").val();
            var arr={flowIdS:num1,flowIdF:num2}
            $.ajax({
                url:"/FlowPara/settingFlowId",
                type:"post",
                dataType:"json",
                data:arr,
                success:function(res){
                    if(res.flag){
                        layer.msg('保存成功！', {icon: 1});
                    }else{
                        layer.msg('保存失败！', {icon: 2});
                    }

                }
            })

        })
    }


</script>
</html>