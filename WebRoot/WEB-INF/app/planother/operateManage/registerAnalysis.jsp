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
	<title>变更单报表</title>

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

	</style>
</head>
<body>
<div class="container">
	<input type="hidden" id="leftId" class="layui-input">
	<div class="wrapper">
		<div class="wrap_left">
			<h2 style="text-align: center;line-height: 35px;">变更单报表</h2>
			<div class="left_form">
				<div class="search_icon">
					<i class="layui-icon layui-icon-search"></i>
				</div>
				<input type="text" name="title" id="search_project" placeholder="项目名称" autocomplete="off"
					   class="layui-input"/>
			</div>
			<div class="tree_module">
				<div id="leftTree" class="eleTree" lay-filter="leftTree"></div>
			</div>
		</div>
		<div class="wrap_right">
			<div class="query_module layui-form layui-row" style="position: relative">
				<div class="layui-col-xs2">
					<input type="text" name="beginDate" id="beginDate" placeholder="开始时间" autocomplete="off" class="layui-input">
				</div>
				<div class="layui-col-xs2" style="margin-left: 15px;">
					<input type="text" name="endDate" id="endDate"  placeholder="结束时间"  autocomplete="off" class="layui-input">
				</div>
				<div class="layui-col-xs2" style="margin-left: 15px;">
					<select name="registerCategory" id="registerCategory">

					</select>
				</div>
				<div class="layui-col-xs2" style="margin-left: 15px;">
					<select name="registerType" id="registerType">

					</select>
				</div>
				<div class="layui-col-xs2" style="margin-left: 15px;">
					<select name="auditerStatus">
						<option value="">请选择审批状态</option>
						<option value="0">未提交</option>
						<option value="1">审批中</option>
						<option value="2">批准</option>
						<option value="3">不批准</option>
					</select>
				</div>
				<div class="layui-col-xs1" style="margin-top: 3px;text-align: center">
					<button type="button" class="layui-btn layui-btn-sm searchData">查询</button>
					<%--                    <button type="button" class="layui-btn layui-btn-sm">高级查询</button>--%>
				</div>
			</div>
			<div style="position: relative">
				<div class="table_box" style="display: none">
					<table id="tableDemo" lay-filter="tableDemo"></table>
				</div>
				<div class="no_data" style="text-align: center;">
					<div class="no_data_img" style="margin-top:12%;">
						<img style="margin-top: 2%;" src="/img/noData.png">
					</div>
					<p style="text-align: center; font-size: 20px; font-weight: normal;">请选择左侧项目</p>
				</div>
			</div>
		</div>
	</div>
</div>

<script>

	var tipIndex = null;
	$('.icon_img').hover(function () {
		var tip = $(this).attr('text')
		tipIndex = layer.tips(tip, this)
	}, function () {
		layer.close(tipIndex)
	});


	var tableIns = null;
	layui.use(['form', 'laydate', 'table', 'element', 'eleTree', 'layer','soulTable'], function () {
		var laydate = layui.laydate;
		var form = layui.form;
		var table = layui.table;
		var element = layui.element;
		var eleTree = layui.eleTree;
		var layer = layui.layer;

		// 获取数据字典数据
		var dictionaryObj = {
			OPERATE_REGISTER_CATEGORY:{},
			OPERATE_REGISTER_TYPE:{}
		}
		var dictionaryStr = 'OPERATE_REGISTER_CATEGORY,OPERATE_REGISTER_TYPE';
		$.get('/plbDictonary/selectDictionaryByDictNos', {plbDictNos: dictionaryStr}, function (res) {
			if (res.flag) {
				for (var dict in dictionaryObj) {
					dictionaryObj[dict] = {object: {}, str: ''}
					if (res.object[dict]) {
						res.object[dict].forEach(function (item) {
							dictionaryObj[dict]['object'][item.plbDictNo] = item.dictName;
							dictionaryObj[dict]['str'] += '<option value=' + item.plbDictNo + '>' + item.dictName + '</option>';
						});
					}
				}
				var str = '<option value="">请选择变更单类别</option>'
				str += (dictionaryObj&&dictionaryObj['OPERATE_REGISTER_CATEGORY']&&dictionaryObj['OPERATE_REGISTER_CATEGORY']['str'])||''
				$('#registerCategory').html(str)
				var str = '<option value="">请选择变更单类型</option>'
				str += (dictionaryObj&&dictionaryObj['OPERATE_REGISTER_TYPE']&&dictionaryObj['OPERATE_REGISTER_TYPE']['str'])||''
				$('#registerType').html(str)
				form.render();
			}
		});


		laydate.render({
			elem: '#beginDate'
			, trigger: 'click'
			, format: 'yyyy-MM-dd'
			// , format: 'yyyy-MM-dd HH:mm:ss'
			//,value: new Date()
		});

		laydate.render({
			elem: '#endDate'
			, trigger: 'click'
			, format: 'yyyy-MM-dd'
			// , format: 'yyyy-MM-dd HH:mm:ss'
			//,value: new Date()
		});


		form.render();

		// 初始化左侧项目
		projectLeft();


		var searchTimer = null
		$('#search_project').on('input propertychange', function () {
			clearTimeout(searchTimer)
			searchTimer = null
			var val = $(this).val()
			searchTimer = setTimeout(function () {
				projectLeft(val)
			}, 300)
		});
		$('.search_icon').on('click', function () {
			projectLeft($('#search_project').val())
		});

		//左侧项目信息列表
		function projectLeft(projectName) {
			projectName = projectName ? projectName : ''
			var loadingIndex = layer.load();
			$.get('/plbOrg/treeListOrg', {projectName: projectName}, function (res) {
				layer.close(loadingIndex);
				if (res.flag) {
					eleTree.render({
						elem: '#leftTree',
						data: res.data,
						highlightCurrent: true,
						showLine: true,
						defaultExpandAll: false,
						request: {
							name: 'name',
							children: "plbProjList",
						}
					});
				}
			});
		}

		// 树节点点击事件
		eleTree.on("nodeClick(leftTree)", function (d) {
			var currentData = d.data.currentData;
			if (currentData.projId) {
				$('#leftId').attr('projId', currentData.projId);
				$('.no_data').hide();
				$('.table_box').show();
				tableShow(currentData.projId);
			} else {
				$('.table_box').hide();
				$('.no_data').show();
			}
		});

		// 渲染表格
		function tableShow(projId) {
			tableIns = table.render({
				elem: '#tableDemo',
				url: '/plbOperateManage/registerAnalysis',
				cols:  [[ //表头
					{field:'projectName',title:'项目名称',minWidth: 120,sort:true,hide:false}
					, {field: 'registerName', title: '变更单名称', minWidth: 120,sort: true, hide: false}
					, {field: 'registerCategoryName', title: '变更单类别',minWidth: 100, sort: true, hide: false}
					, {field: 'registerTypeName', title: '变更单类型',minWidth: 120, sort: true, hide: false}
					, {field: 'registerDate', title: '变更日期',minWidth: 120, sort: true, hide: false}
					, {field: 'firstPartyOrderFlag', title: '甲方是否已下达指令',minWidth: 120, sort: true, hide: false}
					, {field: 'registerContent', title: '变更内容说明',minWidth: 120, sort: true, hide: false}
					, {
						field: 'auditerStatus',
						title: '审核状态',
						minWidth: 120,
						sort: true,
						hide: false,
						templet: function (d) {
							var str = '';
							switch (d.auditerStatus) {
								case '0':
									str = '未提交';
									break;
								case '1':
									str = '审批中';
									break;
								case '2':
									str = '批准';
									break;
								case '3':
									str = '不批准';
									break;
							}
							return str;
						}
					}
				]],
				defaultToolbar: ['filter'],
				height: 'full-100',
				// page: true,
				where: {
					projectId: projId,
					delFlag: '0'
				},
				done: function (res) {

				}
			});
		}


		//点击查询
		$('.searchData').click(function () {
			var searchParams = {}
			var $seachData = $('.query_module [name]')
			$seachData.each(function () {
				searchParams[$(this).attr('name')] = $(this).val() ? $(this).val().trim() : ''
				// 将查询值保存至cookie中
				// $.cookie($(this).attr('name'), $(this).val(), {expires: 5, path: "/",});
			})
			tableIns.reload({
				where: searchParams
			});
		});

	});

</script>
</body>
</html>
