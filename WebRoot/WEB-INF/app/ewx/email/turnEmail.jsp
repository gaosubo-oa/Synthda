<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@taglib prefix="mvc" uri="http://www.springframework.org/tags/form" %>
<%@taglib prefix="fmt" uri="http://www.springframework.org/tags" %>
<%
    String corpId = (String)request.getAttribute("corpId");
    String corpSecret = (String)request.getAttribute("corpSecret");
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
    <link rel="stylesheet" href="../../lib/mui/mui/mui.min.css" />
    <script type="text/javascript" src="../../lib/mui/mui/mui.min.js" ></script>
    <link rel="stylesheet" href="../../css/email/m/mail.css" />
    <link rel="stylesheet" href="../../css/email/m/add_mail.css" />


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
    <script src="/js/ajaxupload.js" type="text/javascript" charset="utf-8"></script>
    <script src="/js/jquery/jquery.form.min.js"></script>
    <title>回复邮件</title>
    <style>
        html,body{
            height: 100%;
            width:100%;
            overflow: auto;
        }
        .choose_type{
            height: 50px;
            line-height: 50px;
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
            padding-left: 0;
            font-family:'microsoft yahei';
            width: 90px;
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
        /*.mui-text-justify{*/
            /*height: calc(100% - 100px) !important;*/
        /*}*/
        textarea{
            /*height: 40% !important;*/
            height: 190px;
            border: 0;
            text-indent: 2em;
            padding: 10px;
        }
        #forms label,#forms1 label{
            width: 400px;
        }
        #modal header{overflow: hidden;}
        .checkbox1,.checkbox2{
            width: 70px;
            height: 70px;
        }
        #old_message{
            margin: 0 34px;
            padding-bottom:50px;
        }
        #header{
            position: fixed;
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
<body id="add" style="position: relative">
<%--<header class="mui-bar mui-bar-nav" id="header">--%>
    <%--<a class="mui-action-back mui-icon mui-icon-left-nav mui-pull-left"></a>--%>
    <%--<h1 class="mui-title">转发</h1>--%>
    <%--<a class="mui-btn mui-btn-blue mui-btn-link mui-pull-right" id="send">发送</a>--%>
<%--</header>--%>
<div class="mui-content" id="aaa">
    <div class="mui-table">
        <ul class="mui-table-view">
            <li class="mui-table-view-cell mui-input-row"><label class="mui-left">收件人：</label><input type="text" placeholder="选择收件人" value="" class="mui-input-clear" id="tname"/><input value="" type="hidden" id="reciever"/><span id="Popover_0" class='mui-icon mui-icon-plus'  ></span></li>
            <li class="mui-table-view-cell mui-input-row"><label class="mui-left">抄送人：</label><input type="text" placeholder="选择抄送人" value="" id="cname" class="mui-input-clear"/><input type="hidden" value="" id="copyreciever"/><span id="Popover_1" class='mui-icon mui-icon-plus'></span></li>
            <li class="mui-table-view-cell mui-input-row"><label class="mui-left">标题：</label><input disabled="disabled" type="text" placeholder="请输入主题" class="mui-input-clear" value="" id="mtitle"/></li>
            <li class="mui-table-view-cell mui-input-row"><label class="mui-left">附件：</label><a  class="mui-pull-right">
                <span class='mui-icon mui-icon-plus mui-pull-right' id="uploadimg">
                        <form id="uploadimgform" target="uploadiframe" action="../upload?module=email" enctype="multipart/form-data" method="post">
                            <input type="file" multiple="multiple" name="file" id="uploadinputimg" class="w-icon5" style="position: absolute;top:6px;opacity: 0;width: 70px;
                            filter: progid:DXImageTransform.Microsoft.Alpha(opacity=0)">
                            <a id="" style="cursor: pointer;"></a>
                        </form>
                    </span>
            </a></li>
        </ul>
        <div class="log_share" style="    margin-left: 18px;">
            <ul id="files" style="text-align:left;width: 85%;display: inline-block;">
                <div style="font-size:12px;color:#C6C6C6;" id="query_uploadArr" style="display:block;">
                </div>
            </ul>
        </div>
    </div>
    <div class="mui-text-justify">
        <textarea class="mui-text-left mui-bor" placeholder="输入正文" id="msg_str"></textarea>
        <div class="mui-text-center" id="start"></div>
        <div style="padding: 5px;width: 100%;text-align: center;color: #6D6D72; ">----------------原始邮件--------------</div>
        <div class="mui-text-left" id="old_message"></div>
    </div>
</div>

<div class="mui-content" style="display: none" id="ccc">
    <div class="mui-bar mui-bar-nav" id="header2" style="height: 100px;">
        <a class="mui-icon mui-icon-close mui-pull-left" href="#modal" id="app"></a>
        <h1 class="mui-title">选择人员</h1>
        <a class="mui-btn-link mui-pull-right" id="re_mail">确认</a>
        <div style="margin-top: 45px;">
            <span>姓名</span>
            <input type="text" name="username" style="width: 73%;height: 36px;border-radius: 10px" class="shoujian">
            <button type="button" class="mui-btn mui-btn-primary userNames1" style="vertical-align: text-bottom;border-radius: 10px">搜索</button>
        </div>
    </div>
    <div  style="height: 100%;margin-top: 100px;">
        <div id="forms">

        </div>
    </div>
</div>
<div class="mui-content"  style="display: none" id="bbb">
    <div class="mui-bar mui-bar-nav" id="header1" style="height: 100px;">
        <a class="mui-icon mui-icon-close mui-pull-left" href="#modal1" id="app1"></a>
        <h1 class="mui-title">选择人员</h1>
        <a class="mui-btn-link mui-pull-right" id="re_mail1">确认</a>
        <div style="margin-top: 45px;">
            <span>姓名</span>
            <input type="text" name="username" style="width: 73%;height: 36px;border-radius: 10px" class="chaosong">
            <button type="button" class="mui-btn mui-btn-primary userNames2" style="vertical-align: text-bottom;border-radius: 10px">搜索</button>
        </div>
    </div>
    <div  style="height: 100%;margin-top: 100px;">
        <div id="forms1">

        </div>
    </div>
</div>

<div class="" id="header">
    <a class="" id="send">发送</a>
</div>
<script type="text/javascript" src="../../js/diary/m/simbaJs.js" ></script>
<script type="text/javascript" src="../../js/diary/m/vue.min.js" ></script>
<script type="text/javascript">
    /**
     * @property{IDString} id id元素
     * @param {AttrString}
     * @param {AttrValueString}
     * @type {HTMLString}
     */
    var mid='',num='';
    var emailId = $.GetRequest().emailId;
    var checkVals;
    var checkVals1
    var attachmentId=''
    var attachmentName=''
    var u = navigator.userAgent;
    var app='<div><p>发件人：<span id="fnames"></span></p><p>收件人：<span id="toName"></span></p><p>抄送人：<span id="copyName"></span></p><p>发件时间：<span id="sendtime"></span></p><p>主题：<span id="subject"></span></p><p>附件：<span id="strs"></span></p><p>内容：</p><p id="objs"></p></div>'

    var isAndroid = u.indexOf('Android') > -1 || u.indexOf('Adr') > -1; //android终端
    var isiOS = !!u.match(/\(i[^;]+;( U;)? CPU.+Mac OS X/); //ios终端
    if(isAndroid == true){
        document.getElementById("start").innerHTML='---发自我的全流程Android版本---';
        document.getElementById("old_message").innerHTML=app;
    }else if(isiOS == true){
        document.getElementById("start").innerHTML='---发自我的全流程IOS版本---';
        document.getElementById("old_message").innerHTML=app;
    }
    var subject=localStorage.getItem("subject");
    document.getElementById("mtitle").setAttribute('value',subject);

    var userName=localStorage.getItem("userName");
    var toName=localStorage.getItem("toName");
    var copyName=localStorage.getItem("copyName");
    var sendtime=localStorage.getItem("sendtime");
    var bodyId=localStorage.getItem("bodyId");
    // var emailId=localStorage.getItem("emailId");
    var content=localStorage.getItem("content");
    var strs=localStorage.getItem("strs")||'';

    strs=strs.substring(1)
    strs=strs.substring(1,strs.length-4)

    $.ajax({
        url:'/email/queryByID',
        data:{emailId:emailId,flag:'copy'},
        type:'get',
        dataType:'json',
        success:function(res){
            var attStr='';
            for(var i=0;i<res.object.attachment.length;i++){
                attStr+=res.object.attachment[i].attachName+','
            }
            document.getElementById("mtitle").setAttribute('value',res.object.subject);
            document.getElementById("fnames").innerHTML=res.object.users.userName;
            document.getElementById("toName").innerHTML=res.object.toName;
            document.getElementById("copyName").innerHTML=res.object.copyName;
            document.getElementById("sendtime").innerHTML=res.object.probablyDate;
            document.getElementById("subject").innerHTML=res.object.subject;
            document.getElementById("strs").innerHTML=attStr
            document.getElementById("objs").innerHTML=res.object.content;
        }
    })
    // document.getElementById("mtitle").setAttribute('value',subject);
    // document.getElementById("fnames").innerHTML=userName;
    // document.getElementById("toName").innerHTML=toName;
    // document.getElementById("copyName").innerHTML=copyName;
    // document.getElementById("sendtime").innerHTML=sendtime;
    // document.getElementById("subject").innerHTML=subject;
    // document.getElementById("strs").innerHTML=strs;
    // document.getElementById("objs").innerHTML=content;


    //点击搜索的界面
    $('.userNames1').on('tap', function() {
        mui.ajax('/user/getAlluser', {
            dataType: 'json',//服务器返回json格式数据
            type: 'get',//HTTP请求类型
            data:{
                notLogin:0,
                userName:$('.shoujian').val()
            },
            success: function (data) {
                if(data.obj==undefined || data.obj== ""){
                    var app='<div class="mui-input-row mui-checkbox mui-left" style="margin-top: 110px;font-size: 25px;text-align: center;">暂无数据</div>'
                    $("#forms")[0].innerHTML = app;
                }else{
                    var str='';
                    var arr=data.obj
                    for(var i=0;i<arr.length;i++){
                        str+='<div class="mui-input-row  mui-radio mui-left">'+
                            '<label style="line-height: 34px">'+arr[i].userName+'</label>'+
                            '<input style="width: 70px;height: 70px;" class="checkbox1" name="checkbox1" value="'+arr[i].userName+'" type="radio" ids="'+arr[i].userId+'">'+
                            '</div>'
                    }
                    $("#forms")[0].innerHTML = str;
                }
            }
        });
        $('input[name="username"]').val('')
    })

    //点击搜索的界面
    $('.userNames2').on('tap', function() {
        mui.ajax('/user/getAlluser', {
            dataType: 'json',//服务器返回json格式数据
            type: 'get',//HTTP请求类型
            data:{
                notLogin:0,
                userName:$('.chaosong').val()
            },
            success: function (data) {
                if(data.obj==undefined || data.obj== ""){
                    var app='<div class="mui-input-row mui-checkbox mui-left" style="margin-top: 110px;font-size: 25px;text-align: center;">暂无数据</div>'
                    $("#forms1")[0].innerHTML = app;
                }else{
                    var str='';
                    var arr=data.obj
                    for(var i=0;i<arr.length;i++){
                        str+='<div class="mui-input-row  mui-radio mui-left">'+
                            '<label style="line-height: 34px">'+arr[i].userName+'</label>'+
                            '<input style="width: 70px;height: 70px;" class="checkbox1" name="checkbox1" value="'+arr[i].userName+'" type="radio" ids="'+arr[i].userId+'">'+
                            '</div>'
                    }
                    $("#forms1")[0].innerHTML = str;
                }
            }
        });
        $('input[name="username"]').val('')
    })


    //上传
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
        header.style.display= "block";
        bt111.style.display= "block";
        bt.style.display= "none";
    })
    //选择收件人，抄送人
    var btn0 = document.getElementById("Popover_0");
    btn0.addEventListener('tap', function() {
        var header = document.getElementById("header")
        var bt111 = document.getElementById("aaa");
        var bt = document.getElementById("ccc");
        header.style.display= "none";
        bt111.style.display= "none";
        bt.style.display= "block";
        mui.ajax('/user/getAlluser', {
            dataType: 'json',//服务器返回json格式数据
            type: 'get',//HTTP请求类型
            data:{
                notLogin:0
            },
            success: function (data) {
                //服务器返回响应，根据响应结果，分析是否登录成功；
                if (data.flag) {
                    var str='';
                    var arr=data.obj
                    for(var i=0;i<arr.length;i++){
                        str+='<div class="mui-input-row mui-checkbox mui-left">'+
                            '<label style="line-height: 34px">'+arr[i].userName+'</label>'+
                            '<input style="width: 70px;height: 70px;" class="checkbox1" name="checkbox1" value="'+arr[i].userName+'" type="checkbox" ids="'+arr[i].userId+'">'+
                            '</div>'
                    }

                }

                $("#forms")[0].innerHTML = str;
            },
            error: function (xhr, type, errorThrown) {
                //异常处理；
                //console.log(type);
            }
        });
        mui("#header2").on('tap', '#re_mail', function () {
            var rdsObj   = document.getElementsByClassName('checkbox1');
            var checkVal = new Array();
            var k        = 0;
            for(i = 0; i < rdsObj.length; i++){
                if(rdsObj[i].checked){
                    checkVal[k] = rdsObj[i].value;
                    k++;
                }
            }

            var rdsObj   = document.getElementsByClassName('checkbox1');
            checkVals = new Array();

            var k = 0;
            for(i = 0; i < rdsObj.length; i++){
                if(rdsObj[i].checked){
                    checkVals[k] = rdsObj[i].getAttribute('ids');
                    k++;
                }
            }
            var header = document.getElementById("header");
            header.style.display= "block";
            bt111.style.display= "block";
            bt.style.display= "none";
            document.getElementById("tname").setAttribute('value',checkVal);
            document.getElementById("tname").setAttribute('ids',checkVals);
        });
    });

    var btn1 = document.getElementById("Popover_1");
    btn1.addEventListener('tap', function() {
        var header = document.getElementById("header");
        var bt111 = document.getElementById("aaa");
        var bt = document.getElementById("bbb");
        header.style.display= "none";
        bt111.style.display= "none";
        bt.style.display= "block";
        mui.ajax('/user/getAlluser', {
            dataType: 'json',//服务器返回json格式数据
            type: 'get',//HTTP请求类型
            data:{
                notLogin:0
            },
            success: function (data) {
                //服务器返回响应，根据响应结果，分析是否登录成功；
                if (data.flag) {
                    var str='';
                    var arr=data.obj
                    for(var i=0;i<arr.length;i++){
                        str+='<div class="mui-input-row mui-checkbox mui-left">'+
                            '<label style="line-height: 34px">'+arr[i].userName+'</label>'+
                            '<input style="width: 70px;height: 70px;" class="checkbox2" name="checkbox2" value="'+arr[i].userName+'" type="checkbox" ids="'+arr[i].userId+'">'+
                            '</div>'
                    }

                }

                $("#forms1")[0].innerHTML = str;
            },
            error: function (xhr, type, errorThrown) {
                //异常处理；
                //console.log(type);
            }
        });
        mui("#header1").on('tap', '#re_mail1', function () {

            var rdsObj   = document.getElementsByClassName('checkbox2');
            var checkVal = new Array();
            var k        = 0;
            for(i = 0; i < rdsObj.length; i++){
                if(rdsObj[i].checked){
                    checkVal[k] = rdsObj[i].value;
                    k++;
                }
            }
            var rdsObj   = document.getElementsByClassName('checkbox2');
            checkVals1 = new Array();
            var k = 0;
            for(i = 0; i < rdsObj.length; i++){
                if(rdsObj[i].checked){
                    checkVals1[k] = rdsObj[i].getAttribute('ids');
                    k++;
                }
            }
            bt111.style.display= "block";
            bt.style.display= "none";
            header.style.display= "block";
            document.getElementById("cname").setAttribute('value',checkVal);
            document.getElementById("cname").setAttribute('ids',checkVals1);
        });
    });

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
                        send_mail(document.getElementById("reciever").value,document.getElementById("copyreciever").value);
                    } else {
                        var btnArray = ['确认'];
                        mui.confirm('您取消了发送！', ' ', btnArray, function(e) {
                        })
                    }
                });
            }else{
                var str=''
                str+=checkVals.join(",")
                var val=document.getElementById("msg_str").value+document.getElementById("old_message").innerHTML
//                cosole.log(val)
                mui.ajax('/email/sendMessageEmail',{
                    data:{
                        emailId:emailId,
                        toId2:str,
                        copyToId:str1,
                        subject:document.getElementById("mtitle").value,
//                        content:document.getElementById("msg_str").value,
                        content:val,
                        remark:document.getElementById("start").innerHTML,
                        attachmentId:attachmentId,
                        attachmentName:attachmentName
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