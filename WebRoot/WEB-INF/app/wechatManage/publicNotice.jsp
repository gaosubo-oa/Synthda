<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@taglib prefix="mvc" uri="http://www.springframework.org/tags/form" %>
<%@taglib prefix="fmt" uri="http://www.springframework.org/tags" %>
<%
    String appName = request.getParameter("appName");
%>
<!DOCTYPE html>
    <head>
        <title>钉钉应用设置 - 公告通知</title>
        <meta http-equiv="Content-Type" content="text/html; charset=gbk" />
        <meta name="renderer" content="webkit">
        <meta http-equiv="X-UA-Compatible" content="IE=10,chrome=1" />
        <meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=0, minimum-scale=1.0, maximum-scale=1.0">
        <script type="text/javascript" >
            var MYOA_JS_SERVER = "";
            var MYOA_STATIC_SERVER = "";
        </script>
        <style>
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
             fieldset h5{
                 font-size: 13pt;
                 font-weight: 700;
             }
            html body{
                font-family: Microsoft yahei,Helvetica Neue,Helvetica,PingFang SC,Tahoma,Arial,sans-serif;
            }
        </style>
    </head>
<body>
<link rel="stylesheet" type="text/css" href="../../css/bootstrap.css">
<link rel="stylesheet" type="text/css" href="../../css/enterpriseManage/weixinqy.css">
<script type="text/javascript" src="../../js/jquery/jquery.min.js"></script>
<script type="text/javascript" src="../../js/unslider.min.js"></script>
<script type="text/javascript" src="../../js/jquery/jquery.tmpl.min.js"></script>
<script src="/lib/layer/layer.js?20201106"></script>
<script type="text/javascript">
    function inputcheck(name,val) {
        if(val==undefined){
            return;
        }
        $('[name="'+name+'"]').val(val)
    }

    var appName = <%=appName%>;

    console.log(appName);

    $(function(){

//        $('#appId').on('blur keyup paste', (function(){
//            var t;
//            return function(){
//                var appid = this.value;
//                t && clearTimeout(t);
//                t = setTimeout(function(){
//                    $('#url').val("http://www.baidu.com/pda/dingding.php?cid=123&url=%252Fpda%252Fnotify%252Findex.php&aid=%7Bappid%7D".replace(/{appid}$/ig, appid));
//                }, 100);
//            }
//        })());


            $.ajax({
                url:'/dingdingManage/getDingdingApp',
                type:'post',
                data:{'appName':appName},
                success:function(res){
                    if(res.flag){
                        inputcheck('appId',res.data.dingdingAppId)
                        inputcheck('appUrl',res.data.dingdingAppUrl)
                    }
                }
            })

        $('.btn-primary').click(function(){
            var appId=$('#appId').val();
            $.ajax({
                url:'/dingdingManage/dingdingAppSetting',
                type:'get',
                data:{'appName':appName,'appId':appId},
                success:function(res){
                    if(res.flag){
                        layer.msg("保存成功", {icon: 1})
                    }
                }
            })
        })
    })
</script>
<div>
    <fieldset>
        <legend><h5>公告通知</h5></legend>
    </fieldset>

    <form class="form-horizontal" >
        <input name="module" type="hidden"  value="$module">
        <div class="control-group">
            <div class="controls">
                <img class="weixin_app_logo" src="../../img/logo2.png" width="64" height="64">
                <span>请保存此图标作为应用logo</span>
            </div>
        </div>
        <div class="control-group">
            <label class="control-label" for="inputEmail">应用ID</label>
            <div class="controls">
                <input  id="appId" name="appId" placeholder="应用ID" value="">
            </div>
        </div>

        <div class="control-group">
            <label class="control-label" for="url">URL</label>
            <div class="controls">
                <input  id="url" name="appUrl" class="span5" value="" disabled>
                <span class="help-block">应用ID确认后再将此地址请复制到钉钉对应的应用 <strong>首页地址</strong> 的URL输入框</span>
            </div>
        </div>

        <div class="control-group">
            <div class="controls">
                <input type="hidden" name="action" type="text" value="initParams"/>
                <button  class="btn btn-primary" type="button">确定</button>
            </div>
        </div>
    </form>

    <%--<fieldset>--%>
        <%--<legend><h5>使用帮助</h5></legend>--%>
    <%--</fieldset>--%>
    <%--<script type="text/javascript">--%>
        <%--(function($){--%>
            <%--$(document).ready(function(){--%>
                <%--var cur_app = 'notify';--%>
                <%--var ddAppData = [--%>
                    <%--{--%>
                        <%--moduleId: 'email',--%>
                        <%--steps: [--%>
                            <%--{--%>
                                <%--stepId: 1,--%>
                                <%--stepText: '点击导航栏【微应用】下的【新增微应用】按钮。在“新增微应用”界面中填写内容。【后台地址】可不填写，【首页地址】需要先填写为http://www.tongda2000.com',--%>
                                <%--stepImg: 'email-1',--%>
                                <%--stepImgStyle: 'width:auto;'--%>
                            <%--},--%>
                            <%--{--%>
                                <%--stepId: 2,--%>
                                <%--stepText: '点击【微应用】下新增应用【电子邮件】的“设置”按钮，在电子邮件设置界面中，将获取到的【AgentID】粘贴到上方【应用ID】内，并点击【确定】按钮。在上方【应该ID】保存成功后，把【首页地址】中的http://www.tongda2000.com删除，将上方【URL】复制到【首页地址】中。',--%>
                                <%--stepImg: 'email-2',--%>
                                <%--stepImgStyle: ''--%>
                            <%--},--%>
                            <%--/*{--%>
                             <%--stepId: 3,--%>
                             <%--stepText: '点击【微应用】下新增应用【电子邮件】的“设置”按钮，在电子邮件设置界面中将【首页地址】中的http://www.tongda2000.com删除，把上一步骤生成的短链接粘贴进去。',--%>
                             <%--stepImg: 'email-3',--%>
                             <%--stepImgStyle: 'width: auto;'--%>
                             <%--},--%>
                             <%--{--%>
                             <%--stepId: 4,--%>
                             <%--stepText: '将获取到的【AgentID】粘贴到【应用ID】中，并点击【确定】按钮。',--%>
                             <%--stepImg: 'email-4',--%>
                             <%--stepImgStyle: 'height: auto;margin-top: 30px;'--%>
                             <%--}*/--%>
                        <%--]--%>
                    <%--},--%>
                    <%--{--%>
                        <%--moduleId: 'notify',--%>
                        <%--steps: [--%>
                            <%--{--%>
                                <%--stepId: 1,--%>
                                <%--stepText: '点击导航栏【微应用】下的【新增微应用】按钮。在“新增微应用”界面中填写内容。【后台地址】可不填写，【首页地址】需要先填写为http://www.tongda2000.com。',--%>
                                <%--stepImg: 'notify-1',--%>
                                <%--stepImgStyle: 'width:auto;'--%>
                            <%--},--%>
                            <%--{--%>
                                <%--stepId: 2,--%>
                                <%--stepText: '第2步 点击【微应用】下新增应用【公告通知】的“设置”按钮，在公告通知设置界面中，将获取到的【AgentID】粘贴到上方【应用ID】内，并点击【确定】按钮。在上方【应该ID】保存成功后，把【首页地址】中的http://www.tongda2000.com删除，将上方【URL】复制到【首页地址】中。',--%>
                                <%--stepImg: 'notify-2',--%>
                                <%--stepImgStyle: ''--%>
                            <%--},--%>
                            <%--/*{--%>
                             <%--stepId: 3,--%>
                             <%--stepText: '点击【微应用】下新增应用【公告通知】的“设置”按钮，在公告通知设置界面中将【首页地址】中的http://www.tongda2000.com删除，把上一步骤生成的短链接粘贴进去。',--%>
                             <%--stepImg: 'notify-3',--%>
                             <%--stepImgStyle: 'width: auto;'--%>
                             <%--},--%>
                             <%--{--%>
                             <%--stepId: 4,--%>
                             <%--stepText: '将获取到的【AgentID】粘贴到【应用ID】中，并点击【确定】按钮。',--%>
                             <%--stepImg: 'notify-4',--%>
                             <%--stepImgStyle: 'height: auto;margin-top: 30px;'--%>
                             <%--}*/--%>
                        <%--]--%>
                    <%--},--%>
                    <%--{--%>
                        <%--moduleId: 'news',--%>
                        <%--steps: [--%>
                            <%--{--%>
                                <%--stepId: 1,--%>
                                <%--stepText: '点击导航栏【微应用】下的【新增微应用】按钮。在“新增微应用”界面中填写内容。【后台地址】可不填写，【首页地址】需要先填写为http://www.tongda2000.com。',--%>
                                <%--stepImg: 'news-1',--%>
                                <%--stepImgStyle: 'width:auto;'--%>
                            <%--},--%>
                            <%--{--%>
                                <%--stepId: 2,--%>
                                <%--stepText: '点击【微应用】下新增应用【新闻】的“设置”按钮，在新闻设置界面中，将获取到的【AgentID】粘贴到上方【应用ID】内，并点击【确定】按钮。在上方【应该ID】保存成功后，把【首页地址】中的http://www.tongda2000.com删除，将上方【URL】复制到【首页地址】中。',--%>
                                <%--stepImg: 'news-2',--%>
                                <%--stepImgStyle: ''--%>
                            <%--},--%>
                            <%--/*{--%>
                             <%--stepId: 3,--%>
                             <%--stepText: '点击【微应用】下新增应用【新闻】的“设置”按钮，在新闻设置界面中将【首页地址】中的http://www.tongda2000.com删除，把上一步骤生成的短链接粘贴进去。',--%>
                             <%--stepImg: 'news-3',--%>
                             <%--stepImgStyle: 'width: auto;'--%>
                             <%--},--%>
                             <%--{--%>
                             <%--stepId: 4,--%>
                             <%--stepText: '将获取到的【AgentID】粘贴到【应用ID】中，并点击【确定】按钮。',--%>
                             <%--stepImg: 'news-4',--%>
                             <%--stepImgStyle: 'height: auto;margin-top: 30px;'--%>
                             <%--}*/--%>
                        <%--]--%>
                    <%--},--%>
                    <%--{--%>
                        <%--moduleId: 'workflow',--%>
                        <%--steps: [--%>
                            <%--{--%>
                                <%--stepId: 1,--%>
                                <%--stepText: '点击导航栏【微应用】下的【新增微应用】按钮。在“新增微应用”界面中填写内容。【后台地址】可不填写，【首页地址】需要先填写为http://www.tongda2000.com。',--%>
                                <%--stepImg: 'workflow-1',--%>
                                <%--stepImgStyle: 'width:auto;'--%>
                            <%--},--%>
                            <%--{--%>
                                <%--stepId: 2,--%>
                                <%--stepText: '点击【微应用】下新增应用【工作流】的“设置”按钮，在工作流设置界面中，将获取到的【AgentID】粘贴到上方【应用ID】内，并点击【确定】按钮。在上方【应该ID】保存成功后，把【首页地址】中的http://www.tongda2000.com删除，将上方【URL】复制到【首页地址】中。',--%>
                                <%--stepImg: 'workflow-2',--%>
                                <%--stepImgStyle: ''--%>
                            <%--},--%>
                            <%--/*{--%>
                             <%--stepId: 3,--%>
                             <%--stepText: '点击【微应用】下新增应用【工作流】的“设置”按钮，在工作流设置界面中将【首页地址】中的http://www.tongda2000.com删除，把上一步骤生成的短链接粘贴进去。',--%>
                             <%--stepImg: 'workflow-3',--%>
                             <%--stepImgStyle: 'width: auto;'--%>
                             <%--},--%>
                             <%--{--%>
                             <%--stepId: 4,--%>
                             <%--stepText: '将获取到的【AgentID】粘贴到【应用ID】中，并点击【确定】按钮。',--%>
                             <%--stepImg: 'workflow-4',--%>
                             <%--stepImgStyle: 'height: auto;margin-top: 30px;'--%>
                             <%--}*/--%>
                        <%--]--%>
                    <%--},--%>
                    <%--{--%>
                        <%--moduleId: 'calendar',--%>
                        <%--steps: [--%>
                            <%--{--%>
                                <%--stepId: 1,--%>
                                <%--stepText: '点击导航栏【微应用】下的【新增微应用】按钮。在“新增微应用”界面中填写内容。【后台地址】可不填写，【首页地址】需要先填写为http://www.tongda2000.com。',--%>
                                <%--stepImg: 'calendar-1',--%>
                                <%--stepImgStyle: 'width:auto;'--%>
                            <%--},--%>
                            <%--{--%>
                                <%--stepId: 2,--%>
                                <%--stepText: '点击【微应用】下新增应用【日程安排】的“设置”按钮，在日程安排设置界面中，将获取到的【AgentID】粘贴到上方【应用ID】内，并点击【确定】按钮。在上方【应该ID】保存成功后，把【首页地址】中的http://www.tongda2000.com删除，将上方【URL】复制到【首页地址】中。',--%>
                                <%--stepImg: 'calendar-2',--%>
                                <%--stepImgStyle: ''--%>
                            <%--},--%>
                            <%--/*{--%>
                             <%--stepId: 3,--%>
                             <%--stepText: '点击【微应用】下新增应用【日程安排】的“设置”按钮，在日程安排设置界面中将【首页地址】中的http://www.tongda2000.com删除，把上一步骤生成的短链接粘贴进去。',--%>
                             <%--stepImg: 'calendar-3',--%>
                             <%--stepImgStyle: 'width: auto;'--%>
                             <%--},--%>
                             <%--{--%>
                             <%--stepId: 4,--%>
                             <%--stepText: '将获取到的【AgentID】粘贴到【应用ID】中，并点击【确定】按钮。',--%>
                             <%--stepImg: 'calendar-4',--%>
                             <%--stepImgStyle: 'height: auto;margin-top: 30px;'--%>
                             <%--}*/--%>
                        <%--]--%>
                    <%--},--%>
                    <%--{--%>
                        <%--moduleId: 'diary',--%>
                        <%--steps: [--%>
                            <%--{--%>
                                <%--stepId: 1,--%>
                                <%--stepText: '点击导航栏【微应用】下的【新增微应用】按钮。在“新增微应用”界面中填写内容。【后台地址】可不填写，【首页地址】需要先填写为http://www.tongda2000.com。',--%>
                                <%--stepImg: 'diary-1',--%>
                                <%--stepImgStyle: 'width:auto;'--%>
                            <%--},--%>
                            <%--{--%>
                                <%--stepId: 2,--%>
                                <%--stepText: '点击【微应用】下新增应用【工作日志】的“设置”按钮，在工作日志设置界面中，将获取到的【AgentID】粘贴到上方【应用ID】内，并点击【确定】按钮。在上方【应该ID】保存成功后，把【首页地址】中的http://www.tongda2000.com删除，将上方【URL】复制到【首页地址】中。',--%>
                                <%--stepImg: 'diary-2',--%>
                                <%--stepImgStyle: ''--%>
                            <%--},--%>
                            <%--/*{--%>
                             <%--stepId: 3,--%>
                             <%--stepText: '点击【微应用】下新增应用【工作日志】的“设置”按钮，在工作日志设置界面中将【首页地址】中的http://www.tongda2000.com删除，把上一步骤生成的短链接粘贴进去。',--%>
                             <%--stepImg: 'diary-3',--%>
                             <%--stepImgStyle: 'width: auto;'--%>
                             <%--},--%>
                             <%--{--%>
                             <%--stepId: 4,--%>
                             <%--stepText: '将获取到的【AgentID】粘贴到【应用ID】中，并点击【确定】按钮。',--%>
                             <%--stepImg: 'diary-4',--%>
                             <%--stepImgStyle: 'height: auto;margin-top: 30px;'--%>
                             <%--}*/--%>
                        <%--]--%>
                    <%--},--%>
                    <%--{--%>
                        <%--moduleId: 'publicfolder',--%>
                        <%--steps: [--%>
                            <%--{--%>
                                <%--stepId: 1,--%>
                                <%--stepText: '点击导航栏【微应用】下的【新增微应用】按钮。在“新增微应用”界面中填写内容。【后台地址】可不填写，【首页地址】需要先填写为http://www.tongda2000.com。',--%>
                                <%--stepImg: 'folder-1',--%>
                                <%--stepImgStyle: 'width:auto;'--%>
                            <%--},--%>
                            <%--{--%>
                                <%--stepId: 2,--%>
                                <%--stepText: '点击【微应用】下新增应用【公共文件柜】的“设置”按钮，在公共文件柜设置界面中，将获取到的【AgentID】粘贴到上方【应用ID】内，并点击【确定】按钮。在上方【应该ID】保存成功后，把【首页地址】中的http://www.tongda2000.com删除，将上方【URL】复制到【首页地址】中。',--%>
                                <%--stepImg: 'folder-2',--%>
                                <%--stepImgStyle: ''--%>
                            <%--},--%>
                            <%--/*{--%>
                             <%--stepId: 3,--%>
                             <%--stepText: '点击【微应用】下新增应用【公共文件柜】的“设置”按钮，在公共文件柜设置界面中将【首页地址】中的http://www.tongda2000.com删除，把上一步骤生成的短链接粘贴进去。',--%>
                             <%--stepImg: 'folder-3',--%>
                             <%--stepImgStyle: 'width: auto;'--%>
                             <%--},--%>
                             <%--{--%>
                             <%--stepId: 4,--%>
                             <%--stepText: '将获取到的【AgentID】粘贴到【应用ID】中，并点击【确定】按钮。',--%>
                             <%--stepImg: 'folder-4',--%>
                             <%--stepImgStyle: 'height: auto;margin-top: 30px;'--%>
                             <%--}*/--%>
                        <%--]--%>
                    <%--},--%>
                    <%--{--%>
                        <%--moduleId: 'picture',--%>
                        <%--steps: [--%>
                            <%--{--%>
                                <%--stepId: 1,--%>
                                <%--stepText: '点击导航栏【微应用】下的【新增微应用】按钮。在“新增微应用”界面中填写内容。【后台地址】可不填写，【首页地址】需要先填写为http://www.tongda2000.com。',--%>
                                <%--stepImg: 'picture-1',--%>
                                <%--stepImgStyle: 'width:auto;'--%>
                            <%--},--%>
                            <%--{--%>
                                <%--stepId: 2,--%>
                                <%--stepText: '点击【微应用】下新增应用【图片浏览】的“设置”按钮，在图片浏览设置界面中，将获取到的【AgentID】粘贴到上方【应用ID】内，并点击【确定】按钮。在上方【应该ID】保存成功后，把【首页地址】中的http://www.tongda2000.com删除，将上方【URL】复制到【首页地址】中。',--%>
                                <%--stepImg: 'picture-2',--%>
                                <%--stepImgStyle: ''--%>
                            <%--},--%>
                            <%--/*{--%>
                             <%--stepId: 3,--%>
                             <%--stepText: '点击【微应用】下新增应用【图片浏览】的“设置”按钮，在图片浏览设置界面中将【首页地址】中的http://www.tongda2000.com删除，把上一步骤生成的短链接粘贴进去。',--%>
                             <%--stepImg: 'picture-3',--%>
                             <%--stepImgStyle: 'width: auto;'--%>
                             <%--},--%>
                             <%--{--%>
                             <%--stepId: 4,--%>
                             <%--stepText: '将获取到的【AgentID】粘贴到【应用ID】中，并点击【确定】按钮。',--%>
                             <%--stepImg: 'picture-4',--%>
                             <%--stepImgStyle: 'height: auto;margin-top: 30px;'--%>
                             <%--}*/--%>
                        <%--]--%>
                    <%--},--%>
                    <%--{--%>
                        <%--moduleId: 'salary',--%>
                        <%--steps: [--%>
                            <%--{--%>
                                <%--stepId: 1,--%>
                                <%--stepText: '点击导航栏【微应用】下的【新增微应用】按钮。在“新增微应用”界面中填写内容。【后台地址】可不填写，【首页地址】需要先填写为http://www.tongda2000.com。',--%>
                                <%--stepImg: 'wage-1',--%>
                                <%--stepImgStyle: 'width:auto;'--%>
                            <%--},--%>
                            <%--{--%>
                                <%--stepId: 2,--%>
                                <%--stepText: '点击【微应用】下新增应用【工资条查询】的“设置”按钮，在工资条查询设置界面中，将获取到的【AgentID】粘贴到上方【应用ID】内，并点击【确定】按钮。在上方【应该ID】保存成功后，把【首页地址】中的http://www.tongda2000.com删除，将上方【URL】复制到【首页地址】中。',--%>
                                <%--stepImg: 'wage-2',--%>
                                <%--stepImgStyle: ''--%>
                            <%--},--%>
                            <%--/*{--%>
                             <%--stepId: 3,--%>
                             <%--stepText: '点击【微应用】下新增应用【工资条查询】的“设置”按钮，在工资条查询设置界面中将【首页地址】中的http://www.tongda2000.com删除，把上一步骤生成的短链接粘贴进去。',--%>
                             <%--stepImg: 'wage-3',--%>
                             <%--stepImgStyle: 'width: auto;'--%>
                             <%--},--%>
                             <%--{--%>
                             <%--stepId: 4,--%>
                             <%--stepText: '将获取到的【AgentID】粘贴到【应用ID】中，并点击【确定】按钮。',--%>
                             <%--stepImg: 'wage-4',--%>
                             <%--stepImgStyle: 'height: auto;margin-top: 30px;'--%>
                             <%--}*/--%>
                        <%--]--%>
                    <%--},--%>
                    <%--{--%>
                        <%--moduleId: 'meeting',--%>
                        <%--steps: [--%>
                            <%--{--%>
                                <%--stepId: 1,--%>
                                <%--stepText: '点击导航栏【微应用】下的【新增微应用】按钮。在“新增微应用”界面中填写内容。【后台地址】可不填写，【首页地址】需要先填写为http://www.tongda2000.com。',--%>
                                <%--stepImg: 'meeting-1',--%>
                                <%--stepImgStyle: 'width:auto;'--%>
                            <%--},--%>
                            <%--{--%>
                                <%--stepId: 2,--%>
                                <%--stepText: '点击【微应用】下新增应用【会议申请】的“设置”按钮，在工资条查询设置界面中，将获取到的【AgentID】粘贴到上方【应用ID】内，并点击【确定】按钮。在上方【应该ID】保存成功后，把【首页地址】中的http://www.tongda2000.com删除，将上方【URL】复制到【首页地址】中。',--%>
                                <%--stepImg: 'meeting-2',--%>
                                <%--stepImgStyle: ''--%>
                            <%--}--%>
                        <%--]--%>
                    <%--},--%>
                    <%--{--%>
                        <%--moduleId: 'vote',--%>
                        <%--steps: [--%>
                            <%--{--%>
                                <%--stepId: 1,--%>
                                <%--stepText: '点击导航栏【微应用】下的【新增微应用】按钮。在“新增微应用”界面中填写内容。【后台地址】可不填写，【首页地址】需要先填写为http://www.tongda2000.com。',--%>
                                <%--stepImg: 'vote-1',--%>
                                <%--stepImgStyle: 'width:auto;'--%>
                            <%--},--%>
                            <%--{--%>
                                <%--stepId: 2,--%>
                                <%--stepText: '点击【微应用】下新增应用【投票管理】的“设置”按钮，在工资条查询设置界面中，将获取到的【AgentID】粘贴到上方【应用ID】内，并点击【确定】按钮。在上方【应该ID】保存成功后，把【首页地址】中的http://www.tongda2000.com删除，将上方【URL】复制到【首页地址】中。',--%>
                                <%--stepImg: 'vote-2',--%>
                                <%--stepImgStyle: ''--%>
                            <%--}--%>
                        <%--]--%>
                    <%--},--%>
                    <%--{--%>
                        <%--moduleId: 'sns',--%>
                        <%--steps: [--%>
                            <%--{--%>
                                <%--stepId: 1,--%>
                                <%--stepText: '点击导航栏【微应用】下的【新增微应用】按钮。在“新增微应用”界面中填写内容。【后台地址】可不填写，【首页地址】需要先填写为http://www.tongda2000.com。',--%>
                                <%--stepImg: 'sns-1',--%>
                                <%--stepImgStyle: 'width:auto;'--%>
                            <%--},--%>
                            <%--{--%>
                                <%--stepId: 2,--%>
                                <%--stepText: '点击【微应用】下新增应用【企业社区】的“设置”按钮，在工资条查询设置界面中，将获取到的【AgentID】粘贴到上方【应用ID】内，并点击【确定】按钮。在上方【应该ID】保存成功后，把【首页地址】中的http://www.tongda2000.com删除，将上方【URL】复制到【首页地址】中。',--%>
                                <%--stepImg: 'sns-2',--%>
                                <%--stepImgStyle: ''--%>
                            <%--}--%>
                        <%--]--%>
                    <%--},--%>
                    <%--{--%>
                        <%--moduleId: 'filefolder',--%>
                        <%--steps: [--%>
                            <%--{--%>
                                <%--stepId: 1,--%>
                                <%--stepText: '点击导航栏【微应用】下的【新增微应用】按钮。在“新增微应用”界面中填写内容。【后台地址】可不填写，【首页地址】需要先填写为http://www.tongda2000.com。',--%>
                                <%--stepImg: 'file-folder-1',--%>
                                <%--stepImgStyle: 'width:auto;'--%>
                            <%--},--%>
                            <%--{--%>
                                <%--stepId: 2,--%>
                                <%--stepText: '点击【微应用】下新增应用【个人文件柜】的“设置”按钮，在个人文件柜设置界面中，将获取到的【AgentID】粘贴到上方【应用ID】内，并点击【确定】按钮。在上方【应该ID】保存成功后，把【首页地址】中的http://www.tongda2000.com删除，将上方【URL】复制到【首页地址】中。',--%>
                                <%--stepImg: 'file-folder-2',--%>
                                <%--stepImgStyle: ''--%>
                            <%--}--%>
                        <%--]--%>
                    <%--}--%>
                <%--];--%>

                <%--$('#app_slides').html("");--%>
                <%--$.each(ddAppData, function(k, m){--%>
                    <%--if(m.moduleId == cur_app){--%>
                        <%--$('#appTmpl').tmpl(m.steps).appendTo('#app_slides');--%>
                    <%--}--%>
                <%--});--%>
                <%--$('.banner').removeClass("hide");--%>
                <%--$('.banner').unslider({--%>
                    <%--speed: 500,--%>
                    <%--delay: false,--%>
                    <%--complete: function() {},--%>
                    <%--keys: true,--%>
                    <%--dots: true,--%>
                    <%--fluid: false,--%>
                    <%--arrows: true,--%>
                    <%--prev: '<',--%>
                    <%--next: '>'--%>
                <%--});--%>
            <%--});--%>
        <%--})(jQuery);--%>
    <%--</script>--%>
    <%--<script id="appTmpl" type="text/x-jquery-tmpl">--%>
<%--&lt;%&ndash;<li>&ndash;%&gt;--%>
	<%--&lt;%&ndash;<div class="slide_wrapper">&ndash;%&gt;--%>
		<%--&lt;%&ndash;<div class="slide_title"><strong>第${stepId}步：</strong>${stepText}</div>&ndash;%&gt;--%>
		<%--&lt;%&ndash;<div class="slide_img">&ndash;%&gt;--%>
			<%--&lt;%&ndash;<img style="${stepImgStyle}" src="/static/modules/weixinqy/images/dingding/${stepImg}.png">&ndash;%&gt;--%>
		<%--&lt;%&ndash;</div>&ndash;%&gt;--%>
	<%--&lt;%&ndash;</div>&ndash;%&gt;--%>
<%--&lt;%&ndash;</li>&ndash;%&gt;--%>
<%--</script>--%>
    <%--<div class="banner hide">--%>
        <%--<ul id="app_slides">--%>
        <%--</ul>--%>
    <%--</div></div>--%>
</body>
</html>