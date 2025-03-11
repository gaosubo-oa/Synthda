// 获取当前时间-前一百年至今
function getYear(){
    var getYear = new Date().getFullYear();
    var arr = [];
    for(var i = 0; i < 100; i++){
        var prevYear = getYear - i;
        arr.push(prevYear);
    }
    return arr;
}