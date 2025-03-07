function past(imageType) {
    window.location.href="/defaultIndexErr?imageType="+imageType;
}
var lockded1 = false;
function encryptPadding() {
    // 创建一个加密对象 使用该对象需要先引入jsencrypt.js文件
    //var encryptor = new JSEncrypt();
    var result1;
    // 获取公钥
    if (!lockded1) {
        lockded1 = true;
        $.ajax({
            type: "post",
            async: false,
            url:  "/getPublicKey",
            success: function (result) {
                // 把公钥放到加密对象中
                //encryptor.setPublicKey(result);
                if (result) {
                    console.log('111')
                    result1=result;
                }else {
                    console.log('222')
                    lockded1 = false;
                    result1=result;
                }

            }
        });
        return result1;
    }


}

function getBlackTheme(){
    // 查询是否开启黑色主题
    $.ajax({
        url: "/sys/getBlackTheme",
        type: "get",
        datatType: "json",
        success: function (data) {
            if(data.flag) {
                if (data.object && data.object.blackTheme === '1') {
                    $("html").css({"-webkit-filter":"grayscale(100%)",
                        " -moz-filterr":"grayscale(100%)",
                        "-ms-filter":"grayscale(100%)",
                        "-o-filter":"grayscale(100%)",
                        " filter":"grayscale(100%)",
                    })
                    $("*").css({"-webkit-filter":"grayscale(100%)",
                        " -moz-filterr":"grayscale(100%)",
                        "-ms-filter":"grayscale(100%)",
                        "-o-filter":"grayscale(100%)",
                        " filter":"grayscale(100%)",
                        " filter":"gray",
                    })
                }
            }

        }
    })
}
