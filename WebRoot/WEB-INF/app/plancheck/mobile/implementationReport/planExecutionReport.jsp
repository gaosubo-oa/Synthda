<%--
  Created by IntelliJ IDEA.
  User: 戎成路
  Date: 2020/9/8
  Time: 14:31
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
	<head>
		<title>计划填报</title>
		
		<meta charset="UTF-8"/>
		<meta name="viewport" content="width=device-width,initial-scale=1,minimum-scale=1,maximum-scale=1,user-scalable=no"/>
		
		<link rel="stylesheet" href="/lib/mui/mui/mui.min.css">
		
		<script src="/js/xoajq/xoajq1.js"></script>
		<script src="/js/base/base.js"></script>
		<script src="/lib/mui/mui/mui.min.js"></script>
		
		<style>
			.content_head .mui-segmented-control {
				width: 90%;
				margin: 5px auto;
				height: 30px;
				min-height: 30px;
			}
			
			.content_head .mui-segmented-control .mui-control-item {
				line-height: 30px;
			}
			
			.content_body {
				position: absolute;
				top: 40px;
				right: 0;
				bottom: 0;
				left: 0;
				padding: 5px 10px;
			}
			
			.t_img {
				width: 30px !important;
				height: 30px !important;
				margin-right: 5px !important;
			}
			
			.t_title {
				white-space: normal;
				font-size: 0.9em;
			}
			
			.mui-ellipsis {
				font-size: 0.7em;
			}
		
		</style>
	
	</head>
	<body style="background-color: #fff;">
		<div class="mui-content" style="background-color: #fff;">
			<div class="content_head">
				<div class="mui-segmented-control">
					<a class="mui-control-item t_complete mui-active" t_complete="1">进行中</a>
					<a class="mui-control-item t_complete" t_complete="2">已完成</a>
				</div>
			</div>
			<div class="content_body">
				<div class="mui-row" style="height: 100%;">
					<div class="mui-col-xs-3" style="padding-right: 10px;">
						<div class="mui-segmented-control mui-segmented-control-inverted mui-segmented-control-vertical">
							<a class="mui-control-item t_type mui-active " t_type="target" style="width: 100%;">关键任务</a>
							<a class="mui-control-item t_type" t_type="item" style="width: 100%;">子任务</a>
						</div>
					</div>
					<div class="mui-col-xs-9" style="height: 100%;">
						<div id="targetModule" class="mui-control-content mui-active" style="height: 100%; overflow-x: hidden;overflow-y: auto;">
							<ul class="mui-table-view" style="display: none;">
								
							</ul>
							<div class="noData" style="display: none; margin-top: 50%; text-align: center;">
								<img src="/img/main_img/shouyekong.png">
								<h6 style="text-align: center;color: #666;">暂无数据</h6>
							</div>
						</div>
						<div id="taskModule" class="mui-control-content" style="height: 100%; overflow-x: hidden;overflow-y: auto;">
							<ul class="mui-table-view">
								
							</ul>
							<div class="noData" style="display: none; margin-top: 50%; text-align: center;">
								<img src="/img/main_img/shouyekong.png">
								<h6 style="text-align: center;color: #666;">暂无数据</h6>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
		
		<script type="text/javascript">
			
			// 进行中、已完成切换
			$('.t_complete').on('click', function(){
			    var complete = $(this).attr('t_complete');
			    var targetOrItem = $('.t_type.mui-active').attr('t_type');
			    initExecutionModule(complete, targetOrItem);
			});
			
			// 关键任务、子任务切换
			$('.t_type').on('click', function(){
			    var complete = $('.t_complete.mui-active').attr('t_complete');
			    var targetOrItem = $(this).attr('t_type');
			    initExecutionModule(complete, targetOrItem);
			});

            initExecutionModule(1, 'target');

            /**
             * 初始化执行填报模块
             * @param complete (1-进行中,2-已完成)
             * @param targetOrItem (target-关键任务,item-子任务)
             */
            function initExecutionModule(complete, targetOrItem) {
                $('.mui-table-view').hide().empty();
                $('.noData').hide();
	            var tType = '';
                var $moduleEle = null;
                if (targetOrItem == 'target') {
                    $moduleEle = $('#targetModule');
                    tType = 6;
                } else {
                    $moduleEle = $('#taskModule');
                    tType = 7;
                }
                $moduleEle.siblings().hide();
                $moduleEle.show();
                var loadingIndex = layer.load(2, {
                    shade: false,
                    fixed: false,
                    success: function (layero) {
                        $(layero.selector).css({
                            'top': '20%',
                            'left': '50%',
                            'margin-top': '-16px',
                            'margin-left': '-16px'
                        });
                        $moduleEle.append($(layero.selector));
                    }
                });
	            
                $.get('/plcPlan/getData', {
                    complete: complete,
                    allocationStatus: 1,
                    targetOrItem: targetOrItem
                }, function (res) {
                    layer.close(loadingIndex);
                    var dataStr = '';
                    if (res.flag && res.obj.length > 0) {
                        res.obj.forEach(function (item) {
                            var statusObj = getStatus(item.status);
                            dataStr += '<li class="mui-table-view-cell mui-media t_link" t_id="'+item.id+'" t_type="'+tType+'">\n' +
                                '\t\t\t\t\t\t\t\t\t<a href="javascript:;">\n' +
                                '\t\t\t\t\t\t\t\t\t\t<img class="mui-media-object mui-pull-left t_img" src="' + statusObj.url + '">\n' +
                                '\t\t\t\t\t\t\t\t\t\t<div class="mui-media-body">\n' +
                                '\t\t\t\t\t\t\t\t\t\t\t<div class="t_title">' + item.name + '</div>\n' +
                                '\t\t\t\t\t\t\t\t\t\t\t<p class="mui-ellipsis"><span>完成度: ' + item.taskPrecess + '%</span><span style="float: right;color: #007aff;">截止日期: ' + format(item.planEndDate) + '</span></p>\n' +
                                '\t\t\t\t\t\t\t\t\t\t</div>\n' +
                                '\t\t\t\t\t\t\t\t\t</a>\n' +
                                '\t\t\t\t\t\t\t\t</li>';
                        });
                    }
                    if (!!dataStr) {
                        $('.noData').hide();
                        $moduleEle.find('ul').html(dataStr).show();
                    } else {
                        $('.mui-table-view').hide();
	                    $('.noData').show();
                    }
                });
            }

            // 链接跳转
            $(document).on('click', '.t_link', function () {
                var id = $(this).attr('t_id');
                var type = $(this).attr('t_type');
                var url = '/plcPlan/implementationReport?id='+id+'&type='+type;
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
            });

            mui.init();

            /**
             * 获取关键任务/子任务状态
             * @param status
             * @returns {{value: string, url: string}}
             */
            function getStatus(status) {
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
            }

            //时间戳转换
            function format(t) {
                if (t) {
                    return new Date(t).Format("yyyy-MM-dd");
                } else {
                    return '';
                }
            }
            
		</script>
	</body>
</html>