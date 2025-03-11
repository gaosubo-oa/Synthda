<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@taglib prefix="mvc" uri="http://www.springframework.org/tags/form" %>
<%@taglib prefix="fmt" uri="http://www.springframework.org/tags" %>

<!DOCTYPE html>
<head>
    <title>政务微信平台设置</title>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <meta name="renderer" content="webkit">
    <meta http-equiv="X-UA-Compatible" content="IE=10,chrome=1" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=0, minimum-scale=1.0, maximum-scale=1.0">
    <style>
        .form-horizontal{
            font-family: Microsoft yahei,Helvetica Neue,Helvetica,PingFang SC,Tahoma,Arial,sans-serif;
        }
        input {
            background-color: #ffffff;
            height: 20px;
            padding: 4px 6px;
            margin-bottom: 10px;
            font-size: 13px;
            line-height: 20px;
            color: #555555;
            -webkit-border-radius: 2px;
            -moz-border-radius: 2px;
            border-radius: 2px;
            vertical-align: middle;
            border: 1px solid #ccc;
        }
        legend h5{
            font-size: 13pt;
            margin-left: 20px;
        }
    </style>
</head>
<body>
<link rel="stylesheet" type="text/css" href="../../css/bootstrap.css">
<link rel="stylesheet" type="text/css" href="../../css/enterpriseManage/weixinqy.css">
<script type="text/javascript" src="../../js/jquery/jquery.min.js"></script>
<script type="text/javascript" src="../../js/unslider.min.js"></script>
<script src="/lib/layer/layer.js?20201106"></script>
<script type="text/javascript">

    $(function(){
        var i=0;
        function inputcheck(name ,val){
            if(val==undefined){
                return;
            }
        }
            $.ajax({
                url:'/syspara/selectByParaName?paraName=WUHAN_SERVICE_URL',
                type:'get',
                dataType:'json',
                success:function(res){
                    if(res.flag){
                        $('#address').val(res.object)
                    }
                }
            });


        $('#btn').click(function(){
            var address=$('#address').val()
            $.ajax({
                url:'/syspara/updateSysParaByParaName',
                type:'POST',
                data:{
                    paraName:'WUHAN_SERVICE_URL',
                    paraValue:address
                },
                dataType:'json',
                success:function (res) {
                    if(res.flag){
                        layer.msg("保存成功", {icon: 1})
                    }

                }
            })
        })
    });

</script>
<div>
    <form class="form-horizontal">
        <legend><h5>政务微信平台设置</h5></legend>
        <fieldset>
            <div class="control-group">
                <label class="control-label" for="inputCorpID">接口地址：</label>
                <div class="span6">
                    <input style="width: 440px!important;"  id="address" name="address">
                </div>
            </div>
            <div class="control-group">
                <div class="controls">
                    <button type="button" class="btn" id="btn" >保存</button>
                </div>
            </div>
        </fieldset>

    </form>


</div>
</body>
</html>