var datas;
var timer;
var num = 0;

//弹出层
function scanLogin(selectPart){
    var loginType = $('.scanLogin').attr('loginType')
    var str = '<div class="scanDiv" style="position: absolute;width: 260px;height: 350px;background: white;top: '+function(){
            if(loginType == '3'){
                return '38px'
            }else{
                return ' 0px'
            }
        }()+';left: '+function(){
        if(loginType == '1'){
            return '145px'
        }else if(loginType == '2'){
            return '94px'
        }else if(loginType == '3'){
            return '100px'
        }else{
            return ' 210px'
        }
    }()+';z-index: 999;">\n' +
        // '                      <label style="font-size: 15px;color: #777070;position: absolute;top: 4px;left: 10px;">心通达</label>\n' +
        '                        <span style="float: right;margin-right: 8px;font-size: 20px;color: #777070;cursor: pointer" class="close">×</span>\n' +
        '                        <div style="width: 200px;text-align: center;height: 100px;line-height: 140px;font-size: 18px;color: #298df6;margin: 0 auto;">扫码登录</div>\n' +
        '                        <div class="twoCode" style="width: 200px;margin: 0 auto;"><img class="scanUrl" src="" style="width: 100%"/></div>\n' +
        '                    <div class="shixiao" style="text-align: center;margin-top: -132px;font-size: 22px;display: none"><span style="display: block">二维码已失效</span><span style="display: block">点击重新获取</span></div>' +
        '                    <div style="text-align: center;margin-bottom: 20px;position: absolute;left: 105px;bottom: -5px;" class="close">' +
        '                    <button style="width: 50px;border: none;height: 25px;background: #298df6;color: white;cursor: pointer">返回</button></div>' +
        '                    </div>'
    $('.entryBg').append(str)
    getSecret(selectPart)
}
//获取密钥,显示二维码
function getSecret(selectPart) {
    num = 0;
    $.post('/qrCode/generateSecret',function (json) {
        if (json.flag) {
            datas = json.data;
            $.post('/qrCode/generate',{secret:datas},function (json) {
                if (json.flag) {
                    var imgScan = json.data;
                    $('.scanUrl').attr('src',imgScan)
                }
            }, 'json')
        }
    }, 'json')
    timer = setInterval(function() {
        showState(selectPart);
    }, 5000);
}
//轮询
function showState(selectPart){
    num ++;
    var obj = {
        secret:datas,
        loginId: selectPart || '',
    }
    $.post('/qrCode/query',obj,function (res) {
        if (res.flag) {
            $.setCookie(res.object);
            window.location.href = "main";
        } else{
            if(num > 11){
                clearInterval(timer);
                $('.twoCode').css('opacity','.2')
                $('.shixiao').css('display','block')
            }
        }
    }, 'json')
}
//重新获取二维码
$(document).on("click",'.twoCode',function(){
    $('.shixiao').css('display','none')
    $('.twoCode').css('opacity','1')
    getSecret()
});
//关闭弹出层
$(document).on("click",'.close',function(){
    $('.scanDiv').css('display','none')
    clearInterval(timer);
});
