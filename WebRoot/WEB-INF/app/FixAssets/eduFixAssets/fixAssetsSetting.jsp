<%--需把局部样式归并为一个通用或符合公告管理的公共样式，
接口对完需调整--%>

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
<head lang="en">
	<meta charset="UTF-8">
	<title>二维码设置</title>
	<link rel="stylesheet" type="text/css" href="../css/news/center.css"/>
	<link rel="stylesheet" type="text/css" href="../lib/pagination/style/pagination.css"/>
	<link rel="stylesheet" type="text/css" href="../css/base.css" />
	<link rel="stylesheet" href="/lib/layer/skin/default/layer.css">
	<script src="../js/xoajq/xoajq3.js" type="text/javascript" charset="utf-8"></script>
	<script src="../js/base/base.js" type="text/javascript" charset="utf-8"></script>
	<script src="/js/jquery/jquery.form.min.js"></script>
	<script src="/lib/jQuery-File-Upload-master/jquery-ui.js" type="text/javascript" charset="utf-8"></script>
	<script src="/lib/jQuery-File-Upload-master/jquery.iframe-transport.js" type="text/javascript" charset="utf-8"></script>
	<script src="/lib/jQuery-File-Upload-master/jquery.fileupload.js" type="text/javascript" charset="utf-8"></script>

	<style>
		.importHead {
			margin: 10px 0 10px 20px;
		}

		.importHead span {
			font-size: 18px;
			margin: 10px 0 10px 5px;
			color: black;
		}

		.importTable {
			width: 80%;
			margin: 0 auto;
		}

		.uploadBtn {
			width: 60px;
			height: 30px;
			border-radius: 5px;
			cursor: pointer;
		}

		.saveBtn{
			width: 60px;
			height: 30px;
			border-radius: 5px;
			cursor: pointer;
			margin-left: 40%;
		}

		#model{
			color: #00a0e9;
			cursor: pointer;
		}
	</style>
	<link rel="stylesheet" type="text/css" href="/css/commonTheme/${sessionScope.InterfaceModel}/commonTheme.css"/>
</head>
<body>
<div class="content">
	<div class="importHead">
		<img src="/img/commonTheme/${sessionScope.InterfaceModel}/icon_addrole_06.png" style="margin-left: 30px;margin-bottom: 2px;">
		<span>二维码设置</span>
	</div>
	<div class="importDiv">
		<table class="importTable">
			<tr>
				<td>选择上传图片：</td>
				<td>
					<input id="uploadinputimgs" accept="image/*" style="width: auto;display: none;" type="file" name="file" />
					<input class="uploadBtn" type="button" value="选择图片">
					<input class="logoAid" style="display: none;">
				</td>
			</tr>
			<tr>
				<td><fmt:message code="roleAuthorization.th.Explain" />：</td>
				<td>
					<p>1、请上传图片格式文件。</p>
					<p>2、图片高度建议不要超过宽度的十分之一。</p>
				</td>
			</tr>
			<tr>
				<td>效果图：</td>
				<td>
					<div class="code" style="float: left;width:250px;padding: 5px;">
						<img width="245px" style="display: none" id="logoImg" src="/img/fixAssets/logo.png">
						<div style="border: 1px solid black;float:left;font-size: 16px;color: black;margin-top: 3px;">
							<div style="float: left">
								<div style="text-align: left;width:160px;overflow: hidden;">固定资产</div>
								<div style="text-align: left;width:160px;overflow: hidden;">编号：00001</div>
								<div style="text-align: left;width:160px;overflow: hidden;">名称：机器人</div></div>
							<div style="display: inline-block;float: right;margin:2px;" id="showQRCode0" title="{&quot;mark&quot;:&quot;fixAssets&quot;,&quot;id&quot;:&quot;GDZC2019062500001&quot;,&quot;createrTime&quot;:&quot;2019-06-25&quot;,&quot;companyId&quot;:&quot;1001&quot;}">
								<canvas width="80" height="80" style="display: none;"></canvas>
								<img src="/img/fixAssets/example_QR.png">
							</div>
						</div>
					</div>
				</td>
			</tr>
			<tr>
				<td colspan="2"><input class="saveBtn" type="button" value="保存"></td>
			</tr>
		</table>
	</div>
</div>
<script type="text/javascript">
    $(function () {

		// 获取设置
        $.ajax({
            url:"/eduFixAssets/getSetting",
            type:"get",
            dataType:"json",
            success:function(res){
                if(res.flag){
                    if(res.object.logoUrl){
                        $('#logoImg').attr('src','/xs?'+res.object.logoUrl)
						if (res.object.logoAid){
							$('.logoAid').val(res.object.logoAid);
						}
					}
                }
                $('#logoImg').css('display','block');
            }
        });

        // 上传图片点击事件
        $('.uploadBtn').on("click",function () {
            $('#uploadinputimgs').click();
        });

        // 图片自动上传
		$('#uploadinputimgs').fileupload({//加载上以后启动上传
			dataType:'json',
			url:'/upload?module=fixAssets',
			done: function (e, data) {
				var res = data.result;
				if(res.flag){

                    $('.logoAid').val(res.obj[0].aid);

                    $('#logoImg').attr('src','/xs?'+res.obj[0].attUrl)
				}
			}
		});


		// 保存按钮点击事件 保存
        $('.saveBtn').on("click",function () {

            $.ajax({
                url:"/eduFixAssets/saveSetting",
                type:"post",
                dataType:"json",
                data:{
                    logoAttachmentId:$('.logoAid').val()
				},
                success:function(res){
					if(res.flag){
                        $.layerMsg({content:"保存成功",icon:1},function () {
                            window.location.reload();
                        })
					}
				}
            })

        })



    });
</script>
</body>
</html>
