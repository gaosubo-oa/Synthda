<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	 <%@taglib prefix="mvc" uri="http://www.springframework.org/tags/form" %>
<%@taglib prefix="fmt" uri="http://www.springframework.org/tags" %>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html>
<html>
<head>
	<title>OA升级</title>
	<meta http-equiv="Content-Type" content="text/html; charset=gbk" />
	<meta name="renderer" content="webkit">
	<meta http-equiv="X-UA-Compatible" content="IE=10,chrome=1" />
	<meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=0, minimum-scale=1.0, maximum-scale=1.0">
	<link rel="stylesheet" href="/lib/layui/layui/css/layui.css?20210319.1"  media="all">
	<script src="../js/xoajq/xoajq1.js" type="text/javascript" charset="utf-8"></script>
	<script src="../lib/layer/layer.js?20201106" type="text/javascript" charset="utf-8"></script>
	<script src="../js/base/base.js" type="text/javascript" charset="utf-8"></script>
	<%--<script src="/js/jqmeter.min.js" type="text/javascript"></script>--%>
	<style type="text/css">
		body,div,a,span,p,input,table,tr,td,th,thead,tbody,select{
			margin: 0;
			padding: 0;
		}
		body{
			font-family: 微软雅黑;
			width: 100%;
			/*overflow: hidden;*/
			background: #f2f2f2;
		}
		.content{
			width: 100%;

		}
		.main{
			width: 800px;
			margin: 50px auto;
			padding: 10px;
			position: relative;
		}
		.fifthSteps{
			width: 1170px;
			margin: 0px auto;
		}
		.divTitle{
			width: 100%;
			height: 40px;
			line-height: 40px;
			text-align: left;
			font-size: 22px;
			font-weight: bold;
			margin-bottom: 20px;
		}
		.main p{
			font-size: 16px;
			color: #555;
			line-height: 30px;

		}
		.tbox div{
			width:0px;
			height:20px;
			background:url(/img/common/pro.png) no-repeat;
			text-align:center;
			font-family: 微软雅黑;
			font-size:14px;
			line-height:20px;
			background-size: 100% 100%;
		}
		.workStatus{
			height:60px;
			width: 82%;
			margin: 0 auto;
		}
		.daoxian{
			width: 56%;
		}
		.workStatus span{
			display: block;
			float: left;
		}
		.boxDiv{
			float: left;
			position: relative;
			width: 28px;
			height: 28px;
			border-radius:50%;
		}
		.textSpan{
			display: block;
			position: absolute;
			width: 70px;
			height: 21px;
			bottom: -25px;
			left: -17px;
		}
		.circleSpan{
			width: 28px;
			height: 28px;
			border-radius:50%;
			border: #bcbcbc 1px solid;
			text-align: center;
			color: #bbb;
			line-height: 28px;
			font-size: 20px;
		}
		.lineSpan{
			width: 180px;
			height:8px;
			background: #e4e4e4;
			margin-top: 11px;
		}
		.backSpan{
			background-color: #0f7eee;
			color: #fff;
			border: #0f7eee 1px solid;
		}
		.backLine{
			background: #0f7eee;
		}
		.backText{
			color: #0f7eee;
		}
		.spanBorder{
			border:#0f7eee 1px solid;
			color: #0f7eee;
		}
		.describe{
			/*margin-top: 50px;*/
			position: relative;
			width: 90%;
			margin: 0 auto;
			border:#ccc 1px solid;
			padding: 30px 10px;
			box-sizing: border-box;
			overflow: hidden;
		}
		.yichang{
			box-sizing: border-box;
			position: absolute;
			display: block;
			width: 100%;
			height:28px;
			line-height: 28px;
			padding-left: 10px;
			left:0px;
			bottom: 0px;
			background: #fed2d2;
		}
		.divFooter{
			width: 90%;
			margin: 0 auto;
			height: 50px;
			margin-top: 20px;
		}
		.prompt{
			float: left;
		}
		.divBtn{
			float: right;
			width: 140px;
			height: 40px;
			/*background-color: rgb(47,128,209);*/
			background: url("/img/common/updateDatebase/anniu_normal.png") no-repeat;
			/*border-radius:5px;*/
			font-size: 17px;
			line-height: 40px;
			text-align: center;
			color: #fff;
			cursor: pointer;
			margin-top: 5px;
		}
		.prompt{
			height: 100%;
			line-height: 50px;
			/*margin-left: 43px;*/
		}
		.iconHeader{
			width: 100%;
			height: 70px;
			padding-top:15px;
			background: #f6f9fb;
			border:#e4e4e4 1px solid;
		}
		/*.shengjishibai{*/
			/**/
		/*}*/
		.borderMiddle{
			width: 100%;
			border:#e4e4e4 1px solid;
			padding-top: 40px;
			background: #fff;
			padding-bottom: 30px;
		}
		.midText{
			display: block;
			width: 100%;
			text-align: left;
			font-weight: bold;
			margin-bottom: 10px;
			color: #0f7eee;
			font-size: 22px;
		}
		.aBtn{
			display: block;
			width: 120px;
			height: 40px;
			background: url("/img/common/updateDatebase/anniu_normal.png") no-repeat;
			font-size: 17px;
			line-height: 40px;
			text-align: center;
			color: #fff;
			cursor: pointer;
			margin: 5px auto;
		}
	</style>
</head>
<body>
	<div class="content">
		<%--第一步--%>
		<div class="main firstStep" style="display: block;">
			<div class="divTitle">OA升级心通达向导</div>
			<div class="iconHeader">
				<div class="workStatus">
					<div class="boxDiv">
						<span class="circleSpan backSpan">1</span>
						<span class="textSpan backText">准备工作</span>
					</div>
					<span class="lineSpan backLine"></span>
					<div class="boxDiv">
						<span class="circleSpan">2</span>
						<span class="textSpan">环境检测</span>
					</div>
					<span class="lineSpan"></span>
					<div class="boxDiv">
						<span class="circleSpan">3</span>
						<span class="textSpan">执行升级</span>
					</div>
					<span class="lineSpan"></span>
					<div class="boxDiv">
						<span class="circleSpan">4</span>
						<span class="textSpan">升级完成</span>
					</div>
				</div>
			</div>
			<div class="borderMiddle">
				<div class="describe">
					<span class="midText" style="">准备工作</span>
					<p>1.按照文档进行数据库操作。</p>
				</div>
				<div class="divFooter">
					<div class="prompt">
						<label for="checked">
							<input id="checked" type="checkbox" class="checked">
							确认按上述要求操作
						</label>
					</div>
					<div class="divBtn" id="divBtn">下一步</div>
				</div>
			</div>
		</div>
		<%--第二步--%>
		<div class="main secondSteps" style="display: none;">
			<div class="divTitle">OA升级心通达向导</div>
			<div class="iconHeader">
				<div class="workStatus">
					<div class="boxDiv">
						<span class="circleSpan backSpan">1</span>
						<span class="textSpan backText">准备工作</span>
					</div>
					<span class="lineSpan backLine"></span>
					<div class="boxDiv">
						<span class="circleSpan spanBorder">2</span>
						<span class="textSpan backText">环境检测</span>
					</div>
					<span class="lineSpan"></span>
					<div class="boxDiv">
						<span class="circleSpan">3</span>
						<span class="textSpan">执行升级</span>
					</div>
					<span class="lineSpan"></span>
					<div class="boxDiv">
						<span class="circleSpan">4</span>
						<span class="textSpan">升级完成</span>
					</div>
				</div>
			</div>
			<div class="borderMiddle">
				<div class="describe">
					<span class="midText" style="">环境检测</span>
					<p><span style="display: inline-block;width: 180px;">1.OA版本为8.X以上版本</span>
						<span style="margin-left: 50px;color: #00bc5d;">满足<img src="/img/common/updateDatebase/icon_zhengque.png" style="margin-left: 10px;" alt=""></span>
					</p>
					<p><span style="display: inline-block;width: 180px;">2.MySQL数据库连接</span>
						<span style="margin-left: 50px;color: #00bc5d;">正常<img src="/img/common/updateDatebase/icon_zhengque.png" style="margin-left: 10px;" alt=""></span>
					</p>
					<p><span style="display: inline-block;width: 180px;">3.心通达库TD_OA</span>
						<span style="margin-left: 50px;color: #00bc5d;">存在<img src="/img/common/updateDatebase/icon_zhengque.png" style="margin-left: 10px;" alt=""></span>
					</p>
				</div>
				<div class="divFooter">
					<div class="divBtn" id="nextBtn">升级</div>
					<div class="divBtn" id="prevBtn" style="margin-right: 10px;">上一步</div>
				</div>
			</div>
		</div>
		<%--第三步--%>
		<div class="main thirdSteps" style="display: none;">
			<div class="divTitle">OA升级心通达向导</div>
			<div class="iconHeader">
				<div class="workStatus">
					<div class="boxDiv">
						<span class="circleSpan backSpan">1</span>
						<span class="textSpan backText">准备工作</span>
					</div>
					<span class="lineSpan backLine"></span>
					<div class="boxDiv">
						<span class="circleSpan backSpan">2</span>
						<span class="textSpan backText">环境检测</span>
					</div>
					<span class="lineSpan backLine"></span>
					<div class="boxDiv">
						<span class="circleSpan spanBorder">3</span>
						<span class="textSpan backText">执行升级</span>
					</div>
					<span class="lineSpan"></span>
					<div class="boxDiv">
						<span class="circleSpan">4</span>
						<span class="textSpan">升级完成</span>
					</div>
				</div>
			</div>
			<div class="borderMiddle">
				<div class="describe">
					<span class="midText" style="">执行升级</span>
					<div>
						<div class="layui-progress layui-progress-big" lay-showpercent="true" lay-filter="demo">
							<div class="layui-progress-bar layui-bg-red" lay-percent="0%"></div>
						</div>
					</div>
				</div>
				<div class="divFooter">
					<%--<div class="divBtn" id="thrPoreBtn">下一步</div>--%>
					<div class="divBtn" id="thrNextBtn" style="margin-right: 10px;">取消</div>
				</div>
			</div>
		</div>
		<%--第四步--%>
		<div class="main fourthSteps" style="display: none;">
			<div class="divTitle">OA升级心通达向导</div>
			<div class="iconHeader">
				<div class="workStatus">
					<div class="boxDiv">
						<span class="circleSpan backSpan">1</span>
						<span class="textSpan backText">准备工作</span>
					</div>
					<span class="lineSpan backLine"></span>
					<div class="boxDiv">
						<span class="circleSpan backSpan">2</span>
						<span class="textSpan backText">环境检测</span>
					</div>
					<span class="lineSpan backLine"></span>
					<div class="boxDiv">
						<span class="circleSpan backSpan">3</span>
						<span class="textSpan backText">执行升级</span>
					</div>
					<span class="lineSpan backLine"></span>
					<div class="boxDiv">
						<span class="circleSpan backSpan">4</span>
						<span class="textSpan backText">升级完成</span>
					</div>
				</div>
			</div>
			<div class="borderMiddle">
				<div class="describe">
					<div style="text-align: center;">
						<img src="/img/common/updateDatebase/icon_wancheng.png" alt="">
					</div>
					<div style="text-align: center;margin-top: 10px;font-size: 18px;">
						<span>恭喜您升级成功</span>
					</div>
					<div style="width: 100%;height: 50px;margin-top: 15px;">
						<a class="aBtn" href="/">立即体验</a>
					</div>
				</div>
			</div>
		</div>
		<%--升级失败--%>
		<div class="main fifthSteps" style="display: none;">
			<div class="divTitle">OA升级心通达向导</div>
			<div class="iconHeader shengjishibai">
				<div class="workStatus daoxian">
					<div class="boxDiv">
						<span class="circleSpan backSpan">1</span>
						<span class="textSpan backText">准备工作</span>
					</div>
					<span class="lineSpan backLine"></span>
					<div class="boxDiv">
						<span class="circleSpan backSpan">2</span>
						<span class="textSpan backText">环境检测</span>
					</div>
					<span class="lineSpan backLine"></span>
					<div class="boxDiv">
						<span class="circleSpan backSpan">3</span>
						<span class="textSpan backText">执行升级</span>
					</div>
					<span class="lineSpan backLine"></span>
					<div class="boxDiv">
						<span class="circleSpan backSpan">4</span>
						<span class="textSpan backText">升级完成</span>
					</div>
				</div>
			</div>
			<div class="borderMiddle">
				<div class="describe">
					<span class="midText" style="">升级异常日志</span>
					<div id="falseData" style="margin-bottom: 30px;height:350px;overflow-y: auto;">

					</div>
					<div class="yichang">升级异常，请联系技术支持QQ</div>
				</div>
				<div class="divFooter">
					<a href="/code/downLog" class="divBtn" id="fifNextBtn" style="margin-right: 10px;background-size: 100% 100%;">异常日志下载</a>
					<%--<a href="/code/downLog" style="float: right;display: block;height: 100%;line-height: 50px;margin-right: 20px;color: #0054ff;font-size: 17px;">异常日志下载</a>--%>
				</div>
			</div>
		</div>
	</div>
	<script src="lib/layui/layui/layui.all.js" charset="utf-8"></script>
	<%--<script src="lib/layui/layui/lay/modules/element.js" charset="utf-8"></script>--%>
	<script type="text/javascript">
        var timer=null;
		$(function () {
		    $('#divBtn').click(function () {
                var state=$('.checked').prop('checked');
                if(state == true){
                    $('.checked').prop('checked',true);
                    $('.secondSteps').show().siblings().hide()
				}else{
                    $('.checked').prop('checked',false);
					layer.msg('请确认是否以按上述要求操作',{icon:2,time:2000});
				}
            })

			$('.divBtn').mouseover(function () {
				$(this).css('background','url("/img/common/updateDatebase/anniu_hover.png") no-repeat')
            })
            $('.divBtn').mouseout(function () {
                $(this).css('background','url("/img/common/updateDatebase/anniu_normal.png") no-repeat')
            })
            $('.divBtn').mousedown(function () {
                $(this).css('background','url("/img/common/updateDatebase/anniu_active.png") no-repeat')
            })
            $('.divBtn').mouseup(function () {
                $(this).css('background','url("/img/common/updateDatebase/anniu_normal.png") no-repeat')
            })

            $('.aBtn').mouseover(function () {
                $(this).css({'background':'url("/img/common/updateDatebase/anniu_hover.png") no-repeat','color':'#fff'})
            })
            $('.aBtn').mouseout(function () {
                $(this).css({'background':'url("/img/common/updateDatebase/anniu_normal.png") no-repeat','color':'#fff'})
            })
            $('.aBtn').mousedown(function () {
                $(this).css({'background':'url("/img/common/updateDatebase/anniu_active.png") no-repeat','color':'#fff'})
            })
            $('.aBtn').mouseup(function () {
                $(this).css({'background':'url("/img/common/updateDatebase/anniu_normal.png") no-repeat','color':'#fff'})
            })


			$('#prevBtn').click(function () {
				$('.firstStep').show().siblings().hide();
            })


			$('#thrPoreBtn').click(function () {
                $('.fourthSteps').show().siblings().hide()
            })
        })
//		进度条
        layui.use('element', function(){
            var no=true;
            var $ = layui.jquery ,element = layui.element; //Tab的切换功能，切换事件监听等，需要依赖element模块
            $('#nextBtn').click(function () {
                $('.thirdSteps').show().siblings().hide();
                loadingAjax();
                timer= setInterval (function(){
					if(no) {
					    no=false;
                        $.ajax({
                            type: 'get',
                            url: '/code/getObjectcount',
                            dataType: 'json',
                            success: function (res) {
                                var data = res.object;
                                var num = data.total;
                                var totalNum = data.count;
                                var n = 0;
								if (res.flag == true) {
									n = n + Math.round(((num / totalNum) * 100).toFixed(0));
									if (num == totalNum || n > 100) {
										n = 100;
										no=false;
										clearInterval(timer);
									}
									element.progress('demo', n + '%');
									no=true;
								} else {
									no = false;
									clearInterval(timer);
								}
                            }
                        });
                    }
                    $('#thrNextBtn').click(function () {
                        $('.secondSteps').show().siblings().hide();
                        clearInterval(timer);
                        return false;
                    })
                },500)

            })
        });


		function loadingData() {
			$.ajax({
				type:'get',
				url:'/code/getObjectdetail',
				dataType:'json',
				success:function(res){
				    var datas=res.object;
				    var str='';
				    if(datas.errorList.length == 0){
				        $('.fourthSteps').show().siblings().hide();
					}else {
				        $('.fifthSteps').show().siblings().hide();
				        for(var i=0;i<datas.errorList.length;i++){
				            str+='<p>' +
                                '<span style=""><img src="/img/common/updateDatebase/icon_cuowu.png" style="margin-right: 10px;margin-top: -20px;" alt=""></span>'+
								'<span style="display: inline-block;width: 970px;overflow: hidden;text-overflow:ellipsis;white-space: nowrap;" title=\''+datas.errorList[i].stringSql+'\'>'+datas.errorList[i].stringSql+'</span>'+
                                '</p>';
						}
						$('#falseData').append(str);
					}
				}
			})
        }
        function loadingAjax() {
		    $.ajax({
				type:'get',
				url:'/code/editDabase',
				dataType:'json',
				success:function(res){
				    if(res.flag){
                        loadingData();
					}else{
                        loadingData();
					}
				}
			})
        }

//        function jindutiao(num,total){
////            var n=((num/total)*100).toFixed(0);
//			layui.use('element', function(){
//                var $ = layui.jquery
//                    ,element = layui.element; //Tab的切换功能，切换事件监听等，需要依赖element模块
//                var n=0;
//                var timer = setInterval(function(){
//                    n=n+((num/total)*100).toFixed(0);
//                    if(n>100){
//                        n = 100;
//                        clearInterval(timer);
//                    }
//                    element.progress('demo', n+'%');
//                }, 200);
//            });
//		}
	</script>
</body>
</html>
