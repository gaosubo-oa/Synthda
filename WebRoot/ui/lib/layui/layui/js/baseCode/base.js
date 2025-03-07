/**
 * 创建作者:   李 然
 * 创建日期:   13:39 2019/7/20
 * 方法介绍:   公共删除函数
 * 参数说明:   * @param ids主键集
 * @return
 */
function publicDelete(url,ids,tableIns,table){
    layer.confirm('确定要删除吗?', {icon: 3, title:'提示'}, function(index){
        var data={
            ids:ids
        }
        var res=toAjaxT(url,data);
        layer.msg(res.msg)
        if(res.code==0){
            try {
                if (ids.substring(ids.length - 1) == ",") {
                    ids = ids.substring(0, ids.length - 1);
                }
                var dataSize = ids.split(",");
                var dataAll = table.cache[tableIns.config.id];
                if (dataAll.length == dataSize.length) {
                    //得到当前页
                    var page = $(".layui-laypage-skip .layui-input").val();
                    alert(11111)
                    if (page > 1) {
                        tableIns.reload({
                            page: {
                                curr: page - 1 //重新从第 1 页开始
                            }}
                            );
                    }else{
                        tableIns=tableIns.reload();

                    }
                } else {
                    tableIns=tableIns.reload();
                }
            } catch (e) {
                tableIns.reload();
            }
        }
        layer.close(index);
        location.reload()
    });
}
//公共AJAX  异步
function toAjaxY(url,data) {
    $.ajax({
        url:url,
        data:data,
        type: 'post',
        dataType: 'json',
    });
}
//同步
function toAjaxT(url,data) {
    var result;
    $.ajax({
        url:url,
        data:data,
        type: 'post',
        async:false,
        dataType: 'json',
        success: function (res){
            result=res;
        }
    });
    return result;
}

function getAttachIds(obj) {
    return obj.aid+"@"+obj.ym+"_"+obj.attachId;
}
function limsPreview(that) { //附件预览点击调取
    var attrUrl = that
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
//截取附件文件后缀
function limsUrlGetRequest(name) {
    var attach=name
    return attach.substring(attach.lastIndexOf(".")+1,attach.length);
}
//查看附件
function selectFile(attchId,model) {
    if(attchId){
        //查看附件
        var data={
            attachId:attchId,
            model:model
        }
        var res=toAjaxT("/equipment/selectAttchUrl",data);
        if(res.code==0){
            if(res.object){
                limsPreview(res.object);
            }
        }
    }

}
//删除已上传附件
function deleteFile(attchIds,model) {
    var data={
        attachIds:attchIds,
        type:1,
        model:model
    }
    return toAjaxT("/limsFile/delete",data);
}

layui.use(['table', 'layer', 'form'], function () {
    var table = layui.table;
    table.on('checkbox(SettlementFilter)', function(obj){
        if(obj.type=='all'){
            if(obj.checked){
                $('.layui-table-body tr').addClass('bgs')
            }else{
                $('.layui-table-body tr').removeClass('bgs')
            }
        }else{
            if(obj.checked){
                obj.tr.addClass('bgs')
            }else{
                obj.tr.removeClass('bgs')
            }
        }

    });
    // table.on('row(SettlementFilter)', function(obj){
    //
    //     obj.tr.addClass('bg').siblings().removeClass('bg')
    // });
})
/**
* 创建作者:   李 然
* 创建日期:   16:43 2019/9/9
* 方法介绍:   lr active MQ 初始化
* 参数说明:   * @param null
* @return
*/
function mqttInit(init) {
    var client, destination;
    // the client is notified when it is connected to the server.
    var onConnect = function(frame) {
        console.log(init.destination+"连接成功")
        if(init.send){
            send(init.send)
        }else{
            client.subscribe(destination);
        }
    };

    function onFailure(failure) {
        console.log("连接失败")
    }

    function send(text) {
        message = new Messaging.Message(text);
        message.destinationName = destination;
        client.send(message);
        client.disconnect();
    }

    //触发回调用函数
    function onMessageArrived(message) {
        if(init.done){
            init.done(message.payloadString);
        }
    }

    function onConnectionLost(responseObject) {
        if (responseObject.errorCode !== 0) {
            console.log(client.clientId + ": " + responseObject.errorCode + "\n");
            mqttInit(init)
        }
    }
    var host=init.host;
    var port=init.port;
    var clientId=init.clientId;
    var user=init.user;
    var password=init.password;
    destination=init.destination
    client = new Messaging.Client(host, Number(port), clientId);
    client.onMessageArrived = onMessageArrived;
    client.onConnectionLost = onConnectionLost;
    client.connect({
        userName:user,
        password:password,
        onSuccess:onConnect,
        onFailure:onFailure
    });
}
