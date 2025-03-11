<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@taglib prefix="mvc" uri="http://www.springframework.org/tags/form" %>
<%@taglib prefix="fmt" uri="http://www.springframework.org/tags" %>

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
        /*.form-horizontal .btn {*/
            /*background: url(../../img/vote/saveBlue.png) no-repeat;*/
            /*color: #fff;*/
            /*line-height: 30px;*/
            /*font-size: 16px;*/
            /*width: 91px;*/
            /*height: 30px;*/
            /*cursor: pointer;*/
        /*}*/
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
                url:'/dingdingManage/baseDingDingGet',
                type:'get',
                dataType:'json',
                success:function(res){
                    if(res.flag){
                        for(var i=0;i<res.data.length;i++){
                            if(res.data[i].paraName=="DINGDINGQY_APPKEY"){
                                inputcheck('appKey',res.data[i].paraValue);
                            }
                            if(res.data[i].paraName=="DINGDINGQY_APPSECRET"){
                                inputcheck('appSecret',res.data[i].paraValue);
                            }
                            if(res.data[i].paraName=="DINGDINGQY_OAURL"){
                                inputcheck('oaUrl',res.data[i].paraValue);
                            }
                            if(res.data[i].paraName=="DINGDINGQY_CORPID"){
                                inputcheck('corpId',res.data[i].paraValue);
                            }
                            if(res.data[i].paraName=="DINGDINGQY_AGENTID"){
                                inputcheck('agentId',res.data[i].paraValue);
                            }
                        }
                    }
                }
            });
        }
        ajax();
        $("#connect-btn").click(function(){
            $.ajax({
                url:'/dingdingManage/dingdingConnect',
                type:'POST',
                async:false,
                dataType:'json',
                success:function (res) {
                    if(res.flag){
                        $("#connect-msg").addClass("text-success").html("连接成功！");
                    }else{
                        $("#connect-msg").removeClass("text-success").addClass("text-error").html("连接失败，请稍后尝试！");
                    }
                }
            })
        });
        $('#btn').click(function(){
            var oaUrl= $('[name="oaUrl"]').val();
            var corpId= $('[name="corpId"]').val();
            var appKey= $('[name="appKey"]').val();
            var appSecret= $('[name="appSecret"]').val();
            var agentId= $('[name="agentId"]').val();
//            document.cookie='pd1=2'
//            var pd1=document.cookie.split(";")[0].split("=")[1];
//            console.log(pd1)
            $.ajax({
                url:'/dingdingManage/baseDingDingSetting',
                type:'POST',
                data:{
                    oaUrl:oaUrl,
                    appKey:appKey,
                    appSecret:appSecret,
                    corpId:corpId,
                    agentId:agentId
                },
                dataType:'json',
                success:function (res) {
                    if(res.flag){
                        ajax();
                        $('#connect-btn').css('display','inline-block')
                        layer.msg("保存成功", {icon: 1})
                    }
                }
            })
        })
    });
//    (function($){
//        $(document).ready(function(){
//            $('.banner').unslider({
//                speed: 500,
//                delay: false,
//                complete: function() {},
//                keys: true,
//                dots: true,
//                fluid: false,
//                arrows: true,
//                prev: '<',
//                next: '>'
//            });
//        });
//    })(jQuery);
</script>
<div>
    <form class="form-horizontal">
        <%--<fieldset>--%>
            <%--<legend><h5> OA访问地址设置</h5></legend>--%>
            <%--<div class="control-group">--%>
                <%--<label class="control-label" for="inputOaUrl">OA外网网址</label>--%>
                <%--<div class="controls">--%>
                    <%--<input id="inputOaUrl" placeholder="www.xxx.com" value="" name="oaUrl">--%>
                    <%--<span class="help-block">OA的外网地址格式为: <code>www.xxx.com</code> 或者 数字ip <code>123.23.12.XX</code> 不需要http前缀。如OA地址使用了https协议443端口，请填写https协议头，如<code>https://www.xxx.com</code>。</span>--%>
                <%--</div>--%>
            <%--</div>--%>
        <%--</fieldset>--%>

        <fieldset>
            <legend><h5>基础参数设置</h5></legend>
            <div class="control-group">
                <label class="control-label" for="inputCorpID">CorpID</label>
                <div class="controls">
                    <input  id="inputCorpID" placeholder="CorpID" value="" name="corpId">
                </div>
            </div>
            <div class="control-group">
                <label class="control-label" for="inputAgentID">AgentID</label>
                <div class="controls">
                    <input  id="inputAgentID" placeholder="AgentID" value="" name="agentId">
                </div>
            </div>
            <div class="control-group">
                <label class="control-label" for="inputCorpID">AppKey</label>
                <div class="controls">
                    <input  id="inputAppKey" placeholder="appKey" value="" name="appKey">
                </div>
            </div>
            <div class="control-group">
                <label class="control-label" for="inputSecret">AppSecret</label>
                <div class="controls">
                    <input  class="span6" id="inputSecret" placeholder="Secret" value="" name="appSecret">
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
        <!--
        <div class="well">
            <p>在哪里找到 CorpID & CorpSecret？</p>
            <p class="muted">用浏览器登陆 https://qy.weixin.qq.com/ ，用微信扫一扫右侧的二维码，输入密码进入管理后台，点击 左侧“设置”，滚动页面到最下方，“管理组开发者凭据”下方即有 <code>CorpID</code> 和 <code>CorpSecret</code></p>
        </div>
        -->
    </form>
    <%--<fieldset>--%>
        <%--<legend><h5>使用帮助</h5></legend>--%>
    <%--</fieldset>--%>
    <%--<div class="banner">--%>
        <%--<ul>--%>
            <%--<li>--%>
                <%--<div class="slide_wrapper">--%>
                    <%--<div class="slide_title"><strong>第1步：</strong>将下方的链接在浏览器中打开，并注册钉钉企业号平台账号。<a href="https://oa.dingtalk.com/register.html?inviteCode=3800" target="_blank">https://oa.dingtalk.com/register.html</a></div>--%>
                    <%--<div class="slide_img">--%>
                        <%--<img style="height: auto;" src="/static/modules/weixinqy/images/dingding/set-1.png">--%>
                    <%--</div>--%>
                <%--</div>--%>
            <%--</li>--%>
            <%--<li>--%>
                <%--<div class="slide_wrapper">--%>
                    <%--<div class="slide_title"><strong>第2步：</strong>进入导航栏【微应用】下的【微应用设置】，在“微应用显示名称”中填写企业名称。点击界面中的【获取】按钮可以获取到“CorpID”和“CorpSecret”链接。将CorpID和CorpSecret粘贴到上方对应处，进行保存后点击界面中显示出的“测试链接”按钮，提示“连接成功”。</div>--%>
                    <%--<div class="slide_img">--%>
                        <%--<img style="height: auto;" src="/static/modules/weixinqy/images/dingding/set-2.png">--%>
                    <%--</div>--%>
                <%--</div>--%>
            <%--</li>--%>
            <%--<li>--%>
                <%--<div class="slide_wrapper">--%>
                    <%--<div class="slide_title"><strong>第3步：</strong>连接成功后点击【组织架构初始化】中的【一键初始化】按钮。初始化操作成功后，OA中的组织机构就已同步到钉钉企业号平台【通讯录】中。</div>--%>
                    <%--<div class="slide_img">--%>
                        <%--<img style="height: auto;margin-top: 30px;" src="/static/modules/weixinqy/images/dingding/set-3.png">--%>
                    <%--</div>--%>
                <%--</div>--%>
            <%--</li>--%>
            <%--<li>--%>
                <%--<div class="slide_wrapper">--%>
                    <%--<div class="slide_title"><strong>第4步：</strong>在上方【用户管理】中勾选要导入的人员，点击【导入选择的人员】，人员将会显示在钉钉企业平台—通讯录中。<span style="color:red">（导入人员必须填写手机号！）</span></div>--%>
                    <%--<div class="slide_img">--%>
                        <%--<img style="height: auto;margin-top: 30px;" src="/static/modules/weixinqy/images/dingding/set-4.png">--%>
                    <%--</div>--%>
                <%--</div>--%>
            <%--</li>--%>
            <%--<li>--%>
                <%--<div class="slide_wrapper">--%>
                    <%--<div class="slide_title"><strong>第5步：</strong>如先在钉钉中创建的人员，可在【钉钉账号绑定到OA用户】中与OA用户进行绑定。<span class="font-red">（在钉钉中创建的人员手机号码必须要与OA中该人员的手机号码一致。）</span></div>--%>
                    <%--<div class="slide_img">--%>
                        <%--<img style="height: auto;margin-top: 30px;" src="/static/modules/weixinqy/images/dingding/set-5.png">--%>
                    <%--</div>--%>
                <%--</div>--%>
            <%--</li>--%>
            <%--<li>--%>
                <%--<div class="slide_wrapper">--%>
                    <%--<div class="slide_title"><strong>第6步：</strong>绑定成功后的人员会在钉钉客户端上显示出第2步“微应用显示名称”中填写企业名称。</div>--%>
                    <%--<div class="slide_img">--%>
                        <%--<img style="height: auto;width:400px;" src="/static/modules/weixinqy/images/dingding/set-6.png">--%>
                    <%--</div>--%>
                <%--</div>--%>
            <%--</li>--%>
        <%--</ul>--%>
    <%--</div>--%>

</div>
</body>
</html>