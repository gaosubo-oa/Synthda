$(function () {
	
	$('.inbox_btn').on('click',function () {
		
		if ($(this).siblings('.ul_show').css('display')=='none') {
			$(this).find('div').removeClass('div_up').addClass('div_down')
			$(this).siblings('.ul_show').slideDown();
		}else{
			$(this).find('div').removeClass('div_down').addClass('div_up')
			$(this).siblings('.ul_show').slideUp();
		}
					
	})
	
})
