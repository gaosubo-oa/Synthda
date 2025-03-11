<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@taglib prefix="mvc" uri="http://www.springframework.org/tags/form" %>
<%@taglib prefix="fmt" uri="http://www.springframework.org/tags" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=gbk" />
    <meta name="renderer" content="webkit">
    <meta http-equiv="X-UA-Compatible" content="IE=10,chrome=1" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=0, minimum-scale=1.0, maximum-scale=1.0">
    <title>基础参数设置</title>
    <link rel="stylesheet" type="text/css" href="../../css/bootstrap.css">
    <link rel="stylesheet" type="text/css" href="../../css/enterpriseManage/weixinqy.css">
    <script type="text/javascript" src="../../js/jquery/jquery.min.js"></script>
    <script type="text/javascript" src="../../js/unslider.min.js"></script>
    <script src="/lib/layer/layer.js"></script>
    <style>
        html,body{
            width: 100%;
            overflow: hidden;
        }
        .form-horizontal{
            font-family: "微软雅黑";
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
        .form-horizontal .span6{
            height: 30px;
            width: 650px;
        }
    </style>
</head>
<body>
<div style="width: 100%;">
    <form class="form-horizontal" style="width: 100%;">
        <fieldset>
            <legend><h5>基础参数设置</h5></legend>
            <div class="control-group">
                <label class="control-label" for="inputAppId">应用ID</label>
                <div class="controls">
                    <input  class="span6"  id="inputAppId" placeholder="APP_ID" value="" name="appId">
                    <span style="color: red;">*</span>
                </div>
            </div>
            <div class="control-group">
                <label class="control-label" for="inputAppName">应用名称</label>
                <div class="controls">
                    <input  class="span6" id="inputAppName" placeholder="APP_NAME" value="" name="appName">
                    <span style="color: red;">*</span>
                </div>
            </div>
            <div class="control-group">
                <label class="control-label" for="jwtPublickey">JWT PublicKey</label>
                <div class="controls">
                    <input  class="span6" id="jwtPublickey" placeholder="JWT Publickey" value="" name="jwtPublickey">
                    <span style="color: red;">*</span>
                </div>
            </div>
            <div class="control-group">
                <label class="control-label" for="apiKey">API_KEY</label>
                <div class="controls">
                    <input  class="span6" id="apiKey" placeholder="API_KEY" value="" name="apiKey">
                    <span style="display: block">注：该字段为推送数据至IDaas的client_id,若不需要推送数据至IDaas可不填</span>
                </div>
            </div>
            <div class="control-group">
                <label class="control-label" for="apiSecret">API_SECRET</label>
                <div class="controls">
                    <input  class="span6" id="apiSecret" placeholder="API_SECRET" value="" name="apiSecret">
                    <span style="display: block">注：该字段为推送数据至IDaas的client-secret,若不需要推送数据至IDaas可不填</span>
                </div>
            </div>
            <div class="control-group">
                <label class="control-label" for="idaasBaseUrl">IDaas API 调用接口</label>
                <div class="controls">
                    <input  class="span6" id="idaasBaseUrl" placeholder="示例如：cjstyibygo.login.aliyunidaas.com" value="" name="idaasBaseUrl">
                    <span style="display: block">注：该字段为IDaas接收推送数据API接口，若不需要推送数据至IDaas可不填</span>
                </div>
            </div>
            <div class="control-group">
                <div class="controls">
                    <button type="button" class="btn" id="btn" >保存</button>
                </div>
            </div>
            <div class="control-group" style="margin-top: 35px">
                <label class="control-label">redirect_uri:</label>
                <div class="controls" style="margin-top: 5px">
                    <div style="font-size: 15px">http://OA系统域名/reliaOASso/ssoLogin?loginId=xxxx</div>
                    <span style="display: block; margin-top: 4px">
                        注：该字段为 IDaas 登录 Lims 系统 API 接口，例：http//127.0.0.1/reliaOASso/ssoLogin?loginId=1001 （loginId 为需要登录指定组织的组织ID，若只有一个组织可以不填写）
                    </span>
                </div>
            </div>
            <div class="control-group">
                <label class="control-label">Target_link_uri:</label>
                <div class="controls" style="margin-top: 5px">
                    <div style="font-size: 15px">http://OA系统域名/main</div>
                    <span style="display: block; margin-top: 4px">注：该字段为 IDaas 登录 lims 系统后页面跳转地址，例：http//127.0.0.1/main</span>
                </div>
            </div>
            <div class="control-group">
                <label class="control-label">SCIM 账户同步地址:</label>
                <div class="controls" style="margin-top: 5px">
                    <div style="font-size: 15px">http://OA系统域名/reliaOASso/synPersion?loginId=xxxx</div>
                    <span style="display: block; margin-top: 4px">
                        注：该字段为 OA 系统接收 IDaas 推送账户数据 API 接口，例http://127.0.0.1/reliaOASso/synPersion?loginId=1001（loginId 为需要推送账户到指定组织的组织ID，若只有一个组织可以不填写）
                    </span>
                </div>
            </div>
            <div class="control-group">
                <label class="control-label">SCIM 组织机构同步地址:</label>
                <div class="controls" style="margin-top: 5px">
                    <div style="font-size: 15px">http://OA系统域名/reliaOASso/synDeptment?loginId=xxxx</div>
                    <span style="display: block; margin-top: 4px">
                        注：该字段为 OA 系统接收 IDaas 推送组织机构数据 API 接口，例http://127.0.0.1/reliaOASso/synDeptment?loginId=1001（loginId 为需要推送组织机构到指定组织的组织ID，若只有一个组织可以不填写）
                    </span>
                </div>
            </div>
        </fieldset>
    </form>
</div>

<script type="text/javascript">
    var data;

    // 获取数据
    $.ajax({
        url:'/idaas_manage/getAlidasSet',
        type:'POST',
        dataType:'json',
        success:function (res) {
            data = res.object[0]
            if(res.flag == true){
                if (res.object.length > 0) {
                    if (res.object[0].appId != undefined) {
                        $("#inputAppId").val(res.object[0].appId)
                    }
                    if (res.object[0].appName != undefined) {
                        $("#inputAppName").val(res.object[0].appName)
                    }
                    if (res.object[0].jwtPublickey != undefined) {
                        $("#jwtPublickey").val(res.object[0].jwtPublickey)
                    }
                    if (res.object[0].apiKey != undefined) {
                        $("#apiKey").val(res.object[0].apiKey)
                    }
                    if (res.object[0].apiSecret != undefined) {
                        $("#apiSecret").val(res.object[0].apiSecret)
                    }
                    if (res.object[0].idaasBaseUrl != undefined) {
                        $("#idaasBaseUrl").val(res.object[0].idaasBaseUrl)
                    }
                }
            }
        }
    });


    // 保存数据
    $('#btn').click(function() {
        if ($("#inputAppId").val() == null || $("#inputAppId").val() == undefined || $("#inputAppId").val() == "") {
            layer.msg("请填写 应用ID", {time: 1500, icon: 7})
        } else if ($("#inputAppName").val() == null || $("#inputAppName").val() == undefined || $("#inputAppName").val() == "") {
            layer.msg("请填写 应用名称", {time: 1500, icon: 7})
        } else if ($("#jwtPublickey").val() == null || $("#jwtPublickey").val() == undefined || $("#jwtPublickey").val() == "") {
            layer.msg("请填写 JW PublicKey", {time: 1500, icon: 7})
        } else {
            var param = {}
            param.appId = $("#inputAppId").val()
            param.appName = $("#inputAppName").val()
            param.jwtPublickey = $("#jwtPublickey").val()
            param.apiKey = $("#apiKey").val()
            param.apiSecret = $("#apiSecret").val()
            param.idaasBaseUrl = $("#idaasBaseUrl").val()
            if (data != null && data != undefined) {
                if (data.idaasId != null && data.idaasId != undefined && data.idaasId != '') {
                    param.idaasId = data.idaasId
                }
            }

            $.ajax({
                url:'/idaas_manage/editAlidassSet',
                type:'POST',
                dataType:'json',
                data: param,
                success:function (res) {
                    if(res.flag ){
                        layer.msg("保存成功", {time: 1500, icon: 1})
                    } else {
                        layer.msg("保存失败", {time: 1500, icon: 2})
                    }
                }
            });
        }
    });
</script>
</body>
</html>