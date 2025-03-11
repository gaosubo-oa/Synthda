<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@taglib prefix="mvc" uri="http://www.springframework.org/tags/form" %>
<%@taglib prefix="fmt" uri="http://www.springframework.org/tags" %>
<%--<%--%>
    <%--String connect = session.getParameter("connect");--%>


<%--%>--%>

<!DOCTYPE html>
<head>
    <title>基础参数设置</title>
    <meta http-equiv="Content-Type" content="text/html; charset=gbk" />
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
            $('[name="'+name+'"]').val(val)
        }
        function ajax() {
            $.ajax({
                url:'/qiyeWeixin/getQiyeWeixinConfig',
                type:'get',
                dataType:'json',
                success:function(res){
                    if(res.flag){
                        inputcheck('corpId',res.data.corpid);
                        inputcheck('corpSecret',res.data.corpsecret);
                        inputcheck('agentid',res.data.agentid);
                        inputcheck('oaUrl',res.data.oaUrl);
                        inputcheck('apiDomain',res.data.apiDomain);
                        inputcheck('addressSecret',res.data.addressSecret);
                    }
                }
            });
        }
        ajax();

        $("#connect-btn").click(function(){
            $(window.parent.$("#iframe").attr("v-s",2));
            $.ajax({
                url:'/ewx/testConnect',
                type:'POST',
                dataType:'json',
                success:function (res) {
                    if(res.flag == true){
                        $("#connect-msg").addClass("text-success").html("连接成功！");
                    }else{
                        $("#connect-msg").removeClass("text-success").addClass("text-error").html("连接失败，请稍后尝试！");
                    }
                    var accessToken=res.access_token;
                }
            })
        });

        $('#btn').click(function(){
            var corpId= $('[name="corpId"]').val();
            var corpSecret= $('[name="corpSecret"]').val();
            var agentid = $('[name="agentid"]').val();
            var oaUrl = $('[name="oaUrl"]').val();
            var apiDomain = $('[name="apiDomain"]').val();
            var addressSecret = $('[name="addressSecret"]').val();
            if(corpId==''){
                layer.msg('请填写CorpId', {icon: 2});
                return;
            }
            if(corpSecret==''){
                layer.msg('请填写CorpSecret', {icon: 2});
                return;
            }
            if(agentid==''){
                layer.msg('请填写AgentId', {icon: 2});
                return;
            }
            if(oaUrl==''){
                layer.msg('请填写OA访问地址', {icon: 2});
                return;
            }
            $.ajax({
                url:'/qiyeWeixin/setQiyeWeixinConfig',
                type:'POST',
                data:{
                    agentid:agentid,
                    corpid:corpId,
                    corpsecret:corpSecret,
                    oaUrl:oaUrl,
                    apiDomain:apiDomain,
                    addressSecret:addressSecret
                },
                dataType:'json',
                success:function (res) {
                    if(res.flag){
                        ajax();
                        $('#connect-btn').css('display','inline-block');
                        layer.msg("保存成功", {icon: 1})
                    }

                }
            })
        })
    });

</script>
<div>
    <form class="form-horizontal">

        <fieldset>
            <legend><h5>基础参数设置</h5></legend>
            <div class="control-group">
                <label class="control-label" for="inputCorpID">CorpId</label>
                <div class="controls">
                    <input  id="inputCorpID" placeholder="CorpID" value="" name="corpId">
                    <span style="color: red;">*</span>
                </div>
            </div>
            <div class="control-group">
                <label class="control-label" for="inputSecret">CorpSecret</label>
                <div class="controls">
                    <input  class="span6" id="inputSecret" placeholder="Secret" value="" name="corpSecret">
                    <span style="color: red;">*</span>
                </div>
            </div>
            <div class="control-group">
                <label class="control-label" for="agentid">AgentId</label>
                <div class="controls">
                    <input  class="span6" id="agentid" placeholder="agentid" value="" name="agentid">
                    <span style="color: red;">*</span>
                </div>
            </div>
            <div class="control-group">
                <label class="control-label" for="oaUrl">OA访问地址</label>
                <div class="controls">
                    <input  class="span6" id="oaUrl" placeholder="OA访问地址：如http://oa.8oa.cn" value="" name="oaUrl">
                    <span style="color: red;">*</span>
                </div>
            </div>
            <div class="control-group">
                <label class="control-label" for="apiDomain">API接口调用的域名</label>
                <div class="controls">
                    <input  class="span6" id="apiDomain" placeholder="示例如：https://qyapi.weixin.qq.com" value="" name="apiDomain">
                    <span>注：该字段多用于私有化的企业微信，如内网的政务微信。非私有化可不填，默认调用官方接口</span>
                </div>
            </div>
            <div class="control-group">
                <label class="control-label" for="addressSecret">通讯录Secret</label>
                <div class="controls">
                    <input  class="span6" id="addressSecret" placeholder="" value="" name="addressSecret">
                    <span>注：该字段用于OA向企业微信组织同步数据，如果不需要可以不用填写</span>
                </div>
            </div>
            <div class="control-group">
                <div class="controls">
                    <button type="button" class="btn" id="btn" >保存</button>
                    <button id="connect-btn" type="button" class="btn btn-warning" style="margin-left: 5px;display: none" v-by=0>测试连接</button>
                    <span id="connect-msg"></span>
                </div>
            </div>
        </fieldset>

    </form>


</div>
</body>
</html>