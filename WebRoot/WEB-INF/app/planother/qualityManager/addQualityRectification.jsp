<%@ page language="java" contentType="text/html; charset=UTF-8"
		 pageEncoding="UTF-8"%>
<%@taglib prefix="mvc" uri="http://www.springframework.org/tags/form" %>
<%@taglib prefix="fmt" uri="http://www.springframework.org/tags" %>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html>
<html>
<head lang="en">
	<meta charset="UTF-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
	<title>新增质量整改</title>
	<link rel="stylesheet" href="/lib/layui/layui/css/layui.css?20190817.1">
	<link rel="stylesheet" href="/lib/layui/layui/css/common.css">
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
	<script type="text/javascript" src="/js/planother/planotherUtil.js?221202108091508"></script>
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
		.layui-col-20{
			width: 20%;
		}


		#south {
			position: fixed;
			bottom: 0px;
			width: 100%;
			text-align: right;
			padding: 5px 0px;
			background: #e7e7e7;
			border-top: 1px #fff solid;
			overflow: hidden;
		}

		input.BigButtonA {
			width: 60px;
			height: 30px;
			height: 28px !important;
			padding-bottom: 3px;
			color: #ffffff;
			background: url(/img/common/selectUser_normal.png) no-repeat;
			border: 0px;
			cursor: pointer;
			font-size: 12pt;
		}
	</style>
</head>
<body>

<div class="container" id="htmBox"></div>

<%----------------------------------------------------数据操作--------------------------------------------------------------------------%>

<script type="text/javascript">
	/**
	 * 此页面为
	 * 质量整改、质量整改流程审批界面引用
	 * 质量验收、质量验收流程审批界面引用
	 * 质量隐患台账 界面引用
	 *
	 * securityInfoDate 父页面传的数据
	 * type = 4 不可编辑
	 *
	 * 右侧事务提醒 质量整改
	 * keyId 主键id
	 * showBtn 是否显示保存按钮 0显示 1不显示
	 *
	 */

	var keyId = getUrlParam("keyId");
	var showBtn = getUrlParam("showBtn");
	//var isAcceptance = getUrlParam("isAcceptance");




	var securityInfoDate = parent.securityInfoDate;
	//var _data = parent.securityInfoDate1;

	// if (!securityInfoDate){
	// 	securityInfoDate=_data
	// }
	console.log(securityInfoDate)
	var urlType = getUrlParam("urlType");
	//console.log(urlType)
	var type = getUrlParam("type");


	var runId = getUrlParam("runId");
	var _disabled = getUrlParam('disabled');
	if(runId&&'0'!=_disabled){
		type = 4
	}

	var _url = '/workflow/qualityRectification/getById?runId='
	var _url2 = '/workflow/qualityRectification/getById?kayId='
	if(urlType == 'acceptance'){
		_url = '/workflow/qualityAcceptanceManager/getById?runId='
		_url2 = '/workflow/qualityAcceptanceManager/getById?kayId='
	}


	if(!securityInfoDate){
		if(runId){
			$.ajax({
				url:_url+runId,
				dataType:"json",
				type:"post",
				async:false,
				success:function(res){
					securityInfoDate=res.obj
				}
			})
		}else if(keyId){
			$.ajax({
				url:_url2+keyId,
				dataType:"json",
				type:"post",
				async:false,
				success:function(res){
					securityInfoDate=res.obj
				}
			})
		}else {
			layer.msg("获取信息失败")
		}
	}
	var rectificationData = null
	var acceptanceData = null
	if(urlType == 'acceptance'){//质量验收
		rectificationData = securityInfoDate&&securityInfoDate.securityRectification
		acceptanceData = securityInfoDate
	}else if(urlType == 'dangerAccount'){//质量隐患台账
		type = 4
		rectificationData = securityInfoDate
		acceptanceData = securityInfoDate&&securityInfoDate.acceptance
	}else {//默认质量整改
		rectificationData = securityInfoDate
		acceptanceData = securityInfoDate&&securityInfoDate.acceptance
	}


	//判断是不是质量验收退回的
	var rectificationFlag = rectificationData?rectificationData.rectificationFlag:''

	//回显图纸打点字段
	var _urlImg = ''

	var transposition = /* region 质量整改 */
			'<div class="layui-colla-item"><h2 class="layui-colla-title">质量整改</h2>' +
			'<div class="layui-colla-content layui-show mtl_info"><form id="baseForm2" class="layui-form" lay-filter="baseForm2">' +
			/*第一行*/
			'<div class="layui-row">' +
			'<div class="layui-col-xs4" style="padding: 0 10px">' +
			'<div class="layui-form-item">' +
			'<label class="layui-form-label form_label">整改描述<span field="rectificationDesc" class="field_required">*</span></label>' +
			'<div class="layui-input-block form_block">' +
			'<textarea type="text" style="width:100%;height 38px;resize: vertical;" id="rectificationDesc" lay-verify="required"  name="rectificationDesc" autocomplete="off" class="layui-input"></textarea>' +
			'</div>' +
			'</div>' +
			'</div>' +
			'<div class="layui-col-xs4" style="padding: 0 10px" id="rectificationUser1">' +
			'<div class="layui-form-item">' +
			'<label class="layui-form-label form_label">整改人<span field="rectificationUser" class="field_required">*</span></label>' +
			'<div class="layui-input-block form_block">' +
			'<input class="layui-input" style="height: 38px !important;" lay-verify="required" id="rectificationUser" name="rectificationUser">' +
			'</div>' +
			'</div>' +
			'</div>' +
			'<div class="layui-col-xs4" style="padding: 0 10px" id="rectificationTime1">' +
			'<div class="layui-form-item">' +
			'<label class="layui-form-label form_label">整改时间<span field="rectificationTime" class="field_required">*</span></label>' +
			'<div class="layui-input-block form_block">' +
			'<input type="text"  style="height: 38px !important;" lay-verify="required" autocomplete="off" class="layui-input"  id="rectificationTime" name="rectificationTime">' +
			'</div>' +
			'</div>' +
			'</div>' +
			'</div>' +
			/* endregion */
			/*第二行*/
			'           <div class="layui-row">' +
			'               <div class="layui-col-xs12" style="padding: 0 10px;">' +
			'                   <div class="layui-form-item">\n' +
			'                       <label class="layui-form-label form_label"><span field="rectificationAttachmentId" class="field_required">*</span>整改照片</label>' +
			'                       <div class="layui-input-block form_block">' +
			'   						<div class="file_module">' +
			'   							<div id="fileAll1" class="file_content"></div>' +
			'   							<div class="file_upload_box">' +
			'   								<a href="javascript:;" class="open_file">' +
			'   									<img src="/img/mg11.png" style="margin: -3px 10px 0 0;"><span>添加附件</span>' +
			'   									<input type="file" multiple id="fileupload1" data-url="/upload?module=quality" name="file">' +
			'   								</a>' +
			'   								<div class="progress" id="progress">' +
			'   									<div class="bar"></div>\n' +
			'   								</div>' +
			'   								<div class="bar_text"></div>' +
			'   							</div>' +
			'   						</div>' +
			'                       </div>\n' +
			'                   </div>' +
			'               </div>' +
			'           </div>' +
			/* endregion */
			'</form>' +
			'</div>' +
			'</div>'
	/* endregion */


	var _htm = '<div class="layer_wrap _disabled"><div class="layui-collapse">' +
			/* region 质量检查 */
			/*第一行*/
			'<div class="layui-colla-item"><h2 class="layui-colla-title">质量检查</h2>' +
			'<div class="layui-colla-content layui-show order_base_info"><form id="baseForm" class="layui-form" lay-filter="baseForm">' +
			'<div class="layui-row">' +
			'<div class="layui-col-xs2 layui-col-20" style="padding: 0 10px">' +
			'<div class="layui-form-item">' +
			'<label class="layui-form-label form_label">单据号</label>' +
			'<div class="layui-input-block form_block">' +
			'<input type="text" readonly name="documentNo" id="documentNo" autocomplete="off" style="background: #e7e7e7"class="layui-input">' +
			'</div>' +
			'</div>' +
			'</div>' +
			'<div class="layui-col-xs2 layui-col-20" style="padding: 0 10px">' +
			'<div class="layui-form-item">' +
			'<label class="layui-form-label form_label">项目名称</label>' +
			'<div class="layui-input-block form_block">' +
			'<input type="text" name="projectName" id="projectName" readonly style="background: #e7e7e7" autocomplete="off" class="layui-input" title="项目名称">' +
			'</div>' +
			'</div>' +
			'</div>' +
			'<div class="layui-col-xs2 layui-col-20" style="padding: 0 10px">' +
			'<div class="layui-form-item">' +
			'<label class="layui-form-label form_label">检查区域</label>' +
			'<div class="layui-input-block form_block">' +
			'<input type="text"  disabled id="securityRegionName"  name="securityRegionName" style="cursor: pointer;height: 38px !important;" autocomplete="off" class="layui-input">\n' +
			// '<div class="eleTree ele3" lay-filter="data3" style="display:none;position:absolute;border: 1px solid #d2d2d2;overflow-y: auto;background-color: #fff;border-radius: 2px;box-shadow: 0 2px 4px rgba(0,0,0,.12);box-sizing: border-box;overflow:hidden;z-index: 999;top:38px;left:0px;width: 100%;"></div>' +
			'</div>' +
			'</div>' +
			'</div>' +
			'<div class="layui-col-xs2 layui-col-20" style="padding: 0 10px">' +
			'<div class="layui-form-item">' +
			'<label class="layui-form-label form_label">检查项</label>' +
			'<div class="layui-input-block form_block">' +
			'<input type="text" disabled id="securityKnowledgeName"  lay-verify="required" style="cursor: pointer;height: 38px !important;" name="ttitle4" autocomplete="off" class="layui-input">' +
			'</div>' +
			'</div>' +
			'</div>' +
			'<div class="layui-col-xs2 layui-col-20" style="padding: 0 10px">' +
			'<div class="layui-form-item">' +
			'<label class="layui-form-label form_label">重大问题</label>' +
			'<div class="layui-input-block form_block">' +
			'<input type="text"  id="securityGrade" disabled lay-verify="required" autocomplete="off" style="height: 38px !important;" class="layui-input">' +
			'</div>' +
			'</div>' +
			'</div>' +
			'</div>' +
			/* endregion */
			/*第二行*/
			'<div class="layui-row">' +
			'<div class="layui-col-xs6" style="padding: 0 10px">' +
			'<div class="layui-form-item">' +
			'<label class="layui-form-label form_label">检查内容</label>' +
			'<div class="layui-input-block form_block">' +
			'<textarea type="text" disabled style="width:100%;height 38px;resize: vertical;" id="securityDangerDesc" lay-verify="required" name="securityDangerDesc" autocomplete="off" class="layui-input"></textarea>' +
			'</div>' +
			'</div>' +
			'</div>' +
			'<div class="layui-col-xs6" style="padding: 0 10px">' +
			'<div class="layui-form-item">' +
			'<label class="layui-form-label form_label">检查情况</label>' +
			'<div class="layui-input-block form_block">' +
			'<textarea type="text" disabled style="width:100%;height 38px;resize: vertical;" id="checkSituation" lay-verify="required" name="checkSituation" autocomplete="off" class="layui-input"></textarea>' +
			'</div>' +
			'</div>' +
			'</div>' +
			'</div>' +
			/* endregion */
			/*第三行*/
			'<div class="layui-row">' +
			'<div class="layui-col-xs2 layui-col-20" style="padding: 0 10px">' +
			'<div class="layui-form-item">' +
			'<label class="layui-form-label form_label">是否需要整改</label>' +
			'<div class="layui-input-block form_block">' +
			'<input type="checkbox" name="close" disabled id="needRecification" lay-skin="switch" lay-filter="switchTest" lay-text="是|否">' +
			'</div>' +
			'</div>' +
			'</div>' +
			'<div class="layui-col-xs2 layui-col-20 pid" style="padding: 0 10px">' +
			'<div class="layui-form-item">' +
			'<label class="layui-form-label form_label">隐患位置</label>' +
			'<div class="layui-input-block form_block">' +
			'<input type="text"  id="dangerLocation" disabled lay-verify="required" autocomplete="off" style="height: 38px !important;" class="layui-input">' +
			'</div>' +
			'</div>' +
			'</div>' +
			'<div class="layui-col-xs2 layui-col-20 pid" style="padding: 0 10px">' +
			'<div class="layui-form-item">' +
			'<label class="layui-form-label form_label">图纸位置</label>' +
			'<div class="layui-input-block form_block">' +
			'<span id="placeSpan" style="cursor: pointer;color:blue;font-size: 25px;line-height: initial;"></span>' +
			'</div>' +
			'</div>' +
			'</div>' +
			'<div class="layui-col-xs2 layui-col-20 pid" style="padding: 0 10px">' +
			'<div class="layui-form-item">' +
			'<label class="layui-form-label form_label">整改期限</label>' +
			'<div class="layui-input-block form_block">' +
			'<input class="layui-input" disabled style="height: 38px !important;" lay-verify="required" id="rectificationPeriod">' +
			'</div>' +
			'</div>' +
			'</div>' +
			'<div class="layui-col-xs2 layui-col-20 pid" style="padding: 0 10px">' +
			'<div class="layui-form-item">' +
			'<label class="layui-form-label form_label">整改责任人</label>' +
			'<div class="layui-input-block form_block">' +
			'<input class="layui-input" disabled style="height: 38px !important;" lay-verify="required" id="rectificationPersion">' +
			'</div>' +
			'</div>' +
			'</div>' +
			'</div>' +
			/* endregion */
			/*第四行*/
			'<div class="layui-row pid">' +
			'<div class="layui-col-xs6" style="padding: 0 10px">' +
			'<div class="layui-form-item">' +
			'<label class="layui-form-label form_label">整改措施</label>' +
			'<div class="layui-input-block form_block">' +
			'<textarea type="text" disabled style="width:100%;height 38px;resize: vertical;" id="securityDangerMeasures" lay-verify="required" name="securityDangerMeasures" autocomplete="off" class="layui-input"></textarea>' +
			'</div>' +
			'</div>' +
			'</div>' +
			'</div>' +
			/* endregion */
			/*第五行*/
			'<div class="layui-row pid">' +
			'<div class="layui-col-xs2 layui-col-20" style="padding: 0 10px;" id="switchShow">' +
			'<div class="layui-form-item">' +
			'<label class="layui-form-label form_label">是否需要验收</label>' +
			'<div class="layui-input-block form_block">' +
			'<input type="checkbox" disabled name="close" id="needAcceptance"  lay-skin="switch" lay-filter="switchTest1" lay-text="是|否">' +
			'</div>' +
			'</div>' +
			'</div>' +
			'<div class="layui-col-xs2 layui-col-20" style="padding: 0 10px" id="acceptanceShow">' +
			'<div class="layui-form-item">' +
			'<label class="layui-form-label form_label">验收责任人</label>' +
			'<div class="layui-input-block form_block">' +
			'<input class="layui-input" disabled style="height: 38px !important;"  lay-verify="required" id="acceptancePersion">' +
			'</div>' +
			'</div>' +
			'</div>' +
			'</div>' +
			/* endregion */
			/*第五行*/
			// '<div class="layui-row">' +
			// '<div class="layui-col-xs6" style="padding: 0 10px">' +
			// '<div class="layui-form-item">' +
			// '<label class="layui-form-label form_label">隐患描述</label>' +
			// '<div class="layui-input-block form_block">' +
			// '<textarea type="text" disabled style="width:100%;height 38px" id="securityDangerDesc" lay-verify="required" name="securityDangerDesc" autocomplete="off" class="layui-input"></textarea>' +
			// '</div>' +
			// '</div>' +
			// '</div>' +
			// '</div>' +
			/* endregion */
			/*第六行*/
			'           <div class="layui-row">' +
			'               <div class="layui-col-xs12" style="padding: 0 10px;">' +
			'                   <div class="layui-form-item">\n' +
			'                       <label class="layui-form-label form_label">检查照片</label>' +
			'                       <div class="layui-input-block form_block">' +
			'   						<div class="file_module">' +
			'   							<div id="fileAll" class="file_content"></div>' +
			'   							<div class="file_upload_box" style="display: none">' +
			'   								<a href="javascript:;" class="open_file">' +
			'   									<img src="/img/mg11.png" style="margin: -3px 10px 0 0;"><span>添加附件</span>' +
			'   									<input type="file" multiple id="fileupload" data-url="/upload?module=quality" name="file">' +
			'   								</a>' +
			'   								<div class="progress" id="progress">' +
			'   									<div class="bar"></div>\n' +
			'   								</div>' +
			'   								<div class="bar_text"></div>' +
			'   							</div>' +
			'   						</div>' +
			'                       </div>\n' +
			'                   </div>' +
			'               </div>' +
			'           </div>' +
			/* endregion */
			'       </form>' +
			'    </div>\n' +
			'  </div>\n' + (rectificationFlag&&rectificationFlag==10&&urlType != 'acceptance'?'':transposition) +
			/* endregion */
			/* region 质量验收 */
			'<div class="layui-colla-item" id="acceptance1" style="display: none"><h2 class="layui-colla-title">质量验收</h2>' +
			'<div class="layui-colla-content layui-show contract_list"><form id="baseForm3" class="layui-form" lay-filter="baseForm3">' +
			/*第一行*/
			'<div class="layui-row">' +
			'<div class="layui-col-xs3" style="padding: 0 10px">' +
			'<div class="layui-form-item">' +
			'<label class="layui-form-label form_label">验收描述</label>' +
			'<div class="layui-input-block form_block">' +
			'<textarea type="text" style="width:100%;height 38px;resize: vertical;" id="acceptanceDesc" lay-verify="required"  name="acceptanceDesc" autocomplete="off" class="layui-input"></textarea>' +
			'</div>' +
			'</div>' +
			'</div>' +
			'<div class="layui-col-xs3" style="padding: 0 10px" id="acceptanceUser1">' +
			'<div class="layui-form-item">' +
			'<label class="layui-form-label form_label">验收人<span field="acceptanceUser" class="field_required">*</span></label>' +
			'<div class="layui-input-block form_block">' +
			'<input class="layui-input" style="height: 38px !important;" lay-verify="required" readonly id="acceptanceUser" name="acceptanceUser">' +
			'</div>' +
			'</div>' +
			'</div>' +
			'<div class="layui-col-xs3" style="padding: 0 10px" id="acceptanceTime1" >' +
			'<div class="layui-form-item">' +
			'<label class="layui-form-label form_label">验收时间<span field="acceptanceTime" class="field_required">*</span></label>' +
			'<div class="layui-input-block form_block">' +
			'<input type="text"  style="height: 38px !important;" lay-verify="required" autocomplete="off" class="layui-input"  id="acceptanceTime" name="acceptanceTime">' +
			'</div>' +
			'</div>' +
			'</div>' +
			'<div class="layui-col-xs3" style="padding: 0 10px;">' +
			'<div class="layui-form-item">' +
			'<label class="layui-form-label form_label">验收结果<span field="acceptanceResult" class="field_required">*</span></label>' +
			'<div class="layui-input-block form_block">' +
			'<input type="checkbox" name="acceptanceResult" id="acceptanceResult" checked="" lay-skin="switch" lay-filter="test2" lay-text="通过|不通过">' +
			'</div>' +
			'</div>' +
			'</div>' +
			'</div>' +
			/* endregion */
			/*第二行*/
			'           <div class="layui-row">' +
			'               <div class="layui-col-xs12" style="padding: 0 10px;">' +
			'                   <div class="layui-form-item">\n' +
			'                       <label class="layui-form-label form_label"><span field="acceptanceAttachmentId" class="field_required">*</span>验收照片</label>' +
			'                       <div class="layui-input-block form_block">' +
			'   						<div class="file_module">' +
			'   							<div id="fileAll2" class="file_content"></div>' +
			'   							<div class="file_upload_box" >' +
			'   								<a href="javascript:;" class="open_file">' +
			'   									<img src="/img/mg11.png" style="margin: -3px 10px 0 0;"><span>添加附件</span>' +
			'   									<input type="file" multiple id="fileupload2" data-url="/upload?module=quality" name="file">' +
			'   								</a>' +
			'   								<div class="progress" id="progress">' +
			'   									<div class="bar"></div>\n' +
			'   								</div>' +
			'   								<div class="bar_text"></div>' +
			'   							</div>' +
			'   						</div>' +
			'                       </div>\n' +
			'                   </div>' +
			'               </div>' +
			'           </div>' +
			/* endregion */
			'</form>' +
			'</div>' +
			'</div>' +  (rectificationFlag&&rectificationFlag==10&&urlType != 'acceptance'?transposition:'') +
			/* endregion */
			'</div></div>' +
			'<div id="south" style="display: none">\n' +
			'<input type="button" class="BigButtonA" id="preservation" value="保存">&nbsp;&nbsp;\n' +
			'<input type="button" class="BigButtonA" id="submit" value="提交">&nbsp;&nbsp;\n' +
			'<input type="button" class="BigButtonA" id="define" value="关闭">&nbsp;&nbsp;\n' +
			'</div>'



	$("#htmBox").html(_htm)

	if(showBtn=='0'){
		$('#south').show()
		$('._disabled').css("padding-bottom","38px");
	}


	function getUrlParam(name){
		var reg = new RegExp(name +"=(.*?)((?=&|$))"); //构造一个含有目标参数的正则表达式对象
		var r = window.location.href.match(reg); //匹配目标参数
		if (r!=null) return unescape(r[1]); return null; //返回参数值
	}

	layui.use(['table','layer','form','element','eleTree','upload','laydate'], function() {
		var table = layui.table;
		var layer = layui.layer;
		var form = layui.form;
		var eleTree = layui.eleTree;
		var element = layui.element;
		var $ = layui.jquery;
		var upload = layui.upload;
		var laydate = layui.laydate;

		form.on('switch(test2)', function (data) {//验收结果
			if (data.elem.checked == true) {
				$('#acceptanceResult').attr('acceptanceResult','0')
			} else {
				$('#acceptanceResult').attr('acceptanceResult','1')
			}
		});


		form.render();
		element.render();

		laydate.render({
			elem: '#rectificationTime'
			, trigger: 'click'
			, format: 'yyyy-MM-dd'
			// , format: 'yyyy-MM-dd HH:mm:ss'
			, value: new Date()
		});

		laydate.render({
			elem: '#acceptanceTime'
			, trigger: 'click'
			, format: 'yyyy-MM-dd'
			// , format: 'yyyy-MM-dd HH:mm:ss'
			, value: new Date()
		});

		//整改后图片
		fileuploadFn('#fileupload1', $('#fileAll1'),1);
		//检查后图片
		fileuploadFn('#fileupload2', $('#fileAll2'),1);

		<%--------------------------------------------------质量整改------------------------------------------------------%>
		//var detailsId = $("#detailsId").val();
		$('#documentNo').val(rectificationData.checklist&&rectificationData.checklist.securityNo||'');//单据号
		getProjName('#projectName',rectificationData.checklist&&rectificationData.checklist.projectId)//项目名称
		if(rectificationData&&rectificationData.detailsInfo){
			$('#securityRegionName').val(rectificationData.detailsInfo.securityRegionName||'');
			$('#securityKnowledgeName').val(rectificationData.detailsInfo.securityKnowledgeName||'');
			if(rectificationData.detailsInfo.securityGrade=='0'){
				$('#securityGrade').val('是');
			}else if(rectificationData.detailsInfo.securityGrade=='1'){
				$('#securityGrade').val('否');
			}
			$('#securityDangerDesc').val(rectificationData.detailsInfo.securityDangerDesc||'');
			$('#checkSituation').val(rectificationData.detailsInfo.checkSituation||'');
			if(rectificationData.detailsInfo.needRecification=='0'){
				$('#needRecification').prop('checked', 'checked');
				$('#dangerLocation').val(rectificationData.detailsInfo.dangerLocation||'');
				$('#rectificationPeriod').val(rectificationData.detailsInfo.rectificationPeriod||'');
				$('#rectificationPersion').val(rectificationData.detailsInfo.rectificationPersionName||'');
				$('#securityDangerMeasures').val(rectificationData.detailsInfo.securityDangerMeasures||'');

				//图纸位置
				if((rectificationData.detailsInfo.regionX)&&(rectificationData.detailsInfo.regionY)){
					$('#placeSpan').text("已标注");
				}else{
					$('#placeSpan').text("未标注");
				}
				if(rectificationData.detailsInfo.urls){
					_urlImg = rectificationData.detailsInfo.urls
					$('#placeSpan').on("click",function() {
						$.popWindow("/workflow/secirityManager/selectDrawing?type=manageOther&regionX="+rectificationData.detailsInfo.regionX+'&regionY='+rectificationData.detailsInfo.regionY);
					})
				}

				if(rectificationData.detailsInfo.needAcceptance=='0'){
					$('#needAcceptance').prop('checked', 'checked');
					$('#acceptancePersion').val(rectificationData.detailsInfo.acceptancePersionName||'');
				}else if(rectificationData.detailsInfo.needAcceptance=='1'){
					$('#needAcceptance').prop('checked', '');
					$('#acceptanceShow').hide()
				}


			}else if(rectificationData.detailsInfo.needRecification=='1'){
				$('#needRecification').prop('checked', '');
				$('.pid').hide()
			}


			//检查照片回显
			if (rectificationData.detailsInfo.attachList && rectificationData.detailsInfo.attachList.length > 0) {
				var fileArr = rectificationData.detailsInfo.attachList;
				$('#fileAll').append(echoAttachment(fileArr))
			}
		}
		$('#fileAll').next().hide()
		$('#fileAll .deImgs').hide()

		$("#rectificationDesc").val(rectificationData.rectificationDesc);//整改描述
		//$("#rectificationUser").attr("rectificationUserId",rectificationData.rectificationUser);//整改人id
		$("#rectificationUser").val(rectificationData.rectificationUser);//整改人
		$("#rectificationTime").val(rectificationData.rectificationTime);//整改时间

		//质量整改附件回显
		if (rectificationData.rectificationAttachmentList && rectificationData.rectificationAttachmentList.length > 0) {
			var fileArr = rectificationData.rectificationAttachmentList;
			$('#fileAll1').append(echoAttachment(fileArr))
		}
		if(type=='4'){
			$("#rectificationDesc").attr("disabled","disabled");
			$("#rectificationUser").attr("disabled","disabled");
			$("#rectificationTime").attr("disabled","disabled");

			$('#fileAll1').next().hide()
			$('#fileAll1 .deImgs').hide()
		}

		<%--------------------------------------------------质量验收------------------------------------------------------%>
		if(urlType == 'acceptance'){
			// 获取当前登录人
			getAutoNumber({autoNumberType: 'security'}, function(res) {
				$("#acceptanceUser").val(res.object.createUserName)
			});

			//$("#rectificationDesc").attr("readOnly",true);
			$("#rectificationDesc").attr("disabled","disabled");
			$("#rectificationUser").attr("disabled","disabled");
			$("#rectificationTime").attr("disabled","disabled");

			$('#fileAll1').next().hide()
			$('#fileAll1 .deImgs').hide()

			$("#acceptance1").show();

			$("#acceptanceDesc").val(acceptanceData.acceptanceDesc);//验收描述
			//$("#acceptanceUser").val(acceptanceData.acceptanceUser);//验收人
			$("#acceptanceTime").val(acceptanceData.acceptanceTime);//验收时间
			if(acceptanceData.acceptanceResult&&acceptanceData.acceptanceResult=='1'){
				$('#acceptanceResult').attr('acceptanceResult','1')
				$('#acceptanceResult').prop('checked', '');
			}else {
				$('#acceptanceResult').attr('acceptanceResult','0')
				$('#acceptanceResult').prop('checked', 'checked');
			}


			//质量验收附件回显
			if (acceptanceData.acceptanceAttachmentList && acceptanceData.acceptanceAttachmentList.length > 0) {
				var fileArr = acceptanceData.acceptanceAttachmentList;
				$('#fileAll2').append(echoAttachment(fileArr))
			}

			if(type=='4'){
				$("#acceptanceDesc").attr("disabled","disabled");
				$("#acceptanceUser").attr("disabled","disabled");
				$("#acceptanceTime").attr("disabled","disabled");
				$("#acceptanceResult").attr("disabled","disabled");


				$('.file_upload_box').hide()
				$('.deImgs').hide()
			}
		}
		<%--------------------------------------------------退回质量整改------------------------------------------------------%>
		if(rectificationFlag&&rectificationFlag==10){
			$("#acceptance1").show();

			// 获取当前登录人
			getAutoNumber({autoNumberType: 'security'}, function(res) {
				$("#acceptanceUser").val(res.object.createUserName)
			});

			$("#acceptanceDesc").val(acceptanceData.acceptance.acceptanceDesc);//验收描述
			//$("#acceptanceUser").val(acceptanceData.acceptance.acceptanceUser);//验收人
			$("#acceptanceTime").val(acceptanceData.acceptance.acceptanceTime);//验收时间
			if(acceptanceData.acceptance.acceptanceResult&&acceptanceData.acceptance.acceptanceResult=='1'){
				$('#acceptanceResult').attr('acceptanceResult','1')
				$('#acceptanceResult').prop('checked', '');
			}else {
				$('#acceptanceResult').attr('acceptanceResult','0')
				$('#acceptanceResult').prop('checked', 'checked');
			}


			//质量验收附件回显
			if (acceptanceData.acceptance.acceptanceAttachmentList && acceptanceData.acceptance.acceptanceAttachmentList.length > 0) {
				var fileArr = acceptanceData.acceptance.acceptanceAttachmentList;
				$('#fileAll2').append(echoAttachment(fileArr))
			}

			$("#acceptanceDesc").attr("disabled","disabled");
			$("#acceptanceUser").attr("disabled","disabled");
			$("#acceptanceTime").attr("disabled","disabled");
			$("#acceptanceResult").attr("disabled","disabled");

			$('#fileAll2').next().hide()
			$('#fileAll2 .deImgs').hide()
		}

		form.render();//初始化表单


		//提交 右侧事务提醒
		$(document).on('click', '#submit', function() {
			if(urlType != 'acceptance'){
				// 提交前先保存
				var childData  = getDate();
				var _flay = false
				if(childData){
					if(!childData.rectificationDesc){
						_flay = true
						layer.msg('整改描述不能为空！', {icon: 0, time: 2000});
					}
					if(!childData.rectificationUser){
						_flay = true
						layer.msg('整改人不能为空！', {icon: 0, time: 2000});
					}
					if(!childData.rectificationTime){
						_flay = true
						layer.msg('整改时间不能为空！', {icon: 0, time: 2000});
					}
					if(!childData.rectificationAttachmentId){
						_flay = true
						layer.msg('整改照片不能为空！', {icon: 0, time: 2000});
					}
				}
				if(_flay){
					return false
				}
				var loadIndex = layer.load();

				$.ajax({
					url: '/workflow/qualityRectification/updateById',
					data: childData,
					dataType: 'json',
					//contentType: "application/json;charset=UTF-8",
					type: 'post',
					success: function (res) {
						var approvalData = res.object;
						delete approvalData.checklist;
						delete approvalData.detailsInfo;
						delete approvalData.rectificationAttachmentList;
						delete approvalData.reportAttachmentList;
						approvalData.projectName=approvalData.projName==undefined?approvalData.projectName:approvalData.projName;
						approvalData.projectName=approvalData.projectName==undefined?approvalData.projName:approvalData.projectName;
						layer.close(loadIndex);
						if (res.flag) {
							layer.open({
								type: 1,
								title: '选择流程',
								area: ['70%', '80%'],
								btn: ['确定', '取消'],
								btnAlign: 'c',
								content: '<div style="padding: 10px"><table id="flowTable" lay-filter="flowTable"></table></div>',
								success: function () {
									$.get('/plbFlowSetting/getOwnFlowData', {plbDictNo: '74'}, function (res) {
										var flowData = []
										$.each(res.data.flowData, function (k, v) {
											flowData.push({
												flowId: k,
												flowName: v
											});
										});
										table.render({
											elem: '#flowTable',
											data: flowData,
											cols: [[
												{type: 'radio'},
												{field: 'flowName', title: '流程名称'}
											]]
										})
									});
								},
								yes: function (_index) {
									var checkStatus = table.checkStatus('flowTable');
									if (checkStatus.data.length > 0) {
										var flowData = checkStatus.data[0];
										newWorkFlow(flowData.flowId, function (res) {
											var submitData = {
												rectificationId:approvalData.rectificationId,
												runId: res.flowRun.runId
												//auditerStatus:1
											}
											$.popWindow("/workflow/work/workform?opflag=1&flowId=" + flowData.flowId + '&type=new&flowStep=1&prcsId=1&runId=' + res.flowRun.runId, '<fmt:message code="newWork.th.Quick" />', '0', '0', '1150px', '700px');

											$.ajax({
												url: "/workflow/qualityRectification/updateById",
												data: submitData,
												dataType: 'json',
												//contentType: "application/json;charset=UTF-8",
												type: 'post',
												success: function (res) {
													layer.close(loadIndex);
													if(res.code==="0"||res.code===0){
														layer.closeAll();
														layer.msg('提交成功!', {icon: 1});
														window.close();
														if(parent.opener.openRold!=undefined){
															parent.opener.openRold()
														}
													} else {
														layer.msg(res.msg, {icon: 2});
													}
												}
											});
										},approvalData);
									} else {
										layer.close(loadIndex);
										layer.msg('请选择一项！', {icon: 0});
									}
								}
							});
						} else {
							layer.msg('保存失败！', {icon: 2});
						}

					}
				});
			}else {
				// 提交前先保存

				var childData  = getDate1();
				var _flay = false
				if(childData){
					/*if(!childData.acceptanceDesc){
						_flay = true
						layer.msg('验收描述不能为空！', {icon: 0, time: 2000});
					}*/
					if(!childData.acceptanceUser){
						_flay = true
						layer.msg('验收人不能为空！', {icon: 0, time: 2000});
					}
					if(!childData.acceptanceTime){
						_flay = true
						layer.msg('验收时间不能为空！', {icon: 0, time: 2000});
					}
					if(!childData.acceptanceResult){
						_flay = true
						layer.msg('验收结果不能为空！', {icon: 0, time: 2000});
					}
					if(!childData.acceptanceAttachmentId){
						_flay = true
						layer.msg('验收照片不能为空！', {icon: 0, time: 2000});
					}
				}
				if(_flay){
					return false
				}
				var loadIndex = layer.load();
				$.ajax({
					url: '/workflow/qualityAcceptanceManager/updateById',
					data:childData,
					dataType: 'json',
					//contentType: "application/json;charset=UTF-8",
					type: 'post',
					success: function (res) {
						var approvalData = res.object;
						delete approvalData.checklist;
						delete approvalData.detailsInfo;
						delete approvalData.acceptanceAttachmentList;
						approvalData.projectName=approvalData.projName==undefined?approvalData.projectName:approvalData.projName;
						approvalData.projectName=approvalData.projectName==undefined?approvalData.projName:approvalData.projectName;
						layer.close(loadIndex);
						if (res.flag) {
							layer.open({
								type: 1,
								title: '选择流程',
								area: ['70%', '80%'],
								btn: ['确定', '取消'],
								btnAlign: 'c',
								content: '<div style="padding: 10px"><table id="flowTable" lay-filter="flowTable"></table></div>',
								success: function () {
									$.get('/plbFlowSetting/getOwnFlowData', {plbDictNo: '75'}, function (res) {
										var flowData = []
										$.each(res.data.flowData, function (k, v) {
											flowData.push({
												flowId: k,
												flowName: v
											});
										});
										table.render({
											elem: '#flowTable',
											data: flowData,
											cols: [[
												{type: 'radio'},
												{field: 'flowName', title: '流程名称'}
											]]
										})
									});
								},
								yes: function (_index) {
									var checkStatus = table.checkStatus('flowTable');
									if (checkStatus.data.length > 0) {
										var flowData = checkStatus.data[0];
										newWorkFlow(flowData.flowId, function (res) {
											var submitData = {
												acceptanceId:approvalData.acceptanceId,
												runId: res.flowRun.runId
												//auditerStatus:1
											}
											$.popWindow("/workflow/work/workform?opflag=1&flowId=" + flowData.flowId + '&type=new&flowStep=1&prcsId=1&runId=' + res.flowRun.runId, '<fmt:message code="newWork.th.Quick" />', '0', '0', '1150px', '700px');

											$.ajax({
												url: "/workflow/qualityAcceptanceManager/updateById",
												data: submitData,
												dataType: 'json',
												//contentType: "application/json;charset=UTF-8",
												type: 'post',
												success: function (res) {
													layer.close(loadIndex);
													if (res.flag) {
														layer.closeAll();
														layer.msg('提交成功!', {icon: 1});
														window.close();
														if(parent.opener.openRold!=undefined){
															parent.opener.openRold()
														}
													} else {
														layer.msg(res.msg, {icon: 2});
													}
												}
											});
										},approvalData);
									} else {
										layer.close(loadIndex);
										layer.msg('请选择一项！', {icon: 0});
									}
								}
							});
						} else {
							layer.msg('保存失败！', {icon: 2});
						}

					}
				});
			}
		});
	})

	//质量整改 保存数据
	function getDate(){
		var obj = {};
		obj.rectificationDesc = $('#rectificationDesc').val();
		obj.rectificationUser = $("#rectificationUser").val();
		//obj.rectificationUser = $('#rectificationUser').attr('rectificationUserId');
		obj.rectificationTime = $('#rectificationTime').val();
		//附件
		var rectificationAttachmentId = '';
		var rectificationAttachmentName = '';
		for (var i = 0; i < $('#fileAll1 .dech').length; i++) {
			rectificationAttachmentId += $('#fileAll1 .dech').eq(i).find('input').val();
			rectificationAttachmentName += $('#fileAll1 .dech').eq(i).find('a').attr('name');
		}

		obj.rectificationAttachmentId  = rectificationAttachmentId;
		obj.rectificationAttachmentName = rectificationAttachmentName;

		obj.rectificationId=rectificationData.rectificationId
		obj.securityContentId=rectificationData.securityContentId
		// obj.rectificationFlag='1'

		return obj;
	}
	//质量验收 保存数据
	function getDate1(){
		var obj = {};
		obj.acceptanceDesc = $('#acceptanceDesc').val();
		//obj.acceptanceUser = $('#acceptanceUser').attr('acceptanceUserId')
		obj.acceptanceUser = $("#acceptanceUser").val();
		obj.acceptanceTime = $('#acceptanceTime').val();
		obj.acceptanceResult = $('#acceptanceResult').attr('acceptanceResult');
		//附件
		var acceptanceAttachmentId = '';
		var acceptanceAttachmentName = '';
		for (var i = 0; i < $('#fileAll2 .dech').length; i++) {
			acceptanceAttachmentId += $('#fileAll2 .dech').eq(i).find('input').val();
			acceptanceAttachmentName += $('#fileAll2 .dech').eq(i).find('a').attr('name');
		}
		obj.acceptanceAttachmentId  = acceptanceAttachmentId;
		obj.acceptanceAttachmentName = acceptanceAttachmentName;

		obj.acceptanceId=acceptanceData.acceptanceId
		// obj.acceptanceFlag='1'

		return obj;
	}

	//state判断是不是右侧事务提醒
	function childFunc(state) {
		var obj={}
		var url = '/workflow/qualityRectification/updateById'

		if(!state){
			if('0'!=_disabled){
				return true
			}
		}

		var requiredFlag = false;
		if(urlType == 'acceptance'){
			obj = getDate1()
			url = '/workflow/qualityAcceptanceManager/updateById'

			// 判断必填项
			$('#baseForm3').find('.field_required').each(function(){
				var field = $(this).attr('field');
				if (field && !obj[field] && obj[field] != '0') {
					var fieldName = $(this).parent().text().replace('*', '');
					layer.msg(fieldName+'不能为空！', {icon: 0, time: 2000});
					requiredFlag = true;
				}
			});
		}else {
			obj = getDate()

			// 判断必填项
			$('#baseForm2').find('.field_required').each(function(){
				var field = $(this).attr('field');
				if (field && !obj[field] && obj[field] != '0') {
					var fieldName = $(this).parent().text().replace('*', '');
					layer.msg(fieldName+'不能为空！', {icon: 0, time: 2000});
					requiredFlag = true;
				}
			});
		}
		if(requiredFlag){
			return true
		}


		var _flag = false;
		var loadIndex = layer.load();
		$.ajax({
			url: url,
			data:obj,
			dataType: 'json',
			//contentType: "application/json;charset=UTF-8",
			type: 'post',
			success: function (res) {
				layer.close(loadIndex);
				if (res.flag) {
					layer.msg('保存成功！', {icon: 1});
					if(state){
						window.close();
						if(parent.opener.openRold!=undefined){
							parent.opener.openRold()
						}
					}
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


	//右侧事务提醒 质量整改 质量验收
	//保存
	$(document).on('click', '#preservation', function() {
		childFunc(true)
	});
	//关闭
	$(document).on('click', '#define', function() {
		window.close();
	});



	/**
	 * 新建流程方法
	 * @param flowId
	 * @param approvalData
	 * @param cb
	 */
	function newWorkFlow(flowId, cb,approvalData) {
		$.ajax({
			url: '/workflow/work/workfastAdd',
			type: 'get',
			dataType: 'json',
			data: {
				flowId: flowId,
				prcsId: 1,
				flowStep: 1,
				runId: '',
				preView: 0,
				isBudgetFlow: true,
				approvalData:JSON.stringify(approvalData),
				isTabApproval:true,
			},
			async: false,//同步请求,这里使用ajax必须使用同步方式请求，因为浏览器认为这种打开在ajax后新页面是不安全的
			success: function (res) {
				if (res.flag == true) {
					var data = res.object;
					cb(data);
				}
			}
		});
	}


	function getAutoNumber(params, callback) {
		$.get('/planningManage/autoNumber', params, function (res) {
			callback(res);
		});
	}


</script>
</body>
</html>
