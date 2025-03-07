/**
 * Created by admin on 2019/7/15.
 */
// 获取当前页面宽度
function autodiv(){
    var winHeight=0;
    if (window.innerHeight)
        winHeight = window.innerHeight;
    else if ((document.body) && (document.body.clientHeight))
        winHeight = document.body.clientHeight;
    if (document.documentElement && document.documentElement.clientHeight)
        winHeight = document.documentElement.clientHeight;
    winWidth = document.documentElement.clientWidth;

    $('#pick').css({'min-height':winHeight - 255 +"px"})

}

function autodivheight(){
    var winHeight=0;
    if (window.innerHeight)
        winHeight = window.innerHeight;
    else if ((document.body) && (document.body.clientHeight))
        winHeight = document.body.clientHeight;
    if (document.documentElement && document.documentElement.clientHeight)
        winHeight = document.documentElement.clientHeight;
    winWidth = document.documentElement.clientWidth;

   return winHeight

}

(function($){
    $.getUrlParam = function(name) {
        var reg = new RegExp("(^|&)"+ name +"=([^&]*)(&|$)");
        var r = window.location.search.substr(1).match(reg);
        if (r!=null) return unescape(r[2]); return null;
    }
})(jQuery);

// 数组去重
function unique(array) {
    // res用来存储结果
    var res = [];
    for (var i = 0, arrayLen = array.length; i < arrayLen; i++) {
        for (var j = 0, resLen = res.length; j < resLen; j++ ) {
            if (array[i] === res[j]) {
                break;
            }
        }
        // 如果array[i]是唯一的，那么执行完循环，j等于resLen
        if (j === resLen) {
            res.push(array[i])
        }
    }
    return res;
}

// 去除最后一个字符
function delastr(str) {
    return str.substring(0, str.length - 1);
}

// 渐变色
/*
 // startColor：开始颜色hex
 // endColor：结束颜色hex
 // step:几个阶级（几步）
 */

function gradientColor(startColor,endColor,step){
    startRGB = this.colorRgb(startColor);//转换为rgb数组模式
    startR = startRGB[0];
    startG = startRGB[1];
    startB = startRGB[2];

    endRGB = this.colorRgb(endColor);
    endR = endRGB[0];
    endG = endRGB[1];
    endB = endRGB[2];

    sR = (endR-startR)/step;//总差值
    sG = (endG-startG)/step;
    sB = (endB-startB)/step;

    var colorArr = [];
    for(var i=0;i<step;i++){
        //计算每一步的hex值
        var hex = this.colorHex('rgb('+parseInt((sR*i+startR))+','+parseInt((sG*i+startG))+','+parseInt((sB*i+startB))+')');
        colorArr.push(hex);
    }
    return colorArr;
}

// 将hex表示方式转换为rgb表示方式(这里返回rgb数组模式)
gradientColor.prototype.colorRgb = function(sColor){
    var reg = /^#([0-9a-fA-f]{3}|[0-9a-fA-f]{6})$/;
    var sColor = sColor.toLowerCase();
    if(sColor && reg.test(sColor)){
        if(sColor.length === 4){
            var sColorNew = "#";
            for(var i=1; i<4; i+=1){
                sColorNew += sColor.slice(i,i+1).concat(sColor.slice(i,i+1));
            }
            sColor = sColorNew;
        }
        //处理六位的颜色值
        var sColorChange = [];
        for(var i=1; i<7; i+=2){
            sColorChange.push(parseInt("0x"+sColor.slice(i,i+2)));
        }
        return sColorChange;
    }else{
        return sColor;
    }
};

// 将rgb表示方式转换为hex表示方式
gradientColor.prototype.colorHex = function(rgb){
    var _this = rgb;
    var reg = /^#([0-9a-fA-f]{3}|[0-9a-fA-f]{6})$/;
    if(/^(rgb|RGB)/.test(_this)){
        var aColor = _this.replace(/(?:(|)|rgb|RGB)*/g,"").split(",");
        var strHex = "#";
        for(var i=0; i<aColor.length; i++){
            var hex = Number(aColor[i]).toString(16);
            hex = hex<10 ? 0+''+hex :hex;// 保证每个rgb的值为2位
            if(hex === "0"){
                hex += hex;
            }
            strHex += hex;
        }
        if(strHex.length !== 7){
            strHex = _this;
        }
        return strHex;
    }else if(reg.test(_this)){
        var aNum = _this.replace(/#/,"").split("");
        if(aNum.length === 6){
            return _this;
        }else if(aNum.length === 3){
            var numHex = "#";
            for(var i=0; i<aNum.length; i+=1){
                numHex += (aNum[i]+aNum[i]);
            }
            return numHex;
        }
    }else{
        return _this;
    }
}

// 选填按钮方法
function ruleButton(code,id) {
    if(code){
        var btn = '';
        var lists = code.split(',');

        $.each(lists,function (index,item) {
            btn += '<img type="'+item+'" objId="'+id+'" class="imgs" onclick="ruleBtnFunc(this)" src="/lims/img/project/'+item+'.png" alt="">'
        })

        return btn

    }else return''

}

// 数组删除指定元素
Array.prototype.remove = function(val) {
    var index = this.indexOf(val);
    if (index > -1) {
        this.splice(index, 1);
    }
};
