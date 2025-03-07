/**
 * zlj
 * js多语言引入文件
 * @param name
 * @returns {null}
 */

function getCookie(name)
{
    var arr,reg=new RegExp("(^| )"+name+"=([^;]*)(;|$)");
    if(arr=document.cookie.match(reg))
        return unescape(arr[2]);
    else
        return null;
}


var type = getCookie("language");

if(type){
    var src="/js/Internationalization/"+type+".js";
}else{
    var src="/js/Internationalization/zh_CN.js";
}
if(type != 'zh_CN'){
    var css = '/css/language/'+ type + '.css';
}

document.write("<script language=javascript src="+ src +"></script>");
document.write(' <link rel="stylesheet" href="'+ css +'">');
