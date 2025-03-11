<%--
  Created by IntelliJ IDEA.
  User: 王秋彤
  Date: 2021/9/13
  Time: 9:44
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
	<title>成本分析</title>

	<meta charset="UTF-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
	<link rel="stylesheet" href="/lib/layui/layui/css/layui.css?20210319.1">
	<link rel="stylesheet" href="/lib/layui/layui/css/eleTree.css">

	<script type="text/javascript" src="/js/xoajq/xoajq1.js"></script>
	<script type="text/javascript" src="/lib/layui/layui/layui.all_v2.5.js"></script>
	<script type="text/javascript" src="/js/base/base.js"></script>
	<script type="text/javascript" src="/lib/layui/layui/global.js?20210527.1"></script>
	<script type="text/javascript" src="/lib/jQuery-File-Upload-master/jquery-ui.js"></script>
	<script type="text/javascript" src="/lib/jQuery-File-Upload-master/jquery.iframe-transport.js"></script>
	<script type="text/javascript" src="/lib/jQuery-File-Upload-master/jquery.fileupload.js"></script>
	<%--        <script type="text/javascript" src="/js/common/fileupload.js"></script>--%>
	<script type="text/javascript" src="/js/planbudget/common.js?20210630.1"></script>
	<script type="text/javascript" src="/js/planother/planotherUtil.js?222021080915083"></script>

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

		.wrap_right {
			position: relative;
			height: 100%;
			/*margin-left: 230px;*/
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

		.field_required {
			color: red;
			font-size: 16px;
		}

		.layer_wrap .layui_col {
			width: 20% !important;
			padding: 0 5px;
		}

		/* region 上传附件样式 */
		.file_upload_box {
			position: relative;
			height: 22px;
			overflow: hidden;
		}
		.open_file {
			float: left;
			position:relative;
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
		.openFile input[type=file]{
			position: absolute;
			top: 0;
			right: 0;
			bottom: 0;
			left: 0;
			width: 100%;
			height: 18px;
			z-index: 99;
			opacity: 0;
		}
		.mtl_info td[data-field="attachName"] .layui-table-cell{
			height: auto;
			overflow:visible;
			text-overflow:inherit;
			white-space:normal;
			word-break: break-word;
		}

		.refresh_no_btn {
			display: none;
			margin-left: 8%;
			color: #00c4ff !important;
			font-weight: 600;
			cursor: pointer;
		}

		.layui-col-xs6{
			width: 20%;
		}

		/*.eleTree-node-content {*/
		/*	overflow: hidden;*/
		/*	word-break: break-all;*/
		/*	white-space: nowrap;*/
		/*	text-overflow: ellipsis;*/
		/*	text-align: left;*/
		/*}*/

		/*.eleTree-node-content:hover, .eleTree-node-content.eleTree-node-content-active {*/
		/*	background-color: #888;*/
		/*}*/

		._one1 .layui-table-body tr:nth-of-type(2n){
			background-color: #f2f2f2;
		}
		._one1 .layui-table-body [data-field="projectName"]{
			background-color:white;
		}
	</style>
</head>
<body>
<div class="container">
	<input type="hidden" id="leftId">
	<div class="wrapper">
		<div class="wrap_right">
			<div class="query_module layui-form layui-row" style="position: relative">
				<div class="layui-col-xs2" style="text-align: center;position:relative;">
					<input type="text" id="ele_Tree" name="ele_Tree" readonly placeholder="请选择项目" autocomplete="off" class="layui-input" style="height: 38px;margin-left: 6px;">
					<div class="eleTree ele2" lay-filter="data2" style="text-align: left;display:none;position:absolute;border: 1px solid #d2d2d2;overflow-y: auto;background-color: #fff;border-radius: 2px;box-shadow: 0 2px 4px rgba(0,0,0,.12);box-sizing: border-box;overflow:hidden;z-index: 999;top:38px;left:5px;width: 100%;"></div>
				</div>
				<div class="layui-col-xs1" style="margin-left: 15px;">
					<input type="text" name="beginDate"  placeholder="开始时间" autocomplete="off" class="layui-input">
				</div>
				<div class="layui-col-xs1" style="margin-left: 15px;">
					<input type="text" name="endDate"  placeholder="结束时间"  autocomplete="off" class="layui-input">
				</div>
				<div class="layui-col-xs2" style="margin-top: 3px;text-align: center">
					<button type="button" class="layui-btn layui-btn-sm" id="searchBtn">查询</button>
					<%--					<button type="button" class="layui-btn layui-btn-sm" id="advancedQuery">高级查询</button>--%>
				</div>
				<div style="position: absolute;top: -1px;right: 10px;height: 35px;line-height: 35px;">
					<i class="layui-icon layui-icon-read icon_img" style="margin-right: 15px" text="知识库"></i>
					<i class="layui-icon layui-icon-survey icon_img" text="帮助"></i>
				</div>
			</div>
			<div class="table_box" style="position: relative">
				<div class="_one1">
					<table id="tableDemo" lay-filter="tableDemo"></table>
				</div>
				<div class="_one2">
					<table id="tableDemo2" lay-filter="tableDemo2"></table>
				</div>
				<div class="layui-tab layui-tab-brief" lay-filter="docDemoTabBrief">
					<ul class="layui-tab-title">
						<li class="layui-this">本月经营情况</li>
						<li>经营汇总情况</li>
					</ul>
					<div class="layui-tab-content">
						<div class="layui-tab-item layui-show _one3">
							<table id="tableDemo3" lay-filter="tableDemo3"></table>
						</div>
					</div>
				</div>
				<div class="layui-tab layui-tab-brief" lay-filter="docDemoTabBrief2">
					<ul class="layui-tab-title">
						<li class="layui-this">本月变更情况</li>
						<li>变更汇总情况</li>
					</ul>
					<div class="layui-tab-content">
						<div class="layui-tab-item layui-show _one4">
							<table id="tableDemo4" lay-filter="tableDemo4"></table>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>

<script type="text/html" id="toolbarDemo">
	<div>
		<h2>本月成本变化</h2>
	</div>
</script>

<script type="text/html" id="toolBar">
	<a class="layui-btn layui-btn layui-btn-xs" lay-event="detail">查看详情</a>
</script>


<script>
	var securityInfoDate = null


	var tipIndex = null;
	$('.icon_img').hover(function () {
		var tip = $(this).attr('text');
		tipIndex = layer.tips(tip, this);
	}, function () {
		layer.close(tipIndex);
	});

	// 获取数据字典数据
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

	$('[name="beginDate"]').val(getMonthBeforeFormatAndDay(0,'-',1))
	$('[name="endDate"]').val(getMonthBeforeFormatAndDay(1,'-',1))


	var index1 = 0
	var index2 = 0
	layui.use(['form', 'laydate', 'table', 'element', 'eleTree'], function () {
		var form = layui.form,
				laydate = layui.laydate,
				table = layui.table,
				element = layui.element,
				eleTree = layui.eleTree;

		laydate.render({
			elem: '[name="beginDate"]'
			, trigger: 'click'
			, format: 'yyyy-MM-dd'
			// , format: 'yyyy-MM-dd HH:mm:ss'
			// ,value: new Date()
		});

		laydate.render({
			elem: '[name="endDate"]'
			, trigger: 'click'
			, format: 'yyyy-MM-dd'
			// , format: 'yyyy-MM-dd HH:mm:ss'
			//,value: new Date()
		});

		element.on('tab(docDemoTabBrief)', function(data){
			index1 = data.index
			console.log(data.index); //得到当前Tab的所在下标
			tableShow3(data.index)
		});

		element.on('tab(docDemoTabBrief2)', function(data){
			index2 = data.index
			console.log(data.index); //得到当前Tab的所在下标
			tableShow4(data.index)
		});
		var el;
		$("[name='ele_Tree']").on("click",function (e) {
			//debugger
			e.stopPropagation();
			if(!el){
				var loadingIndex = layer.load();
				$.get('/plbOrg/treeListOrg', function (res) {
					layer.close(loadingIndex);
					if (res.flag) {
						eleTree.render({
							elem: '.ele2',
							data: res.data,
							highlightCurrent: true,
							showLine: true,
							defaultExpandAll: false,
							expandOnClickNode: false,
							showCheckbox: false,
							checked: false,
							request: {
								name: 'name',
								children: "plbProjList",
							}
						});
						// tableShow('')
					}
				});
			}
			$(".ele2").slideDown();
		})
		$(document).on("click",function() {
			$(".ele2").slideUp();
		})

		//节点点击事件
		eleTree.on("nodeClick(data2)",function(d) {
			var currentData = d.data.currentData;
			if (currentData.projId) {
				$('#ele_Tree').val(currentData.projName).attr('projId',currentData.projId)
			} else {
				$('#ele_Tree').val('').attr('projId','')
			}
		})

		tableShow()
		tableShow2()
		tableShow3(0)
		tableShow4(0)

		// 渲染表格
		function tableShow() {
			var params = getSearchObj()
			table.render({
				elem: '#tableDemo',
				url: '/costAnalysisController/budgetAnalysis?delFlag=0',
				cols:  [[ //表头
					// {type: 'numbers', title: '序号', minWidth: 100}
					 {field:'projectName',title:'项目名称',minWidth: 120}
					, {field: 'd1', title: '初始收入目标', minWidth: 120}
					, {field: 'd2', title: '单位收入',minWidth: 120}
					, {field: 'd3', title: '初始优化目标',minWidth: 120}
					, {field: 'd4', title: '单位优化',minWidth: 120}
					, {field: 'd5', title: '初始管理目标',minWidth: 120}
					, {field: 'd6', title: '单位成本',minWidth: 120}
				]],
				// defaultToolbar: ['filter'],
				// height: 'full-100',
				height: ($(document).height()-150)/2,
				// limit:10,
				// page: true,
				where: params,
				done: function (res) {
					layuiRowspan('._one1','projectName',1);
				}
			});
		}

		function tableShow2() {
			var params = getSearchObj()
			table.render({
				elem: '#tableDemo2',
				url: '/costAnalysisController/businessAnalysis?delFlag=0',
				cols:  [[ //表头
					// {type: 'numbers', title: '序号', minWidth: 100}
					{field:'projectName',title:'项目名称',minWidth: 120}
					, {field: 'd1', title: '本月经营收入', minWidth: 120}
					, {field: 'd2', title: '单位收入',minWidth: 120}
					, {field: 'd3', title: '本月经营成本',minWidth: 120}
					, {field: 'd4', title: '单位成本',minWidth: 120}
					, {field: 'd5', title: '本月变更成本',minWidth: 120}
					, {field: 'd6', title: '单位成本',minWidth: 120}
				]],
				defaultToolbar: [''],
				toolbar: '#toolbarDemo',
				// height: 'full-100',
				height: '300',
				// limit:10,
				// page: true,
				where: params,
				done: function (res) {
					layuiRowspan('._one2','projectName',1);
				}
			});
		}

		function tableShow3(_index) {
			var params ={};
			if(_index==1){
				params = getSearchObj(1)
			}else{
				params = getSearchObj(0)
			}
			table.render({
				elem: '#tableDemo3',
				url: '/businessAnalysisController/businessAnalysis?delFlag=0',
				cols:  [[ //表头
					{type: 'numbers', title: '序号', minWidth: 100}
					, {field:'projectName',title:'项目名称',minWidth: 120}
					, {field: 'projectDate', title: '立项日期', minWidth: 120, sort: true, hide: false}
					, {field: 'manageProjName', title: '经营立项名称', minWidth: 120}
					, {field: 'changeIncome', title: '预计变更收入',minWidth: 100}
					, {field: 'implementationCost', title: '实施成本',minWidth: 120}
					, {field: 'estimatedProfit', title: '预计利润',minWidth: 120}
					, {field: 'incomePrice', title: '预计利润率',minWidth: 120}
					, {field: 'tarckDetailsDate', title: '进展日期',minWidth: 120}
					, {field: 'ourProgress', title: '我方进展',minWidth: 120}
					, {field: 'constructionUnitPro', title: '建设单位进展',minWidth: 120}
					, {field: 'firstConfirmInf', title: '甲方最终确认金额',minWidth: 160}
					, {field: 'firstConfirmInfbig2', title: '最终利润率',minWidth: 120}
				]],
				// defaultToolbar: [''],
				// toolbar: '#toolbarDemo',
				// height: 'full-100',
				height: ($(document).height()-150)/2,
				// limit:10,
				// page: true,
				where: params,
				done: function (res) {
					layuiRowspan('._one3','projectName',1);
				}
			});
		}

		function tableShow4(_index) {
			var params ={};
			if(_index==1){
				params = getSearchObj(1)
			}else{
				params = getSearchObj(0)
			}
			table.render({
				elem: '#tableDemo4',
				url: '/costAnalysisController/targetCostAnalysis?delFlag=0',
				cols:  [[ //表头
					{type: 'numbers', title: '序号', minWidth: 100},
					{field:'projectName',title:'项目名称',minWidth: 120},
					{field: 'costChaName', title: '成本目标调整名称',minWidth:120},
					{field: 'optTarType', title: '优化类型',minWidth:100,templet: function (d) {
							if(!d.optTarType) return ''
							var str = ''
							if(dictionaryObj['OPT_TAR_TYPE']){
								str = '<span>'+dictionaryObj['OPT_TAR_TYPE']['object'][d.optTarType]+'</span>';
							}
							return str
						}},
					{field: 'optChaTotal', title: '优化变更总额',minWidth:100},
					{field: 'chaContent', title: '变更内容',minWidth: 220},
					{field: 'createTime', title: '填报日期',minWidth: 120, sort: true, hide: false}
				]],
				// defaultToolbar: [''],
				// toolbar: '#toolbarDemo',
				// height: 'full-100',
				height: ($(document).height()-150)/2,
				// limit:10,
				// page: true,
				where: params,
				done: function (res) {
					layuiRowspan('._one4','projectName',1);
				}
			});
		}

		// 查询
		$('#searchBtn').on('click', function(){
			tableShow()
			tableShow2()
			tableShow3(index1)
			tableShow4(index2)
		});

		/**
		 * 获取查询条件
		 * @returns {{planNo: (*), planName: (*)}}
		 */
		function getSearchObj(flag) {
			var searchObj = {}
			if(flag===0){
				if($('.query_module [name="ele_Tree"]').attr('projId')){
					searchObj.projectId=$('.query_module [name="ele_Tree"]').attr('projId')
				}
				if($('.query_module [name="beginDate"]').val()){
					searchObj.beginDate=$('.query_module [name="beginDate"]').val()
				}
				if($('.query_module [name="endDate"]').val()){
					searchObj.endDate=$('.query_module [name="endDate"]').val()
				}
			}else if(flag===1){
				if($('.query_module [name="ele_Tree"]').attr('projId')){
					searchObj.projectId=$('.query_module [name="ele_Tree"]').attr('projId')
				}
			}else{
				if($('.query_module [name="ele_Tree"]').attr('projId')){
					searchObj.projectId=$('.query_module [name="ele_Tree"]').attr('projId')
				}
				if($('.query_module [name="beginDate"]').val()){
					searchObj.beginDate=$('.query_module [name="beginDate"]').val()
				}
				if($('.query_module [name="endDate"]').val()){
					searchObj.endDate=$('.query_module [name="endDate"]').val()
				}
			}
			return searchObj
		}
	});

	var execRowspan = function(dom,fieldName,index,flag){
		// 1为不冻结的情况，左侧列为冻结的情况
		let fixedNode = index=="1"?$(dom+" .layui-table-body")[index - 1]:(index=="3"?$(dom+" .layui-table-fixed-r"):$(dom+" .layui-table-fixed-l"));
		// 左侧导航栏不冻结的情况
		let child = $(fixedNode).find("td");
		let childFilterArr = [];
		// 获取data-field属性为fieldName的td
		for(let i = 0; i < child.length; i++){
			if(child[i].getAttribute("data-field") == fieldName){
				childFilterArr.push(child[i]);
			}
		}
		// 获取td的个数和种类
		let childFilterTextObj = {};
		for(let i = 0; i < childFilterArr.length; i++){
			let childText = flag?childFilterArr[i].innerHTML:childFilterArr[i].textContent;
			if(childFilterTextObj[childText] == undefined){
				childFilterTextObj[childText] = 1;
			}else{
				let num = childFilterTextObj[childText];
				childFilterTextObj[childText] = num*1 + 1;
			}
		}
		let canRowspan = true;
		let maxNum;//以前列单元格为基础获取的最大合并数
		let finalNextIndex;//获取其下第一个不合并单元格的index
		let finalNextKey;//获取其下第一个不合并单元格的值
		for(let i = 0; i < childFilterArr.length; i++){
			(maxNum>9000||!maxNum)&&(maxNum = $(childFilterArr[i]).prev().attr("rowspan")&&fieldName!="8"?$(childFilterArr[i]).prev().attr("rowspan"):9999);
			let key = flag?childFilterArr[i].innerHTML:childFilterArr[i].textContent;//获取下一个单元格的值
			let nextIndex = i+1;
			let tdNum = childFilterTextObj[key];
			let curNum = maxNum<tdNum?maxNum:tdNum;
			if(canRowspan){
				for(let j =1;j<=curNum&&(i+j<childFilterArr.length);){//循环获取最终合并数及finalNext的index和key
					finalNextKey = flag?childFilterArr[i+j].innerHTML:childFilterArr[i+j].textContent;
					finalNextIndex = i+j;
					if((key!=finalNextKey&&curNum>1)||maxNum == j){
						canRowspan = true;
						curNum = j;
						break;
					}
					j++;
					if((i+j)==childFilterArr.length){
						finalNextKey=undefined;
						finalNextIndex=i+j;
						break;
					}
				}
				childFilterArr[i].setAttribute("rowspan",curNum);
				if($(childFilterArr[i]).find("div.rowspan").length>0){//设置td内的div.rowspan高度适应合并后的高度
					$(childFilterArr[i]).find("div.rowspan").parent("div.layui-table-cell").addClass("rowspanParent");
					$(childFilterArr[i]).find("div.layui-table-cell")[0].style.height= curNum*38-10 +"px";
				}
				canRowspan = false;
			}else{
				childFilterArr[i].style.display = "none";
			}
			if(--childFilterTextObj[key]==0|--maxNum==0|--curNum==0|(finalNextKey!=undefined&&nextIndex==finalNextIndex)){//||(finalNextKey!=undefined&&key!=finalNextKey)
				canRowspan = true;
			}
		}
	}
	//合并数据表格行
	var layuiRowspan = function(fieldNameTmp,index,flag){
		let fieldName = [];
		if(typeof fieldNameTmp == "string"){
			fieldName.push(fieldNameTmp);
		}else{
			fieldName = fieldName.concat(fieldNameTmp);
		}
		for(let i = 0;i<fieldName.length;i++){
			execRowspan(fieldName[i],index,flag);
		}
	}

	//求自然月日期
	function getMonthBeforeFormatAndDay(num, format, day) {
		var date = new Date();
		date.setMonth(date.getMonth() + (num*1), 1);
		//读取日期自动会减一，所以要加一
		var mo = date.getMonth() + 1;
		//小月
		if (mo == 4 || mo == 6 || mo == 9 || mo == 11) {
			if (day > 30) {
				day = 30
			}
		}
		//2月
		else if (mo == 2) {
			if (isLeapYear(date.getFullYear())) {
				if (day > 29) {
					day = 29
				} else {
					day = 28
				}
			}
			if (day > 28) {
				day = 28
			}
		}
		//大月
		else {
			if (day > 31) {
				day = 31
			}
		}

		if(day>0&&day<10){
			day = '0'+day
		}

		retureValue = date.format('yyyy' + format + 'MM' + format + day);

		return retureValue;
	}

	//JS判断闰年代码
	function isLeapYear(Year) {
		if (((Year % 4) == 0) && ((Year % 100) != 0) || ((Year % 400) == 0)) {
			return (true);
		} else { return (false); }
	}

	//日期格式化
	Date.prototype.format = function (format) {
		var o = {
			"M+": this.getMonth() + 1, // month
			"d+": this.getDate(), // day
			"h+": this.getHours(), // hour
			"m+": this.getMinutes(), // minute
			"s+": this.getSeconds(), // second
			"q+": Math.floor((this.getMonth() + 3) / 3), // quarter
			"S": this.getMilliseconds()
			// millisecond
		}

		if (/(y+)/.test(format))
			format = format.replace(RegExp.$1, (this.getFullYear() + "").substr(4 - RegExp.$1.length));
		for (var k in o)
			if (new RegExp("(" + k + ")").test(format))
				format = format.replace(RegExp.$1, RegExp.$1.length == 1 ? o[k] : ("00" + o[k]).substr(("" + o[k]).length));
		return format;
	}

</script>
</body>
</html>
