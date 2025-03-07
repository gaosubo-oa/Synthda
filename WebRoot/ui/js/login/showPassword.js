$.get('/sys/getInterfaceParam', {params:"loginLiterals,fileNumber,loginValidation"},function(res) {
    var data = res.obj;
    //是否显示忘记密码功能
    if(data.IS_OPEN_GET_PASSWORD == 0) {
        $('.resetPsword').css("visibility","hidden")
    }else {
        $('.resetPsword').show()
    }
    //是否显示机密级字样
    if(data.IS_SHOW_JMJ == 0 || !data.IS_SHOW_JMJ) {
        $('.subTitle').hide()
    }else {

        var dom = $('.titleTxt').length > 0?$('.titleTxt'): $('.mainLefttext');
        var titleTxtSize = dom.css("font-size")
        dom.css("display","inline-block");
        var span = $("<span>");
        span.text("机密级★")
        span.css({
            textAlign:"center",
            color:"red",
            fontSize:titleTxtSize,
            fontFamily:" Microsoft yahei",
            fontWeight:"bold",
            "-webkit-text-fill-color":"red"
        })
       dom.after(span);
        // $('.subTitle').show();
        // $('.subTitle').css("font-size",titleTxtSize);
    }
    //是否展示app相关内容
    if(data.IS_USE_APP == 0) {
        $('#android').show()
        $('#iphone').show()
        $('.header').show()
        $('.header').css("height","70px")
        $('.scanLogin ').show()
    }else {
        $('#android').hide()
        $('#iphone').hide()
        $('.header').hide()
        $('.scanLogin').hide()
        $(".header").css({
            height: 0
        })
        $('.mainCon').height($(document).height() - $('.header').height() - 2);
    }
})