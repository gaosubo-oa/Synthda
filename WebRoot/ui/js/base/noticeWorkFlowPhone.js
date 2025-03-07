function clickDownload(e){
    var url = e.attr('url');
    url = decodeURI(decodeURI(url));
    var name = url.split('&ATTACHMENT_NAME=')[1];
    if (( /(iPhone|iPad|iPod|iOS)/i.test(navigator.userAgent) )) {
        try{
            window.webkit.messageHandlers.overLookFile.postMessage({'url':url,'name':name});
        }catch(err){
            overLookFile(url,name);
        }
    }else if (/(Android)/i.test(navigator.userAgent)) {
        Android.overLookFile(url,name);
    }

}
var length = 0;
setInterval(function () {
    length = document.getElementsByClassName('download').length;
    if(length != 0){
        for(var i=0;i<document.getElementsByClassName('download').length;i++){
            document.getElementsByClassName('download')[i].innerHTML  = '查阅';
        }
        clearInterval();
    }
}, 1000);
$(document).on('click','a',function(){
    var e = $(this);
    if(e.attr('onclick') == undefined){
        var url = e.attr('href')+e.attr('title');
        e.attr({
            'url':encodeURI(encodeURI(url)),
            'onclick':'clickDownload($(this));',
        }).removeAttr('href');
    }
})
