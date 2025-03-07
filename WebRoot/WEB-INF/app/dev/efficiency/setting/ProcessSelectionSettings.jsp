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
    <title>流程选择设置</title>
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport" content="width=device-width, initial-scale=0.3, user-scalable=0, minimum-scale=0, maximum-scale=5.0,user-scalable=yes">
    <link rel="stylesheet" type="text/css" href="../css/base.css" />
    <script src="/js/xoajq/xoajq1.js" type="text/javascript" charset="utf-8"></script>
    <script src="/lib/layer/layer.js?20201106"></script>
</head>
<style>
    body{
        font-size: 14px;

    }
    .content{
        padding: 20px 5%;
        overflow: hidden;
    }
    .fl{
        width:40%;
        margin-right:5%;
        margin-bottom:20px;
        box-sizing: border-box;;
        border:1px solid #eee;
        float: left;
        overflow: auto;

    }
    input{
        margin-right:20px;
    }
    .head{
        border-bottom:1px solid #eee;
        height:50px;
        line-height: 50px;
        background: #ddd;
    }
    .img,.h2{
        float:left;
        margin-left: 20px;

    }
    .img{
        margin-top:20px;
    }
    .ul{
        padding:20px;
    }
    .top{
        height:80px;
        line-height: 80px;
        margin-left: 30px;
    }
    .tit{
        margin-left: 5px;
        font-family: Microsoft yahei,Helvetica Neue,Helvetica,PingFang SC,Tahoma,Arial,sans-serif;
        margin-top: -3px;
        margin-right: 80px;
        font-size: 17pt;
        color: #494d59;
    }
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
        margin-bottom:50px;
    }
    .cl{
        clear:both;
    }
</style>
<body>
<div class="top"><h2 class="tit">工作流程设置</h2></div>
<div class="content">

</div>
<div class="cl"></div>

</body>
<script>
    //获取所有流程

    init();
function init(){
    //查询初始化
    $.ajax({
        url:"/FlowPara/selectFlowPara",
        dataType:"json",
        type:"get",
        success:function(res1){
            if(res1.flag){
                var arr = res1.obj.filter(function(item){
                    return item.paraName=="FLOW_SELECT_ID"
                })
                var arrValue = arr[0].paraValue.split(",");
                $.ajax({
                    url:"/flowSort/getFlowTypes",
                    type:"get",
                    dataType:"json",
                    beforeSend: function(){
                        layer.load(0, {shade: false});
                    },
                    success:function(res){
                        layer.closeAll();
                        var str="";
                        if(res.flag){
                            for(var i=0;i<res.obj.length;i++){
                                $(".content").append("<div class='fl' id='sort"+i+"'><div class='head'><img class='img' src='/img/main_img/theme6/up.png'/><h2 class='h2'>"+res.obj[i].sortName+"</h2></div><ul class='ul' id='flow"+i+"' class='ul'></ul></div>");
                                if(res.obj[i].flowTypeModels.length>0){
                                    var str1="";
                                    for (var j = 0; j < res.obj[i].flowTypeModels.length;j++){
                                        if(arrValue.indexOf(String(res.obj[i].flowTypeModels[j].flowId))==-1){

                                            str1+="<li><input type='checkbox' value='"+ res.obj[i].flowTypeModels[j].flowId+"' id='flow"+i+j+"'><label for='flow"+i+j+"'>"+res.obj[i].flowTypeModels[j].flowName+"</label></li>"
                                        }else{
                                            str1+="<li><input type='checkbox' checked value='"+ res.obj[i].flowTypeModels[j].flowId+"' id='flow"+i+j+"'><label for='flow"+i+j+"'>"+res.obj[i].flowTypeModels[j].flowName+"</label></li>"
                                        }

                                    }
                                    $("#flow"+i).html(str1)
                                }

                            }
                            $("body").append('<div class="btn"><button id="saveBtn"  class="btn_">保存</button></div>')

                        }

                    }
                })


            }
        }
    })

}

//点击标题折叠收起
    $(".content").on("click",".fl .head",function(){
        $(this).siblings(".ul").toggle();
        if($(this).siblings(".ul").css("display")=="block"){
            $(this).children("img").attr("src","/img/main_img/theme6/up.png")
        }else{
            $(this).children("img").attr("src","/img/main_img/theme6/down.png")
        }

    })
    //点击保存
    $("body").on("click","#saveBtn",function(){
        var id_array=new Array();
        $('input[type=checkbox]:checked').each(function(){
            id_array.push($(this).val());
        });
        var flowIdValue=id_array.join(',');
        var arr={paraName:"FLOW_SELECT_ID",paraValue:flowIdValue};
        $.ajax({
            url:"/FlowPara/updateByPrimaryKey",
            type:"post",
            dataType:"json",
            data:{
                paraName:"FLOW_SELECT_ID",
                paraValue:flowIdValue
            },
            success:function(res){
                if(res.flag){
                    layer.msg('保存成功！', {icon: 1});
                }else{
                    layer.msg('保存失败！', {icon: 2});
                }

            }
        })

    })

</script>
</html>