<%--
  Created by IntelliJ IDEA.
  User: 戎成路
  Date: 2020/12/11
  Time: 9:34
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
				z-index: 1;
			}
			
			.container .con_body {
				position: relative;
				width: 100%;
				min-height: 100%;
				padding: 72px 6px 8px;
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
				padding: 10px;
			}
			
			.van-action-sheet__header {
				border-bottom: 1px solid #ccc;
			}
		</style>
	</head>
	<body>
		<div id="app">
			<div class="container">
				<div class="con_header">
					<van-row>
						<van-col span="24">
							<van-dropdown-menu active-color="#1989fa" style="margin-top: 8px;">
								<van-dropdown-item v-model="searchModule.agreeStatus" :options="searchModule.agreeStatusOption" @change="statusChange"/>
							</van-dropdown-menu>
						</van-col>
					</van-row>
				</div>
				<div class="con_body">
					<van-list v-model="loadModule.loading"
					          :finished="loadModule.finished"
					          :error.sync="loadModule.error"
					          error-text="请求失败，点击重新加载"
					          @load="onLoad">
						<template #loading>
							<van-loading color="#faab0c" size="22px">
								<span style="color: #faab0c">加载中...</span>
							</van-loading>
						</template>
						<template #finished>
							<van-divider :style="{ color: '#1989fa', borderColor: '#1989fa', padding: '0 16px' }">
								已加载全部
							</van-divider>
						</template>
						<template #error>
							<span style="display: flex; justify-content: center; align-items: center; font-size: 14px; color: #f00;"><van-icon name="warning-o"
							                                                                                                                   style="margin-right: 3px;"></van-icon>请求失败，点击重新加载</span>
						</template>
						<van-cell v-for="item in listData" :key="item.planId" @click="listClick(item.planId)">
							<van-card>
								<template #title>
									<div class="card_content">
										<div class="list_head">
											<van-row>
												<van-col span="24">
													<p class="list_p" style="display: flex;">
														<span class="p_type" v-text="item.modify == 1 ? '修编' : ''"></span>
														<span class="p_title" :style="{ color: item.agreeStatus == 3 ? '#f00' : '#000' }"
														      v-text="item.planName"></span>
													</p>
												</van-col>
											</van-row>
										</div>
										<div class="list_content">
											<van-row>
												<van-col span="12">
													<p class="list_p p_con">
														<span>审批状态：</span><span v-html="getAgreeStatus(item.agreeStatus)"
														                        @click.stop="agreeStatusClick(item.agreeStatus, item.returnComments, item.questionName)"></span>
													</p>
												</van-col>
												<van-col span="12">
													<p class="list_p p_con">
														<span>类型：</span><span v-text="getPlanClass(item.planClass)"></span>
													</p>
												</van-col>
											</van-row>
											<van-row>
												<van-col span="12">
													<p class="list_p p_con">
														<span>周期类型：</span><span v-text="isShowNull(dictionaryObj['PLAN_SYCLE'][item.planCycle])"></span>
													</p>
												</van-col>
												<van-col span="12">
													<p class="list_p p_con">
														<span>计划类型：</span><span v-text="getPlanType(item.planClass, item.planType)"></span>
													</p>
												</van-col>
											</van-row>
											<van-row>
												<van-col span="12">
													<p class="list_p p_con">
														<span>年度：</span><span v-text="isShowNull(item.planYear)"></span>
													</p>
												</van-col>
												<van-col span="12">
													<p class="list_p p_con">
														<span>月度：</span><span v-text="isShowNull(item.planMonth)"></span>
													</p>
												</van-col>
											</van-row>
											<van-row>
												<van-col span="24">
													<p class="list_p p_con">
														<span>责任人：</span><span v-text="isShowNull(item.dutyUserName)"></span>
													</p>
												</van-col>
											</van-row>
											<van-row>
												<van-col span="24">
													<p class="list_p p_con">
														<span>所属部门：</span><span v-text="isShowNull(item.belongtoUnitName)"></span>
													</p>
												</van-col>
											</van-row>
											<van-row>
												<van-col span="24">
													<p class="list_p p_con" style="display: flex;">
														<span>编制依据：</span>
														<span>
														<a style="display: block;" v-for="file in getFileList(item.attachments1)" :key="file.key"
														   @click="downloadFile($event, file.url, file.attachName)"
														   v-text="file.attachName"></a>
													</span>
													</p>
												</van-col>
											</van-row>
										</div>
									</div>
								</template>
							</van-card>
						</van-cell>
					</van-list>
				</div>
			</div>
			
			<van-action-sheet v-model="sheetShow" title="退回详情" :round="false" :duration="0.2">
				<div class="sheet_content">
					<van-row>
						<van-col span="24" style="font-weight: 600;">退回原因:</van-col>
						<van-col span="24" v-text="returnComments" style="padding: 5px 0;line-height: 1.5;font-size: 14px;text-indent: 2em;"></van-col>
					</van-row>
					<van-row style="margin-top: 20px;">
						<van-col span="24" style="font-weight: 600;">问题关键任务编码名称:</van-col>
						<van-col span="24">
							<template v-for="(item, index) in questionName">
								<p :key="index" v-text="item" style="margin: 5px 0;line-height: 1.5;font-size: 14px;"></p>
							</template>
						</van-col>
					</van-row>
				</div>
			</van-action-sheet>
		</div>
		
		<script>
            let app = new Vue({
                el: '#app',
                data: {
                    loadModule: {
                        loading: false,
                        finished: false,
                        error: false
                    },
                    searchModule: {
                        agreeStatus: 4,
                        agreeStatusOption: [
                            {text: '未审批', value: 4},
                            {text: '已审批', value: 5}
                        ],
                        planName: ''
                    },
                    dictionaryStr: 'PLAN_SYCLE,RENWUJIHUA_TYPE,TG_TYPE',
                    dictionaryObj: {
                        PLAN_SYCLE: {},
                        RENWUJIHUA_TYPE: {},
                        TG_TYPE: {}
                    },
                    pagenation: {
                        page: 1,
                        pageSize: 20,
                        total: 0
                    },
                    listData: [],
                    sheetShow: false,
                    returnComments: '',
                    questionName: []
                },
                methods: {
                    search: function () {
                        let _this = this
                        _this.listData = []
                        _this.pagenation.page = 1
                        _this.pagenation.total = 0
                        _this.loadModule.finished = false
                        _this.loadModule.loading = true
                        _this.onLoad()
                    },
                    getListData: function (callback) {
                        let _this = this

                        let searchData = {
                            page: _this.pagenation.page,
                            pageSize: _this.pagenation.pageSize,
                            apprivalStatus: 1,
                            agreeStatus: _this.searchModule.agreeStatus,
                            targetOrItem: 2
                        }

                        $.get('/plcPlan/query', searchData, function (res) {
                            callback(res)
                        })
                    },
                    onLoad: function () {
                        let _this = this
                        _this.getListData(res => {
                            _this.loadModule.loading = false
                            if (res.flag) {
                                _this.pagenation.total = res.totleNum
                                if ((_this.pagenation.page * _this.pagenation.pageSize) < _this.pagenation.total) {
                                    _this.pagenation.page++
                                } else {
                                    _this.loadModule.finished = true
                                }
                                _this.listData = _this.listData.concat(res.obj)
                            } else {
                                _this.loadModule.error = true
                            }
                        })
                    },
                    statusChange: function () {
                        this.searchModule.planName = ''
                        this.search()
                    },
                    getAgreeStatus: function (agreeStatus, apprivalStatus) {
                        var str = ''
                        if (agreeStatus == 3) {
                            str = '<span style="color: #f00; text-decoration: underline;">退回</span>'
                        } else if (agreeStatus == 2) {
                            str = '同意';
                        } else {
                            if (apprivalStatus == 1) {
                                str = '已上报（待批）'
                            } else {
                                str = '待审批'
                            }
                        }
                        return str
                    },
                    getTaskApproval: function (taskApproval) {
                        var str = ''
                        if (taskApproval == 1) {
                            str = '正在审批'
                        } else if (taskApproval == 2) {
                            str = '同意'
                        } else if (taskApproval == 3) {
                            str = '<span style="color: #f00; text-decoration: underline;">退回</span>'
                        }
                        return str
                    },
                    getPlanClass: function (planClass) {
                        var str = '';
                        switch (planClass) {
                            case '1':
                                str = '主项关键任务';
                                break;
                            case '2':
                                str = '职能关键任务';
                                break;
                            case '3':
                                str = '子任务计划';
                                break;
                            default:
                                break;
                        }

                        return str;
                    },
                    getPlanType: function (planClass, planType) {
                        if (planClass == 3) {
                            return this.dictionaryObj['RENWUJIHUA_TYPE'][planType] || ''
                        } else {
                            return this.dictionaryObj['TG_TYPE'][planType] || ''
                        }
                    },
                    listClick: function (planId) {
                        let url = '/plcPlan/mTaskApprovalDetail?planId=' + planId

                        if (( /(iPhone|iPad|iPod|iOS)/i.test(navigator.userAgent) )) {
                            try {
                                window.webkit.messageHandlers.formInfoUrlLink.postMessage({'url': encodeURI(url), 'name': '子任务审批'});
                            } catch (err) {
                                formInfoUrlLink(encodeURI(url), '子任务审批');
                            }
                        } else if (/(Android)/i.test(navigator.userAgent)) {
                            // Android.formInfoUrlLink(encodeURI(url), '子任务审批');
                            // 上面方式跳转页面无法下载文件
                            window.location.href = url;
                        }
                    },
                    agreeStatusClick: function (agreeStatus, returnComments, questionName, planId) {
                        if (agreeStatus == 3) {
                            this.returnComments = this.isShowNull(returnComments)
                            this.questionName = this.isShowNull(questionName).replace(/,$/, '').split(',')
                            this.sheetShow = true
                        } else {
                            this.listClick(planId)
                        }
                    }
                },
                created: function () {
                    let _this = this

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
                }
            })
		</script>
	</body>
</html>
