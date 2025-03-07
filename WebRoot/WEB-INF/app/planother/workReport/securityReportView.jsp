<%--
  Created by IntelliJ IDEA.
  User: 王秋彤
  Date: 2021/10/12
  Time: 9:41
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
		 pageEncoding="UTF-8" %>
<%@taglib prefix="mvc" uri="http://www.springframework.org/tags/form" %>
<%@taglib prefix="fmt" uri="http://www.springframework.org/tags" %>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
%>
<!DOCTYPE html>
<html>
<head>
	<title>安全月报 预览</title>

	<meta charset="UTF-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">

	<link rel="stylesheet" href="/lib/layui/layui/css/layui.css?20210319.1">
	<link rel="stylesheet" href="/lib/layui/layui/css/eleTree.css">

	<script type="text/javascript" src="/js/xoajq/xoajq1.js"></script>
	<script type="text/javascript" src="/lib/layui/layui/layui.all_v2.5.js"></script>
	<script type="text/javascript" src="/js/base/base.js"></script>
	<script type="text/javascript" src="/lib/layui/layui/global.js?20201229.1"></script>
	<script type="text/javascript" src="/lib/layui/layui/lay/mymodules/tableFilter.js"></script>
	<script type="text/javascript" src="/lib/layui/layui/lay/mymodules/tableChild.js"></script>
	<script type="text/javascript" src="/lib/layui/layui/lay/mymodules/tableMerge.js"></script>
	<script type="text/javascript" src="/lib/jQuery-File-Upload-master/jquery-ui.js"></script>
	<script type="text/javascript" src="/lib/jQuery-File-Upload-master/jquery.iframe-transport.js"></script>
	<script type="text/javascript" src="/lib/jQuery-File-Upload-master/jquery.fileupload.js"></script>
	<%--    <script type="text/javascript" src="/js/common/fileupload.js"></script>--%>
	<script type="text/javascript" src="/js/planbudget/common.js?20210413"></script>
	<script src="../js/jquery/jquery.cookie.js"></script>
	<script type="text/javascript" src="/js/planother/planotherUtil.js?221202108301508"></script>

	<style>

		html, body {
			width: 100%;
			height: 100%;
			background: #fff;
		}

		/*伪元素是行内元素 正常浏览器清除浮动方法*/
		.clearfix:after {
			content: "";
			display: block;
			height: 0;
			clear: both;
			visibility: hidden;
		}

		.clearfix {
			*zoom: 1; /*ie6清除浮动的方式 *号只有IE6-IE7执行，其他浏览器不执行*/
		}

		.container {
			position: relative;
			width: 100%;
			height: 100%;
			padding: 15px 0 10px;
			box-sizing: border-box;
		}

		.wrapper {
			position: relative;
			width: 100%;
			height: 100%;
			padding: 0 8px;
			box-sizing: border-box;
		}

		/* region 左侧样式 */
		.wrap_left {
			position: relative;
			float: left;
			width: 230px;
			height: 100%;
			padding-right: 10px;
			box-sizing: border-box;
		}

		.wrap_left h2 {
			line-height: 35px;
			text-align: center;
		}

		.wrap_left .left_form {
			position: relative;
			overflow: hidden;
		}

		.left_form .layui-input {
			height: 35px;
			margin: 10px 0;
			padding-right: 25px;
		}

		.tree_module {
			position: absolute;
			top: 90px;
			right: 10px;
			bottom: 0;
			left: 0;
			overflow: auto;
			box-sizing: border-box;
		}

		.eleTree-node-content {
			overflow: hidden;
			word-break: break-all;
			white-space: nowrap;
			text-overflow: ellipsis;
		}

		.search_icon {
			position: absolute;
			top: 10px;
			right: 0;
			height: 35px;
			width: 25px;
			padding-top: 8px;
			text-align: center;
			cursor: pointer;
			box-sizing: border-box;
		}

		.search_icon:hover {
			color: #0aa3e3;
		}

		/* endregion */

		/* region 右侧样式 */
		.wrap_right {
			position: relative;
			height: 100%;
			margin-left: 230px;
			overflow: auto;
		}

		.query_module .layui-input {
			height: 35px;
		}

		/* region 图标样式 */
		.icon_img {
			font-size: 25px;
			cursor: pointer;
		}

		.icon_img:hover {
			color: #0aa3e3;
		}

		/* endregion */

		/* endregion */

		/* region 上传附件样式 */
		.file_upload_box {
			position: relative;
			height: 22px;
			overflow: hidden;
		}

		.open_file {
			float: left;
			position: relative;
		}

		.open_file input[type=file] {
			position: absolute;
			top: 0;
			left: 0;
			width: 100%;
			height: 100%;
			z-index: 2;
			opacity: 0;
		}

		.progress {
			float: left;
			width: 200px;
			margin-left: 10px;
			margin-top: 2px;
		}

		.bar {
			width: 0%;
			height: 18px;
			background: green;
		}

		.bar_text {
			float: left;
			margin-left: 10px;
		}

		/* endregion */

		.form_label {
			float: none;
			padding: 9px 0;
			text-align: left;
			width: auto;
		}

		.form_block {
			margin: 0;
		}

		.field_required {
			color: red;
			font-size: 16px;
		}

		/*选中行样式*/
		.selectTr {
			background: #009688 !important;
			color: #fff !important;
		}

		.refresh_no_btn {
			display: none;
			margin-left: 2%;
			color: #00c4ff !important;
			font-weight: 600;
			cursor: pointer;
		}
		.layui-col{
			width: 20%;
		}
	</style>
</head>
<body>

<div class="container" id="htm"></div>


<script>
	// 获取地址栏参数值
	function getQueryString(name){
		var reg = new RegExp("(^|&)"+ name +"=([^&]*)(&|$)");
		var r = window.location.search.substr(1).match(reg);
		if(r!=null)return  unescape(r[2]); return null;
	}

	var runId = getQueryString("runId");

	var _disabled = getQueryString('disabled');
	//var type = getQueryString("type");
	var type;
	if('0'!=_disabled){
		type = 4
	}else {
		type = 1
	}

	var data = null

	var htm = ['<div class="layui-collapse">\n' +
	/* region 方案内容 */
	'  <div class="layui-colla-item">\n' +
	'    <h2 class="layui-colla-title">方案内容</h2>\n' +
	'    <div class="layui-colla-content layui-show plan_base_info">' +
	'       <form class="layui-form _disabled" id="baseForm" lay-filter="formTest">' +
	/* region 第一行 */
	'           <div class="layui-row">' +
	'               <div class="layui-col-xs3 layui-col" style="padding: 0 5px;">' +
	'                   <div class="layui-form-item">\n' +
	'                       <label class="layui-form-label form_label">单据号<span field="documnetNo" class="field_required">*</span><a title="刷新单据号" class="refresh_no_btn"><i class="layui-icon layui-icon-refresh"></i></a></label>\n' +
	'                       <div class="layui-input-block form_block">\n' +
	'                       <input type="text" name="documnetNo" readonly autocomplete="off" style="background: #e7e7e7" class="layui-input">\n' +
	'                       </div>\n' +
	'                   </div>' +
	'               </div>' +
	'               <div class="layui-col-xs3 layui-col" style="padding: 0 5px;">' +
	'                   <div class="layui-form-item">\n' +
	'                       <label class="layui-form-label form_label">项目名称<span field="projectName" class="field_required">*</span></label>\n' +
	'                       <div class="layui-input-block form_block">\n' +
	'                           <input type="text" name="projectName" id="projectName" readonly style="background: #e7e7e7" autocomplete="off" class="layui-input">' +
	'                       </div>\n' +
	'                   </div>' +
	'               </div>' +
	'               <div class="layui-col-xs3 layui-col" style="padding: 0 5px;">' +
	'                   <div class="layui-form-item">\n' +
	'                       <label class="layui-form-label form_label">优化名称<span field="optimizationName" class="field_required">*</span></label>\n' +
	'                       <div class="layui-input-block form_block">\n' +
	'                           <input type="text" name="optimizationName"  autocomplete="off" class="layui-input">' +
	'                       </div>\n' +
	'                   </div>' +
	'               </div>' +
	'               <div class="layui-col-xs3 layui-col" style="padding: 0 5px;">' +
	'                   <div class="layui-form-item">\n' +
	'                       <label class="layui-form-label form_label">责任人<span field="chargeUserName" class="field_required">*</span></label>\n' +
	'                       <div class="layui-input-block form_block">\n' +
	'                           <input type="text" name="chargeUserName" id="chargeUserName" autocomplete="off" class="layui-input">' +
	'                       </div>\n' +
	'                   </div>' +
	'               </div>' +
	'               <div class="layui-col-xs3 layui-col" style="padding: 0 5px;">' +
	'                   <div class="layui-form-item">\n' +
	'                       <label class="layui-form-label form_label">监督人<span field="superviseUserName" class="field_required">*</span></label>\n' +
	'                       <div class="layui-input-block form_block">\n' +
	'                           <input type="text" name="superviseUserName" id="superviseUserName"  autocomplete="off" class="layui-input">' +
	'                       </div>\n' +
	'                   </div>' +
	'               </div>' +
	'           </div>' ,
		'<div class="layui-row">' +
		'    <div class="layui-col-xs6" style="padding: 0 5px;">' +
		'        <div class="layui-form-item">\n' +
		'            <label class="layui-form-label form_label">主要内容<span field="mainSchemeContent" class="field_required">*</span></label>\n' +
		'            <div class="layui-input-block form_block">\n' +
		' 				<textarea type="text" name="mainSchemeContent" style="resize: vertical;min-height: 80px" autocomplete="off" class="layui-input"></textarea>' +
		'            </div>\n' +
		'        </div>' +
		'    </div>' +
		'    <div class="layui-col-xs6" style="padding: 0 5px;">' +
		'        <div class="layui-form-item">\n' +
		'            <label class="layui-form-label form_label">描述说明<!--<span field="schemeDesc" class="field_required">*</span>--></label>\n' +
		'            <div class="layui-input-block form_block">\n' +
		' 				<textarea type="text" name="schemeDesc" style="resize: vertical;min-height: 80px" autocomplete="off" class="layui-input"></textarea>' +
		'            </div>\n' +
		'        </div>' +
		'    </div>' +
		'</div>',
		'           <div class="layui-row">' +
		'               <div class="layui-col-xs12" style="padding: 0 5px;">' +
		'                   <div class="layui-form-item">\n' +
		'                       <label class="layui-form-label form_label">附件<span field="attachmentId" class="field_required">*</span></label>' +
		'                       <div class="layui-input-block form_block">' +
		'<div class="file_module">' +
		'<div id="fileContent" class="file_content"></div>' +
		'<div class="file_upload_box">' +
		'<a href="javascript:;" class="open_file">' +
		'<img src="/img/mg11.png" style="margin: -3px 5px 0 0;"><span>添加附件</span>' +
		'<input type="file" multiple id="fileupload" data-url="/upload?module=optimizationScheme" name="file">' +
		'</a>' +
		'<div class="progress" id="progress">' +
		'<div class="bar"></div>\n' +
		'</div>' +
		'<div class="bar_text"></div>' +
		'</div>' +
		'</div>' +
		'                       </div>\n' +
		'                   </div>' +
		'               </div>' +
		'           </div>',
		/* endregion */
		'       </form>' +
		'    </div>\n' +
		'  </div>\n' +
		/* endregion */
		'</div>'].join('');

	$("#htm").html(htm)
	
	initPage();


	function initPage() {
		layui.use(['form', 'laydate', 'table', 'element', 'eleTree', 'layer'], function () {
			var laydate = layui.laydate;
			var form = layui.form;
			var table = layui.table;
			var element = layui.element;
			var eleTree = layui.eleTree;
			var layer = layui.layer;


			var param = {};
			var fla = true;
			if(runId){
				param.runId=runId;
			}else{
				fla = false;
				layer.msg("信息获取失败！")
				return false;
			}
			if(fla){
				$.ajax({
					url:"/optimizationScheme/getById",
					data:param,
					dataType:"json",
					success:function(res){
						if(res.code===0||res.code==="0"){
							data = res.obj;

							//责任人
							$('#chargeUserName').click(function(){
								user_id = 'chargeUserName';
								$.popWindow('/common/selectUser?0');
							})
							//监督人
							$('#superviseUserName').click(function(){
								user_id = 'superviseUserName';
								$.popWindow('/common/selectUser?0');
							})


							fileuploadFn('#fileupload', $('#fileContent'));
							//回显项目名称
							getProjName('#projectName',data.projectId)

							//回显数据
							if (type == 1 || type == 4) {
								form.val("formTest", data);

								//责任人
								$('#chargeUserName').attr('user_id',data.chargeUser)
								//监督人
								//责任人
								$('#superviseUserName').attr('user_id',data.superviseUser)

								//附件
								if (data.attachmentList && data.attachmentList.length > 0) {
									var fileArr = data.attachmentList;
									$('#fileContent').append(echoAttachment(fileArr));
								}
							}


							//查看详情
							if(type==4){
								$('._disabled [name]').attr('disabled', 'disabled');
								$('.refresh_no_btn').hide();
								$('.file_upload_box').hide()
								$('.deImgs').hide();
							}
							element.render();
							form.render()
						}else{
							layer.msg("信息获取失败！")
							return false;
						}
					}
				})
			}

		})
	}




	function childFunc() {
		if('0'!=_disabled){
			return true
		}
		var datas = $('#baseForm').serializeArray();
		var obj = {}
		datas.forEach(function (item) {
			obj[item.name] = item.value
		});
		//责任人
		var chargeUserDom=$('#chargeUserName');
		var chargeUser = $(chargeUserDom).attr('user_id')||''
		if(chargeUser&&chargeUser.indexOf(',')!=-1){
			chargeUser=chargeUser.substring(0,chargeUser.lastIndexOf(','))
		}
		obj.chargeUser = chargeUser

		//监督人
		var superviseUserDom=$('#superviseUserName');
		var superviseUser = $(superviseUserDom).attr('user_id')||''
		if(superviseUser&&superviseUser.indexOf(',')!=-1){
			superviseUser=superviseUser.substring(0,superviseUser.lastIndexOf(','))
		}
		obj.superviseUser = superviseUser

		obj.projectId = data.projectId;


		if(type == '1'){
			obj.optimizationId= data.optimizationId;
		}

		// 附件
		var attachmentId = '';
		var attachmentName = '';
		for (var i = 0; i < $('#fileContent .dech').length; i++) {
			attachmentId += $('#fileContent .dech').eq(i).find('input').val();
			attachmentName += $('#fileContent .dech').eq(i).find("a").eq(0).attr('name');
		}
		obj.attachmentId = attachmentId;
		obj.attachmentName = attachmentName;

		// 判断必填项
		var requiredFlag = false;
		$('#baseForm').find('.field_required').each(function(){
			var field = $(this).attr('field');
			if (!obj[field]) {
				var fieldName = $(this).parent().text().replace('*', '');
				layer.msg(fieldName+'不能为空！', {icon: 0, time: 2000});
				requiredFlag = true;
				return false;
			}
		});
		if (requiredFlag) {
			return true;
		}
		var loadIndex = layer.load();


		var _flag = false;

		$.ajax({
			url: '/optimizationScheme/updateById',
			data:JSON.stringify(obj),
			dataType: 'json',
			contentType: "application/json;charset=UTF-8",
			type: 'post',
			success: function (res) {
				layer.close(loadIndex);
				if (res.flag) {
					layer.msg('保存成功！', {icon: 1});
					/*layer.close(index);
                    tableIns.config.where._ = new Date().getTime();
                    tableIns.reload();*/
				} else {
					layer.msg(res.msg, {icon: 2});
					_flag = true
				}
			}
		});

		if(_flag){
			return false;
		}
		return true;

	}

</script>
</body>
</html>
