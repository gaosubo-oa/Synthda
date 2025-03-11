var onlyOfficeCallBack = '/onlyOfficeCallBack?'
if(netdisk != undefined &&netdisk == 1){
    onlyOfficeCallBack = '/netdisk/onlyOfficeCallBack?'
}
if (/(iPhone|iPad|iPod|iOS|Android)/i.test(navigator.userAgent)) {
    var jztype = 'mobile';
}else{
    var jztype = 'desktop';
}
var historyArr = [];
var historyOpt = [];
var keyFirst = 0;
var editUrl = '';
if(edit){
    editUrl = location.href.split('&edit=true')[1];
}
$.ajax({
    url: "/getOnlyOfficeFileHistroy",
    type: "get",
    dataType: "json",
    data: {
        aid: AID,
    },
    async: false,
    success: function (res) {
        if(res.flag){
            keyFirst = res.data.length;
            for(var i = 0;i < res.data.length; i++){
                var obj = {};
                var $this = res.data[i];
                obj['created'] = $this.created;
                obj['key'] = $this.historyKey;
                obj['user'] = {
                    'id': $this.userId,
                    'name': $this.userName
                };
                obj['version'] = i + 1;
                historyOpt.push(obj);
                obj['changesUrl'] = $this.changesUrl;
                obj['fileUrl'] = $this.fileUrl;
                historyArr.push(obj);
            }
        }

    }
});
var onRequestHistory = function() {
    docEditor.refreshHistory({
        "currentVersion": 2,
        "history": historyOpt
        // "history": [
        //     {
        //         "created": "2010-07-06 10:13 AM",
        //         "key": "af86C7e71Ca8",
        //         "user": {
        //             "id": "F89d8069ba2b",
        //             "name": "Kate Cage"
        //         },
        //         "version": 1
        //     },
        //     {
        //         "created": "2010-07-07 3:46 PM",
        //         "key": "Khirz6zTPdfd7",
        //         "user": {
        //             "id": "78e1e841",
        //             "name": "John Smith"
        //         },
        //         "version": 2
        //     },
        // ]
    });
};
var onRequestHistoryClose = function() {
    document.location.reload();
};
var onRequestHistoryData = function (event)  {
    var version = event.data;
    var fileUrl = "";
    var changeUrl = "";
    var key = "";
    var previousKey = "";
    var previousUrl = "";
    for(var i = historyArr.length - 1; i >= 0; i--){
        if (version == historyArr[i].version){
            changeUrl = historyArr[i].changesUrl;
            fileUrl = historyArr[i].fileUrl;
            key = historyArr[i].key;
            if(i > 0){
                previousKey = historyArr[i-1].key;
                previousUrl = historyArr[i-1].fileUrl;
            }else{
                previousKey = key;
                previousUrl = fileUrl;
            }
            break;
        }
    }
    var changeUrl2 = changeUrl.replace(/\u0026/, "&");
    docEditor.setHistoryData({
        //下面这里存变化的位置
        // "changesUrl":"http://192.168.99.100:9000/cache/files/1522475922103673500_7157/changes.zip/changes.zip?md5=syFUueSXdnCWe60Iym001g==&expires=1525068326&disposition=attachment&ooname=output.zip",//string1, //the changesUrl from the JSON object returned after saving the document
        "changesUrl":changeUrl2,
        "key": key,
        "previous": {
            "key": previousKey,//这里不影响版本切换。与上个版本对比
            "url": previousUrl //http://192.168.99.100:9000/cache/files/1521953170330601700_4540/output.docx/output.docx?md5=eSwnrSSumTeMuh59IoXhCQ==&expires=1524547423&disposition=attachment&ooname=output.docx这里影响版本
        },
        "url": fileUrl,
        "version": version
    })
};

window.docEditor = new DocsAPI.DocEditor("placeholder",
    {
        "events" : {
            "onRequestHistory": onRequestHistory,
            "onRequestHistoryClose": onRequestHistoryClose,
            "onRequestHistoryData" : onRequestHistoryData,
        },
        "type": jztype,
        "document": {
            "fileType": type.toLowerCase(),
            "info": {
                "sharingSettings": [
                    {
                        "permissions": "Full Access",
                        "user": userInfo.userName
                    }
                ],
            },
            "permissions": {
                "edit": edit,
                "comment": edit,
                "review": edit,
                "download": true,
                "fillForms": edit,
                "modifyFilter": true,
                "modifyContentControl": true,
            },
            // "key": 'key-' + AID,
            "key": (keyFirst + 40000) + '-key-' + AID,
            "title": title,
            "url": url,

        },

        "documentType": documentType,
        "editorConfig": {
            "callbackUrl": http+onlyOfficeCallBack+attUrl+'&uid='+ userInfo.uid + editUrl,
            "lang": "zh",
            "mode": "edit",
            "user": {
                "id": "1a5a196e-xoa-userId-"+userInfo.userId,
                "name": userInfo.userName
            },
            "customization":{
                "forcesave":"true",
                // 初始化onlyoffice参数配置
	            "unit": "pt",
	        	"spellcheck": false,
	        	// 协助历史显示方式
	        	"reviewDisplay": "final",// 查看模式original-原始版本、final-最终修改版、markup-修改痕迹凸显版
	        	"trackChanges": true// 是否跟踪变化
            }
        },
        "height": "100%",
        "width": "100%"
    });