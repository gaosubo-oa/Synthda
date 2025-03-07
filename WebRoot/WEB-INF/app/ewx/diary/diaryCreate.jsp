<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@taglib prefix="mvc" uri="http://www.springframework.org/tags/form" %>
<%@taglib prefix="fmt" uri="http://www.springframework.org/tags" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <!--  <meta http-equiv=X-UA-Compatible content=IE=EmulateIE7>-->
    <meta http-equiv="X-UA-Compatible" content="IE=EmulateIE7"><!– IE7 mode –>
    <meta name="viewport" content="width=device-width,initial-scale=1,minimum-scale=1,maximum-scale=1,user-scalable=no" />
    <title>写日志</title>
    <%--<script type="text/javascript" src="../../js/notes/jquery-2.1.2.min.js" ></script>--%>
    <link rel="stylesheet" href="/lib/layer/skin/default/layer.css">
    <link href="https://cdn.bootcss.com/font-awesome/4.6.3/css/font-awesome.min.css" rel="stylesheet">
    <script src="/js/xoajq/xoajq1.js" type="text/javascript" charset="utf-8"></script>


    <script src="../lib/mui/mui/mui.min.js"></script>
    <script type="text/javascript" src="../js/diary/m/vue.min.js"></script>
    <script src="../../js/diary/m/vue-html5-editor.js?20220622"></script>
<%--    <script src="https://cdn.bootcss.com/vue/2.2.6/vue.js"></script>--%>
    <script src="../lib/mui/mui/mui.picker.min.js"></script>
    <script src="../../lib/layer/layer.js?20201106"></script>
    <script src="/js/base/base.js" type="text/javascript" charset="utf-8"></script>
    <script type="text/javascript" src="../../js/ewx/waterMark.js?20190819.2"></script>
    <script src="/lib/jQuery-File-Upload-master/jquery-ui.js" type="text/javascript" charset="utf-8"></script>
    <script src="/lib/jQuery-File-Upload-master/jquery.iframe-transport.js" type="text/javascript" charset="utf-8"></script>
    <script src="/lib/jQuery-File-Upload-master/jquery.fileupload.js" type="text/javascript" charset="utf-8"></script>
    <script type="text/javascript" src="/js/common/fileupload.js"></script>
    <%--<script src="../js/diary/m/vue.min.js"></script>--%>
    <!--<script src="/static/pack/mobile/js/zepto.min.js"></script>-->
    <link href="../lib/mui/mui/mui.min.css" rel="stylesheet">
    <link href="../lib/mui/mui/mui.picker.min.css" rel="stylesheet">
    <link rel="stylesheet" href="../css/diary/m/diary_base.css" />
    <link rel="stylesheet" href="../css/diary/m/weui.css" />
    <script charset="utf-8" src="/lib/kindeditor/kindeditor-all.js"></script>
    <script charset="utf-8" src="/lib/kindeditor/lang/zh-CN.js"></script>
    <style>
        .mui-content-padded{
            margin: 0;
        }
        li.mui-table-view-cell{
            padding: 6px 15px;
        }
        .mui-btn{
            display: inline-block;
            width: 45%;
            margin-left: 2.5%;

        }
        .mui-btn-negative{
            padding: 4px 0;
        }
        .mui-input-row .mui-btn{
            width: 64%;
            /*padding-left: 5px;*/
        }
        .mui-area{
            margin-top: 10px;
        }
        .share .mui-card{
            width: calc(100% - 20px);
        }
        .mui-input-row .mui-btn {

        }
        .mui-bar-nav~.mui-content{
            height: 100%;
            background: #fafafa;
        }
        .mui-input-group .mui-input-row{
            height: 56px;
        }
        .mui-input-row span{
            display: inline-block;
            margin-bottom: 4px;
        }
        .mui-checkbox  input[type=checkbox]{
            /*top: 15px;*/
        }
        #fenxiang_logo,#yueping_logo{
            float:right;
            font-size:14px;
            color:#CECECE;
            margin-top:10px;
            width:20px;
            height: 20px;
            background:url('/img/diary/m/share.png') no-repeat left top ;
            background-size: 20px 20px;
        }
        .mui-table-view:after
        {
            position: absolute;
            right: 0;
            bottom: 0;
            left: 0;

            /*height: 1px;*/

            content: '';
            -webkit-transform: scaleY(.5);
            transform: scaleY(.5);

            /* background-color: #c8c7cc; */
        }
        .mui-table-view:before
        {
            position: absolute;
            top: 0;
            right: 0;
            left: 0;
            /*height: 1px;*/
            content: '';
            -webkit-transform: scaleY(.5);
            transform: scaleY(.5);

            /*background-color: #c8c7cc; */
        }
        .mui-table-view:before
        {
            top: 0px;
        }
        .weui-cells:after{

        }
        .mui-table-view:after
        {
            position: absolute;
            right: 0;
            bottom: 0;
            left: 0;

            height:0;

            content: '';
            -webkit-transform: scaleY(.5);
            transform: scaleY(.5);

            background-color:'';
        }
        .mui-table-view:before{
            height: 0;
            background-color: '';
        }
        .mui-table-view:after{
            height: 0;
            background-color: '';
        }
        .weui-cells:after{
            height: 0;
            background-color:'';
        }
        .mui-bar{
            border-top:none;
            background-color:'';
            box-shadow:'';
        }
        /*修改底部按钮父元素边框*/
        #nav{
            -webkit-box-shadow: 0 0 1px #d6d6d6;
        }
        .pda_attach.pda_attach_img .icon-delete{
            top: -10px;
            right: -10px;
        }
        .icon-delete{
            position: absolute;
            right: 5px;
            top: 5px;
            background: red;
            width: 20px;
            text-align: center;
            height: 20px;
            line-height: 20px !important;
            border-radius: 10px;
            font-size: 20px !important;
            color: #fff;
            z-index: 99;
        }
        .no_delete .icon-delete{
            display: none;
        }
        #userTopForms>div{
            border-bottom: 1px solid #eee;
        }
        .topForm label{
            padding-left:0;
            color:#666666;
            font-size:15px;
        }
        .mui-input-row select{
            font-size: 15px;
        }
        .vue-html5-editor .color-card {
            border: 1px solid;
        }
        .dashboard label {
            width: 46%;
        }
        .dashboard .dashboard-font label {
            width: 19%;
        }
        .dashboard form label {
            width: 36%;
        }
        .btnTime {
            font-family: 'Helvetica Neue',Helvetica,sans-serif;
            font-size: 15px;
        }
        .share {
            font-family: 'Helvetica Neue',Helvetica,sans-serif;
            font-size: 15px;
        }
        .mui-dtpicker-body{
            width: 170%;
        }
        .mui-dtpicker-title{
            width: 170%;
        }
        .mui-dtpicker-title h5:nth-of-type(4){
            display: none!important;
        }
        .mui-dtpicker-title h5:nth-of-type(5){
            display: none!important;
        }
        .mui-picker:nth-of-type(4){
            display: none!important;
        }
        .mui-picker:nth-of-type(5){
            display: none!important;
        }
    </style>

    <style>
        .main{
            background-color: #fff;
            margin-bottom: 50px;
        }

        .main .part {
            padding: 0.2rem 50px 0.2rem 0;
        }

        .main .part input[type=checkbox] {
            top: 0px;
        }

        .main .person {
            padding: 0.4rem 50px 0.4rem 0;
        }

        .main .person input[type=checkbox] {
            top: -1.6px;
        }

        .main .userPerson {
            padding: 0.4rem 50px 0.4rem 0;
        }

        .main .userPerson input[type=checkbox] {
            top: -3px;
        }

        .main .mui-checkbox input[type=checkbox]:before {
            width: 0.3rem;
            height: 0.3rem;
            line-height: 30px;
            text-align: center;
            display: block;
            font-size: 30px;
        }

        .main h3{
            font-size: 14px;
            border-bottom: 1px solid #dcdcdc;
            font-weight: normal;
        }

        .main .users {
            margin-left: 1rem;
        }

        .main .department {
            margin-left: 1rem;
        }

        .selectFile {
            display: inline-block;
            background: url(/ui/img/diary/m/regular_election.png) no-repeat 0 0;
            background-size: 100% 100%;
            height: 2.25rem;
            width: 2.25rem;
            vertical-align: middle;
            margin-right: 0.27rem;
        }

        .file {
            display: inline-block;
            background: url(/ui/img/diary/m/wen.png) no-repeat 0 0;
            background-size: 100% 100%;
            height: 2.25rem;
            width: 2.25rem;
            vertical-align: middle;
            margin-right: 0.27rem;
        }

        .box_confirm {
            background-color: #5890D7;
            height: 40px;
            line-height: 40px;
            color: #fff;
            border-radius: 5px;
        }
    </style>
</head>
<body id="Create">
<div class="mui-media" id="main">
    <!--<header class="mui-bar mui-bar-nav">
        <a class="mui-action-back mui-icon mui-icon-left-nav mui-pull-left mui-nav-btn"></a>
        <h1 class="mui-title">新建</h1>
    </header>-->
    <div class="mui-content">
        <nav class="mui-bar-nav mui-btn-negative mui-text-center" style="display:none;background:#fe8e7c; border-color:#fe8e7c;">您有一封日志未提交</nav>
        <div class="mui-content-padded">
            <ul class="mui-table-view mui-table-view-striped mui-table-view-condensed topForm" id="topText">
                <li class="mui-table-view-cell mui-input-row">
                    <label class="mui-tab-label mui-pull-left " >日志类型：</label>
                    <select name="" class="typeId" id="diary_type">
                        <option value="1">工作日志</option>
                        <option value="3">工作周报</option>
                        <option value="4">工作月报</option>
                        <option value="2">个人日志</option>
                    </select>
                </li>
                <li class="mui-table-view-cell mui-input-row">
                    <label class="mui-tab-label mui-pull-left ">日志标题：</label>
                    <input style="float:none;font-size: 15px" type="text" name="" id="diary_title"  class="mui-pull-right mui-popup-input"/>
                </li>
                <li class="mui-table-view-cell mui-input-row  btnTime">
                    <div>
                        <label class="mui-tab-label mui-pull-left " >选择日期：</label>
                    </div>
                    <div id="diary_date" style="line-height: 41px;"></div>
                </li>
                <li class="mui-table-view-cell mui-input-row share">
                    <label class="mui-tab-label mui-pull-left " >阅评范围：</label>
                    <span id="yueping_logo"></span>
                    <input type="input" name="" placeholder="选择阅评人员"  readonly class="mui-btn mui-pull-right " id="userTopName" value=""  style="position: absolute;left: 30%;width: calc(65% - 30px); text-align:left;font-size: 15px;" />
                    <input type="hidden" name="" id="diary_userTop_id" value="" />
                </li>
                <li class="mui-table-view-cell mui-input-row share">
                    <label class="mui-tab-label mui-pull-left " >分享给：</label>
                    <span id="fenxiang_logo"></span>
                    <input type="input" name="" placeholder="选择分享人员" readonly class="mui-btn mui-pull-right " id="shareName" value=""  style="position: absolute;left: 30%;width: calc(65% - 30px); text-align:left;font-size: 15px;" />
                    <input type="hidden" name="" id="diary_share_id" value="" />
                </li>
                <li class="mui-table-view-cell mui-input-row">
                    <label class="mui-tab-label mui-pull-left ">评论：</label>
                    <select name="" class="typeId" id="diary_discuss">
                        <option value="1" selected="">开启</option>
                        <option value="0">关闭</option>
                    </select>
                </li>
            </ul>
            <ul class="mui-table-view mui-table-view-striped mui-table-view-condensed">
                <li class="mui-table-view-cell mui-input-row mui-area" style="padding-top: 15px;">
                    <%--                    <textarea class="mui-text-justify" id="diary_connect" style="min-height: 100px; border:none; padding:0 15px 10px 0;" placeholder="请填写日志内容"></textarea>--%>
                    <div id='normalDiary'>
                        <div id="diary_connect" class="mui-text-justify fuText" name="content" type="text/plain" style="width: 100%;min-height: 200px;max-height:100%;">
<%--                            <vue-html5-editor :content="content" :height="300" :show-module-name="showModuleName" @change="updateData" ref="editor"></vue-html5-editor>--%>
                            <div class="content" id="newKindEditor" name="content"  style="width: 100%; height: 300px;"></div>
                        </div>
                        <textarea class="mui-text-justify puText" id="diary_con" style="display:none"></textarea>
                    </div>
                    <div id='templateDiary' style='display:none'>
                    </div>
                </li>
            </ul>
            <ul class="mui-table-view mui-table-view-striped mui-table-view-condensed" id="file">
                <div class="page__bd">
                    <div class="weui-gallery" id="gallery" style="opacity: 0; display: none;">
                        <span class="weui-gallery__img" id="galleryImg" style="background-image:url(blob:https://weui.io/2268da98-1b8a-48d9-b253-c96b422f2574)"></span>
                        <div class="weui-gallery__opr">
                            <a href="javascript:" class="weui-gallery__del">
                                <i class="weui-icon-delete weui-icon_gallery-delete"></i>
                            </a>
                        </div>
                    </div>

                    <div class="weui-cells weui-cells_form">
                        <div class="weui-cell" style="margin-bottom:50px">
                            <div class="weui-cell__bd">
                                <div id="uploader" class="weui-uploader">
                                    <div class="weui-uploader__hd">
                                        <p class="weui-uploader__title" style="margin-left:0px;" onclick="btn1('1')">图片上传</p>
                                    </div>
                                    <div class="weui-uploader__bd">
                                        <div class="" style="position: relative">
                                            <img src="/img/diary/m/tupian.png" id="" style="width: 60px">
                                            <form id="" target="uploadiframe" action="/upload?module=diary" enctype="multipart/form-data" method="post">
                                                <input style="width: 80px;"  id="uploadinputimg2" class="weui-uploader__input" name="file" type="file" accept="image/*" multiple="" onChange=""/>
                                            </form>
                                        </div>
                                        <ul class="weui-uploader__files" id="uploaderFiles2" >
                                        </ul>
                                    </div>

                                    <div class="weui-uploader__hd" style="margin-top:10px">
                                        <p class="weui-uploader__title" style="margin-left:0px;" onclick="btn1('2')">文件上传</p>
                                    </div>
                                    <div class="weui-uploader__bd">

                                        <div class="" style="position: relative">
                                            <img src="/img/diary/m/wenjian.png" id="add_button" style="width: 60px">
                                            <form id="uploadimgform" target="uploadiframe" action="/upload?module=diary" enctype="multipart/form-data" method="post">
                                                <input style="width: 80px;"   id="uploadinputimg" class="weui-uploader__input" name="file" type="file"  multiple="" onChange=""/>
                                                <%--<a href="javascript:;" id="uploadimg"><img style="margin-right:5px;" src="../img/icon_uplod.png">附件上传</a>--%>
                                            </form>

                                        </div>
                                        <ul class="weui-uploader__files" id="uploaderFiles" >
                                        </ul>
                                    </div>

                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </ul>
        </div>

    </div>
    <footer class="mui-bar-footer">
        <nav class="mui-bar mui-bar-tab mui-btn-nav" data-role="footer" id="nav" style="z-index: 1000;">
            <button id="hd" class="mui-btn mui-btn-block" onclick="diary_save(0)" style="border-color:#d9d9d9;">保存为草稿</button>
            <button id="hds" class="mui-btn mui-btn-block mui-btn-primary" onclick="diary_save(1)" style="background-color:#5A8FDF; border-color:#5A8FDF;">立即提交</button>
        </nav>
    </footer>
</div>

<%--选择人员控件--%>
<div class="mui-content"  style="display: none" id="userMain">
    <a style="visibility:hidden;height:0px;" id="to" href=""></a>
    <!--
      <div class="top" style="margin-top:0px;">
          <div class="mui-input-row mui-search">
              <input type="search" class="mui-input-clear" />
              <span class="mui-icon mui-icon-search mui-hidden"></span>
              <p><span class="mui-icon mui-icon-search"></span>搜索</p>
          </div>
      </div>
      -->
    <div class="main">
        <div class="users" id="userss" style="display: block;">
            <h3 id="users" class="mui-input-row mui-checkbox mui-right">
                <label>
                    <i class="selectFile"></i>
                    <span>常选人员</span>
                </label>
            </h3>
        </div>
    </div>
    <nav class="mui-bar mui-bar-tab ">
        <a class="mui-tab-item" href="#" style="padding:0px 10px;" id="save_share">
            <div class="box_confirm" id="com_submit">
                确定
            </div>
        </a>
    </nav>
</div>

<script>
    var deptId = 1;
    var deptTop = "";

    var flagType = 0;
    Vue.use(VueHtml5Editor, {
        showModuleName: true,
        image: {
            sizeLimit: 1024 * 4096,
            compress: true,
            width: 500,
            height: 500,
            quality: 80
        }
    })

    var kindEditorOption = {
        themeType: 'simple', // 定义编辑器为简洁模式
        filterMode: false, // 开启过滤
        allowFileManager: true, // 开启文件空间
        uploadJson: '/ueditor/upload?module=ueditor', // 上传接口
        filePostName: 'upfile', // 自定义后台接收的文件流参数名（默认为 imgFile）
        afterUploadStatusName: 'state', // 定义上传后判断的参数名（默认为 error）
        afterUploadSuccessCode: 'SUCCESS', // 定义上传成功后参数值（默认为 0）此处判断为===，必须保证类型也相同
        afterUploadErrorMsg: 'msg', // 定义上传失败后提示信息的参数名（默认为 message）
        items : [
            'source', '|', 'undo', 'redo', '|',  'justifyleft', 'justifycenter', 'justifyright',
            'justifyfull', 'insertorderedlist', 'insertunorderedlist', 'indent', 'outdent', 'subscript',
            'superscript', 'clearhtml', 'quickformat','|', 'formatblock', 'fontname', 'fontsize', '|', 'forecolor', 'hilitecolor', 'bold',
            'italic', 'underline', 'strikethrough'
        ],
        afterUpload: function (url, data, name) {
            console.log(url);
            console.log(data);
            console.log(name);
        }
    }
    // 新建新闻编辑器
    var newKindEditorObj = null;
    KindEditor.ready(function (K) {
        newKindEditorObj = K.create('#newKindEditor', kindEditorOption);
    });
    // 编辑新闻编辑器
    var editKindEditorObj = null;
    KindEditor.ready(function (K) {
        editKindEditorObj = K.create('#editKindEditor', kindEditorOption);
    });
    new Vue({
        el: "#diary_connect",
        data: {
            content: "",
            showModuleName: false,
        },
        methods: {
            updateData: function(data) {
                // sync content to component
                this.content = data
            },
            fullScreen: function() {
                this.$refs.editor.enableFullScreen()
            },
            focus: function() {
                this.$refs.editor.focus()
            },
            reset: function() {
                var newContent = prompt('please input some html code: ')
                if (newContent) {
                    this.content = newContent
                }
            }

        }
    })
    fileuploadFn('#uploadinputimg',$('#uploaderFiles'));
    fileuploadFn('#uploadinputimg2',$('#uploaderFiles2'));
    //和移动端交互
    function btn1(e){
        if(e == 1){
            // console.log('uploadimgform');
            // alert('企业微信移动端工作流公共附件功能正在开发中！');
           $("#uploadinputimg2").trigger("click");
        }else{
            $("#uploadinputimg").trigger("click");
        }
        // else{
        //     $('.choosewj').attr('src','/img/workflow/work/choose_imgclick.png')
        //     if(e == '1'){
        //         //图片上传
        //         btn('imgadd1',1)
        //     }else{
        //         //文件上传
        //         btn('imgadd2',2)
        //     }
        // }
    }
    function btn(cb, num){
        if (( /(iPhone|iPad|iPod|iOS)/i.test(navigator.userAgent) )) {
            try{
                var filesize = $('.fileupload').attr('filesize')
                window.webkit.messageHandlers.addImage.postMessage({'function':cb,'num':num});
            }catch(err){
                var filesize = $('.fileupload').attr('filesize')
                addImage(cb,num,filesize);
            }

        } else if (/(Android)/i.test(navigator.userAgent)) {
            //alert(navigator.userAgent);
            var filesize = $('.fileupload').attr('filesize')
            Android.addImage(cb,num,filesize);

        }
        $('.choosewj').attr('src','/img/workflow/work/choose_img.png')
    }
    function getCookie (key) {
        var arr=document.cookie.split('; '); //多个cookie之间是用;+空格连接的
        for (var i = 0; i < arr.length; i++) {
            var arr2=arr[i].arr.split('=');
            if(arr2[0]==key){
                return arr2[1];
            }
        }
        return false;//如果函数没有返回值，得到的结果是undefined
    }
    /************调用移动端原始表单查看的方法************************/
    function formInfo() {
        if($.getQueryString("type") == 'EWC'){
            window.location.href = '/workflow/work/workformPreView?flowId=' + globalData.flowId + '&flowStep=&prcsId=&runId=' + globalData.flowRun.runId + '&formInfo=formInfo';
        }else{
            if (( /(iPhone|iPad|iPod|iOS)/i.test(navigator.userAgent) )) {
                try{
                    window.webkit.messageHandlers.formInfoUrlLink.postMessage({'url':'/workflow/work/workformPreView?flowId=' + globalData.flowId + '&flowStep=&prcsId=&runId=' + globalData.flowRun.runId + '&formInfo=formInfo','name':'原始表单'});
                }
                catch(err) {
                    formInfoUrlLink('/workflow/work/workformPreView?flowId=' + globalData.flowId + '&flowStep=&prcsId=&runId=' + globalData.flowRun.runId + '&formInfo=formInfo','原始表单');
                }
            } else if (/(Android)/i.test(navigator.userAgent)) {
                Android.formInfoUrlLink('/workflow/work/workformPreView?flowId=' + globalData.flowId + '&flowStep=&prcsId=&runId=' + globalData.flowRun.runId + '&formInfo=formInfo','原始表单');
            }
        }

    };

    var runId =  $.GetRequest()['runId'] || '';
    function imgadd1(img, name, type){
        var arr = img.split('*');
        var name_arr = name.split('*');
        if(type == 1){
            var img = '';
            for(var i=0;i<arr.length;i++){
                var url =  arr[i];
                img += '<img id="blah"  src="'+ arr[i] +'" onclick="anios($(this))" style="width:50px;height:50px;margin-right: 10px;margin-bottom: 10px;" url="'+url +'" name="'+ name_arr[i] +'">'+
                    '<span style="color: red;margin-left:15px;cursor:pointer;" class="deletefileBtn" atturl="'+arr[i].split('?')[1]+'">×删除</span></br>';
            }
            $('#uploaderFiles2').append(img);
        }else{
            var name_str = '';
            for(var i=0;i<name_arr.length ;i++){
                var url = arr[i];
                if($.getQueryString("type") == 'EWC'){
                    name_str += '<p><a style="display: inline-block;color: #095de0;" href="javascript:void(0)" atturl="'+url+'" url="'+url+'" name="'+ name_arr[i] +'" onclick="lookEwx($(this))">'+ name_arr[i] +'</a></p>'+
                        '<span style="color: red;margin-left:15px;cursor:pointer; cursor: pointer ;" class="deletefileBtn"  atturl="'+ url +'">×删除</span></br>';
                }else {
                    name_str += '<p style = "display: inline-block" onclick="anios($(this))" url="'+url+'"  name="'+ name_arr[i] +'">'+ name_arr[i] +'</p>'+
                        '<span style="color: red;margin-left:15px;cursor:pointer; " class="deletefileBtn" atturl="'+arr[i].split('?')[1]+'">×删除</span></br>';
                }
            }
            $('#uploaderFiles').css('min-height', '50px')
            $('#uploaderFiles').append(name_str);
        }
        $(".deletefileBtn").click(function (){
            $("#uploaderFiles2").remove()
        })
        getFileInfo(runId,1)
    }
    var runId =  $.GetRequest()['runId'] || '';
    function imgadd2(img, name){
        var arr = img.split('*');
        var name_arr = name.split('*');
            var name_str = '';
            for(var i=0;i<name_arr.length ;i++){
                var url = arr[i];
                if($.getQueryString("type") == 'EWC'){
                    name_str += '<p><a style="display: inline-block;color: #095de0;" href="javascript:void(0)" atturl="'+url+'" url="'+url+'" name="'+ name_arr[i] +'" onclick="lookEwx($(this))">'+ name_arr[i] +'</a></p>'+
                        '<span style="color: red;margin-left:15px;cursor:pointer; cursor: pointer ;" class="deletefileBtn"  atturl="'+ url +'">×删除</span></br>';
                }else {
                    name_str += '<p style = "display: inline-block" onclick="anios($(this))" url="'+url+'"  name="'+ name_arr[i] +'">'+ name_arr[i] +'</p>'+
                        '<span style="color: red;margin-left:15px;cursor:pointer; " class="deletefileBtn" atturl="'+arr[i].split('?')[1]+'">×删除</span></br>';
                }
            }
            $('#uploaderFiles').css('min-height', '50px')
            $('#uploaderFiles').append(name_str);


        $(".deletefileBtn").click(function (){
            $("#uploaderFiles").remove()
        })
        getFileInfo(runId,1)
    }
    function anios(e){
        var url = e.attr('url');
        var name = e.attr('name');
        //
        // var name = e.next().text();
        if (( /(iPhone|iPad|iPod|iOS)/i.test(navigator.userAgent) )) {
            if($.getQueryString("type") == 'EWC'){
                window.open(url)
            }else{
                try{
                    window.webkit.messageHandlers.overLookFile.postMessage({'url':url,'name':name});
                }catch(error){
                    overLookFile(url,name);
                }
            }
        } else if (/(Android)/i.test(navigator.userAgent)) {
            if($.getQueryString("type") == 'EWC'){
                window.open(url)
            }else{
                Android.overLookFile(url,name);
            }
        } else {
            window.open(url);
        }
    }
    function spanClick(e){
        anios1(e.prev())
    }
    function imgupSpanClick(e){
        if ($.getQueryString("type") == 'EWC'){
            anios1(e.prev(), 1)
        }else{
            anios1(e.prev())
        }
    }
    function anios1(e, m){
        if(e.attr('url').indexOf('http') >-1){
            var url = e.attr('url');
        }else{
            if (window["context"] == undefined) {
                if (!window.location.origin) {
                    window.location.origin = window.location.protocol + "//" + window.location.hostname + (window.location.port ? ':' + window.location.port: '');
                }
                window["context"] = location.origin;
            }
            var domain = document.location.origin;
            var url = domain+e.attr('url');
        }
        if(e.hasClass('fileupload_data')){
            var url = domain+'/download?'+e.attr('url');
        }
        var name = e.attr('names');
        var atturl = e.attr('url');
        var atturls = atturl.split('xs?')[1]
        var names = atturl.split('&ATTACHMENT_NAME=')[1].split('&FILESIZE=')[0];
        var attachName = names;
        var fileExtension = attachName.substring(attachName.lastIndexOf(".")+1,attachName.length);
        if(globalData.flowProcesses.attachPriv.indexOf('2') > -1){
            var fileattachPriv = '1';
        }else{
            var fileattachPriv = '0';
        }
            if (( /(iPhone|iPad|iPod|iOS)/i.test(navigator.userAgent) )) {
                try{
                    window.webkit.messageHandlers.overLookFile.postMessage({'url':url, 'name':name});
                }catch(error){
                    overLookFile(url, name);
                }
            }else if (/(Android)/i.test(navigator.userAgent)) {
                Android.overLookFile(url, name, fileattachPriv);
            }else{
                if(m == 1){
                    workformh5Pdurl(fileExtension, atturls);
                }else if(m == 2){
                    workformh5Pdurl(fileExtension, atturl);
                }
            }
    }
    /**********************与移动端交互 页面加载后 将附件的图片添加 初始化页面附件查看方式*****************************/
    imptarget = '';
    function phoneimgupload(e) {
        imptarget = $(e);
        file_id = $(e);
        if($.getQueryString("type") == 'EWC'){
            if($(e).attr('src').indexOf('/img/fileupload.png') > -1){
                $("#uploadinputimg").attr('uploadType','4');
            }else{
                $("#uploadinputimg").attr('uploadType','3');
            }
            $('#uploadimgform').attr('action','/upload?module=workflow');
            $("#uploadinputimg").trigger("click");
        }else{
            if($(e).attr('src').indexOf('/img/fileupload.png') > -1){
                btn("imgupload4", 4)
            }else{
                btn("imgupload3", 1)
            }
        }
    }
    function imgupload3(img, name, type){
        var url = img.split('*');
        var listStr = '';
        var editbtn = ''
        if(checkttachPriv(3)){
            editbtn = ' inline-block;;';
        }else{
            editbtn = 'none;';
        }
        for(var i= 0;i<url.length;i++){
            if(url[i]!=''){
                var names = name.split('*')[i];
                var thisspan = names;
                if(thisspan != ''){
                    if(thisspan.split('.')[0].length > 8){
                        var thisspan = thisspan.split('.')[0].substr(0,8)+'…'+thisspan.split('.')[1];
                    }
                }
                if (type == 3) {
                    // 企业微信
                    listStr += '<div class="imgfileBox" style="display:  inline-block;position:  relative;float: left;">' +
                        '<img name="'+imptarget.attr('name')+'" names="'+names+'" onclick="anios1($(this), 1)" src="'+url[i]+'" url="'+url[i]+'" style="width:50px;height: 50px;cursor: pointer;"  id="'+imptarget.attr('name')+'" title="'+imptarget.attr('title')+'" align="absmiddle" style=""  class="imgupload_data"    width="'+imptarget.attr('width')+'" height="'+imptarget.attr('height')+'"/>' +
                        '<span class="uploadImg" onclick="imgupSpanClick($(this))" style="display: inline-block">'+ thisspan +'</span>' +
                        '<span style="color: red;margin-left:15px;cursor:pointer;font-size: 12px; display: '+editbtn+'" class="hoverboxLidelete" atturl="'+url[i].split('?')[1]+'">×删除</span></br>'  +
                        '</div></br>';
                } else {
                    // app 调用
                    listStr += '<div class="imgfileBox" style="display:  inline-block;position:  relative;float: left;">' +
                        '<img name="'+imptarget.attr('name')+'" names="'+names+'" onclick="anios1($(this))" src="/xs?'+url[i].split('/download?')[1]+'" url="/xs?'+url[i].split('/download?')[1]+'" style="width: 50px;height: 50px;cursor: pointer;"  id="'+imptarget.attr('name')+'" title="'+imptarget.attr('title')+'" align="absmiddle" style=""  class="imgupload_data"    width="'+imptarget.attr('width')+'" height="'+imptarget.attr('height')+'"/>' +
                        '<span class="uploadImg" onclick="imgupSpanClick($(this))" style="display: inline-block">'+ thisspan +'</span>' +
                        '<span style="color: red;margin-left:15px;cursor:pointer;font-size: 12px display: '+editbtn+'" class="hoverboxLidelete" atturl="'+url[i].split('?')[1]+'">×删除</span></br>'  +
                        '</div></br>';
                }
            }
        }
        imptarget.before(listStr).parent().css({
            'padding-top': '5px',
            'padding-bottom': '5px'
        });
        imptarget = '';
    }
    function imgupload4(img, name, type){
        var arr = img.split('*');
        var listStr = '';
        var editbtn = ''
        if(checkttachPriv(3)){
            editbtn = ' inline-block;;';
        }else{
            editbtn = 'none;';
        }
        for(var i=0;i<arr.length;i++){
            if(arr[i]!=''){
                var name_arr = name.split('*')[i];
                var thisspan = name_arr;
                if(thisspan != ''){
                    if(thisspan.split('.')[0].length > 8){
                        var thisspan = thisspan.split('.')[0].substr(0,8)+'…'+thisspan.split('.')[1];
                    }
                }
                var http = location.origin;
                var iconImgType = {
                    txt : '/img/icon_file.png',
                    jpg : '/img/icon_image.png',
                    png : '/img/icon_image.png',
                    pdf :  '/img/icon_pdf.png',
                    ppt : '/img/icon_ppt.png',
                    pptx :  '/img/icon_ppt.png',
                    doc : '/img/icon_word.png',
                    docx : '/img/icon_word.png',
                    xls :  '/img/icon_excel.png',
                    xlsx :  '/img/icon_excel.png'
                };
                var attrnametype = name_arr.split('.')[1];
                if(attrnametype.replace(/^(.*[n])*.*(.|n)$/g, "$2") == ','){
                    attrnametype = attrnametype.split(',')[0];
                }
                if(iconImgType[attrnametype] == undefined){
                    var src = '/img/icon_file.png';
                }else{
                    var src = iconImgType[attrnametype];
                }
                if(arr[i].indexOf('/xs?') > -1){
                    var atturl =  arr[i].split('/xs?')[1]
                }else if(arr[i].indexOf('/download?') > -1){
                    var atturl =  arr[i].split('/download?')[1]
                }else{
                    var atturl = arr[i]
                }
                if (type == 4&&$.getQueryString("type") == 'EWC') {
                    listStr += '<div class="imgfileBox" style="display:  inline-block;position:  relative;float: left;height: auto;">' +
                        '<img atturl="'+ atturl +'" name="'+imptarget.attr('name')+'" names="'+name_arr+'" onclick="lookEwx($(this),0)" src="'+ src +'" url="'+ atturl +'" style="cursor: pointer;width: 30px;height: 30px;"  id="'+imptarget.attr('name')+'" title="'+imptarget.attr('title')+'" align="absmiddle" style=""  class="fileupload_data"    width="'+imptarget.attr('width')+'" height="'+imptarget.attr('height')+'"/>' +
                        '<span class="uploadImg fileupload_data" style="display: inline-block" onclick="lookEwx($(this))" atturl="'+ atturl +'" name="'+name_arr+'"  src="'+ src +'" url="'+ atturl +'">'+ thisspan +'</span>' +
                        '<span style="color: red;margin-left:15px;cursor:pointer;font-size: 12px; display: '+editbtn+'" class="hoverboxLidelete" atturl="'+ arr[i]  +'">×删除</span></br>'  +
                        '</div>';
                } else {
                    listStr += '<div class="imgfileBox" style="display:  inline-block;position:  relative;float: left;height: auto;">' +
                        '<img atturl="'+ atturl +'" name="'+imptarget.attr('name')+'" names="'+name_arr+'" onclick="anios1($(this))" src="'+ src +'" url="'+ atturl +'" style="cursor: pointer;width: 30px;height: 30px;"  id="'+imptarget.attr('name')+'" title="'+imptarget.attr('title')+'" align="absmiddle" style=""  class="fileupload_data"    width="'+imptarget.attr('width')+'" height="'+imptarget.attr('height')+'"/>' +
                        '<span class="uploadImg" onclick="spanClick($(this))" style="display: inline-block">'+ thisspan +'</span>' +
                        '<span style="color: red;margin-left:15px;cursor:pointer;font-size: 12px; display: '+editbtn+'" class="hoverboxLidelete" atturl="'+atturl+'">×删除</span></br>'  +
                        '</div>';
                }

            }
        }
        imptarget.before(listStr).parent().css({
            'padding-top': '5px',
            'padding-bottom': '5px'
        });
        imptarget = '';
    }

    //end
    $('.dech').children('a:not(:first-child)').css('display','none')
    $('#uploaderFiles').on('click','.deImgs',function(e){
        e.stopPropagation();
        var data=$(this).parents('.dech').attr('deUrl');
        var dome=$(this).parents('.dech');
        deleteChatment(data,dome);
    })
    $('#uploaderFiles2').on('click','.deImgs',function(e){
        e.stopPropagation();
        var data=$(this).parents('.dech').attr('deUrl');
        var dome=$(this).parents('.dech');
        deleteChatment(data,dome);
    })
    function deleteChatment(data,element){
        var btnArray = ['确认'];
        mui.confirm('确认要删除吗?', ' ', btnArray, function(e) {
            $.ajax({
                type:'get',
                url:'../delete',
                dataType:'json',
                data:data,
                success:function(res){
                    if(res.flag == true){
                        element.remove();
                    }else{

                    }
                }
            });
        })
    }
    $(".btnTime").click(function(){
        var picker = new mui.DtPicker({
            type: "datetime",//设置日历初始视图模式
            beginDate: new Date(year, month, day),//设置开始日期
            endDate: new Date(2222, 04, 25),//设置结束日期
            labels: ['年', '月', '日'],//设置默认标签区域提示语
        })
        picker.show(function(rs) {
            $("#diary_date").html( rs.text.split(' ')[0]);  //rs.text.split(' ')[0]只获取年。下标改成1，只获取月，以此类推
//            //return false;    //这是阻止对话框关闭的
//
            picker.dispose();  //释放组件资源，释放后将将不能再操作组件.所以每次用完便立即调用 dispose 进行释放，下次用时再创建新实例
        })
        $('.mui-btn[data-id="btn-cancel"]').html('取消');
        $('.mui-btn-blue').html('确定');
    })


</script>
</body>

<script >
    var id_str ='';
    var name_str ='';
    var year = new Date().getFullYear() ;
    var month = new Date().getMonth();
    var day = new Date().getDate();
    var today = new Array('星期日','星期一','星期二','星期三','星期四','星期五','星期六');
    var week = today[new Date().getDay()];
    var logTitle = ''+year+'-'+month+'-'+day+' ' +week
    var logTitle2 = ''+year+'-'+month+'-'+day
    function GetQueryString(name) {
        var reg = new RegExp("(^|&)" + name + "=([^&]*)(&|$)");
        var r = window.location.search.substr(1).match(reg);
        if (r != null) return unescape(r[2]); return null;
    }
    DEPT_ID = GetQueryString("DEPT_ID"); //括号里放地址栏传参变量
    USER_ID = GetQueryString("USER_ID"); //括号里放地址栏传参变量
    var type = GetQueryString("type")

    //判断是否使用中高管模板
    var isZhongGaoGuan = 0;
    $(function(){
        if(type == 'add'){
            getDiaryDefault()
        } else {
            //判断是否是中高管
            $.ajax({
                url: "/userPriv/selectIsZhongGaoGuan",
                type:'get',
                dataType:"JSON",
                data: {},
                success:function(data){
                    if(data.flag){
                        if(data.object != undefined && data.object.isZhongGaoGuan == '1'){
                            isZhongGaoGuan = 1;
                        }
                    }
                }
            });
        }
        function getDiaryDefault(checkText){
            $.ajax({
                url: "/diary/getDiaryDefaultSet",
                type:'get',
                dataType:"JSON",
                data: {
                    diaType:checkText
                },
                success:function(data){
                    if(data.flag){
                        $('#diary_title').val(data.object.subject || '')
                        $('#userTopName').val(data.object.userTopIdName || '')
                        $('#userTopName').attr('userid',data.object.userTopId)
                        $('#diary_type').val(data.object.diaType);
                        $('#diary_date').text(data.object.diaDate || '');
                        if(data.object.content != ''){
                            newKindEditorObj.html(data.object.content);
                        }else{
                            newKindEditorObj.html('');
                        }

                        //点击html按钮，使模板主动显示
                        if (jQuery("#diary_connect").find("span")[0].className == "ke-outline ke-selected"){
                            jQuery("#diary_connect").find("span")[0].click();
                        }

                        //判断是否为中高管，如果是中高管则使用中高管模板
                        if (data.object.diaType == '3' && data.object.isZhongGaoGuan == '1'){
                            isZhongGaoGuan = data.object.isZhongGaoGuan;
                            templateInit(data.object.diaType);
                        } else {
                            $("#normalDiary").show();
                            $("#templateDiary").hide();
                        }

                        //获取当前登陆用户的部门
                        deptId = data.object.deptId;

                        //查询本部门的所有上级
                        $.ajax({
                            type:'get',
                            url:'/department/selectDepartmentTop',
                            data: {
                                deptId: deptId
                            },
                            dataType:'json',
                            success:function(res){
                                if(res.flag && res.object != null){
                                    deptTop = res.object.deptTop;
                                }
                            }
                        });
                    }
                }

            })
        }
        var tmpl = '<li class="weui-uploader__file" style="background-image:url(#url#)"></li>',
            $gallery = $("#gallery"), $galleryImg = $("#galleryImg"),
            $uploaderInput = $("#uploaderInput"),
            $uploaderFiles = $("#uploaderFiles")
        ;
        $uploaderInput.on("change", function(e){
            var src, url = window.URL || window.webkitURL || window.mozURL, files = e.target.files;
            for (var i = 0, len = files.length; i < len; ++i) {
                var file = files[i];

                if (url) {
                    src = url.createObjectURL(file);
                } else {
                    src = e.target.result;
                }

                $uploaderFiles.append($(tmpl.replace('#url#', src)));
            }
        });


        $("#diary_type").on("change", function(e){
            var checkText = $("#diary_type").val();
            getDiaryDefault(checkText)
        });
        $uploaderFiles.on("click", "li", function(){
            $galleryImg.attr("style", this.getAttribute("style"));
            $gallery.fadeIn(100);
        });
        $gallery.on("click", function(){
            $gallery.fadeOut(100);
        });
    })

    var platform = "<?=$platform;?>";
    var wait=null;var closewin=null;
    // H5 plus事件处理
    function plusReady(){
        wait=plus.nativeUI.showWaiting('正在加载');
        closewin= plus.nativeUI.closeWaiting();
    }
    if(window.plus){
        plusReady();
    }else{
        document.addEventListener("plusready",plusReady,false);
    }
    function GetQueryString(name) {
        var reg = new RegExp("(^|&)" + name + "=([^&]*)(&|$)");
        var r = window.location.search.substr(1).match(reg);
        if (r != null) return unescape(r[2]); return null;
    }
    DIA_ID = GetQueryString("id"); //括号里放地址栏传参变量
    (function($) {
        mui.init({
            //禁用mui tap监听 否则点击生日选择会弹出两次
            // gestureConfig:{
            //     tap:false
            // }
        });
        if(DIA_ID != null && DIA_ID != ""){
            var data = {
                // "flag":18, //查看路径
                "diaId":DIA_ID
            };
            mui.ajax({
                data:data,
                type: 'get',
                url: '/diary/getConByDiaId',
                dataType:'json',
                beforeSend: function() {
                    // wait;
                },
                complete: function() {
                    // closewin;
                },
                success:function(data){
                    jQuery("#diary_type").val(data.object.diaType);
                    jQuery("#diary_title").val(data.object.subject);
                    jQuery("#diary_date").html(data.object.diaDate);

                    if (data.object.userTopId) {
                        jQuery('#userTopName').val(data.object.userTopIdName || '')
                        jQuery('#userTopName').attr('userid',data.object.userTopId)
                    }

                    if (data.object.toId) {
                        jQuery("#diary_share_id").val(data.object.toId);
                        jQuery("#shareName").val(data.object.toIdName);
                        jQuery("#shareName").attr('userId',data.object.toId);
                    }

                    newKindEditorObj.html(data.object.content);
                    //编辑回显中高管模板
                    templateInit(data.object.diaType, true);

                    if(data.object.attachmentId!=""){
                        var arr=data.object.attachment;
                        var stra=''
                        if(data.object.attachment.length > 0){   //附件显示
                            for(var i=0;i<arr.length;i++){
                                var fileExtension=arr[i].attachName.substring(arr[i].attachName.lastIndexOf(".")+1,arr[i].attachName.length);//截取附件文件后缀
                                var attName = encodeURI(arr[i].attachName).replace(/\+/g, "%2b").replace(/\@/g,"%40").replace(/\#/g,"%23").replace(/\&/g,"%26").replace(/\//g,"%2F").replace(/\?/g,"%3F").replace(/\￥/g,"%ef%bf%a5").replace(/\$/g,"%24").replace(/\！/g,"%ef%bc%81").replace(/\（/g,"%ef%bc%88").replace(/\）/g,"%ef%bc%89").replace(/\…/g,"%e2%80%a6%e2%80%a6");
                                var fileExtensionName=attName.substring(0,attName.lastIndexOf("."));
                                var deUrl = arr[i].attUrl.split('&ATTACHMENT_NAME=')[0]+"&ATTACHMENT_NAME="+fileExtensionName+"."+fileExtension+"&FILESIZE="+arr[i].size;

                                stra+='<div class="dech" deUrl="'+deUrl+'">' +
                                    '<a href="/download?'+encodeURI(deUrl)+'" NAME="'+arr[i].attachName+'*" style="text-decoration:none;">' +
                                    '<img style="margin-right:10px;" src="../img/attachment_icon.png"/>'+arr[i].attachName+'</a>' +
                                    '<img class="deImgs" style="margin-left:5px;cursor: pointer;" src="../img/file/icon_deletecha_03.png"/>' +
                                    '<input type="hidden" class="inHidden" value="'+arr[i].aid+'@'+arr[i].ym+'_'+arr[i].attachId+',">' +
                                    '</div>';
                            }
                            jQuery("#uploaderFiles").append(stra);
                        }


                    }

                    //点击html按钮，使模板主动显示
                    if (jQuery("#diary_connect").find("span")[0].className == "ke-outline ke-selected"){
                        jQuery("#diary_connect").find("span")[0].click();
                    }

                },
                error:function(xhr,type,errorThrown){
                    //异常处理；
                    mui.toast(type);
                }
            });
        }
    })(mui);
    function diary_save(s){
        var content;
        //中高管模板新建，修改时处理
        if ($('#diary_type').val() == 3 && isZhongGaoGuan == 1){
            templateToEditor(3);
            content = newKindEditorObj.html();
            //处理富文本自动生成的<br/>
            while (true){
                var beginbr = content.substring(0,7);
                if (beginbr != "<br />\n"){
                    break;
                }
                content = content.substring(7);
            }
        } else {
            content = newKindEditorObj.html();
        }

        var dia_type = $("#diary_type").val();
        var diary_title = $("#diary_title").val();
        var d_date = $("#diary_date").html();
        var diary_share = $("#diary_share_id").val();
        // var diary_connect = newKindEditorObj.html();
        var allowComment = $('#diary_discuss').val();
        var userTopId = $('#userTopName').attr('userId');

        if (content == ""){
            mui.toast("日志内容不能为空！");
        } else if (dia_type == "" && diary_title == "" && d_date == "" && diary_share == "" && diary_connect == ""){
            mui.toast("您还没有输入任何内容！");
        } else if ((userTopId == undefined || userTopId == "") && dia_type != 2) {
            mui.toast("您没有阅评上级，无法保存，只可以保存个人日志！");
        } else {
            //使提交按钮失效，避免多次提交
            $("#hd").css("pointer-events","none");
            $("#hds").css("pointer-events","none");

            var aId = '';
            var uId = '';
            if ($('.inHidden').length > 0) {
                for (var i = 0; i < $('.inHidden').length; i++) {
                    aId += $('.dech .inHidden').eq(i).val();
                }
            }
            if ($('.dech  .inHidden').length > 0) {
                for (var i = 0; i < $('.dech  .inHidden').length; i++) {
                    uId += $('.dech').eq(i).find('a').attr('NAME');
                }
            }

            var data={
                diaType:$('#diary_type').val(),
                subject:diary_title,
                content:content,
                toAll:0,
                toId:$('#shareName').attr('userId'),
                attachmentId:aId,
                attachmentName:uId,
                diaDate:$('#diary_date').text(),
                shareAll: 0,
                sendRemind: s,
                allowComment:allowComment,
                userTopId:userTopId,
                sFlag: s
            }
            if(DIA_ID!=undefined){
                data.diaId = DIA_ID;
                var url = '/diary/update'
            }else{
                var url = '/diary/save'
            }
            mui.ajax({
                type: 'POST',
                url: url,
                async:true,
                dataType:'json',
                data:data,
                beforeSend: function() {
                    // wait;
                },
                complete: function() {
                    // closewin;
                },
                success:function(data){
                    layer.closeAll();
                    if(s == 0){
                        mui.toast('保存成功',{ duration:'200', type:'div' });
                        $("#hd").css("pointer-events","auto");
                        $("#hds").css("pointer-events","auto");
                        mui.openWindow({
                            id:'/diary/diaryListh5',
                            url:'/ewx/diaryList?type=draft&dataType='+$.GetRequest().dataType
                        });
                    }else{
                        mui.toast('提交成功',{ duration:'200', type:'div' });
                        $("#hd").css("pointer-events","auto");
                        $("#hds").css("pointer-events","auto");
                        mui.openWindow({
                            id:'/diary/iStartedListh5',
                            url:'/ewx/iStartedList?type=initiated&dataType='+$.GetRequest().dataType
                        });
                    }

                },
                error:function(xhr,type,errorThrown){
                    $("#hd").css("pointer-events","auto");
                    $("#hds").css("pointer-events","auto");
                    //异常处理；
                    mui.toast("status："+ xhr.status + "；readyState：" + xhr.readyState + "；type：" + type + "；errorThrown：" + errorThrown);
                }
            });
        }

    }
    //定时保存
    // setInterval(function() {
    //     var dia_type = $("#diary_type").val();
    //     var diary_title = $("#diary_title").val();
    //     var d_date = $("#diary_date").html();
    //     var txt = $('.mui-text-justify').val();
    //     var diary_share = $("#diary_share_id").val();
    //     var diary_connect = $("#diary_connect .content").html();
    //     var allowComment = $('#diary_discuss').val()
    //     if (jQuery("#diary_connect .content").html() == '') {
    //         var diary_connect = ""
    //     } else {
    //         var diary_connect = jQuery("#diary_connect .content").html();
    //     }
    //     var aId='';
    //     var uId='';
    //     for(var i=0;i<$('.inHidden').length;i++){
    //         aId += $('.dech .inHidden').eq(i).val();
    //     }
    //     for(var i=0;i<$('.dech  .inHidden').length;i++){
    //         uId += $('.dech').eq(i).find('a').attr('NAME');
    //     }
    //     jQuery.ajax({
    //         type: 'POST',
    //         url: '/diary/save',
    //         async: true,
    //         dataType: 'json',
    //         data: {
    //             diaType:$('#diary_type').val(),
    //             subject:diary_title,
    //             content:diary_connect,
    //             toAll:0,
    //             toId:$('#shareName').attr('userId'),
    //             attachmentId:aId,
    //             attachmentName:uId,
    //             diaDate:$('#diary_date').text().split(' ')[0],
    //             shareAll: 0,
    //             sendRemind: 1,
    //             allowComment:allowComment,
    //             userTopId:$('userTopName').attr('userId'),
    //             sFlag:0
    //         },
    //         success: function(data) {
    //             DIA_ID = data.DIA_ID;
    //         }
    //     });
    // }, 180000);
    var vm=new Vue({
        el:'#topText',
        data:{
            name:'Vue.js'
        },
        methods:{
            jump_share:function(event){
                var r=document.getElementsByName("checkbox1");
                var to_id='',to_name='';
                for(var i=0;i<r.length;i++){
                    if(r[i].checked){
                        to_id+=r[i].value+",";
                        to_name+=r[i].previousSibling.firstChild.innerHTML+",";
                    }
                }
                jQuery("#diary_share_id").val(to_id);
                jQuery("#shareName").val(to_name);
                jQuery("#main").css("display","block");
                jQuery("#share").css("display","none");

            }
        }
    });




    //初始化文本内容
    function templateInit(typ, isedit){
        setTimeout(() => {
            if($('#template_diary #template_content').length < 1){
                return;
            }
            $("#templateDiary").hide();
            $("#normalDiary").show();
            //
            $('#template_diary #template_content [template_no]').each(function(){
                var tempno = $(this).attr('template_no');
                var temptyp = $(this).attr("template_typ");
                if(tempno == undefined || temptyp == undefined || typ != temptyp){
                    return;
                }
                //
                if(isedit){//编辑
                    var editorHtml = newKindEditorObj.html();
                    $("#temp_editor_html").html(editorHtml);
                    //var nodDiary = $('#normalDiary .content [template_no]');
                    var nodDiary = $('#temp_editor_html [template_no]');
                    var diaryno = nodDiary.attr("template_no");
                    var diarytyp = nodDiary.attr("template_typ");
                    if(diaryno != tempno || temptyp != diarytyp){
                        return;
                    }
                }
                $("#templateDiary").show();
                $("#normalDiary").hide();
                eval("setTemplate_" + tempno + "(" + (isedit ? "true" : "") + ")");
            });

            // 中高管模板 标题去除 <br>
            if (isZhongGaoGuan == 1) {
                var tr = $('#templateDiary').find('tr').eq(0).find('td');
                var trHtml = tr.html().replace(/<br>\n/g, "");
                tr.html(trHtml);
                for (var i = 1; i < 10; i++) {
                    if (i % 2 == 1) {
                        var td = $('#templateDiary').find('tr').eq(i).find('td').eq(i == 1 ? 2 : 1);
                        var tdHtml = td.html().replace(/<br>/g, "");
                        td.html(tdHtml);
                    }
                }
            }

        }, 50);
    }
    //提交时处理富文本编辑器文本
    function templateToEditor(typ){
        $('#templateDiary [template_no]').each(function(){
            var tempno = $(this).attr('template_no');
            var temptyp = $(this).attr("template_typ");
            if(tempno == undefined || temptyp == undefined || typ != temptyp){
                return;
            }
            eval("template2editor_" + tempno + "()");
        });
    }


    // tMobileSDK.ready(function() {
    //     /* jQuery('.flex-container').click(function(){
    //      alert(123123123);
    //      }); */
    //     // alert(platform);
    //     // alert(123123123);
    //     window.upload_sign = function(fileinfo, is_image){
    //         // alert(is_image);
    //         if(platform == "client"){
    //             $.each(fileinfo, function(k, file){
    //                 var name = file.name;
    //                 name = name.substring(0,name.length-1);
    //                 if(is_image){
    //                     $("#file").append('<a href="javascript:void(0);" data-attach_id="'+file.id+'" data-attach_name="'+name+'" class="pda_attach pda_attach_img" _href="'+file.url+'" is_image="1"><img src="'+ file.url +'" /><span class="icon-delete">×</span></a>');
    //                 }else{
    //                     $("#file").append('<a href="javascript:void(0);" data-attach_id="'+file.id+'" data-attach_name="'+name+'" class="pda_attach" _href="'+file.url+'"><span class="fileupload_attach_name">'+name+'</span><span class="icon-delete">×</span></a>');
    //                 }
    //
    //             });
    //         }else if(platform == "wx"){
    //             // alert('wxlalal');
    //             var imgServerId = tMobileSDK.imgServerId.join(',');
    //             // alert(imgServerId);
    //             $.ajax({
    //                 type: 'GET',
    //                 url: '/pda/workflow/img_download.php',
    //                 cache: false,
    //                 data: {
    //                     'ATTACHMENTS': imgServerId,
    //                     "PLATFORM": platform
    //                 },
    //                 success: function(ret)
    //                 {
    //                     // alert(ret);
    //                     str = '';
    //                     var d = JSON.parse(ret);
    //                     $.each(d, function(k, img){
    //                         var attach_id = img.attach_id;
    //                         var attach_name = img.attach_name;
    //                         var attach_url = img.attach_url;
    //                         // str += attach_id+',';
    //                         // $("#uploaderFiles").append('<li  data-attach_id="'+attach_id+'" data-attach_name="'+attach_name+'" class="pda_attach pda_attach_img" is_image="1" _href="'+attach_url+'" width="50" height="50"><img src="'+ attach_url +'" /><span class="icon-delete">×</span></li>');<li class="weui-uploader__file" style="background-image:url(#url#)"></li>
    //                         //$("#UPLOAD_AREA_PUBLIC").append('<a href="javascript:void(0);" data-attach_id="'+attach_id+'" data-attach_name="'+attach_name+'" class="pda_attach pda_attach_img" is_image="1" _href="'+attach_url+'"><img src="'+ attach_url +'" /><span class="icon-delete">×</span></a>');
    //                         id_str += attach_id;
    //                         name_str += attach_name+',';
    //
    //                         var tmpl = '<li class="weui-uploader__file pda_attach pda_attach_img" style="background-image:url(#url#)" data-attach_id="'+attach_id+'" data-attach_name="'+attach_name+'" ><span class="icon-delete">×</span></li>'
    //                         // alert(tmpl);
    //                         $("#uploaderFiles").append($(tmpl.replace('#url#', attach_url)));
    //
    //                     });
    //                 }
    //             });
    //         }
    //     }
    //     window.upload_images = function(callback, $list, from)//from是会签还是附件
    //     {
    //         // alert(callback);
    //         // return;
    //         if(typeof callback != "function"){
    //             callback = function(){}
    //         }
    //         $list = $("#uploaderFiles");
    //         try{
    //             if(platform == "client"){
    //                 tMobileSDK.chooseImage({
    //                     onSuccess: function(result) {
    //                         callback && callback(result, 'is_image');
    //                     },
    //                     onFail: function(err) {
    //                     }
    //                 });
    //             }else if(platform == "wx"){
    //                 tMobileSDK.uploadImage({
    //                     sizeType: ['compress'],
    //                     imgList: $list,
    //                     upErrorCb : function (){},
    //                     upSuccessCb: function (){
    //                         // alert('5121111');
    //                         callback && callback();
    //                         return;
    //                     },
    //                     imgTpl: ''
    //                 })
    //             }
    //
    //         }catch(e){
    //             alert(e);
    //         }
    //     }
    //     $('body').delegate('span.icon-delete', 'click', function(event){
    //         event.preventDefault();
    //         event.stopPropagation();
    //         var $this = $(this);
    //         var diary_id = $this.parent(".pda_attach").attr("data-diary-id");
    //         var id = $this.parent(".pda_attach").attr("data-attach_id");
    //         var name = $this.parent(".pda_attach").attr("data-attach_name");
    //         id_str = id_str.replace(id,'');
    //         name_str = name_str.replace(name,'');
    //         name_str = name_str.replace(',,',',');
    //         var delete_flag = delete_attach(id, name);
    //         if(delete_flag === true){
    //             $this.parent(".pda_attach").remove();
    //             //删除日志表的图片id和name
    //             jQuery.ajax({
    //                 type: 'POST',
    //                 url: 'data/data.php',
    //                 cache: false,
    //                 data: {
    //                     'flag':22,
    //                     "dia_id": diary_id,
    //                     "attach_id": id,
    //                     "attach_name": name
    //                 },
    //                 success: function(data)
    //                 {
    //
    //                 }
    //             });
    //         }
    //         return false;
    //     });
    //     window.delete_attach = function(id, name){
    //         var url = '';
    //         var delete_flag = false;
    //         $.ajax({
    //             type: 'GET',
    //             url: 'delete_sign_attach.php',
    //             cache: false,
    //             async: false,
    //             data: {
    //                 'ATTACHMENT_ID': id,
    //                 'ATTACHMENT_NAME': name
    //             },
    //             success: function(d){
    //                 if(d == '1'){
    //                     //alert("附件删除成功");
    //                     delete_flag = true;
    //                 }
    //             },
    //             error: function(e){
    //                 //alert("附件删除失败");
    //                 delete_flag = false;
    //             }
    //         });
    //         return delete_flag;
    //     }
    // });
</script>
<div id="temp_editor_html" style="display: none">

</div>
<div id="template_diary" style="display: none">
    <script type="text/javascript">
        $.fn.autoHeight_20211117 = function(){
            function autoHeight_20211117(elem){
                elem.style.height = 'auto';
                elem.scrollTop = 0; //防抖动
                elem.style.height = (elem.scrollHeight + 3) + 'px';
            }
            this.each(function(){
                autoHeight_20211117(this);
                $(this).on('keyup', function(){
                    autoHeight_20211117(this);
                });
            });
        }
        var setTemplate_20211117 = function(isedit){
            var htmlcontent = '';
            if(isedit == undefined || !isedit){
                htmlcontent = $("#template_content [template_no='20211117']")[0].outerHTML;
                htmlcontent = clearAll_20211117(htmlcontent, '\n');
                htmlcontent = clearAll_20211117(htmlcontent, '\r');
                htmlcontent = clearAll_20211117(htmlcontent, '  ');
            }else{
                $('#temp_editor_html').contents().find('[man]').each(function(){
                    var nodTd = $(this);
                    var htmltd = nodTd.html().replace(/\n\t\t\t\t/g, "").replace(/\n\t\t\t/g, "").replace(/<br>/g,"");
                    nodTd.html('<textarea style="width:99%;resize: none;font-size:12px;margin:0px;padding:3px;">' + htmltd + '</textarea>');
                });
                htmlcontent = $('#temp_editor_html').html();
            }
            $("#templateDiary").html(htmlcontent);
            $('#templateDiary').contents().find('[man]').each(function(){
                var nodTd = $(this);
                var nodText = nodTd.find('textarea').eq(0);
                nodText.autoHeight_20211117();
                nodText.click(function(){
                    $('body').removeClass('mui-focusin');
                    var flag = nodTd.attr('clr');
                    if(flag == undefined){
                        return;
                    }
                    nodTd.removeAttr('clr');
                    nodText.val('');
                });
                nodText.change(function() {
                    nodText.html(nodText.val());
                });
            });
        }
        var template2editor_20211117 = function(){
            $('#templateDiary').contents().find('textarea').change();
            var htmlcontent = $('#templateDiary').html();
            htmlcontent = htmlcontent.replace(/<\/textarea[^>]+>/g,"").replace(/<textarea[^\/^>]+>/g,"").replace(/\n/g,"<br>");
            newKindEditorObj.html(htmlcontent);
        }
        function clearAll_20211117(str,clearStr){
            while(str.indexOf(clearStr) != -1){
                str = str.replace(clearStr,'');
            }
            return str;
        }
    </script>
    <div id="template_content">
        <table class="td-min-height" style="border: 1px solid #7f7f7f; width: 100%;font:12px/1.2rem 宋体,SimSun;" data-sort="sortDisabled" template_no="20211117" template_typ="3">
            <tbody>
            <tr class="firstRow">
                <td style="border: 1px solid;padding:5px;height:27px;text-align:center;background-color: rgb(247, 150, 70); font-size: 14px;" rowspan="1" colspan="3">
                    <strong>工作周报事项</strong><br>
                </td>
            </tr>
            <tr>
                <td style="border: 1px solid;text-align:center;vertical-align:middle;background-color:#c4bd97;width:30px;padding:0;" rowspan="10">
                    <strong><span>工<br>作<br>复<br>盘</span></strong><br>
                </td>
                <td style="border: 1px solid;text-align:center;vertical-align:middle;background-color:#c4bd97;width:30px;padding:0;" rowspan="2">
                    <strong><span>1</span></strong>
                </td>
                <td style="border: 1px solid;padding:5px;">
                    <span><strong>本人亲自执行的系统建设</strong></span>
                </td>
            </tr>
            <tr>
                <td man clr style="border: 1px solid;padding:5px;height:fit-content;">
                    <textarea style="width:99%;resize: none;font-size:12px;margin:0px;padding:3px;">如：亲自拟定市场策略、规章制度、管理流程、工作方法，起草工作文件，编排工作分工，研究市场情况后的通报文件等</textarea>
                </td>
            </tr>
            <tr>
                <td rowspan="2" style="border: 1px solid;text-align:center;vertical-align:middle;background-color:#c4bd97;width:30px;padding:0;">
                    <strong><span>2</span></strong>
                </td>
                <td style="border: 1px solid;padding:5px;">
                    <strong><span>督导下属的工作</span></strong>
                </td>
            </tr>
            <tr>
                <td man clr style="border: 1px solid;padding:5px;height:fit-content;">
                    <textarea style="width:99%;resize: none;font-size:12px;margin:0px;padding:3px;">如：检查工作成果，督查工作进程，指导工作落地，教导下属工作方法等</textarea>
                </td>
            </tr>
            <tr>
                <td rowspan="2" style="border: 1px solid;text-align:center;vertical-align:middle;background-color:#c4bd97;width:30px;padding:0;">
                    <span><strong>3</strong></span>
                </td>
                <td style="border: 1px solid;padding:5px;">
                    <span><strong>跨部门沟通、协调、合作</strong></span>
                </td>
            </tr>
            <tr>
                <td man clr style="border: 1px solid;padding:5px;height:fit-content;">
                    <textarea style="width:99%;resize: none;font-size:12px;margin:0px;padding:3px;">如：跨部门的沟通、协调、合作等</textarea>
                </td>
            </tr>
            <tr>
                <td rowspan="2" style="border: 1px solid;text-align:center;vertical-align:middle;background-color:#c4bd97;width:30px;padding:0;">
                    <strong><span>4</span></strong>
                </td>
                <td style="border: 1px solid;padding:5px;">
                    <strong><span>外部互动</span></strong>
                </td>
            </tr>
            <tr>
                <td man clr style="border: 1px solid;padding:5px;height:fit-content;">
                    <textarea style="width:99%;resize: none;font-size:12px;margin:0px;padding:3px;">如：外部客户、供应商沟通，公关项目，社会互动等</textarea>
                </td>
            </tr>
            <tr>
                <td rowspan="2" style="border: 1px solid;text-align:center;vertical-align:middle;background-color:#c4bd97;width:30px;padding:0;">
                    <strong><span>5</span></strong>
                </td>
                <td style="border: 1px solid;padding:5px;">
                    <strong><span>组织文化建设</span></strong>
                </td>
            </tr>
            <tr>
                <td man clr style="border: 1px solid;padding:5px;height:fit-content;">
                    <textarea style="width:99%;resize: none;font-size:12px;margin:0px;padding:3px;">如：招聘、岗位职责梳理、学习培训、文化共创活动、员工沟通等</textarea>
                </td>
            </tr>
            <tr>
                <td colspan="2" style="border: 1px solid;text-align:center;vertical-align:middle;background-color:#c4bd97;width:30px;padding:0;">
                    <strong><span>工<br>作<br>总<br>结</span></strong>
                </td>
                <td man clr style="border: 1px solid;padding:5px;height:fit-content;">
                    <textarea style="width:99%;resize: none;font-size:12px;margin:0px;padding:3px;">针对前5项工作内容进行一个概括性的总结，提出对上周工作的思考、感悟以及需求</textarea>
                </td>
            </tr>
            <tr>
                <td rowspan="2" colspan="2" style="border: 1px solid;text-align:center;vertical-align:middle;background-color:#c4bd97;width:30px;padding:0;">
                    <strong><span>下<br>周<br>计<br>划</span></strong><br>
                </td>
                <td man clr style="border: 1px solid;padding:5px;height:fit-content;">
                    <textarea style="width:99%;resize: none;font-size:12px;margin:0px;padding:3px;">（1）下周核心工作事项，包括：集团重点事项、部门重点跟进事项；</textarea>
                </td>
            </tr>
            <tr>
                <td man clr style="border: 1px solid;padding:5px;height:fit-content;">
                    <textarea style="width:99%;resize: none;font-size:12px;margin:0px;padding:3px;">（2）对应的量化目标、时间节点以及预计产出结果。</textarea>
                </td>
            </tr>
            </tbody>
        </table>
    </div>
</div>
<script type="text/javascript">
    // 调用选择人员控件
    $('#yueping_logo').on('click',function(){
        yuepingUser();
    })
    $('#fenxiang_logo').on('click',function(){
        fenxiangUser();
    })

    function yuepingUser(){
        $('#main').hide();
        $('#userMain').show();

        GetUserQueryString("yueping");

        //常选人员
        users("yueping");
        init("yueping");
    }

    function fenxiangUser(){
        $('#main').hide();
        $('#userMain').show();

        GetUserQueryString("fenxiang");

        //常选人员
        users("fenxiang");
        init("fenxiang");
    }

    var index = 1;
    var userids = "";
    var deptIds = "";
    function GetUserQueryString(name) {
        if (name == "yueping"){
            if ($("#userTopName").attr("userid") != undefined){
                userids = $("#userTopName").attr("userid");
            } else {
                userids = "";
            }
            if ($("#userTopName").attr("deptid") != undefined){
                deptIds = $("#userTopName").attr("deptid");
            } else {
                deptIds = "";
            }
        } else if (name == "fenxiang"){
            if ($("#shareName").attr("userid") != undefined){
                userids = $("#shareName").attr("userid");
            } else {
                userids = "";
            }
            if ($("#shareName").attr("deptid") != undefined){
                deptIds = $("#shareName").attr("deptid");
            } else {
                deptIds = "";
            }
        }
    }
</script>
<script type="text/javascript">
    // 转换字符串到元素
    function strToDom(str) {
        var $div = $('<div></div>');
        $div.html(str);
        return $div.children().unwrap();
    }
    // 是否全部选中
    function isAllChecked(arr) {
        var select = true;
        for (var i = 0, len = arr.length; i < len; i++) {
            if (arr[i].checked === false) {
                select = false;
            }
        }
        return select;
    }
    // 创建部门元素
    function createPart(res, checked, upDepId, flag) {
        if (deptIds != '') {
            var deptid = deptIds.substring(0, deptIds.length - 1).split(',');
        }
        if (res.data && res.data.length) {
            var data = res.data;
            var str = '';
            var checkedStr = checked ? 'checked=true' : '';
            for (var i = 0, len = data.length; i < len; i++) {
                str += '<div class="department">' +
                    '<h3 flag="'+flag+'" class="mui-input-row mui-checkbox mui-right part" id="dept' + data[i].DEPT_ID + '" data-dept-id=' + data[i].DEPT_ID + ' data-up-deptid=' + upDepId + ' >' +
                    '<i class="file"></i>' +
                    '<span>' + data[i].DEPT_NAME + '</span>' +
                    '<input type="checkbox" name="part" id="" ' + checkedStr + ' ' +
                    function() {
                        if (deptIds != '') {
                            for (var j = 0; j < deptid.length; j++) {
                                if (deptid.indexOf(data[i].DEPT_ID) >= 0) {
                                    return 'checked'
                                }
                            }
                        }
                    }() + ' /></h3>' +
                    '</div>'
            }
            return strToDom(str);
        } else {
            return "";
        }
    }
    //创建人员元素
    function createPerson(res, checked, upDepId, flag) {
        if (userids != '') {
            var udid = userids.substring(0, userids.length - 1).split(',');
        }
        if (res.item && res.item.length) {
            var data = res.item;
            var str = '';
            var checkStr = checked ? 'checked=true' : '';
            for (var i = 0, len = data.length; i < len; i++) {
                str += '<div class="department">' +
                    '<h3 flag="'+flag+'" class="mui-input-row mui-checkbox mui-right person" data-up-deptid=' + upDepId + ' data-user-id=' + data[i].USER_ID + '>' +
                    '<span>' + data[i].USER_NAME + '</span>' +
                    '<input type="checkbox" name="person" ' +
                    function() {
                        if (userids != '') {
                            for (var j = 0; j < udid.length; j++) {
                                if (udid.indexOf(data[i].USER_ID) >= 0) {
                                    return 'checked'
                                }
                            }
                        }
                    }() + ' id="" ' + checkStr + ' /></h3>' +
                    '</div>'
            }
            return strToDom(str);
        } else {
            return "";
        }
    }

    //常选人员
    function users(flag) {
        if (flag == null){
            flag = ""
        }
        $("#userss").attr("flag", flag);
        if (userids != '') {
            var udid = userids.substring(0, userids.length - 1).split(',');
        }
        $.ajax({
            url: '/user/regularElection',
            type: 'get',
            data: {
                userIds: userids
            },
            dataType: 'json',
            success: function(res) {
                if (res.flag && res.obj != null) {
                    var str = '';
                    for (var i = 0; i < res.obj.length; i++) {
                        if (res.obj[i].USER_NAME != "") {
                            str += '<div class="users">' +
                                '<h3 flag="'+flag+'" class="mui-input-row mui-checkbox mui-right userPerson" data-user-id=' + res.obj[i].USER_ID + '>' +
                                '<span>' + res.obj[i].USER_NAME + '</span>' +
                                '<input type="checkbox" name="userPerson" ' +
                                function() {
                                    if (userids) {
                                        for (var j = 0; j < udid.length; j++) {
                                            if (udid.indexOf(res.obj[i].USER_ID) >= 0) {
                                                return 'checked=true'
                                            }
                                        }
                                    }
                                }() + ' id="" /></h3>' +
                                '</div>'
                        }
                    }
                    $('.users').append(str)
                }
            }
        })
    }

    // 初始化页面
    function init(flag) {
        if (flag == null){
            flag = ""
        }
        index = 1;
        clicked = {};
        $.ajax({
            url: '/user/getUserStructure',
            datatype: 'json',
            type: 'get',
            data: {
                deptId: ''
            },
            success: function(res) {
                var parts = createPart(res.object, false, 0, flag);
                var persons = createPerson(res.object, false, 0, flag);
                $('.main').append(parts);
                $('.main').append(persons);
                var dept_top = deptTop;
                if (dept_top != "") {
                    var arr = dept_top.split(',');
                    if (arr.length > 1) {
                        var arr2 = arr.reverse();
                        $('[data-dept-id=' + arr2[1] + ']').trigger('click');
                        index++;
                        if (arr.length <= 2) {

                        }
                    }
                }
            }
        })
    }

    function uniq(array) {
        var temp = []; //一个新的临时数组
        for (var i = 0; i < array.length; i++) {
            if (temp.indexOf(array[i]) == -1) {
                temp.push(array[i]);
            }
        }
        return temp;
    }

    // 缓存部门点击事件是否点击
    var clicked = {};

    $(function() {
        //常用人员点击事件
        $('.main').on('click', 'input[type=checkbox]', function() {
            var userId = $(this).parent().attr('data-user-id');
            if (!$(this).is(':checked')) {
                if (userids != '') {
                    var uid = userids.split(',')
                    for (var i = 0; i < uid.length; i++) {
                        if (uid[i] == userId) {
                            uid.splice(i, 1)
                        }
                    }
                    var uuid = uid.join(',')

                    userids = uuid;
                }
                $('[data-user-id="' + userId + '"]').find('input').prop('checked', false)
            } else {
                userids += userId + ','
                $('[data-user-id="' + userId + '"]').find('input').prop('checked', true)
            }
        })

        var flag = true;
        $('#users').click(function(e) {
            if (flag) {
                $('#userss').find('.users').hide();
                flag = false;
            } else {
                $('#userss').find('.users').show();
                flag = true;
            }
        })

        // 部门点击事件
        $('.main').on('click', '[data-dept-id]', function(e) {
            var checked = $(this).find('>[type=checkbox]').prop('checked');
            var curEle = $(this);
            curEle.nextAll().toggle();
            var depid = curEle.attr('data-dept-id');
            var flag = curEle.attr("flag");
            if (!clicked["deptid" + depid]) {
                clicked["deptid" + depid] = true;
                $.ajax({
                    url: "/user/getUserStructure",
                    data: {
                        deptId: depid
                    },
                    type: 'get',
                    success: function(res) {
                        var personEle = createPerson(res.object, checked, depid, flag);
                        var partEle = createPart(res.object, checked, depid, flag);
                        curEle.parent().append(personEle).append(partEle);

                        var dept_top = deptTop;
                        if (dept_top != "") {
                            var arr = dept_top.split(',');
                            if (index <= arr.length) {
                                var arr2 = arr.reverse();
                                if (arr2[index] != undefined && arr2[index] != "") {
                                    $('[data-dept-id=' + arr2[index] + ']').trigger('click');
                                    index++;
                                }
                            }
                        }
                    }
                })
            }
        })

        // 复选款的点击事件
        $('.main').on('click', '[type=checkbox]', function(e) {
            // 全部选中
            var selectVal = $(this).prop('checked');
            $(this).parent().parent().find('[type=checkbox]').prop('checked', selectVal)
            totalCheck(this);
            e.stopPropagation();
        })

        // 部门总体点击按钮是否点击
        function totalCheck(el) {
            // 获取总的input框
            var $parent = $(el).parent().parent().parent();
            var totalCheckbox = $parent.find('>h3.mui-input-row>[type=checkbox]')
            // 获取当前同等级的checkbox
            var equalCheckbox = $parent.find('>div.department>.mui-input-row>[type=checkbox]');
            // 下一级菜单选中之后，上一级菜单是否全选中
            totalCheckbox.prop('checked', isAllChecked(equalCheckbox));
            // 下一个
            var upLevelCatalog = $parent.parent().find('>h3.mui-input-row>[type=checkbox]');
            if (upLevelCatalog.length) {
                totalCheck(totalCheckbox)
            }
        }

        // 点击选择人员控件 确定按钮
        $('#save_share').on('click', function() {
            let $checkboxs = $('.department input[type=checkbox]');
            let $checkboxs2 = $('#userss input[type=checkbox]');

            var USER_ID = "";
            var DEPT_ID = "";
            var userDeptName = "";
            var depId, userId;

            var userArr = [];
            for (var i = 0, len = $checkboxs.length; i < len; i++) {
                if ($checkboxs[i].checked === true) {
                    var parent = $($checkboxs[i]).parent();
                    depId = parent.attr('data-dept-id');
                    userDeptName += parent.find("span").html() + ",";
                    if (depId !== '' && depId != undefined) {

                        DEPT_ID += depId + ','
                    }
                    userId = parent.attr('data-user-id');
                    if (userId !== '' && userId != undefined) {
                        userArr.push(userId)
                    }
                }
            }

            for (var j = 0, len2 = $checkboxs2.length; j < len2; j++) {
                if ($checkboxs2[j].checked === true) {
                    var parent = $($checkboxs2[j]).parent();

                    userId = parent.attr('data-user-id');
                    if (userId !== '' && userId != undefined) {
                        userArr.push(userId)
                    }
                }
            }
            var arrUsers = uniq(userArr);
            for (var m = 0; m < arrUsers.length; m++) {
                USER_ID += arrUsers[m] + ','
            }

            // 获取已选择人员的用户名称
            $.ajax({
                url: '/user/regularElection',
                type: 'get',
                data: {
                    userIds: USER_ID
                },
                dataType: 'json',
                success: function (res) {
                    if (res.flag && res.object != null){
                        var flag = $("#userss").attr("flag"); //判断是阅评人员还是分享人员

                        if (flag && flag == "yueping"){
                            $("#userTopName").attr("userid", USER_ID);
                            $("#userTopName").val(res.object.userNames);
                            $("#userTopName").attr("deptid", DEPT_ID);

                            $('#main').show();
                            $('#userMain').hide();
                        } else if (flag && flag == "fenxiang"){
                            $("#shareName").attr("userid", USER_ID);
                            $("#shareName").val(res.object.userNames);
                            $("#shareName").attr("deptid", DEPT_ID);

                            $('#main').show();
                            $('#userMain').hide();
                        }

                        $('.main').html(
                            '<div class="users" id="userss" style="display: block;"> '
                            + '<h3 id="users" class="mui-input-row mui-checkbox mui-right">'
                            + '<label><i class="selectFile"></i><span>常选人员</span></label>'
                            + '</h3>'
                            + '</div>'
                        );

                        // 滚动到页面顶部
                        $(window).scrollTop(0);
                    }
                }
            })
        })
        // 去除重复的部分
        //    function deleteRepeat(USER_ID,DEPT_ID) {
        //      var deptIdArr = DEPT_ID;
        //      var userIdArr = USER_ID;
        //      for(var i = 0, len = userIdArr.length; i < len; i++) {
        //        var curUpDepId = $('[data-user-id='+userIdArr[i]+']').attr('data-up-deptid');
        //        if(isInArr(curUpDepId, deptIdArr)) {
        //            delItem(userIdArr[i], userIdArr);
        //        }
        //      }
        //      for(var j = 0; j < deptIdArr.length; j++) {
        //          var $curUpDepId = $('[data-dept-id='+deptIdArr[j]+']').attr('data-up-deptid');
        //          if(isInArr($curUpDepId, deptIdArr)) {
        //            delItem(deptIdArr[j], deptIdArr);
        //            j--;
        //          }
        //      }
        //      return USER_ID ;
        //      return DEPT_ID;
        //    }
        // 数组查询方法
        //    function isInArr (str, arr) {
        //      var isHas = false;
        //      for(var i = 0, len = arr.length; i < len; i++) {
        //        if(arr[i] === str) {
        //          isHas = true;
        //        }
        //      }
        //      return isHas;
        //    }
        // 数组删除元素方法
        //    function delItem(str, arr) {
        //      var index;
        //      for(var i = 0, len = arr.length; i < len; i++) {
        //        if(arr[i] === str) {
        //          index = i;
        //        }
        //      }
        //      if(index!=undefined) {
        //        arr.splice(index, 1);
        //      }
        //      return arr;
        //    }

        // 搜索框事件
        $('.top [type=search]').on('keyup', function(e) {
            var val = $(this).val().trim();
            if (e.keyCode === 13 && val !== '') {
                $.ajax({
                    url: '/pda/diary/data/data.php',
                    type: 'get',
                    data: {
                        flag: 20,
                        keyword: val
                    },
                    success: function(res) {
                        res = JSON.parse(res);
                        console.log(res);
                        var partEl = createPart(res.object);
                        var personEl = createPerson(res.object);
                        $('.main').html('').append(partEl).append(personEl);
                    }
                })
            }
        })

        var $top = $('.top');
        var $hiddenEl = $top.find('.mui-input-row>.mui-icon');

        $top.on('click', 'p', function() {
            $(this).hide();
            $top.find('[type=search]').focus();
        })

        $('.top [type=search]').on('blur', function() {
            if ($(this).val() === '') {
                $(this).parent().find('>p').show();
            }
            $hiddenEl.addClass('mui-hidden');
        })

        $('.top [type=search]').on("focus", function() {
            $hiddenEl.removeClass('mui-hidden');
        })
    })

</script>
</html>