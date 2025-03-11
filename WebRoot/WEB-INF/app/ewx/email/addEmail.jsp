<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@taglib prefix="mvc" uri="http://www.springframework.org/tags/form" %>
<%@taglib prefix="fmt" uri="http://www.springframework.org/tags" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html>
<head>
    <meta charset="utf-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport" content="width=device-width, initial-scale=1.0,user-scalable=0, minimum-scale=1.0, maximum-scale=1.0">
    <meta name="apple-mobile-web-app-capable" content="yes">
    <meta name="apple-mobile-web-app-status-bar-style" content="black">
    <link rel="stylesheet" href="../../css/email/m/jquery.mobile.css" />
    <link rel="stylesheet" href="../../lib/mui/mui/mui.min.css"/>
    <link rel="stylesheet" href="../../css/email/m/mail.css" />
    <link rel="stylesheet" type="text/css" href="../../css/email/m/add_mail.css"/>


    <link href="../../css/animate.min.css" rel="stylesheet" />
    <script type="text/javascript" src="/js/xoajq/xoajq3.js"></script>
    <script type="text/javascript" src="/js/jquery/jquery-migrate-3.4.0.js"></script>
    <script src="/lib/jQuery-File-Upload-master/jquery-ui.js" type="text/javascript" charset="utf-8"></script>
    <script src="/lib/jQuery-File-Upload-master/jquery.iframe-transport.js" type="text/javascript" charset="utf-8"></script>
    <script src="/lib/jQuery-File-Upload-master/jquery.fileupload.js" type="text/javascript" charset="utf-8"></script>
    <script src="../js/news/page.js"></script>
    <script src="../lib/laydate/laydate.js"></script>
    <script type="text/javascript" src="../../js/base/base.js"></script>
    <script type="text/javascript" src="../../js/ewx/waterMark.js?20190819.2"></script>
    <script src="../lib/pagination/js/jquery.pagination.min.js" type="text/javascript" charset="utf-8"></script>
    <link rel="stylesheet" type="text/css" href="../css/news/new_news.css"/>
    <script src="../../lib/laydate/laydate.js"></script>
    <script src="../../lib/layer/layer.js?20201106"></script>
    <script src="../js/jquery/jquery.cookie.js"></script>
    <script src="/js/ajaxupload.js?20230509.1" type="text/javascript" charset="utf-8"></script>
    <script src="/js/jquery/jquery.form.min.js"></script>

    <script>
        var attachmentId=''
        var attachmentName=''
        $(function(){
            $('#uploadinputimg').fileupload({
                dataType:'json',
                done: function (e, data) {
                    if(data.result.obj != ''){
                        var data = data.result.obj;
                        var str = '';
                        var str1 = '';
                        for (var i = 0; i < data.length; i++) {
                            var gs = data[i].attachName.split('.')[1];
                            if(gs == 'jsp'||gs == 'css'||gs == 'js'||gs == 'html'||gs == 'java'||gs == 'php' ){
                                str += '';
                                layer.alert('jsp、css、js、html、java文件禁止上传!',{},function(){
                                    layer.closeAll();
                                });
                            }else{
                                var attname = data[i].aid+'@'+data[i].ym+'_'+data[i].attachId
                                attachmentId+=attname+','
                                attachmentName+=data[i].attachName+'*'

                                str+='<div class="dech" deUrl="'+encodeURI(data[i].attUrl)+'" style="display:block;"><a class="ATTACH_a" NAME="'+data[i].attachName+'*" href="/download?'+encodeURI(data[i].attUrl)+'">'+data[i].attachName+'</a><img class="deImgs" style="margin-left:5px;cursor: pointer;" src="../img/file/icon_deletecha_03.png"/><input type="hidden" NAME="'+data[i].attachName+'*"  class="inHidden" value="'+data[i].aid+'@'+data[i].ym+'_'+data[i].attachId+',"></div>';
                            }
                        }
                        $('#query_uploadArr').append(str);
                    }else{
                        //alert('添加附件大小不能为空!');
                        layer.alert('添加附件大小不能为空!',{},function(){
                            layer.closeAll();
                        });
                    }
                }
            });
        })

    </script>
    <title>发邮件</title>
    <style>
        html,body{
            height: 100%;
            width:100%;
            overflow: auto;
        }
        .mui-table-view-cell{
            padding: 6px 15px;
        }
        .mui-bar-nav~.mui-content {
            height: 100%;
            background: #fff;
            overflow: auto;
        }
        .mui-input-row label{
            padding-left: 0;font-family:'microsoft yahei';width: 80px;
        }
        .mui-input-row label~input{
            float: left;
            padding: 10px 0;
            width: calc(100% - 120px);
        }
        .mui-input-row span{
            float: right;
            line-height: 40px;
        }
        .mui-input-row span img{
            vertical-align: top;
        }
        .mui-text-justify{
            /*height: calc(100% - 100px) !important;*/
            height: 300px;
        }
        textarea{
            height: calc(100% - 40px) !important;
            border: 0;
            text-indent: 2em;
            padding: 10px;
        }
        .mui-content form p{
            margin: 20px;
            font-size: 16px;
        }
        #forms label,#forms1 label{
            width: 400px;
        }
        #modal header{overflow: hidden;}
        .checkbox1,.checkbox2{
            width: 70px;
            height: 70px;
        }

        #header{
            position: relative;
            bottom: 0;
            background: #007aff;
            display: flex;
            align-items: center;
            justify-content: center;
            height: 44px;
            width: 100%;
        }
        #send{
            color: #fff;
            font-size: 18px;
            letter-spacing: 1px;
            width: 100%;
            height: 44px;
            display: flex;
            align-items: center;
            justify-content: center;
        }
        .mui-content {
            height: calc(100% - 45px);
            background: #fff;
        }
    </style>
</head>
<body id="add">

<div class="mui-content" id="aaa">
    <div class="mui-table">
        <ul class="mui-table-view">
            <li class="mui-table-view-cell mui-input-row"><label class="mui-left">收件人：</label><input type="text" placeholder="选择收件人" value="" class="mui-input-clear" id="tname"/><input value="" type="hidden" id="reciever"/><span id="Popover_0" class='mui-icon mui-icon-plus'  ></span></li>
            <li class="mui-table-view-cell mui-input-row"><label class="mui-left">抄送人：</label><input type="text" placeholder="选择抄送人" value="" id="cname" class="mui-input-clear"/><input type="hidden" value="" id="copyreciever"/><span id="Popover_1" class='mui-icon mui-icon-plus'></span></li>
            <li class="mui-table-view-cell mui-input-row"><label class="mui-left">标题：</label><input type="text" placeholder="请输入主题" class="mui-input-clear" value="" id="mtitle"/></li>
            <li class="mui-table-view-cell">
                <div class="new_type">附&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;件：
                    <span class='mui-icon mui-icon-plus mui-pull-right' onclick="appendByGallery()" id="uploadimg">
                        <form id="uploadimgform" target="uploadiframe" action="../upload?module=email" enctype="multipart/form-data" method="post">
                            <input type="file" multiple="multiple" name="file" id="uploadinputimg" class="w-icon5" style="position: absolute;top:6px;opacity: 0;width: 70px;
                            filter: progid:DXImageTransform.Microsoft.Alpha(opacity=0)">
                            <a id="" style="cursor: pointer;"></a>
                        </form>
                    </span>
                </div>
                <div class="log_share">
                    <ul id="files" style="text-align:left;width: 85%;display: inline-block;">
                        <%--<p id="empty" style="font-size:12px;color:#C6C6C6;">无上传文件</p>--%>
                        <div style="font-size:12px;color:#C6C6C6;" id="query_uploadArr" style="display:block;">
                        </div>
                    </ul>
                </div>
            </li>
        </ul>
    </div>
    <div class="mui-text-justify">
        <textarea class="mui-text-left mui-bor" placeholder="输入正文" id="msg_str"></textarea>
        <%--<div class="mui-text-center" id="start"></div>--%>
    </div>
</div>

<div class="mui-content" style="display: none" id="ccc">
    <div class="mui-bar mui-bar-nav" id="header2" style="height: 100px;">
        <a class="mui-icon mui-icon-close mui-pull-left" href="#modal" id="app"></a>
        <h1 class="mui-title">选择收件人</h1>
        <a class="mui-btn-link mui-pull-right" id="re_mail">确认</a>
        <div style="margin-top: 45px;">
            <span>姓名</span>
            <input type="text" name="username" style="width: 73%;height: 36px;border-radius: 10px" class="shoujian">
            <button type="button" class="mui-btn mui-btn-primary userNames1" style="vertical-align: text-bottom;border-radius: 10px">搜索</button>
        </div>
    </div>
    <div  style="height: 100%;margin-top: 100px">
        <div id="forms">

        </div>
    </div>
</div>
<div class="mui-content"  style="display: none" id="bbb">
    <div class="mui-bar mui-bar-nav" id="header1" style="height: 100px;">
        <a class="mui-icon mui-icon-close mui-pull-left" href="#modal1"  id="app1"></a>
        <h1 class="mui-title">选择抄送人</h1>
        <a class="mui-btn-link mui-pull-right" id="re_mail1">确认</a>
        <div style="margin-top: 45px;">
            <span>姓名</span>
            <input type="text" name="username" style="width: 73%;height: 36px;border-radius: 10px" class="chaosong">
            <button type="button" class="mui-btn mui-btn-primary userNames2" style="vertical-align: text-bottom;border-radius: 10px">搜索</button>
        </div>
    </div>
    <div  style="height: 100%;margin-top: 100px">
        <div id="forms1">

        </div>
    </div>
</div>
<div class="mui-bar-nav" id="header">
    <a class="" id="send">发送</a>
</div>
<%--<script type="text/javascript" src="../../js/notes/jquery-2.1.2.min.js" ></script>--%>
<script type="text/javascript" src="../../lib/mui/mui/mui.min.js" ></script>
<script type="text/javascript" src="../../js/diary/m/simbaJs.js" ></script>
<script type="text/javascript" src="../../js/diary/m/vue.min.js" ></script>
<script type="text/javascript">
    var deptId = 1;
    $.ajax({
        type:'get',
        url:'/getLoginUser',
        dataType:'json',
        success:function(res){
            if(res.flag && res.object != null){
                deptId = res.object.deptId;
            }
        }
    });

    /**
     * @property{IDString} id id元素
     * @param {AttrString}
     * @param {AttrValueString}
     * @type {HTMLString}
     */
    var mid='',num='';
    var checkVals;
    var checkVals1
    var u = navigator.userAgent;
    var receiptObj = []
    var receiptObj2 = []
    var checkSearch = [];
    var checkSearchName = [];
    var isAndroid = u.indexOf('Android') > -1 || u.indexOf('Adr') > -1; //android终端
    var isiOS = !!u.match(/\(i[^;]+;( U;)? CPU.+Mac OS X/); //ios终端
//    if(isAndroid == true){
//        document.getElementById("start").innerHTML='---发自我的全流程Android版本---';
//    }else if(isiOS == true){
//        document.getElementById("start").innerHTML='---发自我的全流程IOS版本---';
//    }

    //收件人
    var selectId = ''
    var selectName = ''
    var btn0 = document.getElementById("Popover_0");
    btn0.addEventListener('tap', function() {
        data = {
            notLogin : 0,
            deptId : deptId,
        };

        var header = document.getElementById("header")
        var bt111 = document.getElementById("aaa");
        var bt = document.getElementById("ccc");
        bt111.style.display= "none";
        header.style.display= "none";
        bt.style.display= "block";
        //获取收件人已选择的人员userId
        var tnameUserIds = $("#tname").attr("ids");
        if (tnameUserIds != undefined && tnameUserIds != ""){
            data['userIds'] = tnameUserIds;
        }
        mui.ajax('/user/getAlluser', {
            dataType: 'json',//服务器返回json格式数据
            type: 'get',//HTTP请求类型
            data: data,
            success: function (data) {
                //服务器返回响应，根据响应结果，分析是否登录成功；
                if (data.flag) {
                    var str='';
                    var arr=data.obj
                    for(var i=0;i<arr.length;i++){
                        str+='<div class="mui-input-row mui-checkbox mui-left">'+
                            '<label style="line-height: 34px">'+arr[i].userName+'</label>'+
                            '<input style="width: 70px;height: 70px;" class="checkbox1" name="checkbox1" onClick="checkReceipt(this)" value="'+arr[i].userName+'" type="checkbox" ids="'+arr[i].userId+'">'+
                            '</div>'
                    }
                }
                $("#forms")[0].innerHTML = str;
                receiptObj = []
                if($('#tname').attr('ids') != undefined){
                    // var checkVal = $('#tname').attr('ids').split(',')
                    for(let i=0;i<$('.checkbox1').length;i++){
                        if($('#tname').attr('ids').split(',').indexOf($('.checkbox1')[i].getAttribute('ids'))!=-1){
                            $('.checkbox1')[i].setAttribute('checked',true)
                            receiptObj.push({
                                id:$('.checkbox1')[i].getAttribute('ids'),
                                value:$('.checkbox1')[i].value,
                            })
                        }
                    }
                }
            },
            error: function (xhr, type, errorThrown) {
                //异常处理；
                //console.log(type);
            }
        });
        mui("#header2").on('tap', '#re_mail', function () {
            var rdsObj   = document.getElementsByClassName('checkbox1');
            checkVals = [];
            for(var i = 0; i < rdsObj.length; i++){
                if(rdsObj[i].checked){
                    checkVals.push(rdsObj[i].getAttribute('ids'))
                }
            }

            bt111.style.display= "block";
            bt.style.display= "none";
            header.style.display= "block";
            $('#tname').attr('ids',receiptObj.map(item=>item.id).join(','))
            $('#tname').attr('value',receiptObj.map(item=>item.value).join(','))

        });
    });



    // 收件人点击搜索的界面
    $('.userNames1').on('tap', function() {
        if ($('.shoujian').val() != ""){
            mui.ajax('/user/getAlluser', {
                dataType: 'json',//服务器返回json格式数据
                type: 'get',//HTTP请求类型
                data:{
                    notLogin:0,
                    userName:$('.shoujian').val(),
                    page:1,
                    pageSize:100,
                    useFlag:true
                },
                success: function (data) {
                    if(data.obj==undefined || data.obj== ""){
                        var app='<div class="mui-input-row mui-checkbox mui-left" style="margin-top: 110px;font-size: 25px;text-align: center;">暂无数据</div>'
                        $("#forms")[0].innerHTML = app;
                    }else{
                        var str='';
                        var arr=data.obj
                        for(var i=0;i<arr.length;i++){
                            str+='<div class="mui-input-row mui-checkbox mui-left">'+
                                '<label style="line-height: 34px">'+arr[i].userName+'</label>'+
                                '<input style="width: 70px;height: 70px;" class="checkbox1" name="checkbox1" onClick="checkReceipt(this)" value="'+arr[i].userName+'" type="checkbox" ids="'+arr[i].userId+'">'+
                                '</div>'
                        }
                        $("#forms")[0].innerHTML = str;

                        for(var i = 0; i < $('.checkbox1').length; i++){
                            if(receiptObj.map(item=>item.id).indexOf($('.checkbox1')[i].getAttribute('ids'))!=-1){
                                $('.checkbox1')[i].setAttribute('checked',true)
                            }
                        }
                    }
                }
            });
            $('input[name="username"]').val('')
        }
    })
    function checkReceipt(el,type){
        if(type == '1'){
            if(receiptObj2.map(item=>item.id).indexOf(el.getAttribute('ids'))!=-1){
                receiptObj2.splice(receiptObj2.map(item=>item.id).indexOf(el.getAttribute('ids')),1)
            }else{
                receiptObj2.push({
                    id:el.getAttribute('ids'),
                    value:el.value,
                })
            }
        }else{
            if(receiptObj.map(item=>item.id).indexOf(el.getAttribute('ids'))!=-1){
                receiptObj.splice(receiptObj.map(item=>item.id).indexOf(el.getAttribute('ids')),1)
            }else{
                receiptObj.push({
                    id:el.getAttribute('ids'),
                    value:el.value,
                })
            }
        }
    }


    //抄送人点击搜索的界面
    var selectId2 = ''
    var selectName2 = ''
    $('.userNames2').on('tap', function() {
        if ($('.chaosong').val() != ""){
            mui.ajax('/user/getAlluser', {
                dataType: 'json',//服务器返回json格式数据
                type: 'get',//HTTP请求类型
                data:{
                    notLogin:0,
                    userName:$('.chaosong').val(),
                    page:1,
                    pageSize:100,
                    useFlag:true
                },
                success: function (data) {
                    if(data.obj==undefined || data.obj== ""){
                        var app='<div class="mui-input-row mui-checkbox mui-left" style="margin-top: 110px;font-size: 25px;text-align: center;">暂无数据</div>'
                        $("#forms1")[0].innerHTML = app;
                    }else{
                        var str='';
                        var arr=data.obj
                        for(var i=0;i<arr.length;i++){
                            str+='<div class="mui-input-row  mui-checkbox mui-left">'+
                                '<label style="line-height: 34px">'+arr[i].userName+'</label>'+
                                '<input style="width: 70px;height: 70px;" class="checkbox2" name="checkbox2" value="'+arr[i].userName+'" onClick="checkReceipt(this,1)" type="checkbox" ids="'+arr[i].userId+'">'+
                                '</div>'
                        }
                        $("#forms1")[0].innerHTML = str;
                        for(var i = 0; i < $('.checkbox2').length; i++){
                            if(receiptObj2.map(item=>item.id).indexOf($('.checkbox2')[i].getAttribute('ids'))!=-1){
                                $('.checkbox2')[i].setAttribute('checked',true)
                            }
                        }
                    }
                }
            });
            $('input[name="username"]').val('')
        }
    })

    //抄送人
    var btn1 = document.getElementById("Popover_1");
    btn1.addEventListener('tap', function() {
        data = {
            notLogin : 0,
            deptId : deptId,
        };

        var header = document.getElementById("header");
        var bt111 = document.getElementById("aaa");
        var bt = document.getElementById("bbb");
        bt111.style.display= "none";
        header.style.display= "none";
        bt.style.display= "block";
        //获取抄送人已选择的人员userId
        var cnameUserIds = $("#cname").attr("ids");
        if (cnameUserIds != undefined && cnameUserIds != ""){
            data['userIds'] = cnameUserIds;
        }
        mui.ajax('/user/getAlluser', {
            dataType: 'json',//服务器返回json格式数据
            type: 'get',//HTTP请求类型
            data: data,
            success: function (data) {
                //服务器返回响应，根据响应结果，分析是否登录成功；
                if (data.flag) {
                    var str='';
                    var arr=data.obj
                    for(var i=0;i<arr.length;i++){
                        str+='<div class="mui-input-row mui-checkbox mui-left">'+
                            '<label style="line-height: 34px">'+arr[i].userName+'</label>'+
                            '<input style="width: 70px;height: 70px;" class="checkbox2" name="checkbox2" value="'+arr[i].userName+'" onClick="checkReceipt(this,1)" type="checkbox" ids="'+arr[i].userId+'">'+
                            '</div>'
                    }
                }
                $("#forms1")[0].innerHTML = str;
                receiptObj2 = []
                if($('#cname').attr('ids') != undefined){
                    for(let i=0;i<$('.checkbox2').length;i++){
                        if($('#cname').attr('ids').split(',').indexOf($('.checkbox2')[i].getAttribute('ids'))!=-1){
                            $('.checkbox2')[i].setAttribute('checked',true)
                            receiptObj2.push({
                                id:$('.checkbox2')[i].getAttribute('ids'),
                                value:$('.checkbox2')[i].value,
                            })
                        }
                    }
                }
            },
            error: function (xhr, type, errorThrown) {
                //异常处理；
                //console.log(type);
            }
        });
        mui("#header1").on('tap', '#re_mail1', function () {
            var rdsObj   = document.getElementsByClassName('checkbox2');
            checkVals1 = [];
            for(var i = 0; i < rdsObj.length; i++){
                if(rdsObj[i].checked){
                    checkVals1.push(rdsObj[i].getAttribute('ids'))
                }
            }
            bt111.style.display= "block";
            bt.style.display= "none";
            header.style.display= "block";
            $('#cname').attr('ids',receiptObj2.map(item=>item.id).join(','))
            $('#cname').attr('value',receiptObj2.map(item=>item.value).join(','))
        });
    });
    $('#app').on('click', function(){
        var header = document.getElementById("header");
        var bt111 = document.getElementById("aaa");
        var bt = document.getElementById("ccc");
        bt111.style.display= "block";
        header.style.display= "block";
        bt.style.display= "none";
    })
    $('#app1').on('click', function(){
        var header = document.getElementById("header");
        var bt111 = document.getElementById("aaa");
        var bt = document.getElementById("bbb");
        bt111.style.display= "block";
        header.style.display= "block";
        bt.style.display= "none";

    })
    //上传
    function appendByGallery(){

    }
    //    //发送邮件
    mui('#header').on('tap', '#send', function(e) {
        var str1=''
        if(checkVals1==undefined){
            str1=''
        }else{
            str1+=checkVals1.join(",")
        }

        if(document.getElementById("tname").value==""){
            var btnArray = ['确认'];
            mui.confirm('请选择至少一个收件人！', ' ', btnArray, function(e) {
            })
        }else{
            if(document.getElementById("mtitle").value==""){
                var btnArray = ['是', '否'];
                mui.confirm('邮件没有主题，是否继续发送？', '提示信息', btnArray, function(e) {
                    if (e.index == 0) {
                        var str8='';
                        str8+=checkVals.join(",")
                        mui.ajax('/email/sendEmail',{
                            data:{
                                toId2:str8,
                                copyToId:str1,
                                subject:document.getElementById("mtitle").value,
                                content:document.getElementById("msg_str").value,
                                // remark:document.getElementById("start").innerHTML,
                                attachmentId:attachmentId,
                                attachmentName: attachmentName

                            },
                            dataType:'json',//服务器返回json格式数据
                            type:'post',//HTTP请求类型
                            success:function(data){
                                if(data.flag){
                                    var btnArray = ['确认'];
                                    mui.confirm('发送成功', ' ', btnArray, function(e) {
                                        mui.back();
                                    })
                                }else{
                                    var btnArray = ['确认'];
                                    mui.confirm('发送失败！', ' ', btnArray, function(e) {
                                    })
                                }

                            }
//
                        });
                    } else {
                        var btnArray = ['确认'];
                        mui.confirm('您取消了发送！', ' ', btnArray, function(e) {
                        })
                    }
                });
            }else{
                var str7=''
                str7+=checkVals.join(",")
                mui.ajax('/email/sendEmail',{
                    data:{
                        toId2:str7,
                        copyToId:str1,
                        subject:document.getElementById("mtitle").value,
                        content:document.getElementById("msg_str").value,
//                        remark:document.getElementById("start").innerHTML,
                        attachmentId:attachmentId,
                        attachmentName: attachmentName
                    },
                    dataType:'json',//服务器返回json格式数据
                    type:'post',//HTTP请求类型
                    success:function(data){
                        if(data.flag){
                            var btnArray = ['确认'];
                            mui.confirm('发送成功', ' ', btnArray, function(e) {
//                                mui.back();
                                mui.openWindow({
                                    url: '/ewx/emailList',
                                    id:'list'
                                });
                            })
                        }else{
                            var btnArray = ['确认'];
                            mui.confirm('发送失败！', ' ', btnArray, function(e) {
                            })
                        }

                    }
//
                });
            }
        }

    });

</script>
</body>
</html>