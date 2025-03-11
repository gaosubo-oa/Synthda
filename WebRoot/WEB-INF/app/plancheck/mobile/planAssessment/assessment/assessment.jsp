<%--
  Created by IntelliJ IDEA.
  User: 戎成路
  Date: 2020/12/23
  Time: 16:17
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
		<title>分配确认</title>
		
		<meta charset="UTF-8"/>
		<meta name="viewport" content="width=device-width,initial-scale=1,minimum-scale=1,maximum-scale=1,user-scalable=no"/>
		<link rel="stylesheet" href="/lib/antDesign/vant/index.css"/>
		
		<script src="/js/xoajq/xoajq1.js"></script>
		<script src="/js/base/base.js"></script>
		<script src="/lib/antDesign/vue/vue.min.js"></script>
		<script src="/lib/antDesign/vant/vant.min.js"></script>
		<script src="/js/planCheck/mobile/vueTool.js"></script>
		
		<style>
			* {
				box-sizing: border-box;
			}
			
			html, body, #app {
				width: 100%;
				height: 100%;
				font-size: 14px;
				background-color: #fff;
			}
			
			.container {
				position: relative;
				width: 100%;
				height: 100%;
				background-color: #fff;
				color: #222;
			}
			
			.container .con_header {
				position: fixed;
				width: 100%;
				height: 64px;
				line-height: 64px;
				padding: 0 5px;
				box-shadow: 0 0px 10px 1px rgba(0, 0, 0, 0.15);
				background-color: #fff;
				z-index: 2;
			}
			
			.task_title {
				display: flex;
				align-items: center;
				flex-wrap: wrap;
				height: 64px;
				max-height: 64px;
				line-height: 21px;
				overflow: hidden;
			}
			
			.container .con_body {
				position: relative;
				width: 100%;
				min-height: 100%;
				padding: 72px 8px 6px;
				background-color: #fff;
			}
			
			.list_p {
				margin: 0;
			}
			
			.list_head {
				width: 100%;
				padding-bottom: 10px;
				font-size: 14px;
				font-weight: 600;
				border-bottom: 1px dashed #c2c2c2;
			}
			
			.list_head .p_type {
				color: #ff0000;
			}
			
			.list_head .p_title {
				flex: 1;
				font-family: '黑体';
				color: #000;
			}
			
			.list_content .p_con {
				padding-top: 5px;
			}
			
			.task_info .van-col {
				padding: 3px 0;
			}
		</style>
	</head>
	<body>
		<div id="app">
			<div class="container">
				<div class="con_header">
					<van-row type="flex" justify="space-between">
						<van-col span="24">
							<div class="task_title" v-text="taskTitle"></div>
						</van-col>
					</van-row>
				</div>
				<div class="con_body">
					<van-form ref="sheetForm" v-if="dataInfo">
						<template v-if="planClass == 1">
							<van-field id="dutyUser" @click="chooseUser('dutyUser', 1)"
							           v-model="formModule.dutyUserName"
							           name="dutyUser"
							           label="中心责任人"
							           :required="true"
							           :readonly="true"
							           placeholder="请选择中心责任人"></van-field>
							<van-field v-model="formModule.mainCenterDeptName"
							           name="mainCenterDeptName"
							           label="中心责任部门"
							           :readonly="true"></van-field>
							<van-field id="mainAreaUser" @click="chooseUser('mainAreaUser', 2)"
							           v-model="formModule.mainAreaUserName"
							           name="mainAreaUser"
							           label="区域责任人"
							           :required="true"
							           :readonly="true"
							           placeholder="请选择区域责任人"></van-field>
							<van-field v-model="formModule.mainAreaDeptName"
							           name="mainAreaDeptName"
							           label="区域责任部门"
							           :readonly="true"></van-field>
							<van-field id="mainProjectUser" @click="chooseUser('mainProjectUser', 3)"
							           v-model="formModule.mainProjectUserName"
							           name="dutyUser"
							           label="总承包部责任人"
							           :required="true"
							           :readonly="true"
							           placeholder="请选择总承包部责任人"></van-field>
							<van-field v-model="formModule.mainProjectDeptName"
							           name="mainProjectDeptName"
							           label="总承包部责任部门"
							           :readonly="true"></van-field>
							<van-field v-model="formModule.hardDegree"
							           :required="true"
							           name="dutyUser"
							           label="难度系数"
							           :readonly="status != 1"
							           placeholder="请输入难度系数"></van-field>
						</template>
						<template v-else-if="planClass == 3 || planClass == 2">
							<van-field id="dutyUser" @click="chooseUser('dutyUser', 1)"
							           v-model="formModule.dutyUserName"
							           name="dutyUser"
							           label="责任人"
							           :required="true"
							           :readonly="true"
							           placeholder="请选择责任人"></van-field>
							<van-field v-model="formModule.hardDegree"
							           :required="true"
							           name="dutyUser"
							           label="难度系数"
							           :readonly="status != 1"
							           placeholder="请输入难度系数"></van-field>
							<van-field
									clickable
									:required="true"
									:readonly="true"
									name="planStartDate"
									:value="formModule.planStartDate"
									label="开始时间"
									placeholder="计划开始时间"
									@click="status == 1 ? showStartCalendar = true : ''"></van-field>
							<van-field
									clickable
									:required="true"
									:readonly="true"
									name="planEndDate"
									:value="formModule.planEndDate"
									label="结束时间"
									placeholder="计划结束时间"
									@click="status == 1 ? showEndCalendar = true : ''"></van-field>
							<van-field v-model="formModule.planContinuedDate"
							           :readonly="true"
							           name="dutyUser"
							           label="计划工期"
							           placeholder="计划工期"></van-field>
						</template>
						<template v-else>
							<van-field id="dutyUser" @click="chooseUser('dutyUser', 1)"
							           v-model="formModule.dutyUserName"
							           name="dutyUser"
							           label="协作人"
							           :required="true"
							           :readonly="true"
							           placeholder="请选择协作人"></van-field>
							<van-field v-model="formModule.mainCenterDeptName"
							           name="dutyUser"
							           label="协作部门"
							           :readonly="true"></van-field>
							<van-field
									:readonly="true"
									name="planStartDate"
									:value="formModule.planStartDate"
									label="开始时间"
									placeholder="计划开始时间"></van-field>
							<van-field
									:readonly="true"
									name="planEndDate"
									:value="formModule.planEndDate"
									label="结束时间"
									placeholder="计划结束时间"></van-field>
							<van-field v-model="formModule.planContinuedDate"
							           :readonly="true"
							           name="dutyUser"
							           label="计划工期"
							           placeholder="计划工期"></van-field>
						</template>
						<div style="margin: 16px; text-align: center;" v-show="status == 1">
							<van-button size="small" type="info" native-type="button" @click="saveForm">保存</van-button>
							<van-button size="small" type="primary" native-type="button" @click="assessment">完成</van-button>
						</div>
					</van-form>
					<van-divider style="margin: 16px 0 0;"></van-divider>
					<h3>任务详情</h3>
					<van-skeleton :row="3" :loading="loading">
						<div v-if="dataInfo" class="task_info">
							<template v-if="planClass == 1 || planClass == 2">
								<van-row>
									<van-col span="8">任务编号:</van-col>
									<van-col span="16" v-text="isShowNull(dataInfo.tgNo)"></van-col>
								</van-row>
								<van-row>
									<van-col span="8">任务名称:</van-col>
									<van-col span="16" v-text="isShowNull(dataInfo.tgName)"></van-col>
								</van-row>
								<van-row>
									<van-col span="8">关注等级:</van-col>
									<van-col span="16" v-text="isShowNull(dictionaryObj['CONTROL_LEVEL'][dataInfo.controlLevel])"></van-col>
								</van-row>
								<van-row>
									<van-col span="8">周期类型:</van-col>
									<van-col span="16" v-text="isShowNull(dictionaryObj['PLAN_SYCLE'][dataInfo.planSycle])"></van-col>
								</van-row>
								<van-row>
									<van-col span="8">任务类型:</van-col>
									<van-col span="16" v-text="isShowNull(dictionaryObj['TG_TYPE'][dataInfo.controlLevel])"></van-col>
								</van-row>
								<van-row>
									<van-col span="8">计划阶段:</van-col>
									<van-col span="16" v-text="isShowNull(dictionaryObj['PLAN_PHASE'][dataInfo.planStage])"></van-col>
								</van-row>
								<van-row>
									<van-col span="8">设计量:</van-col>
									<van-col span="16" v-text="isShowNull(dataInfo.designQuantity)"></van-col>
								</van-row>
								<van-row>
									<van-col span="8">工程量:</van-col>
									<van-col span="16" v-text="isShowNull(dataInfo.itemQuantity)"></van-col>
								</van-row>
								<van-row>
									<van-col span="8">单位:</van-col>
									<van-col span="16" v-text="isShowNull(dictionaryObj['UNIT'][dataInfo.itemQuantityNuit])"></van-col>
								</van-row>
								<van-row>
									<van-col span="8">完成标准:</van-col>
									<van-col span="16" v-text="isShowNull(dataInfo.resultStandard)"></van-col>
								</van-row>
								<van-row>
									<van-col span="8">负责人:</van-col>
									<van-col span="16" v-text="isShowNull(dataInfo.dutyUserName).replace(/,$/, '')"></van-col>
								</van-row>
								<van-row>
									<van-col span="8">中心责任部门:</van-col>
									<van-col span="16" v-text="isShowNull(dataInfo.mainCenterDeptName).replace(/,$/, '')"></van-col>
								</van-row>
								<van-row>
									<van-col span="8">计划开始时间:</van-col>
									<van-col span="16" v-text="format(dataInfo.planStartDate)"></van-col>
								</van-row>
								<van-row>
									<van-col span="8">计划结束时间:</van-col>
									<van-col span="16" v-text="format(dataInfo.planEndDate)"></van-col>
								</van-row>
								<van-row>
									<van-col span="8">计划工期:</van-col>
									<van-col span="16" v-text="isShowNull(dataInfo.planContinuedDate)"></van-col>
								</van-row>
								<van-row>
									<van-col span="8">实际开始时间:</van-col>
									<van-col span="16" v-text="format(dataInfo.realStartDate)"></van-col>
								</van-row>
								<van-row>
									<van-col span="8">实际结束时间:</van-col>
									<van-col span="16" v-text="format(dataInfo.realEndDate)"></van-col>
								</van-row>
								<van-row>
									<van-col span="8">实际工期:</van-col>
									<van-col span="16" v-text="isShowNull(dataInfo.realContinuedDate)"></van-col>
								</van-row>
								<van-row>
									<van-col span="8">难度系数:</van-col>
									<van-col span="16" v-text="isShowNull(dataInfo.hardDegree)"></van-col>
								</van-row>
								<van-row>
									<van-col span="8">风险点:</van-col>
									<van-col span="16" v-text="isShowNull(dataInfo.riskPoint)"></van-col>
								</van-row>
								<van-row>
									<van-col span="8">成果标准模板:</van-col>
									<van-col span="16" v-text="function(){
	                                                var resultDictName = '';
			                                        if (!!dataInfo.resultDict) {
			                                            var resultDictList = dataInfo.resultDict.split(',');
			                                            
			                                            resultDictList.forEach(function (item) {
			                                                resultDictName += (!!dictionaryObj['CGCL_TYPE'][item] ? dictionaryObj['CGCL_TYPE'][item] + ',' : '');
			                                            });
			                                        }
			                                        return resultDictName.replace(/,$/, '');
	                                            }()"></van-col>
								</van-row>
								<van-row>
									<van-col span="8">需提交的成果材料:</van-col>
									<van-col span="16">
										<a style="display: block;" v-for="file in getFileList(dataInfo.attachments2)"
										   :key="file.key"
										   @click="downloadFile($event, file.url, file.attachName)"
										   v-text="file.attachName"></a>
									</van-col>
								</van-row>
								<van-row>
									<van-col span="8">异常原因:</van-col>
									<van-col span="16" v-text="isShowNull(dataInfo.unusualRes)"></van-col>
								</van-row>
								<van-row>
									<van-col span="8">异常原因材料:</van-col>
									<van-col span="16">
										<a style="display: block;" v-for="file in getFileList(dataInfo.attachments3)"
										   :key="file.key"
										   @click="downloadFile($event, file.url, file.attachName)"
										   v-text="file.attachName"></a>
									</van-col>
								</van-row>
								<van-row>
									<van-col span="8">编制依据附件:</van-col>
									<van-col span="16">
										<a style="display: block;" v-for="file in getFileList(dataInfo.attachments4)"
										   :key="file.key"
										   @click="downloadFile($event, file.url, file.attachName)"
										   v-text="file.attachName"></a>
									</van-col>
								</van-row>
							</template>
							<template v-else>
								<van-row>
									<van-col span="8">任务编号:</van-col>
									<van-col span="16" v-text="isShowNull(dataInfo.taskNo)"></van-col>
								</van-row>
								<van-row>
									<van-col span="8">任务名称:</van-col>
									<van-col span="16" v-text="isShowNull(dataInfo.taskName)"></van-col>
								</van-row>
								<van-row>
									<van-col span="8">关联关键任务:</van-col>
									<van-col span="16" v-text="function () {
                                                var tgIds = ''
                                                if (dataInfo.tgIds) {
                                                    dataInfo.tgIds.forEach(function (item) {
                                                        tgIds += item.tgName + ','
                                                    })
                                                    return tgIds.replace(/,$/, '')
                                                } else {
                                                    return '';
                                                }
                                            }()"></van-col>
								</van-row>
								<van-row>
									<van-col span="8">周期类型:</van-col>
									<van-col span="16" v-text="isShowNull(dictionaryObj['PLAN_SYCLE'][dataInfo.planSycle])"></van-col>
								</van-row>
								<van-row>
									<van-col span="8">任务来源:</van-col>
									<van-col span="16" v-text="isShowNull(dictionaryObj['RENWUJIHUA_TYPE'][dataInfo.taskType])"></van-col>
								</van-row>
								<van-row>
									<van-col span="8">负责人:</van-col>
									<van-col span="16" v-text="isShowNull(dataInfo.dutyUserName).replace(/,$/, '')"></van-col>
								</van-row>
								<van-row>
									<van-col span="8">所属部门:</van-col>
									<van-col span="16" v-text="isShowNull(dataInfo.mainCenterDeptName).replace(/,$/, '')"></van-col>
								</van-row>
								<van-row>
									<van-col span="8">计划开始时间:</van-col>
									<van-col span="16" v-text="format(dataInfo.planStartDate)"></van-col>
								</van-row>
								<van-row>
									<van-col span="8">计划结束时间:</van-col>
									<van-col span="16" v-text="format(dataInfo.planEndDate)"></van-col>
								</van-row>
								<van-row>
									<van-col span="8">计划工期:</van-col>
									<van-col span="16" v-text="isShowNull(dataInfo.planContinuedDate)"></van-col>
								</van-row>
								<van-row>
									<van-col span="8">实际开始时间:</van-col>
									<van-col span="16" v-text="format(dataInfo.realStartDate)"></van-col>
								</van-row>
								<van-row>
									<van-col span="8">实际结束时间:</van-col>
									<van-col span="16" v-text="format(dataInfo.realEndDate)"></van-col>
								</van-row>
								<van-row>
									<van-col span="8">实际工期:</van-col>
									<van-col span="16" v-text="isShowNull(dataInfo.realContinuedDate)"></van-col>
								</van-row>
								<van-row>
									<van-col span="8">前置子任务:</van-col>
									<van-col span="16" v-text="function () {
                                                var preTasks = ''
                                                if (dataInfo.preTasks) {
                                                    dataInfo.preTasks.forEach(function (item) {
                                                        preTasks += item.workItemName + ','
                                                    })
                                                    return preTasks.replace(/,$/, '')
                                                } else {
                                                    return ''
                                                }
                                            }()"></van-col>
								</van-row>
								<van-row>
									<van-col span="8">完成标准:</van-col>
									<van-col span="16" v-text="isShowNull(dataInfo.resultStandard)"></van-col>
								</van-row>
								<van-row>
									<van-col span="8">子任务描述:</van-col>
									<van-col span="16" v-text="isShowNull(dataInfo.taskDesc)"></van-col>
								</van-row>
								<van-row>
									<van-col span="8">协助部门:</van-col>
									<van-col span="16" v-text="isShowNull(dataInfo.assistCompanyDeptsName).replace(/,$/, '')"></van-col>
								</van-row>
								<van-row>
									<van-col span="8">成果标准模板:</van-col>
									<van-col span="16" v-text="function(){
	                                                var resultDictName = '';
			                                        if (!!dataInfo.resultDict) {
			                                            var resultDictList = dataInfo.resultDict.split(',');
			                                            
			                                            resultDictList.forEach(function (item) {
			                                                resultDictName += (!!dictionaryObj['CGCL_TYPE'][item] ? dictionaryObj['CGCL_TYPE'][item] + ',' : '');
			                                            });
			                                        }
			                                        
			                                        return resultDictName.replace(/,$/, '');
	                                            }()"></van-col>
								</van-row>
								<van-row>
									<van-col span="8">需提交的成果材料:</van-col>
									<van-col span="16">
										<a style="display: block;" v-for="file in getFileList(dataInfo.attachments2)"
										   :key="file.key"
										   @click="downloadFile($event, file.url, file.attachName)"
										   v-text="file.attachName"></a>
									</van-col>
								</van-row>
								<van-row>
									<van-col span="8">异常原因:</van-col>
									<van-col span="16" v-text="isShowNull(dataInfo.unusualRes)"></van-col>
								</van-row>
								<van-row>
									<van-col span="8">异常原因材料:</van-col>
									<van-col span="16">
										<a style="display: block;" v-for="file in getFileList(dataInfo.attachments3)"
										   :key="file.key"
										   @click="downloadFile($event, file.url, file.attachName)"
										   v-text="file.attachName"></a>
									</van-col>
								</van-row>
								<van-row>
									<van-col span="8">难度点:</van-col>
									<van-col span="16" v-text="isShowNull(dataInfo.difficultPoint)"></van-col>
								</van-row>
								<van-row>
									<van-col span="8">风险点:</van-col>
									<van-col span="16" v-text="isShowNull(dataInfo.riskPoint)"></van-col>
								</van-row>
								<van-row>
									<van-col span="8">编制依据附件:</van-col>
									<van-col span="16">
										<a style="display: block;" v-for="file in getFileList(dataInfo.attachments4)"
										   :key="file.key"
										   @click="downloadFile($event, file.url, file.attachName)"
										   v-text="file.attachName"></a>
									</van-col>
								</van-row>
							</template>
						</div>
					</van-skeleton>
				</div>
			</div>
			
			<van-calendar v-model="showStartCalendar" :default-date="defaultSatrtDate" color="#1989fa" :min-date="minDate" :max-date="maxDate"
			              @confirm="onStartConfirm"></van-calendar>
			<van-calendar v-model="showEndCalendar" :default-date="defaultEndDate" color="#1989fa" :min-date="minDate" :max-date="maxDate"
			              @confirm="onEndConfirm"></van-calendar>
		</div>
		
		<script>
            var user_id = ''

            let date = new Date()
            let year = date.getFullYear()
            let month = date.getMonth()
            let day = date.getDay()

            let chooseUserType = 0

            let app = new Vue({
                el: '#app',
                computed: {
                    minDate: function () {
                        return new Date(year - 5, month, day)
                    },
                    maxDate: function () {
                        return new Date(year + 5, month, day)
                    },
                    defaultSatrtDate: function () {
                        return this.formModule.planStartDate ? new Date(this.formModule.planStartDate) : new Date()
                    },
                    defaultEndDate: function () {
                        return this.formModule.planEndDate ? new Date(this.formModule.planEndDate) : new Date()
                    }
                },
                data: {
                    dictionaryStr: 'PLAN_SYCLE,RENWUJIHUA_TYPE,CGCL_TYPE,PLAN_PHASE,TG_TYPE,CONTROL_LEVEL,UNIT',
                    dictionaryObj: {
                        PLAN_SYCLE: {},
                        RENWUJIHUA_TYPE: {},
                        CGCL_TYPE: {},
                        PLAN_PHASE: {},
                        TG_TYPE: {},
                        CONTROL_LEVEL: {},
                        UNIT: {}
                    },
                    id: '',
                    planClass: 0,
                    status: '',
                    dataInfo: null,
                    taskTitle: '',
                    formModule: {
                        id: '',
                        dutyUser: '',
                        dutyUserName: '',
                        mainCenterDeptName: '',
                        mainAreaUser: '',
                        mainAreaUserName: '',
                        mainAreaDeptName: '',
                        mainProjectUser: '',
                        mainProjectUserName: '',
                        mainProjectDeptName: '',
                        hardDegree: '',
                        planStartDate: '',
                        planEndDate: '',
                        planContinuedDate: ''
                    },
                    showStartCalendar: false,
                    showEndCalendar: false,
                    loading: true
                },
                methods: {
                    getData: function () {
                        let _this = this
                        let searchData = {}
                        if (_this.planClass == 1 || _this.planClass == 2) {
                            searchData.tgId = _this.id
                            getTaskInfo()
                        } else if (_this.planClass == 3) {
                            searchData.planItemId = _this.id
                            getTaskInfo()
                        } else {
                            $.get('/plcAssist/selAllByAssistId', {assistId: _this.id}, function (res) {
                                if (res.flag) {
                                    _this.taskTitle = _this.isShowNull(res.data.taskName)
                                    _this.formModule.id = res.data.assistId
                                    _this.formModule.dutyUser = _this.isShowNull(res.data.assistUser)
                                    _this.formModule.dutyUserName = _this.isShowNull(res.data.assistUserName).replace(/,$/, '')
                                    _this.formModule.mainCenterDeptName = _this.isShowNull(res.data.assistDeptName).replace(/,$/, '')
                                    _this.formModule.hardDegree = res.data.hardDegree
                                    _this.formModule.planStartDate = res.data.planStartDate
                                    _this.formModule.planEndDate = res.data.planEndDate
                                    _this.formModule.planContinuedDate = res.data.planContinuedDate
                                    searchData.planItemId = res.data.planItemId
                                    getTaskInfo()
                                }
                            })
                        }

                        function getTaskInfo() {
                            $.get('/ProjectDaily/selectProjectDailyByItemId', searchData, function (res) {
                                _this.loading = false
                                if (res.flag) {
                                    _this.dataInfo = res.object
                                    if (_this.planClass == 1 || _this.planClass == 2) {
                                        _this.taskTitle = _this.isShowNull(res.object.tgName)
                                        _this.formModule.id = _this.dataInfo.tgId
                                        _this.formModule.dutyUser = _this.isShowNull(_this.dataInfo.dutyUser)
                                        _this.formModule.dutyUserName = _this.isShowNull(_this.dataInfo.dutyUserName).replace(/,$/, '')
                                        _this.formModule.mainCenterDeptName = _this.isShowNull(_this.dataInfo.mainCenterDeptName).replace(/,$/, '')
                                        _this.formModule.mainAreaUser = _this.isShowNull(_this.dataInfo.mainAreaUser)
                                        _this.formModule.mainAreaUserName = _this.isShowNull(_this.dataInfo.mainAreaUserName).replace(/,$/, '')
                                        _this.formModule.mainAreaDeptName = _this.isShowNull(_this.dataInfo.mainAreaDeptName).replace(/,$/, '')
                                        _this.formModule.mainProjectUser = _this.isShowNull(_this.dataInfo.mainProjectUser)
                                        _this.formModule.mainProjectUserName = _this.isShowNull(_this.dataInfo.mainProjectUserName).replace(/,$/, '')
                                        _this.formModule.mainProjectDeptName = _this.isShowNull(_this.dataInfo.mainProjectDeptName).replace(/,$/, '')
                                        _this.formModule.hardDegree = _this.dataInfo.hardDegree
                                    } else if (_this.planClass == 3) {
                                        _this.taskTitle = _this.isShowNull(res.object.taskName)
                                        _this.formModule.id = _this.dataInfo.planItemId
                                        _this.formModule.dutyUser = _this.isShowNull(_this.dataInfo.dutyUser)
                                        _this.formModule.dutyUserName = _this.isShowNull(_this.dataInfo.dutyUserName).replace(/,$/, '')
                                        _this.formModule.hardDegree = _this.dataInfo.hardDegree
                                        _this.formModule.planStartDate = _this.dataInfo.planStartDate
                                        _this.formModule.planEndDate = _this.dataInfo.planEndDate
                                        _this.formModule.planContinuedDate = _this.dataInfo.planContinuedDate
                                    }
                                }
                            })
                        }
                    },
                    chooseUser: function (id, type) {
                        if (this.status == 1) {
                            if (this.planClass == 1) {
                                if (!this.dataInfo.isEdit || !((type == 1 && this.dataInfo.isEdit.mainCenterUser && this.dataInfo.mainCenterDeptName) ||
                                    (type == 2 && this.dataInfo.isEdit.mainAreaUser && this.dataInfo.mainAreaDeptName) ||
                                    (type == 3 && this.dataInfo.isEdit.mainProjectUser && this.dataInfo.mainProjectDeptName))) {
                                    return
                                }
                            }

                            user_id = id
                            chooseUserType = type
	                        layer.open({
		                        type: 2,
		                        area: ['100%', '100%'],
		                        content: '/projectTarget/selectOwnDeptUser?0'
	                        })
                        }
                    },
                    onStartConfirm: function (date) {
                        let startDate = this.format(date)

                        if (this.formModule.planEndDate) {
                            if (new Date(startDate).getTime() > new Date(this.formModule.planEndDate).getTime()) {
                                this.$notify({type: 'danger', message: '开始时间不能晚于结束时间'})
                                return
                            }
                        }

                        this.formModule.planStartDate = startDate
                        this.formModule.planContinuedDate = this.timeRange(this.formModule.planStartDate, this.formModule.planEndDate) + '天'
                        this.showStartCalendar = false;
                    },
                    onEndConfirm: function (date) {
                        let endDate = this.format(date)

                        if (this.formModule.planStartDate) {
                            if (new Date(endDate).getTime() < new Date(this.formModule.planStartDate).getTime()) {
                                this.$notify({type: 'danger', message: '结束时间不能早于开始时间'})
                                return
                            }
                        }

                        this.formModule.planEndDate = endDate
                        this.formModule.planContinuedDate = this.timeRange(this.formModule.planStartDate, this.formModule.planEndDate) + '天'
                        this.showEndCalendar = false;
                    },
                    /***
                     * 计算计划工期
                     * @param beginTime (开始时间)
                     * @param endTime (结束时间)
                     * @returns {number}
                     */
                    timeRange: function (beginTime, endTime) {
                        var days = ''
                        if (beginTime && endTime) {
                            var t1 = new Date(beginTime);
                            var t2 = new Date(endTime);
                            var time = t2.getTime() - t1.getTime();
                            days = parseInt(time / (1000 * 60 * 60 * 24)) + 1;

                        }
                        return days
                    },
                    saveForm: function () {
                        let _this = this
                        let toast = _this.$toast.loading({
                            message: '保存中...',
                            forbidClick: true,
                            duration: 0
                        })

                        let data = []

                        if (_this.planClass == 1) {
                            data.push({
                                tgId: _this.formModule.id,
                                dutyUser: _this.formModule.dutyUser,
                                mainAreaUser: _this.formModule.mainAreaUser,
                                mainProjectUser: _this.formModule.mainProjectUser,
                                hardDegree: _this.formModule.hardDegree
                            })
                        } else if (_this.planClass == 2) {
                            data.push({
                                tgId: _this.formModule.id,
                                dutyUser: _this.formModule.dutyUser,
                                hardDegree: _this.formModule.hardDegree,
                                planContinuedDate: _this.formModule.planContinuedDate,
                                planEndDate: _this.formModule.planEndDate,
                                planStartDate: _this.formModule.planStartDate
                            })
                        } else if (_this.planClass == 3) {
                            data.push({
                                dutyUser: _this.formModule.dutyUser,
                                hardDegree: _this.formModule.hardDegree,
                                planContinuedDate: _this.formModule.planContinuedDate,
                                planEndDate: _this.formModule.planEndDate,
                                planItemId: _this.formModule.id,
                                planStartDate: _this.formModule.planStartDate
                            })
                        } else {
                            data.push({
                                assistId: _this.formModule.id,
                                assistUser: _this.formModule.dutyUser
                            })
                        }

                        _this.saveTaskOrTarget(data, function (res) {
                            toast.clear()
                            if (res.flag) {
                                _this.$notify({type: 'success', message: '保存成功', duration: 2000})
                                _this.getData()
                            } else {
                                _this.$notify({type: 'danger', message: '保存失败', duration: 2000})
                            }
                        })
                    },
                    assessment: function () {
                        let _this = this
	                    let tips = ''
	                    let isPass = true
	                    if (_this.planClass == 1) {
                            if (_this.dataInfo.isEdit.mainCenterUser && _this.dataInfo.mainCenterDeptName && !_this.formModule.dutyUser) {
                                tips = '请选择中心责任人'
	                            isPass = false
                            } else if (_this.dataInfo.isEdit.mainAreaUser && _this.dataInfo.mainAreaDeptName && !_this.formModule.mainAreaUser) {
                                tips = '请选择区域责任人'
	                            isPass = false
                            } else if (_this.dataInfo.isEdit.mainProjectUser && _this.dataInfo.mainProjectDeptName && !_this.formModule.mainProjectUser) {
                                tips = '请选择总承包部责任人'
	                            isPass = false
                            }
	                    } else if (_this.planClass == 2 || _this.planClass == 3) {
	                        if (!_this.formModule.dutyUser) {
	                            tips = '请选择责任人'
		                        isPass = false
	                        }
	                    } else {
	                        if (!_this.formModule.dutyUser) {
	                            tips = '请选择协作人'
		                        isPass = false
	                        }
	                    }
	                    
	                    if (!isPass) {
	                        _this.$notify({type: 'danger', message: tips, duration: 2000})
	                        return
	                    }
	                    
                        _this.$dialog.confirm({
                            message: '确定分配完成该任务？',
                            beforeClose: function (action, done) {
                                if (action === 'confirm') {
                                    let year = new Date().getFullYear();
                                    let month = new Date().getMonth() + 1;
                                    let day = new Date().getDate();
                                    if (month < 10) {
                                        month = "0" + month;
                                    }
                                    if (day < 10) {
                                        day = "0" + day;
                                    }
                                    let today = year + "-" + month + "-" + day;
                                    let data = [{ids: _this.formModule.id, allocationStatus: 1, allocationDate: today}]
                                    // 完成前先保存
                                    _this.saveTaskOrTarget(data, function (json) {
                                        if (json.flag) {
                                            if (_this.planClass == 1 || _this.planClass == 2) {
                                                let allocationStatusList = []
                                                let obj = {
                                                    tgId: _this.formModule.id
                                                }
                                                if (_this.formModule.dutyUser) {
                                                    obj.allocationStatus = 1
                                                    obj.centerAllocationDate = today
                                                }
                                                if (_this.formModule.mainAreaUser) {
                                                    obj.areaAllocationStatus = 1
                                                    obj.areaAllocationDate = today
                                                }
                                                if (_this.formModule.mainProjectUser) {
                                                    obj.projectAllocationStatus = 1
                                                    obj.projectAllocationDate = today
                                                }
                                                allocationStatusList.push(obj)
                                                _this.saveTaskOrTarget(allocationStatusList, function (res) {
                                                    if (res.flag) {
                                                        _this.$notify({
                                                            type: 'success',
                                                            message: '分配成功',
                                                            duration: 2000,
                                                            onClose: function () {
                                                                if (( /(iPhone|iPad|iPod|iOS)/i.test(navigator.userAgent) )) {
                                                                    try {
                                                                        window.webkit.messageHandlers.finishWork.postMessage({})
                                                                    } catch (err) {
                                                                        finishWork()
                                                                    }
                                                                } else if (/(Android)/i.test(navigator.userAgent)) {
                                                                    Android.finishWebActivity()
                                                                }
                                                            }
                                                        })
                                                    } else {
                                                        _this.$notify({type: 'danger', message: '分配失败', duration: 2000})
                                                    }
                                                })
                                            } else {
                                                _this.updateTaskOrTarget(data, function (res) {
                                                    done()
                                                    if (res.flag) {
                                                        _this.$notify({
                                                            type: 'success',
                                                            message: '分配成功',
                                                            duration: 2000,
                                                            onClose: function () {
                                                                if (( /(iPhone|iPad|iPod|iOS)/i.test(navigator.userAgent) )) {
                                                                    try {
                                                                        window.webkit.messageHandlers.finishWork.postMessage({});
                                                                    } catch (err) {
                                                                        finishWork();
                                                                    }
                                                                } else if (/(Android)/i.test(navigator.userAgent)) {
                                                                    Android.finishWebActivity();
                                                                }
                                                            }
                                                        })
                                                    } else {
                                                        _this.$notify({type: 'danger', message: '分配失败', duration: 2000})
                                                    }
                                                })
                                            }
                                        } else {
                                            done()
                                            _this.$notify({type: 'danger', message: '保存失败', duration: 2000})
                                        }
                                    })
                                } else {
                                    done()
                                }
                            }
                        }).catch(() => {
                        })
                    },
                    saveTaskOrTarget: function (data, fn) {
                        let url = ''
                        if (this.planClass == 1 || this.planClass == 2) {
                            url = '/projectTarget/updateList'
                        } else if (this.planClass == 3) {
                            url = '/plcProjectItem/updateList'
                        } else {
                            url = '/plcAssist/updateList'
                        }
                        $.ajax({
                            url: url,
                            data: JSON.stringify(data),
                            contentType: "application/json;charset=UTF-8",
                            dataType: 'json',
                            type: 'post',
                            success: function (res) {
                                if (fn) {
                                    fn(res)
                                }
                            }
                        })
                    },
                    updateTaskOrTarget: function (data, fn) {
                        var url = ''
                        if (this.planClass == 1 || this.planClass == 2) {
                            url = '/projectTarget/updateContent'
                        } else if (this.planClass == 3) {
                            url = '/plcProjectItem/updateByIds'
                        } else {
                            url = '/PlcAssessScore/updateStatus'
                        }

                        $.post(url, data, function (res) {
                            if (fn) {
                                fn(res)
                            }
                        })
                    }
                },
                created: function () {
                    let _this = this

                    _this.id = $.GetRequest()['id'] || ''
                    _this.planClass = $.GetRequest()['planClass'] || ''
                    _this.status = $.GetRequest()['status'] || ''

                    // 获取数据字典数据
                    $.get('/Dictonary/selectDictionaryByDictNos', {dictNos: _this.dictionaryStr}, function (res) {
                        if (res.flag) {
                            for (let dict in _this.dictionaryObj) {
                                _this.dictionaryObj[dict] = {}
                                if (res.object[dict]) {
                                    res.object[dict].forEach(function (item) {
                                        _this.dictionaryObj[dict][item.dictNo] = item.dictName
                                    })
                                }
                            }
                        }
                    })

                    _this.getData()
                }
            })

            // 选人完成回调
            function responsible() {
                if (chooseUserType == 1) {
                    app.formModule.dutyUser = ($('#' + user_id).attr('user_id') || '').replace(/,$/, '')
                    app.formModule.dutyUserName = $('#' + user_id).val().replace(/,$/, '')
                } else if (chooseUserType == 2) {
                    app.formModule.mainAreaUser = ($('#' + user_id).attr('user_id') || '').replace(/,$/, '')
                    app.formModule.mainAreaUserName = $('#' + user_id).val().replace(/,$/, '')
                } else if (chooseUserType == 3) {
                    app.formModule.mainProjectUser = ($('#' + user_id).attr('user_id') || '').replace(/,$/, '')
                    app.formModule.mainProjectUserName = $('#' + user_id).val().replace(/,$/, '')
                }
            }
		</script>
	</body>
</html>
