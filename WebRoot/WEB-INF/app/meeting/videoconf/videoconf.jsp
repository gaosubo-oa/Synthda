<%--
  Created by IntelliJ IDEA.
  User: gaosubo3000
  Date: 2020/12/15
  Time: 17:30
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>视频会议设置</title>
    <link rel="stylesheet" type="text/css" href="/lib/layui/layui/css/layui.css?20210319.1"/>
    <script type="text/javascript" src="/js/xoajq/xoajq1.js"></script>
    <script src="/js/base/base.js" type="text/javascript" charset="utf-8"></script>
    <script src="../../js/jquery/jquery.cookie.js"></script>
    <script src="/lib/jQuery-File-Upload-master/jquery-ui.js" type="text/javascript" charset="utf-8"></script>
    <script src="/lib/jQuery-File-Upload-master/jquery.iframe-transport.js" type="text/javascript" charset="utf-8"></script>
    <script src="/lib/jQuery-File-Upload-master/jquery.fileupload.js" type="text/javascript" charset="utf-8"></script>
    <script type="text/javascript" src="/js/common/fileupload.js"></script>
    <script type="text/javascript" src="/lib/layui/layui/layui.js"></script>
    <script type="text/javascript" src="/lib/layui/layui/layui.all.js"></script>
</head>
<style>
    .content{
        width: 80%;
        margin: 20px auto;
    }
    .headText{
        background: cornflowerblue !important;
        color: white;
    }
    .qutitle{
        font-weight: bold;
    }
    input{
        width: 200px;
    }
    .layui-input, .layui-textarea{
        display: inline-block;
        width: 40%;
    }
</style>
<body>
<div class="content">
    <form class="layui-form" action="" lay-filter="formTest" >
        <table class="layui-table">
            <colgroup>
                <col width="27%">
                <col>
            </colgroup>
            <thead>
            <tr class="headText">
                <th colspan="2"><h3>视频会议设置</h3></th>
            </tr>
            </thead>
            <tbody>
            <tr>
                <td colspan="2" class="qutitle">
                    <input type="radio"  value="1" name="confType" title="腾讯云会议" confId="" checked>
                </td>
            </tr>
            <tr>
                <td class="tdRight">appId</td>
                <td>
                    <input type="text" name="companyId0" class="layui-input" style="width: 230px;">
                </td>
            </tr>
            <tr>
                <td class="tdRight">appkey</td>
                <td>
                    <input type="text" name="server0" class="layui-input" style="width: 230px;">
                </td>
            </tr>
            <tr>
                <td colspan="2" class="qutitle">
                    <input type="radio" value="2" name="confType" title="全视通" confId="">
                </td>
            </tr>
            <tr>
                <td class="tdRight">服务器设置</td>
                <td>
                    <input type="text" name="server1" class="layui-input" style="width: 230px;">
                    <span>如： http://127.0.0.1:8080</span>
                </td>

            </tr>
            <tr>
                <td class="tdRight">企业ID</td>
                <td>
                    <input type="text" name="companyId1" class="layui-input" style="width: 230px;">
                </td>
            </tr>

            </tbody>
        </table>
        <div style="display: flex;justify-content: center;margin-top: 20px">
            <button type="button" class="layui-btn" lay-submit lay-filter="saveBtn">保存</button>
        </div>

    </form>
</div>
</body>
<script>
    layui.use(['form'], function(){
        var form = layui.form;

        //回显
        $.get('/video/getvideo',function (res) {
            var obj = res.object;
            for (let i = 0; i < obj.length; i++) {

                $('input[type="radio"]').eq(i).attr('confId',obj[i].id);

                $('input[name="server'+ i +'"]').val(obj[i].server);
                $('input[name="companyId'+ i +'"]').val(obj[i].companyId);
                if (obj[i].confType && obj[i].confType != ''){
                    form.val("formTest", {
                        "confType": obj[i].confType
                    });
                }
            }
        });


        form.on('submit(saveBtn)', function(data){
            var confType = $('input[name="confType"]:checked').val();

            $('input[type="radio"]').each(function (index,item) {
                var field = {
                    id:$(this).attr('confid')
                    ,server: $('input[name="server'+ index +'"]').val()
                    ,companyId: $('input[name="companyId'+ index +'"]').val()
                };

                if (field.id == confType ){
                    field.confType = confType
                }
                else{
                    field.confType = ''
                }

                $.post('/video/editvideo',field,function(res){

                });
            });
            layer.msg('保存成功');
            return false;
        });

        form.render();
    });
</script>
</html>
