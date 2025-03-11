/***********************处理页面上的图片加载完成后重新对图片进行宽度适配处理*******************************/
function imgReloadWidth(imgObj){
    imgObj.each(function() {
        $(this).load(function(){
            var imgPreWidth = $(this).width();
            var src = $(this).attr('src');
            var newimgObj = new Image();
            newimgObj.src = src;
            var imgNextWidth = newimgObj.width;
            if(imgPreWidth >= imgNextWidth){
                $(this).width(imgNextWidth);
            }
        });
    });
}
/************************结束*****************************************************/