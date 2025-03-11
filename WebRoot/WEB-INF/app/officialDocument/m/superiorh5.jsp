<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@taglib prefix="mvc" uri="http://www.springframework.org/tags/form" %>
<%@taglib prefix="fmt" uri="http://www.springframework.org/tags" %>
<%
    String corpId = (String)request.getAttribute("corpId");
    String corpSecret = (String)request.getAttribute("corpSecret");
%>
<!DOCTYPE html>
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width,initial-scale=1,minimum-scale=1,maximum-scale=1,user-scalable=no" />
    <title>上级来文</title>
    <script type="text/javascript" src="../../js/jquery/jquery.min.js"></script>
    <link href="../../css/H5/default.css" rel="stylesheet"/>
    <script type="text/javascript" src="../../lib/dropload/dropload.js"></script>
    <link href="../../lib/dropload/dropload.css" rel="stylesheet"/>
    <style>
        header {
            height: 0.85rem;
            display: flex;
            align-items: center;
            justify-content: space-between;
            font-size: 0.32rem;
            color: #fff;
            padding-left: 0.23rem;
            padding-right: 0.23rem;
            position: fixed;
            width: 100%;
            z-index: 1;
            background-color: #3984ff;
            box-shadow: 1px 1px 7px rgba(0, 0, 0, .85);
        }


        input{
            font-size: 0.34rem;
            -webkit-box-sizing: border-box;
            box-sizing: border-box;
            height: .62rem;
            border: 0;
            border-radius: 6px;
            outline: 0;
            padding-left: 10px;
            background: #fff;width: 95%;margin: 7px 0 ;

        }
        input::-ms-input-placeholder{text-align: center;}
        input::-webkit-input-placeholder{text-align: center;}

        .nav2{
            color: #333;
            font-size: 0.33rem;
            width: 48%;
            overflow: hidden;
            text-overflow: ellipsis;
            white-space: nowrap;
            display: inline-block;
            float: left;
        }
        .nav1{
            margin:0rem .3rem 0 .3rem;
            color: #646464;
            overflow: hidden;
            text-overflow: ellipsis;
            white-space: nowrap;
        }
        .nav3{
            margin: 0 .4rem;
            color: #646464;
            border-bottom: 1px solid #5a8fd5;
            line-height: 0.7rem;
        }
        .fs14{
            font-size: 0.3rem;
            color: #999;
            float: right;
            display: inline-block;
        }
        .ac{
            color: #5087d0;
            font-size: .28rem;
        }
        .hd{
            height: .85rem;
        }
        .list{
            display: block;
        }
        .content{
            margin-bottom: .38rem;
            margin: 0 .1rem;
        }
        .fs15{
            text-align: center;
            width: 60px;
            height: 26px;
            line-height: 26px;
            background-color: aliceblue;
            font-size: 0.25rem;
            border-radius: .1rem;
            color: #5a8fd5;
            margin-top: .09rem;
        }
        .cc{
            color:#5a8fd5;
        }
    </style>
</head>
<body>
<header>
    <i><a href="javascript:history.back(-1)" style="color: #fff">返回</a></i>
    <span>上级来文</span>
    <i style="width: .4rem"></i>
</header>
<div class="hd"></div>
<div class="" style="background: #ffffff;">
    <div class="content">
    </div>

</div>
</body>
<script>
    var fs = document.documentElement.clientWidth / 750  * 100;
    document.querySelector("html").style.fontSize = fs + "px";

    $(function(){
        var app = '';
        $.ajax({
            type: 'GET',
            url: '/outDocument/getHttpDocuments',
            data:{
//                page:1,
//                pageSize:999
            },
            dataType: 'json',
            success: function(res){
                if(res.flag&&res.data!=0){
                    $.each (res.data,function(index,item){
                        app+='<div style="box-shadow: 1px 1px 7px rgba(206, 194, 194, 0.85);    border-radius: .1rem;background-color: #fff;margin:.25rem .1rem;padding :.2rem 0">'+
                            '<a class="list" href="javascript:;" style="color: #333;" attr_id="'+ item.id +'" businessKey="'+item.businessKey+'" processInstanceId="'+item.processInstanceId+'">'+
                            '<div class="nav1" style="border-bottom: 1px solid #b5b0b0;line-height: .7rem;height: .7rem;">'+
                            '<span class="nav2">'+item.processInstanceName+'</span>'+
                            '<span class="fs14 fs15">'+item.processDefinitionName+'</span>'+
                            '</div>'+
                            '<div style="margin: .18rem 0 0 .3rem;font-size: .26rem;">流程发起人：'+item.startUserName+'</div>'+
                            '<div style="margin: .18rem 0 0 .3rem;font-size: .26rem;">负责人：'+item.assigneeName+'</div>'+
                            '<div style="margin: .18rem 0 0 .3rem;font-size: .26rem;" class="cc">' +
                            '<p class="cc">当前节点：'+item.name+'</p>' +
                            '</div>'+
                            '<div style="margin: .18rem 0 0 .3rem;font-size: .26rem;" class="cc">'+item.friendlyCreateTime+'</div>'+
                            '</a>'+
                            '</div>'
                    })
                    $('.content').html(app)
                }
            },
        });
    });
    $(function(){
        $('.content').on('click','a',function () {
            var businesskey=$(this).attr('businesskey')
            var id=$(this).attr('attr_id')
            $.ajax({
                type: 'GET',
                url: '/outDocument/receiveDoc',
                data:{
                    flag:1,
                    id:businesskey,
                    taskId:id,
                },
                dataType: 'json',
                success: function(res) {
                    if(res.flag) {
                        var flowId=res.object.flowRun.flowId;
                        var runId=res.object.flowRun.runId;

                        window.location.href='/document/getSuperiorformh5?flowId='+flowId+'&flowStep=1'+
                            '&runId='+runId+'&prcsId=1'+'&isNomalType=false&hidden=true&opFlag=1&backType=3'

                    }
                }
            });
        })
    })




</script>
</html>