<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@taglib prefix="mvc" uri="http://www.springframework.org/tags/form" %>
<%@taglib prefix="fmt" uri="http://www.springframework.org/tags" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="utf-8">
	<!--  <meta http-equiv=X-UA-Compatible content=IE=EmulateIE7>-->
	<meta http-equiv="X-UA-Compatible" content="IE=EmulateIE7"><!– IE7 mode –>
	<meta name="viewport" content="width=device-width,initial-scale=1,minimum-scale=1,maximum-scale=1,user-scalable=no" />
	<title>写日志</title>
	<%--<script type="text/javascript" src="../../js/notes/jquery-2.1.2.min.js" ></script>--%>
	<script src="/js/xoajq/xoajq1.js" type="text/javascript" charset="utf-8"></script>
	<script src="../lib/mui/mui/mui.min.js"></script>
	<script src="../lib/mui/mui/mui.picker.min.js"></script>
	<%--<script src="../js/diary/m/vue.min.js"></script>--%>
	<!--<script src="/static/pack/mobile/js/zepto.min.js"></script>-->
	<link href="../lib/mui/mui/mui.min.css" rel="stylesheet">
	<link href="../lib/mui/mui/mui.picker.min.css" rel="stylesheet">
	<link rel="stylesheet" href="../css/diary/m/diary_base.css" />
	<!--引入淘宝图标-->
	<!-- <link rel="stylesheet" href="//at.alicdn.com/t/font_514260_l812l3ij7cvdkj4i.css" /> -->
	<link rel="stylesheet" href="../css/diary/m/weui.css" />
	<style>
		.mui-content-padded{
			margin: 0;
		}
		li.mui-table-view-cell{
			padding: 6px 15px;
		}
		.mui-btn{
			display: inline-block;
			width: 45%;
			margin-left: 2.5%;

		}
		.mui-btn-negative{
			padding: 4px 0;
		}
		.mui-input-row .mui-btn{
			width: 64%;
			padding-left: 5px;
		}
		.mui-area{
			margin-top: 10px;
		}
		.share .mui-card{
			width: calc(100% - 20px);
		}
		.mui-input-row .mui-btn  input#mui-share-other{

		}
		.mui-bar-nav~.mui-content{
			height: 100%;
			background: #fafafa;
		}
		.mui-input-group .mui-input-row{
			height: 56px;
		}
		.mui-input-row label span{
			display: inline-block;
			margin-bottom: 4px;
		}
		.mui-checkbox  input[type=checkbox]{
			top: 15px;
		}
		#fenxiang_logo{
			float:right;
			font-size:20px;
			color:#CECECE;
			margin-top:10px;
			width:20px;
			height: 20px;
			background:url('/img/diary/m/share.png') no-repeat left top ;
			background-size: 20px 20px;
		}
		.mui-table-view:after
		{
			position: absolute;
			right: 0;
			bottom: 0;
			left: 0;

			/*height: 1px;*/

			content: '';
			-webkit-transform: scaleY(.5);
			transform: scaleY(.5);

			/* background-color: #c8c7cc; */
		}
		.mui-table-view:before
		{
			position: absolute;
			top: 0;
			right: 0;
			left: 0;
			/*height: 1px;*/
			content: '';
			-webkit-transform: scaleY(.5);
			transform: scaleY(.5);

			/*background-color: #c8c7cc; */
		}
		.mui-table-view:before
		{
			top: 0px;
		}
		.weui-cells:after{

		}
		.mui-table-view:after
		{
			position: absolute;
			right: 0;
			bottom: 0;
			left: 0;

			height:0;

			content: '';
			-webkit-transform: scaleY(.5);
			transform: scaleY(.5);

			background-color:'';
		}
		.mui-table-view:before{
			height: 0;
			background-color: '';
		}
		.mui-table-view:after{
			height: 0;
			background-color: '';
		}
		.weui-cells:after{
			height: 0;
			background-color:'';
		}
		.mui-bar{
			border-top:none;
			background-color:'';
			box-shadow:'';
		}
		/*修改底部按钮父元素边框*/
		#nav{
			-webkit-box-shadow: 0 0 1px #d6d6d6;
		}
		.pda_attach.pda_attach_img .icon-delete{
			top: -10px;
			right: -10px;
		}
		.icon-delete{
			position: absolute;
			right: 5px;
			top: 5px;
			background: red;
			width: 20px;
			text-align: center;
			height: 20px;
			line-height: 20px !important;
			border-radius: 10px;
			font-size: 20px !important;
			color: #fff;
			z-index: 99;
		}
		.no_delete .icon-delete{
			display: none;
		}
	</style>
</head>
<body id="Create">
<div class="mui-media" id="main">
	<!--<header class="mui-bar mui-bar-nav">
        <a class="mui-action-back mui-icon mui-icon-left-nav mui-pull-left mui-nav-btn"></a>
        <h1 class="mui-title">新建</h1>
    </header>-->
	<div class="mui-content">
		<nav class="mui-bar-nav mui-btn-negative mui-text-center" style="display:none;background:#fe8e7c; border-color:#fe8e7c;">您有一封日志未提交</nav>
		<div class="mui-content-padded">
			<ul class="mui-table-view mui-table-view-striped mui-table-view-condensed">
				<li class="mui-table-view-cell mui-input-row">
					<label class="mui-tab-label mui-pull-left " style="padding-left:0; color:#666666; font-size:16px;">日志类型</label>
					<select name="" class="typeId" id="diary_type">
						<option value="0" selected="">工作日报</option>
						<option value="1">工作周报</option>
						<option value="2">工作月报</option>
					</select>
				</li>
				<li class="mui-table-view-cell mui-input-row">
					<label class="mui-tab-label mui-pull-left " style="padding-left:0; color:#666666; font-size:16px;">日志标题</label>
					<input style="margin-left:-10px; float:none;" type="text" name="" id="diary_title"  class="mui-pull-right mui-popup-input"/>
				</li>
				<li class="mui-table-view-cell mui-input-row  btnTime">
					<label class="mui-tab-label mui-pull-left " style="padding-left:0; color:#666666; font-size:16px;">选择日期</label>
					<div id="diary_date" style="line-height: 41px;"></div>
				</li>
				<li class="mui-table-view-cell mui-input-row share">
					<label class="mui-tab-label mui-pull-left " style="padding-left:0; color:#666666; font-size:16px;">分享给</label>
					<span id="fenxiang_logo" @click="jump_shareother"></span>
					<input type="input" name=""   class="mui-btn mui-pull-right " id="mui-share-other" value=""  style="position: absolute;left: 30%;width: calc(65% - 30px); text-align:left;" />
					<input type="hidden" name="" id="diary-share-id" value="" />
				</li>
			</ul>
			<ul class="mui-table-view mui-table-view-striped mui-table-view-condensed">
				<li class="mui-table-view-cell mui-input-row mui-area" style="padding-top: 15px;">
					<textarea class="mui-text-justify" id="diary_connect" style="min-height: 100px; border:none; padding:0 15px 10px 0;" placeholder="请填写日志内容"></textarea>
				</li>
			</ul>
			<ul class="mui-table-view mui-table-view-striped mui-table-view-condensed" id="file">
				<div class="page__bd">
					<div class="weui-gallery" id="gallery" style="opacity: 0; display: none;">
						<span class="weui-gallery__img" id="galleryImg" style="background-image:url(blob:https://weui.io/f8aa2ca1-8193-4342-8d9f-807264b6243d)"></span>
						<div class="weui-gallery__opr">
							<a href="javascript:" class="weui-gallery__del">
								<i class="weui-icon-delete weui-icon_gallery-delete"></i>
							</a>
						</div>
					</div>

					<div class="page__bd">
						<div class="weui-gallery" id="gallery" style="opacity: 0; display: none;">
							<span class="weui-gallery__img" id="galleryImg" style="background-image:url(blob:https://weui.io/2268da98-1b8a-48d9-b253-c96b422f2574)"></span>
							<div class="weui-gallery__opr">
								<a href="javascript:" class="weui-gallery__del">
									<i class="weui-icon-delete weui-icon_gallery-delete"></i>
								</a>
							</div>
						</div>

						<div class="weui-cells weui-cells_form">
							<div class="weui-cell" style="margin-bottom:50px">
								<div class="weui-cell__bd">
									<div id="uploader" class="weui-uploader">
										<div class="weui-uploader__hd">
											<p class="weui-uploader__title" style="margin-left:0px;">图片上传</p>
											<!--div class="weui-uploader__info" id="num">0</div-->
										</div>
										<div class="weui-uploader__bd">
											<ul class="weui-uploader__files" id="uploaderFiles" >
											</ul>
											<div class="weui-uploader__input-box" onclick="upload_images(upload_sign)">
												<!--input id="uploaderInput" class="weui-uploader__input" type="file" accept="image/*" multiple="" onChange=""-->
											</div>
										</div>
									</div>
								</div>
							</div>
						</div>
					</div>

				</div>
			</ul>
		</div>

	</div>
	<footer class="mui-bar-footer">
		<nav class="mui-bar mui-bar-tab mui-btn-nav" data-role="footer" id="nav" style="z-index: 1000;">
			<button class="mui-btn mui-btn-block" onclick="diary_save(0)" style="border-color:#d9d9d9;">保存为草稿</button>
			<button class="mui-btn mui-btn-block mui-btn-primary" onclick="diary_save(1)" style="background-color:#5A8FDF; border-color:#5A8FDF;">立即提交</button>
		</nav>
	</footer>
</div>
<div class="mui-media" id="share" style="display: none;">
	<header class="mui-bar mui-bar-nav">
		<a class="mui-action-back mui-icon mui-icon-left-nav mui-pull-left mui-nav-btn"></a>
		<h1 class="mui-title">选择分享给其他人</h1>
		<a class="mui-icon  mui-icon-checkmarkempty mui-pull-right mui-nav-btn" id="save_share" @click="jump_share"></a>
	</header>
	<div class="mui-content">
		<div class="mui-table-cell mui-table-view mui-button-row">
			<button class="mui-btn-nav mui-btn-success mui-btn-mini mui-pull-right">全选</button>
			<button class="mui-btn-nav mui-btn-primary mui-btn-mini mui-pull-right">取消</button>
		</div>
		<div class="mui-input-group" id="checkbox_form">
		</div>
	</div>
</div>
<script>


	/*时间控件*/
//    (function($) {
//        $.init();
//        var result = $('#diary_date')[0];
//        var btns = $('.btnTime');
//        var year=new Date().getFullYear() ;
//
//        var  month=new Date().getMonth();
//
//        var day=new Date().getDate();
//        btns.each(function(i, btn) {
//            btn.addEventListener('tap', function() {
//
//                var optionsJson = this.getAttribute('data-options') || '{}';
//                var options = JSON.parse(optionsJson);
//                var id = this.getAttribute('id');
//				/*
//				 * 首次显示时实例化组件
//				 * 示例为了简洁，将 options 放在了按钮的 dom 上
//				 * 也可以直接通过代码声明 optinos 用于实例化 DtPicker
//				 */
//                var picker = new $.DtPicker(options);
//                var picker = new mui.DtPicker({
//                    type: "datetime",//设置日历初始视图模式
//                    beginDate: new Date(year, month, day),//设置开始日期
//                    endDate: new Date(2222, 04, 25),//设置结束日期
//                    labels: ['年', '月', '日', '时', '分'],//设置默认标签区域提示语
//                })
//
//                picker.show(function(rs) {
//					/*
//					 * rs.value 拼合后的 value
//					 * rs.text 拼合后的 text
//					 * rs.y 年，可以通过 rs.y.vaue 和 rs.y.text 获取值和文本
//					 * rs.m 月，用法同年
//					 * rs.d 日，用法同年
//					 * rs.h 时，用法同年
//					 * rs.i 分（minutes 的第二个字母），用法同年
//					 */
//                    result.innerText = ' ' + rs.text;
//					/*
//					 * 返回 false 可以阻止选择框的关闭
//					 * return false;
//					 */
//					/*
//					 * 释放组件资源，释放后将将不能再操作组件
//					 * 通常情况下，不需要示放组件，new DtPicker(options) 后，可以一直使用。
//					 * 当前示例，因为内容较多，如不进行资原释放，在某些设备上会较慢。
//					 * 所以每次用完便立即调用 dispose 进行释放，下次用时再创建新实例。
//					 */
//                    picker.dispose();
//                });
//            }, false);
//        });
//    })(mui);

    var year=new Date().getFullYear() ;

    var  month=new Date().getMonth();

    var day=new Date().getDate();
    $(".btnTime").click(function(){
        var picker = new mui.DtPicker({
            type: "datetime",//设置日历初始视图模式
            beginDate: new Date(year, month, day),//设置开始日期
            endDate: new Date(2222, 04, 25),//设置结束日期
            labels: ['年', '月', '日', '时', '分'],//设置默认标签区域提示语
        })
        picker.show(function(rs) {
//
            $("#diary_date").html(  rs.text);  //rs.text.split(' ')[0]只获取年。下标改成1，只获取月，以此类推
//
//            //return false;    //这是阻止对话框关闭的
//
            picker.dispose();  //释放组件资源，释放后将将不能再操作组件.所以每次用完便立即调用 dispose 进行释放，下次用时再创建新实例
        })
        $('.mui-btn').html('取消');
        $('.mui-btn-blue').html('确定');
    })



</script>
</body>

<script >
    var id_str ='';
    var name_str ='';
    function GetQueryString(name) {
        var reg = new RegExp("(^|&)" + name + "=([^&]*)(&|$)");
        var r = window.location.search.substr(1).match(reg);
        if (r != null) return unescape(r[2]); return null;
    }
    DEPT_ID = GetQueryString("DEPT_ID"); //括号里放地址栏传参变量
    USER_ID = GetQueryString("USER_ID"); //括号里放地址栏传参变量
//    var data = {
//        "flag":21, //查看路径
//        "USER_TO_ID":USER_ID,
//        "DEPT_TO_ID":DEPT_ID
//    };
//    mui.ajax({
//        data:data,
//        type:'get',
//        url:'/pda/diary/data/data.php',
//        dataType:'json',
//        beforeSend: function() {
//            wait;
//        },
//        complete: function() {
//            closewin;
//        },
//        success:function(data){
//            var str="";
//            for(var i=0; i<data.data.length;i++){
//                str+=data.data[i].DEPT_NAME+",";
//            }
//            for(var i=0; i<data.item.length;i++){
//                str+=data.item[i].USER_NAME+",";
//            }
//            $("#mui-share-other").val(str);
//        },
//        error:function(xhr,type,errorThrown){
//            //异常处理；
//
//        }
//    });
    $(function(){
        var tmpl = '<li class="weui-uploader__file" style="background-image:url(#url#)"></li>',
            $gallery = $("#gallery"), $galleryImg = $("#galleryImg"),
            $uploaderInput = $("#uploaderInput"),
            $uploaderFiles = $("#uploaderFiles")
        ;
        $uploaderInput.on("change", function(e){
            var src, url = window.URL || window.webkitURL || window.mozURL, files = e.target.files;
            for (var i = 0, len = files.length; i < len; ++i) {
                var file = files[i];

                if (url) {
                    src = url.createObjectURL(file);
                } else {
                    src = e.target.result;
                }

                $uploaderFiles.append($(tmpl.replace('#url#', src)));
            }
        });
        if('<?=$rank_n?>'=="2044"){
            $("#diary_type").val('0');
            $("#diary_title").val('<?=$title?>');
        }else if('<?=$rank_n?>'=="2045"){
            $("#diary_type").val('1');
            $("#diary_title").val('<?=$title1?>');
        }else if('<?=$rank_n?>'=="2046"){
            $("#diary_type").val('2');
            $("#diary_title").val('<?=$title2?>');
        }


        $("#diary_type").on("change", function(e){
            var checkText=$("#diary_type").find("option:selected").val();
            if(checkText=='0'){
                $("#diary_title").val('<?=$title?>');
            }
            if(checkText=='1'){
                $("#diary_title").val('<?=$title1?>');
            }
            if(checkText=='2'){
                $("#diary_title").val('<?=$title2?>');
            }
        });
        $uploaderFiles.on("click", "li", function(){
            $galleryImg.attr("style", this.getAttribute("style"));
            $gallery.fadeIn(100);
        });
        $gallery.on("click", function(){
            $gallery.fadeOut(100);
        });
    })

    var platform = "<?=$platform;?>";
    var wait=null;var closewin=null;
    // H5 plus事件处理
    function plusReady(){
        wait=plus.nativeUI.showWaiting('正在加载');
        closewin= plus.nativeUI.closeWaiting();
    }
    if(window.plus){
        plusReady();
    }else{
        document.addEventListener("plusready",plusReady,false);
    }
    function GetQueryString(name) {
        var reg = new RegExp("(^|&)" + name + "=([^&]*)(&|$)");
        var r = window.location.search.substr(1).match(reg);
        if (r != null) return unescape(r[2]); return null;
    }
    DIA_ID = GetQueryString("id"); //括号里放地址栏传参变量
//    (function($) {
//        mui.init({
//            //禁用mui tap监听 否则点击生日选择会弹出两次
//            gestureConfig:{
//                tap:false
//            }
//        });
//        if(DIA_ID != null && DIA_ID != ""){
//            var data = {
//                "flag":18, //查看路径
//                "DIA_ID":DIA_ID
//            };
//            mui.ajax({
//                data:data,
//                type: 'get',
//                url: '/pda/diary/data/data.php',
//                dataType:'json',
//                beforeSend: function() {
//                    wait;
//                },
//                complete: function() {
//                    closewin;
//                },
//                success:function(data){
//                    var DIA_TYPE=""
//                    if(data[0].DIA_TYPE==0){
//                        DIA_TYPE="日报"
//                    }else if(data[0].DIA_TYPE==1){
//                        DIA_TYPE="周报"
//                    }else if(data[0].DIA_TYPE==2){
//                        DIA_TYPE="月报"
//                    }
//                    jQuery("#diary_type").find("option[value="+DIA_TYPE+"]").attr("selected",true);
//                    jQuery("#diary_title").val(data[0].SUBJECT);
//                    jQuery("#diary_date").html(data[0].DIA_DATE);
//                    jQuery("#diary_connect").val(data[0].CONTENT);
//                    if(USER_ID==null || DEPT_ID==null){
//                        jQuery("#diary-share-id").val(data[0].TO_ID);
//                        jQuery("#mui-share-other").val(data[0].TO_NAME);
//                    }
//
//                    if(data[0].FILE_INFO!=""){
//                        var tmpll="";
//                        var attach_arr_id=data[0].ATTACHMENT_ID.split(',');
//                        var attach_arr_name=data[0].ATTACHMENT_NAME.split(',');
//                        for(var i=0;i<data[0].FILE_INFO.length;i++){
//                            tmpll += '<li class="weui-uploader__file pda_attach pda_attach_img" style="background-image:url('+data[0].FILE_INFO[i].view+')" data-diary-id="'+data[0].DIA_ID+'" data-attach_id="'+attach_arr_id[i]+'," data-attach_name="'+attach_arr_name[i]+'," ><span class="icon-delete">×</span></li>';
//                        }
//                        jQuery("#uploaderFiles").append(tmpll);
//                    }
//                },
//                error:function(xhr,type,errorThrown){
//                    //异常处理；
//                    mui.toast(type);
//                }
//            });
//        }
//        var share_str='';
//        mui.ajax({
//            type: 'POST',
//            url: '/pda/diary/data/data.php?flag=6',
//            dataType:'json',
//            beforeSend: function() {
//                wait;
//            },
//            complete: function() {
//                closewin;
//            },
//            success:function(data){
//                if(data !=null && data !=''){
//                    for(var i=0;i<data.length;i++){
//                        share_str+='<div class="mui-input-row mui-checkbox"><label class="mui-tab-label"><span>'+data[i].user_name+'</span><p>'+data[i].dept_name+'-'+data[i].priv_name+'</p></label><input name="checkbox1" value="'+data[i].user_id+'" type="checkbox"></div>';
//                    }
//                }else{
//                    share_str+='<div class="mui-input-row mui-checkbox">暂无可分享人员</div>';
//                }
//                mui("#checkbox_form ")[0].innerHTML=share_str;
//            },
//            error:function(xhr,type,errorThrown){
//                //异常处理；
//                mui.toast(type);
//            }
//        });
//    })(mui);
    function diary_save(s){
        var dia_type=jQuery("#diary_type").val();
        // var seleId=$("#diary_type option:selected").val();
        var diary_title=jQuery("#diary_title").val();
        var d_date=jQuery("#diary_date").html();
        var txt=$('.mui-text-justify').val();
        // alert(jQuery("#diary_date").html());
        var diary_share=jQuery("#diary-share-id").val();
        var diary_connect=jQuery("#diary_connect").val();
        // var attach_id=jQuery(".pda_attach").data('attach_id');
        // var attach_name=jQuery(".pda_attach").data('attach_name');
        if(dia_type == "" && diary_title == "" && d_date == "" && diary_share == "" && diary_connect == ""){
            mui.toast("您还没有输入任何内容！");
        }else{
            jQuery.ajax({
                type: 'POST',
                url: '/diary/save ',
                async:true,
                dataType:'json',
                data:{
                    diaType:1,
                    subject:diary_title,
                    content:diary_connect,
                    toAll:0,
                    attachmentId:"",
                    attachmentName:"",
                    diaDate:""
                },
                beforeSend: function() {
                    wait;
                },
                complete: function() {
                    closewin;
                },
                success:function(data){
                        mui.toast('新建成功',{ duration:'200', type:'div' });
                        jQuery(".mui-content").find('input').val(" ");
                        jQuery(".mui-content").find('textarea').val(" ");
                        setTimeout(function(){
//					  				mui.back();
                            if(s==0){
                              	alert("正在开发中！")
                            }else if(s==1){
                                mui.openWindow({
                                    id:'/diary/iStartedListh5',
                                    url:'/diary/iStartedListh5'
                                });
                            }

                        },200);
                },
                error:function(xhr,type,errorThrown){
                    //异常处理；
                    mui.toast(type+"1");
                }
            });
        }
    }
    var vm=new Vue({
        el:'#Create',
        data:{
            name:'Vue.js'
        },
        methods:{
            jump_shareother:function(event){
                var dia_type=jQuery("#diary_type").val();
                var diary_title=jQuery("#diary_title").val();
                var d_date=jQuery("#diary_date").html();
                var txt=$('.mui-text-justify').val();
                // alert(jQuery("#diary_date").html());
                var diary_share=jQuery("#diary-share-id").val();
                var diary_connect=jQuery("#diary_connect").val();

                // var attach_id=jQuery(".pda_attach").data('attach_id');
                // var attach_name=jQuery(".pda_attach").data('attach_name');
                if(dia_type == "" && diary_title == "" && d_date == "" && diary_share == "" && diary_connect == ""){
                    mui.toast("您还没有输入任何内容！");
                }else{
                    jQuery.ajax({
                        type: 'POST',
                        url: '/pda/diary/data/data.php',
                        async:true,
                        dataType:'json',
                        data:{
                            flag:23,
                            SFLAG:2,
                            DIA_DATE:d_date,
                            DIA_TYPE:dia_type,
                            SUBJECT:diary_title,
                            CONTENT:diary_connect,
                            TO_ID:diary_share,
                            DIA_ID:DIA_ID,
                            ATTACHMENT_ID:id_str,
                            ATTACHMENT_NAME:name_str,
                            DEPT_TO_ID:DEPT_ID,
                            USER_TO_ID:USER_ID,

                        },
                        beforeSend: function() {
                            wait;
                        },
                        complete: function() {
                            closewin;
                        },
                        success:function(data){
                            window.location = '/pda/diary/depart_list.php?DIA_ID='+data.DIA_ID;

                        },
                        error:function(xhr,type,errorThrown){
                            //异常处理；
                            mui.toast(type+"1");
                        }
                    });
                }


            },
            jump_share:function(event){

                var r=document.getElementsByName("checkbox1");
                var to_id='',to_name='';
                for(var i=0;i<r.length;i++){
                    if(r[i].checked){
                        to_id+=r[i].value+",";
                        to_name+=r[i].previousSibling.firstChild.innerHTML+",";
                    }
                }
                jQuery("#diary-share-id").val(to_id);
                jQuery("#mui-share-other").val(to_name);
                jQuery("#main").css("display","block");
                jQuery("#share").css("display","none");

            }
        }
    });
    tMobileSDK.ready(function() {
		/* jQuery('.flex-container').click(function(){
		 alert(123123123);
		 }); */
        // alert(platform);
        // alert(123123123);
        window.upload_sign = function(fileinfo, is_image){
            // alert(is_image);
            if(platform == "client"){
                $.each(fileinfo, function(k, file){
                    var name = file.name;
                    name = name.substring(0,name.length-1);
                    if(is_image){
                        $("#file").append('<a href="javascript:void(0);" data-attach_id="'+file.id+'" data-attach_name="'+name+'" class="pda_attach pda_attach_img" _href="'+file.url+'" is_image="1"><img src="'+ file.url +'" /><span class="icon-delete">×</span></a>');
                    }else{
                        $("#file").append('<a href="javascript:void(0);" data-attach_id="'+file.id+'" data-attach_name="'+name+'" class="pda_attach" _href="'+file.url+'"><span class="fileupload_attach_name">'+name+'</span><span class="icon-delete">×</span></a>');
                    }

                });
            }else if(platform == "wx"){
                // alert('wxlalal');
                var imgServerId = tMobileSDK.imgServerId.join(',');
                // alert(imgServerId);
                $.ajax({
                    type: 'GET',
                    url: '/pda/workflow/img_download.php',
                    cache: false,
                    data: {
                        'ATTACHMENTS': imgServerId,
                        "PLATFORM": platform
                    },
                    success: function(ret)
                    {
                        // alert(ret);
                        str = '';
                        var d = JSON.parse(ret);
                        $.each(d, function(k, img){
                            var attach_id = img.attach_id;
                            var attach_name = img.attach_name;
                            var attach_url = img.attach_url;
                            // str += attach_id+',';
                            // $("#uploaderFiles").append('<li  data-attach_id="'+attach_id+'" data-attach_name="'+attach_name+'" class="pda_attach pda_attach_img" is_image="1" _href="'+attach_url+'" width="50" height="50"><img src="'+ attach_url +'" /><span class="icon-delete">×</span></li>');<li class="weui-uploader__file" style="background-image:url(#url#)"></li>
                            //$("#UPLOAD_AREA_PUBLIC").append('<a href="javascript:void(0);" data-attach_id="'+attach_id+'" data-attach_name="'+attach_name+'" class="pda_attach pda_attach_img" is_image="1" _href="'+attach_url+'"><img src="'+ attach_url +'" /><span class="icon-delete">×</span></a>');
                            id_str += attach_id;
                            name_str += attach_name+',';

                            var tmpl = '<li class="weui-uploader__file pda_attach pda_attach_img" style="background-image:url(#url#)" data-attach_id="'+attach_id+'" data-attach_name="'+attach_name+'" ><span class="icon-delete">×</span></li>'
                            // alert(tmpl);
                            $("#uploaderFiles").append($(tmpl.replace('#url#', attach_url)));

                        });
                    }
                });
            }
        }
        window.upload_images = function(callback, $list, from)//from是会签还是附件
        {
            // alert(callback);
            // return;
            if(typeof callback != "function"){
                callback = function(){}
            }
            $list = $("#uploaderFiles");
            try{
                if(platform == "client"){
                    tMobileSDK.chooseImage({
                        onSuccess: function(result) {
                            callback && callback(result, 'is_image');
                        },
                        onFail: function(err) {
                        }
                    });
                }else if(platform == "wx"){
                    tMobileSDK.uploadImage({
                        sizeType: ['compress'],
                        imgList: $list,
                        upErrorCb : function (){},
                        upSuccessCb: function (){
                            // alert('5121111');
                            callback && callback();
                            return;
                        },
                        imgTpl: ''
                    })
                }

            }catch(e){
                alert(e);
            }
        }
        $('body').delegate('span.icon-delete', 'click', function(event){
            event.preventDefault();
            event.stopPropagation();
            var $this = $(this);
            var diary_id = $this.parent(".pda_attach").attr("data-diary-id");
            var id = $this.parent(".pda_attach").attr("data-attach_id");
            var name = $this.parent(".pda_attach").attr("data-attach_name");
            id_str = id_str.replace(id,'');
            name_str = name_str.replace(name,'');
            name_str = name_str.replace(',,',',');
            var delete_flag = delete_attach(id, name);
            if(delete_flag === true){
                $this.parent(".pda_attach").remove();
                //删除日志表的图片id和name
                jQuery.ajax({
                    type: 'POST',
                    url: 'data/data.php',
                    cache: false,
                    data: {
                        'flag':22,
                        "dia_id": diary_id,
                        "attach_id": id,
                        "attach_name": name
                    },
                    success: function(data)
                    {

                    }
                });
            }
            return false;
        });
        window.delete_attach = function(id, name){
            var url = '';
            var delete_flag = false;
            $.ajax({
                type: 'GET',
                url: 'delete_sign_attach.php',
                cache: false,
                async: false,
                data: {
                    'ATTACHMENT_ID': id,
                    'ATTACHMENT_NAME': name
                },
                success: function(d){
                    if(d == '1'){
                        //alert("附件删除成功");
                        delete_flag = true;
                    }
                },
                error: function(e){
                    //alert("附件删除失败");
                    delete_flag = false;
                }
            });
            return delete_flag;
        }
    });
</script>
</html>