<%--
  Created by IntelliJ IDEA.
  User: 戎成路
  Date: 2021/1/7
  Time: 10:48
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
		<title>考核审核</title>

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

			.con_header .plan_head {
				display: flex;
				align-items: center;
				line-height: 1.5;
				height: 100%;
				margin: 0px;
			}

			.con_header .plan_head_btn {
				display: flex;
				justify-content: space-around;
				align-items: center;
				height: 100%;
			}

			.container .con_body {
				position: relative;
				width: 100%;
				min-height: 100%;
				padding: 72px 8px 6px;
				background-color: #fff;
			}

			.con_body .tab_con .van-cell {
				margin-top: 10px;
				padding: 10px 12px;
				border-radius: 4px;
				box-shadow: 0 0 10px 0px rgba(0, 0, 0, .1);
			}

			.con_body .tab_con .van-cell .van-card {
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

			.van-action-sheet {
				height: 100%;
				max-height: 100%;
			}

			.sheet_content {
				position: relative;
				padding: 10px 0;
			}

			.van-action-sheet__header {
				border-bottom: 1px solid #ccc;
			}

			.task_detail .van-row {
				padding: 5px 15px;
			}

			.van-cell-group__title {
				color: #222;
			}
		</style>
	</head>
	<body>
		<div id="app">
			<div class="container">
				<template v-if="scoreData && taskData">
					<div class="con_header">
						<van-row type="flex" justify="space-between" style="height: 100%;">
							<template v-if="scoreData.groupApprivalStatus == 0">
								<van-col style="height: 100%;" span="17">
									<span class="plan_head" v-text="taskType == 1 ? taskData.tgName : taskData.taskName"></span>
								</van-col>
								<van-col style="height: 100%;" span="7">
									<div class="plan_head_btn">
										<van-button type="info" size="small" @click="saveData">
											保存
										</van-button>
										<van-button type="primary" size="small" @click="assessmentData">
											完成
										</van-button>
									</div>
								</van-col>
							</template>
							<template v-else>
								<van-col style="height: 100%;" span="24">
									<p class="plan_head" v-text="taskType == 1 ? taskData.tgName : taskData.taskName"></p>
								</van-col>
							</template>
						</van-row>
					</div>
					<div class="con_body">
						<div class="con_info">
							<van-cell-group>
								<van-cell>
									<template #default>
										<van-row>
											<van-col span="6">
												<span>任务来源:</span>
											</van-col>
											<van-col span="18">
												<span v-text="getTaskType()"></span>
											</van-col>
										</van-row>
									</template>
								</van-cell>
								<van-cell>
									<template #default>
										<van-row>
											<van-col span="6">
												<span>责任人:</span>
											</van-col>
											<van-col span="18">
												<span v-text="isShowNull(scoreData.dutyUserName).replace(/,$/, '')"></span>
											</van-col>
										</van-row>
									</template>
								</van-cell>
								<van-cell>
									<template #default>
										<van-row>
											<van-col span="6">
												<span>难度系数:</span>
											</van-col>
											<van-col span="18">
												<span v-text="scoreData.hardDegree"></span>
											</van-col>
										</van-row>
									</template>
								</van-cell>
								<van-cell>
									<template #default>
										<van-row>
											<van-col span="6">
												<span>完成度:</span>
											</van-col>
											<van-col span="18" style="padding: 10px 0;">
												<van-progress :percentage="isShowNull(scoreData.taskPrecess)"></van-progress>
											</van-col>
										</van-row>
									</template>
								</van-cell>
								<van-cell>
									<template #default>
										<van-row>
											<van-col span="6">
												<span>质量得分:</span>
											</van-col>
											<van-col span="18">
												<span v-text="scoreData.qualityScore"></span>
											</van-col>
										</van-row>
									</template>
								</van-cell>
								<van-cell>
									<template #default>
										<van-row>
											<van-col span="6">
												<span>审核意见:</span>
											</van-col>
											<van-col span="18">
												<span v-text="scoreData.apprivalComment || '无'"></span>
											</van-col>
										</van-row>
									</template>
								</van-cell>
								<van-cell>
									<template #default>
										<van-row>
											<van-col span="6">
												<span>单项得分:</span>
											</van-col>
											<van-col span="18">
												<span v-text="scoreData.endScore"></span>
											</van-col>
										</van-row>
									</template>
								</van-cell>
								<van-cell>
									<template #default>
										<van-row>
											<van-col span="6">
												<span>完成状态:</span>
											</van-col>
											<van-col span="18">
												<span v-text="taskStatus(scoreData.taskStatus)"></span>
											</van-col>
										</van-row>
									</template>
								</van-cell>
								<van-field
									v-model="apprivalOpinion"
									rows="2"
									autosize
									type="textarea"
									name="apprivalOpinion"
									label="小组审批意见"
									placeholder="填写小组审批意见"
									required
									:readonly="scoreData.groupApprivalStatus != 0"></van-field>
								<van-field
									v-model="minusPoints"
									name="minusPoints"
									label="扣分项"
									type="number"
									placeholder="填写扣分项"
									required
									:readonly="scoreData.groupApprivalStatus != 0"></van-field>
								<van-cell>
									<template #default>
										<van-row>
											<van-col span="6">
												<span>提交成果:</span>
											</van-col>
											<van-col span="18">
												<a style="display: block;" v-for="file in getFileList(scoreData.attachmentList1)" :key="file.key"
												   @click="downloadFile($event, file.url, file.attachName)"
												   v-text="file.attachName"></a>
											</van-col>
										</van-row>
									</template>
								</van-cell>
								<template v-if="scoreData.unusualStuff">
									<van-cell>
										<template #default>
											<van-row>
												<van-col span="6">
													<span>异常原因:</span>
												</van-col>
												<van-col span="18">
													<span v-text="scoreData.unusualStuff"></span>
												</van-col>
											</van-row>
										</template>
									</van-cell>
								</template>
								<template v-if="scoreData.attachmentList2 && scoreData.attachmentList2.length > 0">
									<van-cell>
										<template #default>
											<van-row>
												<van-col span="6">
													<span>异常材料:</span>
												</van-col>
												<van-col span="18">
													<a style="display: block;" v-for="file in getFileList(scoreData.attachmentList2)" :key="file.key"
													   @click="downloadFile($event, file.url, file.attachName)"
													   v-text="file.attachName"></a>
												</van-col>
											</van-row>
										</template>
									</van-cell>
								</template>
							</van-cell-group>
						</div>
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
									<template v-if="taskData">
										<van-cell>
											<van-card>
												<template #title>
													<div class="card_content">
														<div style="padding-top: 5px;">
															<van-row>
																<van-col span="8">编号:</van-col>
																<van-col span="16" v-text="isShowNull(taskData.taskNo)"></van-col>
															</van-row>
															<van-row>
																<van-col span="8">关联关键任务:</van-col>
																<van-col span="16" v-text="function () {
                                                var tgIds = ''
                                                if (taskData.tgIds) {
                                                    taskData.tgIds.forEach(function (item) {
                                                        tgIds += item.tgName + ','
                                                    })
                                                    return tgIds.replace(/,$/, '')
                                                } else {
                                                    return ''
                                                }
                                            }()"></van-col>
															</van-row>
															<van-row>
																<van-col span="8">周期类型:</van-col>
																<van-col span="16"
																         v-text="isShowNull(dictionaryObj['PLAN_SYCLE'][taskData.planSycle])"></van-col>
															</van-row>
															<van-row>
																<van-col span="8">子任务类型:</van-col>
																<van-col span="16"
																         v-text="isShowNull(dictionaryObj['RENWUJIHUA_TYPE'][taskData.taskType])"></van-col>
															</van-row>
															<van-row>
																<van-col span="8">负责人:</van-col>
																<van-col span="16" v-text="isShowNull(taskData.dutyUserName).replace(/,$/, '')"></van-col>
															</van-row>
															<van-row>
																<van-col span="8">所属部门:</van-col>
																<van-col span="16" v-text="isShowNull(taskData.mainCenterDeptName).replace(/,$/, '')"></van-col>
															</van-row>
															<van-row>
																<van-col span="8">计划开始时间:</van-col>
																<van-col span="16" v-text="format(taskData.planStartDate)"></van-col>
															</van-row>
															<van-row>
																<van-col span="8">计划结束时间:</van-col>
																<van-col span="16" v-text="format(taskData.planEndDate)"></van-col>
															</van-row>
															<van-row>
																<van-col span="8">计划工期:</van-col>
																<van-col span="16" v-text="isShowNull(taskData.planContinuedDate)"></van-col>
															</van-row>
															<van-row>
																<van-col span="8">实际开始时间:</van-col>
																<van-col span="16" v-text="format(taskData.realStartDate)"></van-col>
															</van-row>
															<van-row>
																<van-col span="8">实际结束时间:</van-col>
																<van-col span="16" v-text="format(taskData.realEndDate)"></van-col>
															</van-row>
															<van-row>
																<van-col span="8">实际工期:</van-col>
																<van-col span="16" v-text="isShowNull(taskData.realContinuedDate)"></van-col>
															</van-row>
															<van-row>
																<van-col span="8">前置子任务:</van-col>
																<van-col span="16" v-text="function () {
                                                var preTasks = ''
                                                if (taskData.preTasks) {
                                                    taskData.preTasks.forEach(function (item) {
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
																<van-col span="16" v-text="isShowNull(taskData.resultStandard)"></van-col>
															</van-row>
															<van-row>
																<van-col span="8">子任务描述:</van-col>
																<van-col span="16" v-text="isShowNull(taskData.taskDesc)"></van-col>
															</van-row>
															<van-row>
																<van-col span="8">协助部门:</van-col>
																<van-col span="16" v-text="isShowNull(taskData.assistCompanyDeptsName)"></van-col>
															</van-row>
															<van-row>
																<van-col span="8">成果标准模板:</van-col>
																<van-col span="16" v-text="function () {
                                                var resultDictName = '';
                                                if (!!taskData.resultDict) {
                                                    var resultDictList = taskData.resultDict.split(',');

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
																	<a style="display: block;" v-for="file in getFileList(taskData.attachments2)"
																	   :key="file.key"
																	   @click="downloadFile($event, file.url, file.attachName)"
																	   v-text="file.attachName"></a>
																</van-col>
															</van-row>
															<van-row>
																<van-col span="8">难度点:</van-col>
																<van-col span="16" v-text="isShowNull(taskData.difficultPoint)"></van-col>
															</van-row>
															<van-row>
																<van-col span="8">风险点:</van-col>
																<van-col span="16" v-text="isShowNull(taskData.riskPoint)"></van-col>
															</van-row>
															<van-row>
																<van-col span="8">编制依据附件:</van-col>
																<van-col span="16">
																	<a style="display: block;" v-for="file in getFileList(taskData.attachments4)"
																	   :key="file.key"
																	   @click="downloadFile($event, file.url, file.attachName)"
																	   v-text="file.attachName"></a>
																</van-col>
															</van-row>
														</div>
													</div>
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
				</template>
			</div>
		</div>

		<script>
			let app = new Vue({
				el: '#app',
				data: {
				    scoreId: '',
                    taskType: '',
					dictionaryObj: {
                        UNIT: {},
                        CONTROL_LEVEL: {},
                        RENWUJIHUA_TYPE: {},
                        TG_TYPE: {},
                        PLAN_SYCLE: {},
                        PLAN_PHASE: {},
                        CGCL_TYPE: {}
                    },
                    dictionaryStr: 'UNIT,CONTROL_LEVEL,RENWUJIHUA_TYPE,TG_TYPE,PLAN_SYCLE,PLAN_PHASE,CGCL_TYPE',
					scoreData: null,
					taskData: null,
					assessmentArr: [],
					apprivalOpinion: '',
					minusPoints: '',
					tabIndex: 0,
					btnLock: false
				},
				methods: {
				    getTaskType: function () {
                        if (this.taskData.assistanceStatus == 1) {
                            return '协助'
                        } else {
                            if (this.taskData.tgType) {
                                if (this.taskData.deptOrProject == 1) {
                                    return '职能关键任务'
                                } else {
                                    return '主项关键任务'
                                }
                            } else {
                                return this.dictionaryObj['RENWUJIHUA_TYPE'][this.taskData.taskType] || ''
                            }
                        }
                    },
                    getScoreData: function () {
                        let _this = this

	                    let toastIndex = _this.$toast.loading('加载中...')

                        $.get('/PlcAssessScore/findAssessmentDataByScoreId', {scoreId: _this.scoreId}, function (res) {
                            toastIndex.close()
                            if (res.flag) {
                                _this.scoreData = res.data
                                _this.apprivalOpinion = res.data.apprivalOpinion
                                _this.minusPoints = res.data.minusPoints
                                let tData = {}
                                if (res.data.tgId) {
                                    tData.tgId = res.data.tgId
                                    _this.taskType = 1
                                } else if (res.data.planItemId) {
                                    tData.planItemId = res.data.planItemId
                                    _this.taskType = 2
                                }
                                if (_this.taskType) {
                                    $.get('/ProjectDaily/selectProjectDailyByItemId', tData, function (json) {
                                        if (json.flag) {
                                            _this.taskData = json.object
                                            _this.assessmentArr = json.data
                                        }
                                    })
                                }
                            }
                        })
                    },
                    saveData: function () {
                        let _this = this

	                    if (_this.btnLock) {
	                        return
	                    }

	                    let toastIndex = _this.$toast.loading('保存中...')

	                    _this.btnLock = true

                        _this.saveFunc(function (res) {
                            toastIndex.close()
                            _this.btnLock = false
                            if (res.flag) {
                                _this.$notify({type: 'success', message: '保存成功', duration: 2000})
                            } else {
                                _this.$notify({type: 'danger', message: '保存失败', duration: 2000})
                            }
                        })
                    },
					assessmentData: function() {
                        let _this = this

						if (_this.btnLock) {
	                        return
	                    }

	                    let toastIndex = _this.$toast.loading('保存中...')

	                    _this.btnLock = true

                        _this.saveFunc(function (json) {
                            if (json.flag) {
                                let data = {socoreIds: _this.scoreId, groupApprivalStatus: 1}
                                $.post('/PlcAssessScore/updateGroupStatus', data, function (res) {
                                    _this.btnLock = false
                                    if (res.flag) {
                                        _this.$notify({
                                            type: 'success', message: '完成成功', duration: 2000, onClose: function () {
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
                                });
                            } else {
                                toastIndex.close()
                                _this.$notify({type: 'danger', message: '保存失败', duration: 2000})
                                _this.btnLock = false
                            }
                        })
                    },
					saveFunc: function(callback) {
                        let data = [{
                            socoreId: this.scoreId,
	                        minusPoints: this.minusPoints || '',
	                        apprivalOpinion: this.apprivalOpinion || ''
                        }]

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

					vant.Toast.setDefaultOptions('loading', { forbidClick: true, duration: 0 });

					_this.scoreId = $.GetRequest()['scoreId'] || ''

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

					_this.getScoreData()
				}
			})
		</script>
	</body>
</html>
