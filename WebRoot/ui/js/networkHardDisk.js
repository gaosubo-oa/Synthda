document.write("<script language=javascript src='/js/jquery.base64.js'></script>");
/**
 * Created by 骆鹏 on 2017/7/4.
 */
var objNode=null;//存储点击节点node数据
var copynum;//kaopi和剪切
var copyArr=[];//剪切和复制时发送的数据
var stateDiskId = null;//剪切和复制时的文件diskId
var urlnum=GetQueryString('muType');//获取参数
var index = true;
//是否有权限使用提醒
$.ajax({
    type:'get',
    url:'/smsRemind/getRemindFlag',
    dataType:'json',
    data:{
        type:17
    },
    success:function (res) {
        if(res.flag){
            if(res.obj.length>0){
                var data = res.obj[0];
                // 是否默认发送
                if(data.isRemind=='0'){
                    $('.remindCheck').prop("checked", false);
                }else if(data.isRemind=='1'){
                    $('.remindCheck').prop("checked", true);
                }
                // 是否手机短信默认提醒
                if(data.isIphone=='0'){
                    $('.smsDefault').prop("checked", false);
                } else if (data.isIphone=='1'){
                    $('.smsDefault').prop("checked", true);
                }
                // 是否允许发送事务提醒
                if(data.isCan=='0'){
                    $('#reminds').hide();
                    $('.remindCheck').prop("checked", false);
                    $('.smsDefault').prop("checked", false);
                    // $('.remind').parent('tr').hide();

                }

            }
        }
    }
})
//处理特殊字符转码
function myEncodeURI(str) {
    return encodeURI(str).replace(/\+/g, "%2b").replace(/\@/g,"%40").replace(/\#/g,"%23").replace(/\&/g,"%26").replace(/\//g,"%2F").replace(/\?/g,"%3F").replace(/\￥/g,"%ef%bf%a5").replace(/\$/g,"%24").replace(/\！/g,"%ef%bc%81").replace(/\（/g,"%ef%bc%88").replace(/\）/g,"%ef%bc%89").replace(/\…/g,"%e2%80%a6%e2%80%a6");
}
//处理特殊字符转码先base64 加密  再转码，再替换特殊字符   预览接口单独处理，兼容PC 预览url 中文问题
function myEncodeURIxS(str) {
    str = $.base64.encode(str);
    return myEncodeURI(str);
}
var menuObj = {}

function reloadTree(fn){//树形结构加载
    $("#fileTransfor").empty();
    $.ajax({
        Type: "GET",
        url: "/netdisk/getNetDiskMenu",
        dataType:'json',
        success: function (data) {
            if (data.flag && data.datas) {
                $("#fileTransfor").append("<ul id=\"fileTree\" class=\"easyui-tree\"data-options=\"method:'get',animate:true\" ></ul>");
                var treeArr = [];
                for(var i = 0;i < data.datas.length; i++){

                    treeArr.push({
                        id: data.datas[i].id,
                        text: data.datas[i].text,
                        attributes: {firstUrl:data.datas[i].attributes.fullUrl}
                    })
                }
                $("#fileTree").tree({
                    data: treeArr,
                    // collapsed:true,
                    // state:closed,
                    onClick: function (node) {
                        objNode = node;
                        $('.wangpanId').val(objNode.id);
                        $('.neww label').html('<span style="font-size: 11pt;" title="'+objNode.text+'"><b>/</b>'+objNode.text+'</span>')
                        // 若所选节点为空则执行请求
                        if ($('#fileTree').tree('isLeaf', node.target)) {
                            if(node.attributes != undefined){
                                if(node.attributes.firstUrl!=undefined){
                                    var parentPath = node.attributes.firstUrl;
                                } else {
                                    var parentPath = node.attributes.fullUrl.replace(/\\/g,"/");
                                }
                            }else{
                                var parentPath = node.text;
                            }
                            $.ajax({
                                url : '/netdisk/getNetDiskMenu',
                                data: {
                                    parentPath: parentPath
                                },
                                type : 'POST',
                                dataType:'json',
                                success : function(data) {
                                    if(data.flag&&data.msg == networkHardDisk_th_Success){
                                        var newData = [];
                                        for(var i = 0;i < data.datas.length; i++){
                                            if(node.attributes != undefined&&node.attributes.url != undefined){
                                                var url = node.attributes.url + data.datas[i].attributes.url;
                                            }else{
                                                var url = data.datas[i].attributes.url;
                                            }
                                            var newAttr = {
                                                url: url,
                                                fullUrl:  data.datas[i].attributes.fullUrl
                                            }
                                            if(data.datas[i].id){
                                                newAttr.pc = 1
                                            }else{
                                                newAttr.pc = 0
                                            }
                                            var newDataEle = {
                                                attributes: newAttr,
                                                text: data.datas[i].diskName?data.datas[i].diskName:data.datas[i].text,
                                                id: data.datas[i].id?data.datas[i].id:node.id
                                            }

                                            newData.push(newDataEle)
                                        }
                                        $('#fileTree').tree('append', {
                                            parent : node.target,
                                            data : newData
                                        })
                                    }
                                }
                            })
                        }
                        // 展开/折叠
                        // if (node.state === 'open') {
                        //     $('#fileTree').tree('collapse', node.target);
                        // } else {
                        //     $('#fileTree').tree('expand', node.target);
                        // }
                        $.ajax({
                            url:'/netdiskSettings/selectByDiskId',
                            type:'get',
                            dataType:'json',
                            data:{ diskId: objNode.id },
                            success:function(res){
                                if(res.object!=undefined && res.object!=""){
                                    var orderBy = res.object.orderBy;
                                    var orderType = res.object.ascDesc;
                                    for(var i=0;i<$('#typeActive li').length;i++){
                                        $('#typeActive li').eq(i).removeClass('typeActive')
                                    }
                                    for(var i=0;i<$('#sortActive li').length;i++){
                                        $('#sortActive li').eq(i).removeClass('sortActive')
                                    }
                                    $('#typeActive li[data-id="'+orderBy+'"]').addClass('typeActive')
                                    $('#sortActive li[data-num="'+orderType+'"]').addClass('sortActive')
                                    elemLoad(objNode,$('#sortActive .sortActive').attr('data-num'),$('#typeActive .typeActive').attr('data-id'))
                                }else{
                                    elemLoad(objNode,$('#sortActive .sortActive').attr('data-num'),$('#typeActive .typeActive').attr('data-id'))
                                }

                            }
                        })
                    },
                    onBeforeLoad:function(){
                        var rooNode = $("#fileTree").tree('getRoot');
                        //调用expand方法
                        // $("#fileTree").tree('expand', rooNode.target);
                    },
                    onLoadSuccess:function (row,data) {
                        // $('#fileTree').tree('collapseAll')
                        //
                        // for(var i=0;i<data.length;i++){
                        //     var node = $("#fileTree").tree("find",data[i].id);//找到id对应的节点
                        //     $(node.target).attr("title",data[i].text);//.target得到dom对象，设置title
                        // }
                        if(typeof fn != undefined&&index){
                            index = false;
                            fn();
                        }
                    }
                });

            }
        }
    });
}


function filechangess(e, type){
    if(objNode == null){
        layer.open({
            type: 1,
            area: ['400px', '200px'],
            btn: [global_lang_close],
            content: '<div style="text-align: center; margin-top: 37px; font-size: 21px;"><span>'+networkHardDisk_th_pleaseSelectAFolderFirst+'</span></div>'
        })
        return;
    }
    var userAgent = navigator.userAgent; //取得浏览器的userAgent字符串
    var isOpera = userAgent.indexOf("Opera") > -1;
    $(".attach").show();
    if(type == 0){
        $('.box').empty();
    }
    if(userAgent.indexOf("compatible") > -1 && userAgent.indexOf("MSIE") > -1 && !isOpera){
        var src = $(this).target || window.event.srcElement; //获取事件源，兼容chrome/IE
        var filename = src.value;
        var str = filename.substring( filename.lastIndexOf('\\') + 1 );
        $('.box').html(str);
    }else{
        var arr = e[0].files;
        var str = '';
        for(var i = 0; i < arr.length; i++){
            str += '<p>' + arr[i].name + '</p>';
        }
        $('.box').html(str);
    }
}

function startUpload(){
    var timestamp = Date.parse( new Date() );
    var desk = $('.wangpanId').val();
    $('#uploadimgform').attr('action', '/netdisk/uploadFile?timestamp=' + timestamp + '&diskId=' + desk);

    if(objNode.attributes != undefined){
        $('[name="path"]').val(objNode.attributes.url);
    }
    var remindVal = 0;
    if($('.remindCheck').is(":checked")){
        remindVal = 1;
    }
    var smsDefault = 1;
    if($('.smsDefault').is(":checked")){
        smsDefault = 0;
    }
    $('#uploadimgform').ajaxSubmit({
        type: 'post',
        dataType: 'html',
        data: {
            remind: remindVal, //事务提醒
            smsDefault: smsDefault //手机提醒
        },
        success: function (jsons) {
            var json = JSON.parse(jsons);
            if (json.flag) {
                $('#uploadimgform [type=file]').each(function (i, n) {
                    var file = $(this);
                    var ie = (navigator.appVersion.indexOf("MSIE") != -1);
                    if( ie ){
                        var file2 = file.cloneNode(false);
                        file2.onchange = file.onchange;
                        file.parentNode.replaceChild(file2, file);
                    }else{
                        $(file).val("");
                    }
                })
                $('.attach').hide();
                $('.box').children().remove();

                $.layerMsg({ content: uplaodOk, icon: 1 },function () {
                    elemLoad(objNode, $('#sortActive .sortActive').attr('data-num'), $('#typeActive .typeActive').attr('data-id'))
                })
            } else {
                $('.attach').hide();
                $('.box').children().remove();
                $.layerMsg({ content: networkHardDisk_th_noUploadPermission, icon:0 })
            }

        },
        xhr: function(){
            myXhr = $.ajaxSettings.xhr();
            if(myXhr.upload){ //检查upload属性是否存在
                //绑定progress事件的回调函数
                myXhr.upload.addEventListener('progress', progressHandlingFunction, false);
            }
            return myXhr; //xhr对象返回给jQuery使用

        }
    })
    function progressHandlingFunction(data){
        var progress = parseInt(data.loaded / data.total * 100, 10);
        $('#progress .bar').css('width', progress + '%');
        $('.barText').html(progress + '%');
        if(progress >= 100){  //判断滚动条到100%清除定时器
            timer = setTimeout(function () {
                $('#progress .bar').css('width', 0 + '%');
                $('.barText').html('');
            },2000);
        }
    }
}

function filechanges(e) {//文件上传
    if(objNode == null){
        layer.open({
            type:1,
            area:['400px','200px'],
            btn:[global_lang_close],
            content:'<div style="text-align: center; margin-top: 37px; font-size: 21px; "><span>'+networkHardDisk_th_pleaseSelectAFolderFirst+'</span></div>'
        })
        return;
    }
    var timestamp = Date.parse(new Date());
    var desk = $('.wangpanId').val();
    $('#uploadimgform').attr('action', '/netdisk/uploadFile?timestamp=' + timestamp + '&diskId=' + desk);
    if(objNode.attributes != undefined){
        $('[name="path"]').val(objNode.attributes.url);
    }
    $('#uploadimgform').ajaxSubmit({
        type: 'post',
        dataType: 'html',
        success: function (jsons) {
            var json = JSON.parse(jsons);
            if (json.flag) {
                $('#uploadimgform [type=file]').each(function (i, n) {
                    var file = $(this);
                    var ie = ( navigator.appVersion.indexOf("MSIE") != -1 );
                    if( ie ){
                        var file2 = file.cloneNode(false);
                        file2.onchange = file.onchange;
                        file.parentNode.replaceChild(file2, file);
                    }else{
                        $(file).val("");
                    }
                })

                $.layerMsg({content: uplaodOk, icon: 1},function () {
                    elemLoad(objNode, $('#sortActive .sortActive').attr('data-num'), $('#typeActive .typeActive').attr('data-id'))
                })
            } else {
                $.layerMsg({content: networkHardDisk_th_noUploadPermission, icon: 0})
            }
        }
    })
}

function elemLoad(node, ordertype, orderby, fn){//搜索当前文件夹下文档(和排序同一个方法)
    if(node == null){
        $.layerMsg({ content: fileTrue, icon: 0 })
        return;
    }
    var ajaxPage={
        data:{
            diskId: node.id,
            orderType: ordertype || 0, //排序方式
            orderBy: orderby || 0, //按什么排序
            page: 1, //当前处于第几页
            pageSize: 10, //一页显示几条
            useFlag: true
        },


        page: function () {
            var diskId = $('.tree-node-selected').attr('node-id');
            var me = this;
            if(node.attributes != undefined && node.attributes.url != undefined && node.attributes.pc != 1){
                me.data.path = node.attributes.url;
            }

            // if($('.tree-node-selected').parent().parent().attr('id') != 'fileTree'){
            //     // var path = node.attributes.url.replace(/\\/g,"/").split('/');
            //     // me.data.path = '';
            //     //
            //     // for(var i = 2; i < path.length; i++){
            //     //     me.data.path += '/' + path[i]
            //     // }
            //     me.data.path = node.attributes.url.replace(/\\/g,"/");
            // }
            $.ajax({
                type: 'get',
                url: '/netdisk/selectNetdiskBySearch',
                dataType: 'json',
                data: me.data,
                success: function(json){
                    if(json.flag){
                        $('#mainContent').show();
                        $('#noFile').hide();
                        var strData = '';
                        var lunboStr = '';
                        if(json.object.downloadPriv){
                            $('#singReading').show();
                        }else{
                            $('#singReading').hide();
                        }
                        if(json.object.makePriv){
                            $('#copy').show();
                            $('#shear').show();
                            $('#paste').show();
                            $('#batch').show();
                            $('#newsAdd').show();
                        }else{
                            $('#copy').hide();
                            $('#shear').hide();
                            $('#paste').hide();
                            $('#batch').hide();
                            $('#newsAdd').hide();
                        }
                        if(json.object.updatePriv){
                            $('#deletebtn').show();
                            $('#one_selected').show();
                            $("#folderEdit").show();
                            $('#folderDelete').show();
                        }else{
                            $('#one_selected').hide();
                            $('#deletebtn').hide();
                        }
                        if(!json.object.updatePriv && !json.object.makePriv && !json.object.downloadPriv){
                            $('.bottom').hide();
                        }else{
                            $('.bottom').show();
                        }
                        var picNum = 0;

                        var openimg = ''
                        var attachmentArr = json.object.list
                        for(var j = 0; j < attachmentArr.length; j++){
                            var attachmentUrl = "/netdisk/xs?path=" + myEncodeURIxS(json.object.list[j].path) + '&diskId=' + diskId +
                                '&ATTACHMENT_NAME=' + attachmentArr[j].neName //获取附件地址
                            var fileExtension = GetFileExt(json.object.list[j].neName)
                            var domain = document.location.origin;
                            if(fileExtension == '.png' || fileExtension == '.PNG' || fileExtension == '.jpg'|| fileExtension == '.JPG') {
                                openimg+= attachmentUrl + '*'
                            }
                        }
                        openNmu = 0
                        for(var i = 0;i < json.object.list.length; i++){
                            var iconType = '';
                            if(GetFileExt(json.object.list[i].neName) == '.docx' || GetFileExt(json.object.list[i].neName) == '.doc' || GetFileExt(json.object.list[i].neName) == '.DOC' || GetFileExt(json.object.list[i].neName) == '.DOCX' || GetFileExt(json.object.list[i].neName) == '.word' || GetFileExt(json.object.list[i].neName) == '.WORD'){
                                iconType = 'word';
                            }else if(GetFileExt(json.object.list[i].neName) == '.pptx' || GetFileExt(json.object.list[i].neName) == '.ppt' || GetFileExt(json.object.list[i].neName) == '.PPTX' || GetFileExt(json.object.list[i].neName) == '.PPT'){
                                iconType = 'ppt';
                            }else if(GetFileExt(json.object.list[i].neName) == '.xlsx' || GetFileExt(json.object.list[i].neName) == '.xls' || GetFileExt(json.object.list[i].neName) == '.XLSX' || GetFileExt(json.object.list[i].neName) == '.XLS'){
                                iconType = 'excel';
                            }else if(GetFileExt(json.object.list[i].neName) == '.pdf' || GetFileExt(json.object.list[i].neName) == '.PDF'){
                                iconType = 'pdf';
                            }else if(GetFileExt(json.object.list[i].neName) == '.exe' || GetFileExt(json.object.list[i].neName) == '.EXE'){
                                iconType = 'exe';
                            }else if(GetFileExt(json.object.list[i].neName) == '.jpg' || GetFileExt(json.object.list[i].neName) == '.png' || GetFileExt(json.object.list[i].neName) == '.PNG' || GetFileExt(json.object.list[i].neName) == '.JPG'){
                                lunboStr += '<div class="swiper-slide"><img style="height: 500px"  src="/netdisk/xs?path=' + myEncodeURIxS(json.object.list[i].path) + '&diskId=' +diskId+'" alt=""></div>'
                                iconType = 'pic';
                            }else if(GetFileExt(json.object.list[i].neName) == '.rar' || GetFileExt(json.object.list[i].neName) == '.zip' || GetFileExt(json.object.list[i].neName) == '.RAR' || GetFileExt(json.object.list[i].neName) == '.ZIP'){
                                iconType ='zip';
                            }else {
                                iconType ='file';
                            }

                            strData += '<tr class="contentTr" style="margin-right: 33px;">' +
                                '<td align="center"><input type="checkbox" style="margin-right: 31px;" path="'+json.object.list[i].path+'"></td>' +
                                '<td align="center" class="floatTd" style="text-align: left;cursor: pointer;position: relative;">' +
                                '<div path="'+json.object.list[i].path+'" player-url="/netdisk/xs?diskId='+ diskId+'&path=' + myEncodeURIxS(json.object.list[i].path) + '"  encryType="'+json.object.list[i].encryType+'"  class="filename" style="color:#54b6fe;display: inline-block;white-space: nowrap;overflow: hidden;text-overflow: ellipsis;" title="'+json.object.list[i].neName+'"><img style="width:18px;height:22px;margin-right:5px;"  src="/img/attachmentIcon/'+iconType+'.png" alt="">'+json.object.list[i].neName+'</div>' +
                                '<div class="floatDiv" style="display: none;">' +
                                function(){
                                    if(json.object.showPriv&&(json.object.list[i].type == 'DOCX'||json.object.list[i].type == 'DOC'||json.object.list[i].type == 'XLSX'||json.object.list[i].type == 'XLS'||json.object.list[i].type == 'PPT'||json.object.list[i].type == 'PPTX'||json.object.list[i].type == 'WPS')){
                                       if(json.object.editPriv) {
                                           return '<div class="preview" type="'+ json.object.list[i].type.toLowerCase() +'">'+yulan+'</div><div class="consult" type="'+ json.object.list[i].type.toLowerCase() +'">'+email_th_refer_to+'</div><div class="edit" type="'+ json.object.list[i].type.toLowerCase() +'">'+edit1+'</div>';
                                       }
                                        return '<div class="preview" type="'+ json.object.list[i].type.toLowerCase() +'">'+yulan+'</div><div class="consult" type="'+ json.object.list[i].type.toLowerCase() +'">'+email_th_refer_to+'</div>';
                                    }else{
                                        return '';
                                    }
                                }()+
                                // '<div class="consult">查阅</div>' +
                                function () {
                                    if(json.object.downloadPriv){
                                        return '<div class="downDiv">'+email_th_download+'</div>';
                                    } else {
                                        return '';
                                    }
                                }() + function () {
                                    if(GetFileExt(json.object.list[i].neName) == '.jpg' || GetFileExt(json.object.list[i].neName) == '.png' || GetFileExt(json.object.list[i].neName) == '.PNG' || GetFileExt(json.object.list[i].neName) == '.JPG'){
                                        var picNums = picNum;
                                        picNum = picNum+1;
                                        var domain = document.location.origin;
                                        return '<div class="playDiv operationImg" picNum="'+ picNums +'">'+networkHardDisk_th_browse+'</div>'+
                                            '<img openimg="'+openimg+'"  openNmu = "'+picNums+'"  class="operation"  src="'+domain+attachmentUrl+'" style="margin-left: 10px;display: none" attrurl="' + attachmentUrl + '" href="javascript:;"></img>';
                                        openNmu++
                                    }else if(GetFileExt(json.object.list[i].neName) == '.mp4' || GetFileExt(json.object.list[i].neName) == '.rmvb' || GetFileExt(json.object.list[i].neName) == '.avi' || GetFileExt(json.object.list[i].neName) == '.ifo' || GetFileExt(json.object.list[i].neName) == '.wmv') {
                                        return '<div class="player" >'+attach_th_play+'</div>';
                                    }else if(GetFileExt(json.object.list[i].neName) == '.pdf' || GetFileExt(json.object.list[i].neName) == '.PDF'){
                                        if(json.object.downloadPriv){
                                            // 拥有下载权限
                                            return '<div class="seeDiv">'+networkHardDisk_th_onlinePreview+'</div>';
                                        }else{
                                            return '<div class="seeDiv" downloadPriv="0" >'+networkHardDisk_th_onlinePreview+'</div>';
                                        }

                                    }else{
                                        return '';
                                    }
                                }()+
                                '</div>'+
                                '</td>' +
                                '<td align="center">'+json.object.list[i].type+'</td>' +
                                '<td align="center">'+json.object.list[i].size+'</td>' +
                                '<td align="center">'+json.object.list[i].time+'</td>' +
                                '</tr>'
                        }
                        $('#file_Tachr').html(strData);
                        $('.swiper-wrapper').html(lunboStr);

                        if(fn!=undefined){
                            fn();
                        }
                        if(json.object.list.length==0){
                            strData='<tr align="center"> <td colspan="5" >\
                    <div class="bgImg" style="width: 360px;height: 150px;margin: 20px 0px;background-color:#357ece;box-shadow: 3px 3px 3px #2F5C8F;\
                    border-radius: 10px;">\
                   <div class="IMG" style="padding-top: 24px;">\
                    <img src="../img/sys/icon64_info.png">\
                    </div>\
                    <div class="TXT" style="color: #fff;font-size: 14pt;">'+noFile+'</div>\
                    </div></td></tr>';

                            $('#file_Tachr').html(strData);
                            $('.seeDiv').on("click",function(){
                             //   console.log(1);
                                window.location.href=$(this).parent().siblings().eq(0).attr('player-url');
                            });
                        }
                    }
                    else {
                        $('#mainContent').hide()
                        $("div#TXT").html(json.msg)
                        $('#noFile').show()
                    }
                    me.pageTwo(json.total,me.data.pageSize,me.data.page)
                }
            });
        },
        pageTwo:function (totalData, pageSize,indexs) {
            var mes=this;
            $('#dbgz_pagesd').pagination({
                totalData: totalData,
                showData: pageSize,
                jump: true,
                coping: true,
                homePage:'',
                endPage: '',
                current:indexs||1,
                callback: function (index) {
                    mes.data.page=index.getCurrent();
                    mes.page();
                }
            });
        }
    }
    ajaxPage.page();
}

//取文件后缀名
function GetFileExt(filepath) {
    if (filepath != "") {
        var pos = "." + filepath.replace(/.+\./, "");
        return pos;
    }
}

function cancless(){
    $('.box').children().remove();
    $('.attach').hide();
}
function addEventHandler(target,type,fn){
    if(target.addEventListener){
        target.addEventListener(type,fn,false);
    }else{
        target.attachEvent("on"+type,fn,false);
    }
}
$('.main').height((document.documentElement.clientHeight || document.body.clientHeight)-50)

addEventHandler(window,'resize',function () {
    var diskWidth=$('.diskDiv').width()-$('.cabinet_left').width()-3;
    $('.cabinet_info').width(diskWidth);
    $('.neww').width((diskWidth - 660)+'px');
})
$(function () {
    var diskWidth=$('.diskDiv').width()-$('.cabinet_left').width()-3;
    $('.cabinet_info').width(diskWidth);
    $('.neww').width((diskWidth - 660)+'px');

    reloadTree(function(){
        var id = location.href.split('?')[1]||'';
        if(id != '' && id != 'muType=0'){
            if(id.indexOf('search=') > -1){
                subject='';
                sort_no='';
                creaters='';
                keyword1='';
                keyword2='';
                keyword3='';
                attScript='';
                attName='';
                attContain='';
                begainTime='';
                endTime='';
                contentId=id.split('search=')[1];
                queryAllData('');
                $('.queryDetail').show().siblings().hide();
            }else{
                if($('.tree-node-selected').attr('node-id') != id){
                    $('.tree-node[node-id='+ id +']').click();
                }
                $('.tree-node[node-id='+ id +']').next().show();
            }
        }
    });

    $('#file_Tachr').on('mousemove','.floatTd',function () {
        $(this).find('.floatDiv').show();
    })
    $('#file_Tachr').on('mouseout','.floatTd',function () {
        $(this).find('.floatDiv').hide();
    })

    // 点击下载
    $('#file_Tachr').on('click','.downDiv',function () {
        if(objNode==null){
            $.layerMsg({content:fileTrue,icon:0});
            return;
        }
        var path = $(this).parent().siblings('.filename').attr("path");
        var diskId = $('.tree-node-selected').attr('node-id');
        var encryType= $(this).parent().siblings('.filename').attr("encryType")=='undefined'?'':$(this).parent().siblings('.filename').attr("encryType");
         window.open('/netdisk/download?path=' + myEncodeURI(path)+ '&diskId='+ diskId);
    })

    $('#file_Tachr').on('click','.edit',function () {
        var thisFileName=$(this).parent().siblings('.filename').attr('title');
        var path = $(this).parent().siblings('.filename').attr("path");
        var type = $(this).attr('type');
        var diskId = $('.tree-node-selected').attr('node-id');
        var url = "/common/webOfficeView?documentEditPriv=0&fomat="+type+"&networkHardDisk=1&fileName=&path="+myEncodeURIxS(path)+ '&diskId='+ diskId;
        $.ajax({
            url:'/syspara/selectTheSysPara?paraName=OFFICE_EDIT',
            type:'post',
            datatype:'json',
            async:false,
            success: function (res) {
                console.log(res,'res')
                if(res.flag){
                    if(res.object[0].paraValue == 0){
                        //默认加载NTKO插件 进行跳转
                        url = "/common/ntkoview?documentEditPriv=0&fomat="+type+"&networkHardDisk=1&fileName=&path="+myEncodeURIxS(path)+ '&diskId='+ diskId;
                    }else if(res.object[0].paraValue == 2){
                        //默认加载NTKO插件 进行跳转
                        url = "/wps/info?_w_module=netdisk&permission=read&netdisk=1&_w_fileid="+diskId+"&_w_pathNetdisk="+myEncodeURIxS(path);
                    }else if(res.object[0].paraValue == 3){
                        //默认加载NTKO插件 进行跳转
                        url = "/common/onlyoffice?_w_module=netdisk&netdisk=1&_w_fileid="+diskId+"&_w_pathNetdisk="+myEncodeURI(path);
                    }
                }

            }
        })
        $.popWindow(url,yulan,'0','0','1200px','600px');

    })
    $('#file_Tachr').on('click','.consult',function () {
        var thisFileName=$(this).parent().siblings('.filename').attr('title');
        var path = $(this).parent().siblings('.filename').attr("path");
        var type = $(this).attr('type');
        var diskId = $('.tree-node-selected').attr('node-id');
        var url = "/common/webOfficeView?documentEditPriv=0&fomat="+type+"&networkHardDisk=1&fileName=&path="+myEncodeURIxS(path)+ '&diskId='+ diskId;
        $.ajax({
            url:'/syspara/selectTheSysPara?paraName=OFFICE_EDIT',
            type:'post',
            datatype:'json',
            async:false,
            success: function (res) {
                if(res.flag){
                    if(res.object[0].paraValue == 0){
                        //默认加载NTKO插件 进行跳转
                        url = "/common/ntkoview?documentEditPriv=0&fomat="+type+"&networkHardDisk=1&fileName=&path="+myEncodeURIxS(path)+ '&diskId='+ diskId;
                    }else if(res.object[0].paraValue == 2){
                        //默认加载NTKO插件 进行跳转
                        url = "/wps/info?_w_module=netdisk&permission=read&netdisk=1&_w_fileid="+diskId+"&_w_pathNetdisk="+myEncodeURIxS(path);
                    }else if(res.object[0].paraValue == 3){
                        //默认加载NTKO插件 进行跳转
                        url = "/common/onlyoffice?_w_module=netdisk&edit=false&netdisk=1&_w_fileid="+diskId+"&_w_pathNetdisk="+myEncodeURI(path);
                    }
                }

            }
        })
        $.popWindow(url,yulan,'0','0','1200px','600px');

    })
    $('#file_Tachr').on('click','.preview',function () {
        var path = $(this).parent().siblings('.filename').attr("path");
        var type = $(this).attr('type').toLowerCase();
        var diskId = $('.tree-node-selected').attr('node-id');
        var neName=('?'+path).substring(('?'+path).lastIndexOf(".")+1,('?'+path).length);//截取附件文件后缀
        neName = neName.toLowerCase();

        if(neName == 'docx' || neName == 'doc' || neName == 'xls' || neName == 'xlsx' || neName == 'ppt' ||neName == 'pptx'){
            $.ajax({
                url: '/syspara/selectTheSysPara?paraName=DOCUMENT_PREVIEW_OPEN',
                type: 'post',
                datatype: 'json',
                async: false,
                success: function (res) {
                    if(res.flag){
                        if(res.object[0].paraValue == 3){
                            // 设置预览方式为wps
                            url = "/wps/info?_w_module=netdisk&permission=read&netdisk=1&_w_fileid="+diskId+"&_w_pathNetdisk="+myEncodeURIxS(path);
                        }else if(res.object[0].paraValue == 4){
                            // 设置预览方式为onlyoffice
                            url = "/common/onlyoffice?_w_module=netdisk&edit=false&netdisk=1&_w_fileid="+diskId+"&_w_pathNetdisk="+myEncodeURI(path);
                        }else if(res.object[0].paraValue == 2||res.object[0].paraValue == 1){
                            // 设置预览方式为内置和微软
                            if(neName == 'docx' || neName == 'doc'){
                                url = "/common/officereader?path="+encodeURIComponent(path)+"&diskId="+diskId+'&type='+type
                            }else if(neName == 'xls' || neName == 'xlsx'){
                                url = "/common/excelPreview?path="+encodeURIComponent(path)+"&diskId="+diskId
                            }else if(neName == 'ppt' ||neName == 'pptx' ){
                                url = "/common/pptPreview?path="+encodeURIComponent(path)+"&diskId="+diskId
                            }
                        }
                    }

                }
            })
        }else if(neName == 'pdf'){
            var url = "/common/pdfPreview?path="+encodeURIComponent(path)+"&diskId="+diskId
        }
        $.popWindow(url,path,'0','0','1200px','600px');

    })
    // 点击播放
    $('#file_Tachr').on('click','.player',function () {
        var path = $(this).parent().siblings('.filename').attr("player-url");
        layer.open({
            type: 2,
            title: false,
            area: ['630px', '360px'],
            shade: 0.8,
            closeBtn: 0,
            shadeClose: true,
            content: "/common/video?videoatturlsplit="+path
        });
        layer.msg(email_th_clickAnywhereToClose);
    })
    // // 点击浏览
    // $('#file_Tachr').on('click','.playDiv',function () {
    //     var initialSlide = $(this).attr('picnum');
    //     $('.footer').show();
    //     var swiper = new Swiper('.swiper-container', {
    //         navigation: {
    //             nextEl: '.swiper-button-next',
    //             prevEl: '.swiper-button-prev',
    //         },
    //         initialSlide :initialSlide,//默认第二个
    //     });
    // });
    // 点击浏览
    $('#file_Tachr').on('click','.operationImg',function () {
        var thisa = $(this).next().attr('openimg')
        var openNmu = $(this).next().attr('openNmu')
        var str3 = '<input type="text" id="getIndex" openNum = "'+openNmu+'" style="display: none">'
        $('#file_Tachr').append(str3)
        $('#getIndex').val(thisa)
        console.log(openNmu)
        window.open("/email/imgOpen?openNmu="+openNmu,"_blank");
    });

    $('#file_Tachr').on('click','.seeDiv',function () {
        var diskId = $('.tree-node-selected').attr('node-id');
        var attrUrlName =  $(this).parent().siblings().eq(0).attr('player-url').split('/netdisk/xs?')[1];
        $('#pathName').val($(this).parent().siblings('.filename').attr('path'));
        var attrUrl = 'path=netDisk';
        if(myBrowser() == "Chrome"||myBrowser() == "IE11"){
            var urlstr = '&pathbase='+attrUrlName.split('path=')[1];
            if($(this).attr('downloadPriv') == 0){
                urlstr += '&downloadpriv&time=20230113'
            }
            $.popWindow("/pdfPreview?"+attrUrl+'&diskId='+ diskId+ urlstr,yulan,'0','0','1500px','800px');
        }else{
            $.popWindow("/pdfPreview?"+attrUrlName+'&size=netdisk',yulan,'0','0','1500px','800px');

        }

        // if(UrlGetRequest('?'+attrUrlName) == 'pdf' || UrlGetRequest('?'+attrUrlName) == 'PDF'){
        //     $.popWindow("/pdfPreview?"+attrUrlName+'&size=netdisk','预览','0','0','1500px','800px');
        // }else if(UrlGetRequest('?'+attrUrlName) == 'png' || UrlGetRequest('?'+attrUrlName) == 'PNG'|| UrlGetRequest('?'+attrUrlName) == 'jpg' || UrlGetRequest('?'+attrUrlName) == 'JPG'|| UrlGetRequest('?'+attrUrlName) == 'txt'|| UrlGetRequest('?'+attrUrlName) == 'TXT'){
        //     $.popWindow("/xs?"+attrUrl,'预览','0','0','1500px','800px');
        // }
    });

    // 点击关闭
    $('.closeBtn').on("click",function () {
        $('.footer').hide();
    })

    $('#contentAdd').on("click",function () {//新建文件夹
        if(objNode==null){
            $.layerMsg({content:fileTrue,icon:2})
            return;
        }
        layer.open({
            title:childFile,
            content:'  \
           <div style="line-height: 33px;margin: 10px 0px;background: #ebeef5;padding-left: 10px;">\
                <span>'+network+'</span>\
                <label class="gttext">\
                </label>\
           </div>\
           <p style="line-height: 65px;height: 65px;">\
                  <label>'+fileName+'：</label>\
                  <input type="text" name="newzi" style="border: 1px solid #ddd;width: 250px;border-radius: 6px;height: 30px;padding-left: 10px;">\
           </p>\
           <p style="line-height: 8px;height: 12px;">\
                            <input type="checkbox" name="remind" class="remindCheck" value="0" checked>\
                                <span><fmt:message code="notice.th.remindermessage" /></span>\
                                <input type="checkbox" name="smsDefault"  class="smsDefault" value="1" >\
                                <span class="hideSpan" ><fmt:message code="vote.th.UseRemind" /></span>\
                       </p>',
            area:['500px','270px'],
            btn:[menusetsure,quxiao],
            yes:function (index) {
                var remindVal=0;
                if($('.remindCheck').is(":checked")){
                    remindVal=1;
                }
                var smsDefault =1;
                if($('.smsDefault').is(":checked")){
                    smsDefault=0;
                }
                console.log(objNode)
                var path='' ;
                if(objNode.attributes!= undefined){
                    path =objNode.attributes.url;
                }
                $.post('/netdisk/mkDirectory',{
                    path:path,
                    directoryName:$('[name="newzi"]').val(),
                    remind:remindVal,
                    diskId:objNode.id,
                    smsDefault:smsDefault,},function (json) {
                    if(json.flag){
                        $.layerMsg({content:Newsuccessfully,icon:1},function () {
                            reloadTree();
                        })
                    }else {
                        $.layerMsg({content:quanxian,icon:2})
                    }
                },'json')
            },success:function () {
                $('.gttext').html('<span><b>&gt;</b>' + objNode.text + '</span>')
            }
        })
    })

    $('.doTitle').on("click",function(event){//文件夹操作
        if($(this).next().css('display')=='none'){
            $(this).next().show()
        }else {
            $(this).next().hide()
        }
        event.stopPropagation();
    });

    $('#classA ul li').on("click",function () {//文件夹里面按钮
        if(objNode == null){
            layer.msg(networkHardDisk_th_PleaseDeleteFolder+"！");
            return false;
        }
        var id = 0;
        if (objNode.id != null){
            id = objNode.id
        }
        if(objNode==null){
            $.layerMsg({content:fileTrue,icon:2})
            return;
        }
        $(this).parent().parent().hide()
        if($(this).attr('data-id')==1){
            if($('#fileTree .tree-node-selected').parent().parent().hasClass('easyui-tree')){
                $.layerMsg({content: networkHardDisk_th_doNotAllowRenaming+'!', icon: 2});
            }else{


                layer.open({
                    title:reset,
                    content:'<p style="line-height: 65px;height: 65px;">\
                    <label>'+origin+'：</label>\
                    <input type="text" name="jiuname" disabled="disabled" style="border: 1px solid #ddd;background:#eee;width: 250px;border-radius: 6px;height: 30px;padding-left: 10px;">\
                  </p>\
                  <p style="line-height: 65px;height: 65px;">\
                    <label>'+newfile+'：</label>\
                     <input type="text" name="newsName" style="border: 1px solid #ddd;width: 250px;border-radius: 6px;height: 30px;padding-left: 10px;">\
                  </p>',
                    area:['500px','270px'],
                    btn:[menusetsure,quxiao],
                    yes:function (index) {
                        var indexs = layer.load(3, {
                            shade: [0.1,'#fff'] //0.1透明度的白色背景
                        });
                        var path ='';
                        if(objNode.attributes!=undefined){
                            path=objNode.attributes.url;
                        }
                        console.log($('.tree-node-selected').attr('node-id'))
                        $.post('/netdisk/changeName',
                            {
                            path:path,
                            newsName:$('[name="newsName"]').val(),
                            diskId:parseInt($('.tree-node-selected').attr('node-id'))
                            },
                            function (json) {
                                if(json.flag){
                                    $.layerMsg({content:menuSSetting_th_editSuccess,icon:1},function () {
                                        reloadTree();
                                        layer.close(indexs);
                                    })
                                }else {
                                    $.layerMsg({content:editFail,icon:2})
                                }
                            },'json')
                    },
                    success:function () {
                        $('[name="jiuname"]').val(objNode.text)
                    }
                })
            }
        }else{
            var path = '';
            if(objNode.attributes !=undefined){
                path =objNode.attributes.url;
            }
            $.layerConfirm({title:sureDele,
                content:dkn,
                icon:0},function(){
                $.post('/netdisk/deleteFolder',
                    {
                     path:path,
                     diskId:id}
                    ,function (json) {
                        if(json.flag){
                            $.layerMsg({content:delsucess,icon:1},function () {
                                reloadTree()
                                $('#file_Tachr').html('')
                            })
                        }else {
                            $.layerMsg({content:networkHardDisk_th_noManagementPermission,icon:0})
                            //$.layerMsg({content:delNo,icon:0})
                        }
                    },'json')
            })
        }
    })

    $('#SEARCH').on("click",function () {
        $.layerMsg({content:kaifazhong,icon:6})
        return
        layer.open({
            title:sousuo,
            content:'<p style="line-height: 65px;height: 65px;">\
                    <label style="display: inline-block;width: 130px;text-align: right">'+file1+'：</label>\
                     <input type="text" readonly="" style="border: 1px solid #ddd;background:#eee;width: 250px;border-radius: 6px;height: 30px;padding-left: 10px;">\
                  </p>\
                  <p style="line-height: 65px;height: 65px;">\
                    <label style="display: inline-block;width: 130px;text-align: right">'+file2+'：</label>\
                     <input type="text" style="border: 1px solid #ddd;width: 250px;border-radius: 6px;height: 30px;padding-left: 10px;">\
                  </p>\
                  <p style="color: red;font-size: 12px;padding-left: 138px;">'+file3+'</p>',
            area:['500px','300px'],
            btn:[menusetsure,quxiao],
            yes:function (index) {

            }
        })
    })

    $('#checkedAll').on("click",function () {
        if($(this).is(':checked')){
            $('#file_Tachr input[type="checkbox"]').each(function (i,n) {
                $(this).prop('checked',true)
                $(this).parent().parent().addClass('bgcolor')
                $('#singReading').removeClass('addBackground');
                $('#copy').removeClass('addBackground');
                $('#shear').removeClass('addBackground');
                $('#paste').removeClass('addBackground');
                $('#deletebtn').removeClass('addBackground');
                $('#download').removeClass('addBackground');
            })
        }else {
            $('#file_Tachr input[type="checkbox"]').each(function (i,n) {
                $(this).prop('checked',false)
                $(this).parent().parent().removeClass('bgcolor')
                $('#singReading').addClass('addBackground');
                $('#copy').addClass('addBackground');
                $('#shear').addClass('addBackground');
                $('#paste').addClass('addBackground');
                $('#deletebtn').addClass('addBackground');
                $('#download').addClass('addBackground');
            })
        }
    })

    $('#file_Tachr').delegate('input[type="checkbox"]','click',function () {
        if($('#file_Tachr input[type="checkbox"]').length==$('#file_Tachr input[type="checkbox"]:checked').length){
            $('#checkedAll').prop('checked',true);
        }else {
            $('#checkedAll').prop('checked',false);
        }
        if($(this).is(':checked')){
            $(this).parent().parent().addClass('bgcolor')
            $('#singReading').removeClass('addBackground');
            $('#copy').removeClass('addBackground');
            $('#shear').removeClass('addBackground');
            $('#paste').removeClass('addBackground');
            $('#deletebtn').removeClass('addBackground');
            $('#download').removeClass('addBackground');
        }else {
            $(this).parent().parent().removeClass('bgcolor')
            if($('#file_Tachr input[type="checkbox"]:checked').length == 0){
                $('#singReading').addClass('addBackground');
                $('#copy').addClass('addBackground');
                $('#shear').addClass('addBackground');
                $('#paste').addClass('addBackground');
                $('#deletebtn').addClass('addBackground');
                $('#download').addClass('addBackground');
            }
        }
    })

    $('#sortActive li').on("click",function () {
        $(this).siblings().removeClass('sortActive')
        $(this).addClass('sortActive')
        elemLoad(objNode,$('#sortActive .sortActive').attr('data-num'),$('#typeActive .typeActive').attr('data-id'))
        $(this).parent().parent().hide()

    });
    $('#typeActive li').on("click",function () {
        $(this).siblings().removeClass('typeActive')
        $(this).addClass('typeActive')
        elemLoad(objNode,$('#sortActive .sortActive').attr('data-num'),$('#typeActive .typeActive').attr('data-id'))
        $(this).parent().parent().hide()

    })
    $(document).on("click",function () {
        $('.hideDiv').hide();
    })
    $('.dowmloadOne').on("click",function () {
        if($('#singReading').hasClass('addBackground')){
            return false;
        }
        //下载
        if(objNode==null){
            $.layerMsg({content:fileTrue,icon:0})
            return;
        }
        if($('#file_Tachr input[type="checkbox"]:checked').length==0){
            $.layerMsg({content:chooseFile,icon:0})
            return;
        }
        if($('#file_Tachr input[type="checkbox"]:checked').length==1) {
            var path =$('#file_Tachr input[type="checkbox"]:checked').attr("path");
            var diskId = $('.tree-node-selected').attr('node-id');
            window.open('/netdisk/download?path=' +myEncodeURI(path)+ '&diskId='+diskId);
        }else {
            var strarr=[];
            $('#file_Tachr input[type="checkbox"]:checked').each(function (i,n) {
                var path = $(this).attr("path").replace(/,/g,"*");
                strarr.push(myEncodeURI(path));
            });
            var diskId = $('.tree-node-selected').attr('node-id');
            window.open('/netdisk/downLoadZipFile?path='+strarr+ '&diskId='+diskId);
        }
    });

    $('.copyfile').on("click",function () {
        if($('#copy').hasClass('addBackground')){
            return false;
        }
        if($('#file_Tachr input[type="checkbox"]:checked').length==0){
            $.layerMsg({content:fileTrue,icon:2})
            return;
        }
        stateDiskId = $('.tree-node-selected').attr('node-id');
        copyArr.splice(0,copyArr.length)
        copynum=$(this).attr('data-numcopy');
        $('#file_Tachr input[type="checkbox"]:checked').each(function () {
            var path = $(this).attr("path");
            copyArr.push(path);
        })
        if(copynum == 1){
            $.layerMsg({content:networkHardDisk_th_cutSuccessfully,icon:1})
        }else{
            $.layerMsg({content:networkHardDisk_th_copySuccessfully,icon:1})
        }
    })


    $('.SIX').on("click",function () {//粘贴
        if($('#paste').hasClass('addBackground')){
            return false;
        }
        if(objNode==null){
            $.layerMsg({content:fileTrue,icon:2})
            return;
        }
        var toPath = '';
        if(objNode.attributes != undefined){
            toPath = objNode.attributes.url;
        }
        var diskId = $('.tree-node-selected').attr('node-id');
        $.post('/netdisk/writeFile',{
            diskId:stateDiskId,
            toDiskId:diskId,
            toPath:toPath,
            resourcesPath:copyArr,
            pasteType:copynum
            },function (json) {
            if(json.flag){
                $.layerMsg({content:PasteSuccessfully,icon:1},function () {
                    elemLoad(objNode,$('#sortActive .sortActive').attr('data-num'),$('#typeActive .typeActive').attr('data-id'))
                })
            }else {
                $.layerMsg({content:json.msg,icon:0})
            }
        },'json')
    })



    $('.FOURs').on("click",function () {
        if($('#deletebtn').hasClass('addBackground')){
            return false;
        }
        if(objNode==null){
            $.layerMsg({content:fileTrue,icon:2})
            return;
        }
        if($('#file_Tachr input[type="checkbox"]:checked').length==0){
            $.layerMsg({content:fileTrue,icon:2})
            return;
        }
        var diskId = $('.tree-node-selected').attr('node-id');
        $.layerConfirm({title:sureDeleteFlie,
            content:sureDelete,
            icon:0},function(){
            var arraytwo=[];
            $('#file_Tachr input[type="checkbox"]:checked').each(function () {
                var urlArr= $(this).attr("path").replace(/,/g,"*");
                arraytwo.push(urlArr)
            })
            $.post('/netdisk/deleteFile',{
                path:arraytwo,
                diskId:diskId
            },function (json) {
                if(json.flag){
                    $.layerMsg({content:delsucess,icon:1},function () {
                        elemLoad(objNode,$('#sortActive .sortActive').attr('data-num'),$('#typeActive .typeActive').attr('data-id'))
                    })
                }else {
                    $.layerMsg({content:delNo,icon:2})
                }
            },'json')

        })

    })
})

function GetQueryString(name) {
    var reg = new RegExp("(^|&)"+ name +"=([^&]*)(&|$)");
    var r = window.location.search.substr(1).match(reg);
    if(r!=null)return  unescape(r[2]); return null;
}