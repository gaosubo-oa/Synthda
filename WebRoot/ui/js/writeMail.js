$(function () {
	
	$('.a1').click(function () {
		var str='<tr class="tian"><td>'+caoSend+'：</td><td><textarea name="txt" disabled></textarea><span class="add_img"><span class="addImg"><img src="img/org_select.png" class="addIcon"/></span><a href="javascript:;" class="Add">'+global_lang_add+'</a></span><span class="add_img"><span class="addImg"><img src="img/org_select2.png" class="clearIcon"/></span><a href="javascript:;" class="clear">'+notice_th_delete1+'</a></span></td></tr>';
		var txt=$(this).text();
		if (txt==email_th_addwait) {
			$(this).text(email_th_HideCC);
			$('.append_tr').after(str);
		}else{
			$(this).text(email_th_addwait);
			$('.tian').remove();
		}
	})
	
	$('.a2').click(function () {
		var str='<tr class="mis"><td>'+miSend+'：</td><td><textarea name="txt" disabled></textarea><span class="add_img"><span class="addImg"><img src="img/org_select.png" class="addIcon"/></span><a href="javascript:;" class="Add">'+global_lang_add+'</a></span><span class="add_img"><span class="addImg"><img src="img/org_select2.png" class="clearIcon"/></span><a href="javascript:;" class="clear">'+notice_th_delete1+'</a></span></td></tr>';
		var txt=$(this).text();
		if (txt==email_th_addbcc) {
			$(this).text(email_th_HiddenSecret);
			$('.append_tr').after(str);
		}else{
			$(this).text(email_th_addbcc);
			$('.mis').remove();
		}
	})
	
	
	
})
