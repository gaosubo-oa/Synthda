
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
    <title>发送短信</title>
    <link rel="stylesheet" href="/lib/pagination/style/pagination.css">
    <link rel="stylesheet" href="/css/base/base.css?20201106.1">
    <link rel="stylesheet" href="/css/notice/noticeManagement.css">
    <script src="/js/common/language.js"></script>
    <script type="text/javascript" src="/js/xoajq/xoajq1.js"></script>
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
    <style>
        table tbody td{
            text-align: left;
            padding: 10px;
            box-sizing: border-box;
        }
        table tbody td.color{
            padding:10px 10px 10px 50px;
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
            width: 229px;
            height: 34px;
            line-height: 34px;
            padding-left: 10px;
            outline: none;
            border-radius: 4px;
            vertical-align: middle;
            font-family:"Microsoft Yahei";
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
            padding-left: 10px;
            box-sizing: border-box;
            padding: 5px;
        }
        .btnsava{
            padding:5px 15px;
            border-radius: 4px;
            background: #2F8AE3;
            color: #fff;
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
            width: 650px;
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
        .navigation .left .news {
            /* font-size: 14px; */
            float:left;
            margin-left: 5px;
            font-family: Microsoft yahei,Helvetica Neue,Helvetica,PingFang SC,Tahoma,Arial,sans-serif;
            margin-top: -3px;
            margin-right: 40px;
            font-size: 22px;
            color: #333;
        }

        table tr.borderNone{
        border:none;
        }
        table tr.borderNone td{
            border: 1px solid #dddcdd;
            margin: 0 -1px -1px 0px;
        }
    </style>
    <%--<script src="/js/learningExperience/LearningExperienceQuery.js"></script>--%>
</head>
<body>
<div class="navigation  clearfix" style="font-size:40px;margin-bottom: 10px;">
    <div class="left">
        <img src="/img/commonTheme/${sessionScope.InterfaceModel}/wangguan.png" style="float:left;margin-top:20px;width: 25px;height: 25px;" alt="">
        <div class="news">发送短信</div>
    </div>
</div>


<%--<div class="navigation">--%>
<%--    &lt;%&ndash;<img src="/img/commonTheme/${sessionScope.InterfaceModel}/gonggaochaxun.png" alt="">&ndash;%&gt;--%>
<%--    &lt;%&ndash;<h2>学习经历信息查询</h2>&ndash;%&gt;--%>
<%--</div>--%>
<div class="query">
    <form id="uploadForm" method="post" action="/sms2/sendMessageByExcel" enctype="multipart/form-data" >
        <table style="width: 100%;border: none;">
            <tbody>
            <tr class="borderNone">
                <td width="40%" class="color">收信人[内部用户]：</td>
                <td width="70%">
                    <textarea   style="height: 60px;width: 300px;line-height: 17px;background-color: #dddcdd; " name=""  class="theControlData"  readonly id="userId" cols="30" rows="10"></textarea>
                    <a href="javascript:;"  class="addroles">添加</a>
                    <a href="javascript:;" class="cleardate">清空</a>
                    <input type="hidden" name="userId">
                </td>
            </tr>

            <tr class="borderNone">
                <td width="30%" class="color">收信人[外部用户]：</td>
                <td width="70%">
                    <div id="con" style="width:22%;float: left; font-size: 10px; margin-right: 20px;margin-top:7px;">未选择短信文件</div>
                    <div  style="width:55%;float: left;">
                        <a href="javascript:;" class="file">请选择文件
                            <input type="file" name="file" id="wj">
                        </a>
                        <a class="file" href="../file/sms/<fmt:message code="sms.th.SMSSendingTemplate" />.xls" style="color: #0088cc;font-size: 10pt;margin-left: 2px;">短信模板下载</a>
                    </div>
                </td>
            </tr>

            <tr class="borderNone">
                <td width="30%" class="color">短信内容：</td>
                <td width="70%">
                    <textarea style="height: 88px;width: 300px;line-height: 17px" name="contextString"  class="theControlData"  id="cont" cols="30" rows="10"></textarea>

                </td>
            </tr>

            <tr class="borderNone">
                <td colspan="3" style="text-align: center;padding: 15px">
                    <a href="javascript:;" class="btnsava send">发送</a>
                    <a href="javascript:;" style="margin-left: 10px" class="btnsava qian">签名</a>
                    <a href="javascript:;" style="margin-left: 10px" class="btnsava clear">清空内容</a>
                </td>
            </tr>
            </tbody>
        </table>
    </form>
</div>
<div id="pagediv" style="visibility:hidden;">

</div>
<script type="text/javascript">
    var user_id=null;
$('.clear').click(function () {
   $('#userId').val('');
   $('#cont').val('');

    window.location.reload()
})

    $(document).on('click','.cleardate',function () {
        $(this).siblings('textarea').val('');
        $(this).siblings('textarea').attr('user_id','');
        $(this).siblings('textarea').attr('deptid','');
        $(this).siblings('textarea').attr('deptname','');
        $(this).siblings('textarea').attr('privid','');
        $(this).siblings('textarea').attr('userpriv','');
        $(this).siblings('textarea').attr('username','');
        $(this).siblings('textarea').attr('dataid','');
        $(this).siblings('textarea').attr('userprivname','');
    })

$('.addroles').click(function () {
    user_id = $(this).siblings('textarea').prop('id');
    $.popWindow("../common/selectUser");
})


//限制文件类型
    $(document).on('change','#wj',function () {
        console.log($(this).val())
        if($(this).val() != '' && $(this).val() != undefined){
            var arr = $(this).val().split("\\");
            var ii = arr[arr.length-1].lastIndexOf(".");
            var brr=arr[arr.length-1].substring(ii+1,arr[arr.length-1].length);
        }
        if(brr == "xls" || brr == "xlsx"){
            $('#con').html(arr[arr.length-1])
        }else{
            layer.msg("请选择xls或xlsx类型的文件！")
            return false;
        }
    })
//发送
$('.send').click(function () {
    var mb = $("#wj").val();//选择了文件
    var contexts =$("#cont").val();//短信内容
    var inpeople =$('#userId').val();//内部收件人

    if (inpeople == '' && mb == '') {
        //内部和外部都没选的情况
        $.layerMsg({content: "请选择收件人！", icon: 2}, function () {
        });
        return;
    }else if($('#userId').val() != '' &&  contexts=='' ){
        //选择了内部收件人，但内部收件人短信内容为空时
        $.layerMsg({content: "内部收件人短信内容不能为空！", icon: 2}, function () {
        });
        return;
    }
    if(contexts !='' && $('#userId').val() == ''){
        //没选内部收件人，写了短信内容的情况下
        $.layerMsg({content: "请选择内部收件人！", icon: 2}, function () {
        });
        return;
    }

    if(mb !='' &&  inpeople == ''){
        //只选择外部收件人的情况下
        $('#uploadForm').ajaxSubmit({
            dataType: 'json',
            data:{
                privArray:$('#userId').attr('dataid'),
            },
            success:function (res) {
                if(res.flag) {
                    $.layerMsg({content:"发送成功！",icon: 1}, function(){
                        window.location.reload()
                    });
                }else{
                    $.layerMsg({content:"发送失败！",icon: 2}, function(){
                    });
                }
            }
        })

    }
    else if(mb =='' &&  (inpeople != '' || contexts !='')) {
        //只选择内部收件人的情况
        $.ajax({
            type:'get',
            url:'/sms2Priv/smsSenders',
            dataType:'json',
            data:{
                contextString:$('#cont').val(),
                privArray:$('#userId').attr('dataid') || '',
            },
            success:function(res){
                if(res.flag) {
                    $.layerMsg({content:"发送成功！",icon: 1}, function(){
                        $(".cleardate").click();
                        $(".clear").click();
                        window.location.reload()

                    });
                }else{
                    $.layerMsg({content:"发送失败！",icon: 2}, function(){

                    });
                }

            }
        })
    }
    else if(mb !='' &&  (inpeople != '' && contexts !='')){
        //内部外部都选择了
        if(mb !=''){
            //外部
            $('#uploadForm').ajaxSubmit({
                dataType: 'json',
                data:{
                    privArray:$('#userId').attr('dataid'),
                },
                success:function (res) {
                    if(res.flag) {
                        $.layerMsg({content:"外部收件人信息发送成功！",icon: 1}, function(){
                            window.location.reload()
                        });
                    }else{
                        $.layerMsg({content:"外部收件人信息发送失败！",icon: 2}, function(){
                        });
                    }
                }
            })
        }
       if(inpeople != '' && contexts !=''){
           //内部
           $.ajax({
               type:'get',
               url:'/sms2Priv/smsSenders',
               dataType:'json',
               data:{
                   contextString:$('#cont').val(),
                   privArray:$('#userId').attr('dataid') || '',
               },
               success:function(res){
                   if(res.flag) {
                       $.layerMsg({content:"内部收件人信息发送成功！",icon: 1}, function(){
                           $(".cleardate").click();
                           $(".clear").click();
                           window.location.reload()

                       });
                   }else{
                       $.layerMsg({content:"内部收件人信息发送失败！",icon: 2}, function(){

                       });
                   }

               }
           })
       }
    }

})

// //签名（原来的）
// $('.qian').click(function () {
//     $.ajax({
//         type:'get',
//         url:'/smsSettings/selectSmsSettings',
//         dataType:'json',
//         success:function(res){
//             if(res.flag) {
//                 var obj = res.obj;
//                 // var sign = obj[0].sign;
//                 var sign = obj[0].signValue; // 使用新字段
//                 $("#cont").val($("#cont").val() + sign)
//             }
//         }
//     })
// })


    //签名
    $('.qian').click(function () {

        $.ajax({
            type:'post',
            url:'/users/getUserTheme',
            dataType:'json',
            success:function(res){
                if(res.flag) {
                    var obj = res.object;
                    var userName = obj.userName;
                    var userPrivName = obj.userPrivName;
                    var str = userName +'('+userPrivName+')'
                    if($("#cont").val() != ''){
                        var abc = $("#cont").val().replace(str,'');
                    }else{
                        var abc = '';
                    }
                    $("#cont").val(abc +userName +'('+userPrivName+')')
                }
            }
        })
    })

</script>
</body>
</html>