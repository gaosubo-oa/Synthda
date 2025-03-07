<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	 <%@taglib prefix="mvc" uri="http://www.springframework.org/tags/form" %>
<%@taglib prefix="fmt" uri="http://www.springframework.org/tags" %>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<link rel="stylesheet" href="../css/index/bootstrap.min.css" />
	<link rel="stylesheet" type="text/css" href="../css/index/login.css"/>
	<script type="text/javascript" src="/js/xoajq/xoajq3.js"></script>
	<script type="text/javascript" src="../js/index/bootstrap.min.js"></script>
 	<script src="../js/base/base.js" type="text/javascript" charset="utf-8"></script>
<head>
		<title></title>
		<style type="text/css">
			*{margin: 0;padding: 0;}
			body{font-family: Microsoft yahei,Helvetica Neue,Helvetica,PingFang SC,Tahoma,Arial,sans-serif;}
			html,body{width:100%;height:100%;}
			.content{width: 100%;height:100%;overflow: hidden;background: url(../img/all.png) no-repeat;background-size:cover;}
			.content .left{width: 55%;min-height:800px;float: left;position: relative;}
			.content .left .logo{width: 350px;position: absolute;top: 20%;left: 25%;}
			.content .left .logo img{display: block;width: 100%;}
			.content .right ul li{line-height: 24px;}
			.content .right{width: 45%;float: left;}
			.content .right ul{list-style: none;margin-top: 26%;margin-left: 15%;position: relative;}
			.content .right ul li.total{width: 384px;height: 50px;background: url(../img/first_one.png) no-repeat;position: relative;border-radius: 25px;background-position:center;margin-bottom: 42px;z-index: 999;}
			.content .right ul li a{text-decoration: none;display: block;width: 100%;}
			.content .right ul li.total .round{display: block;width: 16px;height: 16px;border-radius: 50%;background-color: #fff;;margin-left: 25px;position: absolute;top: 17px;}
			.content .right ul li.total .bord{display: block;color: #fff;margin-left: 50px;width: 1%;font-size: 20px;line-height: 45px;margin-left: 75px;margin-right: 30px;}
			.content .right ul li.total .txt{
				    display: block;
			    width: 75%;
			    margin: -32px auto;
			    text-align: left;
			    font-size: 18px;
			    color: #fff;
			    /* letter-spacing: 3px; */
			    margin-left: 18%;
			}
			.content .right ul li.div_li{width: 320px;height: 44px;border-radius: 22px;margin-left: 60px;position: relative;margin-bottom: 42px;}
			.content .right ul li.div_li .round{display: block;width: 14px;height: 14px;border-radius: 50%;background-color: #fff;;margin-left: 25px;position: absolute;top: 15px;}
			.content .right ul li.div_li .bord{display: block;color: #fff;margin-left: 50px;width: 1%;font-size: 18px;line-height: 40px;margin-left: 75px;margin-right: 30px;}
			.content .right ul li.div_li .txt{display: block;width: 75%;margin: -32px auto;text-align: left;font-size: 18px;color: #fff;margin-left: 20%;}
			.content .right .div_im{width: 30px;height: 360px;position: absolute;top: 16px;left: 30px;}
			.content .right .div_im img{display: block;width: 100%;height: 100%;}

			.content .right ul li.one{background: url(../img/first_two.png) no-repeat;background-position:center;}
			.content .right ul li.tow{background: url(../img/first_three.png) no-repeat;background-position:center;}
			.content .right ul li.three{background: url(../img/first_four.png) no-repeat;background-position:center;}
			.content .right ul li.four{background: url(../img/first_five.png) no-repeat;background-position:center;}

		   @media screen and (min-width: 1680px) and (max-width: 1920px) {
				.content .left .logo{width: 410px;}
			}
		   @media screen and (min-width: 1921px) {
		 		.content .left .logo{width: 478px;}
		 }
		 #lg {
		 width: 250px;
   		 height: 50px;
   		 margin-left:75px;
   		 margin-top: 48px;

		 }
		 #zt {
		 	margin-right:45px;
		 	margin-top:30px;
		 	float: right;


		 }
		 .la:hover {
		 	color:#fff;
		 	background-color:#0088cc;
		 	border-radius: 3px;
		 }
		 .bag{
		 color:#fff;
		 	background-color:#0088cc;
		 	border-radius: 3px;
		 	}
			 	/*  #la {
			 	color:#fff;
			 	background-color:#0088cc;
			 	border-radius: 3px;
			 } */

		</style>
<script type="text/javascript">
    function IsPC()
    {
        var userAgentInfo = navigator.userAgent;
        var Agents = new Array("Android", "iPhone", "SymbianOS", "Windows Phone", "iPad", "iPod");
        var flag = true;
        for (var v = 0; v < Agents.length; v++) {
            if (userAgentInfo.indexOf(Agents[v]) > 0) { flag = false; break; }
        }
        return flag;
    }
		$(function () {
			$("#lg").click(function(){
				$("#tp").slideToggle();
			});
			var lang = $.getQueryString("lang");
			$('#'+lang).addClass("bag").siblings().removeClass("bag")
			 $(".zhuce").click(function(){
				if(IsPC()){
                    $(".btnsq").css("display","block");
                    $(".erweima1").css('overflow-x',"hidden");
                    $(".reg-ye").slideDown();
                    $(".h2_s").animate({top:"100px"},300);
                    $(".h2_s").show();
                    var i=60;
                    for(var j=-40;j>=-i;j+=20){
                        var is=i-=20;
                        $(".h2_s").animate({left:""+(is)+"px"},150);
                        $(".h2_s").animate({left:""+(j)+"px"},150);
                        if(j==0){
                            break;
                        }
                    }
                    $(".erweima").show();
                    $("#css2").css("-webkit-filter","blur(3px)");//谷歌毛玻璃效果
                    $("#css2").css("filter","progid:DXImageTransform.Microsoft.Blur(PixelRadius=10, MakeShadow=false)");//IE毛玻璃效果
                    $(".erweima1").animate({marginLeft:margins0},800);
                    $(".erweima2").animate({marginRight:margins0},800);
                    margins0=-100+"%";
				}else{
				    window.location.href = 'https://fir.im/xintongda';
				}

			  });

			   $(".btnsq").click(function(){
				  	 $(".h2_s").animate({left:"-200%"},300);
				  	 $(".reg-ye").slideUp();
				  	 $(".erweima").slideUp();
				  	 $(".btnsq").slideUp();
				  	 $("#css2").css("-webkit-filter","blur(0px)");//谷歌毛玻璃效果
				  	 $("#css2").css("filter","progid:DXImageTransform.Microsoft.Blur(PixelRadius=0, MakeShadow=false)");//IE毛玻璃效果
				  	 $(".erweima1").animate({marginLeft:margins0},800);
				  	 $(".erweima2").animate({marginRight:margins0},800);
			  	 	margins0=0;
 			 });
 			 /* 切换语言 */
		 /*  $("#qh").click(function(){
		  $(this).addClass("#la");
		}); */

		});
</script>

	</head>
	<body>
	<button type="button" class="btn btn-primary btnsq"><fmt:message code="main.th.Stop" /></button>
	<div id="header"></div>

		<div class="reg-ye">

		</div>
		<div class="content" id="css2" >
			<div class="left">
				<div class="logo">
					<img  src="../img/logo.png"/>
					<a href="#" class="zhuce"><img id="lg"  src="../img/sy01.png"/></a>
					<a href="#" class="zhuce"><img id="lg" src="../img/sy02.png"/></a>
					<a href="http://192.168.0.17:81/pcapps/ispirit_xoa.exe"><img id="lg" src="../img/sy04.png"/></a>
				</div>
				<!-- <img id="tp" src="../img/sy06.png"/> -->

			</div>
			<div class="right">
				<div id="zt">
					<fmt:message code="language" />:
					 <a class="bag" id="zh_CN" class="la" href="?lang=zh_CN">中文</a>
					  &nbsp;&nbsp;
					  <a class="la" id="en_US" href="?lang=en_US">English</a>
					  &nbsp;&nbsp;
					   <a class="wyq" id="zh_tw" href="?lang=zh_tw">繁体</a>
				</div>
				<ul>
					<li class="total">
						<a href="../branchOfLanding?loginId=1001">
							<span class="round"></span>
							<span class="bord">&nbsp;</span>
							<span class="txt"><fmt:message code="headQuarters" /></span>
						</a>
					</li>
					<li class="div_li one">
						<a href="../branchOfLanding?loginId=1002">
							<span class="round"></span>
							<span class="bord">&nbsp;</span>
							<span class="txt"><fmt:message code="branchOfficeOne" /></span>
						</a>
					</li>
					<li class="div_li tow">
						<a href="../branchOfLanding?loginId=1003">
							<span class="round"></span>
							<span class="bord">&nbsp;</span>
							<span class="txt"><fmt:message code="branchOfficeTwo"/></span>
						</a>
					</li>
					<li class="div_li three">
						<a href="../branchOfLanding?loginId=1004">
							<span class="round"></span>
							<span class="bord">&nbsp;</span>
							<span class="txt"><fmt:message code="branchOfficeThree"/></span>
						</a>
					</li>
					<li class="div_li four">
						<a href="../branchOfLanding?loginId=1005">
							<span class="round"></span>
							<span class="bord">&nbsp;</span>
							<span class="txt"><fmt:message code="branchOfficeFore"/></span>
						</a>
					</li>
					<li class="div_im">
						<img src="../img/lianxian.png" alt="" />
					</li>
				</ul>
			</div>
		</div>
		<!-- 弹出二维码 -->
			<h2 class="h2_s"><fmt:message code="main.th.WeChatAPPlogin" /></h2>
			<div class="erweima">

				<div class="erweima1" style="padding-left: 260px;">
					<img src="../img/sy06.png" alt="" />
					<div class="fonts"><fmt:message code="main.th.ScanDownload" /><!-- <a href="http://www.gsubo.com/app" style="text-decoration: none;color: white;" target="_blank">点击这里下载</a> --></div>
				</div>

			</div>
	</body>
</html>
