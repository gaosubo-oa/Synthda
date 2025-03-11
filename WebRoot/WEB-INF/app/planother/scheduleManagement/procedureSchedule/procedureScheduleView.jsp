<%--
  Created by IntelliJ IDEA.
  User: 王秋彤
  Date: 2021/10/18
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
	<title>工序节点计划预览</title>

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
		/*.layui-col-xs4{*/
		/*    width: 20%;*/
		/*}*/
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
	var type = getQueryString("type")||'';
	var projectId = getQueryString("projectId")||'';
	var securityPunishmentId = getQueryString("securityPunishmentId")||'';
	if(runId){
		if('0'!=_disabled){
			type = 4
		}else {
			type = 1
		}
	}else {
		switch (type) {
			case '0':
				type = 0
				break;
			case '1':
				type = 1
				break;
			case '4':
				type = 4
				break;
		}
	}


	var data = null

	var htm = ['<div class="layui-collapse">\n' +
	/* region 材料计划 */
	'  <div class="layui-colla-item">\n' +
	'    <h2 class="layui-colla-title">基本信息</h2>\n' +
	'    <div class="layui-colla-content layui-show plan_base_info">' +
	'       <form class="layui-form _disabled" id="baseForm" lay-filter="formTest">' +
	/* region 第一行 */
	'           <div class="layui-row">' +
	'               <div class="layui-col-xs4" style="padding: 0 5px;">' +
	'                   <div class="layui-form-item">\n' +
	'                       <label class="layui-form-label form_label">排序号<a title="刷新排序号" class="refresh_no_btn"><i class="layui-icon layui-icon-refresh"></i></a></label>\n' +
	'                       <div class="layui-input-block form_block">\n' +
	'                       <input type="text" name="documentNo" readonly autocomplete="off" style="background: #e7e7e7" class="layui-input">\n' +
	'                       </div>\n' +
	'                   </div>' +
	'               </div>' +
	'               <div class="layui-col-xs4" style="padding: 0 5px;">' +
	'                   <div class="layui-form-item">\n' +
	'                       <label class="layui-form-label form_label">项目名称</label>\n' +
	'                       <div class="layui-input-block form_block">\n' +
	'                           <input type="text" name="projectName" id="projectName" readonly style="background: #e7e7e7" autocomplete="off" class="layui-input">' +
	'                       </div>\n' +
	'                   </div>' +
	'               </div>' +
	'               <div class="layui-col-xs4" style="padding: 0 5px;">' +
	'                   <div class="layui-form-item">\n' +
	'                       <label class="layui-form-label form_label">上级进度名称</label>\n' +
	'                       <div class="layui-input-block form_block">\n' +
	'                           <input type="text" name="finedDept"  autocomplete="off" class="layui-input">' +
	'                       </div>\n' +
	'                   </div>' +
	'               </div>' +
	'           </div>' ,
		'<div class="layui-row">' +
		'               <div class="layui-col-xs4" style="padding: 0 5px;">' +
		'                   <div class="layui-form-item">\n' +
		'                       <label class="layui-form-label form_label">上级进度计划开始时间<!--<span field="punishmentDate" class="field_required">*</span>--></label>\n' +
		'                       <div class="layui-input-block form_block">\n' +
		'                       <input type="text" name="punishmentDate" id="punishmentDate" autocomplete="off" class="layui-input" >\n' +
		'                       </div>\n' +
		'                   </div>' +
		'               </div>' +
		'               <div class="layui-col-xs4" style="padding: 0 5px;">' +
		'                   <div class="layui-form-item">\n' +
		'                       <label class="layui-form-label form_label">上级进度计划完成时间<!--<span field="punishmentDate" class="field_required">*</span>--></label>\n' +
		'                       <div class="layui-input-block form_block">\n' +
		'                       <input type="text" name="punishmentDate" id="punishmentDate" autocomplete="off" class="layui-input" >\n' +
		'                       </div>\n' +
		'                   </div>' +
		'               </div>' +
		'               <div class="layui-col-xs4" style="padding: 0 5px;">' +
		'                   <div class="layui-form-item">\n' +
		'                       <label class="layui-form-label form_label">进度名称<!--<span field="punishmentDate" class="field_required">*</span>--></label>\n' +
		'                       <div class="layui-input-block form_block">\n' +
		'                       <input type="text" name="punishmentDate" id="punishmentDate" autocomplete="off" class="layui-input" >\n' +
		'                       </div>\n' +
		'                   </div>' +
		'               </div>' +

		'</div>',
		'<div class="layui-row">' +
		'               <div class="layui-col-xs4" style="padding: 0 5px;">' +
		'                   <div class="layui-form-item">\n' +
		'                       <label class="layui-form-label form_label">计划开始时间<!--<span field="punishmentUser" class="field_required">*</span>--></label>\n' +
		'                       <div class="layui-input-block form_block">\n' +
		'                       <input type="text" name="punishmentUser" id="punishmentUser"  autocomplete="off" class="layui-input">\n' +
		'                       </div>\n' +
		'                   </div>' +
		'               </div>' +
		'               <div class="layui-col-xs4" style="padding: 0 5px;">' +
		'                   <div class="layui-form-item">\n' +
		'                       <label class="layui-form-label form_label">计划完成时间<!--<span field="punishmentUser" class="field_required">*</span>--></label>\n' +
		'                       <div class="layui-input-block form_block">\n' +
		'                       <input type="text" name="punishmentUser"  autocomplete="off" class="layui-input">\n' +
		'                       </div>\n' +
		'                   </div>' +
		'               </div>' +
		'               <div class="layui-col-xs4" style="padding: 0 5px;">' +
		'                   <div class="layui-form-item">\n' +
		'                       <label class="layui-form-label form_label">项目责任人<!--<span field="punishmentUser" class="field_required">*</span>--></label>\n' +
		'                       <div class="layui-input-block form_block">\n' +
		'                       <input type="text" name="punishmentUser2" id="punishmentUser2" autocomplete="off" class="layui-input">\n' +
		'                       </div>\n' +
		'                   </div>' +
		'               </div>' +
		'</div>',
		'<div class="layui-row">' +
		'               <div class="layui-col-xs4" style="padding: 0 5px;">' +
		'                   <div class="layui-form-item">\n' +
		'                       <label class="layui-form-label form_label">说明</label>\n' +
		'                       <div class="layui-input-block form_block">\n' +
		'                       	<input type="text" name="punishmentUser3" autocomplete="off" class="layui-input">\n' +
		// ' 							<textarea type="text"  style="width:100%;min-height: 80px !important;"   name="punishmentReason" autocomplete="off" class="layui-textarea"></textarea>' +
		'                       </div>\n' +
		'                   </div>' +
		'               </div>' +
		'</div>',
		/* endregion */
		'       </form>' +
		'    </div>\n' +
		'  </div>\n' +
		/* endregion */
		'</div>'].join('');

	$("#htm").html(htm)


	initPage();

	//选选人控件添加
	//项目责任人
	$(document).on('click', '#punishmentUser', function () {
		user_id = "punishmentUser";
		$.popWindow("/projectTarget/selectOwnDeptUser?0");
	})
	//公司责任人
	$(document).on('click', '#punishmentUser2', function () {
		user_id = "punishmentUser2";
		$.popWindow("/projectTarget/selectOwnDeptUser?0");
	})


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
			var url = ''

			if(type == 0 ){
				fla = false;
			}else {
				if(runId){
					param.runId=runId;
					url = "/workflow/punishment/getById"
				}else if(securityPunishmentId){
					param.securityPunishmentId=securityPunishmentId;
					url = "/workflow/punishment/getById"
				}else{
					fla = false;
					layer.msg("信息获取失败！")
					return false;
				}
			}

			if(fla){
				$.ajax({
					url:url,
					data:param,
					dataType:"json",
					async:false,
					success:function(res){
						if(res.code===0||res.code==="0"){
							data = res.obj;
						}else{
							layer.msg("信息获取失败！")
							return false;
						}
					}
				})
			}

			//回显项目名称
			getProjName('#projectName',projectId?projectId:data.projectId)

			laydate.render({
				elem: '#punishmentDate'
				, trigger: 'click'
				, format: 'yyyy-MM-dd'
				// , format: 'yyyy-MM-dd HH:mm:ss'
				//,value: new Date()
			});
			//回显数据
			if (type == 1 || type == 4) {
				form.val("formTest", data);
				//项目责任人id
				$('[name="punishmentUser"]').attr('user_id',data.punishmentUserId)
				//公司责任人id
				$('[name="punishmentUser2"]').attr('user_id',data.punishmentUserId2)

				laydate.render({
					elem: 'input[name="punishmentDate"]' //指定元素
					//,trigger: 'click' //采用click弹出
					,format: 'yyyy-MM-dd'
					,value:data.payDate?new Date(data.payDate):''
				});

				//查看详情
				if(type==4){
					$('._disabled').find('input,textarea').attr('disabled', 'disabled');
					$('.refresh_no_btn').hide();
					// $('.file_upload_box').hide()
					// $('.deImgs').hide();
				}
			}else{
				// 获取自动编号
				getAutoNumber({autoNumberType: 'securityPunishment'}, function(res) {
					$('input[name="documentNo"]', $('#baseForm')).val(res.obj);
				});
				$('.refresh_no_btn').show().on('click', function() {
					getAutoNumber({autoNumberType: 'securityPunishment'}, function(res) {
						$('input[name="documentNo"]', $('#baseForm')).val(res.obj);
					});
				});
			}
			element.render();
			form.render()

		})
	}
	function getDate() {
		var datas = $('#baseForm').serializeArray();
		var obj = {}
		datas.forEach(function (item) {
			obj[item.name] = item.value
		});
		//项目责任人id
		var punishmentUserId = $('#baseForm input[name="punishmentUser"]').attr('user_id')
		if(punishmentUserId&&punishmentUserId.indexOf(',')!=-1){
			punishmentUserId = punishmentUserId.substring(0,punishmentUserId.lastIndexOf(','))
		}
		obj.punishmentUserId = punishmentUserId || '';

		//公司责任人id
		var punishmentUserId2 = $('#baseForm input[name="punishmentUser2"]').attr('user_id')
		if(punishmentUserId2&&punishmentUserId2.indexOf(',')!=-1){
			punishmentUserId2 = punishmentUserId2.substring(0,punishmentUserId2.lastIndexOf(','))
		}
		obj.punishmentUserId2 = punishmentUserId2 || '';

		obj.projectId = projectId?projectId:data.projectId;


		if(type == '1'){
			obj.securityPunishmentId= data.securityPunishmentId;
		}

		// 判断必填项
		// var requiredFlag = false;
		// $('#baseForm').find('.field_required').each(function(){
		// 	var field = $(this).attr('field');
		// 	if (!obj[field]) {
		// 		var fieldName = $(this).parent().text().replace('*', '');
		// 		layer.msg(fieldName+'不能为空！', {icon: 0, time: 2000});
		// 		requiredFlag = true;
		// 		return false;
		// 	}
		// });
		// if (requiredFlag) {
		// 	return false;
		// }

		return obj
	}


	function childFunc() {
		if('0'!=_disabled){
            return true
        }
		var data = getData()

		var loadIndex = layer.load();


		var _flag = false;

		$.ajax({
			url: '/workflow/punishment/updateById',
			//data:JSON.stringify(obj),
			data: data ,
			dataType: 'json',
			//contentType: "application/json;charset=UTF-8",
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
	function getAutoNumber(params, callback) {
		$.get('/planningManage/autoNumber', params, function (res) {
			callback(res);
		});
	}


</script>
</body>
</html>
