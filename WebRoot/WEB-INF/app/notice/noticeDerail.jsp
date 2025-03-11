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
    <%--公告详情--%>
    <title><fmt:message code="notice.th.queryDetail"/></title>
    <link rel="stylesheet" type="text/css" href="/lib/layui/layui/css/layui.css?20210319.1"/>
    <script src="../js/xoajq/xoajq1.js" type="text/javascript" charset="utf-8"></script>
    <script src="../js/base/base.js?20190529.3" type="text/javascript" charset="utf-8"></script>
    <script src="../js/webOffice/fileShow.js?20210423.1" type="text/javascript" charset="utf-8"></script>
    <script src="../js/attachment/attachView.js?20210406.1" type="text/javascript" charset="utf-8"></script>
    <script src="/lib/jQuery-File-Upload-master/jquery-ui.js" type="text/javascript" charset="utf-8"></script>
    <script src="/lib/jQuery-File-Upload-master/jquery.iframe-transport.js" type="text/javascript" charset="utf-8"></script>
    <script src="/lib/jQuery-File-Upload-master/jquery.fileupload.js" type="text/javascript" charset="utf-8"></script>
<%--    <script type="text/javascript" src="/js/common/fileupload.js?2019"></script>--%>
    <script src="/js/jquery/jquery.form.min.js"></script>
    <script type="text/javascript" src="../js/email/fileuploadPlus.js?20230529.2"></script>
    <style type="text/css">

        table{
            border-collapse: collapse;
            display: table;
        }
        body {
            padding: 0;
            margin: 0;
            font-family: Microsoft yahei,Helvetica Neue,Helvetica,PingFang SC,Tahoma,Arial,sans-serif;
            width: 100%;
        }

        /* .detailsContent{width: 100%;overflow: hidden;background-color: #f6f7f9;} */
        .detailsContent {
            width: 100%;
            overflow: hidden;
        }

        .detailsContent .title {
            width: 90%;
            margin: 0 auto;
            text-align: center;
            height: 60px;
            line-height: 60px;
            color: #2a588c;
            font-size: 25px;
            font-weight: bold;
            overflow: hidden;
            text-overflow: ellipsis;
            white-space: nowrap;
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
        .infor {
            width: 100%;
            overflow: hidden;
            height: 40px;
            background-color: #d3e7fa;
        }

        .infor ul {
            list-style: none;
            overflow: hidden;
            float: right;
            margin-top: 10px;
        }

        .infor ul li {
            float: left;
            margin-right: 20px;
            font-size: 14px;
        }

        .infor ul li span {
            font-size: 14px;
        }

        .divContent {
            width: 100%;
        }

        .divContent .divTxt {
            margin: 20px 40px;
        }

        .divContent .divTxt p {
            font-size: 14px;
            color: #444;
            line-height: 25px;
            text-align: justify;
        }

        .divContent .keyWord {
            margin: 0 0 10px 50px;
        }

        .divContent .keyWord span {
            margin-right: 10px;
            color: #2b7fe0;
        }

        .btnImg {
            width: 100%;
        }

        .btnImg .margin {
            width: 370px;
            margin: 20px auto;
        }

        .btnImg .margin a {
            margin-right: 20px;
        }

        .spanbreak {
            width: 60px;
            overflow: hidden;
            text-overflow: ellipsis;
            white-space: nowrap;
            display: inline-block;
        }
        .divContent1 .font_{
            margin-top: 6px;
            overflow:hidden;
        }
        .divContent1 .file_a{
            position: relative;
            text-decoration: none;
            /*color: #00a0e9;*/
            cursor: pointer;
        }
        .divContent1 .download_a{
            margin-left: 25px;
            color: #0A5FA2;
        }
        .attachTxt{
            margin-top: 5px;
        }
        .divTxt p{
            word-wrap: break-word;
        }
        .conText{
            width: 60%;
            margin:10px 0px 10px 10px;
            outline:none;
            font-size:16px;
        }
        #submit{
            display:none;
        }
        /*table tr {*/
        /*    border: 1px solid #c0c0c0;*/
        /*}*/
        /*table td {*/
        /*    border: 1px solid #c0c0c0;*/
        /*}*/
        /*table  tr:nth-child(odd) {*/
        /*    background-color: #F6F7F9;*/
        /*}*/
        /*table  tr:nth-child(odd) {*/
        /*    background-color: #F6F7F9;*/
        /*}*/
        .hoverbox {
            position: absolute;
            background: #fff;
            right: -45px;
            width: 60px;
            z-index: 1001;
            top: 0;
            height: auto;
            padding: 2px 0;
            margin: 2px 0 0;
            list-style: none;
            background-color: #ffffff;
            border: 1px solid #ccc;
            border: 1px solid rgba(0,0,0,0.2);
            border-right-width: 2px;
            border-bottom-width: 2px;
            -webkit-border-radius: 6px;
            -moz-border-radius: 6px;
            border-radius: 6px;
            -webkit-box-shadow: 0 5px 10px rgba(0,0,0,0.2);
            -moz-box-shadow: 0 5px 10px rgba(0,0,0,0.2);
            box-shadow: 0 5px 10px rgba(0,0,0,0.2);
            -webkit-background-clip: padding-box;
            -moz-background-clip: padding;
            background-clip: padding-box;
            display: none;
        }
        .hoverbox li {
            font-size: 9pt;
            cursor: pointer;
            color: #333333;
            padding: 0 5px;
        }
        .hoverbox li:hover{
            background-color: #0081c2;
            color: #fff;
        }
        .divContent1 .attachTxt{
            font-size: 14pt;
        }
        .bar {
            height: 18px;
            background: green;
        }

    </style>
    <script type="text/javascript">
        var asyncFlag = true;
        if(location.href.indexOf('&printqt=yes&printBtn=1') > -1){
            asyncFlag = false;
        }
        var titles = '';
        var isTransfer = '';

        $(function () {

            //判断是否有转存权限
            $.get('/checkPriv',{'funcId':16},function(res){
               if(res.flag){
                  isTransfer = res.object;
               }
            });

            fileuploadFn('#fileupload',$('#fileAll'));
            $(document).on('click','.deImgs',function(){
                var data=$(this).parents('.dech').attr('deUrl');
                var dome=$(this).parents('.dech');
                layer.confirm('<fmt:message code="global.lang.sure" />', {
                    btn: ['<fmt:message code="main.th.confirm" />','<fmt:message code="license.cancel" />'], //按钮
                    title:'<fmt:message code="global.lang.sure" />'
                }, function() {
                    //确定删除，调接口
                    $.ajax({
                        type: 'get',
                        url: '/delete',
                        dataType: 'json',
                        data: data,
                        success: function (res) {
                            if (res.flag) {
                                layer.msg('<fmt:message code="license.delsucess" />', {icon: 6,time :3000});
                                dome.remove();
                            } else {
                                layer.msg('<fmt:message code="license.deleSucess" />', {icon: 6,time :3000});
                            }
                        }
                    })
                })
            });
            var nid = $.getQueryString('notifyId');
            var changId = $.GetRequest().changId || ''
            $.ajax({
                type: 'get',
                url: 'getOneById',
                dataType: 'json',
                data: {
                    'notifyId': nid,
                    'permissionId': 1,
                        changId:changId
                },
                async: asyncFlag,
                success: function (rsp) {
                    var data1 = rsp.object;
                    var str = '';
                    var toTypeName = "";
                    if(rsp.obj1 != undefined){
                        if(rsp.obj1 != undefined && rsp.obj1.returnComments != undefined){
                            $("#returnComments").val(rsp.obj1.returnComments)
                        }
                        if (rsp.obj1.returnComments != ""&&rsp.obj1.returnComments != undefined) {
                            $("#form1").show()
                        }
                    }

                    if (rsp.object.toId != "") {
                        toTypeName += rsp.object.deprange;
                    }
                    if (rsp.object.privId != "") {
                        toTypeName += "<fmt:message code="userManagement.th.role" />,";
                    }
                    if (rsp.object.userId != "") {
                        toTypeName += rsp.object.userrange;
                    }
                    if(rsp.object.isOpin == 1 && rsp.object.opinionFields!=''&&rsp.object.opinionFields!=undefined){
                        var arr = rsp.object.opinionFields.split('-');
                        var strs = '<span style="font-weight: bold;width: calc(100% - 75px); margin: 0 auto ;line-height:40px;padding-left:7px;display: block;background-color: #F0F0F0;">回执信息：</span>';
                        strs += '<table class="huizhi" style="    width: calc(100% - 74px);\n'+
                            '    margin: 10px auto;">'
                        for(var i=0;i<arr.length;i++){
                            strs += '<tr ><td style="margin-left: 30px;text-align: center;" >'+arr[i]+':</td><td><input type="text" class="conText" id="'+(i+1)+'" placeholder="请输入反馈" name = "field'+(i+1)+'"></td></tr>';
                        }
                        strs += '</table>'
                        $('#outer').before(strs);
                        }

                    if(rsp.object.isOpin == 1 && rsp.object.opinionFields != ''){
                    if(rsp.obj1!=null&&rsp.obj1!=undefined){

                          if(rsp.obj1.field1!=''&&rsp.obj1.field1!=undefined){
                              $('.conText').eq(0).val(rsp.obj1.field1)
                          }
                          if(rsp.obj1.field2!=''&&rsp.obj1.field2!=undefined){
                              $('.conText').eq(1).val(rsp.obj1.field2)
                          }
                          if(rsp.obj1.field3!=''&&rsp.obj1.field3!=undefined){
                              $('.conText').eq(2).val(rsp.obj1.field3)
                          }
                          if(rsp.obj1.field4!=''&&rsp.obj1.field4!=undefined){
                              $('.conText').eq(3).val(rsp.obj1.field4)
                          }
                          if(rsp.obj1.field5!=''&&rsp.obj1.field5!=undefined){
                              $('.conText').eq(4).val(rsp.obj1.field5)
                          }
                        if(rsp.obj1.field6!=''&&rsp.obj1.field6!=undefined){
                            $('.conText').eq(5).val(rsp.obj1.field6)
                        }
                        if(rsp.obj1.field7!=''&&rsp.obj1.field7!=undefined){
                            $('.conText').eq(6).val(rsp.obj1.field7)
                        }
                        if(rsp.obj1.field8!=''&&rsp.obj1.field8!=undefined){
                            $('.conText').eq(7).val(rsp.obj1.field8)
                        }
                        if(rsp.obj1.field9!=''&&rsp.obj1.field9!=undefined){
                            $('.conText').eq(8).val(rsp.obj1.field9)
                        }
                        if(rsp.obj1.field10!=''&&rsp.obj1.field10!=undefined){
                            $('.conText').eq(9).val(rsp.obj1.field10)
                        }
                        $('table tr:nth-child(odd)').find('.conText').css('background','#F6F7F9')
                        var data1 = rsp.obj1.attachmentList;
                        var str3 = '';
                        for (var i = 0; i < data1.length; i++) {
                            str3+='<div class="dech" deUrl="'+encodeURI(data1[i].attUrl)+'" style="display:block;"><a class="ATTACH_a" NAME="'+data1[i].attachName+'*" href="/download?'+encodeURI(data1[i].attUrl)+'">'+data1[i].attachName+'</a><img class="deImgs" style="margin-left:5px;cursor: pointer;" src="../img/file/icon_deletecha_03.png"/><input type="hidden" NAME="'+data1[i].attachName+'*"  class="inHidden" value="'+data1[i].aid+'@'+data1[i].ym+'_'+data1[i].attachId+',"></div>';
                        }
                        $('#fileAll').append(str3);
                        var tfoot = '<tr><td style="text-align:center"><fmt:message code="main.th.AttachmentFile" />：</td><td style="padding-left:3px" class="fileAll"></td></tr>';
                        $('.huizhi').append(tfoot)
                        $('.fileAll').append($('#fileAll'))
                        $('#fileAll').css('margin','0px')


                        if(rsp.obj1.state!=1){
                            $('.deImgs').hide()
                        }

                        if(rsp.obj1.state==1){
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
                    }else{
                        $('#form').hide()
                    }

                    /*if(rsp.object.isOpin == 1 && rsp.object.opinionFields != ''){
                        $('#form').show()
                        $('#submit').show()
                    }else{
                        $('#form').hide()
                        $('#submit').hide();

                    }*/
                    str =function () {
                            if(rsp.object.draftDeptName){
                                return '<li><span><fmt:message code="notice.th.draftingDepartment" />：</span><span>'+rsp.object.draftDeptName+'<span></li>'
                            }else{
                                return ''
                            }
                        }()+
                        '<li><span><fmt:message code="notice.th.publishdepartment" />：</span><span style="padding-right:20px">'+rsp.object.depName+'</span><span><fmt:message code="notice.th.publisher" />：</span><span>' + rsp.object.name + '</span></li><li>' +
                        '<span>'+
                    function () {
                        if(data1.auditer != ''){
                            return '<fmt:message code="dem.th.AuditTime" />：'
                        }else {
                            return '<fmt:message code="notice.th.PostedTime" /> : '
                        }
                }()
                +'</span><span>'+function () {
                    if(rsp.object.auditer != ''){
                        return rsp.object.auditDate;
                    }else{
                        return rsp.object.notifyDateTime;
                    }
                }()
                +  '</span><span style="padding-left:20px" class="approver"><fmt:message code="hr.th.Approver" />：</span><span class="approver">'+rsp.object.auditerName+'</span></li>';
                    $('ul').append(str);
                    $('.divTxt').append('<p>' + rsp.object.content + '</p>');
                    var _w = parseInt($(window).width());//获取浏览器的宽度
                    $(".divTxt p img").each(function(i){
                        var img = $(this);
                        var realWidth;//真实的宽度
                        var realHeight;//真实的高度
                        //这里做下说明，$("<img/>")这里是创建一个临时的img标签，类似js创建一个new Image()对象！
                        $("<img/>").attr("src", $(img).attr("src")).load(function() {
                            realWidth = this.width;
                            realHeight = this.height;
                            // //如果真实的宽度大于浏览器的宽度就按照100%显示
                            if(realWidth>=_w){
                                $(img).css("width","100%").css("height","auto");
                            }
                            else{//如果小于浏览器的宽度按照原尺寸显示
                                $(img).css("width",realWidth+'px').css("height",realHeight+'px');
                            }
                        });
                    });



                    $('.imgfileBox').css("margin-left","25px")
                    $('.imgfileBox').append('<ul class="hoverbox"><li class="hoverboxLiConsult"><span class="plotting">></span><fmt:message code="document.th.ReferTo" /></li><li class="hoverboxLiDownload"><span class="plotting">></span><fmt:message code="file.th.download" /></li></ul>')
                    $('.imgfileBox').mouseover(function () {
                        $(this).children('.hoverbox').show()
                    });
                    $('.imgfileBox').mouseout(function () {
                        $(this).children('.hoverbox').hide()
                    });
                    $('.imgfileBox').on('click','.hoverboxLiDownload',function(){
                        var atturl=$(this).parents('.imgfileBox').find('img').attr('atturl')
                        if(atturl==''|| atturl==undefined) {
                            window.open("/download?"+encodeURI($(this).parents('.imgfileBox').find('img').attr('src')));
                        }else{
                            window.location.href="/download?"+encodeURI(atturl);
                        }
                    })
                    $('.imgfileBox').on('click','.hoverboxLiConsult',function(){
                        var str = $(this).parents('.imgfileBox').find('img').attr('atturl');
                        var fileURl=$(this).parents('.imgfileBox').find('span').attr('title')
                        var fileExtension=fileURl.substring(fileURl.lastIndexOf(".")+1,fileURl.length);//截取附件文件后缀
                        pdurl(fileExtension,str);
                    });
                    var str1 = "";
                    var arr = new Array();
                    arr = rsp.object.attachment;

                    var widthDom = document.body.clientWidth;
                    var divp = $( "p" );
                    for(var i=0;i<divp.length;i++){
                        if(widthDom<parseInt($(divp[i]).css('text-indent'))){
                            $(divp[i]).css('text-indent','0')
                        }
                    }

                    if (rsp.object.attachmentName != '') {
                        $.ajax({
                            type: 'get',
                            url: '/ShowDownLoadQrCode',
                            dataType: 'json',
                            data: {
                            },
                            success: function (res) {

                                if(res.object == 0){
                                    titles='<fmt:message code="main.th.AttachmentFile" />'
                                }else{
                                    titles='<fmt:message code="document.th.officialDocumentText" />'
                                }

                                attachView(arr,$('.divContent1'),'2','0',rsp.object.download,'0')
                                $('.divContent1 .attachTxt').html(''+titles+'&nbsp;&nbsp;')
                                //判断转存按钮的显示隐藏
                                if(isTransfer == true){
                                    $('.saveto').show()
                                }else{
                                    $('.saveto').hide()
                                }

                                // //中电建要求--遍历附件，因excel文件的预览功能暂未开发，判断如果是excel文件，暂时隐藏对应的预览按钮
                                // $('.font_').each(function () {
                                //     var fileArr=$(this).find('.file_a span').eq(0).text().split('.')
                                //     if(fileArr[fileArr.length-1]=='xlsx' && $(this).find('.operation').text().indexOf('预览') > -1){
                                //         $(this).find('.operation').eq(0).hide()
                                //     }
                                // })
                            }
                        })

//                        attachmentShow(arr,rsp.object.download,$('.divContent1'))
//                         attachView(arr,$('.divContent1'),'2','0',rsp.object.download,'0')
//                         $('.divContent1 .attachTxt').html(''+titles+'&nbsp;&nbsp;')

                    }
                    if(data1.auditerName==''||null){
                        $('.approver').remove();
                    }
                    $('.title').html('<span id="subject">'+rsp.object.subject+'</span>');
                    if(data1.contentSecrecy.indexOf("PUBLIC_SECRECY")!=-1){
                        contentSecrecy='【公开】'
                    }else if(data1.contentSecrecy.indexOf("INSIDE_SECRECY")!=-1){
                        contentSecrecy='【内部】'
                    }else if(data1.contentSecrecy.indexOf("SECRET_SECRECY")!=-1){
                        contentSecrecy='【秘密】'
                    }else if(data1.contentSecrecy.indexOf("CONFIDENTIAL_SECRECY")!=-1){
                        contentSecrecy='【机密】'
                    }
                    $.ajax({
                        type:'get',
                        url:'/syspara/selectTheSysPara?paraName=IS_SHOW_SECRET',
                        dataType:'json',
                        success:function (res) {
                            if(res.object.length!=0){
                                var data=res.object[0]
                                if (data.paraValue!=0){
                                    $('#subject').after('<span style="color: red">'+contentSecrecy+'</span>')

                                }
                            }
                        }
                    })
                }
            });

            $(document).on('click','.operationImg',function () {
                var thisa = $(this).next().attr('openimg')
                var openNmu = $(this).next().attr('openNmu')
                var str3 = '<input type="text" id="getIndex" openNum = "'+openNmu+'" style="display: none">'
                $('.divContent').append(str3)
                $('#getIndex').val(thisa)
                console.log(openNmu)
                window.open("/email/imgOpen?openNmu="+openNmu,"_blank");
                // layer.open({
                //     title:'图片',
                //     type: 2,
                //     shadeClose: true,
                //     shade: 0.5,
                //     maxmin: true, //开启最大化最小化按钮
                //     area: ['100%', '100%'],
                //     content: '/email/imgOpen',
                //     success: function () {
                //
                //     }
                // });
            })

//            点击预览
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
            $('.divContent1').on('click','.readPic',function () {
                var attrUrl=$(this).attr('attrurl');
                $.popWindow("/xs?"+attrUrl,PreviewPage,'0','0','1500px','800px');
            })
            //            点击提交
            $('#submit').click(function(){
                if($('.barText').html() != '' && $('.barText').html()!="100%"){
                    layer.msg('<fmt:message code="email.th.attachmentUploaded" />！',{icon:2});
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
                    data : {'notyId': nid},
                    dataType: 'json',
                    success: function (json) {
                        if (json.flag) {
                            $.layerMsg({content: '<fmt:message code="event.th.SubmitSuccessfully" />', icon: 1,time :3000},function () {
                                location.reload()
                            });
                        } else {
                            $.layerMsg({content: '<fmt:message code="office.Submission.failed" />', icon: 2,time :3000});
                        }

                    }
                })
            })
            $.ajax({
                type:'get',
                url:'/syspara/selectTheSysPara?paraName=IS_SHOW_JMJ',
                dataType:'json',
                success:function (res) {
                    if(res.object.length!=0){
                        var data=res.object[0]
                        if (data.paraValue!=0){
                            $('.title').before('<p style="color: red;font-family: Microsoft YaHei;font-weight: bolder;font-size: 16pt;margin-left: 20px;margin-top: 10px;"> 机密级★ </p>')
                        }
                    }
                }
            })
        });
    </script>
</head>
<body id="print">
<br class="detailsContent"  style="margin-bottom: 40px">
    <div class="title" style="text-align:center;font-weight: bold;margin-bottom: 20px;font-size: 25px;"></div>
    <div class="infor">
        <ul style="word-spacing:0px">

        </ul>
    </div>
    <div class="divContent">
        <div class="divTxt">
        </div>
        <div class="divContent1" style="border-top:1px solid #dedede; padding-top:10px;margin: 20px 40px;font-size: 11pt;">

        </div>
    </div>


        <form action="/notice/addOpinion" id="form" style="overflow:hidden">
            <table style="overflow:hidden" id="outer">
            </table>
            <div>
                <div id="fileAll" class="files" style=" margin:30px 0px 40px 40px">


                </div>
                <span class="fjTitle" style="float:left ;margin: 0px 0px 40px 40px"><fmt:message code="global.th.fileup" />：</span>

                <a href="javascript:;" class="openFile" style="float: left;position: relative;">
                    <img src="../img/mg11.png" alt="">
                    <span><fmt:message code="email.th.addfile"/></span>
                    <input type="file" multiple id="fileupload" data-url="../upload?module=notify" name="file">
                </a>
                <div id="progress" style="width: 200px;float: left;margin-left: 10px;margin-top: 2px;">
                    <div class="bar" style="width: 0%;"></div>
                </div>
                <div class="barText" style="float: left;margin-left: 10px;"></div>
            </div>
            <input type="hidden" name="attachmentId">
            <input type="hidden" name="attachmentName">
            <div><button type="button" id="submit" class="layui-btn"><fmt:message code="diary.th.remand" /></button></div>
        </form>
        <form id="form1" style="display: none">
            <span style="font-weight: bold;width: calc(100% - 75px); margin: 0 auto ;line-height:40px;padding-left:7px;display: block;background-color: #F0F0F0;"><fmt:message code="notice.th.fallbackOpinion" />：</span>
            <div class="layui-input-inline">
                <textarea style="width:1000px;margin-left: 33px;height: 100px;margin-top:10px" disabled="disabled" id="returnComments" class="layui-textarea"  name="returnComments"></textarea>
                </div>
        </form>

    </div>
    <div style="text-align: center">
        <button type="button" class="layui-btn layui-btn-normal print" style="margin-top: 150px;"><fmt:message code="global.lang.print" /></button>
        <button type="button" class="layui-btn layui-btn-normal close" style=" margin-top: 150px;"><fmt:message code="global.lang.close" /></button>
    </div>
</div>
<script>
    if(location.href.indexOf('&printqt=yes&printBtn=1') > -1){
        $(".print").parent().hide();
    }
    // 获取地址栏参数值
    function getQueryString(name) {
        var reg = new RegExp("(^|&)" + name + "=([^&]*)(&|$)");
        var r = window.location.search.substr(1).match(reg);
        if (r != null) return unescape(r[2]);
        return null;
    }
    //内部分发过来公共附件的查阅功能
    $(document).delegate('.fileDownload','click',function () {
        var url=$(this).attr('data-url');
        pdurl($.UrlGetRequest('?'+url),url);
    });
    //内部分发过来公共附件的下载功能
    function clickDownload(e) {
        e.removeAttr('href');
        var url = e.attr('url');
        var file = url.split('ATTACHMENT_NAME=')[1]

        if(file.indexOf('&')>=0){
            file = file.split('&')[1]
            var attUrl = url.split('ATTACHMENT_NAME=')[0]+'ATTACHMENT_NAME=&'+file;
        }else{
            file = ''
            var attUrl = url.split('ATTACHMENT_NAME=')[0]+'ATTACHMENT_NAME=';
        }

        window.open(attUrl);
    };
    //判断是否开启三员管理，如果开启则隐藏打印功能
    $.ajax({
        url:"/syspara/selectTheSysPara?paraName=IS_OPEN_SANYUAN",
        success:function(res) {
            var data = res.object[0];
            if(data.paraValue == 0) {
               $(".print").hide();
            }
        }
    })
    $(".print").click(function(){
        $(".print").parent().hide();
        window.print();
        $(".print").parent().show();
        var userAgent = navigator.userAgent; //取得浏览器的userAgent字符串,判断是否是pc客户端打开的qt浏览器，因为无法打印做一个兼容处理
        if(userAgent.indexOf('QtWebEngine') > -1&&myBrowser() == 'Chrome'){
            var url = window.location.href;
            url += '&printqt=yes&printBtn=1';
            window.open(url);
        }
    });
    $('.close').click(function () {
        if(getQueryString("noticeType") != '1'){
            window.close()
            parent.layer.closeAll();
        }else{
            var index = parent.layer.getFrameIndex(window.name);
            parent.layer.close(index);
        }
    })
</script>
</body>
</html>

