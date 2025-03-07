$(function () {
	$('#noty').on({
		click:function () {$('.div_form').css('display','block');},
		mouseover:function () {$(this).css('color','#1969E8');},
		mouseout:function () {
			$(this).css('color','#000000');
			$('.div_form').css('display','none');
		}
	})
	//选择格式
	$('.div_form a').click(function () {
		var txt=$(this).text();
		$('#noty').text(txt);
	})
	
	
	$('.div_form').on({
		mouseover:function () {
			$(this).css('display','block');
		},
		mouseout:function () {
			$(this).css('display','none');
		}
	})
	$('.div_form a').on({
		mouseover:function () {
			$(this).css('color','#1969E8');
		},
		mouseout:function () {
			$(this).css('color','#000000');
		}
	})
	resetTime();
	
	//发布形式
	$('#href_txt').click(function () {
		var str='<tr class="mis"><td>按人员发布：</td><td><textarea name="txt" disabled></textarea><span class="add_img"><span class="addImg"><img src="img/org_select1.png" class="addIcon"/></span><a href="javascript:;" class="Add">添加</a></span><span class="add_img"><span class="addImg"><img src="img/org_select2.png" class="clearIcon"/></span><a href="javascript:;" class="clear">清除</a></span></td></tr>';
		var str1='<tr class="mis"><td>按角色发布：</td><td><textarea name="txt" disabled></textarea><span class="add_img"><span class="addImg"><img src="img/org_select1.png" class="addIcon"/></span><a href="javascript:;" class="Add">添加</a></span><span class="add_img"><span class="addImg"><img src="img/org_select2.png" class="clearIcon"/></span><a href="javascript:;" class="clear">清除</a></span></td></tr>';
		var txt=$(this).text();
		if (txt=='按人员或角色发布') {
			$(this).text('隐藏按人员或角色发布');
			$(this).parent().parent().after(str+str1)
		}else{
			$(this).text('按人员或角色发布');
			$('.mis').remove();
		}
	})
	
	$('.dropdown').click(function () {
		$('.worldColor').toggle();
	})
	
	$('.worldColor ul li').click(function () {
		var rgb=$(this).css('background-color');
		$('.in_title').css('color',rgb);
		$('.worldColor').css('display','none');
	})
	
	
	//点击保存
	$('#btn2').click(function () {
		var val=$('#txt_id').val();
		if (val=='') {
			alert('请输入标题！');
			return;
		}
		
	})
	
})
function resetTime()
	{
	    var today=new Date();
	    var y = today.getFullYear();
	    var M = today.getMonth()+1;
	    var d = today.getDate();
	    var h =today.getHours();
	    var m =today.getMinutes();
	    var s =today.getSeconds();
	    M = checkTimes(M);
	    d = checkTimes(d);
	    h = checkTimes(h);
	    m = checkTimes(m);
	    s = checkTimes(s);
	    var nowDate=y+"-"+M+ "-"+d+" "+h+":"+m+":"+s;
	 
	    document.form1.SEND_TIME.value=nowDate;
	    
	}
	function checkTimes(i)
	{
	    if(i<10)
	    {
	        i="0" + i;
	    }
	    return i;
	}
	
