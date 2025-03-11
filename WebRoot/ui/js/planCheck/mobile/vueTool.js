Vue.mixin({
    methods: {
        isShowNull: function (data) {
            if (!!data) {
                return data
            } else {
                return ''
            }
        },
        getFileList: function (fileArr) {
            let files = []

            if (fileArr && fileArr.length > 0) {
                fileArr.forEach(function (file, index) {
                    let attachName = file.attachName;
                    let fileExtension = attachName.substring(attachName.lastIndexOf(".") + 1, attachName.length);//截取附件文件后缀
                    let attName = encodeURI(attachName).replace(/\+/g, "%2b").replace(/\@/g, "%40").replace(/#/g, "%23").replace(/\&/g, "%26").replace(/\//g, "%2F").replace(/\?/g, "%3F").replace(/\￥/g, "%ef%bf%a5").replace(/$/g, "%24").replace(/\！/g, "%ef%bc%81").replace(/\（/g, "%ef%bc%88").replace(/\）/g, "%ef%bc%89").replace(/\…/g, "%e2%80%a6%e2%80%a6");
                    let fileExtensionName = attName.substring(0, attName.lastIndexOf("."));
                    let attachmentUrl = file.attUrl;
                    attachmentUrl = attachmentUrl.substring(0, attachmentUrl.lastIndexOf("ATTACHMENT_NAME=")) + "ATTACHMENT_NAME=" + fileExtensionName + "." + fileExtension; //处理附件名字

                    files.push({key: index, url: '/download?' + encodeURI(attachmentUrl), attachName: attachName});
                });
            }

            return files
        },
        format: function (date) {
            if (date) {
                return new Date(date).Format("yyyy-MM-dd")
            } else {
                return ''
            }
        },
        closePage: function () {
            if (( /(iPhone|iPad|iPod|iOS)/i.test(navigator.userAgent) )) {
                try {
                    window.webkit.messageHandlers.finishWork.postMessage({});
                } catch (err) {
                    finishWork();
                }
            } else if (/(Android)/i.test(navigator.userAgent)) {
                Android.finishWebActivity();
            }
        },
        taskStatus: function (value) {
            let str = ''
            if (value == 0) {
                str = '未开始'
            } else if (value == 1) {
                str = '进行中'
            } else if (value == 2) {
                str = '将到期'
            } else if (value == 4) {
                str = '已延期'
            } else if (value == 5) {
                str = '完成'
            } else if (value == 6) {
                str = '延期完成'
            } else if (value == 7) {
                str = '暂停'
            } else if (value == 8) {
                str = '关闭'
            }
            return str
        },
    }
})

/**
 * 下载附件
 * @param e (dom节点)
 * @param url (下载链接)
 * @param name (文件名)
 */
function downloadFile(e, url, name) {
    if (!url || !name) {
        url = $(e).attr('url');
        name = $(e).attr('name');
    }

    let basePath = '/';

    if (url.indexOf(basePath) == -1) {
        url = basePath + url;
    }

    if (( /(iPhone|iPad|iPod|iOS)/i.test(navigator.userAgent) )) {
        try {
            window.webkit.messageHandlers.overLookFile.postMessage({'url': url, 'name': name});
        } catch (error) {
            overLookFile(url, name);
        }
    } else if (/(Android)/i.test(navigator.userAgent)) {
        Android.overLookFile(url, name);
    } else {
        window.open(url);
    }
}