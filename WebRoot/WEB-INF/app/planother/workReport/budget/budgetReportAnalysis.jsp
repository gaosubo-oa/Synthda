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
	<title>成本分析</title>

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

		/*选中行样式*/
		.selectTr {
			background: #009688 !important;
			color: #fff !important;
		}

	</style>
</head>
<body>
<div class="container">
	<input type="hidden" id="leftId" class="layui-input">
	<div class="wrapper">
		<div class="wrap_left">
			<h2 style="text-align: center;line-height: 35px;">成本分析</h2>
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
			</div>
			<div style="position: relative">
				<div class="table_box" style="display: none">
					<div class="layui-tab layui-tab-brief" lay-filter="docDemoTabBrief">
						<ul class="layui-tab-title">
							<li class="layui-this">成本分析汇总</li>
							<li>目标成本变更</li>
						</ul>
						<div class="layui-tab-content">
							<div class="layui-tab-item layui-show">
								<table id="tableObj" lay-filter="parse-table-demo" class="layui-table"  style="display: none" >
									<thead>
									<tr>
<%--										<th id="th1" lay-data="{field:'wbsOne',minWidth:100,align:'center'}" colspan="3">合同收入</th>--%>
										<th id="th1" lay-data="{field:'yvsuan',minWidth:100,align:'center'}" colspan="3">预算目标</th>
										<th lay-data="{field:'youhua',minWidth:100,align:'center'}" colspan="2">优化目标</th>
										<th lay-data="{field:'guanli',minWidth:100,align:'center'}" colspan="3">管理目标</th>
										<th lay-data="{field:'taxMoney',minWidth:100}" rowspan="2">实际成本</th>
										<th lay-data="{field:'manageTarAmount4',minWidth:120}" rowspan="2">管理目标余额</th>
									</tr>
									<tr>
<%--										<th lay-data="{field:'contract1',minWidth:100,align:'center'}">初始值</th>--%>
<%--										<th lay-data="{field:'contract2',minWidth:100,align:'center'}">变更值</th>--%>
<%--										<th lay-data="{field:'contract3',minWidth:100,align:'center'}">变更后值</th>--%>
										<th lay-data="{field:'incomeTarAmount1',minWidth:100,align:'center'}">初始值</th>
										<th lay-data="{field:'incomeTarAmount2',minWidth:100,align:'center'}">变更值</th>
										<th lay-data="{field:'incomeTarAmount3',minWidth:100,align:'center'}">变更后值</th>
										<th lay-data="{field:'optTarAmount1',minWidth:100,align:'center'}">初始值</th>
										<th lay-data="{field:'optTarAmount2',minWidth:100,align:'center'}">变更后值</th>
										<th lay-data="{field:'manageTarAmount1',minWidth:100,align:'center'}">初始值</th>
										<th lay-data="{field:'manageTarAmount2',minWidth:100,align:'center'}">变更值</th>
										<th lay-data="{field:'manageTarAmount3',minWidth:100,align:'center'}">变更后值</th>
									</tr>
									</thead>
								</table>
							</div>
							<div class="layui-tab-item">
								<p style="font-size: 20px;">变更总额合计:<span id="sum"></span></p>
								<table id="tableDemoIn" lay-filter="tableDemoIn"></table>
								<div id="downBox">
									<table id="tableDemoInDown" lay-filter="tableDemoInDown"></table>
								</div>
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

<script type="text/html" id="toolbarDemoIn">
<%--	<div class="layui-btn-container" style="height: 30px;">--%>
		<div style="height: 30px;color: #666">
			<span>全部成本</span>
		</div>
		<div style="position:absolute;top: 8px;left:80px;">
			<input type="checkbox" name="isAll" id="isAll" lay-filter="test" lay-skin="switch" lay-text="是|否">
		</div>

		<%--        <button class="layui-btn layui-btn-sm" lay-event="add">加行</button>--%>
		<%--        <button class="layui-btn layui-btn-sm" lay-event="choice">模板选择</button>--%>
<%--	</div>--%>
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

		var dictionaryObj = {
			OPT_TAR_TYPE:{}
		}
		var dictionaryStr = 'OPT_TAR_TYPE';
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


			$('.wrap_right').css('margin-left',0)
			tableShow(projectId)
		}


		laydate.render({
			elem: '#createYear'
			, trigger: 'click'//呼出事件改成click
			, type: 'year'
			// , format: 'yyyy-MM-dd'
		});

		form.on('switch(test)', function(data){
			console.log(data.elem.checked); //开关是否开启，true或者false
			if(data.elem.checked){
				tableShow($('#leftId').attr('projId'),true)
			}else {
				tableShow($('#leftId').attr('projId'),false)
			}
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
				$('#h2_title').text(currentData.projName+'成本情况综合分析')
				$('.no_data').hide();
				$('.table_box').show();
				tableShow(currentData.projId)
			} else {
				$('.table_box').hide();
				$('.no_data').show();
				$('#h2_title').text('')
			}
		});

		//type : true 查询
		function tableShow(projId,flag,type) {
			var loadIndex = layer.load();


			$('#downBox').hide()

			var params = ''
			if($('#createYear').val()){
				params += '&year='+ $('#createYear').val()
			}
			if($('#createMonth').val()){
				params += '&month='+ $('#createMonth').val()
			}

			var wbsHtm;
			var rbsHtm;
			var cbsHtm;
			$(".th").remove();
			$.ajax({
				url:'/projectCostAnalysis/getWbsCbsLayerNum?projId='+projId+params,
				datatype:'json',
				type:'get',
				async:false,
				success:function(res){
					var wbsNum=res.obj.wbsLayerNum;
					var cbsNum=res.obj.cbsLayerNum;
					var rbsNum=res.obj.rbsLayerNum;
					wbsHtm="";
					rbsHtm="";
					cbsHtm="";
					var htm = "minWidth:100";
					//WBS
					if(wbsNum==0||wbsNum=="0"){

					}else if(wbsNum==1||wbsNum=="1"){
						wbsHtm+='<th class="th" lay-data="{field:\'wbs'+wbsNum+'\',align:\'center\','+htm+'}" rowspan="2">WBS末级</th>'

					}else if(wbsNum==2||wbsNum=="2"){
						for(var i=0;i<wbsNum;i++){
							if(i==1){
								break;
							}
							wbsHtm+='<th class="th" lay-data="{field:\'wbs'+(i+1)+'\',align:\'center\','+htm+'}" rowspan="2">WBS'+getNum(i+1)+'级</th>'
						}
						wbsHtm+='<th class="th" lay-data="{field:\'wbs'+wbsNum+'\',align:\'center\','+htm+'}" rowspan="2">WBS末级</th>'
					}else if(wbsNum>2){
						for(var i=0;i<wbsNum;i++){
							if(i>1){
								break;
							}
							wbsHtm+='<th class="th" lay-data="{field:\'wbs'+(i+1)+'\',align:\'center\','+htm+'}" rowspan="2">WBS'+getNum(i+1)+'级</th>'
						}
						wbsHtm+='<th class="th" lay-data="{field:\'wbs'+wbsNum+'\',align:\'center\','+htm+'}" rowspan="2">WBS末级</th>'
					}
					//RBS
					if(rbsNum==0||rbsNum=="0"){

					}else if(rbsNum==1||rbsNum=="1"){
						rbsHtm+='<th class="th" lay-data="{field:\'rbs'+rbsNum+'\',align:\'center\','+htm+'}" rowspan="2">RBS末级</th>'

					}else if(rbsNum==2||rbsNum=="2"){
						for(var i=0;i<rbsNum;i++){
							if(i==1){
								break;
							}
							rbsHtm+='<th class="th" lay-data="{field:\'rbs'+(i+1)+'\',align:\'center\','+htm+'}" rowspan="2">RBS'+getNum(i+1)+'级</th>'
						}
						rbsHtm+='<th class="th" lay-data="{field:\'rbs'+rbsNum+'\',align:\'center\','+htm+'}" rowspan="2">RBS末级</th>'
					}else if(rbsNum>2){
						for(var i=0;i<rbsNum;i++){
							if(i>1){
								break;
							}
							rbsHtm+='<th class="th" lay-data="{field:\'rbs'+(i+1)+'\',align:\'center\','+htm+'}" rowspan="2">RBS'+getNum(i+1)+'级</th>'
						}
						rbsHtm+='<th class="th" lay-data="{field:\'rbs'+rbsNum+'\',align:\'center\','+htm+'}" rowspan="2">RBS末级</th>'
					}


					//CBS
					if(cbsNum==0||cbsNum=="0"){

					}else if(cbsNum==1||cbsNum=="1"){
						cbsHtm+='<th class="th" lay-data="{field:\'cbs'+cbsNum+'\',align:\'center\','+htm+'}" rowspan="2">CBS末级</th>'

					}else if(cbsNum==2||cbsNum=="2"){
						for(var i=0;i<cbsNum;i++){
							if(i==1){
								break;
							}
							cbsHtm+='<th class="th" lay-data="{field:\'cbs'+(i+1)+'\',align:\'center\','+htm+'}" rowspan="2">CBS'+getNum(i+1)+'级</th>'
						}
						cbsHtm+='<th class="th" lay-data="{field:\'cbs'+cbsNum+'\',align:\'center\','+htm+'}" rowspan="2">CBS末级</th>'
					}else if(cbsNum>2){
						for(var i=0;i<cbsNum;i++){
							if(i>1){
								break;
							}
							cbsHtm+='<th class="th" lay-data="{field:\'cbs'+(i+1)+'\',align:\'center\','+htm+'}" rowspan="2">CBS'+getNum(i+1)+'级</th>'
						}
						cbsHtm+='<th class="th" lay-data="{field:\'cbs'+cbsNum+'\',align:\'center\','+htm+'}" rowspan="2">CBS末级</th>'
					}
					$("#th1").before(wbsHtm,rbsHtm,cbsHtm);
					var yearPar = "";
					if($('#createYear').val()){
						yearPar = '&year='+ $('#createYear').val()
					}
					var monthPar = "";
					if($('#createMonth').val()){
						monthPar += '&month='+ $('#createMonth').val()
					}
					var realOutStr = ''
					if(!flag){
						realOutStr = '&realOut=realOut'
					}
					table.init('parse-table-demo', { //转化静态表格
						url:'/projectCostAnalysis/getCbsWbsByProj?projId='+projId+yearPar+monthPar+realOutStr,
						toolbar: '#toolbarDemoIn', //开启头部工具栏，并为其绑定左侧模板
						defaultToolbar: ['filter'],
						height: 'full-200',
						done:function(res,curr,count){
							var objData = res.obj
							if(showProj){
								$('#h2_title').text((objData&&objData.projectName||'')+'成本情况综合分析')
							}
							if(flag){
								$('#isAll').prop('checked',true)
								form.render()
							}

							if(!type){
								$('#createYear').val(objData&&objData.year)
								$('[name="createMonth"]').val(objData&&objData.month)
								$('[name="createWeek"]').val( res&&res.obj&&res.obj.year + '-W' + getWeek(new String(res&&res.obj&&res.obj.year) +'-'+ new String(res&&res.obj&&res.obj.month)+'-'+new String(res&&res.obj&&res.obj.day)))
							}

							 form.render();

							// layuiRowspan('sum',1);
							// $(".layui-table-tool").css("width",$(".layui-table-view").find("table").width())

							if($('#createYear').val()){
								params = '&year='+ $('#createYear').val()
							}
							if($('#createMonth').val()){
								params += '&month='+ $('#createMonth').val()
							}

							if(week){
								params += '&type=week'
								if($('[name="createWeek"]').val()){
									var arr = ($('[name="createWeek"]').val()).split('-W')
									params += '&beginDate='+getDateOfISOWeek(arr[1],arr[0]).ISOweekStart
									params += '&endDate='+getDateOfISOWeek(arr[1],arr[0]).ISOweekEnd
								}
							}

							$.get('/targetCost/select?delFlag=0&projectId='+projId+params, function (res) {
								$('#sum').text(res.obj||'')
								table.render({
									elem: '#tableDemoIn',
									// url: '/targetCost/select?delFlag=0&projectId='+projId+params,
									data:res.data||[],
									cols: [[
										{field: 'costChaName', title: '成本目标调整名称',minWidth:120,sort: true, hide: false},
										{field: 'optTarType', title: '优化类型',minWidth:100, sort: false, hide: false, templet: function (d) {
												var str = ''
												if(dictionaryObj['OPT_TAR_TYPE']){
													str = '<span>'+dictionaryObj['OPT_TAR_TYPE']['object'][d.optTarType]+'</span>';
												}
												return str
											}},
										{field: 'optChaTotal', title: '优化变更总额',minWidth:100, sort: false, hide: false},
										{field: 'chaContent', title: '变更内容',minWidth: 220, sort: true, hide: false},
										{field: 'createTime', title: '填报时间',minWidth: 220, sort: true, hide: false}
									]],
									height: res.data&&res.data.length?'full-370':false,
									limit:10000
									// page: true
								});
								layer.close(loadIndex);
								}
							);



						}
					});


				}
			})

		}

		//监听行单击事件
		table.on('row(tableDemoIn)', function (obj) {
			// console.log(obj.data) //得到当前行数据
			var data = obj.data
			$('#downBox').show()
			obj.tr.addClass('selectTr').siblings('tr').removeClass('selectTr')
			tableShowDown(data.detailsList)
		});

		//立项明细计划明细表
		function tableShowDown(data) {
			table.render({
				elem: '#tableDemoInDown',
				data: data||[],
				cellMinWidth:150,
				height: data&&data.length>5?'full-500':false,
				cols: [[
					{type: 'numbers', title: '序号'},
					{field: 'wbsName', title: 'WBS',minWidth:230},
					{field: 'rbsName', title: 'RBS',minWidth:200,templet: function (d) {
						return d.rbsLongName || d.rbsName  ||''
						}},
					{field: 'cbsName', title: 'CBS',minWidth:200},
					{field: 'manageTarNum', title: '管理目标数量',minWidth:120,},
					{field: 'manageTarPrice', title: '管理目标单价',minWidth:120},
					{field: 'manageTarAmount', title: '管理目标金额',minWidth:120},
					{field: 'optTarNum', title: '优化目标数量',minWidth:120},
					{field: 'optTarPrice', title: '优化目标单价',minWidth:120},
					{field: 'optTarAmount', title: '优化目标金额',minWidth:120},
					{field: 'adjManTarNum', title: '调整后管理目标数量',minWidth:160},
					{field: 'adjManTarPrice', title: '调整后管理目标单价',minWidth:160},
					{field: 'adjManTarAmount', title: '调整后管理目标金额',minWidth:160}
				]],
				limit:10000
			});
		}


		//点击查询
		$('.searchData').click(function () {
			tableShow($('#leftId').attr('projId'),$('#isAll').prop('checked'),true)
		});

	});

	function getNum(i){
		switch(i){
			case 1:
				return "一"
				break;
			case 2:
				return "二"
				break;
			case 3:
				return "三"
				break;
			case 4:
				return "四"
				break;
			case 5:
				return "五"
				break;
			case 6:
				return "六"
				break;
			case 7:
				return "七"
				break;
			case 8:
				return "八"
				break;
			case 9:
				return "九"
				break;
			case 10:
				return "十"
				break;
		}

	}

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
