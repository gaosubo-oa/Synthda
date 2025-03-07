<%--
  Created by IntelliJ IDEA.
  User: 戎成路
  Date: 2021/1/7
  Time: 10:12
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
		<title>子任务审批</title>

		<meta charset="UTF-8"/>
		<meta name="viewport"
			  content="width=device-width,initial-scale=1,minimum-scale=1,maximum-scale=1,user-scalable=no"/>
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

			.con_body .van-cell {
				margin-top: 10px;
				padding: 10px 12px;
				border-radius: 4px;
				box-shadow: 0 0 10px 0px rgba(0, 0, 0, .1);
			}

			.con_body .van-cell .van-card {
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
				<template v-if="planInfo">
					<div class="con_header">
						<van-row type="flex" justify="space-between" style="height: 100%;">
							<template v-if="!planInfo.agreeStatus || planInfo.agreeStatus == 1">
								<van-col style="height: 100%;" span="17">
									<span class="plan_head" v-text="planInfo.planName"></span>
								</van-col>
								<van-col style="height: 100%;" span="7">
									<div class="plan_head_btn">
										<van-button type="primary" size="small" @click="agreeClick">
											同意
										</van-button>
										<van-button type="danger" size="small" @click="backModule.backSheetShow = true">
											退回
										</van-button>
									</div>
								</van-col>
							</template>
							<template v-else>
								<van-col style="height: 100%;" span="24">
									<p class="plan_head" v-text="planInfo.planName"></p>
								</van-col>
							</template>
						</van-row>
					</div>
					<div class="con_body">
						<template v-if="listData.length > 0">
							<van-cell v-for="item in listData" :key="item.planItemId" @click="listClick(item.planItemId)">
								<van-card>
									<template #title>
										<div class="card_content">
											<div class="list_head">
												<van-row>
													<van-col span="24">
														<p class="list_p">
															<span class="p_title" v-text="planInfo.planClass == 3 ? item.taskName : item.tgName"></span>
														</p>
													</van-col>
												</van-row>
											</div>
											<div class="list_content">
												<van-row>
													<van-col span="10">
														<p class="list_p p_con">
															<span>周期类型：</span><span v-text="dictionaryObj['PLAN_SYCLE'][item.planSycle]"></span>
														</p>
													</van-col>
													<van-col span="14">
														<p class="list_p p_con">
															<span>任务类型：</span><span
															v-text="planInfo.planClass == 3 ? dictionaryObj['RENWUJIHUA_TYPE'][item.taskType] : dictionaryObj['TG_TYPE'][item.tgType]"></span>
														</p>
													</van-col>
												</van-row>
												<van-row>
													<van-col span="10">
														<p class="list_p p_con">
															<span>负责人：</span><span v-text="item.dutyUserName"></span>
														</p>
													</van-col>
													<van-col span="14">
														<p class="list_p p_con">
															<span>责任部门：</span><span v-text="isShowNull(item.mainCenterDeptName).replace(/,$/, '')"></span>
														</p>
													</van-col>
												</van-row>
												<van-row>
													<van-col span="24">
														<p class="list_p p_con">
															<span>计划结束时间：</span><span v-text="item.planStartDate"></span>
														</p>
													</van-col>
												</van-row>
												<van-row>
													<van-col span="24">
														<p class="list_p p_con">
															<span>计划结束时间：</span><span v-text="item.planEndDate"></span>
														</p>
													</van-col>
												</van-row>
												<van-row>
													<van-col span="24">
														<p class="list_p p_con">
															<span>计划工期：</span><span v-text="item.planContinuedDate"></span>
														</p>
													</van-col>
												</van-row>
												<van-row>
													<van-col span="24">
														<p class="list_p p_con">
															<span>完成标准：</span><span v-text="item.resultStandard"></span>
														</p>
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
					</div>
				</template>
			</div>

			<van-action-sheet v-model="taskDetailModule.sheetShow"
			                  title="任务详情"
			                  :round="false"
			                  @closed="taskDetailModule.taskDetail = null"
			                  :duration="0.2">
				<div class="sheet_content">
					<div class="task_detail" v-if="taskDetailModule.taskDetail">
						<van-row>
							<van-col span="8">编号:</van-col>
							<van-col span="16" v-text="isShowNull(taskDetailModule.taskDetail.taskNo)"></van-col>
						</van-row>
						<van-row>
							<van-col span="8">子任务名称:</van-col>
							<van-col span="16" v-text="isShowNull(taskDetailModule.taskDetail.taskName)"></van-col>
						</van-row>
						<van-row>
							<van-col span="8">关联关键任务:</van-col>
							<van-col span="16" v-text="function () {
                                                    var tgIds = ''
                                                    if (taskDetailModule.taskDetail.tgIds) {
                                                        taskDetailModule.taskDetail.tgIds.forEach(function (item) {
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
							<van-col span="16" v-text="isShowNull(dictionaryObj['PLAN_SYCLE'][taskDetailModule.taskDetail.planSycle])"></van-col>
						</van-row>
						<van-row>
							<van-col span="8">任务来源:</van-col>
							<van-col span="16" v-text="isShowNull(dictionaryObj['RENWUJIHUA_TYPE'][taskDetailModule.taskDetail.taskType])"></van-col>
						</van-row>
						<van-row>
							<van-col span="8">负责人:</van-col>
							<van-col span="16" v-text="isShowNull(taskDetailModule.taskDetail.dutyUserName).replace(/,$/, '')"></van-col>
						</van-row>
						<van-row>
							<van-col span="8">责任部门:</van-col>
							<van-col span="16" v-text="isShowNull(taskDetailModule.taskDetail.mainCenterDeptName).replace(/,$/, '')"></van-col>
						</van-row>
						<van-row>
							<van-col span="8">计划开始时间:</van-col>
							<van-col span="16" v-text="format(taskDetailModule.taskDetail.planStartDate)"></van-col>
						</van-row>
						<van-row>
							<van-col span="8">计划结束时间:</van-col>
							<van-col span="16" v-text="format(taskDetailModule.taskDetail.planEndDate)"></van-col>
						</van-row>
						<van-row>
							<van-col span="8">计划工期:</van-col>
							<van-col span="16" v-text="isShowNull(taskDetailModule.taskDetail.planContinuedDate)"></van-col>
						</van-row>
						<van-row>
							<van-col span="8">实际开始时间:</van-col>
							<van-col span="16" v-text="format(taskDetailModule.taskDetail.realStartDate)"></van-col>
						</van-row>
						<van-row>
							<van-col span="8">实际结束时间:</van-col>
							<van-col span="16" v-text="format(taskDetailModule.taskDetail.realEndDate)"></van-col>
						</van-row>
						<van-row>
							<van-col span="8">实际工期:</van-col>
							<van-col span="16" v-text="isShowNull(taskDetailModule.taskDetail.realContinuedDate)"></van-col>
						</van-row>
						<van-row>
							<van-col span="8">前置子任务:</van-col>
							<van-col span="16" v-text="function () {
                                                    var preTasks = ''
                                                    if (taskDetailModule.taskDetail.preTasks) {
                                                        taskDetailModule.taskDetail.preTasks.forEach(function (item) {
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
							<van-col span="16" v-text="isShowNull(taskDetailModule.taskDetail.resultStandard)"></van-col>
						</van-row>
						<van-row>
							<van-col span="8">子任务描述:</van-col>
							<van-col span="16" v-text="isShowNull(taskDetailModule.taskDetail.taskDesc)"></van-col>
						</van-row>
						<van-row>
							<van-col span="8">协助部门:</van-col>
							<van-col span="16" v-text="isShowNull(taskDetailModule.taskDetail.assistCompanyDeptsName).replace(/,$/, '')"></van-col>
						</van-row>
						<van-row>
							<van-col span="8">成果标准模板:</van-col>
							<van-col span="16">
								<a style="display: block;" v-for="file in getFileList(taskDetailModule.taskDetail.attachments2)" :key="file.key"
								   @click="downloadFile($event, file.url, file.attachName)"
								   v-text="file.attachName"></a>
							</van-col>
						</van-row>
						<van-row>
							<van-col span="8">异常原因:</van-col>
							<van-col span="16" v-text="isShowNull(taskDetailModule.taskDetail.unusualRes)"></van-col>
						</van-row>
						<van-row>
							<van-col span="8">异常原因材料:</van-col>
							<van-col span="16">
								<a style="display: block;" v-for="file in getFileList(taskDetailModule.taskDetail.attachments3)" :key="file.key"
								   @click="downloadFile($event, file.url, file.attachName)"
								   v-text="file.attachName"></a>
							</van-col>
						</van-row>
						<van-row>
							<van-col span="8">难度点:</van-col>
							<van-col span="16" v-text="isShowNull(taskDetailModule.taskDetail.difficultPoint)"></van-col>
						</van-row>
						<van-row>
							<van-col span="8">风险点:</van-col>
							<van-col span="16" v-text="isShowNull(taskDetailModule.taskDetail.riskPoint)"></van-col>
						</van-row>
						<van-row>
							<van-col span="8">编制依据附件:</van-col>
							<van-col span="16">
								<a style="display: block;" v-for="file in getFileList(taskDetailModule.taskDetail.attachments4)" :key="file.key"
								   @click="downloadFile($event, file.url, file.attachName)"
								   v-text="file.attachName"></a>
							</van-col>
						</van-row>
					</div>
				</div>
			</van-action-sheet>

			<van-action-sheet v-model="backModule.backSheetShow"
			                  title="退回"
			                  @closed="closeBackModul"
			                  :round="false"
			                  :duration="0.2">
				<div class="sheet_content">
					<van-cell-group title="退回原因">
						<van-field
							v-model="backModule.returnComments"
							rows="3"
							required
							autosize
							label=""
							type="textarea"
							placeholder="请输入退回原因"></van-field>
						<div style="margin: 10px; text-align: center;">
							<van-button type="info" size="small" @click="backModule.backSheetShow = false">取消</van-button>
							<van-button type="danger" size="small" @click="backClick">退回</van-button>
						</div>
						<van-cell title="选择问题任务" is-link @click="backModule.checkBoxShow = true"></van-cell>
						<template v-for="(item, index) in backModule.questionName">
							<van-cell :key="index" :title="'('+item.no+')'+item.name"></van-cell>
						</template>
					</van-cell-group>
				</div>
			</van-action-sheet>

			<van-action-sheet
				title="任务"
				style="height: 60%;"
				v-model="backModule.checkBoxShow"
				:closeable="false"
				cancel-text="确定">
				<div class="sheet_content">
					<van-checkbox-group v-model="backModule.questionName">
						<van-cell-group>
							<van-cell
								v-for="(item, index) in checkboxData"
								clickable
								:key="item.id"
								@click="toggleCheckBox(index)"
								:title="item.name">
								<template #right-icon>
									<van-checkbox :name="item" ref="checkboxes"></van-checkbox>
								</template>
							</van-cell>
						</van-cell-group>
					</van-checkbox-group>
				</div>
			</van-action-sheet>
		</div>

		<script>
			let app = new Vue({
				el: '#app',
				computed: {
                    checkboxData: function() {
                        let _this = this
                        let arr = []
                        if (_this.planInfo && _this.listData.length > 0) {
                            if (_this.planInfo.planClass == 1) {
                                arr = readNodes(this.listData)
                            } else {
                                _this.listData.map(function(item){
                                    let obj = {}
                                    if (_this.planInfo.planClass == 3) {
                                        obj.id = item.planItemId
                                        obj.name = item.taskName
	                                    obj.no = item.taskNo
                                    } else {
                                        obj.id = item.tgId
                                        obj.name = item.tgName
	                                    obj.no = item.tgNo
                                    }
                                    arr.push(obj)
                                })
                            }
                        }
                        return arr
                    }
				},
				data: {
				    planId: '',
                    planInfo: null,
                    listData: [],
                    dictionaryStr: 'PLAN_SYCLE,RENWUJIHUA_TYPE,TG_TYPE',
                    dictionaryObj: {
                        PLAN_SYCLE: {},
                        RENWUJIHUA_TYPE: {},
                        TG_TYPE: {}
                    },
					backModule: {
                        backSheetShow: false,
		                returnComments: '',
		                questionName: [],
		                checkBoxShow: false
	                },
					taskDetailModule: {
                        sheetShow: false,
                        taskDetail: null
                    },
					btnLock: false
				},
				methods: {
				    getListData: function () {
                        let _this = this

					    let toastIndex = _this.$toast.loading('加载中...')

                        $.get('/plcPlan/selectByPlanIdPlus', {planId: _this.planId}, function (res) {
                            if (res.flag) {
                                _this.planInfo = res.object
                            }

                            $.get('/plcPlan/selectByPlanId', {planId: _this.planId}, function (res) {
                                toastIndex.close()
                                if (res.flag) {
                                    _this.listData = res.object
                                } else {
                                    _this.$toast.fail('获取数据失败!')
                                }
                            })
                        })
                    },
					listClick: function (planItemId) {
                        let _this = this
                        if (planItemId) {
                            _this.taskDetailModule.sheetShow = true
                            let toastIndex = _this.$toast.loading('加载中...')
                            $.get('/ProjectDaily/selectProjectDailyByItemId', {planItemId: planItemId}, function (res) {
                                toastIndex.close()
                                if (res.flag) {
                                    _this.taskDetailModule.taskDetail = res.object
                                } else {
                                   _this.$toast.fail('获取数据失败!')
                                }
                            })
                        }
                    },
					agreeClick: function () {
                        let _this = this

	                    if (_this.btnLock) {
	                        return
	                    }
	                    _this.btnLock = true

                        _this.$dialog.confirm({
                            message: '确定同意审批吗？',
                            beforeClose(action, done) {
                                if (action === 'confirm') {
                                    let dataNow = new Date()
                                    let year = dataNow.getFullYear()
                                    let month = dataNow.getMonth() + 1
                                    let day = dataNow.getDate()
                                    if (month < 10) {
                                        month = "0" + month
                                    }
                                    if (day < 10) {
                                        day = "0" + day
                                    }
                                    let today = year + "-" + month + "-" + day

                                    $.post('/plcPlan/updateStatusByIds', {
                                        planIds: _this.planId,
                                        agreeStatus: 2,
                                        taskApproval: 2,
                                        approvalDate: today,
                                        secondApprovalDate: today
                                    }, function (res) {
                                        done()
                                        if (res.flag) {
                                            _this.$notify({
                                                type: 'success', message: '审批成功', duration: 2000, onClose: function () {
                                                    _this.closePage()
                                                }
                                            })
                                        } else {
                                            _this.btnLock = false
                                            _this.$notify({type: 'danger', message: '审批失败', duration: 2000})
                                        }
                                    })
                                } else {
                                    _this.btnLock = false
                                    done()
                                }
                            }
                        }).catch(() => {
                        })
					},
					toggleCheckBox: function(index) {
                        this.$refs.checkboxes[index].toggle();
	                },
	                closeBackModul: function() {
		                this.backModule.returnComments = ''
		                this.backModule.questionName = []
	                },
	                backClick: function () {
                        let _this = this
                        if (_this.btnLock) {
                            return
                        }

                        _this.btnLock = true

                        if (!_this.backModule.returnComments.trim()) {
	                        _this.$notify({type: 'danger', message: '退回原因不能为空', duration: 2000})
                            _this.btnLock = false
                            return
                        }

		                let toastIndex = _this.$toast.loading('退回中...')

                        let questionName = ''
                        _this.backModule.questionName.forEach((item) => {
                            questionName += '(' + item.no + ')' + item.name + ','
                        })

                        let data = {
                            planId: _this.planId,
                            returnComments: _this.backModule.returnComments,
                            questionName: questionName.replace(/,$/, '')
                        }

						let dataNow = new Date()
						let year = dataNow.getFullYear()
						let month = dataNow.getMonth() + 1
						let day = dataNow.getDate()
						if (month < 10) {
							month = "0" + month
						}
						if (day < 10) {
							day = "0" + day
						}
						let today = year + "-" + month + "-" + day

                        $.post('/plcPlan/updatePlcPlan', data, function (json) {
                            if (json.flag) {
                                $.post('/plcPlan/updateStatusByIds', {planIds: _this.planId, agreeStatus: 3,approvalDate: today,secondApprovalDate: today}, function (res) {
                                    toastIndex.close()
                                    if (res.flag) {
                                        _this.$notify({
                                            type: 'success', message: '退回成功', duration: 2000, onClose: function () {
                                                _this.closePage()
                                            }
                                        })
                                    } else {
                                        _this.btnLock = false
                                        _this.$notify({type: 'danger', message: '退回失败', duration: 2000})
                                    }
                                })
                            } else {
                                _this.btnLock = false
                                _this.$notify({type: 'danger', message: '退回失败', duration: 2000})
                            }
                        })
                    }
				},
				created: function(){
				    let _this = this

	                vant.Toast.setDefaultOptions('loading', { forbidClick: true, duration: 0 });

	                _this.planId = $.GetRequest()['planId'] || ''

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

			// 处理主项树结构
            function readNodes(nodes = [], arr = []) {
                for (let item of nodes) {
                    if (item.tgName && item.tgId) {
                        arr.push({
                            id: item.tgId,
                            name: item.tgName,
	                        no: item.tgNo
                        })
                    } else {
                        if (item.children && item.children.length > 0) {
                            readNodes(item.children, arr)
                        }
                    }
                }
                return arr
            }
		</script>
	</body>
</html>
