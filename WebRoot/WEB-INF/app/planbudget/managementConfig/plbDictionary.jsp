<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="utf-8">
	<title>数据字典管理</title>
	<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
	<meta name="viewport"
		  content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=0">

	<link rel="stylesheet" href="/lib/layui/layui/css/layui.css?20210319.1">
	<link rel="stylesheet" href="/lib/layui/layui/css/eleTree.css">

<%--	<script type="text/javascript" src="/js/xoajq/xoajq1.js"></script>--%>
	<script type="text/javascript" src="/js/xoajq/xoajq3.js"></script>
<%--	<script type="text/javascript" src="/js/jquery/jquery-migrate-3.4.0.js"></script>--%>
	<script type="text/javascript" src="/js/jquery/jquery.form.min.js"></script>
	<script type="text/javascript" src="/js/base/base.js"></script>
	<script type="text/javascript" src="/lib/layui/layui/layui.all.js"></script>
	<script type="text/javascript" src="/lib/layui/layui/global.js"></script>
	<script src="/lib/jQuery-File-Upload-master/jquery-ui.js" type="text/javascript" charset="utf-8"></script>
	<script src="/lib/jQuery-File-Upload-master/jquery.iframe-transport.js" type="text/javascript" charset="utf-8"></script>
	<script src="/lib/jQuery-File-Upload-master/jquery.fileupload.js?20200111.3" type="text/javascript" charset="utf-8"></script>
	<script type="text/javascript" src="/js/common/fileupload.js"></script>
	<%--<script src="/lib/ueditor/ueditor.config.js" type="text/javascript" charset="utf-8"></script>--%>
	<%--<script src="/lib/ueditor/ueditor.all.js?20200715.1" type="text/javascript" charset="utf-8"></script>--%>
	<%--<script src="/lib/ueditor/UEcontroller.js" type="text/javascript" charset="utf-8"></script>--%>
	<script type="text/javascript" src="/js/email/fileuploadPlus.js?20230529.7"></script>

	<style>
		.layui-form-label {
			width: 100px;
		}

		.layui-input-block {
			margin-left: 130px;
		}

		.layui-disabled, .layui-disabled:hover {
			color: #797979 !important;
		}

		.ztree * {
			font-size: 11pt !important;
		}

		#questionTree li {
			border-bottom: 1px solid #ddd;
			line-height: 40px;
			padding-left: 10px;
			cursor: pointer;
			border-radius: 3px;
		}

		.select {
			background: #c7e1ff;
		}

		.layui-table-tool {
			min-height: 40px;
			padding: 5px 15px;
		}
	</style>

</head>
<body>
<div class="layui-fluid" id="LAY-app-message">
	<input type="hidden" id="sortId">
	<div class="layui-row ">
		<div class="layui-lf" style="width:250px;float:left">
			<div class="layui-card">
				<div class="layui-card-body" id="leftHeight" style="height:650px;">
					<div style="margin-bottom:10px">
						<button type="button" class="layui-btn layui-btn-primary layui-btn-sm add" id="addPlan">新增
						</button>
						<button type="button" class="layui-btn layui-btn-primary layui-btn-sm add" id="editPlan">编辑
						</button>
						<button type="button" class="layui-btn layui-btn-primary layui-btn-sm del" id="delPlan">删除
						</button>
					</div>
					<ul id="questionTree" style="overflow:auto;height:calc(100% - 40px)">
					</ul>
				</div>
			</div>
		</div>
		<div class="layui-rt rightHeight" style="width:calc(100% - 250px);float:left;background-color: #fff;">
			<div class="layui-card" style="padding-left: 10px;height: 100%;">
				<table id="questionTable" lay-filter="questionTable-table" onload=''></table>
			</div>
		</div>
	</div>
	<script type="text/html" id="barDemo">
		<a class="layui-btn layui-btn-xs" lay-event="edit">编辑</a>
		<a class="layui-btn layui-btn-danger layui-btn-xs" lay-event="del">删除</a>
	</script>
</div>
<script type="text/html" id="toolbar">
	<div class="layui-btn-container">
		<button class="layui-btn layui-btn-sm" style="margin: 0;" id="addTable">新增</button>
	</div>
</script>
<script>
	resizeSize();

	window.onresize = resizeSize;

	var form = null;
	var table = null;
	var tableIns = null;

	var type = $.GetRequest().type;

	$('#questionTree').on('click', 'li', function () {
		$(this).addClass('select').siblings().removeClass('select');
		initTable()

	})

	// 获取左侧类型列表
	function getlis() {
		$.ajax({
			url: '/plbDictonary/selectDictionary',
			type: 'get',
			dataType: 'json',
			success: function (res) {
				if (res.code == 0) {
					var data = res.data;
					var str = ''
					for (var i = 0; i < data.length; i++) {
						if (i == 0) {
							str += '<li class="select"  plbDictNo="' + data[i].plbDictNo + '"  plbDictId="' + data[i].plbDictId + '">' + data[i].dictName + '</li>'
						} else {
							str += '<li plbDictNo="' + data[i].plbDictNo + '" plbDictId="' + data[i].plbDictId + '" >' + data[i].dictName + '</li>'
						}
					}
					$('#questionTree').html(str);
					initTable();
				}
			}
		})
	}

	getlis();

	//左侧新建类型
	$('#addPlan').on('click',function () {
		create(0, '')
	})
	//左侧修改类型
	$('#editPlan').on('click',function () {
		var plbDictId = $('.select').attr('plbDictId');
		create(1, plbDictId)
	})
	//左侧删除类型
	$('#delPlan').on('click',function () {
		var plbDictId = $('.select').attr('plbDictId');
		var text = $('.select').text();
		layer.confirm('是否要删除' + text, {icon: 3, title: '删除'}, function (index) {
			$.ajax({
				url: '/plbDictonary/delDictionary',
				data: {plbDictId: plbDictId},
				type: 'get',
				dataType: 'json',
				success: function (res) {
					if (res.flag) {
						layer.msg('删除成功', {icon: 1})
						getlis()
					} else {
						layer.msg('删除失败', {icon: 2})
					}
				}
			})
			layer.close(index);
		});
	})

	//左侧新建编辑共有函数
	function create(type, plbDictId) {
		if (type == '0') {
			var title = '添加字典'
			var url = '/plbDictonary/insert'
		} else {
			var title = '编辑'
			var url = '/plbDictonary/upDictionary'
		}
		layer.open({
			type: 1,
			title: title,
			shadeClose: true,
			btn: ['确定', '取消'],
			shade: 0.5,
			maxmin: true, //开启最大化最小化按钮
			area: ['500px', '400px'],
			content: ' <div class="layui-form" >' +
					'<div class="layui-form-item"style="width: 80%;margin-top: 8%;">\n' +
					'    <label class="layui-form-label">字典名称:</label>\n' +
					'    <div class="layui-input-block">\n' +
					'      <input type="text" name="dictName" required  lay-verify="required" placeholder="请输入字典名称" autocomplete="off" class="layui-input">\n' +
					'    </div>\n' +
					'  </div>' +
					'<div class="layui-form-item" style="width: 80%;">\n' +
					'    <label class="layui-form-label">代码编号:</label>\n' +
					'    <div class="layui-input-block">\n' +
					'      <input type="text" name="plbDictNo" required  lay-verify="required" placeholder="请输入代码编号" autocomplete="off" class="layui-input">\n' +
					'    </div>\n' +
					'  </div>' +
					'<div class="layui-form-item" style="width: 80%;">\n' +
					'    <label class="layui-form-label">排序号:</label>\n' +
					'    <div class="layui-input-block">\n' +
					'      <input type="text" name="dictOrder" required  lay-verify="required" placeholder="请输入排序号" autocomplete="off" class="layui-input">\n' +
					'    </div>\n' +
					'  </div>' +
					'<div class="layui-form-item" style="width: 80%;">\n' +
					'    <label class="layui-form-label">备注说明:</label>\n' +
					'    <div class="layui-input-block">\n' +
					'      <input type="text" name="remarks" required  lay-verify="required" placeholder="请输入备注说明" autocomplete="off" class="layui-input">\n' +
					'    </div>\n' +
					'  </div>' +
					'</div>',
			success: function () {

				if (type == 1) {
					$.ajax({
						url: '/plbDictonary/selectDictionaryById',
						type: 'get',
						data: {plbDictId: plbDictId},
						dataType: 'json',
						success: function (res) {
							var data = res.data[0]
							$('input[name="dictName"]').val(data.dictName)
							$('input[name="plbDictNo"]').val(data.plbDictNo)
							$('input[name="dictOrder"]').val(data.dictOrder)
							$('input[name="remarks"]').val(data.remarks)

						}
					})
				}
				form.render();
			},
			yes: function () {
				var dictName = $('input[name="dictName"]').val()
				var plbDictNo = $('input[name="plbDictNo"]').val()
				var dictOrder = $('input[name="dictOrder"]').val()
				var remarks = $('input[name="remarks"]').val()
				var data = {
					dictName: dictName,
					plbDictNo: plbDictNo,
					dictOrder: dictOrder,
					remarks: remarks
				}
				if (type == 1) {
					data.plbDictId = plbDictId
				}
				$.ajax({
					url: url,
					data: data,
					dataType: 'json',
					type: 'get',
					success: function (res) {
						if (res.flag) {
							layer.msg('保存成功', {icon: 1});
							getlis();
							layer.closeAll();
						}
					}
				})
			}
		});
	}

	// 渲染右侧表格数据
	function initTable() {
		var plbDictNo = $('.select').attr('plbDictNo'),
				thTitle = $('.select').text() + '名称';
		if (plbDictNo == 'TAX_RATE') {
			thTitle += '（%）';
		}
		layui.use(['table', 'layer', 'form', 'xmSelect'], function () {
			var layer = layui.layer,
					xmSelect = layui.xmSelect;
			table = layui.table;
			form = layui.form;
			if (plbDictNo) {
				tableIns = table.render({
					elem: '#questionTable'
					, url: '/plbDictonary/selectDictionaryByNo?plbDictNo=' + plbDictNo
					, toolbar: '#toolbar'
					, defaultToolbar: ['']
					, height: 'full-80'
					, cols: [[ //表头
						{field: 'plbDictNo', title: '编号'}
						, {field: 'dictName', title: thTitle}
						, {field: 'remarks', title: '备注',}
						, {title: '操作', align: 'center', toolbar: '#barDemo'}
					]]
				});
			}

			//监听工具条
			table.on('tool(questionTable-table)', function (obj) {
				var data = obj.data;
				var layEvent = obj.event;
				var plbDictId = data.plbDictId

				if (layEvent === 'edit') {
					var str = '';
					var parentNo = $('.select').attr('plbDictNo');
					layer.open({
						type: 1,
						title: '编辑',
						shadeClose: true,
						btn: ['确定', '取消'],
						shade: 0.5,
						maxmin: true, //开启最大化最小化按钮
						area: ['600px', '400px'],
						content: ' <div class="layui-form" >' +
								'<div class="layui-form-item"style="width: 80%;margin-top: 8%;padding-left:20px">\n' +
								'    <label class="layui-form-label" style="width: 120px">' + thTitle + ':</label>\n' +
								'    <div class="layui-input-block" style="margin-left: 150px;">\n' +
								'      <input type="text" name="dictName" required  lay-verify="required" placeholder="请输入' + thTitle + '" autocomplete="off" class="layui-input">\n' +
								'    </div>\n' +
								'  </div>' +
								'<div class="layui-form-item"style="width: 80%;padding-left:20px">\n' +
								'    <label class="layui-form-label" style="width: 120px">编号:</label>\n' +
								'    <div class="layui-input-block" style="margin-left: 150px;">\n' +
								'      <input type="text" name="plbDictNo" readonly disabled style="background: #e7e7e7" lay-verify="required" placeholder="请输入编号" autocomplete="off" class="layui-input">\n' +
								'    </div>\n' +
								'  </div>' + str +
								'<div class="layui-form-item" style="width: 80%;padding-left:20px">\n' +
								'    <label class="layui-form-label" style="width: 120px;">备注:</label>\n' +
								'    <div class="layui-input-block" style="margin-left: 150px;">\n' +
								'      <input type="text" name="remarks" required  lay-verify="required" placeholder="请输入备注" autocomplete="off" class="layui-input">\n' +
								'    </div>\n' +
								'  </div>' +
								'</div>'+
								'<div class="layui-form-item" style="width: 80%;padding-left:20px">\n' +
								'    <label class="layui-form-label" style="width: 25%">附件:</label>\n' +
								'    <div class="layui-input-block" style="margin-left: 150px;">\n' +
								'<div id="fileContent" class="file_content"></div>' +
								'<input type="file" multiple id="fileupload" data-url="/upload?module=planbudget" name="file">\n' +
								'    </div>\n' +
								'  </div>',
						success: function () {
							fileuploadFn('#fileupload',$('#fileContent'));
							$('input[name="dictName"]').val(data.dictName);
							$('input[name="plbDictNo"]').val(data.plbDictNo);
							$('input[name="remarks"]').val(data.remarks);

							//附件回显
							if (data.attachmentList && data.attachmentList.length > 0) {
								var fileArr = data.attachmentList;
								var str = '';
								for (var i = 0; i < fileArr.length; i++) {
									var fileExtension = fileArr[i].attachName.substring(fileArr[i].attachName.lastIndexOf(".") + 1, fileArr[i].attachName.length);//截取附件文件后缀
									var attName = encodeURI(fileArr[i].attachName).replace(/\+/g, "%2b").replace(/\@/g, "%40").replace(/\#/g, "%23").replace(/\&/g, "%26").replace(/\//g, "%2F").replace(/\?/g, "%3F").replace(/\￥/g, "%ef%bf%a5").replace(/\$/g, "%24").replace(/\！/g, "%ef%bc%81").replace(/\（/g, "%ef%bc%88").replace(/\）/g, "%ef%bc%89").replace(/\…/g, "%e2%80%a6%e2%80%a6");
									var fileExtensionName = attName.substring(0, attName.lastIndexOf("."));
									var deUrl = fileArr[i].attUrl.split('&ATTACHMENT_NAME=')[0] + "&ATTACHMENT_NAME=" + fileExtensionName + "." + fileExtension + "&FILESIZE=" + fileArr[i].size;

									str += '<div class="dech" deUrl="' + deUrl + '"><a href="/download?' + encodeURI(deUrl) + '" NAME="' + fileArr[i].attachName + '*" style="text-decoration:none;margin-left:5px;"><img src="/img/attachment_icon.png"/>' + fileArr[i].attachName + '</a><img class="deImgs" style="margin-left:5px;cursor: pointer;" src="/img/file/icon_deletecha_03.png"/>' +
											function () {
												if (fileExtension == 'pdf' || fileExtension == 'png' || fileExtension == 'jpg' || fileExtension == 'txt') { //判断是否需要查阅
													return '<a class="operation yulan"  href="javascript:void(0);" data-url="' + encodeURI(deUrl) + '" style="padding: 5px;"><img src="/img/attachmentIcon/icon_skim.png" style="margin-right: 5px;" alt="">查阅</a>'
												} else {
													return '<a class="operation yulan"  href="javascript:void(0);" data-url="' + deUrl + '" style="padding: 5px;"><img src="/img/attachmentIcon/icon_skim.png" style="margin-right: 5px;" alt="">查阅</a>'
												}
											}() +
											'<a class="operation" style="padding: 0 5px 5px 5px;" href="/download?' + encodeURI(deUrl) + '"><img src="/img/attachmentIcon/icon_down.png" style="margin-right: 5px;" alt="">下载</a>'+
											'<input type="hidden" class="inHidden" value="' + fileArr[i].aid + '@' + fileArr[i].ym + '_' + fileArr[i].attachId + ',"></div>';
								}
								$('#fileContent').append(str);
							}

							/*    //附件回显
                                var strs1 = '';

                                if(data.attachmentList && data.attachmentList.length>0){
                                    debugger
                                    for (var i = 0; i < data.attachmentList.length; i++) {
                                        strs1 += '<div class="dech" deUrl="'+encodeURI(data.attachmentList[i].attUrl)+'"><a href="/download?'+encodeURI(data.attachmentList[i].attUrl)+'" NAME="' + data.attachmentList[i].attachName + '*"><img style="margin-right:10px;" src="/img/attachment_icon.png"/>' + data.attachmentList[i].attachName + '</a><img class="deImgs" style="margin-left:5px;cursor: pointer;" src="/img/file/icon_deletecha_03.png"/><input type="hidden" class="inHidden" value="' + data.attachmentList[i].aid + '@' + data.attachmentList[i].ym + '_' + data.attachmentList[i].attachId + ',"></div>';
                                    }
                                }
                                $('#fileContent').append(strs1);*/

							// 附件查阅
							$(document).on('click', '.yulan', function () {
								var url = $(this).attr('data-url');
								pdurl($.UrlGetRequest('?' + url), url);
							});

							//删除附件
							$(document).on('click', '.deImgs',function(){
								var _this = this;
								var attUrl = $(this).parents('.dech').attr('deUrl');
								$.ajax({
									type: 'get',
									url: '/delete?'+attUrl,
									dataType: 'json',
									success:function(res){

										if(res.flag == true){
											layer.msg('删除成功', { icon:6});
											$(_this).parent().remove();
										}else{
											layer.msg('删除失败', { icon:6});

										}
									}
								})
							});


						},
						yes: function () {
							var dictName = $('input[name="dictName"]').val();
							var remarks = $('input[name="remarks"]').val();
							var plbDictNo = $('input[name="plbDictNo"]').val();

							var data = {
								dictName: dictName,
								plbDictId: plbDictId,
								remarks: remarks,
								parentNo: parentNo,
								plbDictNo: plbDictNo
							}
							// 附件
							var attachmentId = '';
							var attachmentName = '';
							for (var i = 0; i < $('#fileContent .dech').length; i++) {
								attachmentId += $('#fileContent .dech').eq(i).find('input.inHidden').val();
								attachmentName += $('#fileContent a').eq(i).attr('name');
							}
							data.attachmentId = attachmentId;
							data.attachmentName = attachmentName;

							if (type == 1) {
								data.dictId = dictId
							}
							$.ajax({
								url: '/plbDictonary/upDictionary',
								data: data,
								dataType: 'json',
								type: 'get',
								success: function (res) {
									if (res.flag) {
										layer.msg('编辑成功', {icon: 1});
										layer.closeAll();
										tableIns.reload()
									}
								}
							});
						}
					});
				} else if (layEvent === 'del') {
					layer.confirm('真的删除该数据吗？', function (index) {
						$.ajax({
							url: '/plbDictonary/delDictionary',
							data: {plbDictId: plbDictId},
							dataType: 'json',
							type: 'get',
							success: function (res) {
								if (res.flag) {
									layer.msg('删除成功', {icon: 1});
									tableIns.reload()
								}
							}
						})
						layer.close(index);

					});
				}
			});
		})
	}

	//右侧新建
	// $('#addTable').off();
	$(document).on('click', '#addTable', function () {
		var plbDictNo = $('.select').attr('plbDictNo'),
				thTitle = $('.select').text() + '名称';
		var parentNo = $('.select').attr('plbDictNo');
		if (plbDictNo == 'TAX_RATE') {
			thTitle += '（%）';
		}
		layer.open({
			type: 1,
			title: '新增',
			btn: ['确定', '取消'],
			shade: 0.5,
			maxmin: true, //开启最大化最小化按钮
			area: ['600px', '400px'],
			content: ' <div class="layui-form" id="newRight" >' +
					'<div class="layui-form-item" style="width: 80%;margin-top: 8%;padding-left:20px">\n' +
					'    <label class="layui-form-label" style="width: 25%">' + thTitle + ':</label>\n' +
					'    <div class="layui-input-block" style="margin-left: 150px;">\n' +
					'      <input type="text" name="dictName" required  lay-verify="required" placeholder="请输入' + thTitle + '" autocomplete="off" class="layui-input">\n' +
					'    </div>\n' +
					'  </div>' +
					'<div class="layui-form-item"style="width: 80%;padding-left:20px">\n' +
					'    <label class="layui-form-label" style="width: 25%">编号:</label>\n' +
					'    <div class="layui-input-block" style="margin-left: 150px;">\n' +
					'      <input type="text" name="plbDictNo" style="background: #e7e7e7" readonly required  lay-verify="required" placeholder="请输入编号" autocomplete="off" class="layui-input">\n' +
					'    </div>\n' +
					'  </div>' +
					'<div class="layui-form-item" style="width: 80%;padding-left:20px">\n' +
					'    <label class="layui-form-label" style="width: 25%">备注:</label>\n' +
					'    <div class="layui-input-block" style="margin-left: 150px;">\n' +
					'      <input type="text" name="remarks" required  lay-verify="required" placeholder="请输入备注" autocomplete="off" class="layui-input">\n' +
					'    </div>\n' +
					'  </div>' +
					'</div>'+
					'<div class="layui-form-item" style="width: 80%;padding-left:20px">\n' +
					'    <label class="layui-form-label" style="width: 25%">附件:</label>\n' +
					'    <div class="layui-input-block" style="margin-left: 150px;">\n' +
					'<div id="fileContent" class="file_content"></div>' +
					'<input type="file" multiple id="fileupload" data-url="/upload?module=planbudget" name="file">\n' +
					'    </div>\n' +
					'  </div>',
			success: function () {
				fileuploadFn('#fileupload',$('#fileContent'));
				var parentNo = $('.select').attr('plbDictNo')
				$.get('/plbDictonary/getNoByParnetNo', {parentNo: parentNo}, function (res) {
					$('#newRight input[name="plbDictNo"]').val(res)
				});
			},
			yes: function (index) {
				var plbDictNo = $('input[name="plbDictNo"]').val();
				var dictName = $('input[name="dictName"]').val();
				var remarks = $('input[name="remarks"]').val();
				var data = {
					plbDictNo: plbDictNo,
					dictName: dictName,
					dictOrder: 0,
					parentNo: parentNo,
					remarks: remarks
				}
				// 附件
				var attachmentId = '';
				var attachmentName = '';
				for (var i = 0; i < $('#fileContent .dech').length; i++) {
					attachmentId += $('#fileContent .dech').eq(i).find('input.inHidden').val();
					attachmentName += $('#fileContent .dech').eq(i).attr('name');
				}
				data.attachmentId = attachmentId;
				data.attachmentName = attachmentName;

				if (type == 1) {
					data.dictId = dictId
				}

				$.ajax({
					url: '/plbDictonary/inserts',
					data: data,
					dataType: 'json',
					type: 'get',
					success: function (res) {
						if (res.flag) {
							if (res.code == 2) {
								layer.msg('该序号已被使用，请重新输入', {icon: 2});
							} else if (res.code == 3) {
								layer.msg(res.msg, {icon: 2});
							} else {
								layer.msg('新增成功', {icon: 1});
								layer.close(index);
								tableIns.reload()
							}
						}
					}
				})
			}
		});
	});

	// 初始化内容高度
	function resizeSize() {
		var height = $(window).height()
		$('#leftHeight').height(height - 80)
	}

</script>
</body>
</html>
