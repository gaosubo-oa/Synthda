//附件上传 方法
var timer=null;
var flags
function fileuploadFn(formId,element,preWork) {
    // $('#uploadinputimg').fileupload({
    //判断是否开启了三员管理
    $.ajax({
        url:"/syspara/selectTheSysPara?paraName=IS_OPEN_SANYUAN",
        success:function(res) {
            var data = res.object[0];
            console.log(data.paraValue)
            if(data.paraValue == 0) {
                //    如果开启了三员管理，显示提示
                var dom = $('#fileTips')
                if($(".fileTips").length > 0){
                    $(".fileTips").replaceWith('<span class="fileTips" style="color: red">（'+sanyuan_th_prohibitUploadingHighSecurityFiles+'）</span>');
                }else{
                    $(dom).after('<span class="fileTips" style="color: red">（'+sanyuan_th_prohibitUploadingHighSecurityFiles+'）</span>');
                }
                flags=true
            }else{
                flags=false
            }
        }
    })
    var progressIN;
    $(formId).fileupload({
        dataType:'json',
        start: function (e) {
            var i = 0;
            progressIN = setInterval(function(){
                i = i + 1;
                $('#progress .bar').css(
                    'width',
                    i *10+ '%'
                );
                $('.barText').html(i * 10 + '%');
                if(i == 9){
                    clearInterval(progressIN);
                }
            }, 1500)

        },
        progressall: function (e, data) {
            var progress = parseInt(data.loaded / data.total * 95, 10);
            $('#progress .bar').css(
                'width',
                progress + '%'
            );
            $('.barText').html(progress + '%');

        },
        done: function (e, data) {
            var datas = data
            if(data.result.obj!=undefined){
                if(data.result.obj != ''){
                    var data = data.result.obj;
                    var str = '';
                    var str1 = '';
                    var preReda = ''
                    for (var i = 0; i < data.length; i++) {
                        var gs = data[i].attachName.split('.')[1];
                        if(gs == 'jsp'||gs == 'css'||gs == 'js'||gs == 'html'||gs == 'java'||gs == 'php'){ //后缀为这些的禁止上传
                            str += '';
                            layer.alert(email_th_uploadingFilesOfThisTypeIsProhibited+'!',{},function(){
                                layer.closeAll();
                            });
                        }else if(data[i].attachName.indexOf('+')!=-1){
                            alert(email_th_theFileNameIsIncorrect1+data[i].attachName+email_th_theFileNameIsIncorrect2);

                        }else{
                            var fileExtension=data[i].attachName.substring(data[i].attachName.lastIndexOf(".")+1,data[i].attachName.length);//截取附件文件后缀
                            var attName = encodeURI(data[i].attachName).replace(/\+/g, "%2b").replace(/\@/g,"%40").replace(/\#/g,"%23").replace(/\&/g,"%26").replace(/\//g,"%2F").replace(/\?/g,"%3F").replace(/\￥/g,"%ef%bf%a5").replace(/\$/g,"%24").replace(/\！/g,"%ef%bc%81").replace(/\（/g,"%ef%bc%88").replace(/\）/g,"%ef%bc%89").replace(/\…/g,"%e2%80%a6%e2%80%a6");
                            var fileExtensionName=attName.substring(0,attName.lastIndexOf("."));
                            var deUrl = data[i].attUrl.split('&ATTACHMENT_NAME=')[0]+"&ATTACHMENT_NAME="+fileExtensionName+"."+fileExtension+"&FILESIZE="+data[i].size;
                            if(preWork == 1){
                                preReda = '<a fileExtension="'+fileExtension+'" attrurl="'+deUrl+'" onclick="preview($(this),1)"  href="javascript:;"  style="padding-left: 5px"><img src="/img/attachmentIcon/icon_skim.png" style="padding: 0 5px;">'+yulan+'</a>'
                            }else if(preWork == 2){
                                preReda = '<a fileExtension="'+fileExtension+'" atturl="'+deUrl+'" onclick="preview($(this),1)"  href="javascript:;"  style="padding-left: 5px"><img src="/img/attachmentIcon/icon_skim.png" style="padding: 0 5px;">'+yulan+'</a>'
                            }
                            str += '<div class="dech" deUrl="' + deUrl+ '" aid="' + data[i].aid + '"  ym="' + data[i].ym + '" attachId="' + data[i].attachId + '" name="' + data[i].attachName + '" fileSize="' + data[i].fileSize + '">' +
                                '<a href="/download?'+encodeURI(deUrl)+'" NAME="' + data[i].attachName + '*" style="text-decoration:none;margin-left:5px;">' +
                                    '<img  src="/img/attachment_icon.png"/>' + data[i].attachName +
                                '</a>' +
                                '<a class="deImgs" href="javascript:;">' +
                                    '<img style="margin: 0 5px;cursor: pointer;" src="/img/file/icon_deletecha_03.png"/>' + workflow_common_delete +
                                '</a>' +
                                '<a class="chayue" fileExtension="'+fileExtension+'" onclick="pdurls($(this))"   href="javascript:;"  style="padding-left: 5px">' +
                                    '<img src="/img/attachmentIcon/icon_skim.png" style="padding: 0 5px;">' + email_th_refer_to +
                                '</a>'+preReda+
                                '<a style="padding-left: 5px" href="/download?'+encodeURI(deUrl)+'" >' +
                                    '<img src="/img/attachmentIcon/icon_down.png"  style="padding: 0 5px;">' + email_th_download +
                                '</a>' +
                                '<input type="hidden" class="inHidden" value="' + data[i].aid + '@' + data[i].ym + '_' + data[i].attachId + ',"></div>';
                        }
                    }
                    // $('.Attachment td').eq(1).append(str);

                    if(datas.result.msg == "OK"){
                        $('#progress .bar').css('width', 100 + '%');
                        $('.barText').html('100%');
                    }
                    element.append(str);

                    if($('#progress .bar').css('width')  == '100%' ||  $('.barText').html() != '' ){
                        timer=setTimeout(function () {
                            $('#progress .bar').css('width', 0 + '%');
                            $('.barText').html('');
                        },1000);
                    }

                }else{
                    layer.alert(attachments1+'!',{},function(){
                        layer.closeAll();
                    });
                }
            }else {
                if(data.result.datas != ''){
                    var data = data.result.datas;
                    var str = '';
                    var str1 = '';
                    for (var i = 0; i < data.length; i++) {
                        var gs = data[i].attachName.split('.')[1];
                        console.log(gs)
                        if(gs == 'jsp'||gs == 'css'||gs == 'js'||gs == 'html'||gs == 'java'||gs == 'php'||gs =='dll' ){ //后缀为这些的禁止上传
                            str += '';
                            layer.alert(email_th_uploadingFilesOfThisTypeIsProhibited+'!',{},function(){
                                layer.closeAll();
                            });
                        }else if(data[i].attachName.indexOf('+')!=-1){
                            alert(email_th_theFileNameIsIncorrect1+data[i].attachName+email_th_theFileNameIsIncorrect2);
                        }else{
                            var fileExtension=data[i].attachName.substring(data[i].attachName.lastIndexOf(".")+1,data[i].attachName.length);//截取附件文件后缀
                            var attName = encodeURI(data[i].attachName).replace(/\+/g, "%2b").replace(/\@/g,"%40").replace(/\#/g,"%23").replace(/\&/g,"%26").replace(/\//g,"%2F").replace(/\?/g,"%3F").replace(/\￥/g,"%ef%bf%a5").replace(/\$/g,"%24").replace(/\！/g,"%ef%bc%81").replace(/\（/g,"%ef%bc%88").replace(/\）/g,"%ef%bc%89").replace(/\…/g,"%e2%80%a6%e2%80%a6");
                            var fileExtensionName=attName.substring(0,attName.lastIndexOf("."));
                            var deUrl = data[i].attUrl.split('&ATTACHMENT_NAME=')[0]+"&ATTACHMENT_NAME="+fileExtensionName+"."+fileExtension+"&FILESIZE="+data[i].size;
                            str += '<div class="dech" deUrl="' + deUrl+ '"><a href="/download?'+encodeURI(deUrl)+'" NAME="' + data[i].attachName + '*" style="text-decoration:none;margin-left:5px;"><img src="/img/attachment_icon.png"/>' + data[i].attachName + '</a><a class="deImgs" href="javascript:;"><img style="margin-left:5px;cursor: pointer;margin-right: 5px;" src="/img/file/icon_deletecha_03.png"/>'+workflow_common_delete+'</a><a class="chayue" fileExtension="'+fileExtension+'" onclick="pdurls($(this))" href="javascript:;"  style="padding-left: 5px" deUrl="' + deUrl+ '"><img src="/img/attachmentIcon/icon_skim.png" style="padding: 0 5px;">'+email_th_refer_to+'</a><a style="padding-left: 5px" href="/download?'+encodeURI(deUrl)+'" ><img src="/img/attachmentIcon/icon_down.png"  style="padding: 0 5px;">'+email_th_download+'</a><input type="hidden" class="inHidden" value="' + data[i].aid + '@' + data[i].ym + '_' + data[i].attachId + ',"></div>';
                        }
                    }
                    // $('.Attachment td').eq(1).append(str);
                    // console.log(element)
                    element.append(str);
                }else{
                    layer.alert(attachments1+'!',{},function(){
                        layer.closeAll();
                    });
                }
            }

            if(flags){
                //    如果开启了三员管理，隐藏文件查阅
                $(".chayue").hide()
            }else{
                $(".chayue").show()
            }
        }
    });
}
function pdurls(_this){ //根据后缀判断选择调取那种打开方式
    var atturl=_this.parents('.dech').attr('deUrl')
    if(atturl != undefined&&atturl.indexOf('&ATTACHMENT_NAME=') > -1){
        var atturl1 = atturl.split('&ATTACHMENT_NAME=')[0] + '&ATTACHMENT_NAME=';
        var atturl2 = '';
        if(atturl.split('&ATTACHMENT_NAME=')[1] != undefined&&atturl.split('&ATTACHMENT_NAME=')[1].indexOf('&') > -1){
            for(var i=1;i<atturl.split('&ATTACHMENT_NAME=')[1].split('&').length;i++){
                atturl2 += '&' + atturl.split('&ATTACHMENT_NAME=')[1].split('&')[i];
            }
            atturl = atturl1 + atturl2;
        }else{
            atturl = atturl1;
        }
    }
    var gs=_this.attr('fileExtension')
    if(gs == 'png'||gs == 'jpg'||gs == 'bmp' || gs == 'emf' || gs == 'gif'|| gs == 'pcx'|| gs == 'pcd'|| gs == 'ai'|| gs == 'webp'|| gs == 'WMF'|| gs == 'dxf' ||gs == 'PNG'||gs == 'JPG'||gs == 'BMP' || gs == 'EMF' || gs == 'GIF'|| gs == 'PCX'|| gs == 'PCD'|| gs == 'AI'|| gs == 'WEBP'|| gs == 'wmf'|| gs == 'DXF'|| gs == 'txt'|| gs == 'TXT'){
        $.popWindow("/xs?"+atturl,PreviewPage,'0','0','1200px','600px');
    }else if(gs == 'mp4'||gs == 'rmvb'||gs == 'avi'||gs == 'ifo'||gs == 'wmv'||gs == 'MP4'||gs == 'RMVB'||gs == 'AVI'||gs == 'IFO'||gs == 'WMV'){
        layer.open({type: 2, title: false, area: ['630px', '360px'], shade: 0.8, closeBtn: 0, shadeClose: true, content: "/common/video?videoatturlsplit="+atturl});
        layer.msg(email_th_clickAnywhereToClose);
    }else if(gs == 'pdf'||gs == 'PDF'){
        $.popWindow("/pdfPreview?"+atturl,PreviewPage,'0','0','1200px','600px');
    }else if(gs == 'ofd'|| gs=='OFD'||gs == 'oFD'||gs == 'oFd'){
        $.popWindow("../../lib/ofdViewer/viewer.html?file="+'/download?'+atturl , PreviewPage, '0', '0', '1200px', '600px')
    }else{
        var url = "/common/webOfficeView?documentEditPriv=0&fomat="+gs+"&"+atturl;
        $.ajax({
            url:'/syspara/selectTheSysPara?paraName=OFFICE_EDIT',
            type:'post',
            datatype:'json',
            async:false,
            success: function (res) {
                if(res.flag){
                    if(res.object[0].paraValue == 0){
                        //默认加载NTKO插件 进行跳转
                        url = "/common/ntkoview?documentEditPriv=0&fomat="+gs+"&"+atturl;
                    }else if(res.object[0].paraValue == 2){
                        //默认加载NTKO插件 进行跳转
                        url = "/wps/info?"+ atturl +"&permission=read";
                    }else if(res.object[0].paraValue == 3){

                        //默认加载NTKO插件 进行跳转
                        url = "/common/onlyoffice?"+ atturl +"&edit=false";
                    }
                }

            }
        })
        $.popWindow(url,PreviewPage,'0','0','1200px','600px');
    }
}
