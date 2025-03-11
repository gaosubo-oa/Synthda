<%--
  Created by IntelliJ IDEA.
  User: 戎成路
  Date: 2020/12/24
  Time: 15:49
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
			
			.plan_title {
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
				padding: 72px 6px 8px;
				background-color: #fff;
			}
			
			.con_body .van-cell {
				margin-top: 10px;
				padding: 10px 12px;
				border-radius: 4px;
				box-shadow: 0 0 10px 0px rgba(0, 0, 0, .1);
			}
			
			.tree_con .van-cell {
				box-shadow: none;
			}
			
			.tree_con .card_content {
				padding: 5px;
			}
			
			.tree_con .list_content {
				padding: 5px;
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
				padding-top: 3px;
				color: #222;
			}
			
			.van-collapse-item__title {
				padding: 10px 5px !important;
			}
			
			.van-collapse-item__content {
				padding: 0 5px !important;
			}
		</style>
	</head>
	<body>
		<div id="app">
			<div class="container">
				<div class="con_header">
					<van-row type="flex" justify="space-between">
						<van-col span="10">
							<div @click="bottomPopModule.show = true" v-text="bottomPopModule.itemStr" style="color: #1989fa"></div>
						</van-col>
						<van-col span="14">
							<div class="plan_title" @click="leftPopModule.show = true" v-show="bottomPopModule.activeId != 3" v-text="planTitle"></div>
						</van-col>
					</van-row>
				</div>
				<div class="con_body">
					<div v-show="noData">
						<van-empty description="暂无数据"></van-empty>
					</div>
					<div v-show="!noData">
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
							<div>
								<template v-if="planClass == 1">
									<div class="tree_con">
										<tree-list :datas='listData' :type="planClass">
											<template v-slot:render="{item}">
												<div class="card_content" @click="listClick(item.tgId)">
													<div class="list_content">
														<van-row>
															<van-col span="24">
																<p class="list_p p_con">
																	<span>中心责任部门责任人：</span><span v-text="item.dutyUserName || ''"></span>
																</p>
															</van-col>
														</van-row>
														<van-row>
															<van-col span="24">
																<p class="list_p p_con">
																	<span>中心责任部门：</span><span v-text="(item.mainCenterDeptName || '').replace(/,$/, '')"></span>
																</p>
															</van-col>
														</van-row>
														<van-row>
															<van-col span="24">
																<p class="list_p p_con">
																	<span>区域责任部门责任人：</span><span v-text="item.mainAreaUserName || ''"></span>
																</p>
															</van-col>
														</van-row>
														<van-row>
															<van-col span="24">
																<p class="list_p p_con">
																	<span>区域责任部门：</span><span v-text="(item.mainAreaDeptName || '').replace(/,$/, '')"></span>
																</p>
															</van-col>
														</van-row>
														<van-row>
															<van-col span="24">
																<p class="list_p p_con">
																	<span>总承包部责任部门责任人：</span><span v-text="item.mainProjectUserName || ''"></span>
																</p>
															</van-col>
														</van-row>
														<van-row>
															<van-col span="24">
																<p class="list_p p_con">
																	<span>总承包部责任部门：</span><span
																		v-text="(item.mainProjectDeptName || '').replace(/,$/, '')"></span>
																</p>
															</van-col>
														</van-row>
														<van-row>
															<van-col span="24">
																<p class="list_p p_con">
																	<span>计划开始时间：</span><span v-text="item.planStartDate || ''"></span>
																</p>
															</van-col>
														</van-row>
														<van-row>
															<van-col span="24">
																<p class="list_p p_con">
																	<span>计划结束时间：</span><span v-text="item.planEndDate || ''"></span>
																</p>
															</van-col>
														</van-row>
														<van-row>
															<van-col span="12">
																<p class="list_p p_con">
																	<span>计划工期：</span><span v-text="item.planContinuedDate || ''"></span>
																</p>
															</van-col>
															<van-col span="12">
																<p class="list_p p_con">
																	<span>难度系数：</span><span v-text="item.hardDegree || ''"></span>
																</p>
															</van-col>
														</van-row>
													</div>
												</div>
											</template>
										</tree-list>
									</div>
								</template>
								<template v-else-if="planClass == 2">
									<van-cell v-for="item in listData" :key="item.tgId" @click="listClick(item.tgId)">
										<van-card>
											<template #title>
												<div class="card_content">
													<div class="card_content">
														<div class="list_head">
															<van-row>
																<van-col span="24">
																	<p class="list_p" style="display: flex;">
																		<span class="p_title" style="flex: 1;" v-text="item.tgName"></span>
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
															</van-row>
															<van-row>
																<van-col span="12">
																	<p class="list_p p_con">
																		<span>协作部门：</span><span v-text="(item.assistDeptName || '').replace(/,$/, '')"></span>
																	</p>
																</van-col>
															</van-row>
															<van-row>
																<van-col span="24">
																	<p class="list_p p_con">
																		<span>计划开始时间：</span><span v-text="item.planStartDate || ''"></span>
																	</p>
																</van-col>
															</van-row>
															<van-row>
																<van-col span="24">
																	<p class="list_p p_con">
																		<span>计划结束时间：</span><span v-text="item.planEndDate || ''"></span>
																	</p>
																</van-col>
															</van-row>
															<van-row>
																<van-col span="12">
																	<p class="list_p p_con">
																		<span>计划工期：</span><span v-text="item.planContinuedDate || ''"></span>
																	</p>
																</van-col>
																<van-col span="12">
																	<p class="list_p p_con">
																		<span>难度系数：</span><span v-text="item.hardDegree || ''"></span>
																	</p>
																</van-col>
															</van-row>
														</div>
													</div>
												</div>
											</template>
										</van-card>
									</van-cell>
								</template>
								<template v-else-if="planClass == 3">
									<van-cell v-for="item in listData" :key="item.planItemId" @click="listClick(item.planItemId)">
										<van-card>
											<template #title>
												<div class="card_content">
													<div class="list_head">
														<van-row>
															<van-col span="24">
																<p class="list_p" style="display: flex;">
																	<span class="p_title" style="flex: 1;" v-text="item.taskName"></span>
																</p>
															</van-col>
														</van-row>
													</div>
													<div class="list_content">
														<van-row>
															<van-col span="24">
																<p class="list_p p_con">
																	<span>责任人：</span><span v-text="item.dutyUserName || ''"></span>
																</p>
															</van-col>
														</van-row>
														<van-row>
															<van-col span="24">
																<p class="list_p p_con">
																	<span>计划开始时间：</span><span v-text="item.planStartDate || ''"></span>
																</p>
															</van-col>
														</van-row>
														<van-row>
															<van-col span="24">
																<p class="list_p p_con">
																	<span>计划结束时间：</span><span v-text="item.planEndDate || ''"></span>
																</p>
															</van-col>
														</van-row>
														<van-row>
															<van-col span="12">
																<p class="list_p p_con">
																	<span>计划工期：</span><span v-text="item.planContinuedDate || ''"></span>
																</p>
															</van-col>
															<van-col span="12">
																<p class="list_p p_con">
																	<span>难度系数：</span><span v-text="item.hardDegree || ''"></span>
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
									<van-cell v-for="item in listData" :key="item.assistId" @click="listClick(item.assistId)">
										<van-card>
											<template #title>
												<div class="card_content">
													<div class="list_head">
														<van-row>
															<van-col span="24">
																<p class="list_p" style="display: flex;">
																	<span class="p_title" style="flex: 1;" v-text="item.taskName"></span>
																</p>
															</van-col>
														</van-row>
													</div>
													<div class="list_content">
														<van-row>
															<van-col span="12">
																<p class="list_p p_con">
																	<span>协作人：</span><span v-text="item.dutyUserName || ''"></span>
																</p>
															</van-col>
															<van-col span="12">
																<p class="list_p p_con">
																	<span>计划工期：</span><span v-text="item.planContinuedDate || ''"></span>
																</p>
															</van-col>
														</van-row>
														<van-row>
															<van-col span="12">
																<p class="list_p p_con">
																	<span>协作部门：</span><span v-text="(item.assistDeptName || '').replace(/,$/, '')"></span>
																</p>
															</van-col>
														</van-row>
														<van-row>
															<van-col span="24">
																<p class="list_p p_con">
																	<span>计划开始时间：</span><span v-text="item.planStartDate || ''"></span>
																</p>
															</van-col>
														</van-row>
														<van-row>
															<van-col span="24">
																<p class="list_p p_con">
																	<span>计划结束时间：</span><span v-text="item.planEndDate || ''"></span>
																</p>
															</van-col>
														</van-row>
													</div>
												</div>
											</template>
										</van-card>
									</van-cell>
								</template>
							</div>
						</van-list>
					</div>
				</div>
			</div>
			
			<van-popup v-model="bottomPopModule.show" position="bottom" @close="closeBottomPopup">
				<van-tree-select
						:items="bottomPopModule.items"
						:active-id.sync="bottomPopModule.activeId"
						:main-active-index.sync="bottomPopModule.activeIndex"></van-tree-select>
			</van-popup>
			
			<van-popup v-model="leftPopModule.show" position="left" :style="{ height: '100%', width: '70%' }">
				<van-sidebar v-model="leftPopModule.activeKey" style="width: 100%;">
					<template v-for="item in leftPlanData">
						<van-sidebar-item :title="item.planName" :key="item.planId" @click="leftItemClick(item)"></van-sidebar-item>
					</template>
				</van-sidebar>
			</van-popup>
		</div>
		
		<script>

            Vue.component('tree-list', {
                name: 'Tl',// 这儿必须起个名字，这个名字其实就是构造函数的名字。没有名字无法递归组件。
                template: `
					<van-collapse v-model="activeKey" :border='false'>
						<template v-for='item in datas'>
							<van-collapse-item :name="getKey(item)" v-if='getShow(item)'>
								<template #title>
							        <div v-html='getHeader(item)'></div>
							    </template>
								<template v-if='item[child]'>
									<tl :datas='item[child]' :type='type'>
										<template v-slot:render="{item}">
											<slot name="render" v-bind:item='item'></slot>
										</template>
									</tl>
								</template>
								<template v-else>
									<slot name="render" v-bind:item='item'></slot>
								</template>
							</van-collapse-item>
						</template>
					</van-collapse>
			     `,
                props: ['datas', 'type'],
                data: function () {
                    return {
                        activeKey: this.getActiveKey()
                    }
                },
                computed: {
                    child: function () {
                        return this.type == 1 ? 'children' : 'items'
                    }
                },
                methods: {
                    getHeader: function (item) {
                        let str = ''
                        if (item.projectName) {
                            str = '<span style="color: #0A5FA2;">【项目】</span>' + item.projectName
                        } else if (item.pbagName) {
                            str = '<span style="color: #0A5FA2;">【子项目】</span>' + item.pbagName
                        } else if (item.tgName) {
                            str = '<span style="color: #0A5FA2;">【关键任务】</span>' + item.tgName
                        }
                        return str
                    },
                    getKey: function (item) {
                        let str = ''
                        if (item.projectName) {
                            str = 'pro' + item.projectId
                        } else if (item.pbagName) {
                            str = 'pbag' + item.pbagId
                        } else if (item.tgName) {
                            str = 'tg' + item.tgId
                        }
                        return str
                    },
                    getShow: function (item) {
                        let flag = false
                        if (item.tgName || (!!item[this.child] && item[this.child].length > 0)) {
                            flag = true
                        }
                        return flag
                    },
                    getActiveKey: function () {
                        // 展开所有
                        let keys = []

                        this.datas.map(function (item) {
                            if (item.projectName) {
                                keys.push('pro' + item.projectId)
                            } else if (item.pbagName) {
                                keys.push('pbag' + item.pbagId)
                            } else if (item.tgName) {
                                keys.push('tg' + item.tgId)
                            }
                        })

                        return keys
                    }
                }
            })

            let app = new Vue({
                el: '#app',
                computed: {
                    planTitle: function () {
                        let str = ''
                        if (this.bottomPopModule.activeIndex == 0 && this.bottomPopModule.activeId == 1) {
                            // 未分配-关键子任务
                            str = this.leftPopModule.targetModuleOne.dataInfo ? this.leftPopModule.targetModuleOne.dataInfo.planName : ''
                        } else if (this.bottomPopModule.activeIndex == 0 && this.bottomPopModule.activeId == 2) {
                            // 未分配-子任务
                            str = this.leftPopModule.taskModuleOne.dataInfo ? this.leftPopModule.taskModuleOne.dataInfo.planName : ''
                        } else if (this.bottomPopModule.activeIndex == 1 && this.bottomPopModule.activeId == 1) {
                            // 已分配-关键子任务
                            str = this.leftPopModule.targetModuleTwo.dataInfo ? this.leftPopModule.targetModuleTwo.dataInfo.planName : ''
                        } else if (this.bottomPopModule.activeIndex == 1 && this.bottomPopModule.activeId == 2) {
                            // 已分配-子任务
                            str = this.leftPopModule.taskModuleTwo.dataInfo ? this.leftPopModule.taskModuleTwo.dataInfo.planName : ''
                        }
                        return str
                    },
                    leftPlanData: function () {
                        let list = []
                        if (this.bottomPopModule.activeIndex == 0 && this.bottomPopModule.activeId == 1) {
                            // 未分配-关键子任务
                            list = this.leftPopModule.targetModuleOne.data
                        } else if (this.bottomPopModule.activeIndex == 0 && this.bottomPopModule.activeId == 2) {
                            // 未分配-子任务
                            list = this.leftPopModule.taskModuleOne.data
                        } else if (this.bottomPopModule.activeIndex == 1 && this.bottomPopModule.activeId == 1) {
                            // 已分配-关键子任务
                            list = this.leftPopModule.targetModuleTwo.data
                        } else if (this.bottomPopModule.activeIndex == 1 && this.bottomPopModule.activeId == 2) {
                            // 已分配-子任务
                            list = this.leftPopModule.taskModuleTwo.data
                        }
                        return list
                    }
                },
                data: {
                    noData: false,
                    dictionaryStr: '',
                    dictionaryObj: {},
                    loadModule: {
                        loading: false,
                        finished: false,
                        error: false
                    },
                    pagenation: {
                        page: 1,
                        pageSize: 20,
                        total: 0
                    },
                    listData: [],
                    bottomPopModule: {
                        show: false,
                        itemStr: '未分配-子任务',
                        items: [
                            {
                                text: '未分配',
                                children: [
                                    {
                                        text: '关键子任务',
                                        id: 1
                                    },
                                    {
                                        text: '子任务',
                                        id: 2
                                    },
                                    {
                                        text: '协助子任务',
                                        id: 3
                                    }
                                ]
                            },
                            {
                                text: '已分配',
                                children: [
                                    {
                                        text: '关键子任务',
                                        id: 1
                                    },
                                    {
                                        text: '子任务',
                                        id: 2
                                    },
                                    {
                                        text: '协助子任务',
                                        id: 3
                                    }
                                ]
                            }
                        ],
                        activeId: 2, // 1、关键子任务，2、子任务，3、协助子任务
                        activeIndex: 0 // 1(0)、未分配，2(1)、已分配
                    },
                    leftPopModule: {
                        show: false,
                        activeKey: 0,
                        targetModuleOne: {
                            isFirst: true,
                            data: [],
                            dataInfo: null
                        },
                        taskModuleOne: {
                            isFirst: true,
                            data: [],
                            dataInfo: null
                        },
                        targetModuleTwo: {
                            isFirst: true,
                            data: [],
                            dataInfo: null
                        },
                        taskModuleTwo: {
                            isFirst: true,
                            data: [],
                            dataInfo: null
                        }
                    },
                    planClass: 0
                },
                methods: {
                    getListData: function (planInfo) {
                        let _this = this
                        _this.planClass = !!planInfo ? planInfo.planClass : ''
                        let searchData = {}
                        let status = _this.bottomPopModule.activeIndex == 0 ? 1 : 2
                        let url = ''
                        if (_this.bottomPopModule.activeId == 3) {
                            url = '/plcProjectItem/getAssist'
                            searchData = {
                                page: _this.pagenation.page,
                                pageSize: _this.pagenation.pageSize,
                                useFlag: true,
                                flag: 1,
                                status: status
                            }
                        } else {
                            searchData = {
                                planId: planInfo.planId,
                                status: status
                            }
                            if (_this.planClass == 1 || _this.planClass == 3) {
                                url = '/plcPlan/selectByPlanIdAndPer'
                            } else {
                                searchData.page = _this.pagenation.page
                                searchData.pageSize = _this.pagenation.pageSize
                                searchData.useFlag = true
                                url = '/plcPlan/selectByPlanIdAndPer'
                            }
                        }

                        $.get(url, searchData, function (res) {
                            _this.loadModule.loading = false
                            if (res.flag) {
                                if (_this.planClass == 1 || _this.planClass == 3) {
                                    _this.listData = res.object
                                    _this.loadModule.finished = true
                                } else {
                                    _this.pagenation.total = res.totleNum
                                    if ((_this.pagenation.page * _this.pagenation.pageSize) < _this.pagenation.total) {
                                        _this.pagenation.page++
                                    } else {
                                        _this.loadModule.finished = true
                                    }
                                    _this.listData = _this.listData.concat(res.object)
                                }
                            } else {
                                _this.loadModule.error = true
                            }
                        })
                    },
                    getProjectList: function (queryType, callback) {
                        let _this = this
                        queryType = queryType ? queryType : 1
                        if (_this.bottomPopModule.activeIndex == 0 && _this.bottomPopModule.activeId == 1) {
                            // 未分配-关键子任务
                            if (_this.leftPopModule.targetModuleOne.isFirst) {
                                _this.leftPopModule.targetModuleOne.isFirst = false
                                getAll({
                                    status: 1,
                                    taskApproval: 2,
                                    flag: 1
                                }, function (res) {
                                    if (res.flag) {
                                        if (res.object && res.object.length > 0) {
                                            _this.leftPopModule.targetModuleOne.data = res.object
                                            _this.leftPopModule.targetModuleOne.dataInfo = res.object[0]
                                            callback(1, _this.leftPopModule.targetModuleOne.dataInfo)
                                        } else {
                                            callback(2)
                                        }
                                    } else {
                                        _this.leftPopModule.targetModuleOne.isFirst = true
                                        callback(0)
                                    }
                                })
                            } else {
                                if (_this.leftPopModule.targetModuleOne.data.length > 0) {
                                    if (queryType != 2) {
                                        _this.leftPopModule.targetModuleOne.dataInfo = _this.leftPopModule.targetModuleOne.data[0]
                                    }
                                    callback(1, _this.leftPopModule.targetModuleOne.dataInfo)
                                } else {
                                    callback(2)
                                }
                            }
                        } else if (_this.bottomPopModule.activeIndex == 0 && _this.bottomPopModule.activeId == 2) {
                            // 未分配-子任务
                            if (_this.leftPopModule.taskModuleOne.isFirst) {
                                _this.leftPopModule.taskModuleOne.isFirst = false
                                getAll({
                                    status: 1,
                                    taskApproval: 2,
                                    flag: 2
                                }, function (res) {
                                    if (res.flag) {
                                        if (res.object && res.object.length > 0) {
                                            _this.leftPopModule.taskModuleOne.data = res.object
                                            _this.leftPopModule.taskModuleOne.dataInfo = res.object[0]
                                            callback(1, _this.leftPopModule.taskModuleOne.dataInfo)
                                        } else {
                                            callback(2)
                                        }
                                    } else {
                                        _this.leftPopModule.taskModuleOne.isFirst = false
                                        callback(0)
                                    }
                                })
                            } else {
                                if (_this.leftPopModule.taskModuleOne.data.length > 0) {
                                    if (queryType != 2) {
                                        _this.leftPopModule.taskModuleOne.dataInfo = _this.leftPopModule.taskModuleOne.data[0]
                                    }
                                    callback(1, _this.leftPopModule.taskModuleOne.dataInfo)
                                } else {
                                    callback(2)
                                }
                            }
                        } else if (_this.bottomPopModule.activeIndex == 1 && _this.bottomPopModule.activeId == 1) {
                            // 已分配-关键子任务
                            if (_this.leftPopModule.targetModuleTwo.isFirst) {
                                _this.leftPopModule.targetModuleTwo.isFirst = false
                                getAll({
                                    status: 2,
                                    taskApproval: 2,
                                    flag: 1
                                }, function (res) {
                                    if (res.flag) {
                                        if (res.object && res.object.length > 0) {
                                            _this.leftPopModule.targetModuleTwo.data = res.object
                                            _this.leftPopModule.targetModuleTwo.dataInfo = res.object[0]
                                            callback(1, _this.leftPopModule.targetModuleTwo.dataInfo)
                                        } else {
                                            callback(2)
                                        }
                                    } else {
                                        _this.leftPopModule.targetModuleTwo.isFirst = true
                                        callback(0)
                                    }
                                })
                            } else {
                                if (_this.leftPopModule.targetModuleTwo.data.length > 0) {
                                    if (queryType != 2) {
                                        _this.leftPopModule.targetModuleTwo.dataInfo = _this.leftPopModule.targetModuleTwo.data[0]
                                    }
                                    callback(1, _this.leftPopModule.targetModuleTwo.dataInfo)
                                } else {
                                    callback(2)
                                }
                            }
                        } else if (_this.bottomPopModule.activeIndex == 1 && _this.bottomPopModule.activeId == 2) {
                            // 已分配-子任务
                            if (_this.leftPopModule.taskModuleTwo.isFirst) {
                                _this.leftPopModule.taskModuleTwo.isFirst = false
                                getAll({
                                    status: 2,
                                    taskApproval: 2,
                                    flag: 2
                                }, function (res) {
                                    if (res.flag) {
                                        if (res.object && res.object.length > 0) {
                                            _this.leftPopModule.taskModuleTwo.data = res.object
                                            _this.leftPopModule.taskModuleTwo.dataInfo = res.object[0]
                                            callback(1, _this.leftPopModule.taskModuleTwo.dataInfo)
                                        } else {
                                            callback(2)
                                        }
                                    } else {
                                        _this.leftPopModule.taskModuleTwo.isFirst = true
                                        callback(0)
                                    }
                                })
                            } else {
                                if (_this.leftPopModule.taskModuleTwo.data.length > 0) {
                                    if (queryType != 2) {
                                        _this.leftPopModule.taskModuleTwo.dataInfo = _this.leftPopModule.taskModuleTwo.data[0]
                                    }
                                    callback(1, _this.leftPopModule.taskModuleTwo.dataInfo)
                                } else {
                                    callback(2)
                                }
                            }
                        }

                        function getAll(query, callback) {
                            $.get('/plcPlan/getAll', query, function (res) {
                                callback(res)
                            })
                        }
                    },
                    onLoad: function (queryType) {
                        let _this = this

                        // 默认加载未分配子任务项目
                        if (_this.bottomPopModule.activeId == 3) {
                            _this.getListData()
                        } else {
                            _this.getProjectList(queryType, function (flag, planInfo) {
                                if (flag == 1) {
                                    _this.getListData(planInfo)
                                } else if (flag == 2) {
                                    _this.noData = true
                                    _this.loadModule.loading = false
                                    _this.loadModule.finished = true
                                } else {
                                    _this.loadModule.loading = false
                                    _this.loadModule.error = true
                                }
                            })
                        }
                    },
                    closeBottomPopup: function () {
                        let activeIndex = this.bottomPopModule.activeIndex
                        let str1 = ''
                        if (activeIndex == 0) {
                            str1 = '未审批'
                        } else if (activeIndex == 1) {
                            str1 = '已审批'
                        }
                        let activeId = this.bottomPopModule.activeId
                        let str2 = ''
                        if (activeId == 1) {
                            str2 = '关键子任务'
                        } else if (activeId == 2) {
                            str2 = '子任务'
                        } else if (activeId == 3) {
                            str2 = '协助子任务'
                        }

                        this.bottomPopModule.itemStr = str1 + '-' + str2

                        this.leftPopModule.activeKey = 0
                        this.planClass = 0
                        this.listData = []
                        this.pagenation.page = 1
                        this.pagenation.total = 0
                        this.noData = false
                        this.loadModule.loading = false
                        this.loadModule.finished = false
                        this.loadModule.loading = true
                        this.onLoad()
                    },
                    leftItemClick: function (item) {
                        if (this.bottomPopModule.activeIndex == 0 && this.bottomPopModule.activeId == 1) {
                            // 未分配-关键子任务
                            this.leftPopModule.targetModuleOne.dataInfo = item
                        } else if (this.bottomPopModule.activeIndex == 0 && this.bottomPopModule.activeId == 2) {
                            // 未分配-子任务
                            this.leftPopModule.taskModuleOne.dataInfo = item
                        } else if (this.bottomPopModule.activeIndex == 1 && this.bottomPopModule.activeId == 1) {
                            // 已分配-关键子任务
                            this.leftPopModule.targetModuleTwo.dataInfo = item
                        } else if (this.bottomPopModule.activeIndex == 1 && this.bottomPopModule.activeId == 2) {
                            // 已分配-子任务
                            this.leftPopModule.taskModuleTwo.dataInfo = item
                        }
                        this.leftPopModule.show = false

                        this.planClass = 0
                        this.listData = []
                        this.pagenation.page = 1
                        this.pagenation.total = 0
                        this.noData = false
                        this.loadModule.loading = false
                        this.loadModule.finished = false
                        this.loadModule.loading = true
                        this.onLoad(2)
                    },
                    listClick: function (id) {
                        let status = this.bottomPopModule.activeIndex == 0 ? 1 : 2
                        let url = '/plcPlan/mAssessment?id=' + id + '&planClass=' + this.planClass + '&status=' + status

                        if (( /(iPhone|iPad|iPod|iOS)/i.test(navigator.userAgent) )) {
                            try {
                                window.webkit.messageHandlers.formInfoUrlLink.postMessage({'url': encodeURI(url), 'name': '分配确认'})
                            } catch (err) {
                                formInfoUrlLink(encodeURI(url), '分配确认')
                            }
                        } else if (/(Android)/i.test(navigator.userAgent)) {
                            // Android.formInfoUrlLink(encodeURI(url), '分配确认')
                            // 上面方式跳转页面无法下载文件
                            window.location.href = url
                        }
                    }
                }
            })
		</script>
	</body>
</html>
