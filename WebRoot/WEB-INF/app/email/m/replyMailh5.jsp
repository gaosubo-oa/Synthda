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
<%--    <script src="/js/xoajq/xoajq1.js" type="text/javascript" charset="utf-8"></script>--%>
    <script type="text/javascript" charset="utf-8" src="/js/xoajq/xoajq3.js"></script>
<%--    <script type="text/javascript" charset="utf-8" src="/js/jquery/jquery-migrate-3.4.0.js"></script>--%>
    <script src="/lib/jQuery-File-Upload-master/jquery-ui.js" type="text/javascript" charset="utf-8"></script>
    <script src="/lib/jQuery-File-Upload-master/jquery.iframe-transport.js" type="text/javascript" charset="utf-8"></script>
    <script src="/lib/jQuery-File-Upload-master/jquery.fileupload.js" type="text/javascript" charset="utf-8"></script>
    <script src="../js/news/page.js"></script>
    <script src="../lib/laydate/laydate.js"></script>
    <script src="../js/base/base.js" type="text/javascript" charset="utf-8"></script>
    <script src="../lib/pagination/js/jquery.pagination.min.js" type="text/javascript" charset="utf-8"></script>
    <link rel="stylesheet" type="text/css" href="../css/news/new_news.css"/>
    <script src="../../lib/laydate/laydate.js"></script>
    <script src="../../lib/layer/layer.js?20201106"></script>
    <script src="../js/jquery/jquery.cookie.js"></script>
    <script src="/js/ajaxupload.js" type="text/javascript" charset="utf-8"></script>
    <script src="/js/jquery/jquery.form.min.js"></script>
    <title><fmt:message code="email.th.replyToTheEmail" /></title>
    <style>
        html,body{
            height: 100%;
            width:100%;
            /*overflow: auto;*/
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
        .mui-text-justify{
            height: calc(100% - 100px) !important;
        }
        textarea{
            height: 40% !important;
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
        }
    </style>
</head>
<body id="add">
<header class="mui-bar mui-bar-nav" id="header">
    <a class="mui-action-back mui-icon mui-icon-left-nav mui-pull-left"></a>
    <h1 class="mui-title"><fmt:message code="global.lang.reply" /></h1>
    <a class="mui-btn mui-btn-blue mui-btn-link mui-pull-right" id="send"><fmt:message code="workflow.th.SendOut" /></a>
</header>
<div class="mui-content" id="aaa">
    <div class="mui-table">
        <ul class="mui-table-view">
            <li class="mui-table-view-cell mui-input-row"><label class="mui-left"><fmt:message code="email.th.recipients" />：</label><input type="text" disabled="disabled" placeholder="<fmt:message code="email.th.selectTheRecipient" />"  readonly="readonly" value="" class="mui-input-clear" id="tname"/><input value="" type="hidden" id="reciever"/><span id="Popover_0" class='mui-icon mui-icon-plus'></span></li>
            <li class="mui-table-view-cell mui-input-row"><label class="mui-left"><fmt:message code="email.th.carbonCopyRecipients" />：</label><input type="text" placeholder="<fmt:message code="email.th.selectTheCCRecipients" />" value="" id="cname" class="mui-input-clear"/><input type="hidden" value="" id="copyreciever"/><span id="Popover_1" class='mui-icon mui-icon-plus'></span></li>
            <li class="mui-table-view-cell mui-input-row"><label class="mui-left"><fmt:message code="notice.th.title" />：</label><input type="text" disabled="disabled" placeholder="<fmt:message code="mailMonitoring.enterSubject" />" class="mui-input-clear" value="" id="mtitle"/></li>
            <li class="mui-table-view-cell mui-input-row"><label class="mui-left"><fmt:message code="email.th.file" />：</label><a class="mui-pull-right">
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
                <%--<p id="empty" style="font-size:12px;color:#C6C6C6;">无上传文件</p>--%>
                <div style="font-size:12px;color:#C6C6C6;" id="query_uploadArr" style="display:block;">
                </div>
            </ul>
        </div>
    </div>
    <div class="mui-text-justify">
        <textarea class="mui-text-left mui-bor" placeholder="<fmt:message code="email.th.enterTheMainText" />" id="msg_str"></textarea>
        <div class="mui-text-center" id="start"></div>
        <div style="padding: 5px;width: 100%;text-align: center;color: #6D6D72; ">----------------<fmt:message code="email.th.originalEmail" />--------------</div>
        <div class="mui-text-left" id="old_message"></div>
    </div>
</div>

<div class="mui-content" style="display: none" id="ccc">
    <div class="mui-bar mui-bar-nav" id="header1">
        <a class="mui-icon mui-icon-close mui-pull-left" href="#modal" id="app"></a>
        <h1 class="mui-title"><fmt:message code="common.th.selPeople" /></h1>
        <a class="mui-btn-link mui-pull-right" id="re_mail1"><fmt:message code="main.th.confirm" /></a>
    </div>
    <div  style="height: 100%;">
        <div id="forms1">

        </div>
    </div>
</div>
<%--<script type="text/javascript" src="../../js/notes/jquery-2.1.2.min.js"></script>--%>
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
    var checkVals1
    var attachmentId
    var attachmentName
    var u = navigator.userAgent;
    var app='<div><p><fmt:message code="email.th.sender" />：<span id="fnames"></span></p><p><fmt:message code="email.th.recipients" />：<span id="toName"></span></p><p><fmt:message code="email.th.carbonCopyRecipients" />：<span id="copyName"></span></p><p><fmt:message code="email.th.sendingTime" />：<span id="sendtime"></span></p><p><fmt:message code="email.th.file" />：<span id="strs"></span></p><p><fmt:message code="email.th.main" />：<span id="subject"></span></p><p><fmt:message code="notice.th.content" />：</p><p id="objs"></p></div>'
    var isAndroid = u.indexOf('Android') > -1 || u.indexOf('Adr') > -1; //android终端
    var isiOS = !!u.match(/\(i[^;]+;( U;)? CPU.+Mac OS X/); //ios终端
    if(isAndroid == true){
        document.getElementById("start").innerHTML='---<fmt:message code="email.th.sentFromMyFullProcessAndroidVersion" />---';
        document.getElementById("old_message").innerHTML=app;

    }else if(isiOS == true){
        document.getElementById("start").innerHTML='---<fmt:message code="email.th.sentFromMyFullProcessIOSVersion" />---';
        document.getElementById("old_message").innerHTML=app;
    }

    var userName=localStorage.getItem("userName");
    var toName=localStorage.getItem("toName");
    var copyName=localStorage.getItem("copyName");
    var sendtime=localStorage.getItem("sendtime");
    var subject=localStorage.getItem("subject");
    var bodyId=localStorage.getItem("bodyId");
    var emailId=localStorage.getItem("emailId");
    var content=localStorage.getItem("content");
    var strs=localStorage.getItem("strs");
    strs=strs.substring(1)
    strs=strs.substring(1,strs.length-4)

    document.getElementById("tname").setAttribute('value',userName);
    document.getElementById("mtitle").setAttribute('value',subject);
    document.getElementById("fnames").innerHTML=userName;
    document.getElementById("toName").innerHTML=toName;
    document.getElementById("copyName").innerHTML=copyName;
    document.getElementById("sendtime").innerHTML=sendtime;
    document.getElementById("subject").innerHTML=subject;
    document.getElementById("strs").innerHTML=strs;

    document.getElementById("objs").innerHTML=content;
    //选择收件人，抄送人
    var btn1 = document.getElementById("Popover_1");

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
                        layer.alert('<fmt:message code="dem.th.uploading" />!',{},function(){
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
                layer.alert('<fmt:message code="dem.th.AddEmpty" />!',{},function(){
                    layer.closeAll();
                });
            }
        }
    });
    $('#app').on('click',function(){
        var bt111 = document.getElementById("aaa");
        var bt = document.getElementById("ccc");
        bt111.style.display= "block";
        bt.style.display= "none";
        var header = document.getElementById("header");
        header.style.display= "block";
    })
    btn1.addEventListener('tap', function() {
        var bt111 = document.getElementById("aaa");
        var header = document.getElementById("header");
        var bt = document.getElementById("ccc");
        header.style.display= "none";
        bt111.style.display= "none";
        bt.style.display= "block";
        mui.ajax('/user/getAlluser', {
            dataType: 'json',//服务器返回json格式数据
            type: 'get',//HTTP请求类型
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
            var header = document.getElementById("header");
            header.style.display= "block";
            bt111.style.display= "block";
            bt.style.display= "none";
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
            var btnArray = ['<fmt:message code="main.th.confirm" />'];
            mui.confirm('<fmt:message code="email.th.pleaseSelectAtLeastOneRecipient" />！', ' ', btnArray, function(e) {
            })
        }else{
            if(document.getElementById("mtitle").value==""){
                var btnArray = ['<fmt:message code="global.lang.yes" />', '<fmt:message code="global.lang.no" />'];
                mui.confirm('<fmt:message code="email.th.noSubjectSendRemind" />', '<fmt:message code="user.th.lkjnlk" />', btnArray, function(e) {
                    if (e.index == 0) {
                        send_mail(document.getElementById("reciever").value,document.getElementById("copyreciever").value);
                    } else {
                        var btnArray = ['<fmt:message code="main.th.confirm" />'];
                        mui.confirm('<fmt:message code="email.th.youHaveCancelledTheSending" />！', ' ', btnArray, function(e) {
                        })
                    }
                });
            }else{
                var val=document.getElementById("msg_str").value+app
                mui.ajax('/email/sendMessageEmail',{
                    data:{
                        toId2:bodyId,
                        copyToId:str1,
                        emailId:emailId,
                        subject:subject,
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
                            var btnArray = ['<fmt:message code="main.th.confirm" />'];
                            mui.confirm('<fmt:message code="global.lang.send" />', ' ', btnArray, function(e) {
                                mui.back();
                            })
                        }else{
                            var btnArray = ['<fmt:message code="main.th.confirm" />'];
                            mui.confirm('<fmt:message code="global.lang.err" />！', ' ', btnArray, function(e) {
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