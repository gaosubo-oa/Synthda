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
	<title>收发文管理报表</title>

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

		td[data-field="attachName"] .layui-table-cell{
			height: auto;
			overflow:visible;
			text-overflow:inherit;
			white-space:normal;
			word-break: break-word;
		}


	</style>
</head>
<body>
<div class="container">
	<input type="hidden" id="leftId" class="layui-input">
	<div class="wrapper">
		<div class="wrap_left">
			<h2 style="text-align: center;line-height: 35px;">收发文情况概述</h2>
			<div class="left_form">
				<div class="search_icon">
					<i class="layui-icon layui-icon-search"></i>
				</div>
				<input type="text" name="title" id="search_project" placeholder="项目名称" autocomplete="off" class="layui-input"/>
			</div>
			<div class="tree_module">
				<div id="leftTree" class="eleTree" lay-filter="leftTree"></div>
			</div>
		</div>
		<div class="wrap_right">
			<div class="query_module layui-form layui-row" style="position: relative">
				<div class="layui-col-xs6" style="text-align: center">
					<h2 id="h2_title" style="margin-top: 10px;text-align: center"></h2>
				</div>
				<div class="layui-col-xs2 week" style="display: none">
					<input type="week" name="week" id="week" placeholder="请选择周" autocomplete="off" class="layui-input">
				</div>
				<div class="layui-col-xs2 month" >
					<input type="text" name="year" id="year" placeholder="请选择年" autocomplete="off" class="layui-input">
				</div>
				<div class="layui-col-xs2 month" style="margin-left: 15px;">
					<select name="month" id="month">
						<option value="">请选择月</option>
						<option value="1">1月</option>
						<option value="2">2月</option>
						<option value="3">3月</option>
						<option value="4">4月</option>
						<option value="5">5月</option>
						<option value="6">6月</option>
						<option value="7">7月</option>
						<option value="8">8月</option>
						<option value="9">9月</option>
						<option value="10">10月</option>
						<option value="11">11月</option>
						<option value="12">12月</option>
					</select>
				</div>
				<div class="layui-col-xs1" style="margin-top: 3px;text-align: center">
					<button type="button" class="layui-btn layui-btn-sm searchData">查询</button>
					<%--                    <button type="button" class="layui-btn layui-btn-sm">高级查询</button>--%>
				</div>
				<div class="layui-col-xs1" style="margin-top: 3px;text-align: center;width: 5%;float: right">
					<i class="layui-icon layui-icon-screen-full screen-full" title="全屏" style="font-size: 33px;cursor: pointer;"></i>
				</div>
<%--				<div style="position: absolute;top: -1px;right: 10px;height: 35px;line-height: 35px;">--%>
<%--					<i class="layui-icon layui-icon-read icon_img" style="margin-right: 15px" text="知识库"></i>--%>
<%--					<i class="layui-icon layui-icon-survey icon_img" text="帮助"></i>--%>
<%--				</div>--%>
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

	// 获取地址栏参数值
	function getQueryString(name){
		var reg = new RegExp("(^|&)"+ name +"=([^&]*)(&|$)");
		var r = window.location.search.substr(1).match(reg);
		if(r!=null)return  unescape(r[2]); return null;
	}

	var projectId = getQueryString("projectId");
	var showProj = getQueryString("showProj");
	var year = getQueryString("year");
	var month = getQueryString("month");

	var week = getQueryString("analysisType");

	if(week){
		$('.week').show()
		$('.month').hide()
	}

	if(showProj){
		$('.wrap_left').hide()

		$('.no_data').hide();
		$('.table_box').show();
		$('.wrap_right').css('margin-left',0)
	}

	$('#createYear').val(year||'')
	$('[name="createMonth"]').val(month||'')

	var tipIndex = null;
	$('.icon_img').hover(function () {
		var tip = $(this).attr('text')
		tipIndex = layer.tips(tip, this)
	}, function () {
		layer.close(tipIndex)
	});

	var animateFlag = true
	$(".screen-full").click(function(){
		$(".wrap_left").animate({
			width:'toggle'
		});
		$(".wrap_right").animate({
			marginLeft:'0'
		},function(){
			$('.searchData').click()
		});
		if(animateFlag){
			$(this).removeClass("layui-icon-screen-full").addClass('layui-icon-screen-restore').attr('title','退出全屏');

		}else {
			$(this).removeClass("layui-icon-screen-restore").addClass('layui-icon-screen-full').attr('title','全屏');
		}

		animateFlag = !animateFlag
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
			FILE_TYPE:{}
		}
		var dictionaryStr = 'FILE_TYPE';
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
			}
		});

		if(showProj){
			$('#leftId').attr('projId', projectId);

			var para_ms = {}
			para_ms.projectId = $('#leftId').attr('projId')||''
			if($('#createYear').val()){
				para_ms.year = $('#createYear').val()
			}
			if($('[name="createMonth"]').val()){
				para_ms.month = $('[name="createMonth"]').val()
			}

			if(week){
				para_ms.type = 'week'
				if($('[name="createWeek"]').val()){
					var arr = ($('[name="createWeek"]').val()).split('-W')
					para_ms.beginDate = getDateOfISOWeek(arr[1],arr[0]).ISOweekStart
					para_ms.endDate = getDateOfISOWeek(arr[1],arr[0]).ISOweekEnd
				}
			}
			para_ms.projectId = projectId
			para_ms.delFlag = 0

			var loadIndex = layer.load();
			tableShow(para_ms);
			layer.close(loadIndex);
		}

		laydate.render({
			elem: '#year'
			, trigger: 'click'//呼出事件改成click
			, type: 'year'
			// , format: 'yyyy-MM-dd'
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
				$('#h2_title').text(currentData.projName+'项目收发文综合分析')
				$('.no_data').hide();
				$('.table_box').show();

				var para_ms = {}
				para_ms.projectId = $('#leftId').attr('projId')||''
				if($('#createYear').val()){
					para_ms.year = $('#createYear').val()
				}
				if($('[name="createMonth"]').val()){
					para_ms.month = $('[name="createMonth"]').val()
				}

				if(week){
					para_ms.type = 'week'
					if($('[name="createWeek"]').val()){
						var arr = ($('[name="createWeek"]').val()).split('-W')
						para_ms.beginDate = getDateOfISOWeek(arr[1],arr[0]).ISOweekStart
						para_ms.endDate = getDateOfISOWeek(arr[1],arr[0]).ISOweekEnd
					}
				}
				para_ms.projectId = $('#leftId').attr('projId')
				para_ms.delFlag = 0

				tableShow(para_ms);
			} else {
				$('.table_box').hide();
				$('.no_data').show();
				$('#h2_title').text('')
			}
		});

		// 渲染表格
		function tableShow(parms,type) {
			tableIns = table.render({
				elem: '#tableDemo',
				url: '/plbOtherDocument/documentReport',
				cols:  [[ //表头
					{title:'序号',type:'numbers'}
					, {field:'fileNo',title:'文件编号',minWidth: 120,sort:true,hide:false}
					, {field: 'fileName', title: '文件名称', minWidth: 120,sort: true, hide: false}
					, {field: 'sendDocumentName', title: '发文单位',minWidth: 120, sort: true, hide: false}
					, {field: 'receiptName', title: '签收单位',minWidth: 120, sort: true, hide: false}
					, {field: 'fileType', title: '文件类型',minWidth: 100, sort: true, hide: false,templet: function (d) {
							if(d.fileType) {
								return '<span>'+((dictionaryObj&&dictionaryObj['FILE_TYPE']&&dictionaryObj['FILE_TYPE']['object'][d.fileType])||'')+'</span>'
							}else {
								return ''
							}
						}}
					, {field: 'receiptDate', title: '来文日期',minWidth: 120, sort: true, hide: false}
					, {field: 'documentSummary', title: '文件摘要',minWidth: 200, sort: true, hide: false}
					, {
						field: 'attachName',
						title: '文件附件',
						align: 'center',
						minWidth: 200,
						templet: function (d) {
							var fileArr = d.attachmentList;
							return '<div id="fileAll'+d.LAY_INDEX+'"> ' +echoAttachment(fileArr)+
									'</div>'

						}
					}
				]],
				defaultToolbar: ['filter'],
				height: 'full-100',
				// page: true,
				where: parms,
				done: function (res) {
					$('.deImgs').hide()
					$('#h2_title').text((res&&res.obj&&res.obj.projectName||'')+'项目收发文综合分析')

					if(!type){
						$('#year').val(res&&res.obj&&res.obj.year)
						$('[name="month"]').val(res&&res.obj&&res.obj.month)
						$('[name="week"]').val( res&&res.obj&&res.obj.year + '-W' + getWeek(new String(res&&res.obj&&res.obj.year) +'-'+ new String(res&&res.obj&&res.obj.month)+'-'+new String(res&&res.obj&&res.obj.day)))
					}
					form.render();
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
			searchParams.projectId = $('#leftId').attr('projId')||''
			searchParams.delFlag = 0

			if(week){
				searchParams.type = 'week'
				if(searchParams.week){
					var arr = searchParams.week.split('-W')
					searchParams.beginDate = getDateOfISOWeek(arr[1],arr[0]).ISOweekStart
					searchParams.endDate = getDateOfISOWeek(arr[1],arr[0]).ISOweekEnd
				}
			}
			tableShow(searchParams,true)
			/*tableIns.reload({
				where: searchParams
			});*/
		});

	});

	//JS 获取指定日期在当年的第几周
	function getWeek(dt){
		let d1 = new Date(dt);
		let d2 = new Date(dt);
		d2.setMonth(0);
		d2.setDate(1);
		let rq = d1-d2;
		let days = Math.ceil(rq/(24*60*60*1000));
		let num = Math.ceil(days/7);
		if(num<10){
			num = '0'+num
		}
		return num;
	}


	//JS 获取指定周年，返回当前周的周一和周日的日期
	function getDateOfISOWeek(w, y) {
		var simple = new Date(y, 0, 1 + (w - 1) * 7);
		var dow = simple.getDay();
		var ISOweekStart = simple;
		if (dow <= 4)
			ISOweekStart.setDate(simple.getDate() - simple.getDay() + 1);
		else
			ISOweekStart.setDate(simple.getDate() + 8 - simple.getDay());
		console.log(ISOweekStart.getFullYear())
		console.log(ISOweekStart.getMonth() + 1)
		console.log(ISOweekStart.getDate())

		var ISOweekEnd = ISOweekStart.getTime()+1000*60*60*24*6
		ISOweekEnd = new Date(ISOweekEnd)

		return {
			ISOweekStart:format(ISOweekStart),
			ISOweekEnd:format(ISOweekEnd)
		}
	}

	function format(data,format) {
		if(!data){
			data = new Date();
		}
		if(!format){
			format = '-'
		}
		var  nstr = "";
		// var now = new Date();
		var nyear = data.getFullYear();
		var nmonth = data.getMonth()+1;
		var nday = data.getDate();
		if(nmonth<10){
			nmonth = "0"+nmonth;
		}
		if(nday<10){
			nday = "0"+nday;
		}
		nstr = nyear+format+nmonth+format+nday;
		return nstr;
	}

</script>
</body>
</html>
