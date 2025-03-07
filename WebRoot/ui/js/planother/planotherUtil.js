//+-*/
//加
function accAdd(a, b) {
    a = a==undefined?0:a;
    b = b==undefined?0:b;
    var c, d, e;
    try {
        c = a.toString().split(".")[1].length;
    } catch (f) {
        c = 0;
    }
    try {
        d = b.toString().split(".")[1].length;
    } catch (f) {
        d = 0;
    }
    return e = Math.pow(10, Math.max(c, d)), (mul(a, e) + mul(b, e)) / e;
}
//减
function sub(a, b) {
    a = a==undefined?0:a;
    b = b==undefined?0:b;
    var c, d, e;
    try {
        c = a.toString().split(".")[1].length;
    } catch (f) {
        c = 0;
    }
    try {
        d = b.toString().split(".")[1].length;
    } catch (f) {
        d = 0;
    }
    return e = Math.pow(10, Math.max(c, d)), (mul(a, e) - mul(b, e)) / e;
}
//乘
function mul(a, b) {
    a = a==undefined?0:a;
    b = b==undefined?0:b;
    var c = 0,
        d = a.toString(),
        e = b.toString();
    try {
        c += d.split(".")[1].length;
    } catch (f) {}
    try {
        c += e.split(".")[1].length;
    } catch (f) {}
    return Number(d.replace(".", "")) * Number(e.replace(".", "")) / Math.pow(10, c);
}
//除
function div(a, b) {
    a = a==undefined?0:a;
    b = b==undefined?0:b;
    var c, d, e = 0,
        f = 0;
    try {
        e = a.toString().split(".")[1].length;
    } catch (g) {}
    try {
        f = b.toString().split(".")[1].length;
    } catch (g) {}
    return c = Number(a.toString().replace(".", "")), d = Number(b.toString().replace(".", "")), mul(c / d, Math.pow(10, f - e));
}

//保留几位小数
//value原来的小数
//number保留几位小数
function retainDecimal(value,number) {
    if(value!=undefined&&number!=undefined){
        var temp=Number(value);
        temp=Math.round(mul(temp,Math.pow(10,number)))/Math.pow(10,number);
        temp=temp.toFixed(number);
        return parseFloat(temp);
    }else{
        return value;
    }
}
//dom 元素节点
//根据projId查询
//async 同步异步
function getProjName(dom,projId,async1) {
    async1?true:async1
    $.ajax({
        url:'/technicalManager/getProjInfoById?projectId='+projId,
        dataType:'json',
        type:'post',
        async:async1,
        success:function(res){
            $(dom).val(res.obj.projName)
        }
    })
}

function getFunc() {
    //var iframeUrl = getQueryString("iframe",$("#zw").attr("src")) //获取src中iframe对应的值
    var iframeUrl = $("#zw").attr("src")
    // var newLims = getQueryString("newLims",$("#zw").attr("src"))
    if(iframeUrl!=undefined&&iframeUrl!=''&&iframeUrl!=null) {
        var iframeFun = $("#zw")[0].contentWindow.childFunc;
        var iframeFuns = iframeFun;
        if (iframeFuns && typeof (iframeFuns) == "function") {
            if (iframeFun != undefined && iframeFun != null) {
                var iframeFunc = $("#zw")[0].contentWindow.childFunc(1)
                var flag = iframeFunc;
                if (!flag) { //方法返回false，终止程序，返回true继续执行
                    return false;
                }else {
                    return true;
                }
            } else {
                return true;
            }
        }else {
            return true;
        }
    }else {
        return true;
    }
}

//type 为 1 只能上传图片
//     其他 都能上传
//附件上传 方法
var timer=null;
function fileuploadFn(formId,element,type) {
    // $('#uploadinputimg').fileupload({
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
            var progress = parseInt(data.loaded / data.total * 100, 10);
            $('#progress .bar').css(
                'width',
                progress + '%'
            );
            $('.barText').html(progress + '%');
            if(progress >= 100){  //判断滚动条到100%清除定时器
                timer=setTimeout(function () {
                    $('#progress .bar').css(
                        'width',
                        0 + '%'
                    );
                    $('.barText').html('');
                },2000);

            }
        },
        done: function (e, data) {
            if(data.result.obj!=undefined){
                if(data.result.obj != ''){
                    var data = data.result.obj;
                    var str = '';
                    var str1 = '';
                    for (var i = 0; i < data.length; i++) {
                        var gs = data[0].attachName.substring(data[0].attachName.lastIndexOf(".")+1);
                        if(type&&type==1){
                            if(gs == 'png'||gs == 'jpg'||gs == 'bmp' || gs == 'emf' || gs == 'gif'|| gs == 'pcx'|| gs == 'pcd'|| gs == 'ai'|| gs == 'webp'|| gs == 'WMF'|| gs == 'dxf' ||gs == 'PNG'||gs == 'JPG'||gs == 'BMP' || gs == 'EMF' || gs == 'GIF'|| gs == 'PCX'|| gs == 'PCD'|| gs == 'AI'|| gs == 'WEBP'|| gs == 'wmf'|| gs == 'DXF'){
                                var fileExtension=data[i].attachName.substring(data[i].attachName.lastIndexOf(".")+1,data[i].attachName.length);//截取附件文件后缀
                                var attName = encodeURI(data[i].attachName).replace(/\+/g, "%2b").replace(/\@/g,"%40").replace(/\#/g,"%23").replace(/\&/g,"%26").replace(/\//g,"%2F").replace(/\?/g,"%3F").replace(/\￥/g,"%ef%bf%a5").replace(/\$/g,"%24").replace(/\！/g,"%ef%bc%81").replace(/\（/g,"%ef%bc%88").replace(/\）/g,"%ef%bc%89").replace(/\…/g,"%e2%80%a6%e2%80%a6");
                                var fileExtensionName=attName.substring(0,attName.lastIndexOf("."));
                                var deUrl = data[i].attUrl.split('&ATTACHMENT_NAME=')[0]+"&ATTACHMENT_NAME="+fileExtensionName+"."+fileExtension+"&FILESIZE="+data[i].size;

                                str += '<div class="dech" deUrl="' + deUrl+ '"><img class="preview" style="width: 100px;" src="/xs?'+encodeURI(deUrl)+'"">' +
                                    '<a href="/download?'+encodeURI(deUrl)+'" NAME="' + data[i].attachName + '*" style="text-decoration:none;margin-left:5px;"><img  src="/img/attachment_icon.png"/>' + data[i].attachName + '</a><img class="deImgs" style="margin-left:5px;cursor: pointer;" src="/img/file/icon_deletecha_03.png"/><a fileExtension="'+fileExtension+'" onclick="pdurls($(this))"   href="javascript:;"  style="padding-left: 5px"><img src="/img/attachmentIcon/icon_skim.png" style="padding: 0 5px;">预览</a><a style="padding-left: 5px" href="/download?'+encodeURI(deUrl)+'" ><img src="/img/attachmentIcon/icon_down.png"  style="padding: 0 5px;">下载</a>' +
                                    /*'<input type="hidden" class="inHidden" value="' + data[i].aid + '@' + data[i].ym + '_' + data[i].attachId + ',">' +*/
                                    '<input type="hidden" class="inHidden" deUrl="' + data[i].attUrl+ '" attachId="' + data[i].attachId+ '" attachName="' + data[i].attachName+ '" size="' + data[i].size+ '"  fileName="'+data[i].attachName+'*" value="' + data[i].aid + '@' + data[i].ym + '_' + data[i].attachId + ',">' +
                                    '</div>';
                            }else { //后缀为这些的禁止上传
                                str += '';
                                layer.msg('只能上传图片!', {icon: 2, time: 1000});
                                /*layer.alert('只能上传图片!',{},function(){
                                    layer.closeAll();
                                });*/
                            }
                        }else {
                            if(gs == 'jsp'||gs == 'css'||gs == 'js'||gs == 'html'||gs == 'java'||gs == 'php' ){ //后缀为这些的禁止上传
                                str += '';
                                layer.alert('jsp、css、js、html、java文件禁止上传!',{},function(){
                                    layer.closeAll();
                                });
                            }
                            /* else if(data[i].attachName.indexOf('+')!=-1){
                                     alert("你上传的"+data[i].attachName+"文件有特殊字符'+',文件名中不可存在特殊字符,请重新上传");

                             }*/
                            else if(gs == 'png'||gs == 'jpg'||gs == 'bmp' || gs == 'emf' || gs == 'gif'|| gs == 'pcx'|| gs == 'pcd'|| gs == 'ai'|| gs == 'webp'|| gs == 'WMF'|| gs == 'dxf' ||gs == 'PNG'||gs == 'JPG'||gs == 'BMP' || gs == 'EMF' || gs == 'GIF'|| gs == 'PCX'|| gs == 'PCD'|| gs == 'AI'|| gs == 'WEBP'|| gs == 'wmf'|| gs == 'DXF'){
                                var fileExtension=data[i].attachName.substring(data[i].attachName.lastIndexOf(".")+1,data[i].attachName.length);//截取附件文件后缀
                                var attName = encodeURI(data[i].attachName).replace(/\+/g, "%2b").replace(/\@/g,"%40").replace(/\#/g,"%23").replace(/\&/g,"%26").replace(/\//g,"%2F").replace(/\?/g,"%3F").replace(/\￥/g,"%ef%bf%a5").replace(/\$/g,"%24").replace(/\！/g,"%ef%bc%81").replace(/\（/g,"%ef%bc%88").replace(/\）/g,"%ef%bc%89").replace(/\…/g,"%e2%80%a6%e2%80%a6");
                                var fileExtensionName=attName.substring(0,attName.lastIndexOf("."));
                                var deUrl = data[i].attUrl.split('&ATTACHMENT_NAME=')[0]+"&ATTACHMENT_NAME="+fileExtensionName+"."+fileExtension+"&FILESIZE="+data[i].size;

                                str += '<div class="dech" deUrl="' + deUrl+ '"><img class="preview" style="width: 100px;" src="/xs?'+encodeURI(deUrl)+'"">' +
                                    '<a href="/download?'+encodeURI(deUrl)+'" NAME="' + data[i].attachName + '*" style="text-decoration:none;margin-left:5px;"><img  src="/img/attachment_icon.png"/>' + data[i].attachName + '</a><img class="deImgs" style="margin-left:5px;cursor: pointer;" src="/img/file/icon_deletecha_03.png"/><a fileExtension="'+fileExtension+'" onclick="pdurls($(this))"   href="javascript:;"  style="padding-left: 5px"><img src="/img/attachmentIcon/icon_skim.png" style="padding: 0 5px;">预览</a><a style="padding-left: 5px" href="/download?'+encodeURI(deUrl)+'" ><img src="/img/attachmentIcon/icon_down.png"  style="padding: 0 5px;">下载</a>' +
                                    /*'<input type="hidden" class="inHidden" value="' + data[i].aid + '@' + data[i].ym + '_' + data[i].attachId + ',">' +*/
                                    '<input type="hidden" class="inHidden" deUrl="' + data[i].attUrl+ '" attachId="' + data[i].attachId+ '" attachName="' + data[i].attachName+ '" size="' + data[i].size+ '" fileName="'+data[i].attachName+'*" value="' + data[i].aid + '@' + data[i].ym + '_' + data[i].attachId + ',">' +
                                    '</div>';
                            } else{
                                var fileExtension=data[i].attachName.substring(data[i].attachName.lastIndexOf(".")+1,data[i].attachName.length);//截取附件文件后缀
                                var attName = encodeURI(data[i].attachName).replace(/\+/g, "%2b").replace(/\@/g,"%40").replace(/\#/g,"%23").replace(/\&/g,"%26").replace(/\//g,"%2F").replace(/\?/g,"%3F").replace(/\￥/g,"%ef%bf%a5").replace(/\$/g,"%24").replace(/\！/g,"%ef%bc%81").replace(/\（/g,"%ef%bc%88").replace(/\）/g,"%ef%bc%89").replace(/\…/g,"%e2%80%a6%e2%80%a6");
                                var fileExtensionName=attName.substring(0,attName.lastIndexOf("."));
                                var deUrl = data[i].attUrl.split('&ATTACHMENT_NAME=')[0]+"&ATTACHMENT_NAME="+fileExtensionName+"."+fileExtension+"&FILESIZE="+data[i].size;

                                str += '<div class="dech" deUrl="' + deUrl+ '"><a href="/download?'+encodeURI(deUrl)+'" NAME="' + data[i].attachName + '*" style="text-decoration:none;margin-left:5px;"><img  src="/img/attachment_icon.png"/>' + data[i].attachName + '</a><img class="deImgs" style="margin-left:5px;cursor: pointer;" src="/img/file/icon_deletecha_03.png"/><a fileExtension="'+fileExtension+'" onclick="pdurls($(this))"   href="javascript:;"  style="padding-left: 5px"><img src="/img/attachmentIcon/icon_skim.png" style="padding: 0 5px;">预览</a><a style="padding-left: 5px" href="/download?'+encodeURI(deUrl)+'" ><img src="/img/attachmentIcon/icon_down.png"  style="padding: 0 5px;">下载</a>' +
                                    /*'<input type="hidden" class="inHidden" value="' + data[i].aid + '@' + data[i].ym + '_' + data[i].attachId + ',">' +*/
                                    '<input type="hidden" class="inHidden" deUrl="' + data[i].attUrl+ '" attachId="' + data[i].attachId+ '" attachName="' + data[i].attachName+ '" size="' + data[i].size+ '" fileName="'+data[i].attachName+'*" value="' + data[i].aid + '@' + data[i].ym + '_' + data[i].attachId + ',">' +
                                    '</div>';
                            }
                        }
                    }
                    // $('.Attachment td').eq(1).append(str);
                    console.log(element)
                    element.append(str);
                }else{
                    layer.msg("添加附件大小不能为空!")
                }
                //     layer.alert('添加附件大小不能为空!',{},function(){
                //         layer.closeAll();
                //     });
                // }
            }else {
                if(data.result.datas != ''){
                    var data = data.result.datas;
                    var str = '';
                    var str1 = '';
                    for (var i = 0; i < data.length; i++) {
                        var gs = data[0].attachName.substring(data[0].attachName.lastIndexOf(".")+1);
                        if(type&&type==1){
                            if(gs == 'png'||gs == 'jpg'||gs == 'bmp' || gs == 'emf' || gs == 'gif'|| gs == 'pcx'|| gs == 'pcd'|| gs == 'ai'|| gs == 'webp'|| gs == 'WMF'|| gs == 'dxf' ||gs == 'PNG'||gs == 'JPG'||gs == 'BMP' || gs == 'EMF' || gs == 'GIF'|| gs == 'PCX'|| gs == 'PCD'|| gs == 'AI'|| gs == 'WEBP'|| gs == 'wmf'|| gs == 'DXF'){
                                var fileExtension=data[i].attachName.substring(data[i].attachName.lastIndexOf(".")+1,data[i].attachName.length);//截取附件文件后缀
                                var attName = encodeURI(data[i].attachName).replace(/\+/g, "%2b").replace(/\@/g,"%40").replace(/\#/g,"%23").replace(/\&/g,"%26").replace(/\//g,"%2F").replace(/\?/g,"%3F").replace(/\￥/g,"%ef%bf%a5").replace(/\$/g,"%24").replace(/\！/g,"%ef%bc%81").replace(/\（/g,"%ef%bc%88").replace(/\）/g,"%ef%bc%89").replace(/\…/g,"%e2%80%a6%e2%80%a6");
                                var fileExtensionName=attName.substring(0,attName.lastIndexOf("."));
                                var deUrl = data[i].attUrl.split('&ATTACHMENT_NAME=')[0]+"&ATTACHMENT_NAME="+fileExtensionName+"."+fileExtension+"&FILESIZE="+data[i].size;

                                str += str += '<div class="dech" deUrl="' + deUrl+ '"><img class="preview" style="width: 100px;" src="/xs?'+encodeURI(deUrl)+'"">' +
                                    '<a href="/download?'+encodeURI(deUrl)+'" NAME="' + data[i].attachName + '*" style="text-decoration:none;margin-left:5px;"><img  src="/img/attachment_icon.png"/>' + data[i].attachName + '</a><img class="deImgs" style="margin-left:5px;cursor: pointer;" src="/img/file/icon_deletecha_03.png"/><a fileExtension="'+fileExtension+'" onclick="pdurls($(this))"   href="javascript:;"  style="padding-left: 5px"><img src="/img/attachmentIcon/icon_skim.png" style="padding: 0 5px;">预览</a><a style="padding-left: 5px" href="/download?'+encodeURI(deUrl)+'" ><img src="/img/attachmentIcon/icon_down.png"  style="padding: 0 5px;">下载</a>' +
                                    /*'<input type="hidden" class="inHidden" value="' + data[i].aid + '@' + data[i].ym + '_' + data[i].attachId + ',">' +*/
                                    '<input type="hidden" class="inHidden" deUrl="' + data[i].attUrl+ '" attachId="' + data[i].attachId+ '" attachName="' + data[i].attachName+ '" size="' + data[i].size+ '" fileName="'+data[i].attachName+'*" value="' + data[i].aid + '@' + data[i].ym + '_' + data[i].attachId + ',">' +
                                    '</div>';
                            }else { //后缀为这些的禁止上传
                                str += '';
                                layer.msg('只能上传图片!', {icon: 2, time: 1000});
                                /*layer.alert('只能上传图片!',{},function(){
                                    layer.closeAll();
                                });*/
                            }
                        }else {
                            if(gs == 'jsp'||gs == 'css'||gs == 'js'||gs == 'html'||gs == 'java'||gs == 'php' ){ //后缀为这些的禁止上传
                                str += '';
                                layer.alert('jsp、css、js、html、java文件禁止上传!',{},function(){
                                    layer.closeAll();
                                });
                            }
                            /* else if(data[i].attachName.indexOf('+')!=-1){
                                     alert("你上传的"+data[i].attachName+"文件有特殊字符'+',文件名中不可存在特殊字符,请重新上传");

                             }*/
                            else if(gs == 'png'||gs == 'jpg'||gs == 'bmp' || gs == 'emf' || gs == 'gif'|| gs == 'pcx'|| gs == 'pcd'|| gs == 'ai'|| gs == 'webp'|| gs == 'WMF'|| gs == 'dxf' ||gs == 'PNG'||gs == 'JPG'||gs == 'BMP' || gs == 'EMF' || gs == 'GIF'|| gs == 'PCX'|| gs == 'PCD'|| gs == 'AI'|| gs == 'WEBP'|| gs == 'wmf'|| gs == 'DXF'){
                                var fileExtension=data[i].attachName.substring(data[i].attachName.lastIndexOf(".")+1,data[i].attachName.length);//截取附件文件后缀
                                var attName = encodeURI(data[i].attachName).replace(/\+/g, "%2b").replace(/\@/g,"%40").replace(/\#/g,"%23").replace(/\&/g,"%26").replace(/\//g,"%2F").replace(/\?/g,"%3F").replace(/\￥/g,"%ef%bf%a5").replace(/\$/g,"%24").replace(/\！/g,"%ef%bc%81").replace(/\（/g,"%ef%bc%88").replace(/\）/g,"%ef%bc%89").replace(/\…/g,"%e2%80%a6%e2%80%a6");
                                var fileExtensionName=attName.substring(0,attName.lastIndexOf("."));
                                var deUrl = data[i].attUrl.split('&ATTACHMENT_NAME=')[0]+"&ATTACHMENT_NAME="+fileExtensionName+"."+fileExtension+"&FILESIZE="+data[i].size;

                                str += '<div class="dech" deUrl="' + deUrl+ '"><img class="preview" style="width: 100px;" src="/xs?'+encodeURI(deUrl)+'"">' +
                                    '<a href="/download?'+encodeURI(deUrl)+'" NAME="' + data[i].attachName + '*" style="text-decoration:none;margin-left:5px;"><img  src="/img/attachment_icon.png"/>' + data[i].attachName + '</a><img class="deImgs" style="margin-left:5px;cursor: pointer;" src="/img/file/icon_deletecha_03.png"/><a fileExtension="'+fileExtension+'" onclick="pdurls($(this))"   href="javascript:;"  style="padding-left: 5px"><img src="/img/attachmentIcon/icon_skim.png" style="padding: 0 5px;">预览</a><a style="padding-left: 5px" href="/download?'+encodeURI(deUrl)+'" ><img src="/img/attachmentIcon/icon_down.png"  style="padding: 0 5px;">下载</a>' +
                                    /*'<input type="hidden" class="inHidden" value="' + data[i].aid + '@' + data[i].ym + '_' + data[i].attachId + ',">' +*/
                                    '<input type="hidden" class="inHidden" deUrl="' + data[i].attUrl+ '" attachId="' + data[i].attachId+ '" attachName="' + data[i].attachName+ '" size="' + data[i].size+ '" fileName="'+data[i].attachName+'*" value="' + data[i].aid + '@' + data[i].ym + '_' + data[i].attachId + ',">' +
                                    '</div>';
                            }else{
                                var fileExtension=data[i].attachName.substring(data[i].attachName.lastIndexOf(".")+1,data[i].attachName.length);//截取附件文件后缀
                                var attName = encodeURI(data[i].attachName).replace(/\+/g, "%2b").replace(/\@/g,"%40").replace(/\#/g,"%23").replace(/\&/g,"%26").replace(/\//g,"%2F").replace(/\?/g,"%3F").replace(/\￥/g,"%ef%bf%a5").replace(/\$/g,"%24").replace(/\！/g,"%ef%bc%81").replace(/\（/g,"%ef%bc%88").replace(/\）/g,"%ef%bc%89").replace(/\…/g,"%e2%80%a6%e2%80%a6");
                                var fileExtensionName=attName.substring(0,attName.lastIndexOf("."));
                                var deUrl = data[i].attUrl.split('&ATTACHMENT_NAME=')[0]+"&ATTACHMENT_NAME="+fileExtensionName+"."+fileExtension+"&FILESIZE="+data[i].size;

                                str += '<div class="dech" deUrl="' + deUrl+ '"><a href="/download?'+encodeURI(deUrl)+'" NAME="' + data[i].attachName + '*" style="text-decoration:none;margin-left:5px;"><img  src="/img/attachment_icon.png"/>' + data[i].attachName + '</a><img class="deImgs" style="margin-left:5px;cursor: pointer;" src="/img/file/icon_deletecha_03.png"/><a fileExtension="'+fileExtension+'" onclick="pdurls($(this))"   href="javascript:;"  style="padding-left: 5px"><img src="/img/attachmentIcon/icon_skim.png" style="padding: 0 5px;">预览</a><a style="padding-left: 5px" href="/download?'+encodeURI(deUrl)+'" ><img src="/img/attachmentIcon/icon_down.png"  style="padding: 0 5px;">下载</a>' +
                                    /*'<input type="hidden" class="inHidden" value="' + data[i].aid + '@' + data[i].ym + '_' + data[i].attachId + ',">' +*/
                                    '<input type="hidden" class="inHidden" deUrl="' + data[i].attUrl+ '" attachId="' + data[i].attachId+ '" attachName="' + data[i].attachName+ '" size="' + data[i].size+ '" fileName="'+data[i].attachName+'*" value="' + data[i].aid + '@' + data[i].ym + '_' + data[i].attachId + ',">' +
                                    '</div>';
                            }
                        }
                    }
                    // $('.Attachment td').eq(1).append(str);
                    console.log(element)
                    element.append(str);
                }else{
                    layer.msg("添加附件大小不能为空!")
                    // layer.alert('添加附件大小不能为空!',{},function(){
                    //     layer.closeAll();
                    // });
                }
            }

        }
    });
}
//回显附件
//data 附件list的数组
//返回拼接好的HTML字符串
function echoAttachment(data){
    if(!data) return ''
    var fileArr = data;
    var str = '';
    for (var i = 0; i < fileArr.length; i++) {
        var fileExtension = fileArr[i].attachName.substring(fileArr[i].attachName.lastIndexOf(".") + 1, fileArr[i].attachName.length);//截取附件文件后缀
        var attName = encodeURI(fileArr[i].attachName).replace(/\+/g, "%2b").replace(/\@/g, "%40").replace(/\#/g, "%23").replace(/\&/g, "%26").replace(/\//g, "%2F").replace(/\?/g, "%3F").replace(/\￥/g, "%ef%bf%a5").replace(/\$/g, "%24").replace(/\！/g, "%ef%bc%81").replace(/\（/g, "%ef%bc%88").replace(/\）/g, "%ef%bc%89").replace(/\…/g, "%e2%80%a6%e2%80%a6");
        var fileExtensionName = attName.substring(0, attName.lastIndexOf("."));
        var deUrl = fileArr[i].attUrl.split('&ATTACHMENT_NAME=')[0] + "&ATTACHMENT_NAME=" + fileExtensionName + "." + fileExtension + "&FILESIZE=" + fileArr[i].size;

        var gs = fileExtension
        if(gs == 'png'||gs == 'jpg'||gs == 'bmp' || gs == 'emf' || gs == 'gif'|| gs == 'pcx'|| gs == 'pcd'|| gs == 'ai'|| gs == 'webp'|| gs == 'WMF'|| gs == 'dxf' ||gs == 'PNG'||gs == 'JPG'||gs == 'BMP' || gs == 'EMF' || gs == 'GIF'|| gs == 'PCX'|| gs == 'PCD'|| gs == 'AI'|| gs == 'WEBP'|| gs == 'wmf'|| gs == 'DXF'){
            str += '<div class="dech" deUrl="' + deUrl+ '"><img class="preview" style="width: 100px;" src="/xs?'+encodeURI(deUrl)+'"">' +
                '<a href="/download?'+encodeURI(deUrl)+'" NAME="' + fileArr[i].attachName + '*" style="text-decoration:none;margin-left:5px;"><img  src="/img/attachment_icon.png"/>' + fileArr[i].attachName + '</a><img class="deImgs" style="margin-left:5px;cursor: pointer;" src="/img/file/icon_deletecha_03.png"/>' +
                '<a fileExtension="'+fileExtension+'" onclick="pdurls($(this))"   href="javascript:;"  style="padding-left: 5px"><img src="/img/attachmentIcon/icon_skim.png" style="padding: 0 5px;">查阅</a>' +
                '<a style="padding-left: 5px" href="/download?'+encodeURI(deUrl)+'" ><img src="/img/attachmentIcon/icon_down.png"  style="padding: 0 5px;">下载</a>' +
                '<input type="hidden" class="inHidden" deUrl="' +fileArr[i].attUrl+ '" attachId="' +fileArr[i].attachId+ '" attachName="' +fileArr[i].attachName+ '" size="' +fileArr[i].size+ '" fileName="'+data[i].attachName+'*" value="' +fileArr[i].aid + '@' +fileArr[i].ym + '_' +fileArr[i].attachId + ',">' +
                '</div>';
        }else {
            /*str += '<div class="dech" deUrl="' + deUrl + '"><a href="/download?' + encodeURI(deUrl) + '" NAME="' + fileArr[i].attachName + '*" style="text-decoration:none;margin-left:5px;"><img src="/img/attachment_icon.png"/>' + fileArr[i].attachName + '</a><img class="deImgs" style="margin-left:5px;cursor: pointer;" src="/img/file/icon_deletecha_03.png"/><input type="hidden" class="inHidden" value="' + fileArr[i].aid + '@' + fileArr[i].ym + '_' + fileArr[i].attachId + ',"></div>';*/
            str += '<div class="dech" deUrl="' + deUrl+ '"><a href="/download?'+encodeURI(deUrl)+'" NAME="' + fileArr[i].attachName + '*" style="text-decoration:none;margin-left:5px;"><img  src="/img/attachment_icon.png"/>' + fileArr[i].attachName + '</a><img class="deImgs" style="margin-left:5px;cursor: pointer;" src="/img/file/icon_deletecha_03.png"/>' +
                '<a fileExtension="'+fileExtension+'" onclick="pdurls($(this))"   href="javascript:;"  style="padding-left: 5px"><img src="/img/attachmentIcon/icon_skim.png" style="padding: 0 5px;">查阅</a>' +
                '<input type="hidden" class="inHidden" deUrl="' +fileArr[i].attUrl+ '" attachId="' +fileArr[i].attachId+ '" attachName="' +fileArr[i].attachName+ '" size="' +fileArr[i].size+ '" fileName="'+data[i].attachName+'*" value="' +fileArr[i].aid + '@' +fileArr[i].ym + '_' +fileArr[i].attachId + ',">' +
                '</div>';
        }

    }
    return str
}
// 预览图片
$(document).on('click', '.preview', function () {
    var deUrl = $(this).attr("src").split('?')[1];
    layui.layer.open({
        type: 2,
        title: '预览',
        content: "/xs?"+encodeURI(deUrl),
        offset:["20px",""],
        area: ['70%', '90%'],
        success:function(layero, index){
            var iframeWindow = window['layui-layer-iframe'+ index];
            var doc = $(iframeWindow.document);
            doc.find('img').css("width","100%");
        }
    })
})
//删除附件
$(document).on('click', '.deImgs', function () {
    var _this = this;
    var attUrl = $(this).parents('.dech').attr('deUrl');
    layer.confirm('确定删除该附件吗？', function (index) {
        $.ajax({
            type: 'get',
            url: '/delete?' + attUrl,
            dataType: 'json',
            success: function (res) {
                if (res.flag == true) {
                    layer.msg('删除成功', {icon: 6, time: 1000});
                    $(_this).parents('.dech').remove();
                } else {
                    layer.msg('删除失败', {icon: 2, time: 1000});
                }
            }
        })
    });
});
// function pdurls(_this){ //根据后缀判断选择调取那种打开方式
//     var atturl=_this.parents('.dech').attr('deUrl')
//     if(atturl != undefined&&atturl.indexOf('&ATTACHMENT_NAME=') > -1){
//         var atturl1 = atturl.split('&ATTACHMENT_NAME=')[0] + '&ATTACHMENT_NAME=';
//         var atturl2 = '';
//         if(atturl.split('&ATTACHMENT_NAME=')[1] != undefined&&atturl.split('&ATTACHMENT_NAME=')[1].indexOf('&') > -1){
//             for(var i=1;i<atturl.split('&ATTACHMENT_NAME=')[1].split('&').length;i++){
//                 atturl2 += '&' + atturl.split('&ATTACHMENT_NAME=')[1].split('&')[i];
//             }
//             atturl = atturl1 + atturl2;
//         }else{
//             atturl = atturl1;
//         }
//     }
//     var gs=_this.attr('fileExtension')
//     if(gs == 'png'||gs == 'jpg'||gs == 'bmp' || gs == 'emf' || gs == 'gif'|| gs == 'pcx'|| gs == 'pcd'|| gs == 'ai'|| gs == 'webp'|| gs == 'WMF'|| gs == 'dxf' ||gs == 'PNG'||gs == 'JPG'||gs == 'BMP' || gs == 'EMF' || gs == 'GIF'|| gs == 'PCX'|| gs == 'PCD'|| gs == 'AI'|| gs == 'WEBP'|| gs == 'wmf'|| gs == 'DXF'|| gs == 'txt'|| gs == 'TXT'){
//         $.popWindow("/xs?"+atturl,PreviewPage,'0','0','1200px','600px');
//     }else if(gs == 'mp4'||gs == 'rmvb'||gs == 'avi'||gs == 'ifo'||gs == 'wmv'||gs == 'MP4'||gs == 'RMVB'||gs == 'AVI'||gs == 'IFO'||gs == 'WMV'){
//         layer.open({type: 2, title: false, area: ['630px', '360px'], shade: 0.8, closeBtn: 0, shadeClose: true, content: "/common/video?videoatturlsplit="+atturl});
//         layer.msg('点击任意处关闭');
//     }else if(gs == 'pdf'||gs == 'PDF'){
//         $.popWindow("/pdfPreview?"+atturl,PreviewPage,'0','0','1200px','600px');
//     }else{
//         var url = "/common/webOfficeView?documentEditPriv=0&fomat="+gs+"&"+atturl;
//         $.ajax({
//             url:'/syspara/selectTheSysPara?paraName=OFFICE_EDIT',
//             type:'post',
//             datatype:'json',
//             async:false,
//             success: function (res) {
//                 if(res.flag){
//                     if(res.object[0].paraValue == 0){
//                         //默认加载NTKO插件 进行跳转
//                         url = "/common/ntkoview?documentEditPriv=0&fomat="+gs+"&"+atturl;
//                     }else if(res.object[0].paraValue == 2){
//                         //默认加载NTKO插件 进行跳转
//                         url = "/wps/info?"+ atturl +"&permission=read";
//                     }else if(res.object[0].paraValue == 3){
//
//                         //默认加载NTKO插件 进行跳转
//                         url = "/common/onlyoffice?"+ atturl +"&edit=false";
//                     }
//                 }
//
//             }
//         })
//         $.popWindow(url,PreviewPage,'0','0','1200px','600px');
//     }
// }
function pdurls(_this,workNum) { //附件预览点击调取
    var attrUrl=_this.parents('.dech').attr('deUrl')
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
    // var type = UrlGetRequest('?'+attrUrl)||'docx';
    // type = type.toLowerCase();
    var type=_this.attr('fileExtension');
    if(type == 'pdf'){
        //$.popWindow('/common/pdfPreview?'+url.split('&COMPANY=')[0],'','0','0','1200px','600px');
        $.popWindow("/common/PDFBrowser?"+url,PreviewPage,'0','0','1200px','600px');
    }else if(type == 'png' || type == 'jpg' ||  type == 'txt'){
        $.popWindow("/xs?"+url,PreviewPage,'0','0','1200px','600px');
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

/**
 *@Date 2021/11/24
 *判断当前登录系统是否是指定系统
 *@Author cdh
 *@Version 1.0
 *
 */
function isOrg(orgName){
    if(orgName){
        var flag = false;
        $.ajax({
            url: '/syspara/selectTheSysPara?paraName=MYPROJECT',
            dataType: 'json',
            type: 'post',
            async:false,
            success: function (res) {
                if(res.object&&res.object[0]&&res.object[0].paraValue&&res.object[0].paraValue==orgName){
                    flag = true;
                }
            }
        });
        return flag;
    }
    return false;
}