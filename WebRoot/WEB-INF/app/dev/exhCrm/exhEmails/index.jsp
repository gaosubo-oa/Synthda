
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@taglib prefix="mvc" uri="http://www.springframework.org/tags/form" %>
<%@taglib prefix="fmt" uri="http://www.springframework.org/tags" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE html>
<html>
<head lang="en">
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <title>发送手机短信</title>
    <link rel="stylesheet" href="/lib/pagination/style/pagination.css">
    <link rel="stylesheet" href="/css/base/base.css?20201106.1">
    <link rel="stylesheet" href="/css/notice/noticeManagement.css">
    <script src="/js/common/language.js"></script>
    <script type="text/javascript" src="/js/xoajq/xoajq3.js"></script>
    <script type="text/javascript" src="/js/jquery/jquery-migrate-3.4.0.js"></script>
    <script type="text/javascript" src="/js/base/tablePage.js"></script>
    <script src="/lib/jQuery-File-Upload-master/jquery-ui.js" type="text/javascript" charset="utf-8"></script>
    <script src="/lib/jQuery-File-Upload-master/jquery.iframe-transport.js" type="text/javascript" charset="utf-8"></script>
    <script src="/lib/jQuery-File-Upload-master/jquery.fileupload.js" type="text/javascript" charset="utf-8"></script>
    <script src="/js/base/base.js"></script>
    <script src="/lib/laydate/laydate.js"></script>
    <script src="/js/jquery/jquery.form.min.js"></script>
    <script src="/lib/pagination/js/jquery.pagination.min.js" type="text/javascript" charset="utf-8"></script>
    <script src="/js/ajaxupload.js" type="text/javascript" charset="utf-8"></script>
    <script src="/js/jquery/jquery.cookie.js"></script>
    <link rel="stylesheet" type="text/css" href="/css/commonTheme/${sessionScope.InterfaceModel}/commonTheme.css"/>
    <script type="text/javascript" src="/lib/layui/layui/global.js?20201229.1"></script>
    <style>
        table tbody td{
            text-align: left;
            padding: 10px;
            box-sizing: border-box;
        }
        table tbody td.color{
            padding:10px 10px 10px 120px;
        }
        input{
            float: none;
        }
        .editAndDelete3{
            color: red;
        }
        .color{
            font-size: 11pt;
            color: #2a588c;
            font-weight: bold;
        }
        table tbody td textarea{
            width: 70%;
            height: 120px;
            line-height: 34px;
            padding-left: 10px;
            outline: none;
            border-radius: 4px;
            vertical-align: middle;
            font-family:"Microsoft Yahei";
            margin:20px 0px 10px 30px;
        }
        table tbody td a{
            vertical-align: middle;
            font-size: 11pt;
        }
        table tbody td select{
            width: 119px;
            height: 28px;
            border-radius: 4px;
        }
        table tbody td input[type=text]{
            width: 288px;
            height: 32px;
            border-radius: 4px;
            box-sizing: border-box;
            padding: 5px;
        }
        .btnsava{
            padding:10px 15px;
            border-radius: 4px;
            background: #2F8AE3;
            color: #fff;
            font-size: 16px;
        }
        .btnsava2{
            padding:10px 15px;
            border-radius: 4px;
            background: #fff;
            border: 1px solid #ccc;
            font-size: 16px;
        }
        .pagediv .page-bottom-outer-layer table td{
            text-align: left;
        }
        .pagediv .page-bottom-outer-layer table td:last-child{
            border-right: 1px #dddddd solid;
        }
        .editAndDelete2{
            color: red;
        }
        .delete_check {
            display: inline-block;
            width: 70px;
            height: 28px;
            position: relative;
            color: #ffffff;
            border-radius: 3px;
            background: #2b7fe0;
            text-align: center;
            line-height: 28px;
            margin-left: 20px;
        }
        .bar {
            height: 18px;
            background: green;
        }

        .query{
            width: 70%;
        }
        .file {
            position: relative;
            display: inline-block;
            background: #D0EEFF;
            border: 1px solid #99D3F5;
            border-radius: 4px;
            padding: 4px 10px;
            overflow: hidden;
            color: #1E88C7;
            text-decoration: none;
            text-indent: 0;
            line-height: 20px;
        }
        .file input {
            position: absolute;
            font-size: 100px;
            right: 0;
            top: 0;
            opacity: 0;
        }
        .file:hover {
            border-color: #78C3F3;
            color: #004974;
            text-decoration: none;
        }

        /*table tr.borderNone{*/
        /*border:none;*/
        /*}*/
    </style>
    <%--<script src="/js/learningExperience/LearningExperienceQuery.js"></script>--%>
</head>
<body >
<div class="navigation">
    <img src="/img/phone.png" alt="" style="width: 30px;margin-right: -9px">
    <h2>发送手机短信</h2>
</div>
<div class="query">
        <div class="header">发送手机短信</div>
    <form id="uploadForm" method="post" action="/exhEmil/smsSenderMobiles" enctype="multipart/form-data" >
        <table style="width: 100%;    border: 1px solid #c0c0c0;border-top: none;">
            <tbody>
            <tr class="borderNone">
                <td width="25%" class="color">收信人：</td>
                <td align="center" style="border: 1px solid #ddd">
                <td width="75%">
                <textarea type="text" id="mobiles" cols="30" rows="10"></textarea>
                    <a class="file" style="color: #0088cc;font-size: 13pt;margin-left: 15px;" id="importBtn" lay-event="importBtn">导入</a>
<%--                    <a class="file" href="../file/exhCrm/手机号导入模板.xls" style="color: #0088cc;font-size: 10pt;margin-left: 2px;">导出</a>--%>
                    <div style="margin-left: 30px;font-size: 11pt;margin-bottom: 20px">提示：发送多人可用英文逗号拼接</div>
                </td>
            </tr>

            <tr class="borderNone">
                <td width="25%" class="color">短信内容：</td>
                <td align="center" style="border: 1px solid #ddd">
                <td width="75%">

                    <textarea style="height: 220px;width: 70%;line-height: 17px;margin:20px 30px" name="content"   id="content" cols="30" rows="10"></textarea>

                </td>
            </tr>
            <tr class="borderNone">
                <td colspan="4" style="text-align: center;padding: 20px">
                    <a href="javascript:;"  class="btnsava send">发送</a>
                    <a href="javascript:;" style="margin-left: 10px"  class="btnsava2 clear">清空内容</a>
                </td>
            </tr>
            </tbody>
        </table>
    </form>
</div>
<div id="pagediv" style="visibility:hidden;">

</div>
<script>
    layui.use(['form', 'table', 'element', 'layedit','eleTree','upload'], function () {
        var table = layui.table
        var form = layui.form
        var element = layui.element
        var upload = layui.upload
        var layedit = layui.layedit
        var eleTree = layui.eleTree;
        form.render()

        //导入按钮功能
        $('#importBtn').on("click", function () {
            layer.open({
                type: 1,
                area: ['531px', '372px'], //宽高
                title: '导入数据',
                maxmin: true,
                btn: ['确定'], //可以无限个按钮
                content: '<div id="importBox" style="margin: 43px auto;">' +
                    '<form class="layui-form" action="">\n' +
                    '  <div class="layui-form-item">\n' +
                    '    <label class="layui-form-label" style="width: 30%;">下载导入模板：</label>\n' +
                    '    <div class="layui-input-block">\n' +
                    '      <a class="layui-form-mid" id="load" style="text-decoration: underline; color: blue; cursor: pointer">下载模板</a>\n' +
                    '    </div>\n' +
                    '  </div>\n' +
                    '  <div class="layui-form-item">\n' +
                    '    <label class="layui-form-label" style="width: 30%;">选择导入文件：</label>\n' +
                    '    <div class="layui-input-inline" style="width: 87px;">\n' +
                    '      <button type="button" class="layui-btn layui-btn-sm" id="test1">\n' +
                    '       <i class="layui-icon">&#xe67c;</i>上传文件\n' +
                    '       </button>' +
                    '    </div>\n' +
                    '    <div class="layui-form-mid layui-word-aux" id="textfilter">未选择文件</div>\n' +
                    '  </div>' +
                    '  <div class="layui-form-item">\n' +
                    '    <label class="layui-form-label" style="width: 30%;">格式说明：</label>\n' +
                    '    <div class="layui-form-mid layui-word-aux">1.导入数据源支持xls格式和xlsx</div>\n' +
                    '  </div>' +
                    '</form>' +
                    '</div>',
                success: function () {
                    // 下载模板
                    $('#load').on('click', function () {
                        window.location.href = encodeURI("../file/exhCrm/手机号导入模板.xls")
                    })
                    //上传
                    //执行实例
                    var uploadInst = upload.render({
                        elem: '#test1' //绑定元素
                        , url: '/exhEmil/insertImport' //上传接口
                        , accept: 'file'
                        , auto: false
                        , bindAction: '.layui-layer-btn0'
                        // ,data:{tableName:data.dName}
                        , choose: function (obj) {
                            //将每次选择的文件追加到文件队列
                            var files = obj.pushFile();
                            obj.preview(function (index, file, result) {
                                $("#textfilter").text(file.name);
                            });
                        }
                        , done: function (res) {
                            //上传完毕回调
                            if (res.flag) {
                                layer.msg('导入成功', {icon: 1})
                                $("#mobiles").val(res.msg)
                                // window.location.reload();
                            } else {
                                layer.msg('导入失败', {icon: 2})
                            }
                        }
                        , error: function () {
                            //请求异常回调
                            layer.msg("请上传正确的附件信息");
                        }
                    });
                },
                yes: function (index, layero) {
                    layer.close(index);
                }
            });
        });
    })

</script>
<script type="text/javascript">
    $('.clear').on('click',function () {
        $('#mobiles').val('');
        $('#content').val('');

        window.location.reload()
    })

    //发送
    $('.send').on('click',function () {
        var mobiles =$("#mobiles").val();//短信内容
        var content =$("#content").val();//短信内容
        if ($('#mobiles').val() == '') {
            //内外部收件人都展示的情况
            $.layerMsg({content: "请选择收件人！", icon: 2}, function () {
            });
            return;
        }else if($('#mobiles').val() != '' &&  content=='' ){
            //选择了内部收件人，但内部收件人短信内容为空时
            $.layerMsg({content: "内部收件人短信内容不能为空！", icon: 2}, function () {
            });
            return;

        }

        $('#uploadForm').ajaxSubmit({
            dataType: 'json',
            data: {
                // content: content,//发送内容
                mobiles:mobiles,
            },
            success: function (res) {
                console.log(res,99999)
                if (res.flag) {
                    $.layerMsg({content: "发送成功！", icon: 1}, function () {
                        $(".clear").trigger('click');
                        window.location.reload()

                    });
                } else {
                    $.layerMsg({content: "发送失败！", icon: 2}, function () {

                    });
                }
            }
        })
    })


</script>
</body>
</html>