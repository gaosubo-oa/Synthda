/*附件显示*/
var officeArr=['word','WORD','doc','DOC','docx','DOCX','xlsx','XLSX','xls','XLS','txt','TXT','png','PNG','jpg','JPG','pdf','PDF','ppt','PPT','pptx','PPTX','ofd','OFD'];
officeArr = officeArr.toString();
var attachViewType= '';
var strOfficeApps = '';
var documentPreviewOpen = 0;
function checkIP(value){
    var exp = /^(25[0-5]|2[0-4][0-9]|[0-1]{1}[0-9]{2}|[1-9]{1}[0-9]{1}|[1-9]).(25[0-5]|2[0-4][0-9]|[0-1]{1}[0-9]{2}|[1-9]{1}[0-9]{1}|[1-9]|0).(25[0-5]|2[0-4][0-9]|[0-1]{1}[0-9]{2}|[1-9]{1}[0-9]{1}|[1-9]|0).(25[0-5]|2[0-4][0-9]|[0-1]{1}[0-9]{2}|[1-9]{1}[0-9]{1}|[0-9])$/;
    var reg = value.match(exp);
    if (reg == null) {
        return false;
    }
}
function attachView(attachmentArr,attachmentBox,styleType,editJurisdiction,downJurisdiction,deleteJurisdiction,arr1,wenjiangui) {

    //attachmentArr：附件集合；attachmentBox：承载附件显示的div的ID；styleType：附件显示样式；editJurisdiction：编辑权限；downJurisdiction下载权限；deleteJurisdiction：删除权限
    var attachmentName='',previewBtn='',consuilBtn='',editBtn='',downBtn='',deleteBtn='',floatDiv='',TransferBtn='';
    //attachmentName：附件名称显示；previewBtn:：预览按钮；consuilBtn：查阅按钮；editBtn：编辑按钮；downBtn：下载按钮；deleteBtn：删除按钮；TransferBtn:转存按钮
    var str='';
    var openimg = ''
    var picNum = 0;
    var picNumWen = 0;
    if(wenjiangui == 'wenjiangui'){
        var attachmentUrl;
        for(var j = 0; j < attachmentArr.length; j++){
            if(attachmentArr[j] != undefined){
                 attachmentUrl =attachmentArr[j].attUrl; //获取附件地址
            }else{
                attachmentUrl = '';
            }
            var fileExtension=('?'+attachmentUrl).substring(('?'+attachmentUrl).lastIndexOf(".")+1,('?'+attachmentUrl).length);//截取附件文件后缀
            fileExtension = fileExtension.toLocaleLowerCase();
            var domain = document.location.origin;
            if(fileExtension == 'png' || fileExtension == 'PNG' || fileExtension == 'jpg') {
                openimg+= domain+'/xs?'+attachmentUrl+'*'
            }
        }
    }else {
        for(var j=0;j<attachmentArr.length;j++){
            var attachmentUrl =attachmentArr[j].attUrl; //获取附件地址
            var fileExtension=('?'+attachmentUrl).substring(('?'+attachmentUrl).lastIndexOf(".")+1,('?'+attachmentUrl).length);//截取附件文件后缀
            var domain = document.location.origin;
            fileExtension = fileExtension.toLocaleLowerCase();
            if(fileExtension == 'png' || fileExtension == 'PNG' || fileExtension == 'jpg') {
                openimg+= domain+'/xs?'+attachmentUrl+'*'
            }
        }
    }

    // openNmu = 0

    for(var i=0;i<attachmentArr.length;i++){ //循环附件集合
        var attachmentUrl =attachmentArr[i].attUrl; //获取附件地址
        var fileExtension=('?'+attachmentUrl).substring(('?'+attachmentUrl).lastIndexOf(".")+1,('?'+attachmentUrl).length);//截取附件文件后缀
        var attName = encodeURI(attachmentArr[i].attachName).replace(/\+/g, "%2b").replace(/\@/g,"%40").replace(/\#/g,"%23").replace(/\&/g,"%26").replace(/\//g,"%2F").replace(/\?/g,"%3F").replace(/\￥/g,"%ef%bf%a5").replace(/\$/g,"%24").replace(/\！/g,"%ef%bc%81").replace(/\（/g,"%ef%bc%88").replace(/\）/g,"%ef%bc%89").replace(/\…/g,"%e2%80%a6%e2%80%a6");
        attachmentUrl = attachmentUrl.substring(0,attachmentUrl.lastIndexOf("ATTACHMENT_NAME="))+"ATTACHMENT_NAME="+attName; //处理附件名字
        var fileIcon='';
        fileExtension = fileExtension.toLocaleLowerCase();
        if(datatyoe[fileExtension] == undefined){ //处理附件图标
            fileIcon='file';
        }else{
            fileIcon=datatyoe[fileExtension];
        }
        var size = attachmentArr[i].size == ''?'': '('+attachmentArr[i].size+')';
        attachmentName ='<a class="file_a"><img class="img_" src="/img/attachmentIcon/'+fileIcon+'.png" style="vertical-align: middle;"/><span style="margin-left: 10px">' + attachmentArr[i].attachName + '</span><span style="margin-left: 5px;">'+size+'</span></a>';
        if(editJurisdiction == '1'){ //判断编辑权限
            if(fileExtension == 'doc' || fileExtension == 'DOC'|| fileExtension == 'docx' || fileExtension == 'DOCX'|| fileExtension == 'xls' || fileExtension == 'XLS'|| fileExtension == 'xlsx' || fileExtension == 'XLSX'|| fileExtension == 'ppt' || fileExtension == 'PPT'|| fileExtension == 'pptx'|| fileExtension == 'PPTX'){
                editBtn='<a class="operation" href="javascript:;" onclick="editAttachment($(this),'+downJurisdiction+')" class="editFile" style="margin-left: 10px;" attrurl="' + attachmentUrl + '"><img src="/img/attachmentIcon/icon_edit.png" style="margin-right: 5px;" alt="">'+edit1+'</a>';
            }else{
                editBtn='';
            }
        }else{
            editBtn='';
        }


        if(downJurisdiction == '1'){ //判断下载权限
            downBtn='<a class="operation download" style="margin-left: 10px;" href="/download?' + encodeURI(attachmentUrl) + '"><img src="/img/attachmentIcon/icon_down.png" style="margin-right: 5px;" alt="">'+email_th_download+'</a>';
            //转存  转存权限和 下载权限一致
            TransferBtn = '<a class="operation saveto" onclick="transfer($(this))" href="javascript:;" attrurl="' + encodeURI(attachmentUrl) +'" style="margin-left: 10px"><img src="/img/attachmentIcon/tran.png" style="margin-right: 5px;" alt="">'+email_th_transfer_and_save+'</a>'
        }else{
            downBtn='';
            TransferBtn='';
        }
        if(deleteJurisdiction == '1'){ //判断删除权限
            deleteBtn='<a class="operation" onclick="deleteAttachment($(this))" href="javascript:;" class="deleteFile" style="margin-left: 10px;" attrurl="' + encodeURI(attachmentUrl) + '">'+del+'</a>'
        }else{
            deleteBtn='';
        }



        if(officeArr.indexOf(fileExtension) > -1){ //判断是否为可读文件

            previewBtn='';
            // if(fileExtension == 'png' || fileExtension == 'PNG' || fileExtension == 'jpg') {
            //     openimg+= domain+'/xs?'+attachmentUrl+'*'
            // }
            if(attachViewType != '0'&&documentPreviewOpen != 0){
                previewBtn='<a class="operation" onclick="preview($(this))" href="javascript:;" attrurl="' + encodeURI(attachmentUrl) +'" style="margin-left: 10px"><img src="/img/attachmentIcon/icon_skim.png" style="margin-right: 5px;" alt="">'+yulan+'</a>';
            }
            if(fileExtension == 'pdf' || fileExtension == 'PDF'  || fileExtension == 'txt'|| fileExtension == 'TXT'){ //判断是否需要查阅
                previewBtn='';
                consuilBtn='<a class="operation" onclick="consult($(this))" downloadPriv="'+ downJurisdiction +'" style="margin-left: 10px" attrurl="' + attachmentUrl + '" href="javascript:;"><img src="/img/attachmentIcon/attachPreview.png" style="margin-right: 5px;" alt="">'+yulan+'</a>';
            }else if(fileExtension == 'ofd' || fileExtension == 'OFD'||fileExtension == 'oFd' || fileExtension == 'oFD' ){ //判断是否需要查阅
                previewBtn='';
                consuilBtn='<a class="operation" onclick="consult($(this))" style="margin-left: 10px" attrurl="' + attachmentUrl + '" href="javascript:;"><img src="/img/attachmentIcon/attachPreview.png" style="margin-right: 5px;" alt="">'+yulan+'</a>';
            }else{
                consuilBtn='<a class="operation" onclick="consult($(this))" style="margin-left: 10px" attrurl="' + attachmentUrl + '" href="javascript:;"><img src="/img/attachmentIcon/attachPreview.png" style="margin-right: 5px;" alt="">'+email_th_refer_to+'</a>';
            }
            if(fileExtension == 'png' || fileExtension == 'PNG' || fileExtension == 'jpg'|| fileExtension == 'JPG'){
                previewBtn='';
                var domain = document.location.origin;

                if(wenjiangui == 'wenjiangui'){
                    picNums = picNumWen
                    picNumWen++
                }else {
                    var picNums = picNum;
                    picNum = picNum+1;
                }
                consuilBtn='<a class="operation operationImg"  style="margin-left: 10px" attrurl="' + attachmentUrl + '" href="javascript:;"><img src="/img/attachmentIcon/attachPreview.png" style="margin-right: 5px;" alt="">'+yulan+'</a>'+
                    '<img openimg="'+openimg+'"  openNmu = "'+picNums+'"  class="operation"  src="'+domain+attachmentUrl+'" style="margin-left: 10px;display: none" attrurl="' + attachmentUrl + '" href="javascript:;"></img>';
                // openNmu++
            }
            if(styleType == '3'){
                str+='<div class="divShow" style="position: relative;"><a href="javascript:;" class="fujian" style="display:block;word-break: break-all;color: #54b6fe;" title="'+attachmentArr[i].attachName+'&nbsp;&nbsp;&nbsp;'+attachmentArr[i].size+'"><img style="margin-right:5px;" src="/img/attachmentIcon/'+fileIcon+'.png"/>'+attachmentArr[i].attachName+'<span style="margin-left: 5px;">('+attachmentArr[i].size +')</span></a>' +
                    '<div class="operationDiv" style="display:none;">'+previewBtn + consuilBtn + editBtn + downBtn + deleteBtn + TransferBtn +'</div>' +
                    '</div>';
            }else{
                str+='<div class="font_" style="display: block">' + attachmentName + previewBtn + consuilBtn + editBtn + downBtn + deleteBtn +TransferBtn+ '</div>';
            }
        }else{
            if(styleType == '3'){
                if(fileExtension == 'mp4') {
                    str+='<div class="divShow" style="position: relative;">' +
                        '<a href="javascript:;" class="fujian" style="display:block;word-break: break-all;color: #54b6fe;" title="'+attachmentArr[i].attachName+'&nbsp;&nbsp;&nbsp;'+attachmentArr[i].size+'">' +
                        '<img style="margin-right:5px;" src="../img/attachmentIcon/'+fileIcon+'.png"/>'+attachmentArr[i].attachName+
                        '<span style="margin-left: 5px;">('+attachmentArr[i].size +')</span>' +
                        '</a>' +
                        '<div class="operationDiv" style="display:none;">'+ downBtn + deleteBtn +TransferBtn+'<a class="operation" href="javascript:;" id="bf" style="margin-left: 10px;" attrurl=' + encodeURI(attachmentUrl) + '>'+attach_th_play+'</a></div>' +
                        '</div>';
                }else if(fileExtension=='mp3') {
                    str+='<div class="divShow" style="position: relative;">' +
                        '<a href="javascript:;" class="fujian" style="display:block;word-break: break-all;color: #54b6fe;" title="'+attachmentArr[i].attachName+'&nbsp;&nbsp;&nbsp;'+attachmentArr[i].size+'">' +
                        '<img style="margin-right:5px;" src="../img/attachmentIcon/'+fileIcon+'.png"/>'+attachmentArr[i].attachName+
                        '<span style="margin-left: 5px;">('+attachmentArr[i].size +')</span>' +
                        '</a>' +
                        '<div class="operationDiv" style="display:none;">'+ downBtn + deleteBtn +TransferBtn+'<a class="operation" href="javascript:;" id="bfyp" style="margin-left: 10px;" attrurl=' + encodeURI(attachmentUrl) + '>'+attach_th_play+'</a></div>' +
                        '</div>';
                }else {
                    str+='<div class="divShow" style="position: relative;">' +
                        '<a href="javascript:;" class="fujian" style="display:block;word-break: break-all;color: #54b6fe;" title="'+attachmentArr[i].attachName+'&nbsp;&nbsp;&nbsp;'+attachmentArr[i].size+'">' +
                        '<img style="margin-right:5px;" src="../img/attachmentIcon/'+fileIcon+'.png"/>'+attachmentArr[i].attachName+
                        '<span style="margin-left: 5px;">('+attachmentArr[i].size +')</span>' +
                        '</a>' +
                        '<div class="operationDiv" style="display:none;">'+ downBtn + deleteBtn +TransferBtn+'</div>' +
                        '</div>';
                }

            }else{
                str+='<div class="font_" style="display: block">' + attachmentName + downBtn + deleteBtn +TransferBtn+ '</div>';
            }
        }
    }
    if(styleType == '1'){ //判断样式
        attachmentBox.html(str);
    }else if(styleType == '2'){
        attachmentBox.html('<div class="font_"  style="display: block"><span class="attachTxt" style="float: left;">'+attach_th_attachmentFile+'：</span><div style="float: left;">'+str+'</div></div>')
    }else{
        return str;
    }
}


function attachViewChatRecord(attachmentArr,attachmentBox,styleType,editJurisdiction,downJurisdiction,deleteJurisdiction,arr1,wenjiangui) {

    //attachmentArr：附件集合；attachmentBox：承载附件显示的div的ID；styleType：附件显示样式；editJurisdiction：编辑权限；downJurisdiction下载权限；deleteJurisdiction：删除权限
    var attachmentName='',previewBtn='',consuilBtn='',editBtn='',downBtn='',deleteBtn='',floatDiv='',TransferBtn='';
    //attachmentName：附件名称显示；previewBtn:：预览按钮；consuilBtn：查阅按钮；editBtn：编辑按钮；downBtn：下载按钮；deleteBtn：删除按钮；TransferBtn:转存按钮
    var str='';
    var openimg = ''
    var picNum = 0;
    var picNumWen = 0;
    if(wenjiangui == 'wenjiangui'){
        var attachmentUrl;
        for(var j = 0; j < arr1.length; j++){
            if(arr1[j] != undefined){
                attachmentUrl =arr1[j].attUrl; //获取附件地址
            }else{
                attachmentUrl = '';
            }
            var fileExtension=('?'+attachmentUrl).substring(('?'+attachmentUrl).lastIndexOf(".")+1,('?'+attachmentUrl).length);//截取附件文件后缀
            fileExtension = fileExtension.toLocaleLowerCase();
            var domain = document.location.origin;
            if(fileExtension == 'png' || fileExtension == 'PNG' || fileExtension == 'jpg') {
                openimg+= domain+'/xs?'+attachmentUrl+'*'
            }
        }
    }else {
        for(var j=0;j<attachmentArr.length;j++){
            var attachmentUrl =attachmentArr[j].file_url; //获取附件地址
            var fileExtension=('?'+attachmentUrl).substring(('?'+attachmentUrl).lastIndexOf(".")+1,('?'+attachmentUrl).length);//截取附件文件后缀
            var domain = document.location.origin;
            fileExtension = fileExtension.toLocaleLowerCase();
            if(fileExtension == 'png' || fileExtension == 'PNG' || fileExtension == 'jpg') {
                openimg+= domain+'/xs?'+attachmentUrl+'*'
            }
        }
    }
    // openNmu = 0

    for(var i=0;i<attachmentArr.length;i++){ //循环附件集合
        var attachmentUrl =attachmentArr[i].file_url; //获取附件地址
        var fileExtension=('?'+attachmentUrl).substring(('?'+attachmentUrl).lastIndexOf(".")+1,('?'+attachmentUrl).length);//截取附件文件后缀
        var attName = encodeURI(attachmentArr[i].file_name).replace(/\+/g, "%2b").replace(/\@/g,"%40").replace(/\#/g,"%23").replace(/\&/g,"%26").replace(/\//g,"%2F").replace(/\?/g,"%3F").replace(/\￥/g,"%ef%bf%a5").replace(/\$/g,"%24").replace(/\！/g,"%ef%bc%81").replace(/\（/g,"%ef%bc%88").replace(/\）/g,"%ef%bc%89").replace(/\…/g,"%e2%80%a6%e2%80%a6");
        attachmentUrl = attachmentUrl.substring(0,attachmentUrl.lastIndexOf("ATTACHMENT_NAME="))+"ATTACHMENT_NAME="+attName; //处理附件名字
        var fileIcon='';
        fileExtension = fileExtension.toLocaleLowerCase();
        if(datatyoe[fileExtension] == undefined){ //处理附件图标
            fileIcon='file';
        }else{
            fileIcon=datatyoe[fileExtension];
        }
        var size = attachmentArr[i].file_size == ''?'': '('+attachmentArr[i].file_size+')';
        attachmentName ='<a class="file_a"><img class="img_" src="/img/attachmentIcon/'+fileIcon+'.png" style="vertical-align: middle;"/><span style="margin-left: 10px">' + attachmentArr[i].file_name + '</span><span style="margin-left: 5px;">'+size+'</span></a>';
        if(editJurisdiction == '1'){ //判断编辑权限
            if(fileExtension == 'doc' || fileExtension == 'DOC'|| fileExtension == 'docx' || fileExtension == 'DOCX'|| fileExtension == 'xls' || fileExtension == 'XLS'|| fileExtension == 'xlsx' || fileExtension == 'XLSX'|| fileExtension == 'ppt' || fileExtension == 'PPT'|| fileExtension == 'pptx'|| fileExtension == 'PPTX'){
                editBtn='<a class="operation" href="javascript:;" onclick="editAttachment($(this),'+downJurisdiction+')" class="editFile" style="margin-left: 10px;" attrurl="' + attachmentUrl + '"><img src="/img/attachmentIcon/icon_edit.png" style="margin-right: 5px;" alt="">'+edit1+'</a>';
            }else{
                editBtn='';
            }
        }else{
            editBtn='';
        }


        if(downJurisdiction == '1'){ //判断下载权限
            downBtn='<a class="operation download" style="margin-left: 10px;" href="/download?' + encodeURI(attachmentUrl) + '"><img src="/img/attachmentIcon/icon_down.png" style="margin-right: 5px;" alt="">'+email_th_download+'</a>';
            //转存  转存权限和 下载权限一致
            TransferBtn = '<a class="operation saveto" onclick="transfer($(this))" href="javascript:;" attrurl="' + encodeURI(attachmentUrl) +'" style="margin-left: 10px"><img src="/img/attachmentIcon/tran.png" style="margin-right: 5px;" alt="">'+email_th_transfer_and_save+'</a>'
        }else{
            downBtn='';
            TransferBtn='';
        }
        if(deleteJurisdiction == '1'){ //判断删除权限
            deleteBtn='<a class="operation" onclick="deleteAttachment($(this))" href="javascript:;" class="deleteFile" style="margin-left: 10px;" attrurl="' + encodeURI(attachmentUrl) + '">'+del+'</a>'
        }else{
            deleteBtn='';
        }



        if(officeArr.indexOf(fileExtension) > -1){ //判断是否为可读文件

            previewBtn='';
            // if(fileExtension == 'png' || fileExtension == 'PNG' || fileExtension == 'jpg') {
            //     openimg+= domain+'/xs?'+attachmentUrl+'*'
            // }
            if(attachViewType != '0'&&documentPreviewOpen != 0){
                previewBtn='<a class="operation" onclick="preview($(this))" href="javascript:;" attrurl="' + encodeURI(attachmentUrl) +'" style="margin-left: 10px"><img src="/img/attachmentIcon/icon_skim.png" style="margin-right: 5px;" alt="">'+yulan+'</a>';
            }
            if(fileExtension == 'pdf' || fileExtension == 'PDF'  || fileExtension == 'txt'|| fileExtension == 'TXT'){ //判断是否需要查阅
                previewBtn='';
                consuilBtn='<a class="operation" onclick="consult($(this))" downloadPriv="'+ downJurisdiction +'" style="margin-left: 10px" attrurl="' + attachmentUrl + '" href="javascript:;"><img src="/img/attachmentIcon/attachPreview.png" style="margin-right: 5px;" alt="">'+yulan+'</a>';
            }else if(fileExtension == 'ofd' || fileExtension == 'OFD'||fileExtension == 'oFd' || fileExtension == 'oFD' ){ //判断是否需要查阅
                previewBtn='';
                consuilBtn='<a class="operation" onclick="consult($(this))" style="margin-left: 10px" attrurl="' + attachmentUrl + '" href="javascript:;"><img src="/img/attachmentIcon/attachPreview.png" style="margin-right: 5px;" alt="">'+yulan+'</a>';
            }else{
                consuilBtn='<a class="operation" onclick="consult($(this))" style="margin-left: 10px" attrurl="' + attachmentUrl + '" href="javascript:;"><img src="/img/attachmentIcon/attachPreview.png" style="margin-right: 5px;" alt="">'+email_th_refer_to+'</a>';
            }
            if(fileExtension == 'png' || fileExtension == 'PNG' || fileExtension == 'jpg'|| fileExtension == 'JPG'){
                previewBtn='';
                var domain = document.location.origin;

                if(wenjiangui == 'wenjiangui'){
                    picNums = picNumWen
                    picNumWen++
                }else {
                    var picNums = picNum;
                    picNum = picNum+1;
                }
                consuilBtn='<a class="operation operationImg"  style="margin-left: 10px" attrurl="' + attachmentUrl + '" href="javascript:;"><img src="/img/attachmentIcon/attachPreview.png" style="margin-right: 5px;" alt="">'+yulan+'</a>'+
                    '<img openimg="'+openimg+'"  openNmu = "'+picNums+'"  class="operation"  src="'+domain+attachmentUrl+'" style="margin-left: 10px;display: none" attrurl="' + attachmentUrl + '" href="javascript:;"></img>';
                // openNmu++
            }
            if(styleType == '3'){
                str+='<div class="divShow" style="position: relative;"><a href="javascript:;" class="fujian" style="display:block;word-break: break-all;color: #54b6fe;" title="'+attachmentArr[i].file_name+'&nbsp;&nbsp;&nbsp;'+attachmentArr[i].file_size+'"><img style="margin-right:5px;" src="/img/attachmentIcon/'+fileIcon+'.png"/>'+attachmentArr[i].file_name+'<span style="margin-left: 5px;">('+attachmentArr[i].file_size +')</span></a>' +
                    '<div class="operationDiv" style="display:none;">'+previewBtn + consuilBtn + editBtn + downBtn + deleteBtn + TransferBtn +'</div>' +
                    '</div>';
            }else{
                str+='<div class="font_" style="display: block">' + attachmentName + previewBtn + consuilBtn + editBtn + downBtn + deleteBtn +TransferBtn+ '</div>';
            }
        }else{
            if(styleType == '3'){
                if(fileExtension == 'mp4') {
                    str+='<div class="divShow" style="position: relative;">' +
                        '<a href="javascript:;" class="fujian" style="display:block;word-break: break-all;color: #54b6fe;" title="'+attachmentArr[i].file_name+'&nbsp;&nbsp;&nbsp;'+attachmentArr[i].file_size+'">' +
                        '<img style="margin-right:5px;" src="../img/attachmentIcon/'+fileIcon+'.png"/>'+attachmentArr[i].file_name+
                        '<span style="margin-left: 5px;">('+attachmentArr[i].file_size +')</span>' +
                        '</a>' +
                        '<div class="operationDiv" style="display:none;">'+ downBtn + deleteBtn +TransferBtn+'<a class="operation" href="javascript:;" id="bf" style="margin-left: 10px;" attrurl=' + encodeURI(attachmentUrl) + '>'+attach_th_play+'</a></div>' +
                        '</div>';
                }else if(fileExtension=='mp3') {
                    str+='<div class="divShow" style="position: relative;">' +
                        '<a href="javascript:;" class="fujian" style="display:block;word-break: break-all;color: #54b6fe;" title="'+attachmentArr[i].file_name+'&nbsp;&nbsp;&nbsp;'+attachmentArr[i].file_size+'">' +
                        '<img style="margin-right:5px;" src="../img/attachmentIcon/'+fileIcon+'.png"/>'+attachmentArr[i].file_name+
                        '<span style="margin-left: 5px;">('+attachmentArr[i].file_size +')</span>' +
                        '</a>' +
                        '<div class="operationDiv" style="display:none;">'+ downBtn + deleteBtn +TransferBtn+'<a class="operation" href="javascript:;" id="bfyp" style="margin-left: 10px;" attrurl=' + encodeURI(attachmentUrl) + '>'+attach_th_play+'</a></div>' +
                        '</div>';
                }else {
                    str+='<div class="divShow" style="position: relative;">' +
                        '<a href="javascript:;" class="fujian" style="display:block;word-break: break-all;color: #54b6fe;" title="'+attachmentArr[i].file_name+'&nbsp;&nbsp;&nbsp;'+attachmentArr[i].file_size+'">' +
                        '<img style="margin-right:5px;" src="../img/attachmentIcon/'+fileIcon+'.png"/>'+attachmentArr[i].file_name+
                        '<span style="margin-left: 5px;">('+attachmentArr[i].file_size +')</span>' +
                        '</a>' +
                        '<div class="operationDiv" style="display:none;">'+ downBtn + deleteBtn +TransferBtn+'</div>' +
                        '</div>';
                }

            }else{
                str+='<div class="font_" style="display: block">' + attachmentName + downBtn + deleteBtn +TransferBtn+ '</div>';
            }
        }
    }
    if(styleType == '1'){ //判断样式
        attachmentBox.html(str);
    }else if(styleType == '2'){
        attachmentBox.html('<div class="font_"  style="display: block"><span class="attachTxt" style="float: left;">'+attach_th_attachmentFile+'：</span><div style="float: left;">'+str+'</div></div>')
    }else{
        return str;
    }
}

openAttachView()
function openAttachView() {
    $.ajax({
        type:'get',
        url:'/sysTasks/getOfficePreviewSetting',
        dataType:'json',
        async:false,
        success:function (res) {
            if(res.flag){
                attachViewType = res.object.previewOpen;//在线预览功能权限
                strOfficeApps = res.object.previewUrl;//在线预览服务地址
            }
        }
    })
    $.ajax({
        type: 'get',
        url: '/syspara/selectTheSysPara?paraName=DOCUMENT_PREVIEW_OPEN',
        dataType: 'json',
        async:false,
        success: function (res) {
            if (res.flag) {
                documentPreviewOpen = res.object[0].paraValue;
            }
        }
    });
}
