<%--
  Created by IntelliJ IDEA.
  User: 戎成路
  Date: 2020/9/16
  Time: 16:20
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@taglib prefix="mvc" uri="http://www.springframework.org/tags/form" %>
<%@taglib prefix="fmt" uri="http://www.springframework.org/tags" %>
<%@ page import="java.util.*" %>
<%
	Long datetime = new Date().getTime(); // 获取系统时间
%>
<html>
	<head>
		<title>计划填报</title>
		
		<meta charset="UTF-8"/>
		<meta name="viewport" content="width=device-width,initial-scale=1,minimum-scale=1,maximum-scale=1,user-scalable=no"/>
		
		<link rel="stylesheet" href="/lib/antDesign/antd.min.css">
		
		<script src="/js/xoajq/xoajq1.js"></script>
		<script src="/js/base/base.js?<%=datetime%>"></script>
		<script src="/lib/antDesign/vue.min.js?<%=datetime%>"></script>
		<script src="/lib/antDesign/moment.js?<%=datetime%>"></script>
		<script src="/lib/antDesign/antd.min.js?<%=datetime%>"></script>
		
		<style>
			.ant-cascader-menu-item-expand-icon {
				top: 50%;
				transform: translateY(-50%) !important;
			}
			
			.head {
				/*position: absolute;*/
				/*top: 0;*/
				/*left: 0;*/
				/*width: 100%;*/
				line-height: 30px;
				padding: 10px 20px;
				border-bottom: 1px solid rgb(204, 204, 204);
			}
			
			.content {
				position: absolute;
				top: 0;
				width: 100%;
				height: calc(100% - 58px);
				margin-top: 58px;
				padding: 10px;
				overflow: hidden;
			}
			
			.list_card {
				display: flex;
				padding: 10px;
				box-shadow: 0 0 5px -2px rgba(0, 0, 0, .8);
				border-radius: 5px;
			}
		</style>
	
	</head>
	<body>
		<div id="app">
			<div class="head">
				<a-cascader v-model="defaultValue" :options="options" @change="onChange">
					<a-icon href="#" type="menu-fold" :style="{ fontSize: '30px', color: '#08c' }"/>
				</a-cascader>
				<span style="margin-left: 10px; font-size: 18px; vertical-align: top;">{{ text }}</span>
			</div>
			
			<scroller-component ref="scroller">
				<a-spin :spinning="spinning" tip="加载中...">
					<template v-if="data.length == 0">
						<a-empty style="margin-top: 40%"/>
					</template>
					<template v-else>
						<a-list :grid="{ gutter: 16, column: 1 }" :data-source="data">
							<a-list-item slot="renderItem" slot-scope="item, index">
								<div class="list_card" @click="listClick(item.id,item.type)">
									<div style="margin-right: 5px;">
										<a-avatar :src="getStatus(item.status).url"/>
									</div>
									<div style="flex: 1;">
										<h3 v-text="item.name"></h3>
										<p style="display: flex; justify-content: space-between;">
											<span style="color: #8f8f94;">完成度：<span v-text="item.taskPrecess"></span>%</span>
											<span style="color: #007aff;">截止日期：<span v-text="format(item.planEndDate)"></span></span>
										</p>
									</div>
								</div>
							</a-list-item>
						</a-list>
					</template>
				</a-spin>
			</scroller-component>
		</div>
		
		<script>

            Vue.component('scroller-component', {
                template: '<div class="scroller_wrapper" :style="wrapperStyle" ref="scrollerWrapper"@touchstart="onStart"\n' +
                    '\t\t\t     @touchmove="onMove"\n' +
                    '\t\t\t     @touchend="onEnd"\n' +
                    '\t\t\t     @touchcancel="onEnd"\n' +
                    '\t\t\t     @mousedown="onStart"\n' +
                    '\t\t\t     @mousemove="onMove"\n' +
                    '\t\t\t     @mouseup="onEnd"\n' +
                    '\t\t\t     @mousecancel="onEnd"\n' +
                    '\t\t\t     @mouseleave="onEnd"\n' +
                    '\t\t\t     @transitionend="onTransitionEnd"><div :style="scrollerStyle" ref="scrollerContent"><slot></slot></div></div>',
                data: function () {
                    return {
                        wrapperStyle: {
                            'position': 'absolute',
	                        'top': '0',
	                        'width': '100%',
	                        'height': 'calc(100% - 58px)',
	                        'margin-top': '58px',
	                        'padding': '10px',
	                        'overflow': 'hidden'
                        },
                        wrapper: null,
                        scroller: null,
	                    minY: 0,
                        maxY: 0,
                        wrapperHeight: 0,
                        offsetY: 0,
                        duration: 0,
                        bezier: 'linear',
                        startY: 0,
                        pointY: 0,
                        startTime: 0,                 // 惯性滑动范围内的 startTime
                        momentumStartY: 0,            // 惯性滑动范围内的 startY
                        momentumTimeThreshold: 300,   // 惯性滑动的启动 时间阈值
                        momentumYThreshold: 15,       // 惯性滑动的启动 距离阈值
                        isStarted: true,             // start锁
                    }
                },
	            computed: {
                    scrollerStyle() {
                        return {
                            'transform': 'translate3d(0, '+this.offsetY+'px, 0)',
                            'transition-duration': +this.duration+'ms',
                            'transition-timing-function': this.bezier,
                        }
                    }
                },
                methods: {
                    onStart: function (e) {
                        this.getMinY();
                        const point = e.touches ? e.touches[0] : e;
                        this.isStarted = true;
                        this.duration = 0;
                        this.stop();
                        this.pointY = point.pageY;
                        this.momentumStartY = this.startY = this.offsetY;
                        this.startTime = new Date().getTime();
                    },
                    onMove: function (e) {
                        if (!this.isStarted) return;
                        const point = e.touches ? e.touches[0] : e;
                        const deltaY = point.pageY - this.pointY;
                        // 浮点数坐标会影响渲染速度
                        let offsetY = Math.round(this.startY + deltaY);
                        // 超出边界时增加阻力
                        if (offsetY < this.minY) {
                            offsetY = Math.round(this.minY + ((offsetY - this.minY) / 4));
                        } else if (offsetY > this.maxY) {
                            offsetY = Math.round(offsetY / 4);
                        }
                        this.offsetY = offsetY;
                        const now = new Date().getTime();
                        // 记录在触发惯性滑动条件下的偏移值和时间
                        if (now - this.startTime > this.momentumTimeThreshold) {
                            this.momentumStartY = this.offsetY;
                            this.startTime = now;
                        }
                    },
                    onEnd: function (e) {
                        if (!this.isStarted) return;
                        this.isStarted = false;
                        if (this.isNeedReset()) return;
                        const absDeltaY = Math.abs(this.offsetY - this.momentumStartY);
                        const duration = new Date().getTime() - this.startTime;
                        // 启动惯性滑动
                        if (duration < this.momentumTimeThreshold && absDeltaY > this.momentumYThreshold) {
                            const momentum = this.momentum(this.scrollerObj.offsetY, this.scrollerObj.momentumStartY, duration);
                            this.scrollerObj.offsetY = Math.round(momentum.destination);
                            this.scrollerObj.duration = momentum.duration;
                            this.scrollerObj.bezier = momentum.bezier;
                        }
                    },
                    onTransitionEnd: function () {
                        this.isNeedReset();
                    },
                    momentum: function (current, start, duration) {
                        const durationMap = {
                            'noBounce': 2500,
                            'weekBounce': 800,
                            'strongBounce': 400,
                        };
                        const bezierMap = {
                            'noBounce': 'cubic-bezier(.17, .89, .45, 1)',
                            'weekBounce': 'cubic-bezier(.25, .46, .45, .94)',
                            'strongBounce': 'cubic-bezier(.25, .46, .45, .94)',
                        };
                        let type = 'noBounce';
                        // 惯性滑动加速度
                        const deceleration = 0.003;
                        // 回弹阻力
                        const bounceRate = 10;
                        // 强弱回弹的分割值
                        const bounceThreshold = 300;
                        // 回弹的最大限度
                        const maxOverflowY = this.wrapperHeight / 6;
                        let overflowY;

                        const distance = current - start;
                        const speed = 2 * Math.abs(distance) / duration;
                        let destination = current + speed / deceleration * (distance < 0 ? -1 : 1);
                        if (destination < this.minY) {
                            overflowY = this.minY - destination;
                            type = overflowY > bounceThreshold ? 'strongBounce' : 'weekBounce';
                            destination = Math.max(this.minY - maxOverflowY, this.minY - overflowY / bounceRate);
                        } else if (destination > this.maxY) {
                            overflowY = destination - this.maxY;
                            type = overflowY > bounceThreshold ? 'strongBounce' : 'weekBounce';
                            destination = Math.min(this.maxY + maxOverflowY, this.maxY + overflowY / bounceRate);
                        }

                        return {
                            destination,
                            duration: durationMap[type],
                            bezier: bezierMap[type],
                        };
                    },
                    // 超出边界时需要重置位置
                    isNeedReset: function () {
                        let offsetY;
                        if (this.offsetY < this.minY) {
                            offsetY = this.minY;
                        } else if (this.offsetY > this.maxY) {
                            offsetY = this.maxY;
                        }
                        if (typeof offsetY !== 'undefined') {
                            this.offsetY = offsetY;
                            this.duration = 500;
                            this.bezier = 'cubic-bezier(.165, .84, .44, 1)';
                            return true;
                        }
                        return false;
                    },
                    stop: function () {
                        // 获取当前 translate 的位置
                        const matrix = window.getComputedStyle(this.scroller).getPropertyValue('transform');
                        this.offsetY = Math.round(+matrix.split(')')[0].split(', ')[5]);
                    },
                    getMinY: function () {
                        this.wrapper = this.$refs.scrollerWrapper;
                        this.scroller = this.$refs.scrollerContent;
                        const {height: wrapperHeight} = this.wrapper.getBoundingClientRect();
                        const {height: scrollHeight} = this.scroller.getBoundingClientRect();
                        this.wrapperHeight = wrapperHeight;
                        this.minY = wrapperHeight - scrollHeight > 0 ? 0 : wrapperHeight - scrollHeight;
                    },
	                resetOffset: function(){
                        this.offsetY = 0;
                    }
                }
            });
			
            let app = new Vue({
                el: '#app',
                data: {
                    text: '关键任务->进行中',
                    defaultValue: ['target', '1'],
                    options: [
                        {
                            value: 'target',
                            label: '关键任务',
                            children: [
                                {
                                    value: '1',
                                    label: '进行中'
                                },
                                {
                                    value: '2',
                                    label: '已完成'
                                }
                            ],
                        },
                        {
                            value: 'item',
                            label: '子任务',
                            children: [
                                {
                                    value: '1',
                                    label: '进行中'
                                },
                                {
                                    value: '2',
                                    label: '已完成'
                                }
                            ],
                        },
                    ],
                    data: [],
                    spinning: false
                },
                methods: {
                    /**
                     * 初始化执行填报模块
                     * @param complete (1-进行中,2-已完成)
                     * @param targetOrItem (target-关键任务,item-子任务)
                     */
                    initData: function (complete, targetOrItem) {
                        let vm = this;
                        
                        if (this.$refs.scroller) {
                            this.$refs.scroller.resetOffset();
                        }
                        
                        vm.spinning = true;
                        $.get('/plcPlan/getData', {
                            complete: complete,
                            allocationStatus: 1,
                            targetOrItem: targetOrItem
                        }, function (res) {
                            vm.spinning = false;
                            if (res.flag) {
                                vm.data = res.obj;
                            }
                        });
                    },
                    onChange: function (value, selectedOptions) {
                        this.text = selectedOptions.map(o => o.label).join('->');
                        this.initData(value[1], value[0]);
                    },
	                listClick: function(t_id, t_type){
                        let url = '/plcPlan/implementationReport?id=' + t_id + '&type=' + t_type;
                        
                        if (( /(iPhone|iPad|iPod|iOS)/i.test(navigator.userAgent) )) {
							try{
								window.webkit.messageHandlers.formInfoUrlLink.postMessage({'url':encodeURI(url) ,'name':'执行填报'});
							}catch(err){
								formInfoUrlLink(encodeURI(url), '执行填报');
							}
                        } else if (/(Android)/i.test(navigator.userAgent)) {
                            // Android.formInfoUrlLink(encodeURI(url), '执行填报');
                            // 上面方式跳转页面无法下载文件
                            window.location.href = url;
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
                    /**
                     * 时间戳转换
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
                },
                created: function () {
                    this.initData('1', 'target');
                }
            });
		</script>
	
	</body>
</html>
