//附件上传 方法
var timer = null;
var gs,flags;
function fileuploadFn(formId, element) {
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
                    $(".fileTips").replaceWith('<span class="fileTips" style="color: red">（禁止上传高密级文件）</span>');
                }else{
                    $(dom).after('<span class="fileTips" style="color: red">（禁止上传高密级文件）</span>');
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
            clearInterval(progressIN);
            var progress = parseInt(data.loaded / data.total * 100, 10);
            $('#progress .bar').css(
                'width',
                progress + '%'
            );
            $('.barText').html(progress + '%');
            if(progress >= 100){  //判断滚动条到100%清除定时器
                timer = setTimeout(function () {
                    $('#progress .bar').css(
                        'width',
                        0 + '%'
                    );
                    $('.barText').html('');
                },2000);

            }
        },
        done: function (e, data) {
            if(data.result.obj){
                if(data.result.obj != ''){
                    var data = data.result.obj;
                    var str = '';

                    for (var i = 0; i < data.length; i++) {
                        var attachName = data[i].attachName;
                        var gs = attachName.substring(attachName.lastIndexOf(".") + 1, attachName.length);
                        gs = gs.toLowerCase();
                        if(gs == 'jsp'||gs == 'css'||gs == 'js'||gs == 'html'||gs == 'java'||gs == 'php' ){ //后缀为这些的禁止上传
                            str += '';
                            layer.alert(dem_th_uploading + '!', {}, function(){
                                layer.closeAll();
                            });
                        }else if(gs == 'jpg'|| gs == 'png'|| gs == 'gif'|| gs == 'jpeg'|| gs == 'svg'|| gs == 'swf' ){
                            var fileExtension = data[i].attachName.substring(data[i].attachName.lastIndexOf(".") + 1, data[i].attachName.length);//截取附件文件后缀
                            var attName = encodeURI(data[i].attachName).replace(/\+/g, "%2b").replace(/\@/g,"%40").replace(/\#/g,"%23").replace(/\&/g,"%26").replace(/\//g,"%2F").replace(/\?/g,"%3F").replace(/\￥/g,"%ef%bf%a5").replace(/\$/g,"%24").replace(/\！/g,"%ef%bc%81").replace(/\（/g,"%ef%bc%88").replace(/\）/g,"%ef%bc%89").replace(/\…/g,"%e2%80%a6%e2%80%a6");
                            var fileExtensionName = attName.substring(0, attName.lastIndexOf("."));
                            var deUrl = data[i].attUrl.split('&ATTACHMENT_NAME=')[0] + "&ATTACHMENT_NAME=" + fileExtensionName + "." + fileExtension + "&FILESIZE=" + data[i].size;

                            str += '<div class="dech" NAME1="' + data[i].attachName + '" deUrl="' + deUrl+ '">' +
                                        '<a href="/download?' + encodeURI(deUrl) + '"   NAME="' + data[i].attachName + '*" style="text-decoration:none;margin-left:5px;">' +
                                            '<img  src="/img/attachment_icon.png"/>' + data[i].attachName + '' +
                                        '</a>' +
                                        '<img class="deImgs" style="margin-left:5px;cursor: pointer;" src="/img/file/icon_deletecha_03.png"/>' +
                                        '<a fileExtension="'+ fileExtension +'" onclick="pdurls($(this))"   href="javascript:;"  style="padding-left: 5px">' +
                                            '<span class="lookFile"><img src="/img/attachmentIcon/icon_skim.png" style="padding: 0 5px;">'+email_th_refer_to+'</span>' +
                                        '</a>' +
                                        '<a style="padding-left: 5px" href="/download?'+ encodeURI(deUrl) +'" >' +
                                            '<img src="/img/attachmentIcon/icon_down.png"  style="padding: 0 5px;">' + email_th_download +
                                        '</a>' +
                                        '<a class="unloading" fileExtension="'+ fileExtension +'" onclick="transfers($(this))"  attrurl="' + deUrl.substring(0, deUrl.lastIndexOf("&"))  + '" href="javascript:;" style="padding-left: 5px"  >' +
                                            '<img src="/img/attachmentIcon/tran.png"  style="padding: 0 5px;">' + email_th_transfer_and_save +
                                        '</a>' +
                                        '<input type="hidden" class="inHidden" size="'+ data[i].size +'" value="' + data[i].aid + '@' + data[i].ym + '_' + data[i].attachId + ',">' +
                                    '</div>';
                        }
                       /* else if(data[i].attachName.indexOf('+')!=-1){
                                alert("你上传的"+data[i].attachName+"文件有特殊字符'+',文件名中不可存在特殊字符,请重新上传");

                        }*/
                        else if(gs == 'docx'|| gs == 'doc'|| gs == 'xls' || gs == 'xlsx' || gs == 'pptx'){
                            var fileExtension = data[i].attachName.substring( data[i].attachName.lastIndexOf(".") + 1, data[i].attachName.length );//截取附件文件后缀
                            var attName = encodeURI(data[i].attachName).replace(/\+/g, "%2b").replace(/\@/g,"%40").replace(/\#/g,"%23").replace(/\&/g,"%26").replace(/\//g,"%2F").replace(/\?/g,"%3F").replace(/\￥/g,"%ef%bf%a5").replace(/\$/g,"%24").replace(/\！/g,"%ef%bc%81").replace(/\（/g,"%ef%bc%88").replace(/\）/g,"%ef%bc%89").replace(/\…/g,"%e2%80%a6%e2%80%a6");
                            var fileExtensionName = attName.substring(0,attName.lastIndexOf("."));
                            var deUrl = data[i].attUrl.split('&ATTACHMENT_NAME=')[0] + "&ATTACHMENT_NAME=" + fileExtensionName + "." + fileExtension + "&FILESIZE=" + data[i].size;

                            str += '<div class="dech" NAME1="' + data[i].attachName + '" deUrl="' + deUrl+ '">' +
                                        '<a href="/download?'+ encodeURI(deUrl) +'" NAME="' + data[i].attachName + '*" style="text-decoration:none;margin-left:5px;">' +
                                            '<img  src="/img/attachment_icon.png"/>' + data[i].attachName + '' +
                                        '</a>' +
                                        '<img class="deImgs" style="margin-left:5px;cursor: pointer;" src="/img/file/icon_deletecha_03.png"/>' +
                                        '<a fileExtension="' + fileExtension + '" onclick="preview($(this),1)" attrurl="' + deUrl + '" href="javascript:;" style="padding-left: 5px">' +
                                            '<span class="lookFile"><img src="/img/attachmentIcon/icon_skim.png" style="padding: 0 5px;">'+yulan+'</span>' +
                                        '</a>' +
                                        '<a style="padding-left: 5px" href="/download?'+ encodeURI(deUrl) +'" >' +
                                            '<img src="/img/attachmentIcon/icon_down.png" style="padding: 0 5px;">' + email_th_download +
                                        '</a>' +
                                        '<a class="operation" href="javascript:;" onclick="editAttachment($(this))" class="editFile" style="margin-left: 10px;" attrurl="' + deUrl + '">' +
                                            '<img src="/img/attachmentIcon/icon_edit.png" style="margin-right: 5px;" alt="">' + edit1 +
                                        '</a>' +
                                        '<a class="unloading" fileExtension="'+ fileExtension +'" onclick="transfers($(this))" attrurl="' + deUrl.substring(0, deUrl.lastIndexOf("&"))  + '" href="javascript:;" style="padding-left: 5px"  >' +
                                            '<img src="/img/attachmentIcon/tran.png"  style="padding: 0 5px;">' + email_th_transfer_and_save +
                                        '</a>' +
                                        '<input type="hidden" class="inHidden" size="'+ data[i].size +'" value="' + data[i].aid + '@' + data[i].ym + '_' + data[i].attachId + ',">' +
                                    '</div>';
                        }
                        else if(gs == 'zip'|| gs == 'mp4' || gs == 'rar'){
                            var fileExtension = data[i].attachName.substring( data[i].attachName.lastIndexOf(".") + 1, data[i].attachName.length );//截取附件文件后缀
                            var attName = encodeURI(data[i].attachName).replace(/\+/g, "%2b").replace(/\@/g,"%40").replace(/\#/g,"%23").replace(/\&/g,"%26").replace(/\//g,"%2F").replace(/\?/g,"%3F").replace(/\￥/g,"%ef%bf%a5").replace(/\$/g,"%24").replace(/\！/g,"%ef%bc%81").replace(/\（/g,"%ef%bc%88").replace(/\）/g,"%ef%bc%89").replace(/\…/g,"%e2%80%a6%e2%80%a6");
                            var fileExtensionName = attName.substring(0, attName.lastIndexOf("."));
                            var deUrl = data[i].attUrl.split('&ATTACHMENT_NAME=')[0] + "&ATTACHMENT_NAME=" + fileExtensionName+"." + fileExtension + "&FILESIZE=" + data[i].size;

                            str += '<div class="dech" NAME1="' + data[i].attachName + '" deUrl="' + deUrl+ '">' +
                                        '<a href="/download?'+ encodeURI(deUrl) +'"   NAME="' + data[i].attachName + '*" style="text-decoration:none;margin-left:5px;">' +
                                            '<img  src="/img/attachment_icon.png"/>' + data[i].attachName + '' +
                                        '</a>' +
                                        '<img class="deImgs" style="margin-left:5px;cursor: pointer;" src="/img/file/icon_deletecha_03.png"/>' +
                                        '<a style="padding-left: 5px" href="/download?'+ encodeURI(deUrl) +'" >' +
                                            '<img src="/img/attachmentIcon/icon_down.png"  style="padding: 0 5px;">' + email_th_download +
                                        '</a>' +
                                        '<a fileExtension="'+ fileExtension +'" onclick="transfers($(this))"  attrurl="' + deUrl.substring(0, deUrl.lastIndexOf("&"))  + '" href="javascript:;" style="padding-left: 5px"  >' +
                                            '<img src="/img/attachmentIcon/tran.png"  style="padding: 0 5px;">' + email_th_transfer_and_save +
                                        '</a>' +
                                        '<input type="hidden" class="inHidden" size="'+ data[i].size +'" value="' + data[i].aid + '@' + data[i].ym + '_' + data[i].attachId + ',">' +
                                    '</div>';
                        }
                        else{
                            var fileExtension = data[i].attachName.substring( data[i].attachName.lastIndexOf(".") + 1, data[i].attachName.length );//截取附件文件后缀
                            var attName = encodeURI(data[i].attachName).replace(/\+/g, "%2b").replace(/\@/g,"%40").replace(/\#/g,"%23").replace(/\&/g,"%26").replace(/\//g,"%2F").replace(/\?/g,"%3F").replace(/\￥/g,"%ef%bf%a5").replace(/\$/g,"%24").replace(/\！/g,"%ef%bc%81").replace(/\（/g,"%ef%bc%88").replace(/\）/g,"%ef%bc%89").replace(/\…/g,"%e2%80%a6%e2%80%a6");
                            var fileExtensionName = attName.substring(0, attName.lastIndexOf("."));
                            var deUrl = data[i].attUrl.split('&ATTACHMENT_NAME=')[0] + "&ATTACHMENT_NAME=" + fileExtensionName + "." + fileExtension + "&FILESIZE=" + data[i].size;

                            str += '<div class="dech" NAME1="' + data[i].attachName + '" deUrl="' + deUrl+ '">' +
                                        '<a href="/download?'+ encodeURI(deUrl) +'"   NAME="' + data[i].attachName + '*" style="text-decoration:none;margin-left:5px;">' +
                                            '<img  src="/img/attachment_icon.png"/>' + data[i].attachName +
                                        '</a>' +
                                        '<img class="deImgs" style="margin-left:5px;cursor: pointer;" src="/img/file/icon_deletecha_03.png"/>' +
                                        '<a fileExtension="'+ fileExtension +'" onclick="preview($(this),1)" attrurl="' + deUrl + '"   href="javascript:;"  style="padding-left: 5px">' +
                                            '<span class="lookFile"><img src="/img/attachmentIcon/icon_skim.png" style="padding: 0 5px;">'+yulan+'</span>' +
                                        '</a>' +
                                        '<a style="padding-left: 5px" href="/download?'+ encodeURI(deUrl) +'" >' +
                                            '<img src="/img/attachmentIcon/icon_down.png"  style="padding: 0 5px;">' + email_th_download +
                                        '</a>' +
                                        '<a class="unloading" fileExtension="'+ fileExtension +'" onclick="transfers($(this))"  attrurl="' + deUrl.substring(0, deUrl.lastIndexOf("&"))  + '" href="javascript:;" style="padding-left: 5px"  >' +
                                            '<img src="/img/attachmentIcon/tran.png"  style="padding: 0 5px;">' + email_th_transfer_and_save +
                                        '</a>' +
                                        '<input type="hidden" class="inHidden" size="'+ data[i].size +'" value="' + data[i].aid + '@' + data[i].ym + '_' + data[i].attachId + ',">' +
                                    '</div>';
                        }
                        $('#uploadinputimg').attr('filename', data[i].attachName)
                    }
                    element.append(str);
                }else{
                    layer.alert(attachments1 + '!',{},function(){
                        layer.closeAll();
                    });
                }
            }else {
                if(data.result.datas != ''){
                    var data = data.result.datas;
                    var str = '';

                    for (var i = 0; i < data.length; i++) {
                        gs = data[i].attachName.split('.')[1];
                        if(gs == 'jsp'||gs == 'css'||gs == 'js'||gs == 'html'||gs == 'java'||gs == 'php' ){ //后缀为这些的禁止上传
                            str += '';
                            layer.alert(dem_th_uploading + '!',{},function(){
                                layer.closeAll();
                            });
                        }
                       /* else if(data[i].attachName.indexOf('+')!=-1){
                            alert("你上传的"+data[i].attachName+"文件有特殊字符'+',文件名中不可存在特殊字符,请重新上传");
                        }*/
                        else{
                            var fileExtension = data[i].attachName.substring( data[i].attachName.lastIndexOf(".") + 1, data[i].attachName.length );//截取附件文件后缀
                            var attName = encodeURI(data[i].attachName).replace(/\+/g, "%2b").replace(/\@/g,"%40").replace(/\#/g,"%23").replace(/\&/g,"%26").replace(/\//g,"%2F").replace(/\?/g,"%3F").replace(/\￥/g,"%ef%bf%a5").replace(/\$/g,"%24").replace(/\！/g,"%ef%bc%81").replace(/\（/g,"%ef%bc%88").replace(/\）/g,"%ef%bc%89").replace(/\…/g,"%e2%80%a6%e2%80%a6");
                            var fileExtensionName = attName.substring(0, attName.lastIndexOf("."));
                            var deUrl = data[i].attUrl.split('&ATTACHMENT_NAME=')[0]+"&ATTACHMENT_NAME="+fileExtensionName+"."+fileExtension+"&FILESIZE="+data[i].size;

                            str += '<div class="dech" NAME1="' + data[i].attachName + '" deUrl="' + deUrl+ '">' +
                                        '<a href="/download?'+ encodeURI(deUrl) +'"  NAME="' + data[i].attachName + '*" style="text-decoration:none;margin-left:5px;">' +
                                            '<img  src="/img/attachment_icon.png"/>' + data[i].attachName +
                                        '</a>' +
                                        '<img class="deImgs" style="margin-left:5px;cursor: pointer;" src="/img/file/icon_deletecha_03.png"/>' +
                                        '<a fileExtension="'+ fileExtension +'" onclick="pdurls($(this))" href="javascript:;"  style="padding-left: 5px">' +
                                            '<img src="/img/attachmentIcon/icon_skim.png" style="padding: 0 5px;">' + email_th_refer_to +
                                        '</a>' +
                                        '<a style="padding-left: 5px" href="/download?'+ encodeURI(deUrl) +'" >' +
                                            '<img src="/img/attachmentIcon/icon_down.png"  style="padding: 0 5px;">' + email_th_download +
                                        '</a>' +
                                        '<a class="operation" href="javascript:;" onclick="editAttachment($(this))" class="editFile" style="margin-left: 10px;" attrurl="' + deUrl + '">' +
                                            '<img src="/img/attachmentIcon/icon_edit.png" style="margin-right: 5px;" alt="">' + edit1 +
                                        '</a>' +
                                        '<a class="unloading" fileExtension="'+ fileExtension +'" onclick="transfers($(this))"  attrurl="' + deUrl.substring(0, deUrl.lastIndexOf("&"))  + '" href="javascript:;" style="padding-left: 5px"  >' +
                                            '<img src="/img/attachmentIcon/tran.png"  style="padding: 0 5px;">' + email_th_transfer_and_save +
                                        '</a>' +
                                        '<input type="hidden" class="inHidden" size="'+ data[i].size +'" value="' + data[i].aid + '@' + data[i].ym + '_' + data[i].attachId + ',">' +
                                    '</div>';
                        }
                        $('#uploadinputimg').attr('filename',data[i].attachName)
                    }
                    element.append(str);

                }else{
                    layer.alert(attachments1 + '!',{},function(){
                        layer.closeAll();
                    });
                }
            }
            //判断一下是否开启了三员管理
            $.ajax({
                url:"/syspara/selectTheSysPara?paraName=IS_OPEN_SANYUAN",
                success:function(res) {
                    var data = res.object[0];
                    if(data.paraValue == 0) {
                        $.ajax({
                            url:"/sysTasks/getSysParaList?paraName=%2COFFICE_EDIT%2CDOCUMENT_PREVIEW_OPEN",
                            success:function(res) {
                                var data = res.obj;
                                var openSetting = "";
                                var editSetting = "";
                                for(var i = 0; i < data.length; i++) {
                                    if(data[i].paraName == "DOCUMENT_PREVIEW_OPEN") {
                                        openSetting = data[i].paraValue
                                    }else if(data[i].paraName == "OFFICE_EDIT") {
                                        editSetting = data[i].paraValue;
                                    }
                                }
                                if(openSetting == 0) {
                                    $(".dech .lookFile").css("display","none")
                                }
                                if(editSetting == -1) {
                                    $(".dech .operation").css("display","none")
                                    $(".dech .unloading").css("display","none")
                                }
                            }
                        })
                    }
                }
            });
            if(flags){
                //    如果开启了三员管理，隐藏文件查阅
                $(".chayue").hide()
            }else{
                $(".chayue").show()
            }
        }
    });
}
//附件上传 转存方法
function transfers(e){
    var atturl = e.attr('attrurl');
    $.popWindow("/email/transfer?"+atturl, PreviewPage, '0', '0', '1200px', '600px');
}
function editAttachment(_this, print) { //编辑附件
    var name = _this.parents('.dech').attr('name1')
    var name1 = name.split('.')[1];
    if(name1 == 'jsp'||name1 == 'css'||name1 == 'js'||name1 == 'html'||name1 == 'java'||name1 == 'php'||name1 == 'pdf'||name1 == 'png'|| name1 == 'oxps'||name1 == 'jpg'||name1 == 'bmp' || name1 == 'emf' || name1 == 'gif'|| name1 == 'pcx'|| name1 == 'pcd'|| name1 == 'ai'|| name1 == 'webp'|| name1 == 'WMF'|| name1 == 'dxf' ||name1 == 'PNG'||name1 == 'JPG'||name1 == 'BMP' || name1 == 'EMF' || name1 == 'GIF'|| name1 == 'PCX'|| name1 == 'PCD'|| name1 == 'AI'|| name1 == 'WEBP'|| name1 == 'wmf'|| name1 == 'DXF' ||name1 == 'ofd'||name1 == 'OFD'||name1 == 'oFd'||name1 == 'oFD'){ //后缀为这些的禁止上传
        layer.msg(name1 + dem_th_theFileCannotBeEdited + '!', {}, function(){

        });
        return false;
    }
    var atturl =_this.attr('attrurl');
    if(atturl && atturl.indexOf('&ATTACHMENT_NAME=') > -1 && atturl.indexOf('isOld=1') == -1){
        var atturl1 = atturl.split('&ATTACHMENT_NAME=')[0] + '&ATTACHMENT_NAME=';
        var atturl2 = '';
        if(atturl.split('&ATTACHMENT_NAME=')[1]&&atturl.split('&ATTACHMENT_NAME=')[1].indexOf('&') > -1){
            for(var i = 1; i < atturl.split('&ATTACHMENT_NAME=')[1].split('&').length; i++){
                atturl2 += '&' + atturl.split('&ATTACHMENT_NAME=')[1].split('&')[i];
            }
            atturl = atturl1 + atturl2;
        }else{
            atturl = atturl1;
        }
    }
    var url = "/common/webOffice?documentEditPriv=1&fomat=" + name1 + "&ntType=1&officeType=1&print=" + print + "&" + atturl;
    $.ajax({
        url: '/syspara/selectTheSysPara?paraName=OFFICE_EDIT',
        type: 'post',
        datatype: 'json',
        async: false,
        success: function (res) {
            if(res.flag){
                if(res.object[0].paraValue == 0){
                    url = "/common/ntko?documentEditPriv=1&fomat=" + name1 + "&ntType=1&officeType=1&print=" + print + "&" + atturl;
                }else if(res.object[0].paraValue == 2){
                    url = "/wps/info?" + atturl + "&permission=write";
                }else if(res.object[0].paraValue == 3){
                    url = "/common/onlyoffice?" + atturl + "&edit=true";
                }
            }
        }
    })
    $.popWindow(url, '<fmt:message code="main.th.PreviewPage" />', '0', '0', '1200px', '600px');
}
function pdurls(_this){ //根据后缀判断选择调取那种打开方式
    var atturl = _this.parents('.dech').attr('deUrl');
    if(atturl && atturl.indexOf('&ATTACHMENT_NAME=') > -1){
        var atturl1 = atturl.split('&ATTACHMENT_NAME=')[0] + '&ATTACHMENT_NAME=';
        var atturl2 = '';
        if(atturl.split('&ATTACHMENT_NAME=')[1] && atturl.split('&ATTACHMENT_NAME=')[1].indexOf('&') > -1){
            for(var i = 1; i < atturl.split('&ATTACHMENT_NAME=')[1].split('&').length; i++){
                atturl2 += '&' + atturl.split('&ATTACHMENT_NAME=')[1].split('&')[i];
            }
            atturl = atturl1 + atturl2;
        }else{
            atturl = atturl1;
        }
    }
    var gs = _this.attr('fileExtension').toLowerCase();
    if(gs == 'png'||gs == 'jpg'||gs == 'bmp' || gs == 'emf' || gs == 'gif'|| gs == 'pcx'|| gs == 'pcd'|| gs == 'ai'|| gs == 'webp'|| gs == 'dxf' || gs == 'wmf' || gs == 'txt'){
        $.popWindow("/xs?" + atturl, PreviewPage, '0', '0', '1200px', '600px');
    }else if(gs == 'mp4'||gs == 'rmvb'||gs == 'avi'||gs == 'ifo'||gs == 'wmv'){
        layer.open({type: 2, title: false, area: ['630px', '360px'], shade: 0.8, closeBtn: 0, shadeClose: true, content: "/common/video?videoatturlsplit="+atturl});
        layer.msg(email_th_clickAnywhereToClose);
    }else if(gs == 'pdf'){
        $.popWindow("/pdfPreview?" + atturl, PreviewPage, '0', '0', '1200px', '600px');
    }else if(gs == 'html'){
        $.popWindow("/common/htmlPreview?"+ atturl, PreviewPage, '0', '0', '1200px', '600px');
    }else if(gs == 'ofd'){
        $.popWindow("../../lib/ofdViewer/viewer.html?file="+'/download?' + atturl , PreviewPage, '0', '0', '1200px', '600px')
    }else if(gs == 'docx'|| gs == 'doc'|| gs == 'xls' || gs == 'xlsx' || gs == 'pptx'){
        var url = "/common/webOfficeView?documentEditPriv=0&fomat=" + gs + "&" + atturl;
        $.ajax({
            url: '/syspara/selectTheSysPara?paraName=OFFICE_EDIT',
            type: 'post',
            datatype: 'json',
            async: false,
            success: function (res) {
                if(res.flag){
                    if(res.object[0].paraValue == 0){
                        url = "/common/ntkoview?documentEditPriv=0&fomat=" + gs + "&" + atturl;
                    }else if(res.object[0].paraValue == 2){
                        url = "/wps/info?"+ atturl +"&permission=read";
                    }else if(res.object[0].paraValue == 3){
                        url = "/common/onlyoffice?"+ atturl +"&edit=false";
                    }
                }
            }
        })
        $.popWindow(url, PreviewPage, '0', '0', '1200px', '600px');
    }else{
        try{
            layer.msg(dem_th_filesInThisFormatCannotBePreviewedOrViewedTemporarily + '！')
        }catch(e){
            alert(dem_th_filesInThisFormatCannotBePreviewedOrViewedTemporarily + '！')
        }
    }
}

function preview(that,workNum) { //附件预览点击调取
    if(workNum == 1){
        if(that.attr('attrurl')) {
            var attrUrl = that.attr('attrurl').split('&FILESIZE')[0];
        }else {
            var attrUrl = that.attr('atturl').split('&FILESIZE')[0];
        }

    }else {
        var attrUrl = that.attr('attrurl')?that.attr('attrurl'):that.attr('atturl');
    }

    var url = attrUrl;
    if(attrUrl != undefined&&attrUrl.indexOf('&ATTACHMENT_NAME=') > -1&&attrUrl.indexOf('isOld=1') == -1){
        var atturl1 = attrUrl.split('&ATTACHMENT_NAME=')[0] + '&ATTACHMENT_NAME=';
        var atturl2 = '';
        if(attrUrl.split('&ATTACHMENT_NAME=')[1] != undefined&&attrUrl.split('&ATTACHMENT_NAME=')[1].indexOf('&') > -1){
            for(var i=1;i<attrUrl.split('&ATTACHMENT_NAME=')[1].split('&').length;i++){
                atturl2 += '&' + attrUrl.split('&ATTACHMENT_NAME=')[1].split('&')[i];
            }
            url = atturl1 + atturl2;
        }else{
            url = atturl1;
        }
    }
    var type = UrlGetRequest('?'+attrUrl)||'docx';
    if(type.indexOf('&') > -1){
        type = type.split('&')[0];
    }
    type = type.toLowerCase();
    if(type == 'pdf'){
        //$.popWindow('/common/pdfPreview?'+url.split('&COMPANY=')[0],'','0','0','1200px','600px');
        $.popWindow("/pdfPreview?"+url,PreviewPage,'0','0','1200px','600px');
    }else if(type == 'png' || type == 'jpg' ||  type == 'txt'){
        $.popWindow("/xs?"+url,PreviewPage,'0','0','1200px','600px');
    }else if(type == 'ofd'|| type=='OFD'){
        $.popWindow("../../lib/ofdViewer/viewer.html?file="+'/download?'+url , PreviewPage, '0', '0', '1200px', '600px')
    }else if(type == 'doc'||type == 'docx'||type == 'xls'||type == 'xlsx'||type == 'ppt'||type == 'pptx'){
        $.ajax({
            type:'get',
            url:'/syspara/selectTheSysPara?paraName=DOCUMENT_PREVIEW_OPEN',
            dataType:'json',
            success:function (res) {
                if(res.flag){
                    documentPreviewOpen = res.object[0].paraValue;
                    if(documentPreviewOpen == 1){
                        $.ajax({
                            type:'get',
                            url:'/sysTasks/getOfficePreviewSetting',
                            dataType:'json',
                            success:function (res) {
                                if(res.flag){
                                    var strOfficeApps = res.object.previewUrl;//在线预览服务地址

                                    $.ajax({
                                        url:'/onlyOfficeCode',
                                        dataType: 'json',
                                        type: 'post',
                                        success:function(res){
                                            if(res.flag){
                                                var code = res.obj;
                                                $.popWindow(strOfficeApps+'/op/view.aspx?src='+domains+'/onlyOfficeDownload'+ encodeURIComponent('?'+url + '&code='+ code),'','0','0','1200px','600px');
                                            }
                                        }
                                    })
                                }
                            }
                        })
                    }else if(documentPreviewOpen == 2){
                        if(type == 'xls'||type == 'xlsx'){
                            $.popWindow('/common/excelPreview?'+url.split('&COMPANY=')[0],'','0','0','1200px','600px');
                        }else if(type == 'ppt'||type == 'pptx'){
                            $.popWindow('/common/pptPreview?'+url.split('&COMPANY=')[0],'','0','0','1200px','600px');
                        }else{
                            $.popWindow('/common/officereader?'+url.split('&COMPANY=')[0],'','0','0','1200px','600px');
                        }
                    }else if(documentPreviewOpen == 3){
                        $.popWindow("/wps/info?"+ url +"&permission=read",'','0','0','1200px','600px');
                    }else if(documentPreviewOpen == 4){
                        $.popWindow("/common/onlyoffice?"+ url +"&edit=false",'','0','0','1200px','600px');
                    }
                }
            }
        })
    } else{
        $.ajax({
            type:'get',
            url:'/sysTasks/getOfficePreviewSetting',
            dataType:'json',
            success:function (res) {
                if(res.flag){
                    var strOfficeApps = res.object.previewUrl;//在线预览服务地址
                    if(strOfficeApps == ''){
                        strOfficeApps = 'https://owa-box.vips100.com';
                    }

                    $.ajax({
                        url:'/onlyOfficeCode',
                        dataType: 'json',
                        type: 'post',
                        success:function(res){
                            if(res.flag){
                                var code = res.obj;
                                $.popWindow(strOfficeApps+'/op/view.aspx?src='+domains+'/onlyOfficeDownload'+ encodeURIComponent('?'+url + '&code='+ code),'','0','0','1200px','600px');
                            }
                        }
                    })
                }
            }
        })
    }
}
