<%--
  Created by IntelliJ IDEA.
  User: 戎成路
  Date: 2020/12/24
  Time: 13:24
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
				padding: 0 5px;
				box-shadow: 0 0px 10px 1px rgba(0, 0, 0, 0.15);
				background-color: #fff;
				z-index: 2;
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
				color: #3D74BB;
				font-weight: 600;
			}
			
			.list_head .p_title {
				flex: 1;
				font-family: '黑体';
				color: #000;
				font-weight: 600;
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
					<van-row type="flex" justify="space-between">
						<van-col span="5">
							<van-dropdown-menu active-color="#1989fa" style="margin-top: 8px; overflow: hidden;">
								<van-dropdown-item v-model="searchModule.checkValiu" :options="searchModule.checkOption" @change="statusChange"/>
							</van-dropdown-menu>
						</van-col>
						<van-col span="14">
							<span class="ant-input-affix-wrapper">
								<input v-model="searchModule.tgName" placeholder="任务名称" type="text" class="ant-input">
							</span>
						</van-col>
						<van-col span="3" style="display: flex;justify-content: center;align-items: center;">
							<van-button type="info" size="small" icon="search" round @click="search"></van-button>
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
							<span style="display: flex; justify-content: center; align-items: center; font-size: 14px; color: #f00;">
								<van-icon name="warning-o" style="margin-right: 3px;"></van-icon>请求失败，点击重新加载</span>
						</template>
						<van-cell v-for="item in listData" :key="item.socoreId" @click="listClick(item.socoreId)">
							<van-card>
								<template #title>
									<div class="card_content">
										<div class="list_head">
											<van-row>
												<van-col span="24">
													<p class="list_p" style="display: flex;">
														<span class="p_type" v-text="item.tgName ? '[关键任务]' : '[子任务]'"></span>
														<span class="p_title" v-text="item.tgName || item.taskName"></span>
													</p>
												</van-col>
											</van-row>
										</div>
										<div class="list_content">
											<van-row>
												<van-col span="12">
													<p class="list_p p_con">
														<span>责任人：</span><span v-text="item.dutyUserName || ''"></span>
													</p>
												</van-col>
												<van-col span="12">
													<p class="list_p p_con">
														<span>完成状态：</span><span v-text="taskStatus(item.taskStatus)"></span>
													</p>
												</van-col>
											</van-row>
											<van-row>
												<van-col span="12">
													<p class="list_p p_con">
														<span>任务类型：</span><span v-text="getAssistanceStatus(item)"></span>
													</p>
												</van-col>
												<van-col span="12">
													<p class="list_p p_con">
														<span>提交时间：</span><span v-text="format(item.submitTime)"></span>
													</p>
												</van-col>
											</van-row>
											<van-row>
												<van-col span="24">
													<p class="list_p p_con" style="display: flex">
														<span>完成度：</span><span style="flex: 1; padding: 11px 0;"><van-progress
															:percentage="item.taskPrecess || 0"/></span>
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
                        checkValiu: 1,
                        checkOption: [
                            {text: '待考核', value: 1},
                            {text: '已考核', value: 2}
                        ],
                        tgName: ''
                    },
                    dictionaryStr: 'RENWUJIHUA_TYPE',
                    dictionaryObj: {
	                    RENWUJIHUA_TYPE: {}
                    },
                    pagenation: {
                        page: 1,
                        pageSize: 20,
                        total: 0
                    },
                    listData: []
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
                            tgName: _this.searchModule.tgName
                        }

                        let url = ''
                        if (_this.searchModule.checkValiu === 1) {
                            searchData.status = 3
                            url = '/PlcAssessScore/findScoreDataByLoginUser'
                        } else {
                            searchData.apprivalStatus = 1
                            url = '/PlcAssessScore/findAssessmentData'
                        }

                        $.get(url, searchData, function (res) {
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
                        this.searchModule.tgName = ''
                        this.search()
                    },
                    getAssistanceStatus: function (info) {
                        if (info.assistanceStatus == 1) {
                            return '协助'
                        } else {
                            if (info.tgType) {
                                if (info.deptOrProject == 1) {
                                    return '职能关键任务'
                                } else {
                                    return '主项关键任务'
                                }
                            } else {
                                return this.dictionaryObj['RENWUJIHUA_TYPE'][info.taskType] || ''
                            }
                        }
                    },
                    listClick: function (scoreId) {
                        let url = '/plcPlan/mTaskAssessment?scoreId=' + scoreId

                        if (( /(iPhone|iPad|iPod|iOS)/i.test(navigator.userAgent) )) {
                            try {
                                window.webkit.messageHandlers.formInfoUrlLink.postMessage({'url': encodeURI(url), 'name': '子任务考核'});
                            } catch (err) {
                                formInfoUrlLink(encodeURI(url), '子任务考核');
                            }
                        } else if (/(Android)/i.test(navigator.userAgent)) {
                            // Android.formInfoUrlLink(encodeURI(url), '子任务考核');
                            // 上面方式跳转页面无法下载文件
                            window.location.href = url;
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
