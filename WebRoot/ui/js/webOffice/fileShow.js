/*附件循环显示方法*/
function attachmentShow(attachmentArr,downloadJuris,objStr,bonType) {
    var str='';
    for (var i = 0; i < (attachmentArr.length); i++) {
        var fileType = attachmentArr[i].attachName.substring(attachmentArr[i].attachName.lastIndexOf("."),attachmentArr[i].attachName.length);
        var downloadStr = ''; //下载按钮显示
        var fileDownStr='';  //附件名称显示
        var webOffice= '';  //webOffice查阅按钮显示
        var atturl = encodeURI(attachmentArr[i].attUrl);
        var attUrl_s = attachmentArr[i].attUrl;
        var attName = encodeURI(attachmentArr[i].attachName).replace(/\+/g, "%2b").replace(/\@/g,"%40").replace(/\#/g,"%23").replace(/\&/g,"%26").replace(/\//g,"%2F").replace(/\?/g,"%3F").replace(/\￥/g,"%ef%bf%a5").replace(/\$/g,"%24").replace(/\！/g,"%ef%bc%81").replace(/\（/g,"%ef%bc%88").replace(/\）/g,"%ef%bc%89").replace(/\…/g,"%e2%80%a6%e2%80%a6");
        attUrl_s = attUrl_s.substring(0,attUrl_s.lastIndexOf("ATTACHMENT_NAME="))+"ATTACHMENT_NAME="+attName;
        if(downloadJuris=='1'){
            downloadStr = '<a class="download_a" href="/download?' + encodeURI(attUrl_s) + '">下载</a>';
            fileDownStr ='<a class="file_a" data-url="/download?' + encodeURI(attachmentArr[i].attUrl)+'"><img class="img_" src="/img/enclosure.png"/><span style="margin-left: 10px">' + attachmentArr[i].attachName + '</span></a>';
        }else{
            fileDownStr ='<a class="file_a" data-url=""><img class="img_" src="/img/enclosure.png"/><span style="margin-left: 25px;color:#333333;">' + attachmentArr[i].attachName + '</span></a>';
        }
            if(UrlGetRequest('?'+atturl) != 'exe'&&UrlGetRequest('?'+atturl) != 'rar'&&UrlGetRequest('?'+atturl) != 'zip'){
                if(UrlGetRequest('?'+attUrl_s) == 'pdf' || UrlGetRequest('?'+attUrl_s) == 'PDF' || UrlGetRequest('?'+attUrl_s) == 'txt'|| UrlGetRequest('?'+attUrl_s) == 'png'|| UrlGetRequest('?'+attUrl_s) == 'jpg'|| UrlGetRequest('?'+attUrl_s) == 'bmp'|| UrlGetRequest('?'+attUrl_s) == 'emf'|| UrlGetRequest('?'+attUrl_s) == 'gif'|| UrlGetRequest('?'+attUrl_s) == 'pcx'|| UrlGetRequest('?'+attUrl_s) == 'pcd'|| UrlGetRequest('?'+attUrl_s) == 'ai'|| UrlGetRequest('?'+attUrl_s) == 'webp'|| UrlGetRequest('?'+attUrl_s) == 'WMF'|| UrlGetRequest('?'+attUrl_s) == 'dxf'){
                    webOffice = '<a class="download_a" onclick="dj($(this))" style="margin: 0 10px" attrurl="' + encodeURI(attUrl_s) + '" href="javascript:;">查阅</a>';
                }else {
                    webOffice = '<a class="download_a" onclick="dj($(this))" style="margin: 0 10px" attrurl="' + attUrl_s + '" href="javascript:;">查阅</a>';
                }
            }else{
                webOffice = '';
            }
        if(bonType == '1'){
            str += '<div class="font_">' +fileDownStr+ webOffice+downloadStr + '</div>';
        }else{
            str += '<div class="font_">' +
                '<span>附件文件：</span>' +fileDownStr+ webOffice+downloadStr +
                '</div>';
        }
    }
    objStr.html(str);
}
//文件柜
function attachmentShow_file(attachmentArr,objStr,downLoad) {
    var str='';
    for (var i = 0; i < (attachmentArr.length); i++) {
        var fileType = attachmentArr[i].attachName.substring(attachmentArr[i].attachName.lastIndexOf("."),attachmentArr[i].attachName.length);
        var downloadStr = ''; //下载按钮显示
        var fileDownStr='';  //附件名称显示
        var webOffice= '';  //webOffice查阅按钮显示
        var atturl = encodeURI(attachmentArr[i].attUrl);
        var attUrl_s = attachmentArr[i].attUrl;
        var attName = encodeURI(attachmentArr[i].attachName).replace(/\+/g, "%2b").replace(/\@/g,"%40").replace(/\#/g,"%23").replace(/\&/g,"%26").replace(/\//g,"%2F").replace(/\?/g,"%3F").replace(/\￥/g,"%ef%bf%a5").replace(/\$/g,"%24").replace(/\！/g,"%ef%bc%81").replace(/\（/g,"%ef%bc%88").replace(/\）/g,"%ef%bc%89").replace(/\…/g,"%e2%80%a6%e2%80%a6");
        attUrl_s = attUrl_s.substring(0,attUrl_s.lastIndexOf("ATTACHMENT_NAME="))+"ATTACHMENT_NAME="+attName;
        if(downLoad == '0'){
            downloadStr='';
        }else{
            downloadStr = '<a class="download_a" href="/download?'+encodeURI(attUrl_s) +'">下载</a>';
        }
        fileDownStr ='<a class="file_a" data-url="/download?' + encodeURI(attachmentArr[i].attUrl)+'"><img class="img_" src="../img/enclosure.png"/><span style="">' + attachmentArr[i].attachName + '</span></a>';
            if(UrlGetRequest('?'+atturl) != 'exe'&&UrlGetRequest('?'+atturl) != 'rar'&&UrlGetRequest('?'+atturl) != 'zip'){
                if(UrlGetRequest('?'+atturl) == 'pdf' || UrlGetRequest('?'+atturl) == 'PDF' || UrlGetRequest('?'+attUrl_s) == 'txt'|| UrlGetRequest('?'+attUrl_s) == 'png'|| UrlGetRequest('?'+attUrl_s) == 'jpg'|| UrlGetRequest('?'+attUrl_s) == 'bmp'|| UrlGetRequest('?'+attUrl_s) == 'emf'|| UrlGetRequest('?'+attUrl_s) == 'gif'|| UrlGetRequest('?'+attUrl_s) == 'pcx'|| UrlGetRequest('?'+attUrl_s) == 'pcd'|| UrlGetRequest('?'+attUrl_s) == 'ai'|| UrlGetRequest('?'+attUrl_s) == 'webp'|| UrlGetRequest('?'+attUrl_s) == 'WMF'|| UrlGetRequest('?'+attUrl_s) == 'dxf'){
                    webOffice = '<a class="download_a" onclick="dj($(this))" style="margin: 0 10px" attrurl="' + encodeURI(attUrl_s) + '" href="javascript:;">查阅</a>';
                }else {
                    webOffice = '<a class="download_a" onclick="dj($(this))" style="margin: 0 10px" attrurl="' + attUrl_s + '" href="javascript:;">查阅</a>';
                }
            }else{
                webOffice = '';
            }
        str += '<div class="font_">' +
            fileDownStr+ webOffice+downloadStr +
            '</div>';
    }
    objStr.html(str);
}
function attachmentShow_mail(attachmentArr) {
    var str='';
    for (var i = 0; i < (attachmentArr.length); i++) {
        var fileType = attachmentArr[i].attachName.substring(attachmentArr[i].attachName.lastIndexOf("."),attachmentArr[i].attachName.length);
        var downloadStr = ''; //下载按钮显示
        var fileDownStr='';  //附件名称显示
        var webOffice= '';  //webOffice查阅按钮显示
        var atturl = encodeURI(attachmentArr[i].attUrl);
        var attUrl_s = attachmentArr[i].attUrl;
        var attName = encodeURI(attachmentArr[i].attachName).replace(/\+/g, "%2b").replace(/\@/g,"%40").replace(/\#/g,"%23").replace(/\&/g,"%26").replace(/\//g,"%2F").replace(/\?/g,"%3F").replace(/\￥/g,"%ef%bf%a5").replace(/\$/g,"%24").replace(/\！/g,"%ef%bc%81").replace(/\（/g,"%ef%bc%88").replace(/\）/g,"%ef%bc%89").replace(/\…/g,"%e2%80%a6%e2%80%a6");
        attUrl_s = attUrl_s.substring(0,attUrl_s.lastIndexOf("ATTACHMENT_NAME="))+"ATTACHMENT_NAME="+attName;
        downloadStr = '<a class="download_a" href="/download?' + encodeURI(attUrl_s) + '">下载</a>';
        fileDownStr ='<a class="file_a" data-url="/download?' + encodeURI(attachmentArr[i].attUrl)+'"><img class="img_" src="../img/enclosure.png"/><span style="">' + attachmentArr[i].attachName + '</span></a>';
            if(UrlGetRequest('?'+atturl) != 'exe'&&UrlGetRequest('?'+atturl) != 'rar'&&UrlGetRequest('?'+atturl) != 'zip'){
                if(UrlGetRequest('?'+attUrl_s) == 'pdf' || UrlGetRequest('?'+attUrl_s) == 'PDF' || UrlGetRequest('?'+attUrl_s) == 'txt'|| UrlGetRequest('?'+attUrl_s) == 'png'|| UrlGetRequest('?'+attUrl_s) == 'jpg'|| UrlGetRequest('?'+attUrl_s) == 'bmp'|| UrlGetRequest('?'+attUrl_s) == 'emf'|| UrlGetRequest('?'+attUrl_s) == 'gif'|| UrlGetRequest('?'+attUrl_s) == 'pcx'|| UrlGetRequest('?'+attUrl_s) == 'pcd'|| UrlGetRequest('?'+attUrl_s) == 'ai'|| UrlGetRequest('?'+attUrl_s) == 'webp'|| UrlGetRequest('?'+attUrl_s) == 'WMF'|| UrlGetRequest('?'+attUrl_s) == 'dxf'){
                    webOffice = '<a class="download_a" onclick="dj($(this))" style="margin: 0 10px" attrurl="' + encodeURI(attUrl_s) + '" href="javascript:;">查阅</a>';
                }else {
                    webOffice = '<a class="download_a" onclick="dj($(this))" style="margin: 0 10px" attrurl="' + attUrl_s + '" href="javascript:;">查阅</a>';
                }
            }else{
                webOffice = '';
            }
        str += '<div class="font_">' +
            fileDownStr+ webOffice+downloadStr +
            '</div>';
    }
    return str;
}
function attachmentShow_news(attachmentArr,objStr) {
    var str='';
    for (var i = 0; i < (attachmentArr.length); i++) {
        var fileType = attachmentArr[i].attachName.substring(attachmentArr[i].attachName.lastIndexOf("."),attachmentArr[i].attachName.length);
        var downloadStr = ''; //下载按钮显示
        var fileDownStr='';  //附件名称显示
        var webOffice= '';  //webOffice查阅按钮显示
        var atturl = encodeURI(attachmentArr[i].attUrl);
        var attUrl_s = attachmentArr[i].attUrl;
        var attName = encodeURI(attachmentArr[i].attachName).replace(/\+/g, "%2b").replace(/\@/g,"%40").replace(/\#/g,"%23").replace(/\&/g,"%26").replace(/\//g,"%2F").replace(/\?/g,"%3F").replace(/\￥/g,"%ef%bf%a5").replace(/\$/g,"%24").replace(/\！/g,"%ef%bc%81").replace(/\（/g,"%ef%bc%88").replace(/\）/g,"%ef%bc%89").replace(/\…/g,"%e2%80%a6%e2%80%a6");
        attUrl_s = attUrl_s.substring(0,attUrl_s.lastIndexOf("ATTACHMENT_NAME="))+"ATTACHMENT_NAME="+attName;
        downloadStr = '<a class="download_a" href="/download?' + encodeURI(attUrl_s) + '">下载</a>';
        fileDownStr ='<a class="file_a" data-url="/download?' + encodeURI(attachmentArr[i].attUrl)+'"><img class="img_" src="../img/enclosure.png"/><span style="margin-left: 25px">' + attachmentArr[i].attachName + '</span></a>';
            if(UrlGetRequest('?'+atturl) != 'exe'&&UrlGetRequest('?'+atturl) != 'rar'&&UrlGetRequest('?'+atturl) != 'zip'){
                if(UrlGetRequest('?'+attUrl_s) == 'pdf' || UrlGetRequest('?'+attUrl_s) == 'PDF' || UrlGetRequest('?'+attUrl_s) == 'txt'|| UrlGetRequest('?'+attUrl_s) == 'png'|| UrlGetRequest('?'+attUrl_s) == 'jpg'|| UrlGetRequest('?'+attUrl_s) == 'bmp'|| UrlGetRequest('?'+attUrl_s) == 'emf'|| UrlGetRequest('?'+attUrl_s) == 'gif'|| UrlGetRequest('?'+attUrl_s) == 'pcx'|| UrlGetRequest('?'+attUrl_s) == 'pcd'|| UrlGetRequest('?'+attUrl_s) == 'ai'|| UrlGetRequest('?'+attUrl_s) == 'webp'|| UrlGetRequest('?'+attUrl_s) == 'WMF'|| UrlGetRequest('?'+attUrl_s) == 'dxf'){
                    webOffice = '<a class="download_a" onclick="dj($(this))" style="margin: 0 10px" attrurl="' + encodeURI(attUrl_s) + '" href="javascript:;">查阅</a>';
                }else {
                    webOffice = '<a class="download_a" onclick="dj($(this))" style="margin: 0 10px" attrurl="' + attUrl_s + '" href="javascript:;">查阅</a>';
                }
            }else{
                webOffice = '';
            }
        str += '<div class="font_">' +
            '<span>附件文件：</span>' +fileDownStr+ webOffice+downloadStr +
            '</div>';
    }
    objStr.html(str);
}
function UrlGetRequest(name) {//截取文件后缀
    var attach=name
    return attach.substring(attach.lastIndexOf(".")+1,attach.length);
}
function dj(e){
    var atturl = e.attr('attrurl');
    pdurl(UrlGetRequest('?'+atturl),atturl);
}
function pdurl(gs,atturl){ //根据后缀判断选择调取那种打开方式
    if(atturl != undefined&&atturl.indexOf('&ATTACHMENT_NAME=') > -1&&atturl.indexOf('isOld=1') == -1){
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
    if(gs == 'png'||gs == 'jpg'||gs == 'bmp' || gs == 'emf' || gs == 'gif'|| gs == 'pcx'|| gs == 'pcd'|| gs == 'ai'|| gs == 'webp'|| gs == 'WMF'|| gs == 'dxf' ||gs == 'PNG'||gs == 'JPG'||gs == 'BMP' || gs == 'EMF' || gs == 'GIF'|| gs == 'PCX'|| gs == 'PCD'|| gs == 'AI'|| gs == 'WEBP'|| gs == 'wmf'|| gs == 'DXF'|| gs == 'txt'|| gs == 'TXT'){
        $.popWindow("/xs?"+atturl,PreviewPage,'0','0','1200px','600px');
    }else if(gs == 'mp4'||gs == 'rmvb'||gs == 'avi'||gs == 'ifo'||gs == 'wmv'||gs == 'MP4'||gs == 'RMVB'||gs == 'AVI'||gs == 'IFO'||gs == 'WMV'){
        layer.open({type: 2, title: false, area: ['630px', '360px'], shade: 0.8, closeBtn: 0, shadeClose: true, content: "/common/video?videoatturlsplit="+atturl});
        layer.msg('点击任意处关闭');
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
                        url = "/common/ntkoview?documentEditPriv=0&fomat="+gs+"&"+atturl+'&ie_open=yes&IE=1';
                    }else if(res.object[0].paraValue == 2){
                        //默认加载NTKO插件 进行跳转
                        url = "/wps/info?"+ atturl +"&permission=read";
                    }else if(res.object[0].paraValue == 3){
                        //默认加载onlyoffice插件 进行跳转
                        url = "/common/onlyoffice?"+ atturl +"&edit=false";
                    }
                }

            }
        })
        $.popWindow(url,PreviewPage,'0','0','1200px','600px');
    }
}