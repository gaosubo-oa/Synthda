<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@taglib prefix="mvc" uri="http://www.springframework.org/tags/form" %>
<%@taglib prefix="fmt" uri="http://www.springframework.org/tags" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>中小企业版激活/续期</title>
    <meta name="renderer" content="webkit">
    <meta http-equiv="X-UA-Compatible" content="IE=10,chrome=1">
    <meta name="viewport" content="width=device-width, initial-scale=0.3, user-scalable=0, minimum-scale=0, maximum-scale=5.0,user-scalable=yes">
    <link rel="stylesheet" type="text/css" href="../css/sys/addUser.css"/>
    <script src="../js/xoajq/xoajq1.js" type="text/javascript" charset="utf-8"></script>
    <script src="../js/base/base.js" type="text/javascript" charset="utf-8"></script>
    <script src="../js/sys/citys.js" type="text/javascript" charset="utf-8"></script>
    <script src="../js/ajaxupload.js" type="text/javascript" charset="utf-8"></script>
    <script src="../js/jquery/jquery.form.min.js" type="text/javascript" charset="utf-8"></script>

    <script>

    </script>
    <style type="text/css">
        .TableBlock {
            border: 1px #cccccc solid;
            line-height: 20px;
            font-size: 11pt;
            border-collapse: collapse;
            position: relative;
            top: 50px;
        }

        .TableBlock .TableContent td, .TableBlock td.TableContent {
            background: #fff;
            border-bottom: 1px #cccccc solid;
            border-right: 1px #cccccc solid;
            padding: 3px;
            height: 30px;
        }

        .TableContent {
            /* BACKGROUND: #4897e8; */
        }

        .TableBlock .TableData td, .TableBlock td.TableData {
            background: #FFFFFF;
            border-bottom: 1px #cccccc solid;
            border-right: 1px #cccccc solid;
            padding: 3px;
            height: 30px;
            border-top: 1px #cccccc solid;
        }

        .TableData {
            BACKGROUND: #FFFFFF;
            COLOR: #000000;
        }

        td, th {
            display: table-cell;
            vertical-align: inherit;
        }

        tr {
            display: table-row;
            vertical-align: inherit;
            border-color: inherit;
        }

        table {
            width: 94%;
            margin: 0 auto;
            font-size: 14px;
            margin-top: 10px;
            margin-bottom: 15px;
        }

        table tr td {
            border-right: 0px solid !important;
        }

        .big3 {
            font-family: Microsoft yahei,Helvetica Neue,Helvetica,PingFang SC,Tahoma,Arial,sans-serif;
            font-size: 22px;
            color: #494d59;
            margin-top: -4px;
        }

        .TableHeader {
            background: #fff;
            border-bottom: 1px #cccccc solid;
        }

        .TableContent {
            border-right: 1px #cccccc solid !important;
        }

        #small {
            position: fixed;
            z-index: 99;
            top: 0px;
            background: #f6f7f9;
            width: 100%;
            margin-top: 0;
            height: 40px;
        }

        .file {
            position: relative;
            display: inline-block;
            background: #D0EEFF;
            border: 1px solid #99D3F5;
            border-radius: 4px;
            padding: 4px 12px;
            overflow: hidden;
            color: #1E88C7;
            text-decoration: none;
            text-indent: 0;
            line-height: 18px;
        }
        .file input {
            position: absolute;
            font-size: 100px;
            right: 0;
            top: 0;
            opacity: 0;
        }
        .file:hover {
            background: #AADFFD;
            border-color: #78C3F3;
            color: #004974;
            text-decoration: none;
        }
        input[type="text"]{
            width:280px!important;
            height:28px!important;
            border-radius: 3px;
        }
        input[type="button"]{
            position: relative;
            display: inline-block;
            border: 1px solid #99D3F5;
            border-radius: 4px;
            padding: 4px 12px;
            overflow: hidden;
            background: #2b7fe0;
            color: #fff;
            text-decoration: none;
            text-indent: 0;
            line-height: 18px;

        }
        #sheng,#city{
            width:80px;
            margin-right:10px;
        }
    </style>
    <link rel="stylesheet" type="text/css" href="/css/commonTheme/${sessionScope.InterfaceModel}/commonTheme.css"/>
</head>
<body style="background: #f6f7f9;">
<table border="0" width="100%" cellspacing="0" cellpadding="3" class="small" id="small">
    <tbody>
    <tr>
        <td class="Big" style="padding: 10px 30px;border-bottom: 1px solid #999;">
            <img src="/img/commonTheme/${sessionScope.InterfaceModel}/sysinfo.png" style="float:left;margin-right: 12px;">

            <div class="big3">中小企业版激活/续期</div>
        </td>
    </tr>
    </tbody>
</table>
<table class="TableBlock" width="800" align="center" id="TableBlock" style="margin-top: 20px;margin-bottom: 50px;">
    <tbody>
    <tr><td nowrap="" colspan="2" align="left" style="border-bottom:1px solid #c0c0c0;"><img src="/img/commonTheme/theme6/xthhkxx.png" style="float:left;margin-right: 12px;vertical-align: baseline;"><b style="color: #2F5C8F; font-size: 13pt; vertical-align: -webkit-baseline-middle;">中小企业版激活/续期</b></td></tr>
    <tr><td nowrap="" style="width: 15%;" class="TableContent"><b>&nbsp;激活后授权用户数： </b></td><td nowrap="" class="TableData">200人</td></tr>
    <tr><td nowrap="" class="TableContent"><b>&nbsp;激活/续期价格：</b></td><td nowrap="" class="TableData">0元</td></tr>
    <tr><td nowrap="" class="TableContent"><b>&nbsp;续期时长：</b></td><td nowrap="" class="TableData">35天</td></tr>
    <tr><td nowrap="" class="TableContent"><b>&nbsp;单位名称<span style="color: red;">*</span>： </b></td><td nowrap="" class="TableData"><input type="text" class="company"></td></tr>
    <tr><td nowrap="" class="TableContent"><b>&nbsp;所在省市<span style="color: red;">*</span>： </b></td><td nowrap="" class="TableData"><select name="sheng" id="sheng"></select><select name="city" id="city"><option value="">请选择</option></select></td></tr>
    <tr><td nowrap="" class="TableContent"><b>&nbsp;联系人<span style="color: red;">*</span>： </b></td><td nowrap="" class="TableData"><input type="text" class="connname"></td></tr>
    <tr><td nowrap="" class="TableContent"><b>&nbsp;手机号<span style="color: red;">*</span>： </b></td><td nowrap="" class="TableData"><input type="text" class="iphone"></td></tr>
    <tr><td nowrap="" class="TableContent"><b>&nbsp;短信验证码<span style="color: red;">*</span>： </b></td><td nowrap="" class="TableData"><input type="text" class="duanxin"><a
            href="javascript:;" style="color:red;font-weight:bold" id="btnSendCode" onclick="send()">免费获取</a></td></tr>
    <tr><td nowrap="" class="TableContent"><b>&nbsp;当前授权用户数： </b></td><td nowrap="" class="TableData userNum"></td></tr>
    <tr><td nowrap="" class="TableContent"><b>&nbsp;当前用户数：</b></td><td nowrap="" class="TableData thisNum"></td></tr>
    <tr><td nowrap="" class="TableContent"><b>&nbsp;安装时间：</b></td><td nowrap="" class="TableData codenum"></td></tr>
    <tr id="end" style="display:none"><td nowrap="" class="TableContent"><b>&nbsp;到期时间： </b></td><td nowrap="" class="TableData endtime"></td></tr>
    <tr><td nowrap="" class="TableContent"><b>&nbsp;版本号： </b></td><td nowrap="" class="TableData edition"></td></tr>
    <tr><td nowrap="" class="TableContent"><b>&nbsp;机器码：</b></td><td nowrap="" class="TableData ma_code"></td></tr>
    <tr><td nowrap="" class="TableContent"><b>&nbsp;本月活跃用户数：</b></td><td nowrap="" class="TableData month"></td></tr>
    <tr><td nowrap="" class="TableContent"><b>&nbsp;本月登录用户数：</b></td><td nowrap="" class="TableData zhou"></td></tr>
    <tr><td nowrap="" class="TableContent"><b>&nbsp;本日活跃用户数：</b></td><td nowrap="" class="TableData ri"></td></tr>
    <tr><td colspan="2" nowrap="" class="TableData" align="center"><input value="提交" id="up" type="button" style="cursor:pointer"><input value="返回" id="back" type="button" style="margin-left:10px;cursor:pointer"></td></tr>
    </tbody>
</table>
<script type="text/javascript">
    console.log()
    // var count = 60;
    var curCount=60;
    var duanxin="";
    var flag = 0;
    var sheng = '<option value="">请选择</option>'
    for(var i=0;i<json.provinces.length;i++){
        sheng += '<option value="'+json.provinces[i].name+'">'+json.provinces[i].name+'</option>'
    }
    $('#sheng').html(sheng);
    $('#sheng').change(function(){
        var prov = $(this).val();
        var citys = '<option value="">请选择</option>'
        for(var i=0;i<json.provinces.length;i++){
            if(json.provinces[i].name == prov){

                if(json.provinces[i].citys!=""&&json.provinces[i].citys!=undefined){
                    for(var j=0;j<json.provinces[i].citys.length;j++){
                        citys += '<option value="'+json.provinces[i].citys[j]+'">'+json.provinces[i].citys[j]+'</option>'
                    }
                }
                //
            }
        }
        $('#city').html(citys);
    })
    // curCount = count;
    function send(){
        $.ajax({
            url:'http://www.tongda3000.com:9090/umanage/renewal.php',
            data:{flag:2,phone:$('.iphone').val()},
            dataType:"jsonp",
            jsonp:"callback",
            type:'get',
            success:function(data){
                // console.log(data)
                if(data.flag==1){
                    $.layerMsg({content:'发送成功'})
                    duanxin = data.code;
                    $("#btnSendCode").text(curCount + "秒后重新发送");
                    $("#btnSendCode").removeAttr("onclick");
                    InterValObj = window.setInterval(SetRemainTime, 1000);
                }else{
                    $.layerMsg({content:'发送失败'})
                }
            }
        })
    }


    function SetRemainTime() {
        if (curCount == 1) {
            window.clearInterval(InterValObj);//停止计时器
            //$("#btnSendCode").removeAttr("disabled");//启用按钮
            $("#btnSendCode").attr("onclick","send();");
            $("#btnSendCode").text("免费获取");
            curCount=60
        }
        else {
            curCount--;
            $("#btnSendCode").text(curCount + "秒后重新发送");
        }
    }

    $.ajax({
        url:'/sys/getEachMouthDay',
        dataType:'json',
        type:'get',
        success:function(res){
            if(res.flag){
                $('.ri').html(res.object.dateUsers)
                $('.zhou').html(res.object.daysUsers)
                $('.month').html(res.object.monthUsers)
            }
        }
    })

    $.ajax({
        url:'/sys/getSysMessage',
        dataType:'json',
        type:'get',
        success:function(res){
            if(res.flag){
                var num = res.object.userInfo.split(' ')[0];
                $('.thisNum').html(num.substring(3));
                $('.userNum').html(res.object.oaUserLimit);
                // $('.company').val(res.object.authorizationUnit);
                $('.codenum').html(res.object.installDate);
                $('.endtime').html(res.object.endLecDateStr);
                $('.ma_code').html(res.object.authorizationCode);
                $('.edition').html(res.object.softVersion);
                if(res.object.isSoftAuth.indexOf('<fmt:message code="main.th.notRegistered" />')>=0){
                   flag = 1
                    $('#end').hide();
                }else if(res.object.show !=undefined && data.object.show == '<fmt:message code="sysInfo.th.showRenewal" />'){
                    flag = 0;

                }else if(res.object.isSoftAuth.indexOf('<fmt:message code="main.th.notRegistered" />')<=0){
                    $('#end').show();
                }

            }
        }
    })
    $('#up').click(function(){
        if($('.company').val()==""){
            $.layerMsg({content:'请填写续期单位名称'});
            return false;
        }
        if($('#sheng').val()==""&&$('#city').val()==""){
            $.layerMsg({content:'请填写所在省市'});
            return false;
        }
        if($('.connname').val()==""){
            $.layerMsg({content:'请填写联系人姓名'});
            return false;
        }
        if($('.iphone').val()==""){
            $.layerMsg({content:'请填写手机号'});
            return false;
        }
        if($('.duanxin').val()==""){
            $.layerMsg({content:'请填写手机验证码'});
            return false;
        }
        // if($('.duanxin').val()!=duanxin&&duanxin == ""){
        //     $.layerMsg({content:'手机验证码不正确'});
        //     return false;
        // }
        $.ajax({
            url:'http://www.tongda3000.com:9090/umanage/renewal.php',
            type:'get',
            data:{
                flag:1,
                COMPANY_NAME:$('.company').val(),//单位名称
                CITY:$('#sheng').val()+'|'+$('#city').val(),//所在省市
                LINKMAN:$('.connname').val(),//联系人姓名
                PHONE:$('.iphone').val(),//手机号
                VERSION:$('.edition').html(),//版本号
                MACHINE_CODE:$('.ma_code').html(),//机器码
                INSTALL_TIME:$('.codenum').html(),//安装时间
                EXPIRED_TIME:$('.endtime').html(),//到期时间
                USER_LIMIT:$('.userNum').html(),//授权用户数
                USER_COUNT:$('.thisNum').html(),//当前用户数
                MAU:$('.month').html(),//月活
                MPV:$('.zhou').html(),//本月登录数
                DAU:$('.ri').html(),//日活
                Interface :window.location.protocol+'//'+window.location.host,
                FUTYPE:flag
            },
            dataType:"jsonp",
            jsonp:"callback",
            success:function(data){
                if(data.flag == 1){
                    var fileString = data.fileString;
                    $.get('/sys/importLec',{fileString:fileString},function(res){
                        if(res.flag){
                            $.layerMsg({content:'提交成功',time:2000},function(){
                                window.history.go(-1)
                            })
                        }
                    },'json')


                }else{
                    $.layerMsg({content:'提交失败'})
                }
            }
        })

    })
    $('#back').click(function(){
        window.history.go(-1)
    })

</script>
</body>
</html>
