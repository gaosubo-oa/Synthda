<%--
  Created by IntelliJ IDEA.
  User: 戎成路
  Date: 2020/12/22
  Time: 9:24
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
		<title>子任务考核</title>
		
		<meta charset="UTF-8"/>
		<meta name="viewport" content="width=device-width,initial-scale=1,minimum-scale=1,maximum-scale=1,user-scalable=no"/>
		<link rel="stylesheet" href="/lib/antDesign/antd.min.css">
		<link rel="stylesheet" href="/lib/antDesign/vant/index.css"/>
		
		<script src="/js/xoajq/xoajq1.js"></script>
		<script src="/js/base/base.js"></script>
		<script src="/lib/antDesign/vue/vue.min.js"></script>
		<script src="/lib/antDesign/vant/vant.min.js"></script>
		<script src="/js/planCheck/mobile/vueTool.js"></script>
		
		<style>
			html, body, #app {
				width: 100%;
				height: 100%;
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
				padding: 0 15px;
				box-shadow: 0 0px 10px 1px rgba(0, 0, 0, 0.15);
				background-color: #fff;
				z-index: 2;
			}
			
			.con_header .plan_head {
				display: flex;
				align-items: center;
				line-height: 1.5;
				height: 100%;
				margin: 0px;
			}
			
			.container .con_body {
				position: relative;
				width: 100%;
				min-height: 100%;
				padding: 72px 6px 8px;
				background-color: #fff;
			}
			
			.tab_con .van-cell {
				margin-top: 10px;
				padding: 10px 12px;
				border-radius: 4px;
				box-shadow: 0 0 10px 0px rgba(0, 0, 0, .1);
			}
			
			.tab_con .van-cell .van-card {
				padding: 4px 8px;
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
		</style>
	</head>
	<body>
		<div id="app">
			<div class="container">
				<div class="con_header">
					<van-row style="height: 100%;">
						<van-col span="24" style="height: 100%;" v-if="targetInfo">
							<span class="plan_head" v-text="t_type == 1 ? targetInfo.tgName : targetInfo.taskName"></span>
						</van-col>
					</van-row>
				</div>
				<div class="con_body">
					<van-form ref="sheetForm" v-if="targetInfo">
						<van-field name="hardDegree" label="难度系数" :value="formModule.hardDegree" readonly></van-field>
						<van-field
								v-model="formModule.taskPrecess"
								name="taskPrecess"
								label="完成度"
								placeholder="填写完成度"
								:readonly="socoreInfo.apprivalStatus != 0"
								:rules="[{ required: true }]">
							<template #right-icon>%</template>
						</van-field>
						<van-field
								v-model="formModule.qualityScore"
								name="qualityScore"
								label="质量得分"
								placeholder="填写质量得分"
								:readonly="socoreInfo.apprivalStatus != 0"
								:rules="[{ required: true }]"></van-field>
						<van-field
								v-model="formModule.apprivalComment"
								name="apprivalComment"
								rows="1"
								autosize
								type="textarea"
								label="审核意见"
								placeholder="填写审核意见"
								:readonly="socoreInfo.apprivalStatus != 0"
								:rules="[{ required: socoreInfo.apprivalStatus == 0 }]"></van-field>
						<div style="margin: 16px; text-align: center;" v-show="socoreInfo.apprivalStatus == 0">
							<van-button size="small" native-type="button" type="danger" class="btns" @click="backForm">退回</van-button>
							<van-button size="small" native-type="button" type="info" class="btns" @click="saveForm">保存</van-button>
							<van-button size="small" native-type="button" type="primary" class="btns" @click="assessmentForm">完成</van-button>
						</div>
					</van-form>
					<van-divider style="margin: 16px 0 0;"></van-divider>
					<div class="tab_con">
						<van-tabs v-model="tabIndex" color="#1989fa">
							<van-tab title="每日填报信息">
								<template v-if="assessmentArr.length > 0">
									<van-cell v-for="item in assessmentArr" :key="item.dailyId">
										<van-card>
											<template #title>
												<div class="card_content">
													<van-row style="padding: 2px 0;">
														<van-col span="5">填报人:</van-col>
														<van-col span="7" v-text="item.ctreateUserName"></van-col>
														<van-col span="4">时间:</van-col>
														<van-col span="8" v-text="item.ctreateTime"></van-col>
													</van-row>
													<van-row style="padding: 2px 0;">
														<van-col span="5">协作人:</van-col>
														<van-col span="7" v-text="item.assistUserName"></van-col>
														<van-col span="4">完成量:</van-col>
														<van-col span="8" style="padding: 11px 0;">
															<van-progress :percentage="item.tadayProgress"></van-progress>
														</van-col>
													</van-row>
													<van-row style="padding: 2px 0;">
														<van-col span="5">转办:</van-col>
														<van-col span="19" v-text="item.transferName"></van-col>
													</van-row>
													<van-row style="padding: 2px 0;">
														<van-col span="5">进展日志:</van-col>
														<van-col span="19" v-text="item.tadayDesc"></van-col>
													</van-row>
												</div>
											</template>
										</van-card>
									</van-cell>
								</template>
								<template v-else>
									<van-empty description="暂无数据"></van-empty>
								</template>
							</van-tab>
							<van-tab title="任务详情">
								<template v-if="targetInfo">
									<van-cell>
										<van-card>
											<template #title>
												<template v-if="t_type == 1">
													<div class="card_content">
														<div style="padding-top: 5px;">
															<van-row>
																<van-col span="8">任务名称:</van-col>
																<van-col span="16" v-text="isShowNull(targetInfo.tgName)"></van-col>
															</van-row>
															<van-row>
																<van-col span="8">编号:</van-col>
																<van-col span="16" v-text="isShowNull(targetInfo.tgNo)"></van-col>
															</van-row>
															<van-row>
																<van-col span="8">关注等级:</van-col>
																<van-col span="16"
																         v-text="isShowNull(dictionaryObj['CONTROL_LEVEL'][targetInfo.planSycle])"></van-col>
															</van-row>
															<van-row>
																<van-col span="8">周期类型:</van-col>
																<van-col span="16"
																         v-text="isShowNull(dictionaryObj['PLAN_SYCLE'][targetInfo.planSycle])"></van-col>
															</van-row>
															<van-row>
																<van-col span="8">任务类型:</van-col>
																<van-col span="16"
																         v-text="isShowNull(dictionaryObj['TG_TYPE'][targetInfo.taskType])"></van-col>
															</van-row>
															<van-row>
																<van-col span="8">计划阶段:</van-col>
																<van-col span="16"
																         v-text="isShowNull(dictionaryObj['PLAN_PHASE'][targetInfo.taskType])"></van-col>
															</van-row>
															<van-row>
																<van-col span="8">设计量:</van-col>
																<van-col span="16" v-text="isShowNull(targetInfo.designQuantity)"></van-col>
															</van-row>
															<van-row>
																<van-col span="8">工程量:</van-col>
																<van-col span="16" v-text="isShowNull(targetInfo.itemQuantity)"></van-col>
															</van-row>
															<van-row>
																<van-col span="8">单位:</van-col>
																<van-col span="16"
																         v-text="isShowNull(dictionaryObj['UNIT'][targetInfo.itemQuantityNuit])"></van-col>
															</van-row>
															<van-row>
																<van-col span="8">完成标准:</van-col>
																<van-col span="16" v-text="isShowNull(targetInfo.resultStandard)"></van-col>
															</van-row>
															<van-row>
																<van-col span="8">负责人:</van-col>
																<van-col span="16"
																         v-text="isShowNull(targetInfo.dutyUserName).replace(/,$/, '')"></van-col>
															</van-row>
															<van-row>
																<van-col span="8">中心责任部门:</van-col>
																<van-col span="16"
																         v-text="isShowNull(targetInfo.mainCenterDeptName).replace(/,$/, '')"></van-col>
															</van-row>
															<van-row>
																<van-col span="8">计划开始时间:</van-col>
																<van-col span="16" v-text="format(targetInfo.planStartDate)"></van-col>
															</van-row>
															<van-row>
																<van-col span="8">计划结束时间:</van-col>
																<van-col span="16" v-text="format(targetInfo.planEndDate)"></van-col>
															</van-row>
															<van-row>
																<van-col span="8">计划工期:</van-col>
																<van-col span="16" v-text="isShowNull(targetInfo.planContinuedDate)"></van-col>
															</van-row>
															<van-row>
																<van-col span="8">实际开始时间:</van-col>
																<van-col span="16" v-text="format(targetInfo.realStartDate)"></van-col>
															</van-row>
															<van-row>
																<van-col span="8">实际结束时间:</van-col>
																<van-col span="16" v-text="format(targetInfo.realEndDate)"></van-col>
															</van-row>
															<van-row>
																<van-col span="8">实际工期:</van-col>
																<van-col span="16" v-text="isShowNull(targetInfo.realContinuedDate)"></van-col>
															</van-row>
															<van-row>
																<van-col span="8">区域责任部门:</van-col>
																<van-col span="16"
																         v-text="isShowNull(targetInfo.mainAreaDeptName).replace(/,$/, '')"></van-col>
															</van-row>
															<van-row>
																<van-col span="8">总承包部责任部门:</van-col>
																<van-col span="16"
																         v-text="isShowNull(targetInfo.mainProjectDeptName).replace(/,$/, '')"></van-col>
															</van-row>
															<van-row>
																<van-col span="8">难度系数:</van-col>
																<van-col span="16" v-text="isShowNull(targetInfo.hardDegree)"></van-col>
															</van-row>
															<van-row>
																<van-col span="8">难度点:</van-col>
																<van-col span="16" v-text="isShowNull(targetInfo.difficultPoint)"></van-col>
															</van-row>
															<van-row>
																<van-col span="8">风险点:</van-col>
																<van-col span="16" v-text="isShowNull(targetInfo.riskPoint)"></van-col>
															</van-row>
															<van-row>
																<van-col span="8">成果标准模板:</van-col>
																<van-col span="16" v-text="function () {
                                                var resultDictName = '';
                                                if (!!targetInfo.resultDict) {
                                                    var resultDictList = targetInfo.resultDict.split(',');

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
																	<a style="display: block;" v-for="file in getFileList(targetInfo.attachments2)"
																	   :key="file.key"
																	   @click="downloadFile($event, file.url, file.attachName)"
																	   v-text="file.attachName"></a>
																</van-col>
															</van-row>
															<van-row>
																<van-col span="8">异常原因:</van-col>
																<van-col span="16" v-text="isShowNull(targetInfo.unusualRes)"></van-col>
															</van-row>
															<van-row>
																<van-col span="8">异常原因材料材料:</van-col>
																<van-col span="16">
																	<a style="display: block;" v-for="file in getFileList(targetInfo.attachments3)"
																	   :key="file.key"
																	   @click="downloadFile($event, file.url, file.attachName)"
																	   v-text="file.attachName"></a>
																</van-col>
															</van-row>
															<van-row>
																<van-col span="8">编制依据附件:</van-col>
																<van-col span="16">
																	<a style="display: block;" v-for="file in getFileList(targetInfo.attachments4)"
																	   :key="file.key"
																	   @click="downloadFile($event, file.url, file.attachName)"
																	   v-text="file.attachName"></a>
																</van-col>
															</van-row>
														</div>
													</div>
												</template>
												<template v-else-if="t_type == 2">
													<div class="card_content">
														<div style="padding-top: 5px;">
															<van-row>
																<van-col span="8">任务名称:</van-col>
																<van-col span="16" v-text="isShowNull(targetInfo.taskName)"></van-col>
															</van-row>
															<van-row>
																<van-col span="8">编号:</van-col>
																<van-col span="16" v-text="isShowNull(targetInfo.taskNo)"></van-col>
															</van-row>
															<van-row>
																<van-col span="8">关联关键任务:</van-col>
																<van-col span="16" v-text="function () {
                                                var tgIds = ''
                                                if (targetInfo.tgIds) {
                                                    targetInfo.tgIds.forEach(function (item) {
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
																<van-col span="16"
																         v-text="isShowNull(dictionaryObj['PLAN_SYCLE'][targetInfo.planSycle])"></van-col>
															</van-row>
															<van-row>
																<van-col span="8">任务类型:</van-col>
																<van-col span="16"
																         v-text="isShowNull(dictionaryObj['RENWUJIHUA_TYPE'][targetInfo.taskType])"></van-col>
															</van-row>
															<van-row>
																<van-col span="8">完成标准:</van-col>
																<van-col span="16" v-text="isShowNull(targetInfo.resultStandard)"></van-col>
															</van-row>
															<van-row>
																<van-col span="8">负责人:</van-col>
																<van-col span="16"
																         v-text="isShowNull(targetInfo.dutyUserName).replace(/,$/, '')"></van-col>
															</van-row>
															<van-row>
																<van-col span="8">所属部门:</van-col>
																<van-col span="16"
																         v-text="isShowNull(targetInfo.mainCenterDeptName).replace(/,$/, '')"></van-col>
															</van-row>
															<van-row>
																<van-col span="8">计划开始时间:</van-col>
																<van-col span="16" v-text="format(targetInfo.planStartDate)"></van-col>
															</van-row>
															<van-row>
																<van-col span="8">计划结束时间:</van-col>
																<van-col span="16" v-text="format(targetInfo.planEndDate)"></van-col>
															</van-row>
															<van-row>
																<van-col span="8">计划工期:</van-col>
																<van-col span="16" v-text="isShowNull(targetInfo.planContinuedDate)"></van-col>
															</van-row>
															<van-row>
																<van-col span="8">实际开始时间:</van-col>
																<van-col span="16" v-text="format(targetInfo.realStartDate)"></van-col>
															</van-row>
															<van-row>
																<van-col span="8">实际结束时间:</van-col>
																<van-col span="16" v-text="format(targetInfo.realEndDate)"></van-col>
															</van-row>
															<van-row>
																<van-col span="8">实际工期:</van-col>
																<van-col span="16" v-text="isShowNull(targetInfo.realContinuedDate)"></van-col>
															</van-row>
															<van-row>
																<van-col span="8">难度系数:</van-col>
																<van-col span="16" v-text="isShowNull(targetInfo.hardDegree)"></van-col>
															</van-row>
															<van-row>
																<van-col span="8">难度点:</van-col>
																<van-col span="16" v-text="isShowNull(targetInfo.difficultPoint)"></van-col>
															</van-row>
															<van-row>
																<van-col span="8">风险点:</van-col>
																<van-col span="16" v-text="isShowNull(targetInfo.riskPoint)"></van-col>
															</van-row>
															<van-row>
																<van-col span="8">子任务描述:</van-col>
																<van-col span="16" v-text="isShowNull(targetInfo.taskDesc)"></van-col>
															</van-row>
															<van-row>
																<van-col span="8">协助部门:</van-col>
																<van-col span="16"
																         v-text="isShowNull(targetInfo.assistCompanyDeptsName).replace(/,$/, '')"></van-col>
															</van-row>
															<van-row>
																<van-col span="8">成果标准模板:</van-col>
																<van-col span="16" v-text="function () {
                                                var resultDictName = '';
                                                if (!!targetInfo.resultDict) {
                                                    var resultDictList = targetInfo.resultDict.split(',');

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
																	<a style="display: block;" v-for="file in getFileList(targetInfo.attachments2)"
																	   :key="file.key"
																	   @click="downloadFile($event, file.url, file.attachName)"
																	   v-text="file.attachName"></a>
																</van-col>
															</van-row>
															<van-row>
																<van-col span="8">异常原因:</van-col>
																<van-col span="16" v-text="isShowNull(targetInfo.unusualRes)"></van-col>
															</van-row>
															<van-row>
																<van-col span="8">异常原因材料材料:</van-col>
																<van-col span="16">
																	<a style="display: block;" v-for="file in getFileList(targetInfo.attachments3)"
																	   :key="file.key"
																	   @click="downloadFile($event, file.url, file.attachName)"
																	   v-text="file.attachName"></a>
																</van-col>
															</van-row>
															<van-row>
																<van-col span="8">编制依据附件:</van-col>
																<van-col span="16">
																	<a style="display: block;" v-for="file in getFileList(targetInfo.attachments4)"
																	   :key="file.key"
																	   @click="downloadFile($event, file.url, file.attachName)"
																	   v-text="file.attachName"></a>
																</van-col>
															</van-row>
														</div>
													</div>
												</template>
											</template>
										</van-card>
									</van-cell>
								</template>
								<template v-else>
									<van-empty description="暂无数据"></van-empty>
								</template>
							</van-tab>
						</van-tabs>
					</div>
				</div>
			</div>
		</div>
		
		<script>
            let app = new Vue({
                el: '#app',
                data: {
                    scoreId: '',
                    t_type: 0,
                    dictionaryStr: 'TG_TYPE,CGCL_TYPE,UNIT,CONTROL_LEVEL,PLAN_SYCLE,RENWUJIHUA_TYPE',
                    dictionaryObj: {
                        TG_TYPE: {},
                        CGCL_TYPE: {},
                        UNIT: {},
                        CONTROL_LEVEL: {},
                        PLAN_SYCLE: {},
                        PLAN_PHASE: {},
                        RENWUJIHUA_TYPE: {}
                    },
                    formModule: {
                        socoreId: '',
                        hardDegree: '',
                        apprivalComment: '',
                        qualityScore: '',
                        taskPrecess: ''
                    },
                    assessmentArr: [],
                    targetInfo: null,
                    socoreInfo: null,
                    tabIndex: 0
                },
                methods: {
                    getListData: function () {
                        let _this = this

                        $.get('/PlcAssessScore/findAssessmentDataByScoreId', {scoreId: _this.scoreId}, function (res) {
                            if (res.flag) {

                                _this.socoreInfo = res.data

                                _this.formModule.socoreId = _this.scoreId
                                _this.formModule.hardDegree = _this.socoreInfo.hardDegree || ''
                                _this.formModule.qualityScore = _this.socoreInfo.qualityScore || ''
                                _this.formModule.taskPrecess = _this.socoreInfo.taskPrecess || ''
                                _this.formModule.apprivalComment = _this.socoreInfo.apprivalComment || ''

                                let data = {}

                                if (_this.socoreInfo.tgId) {
                                    data.tgId = _this.socoreInfo.tgId
                                    _this.t_type = 1
                                } else if (_this.socoreInfo.planItemId) {
                                    data.planItemId = _this.socoreInfo.planItemId
                                    _this.t_type = 2
                                }

                                $.get('/ProjectDaily/selectProjectDailyByItemId', data, function (json) {
                                    if (json.flag) {
                                        _this.targetInfo = json.object
                                        _this.assessmentArr = json.data
                                    }
                                })
                            }
                        })
                    },
                    assessmentForm: function () {
                        let _this = this
                        _this.$refs['sheetForm'].validate().then(() => {
                            _this.$dialog.confirm({
                                message: '确定完成该任务？',
                                beforeClose: function (action, done) {
                                    if (action === 'confirm') {
                                        let data = [_this.formModule]
                                        // 完成前先保存
                                        _this.saveTaskOrTarget(data, function (json) {
                                            if (json.flag) {
                                                $.post('/PlcAssessScore/updateStatus', {
                                                    socoreIds: _this.formModule.socoreId,
                                                    apprivalStatus: 1
                                                }, function (res) {
                                                    done()
                                                    if (res.flag) {
                                                        _this.$notify({
                                                            type: 'success',
                                                            message: '完成成功',
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
                                                        _this.$notify({type: 'danger', message: '完成失败', duration: 2000})
                                                    }
                                                })
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
                        }).catch(() => {
                        })
                    },
                    saveForm: function () {
                        let _this = this

                        let toast = _this.$toast.loading({
                            message: '保存中...',
                            forbidClick: true,
                            duration: 0
                        })

                        let data = [_this.formModule]

                        _this.saveTaskOrTarget(data, function (res) {
                            toast.clear()
                            if (res.flag) {
                                _this.$notify({
                                    type: 'success',
                                    message: '保存成功',
                                    duration: 2000
                                })
                            } else {
                                _this.$notify({type: 'danger', message: '保存失败', duration: 2000})
                            }
                        })
                    },
                    backForm: function () {
                        let _this = this
                        _this.$dialog.confirm({
                            message: '确定退回该任务？',
                            beforeClose: function (action, done) {
                                if (action === 'confirm') {
                                    $.post('/projectTarget/returnTgOrPlanItemId', {
                                        tgId: _this.socoreInfo.tgId || '',
	                                    planItemId: _this.socoreInfo.planItemId || '',
                                        userId: _this.socoreInfo.dutyUser || '',
                                        belongDept: _this.socoreInfo.belongDept || ''
                                    }, function (res) {
                                        done()
                                        if (res.flag) {
                                            _this.$notify({
                                                type: 'success',
                                                message: '退回成功',
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
                                            _this.$notify({type: 'danger', message: '退回失败', duration: 2000})
                                        }
                                    })
                                } else {
                                    done()
                                }
                            }
                        }).catch(() => {
                        })
                    },
                    closeSheetModule: function () {
                        this.formModule.socoreId = ''
                        this.formModule.hardDegree = ''
                        this.formModule.apprivalComment = ''
                        this.formModule.qualityScore = ''
                        this.formModule.taskPrecess = ''
                        this.socoreInfo = null
                        this.assessmentArr = []
                        this.targetInfo = null
                        this.tabIndex = 0
                        this.$refs['sheetForm'].resetValidation()
                    },
                    saveTaskOrTarget: function (data, callback) {
                        $.ajax({
                            url: '/PlcAssessScore/updateList',
                            data: JSON.stringify(data),
                            contentType: "application/json;charset=UTF-8",
                            dataType: 'json',
                            type: 'post',
                            success: function (res) {
                                if (callback) {
                                    callback(res)
                                }
                            }
                        })
                    }
                },
                created: function () {
                    let _this = this

                    _this.scoreId = $.GetRequest()['scoreId'] || '';

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

                    _this.getListData()
                }
            })
		</script>
	</body>
</html>
