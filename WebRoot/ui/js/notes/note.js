/**
 * Created by gsb on 2017/10/10.
 */
function gon_hover(){
    $(function () {
        $(".span_bj").hover(function () {
                $(this).children("img").show();
                // $(this).css({"-webkit-box-shadow":"inset 0 0 30px #fff"," -moz-box-shadow":"inset 0 0 30px #fff","box-shadow":"inset 0 0 30px #fff","opicaty": "0.3"});
            }, //mouseenter
            function () {
                $(this).children("img").hide();
                // $(this).css({"-webkit-box-shadow":"none"," -moz-box-shadow":"none","box-shadow":"none"});
            });//mouseleave
    });
}
var uids;
var aidnum;

function bbb(){
}


var reg = /^#([0-9a-fA-f]{3}|[0-9a-fA-f]{6})$/;
String.prototype.colorHex = function(){
    var that = this;
    if(/^(rgb|RGB)/.test(that)){
        var aColor = that.replace(/(?:\(|\)|rgb|RGB)*/g,"").split(",");
        var strHex = "#";
        for(var i=0; i<aColor.length; i++){
            var hex = Number(aColor[i]).toString(16);
            if(hex === "0"){
                hex += hex;
            }
            strHex += hex;
        }
        if(strHex.length !== 7){
            strHex = that;
        }
        return strHex;
    }else if(reg.test(that)){
        var aNum = that.replace(/#/,"").split("");
        if(aNum.length === 6){
            return that;
        }else if(aNum.length === 3){
            var numHex = "#";
            for(var i=0; i<aNum.length; i+=1){
                numHex += (aNum[i]+aNum[i]);
            }
            return numHex;
        }
    }else{
        return that;
    }
};//rgb颜色值转化16进制颜色值
