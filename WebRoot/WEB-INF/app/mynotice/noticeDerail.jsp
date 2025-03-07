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
    <script src="../js/webOffice/fileShow.js?20201231.1" type="text/javascript" charset="utf-8"></script>
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
        table tr {
            border: 1px solid #c0c0c0;
        }
        table td {
            border: 1px solid #c0c0c0;
        }
        table  tr:nth-child(odd) {
            background-color: #F6F7F9;
        }
        table  tr:nth-child(odd) {
            background-color: #F6F7F9;
        }
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
        var titles = '';
        var isTransfer = '';
        var specifyTable = $.GetRequest()['specifyTable'] || ''
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
            var nid = $.getQueryString('notifyId');
            var changId = $.GetRequest().changId || ''
            $.ajax({
                type: 'get',
                url: 'getOneById',
                dataType: 'json',
                data: {
                    'notifyId': nid,
                    'permissionId': 1,
                        changId:changId,
                    'specifyTable':specifyTable
                },
                success: function (rsp) {
                    var data1 = rsp.object;
                    var str = '';
                    var toTypeName = "";
                    if (rsp.object.toId != "") {
                        toTypeName += rsp.object.deprange;
                    }
                    if (rsp.object.privId != "") {
                        toTypeName += "角色,";
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
                        var tfoot = '<tr><td style="text-align:center">附件文件：</td><td style="padding-left:3px" class="fileAll"></td></tr>';
                        $('.huizhi').append(tfoot)
                        $('.fileAll').append($('#fileAll'))
                        $('#fileAll').css('margin','0px')


                        if(rsp.obj1.state!=1){
                            $('.deImgs').hide()
                        }

                        if(rsp.obj1.state==1){
                            $('#submit').show();
                            $('form').attr('action','/myNotice/updateOpin')
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
                    $('.title').text(rsp.object.subject);
                    str =function () {
                            if(rsp.object.draftDeptName){
                                return '<li><span>拟稿部门：</span><span>'+rsp.object.draftDeptName+'<span></li>'
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
                    $('.imgfileBox').css("margin-left","25px")
                    $('.imgfileBox').append('<ul class="hoverbox"><li class="hoverboxLiConsult"><span class="plotting">></span>查阅</li><li class="hoverboxLiDownload"><span class="plotting">></span>下载</li></ul>')
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
                                    titles='附件文件'
                                }else{
                                    titles='公文正文'
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
                    data : {'notyId': nid},
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


            <%--$('.divContent1').delegate(".file_a","click",function () {--%>
                <%--if($(this).attr("data-url")!=undefined){--%>
                    <%--$.popWindow($(this).attr("data-url"),'<fmt:message code="main.th.PreviewPage" />','0','0','1500px','800px');--%>
                <%--}--%>
            <%--});--%>
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


        <form action="/myNotice/addOpinion" id="form" style="overflow:hidden">
            <table style="overflow:hidden" id="outer">
            </table>
            <div>
                <div id="fileAll" class="files" style=" margin:30px 0px 40px 40px">


                </div>
                <span class="fjTitle" style="float:left ;margin: 0px 0px 40px 40px">附件上传：</span>

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
            <div style="text-align:center;"><button type="button" id="submit">提交</button></div>
        </form>

    </div>
    <div><button type="button" class="layui-btn layui-btn-normal print" style="margin-left: 600px; margin-top: 150px;">打印</button></div>
</div>
<script>


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
    $(".print").click(function(){
        $(".print").hide();
        window.print();
        $(".print").show();
    });

</script>
</body>
</html>

