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
<style>
    .layui-form-checkbox[lay-skin=primary]{
        height: 0!important;
    }
    .layui-unselect span{
        color: blue !important;
    }
</style>
<body>
<div id="first" >
    <blockquote class="layui-elem-quote layui-text">
        请填写您的参会信息，然后点击提交按钮，我们会为您生成参会海报
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
        <label class="layui-form-label layui-font-12">展位号</label>
        <div class="layui-input-block" style="width: 60%">
            <input type="text" name="booth" placeholder="例如：C-215B" autocomplete="off" class="layui-input">
            <span style="color: red">未预定展位不填</span>
        </div>
    </div>
    <div class="layui-form-item" style="margin-left: 11%;" >
        <input type="checkbox" name="like1[read]" lay-skin="primary"  title="我还参与了论坛，也想宣传一下">
        <div id="heihei" style="border: 1px solid lightgray;display:none;width: auto;height: auto;margin-left: -35px">
                <div class="layui-inline" style="margin: 2% 0 2% 0">
                    <label class="layui-form-label">日期</label>
                    <div class="layui-input-block" style="width: 60%">
                        <input type="text" class="layui-input" id="test1" placeholder="设定日期">
                    </div>
                </div>
                <div class="layui-inline"  style="margin: 2% 0 2% 0">
                        <label class="layui-form-label">时间段</label>
                        <div class="layui-input-inline" style="width: 60%">
                            <select name="status" id="forumTimeSlot" lay-verify="required" >
                                <option value="">请选择</option>
                                <option value="上午">上午</option>
                                <option value="下午">下午</option>
                                <option value="全天">全天</option>
                            </select>
                        </div>
                </div>
                <div class="layui-inline"  style="margin: 2% 0 2% 0">
                    <label class="layui-form-label">论坛地点</label>
                    <div class="layui-input-block" style="width: 60%">
                        <input type="text" name="place" id="place" maxlength=14 placeholder="例如：多功能厅，205会议厅" autocomplete="off" class="layui-input">
                    </div>
                </div>
                <div class="layui-inline"  style="margin: 2% 0 2% 0">
                    <label class="layui-form-label">论坛名称</label>
                    <div class="layui-input-block" style="width: 60%">
                        <textarea type="text" name="forumname" id="forumname" maxlength=35 style="height: 7%" placeholder="请输入论坛名称" autocomplete="off" class="layui-input"></textarea>
                    </div>
                </div>
        </div>
    </div>
    <div class="layui-form-item" style="padding-left: 25px">
        <label class="layui-form-label layui-font-12" style="width: 96px">单位图标(logo)</label>
        <div class="layui-input-block" style="width: 60%">
           <div id="fujians"></div>
           <div id="fileAll" style="width: 80%"></div>
          <button type="button" class="layui-btn layui-btn-primary " id="fileupload" style="border: 0px;color:#3870d7;padding: 0;">
          <img src="/img/icon_uplod.png" style="margin-right: 5px;">
         <i style="display: none" class="layui-icon"></i>图片上传</button>
        </div>
    </div>
</form>
    <div  style="width:100%;display: flex;justify-content: space-around">
            <button class="layui-btn" id="submit">提交</button>
    </div>
</div>
</div>
<div id="second" style="display: none">
        <blockquote class="layui-elem-quote layui-text">
        <button class="layui-btn layui-btn-sm" id="back">返回</button>
            <button class="layui-btn  layui-btn-sm" id="download" style="float: right">下载图片</button>
            <button class="layui-btn  layui-btn-sm" id="download1" style="float: right">长按海报保存或分享海报</button>
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
        $('.deImgs').css('width','8%')
    }
    var attachmentPath;
    var checkbox;
    var forumState = 0;

    layui.use(['form', 'table','laydate','upload','laypage'], function(){
        form = layui.form
            ,table = layui.table
            ,laydate=layui.laydate
            ,upload = layui.upload;
        var laypage = layui.laypage;

        laydate.render({
            elem: '#test1',
            value: new Date(),
            tigger:'click',
            format: 'M月d日'
        });

        //图片上传
        upload.render({
            elem: '#fileupload'
            ,url: '/poster2/upload' //上传接口
            ,accept: 'images' //普通文件
            ,done: function(res){
                var str = '';
                var data = res.data;
                attachmentPath = data.attachmentPath
                var fileExtension=data.attachmentName.substring(data.attachmentName.lastIndexOf(".")+1,data.attachmentName.length);//截取附件文件后缀
                var attName = encodeURI(data.attachmentName).replace(/\+/g, "%2b").replace(/\@/g,"%40").replace(/\#/g,"%23").replace(/\&/g,"%26").replace(/\//g,"%2F").replace(/\?/g,"%3F").replace(/\￥/g,"%ef%bf%a5").replace(/\$/g,"%24").replace(/\！/g,"%ef%bc%81").replace(/\（/g,"%ef%bc%88").replace(/\）/g,"%ef%bc%89").replace(/\…/g,"%e2%80%a6%e2%80%a6");
                var fileExtensionName=attName.substring(0,attName.lastIndexOf("."));
                var deUrl = data.attachmentPath.split('&ATTACHMENT_NAME=')+fileExtensionName+"."+fileExtension+"&FILESIZE="+data.attachmentSize;
                str += '<div class="dech" deUrl="' + deUrl+ '"><a  NAME="' + data.attachmentName + '*" style="text-decoration:none;margin-left:5px;">' + data.attachmentName + '</a><img class="deImgs" style="margin-left:10px;cursor: pointer;" src="/img/file/icon_deletecha_03.png"/><input type="hidden" class="inHidden" value="' + data.aid + '@' + data.ym + '_' + data.attachId + ',"></div>';
                $('#fileAll').append(str);
            $('#fileupload').css('display','none')
            }
        })
        //删除
        $(document).on('click', '#fileAll .deImgs', function () {
            $('#fileAll').html('');
            $('#fileupload').css('display','block')

        })
        //返回
        $('#back').click(function(){
            $('#first').css('display','block')
            $('#second').css('display','none')
            document.title='海报信息录入'
        })
        //手机和电脑保存提示
        $('#download1').click(function(){
            layer.msg('长按保存图片',{icon:6});
        })
        $('#download').click(function(){
            layer.msg('右键图片点击保存',{icon:6});
        })
        //监听复选框状态
        form.on('checkbox', function(data){
            checkbox = data.elem.checked;
            if(!checkbox){//是否被选中，true或者false
                $('#heihei').hide()
                forumState = 0 ;
            }else{
                $('#heihei').show()
                 forumState =1
            }

        })
        <%--提交--%>
        $('#submit').click(function(){

            if($('[name="unitname"]').val() == ''){
                layer.msg('请输入单位名称！',{icon:2});
                return false;
            }else if ($('[name="booth"]').val() == '' && forumState == 0){
                layer.msg('海报自动生成器供参展用户或参与主题论坛的用户生成宣传海报，请您填写您的展位号或相关论坛信息后再提交！',{icon:2});
                return false;
            }else if(checkbox){
                if($('#test1').val() == ''){
                    layer.msg('请选择日期！',{icon:2});
                    return false;
                }else if($('#place').val() == ''){
                    layer.msg('请输入地点！',{icon:2});
                    return false;
                }else if($("#forumTimeSlot option:selected").val() == ''){
                    layer.msg('请选择时间段！',{icon:2});
                    return false;
                }else if($('#forumname').val() == ''){
                    layer.msg('请输入论坛名称！',{icon:2});
                    return false;
                }
            }else if(!$('#fileAll').html()){
                layer.msg('请提交图片',{icon:2});
                return false;
            }
            setTimeout(function () {
                var unitname = $('[name="unitname"]').val()
                var booth = $('[name="booth"]').val()
                var businessintroduction = $('[name="businessintroduction"]').val()
                var time = $('#test1').val()
                var place = $('#place').val()
                var forumname = $('#forumname').val()
                var forumTimeSlot = $("#forumTimeSlot option:selected").val();
                $.ajax({
                    url: '/poster2/posterGenerate',//url
                    data: {
                        companyName: unitname,
                        booth: booth,
                        introduce: businessintroduction,
                        attachmentPath: attachmentPath,
                        forumTime: time,
                        forumPlace: place,
                        forumName: forumname,
                        forumTimeSlot: forumTimeSlot,
                        forumState: forumState
                    },
                    dataType: 'json',
                    type: 'get',
                    beforeSend: function () {
                        document.title = '海报图片下载'
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
                        setTimeout(function () {
                            layer.closeAll();
                        }, 2000)
                        $('#first').css('display', 'none')
                        $('#second').css('display', 'block')
                    },
                    success: function (res) {
                        var strr;
                        strr = '<img id="img1" style="height:auto;width:100%"  src="/xs?' + res.object.attUrl + '">'
                        $('#img').html(strr);
                    }
                })
            },1300);
        })

    })
</script>
</html>
