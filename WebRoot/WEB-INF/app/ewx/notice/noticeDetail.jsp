<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@taglib prefix="mvc" uri="http://www.springframework.org/tags/form" %>
<%@taglib prefix="fmt" uri="http://www.springframework.org/tags" %>
<%
    String notifyId = request.getParameter("notifyId");
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
%>

<!DOCTYPE html>
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width,initial-scale=1,minimum-scale=0,maximum-scale=5,user-scalable=yes" />
    <title>公告详情</title>
    <script type="text/javascript" src="/js/xoajq/xoajq3.js"></script>
    <script type="text/javascript" src="/js/jquery/jquery-migrate-3.4.0.js"></script>
    <script type="text/javascript" src="../../js/base/base.js"></script>
    <script type="text/javascript" src="../../js/ewx/waterMark.js?20190819.2"></script>
    <link href="../../css/H5/default.css" rel="stylesheet"/>
    <script src="/lib/jQuery-File-Upload-master/jquery-ui.js" type="text/javascript" charset="utf-8"></script>
    <script src="/lib/jQuery-File-Upload-master/jquery.iframe-transport.js" type="text/javascript" charset="utf-8"></script>
    <script src="/lib/jQuery-File-Upload-master/jquery.fileupload.js" type="text/javascript" charset="utf-8"></script>
    <%--    <script type="text/javascript" src="/js/common/fileupload.js?2019"></script>--%>
    <script src="/js/jquery/jquery.form.min.js"></script>
    <script type="text/javascript" src="../js/email/fileuploadPlus.js?20230529.2"></script>
    <script src="/lib/layui/layui/js/baseCode/base.js?v=201908121454" type="text/javascript" charset="utf-8"></script>
    <style>
        header {
            height: 0.85rem;
            display: flex;
            align-items: center;
            justify-content: space-between;
            font-size: 0.32rem;
            color: #fff;
            padding-left: 0.23rem;
            padding-right: 0.23rem;
            position: fixed;
            width: 100%;
            z-index: 9999;
            background-color: #3984ff;
            box-shadow: 1px 1px 7px rgba(0, 0, 0, .85);
        }
        .fs14{
            font-size: 0.33rem;
            color: #646464;
        }
        .cont{
            margin: 0 .4rem;
            margin-top: .32rem;
            overflow: hidden;
            text-overflow: ellipsis;
            white-space: nowrap;
        }
        .cons{
            margin: 0 .4rem;
            border-bottom: 1px solid #5a8fd5;
            color: #c6c6c6;
            font-size: .32rem;
            line-height: 1rem;
        }
        .conts{
            margin: 0 .4rem;
            margin-top: .32rem;
            padding-bottom:  .32rem;
            font-size: .34rem;
            /*overflow: hidden;*/
            word-break: break-word;
        }
        .enclosure{
            height: .7rem;
            background: #eeeeee;
            line-height: .7rem;
            text-indent: 1em;
        }
        .hd{
            height: 0.85rem;
        }
        table tr:nth-child(odd) {
            background-color: #F6F7F9;
        }
        table tr {
            border: 1px solid #c0c0c0;
        }
        table td {
            border: 1px solid #c0c0c0;
        }
        .conText {
            width: 60%;
            margin: 10px 0px 10px 10px;
            outline: none;
            font-size: 16px;
        }
        .openFile input[type=file] {
            position: absolute;
            top: 0;
            right: 0;
            bottom: 0;
            left: 0;
            width: 100%;
            height: 18px;
            z-index: 99;
            opacity: 0;
            filter: progid:DXImageTransform.Microsoft.Alpha(opacity=0);
        }
        #fileAll img{
            display: inline-block;
        }
        .layui-btn {
            display: inline-block;
            height: 34px;
            line-height: 34px;
            padding: 0 18px;
            background-color: #009688;
            color: #fff;
            white-space: nowrap;
            text-align: center;
            font-size: 14px;
            border: none;
            border-radius: 2px;
            cursor: pointer;
        }
        .conts p {
            font-size: 14px;
            text-indent: 2em;
        }
    </style>
</head>
<body>

<div class="content">

</div>
<%--<form action="/notice/addOpinion" id="form" style="overflow:hidden">--%>
<%--    <table style="overflow:hidden" id="outer">--%>
<%--    </table>--%>
<%--    <div>--%>
<%--        <div id="fileAll" class="files" style=" margin:15px 0px 25px 40px">--%>


<%--        </div>--%>
<%--        <span class="fjTitle" style="float:left ;margin: 0px 0px 0px 40px">附件上传：</span>--%>

<%--        <a href="javascript:;" class="openFile" style="float: left;position: relative;">--%>
<%--            <img src="../img/mg11.png" alt="" style="display: inline-block">--%>
<%--            <span><fmt:message code="email.th.addfile"/></span>--%>
<%--            <input type="file" multiple id="fileupload" data-url="../upload?module=notify" name="file">--%>
<%--        </a>--%>
<%--        <div id="progress" style="width: 200px;float: left;margin-left: 10px;margin-top: 2px;">--%>
<%--            <div class="bar" style="width: 0%;"></div>--%>
<%--        </div>--%>
<%--        <div class="barText" style="float: left;margin-left: 10px;"></div>--%>
<%--    </div>--%>
<%--    <input type="hidden" name="attachmentId">--%>
<%--    <input type="hidden" name="attachmentName">--%>
<%--    <div style="padding-top: 50px;text-align: center;"><button type="button" id="submit" class="layui-btn">提交</button></div>--%>
<%--</form>--%>
</body>
<script>
    var fs = document.documentElement.clientWidth / 750  * 100;
    //fs为计算出来的字体大小
    document.querySelector("html").style.fontSize = 50 + "px";
    var notifyId = <%=notifyId%>;
    var ua = navigator.userAgent.toLowerCase();
    //上传附件
    fileuploadFn('#fileupload',$('#fileAll'));
    //删除附件
    $(document).on('click','.deImgs',function(){
        var data=$(this).parents('.dech').attr('deUrl');
        var dome=$(this).parents('.dech');
        layer.confirm('确认删除吗', {
            btn: ['确认','取消'], //按钮
            title:'确认删除吗'
        }, function() {
            //确定删除，调接口
            $.ajax({
                type: 'get',
                url: '/delete',
                dataType: 'json',
                data: data,
                success: function (res) {
                    if (res.flag) {
                        layer.msg('删除成功', {icon: 6,time :3000});
                        dome.remove();
                    } else {
                        layer.msg('删除失败', {icon: 6,time :3000});
                    }
                }
            })
        })
    });
    //点击预览
    $('.divContent1').on('click','.yulan',function () {
        var attrUrl=$(this).attr('attrurl');
        var url = '/common/weboffice?'+attrUrl;
        $.ajax({
            url:'/syspara/selectTheSysPara?paraName=OFFICE_EDIT',
            type:'post',
            datatype:'json',
            async:false,
            success: function (res) {
                if(res.flag){
                    if(res.object[0].paraValue == 0){
                        //默认加载NTKO插件 进行跳转
                        url = '/common/ntko?'+attrUrl;
                    }else if(res.object[0].paraValue == 2){
                        //默认加载NTKO插件 进行跳转
                        url = "/wps/info?"+ atturl +"&permission=write";
                    }else if(res.object[0].paraValue == 3){
                        //默认加载onlyoffice插件 进行跳转
                        url = "/common/onlyoffice?"+ atturl +"&edit=false";
                    }
                }

            }
        })
        window.open(url);
    })
    $(function(){
        $.ajax({
            url:'/notice/getOneById',
            type:'get',
            data:{
                notifyId:notifyId
            },
            dataType:'json',
            success:function(res){
                var fileObj = {};
                fileObj.attachmentId = '';
                if(res.flag){
                    var app='<div>'+
                        '<h2 class="cont" style="width: 85%;">'+res.object.subject+'</h2>'+
                        '<div class="cont">'+
                        '<span class="fs14" style="margin-right:34px ;">发布人：'+res.object.name+'</span>'+
                        '<span class="fs14">类型：<a href="javascript:;" style="color: #5087d0">'+function(){if(res.object.typeName==''){return '所有类型'}else{return  res.object.typeName}}()+'</a></span>'+
                        '</div>'+
                        '<div class="cons">'+res.object.auditDate+'</div>'+
                        '</div>'+
                        '<div class="conts" style="line-height: .6rem">'+res.object.content+'</div>'+
                        '<p class="enclosure">附件</p>'+
                        '<div class="conts">'+
                        function(){
                            if(res.object.attachmentName==''){
                                return '暂无附件'
                            }else {
                                var arr = new Array();
                                arr = res.object.attachment
                                if (res.attachmentName != '') {
                                    var src=''
                                    for (var i = 0; i < (arr.length); i++) {
                                        fileObj.attachmentId = arr[i].aid + '@' + arr[i].ym + '_' + arr[i].attachId + ',';
                                        var name = arr[i].name.toLowerCase();
                                        src += '<p style="margin-bottom: 10px;"><a style="color: black;cursor: auto;"  href="javascript:;"><img style="display:inline-block;position: relative;top: 4px;right: 7px;" src="../img/enclosure.png"/><span style="width: 73%;display: inline-block;">' + arr[i].attachName + '</span></a>' +
                                            '<a style="color:#3984ff" href="'+ function(){
                                                //判断是否是安卓微信端-图片类型的附件
                                                if (ua.match(/MicroMessenger/i) == "micromessenger"
                                                    &&(/(Android)/i.test(navigator.userAgent))
                                                    &&(name.indexOf('.png') > -1||name.indexOf('.jpg') > -1)
                                                        ||name.indexOf('.jpeg') > -1||name.indexOf('.gif') > -1) {
                                                    return '/xs?' + encodeURI(arr[i].attUrl)
                                                }else{
                                                    return '/download?' + encodeURI(arr[i].attUrl)
                                                }
                                            }() +'" style="margin-left:10px;"><fmt:message code="file.th.download" /></a>'+
                                            '<a  onclick="lookFile(\'' + fileObj.attachmentId + '\')" style="color:#3984ff;cursor:pointer ;margin-left: 10px;">预览</a>'+
                                            '</p>';
                                    }
                                }
                                return src
                            }}()
                    '</div>'+
                    '</div>'
                    $('.content').html(app)
                    var widthDom = document.body.clientWidth;
                    var divp = $( "p" );
                    for(var i=0;i<divp.length;i++){
                        if(widthDom<parseInt($(divp[i]).css('text-indent'))){
                            $(divp[i]).css('text-indent','0')
                        }
                    }
                    if(res.object.isOpin == 1 && res.object.opinionFields!=''&&res.object.opinionFields!=undefined){
                        var arr = res.object.opinionFields.split('-');
                        var strs = '<p class="enclosure">回执信息：</p>';
                        strs += '<table class="huizhi" style="    width: calc(100% - 74px);margin: 10px auto;">'
                        for(var i=0;i<arr.length;i++){
                            strs += '<tr ><td style="margin-left: 30px;text-align: center;font-size: 15px;" >'+arr[i]+':</td><td><input type="text" class="conText" id="'+(i+1)+'" placeholder="请输入反馈" name = "field'+(i+1)+'"></td></tr>';
                        }
                        strs += '</table>'
                        $('#outer').before(strs);
                    }
                    if(res.obj1!=null && res.obj1!=undefined){

                        if(res.obj1.field1!=''&&res.obj1.field1!=undefined){
                            $('.conText').eq(0).val(res.obj1.field1)
                        }
                        if(res.obj1.field2!=''&&res.obj1.field2!=undefined){
                            $('.conText').eq(1).val(res.obj1.field2)
                        }
                        if(res.obj1.field3!=''&&res.obj1.field3!=undefined){
                            $('.conText').eq(2).val(res.obj1.field3)
                        }
                        if(res.obj1.field4!=''&&res.obj1.field4!=undefined){
                            $('.conText').eq(3).val(res.obj1.field4)
                        }
                        if(res.obj1.field5!=''&&res.obj1.field5!=undefined){
                            $('.conText').eq(4).val(res.obj1.field5)
                        }
                        if(res.obj1.field6!=''&&res.obj1.field6!=undefined){
                            $('.conText').eq(5).val(res.obj1.field6)
                        }
                        if(res.obj1.field7!=''&&res.obj1.field7!=undefined){
                            $('.conText').eq(6).val(res.obj1.field7)
                        }
                        if(res.obj1.field8!=''&&res.obj1.field8!=undefined){
                            $('.conText').eq(7).val(rsp.obj1.field8)
                        }
                        if(res.obj1.field9!=''&&res.obj1.field9!=undefined){
                            $('.conText').eq(8).val(res.obj1.field9)
                        }
                        if(res.obj1.field10!=''&&res.obj1.field10!=undefined){
                            $('.conText').eq(9).val(res.obj1.field10)
                        }
                        $('table tr:nth-child(odd)').find('.conText').css('background','#F6F7F9')
                        var data1 = res.obj1.attachmentList;
                        var str3 = '';
                        for (var i = 0; i < data1.length; i++) {
                            str3+='<div class="dech" deUrl="'+encodeURI(data1[i].attUrl)+'" style="display:block;"><a class="ATTACH_a" NAME="'+data1[i].attachName+'*" href="/download?'+encodeURI(data1[i].attUrl)+'">'+data1[i].attachName+'</a><img class="deImgs" style="margin-left:5px;cursor: pointer;" src="../img/file/icon_deletecha_03.png"/><input type="hidden" NAME="'+data1[i].attachName+'*"  class="inHidden" value="'+data1[i].aid+'@'+data1[i].ym+'_'+data1[i].attachId+',"></div>';
                        }
                        $('#fileAll').append(str3);
                        var tfoot = '<tr><td style="text-align:center;font-size: 15px">附件文件：</td><td style="padding-left:3px" class="fileAll"></td></tr>';
                        $('.huizhi').append(tfoot)
                        $('.fileAll').append($('#fileAll'))
                        $('#fileAll').css('margin','0px')


                        if(res.obj1.state!=1){
                            $('.deImgs').hide()
                        }

                        if(res.obj1.state==1){
                            $('#submit').show();
                            $('form').attr('action','/notice/updateOpin')
                            var txt1="<input type=text style='display:none;' value ="+rsp.obj1.opId+" name= opId>";
                            var txt2="<input type=text style='display:none;' value ="+rsp.obj1.state+" name= state>";
                            $("#outer").append(txt1,txt2);
                        }else{
                            $('#submit').hide();
                            $('.conText').attr('readonly','readonly')
                            $('.conText').css('border','aliceblue')
                            //添加隐藏文本框
                            $('.deImgs').hide();
                            $('.openFile').hide()
                            $('.fjTitle').hide()
                        }


                    }else{
                        $('#submit').show()
                        $('#form').show()
                    }
                }

            }
        })
    })
    //            点击提交
    $('#submit').on('click', function(){
        if($('.barText').html() != '' && $('.barText').html()!="100%"){
            layer.msg('附件还未上传完毕！',{icon:2});
            return false;
        }
        $('#submit').hide()
        var filearr=$('#fileAll .dech');
        var aId='';
        var uId='';
        for(var i=0;i<filearr.length;i++){
            aId+=$(filearr[i]).find('input').val();
            uId+=$(filearr[i]).find('a').attr('name');
        }
        $('[name="attachmentId"]').val(aId);
        $('[name="attachmentName"]').val(uId);

        $('#form').ajaxSubmit({
            type: 'post',
            data : {'notyId': notifyId},
            dataType: 'json',
            success: function (json) {
                if (json.flag) {
                    $.layerMsg({content: '提交成功', icon: 1,time :3000},function () {
                        location.reload()
                    });
                } else {
                    $.layerMsg({content: '提交失败', icon: 2,time :3000});
                }

            }
        })
    })
    function lookFile(repalogId){//查看附件
        if (repalogId == undefined || repalogId == "") {
            layer.msg("文件已被损坏，无法查看");
        } else {
            selectFile(repalogId,'notify');
        }
    }
</script>
</html>