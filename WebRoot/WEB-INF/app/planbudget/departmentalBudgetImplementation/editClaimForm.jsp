<%--
  Created by IntelliJ IDEA.
  User: 戎成路
  Date: 2021/4/23
  Time: 15:53
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
<html lang="zh-cn">
<head>
	<meta charset="UTF-8">
	<title>新增-编辑报销单</title>
	<meta name="renderer" content="ie-stand">
	<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
	<link rel="stylesheet" href="/lib/layui/layui/css/layui.css?20210319.1">
	<link rel="stylesheet" href="/lib/layui/layui/css/eleTree.css">

<%--	<script type="text/javascript" src="/js/xoajq/xoajq1.js"></script>--%>
	<script type="text/javascript" src="/js/xoajq/xoajq3.js"></script>
<%--	<script type="text/javascript" src="/js/jquery/jquery-migrate-3.4.0.js"></script>--%>
	<script type="text/javascript" src="/lib/layui/layui/layui.all_v2.5.js"></script>
	<script type="text/javascript" src="/js/base/base.js"></script>
	<script type="text/javascript" src="/lib/layui/layui/global.js?20210604.1"></script>
	<script type="text/javascript" src="/lib/jQuery-File-Upload-master/jquery-ui.js"></script>
	<script type="text/javascript" src="/lib/jQuery-File-Upload-master/jquery.iframe-transport.js"></script>
	<script type="text/javascript" src="/lib/jQuery-File-Upload-master/jquery.fileupload.js"></script>
	<script type="text/javascript" src="/js/common/fileupload.js"></script>
	<script type="text/javascript" src="/js/planbudget/common.js?20210817.1"></script>

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
			box-sizing: border-box;
		}

		.wrapper {
			position: absolute;
			top: 0;
			left: 0;
			bottom: 60px;
			width: 100%;
			padding: 8px;
			box-sizing: border-box;
			overflow: auto;
		}

		.footer {
			position: absolute;
			left: 0;
			bottom: 0;
			width: 100%;
			height: 60px;
			line-height: 60px;
			text-align: center;
			background-color: #fff;
		}

		.wrap_left {
			position: relative;
			float: left;
			width: 230px;
			height: 100%;
			padding-right: 10px;
			box-sizing: border-box;
		}

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

		.del_trip_btn {
			position: absolute;
			top: 10px;
			right: 20px;
			cursor: pointer;
			z-index: 1;
		}

		.refresh_no_btn {
			display: none;
			margin-left: 8%;
			color: #00c4ff !important;
			font-weight: 600;
			cursor: pointer;
		}

		.layui-select-disabled .layui-disabled {
			color: #222 !important;
		}

		.deptDel {
			position: absolute;
			top: 10px;
			right: 4px;
			color: #1E9FFF;
			cursor: pointer;
		}

		.deptDel:hover {
			color: #ff0000;
		}

		.con_left {
			float: left;
			height: 100%;
		}

		.con_right {
			float: left;
			height: 100%;
			padding-left: 10px;
			box-sizing: border-box;
		}

		.invoices_module {
			position: relative;
			padding-right: 20px;
		}

		.invoices_box {
			overflow: hidden;
			word-break: break-all;
			white-space: nowrap;
			text-overflow: ellipsis;
		}

		.choose_invoices {
			position: absolute;
			top: 0;
			right: 0;
			color: #00a1d6 !important;
			cursor: pointer;
		}

		.layui-layer-tips {
			width: 150px !important;
		}

		.tips_module {
			position: relative;
			overflow: hidden;
		}

		.tips_content {
			max-height: 300px;
			padding-right: 20px;
			margin-right: -20px;
			overflow-y: auto;
		}

		.tips_p {
			overflow: hidden;
			font-size: 14px;
			word-break: break-all;
			white-space: nowrap;
			text-overflow: ellipsis;
			cursor: pointer;
		}

		.tips_p:hover {
			color: #e4ff00;
		}

		.invoices_box:hover {
			color: #0A5FA2;
			cursor: pointer;
		}

	</style>
</head>
<body>
<div class="container">
	<object id="WebBrowser" classid="CLSID:8856F961-340A-11D0-A96B-00C04FD705A2" height="0" width="0" viewastext></object>
	<input type="hidden" id="leftId" value="">
	<input type="hidden" id="03" value="">
	<input type="hidden" id="04" value="">
	<div class="wrapper">

		<div class="layui-collapse">
			<form class="layui-form" id="baseForm" lay-filter="baseForm">
				<div class="layui-colla-item">
					<h2 class="layui-colla-title">基本信息</h2>
					<div class="layui-colla-content layui-show" id="baseDiv">


					</div>
				</div>
				<div class="layui-colla-item" id="contractModule" style="display: none">
					<h2 class="layui-colla-title">合同信息</h2>
					<div class="layui-colla-content layui-show">
						<%--							<form class="layui-form" id="contractForm" lay-filter="contractForm">--%>
						<div class="layui-row">
							<div class="layui-col-xs4" style="padding: 0 5px;">
								<div class="layui-form-item">
									<label class="layui-form-label form_label">合同金额<span field="contractMoney" class="field_required">*</span></label>
									<div class="layui-input-block form_block">
										<input type="text"  name="contractMoney" autocomplete="off"  class="layui-input  input_floatNum">
									</div>
								</div>
							</div>
							<div class="layui-col-xs4" style="padding: 0 5px;">
								<div class="layui-form-item">
									<label class="layui-form-label form_label">合同名称<span field="contractName" class="field_required">*</span></label>
									<div class="layui-input-block form_block">
										<input type="text"  name="contractName" autocomplete="off" pointFlag="1" class="layui-input">
									</div>
								</div>
							</div>
							<div class="layui-col-xs4" style="padding: 0 5px;">
								<div class="layui-form-item">
									<label class="layui-form-label form_label">合同编号<span field="contractNo" class="field_required">*</span></label>
									<div class="layui-input-block form_block">
										<input type="text" contractId  name="contractNo" autocomplete="off" pointFlag="1" class="layui-input">
									</div>
								</div>
							</div>
						</div>
						<div class="layui-row">
							<div class="layui-col-xs4" style="padding: 0 5px;">
								<div class="layui-form-item">
									<label class="layui-form-label form_label">款项性质<span field="naturePayment" class="field_required">*</span></label>
									<div class="layui-input-block form_block">
										<select  name="naturePayment" lay-filter="naturePayment"></select>
									</div>
								</div>
							</div>
							<div class="layui-col-xs4" style="padding: 0 5px;">
								<div class="layui-form-item">
									<label class="layui-form-label form_label">客商单位名称<span field="merchantsUnitName" class="field_required">*</span></label>
									<div class="layui-input-block form_block">
										<input type="text" id="merchantsUnitName"  name="merchantsUnitName" readonly  autocomplete="off" class="layui-input" style="cursor: pointer" customerId="" collectionAccount="" collectionBank="" collectionbankNo="" >
									</div>
								</div>
							</div>
							<div class="layui-col-xs4" style="padding: 0 5px;">
								<div class="layui-form-item">
									<label class="layui-form-label form_label">是否占用预算<span field="occupationBudget" class="field_required">*</span></label>
									<div class="layui-input-block form_block" style="pointer-events: none;cursor: default;">
										<input type="radio" name="occupationBudget" lay-filter="occupationBudget"  value="1" title="是" checked>
										<input type="radio" name="occupationBudget" lay-filter="occupationBudget"  value="0" title="否">
									</div>
								</div>
							</div>
						</div>
						<div class="layui-row">
							<div class="layui-col-xs4" style="padding: 0 5px;">
								<div class="layui-form-item">
									<label class="layui-form-label form_label">本次支付金额<span field="paymentMoney" class="field_required">*</span></label>
									<div class="layui-input-block form_block">
										<input type="text" id="paymentMoney"  name="paymentMoney"  readonly autocomplete="off" floatType="RD_paymentMoney" handleCallback="afterFloatChange"  class="layui-input  input_floatNum" style="background: #e7e7e7">
									</div>
								</div>
							</div>
							<div class="layui-col-xs4" style="padding: 0 5px;">
								<div class="layui-form-item">
									<label class="layui-form-label form_label">本次支付金额(大写)</label>
									<div class="layui-input-block form_block">
										<input type="text" id="paymentMoneyStr" readonly autocomplete="off" pointFlag="1" class="layui-input" style="background:#e7e7e7">
									</div>
								</div>
							</div>
						</div>
						<%--							</form>--%>
					</div>
				</div>
			</form>
			<div class="layui-colla-item" id="reimbursementWriteModule" style="display: none">
				<h2 class="layui-colla-title">预付核销</h2>
				<div class="layui-colla-content layui-show">
					<table id="reimbursementWriteTable" lay-filter="reimbursementWriteTable"></table>
				</div>
			</div>
			<div class="layui-colla-item" id="reimbursementDetailsModule">
				<h2 class="layui-colla-title">预算执行</h2>
				<div class="layui-colla-content layui-show">
					<table id="reimbursementDetailsTable" lay-filter="reimbursementDetailsTable"></table>
				</div>
			</div>
			<div class="layui-colla-item" id="tripDetailsModule" style="display: none;">
				<h2 class="layui-colla-title">行程明细</h2>
				<div class="layui-colla-content layui-show">
					<div class="layui-card">
						<div class="layui-card-header" style="font-size: 16px; font-weight: 600;">长途交通费</div>
						<div class="layui-card-body" id="longDistanceTableModule">
							<table id="longDistanceTable" lay-filter="longDistanceTable"></table>
						</div>
					</div>
					<div class="layui-card">
						<div class="layui-card-header" style="font-size: 16px; font-weight: 600;">市内交通费</div>
						<div class="layui-card-body" id="cityCostTableModule">
							<table id="cityCostTable" lay-filter="cityCostTable"></table>
						</div>
					</div>
					<div class="layui-card">
						<div class="layui-card-header" style="font-size: 16px; font-weight: 600;">住宿费</div>
						<div class="layui-card-body" id="stayCostTableModule">
							<table id="stayCostTable" lay-filter="stayCostTable"></table>
						</div>
					</div>
					<div class="layui-card">
						<div class="layui-card-header" style="font-size: 16px; font-weight: 600;">其他费用</div>
						<div class="layui-card-body" id="otherCostTableModule">
							<table id="otherCostTable" lay-filter="otherCostTable"></table>
						</div>
					</div>
					<div class="layui-card">
						<div class="layui-card-header" style="font-size: 16px; font-weight: 600;">补助明细</div>
						<div class="layui-card-body" id="subsidyTableModule">
							<table id="subsidyTable" lay-filter="subsidyTable"></table>
						</div>
					</div>
					<div class="layui-card">
						<div class="layui-card-header" style="font-size: 16px; font-weight: 600;">行程汇总</div>
						<div class="layui-card-body">
							<div class="layui-form">
								<div class="layui-row">
									<div class="layui-col-xs4" style="padding: 0 5px;">
										<div class="layui-form-item">
											<label class="layui-form-label form_label">长途交通费合计</label>
											<div class="layui-input-block form_block">
												<input type="text" id="longDistanceCostTotal" readonly
													   autocomplete="off" class="layui-input">
											</div>
										</div>
									</div>
									<div class="layui-col-xs4" style="padding: 0 5px;">
										<div class="layui-form-item">
											<label class="layui-form-label form_label">住宿费用合计</label>
											<div class="layui-input-block form_block">
												<input type="text" id="stayCostsTotal" readonly
													   autocomplete="off" class="layui-input">
											</div>
										</div>
									</div>
									<div class="layui-col-xs4" style="padding: 0 5px;">
										<div class="layui-form-item">
											<label class="layui-form-label form_label">市内交通费合计</label>
											<div class="layui-input-block form_block">
												<input type="text" id="cityCostTotal" readonly
													   autocomplete="off" class="layui-input">
											</div>
										</div>
									</div>
								</div>
								<div class="layui-row">
									<div class="layui-col-xs4" style="padding: 0 5px;">
										<div class="layui-form-item">
											<label class="layui-form-label form_label">其他费用合计</label>
											<div class="layui-input-block form_block">
												<input type="text" id="otherCostTotal" readonly
													   autocomplete="off" class="layui-input">
											</div>
										</div>
									</div>
									<div class="layui-col-xs4" style="padding: 0 5px;">
										<div class="layui-form-item">
											<label class="layui-form-label form_label">补助费用合计</label>
											<div class="layui-input-block form_block">
												<input type="text" id="subsidyAmountTotal" readonly
													   autocomplete="off" class="layui-input">
											</div>
										</div>
									</div>
									<div class="layui-col-xs4" style="padding: 0 5px;">
										<div class="layui-form-item">
											<label class="layui-form-label form_label">会计调整合计</label>
											<div class="layui-input-block form_block">
												<input type="text" id="adjustAmountTotal" readonly
													   autocomplete="off" class="layui-input">
											</div>
										</div>
									</div>
								</div>
								<div class="layui-row">
									<div class="layui-col-xs4" style="padding: 0 5px;">
										<div class="layui-form-item">
											<label class="layui-form-label form_label">报销金额合计(含税)</label>
											<div class="layui-input-block form_block">
												<input type="text" id="amountIncludingTaxTotal" readonly
													   autocomplete="off" class="layui-input">
											</div>
										</div>
									</div>
									<div class="layui-col-xs4" style="padding: 0 5px;">
										<div class="layui-form-item">
											<label class="layui-form-label form_label">税额合计</label>
											<div class="layui-input-block form_block">
												<input type="text" id="taxAmountTotal" readonly
													   autocomplete="off" class="layui-input">
											</div>
										</div>
									</div>
									<div class="layui-col-xs4" style="padding: 0 5px;">
										<div class="layui-form-item">
											<label class="layui-form-label form_label">报销金额合计(不含税)</label>
											<div class="layui-input-block form_block">
												<input type="text" id="anountExcludingTaxTotal" readonly
													   autocomplete="off" class="layui-input">
											</div>
										</div>
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
			<div class="layui-colla-item" id="paymentDetailsModule">
				<h2 class="layui-colla-title">付款明细</h2>
				<div class="layui-colla-content layui-show">
					<table id="paymentDetailsTable" lay-filter="paymentDetailsTable"></table>
				</div>
			</div>
		</div>
	</div>
	<div class="footer">
		<button type="button" class="layui-btn layui-btn-normal" id="saveBtn">保存</button>
		<button type="button" class="layui-btn layui-btn-warm" id="submitBtn">提交</button>
		<button type="button" class="layui-btn layui-btn-primary" id="closeBtn">关闭</button>
		<button type="button" class="layui-btn layui-btn-warm" id="reSubmitBtn" style="display: none;">提交</button>
	</div>
</div>

<script type="text/html" id="toolbarDemoIn">
	<div class="layui-btn-container" style="height: 30px;">
		<button type="button" class="layui-btn layui-btn-sm" lay-event="add">加行</button>
	</div>
</script>

<script type="text/html" id="toolbarIn">
	<div class="layui-btn-container" style="height: 30px;">
		<button type="button" class="layui-btn layui-btn-sm" lay-event="add">加行</button>
		<button type="button" class="layui-btn layui-btn-sm" lay-event="addInovice">添加发票</button>
		<button type="button" class="layui-btn layui-btn-sm" lay-event="merge">合并</button>
		<button type="button" class="layui-btn layui-btn-sm" lay-event="viewInvoice">查看发票</button>
	</div>
</script>

<script type="text/html" id="tripDetailToolbar">
	<div class="layui-btn-container" style="height: 30px;">
		<button type="button" class="layui-btn layui-btn-sm" lay-event="addInovice">添加发票</button>
		<button type="button" class="layui-btn layui-btn-sm" lay-event="add">加行</button>
	</div>
</script>

<script type="text/html" id="barDemo">
	<button  type="button" class="layui-btn layui-btn-danger layui-btn-xs" lay-event="del">删行</button>
</script>

<script type="text/html" id="addReceipt">
	<div class="layui-btn-container" style="height: 30px;">
		<button type="button" class="layui-btn layui-btn-sm" lay-event="addReceipts">修改发票</button>
	</div>
</script>

<script type="text/javascript" src="/js/planbudget/kingDee.js?20211216.10"></script>
<script type="text/javascript" src="/js/planbudget/departmentalBudgetImplementation/editClaimForm.js?20220224.1"></script>
<script type="text/javascript" src="https://img-expense.piaozone.com/static/gallery/socket.io.js"></script>
<script type="text/javascript" src="https://img-expense.piaozone.com/static/public/js/pwy-socketio-v2.js"></script>
<script type="text/javascript" src="/js/editIEprint/index.js?20210918.1"></script>
</body>
</html>
