var safeArea = ["Ⅱ区"];
var equipType = ["工作站"];
var manufacturer = ["联想集团股份有限公司"];
var equipModdel = ["联想集团"];
var installationSite = ["安装地点"];
var runningState = ["在运"];
function _select(type){
    var str= "";
    for(var i=0;i<type.length;i++) {
        str += '<option>' + type[i] + '</option>';
    }
    return str;
}
