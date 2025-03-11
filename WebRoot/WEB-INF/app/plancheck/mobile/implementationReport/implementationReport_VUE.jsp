<%--
  Created by IntelliJ IDEA.
  User: 戎成路
  Date: 2020/9/11
  Time: 9:23
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@taglib prefix="mvc" uri="http://www.springframework.org/tags/form" %>
<%@taglib prefix="fmt" uri="http://www.springframework.org/tags" %>
<%@ page import="java.util.*" %>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
	Long datetime = new Date().getTime(); // 获取系统时间
%>
<html lang="zh-cn">
	<head>
		<title>执行填报</title>
		
		<meta charset="UTF-8"/>
		<meta name="viewport" content="width=device-width,initial-scale=1,minimum-scale=1,maximum-scale=1,user-scalable=no"/>
		<link rel="stylesheet" href="/lib/antDesign/antd.min.css">
		
		<script src="/js/xoajq/xoajq1.js"></script>
		<script src="/js/base/base.js?<%=datetime%>"></script>
		<script src="/lib/antDesign/vue.min.js?<%=datetime%>"></script>
		<script src="/lib/antDesign/moment.js?<%=datetime%>"></script>
		<script src="/lib/antDesign/antd.min.js?<%=datetime%>"></script>
		
		<style>
			.content {
				position: relative;
				overflow: hidden;
			}
			
			.head_button {
				padding: 5px 0;
				text-align: center;
			}
			
			.t_content .ant-col {
				padding: 5px 9px;
			}
			
			.ant-tabs-nav .ant-tabs-tab {
				height: auto;
			}
			
			.ant-page-header-content {
				padding: 0;
			}
			
			.ant-card-body {
				padding: 10px;
			}
			
			.ant-card-small > .ant-card-body {
				padding: 10px;
			}
			
			.ant-drawer-wrapper-body {
				padding-top: 55px;
			}
			
			.ant-drawer-header {
				position: fixed;
				top: 0;
				width: 100%;
				z-index: 3;
			}
			
			.ant-drawer-body {
				overflow-x: hidden;
			}
			
			#todayModule .ant-row {
				padding: 5px 0;
			}
			
			#submitCheckModule .ant-row {
				padding: 5px 0;
			}
		
		</style>
		
	</head>
	<body>
		<div id="app">
			<div class="content" v-if="t_data">
				<div class="head_button" v-show="!isItemApprivalStatus">
					<a-button type="primary" :disabled="isItemApprivalStatus" @click="todayModuleToggle(true)">今日</a-button>
					<a-button type="primary" :disabled="isSubmit || isItemApprivalStatus" @click="collaboratorModuleToggle(true)">增加协作人</a-button>
					<a-button type="primary" :disabled="isSubmit || isItemApprivalStatus" @click="transferModuleToggle(true)">转办</a-button>
					<a-button type="primary" :disabled="isSubmit || isItemApprivalStatus" @click="submitCheckModuleToggle(true)">提交审核</a-button>
				</div>
				<div class="t_content">
					<a-row>
						<a-col :span="8">名称:</a-col>
						<a-col :span="16" v-text="t_type == 6 ? t_data.tgName : t_data.taskName"></a-col>
					</a-row>
					<a-row>
						<a-col :span="8">累计完成百分比:</a-col>
						<a-col :span="16" style="padding: 9px">
							<a-progress :percent="isShowNull(t_data.leiJi)" size="small" status="active"/>
						</a-col>
					</a-row>
					<a-row>
						<a-col :span="8">计划结束日期:</a-col>
						<a-col :span="16" v-text="format(t_data.planEndDate)"></a-col>
					</a-row>
					<a-row>
						<a-col :span="8">紧急程度:</a-col>
						<a-col :span="16" v-show="urgentObj.flag">
							<a-tag :color="urgentObj.color" v-text="urgentObj.value"></a-tag>
						</a-col>
					</a-row>
					<a-row>
						<a-col :span="8">完成标准:</a-col>
						<a-col :span="16" v-text="isShowNull(t_data.resultStandard)"></a-col>
					</a-row>
					<a-row>
						<a-col :span="8">需提交的成果材料:</a-col>
						<a-col :span="16" v-show="resultFileObj.flag">
							<a style="display: block;" v-for="file in resultFileObj.fileList" :key="file.key"
							   @click="downloadFile($event, file.url, file.attachName)"
							   v-text="file.attachName"></a>
						</a-col>
					</a-row>
					<a-row v-show="errorFileObj.flag && errorFileObj.reason != ''">
						<a-col :span="8">异常原因:</a-col>
						<a-col :span="16" v-text="errorFileObj.reason"></a-col>
					</a-row>
					<a-row v-show="errorFileObj.flag">
						<a-col :span="8">异常原因材料:</a-col>
						<a-col :span="16">
							<a style="display: block;" v-for="file in errorFileObj.fileList" :key="file.key"
							   @click="downloadFile($event, file.url, file.attachName)"
							   v-text="file.attachName"></a>
						</a-col>
					</a-row>
				</div>
				<div class="connected_info" style="margin-bottom: 20px;">
					<a-page-header
							style="padding: 10px; border: 1px solid rgb(235, 237, 240)"
							title="相关信息"/>
					<a-tabs default-active-key="1">
						<a-tab-pane key="1" tab="每日填报">
							<template v-if="connectedInfoList == 0">
								<a-empty/>
							</template>
							<template v-else>
								<a-list :grid="{ gutter: 12, xs: 1}" :data-source="connectedInfoList">
									<a-list-item slot="renderItem" slot-scope="item, index">
										<a-card>
											<a-row style="padding: 2px 0;">
												<a-col :span="5">填报人:</a-col>
												<a-col :span="7" v-text="item.ctreateUserName"></a-col>
												<a-col :span="4">时间:</a-col>
												<a-col :span="8" v-text="item.ctreateTime"></a-col>
											</a-row>
											<a-row style="padding: 2px 0;">
												<a-col :span="5">协作人:</a-col>
												<a-col :span="7" v-text="item.assistUserName"></a-col>
												<a-col :span="4">完成量:</a-col>
												<a-col :span="8" style="padding: 5px 0;">
													<a-progress :percent="item.tadayProgress" size="small" status="active"/>
												</a-col>
											</a-row>
											<a-row style="padding: 2px 0;">
												<a-col :span="5">转办:</a-col>
												<a-col :span="19" v-text="item.transferName"></a-col>
											</a-row>
											<a-row style="padding: 2px 0;">
												<a-col :span="5">进展日志:</a-col>
												<a-col :span="19" v-text="item.tadayDesc"></a-col>
											</a-row>
											<a-row v-show="item.resultFileObj.flag" style="padding: 2px 0;">
												<a-col :span="5">成果材料:</a-col>
												<a-col :span="19">
													<a style="display: block;" v-for="file in item.resultFileObj.fileList" :key="file.key"
													   @click="downloadFile($event, file.url, file.attachName)"
													   v-text="file.attachName"></a>
												</a-col>
											</a-row>
											<a-row v-if="item.unusualReason" style="padding: 2px 0;">
												<a-col :span="5">异常原因:</a-col>
												<a-col :span="19" v-text="item.unusualReason"></a-col>
											</a-row>
											<a-row v-show="item.unusualFIleObj.flag" style="padding: 2px 0;">
												<a-col :span="5">异常材料:</a-col>
												<a-col :span="19">
													<a style="display: block;" v-for="file in item.unusualFIleObj.fileList" :key="file.key"
													   @click="downloadFile($event, file.url, file.attachName)"
													   v-text="file.attachName"></a>
												</a-col>
											</a-row>
										</a-card>
									</a-list-item>
								</a-list>
							</template>
						</a-tab-pane>
						<a-tab-pane key="2" tab="附件">
							<template v-if="!resultFileObj.flag && !errorFileObj.flag && !dailyResultFileFlag && !dailyUnusualFileFlag">
								<a-empty/>
							</template>
							<template v-else>
								<a-card v-show="resultFileObj.flag" size="small" style="margin-bottom: 16px;">
									<a-card-meta title="最终成果(成果材料)"></a-card-meta>
									<div style="padding-top: 5px;">
										<a-row v-for="file in resultFileObj.fileList" :key="file.key" style="padding: 2px 0;">
											<a-col :span="24">
												<a style="display: block;"
												   @click="downloadFile($event, file.url, file.attachName)"
												   v-text="file.attachName"></a>
											</a-col>
										</a-row>
									</div>
								</a-card>
								<a-card v-show="errorFileObj.flag" size="small" style="margin-bottom: 16px;">
									<a-card-meta title="最终成果(异常材料)"></a-card-meta>
									<div style="padding-top: 5px;">
										<a-row v-for="file in errorFileObj.fileList" :key="file.key" style="padding: 2px 0;">
											<a-col :span="24">
												<a style="display: block;"
												   @click="downloadFile($event, file.url, file.attachName)"
												   v-text="file.attachName"></a>
											</a-col>
										</a-row>
									</div>
								</a-card>
								<a-card v-show="dailyResultFileFlag" size="small" style="margin-bottom: 16px;">
									<a-card-meta title="阶段成果(成果材料)"></a-card-meta>
									<div style="padding-top: 5px;">
										<a-row v-for="item in connectedInfoList" :key="item.id" style="padding: 2px 0;">
											<div v-show="item.resultFileObj.flag">
												<a-col :span="8" v-text="item.ctreateTime"></a-col>
												<a-col :span="16">
													<a style="display: block;" v-for="file in item.resultFileObj.fileList"
													   :key="file.key"
													   @click="downloadFile($event, file.url, file.attachName)"
													   v-text="file.attachName"></a>
												</a-col>
											</div>
										</a-row>
									</div>
								</a-card>
								<a-card v-show="dailyUnusualFileFlag" size="small" style="margin-bottom: 16px;">
									<a-card-meta title="阶段成果(异常材料)"></a-card-meta>
									<div style="padding-top: 5px;">
										<a-row v-for="item in connectedInfoList" :key="item.id" style="padding: 2px 0;">
											<div v-show="item.unusualFIleObj.flag">
												<a-col :span="8" v-text="item.ctreateTime"></a-col>
												<a-col :span="16">
													<a style="display: block;" v-for="file in item.unusualFIleObj.fileList" :key="file.key"
													   @click="downloadFile($event, file.url, file.attachName)"
													   v-text="file.attachName"></a>
												</a-col>
											</div>
										</a-row>
									</div>
								</a-card>
							</template>
						</a-tab-pane>
						<a-tab-pane v-if="t_type == 6 && t_data.deptOrProject == '0'" key="3" tab="项目">
							<a-card size="small">
								<a-card-meta :title="projectData.projectName" :description="projectData.projectAbbreviation"></a-card-meta>
								<div style="padding-top: 5px;">
									<a-row>
										<a-col :span="8">项目类型:</a-col>
										<a-col :span="16" v-text="isShowNull(projectTypeObj[projectData.projectType])"></a-col>
									</a-row>
									<a-row>
										<a-col :span="8">项目地点:</a-col>
										<a-col :span="16" v-text="isShowNull(projectData.projectPlace)"></a-col>
									</a-row>
									<a-row>
										<a-col :span="8">中标时间:</a-col>
										<a-col :span="16" v-text="format(projectData.winningDate)"></a-col>
									</a-row>
									<a-row>
										<a-col :span="8">责任部门:</a-col>
										<a-col :span="16" v-text="isShowNull(projectData.respectiveRegionName)"></a-col>
									</a-row>
									<a-row>
										<a-col :span="8">合同额(万元):</a-col>
										<a-col :span="16" v-text="isShowNull(projectData.contractMoney)"></a-col>
									</a-row>
									<a-row>
										<a-col :span="8">计划开始时间:</a-col>
										<a-col :span="16" v-text="format(projectData.statrtTime)"></a-col>
									</a-row>
									<a-row>
										<a-col :span="8">计划结束时间:</a-col>
										<a-col :span="16" v-text="format(projectData.endTime)"></a-col>
									</a-row>
									<a-row>
										<a-col :span="8">合同总工期:</a-col>
										<a-col :span="16" v-text="isShowNull(projectData.contractDuration)"></a-col>
									</a-row>
									<a-row>
										<a-col :span="8">审批人:</a-col>
										<a-col :span="16" v-text="isShowNull(projectData.infoCheckName)"></a-col>
									</a-row>
									<a-row>
										<a-col :span="8">总承包部负责人:</a-col>
										<a-col :span="16" v-text="isShowNull(projectData.overallLeaderName)"></a-col>
									</a-row>
									<a-row>
										<a-col :span="8">项目经理:</a-col>
										<a-col :span="16" v-text="isShowNull(projectData.projectManageName)"></a-col>
									</a-row>
									<a-row>
										<a-col :span="8">项目经理电话:</a-col>
										<a-col :span="16" v-text="isShowNull(projectData.projectManagePhone)"></a-col>
									</a-row>
									<a-row>
										<a-col :span="8">业主单位:</a-col>
										<a-col :span="16" v-text="isShowNull(projectData.ownerUnitName)"></a-col>
									</a-row>
									<a-row>
										<a-col :span="8">业主单位联系方式:</a-col>
										<a-col :span="16" v-text="isShowNull(projectData.ownerPhone)"></a-col>
									</a-row>
									<a-row>
										<a-col :span="8">监理单位:</a-col>
										<a-col :span="16" v-text="isShowNull(projectData.manageUnitName)"></a-col>
									</a-row>
									<a-row>
										<a-col :span="8">业主单位联系方式:</a-col>
										<a-col :span="16" v-text="isShowNull(projectData.managePhone)"></a-col>
									</a-row>
									<a-row>
										<a-col :span="8">验收标准:</a-col>
										<a-col :span="16" v-text="isShowNull(projectData.acceptStandard)"></a-col>
									</a-row>
									<a-row>
										<a-col :span="8">施工内容:</a-col>
										<a-col :span="16" v-text="isShowNull(projectData.workContent)"></a-col>
									</a-row>
								</div>
							</a-card>
						</a-tab-pane>
						<a-tab-pane key="4" :tab="connected_tObj.name">
							<template v-if="connected_tObj.list == 0">
								<a-empty/>
							</template>
							<template v-else>
								<a-list item-layout="horizontal" :data-source="connected_tObj.list">
									<a-list-item slot="renderItem" slot-scope="item, index">
										<a-list-item-meta :description="item.description">
											<a slot="title" v-text="item.title"></a>
											<a-avatar slot="avatar" :src="item.url"/>
										</a-list-item-meta>
									</a-list-item>
								</a-list>
							</template>
						</a-tab-pane>
						<a-tab-pane key="5" tab="流程">
							<a-empty/>
						</a-tab-pane>
					</a-tabs>
				</div>
			</div>
			<!-- 今日进展 -->
			<a-drawer
					title="今日进展"
					placement="bottom"
					:visible="todayModule.visible"
					@close="todayModuleToggle(false)"
					height="100%">
				<div id="todayModule" v-if="t_data">
					<a-spin :spinning="todayModule.spinning" tip="保存中...">
						<a-row>
							<a-col :span="8">名称:</a-col>
							<a-col :span="16" v-text="t_type == 6 ? t_data.tgName : t_data.taskName"></a-col>
						</a-row>
						<a-row>
							<a-col :span="8" style="line-height: 22px;">进展状态:</a-col>
							<a-col :span="16">
								<a-select
										:default-value="todayModule.form.doStatus"
										v-model="todayModule.form.doStatus"
										style="width: 100%"
										size="small">
									<a-select-option value="1">
										正常
									</a-select-option>
									<a-select-option value="2">
										延迟
									</a-select-option>
									<a-select-option value="3">
										完成
									</a-select-option>
									<a-select-option value="4">
										暂停
									</a-select-option>
									<a-select-option value="5">
										关闭
									</a-select-option>
								</a-select>
							</a-col>
						</a-row>
						<a-row>
							<a-col :span="8" style="line-height: 22px;">累计完成量:</a-col>
							<a-col :span="16" style="padding: 5px 0;">
								<a-progress :percent="isShowNull(t_data.leiJi)" size="small" status="active"/>
							</a-col>
						</a-row>
						<a-row>
							<a-col :span="8" style="line-height: 24px;"><span style="color: red;">*</span>今日完成量:</a-col>
							<a-col :span="16">
								<a-input type="number" v-model="todayModule.form.tadayProgress" size="small" suffix="%" @change="changeHandle"/>
							</a-col>
						</a-row>
						<a-row>
							<a-col :span="8">成果标准模板:</a-col>
							<a-col :span="16" v-text="t_data.resultDictStr ? t_data.resultDictStr : ''"></a-col>
						</a-row>
						<a-row>
							<a-col :span="8" style="line-height: 32px;"><span style="color: red;">*</span>进展情况:</a-col>
							<a-col :span="16">
								<a-textarea v-model="todayModule.form.tadayDesc" allow-clear auto-size/>
							</a-col>
						</a-row>
						<a-row>
							<a-col :span="8" style="line-height: 24px;">异常原因:</a-col>
							<a-col :span="16">
								<a-input type="text" v-model="todayModule.form.unusualReason" size="small"/>
							</a-col>
						</a-row>
						<a-row>
							<a-col :span="8" style="line-height: 24px;">异常支撑材料:</a-col>
							<a-col :span="16">
								<div class="files_box unusual_file_box"></div>
								<a-button type="link" icon="cloud-upload" size="small" @click="uploadFile">
									异常材料
								</a-button>
							</a-col>
						</a-row>
						<a-row>
							<a-col :span="8" style="line-height: 24px;">提交的成果材料:</a-col>
							<a-col :span="16">
								<div class="files_box result_file_box"></div>
								<a-button type="link" icon="cloud-upload" size="small" @click="uploadFile">
									成果材料
								</a-button>
							</a-col>
						</a-row>
						<div style="margin-top: 20px;text-align: center;">
							<a-button type="primary" @click="saveToday">保存</a-button>
							<a-button @click="todayModuleToggle(false)">取消</a-button>
						</div>
					</a-spin>
				</div>
			</a-drawer>
			
			<!-- 增加协作人 -->
			<a-drawer
					title="增加协作人"
					placement="bottom"
					:visible="collaboratorModule.visible"
					@close="collaboratorModuleToggle(false)"
					height="100%">
				<div id="collaboratorModule">
					<a-spin :spinning="collaboratorModule.spinning" tip="保存中...">
						<div>
							<label><span style="color: red;">*</span>协作人</label>
							<div>
								<a-textarea id="resUser"
								            disabled="true"
								            :auto-size="{ minRows: 3, maxRows: 5 }"/>
							</div>
							<div style="text-align: right;padding: 10px 50px 0 0;">
								<a href="javascript:;" style="color:#1e9fff;font-size: 16px;margin-right: 10px;" @click="addUser('resUser')">添加</a>
								<a href="javascript:;" style="color:#1e9fff;font-size: 16px;" @click="clearUser('resUser')">清空</a>
							</div>
						</div>
						<div style="margin-top: 30px;text-align: center;">
							<a-button type="primary" @click="saveCollaborator">保存</a-button>
							<a-button @click="collaboratorModuleToggle(false)">取消</a-button>
						</div>
					</a-spin>
				</div>
			</a-drawer>
			
			<!-- 转办 -->
			<a-drawer
					title="转办"
					placement="bottom"
					:visible="transferModule.visible"
					@close="transferModuleToggle(false)"
					height="100%">
				<div id="transferModule">
					<a-spin :spinning="transferModule.spinning" tip="保存中...">
						<div>
							<label><span style="color: red;">*</span>责任人</label>
							<div>
								<a-textarea id="transferUser"
								            disabled="true"
								            :auto-size="{ minRows: 3, maxRows: 5 }"/>
							</div>
							<div style="text-align: right;padding: 10px 50px 0 0;">
								<a href="javascript:;" style="color:#1e9fff;font-size: 16px;margin-right: 10px;" @click="addUser('transferUser')">添加</a>
								<a href="javascript:;" style="color:#1e9fff;font-size: 16px;" @click="clearUser('transferUser')">清空</a>
							</div>
						</div>
						<div style="margin-top: 30px;text-align: center;">
							<a-button type="primary" @click="saveTransfer">保存</a-button>
							<a-button @click="transferModuleToggle(false)">取消</a-button>
						</div>
					</a-spin>
				</div>
			</a-drawer>
			
			<!-- 提交审核 -->
			<a-drawer
					title="提交审核"
					placement="bottom"
					:visible="submitCheckModule.visible"
					@close="submitCheckModuleToggle(false)"
					height="100%">
				<div id="submitCheckModule" v-if="t_data">
					<a-spin :spinning="submitCheckModule.spinning" tip="保存中...">
						<a-row>
							<a-col :span="8">名称:</a-col>
							<a-col :span="16" v-text="t_type == 6 ? t_data.tgName : t_data.taskName"></a-col>
						</a-row>
						<a-row>
							<a-col :span="8" style="line-height: 22px;">累计完成量:</a-col>
							<a-col :span="16" style="padding: 5px 0;">
								<a-progress :percent="isShowNull(t_data.leiJi)" size="small" status="active"/>
							</a-col>
						</a-row>
						<a-row>
							<a-col :span="8" style="line-height: 24px;"><span style="color: red;">*</span>最终成果材料:</a-col>
							<a-col :span="16">
								<div class="files_box result_file_box"></div>
								<a-button type="link" icon="cloud-upload" size="small" @click="uploadFile">
									成果材料
								</a-button>
							</a-col>
						</a-row>
						<a-row>
							<a-col :span="8" style="line-height: 24px;">异常原因:</a-col>
							<a-col :span="16">
								<a-input type="text" v-model="submitCheckModule.form.unusualReason" size="small"/>
							</a-col>
						</a-row>
						<a-row>
							<a-col :span="8" style="line-height: 24px;">异常支撑材料:</a-col>
							<a-col :span="16">
								<div class="files_box unusual_file_box"></div>
								<a-button type="link" icon="cloud-upload" size="small" @click="uploadFile">
									异常材料
								</a-button>
							</a-col>
						</a-row>
						<div style="padding: 10px 0;text-align: center;">
							<a-checkbox-group v-model="submitCheckModule.form.checkedList" :options="submitCheckModule.form.plainOptions"/>
						</div>
						<div style="margin-top: 20px;text-align: center;">
							<a-button type="primary" @click="submitCheck">保存</a-button>
							<a-button @click="submitCheckModuleToggle(false)">取消</a-button>
						</div>
					</a-spin>
				</div>
			</a-drawer>
		</div>
		
		<script>
            let $fileBoxEle = null;

            let app = new Vue({
                el: '#app',
                data: {
                    t_id: '',
                    t_type: '',
                    t_data: null,
                    isSubmit: false,
                    isItemApprivalStatus: false,
                    userId: '${sessionScope.userId}',
                    urgentObj: {
                        flag: false
                    },
                    errorFileObj: {
                        flag: false,
                        reason: '',
                        fileList: []
                    },
                    resultFileObj: {
                        flag: false,
                        fileList: []
                    },
                    connected_tObj: {
                        name: '',
                        list: []
                    },
                    projectData: null,
                    projectTypeObj: {},
                    data: [
                        {
                            title: 'Title 1',
                        },
                        {
                            title: 'Title 2',
                        },
                        {
                            title: 'Title 3',
                        },
                        {
                            title: 'Title 4',
                        },
                        {
                            title: 'Title 5',
                        },
                        {
                            title: 'Title 6',
                        },
                    ],
                    connectedInfoList: [],
                    dailyResultFileFlag: false,
                    dailyUnusualFileFlag: false,
                    todayModule: {
                        visible: false,
                        spinning: false,
                        form: {
                            tadayProgress: '',
                            unusualReason: '',
                            tadayDesc: '',
                            doStatus: '1'
                        }
                    },
                    collaboratorModule: {
                        visible: false,
                        spinning: false
                    },
                    transferModule: {
                        visible: false,
                        spinning: false
                    },
                    submitCheckModule: {
                        visible: false,
                        spinning: false,
                        form: {
                            unusualReason: '',
                            plainOptions: [{label: '事务提醒', value: 'remind'}, {label: '短信提醒', value: 'smsRemind'}],
                            checkedList: ['remind']
                        }
                    }
                },
                methods: {
                    initData: async function () {
                        let vm = this;

                        let queryData = {}

                        if (vm.t_type == 6) {
                            queryData.tgId = vm.t_id;
                        } else {
                            queryData.planItemId = vm.t_id;
                        }

                        let tData = await vm.fetchAjax('/ProjectDaily/selectProjectDailyByItemId', queryData);

                        // 基本信息
                        if (tData.object) {
                            vm.t_data = tData.object;

                            //判断是否已经提交审核过了，提交审核过后按钮不可操作
                            if (vm.t_data.itemApprivalStatus == 1 || vm.t_data.itemApprivalStatus == 2 || vm.t_data.itemApprivalStatus == 3 || vm.t_data.itemApprivalStatus === '0') {
                                vm.isItemApprivalStatus = true;
                            }
                            //判断是否可以提交审核
                            let isSubmit = await vm.isCheck();
                            if (isSubmit) {
                                vm.isSubmit = true;
                            }

                            // 最终成果材料
                            let resultFileList = vm.t_data.attachments2;
                            if (!!resultFileList && resultFileList.length > 0) {
                                vm.resultFileObj.flag = true;
                                resultFileList.forEach(function (file, index) {
                                    let attachName = file.attachName;
                                    let fileExtension = attachName.substring(attachName.lastIndexOf(".") + 1, attachName.length);//截取附件文件后缀
                                    let attName = encodeURI(attachName).replace(/\+/g, "%2b").replace(/\@/g, "%40").replace(/#/g, "%23").replace(/\&/g, "%26").replace(/\//g, "%2F").replace(/\?/g, "%3F").replace(/\￥/g, "%ef%bf%a5").replace(/$/g, "%24").replace(/\！/g, "%ef%bc%81").replace(/\（/g, "%ef%bc%88").replace(/\）/g, "%ef%bc%89").replace(/\…/g, "%e2%80%a6%e2%80%a6");
                                    let fileExtensionName = attName.substring(0, attName.lastIndexOf("."));
                                    let attachmentUrl = file.attUrl;
                                    attachmentUrl = attachmentUrl.substring(0, attachmentUrl.lastIndexOf("ATTACHMENT_NAME=")) + "ATTACHMENT_NAME=" + fileExtensionName + "." + fileExtension; //处理附件名字

                                    vm.resultFileObj.fileList.push({key: index, url: '/download?' + encodeURI(attachmentUrl), attachName: attachName});
                                });
                            }

                            // 最终异常材料
                            let errorFileList = vm.t_data.attachments3;
                            if (!!errorFileList && errorFileList.length > 0) {
                                vm.errorFileObj.falg = true;
                                errorFileList.forEach(function (file, index) {
                                    let attachName = file.attachName;
                                    let fileExtension = attachName.substring(attachName.lastIndexOf(".") + 1, attachName.length);//截取附件文件后缀
                                    let attName = encodeURI(attachName).replace(/\+/g, "%2b").replace(/\@/g, "%40").replace(/#/g, "%23").replace(/\&/g, "%26").replace(/\//g, "%2F").replace(/\?/g, "%3F").replace(/\￥/g, "%ef%bf%a5").replace(/$/g, "%24").replace(/\！/g, "%ef%bc%81").replace(/\（/g, "%ef%bc%88").replace(/\）/g, "%ef%bc%89").replace(/\…/g, "%e2%80%a6%e2%80%a6");
                                    let fileExtensionName = attName.substring(0, attName.lastIndexOf("."));
                                    let attachmentUrl = file.attUrl;
                                    attachmentUrl = attachmentUrl.substring(0, attachmentUrl.lastIndexOf("ATTACHMENT_NAME=")) + "ATTACHMENT_NAME=" + fileExtensionName + "." + fileExtension; //处理附件名字

                                    vm.errorFileObj.fileList.push({key: index, url: '/download?' + encodeURI(attachmentUrl), attachName: attachName});
                                });
                            }

                            if (!!vm.t_data.resultDictList && vm.t_data.resultDictList.length > 0) {
                                let resultDictStr = '';
                                vm.t_data.resultDictList.forEach(function (dict) {
                                    resultDictStr += dict.dictName + ','
                                });
                                vm.t_data.resultDictStr = resultDictStr.replace(/,$/, '');
                            }

                            // 关联的关键任务/子任务
                            if (vm.t_type == 6) {
                                vm.connected_tObj.name = '子任务';
                                // 获取主项关键任务项目信息
                                if (vm.t_data.deptOrProject == 0) {
                                    // 获取项目类型
                                    let projectTypeData = await vm.fetchAjax('/ProjectInfo/selectProjectTypeByNo');

                                    if (projectTypeData.flag && projectTypeData.data && projectTypeData.data.length > 0) {
                                        projectTypeData.data.forEach(function (item) {
                                            vm.projectTypeObj[item.dictNo] = item.dictName;
                                        });
                                    }
                                    $.get('/projectTarget/selectProByTgId', queryData, function (res) {
                                        if (res.object) {
                                            vm.projectData = res.object;
                                        }
                                    });
                                }
                                // 获取关联子任务信息
                                $.get('/projectTarget/findItemByTgId', queryData, function (res) {
                                    if (res.flag && res.obj && res.obj.length > 0) {
                                        res.obj.forEach(function (task) {
                                            let statusObj = vm.getStatus(task.taskStatus);
                                            let description = '起止日期：' + vm.format(task.planStartDate) + ' ~ ' + vm.format(task.planEndDate);
                                            vm.connected_tObj.list.push({title: task.taskName, url: statusObj.url, description: description});
                                        });
                                    }
                                });
                            } else {
                                vm.connected_tObj.name = '关键任务';
                                let targetArr = vm.t_data.tgIds || null;
                                if (!!targetArr && targetArr.length > 0) {
                                    targetArr.forEach(function (target) {
                                        let statusObj = vm.getStatus(target.taskStatus);
                                        let description = '起止日期：' + vm.format(target.planStartDate) + ' ~ ' + vm.format(target.planEndDate);
                                        vm.connected_tObj.list.push({title: target.tgName, url: statusObj.url, description: description});
                                    });
                                }
                            }
                        }

                        // 每日填报信息
                        if (tData.data && tData.data.length > 0) {
                            // 紧急程度
                            let urgent = tData.data[0].urgent;
                            let urgentObj = {flag: true};
                            if (urgent == 1) {
                                urgentObj.color = '#ff0000';
                                urgentObj.value = '重要紧急';
                            } else if (urgent == 2) {
                                urgentObj.color = '#fac090';
                                urgentObj.value = '重要不紧急';
                            } else if (urgent == 3) {
                                urgentObj.color = '#92d050';
                                urgentObj.value = '不重要紧急';
                            } else if (urgent == 4) {
                                urgentObj.color = '#558ed5';
                                urgentObj.value = '不重要不紧急';
                            } else {
                                urgentObj.flag = false;
                            }
                            vm.urgentObj = urgentObj;

                            // 填报信息
                            tData.data.forEach(function (item) {
                                // 成果材料附件
                                let resultFileObj = {flag: false, fileList: []}
                                if (!!item.attachmentList && item.attachmentList.length > 0) {
                                    resultFileObj.flag = true;
                                    vm.dailyResultFileFlag = true;
                                    item.attachmentList.forEach(function (file, index) {
                                        let attachName = file.attachName;
                                        let fileExtension = attachName.substring(attachName.lastIndexOf(".") + 1, attachName.length);//截取附件文件后缀
                                        let attName = encodeURI(attachName).replace(/\+/g, "%2b").replace(/\@/g, "%40").replace(/#/g, "%23").replace(/\&/g, "%26").replace(/\//g, "%2F").replace(/\?/g, "%3F").replace(/\￥/g, "%ef%bf%a5").replace(/$/g, "%24").replace(/\！/g, "%ef%bc%81").replace(/\（/g, "%ef%bc%88").replace(/\）/g, "%ef%bc%89").replace(/\…/g, "%e2%80%a6%e2%80%a6");
                                        let fileExtensionName = attName.substring(0, attName.lastIndexOf("."));
                                        let attachmentUrl = file.attUrl;
                                        attachmentUrl = attachmentUrl.substring(0, attachmentUrl.lastIndexOf("ATTACHMENT_NAME=")) + "ATTACHMENT_NAME=" + fileExtensionName + "." + fileExtension; //处理附件名字

                                        resultFileObj.fileList.push({
                                            key: index,
                                            url: '/download?' + encodeURI(attachmentUrl),
                                            attachName: attachName
                                        });

                                    });
                                }

                                // 异常原因附件
                                let unusualFIleObj = {flag: false, fileList: []}
                                if (!!item.attachmentList2 && item.attachmentList2.length > 0) {
                                    unusualFIleObj.flag = true;
                                    vm.dailyUnusualFileFlag = true;
                                    item.attachmentList2.forEach(function (file, index) {
                                        let attachName = file.attachName;
                                        let fileExtension = attachName.substring(attachName.lastIndexOf(".") + 1, attachName.length);//截取附件文件后缀
                                        let attName = encodeURI(attachName).replace(/\+/g, "%2b").replace(/\@/g, "%40").replace(/#/g, "%23").replace(/\&/g, "%26").replace(/\//g, "%2F").replace(/\?/g, "%3F").replace(/\￥/g, "%ef%bf%a5").replace(/$/g, "%24").replace(/\！/g, "%ef%bc%81").replace(/\（/g, "%ef%bc%88").replace(/\）/g, "%ef%bc%89").replace(/\…/g, "%e2%80%a6%e2%80%a6");
                                        let fileExtensionName = attName.substring(0, attName.lastIndexOf("."));
                                        let attachmentUrl = file.attUrl;
                                        attachmentUrl = attachmentUrl.substring(0, attachmentUrl.lastIndexOf("ATTACHMENT_NAME=")) + "ATTACHMENT_NAME=" + fileExtensionName + "." + fileExtension; //处理附件名字

                                        unusualFIleObj.fileList.push({key: index, url: '/download?' + encodeURI(attachmentUrl), attachName: attachName});
                                    });
                                }

                                let reportData = {
                                    id: item.dailyId,
                                    resultFileObj: resultFileObj,
                                    unusualFIleObj: unusualFIleObj,
                                    ctreateUserName: vm.isShowNull(item.ctreateUserName).replace(/,$/, ''),
                                    ctreateTime: vm.format(item.ctreateTime),
                                    assistUserName: vm.isShowNull(item.assistUserName).replace(/,$/, ''),
                                    transferName: vm.isShowNull(item.transferName).replace(/,$/, ''),
                                    tadayDesc: vm.isShowNull(item.tadayDesc),
                                    unusualReason: vm.isShowNull(item.unusualReason)
                                }

                                // 每日完成量
                                if (item.assistUserName || item.transfer) {
                                    reportData.tadayProgress = 0;
                                } else {
                                    reportData.tadayProgress = (item.tadayProgress || 0);
                                }

                                vm.connectedInfoList.push(reportData);

                            });

                        }
                    },
                    /**
                     * Promise封装ajax
                     * @param url (请求接口)
                     * @param param (请求参数)
                     * @param type (请求类型,默认GET)
                     * @returns {Promise<unknown>}
                     */
                    fetchAjax: (url, param = {}, type = 'GET') => {
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
                    },
                    /**
                     * 判断是否可以提交审核--返回true是不可以提交审核
                     * @returns {Promise<unknown>}
                     */
                    isCheck: async function () {
                        let vm = this;

                        let isOk = false;
                        let urlSubmit = '';

                        if (vm.t_type == 6) {
                            urlSubmit = '/projectTarget/checkDutyUser';
                        } else {
                            urlSubmit = '/plcProjectItem/checkDutyUser';
                        }

                        let data = await vm.fetchAjax(urlSubmit, {id: vm.t_id});

                        if (data.flag && data.code != 1) {
                            isOk = true;
                        }

                        return new Promise((resolve, reject) => {
                            resolve(isOk);
                        });
                    },
                    /**
                     * 判断当前登录人在关键任务中的对应部门
                     * @returns {Promise<unknown>}
                     */
                    getDeptId: async function () {
                        let vm = this;

                        let deptId = '';

                        if (!vm.userId) {
                            let data = await fetchAjax('/getLoginUser');

                            vm.userId = data.object.userId;
                        }

                        if (vm.t_data.dutyUser && vm.t_data.dutyUser.replace(/,$/, '') == vm.userId) {
                            deptId = vm.t_data.mainCenterDept;
                        } else if (vm.t_data.mainAreaUser && vm.t_data.mainAreaUser.replace(/,$/, '') == vm.userId) {
                            deptId = vm.t_data.mainAreaDept;
                        } else if (vm.t_data.mainProjectUser && vm.t_data.mainProjectUser.replace(/,$/, '') == vm.userId) {
                            deptId = vm.t_data.mainProjectDept;
                        }

                        return new Promise((resolve, reject) => {
                            resolve(deptId);
                        });
                    },
                    /**
                     * 判断是否显示空
                     */
                    isShowNull: function (data) {
                        if (!!data) {
                            return data;
                        } else {
                            return '';
                        }
                    },
                    /**
                     * 将毫秒数转为yyyy-MM-dd格式时间
                     * @param t
                     * @returns {string}
                     */
                    format: function (t) {
                        if (t) {
                            return new Date(t).Format("yyyy-MM-dd");
                        } else {
                            return '';
                        }
                    },
                    /**
                     * 获取关键任务/子任务状态
                     * @param status
                     * @returns {{value: string, url: string}}
                     */
                    getStatus: function (status) {
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
                    },
                    todayModuleToggle: function (visible) {
                        let vm = this;
                        vm.todayModule.visible = visible;

                        if (!visible) {
                            vm.todayModule.form.doStatus = '1';
                            vm.todayModule.form.tadayDesc = '';
                            vm.todayModule.form.tadayProgress = '';
                            vm.todayModule.form.unusualReason = '';
                            $('#todayModule .files_box').empty();
                        }
                    },
                    /**
                     * 上传附件
                     * @param e
                     */
                    uploadFile: function (e) {
                        $fileBoxEle = $(e.target).siblings('.files_box');
                        if (( /(iPhone|iPad|iPod|iOS)/i.test(navigator.userAgent) )) {

							try{
								window.webkit.messageHandlers.addImage.postMessage({'function':'addFile','num':'0'});
							}catch(err){
								addImage('addFile', 0);							}
                        } else if (/(Android)/i.test(navigator.userAgent)) {
                            Android.addImage('addFile', 0);
                        }
                    },
                    saveToday: function () {
                        let vm = this;
                        vm.todayModule.spinning = true;

                        let tadayProgress = parseInt(vm.todayModule.form.tadayProgress);
                        tadayProgress = isNaN(tadayProgress) ? 0 : tadayProgress;

                        let completeQuantityNum = parseInt(vm.t_data.leiJi || 0);
                        completeQuantityNum = isNaN(completeQuantityNum) ? 0 : completeQuantityNum;
                        completeQuantityNum += tadayProgress;
                        if (vm.todayModule.form.tadayProgress == '') {
                            vm.todayModule.spinning = false;
                            vm.$message.warning('请填写今日完成量');
                            return false;
                        }

                        if (completeQuantityNum > 100) {
                            vm.todayModule.spinning = false;
                            vm.$message.warning('今日完成量和累计完成百分比相加不能超过100');
                            return false;
                        }

                        let obj = {}
                        //成果材料附件
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
                        obj.taskName = vm.t_type == 6 ? vm.t_data.tgName : vm.t_data.taskName;
                        obj.attachmentId = attachmentId;
                        obj.attachmentName = attachmentName;
                        obj.attachmentId2 = attachmentId2;
                        obj.attachmentName2 = attachmentName2;
                        obj.completeQuantity = completeQuantityNum; //累计完成量
                        obj.tadayProgress = tadayProgress;//今日完成量
                        obj.unusualReason = vm.todayModule.form.unusualReason; //异常原因
                        obj.tadayDesc = vm.todayModule.form.tadayDesc;  //进展情况
                        obj.doStatus = vm.todayModule.form.doStatus; //进展状态

                        if (vm.t_type == 6) {
                            obj.tgId = vm.t_id;
                        } else {
                            obj.planItemId = vm.t_id;
                        }

                        $.post('/ProjectDaily/submit', obj, function (res) {
                            vm.todayModule.spinning = false;
                            if (res.flag) {
                                vm.$message.success('保存成功').then(function () {
                                    window.location.reload();
                                });
                            } else {
                                vm.$message.error('保存失败');
                            }
                        });
                    },
                    changeHandle: function () {
                        let vm = this;

                        let tadayProgress = parseInt(vm.todayModule.form.tadayProgress);
                        tadayProgress = isNaN(tadayProgress) ? 0 : tadayProgress;

                        let completeQuantityNum = parseInt(vm.t_data.leiJi || 0);
                        completeQuantityNum = isNaN(completeQuantityNum) ? 0 : completeQuantityNum;

                        if (tadayProgress + completeQuantityNum > 100) {
                            tadayProgress = 100 - completeQuantityNum;
                        }

                        if (tadayProgress > 100) {
                            tadayProgress = 100;
                        }

                        vm.todayModule.form.tadayProgress = tadayProgress;
                    },
                    collaboratorModuleToggle: function (visible) {
                        let vm = this;
                        vm.collaboratorModule.visible = visible;

                        if (!visible) {
                            vm.clearUser('resUser');
                        }
                    },
                    saveCollaborator: function () {
                        let vm = this;

                        vm.collaboratorModule.spinning = true;

                        if (!$('#resUser').val()) {
                            vm.collaboratorModule.spinning = false;
                            vm.$message.warning('请选择协作人');
                            return false;
                        }
                        let url = '';
                        let dataPer = {ids: vm.t_id, assistUser: $('#resUser').attr('user_id')};
                        if (vm.t_type == 6) {
                            url = '/projectTarget/addPeople';
                        } else {
                            url = '/plcProjectItem/addPeople';
                        }

                        vm.fetchAjax(url, dataPer).then(res => {
                            vm.collaboratorModule.spinning = false;
                            if (res.flag) {
                                vm.$message.success('保存成功').then(function () {
                                    window.location.reload();
                                });
                            } else {
                                vm.$message.error('保存失败');
                            }
                        }).catch(err => {
                            vm.collaboratorModule.spinning = false;
                            vm.$message.error('保存失败');
                        });
                    },
                    transferModuleToggle: function (visible) {
                        let vm = this;
                        vm.transferModule.visible = visible;

                        if (!visible) {
                            vm.clearUser('transferUser');
                        }
                    },
                    saveTransfer: function () {
                        let vm = this;

                        vm.transferModule.spinning = true;

                        if (!$('#transferUser').val()) {
                            vm.transferModule.spinning = false;
                            vm.$message.warning('请选择责任人');
                            return false;
                        }
                        let url = '';
                        let dataPer = {ids: vm.t_id, dutyUser: $('#transferUser').attr('user_id')};
                        if (vm.t_type == 6) {
                            url = '/projectTarget/changeDutyUser';
                        } else {
                            url = '/plcProjectItem/changeDutyUser';
                        }

                        vm.fetchAjax(url, dataPer).then(res => {
                            vm.transferModule.spinning = false;
                            if (res.flag) {
                                vm.$message.success('转办成功').then(function () {
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
                                vm.$message.error('转办失败');
                            }
                        }).catch(err => {
                            vm.transferModule.spinning = false;
                            vm.$message.error('转办失败');
                        });
                    },
                    submitCheckModuleToggle: function (visible) {
                        let vm = this;
                        vm.submitCheckModule.visible = visible;

                        if (!visible) {
                            vm.submitCheckModule.form.unusualReason = '';
                            vm.submitCheckModule.form.checkedList = ['remind'];
                            $('#submitCheckModule .files_box').empty();
                        }
                    },
                    submitCheck: async function () {
                        let vm = this;
                        
                        vm.submitCheckModule.spinning = true;

                        // 成果附件
                        let attachmentId2 = '';
                        let attachmentName2 = '';
                        let $resultFileEles = $('#submitCheckModule .result_file_box').find('a');
                        if ($resultFileEles.length > 0) {
                            $resultFileEles.each(function () {
                                let fileName = $(this).attr('name');
                                let attUrl = $(this).attr('url').split('?')[1];
                                let aId = getUrlString('AID', attUrl);
                                let fileAttachmentId = getUrlString('ATTACHMENT_ID', attUrl);
                                let ym = getUrlString('YM', attUrl);
                                let id = aId + '@' + ym + '_' + fileAttachmentId;
                                attachmentId2 += id + ',';
                                attachmentName2 += fileName + '*';
                            });
                        } else {
                            vm.submitCheckModule.spinning = false;
                            vm.$message.warning('请提交最终成果材料');
                            return false;
                        }

                        // 异常支撑材料
                        let attachmentId3 = '';
                        let attachmentName3 = '';
                        let $unusualFileEles = $('#submitCheckModule .unusual_file_box').find('a');
                        if ($unusualFileEles.length > 0) {
                            $unusualFileEles.each(function () {
                                let fileName = $(this).attr('name');
                                let attUrl = $(this).attr('url').split('?')[1];
                                let aId = getUrlString('AID', attUrl);
                                let fileAttachmentId = getUrlString('ATTACHMENT_ID', attUrl);
                                let ym = getUrlString('YM', attUrl);
                                let id = aId + '@' + ym + '_' + fileAttachmentId;
                                attachmentId3 += id + ',';
                                attachmentName3 += fileName + '*';
                            });
                        }

                        let updateData = {
                            taskPrecess: vm.t_data.leiJi,
                            attachmentId2: attachmentId2,
                            attachmentName2: attachmentName2,
                            attachmentId3: attachmentId3,
                            attachmentName3: attachmentName3,
                            itemApprivalStatus: 0,
                            taskStatus: 5,
                            unusualRes: vm.submitCheckModule.form.unusualReason,
	                        remind: 0,
	                        smsRemind: 0
                        }
                        
                        vm.submitCheckModule.form.checkedList.forEach(function(item){
                            if (item == 'remind') {
                                updateData.remind = 1;
                            }
                            if (item == 'smsRemind') {
                                updateData.smsRemind = 1;
                            }
                        });
                        
                        let updateUrl = '';
						
                        if (vm.t_type == 6) {
                            updateUrl = '/projectTarget/submit';
                            updateData.tgId = vm.t_id;
                            // 判断是否为主项关键任务
                            if (vm.t_data.deptOrProject == '0') {
                                updateData.deptId = await vm.getDeptId();
                                updateData.planClass = 1;
                            } else {
                                updateData.deptId = vm.t_data.targetBelongDept;
                                updateData.planClass = 2;
                            }
                        } else {
                            updateUrl = '/plcProjectItem/submit';
                            updateData.planItemId = vm.t_id;
                            updateData.deptId = vm.t_data.itemBelongDept;
                            updateData.planClass = 3;
                        }

                        vm.fetchAjax(updateUrl, updateData, 'POST').then(res => {
                            vm.submitCheckModule.spinning = false;
                            layer.close(loadingIndex);
                            if (res.flag) {
                                vm.$message.success('提交审核成功').then(function () {
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
                                vm.$message.error('提交审核失败');
                            }
                        }).catch(err => {
                            vm.submitCheckModule.spinning = false;
                            vm.$message.error('提交审核失败');
                        });

                    },
                    /**
                     * 添加用户
                     */
                    addUser: function (eleId) {
                        user_id = eleId;
                        selectUserLayerIndex = layer.open({
                            title: '选择用户',
                            type: 2,
                            content: '/common/selectUser_iframe?isIframeOpen=1&&selectUserLayerIndex=selectUserLayerIndex', // 专用iframe打开的选人控件页面
                            area: ['100%', '100%']
                        });
                    },
                    /**
                     * 清空用户
                     */
                    clearUser: function (eleId) {
                        $("#" + eleId).val('');
                        $("#" + eleId).attr('user_id', '');
                        $("#" + eleId).attr('username', '');
                        $("#" + eleId).attr('dataid', '');
                        $("#" + eleId).attr('userprivname', '');
                    }
                },
                created: function () {
                    let vm = this;
                    vm.t_id = $.GetRequest()['id'] || '';
                    vm.t_type = $.GetRequest()['type'] || '';
                    vm.$message.config({
                        top: `100px`,
                        duration: 2,
                        maxCount: 1,
                    });
                    vm.initData();
                }
            });

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
             * 下载附件
             * @param e (dom节点)
             * @param url (下载链接)
             * @param name (文件名)
             */
            function downloadFile(e, url, name) {
                if (!url || !name) {
                    url = $(e).attr('url');
                    name = $(e).attr('name');
                }

                let basePath = '/';

                if (url.indexOf(basePath) == -1) {
                    url = basePath + url;
                }

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
