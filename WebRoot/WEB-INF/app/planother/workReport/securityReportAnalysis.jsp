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
	<title>安全情况报表</title>

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

		.form_label {
			float: none;
			padding: 9px 0;
			text-align: left;
			width: auto;
		}

		.form_block {
			margin: 0;
		}

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

		.table_Demo6 td[data-field="attachmentName"] .layui-table-cell{
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
			<h2 style="text-align: center;line-height: 35px;">安全情况</h2>
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
				<div class="layui-col-xs6" style="text-align: center">
					<h2 id="h2_title" style="margin-top: 10px;text-align: center"></h2>
				</div>
				<div class="layui-col-xs2 week" style="display: none">
					<input type="week" name="createWeek" id="createWeek" placeholder="请选择周" autocomplete="off" class="layui-input">
				</div>
				<div class="layui-col-xs2 month" >
					<input type="text" name="createYear" id="createYear" placeholder="请选择年" autocomplete="off" class="layui-input">
				</div>
				<div class="layui-col-xs2 month" style="margin-left: 15px;">
					<select name="createMonth" id="createMonth">
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
				<div class="table_box layui-form" style="display: none">
					<div class="layui-row month">
						<div class="layui-col-xs12" style="padding: 0 5px;">
							<h3 style="line-height: 50px;">月度安全情况说明</h3>
							<textarea type="text" name="memo" readonly style="resize: vertical;min-height: 80px" autocomplete="off" class="layui-input"></textarea>
						</div>
					</div>
					<div class="layui-row month">
						<div class="layui-col-xs12" style="padding: 0 5px;">
							<div class="layui-form-item">
								<label class="layui-form-label form_label">附件</label>
								<div class="layui-input-block form_block">
									<div class="file_module">
										<div id="fileContent2" class="file_content"></div>
										<div class="file_upload_box">
											<a href="javascript:;" class="open_file">
												<img src="/img/mg11.png" style="margin: -3px 5px 0 0;"><span>添加附件</span>
												<input type="file" multiple id="fileupload2" data-url="/upload?module=securityReport" name="file">
											</a>
											<%--<div class="progress" id="progress">
												<div class="bar"></div>
											</div>--%>
											<div class="bar_text"></div>
										</div>
									</div>
								</div>
							</div>
						</div>
					</div>
					<div class="layui-tab layui-tab-brief" lay-filter="docDemoTabBrief">
						<ul class="layui-tab-title _tab">
							<li class="layui-this">本月检查计划要求</li>
							<li>项目检查整改执行情况</li>
							<li>政府/甲方检查整改情况</li>
							<li>公司检查整改情况</li>
							<li>项目部检查整改情况</li>
							<li>项目罚款情况</li>
							<li>安全活动情况</li>
							<li>劳务实名制情况</li>
							<li>下月检查计划安排</li>
						</ul>
						<div class="layui-tab-content">
							<div class="layui-tab-item layui-show">
								<table id="detailedTable" lay-filter="detailedTable"></table>
							</div>
							<div class="layui-tab-item">
								<div class="layui-row" style="position: relative">
									<div class="table_box layui-col-xs6" style="display: none;float: left;padding-right: 20px" >
										<table class="layui-table" id="docDemoTabBrief" lay-filter="docDemoTabBrief" cellspacing="0" cellpadding="0">
											<thead>

											</thead>
										</table>
									</div>
									<div class="table_box layui-col-xs6" style="display: none;float:left;">
										<table class="layui-table" id="docDemoTabBrief2" lay-filter="docDemoTabBrief2" cellspacing="0" cellpadding="0">
											<thead>

											</thead>
										</table>
									</div>
								</div>
							</div>
							<div class="layui-tab-item">
								<p style="font-size: 20px;display: inline-block;">共检查<span id="left1"></span>项</p>
								<p style="font-size: 20px;display: inline-block;margin-left: 25px">需整改<span id="right1"></span>项</p>
								<table id="tableDemo2" lay-filter="tableDemo2"></table>
							</div>
							<div class="layui-tab-item">
								<p style="font-size: 20px;display: inline-block;">共检查<span id="left2"></span>项</p>
								<p style="font-size: 20px;display: inline-block;margin-left: 25px">需整改<span id="right2"></span>项</p>
								<table id="tableDemo3" lay-filter="tableDemo3"></table>
							</div>
							<div class="layui-tab-item">
								<p style="font-size: 20px;display: inline-block;">共检查<span id="left3"></span>项</p>
								<p style="font-size: 20px;display: inline-block;margin-left: 25px">需整改<span id="right3"></span>项</p>
								<table id="tableDemo4" lay-filter="tableDemo4"></table>
							</div>
							<div class="layui-tab-item">
								<table id="tableDemo5" lay-filter="tableDemo5"></table>
							</div>
							<div class="layui-tab-item table_Demo6">
								<table id="tableDemo6" lay-filter="tableDemo6"></table>
							</div>
							<div class="layui-tab-item month">
							   <div class="layui-row">
								   <div class="layui-col-xs3" style="padding: 0 5px;">
									   <div class="layui-form-item">
										   <label class="layui-form-label form_label">在册管理人员总数</label>
										   <div class="layui-input-block form_block">
										   <input type="text" name="manageUserNum" readonly autocomplete="off"  class="layui-input">
										   </div>
									   </div>
								   </div>
								   <div class="layui-col-xs3" style="padding: 0 5px;">
									   <div class="layui-form-item">
										   <label class="layui-form-label form_label">在册普通工人总数</label>
										   <div class="layui-input-block form_block">
											   <input type="text" name="workerNum" readonly autocomplete="off" class="layui-input">
										   </div>
									   </div>
								   </div>
								   <div class="layui-col-xs3" style="padding: 0 5px;">
									   <div class="layui-form-item">
										   <label class="layui-form-label form_label">代发工资总额（元）</label>
										   <div class="layui-input-block form_block">
											   <input type="text" name="wagesAmount" readonly autocomplete="off" class="layui-input">
										   </div>
									   </div>
								   </div>
								   <div class="layui-col-xs3" style="padding: 0 5px;">
									   <div class="layui-form-item">
										   <label class="layui-form-label form_label">人员参保总数</label>
										   <div class="layui-input-block form_block">
											   <input type="text" name="insuredNum" readonly autocomplete="off" class="layui-input">
										   </div>
									   </div>
								   </div>
							   </div>
							   <div class="layui-row">
								   <div class="layui-col-xs12" style="padding: 0 5px;">
									   <div class="layui-form-item">
										   <label class="layui-form-label form_label">附件</label>
										   <div class="layui-input-block form_block">
												<div class="file_module">
												<div id="fileContent" class="file_content"></div>
												<div class="file_upload_box">
												<a href="javascript:;" class="open_file">
												<img src="/img/mg11.png" style="margin: -3px 5px 0 0;"><span>添加附件</span>
												<input type="file" multiple id="fileupload" data-url="/upload?module=securityReport" name="file">
												</a>
												<%--<div class="progress" id="progress">
												<div class="bar"></div>
												</div>--%>
												<div class="bar_text"></div>
												</div>
												</div>
										   </div>
									   </div>
								   </div>
							   </div>
							</div>
							<div class="layui-tab-item">
								<table id="tableDemo8" lay-filter="tableDemo8"></table>
							</div>
						</div>
					</div>
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
<script type="text/html" id="navbar">
	<div style="position:absolute;top: 10px;right:60px;">
		<a class="layui-btn  layui-btn-xs" lay-event="refresh">刷新</a>
	</div>
</script>
<script type="text/html" id="toolbarDemo">
	<div style="height: 30px;color: #666">
		<span>安全检查分析报表</span>
	</div>
	<div style="position:absolute;top: 10px;right:60px;">
		<a class="layui-btn  layui-btn-xs" lay-event="refresh">刷新</a>
	</div>
</script>
<script type="text/html" id="toolbarDemo2">
	<div style="height: 30px;color: #666">
		<span>安全整改分析报表</span>
	</div>
	<div style="position:absolute;top: 10px;right:60px;">
		<a class="layui-btn  layui-btn-xs" lay-event="refresh">刷新</a>
	</div>
</script>

<script type="text/html" id="detailBarDemo">
	<a class="layui-btn  layui-btn-xs" lay-event="detail">查看详情</a>
</script>

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
		var tab_html = '<li class="layui-this">本周检查计划要求</li>\n' +
				'<li>项目检查整改执行情况</li>\n' +
				'<li>政府/甲方检查整改情况</li>\n' +
				'<li>公司检查整改情况</li>\n' +
				'<li>项目部检查整改情况</li>\n' +
				'<li>项目罚款情况</li>\n' +
				'<li>安全活动情况</li>' +
				'<li class="month">劳务实名制情况</li>\n' +
				'<li>下周检查计划安排</li>'

		$('._tab').html(tab_html)
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

	var objData = {}

	var _index = 0

	var securityInfoDate = null

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

	layui.use(['form', 'laydate', 'table', 'element', 'eleTree', 'layer','soulTable'], function () {
		var laydate = layui.laydate;
		var form = layui.form;
		var table = layui.table;
		var element = layui.element;
		var eleTree = layui.eleTree;
		var layer = layui.layer;

		// 获取数据字典数据
		var dictionaryObj = {
			SECIRITY_ACTIVITY_TYPE:{},
			SCHEDULE_INPORTANCE:{},
			CHECK_FREQUENCY:{},
			SCHEDULE_INPORTANCE:{}
		}
		var dictionaryStr = 'SECIRITY_ACTIVITY_TYPE,SCHEDULE_INPORTANCE,CHECK_FREQUENCY,SCHEDULE_INPORTANCE';
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

            var loadIndex = layer.load();
            $.get('/securityCycleAnalysis/select', para_ms, function (res) {
                layer.close(loadIndex);
				$('#createYear').val(res&&res.obj&&res.obj.year)
				$('[name="createMonth"]').val(res&&res.obj&&res.obj.month)
				$('[name="createWeek"]').val( res&&res.obj&&res.obj.year + '-W' + getWeek(new String(res&&res.obj&&res.obj.year) +'-'+ new String(res&&res.obj&&res.obj.month)+'-'+new String(res&&res.obj&&res.obj.day)))
				form.render();
				objData.data = res.obj
                tableShow(_index);
            });
        }


        laydate.render({
            elem: '#createYear'
            , trigger: 'click'//呼出事件改成click
            , type: 'year'
            // , format: 'yyyy-MM-dd'
        });

		element.on('tab(docDemoTabBrief)', function(data){
			_index = data.index
			tableShow(data.index);
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
				$('#h2_title').text(currentData.projName+'安全情况综合分析')
				$('.no_data').hide();
				$('.table_box').show();

				objData = {}

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


				var loadIndex = layer.load();
				$.get('/securityCycleAnalysis/select', para_ms, function (res) {
					layer.close(loadIndex);
					$('#createYear').val(res&&res.obj&&res.obj.year)
					$('[name="createMonth"]').val(res&&res.obj&&res.obj.month)
					$('[name="createWeek"]').val( res&&res.obj&&res.obj.year + '-W' + getWeek(new String(res&&res.obj&&res.obj.year) +'-'+ new String(res&&res.obj&&res.obj.month)+'-'+new String(res&&res.obj&&res.obj.day)))
					form.render();
					objData.data = res.obj
					tableShow(_index);
				});

			} else {
				$('#h2_title').text('')
				$('.table_box').hide();
				$('.no_data').show();
			}
		});

		// 渲染表格
		//index 页签索引
		//refresh 是否刷新
		function tableShow(index) {
			if(!($('#leftId').attr('projId'))) return

            if(showProj){
                $('#h2_title').text((objData.data&&objData.data.projectName||'')+'安全情况综合分析')
            }

            var data = objData.data

			var params = {}
			params.projectId = $('#leftId').attr('projId')||''
			params.projId = $('#leftId').attr('projId')||''
			params.delFlag = '0'
			if(data.serchBeginDate){
				params.beginDate = data.serchBeginDate
				objData.beginDate = data.serchBeginDate

			}
			if(data.serchEndDate){
				params.endDate = data.serchEndDate
				objData.endDate = data.serchEndDate
			}

			if(week){
				if($('[name="createWeek"]').val()){
					var arr = ($('[name="createWeek"]').val()).split('-W')
					params.beginDate = getDateOfISOWeek(arr[1],arr[0]).ISOweekStart
					objData.beginDate = getDateOfISOWeek(arr[1],arr[0]).ISOweekStart
					params.endDate = getDateOfISOWeek(arr[1],arr[0]).ISOweekEnd
					objData.endDate = getDateOfISOWeek(arr[1],arr[0]).ISOweekEnd
				}
			}

			var loadIndex = layer.load();
			if(!index){
				index = 0
			}

			$('[name="memo"]').val(data.securityObj&&data.securityObj.memo)

			//劳务实名制情况
			$('[name="manageUserNum"]').val(data.securityObj&&data.securityObj.manageUserNum)
			$('[name="workerNum"]').val(data.securityObj&&data.securityObj.workerNum)
			$('[name="wagesAmount"]').val(data.securityObj&&data.securityObj.wagesAmount)
			$('[name="insuredNum"]').val(data.securityObj&&data.securityObj.insuredNum)
			//附件
			if (data&&data.securityObj&&data.securityObj.attachmentList && data.securityObj.attachmentList.length > 0) {
				var fileArr = data.securityObj.attachmentList;
				$('#fileContent').html(echoAttachment(fileArr));
			}
			if (data&&data.securityObj&&data.securityObj.attachmentList2 && data.securityObj.attachmentList2.length > 0) {
				var fileArr = data.securityObj.attachmentList2;
				$('#fileContent2').html(echoAttachment(fileArr));
			}
			$('.file_upload_box').hide()
			$('.deImgs').hide();
			if(index==0){//本月检查计划要求
				if(objData.detailedTable){
					layer.close(loadIndex);
					return
				}
				table.render({
					elem: '#detailedTable',
					data: data&&data.beforeSecurityDetailsList||[],
					toolbar: '#navbar',
					defaultToolbar: ['filter'],
					height: 'full-170',
					limit: 1000,
					cols: [[
						{type: 'numbers', title: '序号'},
						{field: 'securityKnowledgeName', title: '检查项名称', width: 140},
						/*{field: 'mainDifficulties', title: '主要难点', minWidth: 160},
						{field: 'mainRisk', title: '主要风险', minWidth: 160},
						{field: 'riskSolutions', title: '风险解决措施', minWidth: 160},*/
						{field: 'personLiableName', title: '责任人', width: 200},
						{field: 'checkFrequency', title: '检查频率', width: 120, templet: function (d) {
								return '<span class="checkFrequency" checkFrequency="'+(d.checkFrequency || '') +'" >' + (d.checkFrequency&&dictionaryObj["CHECK_FREQUENCY"]?dictionaryObj["CHECK_FREQUENCY"].object[d.checkFrequency] : '') + '</span>'
							}},
						{field: 'importance', title: '重要性', minWidth: 100, templet: function (d) {
								return '<span class="importance" importance="'+(d.importance || '') +'" >' + (d.importance&&dictionaryObj["SCHEDULE_INPORTANCE"]?dictionaryObj["SCHEDULE_INPORTANCE"].object[d.importance] : '') + '</span>'
							}},
						{field: 'solutions', title: '检查项描述', minWidth: 160},
						{field: 'securityPlanBeginDate', title: '检查开始时间', minWidth: 160},
						{field: 'securityPlanEndDate', title: '检查结束时间', minWidth: 160},
						{field: 'workPlanningName', title: '所属策划', minWidth: 150},
						{field: 'securityKnowledgeName', title: '检查详细内容',width: 120, templet: function (d) {
								return '<span securityTermId="'+(d.securityTermId || '')+'" class="securityKnowledgeName chooseMaterials2"  style="cursor: pointer;color: blue;">' + (d.securityKnowledgeName || '') + '</span>'
							}}
					]],
					done: function (res) {
						objData.detailedTable = res.data
					}
				});
			}else if(index==1)//项目检查整改执行情况
			{
				var tarbarObj = null
				var docDemoTabBriefData = null
				var tarbarArr2 = null
				var tarbarArr3 = null
				var docDemoTabBriefData2 = null
				//安全检查
				if(!objData.docDemoTabBriefData){
					var fl=false;
					$.ajax({
						url:'/securityAnalysis/performanceAnalysis',
						type: 'post',
						data:params,
						dataType: 'json',
						async:false,
						success:function(res){
							if(res.code===0||res.code==="0"){
								fl=true
								tarbarObj = res.object
								docDemoTabBriefData = res.obj
								objData.docDemoTabBriefData = res.obj
							}
						}
					});
					$('#docDemoTabBrief thead').empty()
					if(fl){
						//表头
						var trOne = '<tr><th lay-data="{field:\'knowledgeName\',align:\'center\',minWidth:180}"  rowspan="2">检查项</th>\n' +
								'<th lay-data="{field:\'inspector\',align:\'center\'}"  colspan="'+(Object.keys(tarbarObj).length+1)+'">检查人</th>'+
								'<th lay-data="{field:\'sum\',align:\'center\',minWidth:70}"  rowspan="2">汇总统计</th>' +
								'</tr>'
						var trTwo = ''
						for (var index in tarbarObj){
							trTwo += '<th lay-data="{field:\''+index+'\',align:\'center\',minWidth:50}"  colspan="1">'+tarbarObj[index]+'</th>'
						}

						$('#docDemoTabBrief thead').append(trOne+'<tr>'+trTwo+'</tr>')

						table.init('docDemoTabBrief', { //转化静态表格
							//url:'/PtyMemberEvaluation/selectPmedByCPId?evaluationPartyId='+1+'&evaluationId='+2,
							data:docDemoTabBriefData,
							toolbar: '#toolbarDemo',
							defaultToolbar: ['filter'],
							height: 'full-170',
							limit:10000000,
							done:function(res,curr,count){
								//$("input:radio[name^='evaluating']").attr("disabled","disabled");
							}
						});
					}else{
						table.init('docDemoTabBrief', { //转化静态表格
							//url:'/PtyMemberEvaluation/selectPmedByCPId?evaluationPartyId='+1+'&evaluationId='+2,
							data:[],
							toolbar: '#toolbarDemo',
							defaultToolbar: ['filter'],
							height: 'full-170',
							limit:10000000,
							done:function(res,curr,count){
								//$("input:radio[name^='evaluating']").attr("disabled","disabled");
							}
						});
					}
				}

				if(!objData.docDemoTabBriefData2){
					var fl = false;
					//安全整改
					$.ajax({
						url:'/securityAnalysis/rectificationAnalysis',
						type: 'post',
						data:params,
						dataType: 'json',
						async:false,
						success:function(res){
							if(res.code===0||res.code==="0"){
								tarbarArr2 = (res.object&&res.object.header2)||null
								tarbarArr3 = res.object&&res.object.header3||null
								docDemoTabBriefData2 = res.obj
								objData.docDemoTabBriefData2 = res.obj
								fl=true;
							}else{
								table.init('docDemoTabBrief2', { //转化静态表格
									//url:'/PtyMemberEvaluation/selectPmedByCPId?evaluationPartyId='+1+'&evaluationId='+2,
									data:[],
									toolbar: '#toolbarDemo2',
									defaultToolbar: ['filter'],
									height: 'full-170',
									limit:10000000
								});
							}
						}
					});

					$('#docDemoTabBrief2 thead').empty()
					if(fl){
						//表头
						var tr2One = '<tr><th lay-data="{field:\'knowledgeName\',align:\'center\',minWidth:180}"  rowspan="3">隐患项</th>\n' +
								'<th lay-data="{field:\'inspector\',align:\'center\'}"  colspan="'+(Object.keys(tarbarArr2).length)*2+'">整改人</th>'+
								'<th lay-data="{field:\'sum\',align:\'center\',minWidth:100}"  rowspan="2" colspan="2">汇总统计</th>' +
								'</tr>'
						var tr2Two = ''
						tarbarArr2.forEach(function (item) {
							// tr2Two += '<th lay-data="{field:\''+index+'\',align:\'center\',minWidth:150,templet:\'<div>{{d['+index+']||0}}</div>\'}"  colspan="1">'+tarbarArr2[index]+'</th>'
							tr2Two += '<th lay-data="{field:\''+item.header+'\',align:\'center\'}"  colspan="2">'+item.headerName+'</th>'
						})

						var tr2Three = ''

						tarbarArr3.forEach(function (item) {
							// tr2Two += '<th lay-data="{field:\''+index+'\',align:\'center\',minWidth:150,templet:\'<div>{{d['+index+']||0}}</div>\'}"  colspan="1">'+tarbarArr2[index]+'</th>'
							tr2Three += '<th lay-data="{field:\''+item.header+'\',align:\'center\',minWidth:50}"  colspan="1">'+item.headerName+'</th>'
						})
						tr2Three += '<th lay-data="{field:\'sum-a\',align:\'center\',minWidth:50}"  colspan="1">需整改</th>'
						tr2Three += '<th lay-data="{field:\'sum-b\',align:\'center\',minWidth:50}"  colspan="1">未整改</th>'
						$('#docDemoTabBrief2 thead').append(tr2One+'<tr>'+tr2Two+'</tr><tr>'+tr2Three+'</tr>')

						table.init('docDemoTabBrief2', { //转化静态表格
							//url:'/PtyMemberEvaluation/selectPmedByCPId?evaluationPartyId='+1+'&evaluationId='+2,
							data:docDemoTabBriefData2,
							toolbar: '#toolbarDemo2',
							defaultToolbar: ['filter'],
							height: 'full-170',
							limit:10000000
						});
					}
				}
				layer.close(loadIndex);
			}else if(index==2){//政府/甲方检查整改情况
				if(objData.tableDemo2){
					layer.close(loadIndex);
					return
				}
				params.inspectionlevel='03'
				securityDangerAccount(params,index)
			} else if(index==3){//公司检查整改情况
				if(objData.tableDemo3){
					layer.close(loadIndex);
					return
				}
				params.inspectionlevel='02'
				securityDangerAccount(params,index)
			} else if(index==4){//项目部检查整改情况
				if(objData.tableDemo4){
					layer.close(loadIndex);
					return
				}
				params.inspectionlevel='01'
				securityDangerAccount(params,index)
			} else if(index==5){//项目罚款情况
				if(objData.tableDemo5){
					layer.close(loadIndex);
					return
				}
				table.render({
					elem: '#tableDemo5',
					url: '/workflow/punishment/analySis',
					toolbar: '#navbar',
					where:params,
					cols:  [[ //表头
						{field: 'num', title: '序号', minWidth: 90,sort: true, hide: false}
						, {field: 'finedDept', title: '被罚单位', minWidth: 120,sort: true, hide: false}
						, {field: 'punishmentDate', title: '罚款日期',minWidth: 100, sort: true, hide: false}
						, {field: 'punishmentMoney', title: '罚款金额',minWidth: 120, sort: true, hide: false}
						, {field: 'punishmentReason', title: '罚款原因',minWidth: 120, sort: true, hide: false}
					]],
					defaultToolbar: ['filter'],
					height: 'full-170',
					done: function (res) {
						objData['tableDemo5'] = res.data
					}
				});
			} else if(index==6){// 安全活动情况
				if(objData.tableDemo6){
					layer.close(loadIndex);
					return
				}
				table.render({
					elem: '#tableDemo6',
					url: '/secirityActivity/analysis',
					toolbar: '#navbar',
					where:params,
					cols: [[ //表头
						{type: 'numbers', title: '序号'}
						, {field: 'activityName', title: '安全活动名称', minWidth: 120, sort: true, hide: false}
						, {
							field: 'activityType',
							title: '安全活动类型',
							minWidth: 100,
							sort: true,
							hide: false,
							templet: function (d) {
								if (d.activityType) {
									return '<span>' + ((dictionaryObj && dictionaryObj['SECIRITY_ACTIVITY_TYPE'] && dictionaryObj['SECIRITY_ACTIVITY_TYPE']['object'][d.activityType]) || '') + '</span>'
								} else {
									return ''
								}
							}
						}
						,{field: 'importance', title: '重要性', minWidth: 100, templet: function (d) {
								return '<span class="importance" importance="'+(d.importance || '') +'" >' + (d.importance&&dictionaryObj["SCHEDULE_INPORTANCE"]?dictionaryObj["SCHEDULE_INPORTANCE"].object[d.importance] : '') + '</span>'
							}}
						, {field: 'participatePersion', title: '参加人员/班组', minWidth: 120, sort: true, hide: false}
						, {field: 'activityDate', title: '安全活动时间', minWidth: 120, sort: true, hide: false}
						, {field: 'activityPlace', title: '安全活动地点', minWidth: 120, sort: true, hide: false}
						, {
							field: 'attachmentName',
							title: '附件',
							align: 'center',
							minWidth: 200,
							templet: function (d) {
								var fileArr = d.attachList;
								return '<div id="fileAll'+d.LAY_INDEX+'"> ' +echoAttachment(fileArr)+
										'</div>'

							}
						}
					]],
					defaultToolbar: ['filter'],
					height: 'full-170',
					done: function (res) {
						$('.deImgs').hide()
						objData['tableDemo6'] = res.data
					}
				})
			} else if(index==7){//劳务实名制情况

			} else if(index==8){//下月检查计划安排
				if(objData.tableDemo8){
					layer.close(loadIndex);
					return
				}
				table.render({
					elem: '#tableDemo8',
					data: data&&data.securityDetailsList||[],
					// data:[],
					height: 'full-170',
					toolbar: '#navbar',
					defaultToolbar: ['filter'],
					limit: 1000,
					cols: [[
						{type: 'numbers', title: '序号'},
						{field: 'securityKnowledgeName', title: '检查项名称', width: 140},
						/*{field: 'mainDifficulties', title: '主要难点', minWidth: 160},
						{field: 'mainRisk', title: '主要风险', minWidth: 160},
						{field: 'riskSolutions', title: '风险解决措施', minWidth: 160},*/
						{field: 'personLiableName', title: '责任人', width: 200},
						{field: 'checkFrequency', title: '检查频率', width: 120, templet: function (d) {
								return '<span class="checkFrequency" checkFrequency="'+(d.checkFrequency || '') +'" >' + (d.checkFrequency&&dictionaryObj["CHECK_FREQUENCY"]?dictionaryObj["CHECK_FREQUENCY"].object[d.checkFrequency] : '') + '</span>'
							}},
						{field: 'importance', title: '重要性', minWidth: 100, templet: function (d) {
								return '<span class="importance" importance="'+(d.importance || '') +'" >' + (d.importance&&dictionaryObj["SCHEDULE_INPORTANCE"]?dictionaryObj["SCHEDULE_INPORTANCE"].object[d.importance] : '') + '</span>'
							}},
						{field: 'solutions', title: '检查项描述', minWidth: 160},
						{field: 'securityPlanBeginDate', title: '检查开始时间', minWidth: 160},
						{field: 'securityPlanEndDate', title: '检查结束时间', minWidth: 160},
						{field: 'workPlanningName', title: '所属策划', minWidth: 150},
						{field: 'securityKnowledgeName', title: '检查详细内容',width: 120, templet: function (d) {
								return '<span securityTermId="'+(d.securityTermId || '')+'" class="securityKnowledgeName chooseMaterials2"  style="cursor: pointer;color: blue;">' + (d.securityKnowledgeName || '') + '</span>'
							}}
					]],
					done: function (res) {
						objData['tableDemo8'] = res.data
					}
				});
			}

			$('.table_box').attr('disabled', 'disabled');
			layer.close(loadIndex);
		}


		//点击查询
		$('.searchData').click(function () {
			objData = {}
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

            var loadIndex = layer.load();
            $.get('/securityCycleAnalysis/select', para_ms, function (res) {
                layer.close(loadIndex);
                objData.data = res.obj
                tableShow(_index);
            });
		});

		//安全 检查详细内容
		$(document).on('click', '.chooseMaterials2', function () {
			var loadIndex = layer.load();
			$.post('/securityTerm/getById', {kayId: $(this).attr('securityTermId')}, function (res) {
				new_Edit2(res.obj)
				layer.close(loadIndex);
			})
		})
		//安全 检查详细内容
		function new_Edit2(data) {
			var projectId = $('#leftId').attr('projId');
			layer.open({
				type: 1,
				title: '检查详细内容',
				area: ['90%', '90%'],
				btn: ['确定'],
				btnAlign: 'c',
				content: '<div style="margin:20px"><table id="detailed_Table" lay-filter="detailed_Table"></table></div>',
				success: function () {

					//检查计划明细
					var cols = [
						// {type: 'radio'},
						{type: 'numbers', title: '序号'},
						{field: 'securityDanger', minWidth:150,title: '检查内容'},
						{field: 'securityDangerMeasures', minWidth:150,title: '整改措施'},
						{field: 'securityDangerGrade',minWidth:100, title: '隐患级别',templet:function(d){
								if(d.securityDangerGrade!=undefined&&d.securityDangerGrade!=""){
									if(d.securityDangerGrade===0||d.securityDangerGrade==="0"){
										return '<span securityDangerGrade="'+(d.securityDangerGrade || '')+'" securityTermId="'+(d.securityTermId || '')+'" securityTermDetailId="'+(d.securityTermDetailId || '')+'" securityDangerId="'+(d.securityDangerId || '')+'" securityDangerTypeId="'+(d.securityDangerTypeId || '')+'" index="'+(d.index || d.LAY_INDEX || '')+'">重大隐患</span>';
									}else{
										return '<span securityDangerGrade="'+(d.securityDangerGrade || '')+'" securityTermId="'+(d.securityTermId || '')+'" securityTermDetailId="'+(d.securityTermDetailId || '')+'" securityDangerId="'+(d.securityDangerId || '')+'" securityDangerTypeId="'+(d.securityDangerTypeId || '')+'" index="'+(d.index || d.LAY_INDEX || '')+'">一般隐患</span>';
									}
								}else{
									return '<span securityDangerGrade="'+(d.securityDangerGrade || '')+'" securityTermId="'+(d.securityTermId || '')+'" securityTermDetailId="'+(d.securityTermDetailId || '')+'" securityDangerId="'+(d.securityDangerId || '')+'" securityDangerTypeId="'+(d.securityDangerTypeId || '')+'" index="'+(d.index ||  d.LAY_INDEX || '')+'"></span>';
								}
							}
						}
					]

					table.render({
						elem: '#detailed_Table',
						data: data&&data.detailList||[],
						defaultToolbar: [''],
						limit: 1000,
						cols: [cols],
						done:function(res){
							$('.layui-table-body [data-field="securityDanger"] div,.layui-table-body [data-field="securityDangerMeasures"] div').on('mouseenter', function(){
								var content = $(this).text();
								if(!content){
									return false
								}

								this.index = layer.tips('<div style="padding: 10px; font-size: 14px; color: #eee;">'+ content + '</div>', this, {
									time: -1
									,maxWidth: 280
									,tips: [3, '#3A3D49']
								});
							}).on('mouseleave', function(){
								layer.close(this.index);
							});
						}
					});

					form.render();
				},
				yes: function (index) {
					layer.close(index);
				}
			});
		}

		//整改情况
		function securityDangerAccount(params,_index){

			$.get('/securityAnalysis/checkRecificaData',params,function(res){
				$('#left'+(_index-1)).text(res&&res.obj&&res.obj.checkNum)
				$('#right'+(_index-1)).text(res&&res.obj&&res.obj.recNum)
			})

			table.render({
				elem: '#tableDemo'+_index,
				url: '/workflow/rectification/select',
				cols: [[
					{title: '序号',type:'numbers'},
					{field:'projectName',title:'项目名称',minWidth: 120},
					{field: 'rectificationFlag', title: '整改状态',minWidth: 120,templet: function (d) {
							if(d.detailsInfo&&d.detailsInfo.needAcceptance==0){
								if(d.rectificationFlag&&d.rectificationFlag==1&&d.acceptance&&d.acceptance.auditerStatus==2){
									return  '<span>已完成</span>'
								}else if(d.rectificationFlag&&d.rectificationFlag==1&&d.acceptance&&d.acceptance.auditerStatus!=2){
									return  '<span style="color: red">已整改未验收</span>'
								}else if(d.rectificationFlag&&d.rectificationFlag==1&&!d.acceptance){
									return  '<span style="color: red">已整改未验收</span>'
								}else if(d.rectificationFlag&&d.rectificationFlag==0){
									return  '<span style="color: red">未整改</span>'
								}else{
									return  '<span style="color: red">未验收</span>'
								}
							}else if(d.rectificationFlag&&d.rectificationFlag==0){
								return  '<span style="color: red">未整改</span>'
							}else if(d.rectificationFlag&&d.rectificationFlag==10){
								return  '<span style="color: red">未通过验收</span>'
							}else if(d.detailsInfo&&d.detailsInfo.needAcceptance==1&&d.rectificationFlag&&d.rectificationFlag==1){
								return  '<span>已完成</span>'
							}else{
								return  '<span></span>'
							}
						}},
					{field: 'createTime', title: '检查时间',minWidth: 120, templet: function (d) {
						return '<span>'+(d.checklist?d.checklist.createTime:'')+'</span>'
					}},
					{field: 'securityKnowledgeName', title: '检查项',minWidth: 120,templet: function (d) {
							return '<span>'+(d.detailsInfo?d.detailsInfo.securityKnowledgeName:'')+'</span>'
						}},
					{field: 'securityDangerDesc', title: '检查内容',minWidth: 120,templet: function (d) {
							return '<span>'+(d.detailsInfo?d.detailsInfo.securityDangerDesc:'')+'</span>'
						}},
					{field: 'securityGrade', title: '隐患级别',minWidth: 120, templet: function (d) {
							if(d.detailsInfo){
								if(d.detailsInfo.securityGrade==0){
									return '<span class="securityGrade" securityGrade="'+d.detailsInfo.securityGrade+'" style="color: red" >重大隐患</span>'
								}else if(d.detailsInfo.securityGrade==1){
									return '<span class="securityGrade" securityGrade="'+d.detailsInfo.securityGrade+'">一般隐患</span>'
								}else{
									return '<span class="securityGrade"></span>'
								}
							}else {
								return '<span class="securityGrade"></span>'
							}

						}},
					{field: 'dangerLocation', title: '隐患位置',minWidth: 120,templet: function (d) {
							return '<span>'+(d.detailsInfo?d.detailsInfo.dangerLocation:'')+'</span>'
						}},
					{field: 'securityDangerMeasures', title: '整改措施',minWidth: 200,templet: function (d) {
							return '<span>'+(d.detailsInfo?d.detailsInfo.securityDangerMeasures:'')+'</span>'
						}},
					{field: 'rectificationPeriod', title: '整改期限',minWidth: 120,templet: function (d) {
							return '<span>'+(d.detailsInfo&&d.detailsInfo.rectificationPeriod?d.detailsInfo.rectificationPeriod:'')+'</span>'
						}},
					{field: 'createUserName', title: '检查人',minWidth: 120,templet: function (d) {
							return '<span>'+(d&&d.checklist&&d.checklist.createUserName||'')+'</span>'
						}},
					{field: 'needRectificationUserName',minWidth: 120, title: '整改人'},
					{fixed: 'right', align: 'center', toolbar: '#detailBarDemo', title: '操作', width: 100}
				]],
				toolbar: '#navbar',
				defaultToolbar: ['filter'],
				height: 'full-170',
				limit: 1000,
				where: params,
				done: function (res) {
					objData['tableDemo'+_index] = res.data
				}

			})
		}

		// 本月检查计划要求 刷新
		table.on('toolbar(detailedTable)', function (obj) {
			var layEvent = obj.event;
			if(layEvent === 'refresh'){
				objData.detailedTable = ''
				tableShow(0)
			}
		})
		// 项目检查执行情况 刷新
		table.on('toolbar(docDemoTabBrief)', function (obj) {
			var layEvent = obj.event;
			if(layEvent === 'refresh'){
				objData.docDemoTabBriefData = ''
				tableShow(1)
			}
		})
		// 项目整改执行情况 刷新
		table.on('toolbar(docDemoTabBrief2)', function (obj) {
			var layEvent = obj.event;
			if(layEvent === 'refresh'){
				objData.docDemoTabBriefData2 = ''
				tableShow(1)
			}
		})

		//政府/甲方检查整改情况
		table.on('toolbar(tableDemo2)', function (obj) {
			var layEvent = obj.event;
			if(layEvent === 'refresh'){
				objData.tableDemo2 = ''
				tableShow(2)
			}
		})
		table.on('tool(tableDemo2)', function (obj) {
			var data = obj.data;
			var layEvent = obj.event;
			if(layEvent === 'detail'){
				viewDetails(data)
			}
		});
		//公司检查整改情况
		table.on('toolbar(tableDemo3)', function (obj) {
			var layEvent = obj.event;
			if(layEvent === 'refresh'){
				objData.tableDemo3 = ''
				tableShow(3)
			}
		})
		table.on('tool(tableDemo3)', function (obj) {
			var data = obj.data;
			var layEvent = obj.event;
			if(layEvent === 'detail'){
				viewDetails(data)
			}
		});
		//项目部检查整改情况
		table.on('toolbar(tableDemo4)', function (obj) {
			var layEvent = obj.event;
			if(layEvent === 'refresh'){
				objData.tableDemo4 = ''
				tableShow(4)
			}
		})
		table.on('tool(tableDemo4)', function (obj) {
			var data = obj.data;
			var layEvent = obj.event;
			if(layEvent === 'detail'){
				viewDetails(data)
			}
		});

		//项目罚款情况
		table.on('toolbar(tableDemo5)', function (obj) {
			var layEvent = obj.event;
			if(layEvent === 'refresh'){
				objData.tableDemo5 = ''
				tableShow(5)
			}
		})

		//安全活动情况
		table.on('toolbar(tableDemo6)', function (obj) {
			var layEvent = obj.event;
			if(layEvent === 'refresh'){
				objData.tableDemo6 = ''
				tableShow(6)
			}
		})

		//劳务实名制情况
		table.on('toolbar(tableDemo7)', function (obj) {
			var layEvent = obj.event;
			if(layEvent === 'refresh'){
				objData.tableDemo7 = ''
				tableShow(7)
			}
		})

		// 查看详情
		function viewDetails(data) {
			securityInfoDate = data
			layer.open({
				type: 2,
				title: '查看详情',
				area: ['100%', '100%'],
				btn: '确定',
				btnAlign: 'c',
				content: '/workflow/secirityManager/addRectification?urlType=dangerAccount',
				success: function () {

				},
				yes: function (index) {
					layer.close(index);
				}
			});
		}

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
