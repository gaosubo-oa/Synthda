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
	<title>经营库</title>

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
			padding: 15px;
			box-sizing: border-box;
		}


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

	</style>
</head>
<body>
<div class="container">
	<table id="tableDemo" lay-filter="tableDemo"></table>
</div>

<script type="text/html" id="toolbarDemo">
	<div class="layui-btn-container" style="height: 30px;">
		<button class="layui-btn layui-btn-sm layui-btn-normal" lay-event="add">新建</button>
		<button class="layui-btn layui-btn-sm" lay-event="edit">编辑</button>
		<button class="layui-btn layui-btn-sm layui-btn-danger" lay-event="del">删除</button>
	</div>
</script>

<script>

	var tableIns = null;
	layui.use(['form','table','layer'], function () {
		var form = layui.form;
		var table = layui.table;
		var layer = layui.layer;

		tableShow()

		form.render();


		// 上方按钮显示
		table.on('toolbar(tableDemo)', function (obj) {
			var checkStatus = table.checkStatus(obj.config.id);
			var dataTable = table.checkStatus(obj.config.id).data;
			switch (obj.event) {
				case 'add':
					newOrEdit(0);
					break;
				case 'edit':
					if (checkStatus.data.length != 1) {
						layer.msg('请选择一项！', {icon: 0});
						return false
					}
					newOrEdit(1, checkStatus.data[0])
					break;
				case 'del':
					if (!checkStatus.data.length) {
						layer.msg('请至少选择一项！', {icon: 0});
						return false
					}
					var optimizationKnowId = ''
					checkStatus.data.forEach(function (v, i) {
						optimizationKnowId += v.optimizationKnowId + ','
					})
					layer.confirm('确定删除该条数据吗？', function (index) {
						$.post('/businessKnowledge/del', {ids: optimizationKnowId}, function (res) {
							if (res.code == '0') {
								layer.msg('删除成功！', {icon: 1});
							} else {
								layer.msg('删除失败！', {icon: 0});
							}
							layer.close(index)
							tableIns.config.where._ = new Date().getTime();
							tableIns.reload()
						})
					});
					break;
			}
		});


		// 渲染表格
		function tableShow() {

			tableIns = table.render({
				elem: '#tableDemo',
				url: '/businessKnowledge/select',
				toolbar: '#toolbarDemo',
				cols: [[
					{checkbox: true},
					{field: 'documnetNo', title: '单据号', minWidth: 90, sort: true, hide: false},
					{field: 'optimizationKnowName', title: '经营立项名称', minWidth: 120, sort: true, hide: false}
				]],
				defaultToolbar: ['filter'],
				// height: 'full-80',
				where: {
					delFlag: '0'
				}
			});
		}

		// 新建/编辑
		function newOrEdit(type, data) {
			var title = '';
			var url = '';
			if (type == '0') {
				title = '新建';
				url = '/businessKnowledge/insert';
			} else if (type == '1') {
				title = '编辑';
				url = '/businessKnowledge/updateById';
			}
			layer.open({
				type: 1,
				title: title,
				area: ['30%', '40%'],
				btn: ['保存', '取消'],
				btnAlign: 'c',
				content: ['<form class="layui-form _disabled" id="baseForm" lay-filter="formTest">' +
				'           <div class="layui-row">' +
				'               <div class="layui-col-xs12" style="padding: 0 5px;">' +
				'                   <div class="layui-form-item">\n' +
				'                       <label class="layui-form-label form_label">单据号<span field="documnetNo" class="field_required">*</span></label>\n' +
				'                       <div class="layui-input-block form_block">\n' +
				'                       <input type="text" name="documnetNo" readonly autocomplete="off" style="background: #e7e7e7" class="layui-input">\n' +
				'                       </div>\n' +
				'                   </div>' +
				'               </div>' +
				' 			</div>' +
				'           <div class="layui-row">' +
				'               <div class="layui-col-xs12" style="padding: 0 5px;">' +
				'                   <div class="layui-form-item">\n' +
				'                       <label class="layui-form-label form_label">经营立项名称<span field="optimizationKnowName" class="field_required">*</span></label>\n' +
				'                       <div class="layui-input-block form_block">\n' +
				'                       <input type="text" name="optimizationKnowName" autocomplete="off"  class="layui-input">\n' +
				'                       </div>\n' +
				'                   </div>' +
				'               </div>' +
				' 			</div>' +
				'</form>'].join(''),
				success: function () {

					//回显数据
					if (type == 1) {
						form.val("formTest", data);

					} else {
						// 获取自动编号
						getAutoNumber({autoNumberType: 'businessKnowledge'}, function (res) {
							$('input[name="documnetNo"]', $('#baseForm')).val(res.obj);
						});
					}

					form.render();
				},
				yes: function (index) {
					var datas = $('#baseForm').serializeArray();
					var obj = {}
					datas.forEach(function (item) {
						obj[item.name] = item.value
					});

					if (type == '1') {
						obj.optimizationKnowId = data.optimizationKnowId;
					}

					// 判断必填项
					var requiredFlag = false;
					$('#baseForm').find('.field_required').each(function () {
						var field = $(this).attr('field');
						if (!obj[field]) {
							var fieldName = $(this).parent().text().replace('*', '');
							layer.msg(fieldName + '不能为空！', {icon: 0, time: 2000});
							requiredFlag = true;
							return false;
						}
					});
					if (requiredFlag) {
						return false;
					}
					var loadIndex = layer.load();

					$.ajax({
						url: url,
						data: obj,
						dataType: 'json',
						type: 'post',
						success: function (res) {
							layer.close(loadIndex);
							if (res.code == '0') {
								layer.msg('保存成功！', {icon: 1});
								layer.close(index);
								tableIns.config.where._ = new Date().getTime();
								tableIns.reload();
							} else {
								layer.msg(res.msg, {icon: 7});
							}
						}
					});
				}
			});
		}

	})
	/**
	 * 获取自动编号接口
	 * @param params (参数{autoNumber: 数据库表名, costType: 报销单类型})
	 * @param callback (回调函数)
	 */
	function getAutoNumber(params, callback) {
		$.get('/planningManage/autoNumber', params, function (res) {
			callback(res);
		});
	}

</script>
</body>
</html>
