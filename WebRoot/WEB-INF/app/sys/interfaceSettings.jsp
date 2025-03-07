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
<head>
    <meta charset="UTF-8">
    <title><fmt:message code="main.interfaceset" /></title>
    <meta name="renderer" content="webkit">
    <meta http-equiv="X-UA-Compatible" content="IE=10,chrome=1">

    <meta name="viewport" content="width=device-width, initial-scale=0.3, user-scalable=0, minimum-scale=0, maximum-scale=5.0,user-scalable=yes">
    <!--<link rel="stylesheet" type="text/css" href="../css/sys/addUser.css"/>-->
    <link rel="stylesheet" type="text/css" href="../css/base.css"/>
    <link rel="stylesheet" href="/lib/layer/skin/default/layer.css">
    <script src="/js/xoajq/xoajq1.js" type="text/javascript" charset="utf-8"></script>
    <script src="/lib/jQuery-File-Upload-master/jquery-ui.js" type="text/javascript" charset="utf-8"></script>
    <script src="/lib/jQuery-File-Upload-master/jquery.iframe-transport.js" type="text/javascript" charset="utf-8"></script>
    <script src="/lib/jQuery-File-Upload-master/jquery.fileupload.js" type="text/javascript" charset="utf-8"></script>
    <script src="../js/jquery/jquery.cookie.js"></script>
    <script src="/lib/layer/layer.js?20201106"></script>
    <script src="../js/base/base.js" type="text/javascript" charset="utf-8"></script>
    <script src="../js/ajaxupload.js" type="text/javascript" charset="utf-8"></script>
    <style type="text/css">

        .fs{
            font-size: 13pt;
        }
        table tr td {
            border: 1px solid rgb(192, 192, 192) !important;
        }
        #TableHeader { border: 1px solid rgb(192, 192, 192);}
        #TableHeader { border: 1px solid rgb(192, 192, 192);}
        .header {
            height: 45px;
            border-bottom: #999 1px solid;
            overflow: hidden;
            margin-bottom: 10px;
            padding-left: 30px;
            position: fixed;
            top: 0px;
            width: 100%;
            background-color: #fff;
            z-index:1099;
        }
        .tab{
            top:68px;
            z-index: 0;
            margin-top: 77px;
        }
        .headertitle{
            margin-top: 12px;
            font-family: Microsoft yahei,Helvetica Neue,Helvetica,PingFang SC,Tahoma,Arial,sans-serif;
            font-size: 22px;
            color: #494d59;
            display: inline-block;
            margin-left:12px;
            /*width: 90px;*/
            float:left;
        }
        table {
            width: 600px;
        }
        button{
            cursor: pointer;
        }
        .charstyle {
            color: #2F5C8F;
        }
        .big1 {
            color: #2F5C8F;
        }
        .savebutton{
            background-image:url(../../img/confirm.png);
            cursor:pointer;
            background-repeat:no-repeat;
            background-position:center;
            height: 28px;
        }
        .savebutton span{
            margin-left: 17px;
            line-height: 27px;
        }
        .empty{
            float: right;
            filter:alpha(opacity=0); /*IE滤镜，透明度50%*/
            -moz-opacity:0; /*Firefox私有，透明度50%*/
            opacity:1;/*其他，透明度50%*/
            width: 900px;
            z-index: 9999;
            background: white;
            height:45px;
        }
        td{
            font-size: 11pt;
        }
        input[type="checkbox"],input[type="radio"]{
            background: transparent;
            border: 0;
        }
        #text,#size,#color,#light,#hidcolor{
            background: #fff;
            line-height: 20px;
            border-radius: 3px;
            cursor:pointer;
            margin:0px 10px;
        }
        .attach_div a {
            display: block !important;
            padding: 0px 10px;
            height: 25px;
            line-height: 25px;
            text-decoration: none;
            color: #393939;
        }
        .attach_div a:hover {
            background: #83C1DE;
            color: #FFF;
            text-decoration: none;
        }
        .ColorTable {
            margin: 0px;
            background: #F5FBFF;
            border: #BBBBBB 1px solid;
            width: 160px;
        }
        .ColorTable td {
            font-size: 12px;
            font-weight: bold;
            border-right: 1px #F5FBFF solid;
            border-bottom: 1px #F5FBFF solid;
            padding: 2px;
        }
        .ColorTable td div {
            cursor: pointer;
            border: #BBBBBB 1px solid;
        }
    </style>
    <link rel="stylesheet" type="text/css" href="/css/commonTheme/${sessionScope.InterfaceModel}/commonTheme.css"/>
</head>
<body class="bodycolor">
<div class="header"><img src="/img/commonTheme/${sessionScope.InterfaceModel}/faceSetting.png" style="margin-top: 7px;float: left;"><div class="headertitle"> <fmt:message code="main.interfaceset" /></div><div class="empty"></div></div>
<div class="tab">

</div>
<script type="text/javascript">
    function saveData(){
        $.ajax({
            url:'/sys/selectMySql',
            dataType:'json',
            type:'get',
            success:function(res){
                if(res.code==0){
                    $('#model_sytle').parent().parent().hide();
                }else if(res.code==1){
                    $('#model_sytle').parent().parent().show();
                }
            }
        });
        var avatarUpload=$("#upload_head").is(':checked')?'1':'0';
        var themeSelect=$("#theme_select").is(':checked')?'1':'0';
        if($('#setText').val()==""){
            var bannerFont = ''
        }else{
            var bannerFont="";
            if($('#hidtext').val()!=""){
                bannerFont += 'font-family:'+$('#hidtext').val()+';'
            }
            if($('#hidsize').val()!=""){
                bannerFont += 'font-size:'+$('#hidsize').val()+';'
            }
            if($('#hidcolor').val()!=""){
                bannerFont += 'color:'+$('#hidcolor').val()+';'
            }
            if($('#hidlight').val()!=""){
                bannerFont += $('#hidlight').val()+';'
            }
        }
        var datas={

            //档案备案号
            MIIBEIAN:$("#document_num").val(),
            //浏览器标题设置
            ieTitle:$("#ie_title").val(),
            //登录界面模板
            template:$("#model_sytle option:selected").attr("value"),
            bannertText:$("#BigInput_topwz").val(),
            //底部状态栏置中文字
            statusText:$("#status_text").val(),
            //顶部大标题文字
            bannerText:$('#setText').val(),
            bannerFont:bannerFont,

            //imgWidth:$("#img_width").val(),
            //imgHeight:$("#img_height").val(),
            //是否允许选择界面主题
            themeSelect:themeSelect,
            //界面设置默认主题
            theme:$("#theme").val(),
            //允许用户上传图像
            avatarUpload:avatarUpload,
            //上传头像最宽
            avatarWidth:$("#width_max").val(),
            //上传头像最高
            avatarHeight:$("#height_max").val(),
            //注销提示文字
            LOG_OUT_TEXT:$("#log_out_text").val(),
            //attachMentId:$
            //$("#MYTABLE_BKGROUND").val
            //即时通信
            IM_WINDOW_CAPTION:$("#wi_title").val(),
            loginLiterals:$('[name="loginLiterals"]').val(),
            attachmentId2:$('[name="attachmentId2"]').val(),
            attachmentName2:$('[name="attachmentName2"]').val(),
            attachmentId:$('[name="attachmentId"]').val(),
            attachmentName:$('[name="attachmentName"]').val(),
            attachmentId3:$('[name="attachmentId3"]').val(),
            attachmentName3:$('[name="attachmentName3"]').val(),
            attachmentId4:$('[name="attachmentId4"]').val(),
            attachmentName4:$('[name="attachmentName4"]').val(),
             weatherCity:$('[name="weatherCity"]:checked').val(),
            loginInterface:$('[name="loginInterface"]:checked').val(),
            mobileWatermark:$('[name="mobileWatermark"]:checked').val(),
            blackTheme:$('[name="blackTheme"]:checked').val(),
            workFlowWaterMark: $('[name="workFlowWaterMark"]:checked').val(),
        };
        $.ajax({
            url:"../../sys/updateInterfaceInfo",
            type:"post",
            datatType:"json",
            data:datas,
            success:function(data){
                $.layerMsg({content:"<fmt:message code="interfaceSetting.th.interface" />", icon: 1},function () {
                        parent.window.location.reload();
                })

            }
        })
    }
    function buildThemeSelect(){
        $.ajax({
            url:"../../code/GetDropDownBox",
            type:"get",
            datatType:"json",
            data:{
                CodeNos:'loginTmpl'
            },
            success:function(data){
                if(data && data.loginTmpl){
                    var optionStr = '';
                    data.loginTmpl.forEach(function(v,i){
                        optionStr += '<option value="'+v.codeNo+'">'+v.codeName+'</option> ';
                    })
                   // $('#theme').html(optionStr);
                }

            }
        })
    }
    //    设置字体
    function set_font_family(font){
        if(font!=""&&font!=null){
            $('#text').val(font)
            $('#text').css('fontFamily',font)
            $('#hidtext').val(font)
        }else{
            $('#text').val('字体')
            $('#hidtext').val('')
            $('#text').css('fontFamily','')
        }
        $('#font_family_link_menu').hide();
    }
    //    设置大小
    function set_font_size(size,val){
        if(size!=""){
            $('#size').val(val)
            $('#hidsize').val(size)
        }else{
            $('#size').val('大小')
            $('#hidsize').val('')
        }
        $('#font_size_link_menu').hide();
    }
    //    设置颜色
    function set_font_color(color){
        if(color!=""){
            $('#color').css('color',color)
            $('#hidcolor').val(color)
        }else{
            $('#color').css('color','#000000');
            $('#hidcolor').val('')
        }
        $('#font_color_link_menu').hide();
    }
    function set_font_filter(filter, text)
    {
        var color = "";
        if(filter == "1")
        {
            color = window.prompt("请输入投影的颜色", "#000000");
            filter = "text-shadow: 3px 3px 5px "+color+";";
            $('#light').val(text);
            $('#hidlight').val(filter)
        }
        else if(filter == "2")
        {
            color = window.prompt("请输入发光的颜色", "#000000");
            filter = "text-shadow: 0px 0px 10px "+color+";";
            $('#light').val(text);
            $('#hidlight').val(filter)
        }
        if(color == "" ){
            $('#light').val('效果');
            $('#hidlight').val('')
        }

        $('#font_filter_link_menu').hide();


    }



    $(function () {
        //判断是不是信创项目，是的话显示信创登录默认选项，否则隐藏
        var option_style = "display:none";
        $.ajax({
            url:"/syspara/selectTheSysPara?paraName=MYPROJECT",
            success:function(res) {
                if(res.flag && res.object.length >= 1) {
                    var dataInfo = res.object[0];
                    if(dataInfo.paraValue == 'HBchinaminesafety') {
                        option_style = "display:block";
                    }
                }

            }
        })

    $.ajax({
        url:"../../sys/getInterfaceInfo",
        type:"post",
        datatType:"json",
        //data:datas,
        success:function(data){
            var fileNumber=data.object.fileNumber;
            var ieTitle=data.object.ieTitle;
            var status_text=data.object.statusText;
            var log_text=data.object.logOutText;
            var title =data.object.title;
            var widthpic=data.object.avatarWidth;
            var heightpic=data.object.avatarHeight;
            var mobileWatermark=data.object.mobileWatermark;
            var workFlowWaterMark=data.object.workFlowWaterMark||'';
            var blackTheme=data.object.blackTheme;
            var datatwo=data.object;
            var arrFont = data.object.bannerFont;
            var weather = data.object.weatherCity;
            var loginInterface = data.object.loginInterface;
            var font ="";
            var size=""
            var color='#000000'
            var light="";
            var font2='<fmt:message code="interfaceSetting.th.font" />'
            var size2='<fmt:message code="interfaceSetting.th.size" />'
            var light2= '<fmt:message code="interfaceSetting.th.effect" />'
            if(arrFont!=''&&arrFont!=undefined){
                arrFont = arrFont.split(';')

                for(var i=0;i<arrFont.length;i++){
                    if(arrFont[i].indexOf('font-family')>=0){
                         font = arrFont[i].split(':')[1];
                         font2 = arrFont[i].split(':')[1];
                    }

                    if(arrFont[i].indexOf('font-size')>=0){
                         size = arrFont[i].split(':')[1];
                        switch (size){
                            case '48pt':
                                size2 = '48pt';
                                break;
                            case '9pt':
                                size2 = '小五';
                                break;
                            case '10.5pt':
                                size2 = '五号';
                                break;
                            case '12pt':
                                size2 = '小四';
                                break;
                            case '14pt':
                                size2 = '四号';
                                break;
                            case '15pt':
                                size2 = '小三';
                                break;
                            case '16pt':
                                size2 = '三号';
                                break;
                            case '18pt':
                                size2 = '小二';
                                break;
                            case '22pt':
                                size2 = '二号';
                                break;
                            case '24pt':
                                size2 = '小一';
                                break;
                            case '26pt':
                                size2 = '一号';
                                break;
                            case '28pt':
                                size2 = '28pt';
                                break;
                            case '30pt':
                                size2 = '30pt';
                                break;
                            case '32pt':
                                size2 = '32pt';
                                break;
                            case '34pt':
                                size2 = '34pt';
                                break;
                            case '36pt':
                                size2 = '36pt';
                                break;
                            case '38pt':
                                size2 = '38pt';
                                break;
                            case '40pt':
                                size2 = '40pt';
                                break;

                        }
                    }

                    if(arrFont[i].indexOf('color:')>=0){
                         color = arrFont[i].split(':')[1];
                    }

                    if(arrFont[i].indexOf('text-shadow: 0px')>=0){
                         light = arrFont[i];
                        light2 = '发光'
                    }else if(arrFont[i].indexOf('text-shadow: 3px')>=0){
                         light = arrFont[i];
                         light2 = '投影'
                    }
                }
            }
            var str= '<table class="TableBlock" align="center" style="border-collapse: collapse;width:740px">' +
                '<tbody>' +
                '<tr>' +
                '<td class="TableHeader fs" colspan="2">' +
                '<img src="/img/commonTheme/theme1/icon_login.png" alt="" style="margin-right: 6px;"><b class="charstyle"><fmt:message code="interfaceSetting.th.interfaceWatermarkSettings" /></b>' +
                '</td>' +
                '</tr>' +
                '<tr>' +
                '<td><fmt:message code="interfaceSetting.th.processCenterInterfaceWatermark" />：</td>                    ' +
                '<td>' +
                '<input type="radio" name="workFlowWaterMark" value="1" '+function(){if(workFlowWaterMark == ''||workFlowWaterMark == 1){return "checked=checked"}else{return ""}}()+'> <label for="THEME_SELECT"><fmt:message code="interfaceSetting.th.Open" /></label>' +
                        '<input type="radio" style="margin-left:20px" name="workFlowWaterMark" value="0" '+function(){if(workFlowWaterMark == ''||workFlowWaterMark == 0){return "checked=checked"}else{return ""}}()+'><label for="THEME_SELECT"><fmt:message code="interfaceSetting.th.close" /></label>' +
                    '</td>' +
                '</tr>'
                +function () {
                        return '<tr>\
                    <td class="TableHeader fs" colspan="2">\
                    <img src="/img/commonTheme/theme1/icon_login.png" alt="" style="margin-right: 6px;"><b class="charstyle"><fmt:message code="interfaceSetting.th.LoginInterface" /></b>\
                    </td></tr>\
                    <tr>\
                    <td class="TableData" id="sign_in"><fmt:message code="interfaceSetting.th.LoginInterfaceTemplate" /></td><td>\
                    <select name="" id="model_sytle">\
                    <option value="16"><fmt:message code="home.page.option.16" /></option>\
                            <option value="22"><fmt:message code="home.page.option.22" /></option>\
                    <option value="23"><fmt:message code="home.page.option.23" /></option>\
                    <option value="24"><fmt:message code="home.page.option.24" /></option>\
                    <option value="89" style="${option_style}"><fmt:message code="home.page.option.89" /></option>\
                    <option value="17"><fmt:message code="home.page.option.17" /></option>\
                    <option value="18"><fmt:message code="home.page.option.18" /></option>\
                    <option value="19"><fmt:message code="home.page.option.19" /></option>\
                    <option value="1"><fmt:message code="home.page.option.1" /></option>\
                    <option value="2"><fmt:message code="home.page.option.2" /></option>\
                    <option value="15"><fmt:message code="home.page.option.15" /></option>\
                    <option value="3"><fmt:message code="home.page.option.3" /></option>\
                    <option value="4"><fmt:message code="home.page.option.4" /></option>\
                    <option value="5"><fmt:message code="home.page.option.5" /></option>\
                    <option value="6"><fmt:message code="home.page.option.6" /></option>\
                    <option value="7"><fmt:message code="home.page.option.7" /></option>\
                    <option value="8"><fmt:message code="home.page.option.8" /></option>\
                    <option value="9"><fmt:message code="home.page.option.9" /></option>\
                    <option value="10"><fmt:message code="home.page.option.10" /></option>\
                    <option value="11"><fmt:message code="home.page.option.11" /></option>\
                    <option value="12"><fmt:message code="home.page.option.12" /></option>\
                    <option value="13"><fmt:message code="home.page.option.13" /></option>\
                    <option value="14"><fmt:message code="home.page.option.14" /></option>\
                    <option value="20"><fmt:message code="home.page.option.20" /></option>\
                    </select>\
                    <a href="javascript:void(0)" class="yulanModel" style="text-decoration: none;margin-left: 30px;"><fmt:message code="interfaceSetting.th.preview" /></a>\
                    </td>\
                    </tr>\
                    <tr>\
                    <td><fmt:message code="interfaceSetting.th.Logo" /></td>\
                    <td style="position:relative">\
                    <img style="left: 0;width:400px" class="img">\
                    <input type="file" name="file" id="uploadinputimg"  style="position:absolute;z-index:10;background: red;\
            width: 50px;\
            left: 20px;opacity:0;\
            top: 5px;filter:progid:DXImageTransform.Microsoft.Alpha(opacity=0)"/>\
                    <a href="javascript:void(0)" class="chuan" style="position: absolute;\
                        z-index: 1;\
                        top: 9px;\
                        color: #fff;\
                        text-decoration: none;\
                        left: 20px;\
                        padding: 2px 10px;\
                        border-radius: 4px;\
                        background: cornflowerblue;"><fmt:message code="global.th.upload" /></a>\
                    <a href="javascript:void(0)" style="position: absolute;\
                        z-index: 1;\
                        bottom: 36px;\
                        text-decoration: none;\
                        left: 0px;\
                        padding: 2px 10px;\
                        border-radius: 4px;display:none;"  class="yulan" typelook="1"><fmt:message code="global.lang.view" /></a>\
                     <a href="javascript:void(0)" style="position: absolute;\
                        z-index: 1;\
                        bottom: 36px;\
                        text-decoration: none;\
                        left: 60px;\
                        color:red;\
                        padding: 2px 10px;\
                        border-radius: 4px;display:none;" class="del delIndex">删除</a>\
                    <input type="hidden" name="attachmentId2">\
                    <input type="hidden" name="attachmentName2">\
                    <span style="width: 100%;float: left;margin-top: 40px;" class ="widths"><fmt:message code="interfaceSetting.th.loginPageLogoUpload" /></span>\
                    </td>\
                     </tr>\
                     <tr id="appUpLogo">\
                     <td><fmt:message code="global.lang.mobile" /></td>\
                     <td style="position:relative">\
                     <img style="left: 0;width:400px" class="img">\
                     <input type="file" name="file" id="uploadinputimgIphone"  style="position:absolute;z-index:10;background: red;\
                     width: 50px; left: 20px;opacity:0;top: 5px;filter:progid:DXImageTransform.Microsoft.Alpha(opacity=0)"/>\
                     <a href="javascript:void(0)" class="chuan" style="position: absolute;\
                      z-index: 1;\
                      top: 9px;\
                      color: #fff;\
                      text-decoration: none;\
                      left: 24px;\
                      padding: 2px 10px;\
                      border-radius: 4px;\
                     background: cornflowerblue;"><fmt:message code="global.th.upload" /></a>\
                     <a href="javascript:void(0)" style="position: absolute;\
                     z-index: 1; \
                     text-decoration: none; \
                     bottom: 34px;\
                     left: 0px;\
                     padding: 2px 10px;\
                     border-radius: 4px;display:none;" class="yulan" typelook="2"><fmt:message code="global.lang.view" /></a>\
                     <a href="javascript:void(0)" style="position: absolute;\
                        z-index: 1;\
                        text-decoration: none;\
                        left: 60px;\
                        bottom: 34px;\
                        color:red;\
                        padding: 2px 10px;\
                        border-radius: 4px;display:none;" class="del delIndex">删除</a>\
                    <input type="hidden" name="attachmentId3"> <input type="hidden" name="attachmentName3">\
                    <span style="width: 100%;float: left;margin-top:40px" class="andimg" >手机启动页界面上传LOGO图片，建议尺寸为宽568，高482。</span>\
                    </td>\
                    </tr> \
                     <tr>\
                    <td><fmt:message code="global.th.seting" /></td>\
                    <td><input type="text" style="width:280px;" name="loginLiterals"/></td>\
                    </tr>\
                    <tr>\
                    <td><fmt:message code="interfaceSetting.th.websiteIcpRegistrationNumber" />：</td>\
                    <td><input class=""style="width:280px;" id="document_num" value="'+fileNumber+'"></td>' +
                        '</tr>'+
                           '<tr>\
                    <td><fmt:message code="interfaceSetting.th.loginPageMode" />：</td>\
                    <td>\
                     <input type="radio" name="blackTheme"  value="1" id="" '+function(){if(blackTheme == 1){return "checked=checked"}else{return ""}}()+' >' +
                            '                        <label for="THEME_SELECT"><fmt:message code="interfaceSetting.th.Open" /></label>' +
                            '                        <input type="radio" style="margin-left:20px" name="blackTheme"  value="0" '+function(){if(blackTheme == 0){return "checked=checked"}else{return ""}}()+'>' +
                            '                        <label for="THEME_SELECT"><fmt:message code="interfaceSetting.th.close" /></label>' +
                   '</td>'+
                '</tr>'
                }()+''+
                '<tr>' +
                '<td colspan="2" class="TableHeader fs">' +
                '<img src="/img/commonTheme/theme1/icon_webtitle.png" alt="" style="margin-right: 6px;margin-top: -5px;"><b class="charstyle"><fmt:message code="interfaceSetting.th.mainScreenWindowBrowserTitle" /><span id="appIndexTitle">/APP主界面标题</span></b>\
                </td>\
                </tr>\
                <tr>\
                <td nowrap="" class="TableData" id="" style="width: 189px;"><fmt:message code="interfaceSetting.th.mainScreenWindowBrowserTitle" /><br/><span class="appTitle">/APP主界面标题：</span></td>\
            <td nowrap="" class="TableData" id="win_title">\
            <input type="text" name="IE_TITLE" \
            class="BigInput" size="40" maxlength="100" style="width:280px" \
            value="'+ieTitle+'" id="ie_title">&nbsp;</td></tr><tr id="appIndex">\n' +
                '                <td nowrap="" class="TableData" id="" style="width: 189px;">APP界面显示水印（姓名+手机号后四位）：</td>\n' +
                '            <td nowrap="" class="TableData">' +
                '                        <input type="radio" name="mobileWatermark"  value="1" id="" '+function(){if(mobileWatermark == ''||mobileWatermark == 1){return "checked=checked"}else{return ""}}()+' >' +
                '                        <label for="THEME_SELECT"><fmt:message code="interfaceSetting.th.Open" /></label>' +
                '                        <input type="radio" style="margin-left:20px" name="mobileWatermark"  value="0" '+function(){if(mobileWatermark != ''&&mobileWatermark == 0){return "checked=checked"}else{return ""}}()+'>' +
                '                        <label for="THEME_SELECT"><fmt:message code="interfaceSetting.th.close" /></label>' +
                '                      </td>' +
                '                </tr>' +
                '<tr><td colspan="2" ' +
                'class="TableHeader fs">' +
                '<img src="/img/commonTheme/theme1/icon_mainInterface.png" alt="" style="margin-right: 6px;margin-top: -5px;"><b class="charstyle"><fmt:message code="interfaceSetting.th.Main" /></b>\
                </td>\
                </tr>\
                 <tr >\
                <td nowrap="" class="TableData"><fmt:message code="interfaceSetting.th.mainScreenTopLargeTitleText" />：</td>\
                <td nowrap="" class="TableData">\
                 <input type="text" id="setText" value="'+data.object.bannerText+'" name="" style=" width: 280px;">\
                   </td> \
                   </tr>\
                   \
                    <tr >\n                \
                    <td nowrap="" class="TableData"><fmt:message code="interfaceSetting.th.mainScreenTopLargeTitleStyle" />：</td>\n                \
                    <td nowrap="" class="TableData" style="position: relative;">\n                 \
                     <input type="hidden" id="hidtext" name="" value="'+font+'"  style=" width: 50px;">\
                     <input type="hidden" id="hidsize" name="" value="'+size+'" size=""  style=" width: 50px;">\
                     \
                     <input type="hidden" id="hidlight" name="" value="'+light+'"  style=" width: 50px;">\
                     <input type="button" id="text" name="" value="'+font2+'"  style=" width: 50px;font-family:'+font+'">\n                   \
                    <input type="button" id="size" name="" value="'+size2+'" size=""  style=" width: 50px;">\
                    <input type="button" id="color" name="" value="<fmt:message code="interfaceSetting.th.color" />"  style=" width: 50px;color:'+function(){if(color=='#FFFFFF'){return '#000000'}else{return color;}}()+'">-><input type="text" id="hidcolor" name="" value="'+color+'"  style=" width: 50px;height: 20px;">\
                    <input type="button" id="light" name="" value="'+light2+'"  style=" width: 50px;">\
                    \
                    \
                   \
                    <div id="font_family_link_menu" class="attach_div" style="font-size: 14px; position: absolute; z-index: 50; display: none; clip: rect(auto, auto, auto, auto);background: #fff;\n' +
                '    border: 1px solid #ccc;\n' +
                '    border-radius: 3px;\n' +
                '    left: 20px;">\n' +
                '  <a href="javascript:set_font_family(null);">默认字体</a>\n' +
                '  <a href="javascript:set_font_family(\'宋体\');" style="font-family:宋体;">宋体</a>\n' +
                '  <a href="javascript:set_font_family(\'黑体\');" style="font-family:黑体;">黑体</a>\n' +
                '  <a href="javascript:set_font_family(\'楷体\');" style="font-family:楷体;">楷体</a>\n' +
                '  <a href="javascript:set_font_family(\'隶书\');" style="font-family:隶书;">隶书</a>\n' +
                '  <a href="javascript:set_font_family(\'幼圆\');" style="font-family:幼圆;">幼圆</a>\n' +
                '  <a href="javascript:set_font_family(\'Arial\');" style="font-family:Arial;">Arial</a>\n' +
                '  <a href="javascript:set_font_family(\'Courier New\');" style="font-family:Courier New;">Courier New</a>\n' +
                '  <a href="javascript:set_font_family(\'Fixedsys\');" style="font-family:Fixedsys;">Fixedsys</a>\n' +
                '  <a href="javascript:set_font_family(\'Georgia\');" style="font-family:Georgia;">Georgia</a>\n' +
                '  <a href="javascript:set_font_family(\'Tahoma\');" style="font-family:Tahoma;">Tahoma</a>\n' +
                '  <a href="javascript:set_font_family(\'Verdana\');" style="font-family:Verdana;">Verdana</a>\n' +
                '</div>\
                \
                \
                \
                <div id="font_size_link_menu" class="attach_div" style="position: absolute; z-index: 50; display: none; clip: rect(auto, auto, auto, auto); background:#fff;border: 1px solid #ccc;border-radius: 3px;left: 94px; ">\n' +
                '  <a size="48pt" href="javascript:set_font_size(\'48pt\', \'48pt\');">48pt</a>\n' +
                '  <a size="9pt" href="javascript:set_font_size(\'9pt\', \'小五\');">小五</a>\n' +
                '  <a size="10.5pt" href="javascript:set_font_size(\'10.5pt\', \'五号\');">五号</a>\n' +
                '  <a size="12pt" href="javascript:set_font_size(\'12pt\', \'小四\');">小四</a>\n' +
                '  <a size="14pt" href="javascript:set_font_size(\'14pt\', \'四号\');">四号</a>\n' +
                '  <a size="15pt" href="javascript:set_font_size(\'15pt\', \'小三\');">小三</a>\n' +
                '  <a size="16pt" href="javascript:set_font_size(\'16pt\', \'三号\');">三号</a>\n' +
                '  <a size="18pt" href="javascript:set_font_size(\'18pt\',\'小二\');">小二</a>\n' +
                '  <a size="22pt" href="javascript:set_font_size(\'22pt\', \'二号\');">二号</a>\n' +
                '  <a size="24pt" href="javascript:set_font_size(\'24pt\', \'小一\');">小一</a>\n' +
                '  <a size="26pt" href="javascript:set_font_size(\'26pt\', \'一号\');">一号</a>\n' +
                '  <a size="28pt" href="javascript:set_font_size(\'28pt\', \'28pt\');">28pt</a>\n' +
                '  <a size="30pt" href="javascript:set_font_size(\'30pt\',\'30pt\');">30pt</a>\n' +
                '  <a size="32pt" href="javascript:set_font_size(\'32pt\', \'32pt\');">32pt</a>\n' +
                '  <a size="34pt" href="javascript:set_font_size(\'34pt\', \'34pt\');">34pt</a>\n' +
                '  <a size="36pt" href="javascript:set_font_size(\'36pt\', \'36pt\');">36pt</a>\n' +
                '  <a size="38pt" href="javascript:set_font_size(\'38pt\', \'38pt\');">38pt</a>\n' +
                '  <a size="40pt" href="javascript:set_font_size(\'40pt\',\'40pt\');">40pt</a>\n' +
                '</div>\
                \
                \
                <div id="font_color_link_menu" style="display: none; position: absolute; z-index: 50; clip: rect(auto, auto, auto, auto); left: 168px; "><table cellpadding="0" cellspacing="0" class="ColorTable">  <tbody><tr>    <td onmouseover="this.className=\'Selected\';" onmouseout="this.className=\'\';" onclick="set_font_color(\'#000000\');"><div style="width:11px;height:11px;background-color:#000000;"></div></td>    <td onmouseover="this.className=\'Selected\';" onmouseout="this.className=\'\';" onclick="set_font_color(\'#993300\');"><div style="width:11px;height:11px;background-color:#993300;"></div></td>    <td onmouseover="this.className=\'Selected\';" onmouseout="this.className=\'\';" onclick="set_font_color(\'#333300\');"><div style="width:11px;height:11px;background-color:#333300;"></div></td>    <td onmouseover="this.className=\'Selected\';" onmouseout="this.className=\'\';" onclick="set_font_color(\'#003300\');"><div style="width:11px;height:11px;background-color:#003300;"></div></td>    <td onmouseover="this.className=\'Selected\';" onmouseout="this.className=\'\';" onclick="set_font_color(\'#003366\');"><div style="width:11px;height:11px;background-color:#003366;"></div></td>    <td onmouseover="this.className=\'Selected\';" onmouseout="this.className=\'\';" onclick="set_font_color(\'#000080\');"><div style="width:11px;height:11px;background-color:#000080;"></div></td>    <td onmouseover="this.className=\'Selected\';" onmouseout="this.className=\'\';" onclick="set_font_color(\'#333399\');"><div style="width:11px;height:11px;background-color:#333399;"></div></td>    <td onmouseover="this.className=\'Selected\';" onmouseout="this.className=\'\';" onclick="set_font_color(\'#333333\');"><div style="width:11px;height:11px;background-color:#333333;"></div></td>  </tr>  <tr>    <td onmouseover="this.className=\'Selected\';" onmouseout="this.className=\'\';" onclick="set_font_color(\'#800000\');"><div style="width:11px;height:11px;background-color:#800000;"></div></td>    <td onmouseover="this.className=\'Selected\';" onmouseout="this.className=\'\';" onclick="set_font_color(\'#FF6600\');"><div style="width:11px;height:11px;background-color:#FF6600;"></div></td>    <td onmouseover="this.className=\'Selected\';" onmouseout="this.className=\'\';" onclick="set_font_color(\'#808000\');"><div style="width:11px;height:11px;background-color:#808000;"></div></td>    <td onmouseover="this.className=\'Selected\';" onmouseout="this.className=\'\';" onclick="set_font_color(\'#008000\');"><div style="width:11px;height:11px;background-color:#008000;"></div></td>    <td onmouseover="this.className=\'Selected\';" onmouseout="this.className=\'\';" onclick="set_font_color(\'#008080\');"><div style="width:11px;height:11px;background-color:#008080;"></div></td>    <td onmouseover="this.className=\'Selected\';" onmouseout="this.className=\'\';" onclick="set_font_color(\'#0000FF\');"><div style="width:11px;height:11px;background-color:#0000FF;"></div></td>    <td onmouseover="this.className=\'Selected\';" onmouseout="this.className=\'\';" onclick="set_font_color(\'#666699\');"><div style="width:11px;height:11px;background-color:#666699;"></div></td>    <td onmouseover="this.className=\'Selected\';" onmouseout="this.className=\'\';" onclick="set_font_color(\'#808080\');"><div style="width:11px;height:11px;background-color:#808080;"></div></td>  </tr>  <tr>    <td onmouseover="this.className=\'Selected\';" onmouseout="this.className=\'\';" onclick="set_font_color(\'#0066CC\');"><div style="width:11px;height:11px;background-color:#0066CC;"></div></td>    <td onmouseover="this.className=\'Selected\';" onmouseout="this.className=\'\';" onclick="set_font_color(\'#FF9900\');"><div style="width:11px;height:11px;background-color:#FF9900;"></div></td>    <td onmouseover="this.className=\'Selected\';" onmouseout="this.className=\'\';" onclick="set_font_color(\'#99CC00\');"><div style="width:11px;height:11px;background-color:#99CC00;"></div></td>    <td onmouseover="this.className=\'Selected\';" onmouseout="this.className=\'\';" onclick="set_font_color(\'#339966\');"><div style="width:11px;height:11px;background-color:#339966;"></div></td>    <td onmouseover="this.className=\'Selected\';" onmouseout="this.className=\'\';" onclick="set_font_color(\'#33CCCC\');"><div style="width:11px;height:11px;background-color:#33CCCC;"></div></td>    <td onmouseover="this.className=\'Selected\';" onmouseout="this.className=\'\';" onclick="set_font_color(\'#3366FF\');"><div style="width:11px;height:11px;background-color:#3366FF;"></div></td>    <td onmouseover="this.className=\'Selected\';" onmouseout="this.className=\'\';" onclick="set_font_color(\'#800080\');"><div style="width:11px;height:11px;background-color:#800080;"></div></td>    <td onmouseover="this.className=\'Selected\';" onmouseout="this.className=\'\';" onclick="set_font_color(\'#999999\');"><div style="width:11px;height:11px;background-color:#999999;"></div></td>  </tr>  <tr>    <td onmouseover="this.className=\'Selected\';" onmouseout="this.className=\'\';" onclick="set_font_color(\'#FF00FF\');"><div style="width:11px;height:11px;background-color:#FF00FF;"></div></td>    <td onmouseover="this.className=\'Selected\';" onmouseout="this.className=\'\';" onclick="set_font_color(\'#FFCC00\');"><div style="width:11px;height:11px;background-color:#FFCC00;"></div></td>    <td onmouseover="this.className=\'Selected\';" onmouseout="this.className=\'\';" onclick="set_font_color(\'#FFFF00\');"><div style="width:11px;height:11px;background-color:#FFFF00;"></div></td>    <td onmouseover="this.className=\'Selected\';" onmouseout="this.className=\'\';" onclick="set_font_color(\'#00FF00\');"><div style="width:11px;height:11px;background-color:#00FF00;"></div></td>    <td onmouseover="this.className=\'Selected\';" onmouseout="this.className=\'\';" onclick="set_font_color(\'#00FFFF\');"><div style="width:11px;height:11px;background-color:#00FFFF;"></div></td>    <td onmouseover="this.className=\'Selected\';" onmouseout="this.className=\'\';" onclick="set_font_color(\'#00CCFF\');"><div style="width:11px;height:11px;background-color:#00CCFF;"></div></td>    <td onmouseover="this.className=\'Selected\';" onmouseout="this.className=\'\';" onclick="set_font_color(\'#993366\');"><div style="width:11px;height:11px;background-color:#993366;"></div></td>    <td onmouseover="this.className=\'Selected\';" onmouseout="this.className=\'\';" onclick="set_font_color(\'#CCCCCC\');"><div style="width:11px;height:11px;background-color:#CCCCCC;"></div></td>  </tr>  <tr>    <td onmouseover="this.className=\'Selected\';" onmouseout="this.className=\'\';" onclick="set_font_color(\'#FF99CC\');"><div style="width:11px;height:11px;background-color:#FF99CC;"></div></td>    <td onmouseover="this.className=\'Selected\';" onmouseout="this.className=\'\';" onclick="set_font_color(\'#FFCC99\');"><div style="width:11px;height:11px;background-color:#FFCC99;"></div></td>    <td onmouseover="this.className=\'Selected\';" onmouseout="this.className=\'\';" onclick="set_font_color(\'#FFFF99\');"><div style="width:11px;height:11px;background-color:#FFFF99;"></div></td>    <td onmouseover="this.className=\'Selected\';" onmouseout="this.className=\'\';" onclick="set_font_color(\'#CCFFCC\');"><div style="width:11px;height:11px;background-color:#CCFFCC;"></div></td>    <td onmouseover="this.className=\'Selected\';" onmouseout="this.className=\'\';" onclick="set_font_color(\'#CCFFFF\');"><div style="width:11px;height:11px;background-color:#CCFFFF;"></div></td>    <td onmouseover="this.className=\'Selected\';" onmouseout="this.className=\'\';" onclick="set_font_color(\'#99CCFF\');"><div style="width:11px;height:11px;background-color:#99CCFF;"></div></td>    <td onmouseover="this.className=\'Selected\';" onmouseout="this.className=\'\';" onclick="set_font_color(\'#CC99FF\');"><div style="width:11px;height:11px;background-color:#CC99FF;"></div></td>    <td onmouseover="this.className=\'Selected\';" onmouseout="this.className=\'\';" onclick="set_font_color(\'#FFFFFF\');"><div style="width:11px;height:11px;background-color:#FFFFFF;"></div></td>  </tr></tbody></table></div>\
                \
                \
                <div id="font_filter_link_menu" class="attach_div" style="position: absolute; z-index: 50; display: none; clip: rect(auto, auto, auto, auto); left: 319px;background:#fff;border: 1px solid #ccc;border-radius :3px ">\n' +
                '  <a href="javascript:set_font_filter(\'\', \'效果\');">默认效果</a>\n' +
                '  <a href="javascript:set_font_filter(\'1\', \'投影\');">投影</a>\n' +
                '  <a href="javascript:set_font_filter(\'2\', \'发光\');">发光</a>\n' +
                '</div>\
                                \
                                                                    </td> \n                   \
                                                                    </tr>\
                                                                \
                                                                <tr style="display: none;">\
                                                                <td nowrap="" class="TableData"><fmt:message code="interfaceSetting.th.MainInterface" />：</td>\
            <td nowrap="" class="TableData">\
            <textarea class="BigInput" cols="44" rows="3" id="status_text"></textarea>\
            <br><fmt:message code="interfaceSetting.th.MultipleLines" /> </td> \
                </tr>\
                      <tr>\
                        <td><fmt:message code="global.th.master" /></td>\
                        <td style="position:relative">\
                        <img style="width:400px;left: 0;" class="img">\
                        <input type="file" name="file" id="uploadinputimgs"  style="position:absolute;z-index:10;background: red;\
            width: 50px;\
            left: 20px;opacity:0;\
            top: 5px;filter:progid:DXImageTransform.Microsoft.Alpha(opacity=0)"/>\
                        <a href="javascript:void(0)" class="chuan" style="position: absolute;\
                        z-index: 1;\
                        top: 9px;\
                        color: #fff;\
                        text-decoration: none;\
                        left: 24px;\
                        padding: 2px 10px;\
                        border-radius: 4px;\
                        background: cornflowerblue;"><fmt:message code="global.th.upload" /></a>\
                         <a href="javascript:void(0)" style="position: absolute;\
                        z-index: 1;\
                        bottom: 34px;\
                        text-decoration: none;\
                        left: 0px;\
                        padding: 2px 10px;\
                        border-radius: 4px;display:none;"\
                       class="yulan" typelook="3"><fmt:message code="global.lang.view" /></a>\
                        <a href="javascript:void(0)" style="position: absolute;\
                        z-index: 1;\
                        bottom: 34px;\
                        text-decoration: none;\
                        left: 20px;\
                        color:red;\
                        margin-left: 40px;\
                        padding: 2px 10px;\
                        border-radius: 4px;display:none;"\
                       class="del delIndex"><fmt:message code="global.lang.delete" /></a>\
                        <input type="hidden" name="attachmentId">\
                        <input type="hidden" name="attachmentName">\
                         <span style="width: 100%;float: left;margin-top: 40px;" class="indexlogo"><fmt:message code="global.lang.uploadLogoImageOnMainScreen" /></span>\
                        </td>\
                    </tr>\
                    \
                  \
                  <tr>\
                  <td><fmt:message code="global.lang.interface" /></td>\
                 <td style="position:relative">\
                 <img style="width:400px;left: 0;" class="img">\
                 <input type="file" name="file" id="uploadinputimgIphoneLogin"  style="position:absolute;z-index:10;background: red;\
                 width: 50px; left: 20px;opacity:0;top: 5px;filter:progid:DXImageTransform.Microsoft.Alpha(opacity=0)"/>\
                 <a href="javascript:void(0)" class="chuan" style="position: absolute;\
                  z-index: 1;\
                  top: 9px;\
                  color: #fff;\
                  text-decoration: none;\
                  left: 24px;\
                 padding: 2px 10px;\
                 border-radius: 4px;\
                 background: cornflowerblue;"><fmt:message code="global.th.upload" /></a>\
                <a href="javascript:void(0)" style="position: absolute;z-index: 1; bottom: 34px;text-decoration: none; left: 0px; padding: 2px 10px; border-radius: 4px;display:none;" class="yulan" typelook="4"><fmt:message code="global.lang.view" /></a>\
                  <a href="javascript:void(0)" style="position: absolute;\
                        z-index: 1;\
                        bottom: 34px;\
                        text-decoration: none;\
                        left: 20px;\
                        color:red;\
                        margin-left: 40px;\
                        padding: 2px 10px;\
                        border-radius: 4px;display:none;"\
                       class="del delIndex" id="roidimg"><fmt:message code="global.lang.delete" /></a>\
                <input type="hidden" name="attachmentId4"> <input type="hidden" name="attachmentName4">\
                                         <span style="width: 100%;float: left;margin-top: 40px;"><fmt:message code="global.lang.uploadLogoImageOnMobileLoginPage" />/span>\
                </td>\
                </tr> \
                \
                \
                \
                \
                \
                \
                \
                \
                \
                \
                \
                \
                \
                \
                \
                \
                \
                 <tr>\n                \
                 <td nowrap="" class="TableData"><fmt:message code="interfaceSetting.th.showWeather" />：</td>\n           \
               <td nowrap="" class="TableData">\n            \
               <input type="radio" name="weatherCity" value="0" id="" '+function(){if(weather !=1){return "checked=checked"}else{return ""}}()+'>\n            \
               <label for="THEME_SELECT"><fmt:message code="interfaceSetting.th.yes" /></label>\n                \
                 <input type="radio" name="weatherCity" style="margin-left:20px" id="" value="1" '+function(){if(weather == 1){return "checked=checked"}else{return ""}}()+'>\n                      \
                  <label for="THEME_SELECT"><fmt:message code="interfaceSetting.th.no" /></label>\n                \
               </td>\n                \
               </tr>\
                <tr>\
                <td colspan="2" class="TableHeader fs">\
                <img src="/img/commonTheme/theme1/icon_interfaceTitle.png" alt="" style="margin-right: 6px;margin-top: -5px;"><b class="charstyle"><fmt:message code="interfaceSetting.th.InterfaceTopics" /></b>\
                </td>\
                </tr>\
                <tr>\
                <td nowrap="" class="TableData"><fmt:message code="interfaceSetting.th.SelectInterface" />：</td>\
            <td nowrap="" class="TableData">\
            <input type="checkbox" name="THEME_SELECT" id="theme_select" checked="checked">\
            <label for="THEME_SELECT"><fmt:message code="interfaceSetting.th.AllowsSelectInterface" /></label>\
                </td>\
                </tr>\
                <tr>\
                <td nowrap="" class="TableData"><fmt:message code="interfaceSetting.th.Default" />：</td>\
            <td nowrap="" class="TableData">\
            <select name="THEME" id="theme">\
                <option value="20"><fmt:message code="home.page.fashion.title" /></option>\
                <option value="6"><fmt:message code="controller.th.er" /></option>  \
                <option value="7"><fmt:message code="controller.th.san" /></option>\
                <option value="3"><fmt:message code="controller.th.si" /></option>\
                <option value="4"><fmt:message code="controller.th.gm" /></option>\
                <option value="5"><fmt:message code="controller.th.dge" /></option>\
                </select>\
                </td>\
                \
                </tr>\
                <tr>\
                      <td nowrap="" class="TableData"><fmt:message code="interfaceSetting.th.fashionThemeMenuDefault" />：</td>\
                      <td nowrap="" class="TableData">\
                        <input type="radio" name="loginInterface" value="1" id="" '+function(){if(loginInterface == ''||loginInterface == 1){return "checked=checked"}else{return ""}}()+'>\
                        <label for="THEME_SELECT"> <fmt:message code="interfaceSetting.th.portal" /></label>\
                        <input type="radio" style="margin-left:20px" name="loginInterface" value="0"'+function(){if(loginInterface != ''&&loginInterface == 0){return "checked=checked"}else{return ""}}()+'>\
                        <label for="THEME_SELECT"> <fmt:message code="interfaceSetting.th.applyAll" /></label>\
                      </td>\
                </tr>\
                <tr>\
                <td nowrap="" class="TableHeader fs" colspan="2">\
                <img src="/img/commonTheme/theme1/icon_userImage.png" alt="" style="margin-right: 6px;margin-top: -5px;"><b class="charstyle"><fmt:message code="interfaceSetting.th.UserAvatar" /></b>\
                </td>\
                </tr>\
                <tr>\
                <td><fmt:message code="interfaceSetting.th.UserUploadAvatar" />：</td>\
            <td nowrap="" class="TableData">\
            <input type="checkbox" name="" id="upload_head" checked="checked">\
            <label for="THEME_SELECT"><fmt:message code="interfaceSetting.th.AllowUpload" /></label>\
               </td>\
               </tr>\
               <tr><td><fmt:message code="interfaceSetting.th.MaximumWidth" />：</td>\
            <td nowrap="" class="TableData">\
            <input type="text" name="" class="BigInput" \
            size="10" maxlength="100" value="'+widthpic+'" id="width_max" ' +
                'style="width:50px">&nbsp; <fmt:message code="interfaceSetting.th.pixel" /></td>\
                </td>\
                </tr>\
                <tr>\
                <td><fmt:message code="interfaceSetting.th.MaximumHeight" />：</td>\
            <td nowrap="" class="TableData">\
            <input type="text" name="" class="BigInput" size="10" \
            maxlength="100" value="'+heightpic+'" id="height_max" ' +
                'style="width:50px">&nbsp;<fmt:message code="interfaceSetting.th.pixel" /> </td> \
                </td>\
                </tr>\
                <tr>\
                <td colspan="2" class="TableHeader fs">\
                <img src="/img/commonTheme/theme1/icon_tishiText.png" alt="" style="margin-right: 6px;"><b class="charstyle"><fmt:message code="interfaceSetting.th.CancelPrompt" /></b>\
                </td>\
                </tr>\
                <tr>\
                <td nowrap="" class="TableData" width="150"><fmt:message code="interfaceSetting.th.clicks" />：</td>\
            <td nowrap="" class="TableData">\
            <textarea name="LOG_OUT_TEXT" class="BigInput" cols="44" rows="3" id="log_out_text"><fmt:message code="interfaceSetting.th.leave" /></textarea>\
                <br>\
                </td>\
                </tr>\
                <tr id="pcClientTitle">\
                <td nowrap="" colspan="2" class="TableData TableHeader fs">\
                <img src="/img/commonTheme/theme1/icon_PCTitle.png" alt="" style="margin-right: 6px;margin-top: -5px;"><b class="charstyle">电脑客户端窗口标题</b>\
                </td>\
                </tr>\
                <tr id="pcClientText">\
                <td nowrap="" class="TableData">电脑客户端窗口标题：</td>\
            <td nowrap="" class="TableData">\
            <input type="text" name="IM_WINDOW_CAPTION" \
            class="BigInput" size="40" maxlength="100"\
             value="<fmt:message code="title.login.txt"/>" style="width:280px" id="wi_title">&nbsp;</td>\
            </tr>\
            <tr>\
            <td nowrap="" class="TableControl" colspan="2" align="center">\
            <div onclick="saveData();" class="savebutton"><span><fmt:message code="global.lang.ok"/></span></div>\
                </td>\
                </tr>\
                </tbody>\
                </table>';
            $(".tab").html(str);
            //涉密系统中是否开启启用app功能
            $.ajax({
                type:'get',
                url:'/syspara/selectTheSysPara?paraName=IS_USE_APP',
                dataType:'json',
                success:function (res) {
                    var data = res.object[0];
                    if(data.paraValue == 0) {
                        $(".appTitle").hide();
                        $("#appIndex").hide();
                        $("#pcClientTitle").hide();
                        $("#pcClientText").hide();
                        $("#appUpLogo").hide();
                        $("#appIndexTitle").hide();
                    }
                }
            })

            $.ajax({
                url:'/sys/selectMySql',
                dataType:'json',
                type:'get',
                success:function(res){
                    if(res.code==0){
                        $('#model_sytle').parent().parent().hide();
                    }else if(res.code==1){
                        $('#model_sytle').parent().parent().show();
                    }
                }
            });
            parent.strsecced=datatwo.logOutText;
            $('[name="loginLiterals"]').val(datatwo.loginLiterals)

            $('[name="attachmentId2"]').val(datatwo.attachmentId2)
            $('[name="attachmentName2"]').val(datatwo.attachmentName2)
            if(datatwo.attachment2.length!=0) {
                $('[name="attachmentName2"]').siblings('.chuan').hide()
                $('[name="attachmentName2"]').siblings('.yulan').show()
                $('[name="attachmentName2"]').siblings('.del').show()
                $('[name="attachmentName2"]').siblings('.yulan').attr('data-url', '/xs?' + datatwo.attachment2[0].attUrl)
                $('[name="attachmentName2"]').siblings('.img').attr('src', '/xs?' + datatwo.attachment2[0].attUrl)
            }else{
                $('[name="attachmentName2"]').siblings('.yulan').hide()
                $('[name="attachmentName2"]').siblings('.img').hide()
                $('[name="attachmentName2"]').siblings('.chuan').show()
                $('[name="attachmentName2"]').siblings('span').css('margin-top','30px')
            }
            $('[name="attachmentId"]').val(datatwo.attachmentId)
            $('[name="attachmentName"]').val(datatwo.attachmentName)

            if(datatwo.attachment.length!=0) {
                $('[name="attachmentName"]').siblings('.chuan').hide()
                $('[name="attachmentName"]').siblings('.yulan').show()
                $('[name="attachmentName"]').siblings('.del').show()
                $('[name="attachmentName"]').siblings('.yulan').attr('data-url', '/xs?' + datatwo.attachment[0].attUrl)
                $('[name="attachmentName"]').siblings('.img').attr('src', '/xs?' + datatwo.attachment[0].attUrl)
            }else{
                $('[name="attachmentName"]').siblings('.yulan').hide()
                $('[name="attachmentName"]').siblings('.img').hide()
                $('[name="attachmentName"]').siblings('.chuan').show()
                $('[name="attachmentName"]').siblings('span').css('margin-top','30px')
            }
            $('[name="attachmentId3"]').val(datatwo.attachmentId3)
            $('[name="attachmentName3"]').val(datatwo.attachmentName3)
            if(datatwo.attachment3.length!=0) {
                $('[name="attachmentName3"]').siblings('.chuan').hide()
                $('[name="attachmentName3"]').siblings('.yulan').show()
                $('[name="attachmentName3"]').siblings('.del').show()
                $('[name="attachmentName3"]').siblings('.yulan').attr('data-url', '/xs?' + datatwo.attachment3[0].attUrl)
                $('[name="attachmentName3"]').siblings('.img').attr('src', '/xs?' + datatwo.attachment3[0].attUrl)
            }else{
                $('[name="attachmentName3"]').siblings('.yulan').hide()
                $('[name="attachmentName3"]').siblings('.img').hide()
                $('[name="attachmentName3"]').siblings('.chuan').show()
                $('[name="attachmentName3"]').siblings('span').css('margin-top','30px')
            }
            $('[name="attachmentId4"]').val(datatwo.attachmentId4)
            $('[name="attachmentName4"]').val(datatwo.attachmentName4)
            if(datatwo.attachment4.length!=0) {
                $('[name="attachmentName4"]').siblings('.chuan').hide()
                $('[name="attachmentName4"]').siblings('.yulan').show()
                $('[name="attachmentName4"]').siblings('.del').show()
                $('[name="attachmentName4"]').siblings('.yulan').attr('data-url', '/xs?' + datatwo.attachment4[0].attUrl)
                $('[name="attachmentName4"]').siblings('.img').attr('src', '/xs?' + datatwo.attachment4[0].attUrl)
            }else{
                $('[name="attachmentName4"]').siblings('.yulan').hide()
                $('[name="attachmentName4"]').siblings('.img').hide()
                $('[name="attachmentName4"]').siblings('.chuan').show()
                $('[name="attachmentName4"]').siblings('span').css('margin-top','30px')
            }
            if(datatwo.themeSelect == '1'){
                $('#theme_select').prop('checked',true);
            }else{
                $('#theme_select').prop('checked',false);
            }
            if(datatwo.avatarUpload == '1'){
                $('#upload_head').prop('checked',true);
            }else{
                $('#upload_head').prop('checked',false);
            }
//            $('#theme_select').val(datatwo.themeSelect);
//            $('#upload_head').val(datatwo.avatarUpload);
            buildThemeSelect();



            $('#uploadinputimg').fileupload({//加载上以后启动上传
                dataType:'json',
                url:'/upload?module=interface',
                done: function (e, data) {
                    var datas = data.result.obj;
                    var strid = datas[0].attachId;
                    var strname = datas[0].attachName;
                    $('[name="attachmentId2"]').val(datas[0].aid+'@'+datas[0].ym+'_'+strid+',');
                    $('[name="attachmentName2"]').val(strname+'*');
                    $(this).siblings('.yulan').attr('data-url','/xs?'+datas[0].attUrl);
                    $(this).siblings('.img').attr('src', '/xs?' + datas[0].attUrl)
                    $(this).siblings('.img').css('display','block')
                    $(this).siblings('.yulan').show();
                    $(this).siblings('.del').show()
                    $(this).siblings('.chuan').hide()
                    $('.widths').css('margin-top','40px')
//                    $(this).siblings('.sczs').html(' <img style="width:100%;height:100%;position: absolute;top:0;left:0" src="/xs?'+datas[0].attUrl+'" />\
//                        <b style="    position: absolute;\
//                        color: red;\
//                        right: -2px;\
//                        top: -10px;\
//                        font-weight: bold;cursor: pointer;">x</b>')
                }
            });



            $('#uploadinputimgs').fileupload({//加载上以后启动上传
                dataType:'json',
                url:'/upload?module=interface',
                done: function (e, data) {
                    var datas = data.result.obj;
                    var strid = datas[0].attachId;
                    var strname = datas[0].attachName;
                    $('[name="attachmentId"]').val(datas[0].aid+'@'+datas[0].ym+'_'+strid+',');
                    $('[name="attachmentName"]').val(strname+'*');
                    $(this).siblings('.yulan').attr('data-url','/xs?'+datas[0].attUrl);
                    $(this).siblings('.img').attr('src', '/xs?' + datas[0].attUrl)
                    $(this).siblings('.yulan').show();
                    $(this).siblings('.del').show()
                    $(this).siblings('.chuan').hide()
                    $(this).siblings('.img').css('display','block')
                    $(this).siblings('span').css('margin-top','40px')
                }
            });
            $('#uploadinputimgIphone').fileupload({//加载上以后启动上传
                dataType:'json',
                url:'/upload?module=interface',
                done: function (e, data) {
                    var datas = data.result.obj;
                    var strid = datas[0].attachId;
                    var strname = datas[0].attachName;
                    $('[name="attachmentId3"]').val(datas[0].aid+'@'+datas[0].ym+'_'+strid+',');
                    $('[name="attachmentName3"]').val(strname+'*');
                    $(this).siblings('.yulan').attr('data-url','/xs?'+datas[0].attUrl);
                    $(this).siblings('.img').attr('src', '/xs?' + datas[0].attUrl)
                    $(this).siblings('.img').css('display','block')
                    $(this).siblings('.yulan').show();
                    $(this).siblings('.del').show()
                    $(this).siblings('.chuan').hide()
                    $(this).siblings('.andimg').css('margin-top','40px')

                }
            });
            $('#uploadinputimgIphoneLogin').fileupload({//加载上以后启动上传
                dataType:'json',
                url:'/upload?module=interface',
                done: function (e, data) {
                    var datas = data.result.obj;
                    var strid = datas[0].attachId;
                    var strname = datas[0].attachName;
                    $('[name="attachmentId4"]').val(datas[0].aid+'@'+datas[0].ym+'_'+strid+',');
                    $('[name="attachmentName4"]').val(strname+'*');
                    $(this).siblings('.yulan').attr('data-url','/xs?'+datas[0].attUrl);
                    $(this).siblings('.img').attr('src', '/xs?' + datas[0].attUrl)
                    $(this).siblings('.img').css('display', 'block')
                    $(this).siblings('.yulan').show();
                    $(this).siblings('.del').show()
                    $(this).siblings('.chuan').hide()
                    $(this).siblings('.img').css('display','block')
                    $(this).siblings('span').css('margin-top','40px')
                }
            });


            $("#model_sytle").val(data.object.template);
            $("#theme").val(data.object.theme);
            $("#status_text").val(status_text);
            $("#log_out_text").val(log_text);
            $("#wi_title").val(title);
        }
    });
        //字体显示隐藏
    $(document).on('click','#text',function(){
        $('#font_family_link_menu').show();
    })
        $(document).on('mouseleave','#font_family_link_menu',function(){
            $('#font_family_link_menu').hide();
        })

        //大小显示隐藏
        $(document).on('click','#size',function(){
            $('#font_size_link_menu').show();
        })
        $(document).on('mouseleave','#font_size_link_menu',function(){
            $('#font_size_link_menu').hide();
        })

        //颜色显示隐藏
        $(document).on('click','#color',function(){
            $('#font_color_link_menu').show();
        })
        $(document).on('mouseleave','#font_color_link_menu',function(){
            $('#font_color_link_menu').hide();
        })

        //发光显示隐藏
        $(document).on('click','#light',function(){
            $('#font_filter_link_menu').show();
        })
        $(document).on('mouseleave','#font_filter_link_menu',function(){
            $('#font_filter_link_menu').hide();
        })
    var height = '';
    var width = '';
    $(document).delegate('.yulan','click',function () {
      if($(this).attr('typelook') == '1'){
          height = '57px';
      }else if($(this).attr('typelook') == '2'){
          height = '482px';
          width = '568px';
      }else if($(this).attr('typelook') == '3'){
          height = '61px';
      }else{
          height = '329px';
          width = '335px';
      }
        layer.open({
            type: 1,
            title: false,
            closeBtn: 1,
            shade: false,
            shadeClose: true,
            area: [width,height],
            content: '<img class="picture" style="width:'+width + ';height: '+ height +'" src="'+$(this).attr('data-url')+'" alt="">',
            // success:function(){
            //     var layerInitWidth = $(".layui-layer").width(); //获取弹出层的大小
            //     var img = $('.picture');
            //     var realWidth;//真实的宽度
            //     var realHeight;//真实的高度
            //     //这里做下说明，$("<img/>")这里是创建一个临时的img标签，类似js创建一个new Image()对象！
            //     $("<img/>").attr("src", $(img).attr("src")).load(function() {
            //         realWidth = this.width;
            //         realHeight = this.height;
            //         if(realWidth>=layerInitWidth){
            //             $(img).css("width","100%").css("height","auto");
            //         }else{
            //             $(img).css("width",realWidth+'px').css("height",realHeight+'px');
            //         }
            //     });
            // }
        });



//        var str='<div style="z-index: 1000;position: fixed;top: 0;left: 0;right: 0;bottom: 0;' +
//            'background: rgba(111,111,111,.5)"><img width="165" height="61"' +
//            'style="z-index: 1000;position: fixed;top: 50%;margin-top: -30px;left: 50%;margin-left: -82px" src="'+$(this).attr('data-url')+'" alt="">' +
//            '<b class="guanbi" style="cursor:pointer;color: red;font-size: 18px;font-weight: bold;position: fixed;top: 76px;right: 20px;">x</b></div>';
//        $('body').append(str)
    })
    $(document).delegate('.del','click',function () {
        $(this).hide()
        $(this).siblings('.yulan').hide()
        $(this).siblings('.img').hide()
        $(this).siblings('.chuan').show()
        $(this).siblings('span').css('margin-top','100px')
        $(this).next().val('');
        $(this).next().next().val('');

    })
    $(document).delegate('.delIndex','click',function () {
        $(this).hide()
        $(this).siblings('.yulan').hide()
        $(this).siblings('.img').hide()
        $(this).siblings('.chuan').show()
        $(this).siblings('span').css('margin-top','30px')
        $(this).next().val('');
        $(this).next().next().val('');


    })
    $(document).delegate('.guanbi','click',function () {
        $(this).parent().remove()
    })

        //预览登陆界面模板
        $(document).delegate('.yulanModel','click',function () {
            var selected = $("#model_sytle option:selected").attr("value");
                window.open("/defaultIndex" + selected + "?selected=" + selected)
        })



})
    $.ajax({
        url:'/sys/selectMySql',
        dataType:'json',
        type:'get',
        success:function(res){
            if(res.code==0){
                $('#model_sytle').parent().parent().hide();
            }else if(res.code==1){
                $('#model_sytle').parent().parent().show();
            }
        }
    });
</script>
</body>
</html>
