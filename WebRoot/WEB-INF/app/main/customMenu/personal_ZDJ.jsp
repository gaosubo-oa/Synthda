<%--
  Created by IntelliJ IDEA.
  User: 戎成路
  Date: 2020/8/21
  Time: 17:06
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
	<head>
		<title>中电建个人门户</title>
		<meta charset="UTF-8">
		<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
		<meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=0, minimum-scale=1.0, maximum-scale=1.0">
		
		<link rel="stylesheet" type="text/css" href="/lib/layui/layui/css/layui.css?20210319.1"/>
		
		<script type="text/javascript" src="/js/xoajq/xoajq1.js"></script>
		<script type="text/javascript" src="/js/base/base.js"></script>
		<script type="text/javascript" src="/lib/layui/layui/layui.all.js"></script>
		<script type="text/javascript" src="/lib/drag/dragSort.js?20200824"></script>
		<script type="text/javascript" src="/js/HSTmeeting/base64.js"></script>
		<script type="text/javascript" src="/js/HSTmeeting/entermeeting.js?sid=2b2f9c37241432a91dc2f9343f5e4053"></script>
		<script type="text/javascript" src="/js/webOffice/fileShow.js?20210423.1"></script>
		<script type="text/javascript" src="/js/jquery/jquery.cookie.js"></script>
		
		<style>
			html, body {
				width: 100%;
				min-width: 1000px;
				height: 100%;
				color: #666;
				background-color: #fff;
				font-family: "Microsoft Yahei" !important;
			}
			
			/*伪元素是行内元素 正常浏览器清除浮动方法*/
			.clearfix:after {
				content: "";
				display: block;
				height: 0;
				clear: both;
				visibility: hidden;
			}
			
			.clearfix {
				*zoom: 1; /*ie6清除浮动的方式 *号只有IE6-IE7执行，其他浏览器不执行*/
			}
			
			.container {
				width: 100%;
				height: 100%;
				padding: 5px;
				background-color: #f6f7f7;
				overflow-x: hidden;
				overflow-y: auto;
			}
			
			#setOrder {
				position: absolute;
				top: 5px;
				right: 20px;
				cursor: pointer;
			}
			
			.card_label {
				float: left;
				clear: none;
			}
			
			.order_label {
				width: 170px;
			}
			
			/* 卡片样式 START */
			.card_box {
				height: 400px;
				margin: 5px 0;
			}
			
			.card_item {
				position: relative;
				/*width: 100%;*/
				height: 100%;
				margin: 0 5px;
				background-color: #fff;
				box-shadow: 0 2px 6px rgba(0, 0, 0, 0.2);
				border-top: 3px solid #2b7fe0;
			}
			
			.card_head {
				position: relative;
				height: 31px;
				line-height: 20px;
				padding: 5px 10px;
				background-color: #e8f4fc;
				border-bottom: 1px solid #f0f0f0;
				box-sizing: border-box;
				cursor: move;
			}
			
			.card_head_l {
				float: left;
				height: 22px;
				line-height: 22px;
			}
			
			.card_head_select {
				width: 120px;
				height: 20px;
				margin: 1px 5px;
				font-size: 7.5pt;
				cursor: pointer;
			}
			
			.card_head_r {
				float: right;
			}
			
			.r_item {
				position: relative;
				float: left;
				width: 55px;
				padding: 0 5px;
				box-sizing: border-box;
			}
			
			.r_item_img {
				display: none;
				position: absolute;
				top: -5px;
				right: -3px;
				width: 12px;
				height: 12px;
				line-height: 12px;
				padding: 2px;
				background-color: red;
				border-radius: 50%;
				color: #fff;
				text-align: center;
				font-size: 9pt;
			}
			
			.read_all {
				cursor: pointer;
			}
			
			.r_item_t, .r_item_more {
				display: block;
				text-align: center;
				cursor: pointer;
				font-size: 13px;
				word-break: break-all;
				white-space: nowrap;
			}
			
			.more_t {
				display: none;
			}
			
			.r_item_select .r_item_t {
				border-radius: 5px;
				background: #fff;
			}
			
			.card_title {
				font-size: 14px;
				color: #000;
				font-weight: 600;
				cursor: move;
				user-select: none;
			}
			
			.card_content {
				display: none;
				height: 355px;
				margin: 5px 0;
				padding: 0 20px 0 5px;
				overflow: auto;
				box-sizing: border-box;
			}
			
			.outer_link {
				display: block;
				padding: 5px;
				overflow: hidden;
			}
			
			.noData {
				display: none;
				text-align: center;
				border: none;
				padding-top: 80px;
			}
			
			.noData img {
				width: 10%;
			}
			
			/* 卡片样式 END */
			
			/* 列表样式 START */
			.li_item {
				position: relative;
				height: 20px;
				line-height: 20px;
				margin: 5px;
				padding-left: 20px;
				font-size: 9pt;
				cursor: pointer;
			}
			
			.li_item:hover {
				background-color: #e8f4fc;
			}
			
			.circle {
				position: absolute;
				top: 8px;
				left: 8px;
				width: 4px;
				height: 4px;
				border-radius: 50%;
				background: #666666;
			}
			
			.li_title {
				position: absolute;
				top: 0;
				right: 100px;
				bottom: 0;
				left: 20px;
				overflow: hidden;
				word-break: break-all;
				white-space: nowrap;
				text-overflow: ellipsis;
			}
			
			.hide {
				left: 40px;
			}
			
			.li_date {
				float: right;
			}
			
			.scroll_cover {
				position: absolute;
				right: 0;
				bottom: 0;
				width: 25px;
				height: 369px;
				background-color: #fff;
			}
			
			/* 列表样式 END */
			
			.layui-input-block {
				margin-left: 200px;
			}
		
		</style>
	
	</head>
	<body>
		<iframe id="myiframe" name="myiframe" style="display:none;" src=""></iframe>
		<div class="container layui-container">
			<div class="layui-row hide_content" style="display: none;">
				<div class="layui-col-xs6 card_box" ordernum="01" id="newsModule">
					<div class="card_item">
						<div class="card_head">
							<div class="card_head_l">
								<span class="card_title">新闻</span>
								<select class="card_head_select news_type"></select>
							</div>
							<div class="card_head_r">
								<ul class="clearfix">
									<li class="r_item">
										<span class="r_item_img news_doAuditingNum"></span>
										<span class="r_item_more news_doAuditing" style="display: none;" tid="2015" url="/news/doAuditing">审批<h2 class="more_t">新闻审核</h2></span>
									</li>
									<li class="r_item r_item_select" itemType="0">
										<span class="r_item_img read_all" news="true" title="一键阅读"></span>
										<span class="r_item_t news_no_read">未读</span>
									</li>
									<li class="r_item" itemType="1">
										<span class="r_item_t news_readed">已读</span>
									</li>
									<li class="r_item">
										<span class="r_item_more" tid="0117" url="/news/index">更多<h2 class="more_t">新闻</h2></span>
									</li>
								</ul>
							</div>
						</div>
						<div class="card_content">
						
						</div>
						<div class="scroll_cover"></div>
						<div class="noData">
							<img src="/img/main_img/shouyekong.png">
							<h6 style="text-align: center;color: #666;">暂无数据</h6>
						</div>
					</div>
				</div>
				<div class="layui-col-xs6 card_box" ordernum="02" id="noticeModule">
					<div class="card_item">
						<div class="card_head">
							<div class="card_head_l">
								<span class="card_title">通知公告</span>
								<select class="card_head_select notice_type"></select>
							</div>
							<div class="card_head_r">
								<ul class="clearfix">
									<li class="r_item">
										<span class="r_item_img approval_num"></span>
										<span class="r_item_more approval_link" style="display: none;" tid="2008" url="/notice/appprove">审批<h2 class="more_t">公告通知审批</h2></span>
									</li>
									<li class="r_item" itemType="1">
										<span class="r_item_img"></span>
										<span class="r_item_t meeting">会议</span>
									</li>
									<li class="r_item r_item_select" itemType="2">
										<span class="r_item_img read_all" notice="true" title="一键阅读"></span>
										<span class="r_item_t notice_no_read">未读</span>
									</li>
									<li class="r_item" itemType="3">
										<span class="r_item_t notice_readed">已读</span>
									</li>
									<li class="r_item">
										<span class="r_item_more" tid="0116" url="/notice/allNotifications">更多<h2 class="more_t">通知公告</h2></span>
									</li>
								</ul>
							</div>
						</div>
						<div class="card_content"></div>
						<div class="scroll_cover"></div>
						<div class="noData">
							<img src="/img/main_img/shouyekong.png">
							<h6 style="text-align: center;color: #666;">暂无数据</h6>
						</div>
					</div>
				</div>
				<div class="layui-col-xs6 card_box" ordernum="03" id="businessApprovalModule">
					<div class="card_item">
						<div class="card_head">
							<div class="card_head_l">
								<span class="card_title">业务审批</span>
							</div>
							<div class="card_head_r">
								<ul class="clearfix">
									<li class="r_item" itemType="1">
										<span class="r_item_img"></span>
										<span class="r_item_t assignment_work">经/交办</span>
									</li>
									<li class="r_item r_item_select" itemType="2">
										<span class="r_item_img"></span>
										<span class="r_item_t business_approval_no">待办</span>
									</li>
									<li class="r_item" itemType="3">
										<span class="r_item_t business_approval_yes">已办</span>
									</li>
									<li class="r_item">
										<span class="r_item_more business_approval_link" tid="1020" url="/workflow/work/workList">更多<h2 class="more_t">业务审批</h2></span>
									</li>
								</ul>
							</div>
						</div>
						<div class="card_content"></div>
						<div class="scroll_cover"></div>
						<div class="noData">
							<img src="/img/main_img/shouyekong.png">
							<h6 style="text-align: center;color: #666;">暂无数据</h6>
						</div>
					</div>
				</div>
				<div class="layui-col-xs6 card_box" ordernum="04" id="documentManageModule">
					<div class="card_item">
						<div class="card_head">
							<div class="card_head_l">
								<span class="card_title">公文管理</span>
							</div>
							<div class="card_head_r">
								<ul class="clearfix">
									<li class="r_item" itemType="1">
										<span class="r_item_img"></span>
										<span class="r_item_t assignment_document">经/交办</span>
									</li>
									<li class="r_item r_item_select" itemType="2">
										<span class="r_item_img"></span>
										<span class="r_item_t document_no">待办</span>
									</li>
									<li class="r_item" itemType="3">
										<span class="r_item_t document_yes">已办</span>
									</li>
									<li class="r_item">
										<span class="r_item_more document_link" tid="" url="/document/documentDispatchReceive">更多<h2
												class="more_t">公文收发</h2></span>
									</li>
								</ul>
							</div>
						</div>
						<div class="card_content"></div>
						<div class="scroll_cover"></div>
						<div class="noData">
							<img src="/img/main_img/shouyekong.png">
							<h6 style="text-align: center;color: #666;">暂无数据</h6>
						</div>
					</div>
				</div>
				<div class="layui-col-xs6 card_box" ordernum="05" id="planCheckModule">
					<div class="card_item">
						<div class="card_head">
							<div class="card_head_l">
								<span class="card_title">计划审核</span>
								<select class="card_head_select plan_check_type">
									<option value="">全部</option>
									<option value="1">关键任务审批</option>
									<option value="2">子任务审批</option>
									<option value="3">关键任务考核</option>
									<option value="4">任务考核</option>
									<option value="8">分配确认</option>
									<option value="5">考核审核</option>
									<option value="6">制度审核</option>
									<option value="7">360考核</option>
									<option value="9">关键任务审批（二级）</option>
								</select>
							</div>
							<div class="card_head_r">
								<ul class="clearfix">
									<li class="r_item r_item_select" itemType="">
										<span class="r_item_img"></span>
										<span class="r_item_t check_no">未审核</span>
									</li>
									<li class="r_item" itemType="1">
										<span class="r_item_t check_yes">已审核</span>
									</li>
									<li class="r_item">
										<span class="r_item_more check_link" url="">更多<h2 class="more_t"></h2></span>
									</li>
								</ul>
							</div>
						</div>
						<div class="card_content"></div>
						<div class="scroll_cover"></div>
						<div class="noData">
							<img src="/img/main_img/shouyekong.png">
							<h6 style="text-align: center;color: #666;">暂无数据</h6>
						</div>
					</div>
				</div>
				<div class="layui-col-xs6 card_box" ordernum="06" id="executionModule">
					<div class="card_item">
						<div class="card_head">
							<div class="card_head_l">
								<span class="card_title">执行填报</span>
								<select class="card_head_select task_target_type">
									<option value="">全部</option>
									<option value="target">关键任务</option>
									<option value="item">子任务</option>
								</select>
							</div>
							<div class="card_head_r">
								<ul class="clearfix">
									<li class="r_item r_item_select" itemType="1">
										<span class="r_item_img"></span>
										<span class="r_item_t execution_report_on">正进行</span>
									</li>
									<li class="r_item" itemType="2">
										<span class="r_item_t execution_report_yes">已完成</span>
									</li>
									<li class="r_item">
										<span class="r_item_more execution_link" url="">更多<h2 class="more_t"></h2></span>
									</li>
								</ul>
							</div>
						</div>
						<div class="card_content">
						
						</div>
						<div class="scroll_cover"></div>
						<div class="noData">
							<img src="/img/main_img/shouyekong.png">
							<h6 style="text-align: center;color: #666;">暂无数据</h6>
						</div>
					</div>
				</div>
				<div class="layui-col-xs6 card_box" ordernum="07" id="dataReport_one">
					<div class="card_item">
						<div class="card_head">
							<div class="card_head_l">
								<span class="card_title">流程办理时效-总部各中心</span>
							</div>
						</div>
						<div class="card_content outer_link">
							<iframe src="http://10.191.15.57:8075/webroot/decision/view/report?viewlet=flow/%E6%80%BB%E9%83%A8%E6%B5%81%E7%A8%8B%E6%97%B6%E6%95%88%E5%8D%95%E7%8B%AC%E6%9F%B1%E7%8A%B6%E5%9B%BE.cpt&op=write"
							        frameborder="0" style="width: 100%;height: 100%"></iframe>
						</div>
						<div class="scroll_cover"></div>
					</div>
				</div>
				<div class="layui-col-xs6 card_box" ordernum="08" id="dataReport_two">
					<div class="card_item">
						<div class="card_head">
							<div class="card_head_l">
								<span class="card_title">超过7天未办结流程TOP10</span>
							</div>
						</div>
						<div class="card_content outer_link">
							<iframe src="http://10.191.15.57:8075/webroot/decision/view/report?viewlet=flow%252F%25E8%25B6%2585%25E4%25B8%2583%25E5%25A4%25A9%25E6%25B5%2581%25E7%25A8%258B%25E5%258D%2595%25E7%258B%25AC%25E6%258A%25A5%25E8%25A1%25A8.cpt&op=write"
							        frameborder="0" style="width: 100%;height: 100%"></iframe>
						</div>
						<div class="scroll_cover"></div>
					</div>
				</div>
			</div>
			<div class="layui-row content main" id="sortContent" style="display: none;">
				<button id="setOrder" class="layui-btn layui-btn-xs layui-btn-normal" style="display:none;">设置</button>
			</div>
		</div>
		
		<script type="text/javascript">
			
			var menuObj = {
				planCheck1: {titleStr: '关键任务审批', url: '/plcProjectItem/targetApproval'},
                planCheck2: {titleStr: '子任务审批', url: '/plcProjectItem/taskApproval'},
                planCheck3: {titleStr: '关键任务考核', url: '/projectTarget/targetAssessment'},
                planCheck4: {titleStr: '任务考核', url: '/projectTarget/taskAssessment'},
                planCheck8: {titleStr: '分配确认', url: '/projectTarget/assessment'},
                planCheck5: {titleStr: '考核审核', url: '/projectTarget/assessmentCheck'},
                planCheck6: {titleStr: '制度审核', url: '/institution/examine'},
                planCheck7: {titleStr: '360考核', url: '/ScoreGroupController/score'},
				execution6: {titleStr: '关键任务填报', url: '/ProjectDaily/planExecutionReport'},
                execution7: {titleStr: '子任务填报', url: '/ProjectDaily/taskPlanReport'},
				planCheck9: {titleStr: '关键任务审批（二级）', url: '/plcProjectItem/secondTargetApproval'},
			}
			var menuStr = '';
			for (var key in menuObj) {
			    menuStr += menuObj[key]['url'] + ',';
			}
			
			// 获取url对应的menuId
			$.get('/getMenuIdByUrl', {url: menuStr}, function(res){
			    if (res.flag) {
			        res.object.forEach(function(item){
                        for (var key in menuObj) {
                            if (menuObj[key]['url'] == item.url) {
                                menuObj[key]['tId'] = item.id;
                            }
                        }
			        });
			    }
                // 获取可显示模块及模块显示顺序
                $.get('/user/myTableRight', function (res) {
                    var cardOrderArr = ['01', '02', '03', '04', '05', '06'];
                    try {
                        if (res.flag && res.object) {
                            var cardOrderObj = JSON.parse(res.object);
                            cardOrderArr = cardOrderObj.cardOrder;
                            moduleType = parseInt(cardOrderObj.moduleType);
                        }
                    } catch (e) {
                        console.log(e);
                    }
                    resizeSize();
                    loadCardModule(cardOrderArr);
                });
            });
			
			// 个人门户设置方法
			function setOrder() {
			    $('#setOrder').trigger('click');
			}

            //公文收发的tid
            $.get('/documentDispatchReceive', function (res) {
                if (res.data && res.data.id) {
                    $('.document_link').attr('tid', res.data.id);
                }
            });
            
            var moduleType = 3;

            var address = '';
            //PC客户端自动下载地址
            var clientForPCDownloadAddr = "http://www.hst.com/download/FMDesktop.exe";
			
            // 初始化事件
            function initEvent() {

                // 点击设置
                $('#setOrder').on('click', function () {
                    var height = $(window).height();
                    var layerHeight = height <= 420 ? '100%' : '420px';
                    
                    layui.use(['form'], function () {
                        var form = layui.form;
                        layer.open({
                            type: 1,
                            title: '个人门户设置',
                            btn: ['保存', '取消'],
                            btnAlign: 'c',
                            area: ['500px', layerHeight],
                            content: ['<div style="overflow:hidden;"><form class="layui-form layui-row card_form" style="padding: 20px 20px;overflow: hidden;">',
                                '<div class="layui-form-item layui-col-xs6 card_label" id="01">' +
                                '<label class="layui-form-label order_label">新闻</label>' +
                                '<div class="layui-input-block">' +
                                '<input type="checkbox" value="01" name="setOrder" lay-skin="primary">' +
                                '</div>' +
                                '</div>',
                                '<div class="layui-form-item layui-col-xs6 card_label" id="02">' +
                                '<label class="layui-form-label order_label">通知公告</label>' +
                                '<div class="layui-input-block">' +
                                '<input type="checkbox" value="02" name="setOrder" lay-skin="primary">' +
                                '</div>' +
                                '</div>',
                                '<div class="layui-form-item layui-col-xs6 card_label" id="03">' +
                                '<label class="layui-form-label order_label">业务审批</label>' +
                                '<div class="layui-input-block">' +
                                '<input type="checkbox" value="03" name="setOrder" lay-skin="primary">' +
                                '</div>' +
                                '</div>',
                                '<div class="layui-form-item layui-col-xs6 card_label" id="04">' +
                                '<label class="layui-form-label order_label">公文管理</label>' +
                                '<div class="layui-input-block">' +
                                '<input type="checkbox" value="04" name="setOrder" lay-skin="primary">' +
                                '</div>' +
                                '</div>',
                                '<div class="layui-form-item layui-col-xs6 card_label" id="05">' +
                                '<label class="layui-form-label order_label">计划审核</label>' +
                                '<div class="layui-input-block">' +
                                '<input type="checkbox" value="05" name="setOrder" lay-skin="primary">' +
                                '</div>' +
                                '</div>',
                                '<div class="layui-form-item layui-col-xs6 card_label" id="06">' +
                                '<label class="layui-form-label order_label">执行填报</label>' +
                                '<div class="layui-input-block">' +
                                '<input type="checkbox" value="06" name="setOrder" lay-skin="primary">' +
                                '</div>' +
                                '</div>',
                                '<div class="layui-form-item layui-col-xs6 card_label" id="07">' +
                                '<label class="layui-form-label order_label">流程办理失效-总部各中心</label>' +
                                '<div class="layui-input-block">' +
                                '<input type="checkbox" value="07" name="setOrder" lay-skin="primary">' +
                                '</div>' +
                                '</div>',
                                '<div class="layui-form-item layui-col-xs6 card_label" id="08">' +
                                '<label class="layui-form-label order_label">超过7天未办结流程TOP10</label>' +
                                '<div class="layui-input-block">' +
                                '<input type="checkbox" value="08" name="setOrder" lay-skin="primary">' +
                                '</div>' +
                                '</div>',
	                             '<div class="layui-form-item layui-col-xs6" style="clear: none;">' +
                                '<label class="layui-form-label order_label">四模块</label>' +
                                '<div class="layui-input-block">' +
                                '<input type="radio" value="2" name="moduleType" lay-skin="primary">' +
                                '</div>' +
                                '</div>',
                                '<div class="layui-form-item layui-col-xs6" style="clear: none;">' +
                                '<label class="layui-form-label order_label">六模块</label>' +
                                '<div class="layui-input-block">' +
                                '<input type="radio" value="3" name="moduleType" lay-skin="primary">' +
                                '</div>' +
                                '</div>',
                                '</form></div>'].join(''),
                            success: function () {
                                $.get('/user/myTableRight', function (res) {
                                    var cardOrderArr = cardOrderArr = ['01', '02', '03', '04', '05', '06'];
                                    var moduleType = 3;
                                    var data;
                                    try {
                                        if (res.flag && res.object) {
                                            var cardOrderObj = JSON.parse(res.object);
                                            cardOrderArr = cardOrderObj.cardOrder;
                                            data=res.data;
                                            moduleType = parseInt(cardOrderObj.moduleType);
                                        }
                                    } catch (e) {
                                        console.log(e);
                                    }
									
                                    // for (var i = cardOrderArr.length; i > 0; i--) {
                                    //     var $cardEle = $('#' + cardOrderArr[i - 1]);
                                    //     var $cloneEle = $cardEle.clone();
                                    //     $cardEle.remove();
                                    //     $cloneEle.find('input[name="setOrder"]').prop('checked', true);
                                    //     $('.card_form').prepend($cloneEle);
                                    // }
									cardOrderArr.forEach(function (item) {
										//	$('input[value="'+item+'"]').prop('disabled','disabled')
										$('input[value="'+item+'"]').prop('checked','true')
										form.render()
									})
									data.forEach(function (item) {
										$('input[value="'+item+'"]').prop('disabled','disabled')
										//$('input[value="'+item+'"]').prop('checked','true')
										form.render()
									})
                                    if (moduleType == 3) {
                                        $('input[name="moduleType"]').eq(1).prop('checked', true);
                                    } else {
                                        $('input[name="moduleType"]').eq(0).prop('checked', true);
                                    }

                                    form.render();
                                    // 拖拽
                                    $('.card_label').arrangeable();
                                });
                            },
                            yes: function (index) {
                                var cardOrderArr = []
                                $('input[name="setOrder"]:checked').each(function () {
                                    var key = $(this).val();
                                    cardOrderArr.push(key);
                                });
                                
                                var moduleType = $('input[name="moduleType"]:checked').val();
                                
                                var cardOrderObj = {"cardOrder": cardOrderArr, "moduleType": moduleType}
								
                                $.post('/user/myTableRight', {mytableRight: JSON.stringify(cardOrderObj)}, function (res) {
                                    if (res.flag) {
                                        window.location.reload();
                                    } else {
                                        layer.msg('保存失败！', {icon: 2, time: 2000});
                                    }
                                });
                            }
                        });
                    });
                });

                // 卡片头部右侧点击
                $('.r_item_t').on('click', function () {
                    var $p = $(this).parent();
                    $p.siblings().removeClass('r_item_select');
                    $p.addClass('r_item_select');
                });

                // 拖拽
                $('.card_box').arrangeable({
                    dragSelector: '.card_head',
                    afterDragEnd: function (e) { // 拖拽结束调用
                        var cardOrderArr = []
                        $('.content .card_box').each(function () {
                            var key = $(this).attr('ordernum');
                            cardOrderArr.push(key);
                        });

                        var cardOrderObj = {"cardOrder": cardOrderArr, "moduleType": moduleType}
                        $.post('/user/myTableRight', {mytableRight: JSON.stringify(cardOrderObj)}, function (res) {

                        });
                    }
                });

                /***************************** 新闻模块 START ******************************/

                // 新闻-审批
                $.get('/news/approveNew', function (res) {
                    if (res.flag && res.object == '0') {
                        if (res.totleNum > 0) {
                            $('.news_doAuditingNum').text(res.totleNum).show();
                        } else {
                            $('.news_doAuditingNum').hide();
                        }
                        $('.news_doAuditing').show();
                    } else {
                        $('.news_doAuditing').hide();
                    }
                });

                // 新闻-切换类型
                $('.news_type').on('change', function () {
                    var typeId = $(this).val();
                    var read = $('#newsModule').find('.r_item_select').attr('itemtype');
                    initNewsModule(read, typeId);
                });

                // 新闻-未读
                $('.news_no_read').on('click', function () {
                    var typeId = $('#newsModule .news_type').val();
                    initNewsModule(0, typeId);
                });

                // 新闻-已读
                $('.news_readed').on('click', function () {
                    var typeId = $('#newsModule .news_type').val();
                    initNewsModule(1, typeId);
                });

                /***************************** 新闻模块 END ******************************/

                /***************************** 公告模块 START ******************************/

                // 公告通知-审批
                $.get('/notice/approveNotify', function (res) {
                    if (res.flag && res.object == '0') {
                        if (res.totleNum > 0) {
                            $('.approval_num').text(res.totleNum).show();
                        } else {
                            $('.approval_num').hide();
                        }
                        $('.approval_link').show();
                    } else {
                        $('.approval_link').hide();
                    }
                });

                // 公告通知-类型切换
                $('.notice_type').on('change', function () {
                    var typeId = $(this).val();
                    var noticeType = $('#noticeModule').find('.r_item_select').attr('itemtype');
                    initNoticeModule(noticeType, typeId);
                });

                // 公告通知-会议
                $('.meeting').on('click', function () {
                    $('.notice_type').hide();
                    initNoticeModule(1);
                });

                // 公告通知-未读
                $('.notice_no_read').on('click', function () {
                    $('.notice_type').show();
                    var typeId = $('#noticeModule .notice_type').val();
                    initNoticeModule(2, typeId);
                });

                // 公告通知-已读
                $('.notice_readed').on('click', function () {
                    $('.notice_type').show();
                    var typeId = $('#noticeModule .notice_type').val();
                    initNoticeModule(3, typeId);
                });

                /***************************** 公告模块 END ******************************/

                /***************************** 业务审批模块 START ******************************/

                // 业务审批-经/交办
                $('.assignment_work').on('click', function () {
                    $('.business_approval_link').attr('data-url', '/workflow/work/workList');
                    initBusinessApprovalModule(1);
                });

                // 业务审批-待办
                $('.business_approval_no').on('click', function () {
                    $('.business_approval_link').attr('data-url', '/workflow/work/workList');
                    initBusinessApprovalModule(2);
                });

                // 业务审批-已办
                $('.business_approval_yes').on('click', function () {
                    $('.business_approval_link').attr('data-url', '/workflow/work/endwork');
                    initBusinessApprovalModule(3);
                });

                /***************************** 业务审批模块 END ******************************/

                /***************************** 业务审批模块 START ******************************/

                // 公文-经/交办
                $('.assignment_document').on('click', function () {
                    initDocumentManageModule(1);
                });

                // 公文-待办
                $('.document_no').on('click', function () {
                    initDocumentManageModule(2);
                });

                // 公文-已办
                $('.document_yes').on('click', function () {
                    initDocumentManageModule(3);
                });

                /***************************** 业务审批模块 END ******************************/

                /***************************** 计划审核 START ******************************/

                // 计划审核-类型切换
                $('.plan_check_type').on('change', function () {
                    var typeId = $(this).val();
                    var checkType = $('#planCheckModule').find('.r_item_select').attr('itemtype') || '';
                    if (!!typeId) {
                        $('#planCheckModule').find('.check_link').attr('tid', menuObj['planCheck'+typeId]['tId']).attr('url', menuObj['planCheck'+typeId]['url']);
                        $('#planCheckModule').find('.check_link .more_t').text(menuObj['planCheck'+typeId]['titleStr']);
                    } else {
                        $('#planCheckModule').find('.check_link').attr('tid', '').attr('url', '');
                        $('#planCheckModule').find('.check_link .more_t').text('');
                    }

                    initPlanCheckModule(typeId, checkType);
                });

                // 计划审核-未审核
                $('.check_no').on('click', function () {
                    var typeId = $('#planCheckModule .plan_check_type').val();
                    initPlanCheckModule(typeId, '');
                });

                // 计划审核-已审核
                $('.check_yes').on('click', function () {
                    var typeId = $('#planCheckModule .plan_check_type').val();
                    initPlanCheckModule(typeId, 1);
                });

                /***************************** 计划审核 END ******************************/

                /***************************** 执行填报 START ******************************/

                // 执行填报-类型切换
                $('.task_target_type').on('change', function () {
                    var targetOrItem = $(this).val();
                    var complete = $('#executionModule').find('.r_item_select').attr('itemtype') || '';
                    if (!!targetOrItem) {
                        var type = targetOrItem == 'target' ? 6 : 7;
                        $('#executionModule').find('.execution_link').attr('tid', menuObj['execution'+type]['tId']).attr('url', menuObj['execution'+type]['url']);
                        $('#executionModule').find('.execution_link .more_t').text(menuObj['execution'+type]['titleStr']);
                    } else {
                        $('#executionModule').find('.execution_link').attr('tid', '').attr('url', '');
                        $('#executionModule').find('.execution_link .more_t').text('');
                    }

                    initExecutionModule(complete, targetOrItem);
                });

                // 执行填报-在进行
                $('.execution_report_on').on('click', function () {
                    var targetOrItem = $('#executionModule .task_target_type').val();
                    initExecutionModule(1, targetOrItem);
                });

                // 执行填报-已完成
                $('.execution_report_yes').on('click', function () {
                    var targetOrItem = $('#executionModule .task_target_type').val();
                    initExecutionModule(2, targetOrItem);
                });

                /***************************** 执行填报 END ******************************/

                // 一键阅读
                $('.read_all').on('click', function () {
                    var str = '';

                    if ($(this).attr('news')) {
                        // 新闻
                        var type = $('#newsModule').find('.r_item_select').attr('itemtype');
                        if (type == 0) {
                            var $liEles = $('#newsModule').find('.card_content li');
                            if ($liEles.length > 0) {
                                $liEles.each(function () {
                                    str += $(this).attr('newsid') + ',';
                                });

                                $.get('/news/readNews', {newsIds: str}, function (res) {
                                    if (res.flag) {
                                        var typeId = $('#newsModule .news_type').val();
                                        initNewsModule(0, typeId);
                                    }
                                });
                            }
                        } else {
                            $('.news_no_read').trigger('click');
                        }
                    } else if ($(this).attr('notice')) {
                        // 公告
						var type = $('#noticeModule').find('.r_item_select').attr('itemtype');
						if (type == 2) {
							var $liEles = $('#noticeModule').find('.card_content li');
							if ($liEles.length > 0) {
								$liEles.each(function () {
									if($(this).attr('notifyid')){
										str += $(this).attr('notifyid') + ',';
									}
								});
								if(str){
									$.get('/notice/readNotify', {notifyIds: str}, function (res) {
										if (res.flag) {
											var typeId = $('#noticeModule .notice_type').val();
											initNoticeModule(0, typeId);
										}
									});
								}
							}
						} else {
							$('.notice_no_read').trigger('click');
						}
                        /*if ($('.notice .noticeRead').length > 0) {
                            $('.notice .noticeRead').each(function () {
                                str += $(this).attr('notifyId') + ','
                            });
                            $.get('/notice/readNotify', {notifyIds: str}, function (res) {
                                if (res.flag) {
                                    announcement(this)
                                }
                            });
                        }*/
                    }
                });

                // 更多跳转
                $('.r_item_more').on('click', function () {
                    if ($(this).attr('url')) {
                        parent.getMenuOpen(this);
                    }
                });
            }

            // 加载头部下拉框数据
            function initSelect() {
                // 新闻下拉框
                $.get('/code/GetDropDownBox', {CodeNos: 'NEWS'}, function (res) {

                    var str = '<option value="">全部</option>';
                    var data = res['NEWS'];
                    if (data && data.length > 0) {
                        for (var i = 0; i < data.length; i++) {
                            str += '<option value="' + data[i].codeNo + '">' + data[i].codeName + '</option>'
                        }
                    }

                    $('#newsModule .news_type').html(str);
                });

                // 公告下拉框
                $.get('/sys/getNotifyTypeList', {CodeNos: 'NOTIFY'}, function (res) {

                    var str = '<option value="">全部</option>';
                    if (res.flag && res.obj.length > 0) {
                        var arr = res.obj;
                        for (var i = 0; i < arr.length; i++) {
                            str += '<option value="' + arr[i].codeNo + '">' + arr[i].codeName + '</option>'
                        }
                    }

                    $('#noticeModule .notice_type').html(str);
                });
            }

            /**
             * 加载模块方法
             */
            function loadCardModule(cardOrderArr) {
                var $cardEle = $('.hide_content .card_box');
                if (cardOrderArr && cardOrderArr.length > 0) {
                    cardOrderArr.forEach(function (item) {
                        var $cardEle = $('.card_box[ordernum="' + item + '"]');
                        var $ele = $cardEle.clone();
                        $('.content').append($ele);
                    });
                } else {
                    $cardEle.each(function () {
                        var key = $(this).attr('ordernum');
                        if (!(key == '07' || key == '08')) {
                            var $ele = $(this).clone();
                            $('.content').append($ele);
                        }
                    });
                }
                $('.content').show(0, function () {
                    $('.hide_content').remove();
                    initEvent();
                    initSelect();
                    cardOrderArr.forEach(function (item) {
                        if (item == '01') {
                            initNewsModule(0, '');
                        }
                        if (item == '02') {
                            initNoticeModule(0);
                        }
                        if (item == '03') {
                            initBusinessApprovalModule(0);
                        }
                        if (item == '04') {
                            initDocumentManageModule(0);
                        }
                        if (item == '05') {
                            initPlanCheckModule('', '');
                        }
                        if (item == '06') {
                            initExecutionModule(1, '');
                        }
                    });
                });
            }

            /**
             * 初始化新闻模块
             * @param read (0-未读,1-已读)
             * @param typeId (新闻发布类型)
             */
            function initNewsModule(read, typeId) {
                var loadingIndex = initLoading('newsModule');
                $.get('/news/newsManagePlus', {
                    page: '1',
                    read: read,
                    pageSize: 15,
                    useFlag: 'true',
                    typeId: typeId
                }, function (res) {
                    closeLoading(loadingIndex);
                    if (read == 0) {
                        if (res.totleNum > 0) {
                            $('.news_no_read').siblings('.r_item_img').text('✔').show();
                        } else {
                            $('.news_no_read').siblings('.r_item_img').hide();
                        }
                    }

                    if (res.totleNum > 0) {
                        var str = '';
                        res.obj.forEach(function (item) {
                            str += '<li class="li_item" read="' + read + '" onclick="jumpPage(this)" newsId="' + item.newsId + '" title="' + item.subject + '" data-url="/news/detail?newsId=' + item.newsId + '">' +
                                '<span class="circle"></span><span class="li_title">' + function () {
                                    if (!!item.typeName) {
                                        return '[' + item.typeName + ']' + item.subject;
                                    } else {
                                        return item.subject;
                                    }
                                }() + '</span>' +
                                '<span class="li_date">' + function () {
                                    if (item.newsDateTime != undefined) {
                                        return item.newsDateTime.split(/\s/g)[0];
                                    } else {
                                        return '';
                                    }
                                }() + '</span></li>';
                        });

                        $('#newsModule').find('.card_content').html('<ul>' + str + '</ul>').show();
                    } else {
                        $('#newsModule').find('.noData').show();
                    }
                });
            }

            /**
             * 初始化公告模块
             * @param noticeType (0-页面默认加载,1-会议,2-未读,3-已读)
             * @param typeId (公告类型)
             */
            function initNoticeModule(noticeType, typeId) {
                var loadingIndex = initLoading('noticeModule');
                if (noticeType == 0) {
                    // 页面默认加载
                    $.get('/notice/findNotifyandMeeting', function (res) {
                        closeLoading(loadingIndex);
                        var meetingNum = 0;
                        var noticeArr = [];
                        if (res.flag) {
                            res.obj.forEach(function (item) {
                                var str = '';
                                if (item.url != undefined) {
                                    str += '<li class="li_item" read="' + (item.modelType == 1 ? '0' : '1') + '" onclick="jumpPage(this)" title="' + item.subject + '" notifyId="' + function () {
                                            if(item.subject.substring(0,4)=="[公告]" || item.subject.substring(0,6)=="[内部分发]"){
												return item.url.split('=')[1];
											}else{
                                            	return ''
											}
                                        }() + '" data-url="' + item.url + '">' +
                                        '<span class="circle"></span><span class="li_title">' + item.subject + '</span><span class="li_date">' + format(item.sendTime) + '</span></li>';
                                } else {
                                    str += '<li class="li_item" onclick="joinMeeting(this)" title="' + item.subject + '" meetingId="' + item.mps.meetingId + '" roomNo="' + item.mps.roomNo + '" roomPwd="' + item.mps.roomPwd + '" userNameString="' + item.mps.userNameString + '" roomAddr="' + item.mps.roomAddr + '">' +
                                        '<span class="circle"></span><span class="li_title">' + item.subject + '</span><span class="li_date">' + format(item.sendTime) + '</span></li>';
                                }

                                noticeArr.push(str);

                                // 会议
                                if (item.modelType != 1) {
                                    meetingNum++;
                                }

                            });
                        }
                        // 判断会议数量
                        if (meetingNum > 0) {
                            var num = meetingNum > 99 ? '✔' : meetingNum;
                            $('.meeting').siblings('.r_item_img').text(num).show();
                        } else {
                            $('.meeting').siblings('.r_item_img').hide();
                        }

                        // 判断公告未读
                        if (noticeArr.length > 0) {
                            $('.notice_no_read').siblings('.r_item_img').text('✔').show();

                            $('#noticeModule').find('.card_content').html('<ul>' + noticeArr.join("") + '</ul>').show();
                        } else {
                            $('.notice_no_read').siblings('.r_item_img').hide();
                            $('#noticeModule').find('.noData').show();
                        }
                    });
                } else if (noticeType == 1) {
                    // 会议
                    $.get('/notice/findNotifyandMeeting', function (res) {
                        closeLoading(loadingIndex);
                        var meetingArr = [];
                        if (res.flag) {
                            res.obj.forEach(function (item) {
                                var str = '';
                                if (item.modelType != 1) {
                                    if (item.url != undefined) {
                                        str += '<li class="li_item" onclick="jumpPage(this)" title="' + item.subject + '" data-url="' + item.url + '">' +
                                            '<span class="circle"></span><span class="li_title">' + item.subject + '</span><span class="li_date">' + format(item.sendTime) + '</span></li>'
                                    } else {
                                        str += '<li class="li_item" onclick="joinMeeting(this)" title="' + item.subject + '" meetingId="' + item.mps.meetingId + '" roomNo="' + item.mps.roomNo + '" roomPwd="' + item.mps.roomPwd + '" userNameString="' + item.mps.userNameString + '" roomAddr="' + item.mps.roomAddr + '">' +
                                            '<span class="circle"></span><span class="li_title">' + item.subject + '</span><span class="li_date">' + format(item.sendTime) + '</span></li>'
                                    }
                                }

                                if (!!str) {
                                    meetingArr.push(str);
                                }

                            });
                        }

                        if (meetingArr.length > 0) {
                            var num = meetingArr.length > 99 ? '✔' : meetingArr.length;
                            $('.meeting').siblings('.r_item_img').text(num).show();

                            $('#noticeModule').find('.card_content').html('<ul>' + meetingArr.join("") + '</ul>').show();
                        } else {
                            $('.meeting').siblings('.r_item_img').hide();
                            $('#noticeModule').find('.noData').show();
                        }
                    });
                } else if (noticeType == 2) {
                    // 未读公告
                    if (!typeId) {
                        // 全部
                        $.get('/notice/findNotifyandMeeting', function (res) {
                            closeLoading(loadingIndex);
                            var noticeArr = [];
                            if (res.flag) {
                                res.obj.forEach(function (item) {
                                    var str = '';
                                    if (item.url != undefined) {
                                        str += '<li class="li_item" read="' + (item.modelType == 1 ? '0' : '1') + '" onclick="jumpPage(this)" title="' + item.subject + '" notifyId="' + function () {
												if(item.subject.substring(0,4)=="[公告]" || item.subject.substring(0,6)=="[内部分发]"){
													return item.url.split('=')[1];
												}else{
													return ''
												}
                                            }() + '" data-url="' + item.url + '">' +
                                            '<span class="circle"></span><span class="li_title">' + item.subject + '</span><span class="li_date">' + format(item.sendTime) + '</span></li>';
                                    } else {
                                        str += '<li class="li_item" onclick="joinMeeting(this)" title="' + item.subject + '" meetingId="' + item.mps.meetingId + '" roomNo="' + item.mps.roomNo + '" roomPwd="' + item.mps.roomPwd + '" userNameString="' + item.mps.userNameString + '" roomAddr="' + item.mps.roomAddr + '">' +
                                            '<span class="circle"></span><span class="li_title">' + item.subject + '</span><span class="li_date">' + format(item.sendTime) + '</span></li>';
                                    }
                                    noticeArr.push(str);
                                });
                            }

                            if (noticeArr.length > 0) {
                                $('.notice_no_read').siblings('.r_item_img').text('✔').show();

                                $('#noticeModule').find('.card_content').html('<ul>' + noticeArr.join("") + '</ul>').show();
                            } else {
                                $('.notice_no_read').siblings('.r_item_img').hide();
                                $('#noticeModule').find('.noData').show();
                            }
                        });
                    } else {
                        $.get('/notice/notifyManagePlus', {
                            read: 0,
                            page: 1,
                            pageSize: 15,
                            useFlag: 'true',
                            typeId: typeId
                        }, function (res) {
                            closeLoading(loadingIndex);
                            var data = res.obj;
                            var notifyStr = '';
                            if (data.length > 0) {
                                for (var i = 0; i < data.length; i++) {
                                    notifyStr += '<li class="li_item" read="0" onclick="jumpPage(this)" title="' + data[i].subject + '" data-url="/notice/detail?notifyId=' + data[i].notifyId + '">' +
                                        '<span class="li_title">' + data[i].subject + '</span><span class="li_date">' + function () {
                                            if (data[i].notifyDateTime != undefined) {
                                                return data[i].notifyDateTime.split(/\s/g)[0];
                                            } else {
                                                return '';
                                            }
                                        }() + '</span></li>';
                                }

                                $('.notice_no_read').siblings('.r_item_img').text('✔').show();

                                $('#noticeModule').find('.card_content').html('<ul>' + notifyStr + '</ul>').show();
                            } else {
                                $('.notice_no_read').siblings('.r_item_img').hide();
                                $('#noticeModule').find('.noData').show();
                            }
                        });
                    }
                } else if (noticeType == 3) {
                    // 已读公告
                    $.get('/notice/notifyManagePlus', {
                        read: 1,
                        page: 1,
                        pageSize: 15,
                        useFlag: 'true',
                        typeId: typeId
                    }, function (res) {
                        closeLoading(loadingIndex);
                        var data = res.obj;
                        var notifyStr = '';
                        if (data.length > 0) {
                            for (var i = 0; i < data.length; i++) {
                                notifyStr += '<li class="li_item" read="1" onclick="jumpPage(this)" title="' + data[i].subject + '" data-url="/notice/detail?notifyId=' + data[i].notifyId + '">' +
                                    '<span class="li_title">' + data[i].subject + '</span><span class="li_date">' + function () {
                                        if (data[i].notifyDateTime != undefined) {
                                            return data[i].notifyDateTime.split(/\s/g)[0];
                                        } else {
                                            return '';
                                        }
                                    }() + '</span></li>';
                            }

                            $('#noticeModule').find('.card_content').html('<ul>' + notifyStr + '</ul>').show();
                        } else {
                            $('#noticeModule').find('.noData').show();
                        }
                    });
                }
            }

            /**
             * 初始化业务审批模块
             * @param workType (0-默认加载,1-经/交办,2-待办,3-已办)
             */
            function initBusinessApprovalModule(workType) {
                var loadingIndex = initLoading('businessApprovalModule');
                if (workType != 3) {
                    // 0-默认加载,1-经/交办,2-待办
                    $.ajax({
                        url: '/workflow/work/getAssignData',
                        type: 'get',
                        data: {
                            page: 1,
                            pageSize: 7,
                            useFlag: false
                        },
                        dataType: 'json',
                        success: function (res) {
                            closeLoading(loadingIndex);

                            var commonData = null;
                            var assignData = null;

                            if (res.object) {
                                var dataStr = '';
                                // 待办
                                if (res.object.commonData) {
                                    commonData = res.object.commonData;
                                }
                                // 经/交办
                                if (res.object.assignData) {
                                    assignData = res.object.assignData;
                                }

                                if (workType == 1) {
                                    // 经/交办
                                    if (assignData && assignData.length > 0) {
                                        assignData.forEach(function (item) {
                                            var workLevel='';
                                            if (item.flowRun.workLevel =='1') {
                                                workLevel = '<span style="color: red">【紧急】</span>';
                                            } else if (item.flowRun.workLevel =='2') {
                                                workLevel = '<span style="color: red">【特急】</span>';
                                            }
                                            dataStr += '<li class="li_item" can="' + item.comment + '" runId="' + item.runId + '" flowPrcs="' + item.prcsId + '" prcsId="' + item.flowPrcs + '" removeRed="true"  title="' + function () {
                                                    if (item.handles) {
                                                        var asend = '';
                                                        var ason = '';
                                                        var faon = '';
                                                        var faend = '';
                                                        if (item.handles.asend) {
                                                            asend = item.handles.asend + '\n';
                                                        }
                                                        if (item.handles.ason) {
                                                            ason = item.handles.ason + '\n';
                                                        }
                                                        if (item.handles.faon) {
                                                            faon = item.handles.faon + '\n';
                                                        }
                                                        if (item.handles.faend) {
                                                            faend = item.handles.faend + '\n';
                                                        }
                                                        return asend + ason + faon + faend;
                                                    } else {
                                                        return workLevel+item.flowRun.runName;
                                                    }
                                                }() + '" style="' + function () {
                                                    if ((item.comment && workType == 1) || (item.timeOutFlag && item.timeOutFlag == '1' && workType != 1)) {
                                                        return 'color: red;';
                                                    }
                                                }() + '" onclick="windowOpenNew(this)" data-s="2"  data-url="/workflow/work/workform?opFlag=' + item.opFlag + '&flowId=' + item.flowRun.flowId + '&flowStep=' + item.prcsId + '&runId=' + item.runId + '&prcsId=' + item.flowPrcs + '">' +
                                                '<span class="circle"></span>' +
                                                '<span class="li_title" style="width: 57%">' + workLevel+item.flowRun.runName +
                                                '</span><span style="position: absolute; right: 15%; top: -1px;">' + item.flowRun.userName + '</span>' +
                                                '<span class="li_date">' + function () {
                                                    if (item.createTime != undefined) {
                                                        return item.createTime.split(/\s/)[0];
                                                    } else {
                                                        return '';
                                                    }
                                                }() + '</span></li>';
                                        });
                                        var num = assignData.length > 99 ? '✔' : assignData.length;
                                        $('.assignment_work').siblings('.r_item_img').text(num).show();
                                    } else {
                                        $('.assignment_work').siblings('.r_item_img').hide();
                                    }
                                } else {
                                    // 待办
                                    if (commonData && commonData.length > 0) {
                                        commonData.forEach(function (item) {
                                            var workLevel='';
                                            if (item.flowRun.workLevel =='1') {
                                                workLevel = '<span style="color: red">【紧急】</span>';
                                            } else if (item.flowRun.workLevel =='2') {
                                                workLevel = '<span style="color: red">【特急】</span>';
                                            }
                                            dataStr += '<li class="li_item" style="' + function () {
                                                    if (item.timeOutFlag && item.timeOutFlag == '1') {
                                                        return 'color: red;';
                                                    } else {
                                                        return '';
                                                    }
                                                }() + '" title="' + item.flowRun.runName + '" onclick="windowOpenNew(this)" data-s="2"  data-url="/workflow/work/workform?opFlag=' + item.opFlag + '&flowId=' + item.flowRun.flowId + '&flowStep=' + item.prcsId + '&runId=' + item.runId + '&prcsId=' + item.flowPrcs + '">'
                                                + '<span class="circle"></span>' +
                                                '<span class="li_title" style="width: 57%;">' + workLevel+item.flowRun.runName + '</span>' +
                                                '<span style="position: absolute; right: 15%; top: -1px;">' + item.flowRun.userName + '</span>' +
                                                '<span class="li_date">' + function () {
                                                    if (item.createTime != undefined) {
                                                        return item.createTime.split(/\s/)[0];
                                                    } else {
                                                        return '';
                                                    }
                                                }() + '</span></li>';
                                        });
                                        var num = commonData.length > 99 ? '✔' : commonData.length;
                                        $('.business_approval_no').siblings('.r_item_img').text(num).show();
                                    } else {
                                        $('.business_approval_no').siblings('.r_item_img').hide();
                                    }

                                    if (workType == 0) {
                                        // 经/交办
                                        if (assignData && assignData.length > 0) {
                                            var num = assignData.length > 99 ? '✔' : assignData.length;
                                            $('.assignment_work').siblings('.r_item_img').text(num).show();
                                        } else {
                                            $('.assignment_work').siblings('.r_item_img').hide();
                                        }
                                    }
                                }

                                if (!!dataStr) {
                                    $('#businessApprovalModule').find('.card_content').html('<ul>' + dataStr + '</ul>').show();
                                } else {
                                    $('#businessApprovalModule').find('.noData').show();
                                }

                            } else {
                                $('#businessApprovalModule').find('.r_item_img').hide();
                                $('#businessApprovalModule').find('.noData').show();
                            }
                        }
                    });
                } else {
                    // 已办
                    $.ajax({
                        url: '/workflow/work/selectEndWord',
                        type: 'get',
                        dataType: 'json',
                        data: {
                            page: 1,
                            pageSize: 15,
                            useFlag: true,
                            userId: $.cookie('userId')
                        },
                        success: function (res) {
                            closeLoading(loadingIndex);
                            var data = res.obj;
                            var dataStr = '';
                            if (data.length > 0) {
                                for (var i = 0; i < data.length; i++) {
                                    var tipStr = '';
                                    if (data[i].havaSon != undefined) {
                                        if (data[i].havaSon == 0 && data[i].isHidden == 0) {
                                            tipStr = '<img src="/img/mywork/addlogo.png" style="margin-bottom: 4px; cursor: pointer" title="点击展开" runId="' + data[i].runId + '" onclick="openthis($(this))">';
                                        }
                                    }
                                    dataStr += '<li class="li_item" title="' + data[i].flowRun.runName + '" onclick="windowOpenNew(this)" data-s="2"  data-url="/workflow/work/workformPreView?flowId=' + data[i].flowRun.flowId + '&flowStep=' + data[i].prcsId + '&runId=' + data[i].runId + '&prcsId=' + data[i].flowPrcs + '">' +
                                        '<span class="circle"></span><input type="hidden" class="hidden" isHidden="' + data[i].isHidden + '" name="' + data[i].runId + '"/>' + tipStr +
                                        '<span style="width: 57%" class="li_title hide" isHidden="' + data[i].isHidden + '">' + data[i].flowRun.runName + '</span>' +
                                        '<span style=" position: absolute; right: 15%; top: -1px;">' + data[i].flowRun.userName + '</span>' +
                                        '<span class="li_date">' + function () {
                                            if (data[i].deliverTime != undefined) {
                                                return data[i].deliverTime.split(/\s/)[0];
                                            } else {
                                                return '';
                                            }
                                        }() + '</span></li>'
                                }

                                $('#businessApprovalModule').find('.card_content').html('<ul>' + dataStr + '</ul>').show();
                            } else {
                                $('#businessApprovalModule').find('.noData').show();
                            }
                            //判断默认展开哪些流程
                            var length = $('#businessApprovalModule .hide').length;
                            for (var i = 0; i < length; i++) {
                                var ishidden = $('#businessApprovalModule .hide').eq(i).attr('ishidden');
                                if (ishidden == 1) {
                                    $('#businessApprovalModule .hide').eq(i).parent().hide();
                                }
                            }
                        }
                    });
                }
            }

            /**
             * 初始化公文模块
             * @param workType (0-默认加载,1-经/交办,2-待办,3-已办)
             */
            function initDocumentManageModule(workType) {
                var loadingIndex = initLoading('documentManageModule');
                if (workType != 3) {
                    // 0-默认加载,1-经/交办,2-待办
                    $.ajax({
                        url: '/document/getAssignDocData',
                        type: 'get',
                        data: {
                            page: 1,
                            pageSize: 66,
                            useFlag: false,
                            printDate: '',
                            dispatchType: '',
                            title: '',
                            docStatus: '',
                            flowId: '',
                            documentType: ''
                        },
                        dataType: 'json',
                        success: function (res) {
                            closeLoading(loadingIndex);

                            var commonData = null;
                            var assignData = null;

                            if (res.object) {
                                var dataStr = '';
                                // 待办
                                if (res.object.commonData) {
                                    commonData = res.object.commonData;
                                }
                                // 经/交办
                                if (res.object.assignData) {
                                    assignData = res.object.assignData;
                                }

                                if (workType == 1) {
                                    // 经/交办
                                    if (assignData && assignData.length > 0) {
                                        assignData.forEach(function (item) {
                                            var workLevel = '';
                                            if (item.workLevel =='1') {
                                                workLevel = '<span style="color: red">【紧急】</span>';
                                            } else if (item.workLevel =='2') {
                                                workLevel = '<span style="color: red">【特急】</span>';
                                            }
                                            var url = '/workflow/work/workform?&flowId=' + item.flowId + '&prcsId=' + item.realPrcsId + '&flowStep=' + item.step
                                                + '&runId=' + item.runId + '&tabId=' + item.id + '&tableName=' + item.tableName + '&isNomalType=false&hidden=true&opFlag=' + item.opFlag;
                                            dataStr += '<li class="li_item" onclick="jumpPage(this)" data-s="2" can="' + item.comment + '" runId="' + item.runId + '" flowPrcs="' + item.step + '" prcsId="' + item.realPrcsId + '" removeRed="true" title="' + function () {
                                                if (item.handles) {
                                                    var asend = ''
                                                    var ason = ''
                                                    var faon = ''
                                                    var faend = ''
                                                    if (item.handles.asend) {
                                                        asend = item.handles.asend + '\n';
                                                    }
                                                    if (item.handles.ason) {
                                                        ason = item.handles.ason + '\n';
                                                    }
                                                    if (item.handles.faon) {
                                                        faon = item.handles.faon + '\n';
                                                    }
                                                    if (item.handles.faend) {
                                                        faend = item.handles.faend + '\n';
                                                    }
                                                    return asend + ason + faon + faend;
                                                } else {
                                                    if (item.documentType == '0') {
                                                        return '[发文]' + workLevel + item.title;
                                                    } else {
                                                        return '[收文]' + workLevel + item.title;
                                                    }
                                                }
                                            }() + '" style="' + function () {
                                                if ((item.comment && workType == 1) || (item.timeOutFlag && item.timeOutFlag == '1' && workType != 1)) {
                                                    return 'color: red;';
                                                }
                                            }() + '" daiBan="ture" data-url="' + url + '"><span class="circle"></span><span class="li_title">' + function () {
                                                if (item.documentType == '0') {
                                                    return '[发文]' + workLevel+ item.title;
                                                } else {
                                                    return '[收文]' + workLevel+ item.title;
                                                }
                                            }() + '</span><span class="li_date">' + function () {
                                                if (item.createTime.indexOf('.') > -1) {
                                                    if (item.createTime.indexOf(' ') > -1) {
                                                        return item.createTime.split(' ')[0];
                                                    } else {
                                                        return item.createTime;
                                                    }
                                                } else {
                                                    return '';
                                                }
                                            }() + '</span></li>';
                                        });
                                        var num = assignData.length > 99 ? '✔' : assignData.length;
                                        $('.assignment_document').siblings('.r_item_img').text(num).show();
                                    } else {
                                        $('.assignment_document').siblings('.r_item_img').hide();
                                    }
                                } else {
                                    // 待办
                                    if (commonData && commonData.length > 0) {
                                        commonData.forEach(function (item) {
                                            var workLevel = '';
                                            if (item.workLevel =='1') {
                                                workLevel = '<span style="color: red">【紧急】</span>';
                                            } else if (item.workLevel =='2') {
                                                workLevel = '<span style="color: red">【特急】</span>';
                                            }
                                            var url = '/workflow/work/workform?&flowId=' + item.flowId + '&prcsId=' + item.realPrcsId + '&flowStep=' + item.step
                                                + '&runId=' + item.runId + '&tabId=' + item.id + '&tableName=' + item.tableName + '&isNomalType=false&hidden=true&opFlag=' + item.opFlag;
                                            dataStr += '<li class="li_item" style="' + function () {
                                                if (item.timeOutFlag && item.timeOutFlag == '1') {
                                                    return 'color: red;';
                                                } else {
                                                    return '';
                                                }
                                            }() + '" onclick="jumpPage(this)" title="' + function () {
                                                if (item.documentType == '0') {
                                                    return '[发文]' + item.title;
                                                } else {
                                                    return '[收文]' + item.title;
                                                }
                                            }() + '" daiBan="ture" data-url="' + url + '"><span class="circle"></span><span class="li_title">' + function () {
                                                if (item.documentType == '0') {
                                                    return '[发文]' + workLevel + item.title;
                                                } else {
                                                    return '[收文]' + workLevel + item.title;
                                                }
                                            }() + '</span><span class="li_date">' + function () {
                                                if (item.createTime.indexOf('.') > -1) {
                                                    if (item.createTime.indexOf(' ') > -1) {
                                                        return item.createTime.split(' ')[0];
                                                    } else {
                                                        return item.createTime;
                                                    }
                                                } else {
                                                    return '';
                                                }
                                            }() + '</span></li>';
                                        });
                                        var num = commonData.length > 99 ? '✔' : commonData.length;
                                        $('.document_no').siblings('.r_item_img').text(num).show();
                                    } else {
                                        $('.document_no').siblings('.r_item_img').hide();
                                    }

                                    if (workType == 0) {
                                        // 经/交办
                                        if (assignData && assignData.length > 0) {
                                            var num = assignData.length > 99 ? '✔' : assignData.length;
                                            $('.assignment_document').siblings('.r_item_img').text(num).show();
                                        } else {
                                            $('.assignment_document').siblings('.r_item_img').hide();
                                        }
                                    }
                                }

                                if (!!dataStr) {
                                    $('#documentManageModule').find('.card_content').html('<ul>' + dataStr + '</ul>').show();
                                } else {
                                    $('#documentManageModule').find('.noData').show();
                                }

                            } else {
                                $('#documentManageModule').find('.r_item_img').hide();
                                $('#documentManageModule').find('.noData').show();
                            }
                        }
                    });
                } else {
                    $.ajax({
                        url: '/document/selOverDocSendOrReceive',
                        type: 'get',
                        data: {
                            page: 1,
                            pageSize: 15,
                            useFlag: true,
                            printDate: '',
                            dispatchType: '',
                            title: '',
                            docStatus: '',
                            flowId: '',
                            documentType: ''
                        },
                        dataType: 'json',
                        success: function (res) {
                            closeLoading(loadingIndex);

                            var data = res.datas;
                            var dataStr = '';
                            if (data.length > 0) {
                                data.forEach(function (item) {
                                    var url = '/workflow/work/workformPreView?&flowId=' + item.flowId + '&prcsId=' + item.realPrcsId + '&flowStep=' + item.step
                                        + '&runId=' + item.runId + '&tabId=' + item.id + '&tableName=' + item.tableName + '&isNomalType=false&hidden=true&opFlag=' + item.opFlag;
                                    dataStr += '<li class="li_item" onclick="jumpPage(this)" title="' + function () {
                                        if (item.documentType == '0') {
                                            return '[发文]' + item.title;
                                        } else {
                                            return '[收文]' + item.title;
                                        }
                                    }() + '" data-url="' + url + '"><span class="circle"></span><span class="li_title">' + function () {
                                        if (item.documentType == '0') {
                                            return '[发文]' + item.title;
                                        } else {
                                            return '[收文]' + item.title;
                                        }
                                    }() + '</span><span class="li_date" style="margin-right: 15px;">' + function () {
                                        if (item.createTime.indexOf('.') > -1) {
                                            if (item.createTime.indexOf(' ') > -1) {
                                                return item.createTime.split(' ')[0];
                                            } else {
                                                return item.createTime;
                                            }
                                        } else {
                                            return '';
                                        }
                                    }() + '</span></li>';
                                });

                                $('#documentManageModule').find('.card_content').html('<ul>' + dataStr + '</ul>').show();
                            } else {
                                $('#documentManageModule').find('.noData').show();
                            }
                        }
                    });
                }
            }

            /**
             * 初始化计划考核模块
             * @param typeId
             * @param checkType (未考核,1-已考核)
             */
            function initPlanCheckModule(typeId, checkType) {
                var loadingIndex = initLoading('planCheckModule');
                $.get('/plcPlan/getDataDoor', {type: typeId, flag: checkType}, function (res) {
                    closeLoading(loadingIndex);

                    if (res.flag && res.obj.length > 0) {
                        var dataStr = '';
                        res.obj.forEach(function (item) {
                            dataStr += '<li class="li_item" onclick="parent.getMenuOpen(this)" title="[' + menuObj['planCheck'+item.type]['titleStr'] + ']' + item.name + '" tid="' + menuObj['planCheck'+item.type]['tId'] + '" url="' + menuObj['planCheck'+item.type]['url'] + '">' +
                                '<span class="circle"></span><span class="li_title">[' + menuObj['planCheck'+item.type]['titleStr'] + ']' + item.name + '</span>' +
                                '<span class="li_date">' + format(item.sendTime) + '</span>' +
                                '<h2 class="more_t">' + menuObj['planCheck'+item.type]['titleStr'] + '</h2></li>';
                        });

                        if (checkType != 1) {
                            var num = res.obj.length > 99 ? '✔' : res.obj.length;
                            $('.check_no').siblings('.r_item_img').text(num).show();
                        }

                        $('#planCheckModule').find('.card_content').html('<ul>' + dataStr + '</ul>').show();

                    } else {
                        if (checkType != 1) {
                            $('.check_no').siblings('.r_item_img').hide();
                        }
                        $('#planCheckModule').find('.noData').show();
                    }
                });
            }

            /**
             * 初始化执行填报模块
             * @param complete (1-进行中,2-已完成)
             * @param targetOrItem (target-关键任务,item-子任务)
             */
            function initExecutionModule(complete, targetOrItem) {
                var loadingIndex = initLoading('executionModule');
                $.get('/plcPlan/getData', {
                    complete: complete,
                    allocationStatus: 1,
                    targetOrItem: targetOrItem
                }, function (res) {
                    closeLoading(loadingIndex);
                    if (res.flag && res.obj.length > 0) {
                        var dataStr = '';
                        res.obj.forEach(function (item) {
                            dataStr += '<li '+function () {
										if(complete==1){
											//将要到期
											if(item.color==1){
												return 'style="color:#fad706"'
											}else if(item.color==2){  //延期
												return 'style="color:#e46c0a"'
											}else{
												return ''
											}
										}else{
											return ''
										}
									}()+' class="li_item" onclick="parent.getMenuOpen(this)" title="[' + menuObj['execution'+item.type]['titleStr'] + ']' + item.name + '" tid="' + menuObj['execution'+item.type]['tId'] + '" url="' + menuObj['execution'+item.type]['url'] + '">' +
                                '<span class="circle"></span><span class="li_title">[' + menuObj['execution'+item.type]['titleStr'] + ']' + item.name + '</span>' +
                                '<span class="li_date">' + format(item.planEndDate) + '</span>' +
                                '<h2 class="more_t">' + menuObj['execution'+item.type]['titleStr'] + '</h2></li>';
                        });

                        if (complete == 1) {
                            var num = res.obj.length > 99 ? '✔' : res.obj.length;
                            $('.execution_report_on').siblings('.r_item_img').text(num).show();
                        }

                        $('#executionModule').find('.card_content').html('<ul>' + dataStr + '</ul>').show();
                    } else {
                        if (complete == 1) {
                            $('.execution_report_on').siblings('.r_item_img').hide();
                        }
                        $('#executionModule').find('.noData').show();
                    }
                });
            }

            //时间戳转换
            function format(t) {
                if (t) {
                    return new Date(t).Format("yyyy-MM-dd");
                } else {
                    return '';
                }
            }

            /**
             * 业务审批跳转
             * @param me (点击的dom元素)
             */
            function windowOpenNew(me) {
                if ($(me).attr('data-s') == 2) {
                    if ($(me).attr('removeRed') && $(me).attr('runId')) {
                        $.get('/workflow/work/updateComment', {
                            runId: $(me).attr('runId'),
                            flowPrcs: $(me).attr('flowPrcs'), // 实际步骤
                            prcsId: $(me).attr('prcsId') // 设计步骤
                        }, function (res) {
                            if (res.flag) {
                                initBusinessApprovalModule(1);
                            }
                        });
                    }
                    var objGet = $(me).attr('data-url');

                    window.open(objGet);
                }
                if ($(me).parent().parent().prev().find('.custom_num') != undefined) {
                    var todoNum = $(me).parent().parent().prev().find('.custom_num').text();
                    $(me).parent().parent().prev().find('.custom_num').text(--todoNum)
                }
            }

            /**
             * 点击跳转方法
             * @param ele (点击的dom元素)
             */
            function jumpPage(ele) {

                var $ele = $(ele);

                var read = $ele.attr('read');

                if ($ele.attr('data-s') == 2) {
                    if ($ele.attr('removeRed') && $ele.attr('runId')) {
                        $.get('/workflow/work/updateComment', {
                            runId: $ele.attr('runId'),
                            flowPrcs: $ele.attr('flowPrcs'),
                            prcsId: $ele.attr('prcsId')
                        }, function (res) {
                            if (res.flag) {
                                // amange(this, 1);
                            }
                        });
                    }
                }

                window.open($ele.attr('data-url'));

                if (read == 0) {
                    $ele.remove();
                }
            }

            /**
             * 会议详情、参会
             * @param ele (点击的dom元素)
             */
            function joinMeeting(ele) {
                var $ele = $(ele);
                $.ajax({
                    url: '/hstMeetingRoom/queryHstMeetingById',
                    type: "post",
                    dataType: "json",
                    data: {meetId: $ele.attr('meetingId')},
                    success: function (res) {
                        var data = res.object;
                        layer.open({
                            type: 1,
                            title: '会议详情',
                            shade: 0.5,
                            area: ['50%', '85%'],
                            content: ['<form class="layui-form" id="ajaxforms" lay-filter="formsTest" style="width:90%;margin-left:5%;margin-top: 3%;">',
                                '<table class="layui-table">\n' +
                                '  <tbody>\n' +
                                '    <tr>\n' +
                                '      <td nowrap="nowrap" style="width:20%">会议名称:</td>\n' +
                                '      <td class="meetName">' + data.meetName + '</td>\n' +
                                '    </tr>\n' +
                                '    <tr>\n' +
                                '      <td nowrap="nowrap">会议主题:</td>\n' +
                                '      <td class="subject">' + data.subject + '</td>\n' +
                                '    </tr>\n' +
                                '    <tr>\n' +
                                '      <td nowrap="nowrap">参会人员:</td>\n' +
                                '      <td class="userIdsName">' + data.userIdsName.substring(0, data.userIdsName.length - 1) + '</td>\n' +
                                '    </tr>\n' +
                                '    <tr>\n' +
                                '      <td nowrap="nowrap">开始时间:</td>\n' +
                                '      <td class="startTime">' + data.startTime + '</td>\n' +
                                '    </tr>\n' +
                                '    <tr>\n' +
                                '      <td nowrap="nowrap">结束时间:</td>\n' +
                                '      <td class="endTime">' + data.endTime + '</td>\n' +
                                '    </tr>\n' +
                                '    <tr>\n' +
                                '      <td nowrap="nowrap">审批人:</td>\n' +
                                '      <td class="managerIdName">' + data.managerIdName.substring(0, data.managerIdName.length - 1) + '</td>\n' +
                                '    </tr>\n' +
                                '    <tr>\n' +
                                '      <td nowrap="nowrap">提前进入会议室时间:</td>\n' +
                                '      <td class="advanceMin">' + function () {
                                    if (data.advanceMin == 0) {
                                        return '按时进入会议'
                                    } else {
                                        return data.advanceMin + '分钟'
                                    }
                                }() + '</td>\n' +
                                '    </tr>\n' +
                                '    <tr>\n' +
                                '      <td nowrap="nowrap">附件:</td>\n' +
                                '      <td class="Table">' + function () {
                                }() + '</td>\n' +
                                '    </tr>\n' +
                                '    <tr>\n' +
                                '      <td nowrap="nowrap">会议描述:</td>\n' +
                                '      <td class="meetDesc">' + data.meetDesc + '</td>\n' +
                                '    </tr>\n' +
                                '  </tbody>\n' +
                                '</table>' +
                                '<div style="text-align: center"><button type="button" class="layui-btn layui-btn-sm" id="canhui">参加会议</button></div>',
                                '</form>'].join(''),
                            success: function () {
                                var arr = res.object.attachmentList;
                                attachmentShow_news(arr, $('.Table'));
                                for (var i = 0; i < $('.font_').length; i++) {
                                    $('.font_').eq(i).children(":first").remove();
                                }
                                $('.font_ .file_a  span').css('margin-left', '12px')
                                //点击参加会议
                                $('#canhui').on('click', function () {
                                    layer.confirm('确定要参加会议吗？', function (index) {
                                        address = $ele.attr('roomAddr');
                                        entermeeting($ele.attr('roomNo'), $ele.attr('roomPwd'), $ele.attr('userNameString'));
                                        layer.close(index);
                                    });
                                });
                            }
                        });
                    }
                });
            }

            /**
             * 登录会议室主函数
             * @param roomNo (房间好)
             * @param roomPwd (房间密码)
             * @param nickName (用户名)
             */
            function entermeeting(roomNo, roomPwd, nickName) {
                var roomId = roomNo;
                var roomPwd = roomPwd;
                var userName = '';
                var userPwd = '';
                var nickName = nickName;
                var url = getURLForPC(roomId, roomPwd, userName, userPwd, nickName);
                if (isAndroid) {
                    url = getURLForAndroid(roomId, roomPwd, userName, userPwd, nickName);
                } else if (isiOS) {
                    url = getURLForIphone(roomId, roomPwd, userName, userPwd, nickName);
                }
                if (its.x.isIE() || its.x.isChrome() || its.x.isSafari()) {
                    setTimeout(function () {
                        window.location.href = url;
                    }, 1);
                } else {
                    document.getElementById("myiframe").src = url;
                }
            }

            /**
             * 好视通会议参会调用
             */
            function getUserType() {
                var userType;
                var obj = document.getElementsByName("userType");
                for (var i = 0; i < obj.length; i++) {
                    if (obj[i].checked)
                        userType = obj[i].value;
                }
                return userType;
            }

            // 业务审批展开折叠
            function openthis(e) {
                // 阻止事件冒泡
                if (event.stopPropagation) {
                    event.stopPropagation()
                } else if (window.event) {
                    window.event.cancelBubble = true
                }
                var parentId = e.parents('.card_box').attr('id');
                var $parentEle = $('#' + parentId);
                var runid = e.attr('runid');
                if (e.hasClass('active')) {
                    for (var i = 0; i < $parentEle.find('.hidden[name=' + runid + ']').length; i++) {
                        if ($parentEle.find('.hidden[name=' + runid + ']').eq(i).attr('ishidden') == 1) {
                            $parentEle.find('.hidden[name=' + runid + ']').eq(i).parent().hide();
                        }
                    }
                    e.attr({
                        'title': '点击展开',
                        'src': '/img/mywork/addlogo.png'
                    }).removeClass('active');
                } else {
                    $parentEle.find('.hidden[name=' + runid + ']').parent().show();
                    e.addClass('active').attr({
                        'title': '点击收起',
                        'src': '/img/mywork/deletelogo.png'
                    });
                }
            }

            /**
             * 每10分钟刷新业务审批和公文管理
             */
            setInterval(function () {
                // 流程审批模块
                if ($('#businessApprovalModule').length > 0) {
                    // 流程待办
                    var $p = $('.business_approval_no').parent();
                    $p.siblings().removeClass('r_item_select');
                    $p.addClass('r_item_select');
                    initBusinessApprovalModule(0);
                }
                // 公文模块
                if ($('#documentManageModule').length > 0) {
                    var $p = $('.document_no').parent();
                    $p.siblings().removeClass('r_item_select');
                    $p.addClass('r_item_select');
                    initDocumentManageModule(0);
                }
            }, 600000);

            function openRold() {
                // 流程审批模块
                if ($('#businessApprovalModule').length > 0) {
                    // 流程待办
                    var $p = $('.business_approval_no').parent();
                    $p.siblings().removeClass('r_item_select');
                    $p.addClass('r_item_select');
                    initBusinessApprovalModule(0);
                }
                // 公文模块
                if ($('#documentManageModule').length > 0) {
                    var $p = $('.document_no').parent();
                    $p.siblings().removeClass('r_item_select');
                    $p.addClass('r_item_select');
                    initDocumentManageModule(0);
                }
                parent.listTable();
            }

            /**
             * 初始化加载层
             * @param eleId (模块id)
             * @returns {*}
             */
            function initLoading(eleId) {
                // 隐藏内容框
                $('#' + eleId).find('.card_content').hide().empty();
                // 隐藏无内容提示
                $('#' + eleId).find('.noData').hide();
                var loadingIndex = layer.load(2, {
                    shade: false,
                    fixed: false,
                    // content: '加载中...',
                    success: function (layero) {
                        $(layero.selector).css({
                            'top': '50%',
                            'left': '50%',
                            'margin-top': '-16px',
                            'margin-left': '-16px'
                        });
                        $('#' + eleId).find('.card_item').append($(layero.selector));
                    }
                });

                return loadingIndex;
            }

            /**
             * 关闭加载层
             * @param loadingIndex (加载层id)
             */
            function closeLoading(loadingIndex) {
                layer.close(loadingIndex);
            }

            window.onresize = resizeSize;

            function resizeSize() {
                var windowHeight = $(window).height();
                var cardHeight = (windowHeight - 10 - (moduleType * 10)) / moduleType;
                $('.card_box').height(cardHeight);
                $('.scroll_cover').height(cardHeight - 31);
                $('.card_content').height(cardHeight - 45);
                $('.noData').css('padding-top', (cardHeight - 45) / 4);
            }
		
		</script>
	
	</body>
</html>
