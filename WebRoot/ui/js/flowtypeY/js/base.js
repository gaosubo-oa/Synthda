 var name_c,name_d,name_e;
var dept=0;
var dept_id=0;
var priv=0;
var priv_id=0;
var user=0;
var user_id=0;
 function ff(){
 	if(name_e==1){
 		 	if(name_c=="重新登录"){
  window.top.location.href=name_d;
       
 	}else if(name_c=="关闭"){
 		window.close();
 	}
 	else{
 		window.open(name_d);
 	}
 	}else{
 		 	if(name_c=="重新登录"){
  window.top.location.href=name_d;
       
 	}else if(name_c=="关闭"){
 		window.close();
 	}
 	else{
 		window.location.href=name_d;
 	}
 	}

 }
 function ee(){
	 $('.pro').hide();
 }
  function gg(){
	 $('.pro').hide();
	 window.open(name_d);
 }
			function _pro_(){
				    var a= arguments[0];
			     	    a="pro_"+a;
			     	var b=arguments[1];  
			     	var c=arguments[2]; 
			     	var d=arguments[3];
			     	name_c=c;
			     	name_d=d;
			     	name_e=arguments[4];
			     	var tab='<div class="pro"><table><tr><td height="20" colspan="2" align="right"></ztd></tr><tr><td class="pro_left"><i class="pro_img '+a+'"></i></td><td class="pro_right" style="text-align:left">'+b+'</td></tr><tr><td colspan="2" align="right"></td></tr></table><a style="margin:20px auto 0;padding:5px 10px;background-color:cornflowerblue;color:#fff;border:1px solid blue;display:inline-block;border-radius:5px;" onclick="ff()">'+c+'</a></div>';
			        document.write(tab);
			     }
			function _pro2_(){
				    var a= arguments[0];
			     	    a="pro_"+a;
			     	var b=arguments[1];  
			     	var c=arguments[2]; 
			     	var d=arguments[3];
			     	name_c=c;
			     	name_d=d;
			     	name_e=arguments[4];
					console.log(a,b,c,d,name_e);
			     	var tab='<div class="pro" style="z-index:99999"><table><tr><td height="20" colspan="2" align="right"></ztd></tr><tr><td class="pro_left"><i class="pro_img '+a+'"></i></td><td class="pro_right" style="text-align:left">'+b+'</td></tr><tr><td colspan="2" align="right"></td></tr></table><a style="margin:20px auto 0;padding:5px 10px;background-color:cornflowerblue;color:#fff;border:1px solid blue;display:inline-block;border-radius:5px;mragin-right:30px;" onclick="gg()">'+c+'</a><a style="margin:20px auto 0;padding:5px 10px;background-color:cornflowerblue;color:#fff;border:1px solid blue;display:inline-block;border-radius:5px;margin-left:30px;" onclick="ee()">'+name_e+'</a></div>';
			        document.write(tab);
			     }
			      function _pro1_(){
			        var a= arguments[0];
			     	    a="pro_"+a;
			     	var b=arguments[1];  
			     	var tab='<table class="pro"><tr><td height="20" colspan="2" align="right"></td></tr><tr><td class="pro_left"><i class="pro_img '+a+'"></i></td><td class="pro_right" style="text-align:left">'+b+'</td></tr><tr><td></td><td></td></tr></table>';			      
			     	if(arguments[2]){
			     		var c=arguments[2];
			     		$(c).html(tab);
			     	}else{
			           document.write(tab);
			     	}		     	
			    
			     }
			      function Ajax(){
			      	var data;
			      	var a=arguments[0];
			      	var b=arguments[1];
			      	var c=arguments[2];
			      	$.ajax({
			      		data:a,
			      		dataType:'json',
			      		type:"get",
			      		url:b,
			      		async:c,
			      		success:function(obj){	
			      			data=obj;
			      		},
			      		error:function(){
			      		}
			      	});
			      return data;
			      }
		//图片预览
		
    function setImagePreviews(avalue) {
           $('#cos_span0').show()
        var docObj = document.getElementById("doc");

        var dd = document.getElementById("dd");

        dd.innerHTML = "";

        var fileList = docObj.files;

        for (var i = 0; i < fileList.length; i++) {            



            dd.innerHTML += "<div style='float:left' > <img id='img_" + i + "'  /> </div>";

            var imgObjPreview = document.getElementById("img_"+i); 

            if (docObj.files && docObj.files[i]) {

                //火狐下，直接设img属性

                imgObjPreview.style.display = 'block';

                imgObjPreview.style.width = '150px';

                imgObjPreview.style.height = '180px';

                //imgObjPreview.src = docObj.files[0].getAsDataURL();

                //火狐7以上版本不能用上面的getAsDataURL()方式获取，需要一下方式

                imgObjPreview.src = window.URL.createObjectURL(docObj.files[i]);

            }

            else {

                //IE下，使用滤镜

                docObj.select();

                var imgSrc = document.selection.createRange().text;

                alert(imgSrc)

                var localImagId = document.getElementById("img_" + i);

                //必须设置初始大小

                localImagId.style.width = "150px";

                localImagId.style.height = "180px";

                //图片异常的捕捉，防止用户修改后缀来伪造图片

                try {

                    localImagId.style.filter = "progid:DXImageTransform.Microsoft.AlphaImageLoader(sizingMethod=scale)";

                    localImagId.filters.item("DXImageTransform.Microsoft.AlphaImageLoader").src = imgSrc;

                }

                catch (e) {

                    alert("您上传的图片格式不正确，请重新选择!");

                    return false;

                }

                imgObjPreview.style.display = 'none';

                document.selection.empty();

            }

        }  



        return true;

    }
function dept(a,b){ 
	  dept=a;
	  dept_id=b;
	window.open ('../../../../lib/api/org/dept/index.php#', 'hh', 'height=420, width=800, top=200, left=400')
}
function priv(a,b){ 
	priv=a;
	priv_id=b;
	window.open ('../../../../lib/api/org/priv/index.php#', 'hh', 'height=420, width=800, top=200, left=400')
}
function user(a,b){ 
	user=a;
	user_id=b;
	window.open ('../../../../lib/api/org/user/index.php#', 'hh', 'height=420, width=800, top=200, left=400')
}