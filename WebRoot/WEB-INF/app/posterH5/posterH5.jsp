<%--
  Created by IntelliJ IDEA.
  User: 94216
  Date: 2022/3/2
  Time: 10:51
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="utf-8">
    <title>海报信息录入</title>
    <meta name="renderer" content="webkit">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=0">
    <link rel="stylesheet" href="/lib/layui/layui/css/layui.css?20220302">
    <script src="/lib/layui/layui/layui.js"></script>
    <script type="text/javascript" src="/lib/layui/layui/global.js"></script>
    <script type="text/javascript" src="../../js/xoajq/xoajq1.js"></script>

</head>
<body>
<div id="first" >
    <blockquote class="layui-elem-quote layui-text">
        海报信息录入
    </blockquote>
<div class="layui-container">
<form class="layui-form" action="" style="margin-top: 5%;margin-left: -2%">
    <div class="layui-form-item">
        <label class="layui-form-label layui-font-12">单位名称</label>
        <div class="layui-input-block" style="width: 60%">
            <input name="unitname"  autocomplete="off" placeholder="请输入单位名称" class="layui-input">
        </div>
    </div>
    <div class="layui-form-item">
        <label class="layui-form-label layui-font-12">展位</label>
        <div class="layui-input-block" style="width: 60%">
            <input type="text" name="booth" placeholder="请输入展位" autocomplete="off" class="layui-input">
        </div>
    </div>
    <div class="layui-form-item">
        <label class="layui-form-label layui-font-12">单位图标</label>
        <div class="layui-input-block" style="width: 60%">
           <div id="fujians"></div>
           <div id="fileAll" style="width: 80%"></div>
          <button type="button" class="layui-btn layui-btn-primary " id="fileupload" style="border: 0px;color:#3870d7;padding: 0;">
          <img src="/img/icon_uplod.png" style="margin-right: 5px;">
         <i style="display: none" id="icon" class="layui-icon"></i>图片上传</button>
        </div>
    </div>
</form>
    <div  style="width:100%;display: flex;justify-content: space-around">
            <button class="layui-btn" id="submit" data-type="loading">提交</button>
    </div>
</div>
</div>
<div id="second" style="display: none">
        <blockquote class="layui-elem-quote layui-text">
        <button class="layui-btn layui-btn-sm" id="back">返回</button>
            <button class="layui-btn  layui-btn-sm" id="download" style="float: right">下载图片</button>
            <button class="layui-btn  layui-btn-sm" id="download1" style="float: right">长按存储或共享图片</button>
        </blockquote>
    <div class="layui-container">
    <div  style="width:100%;display: flex;justify-content: space-around;margin-top: 3%">

    </div>
    <div id="img" style="width:auto;height: auto;margin-top: 3%">
    </div>
</div>
</div>
</body>
<script>
    if ((( /(iPhone|iPad|iPod|iOS)/i.test(navigator.userAgent) ) || /(Android)/i.test(navigator.userAgent))) {
        $('#download').css('display','none')
        $('#download1').css('display','block')
        $('.deImgs').css('width','8%')
    }else{
        $('#img').css({'width':'440px','height':'525px','margin':'0 auto'})
        $('#img1').css({'display':'block','margin':'0 auto','width':'','height':''})
        $('#download1').css({'display':'block','margin':'0 auto','width':'','height':''})
        $('#download').css('display','block')
        $('#download1').css('display','none')
        $('.deImgs').css('width','3%')
    }
    var attachmentPath;


    layui.use(['form', 'table','laydate','upload','laypage','element'], function(){
        form = layui.form
            ,table = layui.table
            ,element = layui.element
            ,laydate=layui.laydate
            ,upload = layui.upload;
        var laypage = layui.laypage;

        //图片上传
        upload.render({
            elem: '#fileupload'
            ,url: '/poster/upload' //上传接口
            ,accept: 'images' //普通文件
            ,done: function(res){
                var str = '';
                var data = res.data;
                attachmentPath = data.attachmentPath
                var fileExtension=data.attachmentName.substring(data.attachmentName.lastIndexOf(".")+1,data.attachmentName.length);//截取附件文件后缀
                var attName = encodeURI(data.attachmentName).replace(/\+/g, "%2b").replace(/\@/g,"%40").replace(/\#/g,"%23").replace(/\&/g,"%26").replace(/\//g,"%2F").replace(/\?/g,"%3F").replace(/\￥/g,"%ef%bf%a5").replace(/\$/g,"%24").replace(/\！/g,"%ef%bc%81").replace(/\（/g,"%ef%bc%88").replace(/\）/g,"%ef%bc%89").replace(/\…/g,"%e2%80%a6%e2%80%a6");
                var fileExtensionName=attName.substring(0,attName.lastIndexOf("."));
                var deUrl = data.attachmentPath.split('&ATTACHMENT_NAME=')+fileExtensionName+"."+fileExtension+"&FILESIZE="+data.attachmentSize;
                str += '<div class="dech" deUrl="' + deUrl+ '"><a  NAME="' + data.attachmentName + '*" style="text-decoration:none;margin-left:5px;">' + data.attachmentName + '</a><img class="deImgs" style="margin-left:5px;cursor: pointer;" src="/img/file/icon_deletecha_03.png"/><input type="hidden" class="inHidden" value="' + data.aid + '@' + data.ym + '_' + data.attachId + ',"></div>';
                $('#fileAll').append(str);
            $('#fileupload').css('display','none')
            }
        })

        $(document).on('click', '#fileAll .deImgs', function () {
            $('#fileAll').html('');
            $('#fileupload').css('display','block')

        })

        $('#back').click(function(){
            $('#first').css('display','block')
            $('#second').css('display','none')
            document.title='海报信息录入'
        })
        $('#download1').click(function(){
            layer.msg('长按保存图片',{icon:6});
        })
        $('#download').click(function(){
            layer.msg('右键图片点击保存',{icon:6});
        })
        <%--提交--%>
        $('#submit').click(function(){
            if($('[name="unitname"]').val() == ''){
                layer.msg('请输入单位名称！',{icon:2});
                return false;
            }else if($('[name="booth"]').val() == ''){
                layer.msg('请输入展位！',{icon:2});
                return false;
            }else if(!$('#fileAll').html()){
                layer.msg('请提交图片',{icon:2});
                return false;
            }
            var unitname = $('[name="unitname"]').val()
            var booth = $('[name="booth"]').val()
            $.ajax({
                url:'/poster/posterGenerate',//url
                data:{
                    companyName:unitname,
                    booth:booth,
                    attachmentPath:attachmentPath
                },
                dataType:'json',
                type:'get',
                beforeSend:function() {
                    document.title='海报图片下载'
                    layer.load(0, { //icon支持传入0-2
                        shade: [0.3, '#000'], //0.5透明度的灰色背景
                        content: '图片加载中...',
                        success: function (layero) {
                            layero.find('.layui-layer-content').css({
                                'paddingTop': '40px',
                                'width': '100%',
                            });
                        }
                    });
                },
                complete: function () {  //load默认不会关闭，请求完成需要在complete回调中关闭
                    setTimeout( function(){
                        layer.closeAll();
                    } ,2000)
                    $('#first').css('display','none')
                    $('#second').css('display','block')
                },
                success:function(res){
                        var strr = '<img id="img1" style="height:auto;width:100%"  src="/xs?' + res.object.attUrl + '">'
                        $('#img').html(strr);
                }
            })
        })

    })
</script>
</html>
