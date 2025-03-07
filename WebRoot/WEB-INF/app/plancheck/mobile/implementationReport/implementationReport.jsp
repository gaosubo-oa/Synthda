<%--
  Created by IntelliJ IDEA.
  User: 戎成路
  Date: 2020/9/1
  Time: 17:50
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
	<head>
		<meta charset="UTF-8"/>
		<title>执行填报</title>
		<meta name="viewport" content="width=device-width,initial-scale=1,minimum-scale=1,maximum-scale=1,user-scalable=no"/>
		<link rel="stylesheet" href="/lib/mui/mui/mui.min.css">
		
		<script src="/js/xoajq/xoajq1.js"></script>
		<script src="/js/base/base.js"></script>
		<script src="/lib/mui/mui/mui.min.js"></script>
		
		<style>
			.head_button {
				margin: 5px 0;
				text-align: center;
			}
			
			.mui-btn-success {
				background-color: #009688;
				border-color: #009688;
			}
			
			.mui-btn-success:enabled:active {
				background-color: #009688;
				border-color: #009688;
			}
			
			li {
				list-style: none;
			}
			
			.content .mui-row {
				font-size: 0.85em;
			}
			
			.content .mui-row .mui-table-view-cell {
				padding: 5px 9px;
			}
			
			.urgent_icon {
				display: inline-block;
				width: 10px;
				height: 10px;
				margin-right: 5px;
				border-radius: 50%;
			}
			
			.mui-card-content .mui-table-view-cell {
				padding: 5px;
			}
			
			#completeQuantityText {
				position: absolute;
				top: 4px;
				left: 50%;
				z-index: 2;
				transform: translateX(-50%);
				color: #fff;
			}
			
			.fixed {
				position: fixed;
				top: 0;
				z-index: 3;
				background-color: #efeff4;
			}
			
			.sticky {
				position: -webkit-sticky;
				position: sticky;
				top: 0;
				z-index: 3;
				background-color: #efeff4;
			}
			
			.form_input {
				margin: 0 !important;
				padding: 5px 15px !important;
				height: 31px !important;
				line-height: 21px !important;
				box-sizing: border-box !important;
			}
			
			#todayModule .mui-table-view-cell,
			#checkModule .mui-table-view-cell {
				padding: 11px 7px;
				font-size: 0.9em;
			}
		
		</style>
	</head>
	<body>
		<div class="mui-content" id="content">
			<input type="hidden" id="userId" value="${sessionScope.userId}">
			<input type="hidden" id="completeQuantityNum">
			<div class="head_button">
				<button type="button" class="mui-btn mui-btn-success" id="today">今日</button>
				<button type="button" class="mui-btn mui-btn-success" id="collaborator">增加协作人</button>
				<button type="button" class="mui-btn mui-btn-success" id="transfer">转办</button>
				<button type="button" class="mui-btn mui-btn-success" id="submit">提交审核</button>
			</div>
			<div class="content">
				<div class="mui-row">
					<div class="mui-col-xs-4">
						<li class="mui-table-view-cell">
							<span class="left_title">名称:</span>
						</li>
					</div>
					<div class="mui-col-xs-8">
						<li class="mui-table-view-cell">
							<span class="left_con t_name"></span>
						</li>
					</div>
				</div>
				<div class="mui-row">
					<div class="mui-col-xs-4">
						<li class="mui-table-view-cell">
							<span class="left_title">累计完成百分比:</span>
						</li>
					</div>
					<div class="mui-col-xs-8">
						<li class="mui-table-view-cell">
							<span class="left_con" id="completeQuantityText"><span class="complete_quantity_text"></span>%</span>
							<div id="completeQuantity" style="height: 20px;border-radius: 10px;" class="mui-progressbar">
								<span></span>
							</div>
						</li>
					</div>
				</div>
				<div class="mui-row">
					<div class="mui-col-xs-4">
						<li class="mui-table-view-cell">
							<span class="left_title">计划结束日期:</span>
						</li>
					</div>
					<div class="mui-col-xs-8">
						<li class="mui-table-view-cell">
							<span class="left_con" id="planEndDate"></span>
						</li>
					</div>
				</div>
				<div class="mui-row">
					<div class="mui-col-xs-4">
						<li class="mui-table-view-cell">
							<span class="left_title">紧急程度:</span>
						</li>
					</div>
					<div class="mui-col-xs-8">
						<li class="mui-table-view-cell">
							<span class="left_con" id="urgent"></span>
						</li>
					</div>
				</div>
				<div class="mui-row">
					<div class="mui-col-xs-4">
						<li class="mui-table-view-cell">
							<span class="left_title">完成标准:</span>
						</li>
					</div>
					<div class="mui-col-xs-8">
						<li class="mui-table-view-cell">
							<span class="left_con" id="resultStandard"></span>
						</li>
					</div>
				</div>
				<div class="mui-row">
					<div class="mui-col-xs-4">
						<li class="mui-table-view-cell">
							<span class="left_title">需提交的成果材料:</span>
						</li>
					</div>
					<div class="mui-col-xs-8">
						<li class="mui-table-view-cell">
							<span class="left_con" id="resultFile"></span>
						</li>
					</div>
				</div>
			</div>
			<div class="connected_nfo">
				<div id="connectedHead">
					<h3 style="font-size: 1em;padding: 5px 10px;background-color: #72b3b5;font-weight: 500;">相关信息</h3>
					<div class="mui-segmented-control mui-segmented-control-inverted">
						<a class="mui-control-item mui-active" href="#dailyReport">每日填报</a>
						<a class="mui-control-item" href="#reportFile">附件</a>
						<a class="mui-control-item connected_project" style="display:none;" href="#connected_project">项目</a>
						<a class="mui-control-item connected_t_title" href="#connected_t">子任务</a>
						<a class="mui-control-item" href="#connectedWork">流程</a>
					</div>
				</div>
				<div id="connectedBody" style="margin-bottom: 30px;">
					<div id="dailyReport" class="mui-slider-item mui-control-content mui-active">
					
					</div>
					<div id="reportFile" class="mui-slider-item mui-control-content">
						<div class="mui-card" id="finalResult" style="display: none;">
							<!--页眉，放置标题-->
							<div class="mui-card-header" style="font-size: 1.1em;">最终成果(成果材料)</div>
							<!--内容区-->
							<div class="mui-card-content"></div>
						</div>
						<div class="mui-card" id="finalUnusual" style="display: none;">
							<!--页眉，放置标题-->
							<div class="mui-card-header" style="font-size: 1.1em;">最终成果(异常材料)</div>
							<!--内容区-->
							<div class="mui-card-content">
							
							</div>
						</div>
						<div class="mui-card" id="periodResult" style="display: none;">
							<!--页眉，放置标题-->
							<div class="mui-card-header" style="font-size: 1.1em;">阶段成果(成果材料)</div>
							<!--内容区-->
							<div class="mui-card-content"></div>
						</div>
						<div class="mui-card" id="periodUnusual" style="display: none;">
							<!--页眉，放置标题-->
							<div class="mui-card-header" style="font-size: 1.1em;">阶段成果(异常材料)</div>
							<!--内容区-->
							<div class="mui-card-content"></div>
						</div>
					</div>
					<div id="connected_project" class="mui-slider-item mui-control-content" style="padding: 10px;">
						<div class="mui-card">
							<!--页眉，放置标题-->
							<div class="mui-card-header" style="font-size: 1.1em;flex-direction: column;">
								<div id="projectName"></div>
								<p id="projectAbbreviation" style="margin-bottom: 0;font-size: 0.9em;"></p>
							</div>
							<!--内容区-->
							<div class="mui-card-content"></div>
						</div>
					</div>
					<div id="connected_t" class="mui-slider-item mui-control-content" style="padding: 10px;">
						<ul class="mui-table-view">
						
						</ul>
					</div>
					<div id="connectedWork" class="mui-slider-item mui-control-content" style="padding: 10px;">
					
					</div>
				</div>
			</div>
		</div>
		
		<div class="mui-content" id="todayModule" style="display: none;">
			<h3 style="padding: 5px;">今日进展</h3>
			<div class="mui-row">
				<div class="mui-col-xs-4">
					<li class="mui-table-view-cell">
						<span class="left_title">名称:</span>
					</li>
				</div>
				<div class="mui-col-xs-8">
					<li class="mui-table-view-cell">
						<span class="left_con t_name"></span>
					</li>
				</div>
			</div>
			<div class="mui-row">
				<div class="mui-col-xs-4">
					<li class="mui-table-view-cell">
						<span class="left_title">进展状态:</span>
					</li>
				</div>
				<div class="mui-col-xs-8">
					<li class="mui-table-view-cell" style="padding: 6px 7px;">
						<select class="form_input doStatus">
							<option value="1">正常</option>
							<option value="2">延迟</option>
							<option value="3">完成</option>
							<option value="4">暂停</option>
							<option value="5">关闭</option>
						</select>
					</li>
				</div>
			</div>
			<div class="mui-row">
				<div class="mui-col-xs-4">
					<li class="mui-table-view-cell">
						<span class="left_title">累计完成量:</span>
					</li>
				</div>
				<div class="mui-col-xs-8">
					<li class="mui-table-view-cell">
						<span class="complete_quantity_text"></span>%
					</li>
				</div>
			</div>
			<div class="mui-row">
				<div class="mui-col-xs-4">
					<li class="mui-table-view-cell">
						<span class="left_title">今日完成量:</span>
					</li>
				</div>
				<div class="mui-col-xs-8">
					<li class="mui-table-view-cell" style="padding: 6px 7px;">
						<input type="number" value="" class="form_input tadayProgress number_input">
						<span style="position: absolute;top: 50%;right: 25px;transform: translateY(-50%)">%</span>
					</li>
				</div>
			</div>
			<div class="mui-row">
				<div class="mui-col-xs-4">
					<li class="mui-table-view-cell">
						<span class="left_title">成果标准模板:</span>
					</li>
				</div>
				<div class="mui-col-xs-8">
					<li class="mui-table-view-cell">
						<span class="left_con result_dict"></span>
					</li>
				</div>
			</div>
			<div class="mui-row">
				<div class="mui-col-xs-4">
					<li class="mui-table-view-cell">
						<span class="left_title">进展情况:</span>
					</li>
				</div>
				<div class="mui-col-xs-8">
					<li class="mui-table-view-cell">
						<textarea class="tadayDesc" cols="30" rows="3"></textarea>
					</li>
				</div>
			</div>
			<div class="mui-row">
				<div class="mui-col-xs-4">
					<li class="mui-table-view-cell">
						<span class="left_title">异常原因:</span>
					</li>
				</div>
				<div class="mui-col-xs-8">
					<li class="mui-table-view-cell" style="padding: 6px 7px;">
						<input type="text" value="" class="form_input unusualReason">
					</li>
				</div>
			</div>
			<div class="mui-row">
				<div class="mui-col-xs-4">
					<li class="mui-table-view-cell">
						<span class="left_title">异常支撑材料:</span>
					</li>
				</div>
				<div class="mui-col-xs-8">
					<li class="mui-table-view-cell">
						<span class="left_con">
							<div class="files_box unusual_file_box"></div>
							<a onclick="uploadFile(this)">异常材料</a>
						</span>
					</li>
				</div>
			</div>
			<div class="mui-row">
				<div class="mui-col-xs-4">
					<li class="mui-table-view-cell">
						<span class="left_title">提交的成果材料:</span>
					</li>
				</div>
				<div class="mui-col-xs-8">
					<li class="mui-table-view-cell">
						<span class="left_con">
							<div class="files_box result_file_box"></div>
							<a onclick="uploadFile(this)">成果材料</a>
						</span>
					</li>
				</div>
			</div>
			<div style="text-align: center; margin: 15px 0;">
				<button type="button" class="mui-btn mui-btn-success" id="saveToday">保存</button>
				<button type="button" class="mui-btn mui-btn-success back">取消</button>
			</div>
		</div>
		
		<div class="mui-content" id="checkModule" style="display: none">
			<h3 style="padding: 5px;">提交审核</h3>
			<div class="mui-row">
				<div class="mui-col-xs-4">
					<li class="mui-table-view-cell">
						<span class="left_title">名称:</span>
					</li>
				</div>
				<div class="mui-col-xs-8">
					<li class="mui-table-view-cell">
						<span class="left_con t_name"></span>
					</li>
				</div>
			</div>
			<div class="mui-row">
				<div class="mui-col-xs-4">
					<li class="mui-table-view-cell">
						<span class="left_title">累计完成量:</span>
					</li>
				</div>
				<div class="mui-col-xs-8">
					<li class="mui-table-view-cell">
						<span class="complete_quantity_text"></span>%
					</li>
				</div>
			</div>
			<div class="mui-row">
				<div class="mui-col-xs-4">
					<li class="mui-table-view-cell">
						<span class="left_title">最终成果资料:</span>
					</li>
				</div>
				<div class="mui-col-xs-8">
					<li class="mui-table-view-cell">
						<span class="left_con">
							<div class="files_box result_file_box"></div>
							<a onclick="uploadFile(this)">成果材料</a>
						</span>
					</li>
				</div>
			</div>
			<div class="mui-row">
				<div class="mui-col-xs-4">
					<li class="mui-table-view-cell">
						<span class="left_title">异常原因:</span>
					</li>
				</div>
				<div class="mui-col-xs-8">
					<li class="mui-table-view-cell" style="padding: 6px 7px;">
						<input type="text" value="" class="form_input unusualReason">
					</li>
				</div>
			</div>
			<div class="mui-row">
				<div class="mui-col-xs-4">
					<li class="mui-table-view-cell">
						<span class="left_title">异常支撑材料:</span>
					</li>
				</div>
				<div class="mui-col-xs-8">
					<li class="mui-table-view-cell">
						<span class="left_con">
							<div class="files_box unusual_file_box"></div>
							<a onclick="uploadFile(this)">异常材料</a>
						</span>
					</li>
				</div>
			</div>
			<div class="mui-row">
				<div class="mui-col-xs-5">
					<li class="mui-table-view-cell">
						<div class="mui-input-row mui-checkbox">
							<label>事物提醒</label>
							<input id="remind" name="remind" type="checkbox" checked>
						</div>
					</li>
				</div>
				<div class="mui-col-xs-5">
					<li class="mui-table-view-cell">
						<div class="mui-input-row mui-checkbox">
							<label>短信提醒</label>
							<input id="smsRemind" name="remind" type="checkbox">
						</div>
					</li>
				</div>
			</div>
			<div style="text-align: center;margin: 15px 0;">
				<button type="button" class="mui-btn mui-btn-success" id="submitCheck">保存</button>
				<button type="button" class="mui-btn mui-btn-success back">取消</button>
			</div>
		</div>
		
		<script type="text/javascript">
            // 关键任务/子任务id
            const id = $.GetRequest()['id'] || '';
            // 6-关键任务，7-子任务
            const t_type = $.GetRequest()['type'] || '';

            let $fixedEle = $("#connectedHead");
            let pos = $fixedEle.offset();

            // 关键任务/子任务信息
            let t_data = null;
            // 项目类型
            let projectTypeObj = {}
            let getProjectType = async () => {
                await fetchAjax('/ProjectInfo/selectProjectTypeByNo').then(res => {
                    res.data.forEach(function (item) {
                        projectTypeObj[item.dictNo] = item.dictName;
                    });
                }).catch(err => {

                });
            };

            $(function () {

                getProjectType();

                initData();

                async function initData() {
                    let data = {}
                    if (t_type == 6) {
                        data.tgId = id;
                        $('.connected_t_title').text('子任务');
                    } else {
                        data.planItemId = id;
                        $('.connected_t_title').text('关键任务');
                    }

                    let targetTaskData = await fetchAjax('/ProjectDaily/selectProjectDailyByItemId', data);

                    // 基本信息
                    if (targetTaskData.object) {
                        t_data = targetTaskData.object;

                        //判断是否已经提交审核过了，提交审核过后按钮不可操作
                        if (t_data.itemApprivalStatus == 1 || t_data.itemApprivalStatus == 2 || t_data.itemApprivalStatus == 3 || t_data.itemApprivalStatus === '0') {
                            $('#today').css({
                                'background-color': '#C1C1C1',
                                'border-color': '#C1C1C1'
                            });
                            $('#collaborator').css({
                                'background-color': '#C1C1C1',
                                'border-color': '#C1C1C1'
                            });
                            $('#transfer').css({
                                'background-color': '#C1C1C1',
                                'border-color': '#C1C1C1'
                            });
                            $('#submit').css({
                                'background-color': '#C1C1C1',
                                'border-color': '#C1C1C1'
                            });
                        }
                        //判断是否可以提交审核
                        let isSubmit = await isCheck();

                        if (isSubmit) {
                            $('#collaborator').css({
                                'background-color': '#C1C1C1',
                                'border-color': '#C1C1C1'
                            });
                            $('#transfer').css({
                                'background-color': '#C1C1C1',
                                'border-color': '#C1C1C1'
                            });
                            $('#submit').css({
                                'background-color': '#C1C1C1',
                                'border-color': '#C1C1C1'
                            });
                        }

                        $('.t_name').text(t_type == 6 ? t_data.tgName : t_data.taskName);
                        $('.complete_quantity_text').text(isShowNull(t_data.leiJi));
                        $('#completeQuantityNum').val(t_data.leiJi || 0);
                        mui('#completeQuantity').progressbar().setProgress(t_data.leiJi);
                        $('#planEndDate').text(format(t_data.planEndDate));
                        $('#resultStandard').text(isShowNull(t_data.resultStandard));
                        // 最终成果材料
                        let resultFileList = t_data.attachments2;
                        if (!!resultFileList && resultFileList.length > 0) {
                            let resultFileStr = '';
                            let resultFileStr2 = '';
                            resultFileList.forEach(function (file) {
                                let attachName = file.attachName;
                                let fileExtension = attachName.substring(attachName.lastIndexOf(".") + 1, attachName.length);//截取附件文件后缀
                                let attName = encodeURI(attachName).replace(/\+/g, "%2b").replace(/\@/g, "%40").replace(/#/g, "%23").replace(/\&/g, "%26").replace(/\//g, "%2F").replace(/\?/g, "%3F").replace(/\￥/g, "%ef%bf%a5").replace(/$/g, "%24").replace(/\！/g, "%ef%bc%81").replace(/\（/g, "%ef%bc%88").replace(/\）/g, "%ef%bc%89").replace(/\…/g, "%e2%80%a6%e2%80%a6");
                                let fileExtensionName = attName.substring(0, attName.lastIndexOf("."));
                                let attachmentUrl = file.attUrl;
                                attachmentUrl = attachmentUrl.substring(0, attachmentUrl.lastIndexOf("ATTACHMENT_NAME=")) + "ATTACHMENT_NAME=" + fileExtensionName + "." + fileExtension; //处理附件名字

                                resultFileStr += '<div><a class="operation" onclick="downloadFile(this)" name="' + file.attachName + '" url="/download?' + encodeURI(attachmentUrl) + '">' + file.attachName + '</a></div>';

                                resultFileStr2 += `<div class="mui-row">
                                                        <div class="mui-col-xs-12">
                                                            <li class="mui-table-view-cell">
                                                                <span><a class="operation" onclick="downloadFile(this)" name="` + file.attachName + `" url="/download?` + encodeURI(attachmentUrl) + `">` + file.attachName + `</a></span>
                                                            </li>
                                                        </div>
                                                    </div>`;
                            });

                            $('#resultFile').html(resultFileStr);

                            $('#finalResult').show().find('.mui-card-content').html(resultFileStr2);

                        }
                        // 最终异常材料
                        let errorFileList = t_data.attachments3;
                        if (!!errorFileList && errorFileList.length > 0) {
                            let errorFileStr = '';
                            let errorFileStr2 = '';
                            errorFileList.forEach(function (file) {
                                let attachName = file.attachName;
                                let fileExtension = attachName.substring(attachName.lastIndexOf(".") + 1, attachName.length);//截取附件文件后缀
                                let attName = encodeURI(attachName).replace(/\+/g, "%2b").replace(/\@/g, "%40").replace(/#/g, "%23").replace(/\&/g, "%26").replace(/\//g, "%2F").replace(/\?/g, "%3F").replace(/\￥/g, "%ef%bf%a5").replace(/$/g, "%24").replace(/\！/g, "%ef%bc%81").replace(/\（/g, "%ef%bc%88").replace(/\）/g, "%ef%bc%89").replace(/\…/g, "%e2%80%a6%e2%80%a6");
                                let fileExtensionName = attName.substring(0, attName.lastIndexOf("."));
                                let attachmentUrl = file.attUrl;
                                attachmentUrl = attachmentUrl.substring(0, attachmentUrl.lastIndexOf("ATTACHMENT_NAME=")) + "ATTACHMENT_NAME=" + fileExtensionName + "." + fileExtension; //处理附件名字

                                errorFileStr += '<div><a class="operation" onclick="downloadFile(this)" name="' + file.attachName + '" url="/download?' + encodeURI(attachmentUrl) + '">' + file.attachName + '</a></div>';

                                errorFileStr2 += `<div class="mui-row">
                                                        <div class="mui-col-xs-12">
                                                            <li class="mui-table-view-cell">
                                                                <span><a class="operation" onclick="downloadFile(this)" name="` + file.attachName + `" url="/download?` + encodeURI(attachmentUrl) + `">` + file.attachName + `</a></span>
                                                            </li>
                                                        </div>
                                                    </div>`;
                            });

                            let errorFileEle = `<div class="mui-row">
														<div class="mui-col-xs-4">
															<li class="mui-table-view-cell">
																<span class="left_title">异常原因材料:</span>
															</li>
														</div>
														<div class="mui-col-xs-8">
															<li class="mui-table-view-cell">
																<span class="left_con">` + errorFileStr + `</span>
															</li>
														</div>
													</div>`;

                            $('.content').append(errorFileEle);

                            $('#finalUnusual').show().find('.mui-card-content').html(errorFileStr2);
                        }

                        let resultDictStr = '';
                        if (!!t_data.resultDictList && t_data.resultDictList.length > 0) {
                            t_data.resultDictList.forEach(function (dict) {
                                resultDictStr += dict.dictName + ','
                            });

                            $('.result_dict').text(resultDictStr.replace(/,$/, ''));
                        }

                        // 关联的关键任务/子任务
                        let connected_t = '';
                        if (t_type == 6) {
                            if (t_data.deptOrProject == 0) {
                                $('.connected_project').show();
                                /*展示项目信息*/
                                $.get('/projectTarget/selectProByTgId', data, function (res) {
                                    let projectData = res.object;
                                    if (projectData) {
                                        $('#projectName').text(projectData.projectName);
                                        $('#projectAbbreviation').text(projectData.projectAbbreviation);
                                        let projectStr = `<div class="mui-row">
																<div class="mui-col-xs-4">
																	<li class="mui-table-view-cell">
																		<span class="left_title">项目类型:</span>
																	</li>
																</div>
																<div class="mui-col-xs-8">
																	<li class="mui-table-view-cell">
																		<span class="left_con">` + function () {
                                            if (projectTypeObj[projectData.projectType]) {
                                                return projectTypeObj[projectData.projectType]
                                            } else {
                                                return '';
                                            }
                                        }() + `</span>
																	</li>
																</div>
															</div>
				                                            <div class="mui-row">
																<div class="mui-col-xs-4">
																	<li class="mui-table-view-cell">
																		<span class="left_title">项目地点:</span>
																	</li>
																</div>
																<div class="mui-col-xs-8">
																	<li class="mui-table-view-cell">
																		<span class="left_con">` + projectData.projectPlace + `</span>
																	</li>
																</div>
															</div>
	                                                        <div class="mui-row">
																<div class="mui-col-xs-4">
																	<li class="mui-table-view-cell">
																		<span class="left_title">中标时间:</span>
																	</li>
																</div>
																<div class="mui-col-xs-8">
																	<li class="mui-table-view-cell">
																		<span class="left_con">` + format(projectData.winningDate) + `</span>
																	</li>
																</div>
															</div>
	                                                        <div class="mui-row">
																<div class="mui-col-xs-4">
																	<li class="mui-table-view-cell">
																		<span class="left_title">责任部门:</span>
																	</li>
																</div>
																<div class="mui-col-xs-8">
																	<li class="mui-table-view-cell">
																		<span class="left_con">` + (projectData.respectiveRegionName || '') + `</span>
																	</li>
																</div>
															</div>
	                                                        <div class="mui-row">
																<div class="mui-col-xs-4">
																	<li class="mui-table-view-cell">
																		<span class="left_title">合同额(万元):</span>
																	</li>
																</div>
																<div class="mui-col-xs-8">
																	<li class="mui-table-view-cell">
																		<span class="left_con">` + projectData.contractMoney + `</span>
																	</li>
																</div>
															</div>
	                                                        <div class="mui-row">
																<div class="mui-col-xs-4">
																	<li class="mui-table-view-cell">
																		<span class="left_title">计划开始时间:</span>
																	</li>
																</div>
																<div class="mui-col-xs-8">
																	<li class="mui-table-view-cell">
																		<span class="left_con">` + format(projectData.statrtTime) + `</span>
																	</li>
																</div>
															</div>
	                                                        <div class="mui-row">
																<div class="mui-col-xs-4">
																	<li class="mui-table-view-cell">
																		<span class="left_title">计划结束时间:</span>
																	</li>
																</div>
																<div class="mui-col-xs-8">
																	<li class="mui-table-view-cell">
																		<span class="left_con">` + format(projectData.endTime) + `</span>
																	</li>
																</div>
															</div>
	                                                        <div class="mui-row">
																<div class="mui-col-xs-4">
																	<li class="mui-table-view-cell">
																		<span class="left_title">合同总工期:</span>
																	</li>
																</div>
																<div class="mui-col-xs-8">
																	<li class="mui-table-view-cell">
																		<span class="left_con">` + projectData.contractDuration + `</span>
																	</li>
																</div>
															</div>
	                                                        <div class="mui-row">
																<div class="mui-col-xs-4">
																	<li class="mui-table-view-cell">
																		<span class="left_title">审批人:</span>
																	</li>
																</div>
																<div class="mui-col-xs-8">
																	<li class="mui-table-view-cell">
																		<span class="left_con">` + (projectData.infoCheckName || '') + `</span>
																	</li>
																</div>
															</div>
	                                                        <div class="mui-row">
																<div class="mui-col-xs-4">
																	<li class="mui-table-view-cell">
																		<span class="left_title">总承包部负责人:</span>
																	</li>
																</div>
																<div class="mui-col-xs-8">
																	<li class="mui-table-view-cell">
																		<span class="left_con">` + (projectData.overallLeaderName || '') + `</span>
																	</li>
																</div>
															</div>
	                                                        <div class="mui-row">
																<div class="mui-col-xs-4">
																	<li class="mui-table-view-cell">
																		<span class="left_title">项目经理:</span>
																	</li>
																</div>
																<div class="mui-col-xs-8">
																	<li class="mui-table-view-cell">
																		<span class="left_con">` + (projectData.projectManageName || '') + `</span>
																	</li>
																</div>
															</div>
	                                                        <div class="mui-row">
																<div class="mui-col-xs-4">
																	<li class="mui-table-view-cell">
																		<span class="left_title">项目经理电话:</span>
																	</li>
																</div>
																<div class="mui-col-xs-8">
																	<li class="mui-table-view-cell">
																		<span class="left_con">` + projectData.projectManagePhone + `</span>
																	</li>
																</div>
															</div>
	                                                        <div class="mui-row">
																<div class="mui-col-xs-4">
																	<li class="mui-table-view-cell">
																		<span class="left_title">业主单位:</span>
																	</li>
																</div>
																<div class="mui-col-xs-8">
																	<li class="mui-table-view-cell">
																		<span class="left_con">` + (projectData.ownerUnitName || '') + `</span>
																	</li>
																</div>
															</div>
                                                            <div class="mui-row">
																<div class="mui-col-xs-4">
																	<li class="mui-table-view-cell">
																		<span class="left_title">业主单位联系方式:</span>
																	</li>
																</div>
																<div class="mui-col-xs-8">
																	<li class="mui-table-view-cell">
																		<span class="left_con">` + projectData.ownerPhone + `</span>
																	</li>
																</div>
															</div>
	                                                        <div class="mui-row">
																<div class="mui-col-xs-4">
																	<li class="mui-table-view-cell">
																		<span class="left_title">监理单位:</span>
																	</li>
																</div>
																<div class="mui-col-xs-8">
																	<li class="mui-table-view-cell">
																		<span class="left_con">` + (projectData.manageUnitName || '') + `</span>
																	</li>
																</div>
															</div>
	                                                        <div class="mui-row">
																<div class="mui-col-xs-4">
																	<li class="mui-table-view-cell">
																		<span class="left_title">业主单位联系方式:</span>
																	</li>
																</div>
																<div class="mui-col-xs-8">
																	<li class="mui-table-view-cell">
																		<span class="left_con">` + projectData.managePhone + `</span>
																	</li>
																</div>
															</div>
	                                                        <div class="mui-row">
																<div class="mui-col-xs-4">
																	<li class="mui-table-view-cell">
																		<span class="left_title">验收标准:</span>
																	</li>
																</div>
																<div class="mui-col-xs-8">
																	<li class="mui-table-view-cell">
																		<span class="left_con">` + projectData.acceptStandard + `</span>
																	</li>
																</div>
															</div>
	                                                        <div class="mui-row">
																<div class="mui-col-xs-4">
																	<li class="mui-table-view-cell">
																		<span class="left_title">施工内容:</span>
																	</li>
																</div>
																<div class="mui-col-xs-8">
																	<li class="mui-table-view-cell">
																		<span class="left_con">` + projectData.workContent + `</span>
																	</li>
																</div>
															</div>`;

                                        $('#connected_project').find('.mui-card-content').html(projectStr);
                                    }
                                });
                            }
                            $.get('/projectTarget/findItemByTgId', data, function (res) {
                                if (res.flag && res.obj && res.obj.length > 0) {
                                    res.obj.forEach(function (task) {
                                        let statusObj = getStatus(task.taskStatus);

                                        connected_t += `<li class="mui-table-view-cell mui-media">
															<a href="javascript:;">
																<img class="mui-media-object mui-pull-left" style="width: 20px; height: 20px;margin-right: 5px;" src="` + statusObj.url + `">
																<div class="mui-media-body">
																	<div style="white-space: normal;">` + isShowNull(task.taskName) + `</div>
																	<p class="mui-ellipsis">起止时间 ` + format(task.planStartDate) + `~` + format(task.planEndDate) + `<span style="float: right;">` + isShowNull(task.planContinuedDate) + `</span></p>
																</div>
															</a>
														</li>`;
                                    });
                                    $('#connected_t').find('.mui-table-view').html(connected_t);
                                }
                            });
                        } else {
                            let targetArr = t_data.tgIds || null;
                            if (!!targetArr && targetArr.length > 0) {
                                targetArr.forEach(function (target) {
                                    let statusObj = getStatus(target.taskStatus);

                                    connected_t += `<li class="mui-table-view-cell mui-media">
															<a href="javascript:;">
																<img class="mui-media-object mui-pull-left" style="width: 20px; height: 20px;margin-right: 5px;" src="` + statusObj.url + `">
																<div class="mui-media-body">
																	<div style="white-space: normal;">` + isShowNull(target.tgName) + `</div>
																	<p class="mui-ellipsis">起止时间 ` + format(target.planStartDate) + `~` + format(target.planEndDate) + `<span style="float: right;">` + isShowNull(target.planContinuedDate) + `</span></p>
																</div>
															</a>
														</li>`;
                                });
                                $('#connected_t').find('.mui-table-view').html(connected_t);
                            }
                        }
                    }
                    // 每日填报信息
                    if (targetTaskData.data && targetTaskData.data.length > 0) {
                        let urgent = targetTaskData.data[0].urgent;
                        let urgentStr = '';
                        if (urgent == 1) {
                            urgentStr = '<span style="color: #ff0000;"><i class="urgent_icon" style="background-color: #ff0000"></i>重要紧急</span>'
                        } else if (urgent == 2) {
                            urgentStr = '<span><i class="urgent_icon" style="background-color: #fac090"></i>重要不紧急</span>'
                        } else if (urgent == 3) {
                            urgentStr = '<span><i class="urgent_icon" style="background-color: #92d050;"></i>不重要紧急</span>'
                        } else if (urgent == 4) {
                            urgentStr = '<span><i class="urgent_icon" style="background-color:#558ed5"></i>不重要不紧急</span>'
                        }
                        $('#urgent').html(urgentStr);
                        let dataStr = '';
                        let resultFileStr2 = '';
                        let unusualFIleStr2 = '';
                        targetTaskData.data.forEach(function (item) {

                            // 成果材料附件
                            let resultFileStr = '';

                            if (!!item.attachmentList && item.attachmentList.length > 0) {
                                let str = '';

                                item.attachmentList.forEach(function (file) {
                                    let attachName = file.attachName;
                                    let fileExtension = attachName.substring(attachName.lastIndexOf(".") + 1, attachName.length);//截取附件文件后缀
                                    let attName = encodeURI(attachName).replace(/\+/g, "%2b").replace(/\@/g, "%40").replace(/#/g, "%23").replace(/\&/g, "%26").replace(/\//g, "%2F").replace(/\?/g, "%3F").replace(/\￥/g, "%ef%bf%a5").replace(/$/g, "%24").replace(/\！/g, "%ef%bc%81").replace(/\（/g, "%ef%bc%88").replace(/\）/g, "%ef%bc%89").replace(/\…/g, "%e2%80%a6%e2%80%a6");
                                    let fileExtensionName = attName.substring(0, attName.lastIndexOf("."));
                                    let attachmentUrl = file.attUrl;
                                    attachmentUrl = attachmentUrl.substring(0, attachmentUrl.lastIndexOf("ATTACHMENT_NAME=")) + "ATTACHMENT_NAME=" + fileExtensionName + "." + fileExtension; //处理附件名字

                                    str += '<a class="operation" onclick="downloadFile(this)" name="' + file.attachName + '" url="/download?' + encodeURI(attachmentUrl) + '">' + file.attachName + '</a>';
                                });

                                resultFileStr = `<div class="mui-row">
                                                        <div class="mui-col-xs-3">
                                                            <li class="mui-table-view-cell">
                                                                <span>成果材料:</span>
                                                            </li>
                                                        </div>
                                                        <div class="mui-col-xs-9">
                                                            <li class="mui-table-view-cell">
                                                                <span>` + str + `</span>
                                                            </li>
                                                        </div>
                                                    </div>`;

                                resultFileStr2 += `<div class="mui-row">
                                                        <div class="mui-col-xs-3">
                                                            <li class="mui-table-view-cell">
                                                                <span>` + format(item.ctreateTime) + `</span>
                                                            </li>
                                                        </div>
                                                        <div class="mui-col-xs-9">
                                                            <li class="mui-table-view-cell">
                                                                <span>` + str + `</span>
                                                            </li>
                                                        </div>
                                                    </div>`;
                            }

                            // 异常原因
                            let unusualReasonStr = '';
                            if (!!item.unusualReason) {
                                unusualReasonStr = `<div class="mui-row">
                                                        <div class="mui-col-xs-3">
                                                            <li class="mui-table-view-cell">
                                                                <span>异常原因:</span>
                                                            </li>
                                                        </div>
                                                        <div class="mui-col-xs-9">
                                                            <li class="mui-table-view-cell">
                                                                <span>` + item.unusualReason + `</span>
                                                            </li>
                                                        </div>
                                                    </div>`;
                            }

                            // 异常原因附件
                            let unusualFIleStr = '';
                            if (!!item.attachmentList2 && item.attachmentList2.length > 0) {
                                let str = '';

                                item.attachmentList2.forEach(function (file) {
                                    let attachName = file.attachName;
                                    let fileExtension = attachName.substring(attachName.lastIndexOf(".") + 1, attachName.length);//截取附件文件后缀
                                    let attName = encodeURI(attachName).replace(/\+/g, "%2b").replace(/\@/g, "%40").replace(/#/g, "%23").replace(/\&/g, "%26").replace(/\//g, "%2F").replace(/\?/g, "%3F").replace(/\￥/g, "%ef%bf%a5").replace(/$/g, "%24").replace(/\！/g, "%ef%bc%81").replace(/\（/g, "%ef%bc%88").replace(/\）/g, "%ef%bc%89").replace(/\…/g, "%e2%80%a6%e2%80%a6");
                                    let fileExtensionName = attName.substring(0, attName.lastIndexOf("."));
                                    let attachmentUrl = file.attUrl;
                                    attachmentUrl = attachmentUrl.substring(0, attachmentUrl.lastIndexOf("ATTACHMENT_NAME=")) + "ATTACHMENT_NAME=" + fileExtensionName + "." + fileExtension; //处理附件名字

                                    str += '<a class="operation" onclick="downloadFile(this)" name="' + file.attachName + '" url="/download?' + encodeURI(attachmentUrl) + '">' + file.attachName + '</a>';
                                });

                                unusualFIleStr = `<div class="mui-row">
                                                        <div class="mui-col-xs-3">
                                                            <li class="mui-table-view-cell">
                                                                <span>异常材料:</span>
                                                            </li>
                                                        </div>
                                                        <div class="mui-col-xs-9">
                                                            <li class="mui-table-view-cell">
                                                                <span>` + str + `</span>
                                                            </li>
                                                        </div>
                                                    </div>`;

                                unusualFIleStr2 += `<div class="mui-row">
                                                        <div class="mui-col-xs-3">
                                                            <li class="mui-table-view-cell">
                                                                <span>` + format(item.ctreateTime) + `</span>
                                                            </li>
                                                        </div>
                                                        <div class="mui-col-xs-9">
                                                            <li class="mui-table-view-cell">
                                                                <span>` + str + `</span>
                                                            </li>
                                                        </div>
                                                    </div>`;
                            }

                            dataStr += `<div class="mui-card">
                                                <div class="mui-card-content">
                                                    <div class="mui-row">
                                                        <div class="mui-col-xs-3">
                                                            <li class="mui-table-view-cell">
                                                                <span>填报人:</span>
					                                        </li>
					                                    </div>
				                                    <div class="mui-col-xs-3">
                                                        <li class="mui-table-view-cell">
                                                            <span>` + isShowNull(item.ctreateUserName).replace(/,$/, '') + `</span>
                                                        </li>
                                                    </div>
                                                    <div class="mui-col-xs-2">
					                                    <li class="mui-table-view-cell">
					                                        <span>时间:</span>
					                                    </li>
					                                    </div>
				                                    <div class="mui-col-xs-4">
					                                    <li class="mui-table-view-cell">
					                                        <span>` + format(item.ctreateTime) + `</span>
					                                    </li>
                                                    </div>
                                                </div>
			                                    <div class="mui-row">
				                                    <div class="mui-col-xs-3">
					                                    <li class="mui-table-view-cell">
					                                        <span>协作人:</span>
					                                    </li>
				                                    </div>
				                                    <div class="mui-col-xs-3">
					                                    <li class="mui-table-view-cell">
					                                        <span>` + isShowNull(item.assistUserName).replace(/,$/, '') + `</span>
					                                    </li>
				                                    </div>
				                                    <div class="mui-col-xs-2">
					                                    <li class="mui-table-view-cell">
					                                        <span>完成量:</span>
					                                    </li>
				                                    </div>
				                                    <div class="mui-col-xs-4">
					                                    <li class="mui-table-view-cell">
						                                    <span>` + function () {
                                if (item.assistUserName || item.transfer) {
                                    return '—';
                                } else {
                                    return item.tadayProgress + '%';
                                }
                            }() + `</span>
					                                    </li>
				                                    </div>
			                                    </div>
			                                    <div class="mui-row">
				                                    <div class="mui-col-xs-3">
					                                    <li class="mui-table-view-cell">
					                                        <span>转办:</span>
					                                    </li>
				                                    </div>
				                                    <div class="mui-col-xs-9">
					                                    <li class="mui-table-view-cell">
					                                        <span>` + isShowNull(item.transferName).replace(/,$/, '') + `</span>
					                                    </li>
				                                    </div>
			                                    </div>
			                                    <div class="mui-row">
				                                    <div class="mui-col-xs-3">
					                                    <li class="mui-table-view-cell">
					                                        <span>进展日志:</span>
					                                    </li>
				                                    </div>
				                                    <div class="mui-col-xs-9">
					                                    <li class="mui-table-view-cell">
					                                        <span>` + isShowNull(item.tadayDesc) + `</span>
					                                    </li>
				                                    </div>
			                                    </div>` + resultFileStr + unusualReasonStr + unusualFIleStr + `
											</div></div>`;
                        });
                        $('#dailyReport').html(dataStr);

                        // 阶段成果材料
                        if (!!resultFileStr2) {
                            $('#periodResult').show().find('.mui-card-content').html(resultFileStr2);
                        }

                        // 阶段异常材料
                        if (!!unusualFIleStr2) {
                            $('#periodUnusual').show().find('.mui-card-content').html(unusualFIleStr2);
                        }
                    }

                    $fixedEle = $("#connectedHead");
                    pos = $fixedEle.offset();

                }

                // 点击-今日
                $('#today').on('click', function () {
                    //判断是否已经提交审核过了，提交审核过后按钮不可操作
                    let itemApprivalStatus = t_data.itemApprivalStatus;
                    if (itemApprivalStatus == 1 || itemApprivalStatus == 2 || itemApprivalStatus == 3 || itemApprivalStatus === '0') {
                        return false;
                    }
                    $('#content').hide();
                    $('#todayModule').find('.complete_quantity_text').text($('#completeQuantityNum').val());
                    $('#todayModule').show();
                });
                // 点击-提交审核
                $('#submit').on('click', function () {
                    //判断是否已经提交审核过了，提交审核过后按钮不可操作
                    let itemApprivalStatus = t_data.itemApprivalStatus;
                    if (itemApprivalStatus == 1 || itemApprivalStatus == 2 || itemApprivalStatus == 3 || itemApprivalStatus === '0') {
                        return false;
                    }
                    let checkUrl = '';
                    if (t_type == 6) {
                        checkUrl = '/projectTarget/checkDutyUser';
                    } else {
                        checkUrl = '/plcProjectItem/checkDutyUser';
                    }
                    $.get(checkUrl, {id: id}, function (res) {
                        if (res.flag && res.code == 1) {
                            $('#content').hide();
                            $('#checkModule').show();
                        } else {
                            return false;
                        }
                    });
                });
                // 点击-增加协作人
                $('#collaborator').on('click', async function () {
                    //只有当前登录人是负责人才可增加协作人
                    let isSubmit = await isCheck();

                    if (isSubmit) {
                        return false;
                    }

                    //判断是否已经提交审核过了，提交审核过后按钮不可操作
                    let itemApprivalStatus = t_data.itemApprivalStatus;
                    if (itemApprivalStatus == 1 || itemApprivalStatus == 2 || itemApprivalStatus == 3 || itemApprivalStatus === '0') {
                        return false;
                    }
                    layer.open({
                        type: 1,
                        title: '增加协作人',
                        area: ['100%', '60%'],
                        btn: ['确定', '取消'],
                        content: '<div style="padding: 20px;">' +
                            '                    <label><span style="color: red;">*</span>协作人</label>' +
                            '                    <div>' +
                            '                        <textarea id="resUser" user_id="" readonly style="background: #e7e7e7"></textarea>' +
                            '                    </div><div style="text-align: right;padding-right: 50px;">' +
                            '                    <a href="javascript:;" style="color:#1E9FFF" class="add">添加</a>' +
                            '                    <a href="javascript:;" style="color:#1E9FFF" class="execute">清空</a>' +
                            '                </div></div>',
                        success: function () {
                            $('.add').on('click', function () {
                                user_id = "resUser";
                                $.popWindow("/common/selectUser");
                            });
                            $('.execute').click(function () {
                                $("#resUser").val("");
                                $("#resUser").attr('user_id', '');
                            });
                        },
                        yes: function (index) {
                            if (!$('#resUser').val()) {
                                layer.msg('请选择协作人！', {icon: 0, time: 1500});
                                return false;
                            }
                            let url = '';
                            let dataPer = {ids: id, assistUser: $('#resUser').attr('user_id')};
                            if (t_type == 6) {
                                url = '/projectTarget/addPeople';
                            } else {
                                url = '/plcProjectItem/addPeople';
                            }

                            fetchAjax(url, dataPer).then(res => {
                                if (res.flag) {
                                    layer.msg('保存成功！', {icon: 1, time: 1500}, function () {
                                        initData();
                                        layer.close(index);
                                    });
                                } else {
                                    layer.msg('保存失败！', {icon: 2, time: 1500});
                                }
                            }).catch(err => {
                                layer.msg('保存失败！', {icon: 2, time: 1500});
                            });
                        }
                    });
                });
                // 点击-转办
                $('#transfer').on('click', async function () {
                    // 只有当前登录人是负责人才可增加协作人
                    let isSubmit = await isCheck();
                    if (isSubmit) {
                        return false;
                    }
                    //判断是否已经提交审核过了，提交审核过后按钮不可操作
                    let itemApprivalStatus = t_data.itemApprivalStatus;
                    if (itemApprivalStatus == 1 || itemApprivalStatus == 2 || itemApprivalStatus == 3 || itemApprivalStatus === '0') {
                        return false;
                    }
                    layer.open({
                        type: 1,
                        title: '转办',
                        area: ['100%', '60%'],
                        btn: ['确定', '取消'],
                        content: '<div style="padding: 20px;">' +
                            '                    <label><span style="color: red;">*</span>责任人</label>' +
                            '                    <div>' +
                            '                        <textarea id="transferUser" user_id="" readonly style="background: #e7e7e7"></textarea>' +
                            '                    </div><div style="text-align: right;padding-right: 50px;">' +
                            '                    <a href="javascript:;" style="color:#1E9FFF" class="add">添加</a>' +
                            '                    <a href="javascript:;" style="color:#1E9FFF" class="execute">清空</a>' +
                            '                </div></div>',
                        success: function () {
                            $('.add').on('click', function () {
                                user_id = "transferUser";
                                $.popWindow("/common/selectUser");
                            });
                            $('.execute').click(function () {
                                $("#transferUser").val("");
                                $("#transferUser").attr('user_id', '');
                            });
                        },
                        yes: function (index) {
                            if (!$('#transferUser').val()) {
                                layer.msg('请选择责任人！', {icon: 0});
                                return false;
                            }
                            let url = '';
                            let dataPer = {ids: id, dutyUser: $('#transferUser').attr('user_id')};
                            if (t_type == 6) {
                                url = '/projectTarget/changeDutyUser';
                            } else {
                                url = '/plcProjectItem/changeDutyUser';
                            }

                            fetchAjax(url, dataPer).then(res => {
                                if (res.flag) {
                                    layer.msg('转办成功！', {icon: 1, time: 1500}, function () {
                                        if (( /(iPhone|iPad|iPod|iOS)/i.test(navigator.userAgent) )) {
											try{
												window.webkit.messageHandlers.finishWork.postMessage({});
											}catch(err){
												finishWork();
											}
                                        } else if (/(Android)/i.test(navigator.userAgent)) {
                                            Android.finishWebActivity();
                                        }
                                    });
                                } else {
                                    layer.msg('转办失败！', {icon: 2, time: 1500});
                                }
                            }).catch(err => {
                                layer.msg('转办失败！', {icon: 2, time: 1500});
                            });
                        }
                    });
                });
                // 返回
                $('.back').on('click', function () {
                    $('#content').show();
                    $('#todayModule').hide();
                    $('#checkModule').hide();

                    // 清空数据
                    $('.tadayProgress').val('');
                    $('.unusualReason').val('');
                    $('.tadayDesc').val('');
                    $('.doStatus').val('1');
                    $('#remind').prop('checked', true);
                    $('#smsRemind').prop('checked', false);
                    $('.files_box').empty();

                });
                // 保存今日填报
                $('#saveToday').on('click', function () {
                    try {
                        let loadingIndex = layer.load(0);
                        if ($('#todayModule .tadayProgress').val() == '') {
                            layer.msg('请填写今日完成量!', {time: 1500});
                            layer.close(loadingIndex);
                            return false
                        }

                        let completeQuantity = parseInt($('#todayModule .tadayProgress').val()) + parseInt($('#completeQuantityNum').val());

                        if (completeQuantity > 100) {
                            layer.msg('今日完成量和累计完成百分比相加不能超过100', {time: 1500});
                            layer.close(loadingIndex);
                            return false;
                        }

                        if ($('#todayModule .tadayDesc').val() == '') {
                            layer.msg('请填写进展情况!', {time: 1500});
                            layer.close(loadingIndex);
                            return false
                        }
                        let obj = {}
                        //成果附件
                        let attachmentId = '';
                        let attachmentName = '';
                        let $resultFileEles = $('#todayModule .result_file_box').find('a');
                        if ($resultFileEles.length > 0) {
                            $resultFileEles.each(function () {
                                let fileName = $(this).attr('name');
                                let attUrl = $(this).attr('url').split('?')[1];
                                let aId = getUrlString('AID', attUrl);
                                let fileAttachmentId = getUrlString('ATTACHMENT_ID', attUrl);
                                let ym = getUrlString('YM', attUrl);
                                let id = aId + '@' + ym + '_' + fileAttachmentId;
                                attachmentId += id + ',';
                                attachmentName += fileName + '*';
                            });
                        }
                        //异常支撑材料
                        let attachmentId2 = '';
                        let attachmentName2 = '';
                        let $unusualFileEles = $('#todayModule .unusual_file_box').find('a');
                        if ($unusualFileEles.length > 0) {
                            $unusualFileEles.each(function () {
                                let fileName = $(this).attr('name');
                                let attUrl = $(this).attr('url').split('?')[1];
                                let aId = getUrlString('AID', attUrl);
                                let fileAttachmentId = getUrlString('ATTACHMENT_ID', attUrl);
                                let ym = getUrlString('YM', attUrl);
                                let id = aId + '@' + ym + '_' + fileAttachmentId;
                                attachmentId2 += id + ',';
                                attachmentName2 += fileName + '*';
                            });
                        }
                        obj.taskName = $('.t_name').text();
                        obj.attachmentId = attachmentId;
                        obj.attachmentName = attachmentName;
                        obj.attachmentId2 = attachmentId2;
                        obj.attachmentName2 = attachmentName2;
                        obj.completeQuantity = completeQuantity; //累计完成量
                        obj.tadayProgress = parseInt($('#todayModule .tadayProgress').val());//今日完成量
                        obj.unusualReason = $('#todayModule .unusualReason').val(); //异常原因
                        obj.tadayDesc = $('#todayModule .tadayDesc').val();  //进展情况
                        obj.doStatus = $('#todayModule .doStatus').val(); //进展状态

                        if (t_type == 6) {
                            obj.tgId = id;
                        } else {
                            obj.planItemId = id;
                        }

                        $.post('/ProjectDaily/submit', obj, function (res) {
                            layer.close(loadingIndex);
                            if (res.flag) {
                                layer.msg('保存成功！', {icon: 1, time: 1000}, function () {
                                    $('.back').trigger('click');
                                    initData();
                                });
                            } else {
                                layer.msg('保存失败！', {icon: 2});
                            }
                        });
                    } catch (e) {
                        layer.closeAll();
                    }

                });
                // 确认提交审核
                $('#submitCheck').on('click', async function () {

                    let loadingIndex = layer.load(0);

                    // 成果附件
                    let attachmentId2 = '';
                    let attachmentName2 = '';

                    // 异常支撑材料
                    let attachmentId3 = '';
                    let attachmentName3 = '';

                    let updateData = {
                        taskPrecess: $('.completeQuantity').text(),
                        attachmentId2: attachmentId2,
                        attachmentName2: attachmentName2,
                        attachmentId3: attachmentId3,
                        attachmentName3: attachmentName3,
                        itemApprivalStatus: 0,
                        taskStatus: 5,
                        unusualRes: $('#checkModule .unusualReason').val()
                    }

                    // 事务提醒
                    if ($('#remind').prop('checked')) {
                        updateData.remind = 1;
                    } else {
                        updateData.remind = 0;
                    }
                    // 短信提醒
                    if ($('#smsRemind').prop('checked')) {
                        updateData.smsRemind = 1;
                    } else {
                        updateData.smsRemind = 0;
                    }

                    let updateUrl = '';

                    if (t_type == 6) {
                        updateUrl = '/projectTarget/submit';
                        updateData.tgId = id;
                        // 判断是否为主项关键任务
                        if (t_data.deptOrProject == '0') {
                            updateData.deptId = await getDeptId();
                            updateData.planClass = 1;
                        } else {
                            updateData.deptId = t_data.targetBelongDept;
                            updateData.planClass = 2;
                        }
                    } else {
                        updateUrl = '/plcProjectItem/submit';
                        updateData.planItemId = id;
                        updateData.deptId = t_data.itemBelongDept;
                        updateData.planClass = 3;
                    }

                    fetchAjax(updateUrl, updateData, 'POST').then(res => {
                        layer.close(loadingIndex);
                        if (res.flag) {
                            layer.msg('提交审核成功', {icon: 1, time: 1500}, function () {
                                if (( /(iPhone|iPad|iPod|iOS)/i.test(navigator.userAgent) )) {
									try{
										window.webkit.messageHandlers.finishWork.postMessage({});
									}catch(err){
										finishWork();
									}
                                } else if (/(Android)/i.test(navigator.userAgent)) {
                                    Android.finishWebActivity();
                                }
                            });
                        } else {
                            layer.msg('提交审核失败', {icon: 2, time: 1500});
                        }
                    }).catch(err => {
                        layer.close(loadingIndex);
                        layer.msg('提交审核失败', {icon: 2, time: 1500});
                    });
                });

                // 监听键盘事件，只能输入数字
                $(document).on('keypress', '.number_input', function (e) {
                    var key = window.event ? e.keyCode : e.which;

                    if (!((key > 95 && key < 106) || (key > 47 && key < 58) || key == 8 || key == 9 || key == 13 || key == 37 || key == 39)) {
                        return false;
                    }
                });
                // 监听输入内容
                $(document).on('input propertychange', '.number_input', function () {
                    var completeQuantityNum = parseInt($('#completeQuantityNum').val() || 0);
                    var value = parseInt($(this).val());
                    if (isNaN(value)) {
                        $(this).val('');
                    } else {
                        var total = completeQuantityNum + value;
                        if (total > 100) {
                            $(this).val(100);
                            $('#todayModule').find('.complete_quantity_text').text(100);
                        } else {
                            $(this).val(value);
                            $('#todayModule').find('.complete_quantity_text').text(total);
                        }
                    }
                });

                if (( /(iPhone|iPad|iPod|iOS)/i.test(navigator.userAgent) )) {
                    $('#connectedHead').addClass('sticky');
                } else {
                    $(window).scroll(function () {
                        if ($(this).scrollTop() > (pos.top - 10)) {
                            $fixedEle.addClass('fixed');
                            $('#connectedBody').css('margin-top', '72px');
                        } else if ($(this).scrollTop() < pos.top) {
                            $fixedEle.removeClass('fixed');
                            $('#connectedBody').css('margin-top', '0');
                        }
                    });
                }

                mui.init();

            });

            //判断是否显示空
            function isShowNull(data) {
                if (!!data) {
                    return data;
                } else {
                    return '';
                }
            }

            //将毫秒数转为yyyy-MM-dd格式时间
            function format(t) {
                if (t) {
                    return new Date(t).Format("yyyy-MM-dd");
                } else {
                    return '';
                }
            }

            /**
             * 获取关键任务/子任务状态
             * @param status
             * @returns {{value: string, url: string}}
             */
            function getStatus(status) {
                var statusObj = {value: '', url: ''}
                if (!!status) {
                    if (status == '0') {
                        statusObj.value = '未开始';
                        statusObj.url = '/img/planCheck/planProgressReport/not_started.png';
                    } else if (status == '1') {
                        statusObj.value = '进行中';
                        statusObj.url = '/img/planCheck/planProgressReport/underway.png';
                    } else if (status == '2') {
                        statusObj.value = '将到期';
                        statusObj.url = '/img/planCheck/planProgressReport/delay_underway.png';
                    } else if (status == '4') {
                        statusObj.value = '已延期';
                        statusObj.url = '/img/planCheck/planProgressReport/out_underway.png';
                    } else if (status == '7') {
                        statusObj.value = '暂停';
                        statusObj.url = '/img/planCheck/planProgressReport/suspend.png';
                    } else if (status == '5') {
                        statusObj.value = '完成';
                        statusObj.url = '/img/planCheck/planProgressReport/complete.png';
                    } else if (status == '6') {
                        statusObj.value = '延期完成';
                        statusObj.url = '/img/planCheck/planProgressReport/delay_complete.png';
                    } else if (status == '9') {
                        statusObj.value = '成果不符';
                        statusObj.url = '/img/planCheck/planProgressReport/result_default.png';
                    } else if (status == '8') {
                        statusObj.value = '关闭';
                        statusObj.url = '/img/planCheck/planProgressReport/closed.png';
                    }
                }
                return statusObj;
            }

            /**
             * 判断当前登录人在关键任务中的对应部门
             * @returns {Promise<unknown>}
             */
            async function getDeptId() {
                let deptId = '';

                let userId = $('#userId').val();

                if (!userId) {
                    let data = await fetchAjax('/getLoginUser');

                    userId = data.object.userId;
                }

                if (t_data.dutyUser && t_data.dutyUser.replace(/,$/, '') == userId) {
                    deptId = t_data.mainCenterDept;
                } else if (t_data.mainAreaUser && t_data.mainAreaUser.replace(/,$/, '') == userId) {
                    deptId = t_data.mainAreaDept;
                } else if (t_data.mainProjectUser && t_data.mainProjectUser.replace(/,$/, '') == userId) {
                    deptId = t_data.mainProjectDept;
                }

                return new Promise((resolve, reject) => {
                    resolve(deptId);
                });
            }

            /**
             * 判断是否可以提交审核--返回true是不可以提交审核
             * @returns {Promise<unknown>}
             */
            async function isCheck() {
                let isOk = false;
                let urlSubmit = '';
                if (t_type == 6) {
                    urlSubmit = '/projectTarget/checkDutyUser';
                } else {
                    urlSubmit = '/plcProjectItem/checkDutyUser';
                }

                let data = await fetchAjax(urlSubmit, {id: id});

                if (data.flag && data.code != 1) {
                    isOk = true;
                }

                userId = data.object.userId;

                return new Promise((resolve, reject) => {
                    resolve(isOk);
                });
            }

            /**
             * Promise封装ajax
             * @param url (请求接口)
             * @param param (请求参数)
             * @param type (请求类型,默认GET)
             * @returns {Promise<unknown>}
             */
            let fetchAjax = (url, param = {}, type = 'GET') => {
                return new Promise((resolve, reject) => {
                    $.ajax({
                        type: type,
                        url: url,
                        data: param,
                        dataType: 'json',
                        success: function (res) {
                            resolve(res);
                        },
                        error: function (err) {
                            reject(err);
                        }
                    });
                });
            }

            // 下载附件
            function downloadFile(e) {
                var url = $(e).attr('url');
                var name = $(e).attr('name');
                if (( /(iPhone|iPad|iPod|iOS)/i.test(navigator.userAgent) )) {
					try{
						window.webkit.messageHandlers.overLookFile.postMessage({'url':url,'name':name});
					}catch(error){
						overLookFile(url,name);
					}
                } else if (/(Android)/i.test(navigator.userAgent)) {
                    Android.overLookFile(url, name);
                } else {
                    window.open(url);
                }
            }

            let $fileBoxEle = null;

            // 上传附件
            function uploadFile(e) {
                $fileBoxEle = $(e).siblings('.files_box');
                if (( /(iPhone|iPad|iPod|iOS)/i.test(navigator.userAgent) )) {
					try{
						window.webkit.messageHandlers.addImage.postMessage({'function':'addFile','num':'0'});
					}catch(err){
						addImage('addFile', 0);
					}
                } else if (/(Android)/i.test(navigator.userAgent)) {
                    Android.addImage('addFile', 0);
                }
            }

            /**
             * 上传完后回调函数
             * @param files (文件的url字符串)
             * @param names (文件名的字符串)
             * @param type (1-图片)
             */
            function addFile(files, names, type) {
                let urlArr = (files || '').replace(/,$/, '').split(',');
                let nameArr = (names || '').replace(/,$/, '').split(',');
                let fileStr = '';

                if (nameArr.length > 0) {
                    nameArr.forEach(function (name, index) {
                        if (!!name) {
                            let url = urlArr[index];
                            fileStr += '<p><a onclick="downloadFile(this)" name="' + name + '" url="' + url + '">' + name + '</a></p>';
                        }
                    });
                }

                $fileBoxEle.append(fileStr);
            }

            /**
             * 获取url参数
             * @param name (参数名)
             * @param url
             * @returns {string}
             */
            function getUrlString(name, url) {
                let reg = new RegExp("(^|&)" + name + "=([^&]*)(&|$)", "i");
                re = new RegExp("amp;", "g"); //定义正则表达式
                let r = url.match(reg);
                var context = "";
                if (r != null) {
                    context = r[2];
                }
                reg = null;
                r = null;
                return context == null || context == "" || context == "undefined" ? "" : context;
            }
		
		</script>
	</body>
</html>