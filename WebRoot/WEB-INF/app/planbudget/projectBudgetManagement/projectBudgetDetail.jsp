<%--
  Created by IntelliJ IDEA.
  User: 戎成路
  Date: 2021/4/28
  Time: 9:33
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
		<title>项目预算详情</title>
		<meta charset="UTF-8">
		<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
		<link rel="stylesheet" href="/lib/layui/layui/css/layui.css?20210319.1">

		<script type="text/javascript" src="/js/xoajq/xoajq1.js"></script>
		<script type="text/javascript" src="/lib/layui/layui/layui.all_v2.5.js"></script>
		<script type="text/javascript" src="/js/base/base.js"></script>
		<script type="text/javascript" src="/lib/layui/layui/global.js?20210527.1"></script>
		<script type="text/javascript" src="/lib/jQuery-File-Upload-master/jquery-ui.js"></script>
		<script type="text/javascript" src="/lib/jQuery-File-Upload-master/jquery.iframe-transport.js"></script>
		<script type="text/javascript" src="/lib/jQuery-File-Upload-master/jquery.fileupload.js"></script>
		<script type="text/javascript" src="/js/common/fileupload.js"></script>
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
		</style>
	</head>
	<body>
		<div class="container">
			<input type="hidden" id="leftId" value="">
			<div class="wrapper">
				<form class="layui-form" id="baseForm" lay-filter="baseForm">
					<div class="layui-row">
						<div class="layui-col-xs3" style="padding: 0 5px">
							<div class="layui-form-item">
								<label class="layui-form-label form_label">预算编号<span class="field_required">*</span></label>
								<div class="layui-input-block form_block">
									<input type="text" readonly name="budgetNo" autocomplete="off" style="background-color: #e7e7e7;" class="layui-input">
								</div>
							</div>
						</div>
						<div class="layui-col-xs3" style="padding: 0 5px">
							<div class="layui-form-item">
								<label class="layui-form-label form_label">项目名称<span class="field_required">*</span></label>
								<div class="layui-input-block form_block">
									<input type="text" readonly name="projectName" id="projectName" autocomplete="off" style="background-color: #e7e7e7;" class="layui-input">
								</div>
							</div>
						</div>
						<div class="layui-col-xs3" style="padding: 0 5px">
							<div class="layui-form-item">
								<label class="layui-form-label form_label">预算名称<span class="field_required">*</span></label>
								<div class="layui-input-block form_block">
									<input type="text" readonly name="budgetName" autocomplete="off" style="background-color: #e7e7e7;" class="layui-input">
								</div>
							</div>
						</div>
						<div class="layui-col-xs3" style="padding: 0 5px">
							<div class="layui-form-item">
								<label class="layui-form-label form_label">单位<span class="field_required">*</span></label>
								<div class="layui-input-block form_block">
									<select disabled name="itemUnit"></select>
								</div>
							</div>
						</div>
					</div>
					<div class="layui-row income_tar" style="display: none;">
						<div class="layui-col-xs3" style="padding: 0 5px">
							<div class="layui-form-item">
								<label class="layui-form-label form_label">收入目标数量<span class="field_required">*</span></label>
								<div class="layui-input-block form_block">
									<input type="text" readonly name="incomeTarNum" autocomplete="off" style="background-color: #e7e7e7;" class="layui-input">
								</div>
							</div>
						</div>
						<div class="layui-col-xs3" style="padding: 0 5px">
							<div class="layui-form-item">
								<label class="layui-form-label form_label">收入目标单价</label>
								<div class="layui-input-block form_block">
									<input type="text" readonly name="incomeTarPrice" autocomplete="off" style="background-color: #e7e7e7;" class="layui-input">
								</div>
							</div>
						</div>
						<div class="layui-col-xs3" style="padding: 0 5px">
							<div class="layui-form-item">
								<label class="layui-form-label form_label">收入目标金额<span class="field_required">*</span></label>
								<div class="layui-input-block form_block">
									<input type="text" readonly name="incomeTarAmount" autocomplete="off" style="background-color: #e7e7e7;" class="layui-input">
								</div>
							</div>
						</div>
						<div class="layui-col-xs3" style="padding: 0 5px">
							<div class="layui-form-item">
								<label class="layui-form-label form_label">收入目标说明</label>
								<div class="layui-input-block form_block">
									<input type="text" readonly name="incomeTarExplain" autocomplete="off" style="background-color: #e7e7e7;" class="layui-input">
								</div>
							</div>
						</div>
					</div>
					<%--<div class="layui-row run_tar" style="display: none;">
						<div class="layui-col-xs3" style="padding: 0 5px">
							<div class="layui-form-item">
								<label class="layui-form-label form_label">经营目标收入金额<span class="field_required">*</span></label>
								<div class="layui-input-block form_block">
									<input type="text" readonly name="runTarNum" autocomplete="off" style="background-color: #e7e7e7;" class="layui-input">
								</div>
							</div>
						</div>
						<div class="layui-col-xs3" style="padding: 0 5px">
							<div class="layui-form-item">
								<label class="layui-form-label form_label">经营目标利润金额<span class="field_required">*</span></label>
								<div class="layui-input-block form_block">
									<input type="text" readonly name="runTarPrice" autocomplete="off" style="background-color: #e7e7e7;" class="layui-input">
								</div>
							</div>
						</div>
						<div class="layui-col-xs3" style="padding: 0 5px">
							<div class="layui-form-item">
								<label class="layui-form-label form_label">经营目标金额<span class="field_required">*</span></label>
								<div class="layui-input-block form_block">
									<input type="text" readonly name="runTarAmount" autocomplete="off" style="background-color: #e7e7e7;" class="layui-input">
								</div>
							</div>
						</div>
						<div class="layui-col-xs3" style="padding: 0 5px">
							<div class="layui-form-item">
								<label class="layui-form-label form_label">经营目标说明</label>
								<div class="layui-input-block form_block">
									<input type="text" readonly name="runTarExplain" autocomplete="off" style="background-color: #e7e7e7;" class="layui-input">
								</div>
							</div>
						</div>
						<div class="layui-col-xs12" style="padding: 0 5px;">
							<div class="layui-form-item">
								<label class="layui-form-label form_label">经营目标附件</label>
								<div class="layui-input-block form_block">
									<div class="file_module">
										<div id="fileContentTar" class="file_content"></div>
										<div class="file_upload_box">
											<a href="javascript:;" class="open_file">
												<img src="/img/mg11.png" style="margin: -3px 5px 0 0;"><span>添加附件</span>
												<input type="file" multiple id="fileuploadTar" data-url="/upload?module=planbudget" name="file">
											</a>
										</div>
									</div>
								</div>
							</div>
						</div>
					</div>--%>
					<div class="layui-row opt_tar" style="display: none;">
						<div class="layui-col-xs3" style="padding: 0 5px">
							<div class="layui-form-item">
								<label class="layui-form-label form_label">优化目标数量<span class="field_required">*</span></label>
								<div class="layui-input-block form_block">
									<input type="text" readonly name="optTarNum" autocomplete="off" style="background-color: #e7e7e7;" class="layui-input">
								</div>
							</div>
						</div>
						<div class="layui-col-xs3" style="padding: 0 5px">
							<div class="layui-form-item">
								<label class="layui-form-label form_label">优化目标单价<span class="field_required">*</span></label>
								<div class="layui-input-block form_block">
									<input type="text" readonly name="optTarPrice" autocomplete="off" style="background-color: #e7e7e7;" class="layui-input">
								</div>
							</div>
						</div>
						<div class="layui-col-xs3" style="padding: 0 5px">
							<div class="layui-form-item">
								<label class="layui-form-label form_label">优化目标金额<span class="field_required">*</span></label>
								<div class="layui-input-block form_block">
									<input type="text" readonly name="optTarAmount" autocomplete="off" style="background-color: #e7e7e7;" class="layui-input">
								</div>
							</div>
						</div>
						<div class="layui-col-xs3" style="padding: 0 5px">
							<div class="layui-form-item">
								<label class="layui-form-label form_label">优化目标说明</label>
								<div class="layui-input-block form_block">
									<input type="text" readonly name="optTarExplain" autocomplete="off" style="background-color: #e7e7e7;" class="layui-input">
								</div>
							</div>
						</div>
						<%--<div class="layui-col-xs12" style="padding: 0 5px;">
							<div class="layui-form-item">
								<label class="layui-form-label form_label">优化目标附件</label>
								<div class="layui-input-block form_block">
									<div class="file_module">
										<div id="fileContentOpt" class="file_content"></div>
										<div class="file_upload_box">
											<a href="javascript:;" class="open_file">
												<img src="/img/mg11.png" style="margin: -3px 5px 0 0;"><span>添加附件</span>
												<input type="file" multiple id="fileuploadOpt" data-url="/upload?module=planbudget" name="file">
											</a>
										</div>
									</div>
								</div>
							</div>
						</div>--%>
					</div>
					<div class="layui-row manage_tar" style="display: none;">
						<div class="layui-col-xs3" style="padding: 0 5px">
							<div class="layui-form-item">
								<label class="layui-form-label form_label">管理目标数量<span class="field_required">*</span></label>
								<div class="layui-input-block form_block">
									<input type="text" readonly name="manageTarNum" autocomplete="off" style="background-color: #e7e7e7;" class="layui-input">
								</div>
							</div>
						</div>
						<div class="layui-col-xs3" style="padding: 0 5px">
							<div class="layui-form-item">
								<label class="layui-form-label form_label">管理目标单价<span class="field_required">*</span></label>
								<div class="layui-input-block form_block">
									<input type="text" readonly name="manageTarPrice" autocomplete="off" style="background-color: #e7e7e7;" class="layui-input">
								</div>
							</div>
						</div>
						<div class="layui-col-xs3" style="padding: 0 5px">
							<div class="layui-form-item">
								<label class="layui-form-label form_label">管理目标金额<span class="field_required">*</span></label>
								<div class="layui-input-block form_block">
									<input type="text" readonly name="manageTarAmount" autocomplete="off"  style="background-color: #e7e7e7;"class="layui-input">
								</div>
							</div>
						</div>
						<div class="layui-col-xs3" style="padding: 0 5px">
							<div class="layui-form-item">
								<label class="layui-form-label form_label">管理目标说明</label>
								<div class="layui-input-block form_block">
									<input type="text" name="manageTarExplain" autocomplete="off" class="layui-input">
								</div>
							</div>
						</div>
					</div>
					<div class="layui-row">
						<div class="layui-col-xs3" style="padding: 0 5px">
							<div class="layui-form-item">
								<label class="layui-form-label form_label">编制日期<span class="field_required">*</span></label>
								<div class="layui-input-block form_block">
									<input type="text" id="planDate" name="planDate" readonly autocomplete="off" style="cursor: pointer;" class="layui-input">
								</div>
							</div>
						</div>
						<div class="layui-col-xs3" style="padding: 0 5px">
							<div class="layui-form-item">
								<label class="layui-form-label form_label">备注</label>
								<div class="layui-input-block form_block">
									<textarea name="remarks" placeholder="请输入内容" class="layui-textarea" style="height: 38px;min-height: 38px"></textarea>
								</div>
							</div>
						</div>
						<div class="layui-col-xs12" style="padding: 0 5px;">
							<div class="layui-form-item">
								<label class="layui-form-label form_label">附件</label>
								<div class="layui-input-block form_block">
									<div class="file_module">
										<div id="fileContent" class="file_content"></div>
										<div class="file_upload_box">
											<a href="javascript:;" class="open_file">
												<img src="/img/mg11.png" style="margin: -3px 5px 0 0;"><span>添加附件</span>
												<input type="file" multiple id="fileupload" data-url="/upload?module=planbudget" name="file">
											</a>
										</div>
									</div>
								</div>
							</div>
						</div>
					</div>
				</form>
			</div>
			<div class="footer">
				<button type="button" class="layui-btn layui-btn-normal" id="saveBtn">保存</button>
			</div>
		</div>

		<script>
			var budgetType = $.GetRequest()['budgetType'] || '';
            var budgetItemId = $.GetRequest()['budgetItemId'] || '';
            var disabled = $.GetRequest()['disabled'] || '';

            if (budgetType == 1) {
            	// 项目预算编制
				$('.income_tar').show();
			} else if (budgetType == 2) {
				// 项目经营目标
				$('.income_tar').show();
				$('.run_tar').show();
			} else if (budgetType == 3) {
				// 项目优化目标
				$('.income_tar').show();
				$('.opt_tar').show();
			} else if (budgetType == 4) {
				// 项目管理目标
				$('.income_tar').show();
				$('.run_tar').show();
				$('.opt_tar').show();
				$('.manage_tar').show();
			}

            if (disabled === '1') {
                $('.footer').hide();
                $('#baseForm').find('input').attr('disabled', 'disabled').css('background-color', '#e7e7e7');
                $('#baseForm').find('textarea').attr('disabled', 'disabled').css('background-color', '#e7e7e7');
                $('.file_upload_box').hide();
            }

			// 获取数据字典数据
			var dictionaryObj = {
				CBS_UNIT: {}
			}
			var dictionaryStr = 'CBS_UNIT';
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
				initPage();
			});

			function initPage() {
				layui.use(['form', 'laydate'], function () {
					var layForm = layui.form,
							laydate = layui.laydate;

					$.get('/plbBudgetItem/getBudgetByItemId', {itemId: budgetItemId}, function (res) {
						if (res.flag) {
							if (res.data.plbProjBudgetWithBLOBs) {
								initData(2, res.data.plbProjBudgetWithBLOBs);
							} else {
								initData(1, res.data);
							}
						}
					});

					function initData (type, data) {
						//回显项目名称
						getProjName('#projectName',data.projId)

						fileuploadFn('#fileupload', $('#fileContent'));
						$('select[name="itemUnit"]', $('#baseForm')).html(dictionaryObj['CBS_UNIT']['str']);
						layForm.render();

						// 初始化开始时间
						laydate.render({
							elem: '#planDate',
							value: data ? format(data.planDate) : '',
							trigger: 'click' //采用click弹出
						});

						if (type == 2) {
							layForm.val("baseForm", data);
							// 项目经营目标附件
							$('#fileContentTar').html(getFileEleStr(data.attachmentTarList, disabled != '1'));

							// 项目优化目标附件
							$('#fileContentOpt').html(getFileEleStr(data.attachmentOptList, disabled != '1'));

							// 附件
							$('#fileContent').html(getFileEleStr(data.attachmentList, disabled != '1'));
						} else {
							layForm.val("baseForm", {
								"budgetNo": data.itemNo,
								"budgetName": data.itemName
							});
						}
					}
				});
			}
		</script>
	</body>
</html>
